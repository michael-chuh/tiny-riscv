# Zknh Design Specification

## Configuration

- `isa.RvExtension.Zknh` is a named extension that is part of the `implemented`
  set (no misa bit).
- `IsaConfig.hasZknh` mirrors `extensions.contains(RvExtension.Zknh)`.
- Presets `IsaConfig.rv32imzknh` / `rv64imzknh` reuse `rv32im.misaValue` /
  `rv64im.misaValue` (no `B` bit) and add only `Zicsr`, `MulDiv` and `Zknh`.
  Canonical names are `RV32IM_Zicsr_Zknh` / `RV64IM_Zicsr_Zknh` (the name list
  is sorted, so `Zicsr` precedes `Zknh`).
- `CoreConfig` forwards both the presets and the `hasZknh` flag.

## Decode

`Decoder` applies a `withZknh` overlay (last-connect-wins) after the base
OP-IMM / OP decode:

OP-IMM (`0010011`), `funct7=0001000`, `funct3=001`, selector in `rs2` bits
`[24:20]`:

| selector | RV32 | RV64 |
|----------|------|------|
| 00000 | `sha256sum0` | `sha256sum0` |
| 00001 | `sha256sum1` | `sha256sum1` |
| 00010 | `sha256sig0` | `sha256sig0` |
| 00011 | `sha256sig1` | `sha256sig1` |
| 00100 | illegal | `sha512sum0` |
| 00101 | illegal | `sha512sum1` |
| 00110 | illegal | `sha512sig0` |
| 00111 | illegal | `sha512sig1` |

Other selectors under this `funct7`/`funct3` are illegal.

RV32-only OP (`0110011`), `funct3=000`:

| funct7 | operation |
|--------|-----------|
| 0101000 | `sha512sum0r` |
| 0101001 | `sha512sum1r` |
| 0101010 | `sha512sig0l` |
| 0101110 | `sha512sig0h` |
| 0101011 | `sha512sig1l` |
| 0101111 | `sha512sig1h` |

These are normally `ADD`/`SUB` on RV32I; the overlay overrides the six specific
`funct7` values. On RV64 the split forms are not decoded.

## ALU datapath

- Helpers `shlW` / `shrW` / `rotrW` operate on a fixed width `w`, explicitly
  resizing because Spinal's `>>` on UInt narrows the result.
- SHA-256: 32-bit `ROR`/`SHR` combinations, sign-extended to XLEN via
  `asSInt.resize(xlen)`.
- SHA-512 (RV64): 64-bit `ROR`/`SHR` combinations over `aU.resize(64)`.
- SHA-512 split (RV32): XOR of shifted/rotated low-32 terms of both operands
  (e.g. `sum0r = (a<<25)^(a<<30)^(a>>28)^(b>>7)^(b>>2)^(b<<4)`), sign-extended.
- All terms are computed combinationally in the EX stage; no new pipeline state
  or stall is introduced.

## RTL generation

`RiscvCoreGen` adds `RiscvCoreKNH` / `RiscvCore64KNH`, bringing the generated
config count to twenty-eight.

## Verification

- `RiscvCoreTest`: RV32 program exercising the SHA-256 ops and all six SHA-512
  split forms; RV64 program exercising the full-width SHA-256 and SHA-512 ops
  (including sign-extension of the SHA-256 results), with reference vectors
  matching the Spike integer model.
- `IsaConfigSpec`: `rv32imzknh` / `rv64imzknh` expose `hasZknh` without a
  reserved misa `B` bit, and a plain core exposes none of it.
