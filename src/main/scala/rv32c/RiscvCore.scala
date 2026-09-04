package rv32c

import spinal.core._
import spinal.lib._
import rv32c.bus._
import rv32c.core._

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
  val wbSel = UInt(2 bits)
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
  val rs1Data = Bits(xlen bits)
  val rs2Data = Bits(xlen bits)
}
object IdExBundle {
  def zero(xlen: Int): IdExBundle = {
    val b = new IdExBundle(xlen)
    b.valid := False
    b.pc := U(0, xlen bits)
    b.regWrite := False
    b.aluSrc := False
    b.wbSel := U(0, 2 bits)
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
    b.rs1Data := B(0, xlen bits)
    b.rs2Data := B(0, xlen bits)
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
  val aluResult = Bits(xlen bits)
  val rs2Data = Bits(xlen bits)
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
    b.aluResult := B(0, xlen bits)
    b.rs2Data := B(0, xlen bits)
    b
  }
}

class MemWbBundle(xlen: Int) extends Bundle {
  val valid = Bool()
  val regWrite = Bool()
  val rd = UInt(5 bits)
  val wbData = Bits(xlen bits)
}
object MemWbBundle {
  def zero(xlen: Int): MemWbBundle = {
    val b = new MemWbBundle(xlen)
    b.valid := False
    b.regWrite := False
    b.rd := U(0, 5 bits)
    b.wbData := B(0, xlen bits)
    b
  }
}

class RiscvCore(config: CoreConfig) extends Component {
  val io = new Bundle {
    val iBus = master(IBusInterface(config.xlen))
    val dBus = master(DBusInterface(config.xlen))
    val debugPc = out UInt(config.xlen bits)
    val debugRegs = out Vec(Bits(config.xlen bits), 32)
  }

  val xlen = config.xlen

  // ===== Fetch stage =====
  val pcReg = RegInit(U(config.resetVector, xlen bits))
  io.iBus.valid := True
  io.iBus.pc := pcReg

  // ===== IF/ID pipeline register =====
  val ifId = Reg(new IfIdBundle(xlen)) init (IfIdBundle.zero(xlen))
  val ifIdRs1 = ifId.instruction(19 downto 15).asUInt
  val ifIdRs2 = ifId.instruction(24 downto 20).asUInt

  // ===== Decode =====
  val decoder = new Decoder(xlen, config.withMulDiv)
  decoder.io.instruction := ifId.instruction
  val dec = decoder.io.output

  // ===== Register file =====
  val regFile = new RegisterFile(xlen)
  regFile.io.rs1 := ifIdRs1
  regFile.io.rs2 := ifIdRs2

  // ===== ID/EX pipeline register =====
  val idEx = Reg(new IdExBundle(xlen)) init (IdExBundle.zero(xlen))

  // ===== Forwarding =====
  val exMem = Reg(new ExMemBundle(xlen)) init (ExMemBundle.zero(xlen))
  val memWb = Reg(new MemWbBundle(xlen)) init (MemWbBundle.zero(xlen))

  val forwardRs1 = Bits(xlen bits)
  when(exMem.valid && exMem.regWrite && exMem.rd =/= U(0) && !exMem.memRead && exMem.rd === idEx.rs1) {
    forwardRs1 := exMem.aluResult
  } elsewhen (memWb.valid && memWb.regWrite && memWb.rd =/= U(0) && memWb.rd === idEx.rs1) {
    forwardRs1 := memWb.wbData
  } otherwise {
    forwardRs1 := idEx.rs1Data
  }

