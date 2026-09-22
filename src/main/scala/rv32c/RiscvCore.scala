package rv32c

import spinal.core._
import spinal.lib._
import rv32c.bus._
import rv32c.core._
import rv32c.isa._

class IfIdBundle(xlen: Int) extends Bundle {
  val valid = Bool()
  val pc = UInt(xlen bits)
  val instruction = Bits(32 bits)
  val compressed = Bool()      // RV32C: instruction is 16 bits wide
}
object IfIdBundle {
  def zero(xlen: Int): IfIdBundle = {
    val b = new IfIdBundle(xlen)
    b.valid := False
    b.pc := U(0, xlen bits)
    b.instruction := B(0, 32 bits)
    b.compressed := False
    b
  }
}

class IdExBundle(xlen: Int) extends Bundle {
  val valid = Bool()
  val pc = UInt(xlen bits)
  val compressed = Bool()      // RV32C: instruction is 16 bits wide
  val regWrite = Bool()
  val aluSrc = Bool()
  val wbSel = UInt(3 bits)     // WbSel: ALU / MEM / PC4 / CSR
  val branch = Bool()
  val jump = Bool()
  val jalr = Bool()
  val aluOp = AluOp()
  val branchType = BranchOp()
  val aluASrc = UInt(2 bits)
  val memRead = Bool()
  val memWrite = Bool()
  val memSize = UInt(2 bits)
  val memSign = Bool()
  // --- A extension (LR/SC/AMO) ---
  val atomic = Bool()          // SC / AMO*: result is produced in MEM, not EX
  val isLr = Bool()
  val isSc = Bool()
  val amoOp = UInt(5 bits)     // funct5 for AMO*
  val rs1 = UInt(5 bits)
  val rs2 = UInt(5 bits)
  val rd = UInt(5 bits)
  val imm = SInt(xlen bits)
  // --- Zicsr / exception control ---
  val illegal = Bool()         // statically illegal instruction (decoder)
  val csrOp = CsrOp()          // NONE unless this is a CSR access
  val csrImm = Bool()          // immediate (CSRRW*I) form: operand is zimm
  val csrAddr = UInt(12 bits)  // CSR address (instr[31:20])
  val csrWe = Bool()           // instruction performs a CSR write
  val sysOp = SysOp()          // SYSTEM sub-op (ecall/ebreak/mret/wfi/illegal)
}
object IdExBundle {
  def zero(xlen: Int): IdExBundle = {
    val b = new IdExBundle(xlen)
    b.valid := False
    b.pc := U(0, xlen bits)
    b.compressed := False
    b.regWrite := False
    b.aluSrc := False
    b.wbSel := U(0, 3 bits)
    b.branch := False
    b.jump := False
    b.jalr := False
    b.aluOp := AluOp.ADD
    b.branchType := BranchOp.NONE
    b.aluASrc := U(0, 2 bits)
    b.memRead := False
    b.memWrite := False
    b.memSize := U(0, 2 bits)
    b.memSign := False
    b.atomic := False
    b.isLr := False
    b.isSc := False
    b.amoOp := U(0, 5 bits)
    b.rs1 := U(0, 5 bits)
    b.rs2 := U(0, 5 bits)
    b.rd := U(0, 5 bits)
    b.imm := S(0, xlen bits)
    b.illegal := False
    b.csrOp := CsrOp.NONE
    b.csrImm := False
    b.csrAddr := U(0, 12 bits)
    b.csrWe := False
    b.sysOp := SysOp.NONE
    b
  }
}

class ExMemBundle(xlen: Int) extends Bundle {
  val valid = Bool()
  val memRead = Bool()
  val memWrite = Bool()
  val memSize = UInt(2 bits)
  val memSign = Bool()
  // --- A extension (LR/SC/AMO) ---
  val atomic = Bool()
  val isLr = Bool()
  val isSc = Bool()
  val amoOp = UInt(5 bits)
  val regWrite = Bool()
  val rd = UInt(5 bits)
  val wbSel = UInt(3 bits)     // WbSel: ALU / MEM / PC4 / CSR
  val aluResult = Bits(xlen bits)
  val rs2Data = Bits(xlen bits)
  val csrOp = CsrOp()
  val csrWe = Bool()
  val csrAddr = UInt(12 bits)
  val csrWrData = Bits(xlen bits)
}
object ExMemBundle {
  def zero(xlen: Int): ExMemBundle = {
    val b = new ExMemBundle(xlen)
    b.valid := False
    b.memRead := False
    b.memWrite := False
    b.memSize := U(0, 2 bits)
    b.memSign := False
    b.atomic := False
    b.isLr := False
    b.isSc := False
    b.amoOp := U(0, 5 bits)
    b.regWrite := False
    b.rd := U(0, 5 bits)
    b.wbSel := U(0, 3 bits)
    b.aluResult := B(0, xlen bits)
    b.rs2Data := B(0, xlen bits)
    b.csrOp := CsrOp.NONE
    b.csrWe := False
    b.csrAddr := U(0, 12 bits)
    b.csrWrData := B(0, xlen bits)
    b
  }
}

