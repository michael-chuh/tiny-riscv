package rv32c.core

import spinal.core._

object AluOp extends SpinalEnum {
  val ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND = newElement()
  val MUL, MULH, MULHSU, MULHU = newElement()
  val DIV, DIVU, REM, REMU = newElement()
}

object BranchOp extends SpinalEnum {
  val NONE, BEQ, BNE, BLT, BGE, BLTU, BGEU = newElement()
}

class Alu(xlen: Int) extends Component {
  val io = new Bundle {
    val a = in Bits(xlen bits)
    val b = in Bits(xlen bits)
    val op = in(AluOp())
    val result = out Bits(xlen bits)
  }

  val aU = io.a.asUInt
  val bU = io.b.asUInt
  val aS = io.a.asSInt
  val bS = io.b.asSInt
  val shamt = io.b(log2Up(xlen) - 1 downto 0).asUInt

  // ----- Multiplication helpers (full-width products) -----
  val mulUU = aU * bU                       // unsigned * unsigned (2*xlen bits)
  val mulSS = aS * bS                       // signed   * signed   (2*xlen bits)
  val aSE = aS.resize(xlen + 1)             // sign-extended a
  val bUE = bU.resize(xlen + 1).asSInt      // zero-extended b (unsigned as SInt)
  val mulSU = aSE * bUE                     // signed a * unsigned b (2*xlen+2 bits)

  val mulLow = mulUU.asBits(xlen - 1 downto 0)
  val mulHighS = mulSS.asBits(2 * xlen - 1 downto xlen)
  val mulHighSu = mulSU.asBits(2 * xlen - 1 downto xlen)
  val mulHighU = mulUU.asBits(2 * xlen - 1 downto xlen)

  val result = Bits(xlen bits)
  switch(io.op) {
    is(AluOp.ADD) {
      result := (aU + bU).asBits
    }
    is(AluOp.SUB) {
      result := (aU - bU).asBits
    }
    is(AluOp.SLL) {
      result := (aU << shamt).resize(xlen).asBits
    }
    is(AluOp.SLT) {
      result := Mux(aS < bS, B(1, xlen bits), B(0, xlen bits))
    }
    is(AluOp.SLTU) {
      result := Mux(aU < bU, B(1, xlen bits), B(0, xlen bits))
    }
    is(AluOp.XOR) {
      result := io.a ^ io.b
    }
    is(AluOp.SRL) {
      result := (aU >> shamt).resize(xlen).asBits
    }
    is(AluOp.SRA) {
      result := (aS >> shamt).resize(xlen).asBits
    }
    is(AluOp.OR) {
      result := io.a | io.b
    }
    is(AluOp.AND) {
      result := io.a & io.b
    }
    // RV32M: multiply (combinational)
    is(AluOp.MUL) {
      result := mulLow
    }
    is(AluOp.MULH) {
      result := mulHighS
    }
    is(AluOp.MULHSU) {
      result := mulHighSu
    }
    is(AluOp.MULHU) {
      result := mulHighU
    }
    // RV32M: divide/remainder are executed by the multi-cycle divider in the
    // pipeline (see core/MulDiv.scala); the ALU result is unused for them.
    is(AluOp.DIV) {
      result := B(0, xlen bits)
    }
    is(AluOp.DIVU) {
      result := B(0, xlen bits)
    }
    is(AluOp.REM) {
      result := B(0, xlen bits)
    }
    is(AluOp.REMU) {
      result := B(0, xlen bits)
    }
  }
  io.result := result
}
