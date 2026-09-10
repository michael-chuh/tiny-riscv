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
}
object IfIdBundle {
  def zero(xlen: Int): IfIdBundle = {
    val b = new IfIdBundle(xlen)
    b.valid := False
    b.pc := U(0, xlen bits)
    b.instruction := B(0, 32 bits)
    b
  }
}

class IdExBundle(xlen: Int) extends Bundle {
  val valid = Bool()
  val pc = UInt(xlen bits)
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
  val MODE_M = U(3, 2 bits)
  val MODE_U = U(0, 2 bits)

  // ---- Capability check: which configurations this RTL can actually run ----
  require(config.isa.isRV32, "rv32c currently implements RV32I only; RV64 is a roadmap branch")
  require((config.isa.extensions -- RvExtension.implemented).isEmpty,
    s"extensions not implemented by this core: ${(config.isa.extensions -- RvExtension.implemented).toSeq.sorted.mkString(", ")}")
  require(config.isa.hasZicsr, "Zicsr decode is currently unconditional; it cannot be disabled")
  require(config.priv.hasUser, "rv32c implements the M/U stack (pure-M is not supported)")
  require(!config.priv.hasSupervisor && !config.priv.hasHypervisor,
    "S/H modes are roadmap features and are not implemented yet")

  // ===== Fetch stage =====
  val pcReg = RegInit(U(config.resetVector, xlen bits))
  io.iBus.valid := True
  io.iBus.pc := pcReg

  // ===== IF/ID pipeline register =====
  val ifId = Reg(new IfIdBundle(xlen)) init (IfIdBundle.zero(xlen))
  val ifIdRs1 = ifId.instruction(19 downto 15).asUInt
  val ifIdRs2 = ifId.instruction(24 downto 20).asUInt

  // ===== Decode =====
  val decoder = new Decoder(xlen, config.hasMulDiv)
  decoder.io.instruction := ifId.instruction
  val dec = decoder.io.output

  // ===== Register file =====
  // The read ports are addressed from the EX stage. A consumer whose operands
  // are not covered by forwarding re-reads them combinationally here, so it
  // observes a write committed at the end of the producer's WB cycle instead of
  // a value latched one cycle early at the ID/EX boundary.
  val regFile = new RegisterFile(xlen)

  // ===== CSR file =====
  val csrFile = new CsrFile(xlen, config.hartId, config.misaValue)
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

  val aluResult = Bits(xlen bits)
  when(idEx.jump) {
    aluResult := (idEx.pc + U(4)).asBits
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
     idEx.aluOp === AluOp.REM || idEx.aluOp === AluOp.REMU)

  // ===== CSR legality checks (EX stage) =====
  // A CSR access is illegal when performed from U mode (no U-accessible CSR is
  // implemented), when the address is not implemented, when a full write
  // (CSRRW/I) targets a read-only CSR, or when an mtvec write would set a
  // nonzero MODE field. CSRRS/CSRRC touching only read-only bits are legal
  // reads (R1.8).
  val isCsrInst = idEx.csrOp =/= CsrOp.NONE
  val csrImplemented = idEx.csrAddr === U(0x300, 12 bits) ||
    idEx.csrAddr === U(0x301, 12 bits) ||
    idEx.csrAddr === U(0x304, 12 bits) ||
    idEx.csrAddr === U(0x305, 12 bits) ||
    idEx.csrAddr === U(0x340, 12 bits) ||
    idEx.csrAddr === U(0x341, 12 bits) ||
    idEx.csrAddr === U(0x342, 12 bits) ||
    idEx.csrAddr === U(0x343, 12 bits) ||
    idEx.csrAddr === U(0x344, 12 bits) ||
    idEx.csrAddr === U(0xF14, 12 bits)
  val csrReadOnly = idEx.csrAddr === U(0x301, 12 bits) ||
    idEx.csrAddr === U(0x344, 12 bits) ||
    idEx.csrAddr === U(0xF14, 12 bits)

  val csrRoWrite = isCsrInst && csrReadOnly && idEx.csrOp === CsrOp.WRITE && idEx.csrWe
  val csrUnimpl = isCsrInst && !csrImplemented
  val csrUAccess = isCsrInst && curMode === MODE_U
  // mtvec.MODE after the write (the stored mode is always 0: nonzero writes trap).
  val mtvecModeBad = isCsrInst && idEx.csrWe && idEx.csrAddr === U(0x305, 12 bits) &&
    (idEx.csrOp === CsrOp.WRITE || idEx.csrOp === CsrOp.SET) &&
    csrWrDataEx(1 downto 0) =/= B(0, 2 bits)
  val csrIllegal = (csrRoWrite || csrUnimpl || csrUAccess || mtvecModeBad) && idEx.valid

  // ===== Synchronous exception decode (EX stage) =====
  // Only one case applies per instruction (SYSTEM ops and CSR ops are mutually
  // exclusive), so last-write-wins assignment ordering is safe.
  val exTrapEna = Bool()
  val exTrapCause = Bits(xlen bits)
  val exTrapTval = Bits(xlen bits)
  exTrapEna := False
  exTrapCause := B(0, xlen bits)
  exTrapTval := B(0, xlen bits)

