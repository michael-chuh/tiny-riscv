# Requirements Document — RV32C 压缩指令扩展（rv32c-compressed）

## Introduction

为 rv32c 增加 **C（Compressed）** 扩展，使 RV32 核能够取指并执行 16 位压缩指令，降低代码体积，补齐 rv32 MCU 目标的最后一块指令集能力。C 扩展通过 `IsaConfig.extensions` 中的 `RvExtension.Compressed` 使能，默认关闭；RV64 的 C 支持保持预留（`rv64 预留规划`），本需求仅覆盖 RV32。

C 扩展以 RISC-V 非特权规范（v2.1+）的 RV32C 子集为参照。目标是：压缩指令与既有 32 位指令在同一流水线中混合执行，PC 支持 2 字节粒度推进，非法/保留编码按 ILLEGAL 异常处理，且默认（C 关闭）配置的既有行为完全不变。

## Glossary

- **核（core）**：`RiscvCore` 及其五级流水线。
- **压缩指令**：16 位编码、低 2 位（`instr[1:0]`）非 `11` 的指令。
- **32 位指令**：低 2 位为 `11` 的指令，包含 RV32I/M 与 SYSTEM 指令。
- **半字（halfword）**：16 位对齐单元，即 2 字节。
- **quadrant**：压缩指令按 `instr[1:0]` 划分的三类编码空间（Q0=`00`，Q1=`01`，Q2=`10`）。
- **取指字（fetch word）**：指令总线一次返回的 32 位对齐数据。
- **C 关闭配置**：`IsaConfig.extensions` 不含 `Compressed` 的配置（默认与既有全部配置）。

## Requirements

### R1 配置与使能

**User Story:** 作为 SoC 集成者，我希望 C 扩展是一个可配置开关，以便按面积/代码体积需求取舍。

**R1.1** WHEN `IsaConfig.extensions` 含 `Compressed` 且 `xlen=32`，核 SHALL 译码并执行 RV32C 指令。
**R1.2** WHEN `IsaConfig.extensions` 含 `Compressed` 且 `xlen=64`，核 SHALL 在 elaboration 期拒绝该配置，并以消息指出 RV64C 为预留能力。
**R1.3** WHILE 处于 C 关闭配置，核 SHALL 将 `instr[1:0]!=11` 的指令按 illegal-instruction 处理，且 SHALL 保持与当前实现完全一致的取指、PC 推进与流水线时序。
**R1.4** WHEN C 使能，`misa` SHALL 置位 `C` 位；WHILE C 关闭，`misa` SHALL 清零 `C` 位。
**R1.5** 系统 SHALL 提供 `IsaConfig.rv32imc` 预设（RV32IMC_Zicsr，M/U），且既有预设（`rv32`、`rv32im`、`rv64`）的配置内容 SHALL 保持不变。

### R2 取指与 PC 推进

**User Story:** 作为处理器，我需要正确地在 16 位与 32 位指令之间推进 PC，以便混合执行压缩与标准指令。

**R2.1** WHEN 当前指令为压缩指令，核 SHALL 将 PC 推进 2 字节。
**R2.2** WHEN 当前指令为 32 位指令，核 SHALL 将 PC 推进 4 字节。
**R2.3** WHEN 分支或跳转命中，核 SHALL 将 PC 置为按 2 字节对齐计算的目标地址。
**R2.4** WHEN 目标地址使 `pc[1]=1` 且该处为 32 位指令，核 SHALL 通过取指字高位半字与下一取指字低位半字拼接得到该 32 位指令。
**R2.5** WHEN `pc[1]=1` 且该处为压缩指令，核 SHALL 仅使用取指字的高位半字，且 SHALL 在一次取指内完成。
**R2.6** IF 访存总线未 ready，核 SHALL 按既有握手规则停顿取指，并 SHALL 保持已锁存半字不丢失。

### R3 RV32C 指令覆盖

**User Story:** 作为编译器后端，我希望 RV32C 常用指令齐备，以便生成紧凑代码。

**R3.1** 核 SHALL 实现 quadrant 0：`C.ADDI4SPN`、`C.LW`、`C.SW`（RV32）。
**R3.2** 核 SHALL 实现 quadrant 1：`C.ADDI`、`C.JAL`、`C.LI`、`C.ADDI16SP`、`C.LUI`、`C.SRLI`、`C.SRAI`、`C.ANDI`、`C.SUB`、`C.XOR`、`C.OR`、`C.AND`、`C.J`、`C.BEQZ`、`C.BNEZ`。
**R3.3** 核 SHALL 实现 quadrant 2：`C.SLLI`、`C.LWSP`、`C.JR`、`C.MV`、`C.EBREAK`、`C.JALR`、`C.ADD`、`C.SWSP`。
**R3.4** WHEN 译码到 RV64C 专属编码（`C.LD/C.SD/C.ADDIW/C.LDSP/C.SDSP` 等）或保留编码，核 SHALL 触发 illegal-instruction 异常。
**R3.5** WHEN 压缩指令的源/目标寄存器为 `x0`，核 SHALL 按规范对该编码的约束处理（如 `C.MV`/`C.ADD` 允许 `rd=x0` 时忽略写回，保留编码按 R3.4 处理）。
**R3.6** `C.LWSP`/`C.LW` SHALL 按 32 位加载符号扩展语义回写；`C.SWSP`/`C.SW` SHALL 按字存储语义写掩码。
**R3.7** `C.JAL`/`C.J`/`C.BEQZ`/`C.BNEZ` SHALL 复用既有分支/跳转执行路径，且 `C.JAL` SHALL 将 `pc+2` 写入 `rd`。

### R4 异常与语义一致性

**User Story:** 作为固件开发者，我希望压缩指令的异常行为与标准指令一致。

**R4.1** WHEN 压缩指令触发同步异常，核 SHALL 将 `mepc` 记录为该压缩指令的地址，并 SHALL 保持既有 `mcause/mtval/mstatus` 语义。
**R4.2** WHEN 非法压缩指令被译码，核 SHALL 触发 illegal-instruction（cause 2），且 SHALL 取消该指令及其后续指令的流水线副作用。
**R4.3** `C.EBREAK` SHALL 产生与 `EBREAK` 相同的 breakpoint（cause 3）语义。

### R5 验证与回归

**User Story:** 作为维护者，我希望压缩指令有仿真覆盖，且既有功能不回归。

**R5.1** 新增 RV32C 仿真程序 SHALL 覆盖 Q0/Q1/Q2 代表指令、`pc[1]=1` 起始的 32 位指令、压缩与标准指令混合、以及至少一条非法压缩编码。
**R5.2** 既有 27 项测试（含 RV32I/RV32M/RV64I/RV64M/Zicsr/trap）SHALL 保持通过。
**R5.3** C 关闭配置生成的 RTL SHALL 与当前 `rtl/RiscvCore.v` 语义一致；C 使能配置 SHALL 可成功生成 RTL。
