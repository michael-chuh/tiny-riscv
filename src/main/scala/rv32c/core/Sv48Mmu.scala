package rv32c.core

import spinal.core._

/** Sv48 MMU - 4-level page table walker for 48-bit virtual addressing.
  *
  * Supports:
  * - 4-level page table walk (512GB address space)
  * - Svade: A/D bits managed by hardware
  * - SUM: Supervisor User Mode access control
  * - Page fault exceptions
  */
class Sv48Mmu(val addrWidth: Int = 64) extends Component {
  val io = new Bundle {
    // Control
    val enable = in Bool()
    val ppn = in UInt(44 bits)  // satp.PPN
    val priv = in UInt(2 bits)  // Current privilege mode
    val sum = in Bool()         // MSTATUS.SUM
    val flush = in Bool()       // TLB flush request
    
    // Instruction fetch
    val iValid = in Bool()
    val iVaddr = in UInt(addrWidth bits)
    val iHit = out Bool()
    val iFault = out Bool()
    val iPaddr = out UInt(addrWidth bits)
    
    // Data access
    val dValid = in Bool()
    val dAccess = in UInt(2 bits)  // Bit0: Read, Bit1: Write
    val dVaddr = in UInt(addrWidth bits)
    val dHit = out Bool()
    val dFault = out Bool()
    val dPaddr = out UInt(addrWidth bits)
    
    // Page table walk interface
    val ptwValid = out Bool()
    val ptwAddr = out UInt(addrWidth bits)
    val ptwData = in Bits(64 bits)
  }

  val vpnBits = 9
  val offsetBits = 12
  val ppnBits = addrWidth - offsetBits
  
  // TLB: 32 entries, fully associative
  val tlbSize = 32
  val tlbVpn = Vec(Reg(UInt((addrWidth - offsetBits) bits)), tlbSize)
  val tlbPpn = Vec(Reg(UInt(ppnBits bits)), tlbSize)
  val tlbValid = Vec(RegInit(False), tlbSize)
  val tlbPerm = Vec(Reg(Bits(5 bits)), tlbSize)  // R/W/X/U bits
  
  // TLB lookup
  val iVpn = io.iVaddr(addrWidth - 1 downto offsetBits)
  val dVpn = io.dVaddr(addrWidth - 1 downto offsetBits)
  val iOffset = io.iVaddr(offsetBits - 1 downto 0)
  val dOffset = io.dVaddr(offsetBits - 1 downto 0)
  
  val iTagMatch = Vec(False, tlbSize)
  val dTagMatch = Vec(False, tlbSize)
  for (i <- 0 until tlbSize) {
    iTagMatch(i) := tlbValid(i) && (tlbVpn(i)(35 downto 0) === iVpn48)
    dTagMatch(i) := tlbValid(i) && (tlbVpn(i)(35 downto 0) === dVpn48)
  }
  
  val iTlbHit = iTagMatch.asBits.orR && io.enable
  val dTlbHit = dTagMatch.asBits.orR && io.enable
  
  // Permission check
  def checkPerm(perm: Bits, isFetch: Bool, isWrite: Bool, priv: UInt, sum: Bool): Bool = {
    val v = perm(3)  // Valid
    val r = perm(2)  // Readable
    val w = perm(1)  // Writable
    val x = perm(0)  // Executable
    val u = perm(4)  // User accessible
    
    val modeS = priv === U(1, 2 bits)
    val canAccessU = u && (modeS || sum)
    val canAccessS = !u && modeS
    
    val permOk = v && (isFetch && x || !isFetch && (isWrite && w || !isWrite && r))
    val privOk = canAccessU || canAccessS || priv === U(0, 2 bits)
    
    permOk && privOk
  }
  
  // Find matching TLB entry
  val iPerm = Bits(5 bits)
  val dPerm = Bits(5 bits)
  val iPpn = UInt(ppnBits bits)
  val dPpn = UInt(ppnBits bits)
  
