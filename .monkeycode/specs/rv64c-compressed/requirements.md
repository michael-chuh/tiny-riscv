# Requirements Document — RV64C 压缩指令扩展（rv64c-compressed）

## Introduction

在既有 RV32C 实现之上补齐 **RV64C**，使 RV64 核在 `Compressed` 使能时能够取指并执行 RV64 专属的 16 位压缩编码，形成与 RV32C 对称的能力。RV64C 通过 `IsaConfig.extensions` 中的 `RvExtension.Compressed` 使能，默认关闭；本需求把当前"配置可表达但 RTL 拒绝"的 RV64C 提升为可实例化能力。

本需求以 RISC-V 非特权规范（v2.1+）的 RV64C 子集为参照。目标：复用既有压缩取指通路（2 字节 PC 粒度、`pc[1]=1` 拼接），仅在译码层增加 RV64 专属编码，并保证 RV32C、RV64I/M、C 关闭配置的既有行为完全不变。

## Glossary

- **核（core）**：`RiscvCore` 及其五级流水线。
- **压缩指令**：16 位编码、低 2 位（`instr[1:0]`）非 `11` 的指令。
- **RV64C 专属编码**：仅 xlen=64 合法的压缩编码（`C.LD/C.SD/C.LDSP/C.SDSP/C.ADDIW/C.SUBW/C.ADDW` 与 6 位 shamt 形式）。
- **quadrant**：压缩指令按 `instr[1:0]` 划分的三类编码空间（Q0=`00`，Q1=`01`，Q2=`10`）。
- **C 关闭配置**：`IsaConfig.extensions` 不含 `Compressed` 的配置。

## Requirements

### R1 配置与使能

**User Story:** 作为 SoC 集成者，我希望 RV64C 与 RV32C 使用同一开关，以便统一按代码体积取舍。

**R1.1** WHEN `IsaConfig.extensions` 含 `Compressed` 且 `xlen=64`，核 SHALL 在 elaboration 期接受该配置并译码执行 RV64C 指令。
**R1.2** WHEN `IsaConfig.extensions` 含 `Compressed` 且 `xlen=32`，核 SHALL 保持既有 RV32C 行为不变。
**R1.3** WHILE 处于 C 关闭配置，核 SHALL 保持与当前实现完全一致的取指、PC 推进与流水线时序。
**R1.4** WHEN C 使能，`misa` SHALL 置位 `C` 位，与 xlen 无关。
**R1.5** 系统 SHALL 提供 `IsaConfig.rv64imc` / `CoreConfig.rv64imc` 预设（RV64IMC_Zicsr，M/U），且既有预设内容 SHALL 保持不变。

### R2 取指与 PC 推进

**User Story:** 作为处理器，我需要在 RV64 下同样正确混合执行 16/32 位指令。

**R2.1** 核 SHALL 沿用既有压缩取指通路：PC 2 字节粒度、取指地址按字对齐、`pc[1]=1` 且高半字为 32 位指令时锁存拼接。
**R2.2** WHEN 目标地址落在 `pc[1]=1`，核 SHALL 计算并记录压缩/32 位指令的精确地址。
**R2.3** `C.JAL`/`C.JALR` 的链接值 SHALL 为 `pc+2`；其余链接语义 SHALL 与 32 位指令一致。

### R3 RV64C 指令覆盖

**User Story:** 作为 RV64 编译器后端，我希望 RV64 专属压缩指令齐备。

**R3.1** 核 SHALL 实现 Q0 的 `C.LD`、`C.SD`（在 RV32 上这两个编码 SHALL 触发 illegal-instruction）。
**R3.2** 核 SHALL 实现 Q2 的 `C.LDSP`、`C.SDSP`（在 RV32 上这两个编码 SHALL 触发 illegal-instruction）。
**R3.3** 核 SHALL 在 Q1 `funct3=001` 上按 xlen 区分：RV32 为 `C.JAL`，RV64 为 `C.ADDIW`（`rd=x0` 为保留编码）。
**R3.4** 核 SHALL 实现 Q1 `funct3=100`、`instr[12]=1`、`instr[11:10]=11` 的 RV64 形式：`C.SUBW`（`instr[6:5]=00`）、`C.ADDW`（`instr[6:5]=01`），其余为保留。
**R3.5** WHEN xlen=64，核 SHALL 接受 `C.SLLI/C.SRLI/C.SRAI` 的 `instr[12]=1`（6 位 shamt）；WHEN xlen=32，这些编码 SHALL 保持 illegal-instruction。
**R3.6** `C.LD`/`C.SD`/`C.LDSP`/`C.SDSP` SHALL 使用双字（8 字节）访存语义与按 8 缩放的立即数编码。
**R3.7** `C.ADDIW` SHALL 复用 `ADDW` 语义（32 位结果符号扩展至 64 位）。
**R3.8** WHEN 译码到当前 xlen 非法的 RV64C/RV32C 专属编码或保留编码，核 SHALL 触发 illegal-instruction 异常。

### R4 异常与语义一致性

**User Story:** 作为固件开发者，我希望 RV64C 的异常行为与既有压缩指令一致。

**R4.1** WHEN RV64C 指令触发同步异常，核 SHALL 将 `mepc` 记录为该压缩指令的地址，并 SHALL 保持既有 `mcause/mtval/mstatus` 语义。
**R4.2** WHEN 非法/保留压缩编码被译码，核 SHALL 触发 illegal-instruction（cause 2），且 SHALL 取消该指令及其后续指令的流水线副作用。

### R5 验证与回归

**User Story:** 作为维护者，我希望 RV64C 有仿真覆盖且既有能力不回归。

**R5.1** 新增 RV64C 仿真程序 SHALL 覆盖 `C.LD/C.SD`、`C.LDSP/C.SDSP`、`C.ADDIW`、`C.SUBW/C.ADDW`、6 位 shamt 移位、以及 `pc[1]=1` 起始的压缩/32 位混合。
**R5.2** 既有 31 项测试（RV32I/M、RV64I/M、RV32C 全指令、Zicsr/trap、配置单测）SHALL 保持通过。
**R5.3** RV64C 配置 SHALL 可成功生成 RTL；RV32（C 开/关）RTL 语义 SHALL 保持不变。