class MemWbBundle(xlen: Int) extends Bundle {
  val valid = Bool()
  val regWrite = Bool()
  val rd = UInt(5 bits)
  val wbSel = UInt(3 bits)     // WbSel: ALU / MEM / PC4 / CSR
  val wbData = Bits(xlen bits)
  val csrOp = CsrOp()
  val csrWe = Bool()
  val csrAddr = UInt(12 bits)
  val csrWrData = Bits(xlen bits)
}
object MemWbBundle {
  def zero(xlen: Int): MemWbBundle = {
    val b = new MemWbBundle(xlen)
    b.valid := False
    b.regWrite := False
    b.rd := U(0, 5 bits)
    b.wbSel := U(0, 3 bits)
    b.wbData := B(0, xlen bits)
    b.csrOp := CsrOp.NONE
    b.csrWe := False
    b.csrAddr := U(0, 12 bits)
    b.csrWrData := B(0, xlen bits)
    b
  }
}

class RiscvCore(config: CoreConfig) extends Component {
  val io = new Bundle {
    val iBus = master(IBusInterface(config.xlen))
    val dBus = master(DBusInterface(config.xlen))
    val timerInterrupt = in Bool()
    val debugPc = out UInt(config.xlen bits)
    val debugRegs = out Vec(Bits(config.xlen bits), 32)
    val debugMepc = out UInt(config.xlen bits)
    val debugMcause = out Bits(config.xlen bits)
    val debugMode = out UInt(2 bits)
  }

  val xlen = config.xlen
  val MODE_U = U(PrivMode.U.encoding, 2 bits)
  val MODE_M = U(PrivMode.M.encoding, 2 bits)

  // ---- Capability check: which configurations this RTL can actually run ----
  require((config.isa.extensions -- RvExtension.implemented).isEmpty,
    s"extensions not implemented by this core: ${(config.isa.extensions -- RvExtension.implemented).toSeq.sorted.mkString(", ")}")
  require(config.isa.hasZicsr, "Zicsr decode is currently unconditional; it cannot be disabled")
  require(config.priv.hasUser, "rv32c implements the M/U stack (pure-M is not supported)")
  require(!config.priv.hasSupervisor && !config.priv.hasHypervisor,
    "S/H modes are roadmap features and are not implemented yet")

  // ===== Privilege-mode legality (configuration driven) =====
  // The configured stack is the authoritative set of encodings the hart may
  // hold or return to. This keeps MPP/MRET/ECALL checks correct when the stack
  // grows from M/U to M/S/U (roadmap).
  def modeSupported(enc: UInt): Bool = {
    val alternatives = config.priv.supportedEncodings.toSeq.sorted
    alternatives.map(e => enc === U(e, 2 bits)).reduceOption(_ || _).getOrElse(False)
  }

  /** Privilege check: is `curMode` at least as privileged as `req`? RISC-V
    * encodes higher privilege as a larger value, so a numeric compare works. */
  def privAtLeast(req: PrivMode): Bool = curMode >= U(req.encoding, 2 bits)

  /** Synchronous `mcause` code for an ECALL from `mode`. */
  def ecallCause(mode: UInt): UInt =
    Mux(mode === MODE_U, U(ExceptionCode.ecallFromU),
      Mux(mode === U(PrivMode.S.encoding, 2 bits), U(ExceptionCode.ecallFromS),
        U(ExceptionCode.ecallFromM)))

  // ===== Fetch stage =====
  // Without C, pcReg keeps its 4-byte granularity and a full word is delivered
  // each cycle. With C the PC is 2-byte granular: the bus always fetches the
  // aligned word and the core selects/splices halfwords. A 32-bit instruction
  // that starts at the upper halfword needs one extra cycle to latch the high
  // half and fetch the next word; that cycle presents itself as a fetch stall.
  val withCompressed = config.isa.hasCompressed
  val withAtomic = config.isa.hasAtomic
  val pcReg = RegInit(U(config.resetVector, xlen bits))
  val mis32 = Reg(Bool) init False
  val hiReg = Reg(Bits(16 bits)) init B(0, 16 bits)

  val mis32Start = Bool()
  val mis32Stall = Bool()
  val fetchInstr = Bits(32 bits)
  val fetchLen = UInt(3 bits)
  val fetchCompressed = Bool()

  io.iBus.valid := True
  if (withCompressed) {
    val alignedPc = Cat(pcReg(xlen - 1 downto 2), U(0, 2 bits)).asUInt
    io.iBus.pc := Mux(mis32, alignedPc + U(4, xlen bits), alignedPc)

    val word = io.iBus.instruction
    val lowHalf = word(15 downto 0)
    val highHalf = word(31 downto 16)
    mis32Start := !mis32 && pcReg(1) && (highHalf(1 downto 0) === B"11")
    mis32Stall := mis32Start

    when(mis32) {
      mis32 := False
    } elsewhen (mis32Start) {
      mis32 := True
    }
    when(mis32Start) {
      hiReg := highHalf
    }

    when(mis32) {
      fetchInstr := Cat(word(15 downto 0), hiReg)
      fetchLen := U(4, 3 bits)
      fetchCompressed := False
    } elsewhen (pcReg(1)) {
      fetchInstr := Cat(B(0, 16 bits), highHalf)
      fetchLen := U(2, 3 bits)
      fetchCompressed := True
    } elsewhen (lowHalf(1 downto 0) === B"11") {
      fetchInstr := word
      fetchLen := U(4, 3 bits)
      fetchCompressed := False
    } otherwise {
      fetchInstr := Cat(B(0, 16 bits), lowHalf)
      fetchLen := U(2, 3 bits)
      fetchCompressed := True
    }
  } else {
    io.iBus.pc := pcReg
    mis32Start := False
    mis32Stall := False
    fetchInstr := io.iBus.instruction
    fetchLen := U(4, 3 bits)
    fetchCompressed := False
  }

