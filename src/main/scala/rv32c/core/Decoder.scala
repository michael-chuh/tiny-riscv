package rv32c.core

import spinal.core._
import rv32c.isa._

object WbSel {
  def ALU = U(0, 3 bits)
  def MEM = U(1, 3 bits)
  def PC4 = U(2, 3 bits)
  def CSR = U(3, 3 bits)
}

object AluASrc {
  def RS1 = U(0, 2 bits)
  def PC = U(1, 2 bits)
  def ZERO = U(2, 2 bits)
}

/** CSR write-style decoded from a CSR instruction (funct3 lower two bits).
  * NONE means the instruction is not a CSR access.
  */
object CsrOp extends SpinalEnum {
  val NONE, WRITE, SET, CLEAR = newElement()
}

/** SYSTEM opcode (funct3=000) sub-operations plus a generic illegal marker.
  * ILLEGAL is also used as the catch-all for unrecognized instructions.
  */
object SysOp extends SpinalEnum {
  val NONE, ECALL, EBREAK, MRET, WFI, ILLEGAL = newElement()
}

class DecodeOutput(xlen: Int) extends Bundle {
  val regWrite = Bool()
  val aluSrc = Bool()          // ALU operand b: 0=rs2, 1=imm
  val wbSel = UInt(3 bits)     // WbSel: ALU / MEM / PC4 / CSR
  val branch = Bool()
  val jump = Bool()
  val jalr = Bool()
  val aluOp = AluOp()
  val branchType = BranchOp()
  val aluASrc = UInt(2 bits)   // AluASrc: RS1 / PC / ZERO
  val memRead = Bool()
  val memWrite = Bool()
  val memSize = UInt(2 bits)   // 0=byte, 1=half, 2=word, 3=doubleword
  val memSign = Bool()
  val rs1 = UInt(5 bits)
  val rs2 = UInt(5 bits)
  val rd = UInt(5 bits)
  val imm = SInt(xlen bits)
  // --- Zicsr / exception fields ---
  val illegal = Bool()         // unrecognized / unsupported instruction
  val csrOp = CsrOp()          // NONE for non-CSR
  val csrAddr = UInt(12 bits)  // CSR address (instr[31:20])
  val csrImm = Bool()          // immediate form (CSRRW*I)
  val csrWe = Bool()           // this instruction actually writes the CSR
  val sysOp = SysOp()          // SYSTEM sub-op for ecall/ebreak/mret/wfi
  val valid = Bool()
}

class Decoder(xlen: Int, isa: IsaConfig = IsaConfig.rv32) extends Component {
  val io = new Bundle {
    val instruction = in Bits(32 bits)
    val output = out(new DecodeOutput(xlen))
  }

  // Extension enablement is derived from the ISA configuration so decode has a
  // single, declarative source of truth.
  private val withMulDiv: Boolean = isa.hasMulDiv
  private val isRV64: Boolean = isa.isRV64

  val instr = io.instruction
  val opcode = instr(6 downto 0)
  val funct3 = instr(14 downto 12)
  val funct7 = instr(31 downto 25)
  val rs1Num = instr(19 downto 15).asUInt
  val rdNum = instr(11 downto 7).asUInt

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
  d.rs1 := rs1Num
  d.rs2 := instr(24 downto 20).asUInt
  d.rd := rdNum
  d.imm := immI
  d.illegal := False
  d.csrOp := CsrOp.NONE
  d.csrAddr := U(0, 12 bits)
  d.csrImm := False
  d.csrWe := False
  d.sysOp := SysOp.NONE
  d.valid := True

