# 微架构设计

## 概述

rv32c 采用经典哈佛结构的五级流水线，指令和数据走独立总线。整体为单发射、按序（in-order）执行，目标是高时钟频率与简单可验证的设计，后续可逐步引入乱序或更深流水。

```mermaid
graph LR
    A["IF 取指"] --> B["ID 译码/读寄存器"]
    B --> C["EX 执行/分支判定"]
    C --> D["MEM 访存"]
    D --> E["WB 写回"]
```

## 五级流水线

### IF（取指）

- `pcReg` 输出到指令总线，握手成功后指令进入 IF/ID 寄存器
- 遇到停顿（stall）时 PC 冻结；遇到跳转/分支时 PC 更新为目标地址
- 复位后从 `CoreConfig.resetVector` 开始取指
- **RV32C / RV64C（`isa.hasCompressed`）**：PC 变为 2 字节粒度，总线恒取对齐字（`pc & ~3`），核内按 `pc[1]` 选择低/高半字；32 位指令起始于高半字时进入一拍 `mis32` 停顿——锁存高半字、下一拍取下一字拼接后交付。PC 增量改为指令长度 `instrLen`（压缩 2，标准 4），链接值与 `mepc` 均使用精确地址。RV32 与 RV64 共用该通路，专属编码在译码级按 `xlen` 区分。C 关闭时上述逻辑整体省略，逐拍等价于原取指

### ID（译码）