  // ===== IF/ID pipeline register =====
  val ifId = Reg(new IfIdBundle(xlen)) init (IfIdBundle.zero(xlen))

  // ===== Decode =====
  val decoder = new Decoder(xlen, config.isa)
  decoder.io.instruction := ifId.instruction
  val dec = decoder.io.output

  // ===== Register file =====
  // The read ports are addressed from the EX stage. A consumer whose operands
  // are not covered by forwarding re-reads them combinationally here, so it
  // observes a write committed at the end of the producer's WB cycle instead of
  // a value latched one cycle early at the ID/EX boundary.
  val regFile = new RegisterFile(xlen)

  // ===== CSR file =====
  val csrFile = new CsrFile(xlen, config.hartId, config.isa)
  csrFile.io.timerInterrupt := io.timerInterrupt

  // ===== ID/EX, EX/MEM, MEM/WB pipeline registers =====
  val idEx = Reg(new IdExBundle(xlen)) init (IdExBundle.zero(xlen))
  val exMem = Reg(new ExMemBundle(xlen)) init (ExMemBundle.zero(xlen))
  val memWb = Reg(new MemWbBundle(xlen)) init (MemWbBundle.zero(xlen))

  regFile.io.rs1 := idEx.rs1
  regFile.io.rs2 := idEx.rs2

  // ===== CSR state readouts used by EX / trap logic =====
  val curMode = csrFile.io.curMode
  val mstatusMie = csrFile.io.mstatusMie
  val mstatusMpp = csrFile.io.mstatusMpp
  val mieMtie = csrFile.io.mieMtie
  val mtvecRegBits = csrFile.io.mtvec
  val mepcRead = csrFile.io.mepc

  // ===== Forwarding =====
  // exMem ALU results are forwardable. Loads and CSR reads produce their rd
  // only when they reach WB (a CSR's rd is its pre-write value, read at WB), so
  // they are excluded here and handled by a stall in the hazard section.
  val wbWriteData = Bits(xlen bits)
  wbWriteData := Mux(memWb.wbSel === WbSel.CSR, csrFile.io.rdData, memWb.wbData)

  val forwardRs1 = Bits(xlen bits)
  when(exMem.valid && exMem.regWrite && exMem.rd =/= U(0) && !exMem.memRead &&
       !exMem.atomic &&
       exMem.wbSel =/= WbSel.CSR && exMem.rd === idEx.rs1) {
    forwardRs1 := exMem.aluResult
  } elsewhen (memWb.valid && memWb.regWrite && memWb.rd =/= U(0) && memWb.rd === idEx.rs1) {
    forwardRs1 := wbWriteData
  } otherwise {
    // Read the architectural value at EX time. A producer writes the regfile at
    // the end of its WB cycle; re-reading here lets a consumer issued any
    // distance behind (>=3 slots) see the committed value instead of a value
    // latched a cycle early at the ID/EX boundary.
    forwardRs1 := regFile.io.rs1Data
  }

  val forwardRs2 = Bits(xlen bits)
  when(exMem.valid && exMem.regWrite && exMem.rd =/= U(0) && !exMem.memRead &&
       !exMem.atomic &&
       exMem.wbSel =/= WbSel.CSR && exMem.rd === idEx.rs2) {
    forwardRs2 := exMem.aluResult
  } elsewhen (memWb.valid && memWb.regWrite && memWb.rd =/= U(0) && memWb.rd === idEx.rs2) {
    forwardRs2 := wbWriteData
  } otherwise {
    forwardRs2 := regFile.io.rs2Data
  }

  // ===== Execute stage =====
  val alu = new Alu(xlen)
  val aluA = Bits(xlen bits)
  switch(idEx.aluASrc) {
    is(AluASrc.RS1) {
      aluA := forwardRs1
    }
    is(AluASrc.PC) {
      aluA := idEx.pc.asBits
    }
    default {
      aluA := B(0, xlen bits)
    }
  }
  val aluB = Mux(idEx.aluSrc, idEx.imm.asBits, forwardRs2)
  alu.io.a := aluA
  alu.io.b := aluB
  alu.io.op := idEx.aluOp

  // Instruction length of the instruction in EX; compressed instructions link
  // to pc+2 instead of pc+4.
  val instrLenEx = Mux(idEx.compressed, U(2, xlen bits), U(4, xlen bits))
  val aluResult = Bits(xlen bits)
  when(idEx.jump) {
    aluResult := (idEx.pc + instrLenEx).asBits
  } otherwise {
    aluResult := alu.io.result
  }

