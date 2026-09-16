# 指令集支持

当前版本实现 **RV32I / RV64I** 基础整数指令集、**RV32M** 乘除扩展、**RV64M** 的 W 后缀乘除，以及 **RV32C** 压缩指令扩展（RISC-V 规范 v2.1+ 中 I 扩展的全部指令）。位宽由 `IsaConfig.xlen` 选择；M 扩展由 `RvExtension.MulDiv` 使能，C 扩展由 `RvExtension.Compressed` 使能（仅 RV32，默认 RV32 配置为 `rv32im`，压缩核配置为 `rv32imc`）。RV64 下额外支持 `*W` 后缀指令、64 位移位与 `LD/LWU/SD`；RV64C、S/H 模式为 roadmap。

## 指令覆盖矩阵

### 整数运算（OP, 0110011）

| 指令 | funct3 | funct7 | 实现状态 |
|------|--------|--------|----------|
| ADD | 000 | 0000000 | 已实现 |
| SUB | 000 | 0100000 | 已实现 |
| SLL | 001 | 0000000 | 已实现 |
| SLT | 010 | 0000000 | 已实现 |
| SLTU | 011 | 0000000 | 已实现 |
| XOR | 100 | 0000000 | 已实现 |
| SRL | 101 | 0000000 | 已实现 |
| SRA | 101 | 0100000 | 已实现 |
| OR | 110 | 0000000 | 已实现 |
| AND | 111 | 0000000 | 已实现 |

### 乘除（RV32M, OP, funct7=0000001）

| 指令 | funct3 | 实现方式 |
|------|--------|----------|
| MUL | 000 | 组合乘法，取乘积低 32 位 |
| MULH | 001 | 组合乘法，取有符号×有符号高 32 位 |
| MULHSU | 010 | 组合乘法，取有符号×无符号高 32 位 |
| MULHU | 011 | 组合乘法，取无符号×无符号高 32 位 |
| DIV | 100 | EX 段多周期除法器（有符号，向零截断） |
| DIVU | 101 | EX 段多周期除法器（无符号） |
| REM | 110 | EX 段多周期除法器（余数符号同被除数） |
| REMU | 111 | EX 段多周期除法器（无符号余数） |

> 说明：乘法在 ALU 内组合完成；DIV/REM 共享一个恢复除法器，运算期间整条流水线冻结（约 `xlen` 拍），完成后结果经原 EX/MEM 旁路/回写路径送出。除零返回 quotient=全 1、remainder=被除数；有符号 MIN/-1 溢出返回 MIN（余数 0），均符合规范。

### 乘除（RV64M, OP-32, opcode=0111011, funct7=0000001）

| 指令 | funct3 | 语义 |
|------|--------|------|
| MULW | 000 | 32 位乘法，取低 32 位后符号扩展 |
| DIVW | 100 | 32 位有符号除法，结果符号扩展（MIN/-1 溢出返回 MIN） |
| DIVUW | 101 | 32 位无符号除法，结果符号扩展 |
| REMW | 110 | 32 位有符号余数，结果符号扩展 |
| REMUW | 111 | 32 位无符号余数，结果符号扩展 |

> 说明：MULW 在 ALU 内组合完成。DIVW/DIVUW/REMW/REMUW 复用同一个 `xlen` 位除法器：有符号 W 操作数按低 32 位符号扩展、无符号 W 操作数按低 32 位零扩展送入，输出的 32 位结果再符号扩展到 `xlen`（与规范一致）。除零与 MIN/-1 溢出语义同 RV32M，按 32 位判定。

### 立即数运算（OP-IMM, 0010011）

| 指令 | funct3 | 实现状态 |
|------|--------|----------|
| ADDI | 000 | 已实现 |
| SLLI | 001 | 已实现 |
| SLTI | 010 | 已实现 |
| SLTIU | 011 | 已实现 |
| XORI | 100 | 已实现 |
| SRLI / SRAI | 101 | 已实现 |
| ORI | 110 | 已实现 |
| ANDI | 111 | 已实现 |

### 载入（LOAD, 0000011）

| 指令 | funct3 | 实现状态 |
|------|--------|----------|
| LB | 000 | 已实现 |
| LH | 001 | 已实现 |
| LW | 010 | 已实现 |
| LBU | 100 | 已实现 |
| LHU | 101 | 已实现 |
| LWU | 110 | 仅 RV64：零扩展 32 位 |
| LD | 011 | 仅 RV64：加载双字 |

### 存储（STORE, 0100011）