- 组合译码器 `Decoder` 生成全部控制信号：寄存器写使能、ALU 操作、访存属性、分支类型、写回选择、立即数，以及 CSR/异常指令的 `csrOp/csrWe/csrAddr/sysOp` 控制域
- 立即数按 I / S / B / U / J 五种格式生成并符号扩展到位宽；RV32C / RV64C 使能时，16 位压缩指令在译码级展开为等价的标准操作（与 32 位路径写入同一组控制域），非法/保留压缩编码置 `illegal`（cause 2）
- **RV32A / RV64A（`isa.hasAtomic`）**：opcode `0101111` 按 `funct5[31:27]` 展开 LR/SC/AMO 控制域（`atomic/isLr/isSc/amoOp`），有效地址为 `rs1`；`funct3` 决定 `.W`/`.D`，非本宽度的 `funct3`、未知 `funct5` 或 A 关闭时置 `illegal`（cause 2）
- **RV32F / RV64F / RV64D（`isa.hasFpu`）**：opcode `0000111`/`0100111` 译为 FLW/FSW（FLD/FSD 仅 D），opcode `1010011` 按 `funct6`/`funct3` 展开 FADD/FSUB/FMUL/FDIV/FSQRT/FSGNJ/FMIN/FMAX/FCMP/FCLASS/FMV/FCVT 控制域（`fpWrite/fpOp/fpRm/fpFmt`），其中 funct6 `010000` 展开 `FCVT.S.D`/`FCVT.D.S`（仅 D），opcode `1000011/1000111/1001011/1001111` 展开四种 FMA；无 D 的 F 核上 fmt=01（D）编码置 `illegal`。FP CSR 的合法性在 EX 结合 `mstatus.FS` 判定
- **Zba / Zbb / Zbs / Zbc / Zbkb / Zbkc / Zbkx（`isa.hasZbb/hasZbs/hasZba/hasZbc/hasZbkb/hasZbkc/hasZbkx`）**：在 OP / OP-IMM / OP-32 / OP-IMM-32 的基础译码之后追加覆盖（SpinalHDL 末次连接语义），分别展开基础位操作、单比特操作、地址生成、无进位乘法以及密码学位操作控制域；覆盖默认非法的 OP-32 编码时复位 `valid`/`illegal`，未使能的 `Zb*` 编码保持 cause 2。`Zbkc` 与 `Zbc` 共用 `funct7=0000101` 的 `clmul/clmulh` 编码，`clmulr` 仅在使能 `Zbc` 时译码
- **Zknh（`isa.hasZknh`）**：在 OP-IMM / OP 的基础译码之后追加覆盖，展开 SHA-2 哈希位操作控制域；SHA-256/512 变换编码为 OP-IMM（`funct7=0001000`、`funct3=001`，`rs2` 位段选择 8 种操作），RV32 的 SHA-512 拆分形式编码为 OP（`funct3=000`，`funct7` 区分）；RV64 上 `sha512*` 为 64 位形式、RV32 上为拆分形式，未使能时编码保持 cause 2
- **Zksh / Zksed（`isa.hasZksh/hasZksed`）**：`Zksh` 的 `sm3p0/sm3p1` 复用 `Zknh` 的 OP-IMM 编码（`funct7=0001000`、`funct3=001`，选择子 8/9），在 `Zknh` 覆盖层之后复位 `valid`/`illegal` 以启用；`Zksed` 的 `sm4ed/sm4ks` 编码为 OP（`funct3=000`），由 `instr[29:25]` 选择操作、`instr[31:30]` 给出字节选择 `bs`，`bs` 经 ID/EX 寄存器送入 ALU；未使能时对应编码保持 cause 2
- **Zknd / Zkne（`isa.hasZknd/hasZkne`）**：RV32 的 `aes32{es,esm,ds,dsm}i` 编码为 OP（`funct3=000`），由 `instr[29:25]` 选择操作、`instr[31:30]` 给出 `bs`；RV64 的 `aes64{es,esm,ds,dsm}`/`aes64ks2` 编码为 OP（`funct3=000`，`funct7` 区分），`aes64im` 与 `aes64ks1i` 编码为 OP-IMM（`imm[11:4]` 固定、`rcon` 取 `instr[23:20]`，经新增 4 位 `rcon` 随 ID/EX 送入 ALU）；`aes64ks1i` 的 `rcon>10` 在译码级判为 cause 2；未使能时对应编码保持 cause 2
- **Zicond（`isa.hasZicond`）**：`czero.eqz/czero.nez` 编码为 OP（`funct3=101`/`111`），以 `funct7=0000111` 与基础 RV32I 的 `srl/sra/and` 区分；覆盖层在 OP 分支末尾生效，未使能时编码保持 cause 2
- **Zifencei（`isa.hasZifencei`）**：MISC-MEM 的 `funct3=001` 仅在该扩展使能时合法；无 I 缓存，译码后不引入额外状态
- **Zicntr（`isa.hasZicntr`）**：64 位 `cycle/instret` 计数器常驻 `CsrFile`，`cycle` 每拍自增、`instret` 在 WB 提交（`memWb.valid && !freezeAll`）时自增；`mcycle/minstret` 为其 M 模式可写别名，`time` 复用 `cycle` 时基，RV32 以 `cycleh/timeh/instreth` 暴露高 32 位；`mcountinhibit` 的 CY/TM/IR 位分别冻结 `cycle/time/instret` 而互不影响；低于 M 模式读用户计数器需对应 `mcounteren` 位，M/S/U 栈的 U 模式还需 `scounteren` 位，否则按非法指令（cause 2）处理
- **Sstc（`isa.hasSstc`）**：`stimecmp`（RV32 含 `stimecmph`）与 `menvcfg`（RV32 含 `menvcfgh`，WARL 仅保留 `STCE`=bit 63）常驻 `CsrFile`；`STCE` 置位后组合比较 Zicntr 的 64 位 `time` 与 `stimecmp`，结果作为 STIP 参与 `mip/sip` 并在 `mie.STIE + mideleg[7]` 使能时按 cause 5 进入 S 模式；`STCE` 清零后 `stimecmp` 读 0 且写入被忽略
- **Zcb（`isa.hasZcb`）**：压缩字节/半字访存在 Q0 `cfunct3=100`（`instr[12:10]` 区分 LB/LH/LHU/SB/SH），压缩寄存器运算在 Q1 `cfunct3=100` + `instr[12:10]=111`（`instr[6:5]=11` 为 zext/sext/not，`instr[6:5]=10` 为 c.mul）；仅 `instr[6:5]=10/11` 被覆盖，其余保留基础 C.SUB/C.XOR/C.OR/C.AND 译码
- 本阶段不做寄存器数据读取；读地址（rs1/rs2）随 ID/EX 寄存器进入 EX，操作数在 EX 段统一取得（见「数据冒险」）

### EX（执行）

