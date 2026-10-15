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
  // Zbkb crypto bit manipulation: pack/packh/packw, brev8, and zip/unzip
  // (zip/unzip are RV32-only; the RV64 datapath is pruned by the decoder).
  val PACK, PACKH, PACKW, BREV8, ZIP, UNZIP = newElement()
  // Zbkx crossbar permutations: gather a nibble/byte from operand a using the
  // index held in the matching group of operand b.
  val XPERM4, XPERM8 = newElement()
  // RV64 Zbb W-suffix: 32-bit count/rotate, result sign-extended to xlen.
  val CLZW, CTZW, CPOPW, ROLW, RORW = newElement()
  // Zknh SHA-2 hash bit manipulation. The sha256* and (RV32) sha512* split
  // forms operate on the low 32 bits and sign-extend; the RV64 sha512* forms
  // operate on the full 64-bit operand.
  val SHA256SUM0, SHA256SUM1, SHA256SIG0, SHA256SIG1 = newElement()
  val SHA512SUM0, SHA512SUM1, SHA512SIG0, SHA512SIG1 = newElement()
  val SHA512SUM0R, SHA512SUM1R = newElement()
  val SHA512SIG0L, SHA512SIG0H, SHA512SIG1L, SHA512SIG1H = newElement()
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

  // Zbkx: crossbar permutation. Operand a is the lookup table of
  // (xlen / groupBits) groups; each group i of operand b holds the index that
  // selects the group written to group i of the result. An out-of-range index
  // yields zero. groupBits is 4 (xperm4, index width 2) or 8 (xperm8, width 3).
  private def xpermN(table: Bits, idxs: Bits, groupLog2: Int): Bits = {
    val groupBits = 1 << groupLog2
    val groups = xlen / groupBits
    val out = Bits(xlen bits)
    for (i <- 0 until groups) {
      // Each index occupies a full group (nibble for xperm4, byte for xperm8) and
      // selects the matching group of the table; out-of-range indices yield zero.
      val idx = idxs(i * groupBits + groupBits - 1 downto i * groupBits).asUInt
      val gathered = (0 until groups).foldLeft(B(0, groupBits bits)) { (acc, g) =>
        Mux(idx === g, table(g * groupBits + groupBits - 1 downto g * groupBits), acc)
      }
      out(i * groupBits + groupBits - 1 downto i * groupBits) := gathered
    }
    out
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

  // Byte-width-preserving shifts used by the SHA-2 hash instructions, which use
  // constant rotate/shift amounts and truncate to the operation width (like the
  // C `reg_t` arithmetic in the reference model). Spinal's `>>` on UInt narrows
  // the result, so both directions are explicitly resized back to `w`.
  private def shlW(x: UInt, n: Int, w: Int): UInt = (x << n).resize(w)
  private def shrW(x: UInt, n: Int, w: Int): UInt = (x >> n).resize(w)
  private def rotrW(x: UInt, n: Int, w: Int): UInt = shrW(x, n, w) | shlW(x, w - n, w)

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
    // ---- Zbkb: crypto bit manipulation ----
    is(AluOp.PACK) {
      val half = xlen / 2
      result := ((bU(half - 1 downto 0) << half).resize(xlen) |
        aU(half - 1 downto 0).resize(xlen)).asBits
    }
    is(AluOp.PACKH) {
      result := ((bU(7 downto 0) << 8).resize(xlen) | aU(7 downto 0).resize(xlen)).asBits
    }
    is(AluOp.PACKW) { // RV64: pack the low 16 bits, then sign-extend to 64
      val lo = aU(15 downto 0).resize(32)
      val hi = (bU(15 downto 0).resize(32) << 16).resize(32)
      result := (lo | hi).asSInt.resize(xlen).asBits
    }
    is(AluOp.BREV8) { // reverse the bit order within each byte
      val out = Bits(xlen bits)
      for (k <- 0 until xlen / 8; j <- 0 until 8) out(8 * k + j) := io.a(8 * k + 7 - j)
      result := out
    }
    is(AluOp.ZIP) { // RV32: low half -> even bit positions, high half -> odd
      val out = Bits(xlen bits)
      val half = xlen / 2
      for (i <- 0 until half) { out(2 * i) := io.a(i); out(2 * i + 1) := io.a(i + half) }
      result := out
    }
    is(AluOp.UNZIP) { // RV32: inverse of zip
      val out = Bits(xlen bits)
      val half = xlen / 2
      for (i <- 0 until half) { out(i) := io.a(2 * i); out(i + half) := io.a(2 * i + 1) }
      result := out
    }
    // ---- Zbkx: crossbar permutations ----
    is(AluOp.XPERM4) { result := xpermN(io.a, io.b, 2) }
    is(AluOp.XPERM8) { result := xpermN(io.a, io.b, 3) }
    // RV64 Zbb W-suffix: operate on the low 32 bits, sign-extend the result.
    is(AluOp.CLZW)  { result := clzN(io.a(31 downto 0), 32).resize(xlen).asBits }
    is(AluOp.CTZW)  { result := ctzN(io.a(31 downto 0), 32).resize(xlen).asBits }
    is(AluOp.CPOPW) { result := cpopN(io.a(31 downto 0), 32).resize(xlen).asBits }
    is(AluOp.ROLW)  { result := rotlN(aWU, shamtW, 32).asSInt.resize(xlen).asBits }
    is(AluOp.RORW)  { result := rotrN(aWU, shamtW, 32).asSInt.resize(xlen).asBits }
    // ---- Zknh: SHA-2 hash bit manipulation ----
    // SHA-256 forms operate on the low 32 bits and sign-extend to xlen.
    is(AluOp.SHA256SUM0) {
      val a = aU.resize(32)
      result := (rotrW(a, 2, 32) ^ rotrW(a, 13, 32) ^ rotrW(a, 22, 32)).asSInt.resize(xlen).asBits
    }
    is(AluOp.SHA256SUM1) {
      val a = aU.resize(32)
      result := (rotrW(a, 6, 32) ^ rotrW(a, 11, 32) ^ rotrW(a, 25, 32)).asSInt.resize(xlen).asBits
    }
    is(AluOp.SHA256SIG0) {
      val a = aU.resize(32)
      result := (rotrW(a, 7, 32) ^ rotrW(a, 18, 32) ^ shrW(a, 3, 32)).asSInt.resize(xlen).asBits
    }
    is(AluOp.SHA256SIG1) {
      val a = aU.resize(32)
      result := (rotrW(a, 17, 32) ^ rotrW(a, 19, 32) ^ shrW(a, 10, 32)).asSInt.resize(xlen).asBits
    }
    // RV64 SHA-512 forms operate on the full 64-bit operand.
    is(AluOp.SHA512SUM0) {
      val a = aU.resize(64)
      result := (rotrW(a, 28, 64) ^ rotrW(a, 34, 64) ^ rotrW(a, 39, 64)).resize(xlen).asBits
    }
    is(AluOp.SHA512SUM1) {
      val a = aU.resize(64)
      result := (rotrW(a, 14, 64) ^ rotrW(a, 18, 64) ^ rotrW(a, 41, 64)).resize(xlen).asBits
    }
    is(AluOp.SHA512SIG0) {
      val a = aU.resize(64)
      result := (rotrW(a, 1, 64) ^ rotrW(a, 8, 64) ^ shrW(a, 7, 64)).resize(xlen).asBits
    }
    is(AluOp.SHA512SIG1) {
      val a = aU.resize(64)
      result := (rotrW(a, 19, 64) ^ rotrW(a, 61, 64) ^ shrW(a, 6, 64)).resize(xlen).asBits
    }
    // RV32 SHA-512 split forms: 32-bit results (sign-extended by the RV32 xlen).
    is(AluOp.SHA512SUM0R) {
      val a = aU.resize(32); val b = bU.resize(32)
      val r = shlW(a, 25, 32) ^ shlW(a, 30, 32) ^ shrW(a, 28, 32) ^ shrW(b, 7, 32) ^ shrW(b, 2, 32) ^ shlW(b, 4, 32)
      result := r.asSInt.resize(xlen).asBits
    }
    is(AluOp.SHA512SUM1R) {
      val a = aU.resize(32); val b = bU.resize(32)
      val r = shlW(a, 23, 32) ^ shrW(a, 14, 32) ^ shrW(a, 18, 32) ^ shrW(b, 9, 32) ^ shlW(b, 18, 32) ^ shlW(b, 14, 32)
      result := r.asSInt.resize(xlen).asBits
    }
    is(AluOp.SHA512SIG0L) {
      val a = aU.resize(32); val b = bU.resize(32)
      val r = shrW(a, 1, 32) ^ shrW(a, 7, 32) ^ shrW(a, 8, 32) ^ shlW(b, 31, 32) ^ shlW(b, 25, 32) ^ shlW(b, 24, 32)
      result := r.asSInt.resize(xlen).asBits
    }
    is(AluOp.SHA512SIG0H) {
      val a = aU.resize(32); val b = bU.resize(32)
      val r = shrW(a, 1, 32) ^ shrW(a, 7, 32) ^ shrW(a, 8, 32) ^ shlW(b, 31, 32) ^ shlW(b, 24, 32)
      result := r.asSInt.resize(xlen).asBits
    }
    is(AluOp.SHA512SIG1L) {
      val a = aU.resize(32); val b = bU.resize(32)
      val r = shlW(a, 3, 32) ^ shrW(a, 6, 32) ^ shrW(a, 19, 32) ^ shrW(b, 29, 32) ^ shlW(b, 26, 32) ^ shlW(b, 13, 32)
      result := r.asSInt.resize(xlen).asBits
    }
    is(AluOp.SHA512SIG1H) {
      val a = aU.resize(32); val b = bU.resize(32)
      val r = shlW(a, 3, 32) ^ shrW(a, 6, 32) ^ shrW(a, 19, 32) ^ shrW(b, 29, 32) ^ shlW(b, 13, 32)
      result := r.asSInt.resize(xlen).asBits
    }
  }
  io.result := result
}