  // CSR write data: register form takes the forwarded rs1 value; the immediate
  // form (CSRRW*I) takes zimm[4:0] (instr[19:15]) zero-extended.
  val csrWrDataEx = Bits(xlen bits)
  when(idEx.csrImm) {
    csrWrDataEx := idEx.rs1.resize(xlen).asBits
  } otherwise {
    csrWrDataEx := forwardRs1
  }

  val branchCond = Bool()
  switch(idEx.branchType) {
    is(BranchOp.BEQ) {
      branchCond := forwardRs1 === forwardRs2
    }
    is(BranchOp.BNE) {
      branchCond := forwardRs1 =/= forwardRs2
    }
    is(BranchOp.BLT) {
      branchCond := forwardRs1.asSInt < forwardRs2.asSInt
    }
    is(BranchOp.BGE) {
      branchCond := forwardRs1.asSInt >= forwardRs2.asSInt
    }
    is(BranchOp.BLTU) {
      branchCond := forwardRs1.asUInt < forwardRs2.asUInt
    }
    is(BranchOp.BGEU) {
      branchCond := forwardRs1.asUInt >= forwardRs2.asUInt
    }
    default {
      branchCond := False
    }
  }

  val branchTaken = idEx.valid && idEx.branch && branchCond
  val jumpTaken = idEx.valid && idEx.jump
  val ctrlFlush = branchTaken || jumpTaken

  val ctrlTarget = UInt(xlen bits)
  when(idEx.jalr) {
    ctrlTarget := (forwardRs1.asUInt + idEx.imm.asUInt) & ~U(1, xlen bits)
  } otherwise {
    ctrlTarget := (idEx.pc + idEx.imm.asUInt).resize(xlen)
  }

  val divInEx = idEx.valid &&
    (idEx.aluOp === AluOp.DIV || idEx.aluOp === AluOp.DIVU ||
     idEx.aluOp === AluOp.REM || idEx.aluOp === AluOp.REMU ||
     idEx.aluOp === AluOp.DIVW || idEx.aluOp === AluOp.DIVUW ||
     idEx.aluOp === AluOp.REMW || idEx.aluOp === AluOp.REMUW)

  // ===== CSR legality checks (EX stage) =====
  // A CSR access is illegal when performed from U mode (no U-accessible CSR is
  // implemented), when the address is not implemented, when a full write
  // (CSRRW/I) targets a read-only CSR, or when an mtvec write would set a
  // nonzero MODE field. CSRRS/CSRRC touching only read-only bits are legal
  // reads (R1.8).
  val isCsrInst = idEx.csrOp =/= CsrOp.NONE
  // Implemented / read-only address sets are derived from the ISA-level CsrMap,
  // so this legality check and the CSR file share a single source of truth.
  private val csrDefs = CsrMap.implementedFor(config.isa)
  private val csrReadOnlyDefs = CsrMap.readOnlyFor(config.isa)
  require(csrDefs.nonEmpty, "a hart must implement at least one CSR")
  val csrImplemented = csrDefs.map(d => idEx.csrAddr === U(d.addr, 12 bits)).reduce(_ || _)
  val csrReadOnly = csrReadOnlyDefs.map(d => idEx.csrAddr === U(d.addr, 12 bits)).reduce(_ || _)

  val csrRoWrite = isCsrInst && csrReadOnly && idEx.csrOp === CsrOp.WRITE && idEx.csrWe
  val csrUnimpl = isCsrInst && !csrImplemented
  // A CSR is illegal unless the current mode is at least its minimum privilege
  // (each CsrDef carries that level). With the current M/U stack this means
  // "no CSR is accessible from U mode", matching the spec subset.
  val csrPrivIllegal = isCsrInst && csrDefs.map(d => !privAtLeast(d.minPriv)).reduce(_ || _)
  // mtvec.MODE after the write (the stored mode is always 0: nonzero writes trap).
  val mtvecModeBad = isCsrInst && idEx.csrWe && idEx.csrAddr === U(0x305, 12 bits) &&
    (idEx.csrOp === CsrOp.WRITE || idEx.csrOp === CsrOp.SET) &&
    csrWrDataEx(1 downto 0) =/= B(0, 2 bits)
  val csrIllegal = (csrRoWrite || csrUnimpl || csrPrivIllegal || mtvecModeBad) && idEx.valid

  // ===== Synchronous exception decode (EX stage) =====
  // Only one case applies per instruction (SYSTEM ops and CSR ops are mutually
  // exclusive), so last-write-wins assignment ordering is safe.
  val exTrapEna = Bool()
  val exTrapCause = Bits(xlen bits)
  val exTrapTval = Bits(xlen bits)
  exTrapEna := False
  exTrapCause := B(0, xlen bits)
  exTrapTval := B(0, xlen bits)

  // MRET returns to mstatus.MPP, which must name a mode this hart implements;
  // any other encoding is a reserved/unsupported target and traps as illegal.
  val mppSupported = modeSupported(mstatusMpp)

