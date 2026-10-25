package rv32c.core

import spinal.core._
import rv32c.isa._

/** CSR file for the Zicsr/M/S/U privilege subset.
  *
  * Machine CSRs:
  *   mstatus(0x300) mscratch(0x340) mepc(0x341) mcause(0x342) mtval(0x343)
  *   mie(0x304)     mtvec(0x305)    medeleg(0x302) mideleg(0x303)   (RW)
  *   misa(0x301)    mip(0x344)    mhartid(0xF14)                    (RO)
  *
  * Supervisor CSRs (only present with S mode):
  *   sstatus(0x100) sie(0x104) stvec(0x105) sscratch(0x140) sepc(0x141)
  *   scause(0x142)  stval(0x143) satp(0x180)                        (RW)
  *   sip(0x144)                                                     (RO)
  *
  * sstatus is a view of mstatus; sie is a view of mie restricted to the
  * supervisor interrupt bits and sip mirrors mip with no writable bits. satp is
  * WARL with translation disabled: the MODE field is forced to BARE and the
  * ASID/PPN fields are stored unchanged.
  *
  * curMode tracks M(3)/S(1)/U(0), reset to M. Writes are WARL-masked; read of an
  * unimplemented address returns 0 (access fault detection happens in EX).
  *
  * Ports:
  *   csrAddr/csrOp/csrWe/csrWrData : WB normal write access (old value on rdData)
  *   trapEna/trapToS/trapEpc/trapCause/trapTval : trap state commit; a trap to S
  *       updates SPP/SPIE/SIE and sepc/scause/stval, a trap to M updates
  *       MPP/MPIE/MIE and mepc/mcause/mtval
  *   mretEna : MIE<-MPIE, MPIE<-1, MPP<-M, curMode<-MPP
  *   sretEna : SIE<-SPIE, SPIE<-1, SPP<-U, curMode<-SPP
  *   Control readouts for EX/trap logic and debug are outputs.
  */
class CsrFile(xlen: Int, hartId: Int, isa: IsaConfig) extends Component {
  val io = new Bundle {
    val timerInterrupt = in Bool()
    // ---- WB normal CSR instruction port ----
    val csrAddr = in UInt(12 bits)
    val csrOp = in(CsrOp())
    val csrWe = in Bool()
    val csrWrData = in Bits(xlen bits)
    val rdData = out Bits(xlen bits)
    // ---- trap / mret / sret commit ----
    val trapEna = in Bool()
    val trapToS = in Bool()
    val trapEpc = in UInt(xlen bits)
    val trapCause = in Bits(xlen bits)
    val trapTval = in Bits(xlen bits)
    val mretEna = in Bool()
    val sretEna = in Bool()
    // Zicntr: one retired (committed) instruction this cycle.
    val retire = in Bool()
    // FP: an FP instruction (or FP CSR write) committed this cycle -> FS <- Dirty.
    val fpDirty = in Bool()
    // FP: accrued exception flags from a committed FP instruction (sticky OR).
    val fpFlagsWe = in Bool()
    val fpFlags = in Bits(5 bits)
    // ---- control readouts ----
    val curMode = out UInt(2 bits)
    val mstatusMie = out Bool()
    val mstatusMpp = out UInt(2 bits)
    val mstatusSpp = out Bool()
    val mstatusFs = out UInt(2 bits)
    val frm = out Bits(3 bits)
    val mieMtie = out Bool()
    val mieStie = out Bool()
    val mtvec = out Bits(xlen bits)
    val mepc = out UInt(xlen bits)
    val medeleg = out Bits(xlen bits)
    val mideleg = out Bits(xlen bits)
    val stvec = out Bits(xlen bits)
    val sepc = out UInt(xlen bits)
    val mstatusSie = out Bool()
    // Zicntr: mcounteren/scounteren enable bits (CY/TM/IR order).
    val counterEnM = out Bits(3 bits)
    val counterEnS = out Bits(3 bits)
    // ---- debug readouts ----
    val debugMepc = out UInt(xlen bits)
    val debugMcause = out Bits(xlen bits)
    val debugMode = out UInt(2 bits)
  }

  private val MODE_M = U(3, 2 bits)
  private val MODE_S = U(1, 2 bits)
  private val MODE_U = U(0, 2 bits)

  private val hasSupervisor = isa.priv.hasSupervisor

