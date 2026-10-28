# 指令集支持

当前版本实现 **RV32I / RV64I** 基础整数指令集、**RV32M** 乘除扩展、**RV64M** 的 W 后缀乘除、**RV32A / RV64A** 原子扩展（LR/SC 与 9 种 AMO）、**RV32C / RV64C** 压缩指令扩展（RISC-V 规范 v2.1+ 中 I 扩展的全部指令，含 RV64 专属编码）、**RV32F / RV64F** 单精度与 **RV64D** 双精度浮点扩展（FLW/FSW/FLD/FSD、算术/比较/分类/转换/FMA/格式转换，5 种舍入与 fflags），以及 **Zba / Zbb / Zbs / Zbc / Zbkb / Zbkc / Zbkx / Zknh / Zksh / Zksed / Zknd / Zkne** 位操作扩展（RV32 与 RV64 均支持）。位宽由 `IsaConfig.xlen` 选择；M 扩展由 `RvExtension.MulDiv` 使能，A 扩展由 `RvExtension.Atomic` 使能，C 扩展由 `RvExtension.Compressed` 使能（RV32 与 RV64 均支持），F 扩展由 `RvExtension.SingleFloat` 使能，D 扩展由 `RvExtension.DoubleFloat` 使能（蕴含 F，仅 RV64），位操作扩展分别由 `RvExtension.Zba` / `RvExtension.Zbb` / `RvExtension.Zbs` / `RvExtension.Zbc` / `RvExtension.Zbkb` / `RvExtension.Zbkc` / `RvExtension.Zbkx` / `RvExtension.Zknh` / `RvExtension.Zksh` / `RvExtension.Zksed` / `RvExtension.Zknd` / `RvExtension.Zkne` 使能（均为无 MISA 位的命名扩展）；默认 RV32 配置为 `rv32im`，原子核配置为 `rv32ima` / `rv64ima`，压缩核配置为 `rv32imc` / `rv64imc`，浮点核配置为 `rv32f` / `rv64f` / `rv64d`，位操作核配置为 `rv32imzbb` / `rv64imzbb` / `rv32imzbs` / `rv64imzbs` / `rv32imzba` / `rv64imzba` / `rv32imzbc` / `rv64imzbc` / `rv32imzbkb` / `rv64imzbkb` / `rv32imzbkc` / `rv64imzbkc` / `rv32imzbkx` / `rv64imzbkx` / `rv32imzbk` / `rv64imzbk` / `rv32imzknh` / `rv64imzknh` / `rv32imzksh` / `rv64imzksh` / `rv32imzksed` / `rv64imzksed` / `rv32imzks` / `rv64imzks` / `rv32imzknd` / `rv64imzknd` / `rv32imzkne` / `rv64imzkne` / `rv32imzkn` / `rv64imzkn`。RV64 下额外支持 `*W` 后缀指令、64 位移位与 `LD/LWU/SD`；S/H 模式为 roadmap。

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

### 压缩指令（RV32C / RV64C, 16 位编码，仅当 `RvExtension.Compressed` 使能）

取指阶段保持 32 位指令总线，核内按 `pc[1]` 选择半字；当 32 位指令起始于高半字时，用一拍停顿锁存高半字并拼接下一个字。压缩指令在译码级展开为等价的标准操作。RV32 与 RV64 共用同一压缩取指通路，专属编码按 `xlen` 区分。

| 指令 | quadrant / funct3 | 内部等价 |
|------|-------------------|----------|
| C.ADDI4SPN | 00 / 000 | `addi rd', x2, nzuimm`（nzuimm=0 非法） |
| C.LW / C.SW | 00 / 010 / 110 | word 载入/存储，base=rs1' |
| C.LD / C.SD | 00 / 011 / 111 | doubleword 载入/存储，base=rs1'（仅 RV64） |
| C.ADDI / C.NOP | 01 / 000 | `addi rd, rd, nzimm` |
| C.JAL | 01 / 001 | 跳转并链接 `pc+2` 到 x1（仅 RV32） |
| C.ADDIW | 01 / 001 | `addiw rd, rd, imm`（仅 RV64，rd=0 非法） |
| C.LI | 01 / 010 | `addi rd, x0, imm` |
| C.ADDI16SP / C.LUI | 01 / 011 | `addi x2,x2,imm` / `lui`（crd=0 或 c6=0 非法） |
| C.SRLI / C.SRAI / C.ANDI | 01 / 100 | `srli/srai/andi rd', rd', imm`（RV32 shamt[5]=1 非法，RV64 允许 6 位 shamt） |
| C.SUB/XOR/OR/AND | 01 / 100 (11) | 对应寄存器 ALU 操作 |
| C.SUBW/C.ADDW | 01 / 100 (11, bit12=1) | 对应 32 位 ALU 操作并符号扩展（仅 RV64） |
| C.J | 01 / 101 | 跳转 `pc+2` |
| C.BEQZ / C.BNEZ | 01 / 110 / 111 | `beq/bne rs1', x0` |
| C.SLLI | 10 / 000 | `slli rd, rd, shamt`（RV32 shamt[5]=1 非法，RV64 允许 6 位 shamt） |
| C.LWSP | 10 / 010 | word 载入，base=x2（rd=0 非法） |
| C.LDSP / C.SDSP | 10 / 011 / 111 | doubleword 载入/存储，base=x2（仅 RV64，C.LDSP rd=0 非法） |
| C.JR / C.MV | 10 / 100 (bit12=0) | 跳转 `rs1` / `add rd, x0, rs2` |
| C.EBREAK / C.JALR / C.ADD | 10 / 100 (bit12=1) | `ebreak` / 跳转链接 `pc+2` / `add rd, rd, rs2` |
| C.SWSP | 10 / 110 | word 存储，base=x2 |

