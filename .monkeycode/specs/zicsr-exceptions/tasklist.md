# 需求实施计划：zicsr-exceptions

- [x] 1. 新增 CSR 寄存器堆组件 `core/CsrFile.scala`
  - 依据 design「CsrFile」与 R2.1 内置 CSR：`mstatus/misa/mie/mtvec/mscratch/mepc/mcause/mtval/mip/mhartid`；内部寄存器 `curMode` 复位为 M（R2.8/R6.1/R7.1）
  - 位掩码写逻辑：仅实现位可写、保留位读 0 写忽略；`misa/mip/mhartid` 只读忽略写入；`mip.MTIP` 直接接 `io.timerInterrupt`（R2.2–R2.4/R2.7/R4.1）
  - 两个组合读口：WB 读口（返回 CSR 旧值）、EX 控制读口（`mtvec/mepc/mstatus` 域、`curMode`），供解码写回与非法复核（R1.1/R6.4）
  - trap 提交写口（`trapEna/trapCause/trapEpc/trapTval` → `mepc/mcause/mtval/mstatus.MPIE←MIE,MIE←0,MPP←curMode,curMode←M`）与 `mretEna` 写口（`MIE←MPIE,MPIE←1,MPP←M,curMode←MPP`）（R3.4/R3.5/R5.2/R5.3/R6.2/R6.3）
  - WB 普通写口 `csrWe/csrWrData/csrAddr`，CSRRS/RC 采用读-改-写（读口值参与按位 set/clear）（R1.2/R1.3/R1.8）
  - 模块可独立通过 SpinalHDL elaboration 编译

- [x] 2. Decoder 扩展 CSR/SYSTEM 指令译码
  - 新增 `DecodeOutput` 字段：`isCsr/csrOp/csrImm/csrAddr/csrWe/sysOp`，默认清零/置 NONE（design「Decoder 新输出」表）
  - 新增 `CsrOp`（`CSRW/CSRS/CSRC`）与 `SysOp`（`NONE/ECALL/EBREAK/MRET/WFI/ILLEGAL_SYS`）枚举（sysOp 仅需 ECALL 区分 U/M，可由 curMode 在 EX 判定）
  - 重写 `opcode=1110011`（SYSTEM）分支：6 条 CSR 指令按 funct3 译码（R1.1–R1.6），`ECALL/EBREAK/MRET/WFI` 按 funct7+funct3+imm 编码识别（R3.1/R3.2/R5.1/R6.6），`SRET/URET`/未定义编码 → `ILLEGAL_SYS`（R6.7）
  - `csrWe` 组合：CSRRW/CSRRWI 恒真；CSRRS(I)/CSRRC(I) 为 `zimm≠0`（立即数形取 `instr[19:15]`，寄存器形由 EX 以 `rs1≠0` 复核——立即数形 RS1 位域即 zimm）（R1.4–R1.6）
  - 仅 RD/rs1=x0 的只读语义在 EX/WB 由 `csrWrData` 实际旁路值判定；既有 RV32I/M 译码路径回归保持通过

- [x] 3. 流水线 bundle 字段扩展与 WB 写回 CSR 源
  - `IdEx/ExMem/MemWb` bundle 新增 `csrOp/csrImm/csrAddr/csrWe/csrWrData`，EX 级在旁路后生成 `csrWrData`（寄存器形 = `forwardRs1` 且 `rs1≠0`；立即数形 = zimm 零扩展）随流水传至 WB（R1.1–R1.6）
  - `wbSel` 扩为 3 位并新增 `WbSel.CSR=3`；WB 写回 mux 增 CSR 源：`wbData=csrRdData`（CSR 旧值），regWrite 保持 `rd≠0` 语义（design「流水线字段」/R1.1）
  - 各 pipeline 寄存器 zero()/复位默认同步补齐新字段