  // CSR write intent: CSRRW swaps only when rs1!=x0; CSRRWI always writes the
  // zimm; CSRRS/CSRRC (register and immediate forms) write only when the mask
  // (rs1, or zimm in the rs1 field for immediate forms) is nonzero.
  val csrWrite = Bool()
  when(d.csrOp === CsrOp.WRITE) {
    csrWrite := Mux(d.csrImm, True, rs1Num =/= U(0))
  } otherwise {
    csrWrite := rs1Num =/= U(0)
  }

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
        default { d.illegal := True; d.valid := False }
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
        is(M"010") { d.memSize := U(2, 2 bits); d.memSign := True }  // lw
        is(M"100") { d.memSize := U(0, 2 bits) }                     // lbu
        is(M"101") { d.memSize := U(1, 2 bits) }                     // lhu
        is(M"011") { // ld (RV64)
          if (isRV64) { d.memSize := U(3, 2 bits) }
          else { d.illegal := True; d.valid := False }
        }
        is(M"110") { // lwu (RV64, zero-extend)
          if (isRV64) { d.memSize := U(2, 2 bits) }
          else { d.illegal := True; d.valid := False }
        }
        default { d.illegal := True; d.valid := False }
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
        is(M"011") { // sd (RV64)
          if (isRV64) { d.memSize := U(3, 2 bits) }
          else { d.illegal := True; d.valid := False }
        }
        default { d.illegal := True; d.valid := False }
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
        default { d.illegal := True; d.valid := False }
      }
    }
    is(M"0011011") { // OP-IMM-32 (RV64): ADDIW/SLLIW/SRLIW/SRAIW
      if (isRV64) {
        d.regWrite := True
        d.aluSrc := True
        switch(funct3) {
          is(M"000") { d.aluOp := AluOp.ADDW }
          is(M"001") { d.aluOp := AluOp.SLLW }
          is(M"101") { d.aluOp := Mux(instr(30), AluOp.SRAW, AluOp.SRLW) }
          default { d.illegal := True; d.valid := False }
        }
      } else {
        d.illegal := True
        d.valid := False
      }
    }
    is(M"0111011") { // OP-32 (RV64): ADDW/SUBW/SLLW/SRLW/SRAW (+ RV64M W forms, not yet)
      if (isRV64) {
        d.regWrite := True
        switch(funct7) {
          is(M"0000000") {
            switch(funct3) {
              is(M"000") { d.aluOp := AluOp.ADDW }
              is(M"001") { d.aluOp := AluOp.SLLW }
              is(M"101") { d.aluOp := AluOp.SRLW }
              default { d.illegal := True; d.valid := False }
            }
          }
          is(M"0100000") {
            switch(funct3) {
              is(M"000") { d.aluOp := AluOp.SUBW }
              is(M"101") { d.aluOp := AluOp.SRAW }
              default { d.illegal := True; d.valid := False }
            }
          }
          default { d.illegal := True; d.valid := False }
        }
      } else {
        d.illegal := True
        d.valid := False
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
            default { d.illegal := True; d.valid := False }
          }
        } else {
          d.illegal := True // M-extension disabled by config
          d.valid := False
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
          default { d.illegal := True; d.valid := False }
        }
      }
    }
    is(M"0001111") { // FENCE / FENCE.I: treated as NOP
      switch(funct3) {
        is(M"000") {}
        is(M"001") {}
        default { d.illegal := True; d.valid := False }
      }
    }
    is(M"1110011") { // SYSTEM: CSR instructions + ecall/ebreak/mret/wfi
      switch(funct3) {
        is(M"001") { // CSRRW
          d.regWrite := rdNum =/= U(0)
          d.csrOp := CsrOp.WRITE
          d.csrWe := csrWrite
          d.wbSel := WbSel.CSR
        }
        is(M"010") { // CSRRS
          d.regWrite := rdNum =/= U(0)
          d.csrOp := CsrOp.SET
          d.csrWe := csrWrite
          d.wbSel := WbSel.CSR
        }
        is(M"011") { // CSRRC
          d.regWrite := rdNum =/= U(0)
          d.csrOp := CsrOp.CLEAR
          d.csrWe := csrWrite
          d.wbSel := WbSel.CSR
        }
        is(M"101") { // CSRRWI
          d.regWrite := rdNum =/= U(0)
          d.csrOp := CsrOp.WRITE
          d.csrImm := True
          d.csrWe := True
          d.wbSel := WbSel.CSR
        }
        is(M"110") { // CSRRSI
          d.regWrite := rdNum =/= U(0)
          d.csrOp := CsrOp.SET
          d.csrImm := True
          d.csrWe := csrWrite
          d.wbSel := WbSel.CSR
        }
        is(M"111") { // CSRRCI
          d.regWrite := rdNum =/= U(0)
          d.csrOp := CsrOp.CLEAR
          d.csrImm := True
          d.csrWe := csrWrite
          d.wbSel := WbSel.CSR
        }
        is(M"000") { // system calls & privileged instructions
          switch(instr(31 downto 20)) {
            is(M"000000000000") { d.sysOp := SysOp.ECALL }
            is(M"000000000001") { d.sysOp := SysOp.EBREAK }
            is(M"001100000010") { d.sysOp := SysOp.MRET }
            is(M"000100000101") { d.sysOp := SysOp.WFI }
            default { d.sysOp := SysOp.ILLEGAL; d.valid := False } // SRET/URET/reserved
          }
        }
        default { // funct3 = 100 (reserved)
          d.illegal := True
          d.valid := False
        }
      }
      d.csrAddr := instr(31 downto 20).asUInt
    }
    default {
      d.illegal := True
      d.valid := False
    }
  }
}