  when(idEx.valid) {
    when(idEx.sysOp === SysOp.ECALL) {
      exTrapEna := True
      exTrapCause := B(ecallCause(curMode), xlen bits)
    }
    when(idEx.sysOp === SysOp.EBREAK) {
      exTrapEna := True
      exTrapCause := B(ExceptionCode.breakpoint, xlen bits)
    }
    when(idEx.sysOp === SysOp.MRET && (curMode =/= MODE_M || !mppSupported)) {
      exTrapEna := True
      exTrapCause := B(ExceptionCode.instructionIllegal, xlen bits)
    }
    when(csrIllegal) {
      exTrapEna := True
      exTrapCause := B(ExceptionCode.instructionIllegal, xlen bits)
      exTrapTval := idEx.csrAddr.resize(xlen).asBits
    }
    when(idEx.illegal || idEx.sysOp === SysOp.ILLEGAL) {
      exTrapEna := True
      exTrapCause := B(ExceptionCode.instructionIllegal, xlen bits)
    }
    // A-extension ops require natural alignment (W: 4 bytes, D: 8 bytes).
    // LR uses the load-misaligned cause, SC/AMO the store/AMO one.
    when(idEx.atomic || idEx.isLr) {
      val alignCheck = Mux(idEx.memSize === U(2, 2 bits),
        aluResult(1 downto 0) === B"00", aluResult(2 downto 0) === B"000")
      when(!alignCheck) {
        exTrapEna := True
        exTrapCause := Mux(idEx.isLr,
          U(ExceptionCode.loadMisaligned, xlen bits),
          U(ExceptionCode.storeMisaligned, xlen bits)).asBits
        exTrapTval := aluResult
      }
    }
  }

  // ===== MRET / interrupt resolution =====
  val mretLegal = idEx.valid && idEx.sysOp === SysOp.MRET && curMode === MODE_M && mppSupported

  // MRET reads mepc/mstatus.MPP which a CSR instruction 1-2 slots behind (still
  // in EX/MEM or MEM/WB) has not yet committed. Stall MRET until those writes
  // have reached WB and committed.
  val csrAffectsMret = (memWb.valid && memWb.csrWe &&
    (memWb.csrAddr === U(0x300, 12 bits) || memWb.csrAddr === U(0x341, 12 bits))) ||
    (exMem.valid && exMem.csrWe &&
      (exMem.csrAddr === U(0x300, 12 bits) || exMem.csrAddr === U(0x341, 12 bits)))
  val csrMretStall = mretLegal && csrAffectsMret
  val exMretRaw = mretLegal && !csrMretStall

  val intrReq = io.timerInterrupt && mieMtie && mstatusMie && curMode === MODE_M

  // ===== Hazard detection =====
  // Loads and CSR reads produce rd only at WB, so a consumer in ID whose source
  // is produced by such an instruction currently in EX must be bubbled one cycle
  // (the existing load-use stall extended to CSR results).
  val stallData = idEx.valid && idEx.rd =/= U(0) &&
    (idEx.memRead || idEx.atomic || (idEx.wbSel === WbSel.CSR && idEx.regWrite)) &&
    (idEx.rd === dec.rs1 || idEx.rd === dec.rs2)
  val fetchStall = !io.iBus.ready
  val memStall = exMem.valid && (exMem.memRead || exMem.memWrite) && !exMem.atomic && !io.dBus.ready

  // ===== RV32M / RV64M divide/remainder (multi-cycle divider in EX) =====
  // The divider is only instantiated when the M-extension is enabled. With it
  // disabled the decoder never issues a DIV/REM op, so the pipeline behaves as
  // a plain RV32I core (freezeAll collapses back to the bus stalls).
  //
  // W-suffix division uses the same xlen-wide divider. Signed W operands are
  // sign-extended / unsigned W operands zero-extended from the low 32 bits, and
  // the 32-bit result is sign-extended back to xlen, per the RISC-V spec.
  val divIsDiv = (idEx.aluOp === AluOp.DIV) || (idEx.aluOp === AluOp.DIVU) ||
    (idEx.aluOp === AluOp.DIVW) || (idEx.aluOp === AluOp.DIVUW)
  val divIsRem = (idEx.aluOp === AluOp.REM) || (idEx.aluOp === AluOp.REMU) ||
    (idEx.aluOp === AluOp.REMW) || (idEx.aluOp === AluOp.REMUW)
  val divSigned = (idEx.aluOp === AluOp.DIV) || (idEx.aluOp === AluOp.REM) ||
    (idEx.aluOp === AluOp.DIVW) || (idEx.aluOp === AluOp.REMW)
  val divIsW = (idEx.aluOp === AluOp.DIVW) || (idEx.aluOp === AluOp.DIVUW) ||
    (idEx.aluOp === AluOp.REMW) || (idEx.aluOp === AluOp.REMUW)

  val divStall = Bool()
  val exAluResult = Bits(xlen bits)

  if (config.hasMulDiv) {
    val divider = new Divider(xlen)
    val aRaw = alu.io.a.asUInt
    val bRaw = alu.io.b.asUInt
    val aLowW = aRaw(31 downto 0)
    val bLowW = bRaw(31 downto 0)
    divider.io.a := Mux(divIsW,
      Mux(divSigned, aLowW.asSInt.resize(xlen).asUInt, aLowW.resize(xlen)), aRaw)
    divider.io.b := Mux(divIsW,
      Mux(divSigned, bLowW.asSInt.resize(xlen).asUInt, bLowW.resize(xlen)), bRaw)
    divider.io.signed := divSigned

    divider.io.start := divInEx && !divider.io.busy && !divider.io.done && !(memStall || fetchStall)
    divider.io.ack := divInEx && divider.io.done && !(memStall || fetchStall)

    val divResult = Mux(divIsRem, divider.io.remainder, divider.io.quotient)
    val divResultW = divResult(31 downto 0).asSInt.resize(xlen).asBits

    divStall := divInEx && !divider.io.done && !(memStall || fetchStall)
    exAluResult := Mux(divInEx && divider.io.done,
      Mux(divIsW, divResultW, divResult.asBits), aluResult)
  } else {
    divStall := False
    exAluResult := aluResult
  }

