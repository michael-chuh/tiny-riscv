# Supervisor Mode (M/S/U)

## Feature summary

Add Supervisor mode to `rv32c` on both RV32 and RV64. A hart configured with
`PrivConfig.MSU` implements the S-level CSRs, delegates selected exceptions and
interrupts to S via `medeleg`/`mideleg`, and executes `SRET` in S mode. The
existing M/U configurations and their behaviour stay unchanged.

## Scope

In scope:

- S-level CSRs: `sstatus(0x100)`, `sie(0x104)`, `stvec(0x105)`,
  `sscratch(0x140)`, `sepc(0x141)`, `scause(0x142)`, `stval(0x143)`,
  `sip(0x144, RO)`, `satp(0x180)`.
- Machine delegation CSRs: `medeleg(0x302)`, `mideleg(0x303)`.
- `SRET` (SYSTEM, `funct12=0x102`) with SPP-based return.
- Trap entry to S when delegated, with `SPP/SPIE/SIE` updates.
- Supervisor timer interrupt (`cause 5`) delivered through `mideleg[7]`.
- S-mode presets `rv32imsu` / `rv64imsu` and RTL `RiscvCoreS` / `RiscvCore64S`.

Out of scope:

- Address translation: `satp` is WARL with MODE forced to BARE; no SV39, TLB
  or page-fault exceptions.
- Vectored trap modes: `mtvec`/`stvec` accept MODE=0 only.
- Hypervisor mode.

## Requirements (EARS)

WHEN `IsaConfig.priv` contains S mode,
THE `RiscvCore` SHALL implement the S-level CSRs and the `medeleg`/`mideleg`
delegation registers.

WHEN an exception is taken in S or U mode and `medeleg[cause]` is set,
THE `RiscvCore` SHALL enter S mode with `sepc/scause/stval` written,
`SPP` recording the source mode, `SPIE←SIE` and `SIE←0`, and the PC set to
`stvec.BASE`.

WHEN a synchronous exception is taken in M mode, or its cause is not delegated,
THE `RiscvCore` SHALL enter M mode exactly as before, regardless of `medeleg`.

WHEN `mideleg[7]` is set and the timer interrupt is pending,
THE `RiscvCore` SHALL deliver it to S (cause `0x80000005`) in S/U whenever
`sstatus.SIE` (in S) or the hart runs below S, using `stvec`.

WHEN `SRET` executes in S mode with an implemented SPP target,
THE `RiscvCore` SHALL set `pc←sepc`, restore `SIE←SPIE, SPIE←1, SPP←U` and set
`curMode` from the old SPP; `SRET` outside S mode SHALL raise illegal
instruction (cause 2).

THE `RiscvCore` SHALL reject a CSR access from a mode below the addressed CSR's
minimum privilege (S code cannot touch M CSRs; U code cannot touch S/M CSRs).

THE `IsaConfig` SHALL set the `misa` S bit for M/S/U stacks while Z-extensions
remain misa-neutral.

## Acceptance criteria

- `rv32imsu` / `rv64imsu` presets exist; `misa` includes the S bit.
- On an M/U hart, `medeleg`/`mideleg` and all S CSRs are absent (illegal).
- Directed tests cover: delegated S ECALL entering `stvec` with `SRET` return,
  undelegated S ECALL staying in M, and `SRET` illegal in M.
- Full `sbt test` passes; `RiscvCoreGen` emits 46 configs including
  `RiscvCoreS.v` / `RiscvCore64S.v`.
