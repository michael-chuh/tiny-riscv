# Sv39 MMU Requirements

## Overview

Implement Sv39 39-bit virtual memory translation for RV64 cores with a small direct-mapped TLB and three-level page-table walk.

## EARS-style Requirements

### Capability (what the system shall do)

1. **TLB Translation**
   - The MMU shall cache 16 virtual-to-physical translations in a direct-mapped TLB indexed by `vaddr[15:12]`.
   - The MMU shall translate both instruction fetch and data load/store addresses when `satp.MODE=8`.

2. **Page-Table Walk**
   - On a TLB miss, the MMU shall perform a three-level page-table walk using the hardware data bus.
   - The MMU shall freeze the pipeline during the walk to ensure atomicity.

3. **Permission Checks**
   - The MMU shall check R/W/X permission bits on every access.
   - The MMU shall enforce U/S privilege and `mstatus.SUM` rules.
   - The MMU shall implement Svade: fault if A=0 or (W=1 and D=0).

4. **Fault Reporting**
   - The MMU shall raise instruction page-fault (cause 12) for fetch failures.
   - The MMU shall raise load page-fault (cause 13) for load failures.
   - The MMU shall raise store page-fault (cause 15) for store/AMO failures.
   - The faulting virtual address shall be written to `stval`.

5. **SFENCE.VMA Support**
   - The core shall decode `SFENCE.VMA` (funct3=001, rs1/rs2=any) as a supervisor instruction.
   - A `SFENCE.VMA` execution or `satp` write shall flush the TLB.

### Environmental Constraints

- Sv39 translation is only available on RV64 cores (`xlen=64`).
- RV32 cores shall keep BARE-only mode and bypass the MMU.

## Acceptance Criteria

- All 135 existing tests pass.
- RV64 S-mode cores can successfully run with `satp.MODE=8` and valid page tables.
- Page faults are correctly delegated and caught by S-mode handlers.
