# RV32B / RV64B SM3 / SM4 Crypto Bit-Manipulation Extensions (Zksh, Zksed)

## Feature summary

Add the ratified SM hash/block-cipher bit-manipulation sub-extensions `Zksh`
(SM3) and `Zksed` (SM4) to `rv32c` on both RV32 and RV64, continuing the staged
crypto bit-manipulation work (`Zbb` → `Zbs` → `Zba` → `Zbc` → `Zbk*` → `Zknh` →
now `Zks*`). Capability is declared in `isa.RvExtension.Zksh` /
`isa.RvExtension.Zksed`, derived by `IsaConfig`, and decoded by the `Decoder` /
executed by the `Alu`, following the same pattern as the other `Z*` extensions.

## Scope

In scope:

- SM3: `sm3p0`, `sm3p1` (`Zksh`) on RV32 and RV64.
- SM4: `sm4ed`, `sm4ks` (`Zksed`) on RV32 and RV64.

Out of scope:

- `Zknd` / `Zkne` (AES), `Zknh` (SHA-2, already implemented) and `Zv*` vector
  crypto.
- A single-letter `B` misa bit is not set: `Zksh` / `Zksed` capability is
  exposed through the named extensions and does not change `misaValue`.

## Requirements (EARS)

WHEN `RvExtension.Zksh` is present in `IsaConfig.extensions`,
THE `RiscvCore` SHALL decode and execute `sm3p0` and `sm3p1` on both RV32 and
RV64.

WHEN `sm3p0` / `sm3p1` executes,
THE `RiscvCore` SHALL produce `sext32(a ^ ROL32(a,9) ^ ROL32(a,17))` and
`sext32(a ^ ROL32(a,15) ^ ROL32(a,23))` respectively.

WHEN `RvExtension.Zksed` is present in `IsaConfig.extensions`,
THE `RiscvCore` SHALL decode and execute `sm4ed` and `sm4ks` for all four
byte-select values `bs` (bits `[31:30]`) on both RV32 and RV64.

WHEN `sm4ed` / `sm4ks` executes,
THE `RiscvCore` SHALL take `sb_in = (rs2 >> (8*bs)) & 0xFF`, apply the SM4
S-box, apply the corresponding linear/keystream transform, rotate left by
`8*bs`, XOR with `rs1`, and sign-extend the 32-bit result to XLEN.

WHEN `RvExtension.Zksh` and/or `RvExtension.Zksed` is absent,
THE `RiscvCore` SHALL treat the corresponding encodings as illegal instructions
(cause 2) and SHALL NOT include the corresponding datapath in the synthesized
ALU result selection.

THE `IsaConfig` SHALL expose `hasZksh` and `hasZksed` and derive canonical names
`<base>IM_Zicsr_Zksh` / `<base>IM_Zicsr_Zksed` for the corresponding presets,
with the same `misaValue` as `rv32im` / `rv64im`.

## Acceptance criteria

- `rv32imzksh` / `rv64imzksh`, `rv32imzksed` / `rv64imzksed` and the combined
  `rv32imzks` / `rv64imzks` presets exist and set the corresponding flags
  without affecting `misaValue`.
- Directed RV32 and RV64 programs cover the new instructions with reference
  vectors matching the Spike integer model.
- `sbt test` passes and the RTL generator emits `RiscvCoreKSH.v`,
  `RiscvCore64KSH.v`, `RiscvCoreKSED.v`, `RiscvCore64KSED.v`, `RiscvCoreKS.v`
  and `RiscvCore64KS.v`.
