package rv32c.core

import spinal.core._

/** Sv39 memory management unit (RV64).
  *
  * A small direct-mapped TLB (16 entries, indexed by `vaddr[15:12]`) caches
  * leaf translations for both the instruction and the data port. On a miss a
  * three-level page-table walk drives `ptw*`, which the core multiplexes onto
  * the data bus while the pipeline is frozen. Translations are per-access:
  * permissions, privilege (U/S), `mstatus.SUM` and the Svade A/D rule are
  * evaluated on every lookup, so a TLB hit cannot bypass them.
  *
  * Sv39 only: `satp.MODE` is decoded by `CsrFile` and `enable` is only high for
  * MODE=8. M-mode accesses never reach the unit (the core ties `enable` low).
  */
class Sv39Mmu(xlen: Int = 64) extends Component {
  val io = new Bundle {
    val enable = in Bool() // satp.MODE == 8 (Sv39)
    val ppn = in UInt (44 bits) // satp.PPN
    val priv = in UInt (2 bits) // current privilege mode
    val sum = in Bool() // mstatus.SUM
    val flush = in Bool() // satp write or SFENCE.VMA

    // Instruction port (translation of the word being fetched).
    val iValid = in Bool()
    val iVaddr = in UInt (xlen bits)
    val iPaddr = out UInt (xlen bits)
    val iHit = out Bool() // translation (and permission) available
    val iFault = out Bool()

    // Data port (loads, stores, LR/SC/AMO).
    val dValid = in Bool()
    val dAccess = in UInt (2 bits) // bit0 = read, bit1 = write
    val dVaddr = in UInt (xlen bits)
    val dPaddr = out UInt (xlen bits)
    val dHit = out Bool()
    val dFault = out Bool()

    // Page-table walk port, driven onto the core data bus.
    val ptwValid = out Bool()
    val ptwAddr = out UInt (xlen bits)
    val ptwData = in Bits (64 bits)
  }

  private val MODE_S = U(1, 2 bits)
  private val MODE_U = U(0, 2 bits)

  private val TLB_N = 16

  private def canonical(v: UInt): Bool = {
    if (xlen <= 39) True
    else {
      val hi = v(63 downto 39)
      (hi === U(0, 25 bits)) || (hi === U((BigInt(1) << 25) - 1, 25 bits))
    }
  }

  // ---- TLB ----
  val tlbValid = Vec.fill(TLB_N)(RegInit(False))
  val tlbVpn = Vec.fill(TLB_N)(RegInit(U(0, 27 bits)))
  val tlbPpn = Vec.fill(TLB_N)(RegInit(U(0, 44 bits)))
  val tlbPerm = Vec.fill(TLB_N)(RegInit(B(0, 4 bits))) // U,X,W,R
  val tlbDirty = Vec.fill(TLB_N)(RegInit(False))

  def tlbLookup(v: UInt, access: UInt): (Bool, UInt) = {
    val idx = v(15 downto 12)
    val vpn = v(38 downto 12)
    val entry = tlbValid(idx) && (tlbVpn(idx) === vpn)
    val perm = tlbPerm(idx)
    val needR = access(0)
    val needW = access(1)
    val needX = !access(0) && !access(1)
    // Svade: a store also needs the PTE dirty bit; A was checked at fill time.
    val permOk = (!needR || perm(0)) && (!needW || (perm(1) && tlbDirty(idx))) &&
      (!needX || perm(2))
    val privOk = Mux(io.priv === MODE_U, perm(3),
      Mux(io.priv === MODE_S, !perm(3) || (io.sum && needR && !needW), True))
    (entry && permOk && privOk, tlbPpn(idx))
  }

  // ---- Fault registers (tagged by virtual address) ----
  val iFaultValid = RegInit(False)
  val iFaultVaddr = Reg(UInt(xlen bits)) init U(0)
  val dFaultValid = RegInit(False)
  val dFaultVaddr = Reg(UInt(xlen bits)) init U(0)

  val iFaultMatch = iFaultValid && (iFaultVaddr === io.iVaddr)
  val dFaultMatch = dFaultValid && (dFaultVaddr === io.dVaddr)
  io.iFault := io.enable && iFaultMatch
  io.dFault := io.enable && dFaultMatch

  // ---- Lookup (combinational) ----
  val (iEntryOk, iPpn) = tlbLookup(io.iVaddr, U(0, 2 bits))
  val (dEntryOk, dPpn) = tlbLookup(io.dVaddr, io.dAccess)
  val iHitRaw = canonical(io.iVaddr) && iEntryOk
  val dHitRaw = canonical(io.dVaddr) && dEntryOk
  io.iHit := !io.enable || iHitRaw
  io.dHit := !io.enable || dHitRaw
  io.iPaddr := Mux(io.enable, Cat(iPpn, io.iVaddr(11 downto 0)).asUInt, io.iVaddr)
  io.dPaddr := Mux(io.enable, Cat(dPpn, io.dVaddr(11 downto 0)).asUInt, io.dVaddr)