> 非法/保留压缩编码（`C.ADDI4SPN` nzuimm=0、`C.LUI` imm=0/rd=0、`C.LWSP`/`C.LDSP` rd=0、RV32 shamt[5]=1、RV64 核上出现 RV32 专属编码，以及 RV32 核上出现 RV64 专属编码）统一触发 cause 2，`mepc` 记录压缩指令的精确地址。C 关闭时取指与译码逻辑逐拍等价于非压缩核。

### 原子指令（RV32A / RV64A, opcode=0101111，仅当 `RvExtension.Atomic` 使能）

A 扩展的 `funct5` 位于 `instr[31:27]`；`funct3=010` 为 `.W`（32 位），`funct3=011` 为 `.D`（doubleword，仅 RV64）。LR/SC 与 AMO 的有效地址均为 `rs1`（无偏移），`.W` 形式在 RV64 上只访问低/高 32 位并按符号扩展回写 rd。

| 指令 | funct5 | 语义 |
|------|--------|------|
| LR.W / LR.D | 00010 | 载入并建立地址预约（rd=旧值） |
| SC.W / SC.D | 00011 | 仅当预约有效且地址匹配时写入；rd=0 成功 / 1 失败 |
| AMOADD.W / .D | 00000 | 读-改-写：旧值送 rd，内存写 `mem + rs2` |
| AMOSWAP.W / .D | 00001 | 内存写 `rs2`，旧值送 rd |
| AMOXOR.W / .D | 00100 | `mem ^ rs2` |
| AMOOR.W / .D | 01000 | `mem \| rs2` |
| AMOAND.W / .D | 01100 | `mem & rs2` |
| AMOMIN.W / .D | 10000 | 有符号 `min(mem, rs2)` |
| AMOMAX.W / .D | 10100 | 有符号 `max(mem, rs2)` |
| AMOMINU.W / .D | 11000 | 无符号 `min` |
| AMOMAXU.W / .D | 11100 | 无符号 `max` |

> 原子性：AMO 在 MEM 级以「读 → 改 → 写」两拍状态机实现，期间冻结整条流水线（`amoStall`），读回应值与组合运算结果锁存后再发起写，单核下不存在中间可见状态。LR 建立的预约在整个流水线推进时设置；任何提交的存储、SC 或已提交的 AMO 都会清除预约，因此上下文切换/中断天然使预约失效。SC 仅在预约有效且地址相等时驱动总线写。AMO 结果（旧值）经 MEM/WB 旁路回写 rd，可被紧随其后的指令前递。
>
> 对齐：A 访问地址未按访问宽度自然对齐时触发地址非对齐异常——LR 为 cause 4（load address misaligned），SC/AMO 为 cause 6（store/AMO address misaligned），`mtval` 记录故障地址，且在产生任何内存副作用之前陷阱。非本宽度的 `funct3`、未知 `funct5`、以及 A 关闭时出现 opcode `0101111` 均触发 cause 2。

### 浮点指令（RV32F / RV64F / RV64D，单精度由 `RvExtension.SingleFloat` 使能，双精度由 `RvExtension.DoubleFloat` 使能）

FP 扩展使用独立的浮点寄存器堆（`f0`–`f31`，无硬连线零寄存器），FLEN 由配置推导：仅 F 时为 32，含 D 时为 64。指令按 fmt 域区分单精度（fmt=00，`.S`）与双精度（fmt=01，`.D`，仅 RV64）。D 核同时实例化 `FpUnit(8,23)`（binary32）与 `FpUnit(11,52)`（binary64）两个运算单元，按指令 fmt 路由，避免在宽格式中二次舍入；`FCVT.S.D` / `FCVT.D.S` 由 binary64 单元执行。FP 指令通路仅在 `isa.hasFpu` 时生成，且要求 `mstatus.FS != Off`，否则触发 illegal（cause 2）。

**访存（opcode 0000111 / 0100111）**

| 指令 | funct3 | 语义 |
|------|--------|------|
| FLW | 010 | 32 位载入到 `frd` |
| FSW | 010 | 32 位存储 `frs2` |
| FLD / FSD | 011 | 64 位载入/存储（仅 RV64 + D） |