  // ---- Storage ----
  val mstatusReg = Reg(Bits(xlen bits)) init B(0, xlen bits)
  val mieReg = Reg(Bits(xlen bits)) init B(0, xlen bits)
  val mtvecReg = Reg(Bits(xlen bits)) init B(0, xlen bits)
  val mscratchReg = Reg(Bits(xlen bits)) init B(0, xlen bits)
  val mepcReg = Reg(Bits(xlen bits)) init B(0, xlen bits)
  val mcauseReg = Reg(Bits(xlen bits)) init B(0, xlen bits)
  val mtvalReg = Reg(Bits(xlen bits)) init B(0, xlen bits)
  val medelegReg = Reg(Bits(xlen bits)) init B(0, xlen bits)
  val midelegReg = Reg(Bits(xlen bits)) init B(0, xlen bits)
  val curModeReg = Reg(UInt(2 bits)) init MODE_M
  // Supervisor state; instantiated only when the stack contains S mode.
  val stvecReg = if (hasSupervisor) Some(Reg(Bits(xlen bits)) init B(0, xlen bits)) else None
  val sscratchReg = if (hasSupervisor) Some(Reg(Bits(xlen bits)) init B(0, xlen bits)) else None
  val sepcReg = if (hasSupervisor) Some(Reg(Bits(xlen bits)) init B(0, xlen bits)) else None
  val scauseReg = if (hasSupervisor) Some(Reg(Bits(xlen bits)) init B(0, xlen bits)) else None
  val stvalReg = if (hasSupervisor) Some(Reg(Bits(xlen bits)) init B(0, xlen bits)) else None
  val satpReg = if (hasSupervisor) Some(Reg(Bits(xlen bits)) init B(0, xlen bits)) else None
  // Zicntr counters (64-bit internal so RV32 can expose high halves) and the
  // counter-enable registers. cycle/time share the same clock source.
  val cycleCnt = if (isa.hasZicntr) Some(Reg(UInt(64 bits)) init U(0, 64 bits)) else None
  val instretCnt = if (isa.hasZicntr) Some(Reg(UInt(64 bits)) init U(0, 64 bits)) else None
  val mcounterenReg = if (isa.hasZicntr) Some(Reg(Bits(3 bits)) init B(0, 3 bits)) else None
  val scounterenReg = if (isa.hasZicntr && hasSupervisor) Some(Reg(Bits(3 bits)) init B(0, 3 bits)) else None
  // FP CSRs; only meaningful (and only wired) when the hart has an FPU.
  val fflagsReg = Reg(Bits(5 bits)) init B(0, 5 bits)
  val frmReg = Reg(Bits(3 bits)) init B(0, 3 bits)

  // misa is read-only and comes from the ISA configuration: MXL (by xlen) +
  // I base + enabled extension letters + U/S capability bits (see IsaConfig).
  // mhartid is a constant. Neither goes through the write port.

  // Writable masks (WARL). mstatus carries the M fields plus the S fields used
  // by sstatus (SIE/SPIE/SPP/SD-relevant FS/SUM/MXR) so both views share storage.
  private def mstatusMask: BigInt =
    (3 << 13) | (1 << 12) | (1 << 11) | (1 << 8) | (1 << 7) | (1 << 5) |
      (1 << 3) | (1 << 1) | (1 << 18) | (1 << 19)
  // Bits writable through the sstatus view.
  private def sstatusMask: BigInt =
    (3 << 13) | (1 << 8) | (1 << 5) | (1 << 1) | (1 << 18) | (1 << 19)
  // MTIP (7) plus the supervisor interrupt-pending/enable bits (SSIE/STIE/SEIE).
  private def sieMask: BigInt = (1 << 1) | (1 << 5) | (1 << 7) | (1 << 9)
  private val mieMask: BigInt = (1 << 1) | (1 << 5) | (1 << 7) | (1 << 9)
  // Exception causes this hart can delegate: instruction address-misaligned,
  // illegal instruction, breakpoint, load/store misaligned, ecall from U/S.
  private val medelegMask: BigInt =
    (1 << 0) | (1 << 2) | (1 << 3) | (1 << 4) | (1 << 6) | (1 << 8) | (1 << 9)
  // Only the machine timer interrupt has a source in this platform.
  private val midelegMask: BigInt = 1 << 7

