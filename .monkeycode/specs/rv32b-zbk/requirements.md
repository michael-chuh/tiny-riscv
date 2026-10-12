# RV32B / RV64B Crypto Bit-Manipulation Extensions (Zbkb / Zbkc / Zbkx)

## Feature summary

Add the ratified crypto bit-manipulation sub-extensions `Zbkb`, `Zbkc` and
`Zbkx` to `rv32c` on both RV32 and RV64, completing the staged bit-manipulation
work (`Zbb` → `Zbs` → `Zba` → `Zbc` → now `Zbk*`). Capability is declared in
`isa.RvExtension.Zbkb/Zbkc/Zbkx`, derived by `IsaConfig`, and decoded by the
`Decoder` / executed by the `Alu`, following the same pattern as the other
`Zb*` extensions.

## Scope

In scope:

- `Zbkb`: `pack`, `packh`, `packw` (RV64), `brev8`, RV32 `zip` / `unzip`, plus
  `rev8` (shared with `Zbb`).
- `Zbkc`: `clmul`, `clmulh` only — the `Zbc` subset without `clmulr`.
- `Zbkx`: `xperm4`, `xperm8` crossbar nibble/byte permutations.
- A combined `Zbkb + Zbkc + Zbkx` configuration.

Out of scope:

- `Zk*` (N/T) and `Zv*` vector crypto, and other unratified B drafts.
- A single-letter `B` misa bit is not set: `Zbk*` capability is exposed through
  the named extensions and does not change `misaValue`.

## Requirements (EARS)

WHEN `RvExtension.Zbkb` is present in `IsaConfig.extensions`,
THE `RiscvCore` SHALL decode and execute `pack`, `packh`, `brev8`, `zip`/`unzip`
(RV32) and `packw` (RV64).

WHEN `RvExtension.Zbkc` is present,
THE `RiscvCore` SHALL decode and execute `clmul` and `clmulh`, and SHALL NOT
decode `clmulr`.

WHEN `RvExtension.Zbkx` is present,
THE `RiscvCore` SHALL decode and execute `xperm4` and `xperm8`.

WHEN a given `Zbk*` extension is absent,
THE `RiscvCore` SHALL treat its encodings as illegal instructions (cause 2) and
SHALL NOT include the corresponding datapath in the synthesized ALU result
selection.

WHEN `pack` executes on RV32,
THE `RiscvCore` SHALL write `{rs2[15:0], rs1[15:0]}`; on RV64 it SHALL write
`{rs2[31:0], rs1[31:0]}`.

WHEN `packw` executes,
THE `RiscvCore` SHALL sign-extend the 32-bit packed low-half to XLEN.

WHEN `brev8` executes,
THE `RiscvCore` SHALL reverse the bit order within every byte of `rs1`.

WHEN `zip` / `unzip` executes on RV32,
THE `RiscvCore` SHALL interleave / de-interleave the two 16-bit halves into the
even/odd bit positions.

WHEN `xperm4` / `xperm8` executes,
THE `RiscvCore` SHALL use `rs1` as the table and `rs2` as per-group indices,
writing the selected group for each output group and zero for out-of-range
indices.

THE `IsaConfig` SHALL expose `hasZbkb`, `hasZbkc` and `hasZbkx` and derive the
canonical names `<base>IM_Zbk*_Zicsr` for the corresponding presets, with the
same `misaValue` as `rv32im` / `rv64im`.

## Acceptance criteria

- `rv32imzbkb`/`rv64imzbkb`, `rv32imzbkc`/`rv64imzbkc`, `rv32imzbkx`/`rv64imzbkx`
  and `rv32imzbk`/`rv64imzbk` presets exist and set the expected `has*` flags
  without affecting `misaValue`.
- Directed RV32 and RV64 programs cover the new instructions with reference
  vectors matching the Spike integer model.
- `sbt test` passes and the RTL generator emits `RiscvCore{BKB,BKC,BKX,BK}.v`
  and their `64` variants.