  // ===== A extension: LR/SC reservation + AMO read-modify-write =====
  // LR is an ordinary load that also sets a reservation; SC is a conditional
  // store whose rd carries 0 (success) / 1 (failure); AMO runs a two-step
  // read-then-write in MEM, freezing the pipeline so the update is atomic.
  val scSuccess = Bool()
  val amoStall = Bool()
  val amoDriveRead = Bool()
  val amoDriveWrite = Bool()
  val amoNewValue = Bits(xlen bits)
  val amoOldValue = Bits(xlen bits)

  // AMO operation combiner at a given width; `default` never uses the result
  // (illegal funct5 is rejected by the decoder).
  def amoCombine(width: Int, op: UInt, lhs: Bits, rhs: Bits): Bits = {
    val l = lhs.asUInt.resize(width)
    val r = rhs.asUInt.resize(width)
    val res = Bits(width bits)
    switch(op) {
      is(U(0x00, 5 bits)) { res := (l + r).asBits }                       // AMOADD
      is(U(0x01, 5 bits)) { res := r.asBits }                             // AMOSWAP
      is(U(0x04, 5 bits)) { res := (l ^ r).asBits }                       // AMOXOR
      is(U(0x08, 5 bits)) { res := (l | r).asBits }                       // AMOOR
      is(U(0x0c, 5 bits)) { res := (l & r).asBits }                       // AMOAND
      is(U(0x10, 5 bits)) { res := Mux(l.asSInt < r.asSInt, l, r).asBits } // AMOMIN
      is(U(0x14, 5 bits)) { res := Mux(l.asSInt > r.asSInt, l, r).asBits } // AMOMAX
      is(U(0x18, 5 bits)) { res := Mux(l < r, l, r).asBits }              // AMOMINU
      is(U(0x1c, 5 bits)) { res := Mux(l > r, l, r).asBits }              // AMOMAXU
      default { res := l.asBits }
    }
    res
  }

  val otherFreeze = memStall || fetchStall || divStall || mis32Stall

  if (withAtomic) {
    val resvValid = RegInit(False)
    val resvAddr = Reg(UInt(xlen bits))
    val memAddrEx = exMem.aluResult.asUInt
    val isLrMem = exMem.valid && exMem.isLr
    val isScMem = exMem.valid && exMem.isSc
    val isAmoMem = exMem.valid && exMem.atomic && !exMem.isSc

    val scOk = resvValid && (resvAddr === memAddrEx)

    // AMO FSM: 0 = issue read (latch the old word), 1 = issue write (release).
    val amoState = RegInit(U(0, 2 bits))
    val amoOld = Reg(Bits(xlen bits))
    val shiftWidth = log2Up(xlen)
    val amoWordShift = if (xlen > 32)
      Mux(memAddrEx(log2Up(xlen / 8) - 1), U(32, shiftWidth bits), U(0, shiftWidth bits))
    else
      U(0, shiftWidth bits)
    val amoIsW = exMem.memSize === U(2, 2 bits)
    val amoOldWord = (amoOld >> amoWordShift)(31 downto 0)

    amoOldValue := Mux(amoIsW, amoOldWord.asSInt.resize(xlen).asBits, amoOld)
    val wNew = amoCombine(32, exMem.amoOp, (amoOld >> amoWordShift)(31 downto 0), exMem.rs2Data(31 downto 0))
    val dNew = amoCombine(xlen, exMem.amoOp, amoOld, exMem.rs2Data)
    amoNewValue := Mux(amoIsW, wNew.asSInt.resize(xlen).asBits, dNew)

    amoDriveRead := isAmoMem && amoState === U(0)
    amoDriveWrite := isAmoMem && amoState === U(1)
    amoStall := isAmoMem && !(amoState === U(1) && io.dBus.ready)
    scSuccess := scOk

    when(isAmoMem) {
      when(amoState === U(0)) {
        when(io.dBus.ready) { amoOld := io.dBus.readData; amoState := U(1) }
      } elsewhen (amoState === U(1)) {
        when(io.dBus.ready) { amoState := U(0) }
      }
    } otherwise {
      amoState := U(0)
    }

    // LR establishes a reservation; any store, SC or committed AMO clears it.
    when(!otherFreeze) {
      when(isLrMem) {
        resvValid := True
        resvAddr := memAddrEx
      }
      when(isScMem || (exMem.valid && exMem.memWrite) ||
           (isAmoMem && amoState === U(1) && io.dBus.ready)) {
        resvValid := False
      }
    }
  } else {
    amoStall := False
    amoDriveRead := False
    amoDriveWrite := False
    amoNewValue := B(0, xlen bits)
    amoOldValue := B(0, xlen bits)
    scSuccess := False
  }