  // ---- Combinational read (returns the current value for a CSR address) ----
  val readData = Bits(xlen bits)
  // mip: bit7 (MTIP) mirrors the external timer interrupt line, all other bits 0.
  val mipBits = Bits(xlen bits)
  mipBits := (B(0, xlen - 8 bits) ## io.timerInterrupt.asBits ## B(0, 7 bits))
  switch(io.csrAddr) {
    is(U(0x300, 12 bits)) { readData := mstatusReg }
    is(U(0x301, 12 bits)) { readData := B(isa.misaValue, xlen bits) }
    is(U(0x302, 12 bits)) { readData := medelegReg }
    is(U(0x303, 12 bits)) { readData := midelegReg }
    is(U(0x304, 12 bits)) { readData := mieReg }
    is(U(0x305, 12 bits)) { readData := mtvecReg }
    is(U(0x340, 12 bits)) { readData := mscratchReg }
    is(U(0x341, 12 bits)) { readData := mepcReg }
    is(U(0x342, 12 bits)) { readData := mcauseReg }
    is(U(0x343, 12 bits)) { readData := mtvalReg }
    is(U(0x344, 12 bits)) { readData := mipBits }
    is(U(0xF14, 12 bits)) { readData := B(hartId, xlen bits) }
    default { readData := B(0, xlen bits) }
  }
  if (hasSupervisor) {
    val sstatus = mstatusReg
    val sstatusView = Bits(xlen bits)
    sstatusView := B(0, xlen bits)
    sstatusView(1) := sstatus(1)                 // SIE
    sstatusView(5) := sstatus(5)                 // SPIE
    sstatusView(8) := sstatus(8)                 // SPP
    sstatusView(14 downto 13) := sstatus(14 downto 13) // FS
    sstatusView(18) := sstatus(18)               // SUM
    sstatusView(19) := sstatus(19)               // MXR
    // UXL is WARL with a single legal value matching the hart's xlen.
    if (xlen == 64) { sstatusView(33 downto 32) := B"10" }
    when(io.csrAddr === U(0x100, 12 bits)) { readData := sstatusView }
    when(io.csrAddr === U(0x104, 12 bits)) { readData := mieReg & B(sieMask, xlen bits) }
    when(io.csrAddr === U(0x105, 12 bits)) { readData := stvecReg.get }
    when(io.csrAddr === U(0x140, 12 bits)) { readData := sscratchReg.get }
    when(io.csrAddr === U(0x141, 12 bits)) { readData := sepcReg.get }
    when(io.csrAddr === U(0x142, 12 bits)) { readData := scauseReg.get }
    when(io.csrAddr === U(0x143, 12 bits)) { readData := stvalReg.get }
    when(io.csrAddr === U(0x144, 12 bits)) { readData := mipBits & B(sieMask, xlen bits) }
    when(io.csrAddr === U(0x180, 12 bits)) { readData := satpReg.get }
  }
  // Zicntr CSRs: read-only counters plus the counter-enable registers.
  if (isa.hasZicntr) {
    val cyc = cycleCnt.get
    val ir = instretCnt.get
    val me = mcounterenReg.get
    if (xlen == 32) {
      when(io.csrAddr === U(0xB00, 12 bits)) { readData := cyc(31 downto 0).asBits }
      when(io.csrAddr === U(0xB02, 12 bits)) { readData := ir(31 downto 0).asBits }
      when(io.csrAddr === U(0xB80, 12 bits)) { readData := cyc(63 downto 32).asBits }
      when(io.csrAddr === U(0xB82, 12 bits)) { readData := ir(63 downto 32).asBits }
      when(io.csrAddr === U(0xC00, 12 bits)) { readData := cyc(31 downto 0).asBits }
      when(io.csrAddr === U(0xC01, 12 bits)) { readData := cyc(31 downto 0).asBits }
      when(io.csrAddr === U(0xC02, 12 bits)) { readData := ir(31 downto 0).asBits }
      when(io.csrAddr === U(0xC80, 12 bits)) { readData := cyc(63 downto 32).asBits }
      when(io.csrAddr === U(0xC81, 12 bits)) { readData := cyc(63 downto 32).asBits }
      when(io.csrAddr === U(0xC82, 12 bits)) { readData := ir(63 downto 32).asBits }
    } else {
      when(io.csrAddr === U(0xB00, 12 bits)) { readData := cyc.asBits }
      when(io.csrAddr === U(0xB02, 12 bits)) { readData := ir.asBits }
      when(io.csrAddr === U(0xC00, 12 bits)) { readData := cyc.asBits }
      when(io.csrAddr === U(0xC01, 12 bits)) { readData := cyc.asBits }
      when(io.csrAddr === U(0xC02, 12 bits)) { readData := ir.asBits }
    }
    when(io.csrAddr === U(0x306, 12 bits)) { readData := me.resize(xlen) }
    if (hasSupervisor) {
      when(io.csrAddr === U(0x106, 12 bits)) { readData := scounterenReg.get.resize(xlen) }
    }
  }
  // FP CSRs (present only with an FPU). fcsr = frm[7:5] | fflags[4:0].
  if (isa.hasFpu) {
    when(io.csrAddr === U(0x001, 12 bits)) { readData := fflagsReg.resize(xlen) }
    when(io.csrAddr === U(0x002, 12 bits)) { readData := frmReg.resize(xlen) }
    when(io.csrAddr === U(0x003, 12 bits)) { readData := (frmReg ## fflagsReg).resize(xlen) }
  }
  io.rdData := readData

  // ---- Next-value helpers (priority: WB normal write, then trap/mret/sret) ----
  val wbActive = io.csrWe && io.csrOp =/= CsrOp.NONE

  def maskedNext(cur: Bits, raw: Bits, mask: BigInt): Bits = {
    val ones = (BigInt(1) << xlen) - 1
    val m = B(mask & ones, xlen bits)
    (cur & ~m) | (raw & m)
  }

  // newVal depends on CSR-style op against the *pre-write* read value.
  val opNew = Bits(xlen bits)
  switch(io.csrOp) {
    is(CsrOp.WRITE) { opNew := io.csrWrData }
    is(CsrOp.SET) { opNew := readData | io.csrWrData }
    is(CsrOp.CLEAR) { opNew := readData & ~io.csrWrData }
    default { opNew := io.csrWrData }
  }

  def wbHit(addr: BigInt): Bool = wbActive && io.csrAddr === U(addr, 12 bits)

  // ---- mstatus: apply WB write (through either view) then trap/mret/sret ----
  val mstatusPostWb = Bits(xlen bits)
  when(wbHit(0x300)) {
    mstatusPostWb := maskedNext(mstatusReg, opNew, mstatusMask)
  } elsewhen (if (hasSupervisor) wbHit(0x100) else False) {
    mstatusPostWb := maskedNext(mstatusReg, opNew, sstatusMask)
  } otherwise {
    mstatusPostWb := mstatusReg
  }
  val mstatusNext = Bits(xlen bits)
  when(io.trapEna) {
    mstatusNext := mstatusPostWb
    when(io.trapToS) {
      mstatusNext(8) := curModeReg(0)      // SPP <- source mode (U=0, S=1)
      mstatusNext(5) := mstatusPostWb(1)   // SPIE <- SIE
      mstatusNext(1) := False              // SIE <- 0
    } otherwise {
      mstatusNext(7) := mstatusPostWb(3)   // MPIE <- MIE
      mstatusNext(3) := False              // MIE <- 0
      mstatusNext(12 downto 11) := curModeReg.asBits // MPP <- source mode
    }
  } elsewhen (io.mretEna) {
    mstatusNext := mstatusPostWb
    mstatusNext(3) := mstatusPostWb(7)     // MIE <- MPIE
    mstatusNext(7) := True                 // MPIE <- 1
    mstatusNext(12 downto 11) := MODE_M.asBits    // MPP <- M (minimal U rule, R5.3)
  } elsewhen (io.sretEna) {
    mstatusNext := mstatusPostWb
    mstatusNext(1) := mstatusPostWb(5)     // SIE <- SPIE
    mstatusNext(5) := True                 // SPIE <- 1
    mstatusNext(8) := False                // SPP <- U
  } otherwise {
    mstatusNext := mstatusPostWb
  }
  // Committing an FP instruction leaves the FP state dirty.
  if (isa.hasFpu) {
    when(io.fpDirty) { mstatusNext(14 downto 13) := B"11" }
  }

  // ---- curMode: M/S on trap; MRET restores the *pre-update* MPP, SRET the
  // pre-update SPP. ----
  val curModeNext = UInt(2 bits)
  when(io.trapEna) {
    curModeNext := Mux(io.trapToS, MODE_S, MODE_M)
  } elsewhen (io.mretEna) {
    curModeNext := mstatusPostWb(12 downto 11).asUInt
  } elsewhen (io.sretEna) {
    curModeNext := Mux(mstatusPostWb(8), MODE_S, MODE_U)
  } otherwise {
    curModeNext := curModeReg
  }

  // ---- mepc/mcause/mtval: WB write then trap overwrite ----
  def epcMaskedNext(cur: Bits): Bits = {
    val b = Bits(xlen bits)
    when(wbHit(0x341)) { b := opNew } otherwise { b := cur }
    b
  }
  val mepcNext = Bits(xlen bits)
  mepcNext := epcMaskedNext(mepcReg)
  when(io.trapEna && !io.trapToS) { mepcNext := io.trapEpc.asBits }

  val mcauseNext = Bits(xlen bits)
  when(wbHit(0x342)) { mcauseNext := opNew } otherwise { mcauseNext := mcauseReg }
  when(io.trapEna && !io.trapToS) { mcauseNext := io.trapCause }

  val mtvalNext = Bits(xlen bits)
  when(wbHit(0x343)) { mtvalNext := opNew } otherwise { mtvalNext := mtvalReg }
  when(io.trapEna && !io.trapToS) { mtvalNext := io.trapTval }

  // ---- other RW CSRs (WB only, no trap interaction) ----
  val mieNext = Bits(xlen bits)
  mieNext := mieReg
  when(wbHit(0x304)) { mieNext := maskedNext(mieReg, opNew, mieMask) }
  if (hasSupervisor) {
    when(wbHit(0x104)) { mieNext := maskedNext(mieReg, opNew, sieMask) }
  }

  val mtvecNext = Bits(xlen bits)
  when(wbHit(0x305)) {
    // force MODE field to 0 (BASE writes accepted); nonzero-mode writes are
    // rejected as illegal in EX and never reach WB.
    mtvecNext := maskedNext(mtvecReg, opNew, ~BigInt(3))
  } otherwise {
    mtvecNext := mtvecReg
  }

  val mscratchNext = Bits(xlen bits)
  when(wbHit(0x340)) { mscratchNext := opNew } otherwise { mscratchNext := mscratchReg }

  val mcounterenNext = Bits(3 bits)
  val scounterenNext = Bits(3 bits)
  if (isa.hasZicntr) {
    mcounterenNext := mcounterenReg.get
    when(wbHit(0x306)) { mcounterenNext := opNew(2 downto 0) }
    if (hasSupervisor) {
      scounterenNext := scounterenReg.get
      when(wbHit(0x106)) { scounterenNext := opNew(2 downto 0) }
    } else {
      scounterenNext := B(0, 3 bits)
    }
  } else {
    mcounterenNext := B(0, 3 bits)
    scounterenNext := B(0, 3 bits)
  }

  val medelegNext = Bits(xlen bits)
  when(wbHit(0x302)) { medelegNext := maskedNext(medelegReg, opNew, medelegMask) } otherwise {
    medelegNext := medelegReg
  }

  val midelegNext = Bits(xlen bits)
  when(wbHit(0x303)) { midelegNext := maskedNext(midelegReg, opNew, midelegMask) } otherwise {
    midelegNext := midelegReg
  }

  // ---- Supervisor CSRs ----
  val stvecNext = Bits(xlen bits)
  val sscratchNext = Bits(xlen bits)
  val sepcNext = Bits(xlen bits)
  val scauseNext = Bits(xlen bits)
  val stvalNext = Bits(xlen bits)
  val satpNext = Bits(xlen bits)
  if (hasSupervisor) {
    stvecNext := stvecReg.get
    when(wbHit(0x105)) {
      stvecNext := maskedNext(stvecReg.get, opNew, ~BigInt(3))
    }
    sscratchNext := sscratchReg.get
    when(wbHit(0x140)) { sscratchNext := opNew }

    sepcNext := sepcReg.get
    when(wbHit(0x141)) { sepcNext := opNew }
    when(io.trapEna && io.trapToS) { sepcNext := io.trapEpc.asBits }

    scauseNext := scauseReg.get
    when(wbHit(0x142)) { scauseNext := opNew }
    when(io.trapEna && io.trapToS) { scauseNext := io.trapCause }

    stvalNext := stvalReg.get
    when(wbHit(0x143)) { stvalNext := opNew }
    when(io.trapEna && io.trapToS) { stvalNext := io.trapTval }

    // satp: address translation is not implemented, so MODE is WARL forced to
    // BARE while ASID/PPN are stored unchanged.
    val modeMask: BigInt = if (xlen == 32) BigInt(1) << 31 else BigInt(0xF) << 60
    val dataMask: BigInt = ((BigInt(1) << xlen) - 1) & ~modeMask
    satpNext := satpReg.get
    when(wbHit(0x180)) { satpNext := maskedNext(satpReg.get, opNew, dataMask) }
  } else {
    stvecNext := B(0, xlen bits)
    sscratchNext := B(0, xlen bits)
    sepcNext := B(0, xlen bits)
    scauseNext := B(0, xlen bits)
    stvalNext := B(0, xlen bits)
    satpNext := B(0, xlen bits)
  }

  // ---- FP CSRs: fflags(0x001) / frm(0x002) / fcsr(0x003) ----
  val fflagsNext = Bits(5 bits)
  val frmNext = Bits(3 bits)
  if (isa.hasFpu) {
    frmNext := frmReg
    when(wbHit(0x002)) { frmNext := opNew(7 downto 5) }
    when(wbHit(0x003)) { frmNext := opNew(7 downto 5) }
    // Exception flags from a committing FP instruction accumulate (sticky).
    // Combine with the register/CSR write via a pure expression to avoid a
    // self-referential combinational assignment on fflagsNext.
    val fflagsCsr = Mux(wbHit(0x003) || wbHit(0x001), opNew(4 downto 0), fflagsReg)
    fflagsNext := Mux(io.fpFlagsWe, fflagsCsr | io.fpFlags, fflagsCsr)
  } else {
    fflagsNext := fflagsReg
    frmNext := frmReg
  }

  // ---- Register updates ----
  mstatusReg := mstatusNext
  mieReg := mieNext
  mtvecReg := mtvecNext
  mscratchReg := mscratchNext
  mepcReg := mepcNext
  mcauseReg := mcauseNext
  mtvalReg := mtvalNext
  medelegReg := medelegNext
  midelegReg := midelegNext
  curModeReg := curModeNext
  if (hasSupervisor) {
    stvecReg.get := stvecNext
    sscratchReg.get := sscratchNext
    sepcReg.get := sepcNext
    scauseReg.get := scauseNext
    stvalReg.get := stvalNext
    satpReg.get := satpNext
  }
  fflagsReg := fflagsNext
  frmReg := frmNext
  if (isa.hasZicntr) {
    cycleCnt.get := cycleCnt.get + 1
    when(io.retire) { instretCnt.get := instretCnt.get + 1 }
    // mcycle/minstret write aliases override the free-running increment.
    if (xlen == 32) {
      when(wbHit(0xB00)) { cycleCnt.get := Cat(cycleCnt.get(63 downto 32), opNew(31 downto 0)).asUInt }
      when(wbHit(0xB80)) { cycleCnt.get := Cat(opNew(31 downto 0), cycleCnt.get(31 downto 0)).asUInt }
      when(wbHit(0xB02)) { instretCnt.get := Cat(instretCnt.get(63 downto 32), opNew(31 downto 0)).asUInt }
      when(wbHit(0xB82)) { instretCnt.get := Cat(opNew(31 downto 0), instretCnt.get(31 downto 0)).asUInt }
    } else {
      when(wbHit(0xB00)) { cycleCnt.get := opNew.asUInt }
      when(wbHit(0xB02)) { instretCnt.get := opNew.asUInt }
    }
    mcounterenReg.get := mcounterenNext
    if (hasSupervisor) { scounterenReg.get := scounterenNext }
  }

  // ---- Readouts ----
  io.curMode := curModeReg
  io.mstatusMie := mstatusReg(3)
  io.mstatusMpp := mstatusReg(12 downto 11).asUInt
  io.mstatusSpp := mstatusReg(8)
  io.mstatusFs := mstatusReg(14 downto 13).asUInt
  io.frm := frmReg
  io.mieMtie := mieReg(7)
  io.mieStie := mieReg(5)
  io.mtvec := mtvecReg
  io.mepc := mepcReg.asUInt
  io.medeleg := medelegReg
  io.mideleg := midelegReg
  io.mstatusSie := mstatusReg(1)
  if (isa.hasZicntr) {
    io.counterEnM := mcounterenReg.get
  } else {
    io.counterEnM := B(0, 3 bits)
  }
  if (isa.hasZicntr && hasSupervisor) {
    io.counterEnS := scounterenReg.get
  } else {
    io.counterEnS := B(0, 3 bits)
  }
  if (hasSupervisor) {
    io.stvec := stvecReg.get
    io.sepc := sepcReg.get.asUInt
  } else {
    io.stvec := B(0, xlen bits)
    io.sepc := U(0, xlen bits)
  }
  io.debugMepc := mepcReg.asUInt
  io.debugMcause := mcauseReg
  io.debugMode := curModeReg
}
