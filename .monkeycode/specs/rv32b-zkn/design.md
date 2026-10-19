# Zknd / Zkne Design Specification

## Configuration

- `isa.RvExtension.Zkne` and `isa.RvExtension.Zknd` are named extensions that
  are part of the `implemented` set (no misa bit).
- `IsaConfig.hasZkne` / `hasZknd` mirror
  `extensions.contains(RvExtension.Zkne)` / `...Zknd`.
- Presets `rv32imzkne` / `rv64imzkne`, `rv32imzknd` / `rv64imzknd` and the
  combined `rv32imzkn` / `rv64imzkn` reuse `rv32im.misaValue` /
  `rv64im.misaValue` (no `B` bit) and add only `Zicsr`, `MulDiv` and the
  relevant `Zkn*` extensions. Canonical names sort the extension list, so the
  combined form is `RV32IM_Zicsr_Zknd_Zkne`.
- `CoreConfig` forwards both the presets and the `hasZkne` / `hasZknd` flags.

## Decode

`Decoder` applies `withZkne` / `withZknd` overlays (last-connect-wins) after the
base OP / OP-IMM decode:

- RV32 `aes32esi` / `aes32esmi` / `aes32dsi` / `aes32dsmi` are OP (`0110011`),
  `funct3=000`; the operation is selected by `instr[29:25]`
  (`10001` / `10011` / `10101` / `10111`) and `bs` is `instr[31:30]` (RV32
  only).
- RV64 `aes64es` / `aes64esm` / `aes64ds` / `aes64dsm` / `aes64ks2` are OP,
  `funct3=000`, distinguished by `funct7`
  (`0011001` / `0011011` / `0011101` / `0011111` / `0111111`).
- RV64 `aes64im` and `aes64ks1i` are OP-IMM (`0010011`), `funct3=001`, with the
  fixed selectors `imm[11:0]=0x300` and `imm[11:4]=0x31`; `aes64ks1i` takes
  `rcon` from `instr[23:20]` and is illegal when `rcon > 10`.
- The overlays set `regWrite := True`; unmatched encodings stay illegal.

## ALU datapath

- A new 4-bit `rcon` input is plumbed from the decoder through the ID/EX
  pipeline register to the `Alu`, alongside the existing `bs`.
- AES S-box tables `aesEncSboxTable` and `aesDecSboxTable` (256 entries each)
  follow the reference `aes_common.h`; `aesRconTable` holds `0x01`..`0x36` for
  indices 0..10.
- Helpers `aesXtime`, `aesGfmul`, `aesShiftRowsLo`, `aesInvShiftRowsLo`,
  `aesSubWord64`, `aesSubWord32`, `aesMixColumn` and `aesInvMixColumn` mirror
  the Spike integer model.
- `aes32*` transform the byte selected by `bs`, optionally apply MixColumns /
  InvMixColumns, rotate left by `8*bs`, XOR `rs1`, and sign-extend.
- `aes64*` operate on the full 64-bit operand; `aes64ks1i` applies the
  RotWord / SubWord / Rcon schedule (identity for `rcon = 10`) and `aes64ks2`
  combines both halves.
- All terms are computed combinationally in the EX stage; no new pipeline state
  or stall is introduced.

## RTL generation

`RiscvCoreGen` adds `RiscvCoreKNE` / `RiscvCore64KNE`, `RiscvCoreKND` /
`RiscvCore64KND` and the combined `RiscvCoreKN` / `RiscvCore64KN`, bringing the
generated config count to forty.

## Verification

- `RiscvCoreTest`: RV32 program exercising all four `aes32*` instructions with
  two `bs` values; RV64 program exercising the `aes64*` round, mix-column,
  `aes64im` and key-schedule instructions with `rcon` 0, 3 and 10. Reference
  vectors match the Spike integer model.
- `IsaConfigSpec`: `rv32imzkne` / `rv64imzkne`, `rv32imzknd` / `rv64imzknd` and
  `rv32imzkn` / `rv64imzkn` expose the flags without a reserved misa `B` bit,
  and `CoreConfig` forwards them.