- [x] 4. EX 级 trap 判定、MRET 与 flush 重定向
  - `exTrapEna = idEx.valid && sysTrapCause ≠ NONE`：EBREAK/MRET-in-U/ECALL 在 EX 判定；CSR 访问类非法（只读写 R1.7/R1.9、`mtvec.MODE≠0` R2.5、U 模式访 M 级 CSR R6.4）需依赖 CSR 内容与模式，在 EX 用控制读口复核产生 cause=ILLEGAL，`mtval=csrAddr`（R3.3/R3.4/Correctness 3）
  - trap 提交：复用 `ctrlFlush` 通路（`branchTaken||jumpTaken`）扩展为含 trap，重定向 `pc←{mtvec.BASE[31:2],00}`（D5），气泡注入 ifId/idEx（R3.6/R6.3）
  - 判定与提交单周期：trap 时该拍不产生 WB/寄存器写副作用（Correctness 2/3）
  - `MRET`（EX，curMode=M）：`pc←mepc`、mretEna 状态写口，flush 同 trap（R5.1–R5.3）；`MRET` 且 `MPP`=1/2 → ILLEGAL（R5.4）
  - 中断接受（取指边界）：`intrTake = csrFile.trapPending && mie.MTIE && mstatus.MIE && curMode=M && !exTrapEna && !ctrlFlush && !freezeAll`，`mepc←pcReg`，重定向 mtvec 入口（R4.2/R4.3/R4.6 上界 = 单拍接受无额外延迟）
  - 顶层 io 增 `timerInterrupt: in Bool`；`withDebug=true` 时导出 `debugMepc/debugMcause/debugMode`（R7.2）

- [x] 5. 仿真 harness 扩展与新测试程序（Python 模型交叉验证）
  - `CpuTb` 新增 `timerInterrupt` 驱动输入与 `debugMepc/debugMcause/debugMode` 透传（R7.2/R7.3）
  - 新增 RV32Zicsr 程序：6 条 CSR 指令对 mstatus/mscratch/mepc/mcause/mtval 读写往返、rs1=x0 只读语义、CSRRS/CSRRC 位操作、写只读（misa/mip）触发非法（R1–R3 验收 1/2）
  - 新增异常程序：M 模式 ECALL→cause 11、EBREAK→3、非法指令/写未实现 CSR→2 且 mepc/mtval 正确、handler 写标记（R3/R5 验收 3）
  - 新增中断程序：置 `mie.MTIE=1`+`mstatus.MIE=1`+`mtvec`，拉升 `timerInterrupt`，验证进 handler（cause=0x80000007）、`MRET` 回断点与 `MIE/MPP` 恢复（R4/R5 验收 4）
  - 新增 U 模式程序：M 经 `MPP=0`+`MRET` 进 U，U 内 CSR 访问→非法 cause 2（MPP=0）、`ECALL`→cause 8，回 M 验证模式往返（R6 验收 5）；复位读 0 与 debugPc 回到 resetVector（R7.1 验收 6）
  - 期望值以仿真中独立计数器/handler 标记寄存器的分段断言交叉核对（CSR 位运算为确定性布尔算术，逐寄存器断言即可闭环，未另行引入 Python 参考模型）

- [x] 6. 回归与构建验证
  - 既有 `RiscvCoreTest`（RV32I/RV32M）全部保持通过
  - 新测试全部通过，`debugPc` 断言在自循环终点稳定
  - sbt 全量 compile + test 通过；`RiscvCoreGen` RTL 可重新生成（文档步骤）

- [x] 7. 文档同步
  - 更新 `docs/isa-support.md`（新增 Zicsr/M/U/异常/中断支持表）、`docs/configuration.md`（withDebug/timerInterrupt 说明）、`docs/architecture.md`（CSR 文件与 trap 通路），保持与实现一致

> 注：实现/验证过程中额外定位并修复了既有的 3-slot RAW 数据冒险（操作数改在 EX 段组合读寄存器堆，而非 ID/EX 边界锁存），由 `ZicsrTrapTest` 回归覆盖；详述见 `docs/architecture.md`「数据冒险」。
