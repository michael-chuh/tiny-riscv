# RV32B / RV64B AES Crypto Bit-Manipulation Extensions (Zknd, Zkne)

## Feature summary

Add the ratified AES bit-manipulation sub-extensions `Zkne` (encryption round)
and `Zknd` (decryption round) to `rv32c` on both RV32 and RV64, completing the
staged crypto bit-manipulation work (`Zbb` → `Zbs` → `Zba` → `Zbc` → `Zbk*` →
`Zknh` → `Zks*` → now `Zkn*`). Capability is declared in
`isa.RvExtension.Zkne` / `isa.RvExtension.Zknd`, derived by `IsaConfig`, and
decoded by the `Decoder` / executed by the `Alu`, following the same pattern as
the other `Z*` extensions.

## Scope

In scope:

- AES encryption round: `aes32esi`, `aes32esmi` (`Zkne`, RV32) and `aes64es`,
  `aes64esm` (`Zkne`, RV64).
- AES decryption round: `aes32dsi`, `aes32dsmi` (`Zknd`, RV32) and `aes64ds`,
  `aes64dsm`, `aes64im` (`Zknd`, RV64).
- AES-64 key schedule: `aes64ks1i`, `aes64ks2`, shared by `Zkne` and `Zknd`.

Out of scope:

- `Zks*` (SM3/SM4, already implemented), `Zknh` (SHA-2, already implemented) and
  `Zv*` vector crypto.
- A single-letter `B` misa bit is not set: `Zknd` / `Zkne` capability is exposed
  through the named extensions and does not change `misaValue`.

## Requirements (EARS)

WHEN `RvExtension.Zkne` is present in `IsaConfig.extensions`,
THE `RiscvCore` SHALL decode and execute `aes32esi` / `aes32esmi` on RV32 and
`aes64es` / `aes64esm` on RV64.

WHEN `RvExtension.Zknd` is present in `IsaConfig.extensions`,
THE `RiscvCore` SHALL decode and execute `aes32dsi` / `aes32dsmi` on RV32 and
`aes64ds` / `aes64dsm` / `aes64im` on RV64.

WHEN `RvExtension.Zkne` or `RvExtension.Zknd` is present,
THE `RiscvCore` SHALL decode and execute `aes64ks1i` (for `rcon` 0..10) and
`aes64ks2` on RV64.

WHEN a `aes32*` instruction executes,
THE `RiscvCore` SHALL apply the byte-oriented AES round transform selected by
`bs` (bits `[31:30]`), optionally MixColumns / InvMixColumns, rotate left by
`8*bs`, XOR with `rs1`, and sign-extend the 32-bit result to XLEN.

WHEN an `aes64*` instruction executes,
THE `RiscvCore` SHALL apply the 64-bit AES ShiftRows / InvShiftRows, SubBytes /
InvSubBytes and (for the `m` forms) MixColumns / InvMixColumns transforms, or the
AES-64 key-schedule transform for `aes64ks1i` / `aes64ks2`.

WHEN `aes64ks1i` is decoded with `rcon > 10`,
THE `RiscvCore` SHALL treat the encoding as an illegal instruction (cause 2).

WHEN the relevant extension is absent,
THE `RiscvCore` SHALL treat the corresponding encodings as illegal instructions
(cause 2) and SHALL NOT include the corresponding datapath in the synthesized
ALU result selection.

THE `IsaConfig` SHALL expose `hasZkne` and `hasZknd` and derive canonical names
`<base>IM_Zicsr_Zkne`, `<base>IM_Zicsr_Zknd` and
`<base>IM_Zicsr_Zknd_Zkne` for the corresponding presets, with the same
`misaValue` as `rv32im` / `rv64im`.

## Acceptance criteria

- `rv32imzkne` / `rv64imzkne`, `rv32imzknd` / `rv64imzknd` and the combined
  `rv32imzkn` / `rv64imzkn` presets exist and set the corresponding flags
  without affecting `misaValue`.
- Directed RV32 and RV64 programs cover the new instructions with reference
  vectors matching the Spike integer model, including three `rcon` values.
- `sbt test` passes and the RTL generator emits `RiscvCoreKNE.v`,
  `RiscvCore64KNE.v`, `RiscvCoreKND.v`, `RiscvCore64KND.v`, `RiscvCoreKN.v` and
  `RiscvCore64KN.v`.
