package rv32c.core

import spinal.core._

object WbSel {
  def ALU = U(0, 2 bits)
  def MEM = U(1, 2 bits)
  def PC4 = U(2, 2 bits)
}

object AluASrc {
  def RS1 = U(0, 2 bits)
  def PC = U(1, 2 bits)
  def ZERO = U(2, 2 bits)
}

class DecodeOutput(xlen: Int) extends Bundle {
  val regWrite = Bool()
  val aluSrc = Bool()          // ALU operand b: 0=rs2, 1=imm
  val wbSel = UInt(2 bits)     // WbSel: ALU / MEM / PC4
  val branch = Bool()
  val jump = Bool()
  val jalr = Bool()
  val aluOp = AluOp()
  val branchType = BranchOp()
  val aluASrc = UInt(2 bits)   // AluASrc: RS1 / PC / ZERO
  val memRead = Bool()
  val memWrite = Bool()
  val memSize = UInt(2 bits)   // 0=byte, 1=half, 2=word
  val memSign = Bool()
  val rs1 = UInt(5 bits)
  val rs2 = UInt(5 bits)
  val rd = UInt(5 bits)
  val imm = SInt(xlen bits)
  val valid = Bool()
}

class Decoder(xlen: Int, withMulDiv: Boolean = false) extends Component {
  val io = new Bundle {
    val instruction = in Bits(32 bits)
    val output = out(new DecodeOutput(xlen))
  }

  val instr = io.instruction
  val opcode = instr(6 downto 0)
  val funct3 = instr(14 downto 12)
  val funct7 = instr(31 downto 25)

  val d = io.output

  val immI = instr(31 downto 20).asSInt.resize(xlen)
  val immS = Cat(instr(31 downto 25), instr(11 downto 7)).asSInt.resize(xlen)
  val immB = (Cat(instr(31), instr(7), instr(30 downto 25), instr(11 downto 8)).asSInt.resize(xlen) << 1).resize(xlen)
  val immU = (instr(31 downto 12) << 12).asSInt.resize(xlen)
  val immJ = (Cat(instr(31), instr(19 downto 12), instr(20), instr(30 downto 21)).asSInt.resize(xlen) << 1).resize(xlen)

  d.regWrite := False
  d.aluSrc := False
  d.wbSel := WbSel.ALU
  d.branch := False
  d.jump := False
  d.jalr := False
  d.aluOp := AluOp.ADD
  d.branchType := BranchOp.NONE
  d.aluASrc := AluASrc.RS1
  d.memRead := False
  d.memWrite := False
  d.memSize := U(2, 2 bits)
  d.memSign := False
  d.rs1 := instr(19 downto 15).asUInt
  d.rs2 := instr(24 downto 20).asUInt
  d.rd := instr(11 downto 7).asUInt
  d.imm := immI
  d.valid := True

  switch(opcode) {
    is(M"0110111") { // LUI
      d.regWrite := True
      d.aluSrc := True
      d.aluASrc := AluASrc.ZERO
      d.imm := immU
    }
    is(M"0010111") { // AUIPC
      d.regWrite := True
      d.aluSrc := True
      d.aluASrc := AluASrc.PC
      d.imm := immU
    }
    is(M"1101111") { // JAL
      d.regWrite := True
      d.jump := True
      d.wbSel := WbSel.PC4
      d.imm := immJ
    }
    is(M"1100111") { // JALR
      d.regWrite := True
      d.jump := True
      d.jalr := True
      d.wbSel := WbSel.PC4
      d.aluSrc := True
      d.imm := immI
    }
    is(M"1100011") { // Branch
      d.branch := True
      d.imm := immB
      switch(funct3) {
        is(M"000") { d.branchType := BranchOp.BEQ }
        is(M"001") { d.branchType := BranchOp.BNE }
        is(M"100") { d.branchType := BranchOp.BLT }
        is(M"101") { d.branchType := BranchOp.BGE }
        is(M"110") { d.branchType := BranchOp.BLTU }
        is(M"111") { d.branchType := BranchOp.BGEU }
        default { d.valid := False }
      }
    }
    is(M"0000011") { // Loads
      d.regWrite := True
      d.memRead := True
      d.wbSel := WbSel.MEM
      d.aluSrc := True
      switch(funct3) {
        is(M"000") { d.memSize := U(0, 2 bits); d.memSign := True }  // lb
        is(M"001") { d.memSize := U(1, 2 bits); d.memSign := True }  // lh
        is(M"010") { d.memSize := U(2, 2 bits) }                     // lw
        is(M"100") { d.memSize := U(0, 2 bits) }                     // lbu
        is(M"101") { d.memSize := U(1, 2 bits) }                     // lhu
        default { d.valid := False }
      }
    }
    is(M"0100011") { // Stores
      d.memWrite := True
      d.aluSrc := True
      d.imm := immS
      switch(funct3) {
        is(M"000") { d.memSize := U(0, 2 bits) } // sb
        is(M"001") { d.memSize := U(1, 2 bits) } // sh
        is(M"010") { d.memSize := U(2, 2 bits) } // sw
        default { d.valid := False }
      }
    }
    is(M"0010011") { // OP-IMM
      d.regWrite := True
      d.aluSrc := True
      switch(funct3) {
        is(M"000") { d.aluOp := AluOp.ADD }
        is(M"001") { d.aluOp := AluOp.SLL }
        is(M"010") { d.aluOp := AluOp.SLT }
        is(M"011") { d.aluOp := AluOp.SLTU }
        is(M"100") { d.aluOp := AluOp.XOR }
        is(M"101") { d.aluOp := Mux(instr(30), AluOp.SRA, AluOp.SRL) }
        is(M"110") { d.aluOp := AluOp.OR }
        is(M"111") { d.aluOp := AluOp.AND }
        default { d.valid := False }
      }
    }
    is(M"0110011") { // OP: RV32I ALU ops, or RV32M when funct7 == 0b0000001
      when(funct7 === M"0000001") {
        if (withMulDiv) { // RV32M multiply/divide
          d.regWrite := True
          switch(funct3) {
            is(M"000") { d.aluOp := AluOp.MUL }
            is(M"001") { d.aluOp := AluOp.MULH }
            is(M"010") { d.aluOp := AluOp.MULHSU }
            is(M"011") { d.aluOp := AluOp.MULHU }
            is(M"100") { d.aluOp := AluOp.DIV }
            is(M"101") { d.aluOp := AluOp.DIVU }
            is(M"110") { d.aluOp := AluOp.REM }
            is(M"111") { d.aluOp := AluOp.REMU }
            default { d.valid := False }
          }
        } else {
          d.valid := False // M-extension disabled by config
        }
      } otherwise { // RV32I ALU ops
        d.regWrite := True
        switch(funct3) {
          is(M"000") { d.aluOp := Mux(instr(30), AluOp.SUB, AluOp.ADD) }
          is(M"001") { d.aluOp := AluOp.SLL }
          is(M"010") { d.aluOp := AluOp.SLT }
          is(M"011") { d.aluOp := AluOp.SLTU }
          is(M"100") { d.aluOp := AluOp.XOR }
          is(M"101") { d.aluOp := Mux(instr(30), AluOp.SRA, AluOp.SRL) }
          is(M"110") { d.aluOp := AluOp.OR }
          is(M"111") { d.aluOp := AluOp.AND }
          default { d.valid := False }
        }
      }
    }
    is(M"0001111") { // FENCE: treated as NOP
      d.valid := False
    }
    is(M"1110011") { // SYSTEM: ecall/ebreak treated as NOP for now
      d.valid := False
    }
    default {
      d.valid := False
    }
  }
}
