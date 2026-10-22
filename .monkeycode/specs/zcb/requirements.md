# Zcb Additional Compressed Instructions Extension

## Feature summary

Add the ratified `Zcb` extension (additional compressed instructions) to
`rv32c` on both RV32 and RV64. Capability is declared in
`isa.RvExtension.Zcb`, derived by `IsaConfig`, and decoded by the `Decoder`,
following the same pattern as the other `Z*` extensions.

## Scope

In scope:

- Compressed byte/halfword memory accesses: `c.lbu`, `c.lhu`, `c.lh`, `c.sb`,
  `c.sh` on RV32 and RV64.
- Compressed register operations: `c.zext.b`, `c.not`, `c.mul` (always), plus
  `c.sext.b`, `c.zext.h`, `c.sext.h` (requires Zbb) and `c.zext.w`
  (requires RV64 and Zba).

Out of scope:

- `Zcmp` push/pop/move instructions.
- Byte/halfword compressed accesses wider than the 2-bit compressed immediate
  allows (offset 0..3 for bytes, 0/2 for halfwords).
- A single-letter misa bit: `Zcb` is exposed through the named extension and
  does not change `misaValue`.

## Requirements (EARS)

WHEN `RvExtension.Zcb` is present in `IsaConfig.extensions`,
THE `RiscvCore` SHALL decode and execute the Zcb compressed instructions on both
RV32 and RV64.

WHEN `c.lbu`, `c.lhu` or `c.lh` executes,
THE `RiscvCore` SHALL load from `rs1' + uimm` using the address in `x8`-`x15`,
zero-extending byte/halfword values and sign-extending `c.lh`.

WHEN `c.sb` or `c.sh` executes,
THE `RiscvCore` SHALL store the low 8 or 16 bits of `rs2'` to `rs1' + uimm`.

WHILE Zbb is not enabled,
THE `RiscvCore` SHALL treat `c.sext.b`, `c.zext.h` and `c.sext.h` as illegal
instructions (cause 2).

WHILE Zba is not enabled or the hart is RV32,
THE `RiscvCore` SHALL treat `c.zext.w` as an illegal instruction (cause 2).

WHILE M/Zmmul is not enabled,
THE `RiscvCore` SHALL treat `c.mul` as an illegal instruction (cause 2).

WHEN `RvExtension.Zcb` is absent,
THE `RiscvCore` SHALL keep the reserved compressed encodings illegal and SHALL
NOT include any Zcb datapath in the synthesized core.

## Acceptance criteria

- `rv32imzcb` / `rv64imzcb` presets exist and set the flag without affecting
  `misaValue`.
- Directed RV32 and RV64 programs cover every Zcb instruction with observable
  memory round-trips and 32/64-bit value checks.
- `sbt test` passes and the RTL generator emits `RiscvCoreZCB.v` and
  `RiscvCore64ZCB.v`.
