# Zbc Design Specification

## Configuration

- `isa.RvExtension.Zbc` is a `reserved`-style named extension that is part of
  the `implemented` set (no misa bit).
- `IsaConfig.hasZbc` mirrors `extensions.contains(RvExtension.Zbc)`.
- Presets `IsaConfig.rv32imzbc` / `IsaConfig.rv64imzbc` reuse the
  `rv32im.misaValue` / `rv64im.misaValue` (no `B` bit) and add only
  `RvExtension.Zbc` to the extension set.
- `CoreConfig.rv32imzbc` / `CoreConfig.rv64imzbc` forward the presets.

## Decode

`Decoder` applies a `withZbc` overlay on opcode `OP` (0x33), sharing `funct7 =
0000101` with the `Zbb` `min/max` group (which uses `funct3 = 100..111`):

| funct3 | operation |
|--------|-----------|
| 001 | `clmul` |
| 010 | `clmulr` |
| 011 | `clmulh` |

The overlay is only applied when `isa.hasZbc`; otherwise the encodings stay
illegal (cause 2). The overlay sets the corresponding `AluOp` and the ALU
result mux selects the carry-less product.

## ALU datapath

- A helper `clmulFull(a, b)` produces the 2*XLEN-bit carry-less product by
  XOR-ing `a << i` for each set bit `i` of `b`. All shifting is static-width
  (`Cat`/`resize`), so the logic is purely combinational and pruning-friendly.
- Result selection:
  - `clmul`  = `clmulFull[xlen-1 : 0]`
  - `clmulh` = `clmulFull[2*xlen-1 : xlen]`
  - `clmulr` = `clmulFull[2*xlen-2 : xlen-1]`
- No new pipeline state or stall is introduced; the operation reuses the
  existing EX result path.

## RTL generation

`RiscvCoreGen` adds `RiscvCoreBC` (`CoreConfig.rv32imzbc`) and `RiscvCore64BC`
(`CoreConfig.rv64imzbc`), bringing the generated-config count to sixteen. The
emitted files are `rtl/RiscvCoreBC.v` and `rtl/RiscvCore64BC.v`.

## Verification

- `RiscvCoreTest`: RV32 program exercising `clmul` (0b1011 × 0b1101), `clmulh`/
  `clmulr` on a product crossing bit 31, and all-ones operands; RV64 program
  exercising the same across the bit-63 boundary.
- `IsaConfigSpec`: `rv32imzbc` / `rv64imzbc` expose `hasZbc` without a reserved
  misa `B` bit, and a plain core does not.
