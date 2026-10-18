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
  // --- A extension (LR/SC/AMO) ---
  val atomic = Bool()          // this is an A-extension memory op
  val isLr = Bool()            // LR (sets a reservation)
  val isSc = Bool()            // SC (conditional store, fail bit in rd)
  val amoOp = UInt(5 bits)     // funct5 for AMO*; 0 for LR/SC
  // --- F/D floating point ---
  val fp = Bool()              // this is a floating-point instruction
  val fpWrite = Bool()         // result is written to the FP register file
  val fpLoad = Bool()          // FP load (FLW/FLD)
  val fpStore = Bool()         // FP store (FSW/FSD)
  val fpIntRd = Bool()         // FP instruction whose result goes to an integer register
  val fpOp = UInt(6 bits)      // FPU operation selector (FpOp)
  val fpRm = UInt(3 bits)      // effective rounding mode
  val fpFmt = Bool()           // false = single (S), true = double (D)
  val rs3 = UInt(5 bits)       // FMA addend register
  val rs1 = UInt(5 bits)
  val rs2 = UInt(5 bits)
  val rd = UInt(5 bits)
  val imm = SInt(xlen bits)
  val bs = UInt(2 bits)        // Zksed SM4 byte-select (instr[31:30])
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
  private val withCompressed: Boolean = isa.hasCompressed
  private val withAtomic: Boolean = isa.hasAtomic
  private val withFloat: Boolean = isa.hasFpu
  private val withDouble: Boolean = isa.hasDoubleFloat
  private val withZbb: Boolean = isa.hasZbb
  private val withZbs: Boolean = isa.hasZbs
  private val withZba: Boolean = isa.hasZba
  private val withZbc: Boolean = isa.hasZbc
  private val withZbkb: Boolean = isa.hasZbkb
  private val withZbkc: Boolean = isa.hasZbkc
  private val withZbkx: Boolean = isa.hasZbkx
  private val withZknh: Boolean = isa.hasZknh
  private val withZksh: Boolean = isa.hasZksh
  private val withZksed: Boolean = isa.hasZksed

  val instr = io.instruction
  val opcode = instr(6 downto 0)
  val funct3 = instr(14 downto 12)
  val funct7 = instr(31 downto 25)
  val funct5 = instr(31 downto 27)
  val funct6 = instr(31 downto 26)
  val convSel = instr(21 downto 20) // OP-FP rs2[1:0]: W / WU / L / LU
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
  d.atomic := False
  d.isLr := False
  d.isSc := False
  d.amoOp := U(0, 5 bits)
  d.fp := False
  d.fpWrite := False
  d.fpLoad := False
  d.fpStore := False
  d.fpIntRd := False
  d.fpOp := U(0, 6 bits)
  d.fpRm := U(0, 3 bits)
  d.fpFmt := False
  d.rs3 := instr(31 downto 27).asUInt
  d.rs1 := rs1Num
  d.rs2 := instr(24 downto 20).asUInt
  d.rd := rdNum
  d.imm := immI
  d.bs := U(0, 2 bits)
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

  // ===== RV32C (compressed) decode =====
  // A 16-bit instruction is expanded into the same control fields the 32-bit
  // path produces, so EX/MEM/WB are unchanged. With C disabled `isComp` stays
  // constant false and the whole branch is pruned.
  val isComp = if (withCompressed) instr(1 downto 0) =/= B"11" else False

  val cfunct3 = instr(15 downto 13) // RV32C uses instr[15:13], not the RV32I funct3
  val crd = instr(11 downto 7).asUInt
  val crs2 = instr(6 downto 2).asUInt
  val crdp = (U(8, 5 bits) + instr(4 downto 2).asUInt.resize(5)).resize(5)
  val crs1p = (U(8, 5 bits) + instr(9 downto 7).asUInt.resize(5)).resize(5)
  val crs2p = (U(8, 5 bits) + instr(4 downto 2).asUInt.resize(5)).resize(5)
  val c6 = Cat(instr(12), instr(6 downto 2))
  val c6S = c6.asSInt
  val cShamt = c6.asUInt.resize(xlen).asSInt
  val cAddi4spn = Cat(instr(10 downto 7), instr(12 downto 11), instr(5), instr(6), B"00")
  val cLwImm = Cat(instr(5), instr(12 downto 10), instr(6), B"00")
  val cLwspImm = Cat(instr(3 downto 2), instr(12), instr(6 downto 4), B"00")
  val cSwspImm = Cat(instr(8 downto 7), instr(12 downto 9), B"00")
  val cJImm = Cat(instr(12), instr(8), instr(10), instr(9), instr(6), instr(7),
    instr(2), instr(11), instr(5), instr(4), instr(3), B"0").asSInt
  val cBImm = Cat(instr(12), instr(6), instr(5), instr(2), instr(11), instr(10),
    instr(4), instr(3), B"0").asSInt
  val cAddi16sp = (Cat(instr(12), instr(4), instr(3), instr(5), instr(2), instr(6)) << 4).asSInt

  // RV64C doubleword forms: offsets are scaled by 8.
  val cLdImm = (Cat(instr(6 downto 5), instr(12 downto 10)) << 3).asSInt    // C.LD/C.SD
  val cLdspImm = (Cat(instr(4 downto 2), instr(12), instr(6 downto 5)) << 3).asSInt // C.LDSP
  val cSdspImm = (Cat(instr(9 downto 7), instr(12 downto 10)) << 3).asSInt   // C.SDSP

  when(isComp) {
    switch(instr(1 downto 0)) {
      is(B"00") { // Quadrant 0
        switch(cfunct3) {
          is(B"000") { // C.ADDI4SPN
            when(cAddi4spn === B(0, 10 bits)) {
              d.illegal := True; d.valid := False
            } otherwise {
              d.regWrite := True; d.aluOp := AluOp.ADD; d.aluSrc := True
              d.rs1 := U(2, 5 bits); d.rd := crdp
              d.imm := cAddi4spn.resize(xlen).asSInt
            }
          }
          is(B"010") { // C.LW
            d.regWrite := True; d.memRead := True; d.memSize := U(2, 2 bits)
            d.wbSel := WbSel.MEM; d.aluOp := AluOp.ADD; d.aluSrc := True
            d.rs1 := crs1p; d.rd := crdp; d.imm := cLwImm.resize(xlen).asSInt
          }
          is(B"011") { // C.LD (RV64)
            if (isRV64) {
              d.regWrite := True; d.memRead := True; d.memSize := U(3, 2 bits)
              d.wbSel := WbSel.MEM; d.aluOp := AluOp.ADD; d.aluSrc := True
              d.rs1 := crs1p; d.rd := crdp; d.imm := cLdImm.resize(xlen)
            } else {
              d.illegal := True; d.valid := False
            }
          }
          is(B"110") { // C.SW
            d.memWrite := True; d.memSize := U(2, 2 bits)
            d.aluOp := AluOp.ADD; d.aluSrc := True
            d.rs1 := crs1p; d.rs2 := crs2p; d.imm := cLwImm.resize(xlen).asSInt
          }
          is(B"111") { // C.SD (RV64)
            if (isRV64) {
              d.memWrite := True; d.memSize := U(3, 2 bits)
              d.aluOp := AluOp.ADD; d.aluSrc := True
              d.rs1 := crs1p; d.rs2 := crs2p; d.imm := cLdImm.resize(xlen)
            } else {
              d.illegal := True; d.valid := False
            }
          }
          default { d.illegal := True; d.valid := False }
        }
      }
      is(B"01") { // Quadrant 1
        switch(cfunct3) {
          is(B"000") { // C.ADDI / C.NOP
            d.regWrite := True; d.aluOp := AluOp.ADD; d.aluSrc := True
            d.rs1 := crd; d.rd := crd; d.imm := c6S.resize(xlen)
          }
          is(B"001") { // C.JAL (RV32) / C.ADDIW (RV64)
            if (isRV64) {
              when(crd === U(0, 5 bits)) {
                d.illegal := True; d.valid := False // C.ADDIW rd=x0 is reserved
              } otherwise {
                d.regWrite := True; d.aluOp := AluOp.ADDW; d.aluSrc := True
                d.rs1 := crd; d.rd := crd; d.imm := c6S.resize(xlen)
              }
            } else {
              d.regWrite := True; d.jump := True; d.wbSel := WbSel.PC4
              d.rd := U(1, 5 bits); d.imm := cJImm.resize(xlen)
            }
          }
          is(B"010") { // C.LI
            d.regWrite := True; d.aluOp := AluOp.ADD; d.aluSrc := True
            d.rs1 := U(0, 5 bits); d.rd := crd; d.imm := c6S.resize(xlen)
          }
          is(B"011") {
            when(crd === U(2, 5 bits)) { // C.ADDI16SP
              d.regWrite := True; d.aluOp := AluOp.ADD; d.aluSrc := True
              d.rs1 := U(2, 5 bits); d.rd := U(2, 5 bits)
              d.imm := cAddi16sp.resize(xlen)
            } otherwise { // C.LUI
              when(crd === U(0, 5 bits) || c6 === B(0, 6 bits)) {
                d.illegal := True; d.valid := False
              } otherwise {
                d.regWrite := True; d.aluOp := AluOp.ADD; d.aluSrc := True
                d.aluASrc := AluASrc.ZERO; d.rd := crd
                d.imm := (c6S << 12).resize(xlen)
              }
            }
          }
          is(B"100") {
            switch(instr(11 downto 10)) {
              is(B"00") { // C.SRLI (6-bit shamt on RV64)
                if (isRV64) {
                  d.regWrite := True; d.aluOp := AluOp.SRL; d.aluSrc := True
                  d.rs1 := crs1p; d.rd := crs1p; d.imm := cShamt
                } else {
                  when(instr(12)) { d.illegal := True; d.valid := False } otherwise {
                    d.regWrite := True; d.aluOp := AluOp.SRL; d.aluSrc := True
                    d.rs1 := crs1p; d.rd := crs1p; d.imm := cShamt
                  }
                }
              }
              is(B"01") { // C.SRAI (6-bit shamt on RV64)
                if (isRV64) {
                  d.regWrite := True; d.aluOp := AluOp.SRA; d.aluSrc := True
                  d.rs1 := crs1p; d.rd := crs1p; d.imm := cShamt
                } else {
                  when(instr(12)) { d.illegal := True; d.valid := False } otherwise {
                    d.regWrite := True; d.aluOp := AluOp.SRA; d.aluSrc := True
                    d.rs1 := crs1p; d.rd := crs1p; d.imm := cShamt
                  }
                }
              }
              is(B"10") { // C.ANDI
                d.regWrite := True; d.aluOp := AluOp.AND; d.aluSrc := True
                d.rs1 := crs1p; d.rd := crs1p; d.imm := c6S.resize(xlen)
              }
              default { // 11: C.SUB/XOR/OR/AND (RV32); C.SUBW/C.ADDW (RV64)
                when(instr(12)) {
                  if (isRV64) {
                    switch(instr(6 downto 5)) {
                      is(B"00") { // C.SUBW
                        d.regWrite := True; d.aluOp := AluOp.SUBW
                        d.rs1 := crs1p; d.rs2 := crs2p; d.rd := crs1p
                      }
                      is(B"01") { // C.ADDW
                        d.regWrite := True; d.aluOp := AluOp.ADDW
                        d.rs1 := crs1p; d.rs2 := crs2p; d.rd := crs1p
                      }
                      default { d.illegal := True; d.valid := False } // 10/11 reserved
                    }
                  } else {
                    d.illegal := True; d.valid := False
                  }
                } otherwise {
                  d.regWrite := True
                  d.aluOp := Mux(instr(6),
                    Mux(instr(5), AluOp.AND, AluOp.OR),
                    Mux(instr(5), AluOp.XOR, AluOp.SUB))
                  d.rs1 := crs1p; d.rs2 := crs2p; d.rd := crs1p
                }
              }
            }
          }
          is(B"101") { // C.J
            d.jump := True; d.wbSel := WbSel.PC4; d.rd := U(0, 5 bits)
            d.imm := cJImm.resize(xlen)
          }
          is(B"110") { // C.BEQZ
            d.branch := True; d.branchType := BranchOp.BEQ
            d.rs1 := crs1p; d.rs2 := U(0, 5 bits); d.imm := cBImm.resize(xlen)
          }
          is(B"111") { // C.BNEZ
            d.branch := True; d.branchType := BranchOp.BNE
            d.rs1 := crs1p; d.rs2 := U(0, 5 bits); d.imm := cBImm.resize(xlen)
          }
        }
      }
      is(B"10") { // Quadrant 2
        switch(cfunct3) {
          is(B"000") { // C.SLLI (6-bit shamt on RV64)
            if (isRV64) {
              d.regWrite := True; d.aluOp := AluOp.SLL; d.aluSrc := True
              d.rs1 := crd; d.rd := crd; d.imm := cShamt
            } else {
              when(instr(12)) { d.illegal := True; d.valid := False } otherwise {
                d.regWrite := True; d.aluOp := AluOp.SLL; d.aluSrc := True
                d.rs1 := crd; d.rd := crd; d.imm := cShamt
              }
            }
          }
          is(B"010") { // C.LWSP
            when(crd === U(0, 5 bits)) { d.illegal := True; d.valid := False } otherwise {
              d.regWrite := True; d.memRead := True; d.memSize := U(2, 2 bits)
              d.wbSel := WbSel.MEM; d.aluOp := AluOp.ADD; d.aluSrc := True
              d.rs1 := U(2, 5 bits); d.rd := crd; d.imm := cLwspImm.resize(xlen).asSInt
            }
          }
          is(B"011") { // C.LDSP (RV64)
            if (isRV64) {
              when(crd === U(0, 5 bits)) { d.illegal := True; d.valid := False } otherwise {
                d.regWrite := True; d.memRead := True; d.memSize := U(3, 2 bits)
                d.wbSel := WbSel.MEM; d.aluOp := AluOp.ADD; d.aluSrc := True
                d.rs1 := U(2, 5 bits); d.rd := crd; d.imm := cLdspImm.resize(xlen)
              }
            } else {
              d.illegal := True; d.valid := False
            }
          }
          is(B"100") {
            when(instr(12) === False) {
              when(crs2 === U(0, 5 bits)) {
                when(crd === U(0, 5 bits)) { // C.JR x0 is reserved
                  d.illegal := True; d.valid := False
                } otherwise { // C.JR
                  d.jump := True; d.jalr := True; d.wbSel := WbSel.PC4
                  d.rs1 := crd; d.aluSrc := True; d.imm := S(0, xlen bits)
                }
              } otherwise { // C.MV
                d.regWrite := True; d.aluOp := AluOp.ADD; d.aluASrc := AluASrc.ZERO
                d.rs2 := crs2; d.rd := crd
              }
            } otherwise {
              when(crs2 === U(0, 5 bits)) {
                when(crd === U(0, 5 bits)) { // C.EBREAK
                  d.sysOp := SysOp.EBREAK
                } otherwise { // C.JALR
                  d.regWrite := True; d.jump := True; d.jalr := True; d.wbSel := WbSel.PC4
                  d.rs1 := crd; d.rd := U(1, 5 bits); d.aluSrc := True; d.imm := S(0, xlen bits)
                }
              } otherwise { // C.ADD
                d.regWrite := True; d.aluOp := AluOp.ADD
                d.rs1 := crd; d.rs2 := crs2; d.rd := crd
              }
            }
          }
          is(B"110") { // C.SWSP
            d.memWrite := True; d.memSize := U(2, 2 bits)
            d.aluOp := AluOp.ADD; d.aluSrc := True
            d.rs1 := U(2, 5 bits); d.rs2 := crs2; d.imm := cSwspImm.resize(xlen).asSInt
          }
          is(B"111") { // C.SDSP (RV64)
            if (isRV64) {
              d.memWrite := True; d.memSize := U(3, 2 bits)
              d.aluOp := AluOp.ADD; d.aluSrc := True
              d.rs1 := U(2, 5 bits); d.rs2 := crs2; d.imm := cSdspImm.resize(xlen)
            } else {
              d.illegal := True; d.valid := False
            }
          }
          default { d.illegal := True; d.valid := False }
        }
      }
      default { d.illegal := True; d.valid := False }
    }
  } otherwise {
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
    is(M"0000111") { // Loads (FP): FLW / FLD
      if (withFloat) {
        d.fp := True
        d.fpWrite := True
        d.fpLoad := True
        d.aluSrc := True
        switch(funct3) {
          is(M"010") { // FLW
            d.memRead := True; d.wbSel := WbSel.MEM
            d.memSize := U(2, 2 bits); d.rd := rdNum
          }
          is(M"011") { // FLD (D only, RV64)
            if (withDouble) {
              d.memRead := True; d.wbSel := WbSel.MEM
              d.memSize := U(3, 2 bits); d.rd := rdNum
            } else { d.illegal := True; d.valid := False }
          }
          default { d.illegal := True; d.valid := False }
        }
      } else { d.illegal := True; d.valid := False }
    }
    is(M"0100111") { // Stores (FP): FSW / FSD
      if (withFloat) {
        d.fp := True
        d.fpStore := True
        d.memWrite := True
        d.aluSrc := True
        d.imm := immS
        switch(funct3) {
          is(M"010") { d.memSize := U(2, 2 bits) } // FSW
          is(M"011") { // FSD (D only, RV64)
            if (withDouble) { d.memSize := U(3, 2 bits) }
            else { d.illegal := True; d.valid := False }
          }
          default { d.illegal := True; d.valid := False }
        }
      } else { d.illegal := True; d.valid := False }
    }
    is(M"1010011") { // OP-FP: arithmetic, compare, classify, convert, move
      if (withFloat) {
        d.fp := True
        d.fpFmt := instr(25)
        d.fpRm := funct3.asUInt
        d.rd := rdNum
        d.rs1 := rs1Num
        d.rs2 := instr(24 downto 20).asUInt
        // D-format encodings are rejected unless the D extension is configured.
        if (!withDouble) { when(instr(25)) { d.illegal := True; d.valid := False } }
        switch(funct6) {
          is(B"000000") { d.fpWrite := True; d.fpOp := FpOp.ADD }
          is(B"000010") { d.fpWrite := True; d.fpOp := FpOp.SUB }
          is(B"000100") { d.fpWrite := True; d.fpOp := FpOp.MUL }
          is(B"000110") { d.fpWrite := True; d.fpOp := FpOp.DIV }
          is(B"010110") { d.fpWrite := True; d.fpOp := FpOp.SQRT }
          is(B"001000") { // FSGNJ / FSGNJN / FSGNJX
            d.fpWrite := True
            switch(funct3) {
              is(B"000") { d.fpOp := FpOp.SGNJ }
              is(B"001") { d.fpOp := FpOp.SGNJN }
              is(B"010") { d.fpOp := FpOp.SGNJX }
              default { d.illegal := True; d.valid := False }
            }
          }
          is(B"001010") { // FMIN / FMAX
            d.fpWrite := True
            switch(funct3) {
              is(B"000") { d.fpOp := FpOp.MIN }
              is(B"001") { d.fpOp := FpOp.MAX }
              default { d.illegal := True; d.valid := False }
            }
          }
          is(B"101000") { // FEQ / FLT / FLE
            d.regWrite := True
            d.fpIntRd := True
            switch(funct3) {
              is(B"000") { d.fpOp := FpOp.LE }
              is(B"001") { d.fpOp := FpOp.LT }
              is(B"010") { d.fpOp := FpOp.EQ }
              default { d.illegal := True; d.valid := False }
            }
          }
          is(B"111000") { // FCLASS / FMV.X.W (D-format on RV64)
            d.regWrite := True
            d.fpIntRd := True
            switch(funct3) {
              is(B"000") { d.fpOp := FpOp.MV_X_W }
              is(B"001") { d.fpOp := FpOp.CLASS }
              default { d.illegal := True; d.valid := False }
            }
          }
          is(B"111100") { // FMV.W.X (D-format on RV64)
            d.fpWrite := True
            d.fpOp := FpOp.MV_W_X
            when(funct3 =/= B"000") { d.illegal := True; d.valid := False }
          }
          is(B"110000") { // FCVT.W / WU / L / LU (int <- FP)
            d.regWrite := True
            d.fpIntRd := True
            switch(convSel) {
              is(B"00") { d.fpOp := FpOp.CVT_W_S }
              is(B"01") { d.fpOp := FpOp.CVT_WU_S }
              is(B"10") {
                if (isRV64) { d.fpOp := FpOp.CVT_L_S }
                else { d.illegal := True; d.valid := False }
              }
              default {
                if (isRV64) { d.fpOp := FpOp.CVT_LU_S }
                else { d.illegal := True; d.valid := False }
              }
            }
          }
          is(B"110100") { // FCVT.S / D .W / WU / L / LU (FP <- int)
            d.fpWrite := True
            switch(convSel) {
              is(B"00") { d.fpOp := FpOp.CVT_S_W }
              is(B"01") { d.fpOp := FpOp.CVT_S_WU }
              is(B"10") {
                if (isRV64) { d.fpOp := FpOp.CVT_S_L }
                else { d.illegal := True; d.valid := False }
              }
              default {
                if (isRV64) { d.fpOp := FpOp.CVT_S_LU }
                else { d.illegal := True; d.valid := False }
              }
            }
          }
          is(B"010000") { // FCVT.S.D / FCVT.D.S (format conversion, D only)
            // fmt (instr[25]) is the source format: 0 = D source (FCVT.S.D,
            // result single), 1 = S source (FCVT.D.S, result double).
            if (withDouble) {
              d.fpWrite := True
              when(instr(25)) { d.fpOp := FpOp.CVT_D_S } otherwise { d.fpOp := FpOp.CVT_S_D }
            } else { d.illegal := True; d.valid := False }
          }
          default { d.illegal := True; d.valid := False }
        }
      } else {
        d.illegal := True
        d.valid := False
      }
    }
    is(M"1000011") { // FMADD
      if (withFloat) {
        d.fp := True; d.fpWrite := True; d.fpOp := FpOp.FMA
        d.fpFmt := instr(25); d.fpRm := funct3.asUInt
        d.rs1 := rs1Num; d.rs2 := instr(24 downto 20).asUInt
        d.rs3 := instr(31 downto 27).asUInt; d.rd := rdNum
        if (!withDouble) { when(instr(25)) { d.illegal := True; d.valid := False } }
      } else { d.illegal := True; d.valid := False }
    }
    is(M"1000111") { // FMSUB
      if (withFloat) {
        d.fp := True; d.fpWrite := True; d.fpOp := FpOp.FMSUB
        d.fpFmt := instr(25); d.fpRm := funct3.asUInt
        d.rs1 := rs1Num; d.rs2 := instr(24 downto 20).asUInt
        d.rs3 := instr(31 downto 27).asUInt; d.rd := rdNum
        if (!withDouble) { when(instr(25)) { d.illegal := True; d.valid := False } }
      } else { d.illegal := True; d.valid := False }
    }
    is(M"1001011") { // FNMSUB
      if (withFloat) {
        d.fp := True; d.fpWrite := True; d.fpOp := FpOp.FNMSUB
        d.fpFmt := instr(25); d.fpRm := funct3.asUInt
        d.rs1 := rs1Num; d.rs2 := instr(24 downto 20).asUInt
        d.rs3 := instr(31 downto 27).asUInt; d.rd := rdNum
        if (!withDouble) { when(instr(25)) { d.illegal := True; d.valid := False } }
      } else { d.illegal := True; d.valid := False }
    }
    is(M"1001111") { // FNMADD
      if (withFloat) {
        d.fp := True; d.fpWrite := True; d.fpOp := FpOp.FNMADD
        d.fpFmt := instr(25); d.fpRm := funct3.asUInt
        d.rs1 := rs1Num; d.rs2 := instr(24 downto 20).asUInt
        d.rs3 := instr(31 downto 27).asUInt; d.rd := rdNum
        if (!withDouble) { when(instr(25)) { d.illegal := True; d.valid := False } }
      } else { d.illegal := True; d.valid := False }
    }
    is(M"0101111") { // AMO (A extension): LR / SC / AMO*
      if (withAtomic) {
        d.regWrite := True
        d.rs1 := rs1Num
        d.rs2 := instr(24 downto 20).asUInt
        d.rd := rdNum
        d.amoOp := funct5.asUInt
        // The effective address is rs1 with no offset: fold an explicit zero
        // immediate into the ALU so rs2 stays the AMO/SC operand.
        d.aluSrc := True
        d.imm := S(0, xlen bits)
        // W is funct3=010; D (funct3=011) exists only on RV64.
        val sizeOk = if (isRV64) (funct3 === M"010") || (funct3 === M"011") else funct3 === M"010"
        when(sizeOk) {
          when(funct3 === M"010") { d.memSize := U(2, 2 bits) } otherwise { d.memSize := U(3, 2 bits) }
          switch(funct5) {
            is(M"00010") { // LR.W / LR.D: ordinary load + reservation
              d.isLr := True; d.memRead := True; d.wbSel := WbSel.MEM
            }
            is(M"00011") { // SC.W / SC.D: conditional store + fail bit in rd
              d.isSc := True; d.atomic := True; d.memWrite := True
            }
            is(M"00000", M"00001", M"00100", M"01000", M"01100",
               M"10000", M"10100", M"11000", M"11100") { // AMO*.W / AMO*.D
              d.atomic := True; d.memRead := True // memRead routes the WB result + hazard
            }
            default { d.illegal := True; d.valid := False }
          }
        } otherwise {
          d.illegal := True; d.valid := False
        }
      } else {
        d.illegal := True // A-extension disabled by config
        d.valid := False
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
      if (withZbb) { // Zbb ops encoded in OP-IMM (last connect wins)
        when(funct7 === M"0110000") {
          switch(funct3) {
            is(M"001") { // clz/ctz/cpop/sext.b/sext.h (rs2 selects)
              switch(instr(24 downto 20)) {
                is(M"00000") { d.aluOp := AluOp.CLZ }
                is(M"00001") { d.aluOp := AluOp.CTZ }
                is(M"00010") { d.aluOp := AluOp.CPOP }
                is(M"00100") { d.aluOp := AluOp.SEXTB }
                is(M"00101") { d.aluOp := AluOp.SEXTH }
                default { d.illegal := True; d.valid := False }
              }
            }
            is(M"101") { d.aluOp := AluOp.ROR } // rori (RV32, 5-bit shamt)
            default {}
          }
        }
        if (isRV64) { // rori with 6-bit shamt: shamt[5] is instr(25)
          when(funct7 === M"0110001" && funct3 === M"101") { d.aluOp := AluOp.ROR }
        }
        when(funct7 === M"0010100" && funct3 === M"101" && instr(24 downto 20) === M"00111") {
          d.aluOp := AluOp.ORCB
        }
        if (!isRV64) { // rev8 rv32
          when(funct7 === M"0110100" && funct3 === M"101" && instr(24 downto 20) === M"11000") {
            d.aluOp := AluOp.REV8
          }
        }
        if (isRV64) { // rev8 rv64
          when(funct7 === M"0110101" && funct3 === M"101" && instr(24 downto 20) === M"11000") {
            d.aluOp := AluOp.REV8
          }
        }
      }
      if (withZbs) { // Zbs immediate forms (bit index in the low shamt bits)
        when(funct7 === M"0010100" && funct3 === M"001") { d.aluOp := AluOp.BSET }
        when(funct7 === M"0100100") {
          switch(funct3) {
            is(M"001") { d.aluOp := AluOp.BCLR }
            is(M"101") { d.aluOp := AluOp.BEXT }
            default {}
          }
        }
        when(funct7 === M"0110100" && funct3 === M"001") { d.aluOp := AluOp.BINV }
        if (isRV64) { // shamt[5] is carried in funct7 bit 0
          when(funct7 === M"0010101" && funct3 === M"001") { d.aluOp := AluOp.BSET }
          when(funct7 === M"0100101") {
            switch(funct3) {
              is(M"001") { d.aluOp := AluOp.BCLR }
              is(M"101") { d.aluOp := AluOp.BEXT }
              default {}
            }
          }
          when(funct7 === M"0110101" && funct3 === M"001") { d.aluOp := AluOp.BINV }
        }
      }
      if (withZbkb) { // Zbkb OP-IMM forms: brev8 and (RV32-only) zip/unzip
        when(funct7 === M"0110100" && funct3 === M"101" && instr(24 downto 20) === M"00111") {
          d.aluOp := AluOp.BREV8
        }
        if (!isRV64) { // on RV64 these encodings are SLLI/SRLI/SRAI
          when(funct7 === M"0000100" && instr(24 downto 20) === M"01111") {
            switch(funct3) {
              is(M"001") { d.aluOp := AluOp.ZIP }
              is(M"101") { d.aluOp := AluOp.UNZIP }
              default {}
            }
          }
        }
      }
      if (withZknh) { // Zknh SHA-2 ops (funct7=0001000, funct3=001, rs2 selects)
        when(funct7 === M"0001000" && funct3 === M"001") {
          switch(instr(24 downto 20)) {
            is(M"00000") { d.aluOp := AluOp.SHA256SUM0 }
            is(M"00001") { d.aluOp := AluOp.SHA256SUM1 }
            is(M"00010") { d.aluOp := AluOp.SHA256SIG0 }
            is(M"00011") { d.aluOp := AluOp.SHA256SIG1 }
            // SHA-512 64-bit forms exist only on RV64; on RV32 these are the
            // R-type split forms and the OP-IMM encodings are reserved.
            is(M"00100") {
              if (isRV64) { d.aluOp := AluOp.SHA512SUM0 } else { d.illegal := True; d.valid := False }
            }
            is(M"00101") {
              if (isRV64) { d.aluOp := AluOp.SHA512SUM1 } else { d.illegal := True; d.valid := False }
            }
            is(M"00110") {
              if (isRV64) { d.aluOp := AluOp.SHA512SIG0 } else { d.illegal := True; d.valid := False }
            }
            is(M"00111") {
              if (isRV64) { d.aluOp := AluOp.SHA512SIG1 } else { d.illegal := True; d.valid := False }
            }
            default { d.illegal := True; d.valid := False }
          }
        }
      }
      if (withZksh) { // Zksh SM3 ops share the Zknh OP-IMM encoding (funct7=0001000, funct3=001)
        when(funct7 === M"0001000" && funct3 === M"001") {
          switch(instr(24 downto 20)) {
            is(M"01000") { d.aluOp := AluOp.SM3P0; d.illegal := False; d.valid := True }
            is(M"01001") { d.aluOp := AluOp.SM3P1; d.illegal := False; d.valid := True }
            default {
              // Selectors 0..7 belong to Zknh; only illegal when it is disabled.
              if (!withZknh) { d.illegal := True; d.valid := False }
            }
          }
        }
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
        if (withZbb) { // RV64 Zbb W-suffix counts and roriw
          when(funct7 === M"0110000") {
            switch(funct3) {
              is(M"001") {
                switch(instr(24 downto 20)) {
                  is(M"00000") { d.aluOp := AluOp.CLZW }
                  is(M"00001") { d.aluOp := AluOp.CTZW }
                  is(M"00010") { d.aluOp := AluOp.CPOPW }
                  default { d.illegal := True; d.valid := False }
                }
              }
              is(M"101") { d.aluOp := AluOp.RORW }
              default {}
            }
          }
        }
        if (withZba) { // Zba slli.uw: funct6=000010, 6-bit shamt in imm[5:0]
          when(funct6 === M"000010" && funct3 === M"001") { d.aluOp := AluOp.SLLIUW }
        }
      } else {
        d.illegal := True
        d.valid := False
      }
    }
    is(M"0111011") { // OP-32 (RV64): ADDW/SUBW/SLLW/SRLW/SRAW and RV64M W forms
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
          is(M"0000001") { // RV64M W forms
            if (withMulDiv) {
              switch(funct3) {
                is(M"000") { d.aluOp := AluOp.MULW }
                is(M"100") { d.aluOp := AluOp.DIVW }
                is(M"101") { d.aluOp := AluOp.DIVUW }
                is(M"110") { d.aluOp := AluOp.REMW }
                is(M"111") { d.aluOp := AluOp.REMUW }
                default { d.illegal := True; d.valid := False }
              }
            } else {
              d.illegal := True // M-extension disabled by config
              d.valid := False
            }
          }
          default { d.illegal := True; d.valid := False }
        }
        if (withZbb) { // RV64 Zbb W-suffix: rolw/rorw and zext.h
          when(funct7 === M"0110000") {
            switch(funct3) {
              is(M"001") { d.aluOp := AluOp.ROLW; d.illegal := False; d.valid := True }
              is(M"101") { d.aluOp := AluOp.RORW; d.illegal := False; d.valid := True }
              default {}
            }
          }
          when(funct7 === M"0000100" && funct3 === M"100") {
            d.aluOp := AluOp.ZEXTH; d.illegal := False; d.valid := True
          }
        }
        if (withZba) { // Zba RV64 word forms: add.uw and sh*add.uw
          when(funct7 === M"0000100" && funct3 === M"000") {
            d.aluOp := AluOp.ADDUW; d.illegal := False; d.valid := True
          }
          when(funct7 === M"0010000") {
            switch(funct3) {
              is(M"010") { d.aluOp := AluOp.SH1ADDUW; d.illegal := False; d.valid := True }
              is(M"100") { d.aluOp := AluOp.SH2ADDUW; d.illegal := False; d.valid := True }
              is(M"110") { d.aluOp := AluOp.SH3ADDUW; d.illegal := False; d.valid := True }
              default {}
            }
          }
        }
        if (withZbkb) { // Zbkb RV64 word form: packw (shares the zext.h encoding)
          when(funct7 === M"0000100" && funct3 === M"100") {
            d.aluOp := AluOp.PACKW; d.illegal := False; d.valid := True
          }
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
      if (withZbb) { // Zbb register-register ops (last connect wins over RV32I)
        when(funct7 === M"0100000") {
          switch(funct3) {
            is(M"100") { d.aluOp := AluOp.XNOR }
            is(M"110") { d.aluOp := AluOp.ORN }
            is(M"111") { d.aluOp := AluOp.ANDN }
            default {}
          }
        }
        when(funct7 === M"0000101") {
          switch(funct3) {
            is(M"100") { d.aluOp := AluOp.MIN }
            is(M"101") { d.aluOp := AluOp.MINU }
            is(M"110") { d.aluOp := AluOp.MAX }
            is(M"111") { d.aluOp := AluOp.MAXU }
            default {}
          }
        }
        when(funct7 === M"0110000") {
          switch(funct3) {
            is(M"001") { d.aluOp := AluOp.ROL }
            is(M"101") { d.aluOp := AluOp.ROR }
            default {}
          }
        }
        if (!isRV64) { // zext.h uses OP on RV32, OP-32 on RV64
          when(funct7 === M"0000100" && funct3 === M"100") { d.aluOp := AluOp.ZEXTH }
        }
      }
      if (withZbs) { // Zbs register forms (bit index from rs2's low bits)
        when(funct7 === M"0010100" && funct3 === M"001") { d.aluOp := AluOp.BSET }
        when(funct7 === M"0100100") {
          switch(funct3) {
            is(M"001") { d.aluOp := AluOp.BCLR }
            is(M"101") { d.aluOp := AluOp.BEXT }
            default {}
          }
        }
        when(funct7 === M"0110100" && funct3 === M"001") { d.aluOp := AluOp.BINV }
      }
      if (withZba) { // Zba sh1add/sh2add/sh3add (RV32 and RV64)
        when(funct7 === M"0010000") {
          switch(funct3) {
            is(M"010") { d.aluOp := AluOp.SH1ADD }
            is(M"100") { d.aluOp := AluOp.SH2ADD }
            is(M"110") { d.aluOp := AluOp.SH3ADD }
            default {}
          }
        }
      }
      if (withZbkb) { // Zbkb register forms: pack/packh (share the zext.h encoding)
        when(funct7 === M"0000100") {
          switch(funct3) {
            is(M"100") { d.aluOp := AluOp.PACK }
            is(M"111") { d.aluOp := AluOp.PACKH }
            default {}
          }
        }
      }
      if (withZbc || withZbkc) { // Zbc/Zbkc carry-less multiply (shares funct7 with Zbb min/max)
        when(funct7 === M"0000101") {
          switch(funct3) {
            is(M"001") { d.aluOp := AluOp.CLMUL }
            is(M"011") { d.aluOp := AluOp.CLMULH }
            is(M"010") { if (withZbc) { d.aluOp := AluOp.CLMULR } } // Zbkc omits clmulr
            default {}
          }
        }
      }
      if (withZbkx) { // Zbkx crossbar permutations (nibble/byte lookup)
        when(funct7 === M"0010100") {
          switch(funct3) {
            is(M"010") { d.aluOp := AluOp.XPERM4 }
            is(M"100") { d.aluOp := AluOp.XPERM8 }
            default {}
          }
        }
      }
      if (withZknh && !isRV64) { // Zknh RV32 SHA-512 split forms (OP, funct3=000)
        when(funct3 === M"000") {
          switch(funct7) {
            is(M"0101000") { d.aluOp := AluOp.SHA512SUM0R }
            is(M"0101001") { d.aluOp := AluOp.SHA512SUM1R }
            is(M"0101010") { d.aluOp := AluOp.SHA512SIG0L }
            is(M"0101110") { d.aluOp := AluOp.SHA512SIG0H }
            is(M"0101011") { d.aluOp := AluOp.SHA512SIG1L }
            is(M"0101111") { d.aluOp := AluOp.SHA512SIG1H }
            default {}
          }
        }
      }
      if (withZksed) { // Zksed SM4 ops: funct3=000, funct5=instr[29:25], bs=instr[31:30]
        when(funct3 === M"000") {
          switch(instr(29 downto 25)) {
            is(M"11000") { d.aluOp := AluOp.SM4ED; d.bs := instr(31 downto 30).asUInt; d.illegal := False; d.valid := True }
            is(M"11010") { d.aluOp := AluOp.SM4KS; d.bs := instr(31 downto 30).asUInt; d.illegal := False; d.valid := True }
            default {}
          }
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
}