  val freezeAll = otherFreeze || amoStall

  // ===== Interrupt acceptance (instruction boundary) =====
  // Taken only when the pipeline is otherwise advancing and nothing older in
  // EX/MEM is redirecting or still running a divide; synchronous exceptions
  // (EX) always win over the timer interrupt (R4.4).
  val intrTake = intrReq && !exTrapEna && !ctrlFlush && !exMretRaw && !csrMretStall &&
    !divInEx && !stallData && !freezeAll

  // Address of the interrupted instruction: the instruction in EX if any, else
  // the one in ID, else the fetch address (pipeline-drained case).
  val intrEpc = UInt(xlen bits)
  when(idEx.valid) {
    intrEpc := idEx.pc
  } elsewhen (ifId.valid) {
    intrEpc := ifId.pc
  } otherwise {
    intrEpc := pcReg
  }

  val trapCommit = (exTrapEna || intrTake) && !freezeAll
  val exMret = exMretRaw && !freezeAll

  val trapEntry = (mtvecRegBits & B((BigInt(1) << xlen) - 4, xlen bits)).asUInt
  val intrCauseVal = (BigInt(1) << (xlen - 1)) | 7

  // ===== CSR file commit ports =====
  csrFile.io.csrAddr := memWb.csrAddr
  csrFile.io.csrOp := memWb.csrOp
  csrFile.io.csrWe := memWb.valid && memWb.csrWe
  csrFile.io.csrWrData := memWb.csrWrData
  csrFile.io.trapEna := trapCommit
  csrFile.io.trapEpc := Mux(intrTake, intrEpc, idEx.pc)
  csrFile.io.trapCause := Mux(intrTake, B(intrCauseVal, xlen bits), exTrapCause)
  csrFile.io.trapTval := Mux(intrTake, B(0, xlen bits), exTrapTval)
  csrFile.io.mretEna := exMret

  // ===== Control redirection =====
  // A branch/jump flush only invalidates the two younger stages; the
  // redirecting instruction itself still flows to WB (needed for JAL link
  // writes). A trap / MRET / interrupt additionally bubbles EX/MEM so the
  // faulted or interrupted instruction never reaches WB.
  val flushYounger = ctrlFlush || trapCommit || exMret || intrTake
  val bubbleEx = trapCommit || exMret || csrMretStall

  // ===== PC update =====
  when(!freezeAll) {
    when(trapCommit) {
      pcReg := trapEntry
    } elsewhen (exMret) {
      pcReg := mepcRead
    } elsewhen (ctrlFlush) {
      pcReg := ctrlTarget
    } elsewhen (stallData || csrMretStall) {
      pcReg := pcReg // hold
    } otherwise {
      pcReg := pcReg + fetchLen
    }
  }

  // ===== IF/ID update =====
  when(!freezeAll) {
    when(stallData || csrMretStall) {
      // hold
    } elsewhen (flushYounger) {
      ifId.valid := False
    } otherwise {
      ifId.pc := pcReg
      ifId.instruction := fetchInstr
      ifId.compressed := fetchCompressed
      ifId.valid := True
    }
  }

  // ===== ID/EX update =====
  when(!freezeAll && !csrMretStall) {
    when(stallData || flushYounger) {
      idEx.valid := False
    } otherwise {
      idEx.valid := ifId.valid
    }
    idEx.pc := ifId.pc
    idEx.compressed := ifId.compressed
    idEx.regWrite := dec.regWrite
    idEx.aluSrc := dec.aluSrc
    idEx.wbSel := dec.wbSel
    idEx.branch := dec.branch
    idEx.jump := dec.jump
    idEx.jalr := dec.jalr
    idEx.aluOp := dec.aluOp
    idEx.branchType := dec.branchType
    idEx.aluASrc := dec.aluASrc
    idEx.memRead := dec.memRead
    idEx.memWrite := dec.memWrite
    idEx.memSize := dec.memSize
    idEx.memSign := dec.memSign
    idEx.atomic := dec.atomic
    idEx.isLr := dec.isLr
    idEx.isSc := dec.isSc
    idEx.amoOp := dec.amoOp
    idEx.rs1 := dec.rs1
    idEx.rs2 := dec.rs2
    idEx.rd := dec.rd
    idEx.imm := dec.imm
    idEx.illegal := dec.illegal
    idEx.csrOp := dec.csrOp
    idEx.csrImm := dec.csrImm
    idEx.csrAddr := dec.csrAddr
    idEx.csrWe := dec.csrWe
    idEx.sysOp := dec.sysOp
  }

  // ===== EX/MEM update =====
  when(!freezeAll) {
    when(bubbleEx) {
      exMem.valid := False
    } otherwise {
      exMem.valid := idEx.valid
    }
    exMem.memRead := idEx.memRead
    exMem.memWrite := idEx.memWrite
    exMem.memSize := idEx.memSize
    exMem.memSign := idEx.memSign
    exMem.atomic := idEx.atomic
    exMem.isLr := idEx.isLr
    exMem.isSc := idEx.isSc
    exMem.amoOp := idEx.amoOp
    exMem.regWrite := idEx.regWrite
    exMem.rd := idEx.rd
    exMem.wbSel := idEx.wbSel
    exMem.aluResult := exAluResult
    exMem.rs2Data := forwardRs2
    exMem.csrOp := idEx.csrOp
    exMem.csrWe := idEx.csrWe
    exMem.csrAddr := idEx.csrAddr
    exMem.csrWrData := csrWrDataEx
  }