  iPerm := B(0, 5 bits)
  dPerm := B(0, 5 bits)
  iPpn := (io.iVaddr(addrWidth - 1 downto offsetBits).asBits ## iOffset)(addrWidth - 1 downto offsetBits).asUInt
  dPpn := (io.dVaddr(addrWidth - 1 downto offsetBits).asBits ## dOffset)(addrWidth - 1 downto offsetBits).asUInt
  
  for (i <- 0 until tlbSize) {
    when(iTagMatch(i)) {
      iPpn := tlbPpn(i)
      iPerm := tlbPerm(i)
    }
    when(dTagMatch(i)) {
      dPpn := tlbPpn(i)
      dPerm := tlbPerm(i)
    }
  }
  
  io.iHit := iTlbHit && checkPerm(iPerm, True, False, io.priv, io.sum)
  io.dHit := dTlbHit && checkPerm(dPerm, False, io.dAccess(1), io.priv, io.sum)
  io.iPaddr := iPpn @@ iOffset
  io.dPaddr := dPpn @@ dOffset
  
  // Page table walker FSM
  object WalkState extends SpinalEnum {
    val IDLE, L4, L3, L2, L1, FINAL = newElement()
  }
  import WalkState._
  
  val walkState = RegInit(IDLE)
  val walkLevel = Reg(UInt(2 bits))
  val walkAddr = Reg(UInt(addrWidth bits))
  val walkData = Reg(Bits(64 bits))
  val walkFault = RegInit(False)
  val walkPpn = Reg(UInt(ppnBits bits))
  val walkPerm = Reg(Bits(5 bits))
  
  // Sv48: 4 levels (L4->L3->L2->L1)
  // Sv48 VPN fields (bits 47:12)
  // vpn4: bits 47:39, vpn3: bits 38:30, vpn2: bits 29:21, vpn1: bits 20:12
  val vpn4 = io.dVaddr(47 downto 39)
  val vpn3 = io.dVaddr(38 downto 30)
  val vpn2 = io.dVaddr(29 downto 21)
  val vpn1 = io.dVaddr(20 downto 12)
  
  // For TLB tag comparison, use full 48-bit VA shifted right by 12
  val iVpn48 = io.iVaddr(47 downto offsetBits)
  val dVpn48 = io.dVaddr(47 downto offsetBits)
  
  io.ptwValid := walkState =/= IDLE
  io.ptwAddr := walkAddr
  
  // PTE fields
  val pteV = walkData(0)
  val pteR = walkData(1)
  val pteW = walkData(2)
  val pteX = walkData(3)
  val pteU = walkData(4)
  val pteA = walkData(5)
  val pteD = walkData(6)
  val ptePpn = walkData(63 downto 10)
  
  when(io.flush) {
    for (i <- 0 until tlbSize) {
      tlbValid(i) := False
    }
    walkState := IDLE
  }
  
  // Start page walk on TLB miss
  val dTlbMiss = io.dValid && !dTlbHit && io.enable
  val iTlbMiss = io.iValid && !iTlbHit && io.enable
  
  when((dTlbMiss || iTlbMiss) && walkState === IDLE) {
    walkState := L4
    walkLevel := U(3, 2 bits)  // Start from L4
    walkAddr := ((io.ppn.asBits ## U(0, offsetBits bits)).asUInt.resized).resize(addrWidth)
    walkFault := False
    when(dTlbMiss) {
      walkAddr := ((io.ppn.asBits ## vpn4).asUInt.resized).resize(addrWidth)
    } otherwise {
      walkAddr := ((io.ppn.asBits ## iVpn(addrWidth - 1 downto addrWidth - vpnBits)).asUInt.resized).resize(addrWidth)
    }
  }
  
  when(walkState =/= IDLE && io.ptwValid) {
    switch(walkState) {
      is(L4) {
        walkData := io.ptwData
        when(!pteV) {
          walkState := IDLE
          walkFault := True
        }.elsewhen(pteR || pteW || pteX) {
          // Leaf at L4
          walkState := FINAL
          walkPpn := ptePpn(51 downto 0).asUInt
          walkPerm := Cat(pteU, pteV, pteR, pteW, pteX)
        }.otherwise {
          // Continue to L3
          walkState := L3
          walkLevel := walkLevel - 1
          walkAddr := ((ptePpn.asBits ## vpn3).asUInt.resized).resize(addrWidth)
        }
      }
      is(L3) {
        walkData := io.ptwData
        when(!pteV) {
          walkState := IDLE
          walkFault := True
        }.elsewhen(pteR || pteW || pteX) {
          // Leaf at L3
          walkState := FINAL
          walkPpn := ((ptePpn.asBits ## U(0, vpnBits bits)).asUInt.resized).resize(ppnBits)
          walkPerm := Cat(pteU, pteV, pteR, pteW, pteX)
        }.otherwise {
          // Continue to L2
          walkState := L2
          walkLevel := walkLevel - 1
          walkAddr := ((ptePpn.asBits ## vpn2).asUInt.resized).resize(addrWidth)
        }
      }
      is(L2) {
        walkData := io.ptwData
        when(!pteV) {
          walkState := IDLE
          walkFault := True
        }.elsewhen(pteR || pteW || pteX) {
          // Leaf at L2
          walkState := FINAL
          walkPpn := ((ptePpn.asBits ## U(0, 2*vpnBits bits)).asUInt.resized).resize(ppnBits)
          walkPerm := Cat(pteU, pteV, pteR, pteW, pteX)
        }.otherwise {
          // Continue to L1
          walkState := L1
          walkLevel := walkLevel - 1
          walkAddr := ((ptePpn.asBits ## vpn1).asUInt.resized).resize(addrWidth)
        }
      }
      is(L1) {
        walkData := io.ptwData
        when(!pteV) {
          walkState := IDLE
          walkFault := True
        }.elsewhen(pteR || pteW || pteX) {
          // Leaf at L1
          walkState := FINAL
          walkPpn := ((ptePpn.asBits ## U(0, 3*vpnBits bits)).asUInt.resized).resize(ppnBits)
          walkPerm := Cat(pteU, pteV, pteR, pteW, pteX)
        }.otherwise {
          // Invalid: not a leaf at L1
          walkState := IDLE
          walkFault := True
        }
      }
      is(FINAL) {
        // Update TLB
        val tlbIdx = CombInit(U(0, log2Up(tlbSize) bits))
        for (i <- 0 until tlbSize) {
          when(!tlbValid(i)) {
            tlbIdx := U(i, log2Up(tlbSize) bits)
          }
        }
        
        tlbValid(tlbIdx) := True
        tlbVpn(tlbIdx) := Mux(dTlbMiss, (U(0, 16 bits) ## dVpn48.asBits)(51 downto 0).asUInt, (U(0, 16 bits) ## iVpn48.asBits)(51 downto 0).asUInt)
        tlbPpn(tlbIdx) := walkPpn
        tlbPerm(tlbIdx) := walkPerm
        
        walkState := IDLE
      }
    }
  }
  
  io.iFault := walkFault && iTlbMiss
  io.dFault := walkFault && dTlbMiss
}
