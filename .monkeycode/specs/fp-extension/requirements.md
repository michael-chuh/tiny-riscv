# Requirements Document — 浮点扩展（F / D）

Feature Name: fp-extension
Updated: 2026-09-22

## Introduction

在既有 RV32I/RV64I、M、A、C 之上补齐 **F（单精度）与 D（双精度）浮点扩展**，使核在 `RvExtension.SingleFloat` / `DoubleFloat` 使能时能够执行浮点访存、计算、比较与转换指令，并维护 `fcsr`（`fflags`/`frm`）与 `mstatus.FS`。这是面向 MCU（RV32F）与高性能（RV64D）目标的关键能力。

本需求以 RISC-V 非特权规范（v2.1+）F/D 子集为参照。目标：新增独立浮点寄存器堆与一个多周期 IEEE-754 浮点单元（复用既有流水线冻结机制），在单发射按序五级流水线上实现全部 F/D 指令；F/D 关闭配置与既有 RV32/RV64/M/A/C 行为完全不变。

**落地顺序（已确认）**：先实现 F（含全部 F 指令与 FPU），回归通过后再将同一参数化 FPU 扩展为 D。D 仅在 RV64 上提供（RV32 数据总线为 32 位，`FLD/FSD` 需双周期访问；RV32 目标为 MCU，不实现 D）。

## Glossary

- **核（core）**：`RiscvCore` 及其五级流水线。
- **FLEN**：浮点寄存器位宽。仅 F 时 FLEN=32；含 D 时 FLEN=64；无 F/D 时浮点通路整体省略。
- **fmt**：精度格式，`00`=单精度（S）、`01`=双精度（D）。
- **FP 寄存器**：`f0`..`f31`，独立于整数寄存器 `x0`..`x31`。
- **rm**：舍入模式。指令 `funct3` 或动态用 `frm`。
- **F 关闭配置**：`IsaConfig.extensions` 不含 `SingleFloat`（D 蕴含 F）。

## Requirements

### R1 配置与使能

**User Story:** 作为 SoC 集成者，我希望 F/D 与其他扩展一样由配置开启。

**R1.1** WHEN `IsaConfig.extensions` 含 `SingleFloat`，核 SHALL 在 elaboration 期接受该配置并译码执行 F 指令。
**R1.2** WHEN `IsaConfig.extensions` 含 `DoubleFloat`，核 SHALL 同时使能 F 与 D；D 蕴含 F（配置模型 SHALL 强制）。
**R1.3** WHILE 处于 F/D 关闭配置，核 SHALL 保持既有取指、译码、流水线与访存行为逐拍不变。
**R1.4** WHEN F 使能，`misa` SHALL 置 `F` 位；WHEN D 使能，SHALL 同时置 `F` 与 `D` 位。
**R1.5** 系统 SHALL 提供 `IsaConfig.rv32f`/`rv64f`/`rv64d` 与对应 `CoreConfig` 预设，且既有预设内容 SHALL 保持不变。
**R1.6** 仅 RV64 配置 SHALL 接受 `DoubleFloat`；在 RV32 配置中声明 D SHALL 在 elaboration 期被拒绝。

### R2 浮点状态（`mstatus.FS` 与 `fcsr`）

**User Story:** 作为上下文切换软件，我需要浮点状态可被保存/恢复，并在未开启时触发异常。

