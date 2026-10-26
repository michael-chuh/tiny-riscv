# User Counters (Zicntr) Design Specification

## Configuration

- `RvExtension.Zicntr` is added to `RvExtension.implemented`; it contributes no
  misa bit.
- `IsaConfig.hasZicntr` forwards from the extension set. Presets
  `rv32imzicntr` / `rv64imzicntr` = `{Zicsr, MulDiv, Zicntr}` + `PrivConfig.MU`;
  `CoreConfig.rv32imzicntr` / `rv64imzicntr` forward them.
- `CsrDef` gains `requiresZicntr` and `isRv32Only`. `CsrMap.implementedFor`
  filters on both, so the counters exist only on counter harts and the high
  halves only on RV32. `mcycle/minstret` are read/write at M; `cycle/time/instret`
  are `readOnly` with `minPriv = U`; `mcounteren(0x306)` is M and
  `scounteren(0x106)` is S.

## CSR file

- New storage (guarded by `hasZicntr`): 64-bit `cycleCnt`, 64-bit `instretCnt`,
  `mcounterenReg(2:0)`, `mcountinhibitReg(2:0)` and, on S harts,
  `scounterenReg(2:0)`. `time` has its own 64-bit register so TM can freeze it
  without stalling `cycle`.
- `cycleCnt` increments every edge (free running, independent of stalls);
  `instretCnt` increments when `io.retire` is high. `retire` is driven in the
  core from `memWb.valid && !freezeAll`, i.e. one pulse per committed
  instruction; a frozen WB does not double count.
- Reads: `0xB00/0xB02` return the machine counter aliases, `0xC00/0xC01` return
  `cycleCnt` (low half on RV32), `0xC02` returns `instretCnt`. On RV32
  `0xB80/0xB82` and `0xC80/0xC81/0xC82` return the high halves; on RV64 the full
  64-bit values are returned and the high-half addresses stay unimplemented.
  `time` aliases `cycle`.
- Writes: `0xB00/0xB02` replace the 64-bit counters (RV32 high-half writes at
  `0xB80/0xB82` replace the upper word after the increment); `0x306/0x106`
  store the low three bits (CY/TM/IR).
- `mcountinhibit` bits CY/TM/IR gate the three increments independently; writes
  store the low three bits.
- Readouts `counterEnM` / `counterEnS` export the enable bits to the core.

## Core

- `counterCsr` decodes the six user counter addresses; `counterIdx` picks the
  CY/TM/IR bit (TM for `0xC01/0xC81`, IR for `0xC02/0xC82`, CY otherwise).
- `mCounterDenied` is true below M mode when the `mcounteren` bit is clear;
  `sCounterDenied` is true in U mode on M/S/U harts when the `scounteren` bit
  is clear. Either folds into `csrIllegal`, which raises cause 2 with
  `mtval = CSR address`.
- Machine reads are never gated; read-only writes already trap through
  `csrRoWrite`, and writes to `mcycle/minstret` are legal in M mode.

## Tests and RTL

- `ZicsrTrapTest`: counters advance (cycle delta, `time` tracking, zero high
  halves on RV32), instret delta equals the retired instructions between reads,
  an `mcycle` write resets the counter, `mcountinhibit` freezes each counter
  independently; U-mode counter reads trap until
  `mcounteren` is set by the handler.
- `IsaConfigSpec` / `CsrMapSpec`: preset shape, no misa change, counter
  visibility, RV32-only high halves, `scounteren` requiring both Zicntr and S.
- `RiscvCoreGen` emits `RiscvCoreZICNTR` / `RiscvCore64ZICNTR` (48 configs).
