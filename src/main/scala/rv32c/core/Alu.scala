package rv32c.core

import spinal.core._

object AluOp extends SpinalEnum {
  val ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND = newElement()
  // RV64I W-suffix: operate on the low 32 bits, sign-extend the result to xlen.
  val ADDW, SUBW, SLLW, SRLW, SRAW = newElement()
  val MUL, MULH, MULHSU, MULHU = newElement()
  val DIV, DIVU, REM, REMU = newElement()
  // RV64M W-suffix: 32-bit multiply/divide, result sign-extended to xlen.
  val MULW, DIVW, DIVUW, REMW, REMUW = newElement()
  // Zbb (basic bit manipulation). The immediate and register forms of the
  // shift-based ops share an opcode; operand b holds the register or immediate
  // value and only its low log2Up(xlen) bits select the bit/rotation.
  val ANDN, ORN, XNOR = newElement()
  val CLZ, CTZ, CPOP = newElement()
  val SEXTB, SEXTH, ZEXTH = newElement()
  val ORCB, REV8 = newElement()
  val ROL, ROR = newElement()
  val MIN, MINU, MAX, MAXU = newElement()
  // Zbs single-bit operations: set/clear/invert/test the bit selected by the
  // low log2(xlen) bits of operand b (register or immediate).
  val BSET, BCLR, BINV, BEXT = newElement()
  // Zba address generation: rd = (rs1 << k) + rs2. The word forms ("uw")
  // zero-extend rs1's low 32 bits before shifting/adding on RV64.
  val SH1ADD, SH2ADD, SH3ADD = newElement()
  val ADDUW, SH1ADDUW, SH2ADDUW, SH3ADDUW, SLLIUW = newElement()
  // Zbc carry-less multiply: low / high / reversed halves of the GF(2) product.
  val CLMUL, CLMULH, CLMULR = newElement()
  // RV64 Zbb W-suffix: 32-bit count/rotate, result sign-extended to xlen.
  val CLZW, CTZW, CPOPW, ROLW, RORW = newElement()
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

  // RV64 W-suffix operands: low 32 bits, with a 5-bit shift amount.
  val aW = aS(31 downto 0)
  val bW = bS(31 downto 0)
  val aWU = aU(31 downto 0)
  val shamtW = io.b(4 downto 0).asUInt

  // Zbs: one-hot mask selecting the bit index held in the low log2(xlen) bits
  // of operand b. The shift amount is already width-clamped, so the mask stays
  // in range for both the register and immediate forms.
  val bitOneHot = (U(1, xlen bits) << shamt).resize(xlen)

  // Zba: zero-extended low 32 bits of operand a (identity on RV32), used by the
  // RV64 word forms add.uw / slli.uw / sh*add.uw.
  val aZext = aU(31 downto 0).resize(xlen)

  // Zbc: full 2*xlen-bit carry-less (GF(2)) product = XOR of (aU << i) over
  // every set bit i of bU. clmul reads the low half, clmulh the high half and
  // clmulr the high half shifted down by one bit.
  val clmulFull: UInt = {
    var acc = U(0, (2 * xlen) bits)
    for (i <- 0 until xlen) {
      val term = (aU << i).resize(2 * xlen)
      acc = acc ^ Mux(bU(i), term, U(0, (2 * xlen) bits))
    }
    acc
  }