> F 核（FLEN=32）下 FLW/FSW 地址按 4 字节对齐检查，未对齐触发 cause 4 / 6；D 核下 FLD/FSD 按 8 字节对齐。FLEN=64 时 FP 写回做 NaN-boxing：单精度结果的高 32 位置 1。FS=Off 时 FP 访存同样触发 cause 2。

**算术（OP-FP, opcode 1010011，funct7 = funct6<<1 | fmt）**

| 指令 | funct6 | 语义 |
|------|--------|------|
| FADD.S / FADD.D | 000000 | 加法（单次舍入） |
| FSUB.S / FSUB.D | 000010 | 减法 |
| FMUL.S / FMUL.D | 000100 | 乘法 |
| FDIV.S / FDIV.D | 000110 | 除法 |
| FSQRT.S / FSQRT.D | 010110 | 平方根 |
| FSGNJ / FSGNJN / FSGNJX | 001000 | 符号注入（funct3 000/001/010） |
| FMIN / FMAX | 001010 | 最小/最大（NaN 与 ±0 按规范处理，funct3 000/001） |
| FLE / FLT / FEQ | 101000 | 比较，结果写整数 rd（funct3 000/001/010） |
| FCLASS | 111000 (funct3=001) | 分类结果写整数 rd（10 位掩码） |
| FMV.X.W | 111000 (funct3=000) | FP→整数寄存器搬运 |
| FMV.W.X | 111100 (funct3=000) | 整数→FP 搬运 |
| FCVT.W.* / WU / L / LU | 110000 | FP→整数转换（源格式由 fmt 域选择；`WU` 与 RV64 专属 `L/LU` 由 rs2 域选择） |
| FCVT.S.W / WU / L / LU | 110100 | 整数→FP 转换（目标格式由 fmt 域选择；RV64 专属 `L/LU` 由 rs2 域选择） |
| FCVT.S.D | 010000 (fmt=00) | 双精度→单精度（精确舍入到单精度） |
| FCVT.D.S | 010000 (fmt=01) | 单精度→双精度（精确宽化；sNaN 置 NV，结果取规范 NaN） |

> `FCVT.S.D` / `FCVT.D.S`（funct6 `010000`）仅在 `RvExtension.DoubleFloat` 使能时合法，否则触发 cause 2。`FCVT.D.S` 的输入按 NaN-boxing 规则解码：FLEN=64 时高 32 位非全 1 的单精度源视为非 boxed 并取规范 NaN。

**融合乘加（opcode 1000011/1000111/1001011/1001111）**

| 指令 | opcode | 语义 |
|------|--------|------|
| FMADD.S / .D | 1000011 | `a*b + c`（单次舍入） |
| FMSUB.S / .D | 1000111 | `a*b - c` |
| FNMSUB.S / .D | 1001011 | `-(a*b) + c` |
| FNMADD.S / .D | 1001111 | `-(a*b) - c` |

> **运算单元**：`FpUnit(expw, sigw)` 参数化——单精度为 `(8, 23)`，双精度为 `(11, 52)`；工作精度 `P = sigw + 1`，内部保留 `P+3` 位（含保护/舍入/粘滞位），统一经 `roundPack` / `roundPackTo(target)` 完成任意目标格式的单次舍入（收窄时低位折入 sticky）。支持 5 种舍入模式（RNE/RTZ/RDN/RUP/RMM）：动态模式取自 `frm`，静态模式来自指令 `rm`（`rm=111` 时使用 `frm`）。运算在 EX 段组合完成，置 `fpStall` 冻结 1 拍（复用统一 `freezeAll`），结果仅经 WB 旁路。D 核的格式转换（`FCVT.S.D` / `FCVT.D.S`）在 binary64 单元上执行。
>
> **CSR 与状态**：`fflags(0x001)`、`frm(0x002)`、`fcsr(0x003)` 仅在 FPU 使能时实现；提交任意 FP 算术指令会累积 NV/DZ/OF/UF/NX 异常标志到 `fflags`，并将 `mstatus.FS` 置 Dirty(11)。`frm` 为 WARL，仅接受 0–4。`mstatus.FS` 为 WARL（`FS=Off` 时 FP 指令与 FP CSR 访问均非法）。

### 位操作指令（Zba / Zbb / Zbs / Zbc / Zbkb / Zbkc / Zbkx / Zknh / Zksh / Zksed / Zknd / Zkne / Zicond / Zcb，分别由对应 `RvExtension.*` 使能）

所有 `Zb*`、`Zknh` 与 `Zk*` 均为无 MISA 位的命名扩展（单字母 `B` 位保留），仅当对应 `RvExtension` 使能时其编码合法，否则按非法指令（cause 2）处理。所有位操作在 EX 段组合完成，复用现有 ALU 结果通路，不引入新的停顿状态。

**Zbb（基础位操作）**