- 旁路单元根据 EX/MEM 与 MEM/WB 的结果优先选择操作数；未被旁路覆盖的操作数在 EX 段**组合读寄存器堆**取得（读地址即本指令 rs1/rs2），因此总能观察到已提交的架构值
- ALU 完成算术/逻辑/移位/比较运算；乘法在 ALU 内组合完成（RV32M）
- **位操作执行（`isa.hasZbb/hasZbs/hasZba/hasZbc/hasZbkb/hasZbkc/hasZbkx/hasZknh/hasZksh/hasZksed/hasZknd/hasZkne`）**：全部 `Zb*`/`Zk*` 指令在 ALU 内组合完成，复用现有结果通路，无新增停顿状态；Zbb 的计数（`clz/ctz/cpop`）与旋转、Zbs 的单比特掩码（`bset/bclr/binv/bext`，位索引取操作数低位）、Zba 的 `(rs1<<k)+rs2`、Zbc 与 Zbkc 的无进位乘法（对 `rs2` 每个置位 `i` 异或 `(rs1<<i)` 得到 2*XLEN 位积后按位段选择）、Zbkb 的 `pack/packh/packw`（`packw` 符号扩展 32 位结果）、逐字节 `brev8` 与 RV32 `zip/unzip`、Zbkx 的 `xperm4/xperm8`（按 nibble/字节索引在操作数内交叉取位）、Zknh 的 SHA-2 变换（定宽 `ROR`/`SHR` 组合，SHA-256 与 RV32 拆分形式为 32 位并符号扩展、RV64 SHA-512 为 64 位）、Zksh 的 SM3 变换与 Zksed 的 SM4 S-box 变换（32 位并符号扩展，`bs` 选择字节与旋转量）、Zknd/Zkne 的 AES 轮变换（ShiftRows/InvShiftRows + 加密/解密 S-box + 可选 MixColumns/InvMixColumns，RV32 形式为单字节变换后按 `8*bs` 左旋，RV64 形式基于 64 位操作数）与 `aes64ks1i/aes64ks2` 密钥调度均在单周期内算出，RV64 W 形式只取低 32 位并符号扩展
- **分支与跳转在 EX 阶段提前判定**，条件跳转直接消耗转发后的操作数，避免等到 MEM 阶段，将错误预测代价从 3 拍降到 2 拍
- JALR 目标 = `rs1 + imm` 并强制按 2 字节对齐（清 LSB）
- 异常（`ecall/ebreak/非法指令/mret 违例`）在 EX 段判定并提交 trap（见「CSR 与异常/中断通路」）
- **A 扩展对齐检查**：LR/SC 与 AMO 的地址未按访问宽度自然对齐时在 EX 段判定并提交 trap——LR 为 cause 4，SC/AMO 为 cause 6，`mtval` 记录故障地址；异常先于任何内存副作用
- **FP 执行（`isa.hasFpu`）**：EX 段组合完成全部 IEEE-754 运算（含 FMA 单次舍入、FSQRT、5 种舍入模式），产生 `fpResult/fpFlags`。F 核实例化单个 `FpUnit(8,23)`；D 核同时实例化 `FpUnit(8,23)` 与 `FpUnit(11,52)`，按指令 fmt 路由（`.S` 走 32 位单元、`.D` 走 64 位单元），`FCVT.S.D`/`FCVT.D.S` 由 64 位单元执行，避免双重舍入。源操作数取自浮点寄存器堆（EX 组合读 + WB 级 FP 转发），结果经 EX/MEM 携带到 WB 写入 FP 寄存器堆；`fpStall` 拉高时冻结 1 拍，复用统一 `freezeAll`
- **FP 状态与合法性**：`mstatus.FS=Off` 时任何 FP 指令或 FP CSR 访问在 EX 置 illegal（cause 2）；提交 FP 指令累积 `fflags` 并置 `mstatus.FS=Dirty`

### MEM（访存）

- 根据指令访问数据总线（读写、字节/半字/字、符号扩展）
- 写数据与写掩码（byte strobe）在核心内生成，从地址低 2 位计算字节偏移
- 读回数据按访问宽度截取并做符号/零扩展
- **AMO 原子读-改-写（`isa.hasAtomic`）**：以两态状态机在 MEM 级完成「读回旧值 → 组合运算 → 写回」，期间拉高 `amoStall` 冻结整条流水线；旧值经 MEM/WB 旁路回写 rd，写回值由组合器按 `wNew/dNew` 生成；SC 仅当预约有效且地址匹配时驱动总线写，rd 写 0/1 表示成功/失败

### WB（写回）