  // ===== Memory stage =====
  val memAddr = exMem.aluResult
  // An SC drives the bus only when its reservation check succeeds; AMO read /
  // write phases are driven by the FSM instead of the ordinary load/store path.
  val effMemWrite = exMem.memWrite && Mux(exMem.isSc, scSuccess, True)
  val normalRead = exMem.valid && exMem.memRead && !exMem.atomic
  val normalWrite = exMem.valid && effMemWrite
  io.dBus.valid := normalRead || normalWrite || amoDriveRead || amoDriveWrite
  io.dBus.write := normalWrite || amoDriveWrite
  io.dBus.size := exMem.memSize
  io.dBus.address := memAddr.asUInt

  // Byte offset within the data-memory word; the word is xlen/8 bytes wide, so
  // RV64 needs 3 offset bits to reach the high half of a word (addresses 4..7).
  val byteOffsetWidth = log2Up(xlen / 8)
  val storeOffset = memAddr(byteOffsetWidth - 1 downto 0).asUInt
  // AMO write uses the combined value; ordinary stores use rs2.
  val storeValue = Mux(amoDriveWrite, amoNewValue, exMem.rs2Data)
  io.dBus.writeData := B(0, xlen bits)
  io.dBus.writeMask := B(0, xlen / 8 bits)
  switch(exMem.memSize) {
    is(U(0)) { // byte
      io.dBus.writeData := (storeValue << (storeOffset * 8)).resize(xlen)
      io.dBus.writeMask := (U(1, xlen / 8 bits) << storeOffset).resize(xlen / 8).asBits
    }
    is(U(1)) { // half
      io.dBus.writeData := (storeValue << (storeOffset * 8)).resize(xlen)
      io.dBus.writeMask := (U(3, xlen / 8 bits) << storeOffset).resize(xlen / 8).asBits
    }
    is(U(2)) { // word: low 4 bytes, or the high half of the bus word on RV64
      if (xlen > 32) {
        io.dBus.writeData := (storeValue << (storeOffset * 8)).resize(xlen)
        io.dBus.writeMask := (U(0xf, xlen / 8 bits) << storeOffset).resize(xlen / 8).asBits
      } else {
        io.dBus.writeData := storeValue
        io.dBus.writeMask := B(0xf, xlen / 8 bits)
      }
    }
    default { // doubleword (RV64)
      io.dBus.writeData := storeValue
      io.dBus.writeMask := B((BigInt(1) << (xlen / 8)) - 1, xlen / 8 bits)
    }
  }

  val loadResult = Bits(xlen bits)
  switch(exMem.memSize) {
    is(U(0)) { // byte
      val byte = (io.dBus.readData >> (storeOffset * 8))(7 downto 0)
      loadResult := Mux(exMem.memSign, byte.asSInt.resize(xlen).asBits, byte.resize(xlen))
    }
    is(U(1)) { // half
      val half = (io.dBus.readData >> (storeOffset * 8))(15 downto 0)
      loadResult := Mux(exMem.memSign, half.asSInt.resize(xlen).asBits, half.resize(xlen))
    }
    is(U(2)) { // word: sign-extend (lw) or zero-extend (lwu) on RV64
      val word = (io.dBus.readData >> (storeOffset * 8))(31 downto 0)
      loadResult := Mux(exMem.memSign, word.asSInt.resize(xlen).asBits, word.resize(xlen))
    }
    default { // doubleword
      loadResult := io.dBus.readData
    }
  }

  // ===== MEM/WB update =====
  when(!freezeAll) {
    memWb.valid := exMem.valid
    memWb.regWrite := exMem.regWrite
    memWb.rd := exMem.rd
    memWb.wbSel := exMem.wbSel
    when(exMem.atomic) {
      // SC returns 0 on success / 1 on failure; AMO returns the original value.
      memWb.wbData := Mux(exMem.isSc,
        Mux(scSuccess, B(0, xlen bits), B(1, xlen bits)), amoOldValue)
    } elsewhen (exMem.memRead) {
      memWb.wbData := loadResult
    } otherwise {
      memWb.wbData := exMem.aluResult
    }
    memWb.csrOp := exMem.csrOp
    memWb.csrWe := exMem.csrWe
    memWb.csrAddr := exMem.csrAddr
    memWb.csrWrData := exMem.csrWrData
  }

  // ===== Writeback =====
  // CSR instructions write the pre-write CSR value to rd (wbSel==CSR); loads
  // write the loaded value (folded into wbData at MEM); everything else writes
  // the ALU/PC4 result.
  regFile.io.rd := memWb.rd
  regFile.io.writeData := wbWriteData
  regFile.io.writeEnable := memWb.valid && memWb.regWrite

  // ===== Debug =====
  io.debugPc := pcReg
  io.debugRegs := regFile.io.debugRegs
  io.debugMepc := csrFile.io.debugMepc
  io.debugMcause := csrFile.io.debugMcause
  io.debugMode := csrFile.io.debugMode
}