| 指令 | opcode | funct7 | funct3 | 其他 | 语义 |
|------|--------|--------|--------|------|------|
| ANDN | 0110011 | 0100000 | 111 | | `rs1 & ~rs2` |
| ORN | 0110011 | 0100000 | 110 | | `rs1 \| ~rs2` |
| XNOR | 0110011 | 0100000 | 100 | | `~(rs1 ^ rs2)` |
| MIN / MINU | 0110011 | 0000101 | 100 / 101 | | 有符号 / 无符号最小值 |
| MAX / MAXU | 0110011 | 0000101 | 110 / 111 | | 有符号 / 无符号最大值 |
| ROL / ROR | 0110011 | 0110000 | 001 / 101 | | 循环左移 / 右移（移位量为 rs2 低位） |
| CLZ / CTZ / CPOP | 0010011 | 0110000 | 001 | rs2=00000/00001/00010 | 前导零 / 尾随零 / 置位数 |
| SEXT.B / SEXT.H | 0010011 | 0110000 | 001 | rs2=00100/00101 | 字节 / 半字符号扩展 |
| RORI | 0010011 | 0110000（RV64 6 位 shamt 时 +0x31） | 101 | | 立即数循环右移 |
| ORC.B | 0010011 | 0010100 | 101 | rs2=00111 | 每字节非零则置 0xFF |
| REV8 | 0010011 | 0110100 / 0110101（RV64） | 101 | rs2=11000 | 字节序反转 |
| ZEXT.H（RV32） | 0110011 | 0000100 | 100 | | 半字零扩展 |

> RV64 W 形式：`CLZW`/`CTZW`/`CPOPW`（OP-IMM-32 `0011011`，funct7=0110000，funct3=001，rs2=00000/00001/00010）、`RORIW`（OP-IMM-32，funct7=0110000，funct3=101）、`ROLW`/`RORW`（OP-32 `0111011`，funct7=0110000，funct3=001/101）、`ZEXT.H`（OP-32，funct7=0000100，funct3=100）；均只取低 32 位、结果符号扩展到 64 位。

**Zbs（单比特操作，位索引取 rs2 低位或立即数低 shamt 位；RV32 5 位、RV64 6 位）**

| 指令 | opcode | funct7 | funct3 | 语义 |
|------|--------|--------|--------|------|
| BSET / BCLR / BINV | 0110011 | 0010100 / 0100100 / 0110100 | 001 | 置位 / 清位 / 翻转位（索引来自 rs2） |
| BEXT | 0110011 | 0100100 | 101 | 取位（结果 0/1） |
| BSETI / BCLRI / BINVI | 0010011 | 0010100 / 0100100 / 0110100 | 001 | 立即数索引置位 / 清位 / 翻转位 |
| BEXTI | 0010011 | 0100100 | 101 | 立即数索引取位 |

> RV64 6 位位索引时 `shamt[5]` 由 funct7 最低位携带：BSETI=funct7 `0010101`、BCLRI/BEXTI=funct7 `0100101`、BINVI=funct7 `0110101`，其余同上。

**Zba（地址生成）**

| 指令 | opcode | funct7 | funct3 | 语义 |
|------|--------|--------|--------|------|
| SH1ADD / SH2ADD / SH3ADD | 0110011 | 0010000 | 010 / 100 / 110 | `(rs1 << 1/2/3) + rs2` |

> RV64 word 形式（`rs1` 低 32 位先零扩展）：`ADD.UW`（OP-32 `0111011`，funct7=0000100，funct3=000）、`SH1ADD.UW`/`SH2ADD.UW`/`SH3ADD.UW`（OP-32，funct7=0010000，funct3=010/100/110）、`SLLI.UW`（OP-IMM-32 `0011011`，funct6=000010，funct3=001，6 位 shamt）。

**Zbc（无进位乘法）**

| 指令 | opcode | funct7 | funct3 | 语义 |
|------|--------|--------|--------|------|
| CLMUL | 0110011 | 0000101 | 001 | 无进位乘积低 XLEN 位 |
| CLMULH | 0110011 | 0000101 | 011 | 无进位乘积高 XLEN 位 |
| CLMULR | 0110011 | 0000101 | 010 | 无进位乘积的 `[2*XLEN-2 : XLEN-1]` 位 |

> Zbc 与 Zbb 的 `MIN/MAX` 共享 funct7=0000101，靠 funct3 区分（Zbc 用 001/010/011，Zbb 用 100–111）。无进位乘法在 EX 段按位组合：对 `rs2` 每个置位 `i` 异或 `(rs1 << i)`，得到 2*XLEN 位积后按位段选择结果。

**Zbkb（密码学位操作）**

| 指令 | opcode | funct7 | funct3 | 其他 | 语义 |
|------|--------|--------|--------|------|------|
| PACK | 0110011 | 0000100 | 100 | | `{rs2[XLEN/2-1:0], rs1[XLEN/2-1:0]}` |
| PACKH | 0110011 | 0000100 | 111 | | `{rs2[7:0], rs1[7:0]}` |
| PACKW | 0111011（仅 RV64） | 0000100 | 100 | | 打包低 16 位后符号扩展 32→64 |
| BREV8 | 0010011 | 0110100 | 101 | rs2=00111 | 每字节内逐位反转 |
| ZIP | 0010011（仅 RV32） | 0000100 | 001 | rs2=01111 | 低半字 → 偶数位、高半字 → 奇数位 |
| UNZIP | 0010011（仅 RV32） | 0000100 | 101 | rs2=01111 | ZIP 的逆操作 |

