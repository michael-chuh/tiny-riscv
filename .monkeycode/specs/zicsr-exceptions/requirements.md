# Requirements Document — Zicsr 与异常/中断（zicsr-exceptions）

## Introduction

为 rv32c（SpinalHDL 五级流水线 RV32IM 核，见 `docs/architecture.md`）落地 **Zicsr**（CSR 指令）与 **Machine 模式异常/中断/返回** 基础能力，使软件能够：
- 通过 `CSRRW/CSRRS/CSRRC`（含立即数形式）访问机器级 CSR；
- 捕获 `ECALL`、`EBREAK`、非法指令三类同步异常，并跳转进入 `mtvec` 指向的处理入口；
- 响应至少一路定时器中断（可扩展外部/软件中断），实现中断使能、状态保存与 `MRET` 返回。

本需求以 RISC-V 特权架构规范（priv-isa v1.12）的 **Machine + 最小 User 模式子集** 为参照。目标基线：RV32IM、单 hart、无 MMU、无总线错误信号、无 Supervisor 模式；实现 **M 与 U 两个权限模式**（决策 D1）与 **仅定时器 MTIP 中断源**（决策 D2），未实现语义**按规范抛 ILLEGAL 或按允许的 NOP 完成**（决策 D3）。

## Glossary

- **系统**: rv32c 内核（`RiscvCore`），含取指到写回的完整流水线与全部 CSR 逻辑。
- **CSR**: 控制与状态寄存器，12 位地址，位于 CPU 特权域。
- **trap**: 同步异常（exception）或异步中断（interrupt）进入 Machine 模式的总称。
- **M/U 模式**: Machine（特权）与 User（非特权）两个权限模式；trap 总是进入 M，`MRET` 依据 `MPP` 回到来源模式。
- **当前模式**: 内核内部维护的执行权限（复位为 M；本阶段仅 M/U 两个合法值）。
- **Zicsr**: RISC-V "CSR 指令" 扩展，包含 6 条 CSR 访问指令。
- **直接向量**: `mtvec.BASE` 模式 0（Direct），所有 trap 跳转到固定入口。
- **处理入口（handler）**: 软件异常/中断服务例程。

## Requirements

### R1 CSR 指令集（Zicsr）

**User Story:** 作为软件开发者，我希望用标准 CSR 指令读写控制寄存器，以便配置中断与保存上下文。

**R1.1** WHEN 译码到 `CSRRW`（opcode=1110011, funct3=001），系统 SHALL 读取 `csr[addr]` 旧值写入 `rd`，并写入 `rs1` 值到 `csr[addr]`。
**R1.2** WHEN 译码到 `CSRRS`（funct3=010），系统 SHALL 读取旧值写入 `rd`，并将 `rs1` 对应置 1 位写入 CSR。
**R1.3** WHEN 译码到 `CSRRC`（funct3=011），系统 SHALL 读取旧值写入 `rd`，并将 `rs1` 对应清 0 位写入 CSR。
**R1.4** WHEN `rs1=x0` 且指令为 `CSRRW`，系统 SHALL 仅读取旧值写入 `rd`，SHALL 保持 CSR 内容不变。
**R1.5** WHEN `rs1=x0` 且指令为 `CSRRS/CSRRC`，系统 SHALL 仅读取并返回旧值，SHALL 不修改 CSR（zimm=0 语义）。
**R1.6** WHEN 译码到立即数形式 `CSRRWI/CSRRSI/CSRRCI`（funct3=101/110/111），系统 SHALL 以 `uimm[4:0]` 作为写掩码/写数据，其余行为与 R1.1–R1.3 相同。
**R1.7** WHEN CSR 目标为只读寄存器且指令以写意图访问，系统 SHALL 以 ILLEGAL 异常处理（细节见 R3，write-1 屏蔽规则见 R1.8）。
**R1.8** WHEN `CSRRS/CSRRC`（含立即数形式）的写位全部落在只读寄存器的只读位，系统 SHALL 正常返回旧值，SHALL 抛出不产生 ILLEGAL 异常。
**R1.9** WHEN CSR 地址未实现或非法，系统 SHALL 以 ILLEGAL 异常处理，SHALL 保证 CSR 与 `rd` 均不被修改。
**R1.10** WHEN 触发 ILLEGAL 异常，系统 SHALL 记录被取消指令的 CSR 写入，保证异常处理入口可见一致的寄存器状态。

