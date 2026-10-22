# Zifencei Design Specification

## Configuration

- `isa.RvExtension.Zifencei` moves from `reserved` to `implemented`, so
  `RiscvCore`'s `require` accepts configurations that name it. The `reserved`
  set is now empty.
- `IsaConfig.hasZifencei` already mirrored the extension membership and is now
  used by the decoder.
- Presets `rv32imzifencei` / `rv64imzifencei` reuse `rv32im.misaValue` /
  `rv64im.misaValue` and add only `Zicsr`, `MulDiv` and `Zifencei`; canonical
  names read `RV32IM_Zicsr_Zifencei` / `RV64IM_Zicsr_Zifencei` because the
  Z-extension list is sorted alphabetically.
- `CoreConfig` forwards the presets and the `hasZifencei` flag.

## Decode

`Decoder` adds a `withZifencei` flag and gates the existing MISC-MEM branch:

- `funct3=000` (`fence`) remains a NOP regardless of the extension.
- `funct3=001` (`fence.i`) is legal only when `withZifencei`; otherwise the
  instruction is marked illegal.
- Other `funct3` values stay illegal.

## Datapath

The core has no instruction cache, so `fence.i` has no architectural work
beyond decoding successfully. No pipeline state, field or stall is added, and
the ALU/LSU are untouched.

## RTL generation

`RiscvCoreGen` adds `RiscvCoreZIFENCEI` and `RiscvCore64ZIFENCEI`, bringing the
generated config count to forty-four.

## Verification

- `ZicsrTrapTest`: a program executes `fence.i` before `addi x10,x0,7` with a
  trap handler that records `mcause`/`mepc`. Enabled: `x10==7`, no trap.
  Disabled: `mcause==2`, `mepc` at the `fence.i` word and `x10==0`.
- `IsaConfigSpec`: the presets expose the flag without a reserved misa bit, the
  canonical names are stable, `CoreConfig` forwards the flag, and the
  `reserved` set is empty.
