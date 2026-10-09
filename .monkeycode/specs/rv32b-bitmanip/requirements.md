# RV32B / RV64B Bit-Manipulation Extension (Zba / Zbb / Zbs)

## Feature summary

Add the ratified RISC-V bit-manipulation extension to `rv32c` as a
configuration-selectable set of sub-extensions (`Zba`, `Zbb`, `Zbs`) on both
RV32 and RV64. The extension follows the established pattern: capability is
declared in `isa.RvExtension`, derived by `IsaConfig`, and decoded by the
`Decoder` / executed by the `Alu`. Implementation is staged: `Zbb` first
(this change), then `Zbs`, then `Zba`.

## Stakeholders

- rv32 MCU users: `Zbb`/`Zbs` reduce code size and cycles for common integer
  idioms (bit scans, byte reversal, single-bit set/clear/test).
- rv64 high-performance users: `Zba` accelerates address generation
  (`sh*add`, `add.uw`, `slli.uw`).

## Scope

In scope:

- `Zbb`: `andn/orn/xnor`, `clz/ctz/cpop`, `min/minu/max/maxu`, `rol/ror/rori`,
  `sext.b/sext.h/zext.h`, `orc.b/rev8`, plus RV64 W-forms
  (`clzw/ctzw/cpopw/rolw/rorw/roriw`).
- `Zbs`: `bset/bclr/binv/bext` and immediate forms (RV32 5-bit shamt,
  RV64 6-bit shamt).
- `Zba`: `sh1add/sh2add/sh3add`; RV64 `add.uw`, `slli.uw`,
  `sh1add.uw/sh2add.uw/sh3add.uw`.

Out of scope:

- `Zbc` (carry-less multiply), `Zbkb/Zbkc/Zbkx/Zk*` (crypto), `Zbf/Zbp`
  and other unratified B drafts.
- A single-letter `B` misa bit is not set: the current RISC-V specification
  leaves the `B` misa bit reserved and exposes the capability through the
  named `Zb*` extensions instead.

## Requirements (EARS)

WHEN `RvExtension.Zbb` is present in `IsaConfig.extensions`,
THE `RiscvCore` SHALL decode and execute every `Zbb` instruction listed in
the scope on both RV32 and RV64 harts.

WHEN `RvExtension.Zbb` is absent,
THE `RiscvCore` SHALL treat every `Zbb` encoding as an illegal instruction
(`cause 2`) and SHALL NOT include the bit-manipulation datapath in the
synthesized ALU result selection.

WHEN the hart is RV64 and executes a W-suffix bit-manipulation instruction,
THE `RiscvCore` SHALL operate on the low 32 bits and sign-extend the result to
64 bits.

WHEN the hart is RV32 and an RV64-only `Zbb` encoding is presented,
THE `RiscvCore` SHALL raise an illegal instruction.

THE `IsaConfig` SHALL expose `hasZbb` and SHALL derive the canonical name
`RV32IM_Zbb_Zicsr` / `RV64IM_Zbb_Zicsr` for the corresponding presets.

## Acceptance criteria

- All base regressions remain green.
- New directed tests cover each `Zbb` instruction family on RV32 and RV64,
  including zero-count edge cases (`clz 0`, `ctz 0`, `cpop 0`) and rotate by 0.
- RTL generation succeeds for the new `Zbb` configurations.

## Quality attributes

- No change to the frozen architecture invariants: single freeze mechanism,
  EX-stage trap redirection, WB-only register write, single write port.
- Bit-manipulation execution stays fully combinational in the EX stage, sharing
  the existing ALU result path (no new stall state).

## Open questions

- Whether to continue with `Zbs` and `Zba` immediately after this change: yes,
  as separate follow-up changes under the same `rv32b-bitmanip` spec.