> Zbkb 还包含 Zbb 表中的 `REV8`（字节序反转）。`PACK`（RV32）与 Zbb 的 `ZEXT.H` 共享 OP/funct7=0000100/funct3=100，`PACKW`（RV64）与 `ZEXT.H` 共享 OP-32 同编码，靠是否使能 Zbkb / rs2 语义区分。

**Zbkc（无进位乘法子集，无 `clmulr`）**

| 指令 | opcode | funct7 | funct3 | 语义 |
|------|--------|--------|--------|------|
| CLMUL | 0110011 | 0000101 | 001 | 无进位乘积低 XLEN 位 |
| CLMULH | 0110011 | 0000101 | 011 | 无进位乘积高 XLEN 位 |

> Zbkc 与 Zbc 共用 `clmul/clmulh` 编码（funct7=0000101，funct3=001/011），但 Zbkc 不提供 `clmulr`（funct3=010）。

**Zbkx（交叉位置换）**

| 指令 | opcode | funct7 | funct3 | 语义 |
|------|--------|--------|--------|------|
| XPERM4 | 0110011 | 0010100 | 010 | 按 4 位组索引在 `rs1` 内交叉取位 |
| XPERM8 | 0110011 | 0010100 | 100 | 按 8 位组索引在 `rs1` 内交叉取位 |

> XPERM4/XPERM8 以 `rs1` 为表、`rs2` 为索引：结果第 i 组取 `rs1` 中由 `rs2` 第 i 组索引选出的同宽组；索引指向越界组时该组输出 0。RV32 下 XPERM4 有 8 个 nibble 组、XPERM8 有 4 个字节组；RV64 下分别为 16 与 8 组。

**Zknh（SHA-2 哈希位操作，由 `RvExtension.Zknh` 使能）**

SHA-256/512 变换编码为 OP-IMM（`0010011`），`funct7=0001000`、`funct3=001`，`rs2` 位段 `[24:20]` 选择操作：

| 选择子 | 指令 | 语义 |
|--------|------|------|
| 00000 | SHA256SUM0 | `ROR32(a,2) ^ ROR32(a,13) ^ ROR32(a,22)` |
| 00001 | SHA256SUM1 | `ROR32(a,6) ^ ROR32(a,11) ^ ROR32(a,25)` |
| 00010 | SHA256SIG0 | `ROR32(a,7) ^ ROR32(a,18) ^ SHR32(a,3)` |
| 00011 | SHA256SIG1 | `ROR32(a,17) ^ ROR32(a,19) ^ SHR32(a,10)` |
| 00100 | SHA512SUM0（仅 RV64） | `ROR64(a,28) ^ ROR64(a,34) ^ ROR64(a,39)` |
| 00101 | SHA512SUM1（仅 RV64） | `ROR64(a,14) ^ ROR64(a,18) ^ ROR64(a,41)` |
| 00110 | SHA512SIG0（仅 RV64） | `ROR64(a,1) ^ ROR64(a,8) ^ SHR64(a,7)` |
| 00111 | SHA512SIG1（仅 RV64） | `ROR64(a,19) ^ ROR64(a,61) ^ SHR64(a,6)` |

SHA-512 拆分形式编码为 OP（`0110011`），`funct3=000`，仅 RV32 使能（RV64 上为非法指令）：

| 指令 | funct7 | 语义 |
|------|--------|------|
| SHA512SUM0R | 0101000 | `(a<<25) ^ (a<<30) ^ (a>>28) ^ (b>>7) ^ (b>>2) ^ (b<<4)`（低 32 位） |
| SHA512SUM1R | 0101001 | `(a<<23) ^ (a>>14) ^ (a>>18) ^ (b>>9) ^ (b<<18) ^ (b<<14)` |
| SHA512SIG0L | 0101010 | `(a>>1) ^ (a>>7) ^ (a>>8) ^ (b<<31) ^ (b<<25) ^ (b<<24)` |
| SHA512SIG0H | 0101110 | `(a>>1) ^ (a>>7) ^ (a>>8) ^ (b<<31) ^ (b<<24)` |
| SHA512SIG1L | 0101011 | `(a<<3) ^ (a>>6) ^ (a>>19) ^ (b>>29) ^ (b<<26) ^ (b<<13)` |
| SHA512SIG1H | 0101111 | `(a<<3) ^ (a>>6) ^ (a>>19) ^ (b>>29) ^ (b<<13)` |

> SHA-256 与 RV32 拆分形式在 32 位宽度上计算并符号扩展到 XLEN；RV64 的 `sha512*` 在全 64 位宽度上计算。所有项均为定宽 `ROR`/`SHR` 组合，在 EX 段组合完成，未使能时编码按非法指令（cause 2）处理。

**Zksh（SM3 哈希位操作，由 `RvExtension.Zksh` 使能）**

