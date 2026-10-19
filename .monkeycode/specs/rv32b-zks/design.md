# Zksh / Zksed Design Specification

## Configuration

- `isa.RvExtension.Zksh` and `isa.RvExtension.Zksed` are named extensions that
  are part of the `implemented` set (no misa bit).
- `IsaConfig.hasZksh` / `hasZksed` mirror
  `extensions.contains(RvExtension.Zksh)` / `...Zksed`.
- Presets `rv32imzksh` / `rv64imzksh`, `rv32imzksed` / `rv64imzksed` and the
  combined `rv32imzks` / `rv64imzks` reuse `rv32im.misaValue` /
  `rv64im.misaValue` (no `B` bit) and add only `Zicsr`, `MulDiv` and the
  relevant `Zks*` extensions. Canonical names sort the extension list, so the
  combined form is `RV32IM_Zicsr_Zksed_Zksh` (`Zksed` precedes `Zksh`).
- `CoreConfig` forwards both the presets and the `hasZksh` / `hasZksed` flags.

## Decode

`Decoder` applies `withZksh` / `withZksed` overlays (last-connect-wins) after
the base OP-IMM / OP decode:

- `sm3p0` / `sm3p1` (`Zksh`) share the `Zknh` OP-IMM encoding: `0010011`,
  `funct7=0001000`, `funct3=001`, selector in `instr[24:20]` = `01000` /
  `01001`. When `Zksh` is enabled the matching selectors are re-enabled after
  the `Zknh` overlay has marked the `Zknh` selector space illegal.
- `sm4ed` / `sm4ks` (`Zksed`) are OP (`0110011`), `funct3=000`; the operation
  is selected by `instr[29:25]` (`11000` = `sm4ed`, `11010` = `sm4ks`) and the
  byte-select `bs` is `instr[31:30]`.

## ALU datapath

- A new 2-bit `bs` input is plumbed from the decoder through the ID/EX pipeline
  register to the `Alu`.
- New helper `rotlW` (constant rotate) complements `shlW` / `shrW` / `rotrW`.
- The SM4 S-box (`Alu.sm4SboxTable`, 256 entries from the reference
  `sm4_common.h`) is indexed by the selected byte; unused cores prune the
  lookup.
- `sm3p0` = `a ^ ROL32(a,9) ^ ROL32(a,17)`, `sm3p1` =
  `a ^ ROL32(a,15) ^ ROL32(a,23)`, both sign-extended via
  `asSInt.resize(xlen)`.
- `sm4ed` / `sm4ks` apply the S-box, the respective linear/keystream transform,
  rotate left by `8*bs`, XOR `rs1` (low 32 bits), and sign-extend. All terms
  are computed combinationally in the EX stage; no new pipeline state or stall
  is introduced.

## RTL generation

`RiscvCoreGen` adds `RiscvCoreKSH` / `RiscvCore64KSH`, `RiscvCoreKSED` /
`RiscvCore64KSED` and the combined `RiscvCoreKS` / `RiscvCore64KS`, bringing
the generated config count to thirty-four.

## Verification

- `RiscvCoreTest`: RV32 program exercising `sm3p0`/`sm3p1` and all four
  `sm4ed`/`sm4ks` byte-selects; RV64 program verifying the sign-extension of
  the 32-bit results, with reference vectors matching the Spike integer model.
- `IsaConfigSpec`: `rv32imzksh` / `rv64imzksh`, `rv32imzksed` / `rv64imzksed`
  and `rv32imzks` / `rv64imzks` expose the flags without a reserved misa `B`
  bit.