- 选择写回源：ALU 结果 / 访存结果 / `pc + instrLen`（JAL/JALR 链接，压缩指令为 pc+2）/ CSR 读回旧值（`rd=x0` 时忽略）
- 写入寄存器堆（`rd == 0` 时忽略，符合 RISC-V 规范）；寄存器堆为**单写端口**，WB 是唯一写入口
- **FP 写回（`isa.hasFpu`）**：FP 指令与 FLW 在 WB 写入独立的浮点寄存器堆（同样单写端口，由 `memWb.valid && memWb.fpWrite` 驱动），`frd=0` 不被忽略；FLEN=64（D）时把单精度结果 NaN-boxing 到高 32 位后再写回

## 冒险处理

### 数据冒险（RAW）

采用两级旁路 + EX 段组合读回的组合方案，优先级：

1. EX/MEM → EX：最近 ALU 结果（排除 load / CSR 读这类 rd 尚未就绪的指令）
2. MEM/WB → EX：WB 写回值（load 读回数据、CSR 旧值）
3. 其余（与流水线内写回相距 ≥3 槽）：**EX 段直接读寄存器堆**——生产者已在 WB 末端把结果提交进寄存器堆，消费指令执行时读到的是已提交的架构值

旁路判定条件：`regWrite && rd != 0 && rd == 源寄存器`。

> 说明：操作数不再在 ID/EX 边界锁存旧值，读地址随流水到 EX 后统一取值，因此对任意间距的 RAW 都给出正确架构值；WB 单写端口的提交语义不变。

### load / CSR 结果冒险（停顿 1 拍）

当 EX 阶段是 load 或 CSR 读且 ID 阶段指令需要使用其目标寄存器时，硬件停顿 1 拍：

```text
检测: EX.valid && EX.rd != 0 && (EX.MemRead || EX 是 CSR 写) &&
      (EX.rd == ID.rs1 || EX.rd == ID.rs2)
动作: 冻结 PC 与 IF/ID 寄存器，向 EX 段插入气泡
```

停顿一拍后 load/CSR 的结果已进入 MEM/WB，由第 2 级旁路正确转发（CSR 的 rd = 写前旧值，在 WB 读出）。

### CSR→MRET 冒险（停顿）

`mret` 读取 `mepc` 与 `mstatus.MPP`。若其后 1-2 槽内存在写入 `mepc(0x341)/mstatus(0x300)` 的 CSR 指令尚未提交，则冻结 `mret` 一拍，等这些写提交后再读取。

### RV32M 除法（多周期 EX 停顿）

DIV/DIVU/REM/REMU 在 EX 段由一个恢复除法器执行，运算期间整条流水线冻结：

```text
检测: EX.valid && (aluOp ∈ {DIV,DIVU,REM,REMU}) && !divider.done
动作: divStall=1，freezeAll = memStall || fetchStall || divStall，
      PC/IFID/IDEX/EXMEM/MEMWB 全部保持
完成: divider.done 一拍内释放停顿，除法器结果经 exMem.aluResult
      送入原有旁路与回写路径，同时 ack 除法器复位
```

结果通过既有 EX/MEM 旁路网络转发，流水线其余逻辑无需感知除法器的多周期特性。

### RV32A / RV64A 原子访存（多周期 MEM 停顿）

LR 是普通载入并置位预约；SC 在预约校验失败时不驱动总线写；AMO 在 MEM 段以两态状态机完成读-改-写：

```text
状态 0 (READ): 驱动总线读，amoStall=1 冻结流水线，读回值锁存到 amoOld
状态 1 (WRITE): 组合器算出新值驱动总线写，amoStall 释放，旧值经 MEM/WB 回写 rd
预约: LR 置 resvValid/resvAddr；任何提交的存储、SC 或已提交 AMO 清除预约
```

`freezeAll = otherFreeze || amoStall`，因此 AMO 读写两拍间所有阶段保持；A 关闭时该分支、预约寄存器与状态机被整体剪除。

### 浮点数据冒险（FP 转发 + 停顿 1 拍）

FP 源操作数在 EX 段由三路构成：WB 级 FP 转发（`memWb.fpWrite`）优先，其次 EX 段组合读浮点寄存器堆。若 EX 段 FP 指令的源寄存器正好是 EX 段或 MEM 段中尚未到达 WB 的 FP 生产者（即相距 1–2 槽），则 `fpStallData` 拉高，冻结 1 拍，等生产者进入 WB 后再转发：

```text
检测: (EX 是 FP 生产者 && EX.rd == 本指令任一 FP 源) ||
      (MEM 是 FP 生产者 && MEM.rd == 本指令任一 FP 源)
动作: stallData = intStallData || fpStallData
```