`sm3p0`/`sm3p1` 复用 `Zknh` 的 OP-IMM 编码（`0010011`），`funct7=0001000`、`funct3=001`，`rs2` 位段 `[24:20]` 选择操作：

| 选择子 | 指令 | 语义 |
|--------|------|------|
| 01000 | SM3P0 | `sext32(a ^ ROL32(a,9) ^ ROL32(a,17))` |
| 01001 | SM3P1 | `sext32(a ^ ROL32(a,15) ^ ROL32(a,23))` |

**Zksed（SM4 变换，由 `RvExtension.Zksed` 使能）**

`sm4ed`/`sm4ks` 编码为 OP（`0110011`），`funct3=000`，由 `instr[29:25]` 选择操作、`instr[31:30]` 给出字节选择 `bs`：

| instr[29:25] | 指令 | 语义 |
|--------------|------|------|
| 11000 | SM4ED | 取 `sb_in=(rs2>>(8*bs))&0xFF`，查 SM4 S-box，线性变换后左旋 `8*bs`，异或 `rs1` |
| 11010 | SM4KS | 取 `sb_in`，查 SM4 S-box，密钥变换后左旋 `8*bs`，异或 `rs1` |

> SM3/SM4 指令在 32 位宽度上计算并符号扩展到 XLEN；SM4 的 S-box 为 256 项组合查表。全部在 EX 段组合完成，对应 `RvExtension` 未使能时编码按非法指令（cause 2）处理。

**Zkne（AES 加密轮变换，由 `RvExtension.Zkne` 使能）**

RV32 使用 `aes32esi`/`aes32esmi`，编码为 OP（`0110011`），`funct3=000`，由 `instr[29:25]` 选择操作、`instr[31:30]` 给出字节选择 `bs`：

| instr[29:25] | 指令 | 语义 |
|--------------|------|------|
| 10001 | AES32ESI | `sb=SBOX_ENC[(rs2>>(8*bs))&0xFF]`，`sext32(ROL32(sb,8*bs) ^ rs1)` |
| 10011 | AES32ESMI | 对 `sb` 做 MixColumns 字节变换后左旋 `8*bs`，异或 `rs1` 并符号扩展 |

RV64 使用 `aes64es`/`aes64esm`，编码为 OP，`funct3=000`，`funct7` 选择操作：

| funct7 | 指令 | 语义 |
|--------|------|------|
| 0011001 | AES64ES | `SubBytes(ShiftRows(rs1,rs2))`（加密 S-box） |
| 0011011 | AES64ESM | `MixColumns(SubBytes(ShiftRows(rs1,rs2)))` |

**Zknd（AES 解密轮变换，由 `RvExtension.Zknd` 使能）**

RV32 使用 `aes32dsi`/`aes32dsmi`，编码与 Zkne 相同（`funct3=000`、`instr[29:25]` 选择、`instr[31:30]` 为 `bs`）：

| instr[29:25] | 指令 | 语义 |
|--------------|------|------|
| 10101 | AES32DSI | `sb=SBOX_DEC[(rs2>>(8*bs))&0xFF]`，`sext32(ROL32(sb,8*bs) ^ rs1)` |
| 10111 | AES32DSMI | 对 `sb` 做 InvMixColumns 字节变换后左旋 `8*bs`，异或 `rs1` 并符号扩展 |

RV64 使用 `aes64ds`/`aes64dsm`/`aes64im`，编码为 OP（`funct3=000`，`funct7` 选择）或 OP-IMM：

| 编码 | 指令 | 语义 |
|------|------|------|
| funct7=0011101 | AES64DS | `InvSubBytes(InvShiftRows(rs1,rs2))`（解密 S-box） |
| funct7=0011111 | AES64DSM | `InvMixColumns(InvSubBytes(InvShiftRows(rs1,rs2)))` |
| OP-IMM imm[11:0]=0x300 | AES64IM | 对 `rs1` 的两个 32 位列分别做 InvMixColumns |

**AES 密钥调度（RV64，Zknd/Zkne 共用）**

| 编码 | 指令 | 语义 |
|------|------|------|
| OP-IMM imm[11:4]=0x31，`rcon=imm[3:0]` | AES64KS1I | `rcon=0xA` 时不旋转且常数为 0；否则 `RotWord(rs1[63:32])`、加密 SubWord、异或轮常数 `RC[rcon]`，高/低 32 位相同 |
| funct7=0111111 | AES64KS2 | `lo=rs1[63:32]^rs2[31:0]`，`hi=lo^rs2[63:32]` |

> `aes64ks1i` 的 `rcon` 取值范围为 0..10，`rcon>10` 按非法指令处理。AES 指令的 ShiftRows/SubBytes/MixColumns 均为组合逻辑（加密与解密各一张 256 项 S-box），在 EX 段单周期完成；RV32 形式结果符号扩展，RV64 形式使用完整 64 位操作数。

**Zicond（条件运算，由 `RvExtension.Zicond` 使能）**

