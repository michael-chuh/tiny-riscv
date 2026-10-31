# Sv39 MMU Design Specification

## Architecture

```
+-------------------+
| Instruction Fetch |
+-------------------+
         |
         v
+-------------------+     +------------------+
|  Sv39Mmu (RV64)   |---->| Core iBus (PC)   |
| - 16-entry TLB    |     +------------------+
| - 3-level Walker  |
+-------------------+     +------------------+
         |              | | Core dBus        |
         v              | +------------------+
+-------------------+   v
|   satp (CSR)      |
| - MODE (8=Sv39)   |
| - PPN (44 bits)   |
+-------------------+
```

## TLB Structure

- **Size**: 16 entries, direct-mapped
- **Index**: `vaddr[15:12]`
- **Tag**: `vaddr[38:12]` (VPN)
- **Data**: PPN (44 bits), permission bits (U/X/W/R), dirty bit
- **Lookup**: Combinational; permission + privilege + Svade check per access

## Page-Table Walk

- **FSM States**: IDLE → REQ → EVAL → (IDLE or fault)
- **Priority**: Data walk > Instruction walk (data is older)
- **Bus Access**: Drives core dBus during walk; pipeline frozen
- **Levels**: 3 (Sv39: bits 38-30, 29-21, 20-12)

## Fault Handling

- **Instruction Page Fault**: Cause 12, `stval = faulting PC`
- **Load Page Fault**: Cause 13, `stval = faulting address`
- **Store Page Fault**: Cause 15, `stval = faulting address`
- **Fault Conditions**:
  - Invalid PTE (V=0)
  - Reserved encoding (W=1, R=0)
  - Superpage misalignment
  - Permission denied (R/W/X, U/S, SUM)
  - Svade violation (A=0 or W=1 & D=0)

## SFENCE.VMA

- **Encoding**: `000100100000` (funct3=001, rs1/rs2=any)
- **Privilege**: S-mode or M-mode only (illegal in U)
- **Effect**: Flush TLB + fault registers + walker FSM

## Integration

- **RV64**: MMU instantiated, translation active when `satp.MODE=8`
- **RV32**: MMU bypassed, always BARE mode
- **M-mode**: Always bypasses MMU (physical addresses)