### R2 CSR 寄存器组（最小 Machine 集）

**User Story:** 作为系统程序员，我希望标准 CSR 名称与位含义可预期，以便编写可移植的中断处理代码。

**R2.1** 系统 SHALL 实现以下 CSR 及其地址：`mstatus`(0x300)、`misa`(0x301，只读)、`mie`(0x304)、`mtvec`(0x305)、`mscratch`(0x340)、`mepc`(0x341)、`mcause`(0x342)、`mtval`(0x343)、`mip`(0x344，只读)、`mhartid`(0xF14，只读)。
**R2.2** `mstatus` 系统 SHALL 实现字段：`MIE`(bit3)、`MPIE`(bit7)、`MPP`(bits12:11)；trap 时按来源模式更新 `MPP`，`MRET` 时以 `MPP` 恢复模式（见 R6）。保留位 SHALL 读出为 0、写入忽略；`MPRV`/`SUM`/`MXR`/`TVM`/`TW`/`TSR` 等未实现位按保留位处理。
**R2.3** `misa` 系统 SHALL 报告 `MXL=1`（RV32）并置位扩展位 `I`、`M`、`U`，其余扩展位 SHALL 读出为 0；`misa` SHALL 忽略写入。
**R2.4** `mie`/`mip` 系统 SHALL 实现并接通 **`MTIE`/`MTIP`(bit7)** 一路；`MSIE`/`MSIP`(bit3) 与 `MEIE`/`MEIP`(bit11) 位 SHALL 读出为 0、写入忽略（未接入的中断源）。`mip` 的 pending 位由中断源硬件驱动，SHALL 忽略软件写入（R2.1 中 `mip` 只读）。
**R2.5** `mtvec` 系统 SHALL 仅接受 Direct 模式：WHEN 写入使 `MODE` 字段非零，系统 SHALL 以 illegal-instruction 异常处理（决策 D3）；跳转地址取 `BASE`（低位 2 位清零）。
**R2.6** `mscratch` 系统 SHALL 提供完整读写，供处理例程交换通用寄存器（实现 `csrrw mscratch, t0` 语义）。
**R2.7** `mhartid` 系统 SHALL 返回 `CoreConfig.hartId`，SHALL 忽略写入。
**R2.8** WHEN 复位，系统 SHALL 使 `mstatus`=0、`mtvec`=0、`mepc`/`mcause`/`mtval`=0、`mie`=0、`mscratch`=0，当前模式置 M，PC 回到 `CoreConfig.resetVector`。

### R3 同步异常（ECALL / EBREAK / ILLEGAL）

**User Story:** 作为软件，我希望非法操作与显式自陷进入受控的处理入口，以便报告错误或请求机器服务。

**R3.1** WHEN 译码到 `EBREAK`（0x00100073），系统 SHALL 触发 breakpoint 异常（`mcause.excode=3`，interrupt=0）。
**R3.2** WHEN 在 M 模式执行 `ECALL`，系统 SHALL 触发 environment-call-from-M-mode 异常（`mcause.excode=11`）。
**R3.3** WHEN 译码到无法识别的指令，或 CSR 访问违反 R1.7/R1.9，系统 SHALL 触发 illegal-instruction 异常（`mcause.excode=2`）。
**R3.4** WHEN 触发任一同步异常，系统 SHALL 将引发异常的指令地址写入 `mepc`，写入异常编码到 `mcause`，异常相关辅助值（如非法 CSR 地址）写入 `mtval`（无辅助值则写 0）。
**R3.5** WHEN trap 发生，系统 SHALL 将 `mstatus.MPIE` 置为原 `MIE` 值、`MIE` 清 0，并将 `MPP` 置为来源模式（M 模式来源为 3、U 模式来源为 0）。
**R3.6** WHEN 异常被接受，系统 SHALL 取消流水线中位于该指令之后的所有指令，SHALL 从 `mtvec` 基址继续取指。
**R3.7** IF 在 U 模式取指/译码到非法指令、`ECALL`（environment-call-from-U-mode）或访问无权限的 M 级 CSR，系统 SHALL 触发对应异常并将 `MPP` 记录为 0，使能软件经 `MRET` 回到 U。
**R3.8** 系统 SHALL 保证同步异常在同一指令的 CSR 写副作用之前提交 `mepc/mcause/mstatus` 更新，异常优先级高于普通写回。

