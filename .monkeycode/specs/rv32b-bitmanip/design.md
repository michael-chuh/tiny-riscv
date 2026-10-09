# RV32B / RV64B Bit-Manipulation Extension — Technical Design

## Overview

Bit manipulation is confined to the ALU and the instruction decoder. No new
pipeline stages, stall states, or register files are introduced. The extension
adds `AluOp` elements, combinational helpers in `Alu`, decode overlays in
`Decoder`, and configuration plumbing in the `isa` package.

## Configuration model

`isa/RvExtension.scala` gains:

- `Zbb` (`"Zbb"`), `Zbs` (`"Zbs"`), `Zba` (`"Zba"`) — all without a misa letter
  (Z-prefixed extensions do not own a MISA bit). Only `Zbb` is added in this
  change.

`isa/IsaConfig.scala` gains:

- `hasZbb` (and later `hasZbs`/`hasZba`).
- Presets `rv32imzbb`, `rv64imzbb`.
- Canonical-name letter ordering is fixed to the standard `IMAFDQLCB...`
  sequence; Z-extensions keep alphabetical order after the underscore.

`CoreConfig` forwards `hasZbb` and adds `rv32imzbb` / `rv64imzbb` presets.

## ALU design (`core/Alu.scala`)

New `AluOp` members:

```
ANDN ORN XNOR CLZ CTZ CPOP SEXTB SEXTH ZEXTH ORCB REV8 ROL ROR MIN MINU MAX MAXU
CLZW CTZW CPOPW ROLW RORW
```

Combinational helpers (Scala `var` + `Mux` to stay loop-free):

- `clzN(x, w)` / `ctzN(x, w)`: scan for the first 1, returning `w` when none.
- `cpopN(x, w)`: sum of `x.asBools` (resized to `log2Up(w+1)`).
- `rotlN` / `rotrN`: `(x << s)|(x >> (w-s))` with an `s == 0` bypass so the
  variable shift never exceeds the representable range.
- `sext.b/h` use `asSInt.resize(xlen)`; `zext.h` uses `asUInt.resize(xlen)`.
- `orc.b` / `rev8` build the result from per-byte `Cat` slices.
- `min/max` use signed compares, `minu/maxu` unsigned.
- W-forms operate on `io.a(31 downto 0)` and sign-extend the result.

## Decoder design (`core/Decoder.scala`)

`withZbb = isa.hasZbb` gates all overlays. Overlays are placed after the base
decode inside each opcode case; SpinalHDL last-connect semantics let them
override the RV32I interpretation without duplicating the base decode.

Encodings (opcode / funct7 / funct3 / rs2):

| instruction | opcode | funct7 | funct3 | other |
|-------------|--------|--------|--------|-------|
| andn / orn / xnor | OP 0110011 | 0100000 | 7 / 6 / 4 | |
| min / minu / max / maxu | OP | 0000101 | 4 / 5 / 6 / 7 | |
| rol / ror | OP | 0110000 | 1 / 5 | rs2 = shift |
| clz / ctz / cpop | OP-IMM 0010011 | 0110000 | 1 | rs2 = 0 / 1 / 2 |
| sext.b / sext.h | OP-IMM | 0110000 | 1 | rs2 = 4 / 5 |
| rori | OP-IMM | 0110000 (RV64 +0x31) | 5 | shamt |
| orc.b | OP-IMM | 0010100 | 5 | rs2 = 00111 |
| zext.h (RV32) | OP | 0000100 | 4 | rs2 = 0 |
| rev8.rv32 / rev8 | OP-IMM | 0110100 / 0110101 | 5 | rs2 = 11000 |
| clzw / ctzw / cpopw | OP-IMM-32 0011011 | 0110000 | 1 | rs2 = 0 / 1 / 2 |
| roriw | OP-IMM-32 | 0110000 | 5 | shamt |
| rolw / rorw | OP-32 0111011 | 0110000 | 1 / 5 | |
| zext.h (RV64) | OP-32 | 0000100 | 4 | rs2 = 0 |

`clz/ctz/cpop/sext` are register-only and ignore operand b; the immediate
forms (`rori`, and later `*i` of Zbs) reuse the existing `aluSrc` path so the
ALU reads the shift/index from the sign-extended immediate's low bits. RV32
uses a 5-bit shift, RV64 a 6-bit shift; the immediate's `bit 31` is always 0
for these funct7 values, so sign extension does not corrupt the index.

## Verification

- `RiscvCoreTest` gains a `RV32B (Zbb)` program and an `RV64B (Zbb)` program
  using the existing `runUntil` harness. Programs are built from the shared
  `encR` / `encI` helpers.
- Existing 55 tests must stay green; the `IsaConfigSpec` gains Zbb cases.

## RTL

`RiscvCoreGen` gains `RiscvCoreB.v` (`CoreConfig.rv32imzbb`) and
`RiscvCore64B.v` (`CoreConfig.rv64imzbb`). Non-Zbb configurations keep their
existing ALU result selection (the new switch arms are pruned when unused).

## Risks

- Combinational width errors in the rotate helpers: mitigated by explicit
  `resize` and the `s == 0` bypass; covered by directed tests.
- ILLEGAL decode for unassigned funct3 within a Zbb funct7: the
  `clz/ctz/cpop/sext` selector switch has a `default illegal`.
