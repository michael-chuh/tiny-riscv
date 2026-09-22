# Requirements Document — A 原子扩展（rv32a-atomics）

## Introduction

在既有 RV32I/RV64I、M、C 之上补齐 **A 原子扩展**（RV32A / RV64A），使核在 `RvExtension.Atomic` 使能时能够执行 LR/SC 与 AMO 类的原子内存操作。这是 S 模式、多核与 Linux 目标的前置能力。

本需求以 RISC-V 非特权规范（v2.1+）的 A 子集为参照。目标：在单发射、按序五级流水线中以 MEM 级多周期读-改-写实现 AMO，以保留集（reservation set）实现 LR/SC，并保证 A 关闭配置与既有 RV32/RV64/M/C 行为完全不变。

## Glossary

- **核（core）**：`RiscvCore` 及其五级流水线。
- **A 指令**：`LR.W/LR.D`、`SC.W/SC.D`、`AMO*.W/AMO*.D`。
- **AMO**：读-改-写类原子操作（AMOSWAP/AMOADD/AMOXOR/AMOAND/AMOOR/AMOMIN/AMOMAX/AMOMINU/AMOMAXU）。
- **保留集**：LR 建立的地址预约；SC 仅当预约仍有效且地址匹配时成功。
- **A 关闭配置**：`IsaConfig.extensions` 不含 `Atomic`。

## Requirements

### R1 配置与使能

**User Story:** 作为 SoC 集成者，我希望 A 扩展与其他扩展一样由配置开启。

**R1.1** WHEN `IsaConfig.extensions` 含 `Atomic`，核 SHALL 在 elaboration 期接受该配置并译码执行 A 指令。
**R1.2** WHILE 处于 A 关闭配置，核 SHALL 保持既有取指、译码与流水线行为逐拍不变。
**R1.3** WHEN A 使能，`misa` SHALL 置位 `A` 位。
**R1.4** 系统 SHALL 提供 `IsaConfig.rv32ima` / `IsaConfig.rv64ima` 与对应 `CoreConfig` 预设，且既有预设内容 SHALL 保持不变。

### R2 译码与编码合法性

**User Story:** 作为编译器后端，我希望 A 扩展的编码被正确识别，非法编码触发异常。

**R2.1** 核 SHALL 译码 opcode `0101111`、`funct3=010` 的 W 形式与 `funct3=011`（仅 RV64）的 D 形式。
**R2.2** `funct5` SHALL 映射：`00000` AMOADD、`00001` AMOSWAP、`00100` AMOXOR、`01000` AMOOR、`01100` AMOAND、`10000` AMOMIN、`10100` AMOMAX、`11000` AMOMINU、`11100` AMOMAXU、`00010` LR、`00011` SC。
**R2.3** WHEN A 关闭，opcode `0101111` SHALL 触发 illegal-instruction（cause 2）。
**R2.4** WHEN 在 RV32 上译码 D 形式，或 `funct5` 为保留值，核 SHALL 触发 illegal-instruction。
**R2.5** `aq`/`rl` 位（`instr[26:25]`）SHALL 被接受但不改变单核顺序语义（文档化）。

### R3 LR / SC 语义

**User Story:** 作为并发代码作者，我需要 LR/SC 提供可判定的原子序列。

**R3.1** `LR.W/LR.D` SHALL 从内存读取自然对齐的值写入 `rd`，并建立覆盖该地址的保留集。
**R3.2** `SC.W/SC.D` SHALL 仅当保留集仍有效且地址匹配时执行存储，并向 `rd` 写 0；否则 SHALL 不写内存并向 `rd` 写 1（失败）。
**R3.3** SC 执行后（无论成败）保留集 SHALL 被清除；任一存储或 AMO 提交 SHALL 清除保留集。
**R3.4** LW 形式的 `rd` SHALL 按 W 语义符号扩展至 xlen；D 形式为 xlen 宽度。

### R4 AMO 语义

**User Story:** 作为原子算法作者，我需要 AMO 在一个不可分割的操作中读-改-写内存。

**R4.1** AMO SHALL 在 MEM 级以「读取 → 计算 → 写回」的多周期原子序列完成，期间核 SHALL 冻结流水线以保证不可分割。
**R4.2** AMO SHALL 将内存原值写入 `rd`（W 形式符号扩展至 xlen）。
**R4.3** AMO 运算 SHALL 覆盖 ADD/SWAP/XOR/OR/AND/MIN/MAX/MINU/MAXU，其中 MIN/MAX 为有符号比较，MINU/MAXU 为无符号比较。
**R4.4** W 形式的运算与比较 SHALL 在 32 位宽度上进行，并将 32 位结果符号扩展回 xlen。

### R5 异常与对齐

**User Story:** 作为固件开发者，我希望对齐错误按规范触发异常。

**R5.1** WHEN A 指令的有效地址未自然对齐（W 需 4 字节，D 需 8 字节），核 SHALL 触发地址非对齐异常：LR 用 cause 4，SC/AMO 用 cause 6，且 SHALL 不产生访存副作用。
**R5.2** WHEN A 指令触发同步异常，核 SHALL 将 `mepc` 记录为该指令地址并保持既有 `mcause/mtval/mstatus` 语义。
**R5.3** AMO/LR/SC 结果 SHALL 经 WB 级统一写回，消费者 SHALL 以既有 load-use 停顿方式等待。

### R6 验证与回归

**User Story:** 作为维护者，我希望 A 扩展有仿真覆盖且既有能力不回归。

**R6.1** 新增 RV32A 仿真程序 SHALL 覆盖 LR/SC 成功、SC 失败（地址不匹配）、AMOADD/AMOSWAP/AMOXOR/AMOAND/AMOOR/AMOMIN/AMOMAX/AMOMINU/AMOMAXU 的结果与原值写回、以及结果旁路。
**R6.2** 新增 RV64A 仿真程序 SHALL 覆盖 LR.D/SC.D、AMO*.W 的 32 位运算与符号扩展、AMO*.D 的 64 位运算与比较。
**R6.3** 新增对齐异常用例 SHALL 验证 cause 4/6 与 `mepc`。
**R6.4** 既有测试（RV32I/M、RV64I/M、RV32C/RV64C、Zicsr/trap、配置单测）SHALL 保持通过。
**R6.5** A 使能配置 SHALL 可成功生成 RTL；既有 RV32/RV64 RTL SHALL 语义不变。