  // ---- Page-table walker ----
  object St extends SpinalEnum {
    val IDLE, REQ, EVAL = newElement()
  }
  val state = RegInit(St.IDLE)
  val isData = RegInit(False)
  val walkLevel: UInt = RegInit(U(0, 2 bits))
  val basePpn: UInt = RegInit(U(0, 44 bits))
  val vpnReg: UInt = RegInit(U(0, 27 bits))
  val accessReg: UInt = RegInit(U(0, 2 bits))
  val pteReg: Bits = RegInit(B(0, 64 bits))

  val iNeedWalk = io.iValid && io.enable && canonical(io.iVaddr) &&
    !iHitRaw && !iFaultMatch
  val dNeedWalk = io.dValid && io.enable && canonical(io.dVaddr) &&
    !dHitRaw && !dFaultMatch

  // Data accesses are older than an in-flight fetch, so they walk first.
  when(state === St.IDLE) {
    when(dNeedWalk) {
      isData := True
      vpnReg := io.dVaddr(38 downto 12)
      accessReg := io.dAccess
      basePpn := io.ppn
      walkLevel := U(2, 2 bits)
      state := St.REQ
    } elsewhen (iNeedWalk) {
      isData := False
      vpnReg := io.iVaddr(38 downto 12)
      accessReg := U(0, 2 bits)
      basePpn := io.ppn
      walkLevel := U(2, 2 bits)
      state := St.REQ
    }
  }

  val vpnSel = UInt(9 bits)
  switch(walkLevel) {
    is(U(0, 2 bits)) { vpnSel := vpnReg(8 downto 0) }
    is(U(1, 2 bits)) { vpnSel := vpnReg(17 downto 9) }
    default { vpnSel := vpnReg(26 downto 18) }
  }

  io.ptwValid := state === St.REQ
  io.ptwAddr := Cat(basePpn, vpnSel, U(0, 3 bits)).resize(xlen).asUInt

  // ---- PTE evaluation ----
  val pteValid = pteReg(0)
  val pteR = pteReg(1)
  val pteW = pteReg(2)
  val pteX = pteReg(3)
  val pteU = pteReg(4)
  val pteA = pteReg(6)
  val pteD = pteReg(7)
  val ptePpn: UInt = pteReg(53 downto 10).asUInt
  val pteUpperBad = pteReg(63 downto 54) =/= B(0, 10 bits)
  val leaf = pteR || pteX
  val wrNoR = pteW && !pteR
  val superBad = (walkLevel === U(1, 2 bits) && ptePpn(8 downto 0) =/= U(0, 9 bits)) ||
    (walkLevel === U(2, 2 bits) && ptePpn(17 downto 0) =/= U(0, 18 bits))
  val needW = accessReg(1)
  val needR = accessReg(0)
  val accessOk = (!needR || pteR) && (!needW || pteW) && (needR || needW || pteX)
  val privOk = Mux(io.priv === MODE_U, pteU,
    Mux(io.priv === MODE_S, !pteU || (io.sum && needR && !needW), True))
  val adOk = pteA && (!needW || pteD)
  val leafFault = !accessOk || !privOk || !adOk || pteUpperBad || superBad
  val walkFault = !pteValid || wrNoR || (leaf && leafFault) || (!leaf && walkLevel === U(0, 2 bits))

  val targetVaddr = Mux(isData, io.dVaddr, io.iVaddr)
  val finalPpn = UInt(44 bits)
  switch(walkLevel) {
    is(U(0, 2 bits)) { finalPpn := ptePpn }
    is(U(1, 2 bits)) { finalPpn := Cat(ptePpn(43 downto 9), targetVaddr(29 downto 21)).asUInt }
    default { finalPpn := Cat(ptePpn(43 downto 18), targetVaddr(38 downto 30), targetVaddr(29 downto 21)).asUInt }
  }

  val tlbIdx = targetVaddr(15 downto 12)
  val perm = Cat(pteU, pteX, pteW, pteR) // bit3=U, bit2=X, bit1=W, bit0=R

  when(state === St.REQ) {
    pteReg := io.ptwData
    state := St.EVAL
  }
  when(state === St.EVAL) {
    when(walkFault) {
      when(isData) {
        dFaultValid := True
        dFaultVaddr := io.dVaddr
      } otherwise {
        iFaultValid := True
        iFaultVaddr := io.iVaddr
      }
      state := St.IDLE
    } elsewhen (leaf) {
      tlbValid(tlbIdx) := True
      tlbVpn(tlbIdx) := vpnReg
      tlbPpn(tlbIdx) := finalPpn
      tlbPerm(tlbIdx) := perm
      tlbDirty(tlbIdx) := pteD
      state := St.IDLE
    } otherwise {
      basePpn := ptePpn
      walkLevel := walkLevel - 1
      state := St.REQ
    }
  }

  // ---- Flush / stale fault clearing (last connect wins) ----
  when(iFaultValid && !iFaultMatch) { iFaultValid := False }
  when(dFaultValid && !dFaultMatch) { dFaultValid := False }
  when(io.flush) {
    for (i <- 0 until TLB_N) {
      tlbValid(i) := False
    }
    iFaultValid := False
    dFaultValid := False
    state := St.IDLE
  }
}
