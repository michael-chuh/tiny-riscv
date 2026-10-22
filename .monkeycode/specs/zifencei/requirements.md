# Zifencei Instruction-Fetch Fence Extension

## Feature summary

Add the ratified `Zifencei` extension to `rv32c` on both RV32 and RV64.
Capability is declared in `isa.RvExtension.Zifencei`, derived by `IsaConfig`,
and decoded by the `Decoder`. `fence.i` becomes a legal instruction only when
the extension is enabled.

## Scope

In scope:

- `fence.i` decoding on RV32 and RV64.
- Making `Zifencei` part of `RvExtension.implemented` so `RiscvCore` no longer
  rejects configurations that name it.

Out of scope:

- Instruction caches or fetch buffers; the core has no instruction cache, so
  `fence.i` carries no invalidation work.
- Changes to `fence` (the memory-ordering instruction), which stays a NOP.

## Requirements (EARS)

WHEN `RvExtension.Zifencei` is present in `IsaConfig.extensions`,
THE `RiscvCore` SHALL decode `fence.i` (MISC-MEM, `funct3=001`) as a legal
instruction and SHALL continue executing the following instruction.

WHEN `RvExtension.Zifencei` is absent,
THE `RiscvCore` SHALL treat `fence.i` as an illegal instruction (cause 2) with
`mepc` pointing at the `fence.i` encoding.

THE `IsaConfig` SHALL expose `hasZifencei` and derive the canonical names
`RV32IM_Zicsr_Zifencei` / `RV64IM_Zicsr_Zifencei`, with the same `misaValue` as
`rv32im` / `rv64im`.

## Acceptance criteria

- `rv32imzifencei` / `rv64imzifencei` presets exist and set the flag without
  affecting `misaValue`.
- `RvExtension.reserved` is empty and `Zifencei` is in `implemented`.
- Directed tests cover the enabled (NOP, no trap) and disabled (cause 2, mepc)
  paths.
- `sbt test` passes and the RTL generator emits `RiscvCoreZIFENCEI.v` and
  `RiscvCore64ZIFENCEI.v`.
