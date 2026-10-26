# User Counters (Zicntr)

## Feature summary

Add the `Zicntr` user-level counter extension to `rv32c` on both RV32 and RV64.
A hart configured with `RvExtension.Zicntr` exposes `cycle`, `time` and
`instret` (plus the RV32 high halves) together with the `mcounteren` and
`scounteren` access-control registers. Harts without Zicntr keep their current
CSR set and behaviour.

## Scope

In scope:

- Machine counters: `mcycle(0xB00)`, `minstret(0xB02)` as read/write aliases.
- User counters: `cycle(0xC00)`, `time(0xC01)`, `instret(0xC02)` read-only.
- RV32-only high halves: `cycleh(0xC80)`, `timeh(0xC81)`, `instreth(0xC82)`.
- Access control: `mcounteren(0x306)` and, on M/S/U harts, `scounteren(0x106)`.
- Counter freeze: `mcountinhibit(0x320)` with CY(0)/TM(1)/IR(2).
- Presets `rv32imzicntr` / `rv64imzicntr` and RTL
  `RiscvCoreZICNTR` / `RiscvCore64ZICNTR`.

Out of scope:

- External real-time clock input; `time` shares the `cycle` time base.
- Interrupt-on-overflow (`mip` counter bits) and `mcyclecfg/minstretcfg`
  event configuration.
- Performance-monitoring counters (`mhpmcounter*`, `mhpmevent*`).

## Requirements (EARS)

WHEN `IsaConfig.hasZicntr` is set,
THE `CsrFile` SHALL maintain a 64-bit cycle counter that increments every
clock edge and a 64-bit retired-instruction counter that increments once per
committed instruction.

WHEN the hart is configured for RV32,
THE `CsrFile` SHALL expose the upper 32 bits through `cycleh/timeh/instreth`
and return them as zero on RV64, which implements no high halves.

WHEN a counter CSR at `0xC00/0xC01/0xC02` (or the RV32 high halves) is read
in M mode,
THE `RiscvCore` SHALL return the counter value without further gating.

WHEN such a read executes below M mode,
THE `RiscvCore` SHALL require the matching `mcounteren` bit, and in a M/S/U
hart executing in U mode SHALL additionally require the matching `scounteren`
bit, raising an illegal-instruction exception (cause 2, `mtval` = CSR address)
otherwise.

WHEN `mcountinhibit` has CY/TM/IR set,
THE `CsrFile` SHALL stop incrementing `cycle`/`time`/`instret` respectively,
leaving the other counters running.

WHEN `mcycle/minstret` are written,
THE `CsrFile` SHALL replace the corresponding 64-bit counter value.

IF the hart lacks Zicntr,
THEN the counter and counter-enable CSR addresses SHALL remain unimplemented
(cause 2) and no counter registers SHALL be inferred.