FP 结果仅经 WB 一条路径写回，因此无需 EX/MEM 级 FP 旁路，逻辑与整数 load/CSR 停顿同构。FS=Off 的 FP 指令不进入该停顿判定（其已在 EX 判非法）。

### 控制冒险

分支在 EX 判定，跳转发生时：

- 冻结 IF/ID 中的 2 条错误取指指令（通过清 `valid` 位实现）
- PC 更新为分支/跳转目标

代价：条件分支错误预测固定 2 拍。JAL 无条件跳转同样 2 拍。

## CSR 文件与异常/中断通路

### CSR 文件（`CsrFile`）

- 内部 CSR：`mstatus/mie/mtvec/mscratch/mepc/mcause/mtval/mip/mhartid/medeleg/mideleg`，复位全 0；另有内部寄存器 `curMode` 复位为 **M**（2'b11）；`misa` 为只读常量，值由 `IsaConfig.misaValue`（MXL + I + 扩展字母位 + U/S 位）推导
- S 模式（`isa.priv.hasSupervisor`）：`sstatus/sie/stvec/sscratch/sepc/scause/stval/sip/satp` 由 `CsrMap` 在 S 栈下纳入；`sstatus` 是 `mstatus` 的字段视图（共享存储，仅在 `SIE/SPIE/SPP/FS/SUM/MXR/UXL` 位可见），`sie` 是 `mie` 在 S 中断位上的投影，`sip` 为只读投影；`satp` 为 WARL，MODE 域强制 BARE、ASID/PPN 原样保存
- **位掩码写**：仅实现位可写，保留位读 0 写忽略；`misa/mip/mhartid` 只读，写入在 EX 判非法
- 已实现地址集与只读地址集由 ISA 层的 `CsrMap` 派生（`implementedFor/readOnlyFor`），EX 合法性检查与 `CsrFile` 读通路共用同一事实源；异常号为 `ExceptionCode` 具名常量
- `mip.MTIP` 直接由顶层输入 `timerInterrupt` 电平组合反映，不经写口
- 写口（WB 同步提交）：CSR 普通写 `csrWe/csrWrData/csrAddr`、trap 提交写口（`trapEna/trapToS/cause/epc/tval`）、`mretEna`/`sretEna` 状态写口——同一拍至多一条指令写 CSR，单写端口语义与寄存器堆一致
- 读口：WB 读口（返回写前旧值，作为 `csrr*` 的 rd 源）、EX 控制读口（`mtvec/mepc/mstatus` 域、`curMode`，供 trap 重定向与非法复核）
- `mstatus` 可写域：`MIE(3)/MPIE(7)/MPP(12:11)/SIE(1)/SPIE(5)/SPP(8)/FS(14:13)/SUM(18)/MXR(19)`；`mie` 可写域：`MTIE(7)/STIE(5)/SSIE(1)/SEIE(9)`；`medeleg` 仅接受已实现的同步异常位，`mideleg` 仅接受定时器中断位（bit7）
- **浮点 CSR（`isa.hasFpu`）**：`fflags(0x001)`、`frm(0x002)`、`fcsr(0x003)` 由 `CsrMap.implementedFor` 在 F 使能时纳入；提交 FP 指令时 `fpFlagsWe/fpFlags` 累积异常标志到 `fflags`（与 WB 写口同拍 OR 合并），`fpDirty` 把 `mstatus.FS` 置 Dirty；`fcsr` 高 5 位即 `frm`、低 5 位即 `fflags`

### 同步异常（EX 级判定并提交）

- `ecall`：cause 由 `ecallCause(curMode)` 派生（U→8、S→9、M→11）。`ebreak`：cause 3。非法指令/CSR 访问违例：cause 2，`mtval`=违例 CSR 地址或指令字；`MPP`/`SPP` 不属于配置特权栈的 `mret`/`sret`：cause 2
- 模式合法性由 `PrivConfig.supportedEncodings` 驱动：`mppSupported`/`sppSupported` 判断返回目标是否为已实现模式；CSR 权限按**被访问地址**的 `minPriv` 判定（`privAtLeast`），S 模式可访问 S 级与非特权 CSR，M 级 CSR 仍为 M 专属
- 判定所需 CSR 域（写只读、`mtvec/stvec.MODE≠0`、当前模式低于 CSR 最低特权、MRET/SRET 目标模式非法等）由 EX 控制读口实时读取，避免对 1-2 槽前未提交写敏感
- **委托**：trap 在 M 下发生时始终进入 M；在 S/U 下发生且 `medeleg[cause]=1` 时进入 S（`trapToS`）。提交目标为 `Mux(trapToS, stvec.BASE, mtvec.BASE)`（固定 MODE=0 取址）
- 提交 = 复用 `ctrlFlush` 重定向：该拍不产生 WB 副作用；进入 M 时写 `mepc/mcause/mtval` 并更新 `mstatus`（`MPIE←MIE, MIE←0, MPP←curMode`）、`curMode←M`；进入 S 时写 `sepc/scause/stval` 并更新 `mstatus`（`SPIE←SIE, SIE←0, SPP←curMode`）、`curMode←S`