### R4 中断（定时器优先，范围由 D2 决定）

**User Story:** 作为软件，我希望周期定时器能打断主流程并安全返回，以便实现调度与计步。

**R4.1** 系统 SHALL 暴露至少一路外部定时器中断请求输入（对应 `MTIP`），该输入在 core 外部由 `mtime` 比较器驱动（`mtime`/`mtimecmp` 属 SoC，不在本需求范围）。
**R4.2** WHEN `mie.MTIE=1` 且 `mstatus.MIE=1` 且 `mip.MTIP=1`，系统 SHALL 在取指边界接受机器定时器中断。
**R4.3** WHEN 接受定时器中断，系统 SHALL 以 `mcause.interrupt=1, excode=7` 记录，`mepc` 记录中断返回地址（被打断指令地址），其余动作与 R3.4–R3.6 一致。
**R4.4** 系统 SHALL 在已接入中断源（仅定时器）范围内仲裁：同步异常优先于定时器中断，单源无次级竞争。
**R4.5** WHEN 中断服务完成且软件执行 `MRET`，系统 SHALL 恢复 `MIE`（由 MPIE 还原）、按 `MPP` 恢复模式并跳转回 `mepc`（见 R5）。
**R4.6** 系统 SHALL 保证中断的接受延迟有上界：自 `MTIP` 拉高且使能成立起，至进入 `mtvec` 入口的时钟周期数 SHALL 至多为流水线排空深度加固定值（设计文档给出）。

### R5 MRET 返回

**User Story:** 作为软件，我希望 trap 处理结束后用单条指令返回被中断/异常的程序。

**R5.1** WHEN 译码到 `MRET`（0x30200073），系统 SHALL 将程序计数器置为 `mepc`，并停止执行 trap 入口后续的流水线指令。
**R5.2** WHEN 执行 `MRET`，系统 SHALL 将 `mstatus.MIE` 恢复为 `MPIE` 的值，并将 `MPIE` 置 1。
**R5.3** WHEN 执行 `MRET`，系统 SHALL 以 `mstatus.MPP` 恢复当前模式（3=M、0=U），并按 D1 规则把 `MPP` 置为 M（写入 3）。
**R5.4** WHEN 在 U 模式译码到 `MRET`，或 `mepc`/`mstatus.MPP` 处于不支持状态（`MPP` 为保留值），系统 SHALL 以 illegal-instruction 异常处理该指令，不产生控制流转移。
**R5.5** `MRET` SHALL 不写任何通用寄存器，仅产生一次控制流转移与 CSR 状态更新。

### R6 特权与模式（M + 最小 U）

**User Story:** 作为移植者，我希望特权模型与 RISC-V 规范兼容，允许软件经 M 模式配置后把普通任务运行在 U 模式。

**R6.1** 系统 SHALL 维护一个当前模式（内部寄存器），复位为 M；合法值为 M(3) 与 U(0)。
**R6.2** WHEN 执行 `MRET`，系统 SHALL 将当前模式切为 `mstatus.MPP` 指定的模式（U/M），并将 `MPP` 置回 M(3)。
**R6.3** WHEN 发生 trap（异常或中断），系统 SHALL 将当前模式置为 M，并按来源把 `MPP` 记录为 3（来自 M）或 0（来自 U）。
**R6.4** WHEN 在 U 模式访问特权位为 M（CSR 地址 bit[9:8]=11）的 CSR，系统 SHALL 以 illegal-instruction 异常处理（R6.2 例外：`mstatus` 的 U 可读位若实现则按只读暴露——本需求未实现，故 U 模式全部 CSR 访问 SHALL 视为无权限）。
**R6.5** WHEN 在 U 模式执行 `ECALL`，系统 SHALL 触发 environment-call-from-U-mode 异常（`mcause.excode=8`）；M 模式执行 `ECALL` 触发 excode=11。
**R6.6** WHEN 译码到 `WFI`（0x10500073），系统 SHALL 以 NOP 方式完成，SHALL 不抛异常（M/U 模式均可执行）。
**R6.7** 系统 SHALL 在指令级对以下情形以 illegal-instruction 处理：U 模式执行 `MRET`（R5.4）、`mret` 时 `MPP` 为保留值 1/2（R5.4）、写入未实现的 CSR 或非法的 CSR 地址（R1.9）、对只读 CSR 写入（R1.7）、`mtvec.MODE` 非零（R2.5）。

