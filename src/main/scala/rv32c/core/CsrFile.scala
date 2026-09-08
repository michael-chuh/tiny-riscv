package rv32c.core

import spinal.core._

/** Machine-level CSR file for the minimal Zicsr/M-U privilege subset.
  *
  * Implemented CSRs (see specs/zicsr-exceptions/requirements.md R2):
  *   mstatus(0x300) mscratch(0x340) mepc(0x341) mcause(0x342) mtval(0x343)
  *   mie(0x304)     mtvec(0x305)                        (RW, writable-bit masked)
  *   misa(0x301)    mip(0x344)    mhartid(0xF14)        (RO)
  *
  * curMode tracks M(3)/U(0), reset to M. Writes are WARL-masked; read of an
  * unimplemented address returns 0 (access fault detection happens in EX).
  *
  * Ports:
  *   csrAddr/csrOp/csrWe/csrWrData : WB normal write access (old value on rdData)
  *   trapEna/trapEpc/trapCause/trapTval : trap state commit (mepc/mcause/mtval,
  *       MPIE<-MIE, MIE<-0, MPP<-curMode, curMode<-M)
  *   mretEna : MIE<-MPIE, MPIE<-1, MPP<-M, curMode<-MPP
  *   Control readouts for EX/trap logic and debug are outputs.
  */
class CsrFile(xlen: Int, hartId: Int) extends Component {
  val io = new Bundle {
    val timerInterrupt = in Bool()
    // ---- WB normal CSR instruction port ----
    val csrAddr = in UInt(12 bits)
    val csrOp = in(CsrOp())
    val csrWe = in Bool()
    val csrWrData = in Bits(xlen bits)
    val rdData = out Bits(xlen bits)
    // ---- trap / mret commit ----
    val trapEna = in Bool()
    val trapEpc = in UInt(xlen bits)
    val trapCause = in Bits(xlen bits)
    val trapTval = in Bits(xlen bits)
    val mretEna = in Bool()
    // ---- control readouts ----
    val curMode = out UInt(2 bits)
    val mstatusMie = out Bool()
    val mstatusMpp = out UInt(2 bits)
    val mieMtie = out Bool()
    val mtvec = out Bits(xlen bits)
    val mepc = out UInt(xlen bits)
    // ---- debug readouts ----
    val debugMepc = out UInt(xlen bits)
    val debugMcause = out Bits(xlen bits)
    val debugMode = out UInt(2 bits)
  }

  private val MODE_M = U(3, 2 bits)
  private val MODE_U = U(0, 2 bits)

  // ---- Storage ----
  val mstatusReg = Reg(Bits(xlen bits)) init B(0, xlen bits)
  val mieReg = Reg(Bits(xlen bits)) init B(0, xlen bits)
  val mtvecReg = Reg(Bits(xlen bits)) init B(0, xlen bits)
  val mscratchReg = Reg(Bits(xlen bits)) init B(0, xlen bits)
  val mepcReg = Reg(Bits(xlen bits)) init B(0, xlen bits)
  val mcauseReg = Reg(Bits(xlen bits)) init B(0, xlen bits)
  val mtvalReg = Reg(Bits(xlen bits)) init B(0, xlen bits)
  val curModeReg = Reg(UInt(2 bits)) init MODE_M

  // misa: MXL=1 (RV32) + I/M/U bits; mhartid constant.
  val misaValue: BigInt = (BigInt(1) << 30) | (1 << 20) | (1 << 12) | (1 << 8)

  // Writable masks (WARL).
  private def mstatusMask: BigInt = (1 << 12) | (1 << 11) | (1 << 7) | (1 << 3)
  private def mieMask: BigInt = 1 << 7

  // ---- Combinational read (returns the current value for a CSR address) ----
  val readData = Bits(xlen bits)
  // mip: bit7 (MTIP) mirrors the external timer interrupt line, all other bits 0.
  val mipBits = Bits(xlen bits)
  mipBits := (B(0, xlen - 8 bits) ## io.timerInterrupt.asBits ## B(0, 7 bits))
  switch(io.csrAddr) {
    is(U(0x300, 12 bits)) { readData := mstatusReg }
    is(U(0x301, 12 bits)) { readData := B(misaValue, xlen bits) }
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
  io.rdData := readData

  // ---- Next-value helpers (priority: WB normal write, then trap/mret) ----
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

  // ---- mstatus: apply WB write then trap/mret field updates ----
  val mstatusPostWb = Bits(xlen bits)
  when(wbHit(0x300)) {
    mstatusPostWb := maskedNext(mstatusReg, opNew, mstatusMask)
  } otherwise {
    mstatusPostWb := mstatusReg
  }
  val mstatusNext = Bits(xlen bits)
  when(io.trapEna) {
    mstatusNext := mstatusPostWb
    mstatusNext(7) := mstatusPostWb(3) // MPIE <- MIE
    mstatusNext(3) := False            // MIE <- 0
    mstatusNext(12 downto 11) := curModeReg.asBits // MPP <- source mode
  } elsewhen (io.mretEna) {
    mstatusNext := mstatusPostWb
    mstatusNext(3) := mstatusPostWb(7)     // MIE <- MPIE
    mstatusNext(7) := True                 // MPIE <- 1
    mstatusNext(12 downto 11) := MODE_M.asBits    // MPP <- M (minimal U rule, R5.3)
  } otherwise {
    mstatusNext := mstatusPostWb
  }

  // ---- curMode: M on trap; on MRET restore the *pre-update* MPP (the mode the
  // trap came from), since the MRET state update below rewrites MPP to M. ----
  val curModeNext = UInt(2 bits)
  when(io.trapEna) {
    curModeNext := MODE_M
  } elsewhen (io.mretEna) {
    curModeNext := mstatusPostWb(12 downto 11).asUInt
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
  when(io.trapEna) { mepcNext := io.trapEpc.asBits }

  val mcauseNext = Bits(xlen bits)
  when(wbHit(0x342)) { mcauseNext := opNew } otherwise { mcauseNext := mcauseReg }
  when(io.trapEna) { mcauseNext := io.trapCause }

  val mtvalNext = Bits(xlen bits)
  when(wbHit(0x343)) { mtvalNext := opNew } otherwise { mtvalNext := mtvalReg }
  when(io.trapEna) { mtvalNext := io.trapTval }

  // ---- other RW CSRs (WB only, no trap interaction) ----
  val mieNext = Bits(xlen bits)
  when(wbHit(0x304)) { mieNext := maskedNext(mieReg, opNew, mieMask) } otherwise { mieNext := mieReg }

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

  // ---- Register updates ----
  mstatusReg := mstatusNext
  mieReg := mieNext
  mtvecReg := mtvecNext
  mscratchReg := mscratchNext
  mepcReg := mepcNext
  mcauseReg := mcauseNext
  mtvalReg := mtvalNext
  curModeReg := curModeNext

  // ---- Readouts ----
  io.curMode := curModeReg
  io.mstatusMie := mstatusReg(3)
  io.mstatusMpp := mstatusReg(12 downto 11).asUInt
  io.mieMtie := mieReg(7)
  io.mtvec := mtvecReg
  io.mepc := mepcReg.asUInt
  io.debugMepc := mepcReg.asUInt
  io.debugMcause := mcauseReg
  io.debugMode := curModeReg
}