**R2.1** 核 SHALL 实现 `mstatus.FS`（bit13:14，WARL）：值 `00`=Off、`01`=Initial、`10`=Clean、`11`=Dirty。
**R2.2** WHEN `mstatus.FS=Off` 且执行任意 F/D 指令或访问 `fcsr`/`frm`/`fflags`，核 SHALL 触发 illegal-instruction（cause 2）。
**R2.3** WHEN 执行写浮点寄存器或写浮点 CSR 的指令且 `FS≠Off`，核 SHALL 将 `FS` 置为 `Dirty(11)`。
**R2.4** 核 SHALL 实现 `fflags(0x001)`、`frm(0x002)`、`fcsr(0x003)`：`fcsr = frm(fcsr[7:5]) | fflags(fcsr[4:0])`；写 `fcsr` 同时更新两者；三者对 M/U 均可见（非特权）。
**R2.5** `fflags` SHALL 可读可写，位含义 NV=4、DZ=3、OF=2、UF=1、NX=0；写 `fcsr`/`fflags` 的位语义 SHALL 与读回一致。
**R2.6** `frm` SHALL 可读可写（3 位）；`frm` 取值 `101/110/111` 为保留，读取保留值 SHALL 原样返回。

### R3 浮点寄存器堆与访存

**User Story:** 作为编译器，我需要把浮点数据在寄存器堆与内存之间搬运。

**R3.1** 核 SHALL 提供 32×FLEN 的浮点寄存器堆，带 3 个读端口（`rs1/rs2/rs3`）与 1 个写端口，写端口为唯一写入口。
**R3.2** 核 SHALL 解码并执行 `FLW`（opcode 0000111, funct3=010）与 `FSW`（opcode 0100111, funct3=010）：以整数 `rs1` 为基址，单精度存取到 `f[rd]` / `f[rs2]`。
**R3.3** 核 SHALL 解码并执行 `FLD`（funct3=011）与 `FSD`（funct3=011）；`FLD`/`FSD` SHALL 仅在含 D 的 RV64 配置可用。
**R3.4** 当 FLEN=64 时，`FLW` SHALL 按 RISC-V NaN-boxing 规则把 32 位结果置入 `f[rd]` 低 32 位并将高 32 位置 1；`FSW` SHALL 只写 `f[rs2]` 低 32 位。
**R3.5** 浮点访存地址未按访问宽度自然对齐时 SHALL 触发地址非对齐异常（load→cause 4，store→cause 6），`mtval` 记录故障地址，且不产生访存副作用。
**R3.6** `FLW` 的写回目标为浮点寄存器堆，SHALL 不写整数寄存器堆。

### R4 浮点计算指令

**User Story:** 作为数值代码作者，我要用到符合 IEEE-754 的浮点算术。

**R4.1** 核 SHALL 实现 FADD/FSUB/FMUL/FDIV（opcode 1010011）与对应的 D 形式（fmt=01，仅 RV64）。
**R4.2** 核 SHALL 实现 FSQRT（S/D，`rs2=0`）。
**R4.3** 核 SHALL 实现融合乘加 FMADD/FMSUB/FNMSUB/FNMADD（opcode 1000011/1000111/1001011/1001111，fmt=`instr[26:25]`，乘数 `rs3=instr[31:27]`），中间乘积 SHALL 不舍入。
**R4.4** 核 SHALL 实现 FSGNJ/FSGNJN/FSGNJX（funct3=000/001/010），按位选择符号，不产生异常标志。
**R4.5** 核 SHALL 实现 FMIN/FMAX（funct3=000/001）：任一操作数为 NaN 时返回非 NaN 操作数（两者皆 NaN 返回规范 NaN）；`±0` 有确定顺序（min(-0,+0)=-0，max=-+0）；`fmin(x,x)` 对 NaN 返回 x 的规范 NaN 语义。
**R4.6** 所有计算指令 SHALL 按 `rm` 舍入，并 SHALL 正确处理 `±0`、`±∞`、NaN、次正规数与符号。
**R4.7** 浮点计算 SHALL 采用多周期单元实现，运算期间冻结流水线（复用 `freezeAll`），结果经既有旁路/回写通路送回浮点寄存器堆。

### R5 浮点比较与分类

**User Story:** 作为控制流作者，我需要比较浮点数并把结果读入整数寄存器。