| 编码 | 指令 | 语义 |
|------|------|------|
| OP funct7=0000111, funct3=101 | CZERO.EQZ | `rd = (rs2 == 0) ? 0 : rs1` |
| OP funct7=0000111, funct3=111 | CZERO.NEZ | `rd = (rs2 != 0) ? 0 : rs1` |

> 两条指令在 EX 段组合完成，RV32 与 RV64 均按完整 `xlen` 比较 `rs2`，未使能时编码按非法指令处理。

**Zcb（附加压缩指令，由 `RvExtension.Zcb` 使能，需同时使能 C）**

| 编码 | 指令 | 语义 | 前置扩展 |
|------|------|------|----------|
| Q0 cfunct3=100, instr[12:10]=000 | C.LBU | `rd' = zext8(mem8[rs1'+uimm])` | 无 |
| Q0 cfunct3=100, instr[12:10]=001, instr[6]=0 | C.LHU | `rd' = zext16(mem16[rs1'+uimm])` | 无 |
| Q0 cfunct3=100, instr[12:10]=001, instr[6]=1 | C.LH | `rd' = sext16(mem16[rs1'+uimm])` | 无 |
| Q0 cfunct3=100, instr[12:10]=010 | C.SB | `mem8[rs1'+uimm] = rs2'[7:0]` | 无 |
| Q0 cfunct3=100, instr[12:10]=011 | C.SH | `mem16[rs1'+uimm] = rs2'[15:0]` | 无 |
| Q1 cfunct3=100, instr[12:10]=111, instr[6:5]=11, instr[4:2]=000 | C.ZEXT.B | `rsd' = zext8(rsd')` | 无 |
| Q1 …, instr[4:2]=001 | C.SEXT.B | `rsd' = sext8(rsd')` | Zbb |
| Q1 …, instr[4:2]=010 | C.ZEXT.H | `rsd' = zext16(rsd')` | Zbb |
| Q1 …, instr[4:2]=011 | C.SEXT.H | `rsd' = sext16(rsd')` | Zbb |
| Q1 …, instr[4:2]=100 | C.ZEXT.W | `rsd' = zext32(rsd')` | RV64 + Zba |
| Q1 …, instr[4:2]=101 | C.NOT | `rsd' = ~rsd'` | 无 |
| Q1 cfunct3=100, instr[12:10]=111, instr[6:5]=10 | C.MUL | `rd' = rs1' * rs2'`（低 `xlen` 位） | M 或 Zmmul |

> 压缩访存立即数只有 2 位（字节形式 `{instr[5],instr[6]}`，半字形式 `{instr[5],0}`），且 `rd'`/`rs1'`/`rs2'` 限定在 `x8`–`x15`。C.ZEXT.B/C.NOT 通过 ALU 的 `AND 0xFF` / `XOR -1` 实现；C.SEXT.B/C.ZEXT.H/C.SEXT.H/C.ZEXT.W 复用 Zbb/Zba 的 ALU 操作。当对应前置扩展未使能时，该编码按非法指令处理。

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
| FENCE.I | 0001111 | 使能 Zifencei 时作为合法提交点（无 I 缓存，无额外状态）；未使能时按非法指令处理 |
| ECALL / EBREAK | 1110011 | 已实现（M/S/U 模式 cause 11/9/8 与 3，见下文） |
| MRET | 1110011 | 已实现（M 模式恢复 mstatus/模式并跳转 mepc） |
| SRET | 1110011 | 已实现（S 模式恢复 sstatus/模式并跳转 sepc；非 S 模式为非法指令） |
| WFI | 1110011 | 当作 NOP 处理 |
| URET / 其他 SYSTEM funct12 | 1110011 | 译码为非法指令（cause 2） |

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

- 支持 **M/U**（`rv32im` 等）与 **M/S/U**（`rv32imsu`/`rv64imsu`）两种特权栈，复位进入 M；`mret` 按 MPP 进入 S 或 U，`sret` 按 SPP 在 S/U 间返回
- 内置 CSR（全部 32 位）：`mstatus/misa/mie/mtvec/mscratch/mepc/mcause/mtval/mip/mhartid`；S 栈额外实现 `medeleg/mideleg` 与 `sstatus/sie/stvec/sscratch/sepc/scause/stval/sip/satp`
  - 仅实现位可写，保留位读 0 写忽略；`misa/mip/mhartid/sip` 只读：CSRRW/I 写入触发 cause 2，CSRRS/CSRRC 命中只读位按读处理
  - S 级访问受 `minPriv` 约束：S 模式可读 S 级与非特权 CSR，访问 M 级 CSR 触发 cause 2；`mtvec/stvec` 仅接受 MODE=0，`satp` 的 MODE 强制 BARE
  - `mtvec` 的 MODE 域写入非 0 值触发 cause 2；trap 重定向恒按 direct 模式取 `{mtvec.BASE,2'b00}`
  - `mip.MTIP` 由顶层 `timerInterrupt` 输入电平直接反映
  - `mstatus` 可写域：`MIE/MPIE/MPP/SIE/SPIE/SPP/FS/SUM/MXR`；`mie` 可写 `MTIE/STIE/SSIE/SEIE`；`medeleg/mideleg` 按已实现异常/中断位掩码写入