  // ----- Zbb bit-manipulation helpers -----
  // Count leading/trailing zeros and population count for an arbitrary width.
  // Scala `var`s combined with Mux keep the scan purely combinational.
  private def clzN(x: Bits, w: Int): UInt = {
    val rw = log2Up(w + 1)
    var res = U(w, rw bits)
    var active = True
    for (i <- w - 1 downto 0) {
      res = Mux(active && x(i), U(w - 1 - i, rw bits), res)
      active = active && !x(i)
    }
    res
  }
  private def ctzN(x: Bits, w: Int): UInt = {
    val rw = log2Up(w + 1)
    var res = U(w, rw bits)
    var active = True
    for (i <- 0 until w) {
      res = Mux(active && x(i), U(i, rw bits), res)
      active = active && !x(i)
    }
    res
  }
  private def cpopN(x: Bits, w: Int): UInt = {
    val rw = log2Up(w + 1)
    var res = U(0, rw bits)
    for (b <- x.asBools) res = (res +^ b.asUInt).resize(rw)
    res
  }
  private def rotlN(x: UInt, s: UInt, w: Int): UInt = {
    val sw = log2Up(w + 1)
    val sh = s.resize(sw)
    val left = (x << sh.resize(log2Up(w))).resize(w)
    val right = x >> (U(w, sw bits) - sh)
    Mux(s === 0, x, left | right)
  }
  private def rotrN(x: UInt, s: UInt, w: Int): UInt = {
    val sw = log2Up(w + 1)
    val sh = s.resize(sw)
    val right = x >> sh
    val left = (x << (U(w, sw bits) - sh)).resize(w)
    Mux(s === 0, x, right | left)
  }

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
    // RV64I W-suffix: 32-bit operation, result sign-extended to xlen.
    is(AluOp.ADDW) {
      result := (aW + bW).resize(xlen).asBits
    }
    is(AluOp.SUBW) {
      result := (aW - bW).resize(xlen).asBits
    }
    is(AluOp.SLLW) {
      result := (aWU << shamtW).resize(32).asSInt.resize(xlen).asBits
    }
    is(AluOp.SRLW) {
      result := (aWU >> shamtW).resize(32).asSInt.resize(xlen).asBits
    }
    is(AluOp.SRAW) {
      result := (aW >> shamtW).resize(xlen).asBits
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
    // RV64M W-suffix: MULW is combinational (low 32 bits of the product,
    // sign-extended); DIVW/DIVUW/REMW/REMUW run on the divider in the pipeline.
    is(AluOp.MULW) {
      result := (aW * bW).resize(32).resize(xlen).asBits
    }
    is(AluOp.DIVW) {
      result := B(0, xlen bits)
    }
    is(AluOp.DIVUW) {
      result := B(0, xlen bits)
    }
    is(AluOp.REMW) {
      result := B(0, xlen bits)
    }
    is(AluOp.REMUW) {
      result := B(0, xlen bits)
    }
    // ---- Zbb: basic bit manipulation ----
    is(AluOp.ANDN) { result := io.a & ~io.b }
    is(AluOp.ORN)  { result := io.a | ~io.b }
    is(AluOp.XNOR) { result := ~(io.a ^ io.b) }
    is(AluOp.CLZ)  { result := clzN(io.a, xlen).resize(xlen).asBits }
    is(AluOp.CTZ)  { result := ctzN(io.a, xlen).resize(xlen).asBits }
    is(AluOp.CPOP) { result := cpopN(io.a, xlen).resize(xlen).asBits }
    is(AluOp.SEXTB) { result := io.a(7 downto 0).asSInt.resize(xlen).asBits }
    is(AluOp.SEXTH) { result := io.a(15 downto 0).asSInt.resize(xlen).asBits }
    is(AluOp.ZEXTH) { result := io.a(15 downto 0).asUInt.resize(xlen).asBits }
    is(AluOp.ORCB) {
      val bs = (0 until xlen / 8).map(k => Mux(io.a(8 * k + 7 downto 8 * k).orR, B(0xFF, 8 bits), B(0, 8 bits)))
      result := Cat(bs)
    }
    is(AluOp.REV8) {
      val bs = (0 until xlen / 8).map(k => io.a(8 * k + 7 downto 8 * k))
      result := Cat(bs.reverse)
    }
    is(AluOp.ROL) { result := rotlN(aU, shamt, xlen).asBits }
    is(AluOp.ROR) { result := rotrN(aU, shamt, xlen).asBits }
    is(AluOp.MIN)  { result := Mux(aS < bS, io.a, io.b) }
    is(AluOp.MINU) { result := Mux(aU < bU, io.a, io.b) }
    is(AluOp.MAX)  { result := Mux(aS > bS, io.a, io.b) }
    is(AluOp.MAXU) { result := Mux(aU > bU, io.a, io.b) }
    // ---- Zbs: single-bit set/clear/invert/test ----
    is(AluOp.BSET) { result := io.a | bitOneHot.asBits }
    is(AluOp.BCLR) { result := io.a & ~bitOneHot.asBits }
    is(AluOp.BINV) { result := io.a ^ bitOneHot.asBits }
    is(AluOp.BEXT) { result := Mux((aU & bitOneHot).orR, B(1, xlen bits), B(0, xlen bits)) }
    // ---- Zba: address generation (rd = (rs1 << k) + rs2) ----
    is(AluOp.SH1ADD) { result := ((aU << 1) + bU).resize(xlen).asBits }
    is(AluOp.SH2ADD) { result := ((aU << 2) + bU).resize(xlen).asBits }
    is(AluOp.SH3ADD) { result := ((aU << 3) + bU).resize(xlen).asBits }
    // RV64 word forms: rs1's low 32 bits are zero-extended first.
    is(AluOp.ADDUW)    { result := (aZext + bU).resize(xlen).asBits }
    is(AluOp.SH1ADDUW) { result := ((aZext << 1) + bU).resize(xlen).asBits }
    is(AluOp.SH2ADDUW) { result := ((aZext << 2) + bU).resize(xlen).asBits }
    is(AluOp.SH3ADDUW) { result := ((aZext << 3) + bU).resize(xlen).asBits }
    is(AluOp.SLLIUW)   { result := (aZext << shamt).resize(xlen).asBits }
    // ---- Zbc: carry-less multiply ----
    is(AluOp.CLMUL)  { result := clmulFull(xlen - 1 downto 0).asBits }
    is(AluOp.CLMULH) { result := clmulFull(2 * xlen - 1 downto xlen).asBits }
    is(AluOp.CLMULR) { result := clmulFull(2 * xlen - 2 downto xlen - 1).asBits }
    // RV64 Zbb W-suffix: operate on the low 32 bits, sign-extend the result.
    is(AluOp.CLZW)  { result := clzN(io.a(31 downto 0), 32).resize(xlen).asBits }
    is(AluOp.CTZW)  { result := ctzN(io.a(31 downto 0), 32).resize(xlen).asBits }
    is(AluOp.CPOPW) { result := cpopN(io.a(31 downto 0), 32).resize(xlen).asBits }
    is(AluOp.ROLW)  { result := rotlN(aWU, shamtW, 32).asSInt.resize(xlen).asBits }
    is(AluOp.RORW)  { result := rotrN(aWU, shamtW, 32).asSInt.resize(xlen).asBits }
  }
  io.result := result
}