### 定时器中断（取指边界接受）

- 机器级接受条件：`timerInterrupt && mie.MTIE && !mideleg[7] && (curMode≠M || mstatus.MIE)`；S 级接受条件：`timerInterrupt && mie.STIE && mideleg[7] && (curMode==U || (curMode==S && mstatus.SIE))`。两者都要求当前拍无 EX trap、无分支/跳转/trap flush、无 `mret`/`sret`、无 load/CSR 停顿、流水线无冻结
- `mepc`/`sepc` = 被中断指令地址（EX 有合法指令取其 pc，否则取 ID 的 pc，管线排空情形取取指地址）；M 级 cause=`0x80000007`，S 级 cause=`0x80000005`，`mtval/stval=0`
- 同步异常优先级高于中断（EX trap 一拍内先提交）

### MRET / SRET（EX 级）

- `mret`：`pc←mepc`，`mstatus` 恢复 `MIE←MPIE, MPIE←1, MPP←M`，`curMode←原 MPP`（M/S/U 栈下可为 M 或 S）；写回/旁路不受影响
- `sret`：仅 S 模式合法，`pc←sepc`，`mstatus` 恢复 `SIE←SPIE, SPIE←1, SPP←U`，`curMode←原 SPP`
- 两者都与其 1-2 槽内未提交的 `mepc/sepc/mstatus/sstatus` CSR 写之间停顿防冒险（`csrXretStall`）
- 若 `MPP`/`SPP` 编码不属于配置特权栈，或 `mret` 不在 M、`sret` 不在 S，则判非法（cause 2）而非执行

## 总线接口

核心通过两个握手接口对外访问，均支持 `valid/ready` 反压：

- `IBusInterface`：`valid` + `pc` → `ready` + `instruction`
- `DBusInterface`：`valid/write/size/address/writeData/writeMask` → `ready/readData`

当前仿真内存模型为零等待（组合读），未来可在此接口后接入 SRAM 控制器或缓存，无需改动核心。

## 关键设计决策

