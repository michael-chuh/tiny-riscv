# Supervisor Mode Design Specification

## Configuration

- `PrivConfig.MSU` already existed; `IsaConfig` no longer rejects S on RV32
  (only H stays RV64-only). `misaValue` sets the S bit whenever
  `priv.hasSupervisor`.
- Presets: `IsaConfig.rv32imsu` / `rv64imsu` = `{Zicsr, MulDiv}` + `MSU`,
  forwarded by `CoreConfig.rv32imsu` / `rv64imsu`.
- `CsrMap` gains a `requiresSupervisor` flag used by `medeleg`/`mideleg`; the
  S-level CSRs are filtered by their `minPriv = S`, so an M/U hart implements
  neither the delegation registers nor the S CSRs.
- `ExceptionCode.supervisorTimer = 5` is added for the delegated interrupt.

## CSR file

- New storage: `medeleg`, `mideleg`, and (guarded by `hasSupervisor`)
  `stvec/sscratch/sepc/scause/stval/satp`. `sstatus` is a field view over
  `mstatus` storage (SIE/SPIE/SPP/FS/SUM/MXR/UXL), `sie` is `mie & sieMask`,
  `sip` is `mip & sieMask` (read-only).
- `mstatus` mask extends to `SIE(1)/SPIE(5)/SPP(8)/SUM(18)/MXR(19)`; writes
  through `0x300` use the full mask, writes through `0x100` (sstatus) use the
  S-only mask. `mie` accepts `SSIE/STIE/SEIE` in addition to `MTIE`.
- `satp` is WARL: MODE bits are cleared (BARE), ASID/PPN are stored as written.
- Trap commit takes `trapToS`: to S it writes `sepc/scause/stval` and updates
  `SPP←curMode[0], SPIE←SIE, SIE←0` and `curMode←S`; to M it behaves as before.
  `sretEna` performs `SIE←SPIE, SPIE←1, SPP←U, curMode←old SPP`.
- Readouts `mstatusSpp/mstatusSie/mieStie/medeleg/mideleg/stvec/sepc` feed EX.

## Core

- `Decoder`: `SysOp.SRET` is decoded from `funct12=0x102`; remaining SYSTEM
  funct12 values stay illegal.
- CSR legality: `csrPrivIllegal` now tests the addressed CSR only (per-address
  `minPriv`), so S code can access S CSRs and M code still accesses everything.
  `stvecModeBad` mirrors the `mtvec` WARL check.
- `sretLegal` = S mode + `hasSupervisor` + `SPP` target implemented. Illegal
  `SRET` raises cause 2. `csrXretStall` extends the existing MRET hazard to
  `sstatus(0x100)` and `sepc(0x141)`.
- Trap target: `trapToS = (intrTake && intrS) || (exTrapEna && curMode≠M &&
  medeleg[cause])`; PC = `stvec.BASE` or `mtvec.BASE`, both masked to MODE=0.
- Interrupts: machine timer is taken when `MTIE && !mideleg[7] && (curMode≠M ||
  MIE)`; supervisor timer when `STIE && mideleg[7] && (curMode==U ||
  (curMode==S && SIE))`. Only one of the two can fire in a cycle.
- `SRET` redirects the PC to `sepc` and bubbles EX like `MRET`.

## RTL generation

`RiscvCoreGen` adds `RiscvCoreS` / `RiscvCore64S`, bringing the generated
config count to forty-six.

## Verification

- `ZicsrTrapTest`: delegated S ECALL (checks `scause`, `sepc`, `SPP`, `SRET`
  resume), undelegated S ECALL handled in M, and `SRET` illegal in M.
- `IsaConfigSpec`: S presets, misa S bit, S CSR visibility on MSU vs MU.
- `CsrMapSpec`: M/U hart excludes the S CSRs and delegation registers.