- Zicntr 计数器（仅 `RvExtension.Zicntr` 使能时）：`mcycle(0xB00)`/`minstret(0xB02)` 与用户视图 `cycle(0xC00)`/`time(0xC01)`/`instret(0xC02)`；RV32 另实现高半字 `cycleh(0xC80)`/`timeh(0xC81)`/`instreth(0xC82)`；`mcycle/minstret` 的 RV32 高半字为 `mcycleh(0xB80)`/`minstreth(0xB82)`。`cycle` 每时钟自增，`instret` 按 WB 提交的指令数累加，`time` 复用 `cycle` 时基
  - `mcountinhibit(0x320)` 的 CY(0)/TM(1)/IR(2) 分别冻结 `cycle/time/instret`，清除后恢复累加
  - 使能门控：`mcounteren(0x306)` 控制 S/U 读取，M/S/U 栈的 `scounteren(0x106)` 进一步控制 U；低于 M 且对应位为 0 时触发 cause 2（`mtval`=CSR 地址）
- Sstc 监督者定时器比较（仅 `RvExtension.Sstc` 使能时，需 Zicntr 与 S 模式）：`stimecmp(0x14D)` 与 RV32 `stimecmph(0x15D)`、`menvcfg(0x30A)` 与 RV32 `menvcfgh(0x31A)`
  - `menvcfg` 为 WARL，本实现仅保留 `STCE`（bit 63），其余位读 0 写忽略
  - `STCE=1` 后硬件比较 Zicntr 的 `time` 与 `stimecmp`：`time >= stimecmp` 时内部拉高 STIP（`mip/sip` bit 5），清零 `stimecmp` 或在 `STCE=0` 时撤回
  - `STCE=0` 时 `stimecmp` 读 0 且写入被忽略；`mie.STIE` + `mideleg.STIP` 使能后按 cause 5 进入 S 模式
- 浮点 CSR（仅 `RvExtension.SingleFloat` 使能时）：`fflags(0x001)`、`frm(0x002)`、`fcsr(0x003)`；`frm` 为 WARL 仅接受 0–4，提交 FP 指令累积 `fflags` 并把 `mstatus.FS` 置 Dirty
- 同步异常 cause：ECALL(M)=11、ECALL(S)=9、ECALL(U)=8、EBREAK=3、非法指令/CSR 访问违例=2、`MPP`/`SPP` 不在配置特权栈的 MRET/SRET=2
- 异常委托：M 下 trap 始终进入 M；S/U 下 `medeleg[cause]=1` 时进入 S（`sepc/scause/stval` + `SPP/SPIE/SIE`）
- 定时器中断：M 级在 `MTIE && !mideleg[7] && (curMode≠M || MIE)` 时接受（cause=0x80000007）；S 级在 `(timerInterrupt || Sstc STIP) && STIE && mideleg[7] && (curMode==U || (curMode==S && SIE))` 时接受（cause=0x80000005），`mtval/stval=0`
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

- **SV39 MMU**：`satp` 地址翻译、TLB 与页错误异常（S 模式 CSR、异常委托与 `SRET` 已实现，`satp` 当前仅 BARE）
- **F/D**：RV32F / RV64F 单精度（FLEN=32）与 RV64D 双精度（FLEN=64，含 `FCVT.S.D`/`FCVT.D.S` 与 NaN-boxing）均已实现并有定向测试与 RTL 生成
- **Zba / Zbb / Zbs / Zbc / Zbkb / Zbkc / Zbkx / Zknh / Zksh / Zksed / Zknd / Zkne**：位操作扩展（RV32 与 RV64）已实现并有定向测试与 RTL 生成；`Zv*` 等未实现
- **Zicond**：`czero.eqz`/`czero.nez` 条件运算（RV32 与 RV64）已实现并有定向测试与 RTL 生成
- **Zcb**：附加压缩访存与寄存器运算（`c.lbu/c.lhu/c.lh/c.sb/c.sh/c.zext.b/c.sext.b/c.zext.h/c.sext.h/c.zext.w/c.not/c.mul`，RV32 与 RV64）已实现并有定向测试与 RTL 生成
- **Zifencei**：`fence.i` 指令流同步（RV32 与 RV64）已实现并有定向测试与 RTL 生成
- **Zicntr**：`cycle/time/instret`（RV32 含 `cycleh/timeh/instreth`）与 `mcycle/minstret`、`mcounteren/scounteren` 已实现；`time` 与 `cycle` 同源，未接入外部实时时钟
- **Zicntr 访问控制**：M 模式直接可读；S/U 模式需 `mcounteren` 对应位，M/S/U 栈的 U 模式还需 `scounteren` 对应位，违反时按非法指令（cause 2）处理
- **Sstc**：`stimecmp/menvcfg`（RV32 含高半字）与 `menvcfg.STCE` 驱动 STIP，实现无 SBI 的 S 模式定时器中断（RV32 与 RV64）已实现并有定向测试与 RTL 生成
