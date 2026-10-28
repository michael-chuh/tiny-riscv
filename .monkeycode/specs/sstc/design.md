# Sstc Design

## Configuration

- `RvExtension.Sstc` is a named extension without a MISA bit; it is listed in
  `RvExtension.implemented`.
- `IsaConfig` validates `Sstc => S privilege stack && Zicntr`.
- Presets `rv32imzicntrsu` / `rv64imzicntrsu` combine `{Zicsr, MulDiv,
  Zicntr, Sstc}` with `PrivConfig.MSU`; `CoreConfig` re-exports both.
- `CsrMap` tags the four Sstc CSRs with `requiresSstc` and marks
  `menvcfgh` / `stimecmph` as RV32-only.

## CSR file

`CsrFile` keeps two 64-bit registers when `isa.hasSstc`:

- `menvcfgReg`: WARL storage. Read returns the raw register (high half on
  RV32 via `menvcfgh`); write keeps only `opNew(63)` and zeroes the rest.
- `stimecmpReg`: written only while `menvcfgReg(63)` is set. RV32 writes the
  low half at `0x14D` and the high half at `0x15D`; RV64 writes the full
  64-bit value at `0x14D`. Reads return zero while `STCE = 0`.

The comparator is combinational and reuses the Zicntr `time` register:

```scala
val sTimerPending =
  menvcfgReg.get(63) && (timeCnt.get >= stimecmpReg.get)
```

`sTimerPending` is exported to `RiscvCore`, mirrored into `mipBits(5)` (so
`sip` shows it as well), and reset by clearing `STCE` or by programming a
larger `stimecmp`.

## Interrupt path

`RiscvCore` ORs the platform timer line with `sTimerPending` before the
existing supervisor-timer accept logic:

```scala
val intrS = (io.timerInterrupt || sTimerPending) && mieStie && delegTimer &&
  (curMode === MODE_U || (curMode === MODE_S && mstatusSie))
```

Delivery reuses the existing trap commit path: `trapToS` with cause
`0x80000005`, `sepc = pc`, `scause`, `sstatus.SPP/SPIE/SIE` updates, handler
entry at `stvec`. No new pipeline state or stall is introduced.

## RTL and tests

- `RiscvCoreGen` adds `RiscvCoreZICNTRSU` / `RiscvCore64ZICNTRSU`, bringing
  the generated configuration count to 50.
- `ZicsrTrapTest` gains two directed programs (RV64 and RV32) that set STCE,
  program `stimecmp = time + 64`, delegate the timer, drop to S with `MRET`,
  and assert the S handler ran with the right `scause`.
- `IsaConfigSpec` covers the preset contents and the structural `require`.
- `CsrMapSpec` checks address uniqueness and Sstc-only CSR visibility.
