# Supervisor Timer Compare (Sstc)

## Feature summary

Add the `Sstc` extension to `rv32c` on both RV32 and RV64. A hart configured
with `RvExtension.Sstc` gains `stimecmp` (plus `stimecmph` on RV32) and
`menvcfg` (plus `menvcfgh` on RV32). With `menvcfg.STCE` set, the hardware
compares its Zicntr `time` against `stimecmp` and raises STIP directly, so a
supervisor timer interrupt no longer needs an SBI/M-mode round trip.

## Scope

In scope:

- `menvcfg(0x30A)` and RV32 `menvcfgh(0x31A)`; WARL, only `STCE` (bit 63) kept.
- `stimecmp(0x14D)` and RV32 `stimecmph(0x15D)`.
- STIP generation: `mip/sip` bit 5 while `time >= stimecmp` and `STCE=1`.
- Delegated delivery: `mie.STIE` + `mideleg[7]` raises cause 5 in S mode.
- Presets `rv32imzicntrsu` / `rv64imzicntrsu` and RTL
  `RiscvCoreZICNTRSU` / `RiscvCore64ZICNTRSU`.

Out of scope:

- `menvcfg` fields other than `STCE` (PBMTE/ADUE/CBIE/FIOM etc.).
- `menvcfg.FIOM` handling for `fence.i` and other cache-control behaviour.
- `mstateen`-style gating of `menvcfg` access from lower privilege.
- `stimecmp` being written through `mtimecmp` aliasing; the Zicntr `time`
  counter remains the only time source.

## Requirements (EARS)

WHEN `IsaConfig.hasSstc` is set,
THE `CsrFile` SHALL implement `stimecmp` as a 64-bit read/write register and
`menvcfg` as a 64-bit WARL register in which only bit 63 (`STCE`) is writable
and all other bits read as zero.

WHEN the hart is configured for RV32,
THE `CsrFile` SHALL expose the upper halves through `menvcfgh(0x31A)` and
`stimecmph(0x15D)`; on RV64 these addresses SHALL decode as illegal.

WHEN `menvcfg.STCE = 0`,
THE `CsrFile` SHALL read `stimecmp` as zero and IGNORE writes to it.

WHILE `menvcfg.STCE = 1`,
THE `CsrFile` SHALL drive STIP (`mip`/`sip` bit 5) whenever the 64-bit Zicntr
`time` value is greater than or equal to `stimecmp`.

WHEN STIP is pending, `mie.STIE = 1` and `mideleg[7] = 1`,
THE `RiscvCore` SHALL take a supervisor timer interrupt (cause 5) while
running in U, or in S with `sstatus.SIE = 1`, entering the handler through
`stvec`.

IF the hart is configured with `Sstc` but without `Zicntr` or without the S
privilege stack,
THEN `IsaConfig` SHALL reject the configuration at construction time.

## Acceptance criteria

- `sbt test` passes with `Sstc` tests on both RV32 and RV64.
- RV64 test: `menvcfg` write of bit 63 reads back, `stimecmp = time + 64`
  fires cause `0x8000000000000005` in S mode.
- RV32 test: the same scenario via `menvcfgh`/`stimecmph` fires
  `0x80000005` in S mode.
- `CsrMapSpec` hides the Sstc CSRs on harts without the extension and keeps
  every address unique.
- RTL generation adds `RiscvCoreZICNTRSU.v` / `RiscvCore64ZICNTRSU.v`
  (50 configurations in total).