  val forwardRs2 = Bits(xlen bits)
  when(exMem.valid && exMem.regWrite && exMem.rd =/= U(0) && !exMem.memRead && exMem.rd === idEx.rs2) {
    forwardRs2 := exMem.aluResult
  } elsewhen (memWb.valid && memWb.regWrite && memWb.rd =/= U(0) && memWb.rd === idEx.rs2) {
    forwardRs2 := memWb.wbData
  } otherwise {
    forwardRs2 := idEx.rs2Data
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

  // ===== Hazard detection =====
  val stallLoad = idEx.valid && idEx.memRead && idEx.rd =/= U(0) &&
    (idEx.rd === ifIdRs1 || idEx.rd === ifIdRs2)
  val fetchStall = !io.iBus.ready
  val memStall = exMem.valid && (exMem.memRead || exMem.memWrite) && !io.dBus.ready

  // ===== RV32M divide/remainder (multi-cycle divider in EX) =====
  // The divider is only instantiated when the M-extension is enabled. With it
  // disabled the decoder never issues a DIV/REM op, so the pipeline behaves as
  // a plain RV32I core (freezeAll collapses back to the bus stalls).
  val divIsDiv  = (idEx.aluOp === AluOp.DIV) || (idEx.aluOp === AluOp.DIVU)
  val divIsRem  = (idEx.aluOp === AluOp.REM) || (idEx.aluOp === AluOp.REMU)
  val divInEx   = idEx.valid && (divIsDiv || divIsRem)
  val divSigned = (idEx.aluOp === AluOp.DIV) || (idEx.aluOp === AluOp.REM)

  val divStall    = Bool()
  val exAluResult = Bits(xlen bits)

  if (config.withMulDiv) {
    val divider = new Divider(xlen)
    divider.io.a := alu.io.a.asUInt
    divider.io.b := alu.io.b.asUInt
    divider.io.signed := divSigned

    // Start once the divide sits in EX and the divider is idle (no bus stall in
    // front of it); while it runs the whole pipeline is frozen (divStall). When
    // the divider reports done the instruction advances to EX/MEM in that same
    // cycle carrying the divider output, and the divider is acknowledged.
    divider.io.start := divInEx && !divider.io.busy && !divider.io.done && !(memStall || fetchStall)
    divider.io.ack   := divInEx && divider.io.done && !(memStall || fetchStall)

    divStall := divInEx && !divider.io.done && !(memStall || fetchStall)
    exAluResult := Mux(divInEx && divider.io.done,
      Mux(divIsRem, divider.io.remainder, divider.io.quotient).asBits, aluResult)
  } else {
    divStall := False
    exAluResult := aluResult
  }

  val freezeAll = memStall || fetchStall || divStall

  // ===== PC update =====
  when(!freezeAll) {
    when(!stallLoad) {
      when(ctrlFlush) {
        pcReg := ctrlTarget
      } otherwise {
        pcReg := pcReg + U(4)
      }
    }
  }

  // ===== IF/ID update =====
  when(!freezeAll) {
    when(!stallLoad) {
      when(ctrlFlush) {
        ifId.valid := False
      } otherwise {
        ifId.pc := pcReg
        ifId.instruction := io.iBus.instruction
        ifId.valid := True
      }
    }
  }

  // ===== ID/EX update =====
  when(!freezeAll) {
    when(stallLoad || ctrlFlush) {
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
    idEx.rs1Data := regFile.io.rs1Data
    idEx.rs2Data := regFile.io.rs2Data
  }

  // ===== EX/MEM update =====
  when(!freezeAll) {
    exMem.valid := idEx.valid
    exMem.memRead := idEx.memRead
    exMem.memWrite := idEx.memWrite
    exMem.memSize := idEx.memSize
    exMem.memSign := idEx.memSign
    exMem.regWrite := idEx.regWrite
    exMem.rd := idEx.rd
    exMem.aluResult := exAluResult
    exMem.rs2Data := forwardRs2
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
    when(exMem.memRead) {
      memWb.wbData := loadResult
    } otherwise {
      memWb.wbData := exMem.aluResult
    }
  }

  // ===== Writeback =====
  regFile.io.rd := memWb.rd
  regFile.io.writeData := memWb.wbData
  regFile.io.writeEnable := memWb.valid && memWb.regWrite

  // ===== Debug =====
  io.debugPc := pcReg
  io.debugRegs := regFile.io.debugRegs
}