  when(idEx.valid) {
    when(idEx.sysOp === SysOp.ECALL) {
      exTrapEna := True
      exTrapCause := B(Mux(curMode === MODE_U, U(8), U(11)), xlen bits)
    }
    when(idEx.sysOp === SysOp.EBREAK) {
      exTrapEna := True
      exTrapCause := B(3, xlen bits)
    }
    when(idEx.sysOp === SysOp.MRET &&
         (curMode === MODE_U || mstatusMpp === U(1, 2 bits) || mstatusMpp === U(2, 2 bits))) {
      exTrapEna := True
      exTrapCause := B(2, xlen bits)
    }
    when(csrIllegal) {
      exTrapEna := True
      exTrapCause := B(2, xlen bits)
      exTrapTval := idEx.csrAddr.resize(xlen).asBits
    }
    when(idEx.illegal || idEx.sysOp === SysOp.ILLEGAL) {
      exTrapEna := True
      exTrapCause := B(2, xlen bits)
    }
  }

  // ===== MRET / interrupt resolution =====
  val mppReserved = mstatusMpp === U(1, 2 bits) || mstatusMpp === U(2, 2 bits)
  val mretLegal = idEx.valid && idEx.sysOp === SysOp.MRET && curMode === MODE_M && !mppReserved

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
    (idEx.memRead || (idEx.wbSel === WbSel.CSR && idEx.regWrite)) &&
    (idEx.rd === ifIdRs1 || idEx.rd === ifIdRs2)
  val fetchStall = !io.iBus.ready
  val memStall = exMem.valid && (exMem.memRead || exMem.memWrite) && !io.dBus.ready

  // ===== RV32M divide/remainder (multi-cycle divider in EX) =====
  // The divider is only instantiated when the M-extension is enabled. With it
  // disabled the decoder never issues a DIV/REM op, so the pipeline behaves as
  // a plain RV32I core (freezeAll collapses back to the bus stalls).
  val divIsDiv = (idEx.aluOp === AluOp.DIV) || (idEx.aluOp === AluOp.DIVU)
  val divIsRem = (idEx.aluOp === AluOp.REM) || (idEx.aluOp === AluOp.REMU)
  val divSigned = (idEx.aluOp === AluOp.DIV) || (idEx.aluOp === AluOp.REM)

  val divStall = Bool()
  val exAluResult = Bits(xlen bits)

  if (config.hasMulDiv) {
    val divider = new Divider(xlen)
    divider.io.a := alu.io.a.asUInt
    divider.io.b := alu.io.b.asUInt
    divider.io.signed := divSigned

    divider.io.start := divInEx && !divider.io.busy && !divider.io.done && !(memStall || fetchStall)
    divider.io.ack := divInEx && divider.io.done && !(memStall || fetchStall)

    divStall := divInEx && !divider.io.done && !(memStall || fetchStall)
    exAluResult := Mux(divInEx && divider.io.done,
      Mux(divIsRem, divider.io.remainder, divider.io.quotient).asBits, aluResult)
  } else {
    divStall := False
    exAluResult := aluResult
  }

  val freezeAll = memStall || fetchStall || divStall

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
      pcReg := pcReg + U(4)
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
      ifId.instruction := io.iBus.instruction
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
  io.dBus.valid := exMem.valid && (exMem.memRead || exMem.memWrite)
  io.dBus.write := exMem.memWrite
  io.dBus.size := exMem.memSize
  io.dBus.address := memAddr.asUInt

  val storeOffset = memAddr(1 downto 0).asUInt
  io.dBus.writeData := B(0, xlen bits)
  io.dBus.writeMask := B(0, xlen / 8 bits)
  switch(exMem.memSize) {
    is(U(0)) { // byte
      io.dBus.writeData := (exMem.rs2Data << (storeOffset * 8)).resize(xlen)
      io.dBus.writeMask := (U(1, xlen / 8 bits) << storeOffset).resize(xlen / 8).asBits
    }
    is(U(1)) { // half
      io.dBus.writeData := (exMem.rs2Data << (memAddr(1).asUInt * 8)).resize(xlen)
      io.dBus.writeMask := Mux(memAddr(1), B((1 << (xlen / 8)) - 2, xlen / 8 bits), B(0x3, xlen / 8 bits))
    }
    default { // word
      io.dBus.writeData := exMem.rs2Data
      io.dBus.writeMask := B((1 << (xlen / 8)) - 1, xlen / 8 bits)
    }
  }

  val loadResult = Bits(xlen bits)
  switch(exMem.memSize) {
    is(U(0)) { // byte
      val byte = (io.dBus.readData >> (storeOffset * 8))(7 downto 0)
      loadResult := Mux(exMem.memSign, byte.asSInt.resize(xlen).asBits, byte.resize(xlen))
    }
    is(U(1)) { // half
      val half = (io.dBus.readData >> (memAddr(1).asUInt * 8))(15 downto 0)
      loadResult := Mux(exMem.memSign, half.asSInt.resize(xlen).asBits, half.resize(xlen))
    }
    default {
      loadResult := io.dBus.readData
    }
  }

  // ===== MEM/WB update =====
  when(!freezeAll) {
    memWb.valid := exMem.valid
    memWb.regWrite := exMem.regWrite
    memWb.rd := exMem.rd
    memWb.wbSel := exMem.wbSel
    when(exMem.memRead) {
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