| 指令 | funct3 | 实现状态 |
|------|--------|----------|
| SB | 000 | 已实现 |
| SH | 001 | 已实现 |
| SW | 010 | 已实现 |
| SD | 011 | 仅 RV64：存储双字 |

### RV64 专属（OP-IMM-32 / OP-32, 0011011 / 0111011）

| 指令 | opcode | funct3 | funct7 | 语义 |
|------|--------|--------|--------|------|
| ADDIW | 0011011 | 000 | — | 32 位加立即数，结果符号扩展 |
| SLLIW | 0011011 | 001 | — | 32 位逻辑左移（立即数） |
| SRLIW / SRAIW | 0011011 | 101 | — | 32 位右移（instr[30] 选逻辑/算术） |
| ADDW / SUBW | 0111011 | 000 | 0000000 / 0100000 | 32 位加/减，结果符号扩展 |
| SLLW | 0111011 | 001 | 0000000 | 32 位逻辑左移 |
| SRLW | 0111011 | 101 | 0000000 | 32 位逻辑右移 |
| SRAW | 0111011 | 101 | 0100000 | 32 位算术右移 |

> 所有 `*W` 指令只取操作数低 32 位、产生 32 位结果，再符号扩展到 64 位写回。RV64 的 `SLLI/SRLI/SRAI` 移位量为 `instr[25:20]`（6 位），RV32 为 `instr[24:20]`。

### 压缩指令（RV32C, 16 位编码，仅当 `RvExtension.Compressed` 使能）

取指阶段保持 32 位指令总线，核内按 `pc[1]` 选择半字；当 32 位指令起始于高半字时，用一拍停顿锁存高半字并拼接下一个字。压缩指令在译码级展开为等价的标准操作。

| 指令 | quadrant / funct3 | 内部等价 |
|------|-------------------|----------|
| C.ADDI4SPN | 00 / 000 | `addi rd', x2, nzuimm`（nzuimm=0 非法） |
| C.LW / C.SW | 00 / 010 / 110 | word 载入/存储，base=rs1' |
| C.ADDI / C.NOP | 01 / 000 | `addi rd, rd, nzimm` |
| C.JAL | 01 / 001 | 跳转并链接 `pc+2` 到 x1 |
| C.LI | 01 / 010 | `addi rd, x0, imm` |
| C.ADDI16SP / C.LUI | 01 / 011 | `addi x2,x2,imm` / `lui`（crd=0 或 c6=0 非法） |
| C.SRLI / C.SRAI / C.ANDI | 01 / 100 | `srli/srai/andi rd', rd', imm`（shamt[5]=1 非法） |
| C.SUB/XOR/OR/AND | 01 / 100 (11) | 对应寄存器 ALU 操作 |
| C.J | 01 / 101 | 跳转 `pc+2` |
| C.BEQZ / C.BNEZ | 01 / 110 / 111 | `beq/bne rs1', x0` |
| C.SLLI | 10 / 000 | `slli rd, rd, shamt`（shamt[5]=1 非法） |
| C.LWSP | 10 / 010 | word 载入，base=x2（rd=0 非法） |
| C.JR / C.MV | 10 / 100 (bit12=0) | 跳转 `rs1` / `add rd, x0, rs2` |
| C.EBREAK / C.JALR / C.ADD | 10 / 100 (bit12=1) | `ebreak` / 跳转链接 `pc+2` / `add rd, rd, rs2` |
| C.SWSP | 10 / 110 | word 存储，base=x2 |

> 非法/保留压缩编码（含 RV64C 专属、`C.ADDI4SPN` nzuimm=0、`C.LUI` imm=0/rd=0、`C.LWSP` rd=0、RV32 shamt[5]=1 等）统一触发 cause 2，`mepc` 记录压缩指令的精确地址。C 关闭时取指与译码逻辑逐拍等价于非压缩核。

### 分支（BRANCH, 1100011）

| 指令 | funct3 | 实现状态 |
|------|--------|----------|
| BEQ | 000 | 已实现 |
| BNE | 001 | 已实现 |
| BLT | 100 | 已实现 |
| BGE | 101 | 已实现 |
| BLTU | 110 | 已实现 |
| BGEU | 111 | 已实现 |

### 跳转与访存上下类

| 指令 | opcode | 实现状态 |
|------|--------|----------|
| JAL | 1101111 | 已实现（写回 pc+4） |
| JALR | 1100111 | 已实现（目标 LSB 清零） |
| LUI | 0110111 | 已实现 |
| AUIPC | 0010111 | 已实现 |