### R7 复位与调试

**User Story:** 作为验证工程师，我希望复位后状态确定且调试可见 trap 上下文。

**R7.1** WHEN 复位信号有效，系统 SHALL 按 R2.8 复位全部 CSR，PC 回到 `CoreConfig.resetVector`。
**R7.2** WHEN `CoreConfig.withDebug=true`，系统 SHALL 导出用于测试观察的 trap 状态（至少 `pc`、`mepc`、`mcause`、trap 有效标志）到顶层端口。
**R7.3** 系统 SHALL 在现有仿真 harness（`CpuTb`，见 `src/test/scala/rv32c/sim/CpuTb.scala`）上可注入定时器中断并观测 handler 执行。

## 未包含（Out of Scope，本阶段不做）

- U/S 模式、页表/MMU、`SAT*` CSR
- `WFI` 真实语义（可保留为 NOP，见 D3）
- 计时 CSR（`cycle/time/instret`）或 `mcycle` 计数器（列后续需求）
- 访存/取指总线错误异常（当前 I/D 总线无错误信号，见 `src/main/scala/rv32c/bus/BusInterfaces.scala`）
- 非对齐访问异常、物理内存保护（PMP）
- `mtime`/`mtimecmp` 比较器（SoC 外设，仅提供中断线输入）

## 决策记录（已确认）

- **D1** 特权模式范围：**实现最小 U 模式**——维护 M/U 当前模式，trap 记录 `MPP`、`MRET` 恢复模式，U 模式 CSR/`MRET` 无权限访问按 ILLEGAL 处理。
- **D2** 中断源接入：**仅定时器 `MTIP`**；`MSIE/MEIP` 位保留为读出 0。
- **D3** 未实现语义：**按规范处理**——访问未实现 CSR、只读 CSR 写入、`mtvec.MODE≠0`、U 模式 `MRET` 等抛 illegal-instruction；`WFI` 按允许语义 NOP 完成。
- **D4** 定时器中断输入为**电平且接受后不复位**：`mip.MTIP` 直接反映输入，防重入由软件关闭 `MTIE` 或外部 `mtimecmp` 清除负责。
- **D5** `mtvec` 直接模式下写入非 4 字节对齐的 `BASE` 被容忍，trap 跳转入口取 `BASE` 低 2 位清零后的地址。
- **D6** 本阶段**不实现**计时 CSR（`mcycle`/`minstret`/`cycle`/`time`），列入后续需求。

## 验收准则汇总（供测试参考）

1. 6 条 CSR 指令对每个实现的 CSR 完成读回写往返，`rs1=x0` 只读语义正确。
2. 只读 CSR 写（CSRRW/CSRRWI）触发 ILLEGAL，`mepc` 指向该指令、`mcause=2`。
3. `ECALL`（M 模式）→ `mcause=11`；`ECALL`（U 模式）→ `mcause=8`；`EBREAK` → `mcause=3`；`mepc` 正确，入口跳至 `mtvec`。
4. 定时器中断在 `MTIE=1` 且 `MIE=1` 时进入 handler，`mcause=0x80000007`，`MRET` 后回到 `mepc` 且 `MIE`/模式恢复。
5. M 模式经 `MRET`（`MPP=0`）进入 U；U 模式执行 `MRET` 或访问 M 级 CSR 触发 ILLEGAL。
6. 复位后 CSR 清零、当前模式为 M、`debugPc` 回到 resetVector。