| 决策 | 选择 | 理由 |
|------|------|------|
| 分支判定阶段 | EX | 比 MEM 阶段少 1 拍错误预测代价，不引入专用预测器 |
| 数据冒险 | 两级旁路 + EX 段组合读寄存器堆 | 覆盖任意间距 RAW，仅 load/CSR 结果需停顿 1 拍 |
| 寄存器堆 | 单写端口，WB 集中提交；EX 组合读 | 提交语义简单一致，多读口无写端口竞争 |
| 同步异常判定 | EX 级单拍判定+提交 | 复用分支 flush 通路，trap 无 WB 副作用 |
| 中断 | 取指边界接受，`mepc` 排空取址 | 同步异常优先，避免回写一半的状态 |
| 哈佛结构 | 独立 I/D 总线 | 避免单端口存储器的吞吐瓶颈，接口对称易扩展 |
| 位宽参数化 | 全程使用 `isa.xlen`（经 `CoreConfig`） | 从 RV32 迁移 RV64 只需改一处配置 |
| RV32M 乘法 | ALU 内组合乘法 | 单周期出结果，零流水线代价 |
| RV32M 除法 | EX 段恢复除法器 + 整条流水线冻结 | 面积/时序友好；`IsaConfig` 不含 `MulDiv` 时不实例化 |
| RV32A / RV64A 原子 | MEM 段「读→改→写」状态机 + 流水线冻结；LR/SC 预约集 | 单核下无需总线锁即可保证原子性；`IsaConfig` 不含 `Atomic` 时整体剪除 |
| RV32F / RV64F / RV64D 浮点 | EX 段参数化组合 FPU + 单冻结周期；独立浮点寄存器堆；FP 结果仅 WB 转发；D 核实例化 binary32 + binary64 两个单元并按 fmt 路由 | 复用统一 `freezeAll` 与停滞框架；`expw/sigw` 参数化 + `roundPackTo` 支持格式转换；双单元避免双重舍入；F 关闭时 FPU/FP 寄存器堆整体剪除 |
| Zba / Zbb / Zbs / Zbc / Zbkb / Zbkc / Zbkx 位操作 | EX 段组合 ALU 结果选择，复用现有结果通路与转发网络 | 无新增流水线状态或停顿；未使能的 `Zb*` 分支在 elaboration 期被剪除 |
| Zknh SHA-2 哈希位操作 | EX 段组合 ALU 结果选择（定宽 `ROR`/`SHR`），复用现有结果通路与转发网络 | 无新增流水线状态或停顿；未使能时编码保持 cause 2 |
| Zksh / Zksed SM3/SM4 位操作 | EX 段组合 ALU 结果选择（SM3 定宽 `ROL`；SM4 S-box 查表 + 线性变换 + `bs` 旋转移位） | 新增 2 位 `bs` 随 ID/EX 传递；无新增停顿；未使能时编码保持 cause 2 |
| Zknd / Zkne AES 位操作 | EX 段组合 ALU 结果选择（ShiftRows/InvShiftRows + 加密/解密 S-box + MixColumns/InvMixColumns + 密钥调度） | 复用 2 位 `bs`，新增 4 位 `rcon` 随 ID/EX 传递；无新增停顿；未使能时编码保持 cause 2 |
| Zicond 条件运算 | EX 段组合 ALU 结果选择（`rs2 == 0` 判定后选择 `rs1` 或零） | 无新增流水线状态或停顿；未使能时编码保持 cause 2 |
| Zifencei 指令流同步 | `fence.i` 作为合法提交点（无缓存失效动作） | 无新增状态；未使能时为 cause 2 |
| Zicntr 用户计数器 | `CsrFile` 内 64 位 `cycle/instret` 计数器 + `mcounteren/scounteren` 门控；RV32 拆分高半字 | 新增退休回写信号 `retire`；计数器自由运行，不引入停顿 |
| Zcb 压缩访存与运算 | 16 位压缩编码复用 32 位译码字段，访存走统一 LSU，寄存器运算复用 ALU（`AND 0xFF`/`XOR -1`/Zbb/Zba 操作） | 无新增状态；前置扩展缺失时该编码为 cause 2 |
| Sstc 监督者定时器比较 | `CsrFile` 内 64 位 `stimecmp` 与 `menvcfg.STCE`；比较 Zicntr 的 `time` 产生 STIP，经 `mideleg.STIP` 走既有 S 级中断接受逻辑 | 无新增流水线状态；`menvcfg` 为 WARL 仅保留 STCE，RV32 通过高半字寄存器拼接 |
| S 模式（M/S/U） | S 级 CSR 与 `mstatus` 共享存储；`medeleg/mideleg` 决定 trap 目标（`stvec`/`mtvec`）；`SRET` 与 `MRET` 对称；`satp` 仅 BARE | 复用既有 EX trap 提交与 flush 通路；无 MMU/TLB 状态，S 级中断经委托复用同一接受逻辑 |

## 未来演进（对应参数化预留）

- **RV64**：RV64I、RV64M（`*W` 后缀，复用按 `xlen` 参数化的 ALU/除法器）、RV64C 压缩编码、RV64A 原子（`.W`/`.D`）、RV64F/RV64D 浮点（参数化 FPU）与 RV64 Zba/Zbb/Zbs/Zbc/Zbkb/Zbkc/Zbkx 位操作及 Zknh SHA-2、Zksh SM3、Zksed SM4、Zknd/Zkne AES 密码位操作、Zicond 条件运算、Zcb 附加压缩指令、Zifencei 指令流同步（W 形式按 `xlen` 展开）、Zicntr 用户计数器、Sstc 监督者定时器比较与 S 模式（M/S/U 特权栈、S 级 CSR、异常/中断委托、SRET）已实现；SV39 MMU 待补
- **分支预测**：`BranchPredictorConfig` 已预留，可插入 BHT/gshare
- **缓存**：`withICache/withDCache` 配置项已定义，后续在总线接口后挂接
- **多核**：`numCores` 参数化，互联核外组合
