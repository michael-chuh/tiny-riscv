# RV32B / RV64B Bit-Manipulation Extension (Zbc)

## Feature summary

Add the ratified `Zbc` (carry-less multiplication) sub-extension to `rv32c` on
both RV32 and RV64, continuing the staged bit-manipulation work (`Zbb`, then
`Zbs`, then `Zba`, now `Zbc`). Capability is declared in `isa.RvExtension.Zbc`,
derived by `IsaConfig`, and decoded by the `Decoder` / executed by the `Alu`,
following the same pattern as the other `Zb*` extensions.

## Scope

In scope:

- `Zbc`: `clmul`, `clmulh`, `clmulr` — carry-less (GF(2) polynomial) multiply
  producing the low XLEN bits, the high XLEN bits, and the
  `[2*XLEN-2 : XLEN-1]` bit window respectively.

Out of scope:

- `Zbkb/Zbkc/Zbkx/Zk*` (crypto) and other unratified B drafts.
- A single-letter `B` misa bit is not set: the `Zb*` capability is exposed
  through the named extensions and does not change `misaValue`.

## Requirements (EARS)

WHEN `RvExtension.Zbc` is present in `IsaConfig.extensions`,
THE `RiscvCore` SHALL decode and execute `clmul`, `clmulh` and `clmulr` on both
RV32 and RV64 harts.

WHEN `RvExtension.Zbc` is absent,
THE `RiscvCore` SHALL treat every `Zbc` encoding as an illegal instruction
(`cause 2`) and SHALL NOT include the carry-less multiply datapath in the
synthesized ALU result selection.

WHEN `clmul` executes,
THE `RiscvCore` SHALL write the low XLEN bits of the 2*XLEN-bit carry-less
product of `rs1` and `rs2`.

WHEN `clmulh` executes,
THE `RiscvCore` SHALL write bits `[2*XLEN-1 : XLEN]` of the carry-less product.

WHEN `clmulr` executes,
THE `RiscvCore` SHALL write bits `[2*XLEN-2 : XLEN-1]` of the carry-less
product.

THE `IsaConfig` SHALL expose `hasZbc` and SHALL derive the canonical name
`RV32IM_Zbc_Zicsr` / `RV64IM_Zbc_Zicsr` for the corresponding presets, with the
same `misaValue` as `rv32im` / `rv64im`.

## Acceptance criteria

- `rv32imzbc` / `rv64imzbc` presets exist and set `hasZbc` without affecting
  `RiscvCore` legality of other extensions.
- Directed RV32 and RV64 programs cover `clmul`, `clmulh` and `clmulr`,
  including products that cross the XLEN boundary and all-ones operands.
- `sbt test` passes and the RTL generator emits `RiscvCoreBC.v` and
  `RiscvCore64BC.v`.
