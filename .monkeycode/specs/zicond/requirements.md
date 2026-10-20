# Zicond Conditional Operations Extension

## Feature summary

Add the ratified `Zicond` integer conditional-operations extension to `rv32c`
on both RV32 and RV64. Capability is declared in
`isa.RvExtension.Zicond`, derived by `IsaConfig`, and decoded by the `Decoder` /
executed by the `Alu`, following the same pattern as the other `Z*` extensions.

## Scope

In scope:

- `czero.eqz`, `czero.nez` on RV32 and RV64.

Out of scope:

- Branch-free select sequences built on top of these primitives.
- A single-letter misa bit: `Zicond` is exposed through the named extension and
  does not change `misaValue`.

## Requirements (EARS)

WHEN `RvExtension.Zicond` is present in `IsaConfig.extensions`,
THE `RiscvCore` SHALL decode and execute `czero.eqz` and `czero.nez` on both
RV32 and RV64.

WHEN `czero.eqz` executes,
THE `RiscvCore` SHALL write zero to `rd` when `rs2` is zero and `rs1`
otherwise.

WHEN `czero.nez` executes,
THE `RiscvCore` SHALL write zero to `rd` when `rs2` is non-zero and `rs1`
otherwise.

WHEN `RvExtension.Zicond` is absent,
THE `RiscvCore` SHALL treat the corresponding encodings as illegal instructions
(cause 2) and SHALL NOT include the conditional datapath in the synthesized ALU
result selection.

THE `IsaConfig` SHALL expose `hasZicond` and derive the canonical names
`<base>IM_Zicond_Zicsr` for the corresponding presets, with the same
`misaValue` as `rv32im` / `rv64im`.

## Acceptance criteria

- `rv32imzicond` / `rv64imzicond` presets exist and set the flag without
  affecting `misaValue`.
- Directed RV32 and RV64 programs cover both instructions with zero, non-zero
  and negative (RV32) operands.
- `sbt test` passes and the RTL generator emits `RiscvCoreZICOND.v` and
  `RiscvCore64ZICOND.v`.