**R5.1** 核 SHALL 实现 FLE/FLT/FEQ（opcode 1010011, funct7 101000x, funct3=000/001/010），结果写整数寄存器（0/1）；任何操作数为 NaN 时 FEQ 返回 0，FLE/FLT 返回 0 并置 NV。
**R5.2** 核 SHALL 实现 FCLASS（funct3=001, rs2=0），结果位定义按规范（bit0 -Inf … bit9 NaN）。
**R5.3** 核 SHALL 实现 FMV.X.W / FMV.W.X（funct3=000，S/D 形式）；`FMV.X.W` 对 FLEN=64 取低 32 位并符号扩展到 xlen，`FMV.W.X` 把整数低 32 位置入浮点寄存器低半，FLEN=64 时高半按 NaN-boxing 置 1。

### R6 浮点与整数转换

**User Story:** 作为混合代码作者，我需要在整数与浮点之间转换。

**R6.1** 核 SHALL 实现 FCVT.W.[S/D]、FCVT.WU.[S/D]、FCVT.L.[S/D]、FCVT.LU.[S/D]（opcode 1010011，funct7 110000x，rs2 选择目标整数宽度）与反向 FCVT.[S/D].W/WU/L/LU（funct7 110100x）。
**R6.2** 整数→浮点转换 SHALL 按 `rm` 舍入并正确置 NX（必要时）。
**R6.3** 浮点→整数转换 SHALL 在源超出目标整数可表示范围或源为 NaN/±∞ 时置 NV，并返回规范饱和值（NaN/±∞/超大→目标最大正值或最小负值，按规范）。
**R6.4** `FCVT.L`/`FCVT.LU` SHALL 仅在 xlen=64 时可用。
**R6.5** 核 SHALL 实现 FCVT.S.D / FCVT.D.S（fmt 间转换，funct7 0100000/0100001，仅含 D 配置）；S→D 精确，D→S 按 `rm` 舍入。

### R7 异常标志（`fflags`）

**User Story:** 作为数值健壮性代码作者，我需要读取浮点异常标志。

**R7.1** 核 SHALL 产生并累积 `NV(4)/DZ(3)/OF(2)/UF(1)/NX(0)` 标志：标志 SHALL 累积到 `fflags`（写 `fcsr`/`fflags` 为读改写）。
**R7.2** 比较/符号注入/分类/移动/mv 转换（FMV）SHALL 不产生浮点异常标志（比较例外见 R5.1）。
**R7.3** 无效运算（NaN 与非法格式操作、`0/0`、`∞/∞`、`sqrt(负数)`、溢出转换）SHALL 置 NV；`x/0`（x 有限非零）SHALL 置 DZ；上溢 SHALL 置 OF+NX；下溢（舍入后为次正规/零且不精确）SHALL 置 UF+NX；其余不精确结果 SHALL 置 NX。

### R8 冒险与流水线

**User Story:** 作为流水线设计者，我要保证浮点依赖被正确处理。

**R8.1** 核 SHALL 对浮点寄存器 RAW 依赖做旁路与停顿，语义与整数通路一致。
**R8.2** 浮点访存与浮点计算 SHALL 复用既有 load-use 停顿与 EX/MEM、MEM/WB 旁路；多周期 FPU 结果 SHALL 在完成后经既有旁路可见。
**R8.3** 核 SHALL 在 `mstatus.FS=Off` 时把所有 F/D 指令与 `fcsr` 访问当作 illegal-instruction，且不改变浮点状态。

### R9 验证与不变式

**R9.1** 既有 RV32I/RV64I/M/A/C 全部测试 SHALL 保持通过。
**R9.2** F/D 关闭时 RTL 中 SHALL 不含浮点寄存器堆、FPU 与 FP 译码分支（逐拍等价）。
**R9.3** 新增 F（及后续 D）定向测试，覆盖访存、算术、比较/分类、转换、舍入模式、异常标志与 NaN/∞/次正规/有符号零边界。
