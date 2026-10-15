# RV32B / RV64B SHA-2 Hash Bit-Manipulation Extension (Zknh)

## Feature summary

Add the ratified hash bit-manipulation sub-extension `Zknh` to `rv32c` on both
RV32 and RV64, continuing the staged crypto bit-manipulation work
(`Zbb` → `Zbs` → `Zba` → `Zbc` → `Zbk*` → now `Zknh`). Capability is declared in
`isa.RvExtension.Zknh`, derived by `IsaConfig`, and decoded by the `Decoder` /
executed by the `Alu`, following the same pattern as the other `Z*` extensions.

## Scope

In scope:

- SHA-256: `sha256sum0`, `sha256sum1`, `sha256sig0`, `sha256sig1`.
- SHA-512 (RV64): `sha512sum0`, `sha512sum1`, `sha512sig0`, `sha512sig1`.
- SHA-512 split forms (RV32): `sha512sum0r`, `sha512sum1r`,
  `sha512sig0l`, `sha512sig0h`, `sha512sig1l`, `sha512sig1h`.

Out of scope:

- `Zknd` / `Zkne` (AES), `Zknh`'s sibling `Zks*` (SM3/SM4) and `Zv*` vector
  crypto.
- A single-letter `B` misa bit is not set: `Zknh` capability is exposed through
  the named extension and does not change `misaValue`.

## Requirements (EARS)

WHEN `RvExtension.Zknh` is present in `IsaConfig.extensions`,
THE `RiscvCore` SHALL decode and execute `sha256sum0`, `sha256sum1`,
`sha256sig0` and `sha256sig1` on both RV32 and RV64.

WHEN `RvExtension.Zknh` is present and the hart is RV64,
THE `RiscvCore` SHALL additionally decode and execute `sha512sum0`,
`sha512sum1`, `sha512sig0` and `sha512sig1`.

WHEN `RvExtension.Zknh` is present and the hart is RV32,
THE `RiscvCore` SHALL additionally decode and execute the SHA-512 split forms
`sha512sum0r`, `sha512sum1r`, `sha512sig0l`, `sha512sig0h`, `sha512sig1l` and
`sha512sig1h`.

WHEN `RvExtension.Zknh` is absent,
THE `RiscvCore` SHALL treat all `Zknh` encodings as illegal instructions
(cause 2) and SHALL NOT include the corresponding datapath in the synthesized
ALU result selection.

WHEN a `sha256*` or (RV32) `sha512*` split instruction executes,
THE `RiscvCore` SHALL compute in 32-bit width and sign-extend the result to XLEN.

WHEN an RV64 `sha512*` instruction executes,
THE `RiscvCore` SHALL compute over the full 64-bit operand.

WHEN `sha256sum0` / `sha256sum1` executes,
THE `RiscvCore` SHALL produce `ROR32(a,2)^ROR32(a,13)^ROR32(a,22)` and
`ROR32(a,6)^ROR32(a,11)^ROR32(a,25)` respectively.

WHEN `sha256sig0` / `sha256sig1` executes,
THE `RiscvCore` SHALL produce `ROR32(a,7)^ROR32(a,18)^SHR32(a,3)` and
`ROR32(a,17)^ROR32(a,19)^SHR32(a,10)` respectively.

THE `IsaConfig` SHALL expose `hasZknh` and derive canonical names
`<base>IM_Zicsr_Zknh` for the corresponding presets, with the same `misaValue`
as `rv32im` / `rv64im`.

## Acceptance criteria

- `rv32imzknh` / `rv64imzknh` presets exist and set `hasZknh` without affecting
  `misaValue`.
- Directed RV32 and RV64 programs cover the new instructions with reference
  vectors matching the Spike integer model.
- `sbt test` passes and the RTL generator emits `RiscvCoreKNH.v` and
  `RiscvCore64KNH.v`.
