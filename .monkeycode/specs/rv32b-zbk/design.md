# Zbkb / Zbkc / Zbkx Design Specification

## Configuration

- `isa.RvExtension.Zbkb`, `Zbkc`, `Zbkx` are named extensions that are part of
  the `implemented` set (no misa bit).
- `IsaConfig.hasZbkb/hasZbkc/hasZbkx` mirror the corresponding
  `extensions.contains(...)`.
- Presets `IsaConfig.rv32imzbkb`/`rv64imzbkb`, `rv32imzbkc`/`rv64imzbkc`,
  `rv32imzbkx`/`rv64imzbkx` and the combined `rv32imzbk`/`rv64imzbk` reuse
  `rv32im.misaValue` / `rv64im.misaValue` (no `B` bit) and add only the
  respective `RvExtension` values.
- `CoreConfig` forwards both the presets and the `has*` flags.

## Decode

`Decoder` applies three overlays (last-connect-wins) after the base
OP / OP-IMM / OP-32 / OP-IMM-32 decode:

`withZbkb`:

| form | opcode | funct7 | funct3 | other | operation |
|------|--------|--------|--------|-------|-----------|
| OP | 0110011 | 0000100 | 100 | | `pack` |
| OP | 0110011 | 0000100 | 111 | | `packh` |
| OP-32 | 0111011 | 0000100 | 100 | RV64 | `packw` |
| OP-IMM | 0010011 | 0110100 | 101 | rs2=00111 | `brev8` |
| OP-IMM | 0010011 | 0000100 | 001 | rs2=01111, RV32 | `zip` |
| OP-IMM | 0010011 | 0000100 | 101 | rs2=01111, RV32 | `unzip` |

`pack`/`packh` share the `funct7=0000100` encoding with the `Zbb` `zext.h`
group; `packw` shares the OP-32 `zext.h` encoding.

`withZbc || withZbkc` on OP, `funct7=0000101` (shared with `Zbb` min/max):

| funct3 | operation |
|--------|-----------|
| 001 | `clmul` |
| 011 | `clmulh` |
| 010 | `clmulr` (only when `withZbc`) |

`withZbkx` on OP, `funct7=0010100`:

| funct3 | operation |
|--------|-----------|
| 010 | `xperm4` |
| 100 | `xperm8` |

Each overlay is applied only when the corresponding flag is set; otherwise the
encodings stay illegal (cause 2). Overlays set the `AluOp`, and the ALU result
mux selects the datapath.

## ALU datapath

- `pack` / `packh`: concatenate the low half/byte of `rs2` above that of `rs1`,
  each operand resized to XLEN so the bitwise OR is width-matched.
- `packw`: pack the low 16 bits into 32 bits, then sign-extend to XLEN.
- `brev8`: bit-reverse every byte of `rs1`.
- `zip` / `unzip` (RV32): interleave / de-interleave the two 16-bit halves into
  even/odd bit positions.
- `xpermN(table, idxs, groupLog2)`: group width is `1 << groupLog2` (nibble or
  byte); each index occupies a full group field and selects the matching group
  of `table`, with out-of-range indices yielding zero. This matches the Spike
  `xperm` reference (`xperm(rs1, rs2, sz_log2, xlen)`).
- `clmul`/`clmulh` reuse the `Zbc` `clmulFull` product with bit-window
  selection; no new pipeline state or stall is introduced.

## RTL generation

`RiscvCoreGen` adds `RiscvCoreBKB`/`RiscvCore64BKB`, `RiscvCoreBKC`/
`RiscvCore64BKC`, `RiscvCoreBKX`/`RiscvCore64BKX` and `RiscvCoreBK`/
`RiscvCore64BK`, bringing the generated-config count to twenty-six.

## Verification

- `RiscvCoreTest`: RV32/RV64 programs exercising `pack`/`packh`/`packw`,
  `brev8`, `zip`/`unzip`, `clmul`/`clmulh` (Zbkc) and `xperm4`/`xperm8`
  (including 64-bit eight/nibble-group behaviour), with reference vectors
  matching the Spike integer model.
- `IsaConfigSpec`: the new presets expose the expected `has*` flags without a
  reserved misa `B` bit, and a plain core exposes none of them.
