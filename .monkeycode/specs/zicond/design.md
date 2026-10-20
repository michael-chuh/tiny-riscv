# Zicond Design Specification

## Configuration

- `isa.RvExtension.Zicond` is a named extension that is part of the
  `implemented` set (no misa bit).
- `IsaConfig.hasZicond` mirrors `extensions.contains(RvExtension.Zicond)`.
- Presets `rv32imzicond` / `rv64imzicond` reuse `rv32im.misaValue` /
  `rv64im.misaValue` and add only `Zicsr`, `MulDiv` and `Zicond`. Canonical
  names sort the extension list, so they read `RV32IM_Zicond_Zicsr` and
  `RV64IM_Zicond_Zicsr`.
- `CoreConfig` forwards the preset and the `hasZicond` flag.

## Decode

`Decoder` applies the `withZicond` overlay (last-connect-wins) at the end of the
OP branch:

- `czero.eqz` is OP (`0110011`), `funct3=101`, `funct7=0000111`.
- `czero.nez` is OP, `funct3=111`, `funct7=0000111`.

The overlay sets `regWrite := True` and clears `illegal`, because the base OP
decode otherwise maps `funct3=101` to `srl/sra` and `111` to `and`. Other
`funct3` values under `funct7=0000111` stay illegal.

## ALU datapath

- New ops `CZEROEQZ` and `CZERONEZ` compare the full-width operand `b` against
  zero and select either zero or operand `a`, all combinationally in the EX
  stage. No new pipeline state, field or stall is introduced.

## RTL generation

`RiscvCoreGen` adds `RiscvCoreZICOND` / `RiscvCore64ZICOND`, bringing the
generated config count to forty-two.

## Verification

- `RiscvCoreTest`: RV32 program exercising both instructions with `rs2` zero and
  non-zero plus a negative `rs1`; RV64 program exercising both instructions
  with a full-width 64-bit `rs1`.
- `IsaConfigSpec`: the presets expose the flag without a reserved misa bit, and
  `CoreConfig` forwards it.
