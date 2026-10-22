# Zcb Design Specification

## Configuration

- `isa.RvExtension.Zcb` is a named extension that is part of the
  `implemented` set (no misa bit).
- `IsaConfig.hasZcb` mirrors `extensions.contains(RvExtension.Zcb)`.
- Presets `rv32imzcb` (`RV32IMC_Zbb_Zcb_Zicsr`) and `rv64imzcb`
  (`RV64IMC_Zba_Zbb_Zcb_Zicsr`) reuse `rv32imc.misaValue` / `rv64imc.misaValue`;
  Zcb itself never changes the misa value.
- `CoreConfig` forwards the presets and the `hasZcb` flag.

## Decode

`Decoder` adds a `withZcb` flag and extends two compressed quadrants:

- Quadrant 0, `cfunct3=100`, with `instr[12:10]` selecting C.LBU (000),
  C.LHU/C.LH (001, `instr[6]` selects sign extension), C.SB (010) and C.SH
  (011). Immediates are zero-extended 2-bit values (`{instr[5],instr[6]}` for
  bytes, `{instr[5],0}` for halfwords); `rd'`/`rs1'`/`rs2'` decode to
  `x8`-`x15`.
- Quadrant 1, `cfunct3=100`, `instr[12:10]=111`, only when `instr[6:5]` is `11`
  or `10`; other values keep the base C.SUB/C.XOR/C.OR/C.AND decode:
  - `instr[6:5]=11`, `instr[4:2]` selects C.ZEXT.B (000), C.SEXT.B (001),
    C.ZEXT.H (010), C.SEXT.H (011), C.ZEXT.W (100) and C.NOT (101); 110/111
    are illegal.
  - `instr[6:5]=10` selects C.MUL with `rs2' = x8+instr[4:2]`.
- Sub-extension prerequisites are enforced in the decoder: Zbb for
  `c.sext.b`/`c.zext.h`/`c.sext.h`, RV64+Zba for `c.zext.w`, and MulDiv for
  `c.mul`. Failing prerequisites, or `withZcb=false` for the quadrant-0
  `cfunct3=100` block, yields an illegal instruction (cause 2).

## ALU datapath

- C.ZEXT.B is `AND` with `0xFF`; C.NOT is `XOR` with `-1`; C.ZEXT.W uses the
  existing `ADDUW` op. C.SEXT.B, C.ZEXT.H and C.SEXT.H reuse the Zbb ops, and
  C.MUL reuses the multiplier. Memory forms use the existing LSU with
  `memSize` 0/1 and `memSign` from C.LH.
- No new pipeline state, field or stall is introduced.

## RTL generation

`RiscvCoreGen` adds `RiscvCoreZCB` (RV32IMC+Zbb+Zcb) and `RiscvCore64ZCB`
(RV64IMC+Zba+Zbb+Zcb), bringing the generated config count to forty-two.

## Verification

- `RiscvCoreTest`: RV32 program covering all Zcb instructions with byte and
  halfword store/load round-trips plus zero/sign extension, `c.not` and
  `c.mul`; RV64 program covering `c.zext.w` and 64-bit `c.lh` sign extension.
  Both programs are packed with a local `assemble` helper that folds mixed
  16/32-bit instructions into 32-bit words.
- `IsaConfigSpec`: the presets expose the flag, keep the misa value of the
  compressed base and canonicalize as `RV32IMC_Zbb_Zcb_Zicsr` /
  `RV64IMC_Zba_Zbb_Zcb_Zicsr`; `CoreConfig` forwards the flag.