### 其他

| 指令 | opcode | 实现状态 |
|------|--------|----------|
| FENCE | 0001111 | 当作 NOP 处理（单核无一致性需求） |
| ECALL / EBREAK | 1110011 | 已实现（M 模式 cause 11 / 3，U 模式 cause 8 / 3，见下文） |
| MRET | 1110011 | 已实现（M 模式恢复 mstatus/模式并跳转 mepc） |
| WFI | 1110011 | 当作 NOP 处理 |
| SRET / URET | 1110011 | 译码为非法指令（cause 2） |

## Zicsr：CSR 访问指令（SYSTEM, 1110011）

CSR 指令在译码级无条件支持（与 RV32I 同属基础路径）。下表 funct3 与 `CSR` 地址段含义同 RISC-V 规范。

| 指令 | funct3 | 语义 | 实现状态 |
|------|--------|------|----------|
| CSRRW | 001 | 读旧值写新值（rs1 值；rs1=x0 时仅读） | 已实现 |
| CSRRS | 010 | 读旧值，按 rs1 置位（rs1=x0 仅读） | 已实现 |
| CSRRC | 011 | 读旧值，按 rs1 清位（rs1=x0 仅读） | 已实现 |
| CSRRWI | 101 | 读旧值，写 zimm 零扩展 | 已实现 |
| CSRRSI | 110 | 读旧值，按 zimm 置位（zimm=0 仅读） | 已实现 |
| CSRRCI | 111 | 读旧值，按 zimm 清位（zimm=0 仅读） | 已实现 |

> CSR 的 `rd` 总是返回写前旧值；`rd=x0` 时忽略写回。CSR 写与异常/中断的优先级见 `architecture.md` 的 trap 通路。

## 特权模式、异常与中断

- 支持 **M/U 两种特权模式**，复位进入 M；通过 `mret`（MPP=0 时）或异常委托路径进入 U，U 内非法/`ecall` 回到 M
- 内置 CSR（全部 32 位）：`mstatus/misa/mie/mtvec/mscratch/mepc/mcause/mtval/mip/mhartid`
  - 仅实现位可写，保留位读 0 写忽略；`misa/mip/mhartid` 只读：CSRRW/I 写入触发 cause 2，CSRRS/CSRRC 命中只读位按读处理
  - `mtvec` 的 MODE 域写入非 0 值触发 cause 2；trap 重定向恒按 direct 模式取 `{mtvec.BASE,2'b00}`
  - `mip.MTIP` 由顶层 `timerInterrupt` 输入电平直接反映
  - `mstatus` 可写域：`MIE/MPIE/MPP(3)/FS`；`mie.MTIE` 是唯一可写中断使能位
- 同步异常 cause：ECALL(M)=11、ECALL(U)=8、EBREAK=3、非法指令/CSR 访问违例=2、`MPP` 不在配置特权栈的 MRET=2
- 机器定时器中断：`mip.MTIP && mie.MTIE && mstatus.MIE && curMode=M` 时在取指边界接受，cause=0x80000007，`mtval=0`
- 复位 `debugPc` 回到 `resetVector`，内部 CSR/模式全部清零/复位为 M

## 立即数编码

| 类型 | 生成规则 |
|------|----------|
| I | `instr[31:20]` 符号扩展 |
| S | `{instr[31:25], instr[11:7]}` 符号扩展 |
| B | `{instr[31], instr[7], instr[30:25], instr[11:8]}` 符号扩展后左移 1 位 |
| U | `instr[31:12]` 左移 12 位 |
| J | `{instr[31], instr[19:12], instr[20], instr[30:21]}` 符号扩展后左移 1 位 |

## 已确认的 RISC-V 语义

- `rd == x0` 时寄存器写被忽略（硬件保证）
- load/store 支持非对齐地址下的字节/半字选择（字节偏移由地址低 2 位决定）
- JALR 目标强制字节对齐（结果 LSB 清零）
- 分支目标按字节地址计算（`pc + 符号扩展立即数`）

## 后续扩展计划

- **S 模式**：S 级 CSR（`sstatus/stvec/sepc/scause/stval` 等）、异常委托、`SRET` 与 SV39 MMU
- **RV64C**：压缩指令的 RV64 专属编码（`C.LD/C.SD`、64 位 `C.SLLI` 等），当前仅 RV32 使能
- **A/F/D**：原子、浮点扩展（`RvExtension` 的 `reserved` 集合）
