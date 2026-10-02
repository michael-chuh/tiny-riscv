package rv32c.core

import spinal.core._
import spinal.lib._

/** IEEE-754 floating-point unit for one binary format.
  *
  * Parameterized by the exponent and significand widths (`expw`/`sigw`), so the
  * same RTL serves binary32 (expw=8, sigw=23) and binary64 (expw=11, sigw=52).
  * The unit is purely combinational: the pipeline inserts a single freeze cycle
  * while the instruction issues, after which the result rides the normal
  * EX -> MEM -> WB path. All arithmetic is computed at a working precision of
  * P+3 bits (implicit bit + 3 guard/round/sticky bits) so a single rounding step
  * at the end implements RNE/RTZ/RDN/RUP/RMM exactly.
  *
  * Flag bits (io.flags): NV=4 DZ=3 OF=2 UF=1 NX=0, matching `fflags`.
  */
class FpUnit(expw: Int, sigw: Int) extends Component {
  val flen = 1 + expw + sigw
  val P = sigw + 1          // significand incl. implicit bit
  val WM = P + 3            // working mantissa incl. G/R/S
  val bias = (1 << (expw - 1)) - 1
  val emin = 1 - bias
  val emax = bias
  val expMax = (1 << expw) - 1
  val canonNaN = (((BigInt(1) << expw) - 1) << sigw) | (BigInt(1) << (sigw - 1)) // +qNaN

  val io = new Bundle {
    val op = in UInt (6 bits)
    val rm = in UInt (3 bits)
    val a = in Bits (64 bits)
    val b = in Bits (64 bits)
    val c = in Bits (64 bits)
    val result = out Bits (64 bits)
    val flags = out Bits (5 bits)
  }

  // ===== classification / unpacking =====
  case class FP(sign: Bool, e: SInt, sig: UInt, isZero: Bool, isInf: Bool,
      isNaN: Bool, isSNaN: Bool, isSubnormal: Bool)

  def unpack(x: Bits): FP = {
    val sign = x(flen - 1)
    val ef = x(flen - 2 downto sigw)
    val frac = x(sigw - 1 downto 0)
    val expZero = ef === 0
    val expAll = ef.andR
    val fracZero = frac === 0
    val isZero = expZero && fracZero
    val isInf = expAll && fracZero
    val isNaN = expAll && !fracZero
    val isSNaN = isNaN && !frac(sigw - 1)
    val isSubnormal = expZero && !fracZero
    val e = Mux(expZero, S(emin, expw + 2 bits), ef.asUInt.resize(expw + 2).asSInt - S(bias, expw + 2 bits))
    val sig = Mux(expZero, frac.resize(P).asUInt, Cat(True, frac).asUInt)
    FP(sign, e, sig, isZero, isInf, isNaN, isSNaN, isSubnormal)
  }

  val ua = unpack(io.a)
  val ub = unpack(io.b)
  val uc = unpack(io.c)

  // ===== canonical outputs (overridden per op) =====
  val res = Bits(64 bits)
  res := B(canonNaN, flen bits).resize(64)
  val flagNV = Bool(); flagNV := False
  val flagDZ = Bool(); flagDZ := False
  val flagOF = Bool(); flagOF := False
  val flagUF = Bool(); flagUF := False
  val flagNX = Bool(); flagNX := False

  def packInfT(sign: Bool, e2: Int, s2: Int): Bits = Cat(sign, B((1 << e2) - 1, e2 bits), B(0, s2 bits)).asBits
  def packZeroT(sign: Bool, e2: Int, s2: Int): Bits = Cat(sign, B(0, e2 bits), B(0, s2 bits)).asBits
  def packFiniteT(sign: Bool, ef: UInt, frac: Bits, e2: Int, s2: Int): Bits = Cat(sign, ef, frac).asBits

  def packInf(sign: Bool): Bits = packInfT(sign, expw, sigw)
  def packZero(sign: Bool): Bits = packZeroT(sign, expw, sigw)
  def packFinite(sign: Bool, ef: UInt, frac: Bits): Bits = packFiniteT(sign, ef, frac, expw, sigw)

  /** Normalize a magnitude so its highest set bit lands at bit P+2. `e0` is the
    * exponent weight of the magnitude's LSB (value = mag * 2^e0). Returns the
    * WM-bit mantissa, the OR of bits shifted out, and the leading-bit exponent. */
  case class Norm(mant: Bits, sticky: Bool, eLead: SInt)
  def normalize(mag: UInt, e0: SInt): Norm = {
    val w = mag.getWidth
    val hiPos = UInt(log2Up(w + 1) bits)
    hiPos := 0
    for (i <- 0 until w) { when(mag(i)) { hiPos := U(i) } } // ascending: highest wins
    val mant = Bits(WM bits)
    val sticky = Bool()
    mant := 0; sticky := False
    val target = P + 2
    val eLead = (hiPos.resize(expw + 4).asSInt + e0)
    when(mag =/= 0) {
      when(hiPos > U(target)) {
        val sh = hiPos - U(target)
        mant := (mag >> sh).resize(WM).asBits
        sticky := (mag & ((U(1, w bits) << sh).resize(w) - 1)).orR
      } otherwise {
        val sh = U(target) - hiPos
        mant := (mag << sh).resize(WM).asBits
        sticky := False
      }
    }
    Norm(mant, sticky, eLead)
  }

  /** Round the normalized mantissa at exponent `eLead` and pack to `flen` bits.
    * Returns (bits, inexact, overflow, underflow). */
  case class Rounded(bits: Bits, inexact: Bool, of: Bool, uf: Bool)
  def roundPack(sign: Bool, n: Norm, rm: UInt): Rounded = roundPackTo(sign, n, rm, expw, sigw)

  /** Round-and-pack to an arbitrary `(tExpw, tSigw)` target format. The source
    * `n` is normalized for this unit's precision; when narrowing, the discarded
    * low bits are folded into sticky so a single final rounding stays exact. */
  def roundPackTo(sign: Bool, n: Norm, rm: UInt, tExpw: Int, tSigw: Int): Rounded = {
    val tP = tSigw + 1
    val tWM = tP + 3
    val tBias = (1 << (tExpw - 1)) - 1
    val tEmin = 1 - tBias
    val tExpMax = (1 << tExpw) - 1
    val tFlen = 1 + tExpw + tSigw
    // Re-align the source mantissa (leading bit at P+2) so its leading bit lands
    // at tP+2; narrowing discards low bits into sticky.
    val diff = P - tP
    val wideW = scala.math.max(WM, tWM) + scala.math.abs(diff) + 2
    val srcM = n.mant.resize(wideW).asUInt
    val mantA = UInt(wideW bits)
    val stickyDrop = Bool()
    if (diff >= 0) {
      mantA := (srcM >> diff).resize(wideW)
      val mask = if (diff == 0) U(0, wideW bits) else ((U(1, wideW bits) << diff).resize(wideW) - 1)
      stickyDrop := (srcM & mask).orR
    } else {
      mantA := (srcM << (-diff)).resize(wideW)
      stickyDrop := False
    }
    val stickyIn = n.sticky || stickyDrop
    // Subnormal correction: if the leading exponent is below tEmin we must lose
    // precision so the LSB weight matches the subnormal encoding.
    val tiny = n.eLead + S(tBias, tExpw + 4 bits) < S(1, tExpw + 4 bits)
    val shS = S(tEmin, tExpw + 4 bits) - n.eLead
    val sh = Mux(tiny, shS, S(0, tExpw + 4 bits))
    val shU = sh.asUInt
    val mantS = Bits(tWM bits)
    val stickyS = Bool()
    when(sh <= 0) {
      mantS := mantA.resize(tWM).asBits
      stickyS := stickyIn
    } elsewhen (shU >= U(tWM)) {
      mantS := 0
      stickyS := mantA.orR || stickyIn
    } otherwise {
      mantS := (mantA >> shU.resize(log2Up(wideW))).resize(tWM).asBits
      stickyS := ((mantA & ((U(1, wideW bits) << shU.resize(log2Up(wideW))).resize(wideW) - 1)).orR) || stickyIn
    }
    val eLead = Mux(tiny, S(tEmin, tExpw + 4 bits), n.eLead)

    val g = mantS(2)
    val r = mantS(1)
    val s = mantS(0) || stickyS
    val trunc = mantS(tP + 2 downto 3) // tP bits
    val lsb = trunc(0)
    val inc = Mux(rm === U(0, 3 bits), g && (r || s || lsb),
              Mux(rm === U(1, 3 bits), False,
              Mux(rm === U(2, 3 bits), sign && (g || r || s),
              Mux(rm === U(3, 3 bits), !sign && (g || r || s),
                  g))))
    val sum = trunc.asUInt.resize(tP + 1) + inc.asUInt.resize(tP + 1)
    val carry = sum(tP)
    val sig = Mux(carry, (sum >> 1).resize(tP), sum.resize(tP))
    val eFinal = Mux(carry, eLead + 1, eLead)
    val biased = eFinal + S(tBias, tExpw + 4 bits)
    val inexact = g || r || s
    val of = biased >= S(tExpMax, tExpw + 4 bits)
    val uf = tiny && inexact
    val inf = packInfT(sign, tExpw, tSigw)
    val maxFin = packFiniteT(sign, U(tExpMax - 1, tExpw bits), B((BigInt(1) << tSigw) - 1, tSigw bits), tExpw, tSigw)
    val bits = Bits(tFlen bits)
    bits := B(0, tFlen bits)
    // For a tiny result the leading bit can land below the implicit position
    // (subnormal) or be rounded away entirely (zero); a normal result has the
    // leading bit at tP-1 with biased exponent eFinal + tBias.
    val isZeroResult = tiny && (sig === 0)
    val isSubnormalResult = tiny && (sig =/= 0) && !sig(tP - 1)
    when(of) {
      bits := Mux(rm === U(1, 3 bits), maxFin,
        Mux(rm === U(2, 3 bits), Mux(sign, inf, maxFin),
          Mux(rm === U(3, 3 bits), Mux(sign, maxFin, inf), inf)))
    } elsewhen (isZeroResult) {
      bits := packZeroT(sign, tExpw, tSigw)
    } elsewhen (isSubnormalResult) {
      bits := packFiniteT(sign, U(0, tExpw bits), sig(tSigw - 1 downto 0).asBits, tExpw, tSigw)
    } otherwise {
      bits := packFiniteT(sign, biased.asUInt.resize(tExpw), sig(tSigw - 1 downto 0).asBits, tExpw, tSigw)
    }
    Rounded(bits, inexact, of, uf)
  }

  // ===== ADD / SUB (and the addend half of FMA reuse this shape) =====
  def addSub(signA: Bool, eA: SInt, sigA: UInt,
             signB: Bool, eB: SInt, sigB: UInt,
             zA: Bool, zB: Bool, nanA: Bool, nanB: Bool, snanA: Bool, snanB: Bool,
             infA: Bool, infB: Bool, rm: UInt): Bits = {
    val swap = eA < eB
    val bigS = Mux(swap, signB, signA)
    val smlS = Mux(swap, signA, signB)
    val bigE = Mux(swap, eB, eA)
    val smlE = Mux(swap, eA, eB)
    val bigSig = Mux(swap, sigB, sigA).resize(WM + 1)
    val smlSig = Mux(swap, sigA, sigB).resize(WM + 1)
    val WA = WM + 1
    val bigPre = (bigSig << 3).resize(WA)
    val smlPre = (smlSig << 3).resize(WA)
    val diff = (bigE - smlE).asUInt
    val shifted = Bits(WA bits)
    val stickyAlign = Bool()
    when(diff >= U(WA)) {
      shifted := 0
      stickyAlign := smlPre.orR
    } otherwise {
      shifted := (smlPre >> diff).resize(WA).asBits
      stickyAlign := (smlPre & ((U(1, WA bits) << diff.resize(log2Up(WA))).resize(WA) - 1)).orR
    }
    val sameSign = bigS === smlS
    val sub = !sameSign
    val bigU = bigPre
    val shU = shifted.asUInt
    val borrow = sub && (bigU < shU)
    val mag = Mux(sub, Mux(borrow, shU - bigU, bigU - shU), bigU + shU)
    val resSign = Mux(borrow, smlS, bigS)
    val e0 = bigE - S(P + 2, expw + 4 bits)
    val n = normalize(mag, e0)
    val exactZero = mag === 0
    val r = roundPack(resSign, n, rm)
    val bits = Bits(flen bits)
    bits := r.bits
    // Any NaN -> canonical NaN (NV on signaling). +Inf + -Inf -> NV.
    val anyNaN = nanA || nanB
    val anySNaN = snanA || snanB
    val infMinusInf = infA && infB && (signA =/= signB)
    when(anyNaN) { bits := B(canonNaN, flen bits); flagNV := anySNaN }
    .elsewhen(infMinusInf) { bits := B(canonNaN, flen bits); flagNV := True }
    .elsewhen(infA) { bits := packInf(signA) }
    .elsewhen(infB) { bits := packInf(signB) }
    .elsewhen(exactZero) {
      // Exact cancellation: +0 except round-down mode.
      bits := packZero(Mux(rm === U(2, 3 bits), True, False))
    }
    .otherwise { flagNX := r.inexact; flagOF := r.of; flagUF := r.uf }
    bits
  }

  /** ADD/SUB entry point (b's sign may be flipped by the caller). */
  def doAddSub(subtract: Bool, rm: UInt): Bits =
    addSub(ua.sign, ua.e, ua.sig, ub.sign ^ subtract, ub.e, ub.sig,
      ua.isZero, ub.isZero, ua.isNaN, ub.isNaN, ua.isSNaN, ub.isSNaN,
      ua.isInf, ub.isInf, rm)

  // ===== MULTIPLY =====
  def doMul(rm: UInt): Bits = {
    val sign = ua.sign ^ ub.sign
    val prod = ua.sig * ub.sig // 2P bits
    val e0 = (ua.e + ub.e) - S(2 * (P - 1), expw + 4 bits)
    val n = normalize(prod, e0)
    val r = roundPack(sign, n, rm)
    val bits = Bits(flen bits)
    bits := r.bits
    val anyNaN = ua.isNaN || ub.isNaN
    val anySNaN = ua.isSNaN || ub.isSNaN
    val infTimesZero = (ua.isInf && ub.isZero) || (ua.isZero && ub.isInf)
    when(anyNaN) { bits := B(canonNaN, flen bits); flagNV := anySNaN }
    .elsewhen(infTimesZero) { bits := B(canonNaN, flen bits); flagNV := True }
    .elsewhen(ua.isInf || ub.isInf) { bits := packInf(sign) }
    .elsewhen(ua.isZero || ub.isZero) { bits := packZero(sign) }
    .otherwise { flagNX := r.inexact; flagOF := r.of; flagUF := r.uf }
    bits
  }

  // ===== DIVIDE =====
  def doDiv(rm: UInt): Bits = {
    val sign = ua.sign ^ ub.sign
    val shift = P + 3
    val numW = P + shift + 2
    val num = (ua.sig.resize(numW) << shift)
    val q = (num / ub.sig.resize(numW)).resize(WM + 2)
    val rem = num - q.resize(numW) * ub.sig.resize(numW)
    val e0 = (ua.e - ub.e) - S(shift, expw + 4 bits)
    val n0 = normalize(q, e0)
    val stickyDiv = rem =/= 0
    val n = Norm(n0.mant, n0.sticky || stickyDiv, n0.eLead)
    val r = roundPack(sign, n, rm)
    val bits = Bits(flen bits)
    bits := r.bits
    val anyNaN = ua.isNaN || ub.isNaN
    val anySNaN = ua.isSNaN || ub.isSNaN
    val zeroDivZero = ua.isZero && ub.isZero
    val infDivInf = ua.isInf && ub.isInf
    when(anyNaN) { bits := B(canonNaN, flen bits); flagNV := anySNaN }
    .elsewhen(zeroDivZero || infDivInf) {
      bits := B(canonNaN, flen bits); flagNV := True
    }
    .elsewhen(ua.isInf) { bits := packInf(sign) }
    .elsewhen(ub.isInf) { bits := packZero(sign) }
    .elsewhen(ub.isZero) {
      bits := packInf(sign); flagDZ := True
    }
    .elsewhen(ua.isZero) { bits := packZero(sign) }
    .otherwise { flagNX := r.inexact; flagOF := r.of; flagUF := r.uf }
    bits
  }

  // ===== SQUARE ROOT =====
  def doSqrt(rm: UInt): Bits = {
    // Make the operand exponent even so sqrt halves it exactly.
    val eOdd = ua.e(0)
    val sigAdj = Mux(eOdd, (ua.sig << 1), ua.sig).resize(P + 1)
    val eAdj = Mux(eOdd, ua.e - S(1, expw + 4 bits), ua.e)
    val eRes = eAdj >> 1
    val extra = 3
    val shiftAmt = P - 1 + 2 * extra
    val numW = 2 * P + 2 * extra + 2
    val num = (sigAdj.resize(numW) << shiftAmt).resize(numW)
    // Digit-by-digit integer square root (functional: Scala vars hold the
    // per-iteration expression so no combinational feedback loops form).
    val rootW = (numW + 1) / 2 + 2
    var root: UInt = U(0, rootW bits)
    var rem: UInt = U(0, numW + 2 bits)
    for (i <- (numW - 2) to 0 by -2) {
      val remShift = ((rem << 2).resize(numW + 2) | num(i + 1 downto i).resize(numW + 2))
      val cand = ((root << 2).resize(numW + 2) | U(1, numW + 2 bits))
      val ge = remShift >= cand
      root = Mux(ge, ((root << 1).resize(rootW) | U(1, rootW bits)), (root << 1).resize(rootW))
      rem = Mux(ge, remShift - cand, remShift)
    }
    val e0 = eRes - S(P - 1 + extra, expw + 4 bits)
    val n0 = normalize(root, e0)
    val n = Norm(n0.mant, n0.sticky || (rem =/= 0), n0.eLead)
    val r = roundPack(False, n, rm)
    val bits = Bits(flen bits)
    bits := r.bits
    when(ua.isNaN) { bits := B(canonNaN, flen bits); flagNV := ua.isSNaN }
    .elsewhen(ua.sign && !ua.isZero) { bits := B(canonNaN, flen bits); flagNV := True }
    .elsewhen(ua.isInf) { bits := packInf(False) }
    .elsewhen(ua.isZero) { bits := packZero(ua.sign) }
    .otherwise { flagNX := r.inexact; flagOF := r.of; flagUF := r.uf }
    bits
  }

  // ===== FUSED MULTIPLY-ADD =====
  def doFma(negateProd: Bool, negateC: Bool, rm: UInt): Bits = {
    val pSign = ua.sign ^ ub.sign ^ negateProd
    val cSign = uc.sign ^ negateC
    val prod = ua.sig * ub.sig
    val pe = (ua.e + ub.e) - S(2 * (P - 1), expw + 4 bits)
    // `ce` is the LSB weight of the addend's significand, so the product and the
    // addend are aligned in the same fixed-point scale.
    val ce = uc.e - S(P - 1, expw + 4 bits)
    val base = Mux(pe >= ce, pe, ce)
    val FW = 2 * P + 6
    // Align both addends down to `base`.
    def alignMag(sig: UInt, e: SInt): (UInt, Bool) = {
      val sh = (base - e)
      val shU = sh.asUInt
      val m = Bits(FW bits)
      val st = Bool()
      when(sh <= 0) { m := sig.resize(FW).asBits; st := False }
      .elsewhen(shU >= U(FW)) { m := 0; st := sig.orR }
      .otherwise {
        m := (sig.resize(FW) >> shU).resize(FW).asBits
        st := (sig.resize(FW) & ((U(1, FW bits) << shU.resize(log2Up(FW))).resize(FW) - 1)).orR
      }
      (m.asUInt, st)
    }
    val (pMag, pSt) = alignMag(prod, pe)
    val (cMag, cSt) = alignMag(uc.sig, ce)
    // Signed combination at width FW+1.
    val pMagS = pMag.resize(FW + 1).asSInt
    val cMagS = cMag.resize(FW + 1).asSInt
    val pSigned = Mux(pSign, -pMagS, pMagS).resize(FW + 2)
    val cSigned = Mux(cSign, -cMagS, cMagS).resize(FW + 2)
    val total = (pSigned + cSigned).resize(FW + 2)
    val totalSign = total(total.getWidth - 1)
    val totalMag = Mux(totalSign, (-total).asUInt, total.asUInt)
    val n0 = normalize(totalMag, base)
    val n = Norm(n0.mant, n0.sticky || pSt || cSt, n0.eLead)
    val r = roundPack(totalSign, n, rm)
    val bits = Bits(flen bits)
    bits := r.bits
    val anyNaN = ua.isNaN || ub.isNaN || uc.isNaN
    val anySNaN = ua.isSNaN || ub.isSNaN || uc.isSNaN
    val infTimesZero = (ua.isInf && ub.isZero) || (ua.isZero && ub.isInf)
    val infMinusInf = (ua.isInf || ub.isInf) && uc.isInf && (pSign =/= cSign)
    val prodInf = ua.isInf || ub.isInf
    when(anyNaN) { bits := B(canonNaN, flen bits); flagNV := anySNaN }
    .elsewhen(infTimesZero) { bits := B(canonNaN, flen bits); flagNV := True }
    .elsewhen(infMinusInf) { bits := B(canonNaN, flen bits); flagNV := True }
    .elsewhen(prodInf) { bits := packInf(pSign) }
    .elsewhen(uc.isInf) { bits := packInf(cSign) }
    .otherwise { flagNX := r.inexact; flagOF := r.of; flagUF := r.uf }
    bits
  }

  // ===== SIGN INJECTION / MIN / MAX =====
  def doSgnj(mode: UInt): Bits = {
    val bits = Bits(flen bits)
    bits := io.a(flen - 1 downto 0)
    switch(mode) {
      is(FpOp.SGNJ) { bits(flen - 1) := io.b(flen - 1) }
      is(FpOp.SGNJN) { bits(flen - 1) := !io.b(flen - 1) }
      is(FpOp.SGNJX) { bits(flen - 1) := io.a(flen - 1) ^ io.b(flen - 1) }
    }
    bits
  }

  def doMinMax(isMax: Bool): Bits = {
    // Signaling NaNs raise NV even though the result is the other operand.
    flagNV := ua.isSNaN || ub.isSNaN
    // Ordering used for min/max: -Inf < ... < -0 < +0 < ... < +Inf.
    val aNaN = ua.isNaN
    val bNaN = ub.isNaN
    val bothZero = ua.isZero && ub.isZero
    val aMagLess = (ua.e < ub.e) || (ua.e === ub.e && ua.sig < ub.sig)
    val aLess = Mux(ua.sign === ub.sign,
      Mux(ua.sign, !aMagLess && !(ua.e === ub.e && ua.sig === ub.sig), aMagLess),
      ua.sign)
    val bits = Bits(flen bits)
    bits := io.a(flen - 1 downto 0)
    when(aNaN && bNaN) { bits := B(canonNaN, flen bits) }
    .elsewhen(aNaN) { bits := io.b(flen - 1 downto 0) }
    .elsewhen(bNaN) { bits := io.a(flen - 1 downto 0) }
    .elsewhen(bothZero) { bits := packZero(Mux(isMax, False, True)) }
    .otherwise {
      when(isMax) { bits := Mux(aLess, io.b(flen - 1 downto 0), io.a(flen - 1 downto 0)) }
      .otherwise { bits := Mux(aLess, io.a(flen - 1 downto 0), io.b(flen - 1 downto 0)) }
    }
    bits
  }

  // ===== COMPARE / CLASSIFY / MOVE / CONVERT =====
  def doCompare(mode: UInt): Bits = {
    val aNaN = ua.isNaN
    val bNaN = ub.isNaN
    val aZero = ua.isZero
    val bZero = ub.isZero
    val eq = !aNaN && !bNaN && ((aZero && bZero) || (ua.sign === ub.sign && ua.e === ub.e && ua.sig === ub.sig))
    val lt = (!aNaN && !bNaN) && (!(aZero && bZero)) &&
      Mux(ua.sign =/= ub.sign, ua.sign, Mux(ua.sign, ua.e > ub.e, ua.e < ub.e))
    val bits = Bits(flen bits)
    bits := B(0, flen bits)
    switch(mode) {
      is(FpOp.EQ) { bits(0) := eq }
      is(FpOp.LT) { bits(0) := lt; flagNV := (aNaN || bNaN) }
      is(FpOp.LE) { bits(0) := (eq || lt); flagNV := (aNaN || bNaN) }
    }
    bits
  }

  def doClass(): Bits = {
    val bits = Bits(flen bits)
    val r = Bits(10 bits)
    r := 0
    r(0) := ua.sign && ua.isInf
    r(1) := ua.sign && !ua.isInf && !ua.isNaN && !ua.isZero && !ua.isSubnormal // negative normal
    r(2) := ua.sign && ua.isSubnormal
    r(3) := ua.sign && ua.isZero
    r(4) := !ua.sign && ua.isZero
    r(5) := !ua.sign && ua.isSubnormal
    r(6) := !ua.sign && !ua.isInf && !ua.isNaN && !ua.isZero && !ua.isSubnormal // positive normal
    r(7) := !ua.sign && ua.isInf
    r(8) := ua.isSNaN
    r(9) := ua.isNaN && !ua.isSNaN
    bits := r.resize(flen).asBits
    bits
  }

  // FP -> signed/unsigned integer. `w` is the target width (32 or 64); `signed`.
  def doFpToInt(w: Int, signed: Boolean, rm: UInt): Bits = {
    val src = ua
    val eLead = src.e
    val shLeft = eLead - S(P - 1, expw + 4 bits)
    val magW = w + 2
    val intMag = UInt(magW bits)
    val fracNonzero = Bool()
    when(shLeft >= S(magW, expw + 4 bits)) {
      intMag := U((BigInt(1) << (magW - 1)) - 1, magW bits) // saturated high marker
      fracNonzero := True
    } .elsewhen (shLeft <= S(-(P), expw + 4 bits)) {
      intMag := 0
      fracNonzero := src.sig =/= 0
    } .elsewhen (shLeft < 0) {
      val sh = (-shLeft).asUInt
      intMag := (src.sig >> sh).resize(magW)
      fracNonzero := (src.sig & ((U(1, P bits) << sh.resize(log2Up(P))).resize(P) - 1)) =/= 0
    } .otherwise {
      intMag := (src.sig.resize(magW) << shLeft.asUInt.resize(log2Up(magW))).resize(magW)
      fracNonzero := False
    }
    val inc = Mux(rm === U(0, 3 bits), (fracNonzero && intMag(0)),
              Mux(rm === U(1, 3 bits), False,
              Mux(rm === U(2, 3 bits), (src.sign && fracNonzero),
              Mux(rm === U(3, 3 bits), (!src.sign && fracNonzero),
                  fracNonzero))))
    val magR = intMag.resize(w + 2) + inc.asUInt.resize(w + 2)
    val maxMag = if (signed) (BigInt(1) << (w - 1)) else (BigInt(1) << w) - 1
    val overflow = !src.isNaN && !src.isInf && (magR > U(maxMag, w + 2 bits))
    // A negative input to an unsigned conversion is invalid (result 0, NV).
    val negToUnsigned: Bool = if (!signed) (src.sign && !src.isZero && !src.isNaN) else False
    val bits = Bits(64 bits)
    val invalid = src.isNaN || src.isInf || overflow || negToUnsigned
    val out = UInt(w bits)
    when(invalid) {
      flagNV := True
      out := (if (signed) U((BigInt(1) << (w - 1)) - 1, w bits) else U((BigInt(1) << w) - 1, w bits))
      // -Inf / negative overflow saturates to the most-negative value; an
      // unsigned negative input saturates to zero.
      when(src.sign && !src.isNaN) { out := (if (signed) U(BigInt(1) << (w - 1), w bits) else U(0, w bits)) }
    } .otherwise {
      when(src.sign) { out := (U(0, w bits) - magR.resize(w)) } otherwise { out := magR.resize(w) }
      flagNX := fracNonzero
    }
    bits := (if (signed) out.asSInt.resize(64).asBits else out.resize(64).asBits)
    bits
  }

  // Integer -> FP (a holds the integer operand, already extended by the core).
  def doIntToFp(w: Int, signed: Boolean, rm: UInt): Bits = {
    val sgn = if (signed) io.a(w - 1) else False
    val raw = io.a(w - 1 downto 0)
    val magW = P + w
    val mag = Mux(sgn, U(0, magW bits) - raw.resize(magW).asUInt, raw.resize(magW).asUInt)
    val n = normalize(mag, S(0, expw + 4 bits))
    val r = roundPack(sgn, n, rm)
    val bits = Bits(flen bits)
    bits := r.bits
    when(mag === 0) { bits := packZero(sgn) }
    .otherwise { flagNX := r.inexact; flagOF := r.of }
    bits
  }

  // ===== FORMAT CONVERSION (bridge ops, exercised by the binary64 unit) =====
  // Single -> double is an exact widening: the source has fewer significand bits
  // than the target, so the shared normalize/roundPack path never rounds. Only
  // a signaling NaN raises NV.
  def doS2D(rm: UInt): Bits = {
    val s = io.a(31)
    val e = io.a(30 downto 23)
    val f = io.a(22 downto 0)
    val isZero = (e === 0) && (f === 0)
    val isInf = (e === 0xff) && (f === 0)
    val isNaN = (e === 0xff) && (f =/= 0)
    val isSNaN = isNaN && !f(22)
    val sub = (e === 0) && (f =/= 0)
    val sigS = Mux(sub, f.resize(P).asUInt, Cat(True, f).asUInt.resize(P))
    // Subnormal weight is 2^-149; a normal single has weight 2^(e-150).
    val e0 = Mux(sub, S(-149, expw + 4 bits),
      e.asUInt.resize(expw + 4).asSInt - S(150, expw + 4 bits))
    val r = roundPack(s, normalize(sigS, e0), rm)
    val bits = Bits(flen bits)
    bits := r.bits
    when(isNaN) { bits := B(canonNaN, flen bits); flagNV := isSNaN }
    .elsewhen(isInf) { bits := packInf(s) }
    .elsewhen(isZero) { bits := packZero(s) }
    bits
  }

  // Double -> single rounds to binary32; overflow/underflow follow the generic
  // roundPack target rules. NaN inputs collapse to the canonical single NaN.
  def doD2S(rm: UInt): Bits = {
    val canonNaN32 = (((BigInt(1) << 8) - 1) << 23) | (BigInt(1) << 22)
    val n = normalize(ua.sig, ua.e - S(P - 1, expw + 4 bits))
    val r = roundPackTo(ua.sign, n, rm, 8, 23)
    val bits = Bits(32 bits)
    bits := r.bits
    when(ua.isNaN) { bits := B(canonNaN32, 32 bits); flagNV := ua.isSNaN }
    .elsewhen(ua.isInf) { bits := packInfT(ua.sign, 8, 23) }
    .elsewhen(ua.isZero) { bits := packZeroT(ua.sign, 8, 23) }
    .otherwise { flagNX := r.inexact; flagOF := r.of; flagUF := r.uf }
    bits
  }

  // ===== dispatch =====
  switch(io.op) {
    is(FpOp.ADD) { res := doAddSub(False, io.rm).resize(64) }
    is(FpOp.SUB) { res := doAddSub(True, io.rm).resize(64) }
    is(FpOp.MUL) { res := doMul(io.rm).resize(64) }
    is(FpOp.DIV) { res := doDiv(io.rm).resize(64) }
    is(FpOp.SQRT) { res := doSqrt(io.rm).resize(64) }
    is(FpOp.MIN) { res := doMinMax(False).resize(64) }
    is(FpOp.MAX) { res := doMinMax(True).resize(64) }
    is(FpOp.SGNJ, FpOp.SGNJN, FpOp.SGNJX) { res := doSgnj(io.op).resize(64) }
    is(FpOp.EQ, FpOp.LT, FpOp.LE) { res := doCompare(io.op).resize(64) }
    is(FpOp.CLASS) { res := doClass().resize(64) }
    is(FpOp.MV_X_W) { res := io.a }
    is(FpOp.MV_W_X) { res := io.a }
    is(FpOp.FMA) { res := doFma(False, False, io.rm).resize(64) }
    is(FpOp.FMSUB) { res := doFma(False, True, io.rm).resize(64) }
    is(FpOp.FNMSUB) { res := doFma(True, False, io.rm).resize(64) }
    is(FpOp.FNMADD) { res := doFma(True, True, io.rm).resize(64) }
    is(FpOp.CVT_W_S) { res := doFpToInt(32, signed = true, io.rm) }
    is(FpOp.CVT_WU_S) { res := doFpToInt(32, signed = false, io.rm) }
    is(FpOp.CVT_L_S) { res := doFpToInt(64, signed = true, io.rm) }
    is(FpOp.CVT_LU_S) { res := doFpToInt(64, signed = false, io.rm) }
    is(FpOp.CVT_S_W) { res := doIntToFp(32, signed = true, io.rm).resize(64) }
    is(FpOp.CVT_S_WU) { res := doIntToFp(32, signed = false, io.rm).resize(64) }
    is(FpOp.CVT_S_L) { res := doIntToFp(64, signed = true, io.rm).resize(64) }
    is(FpOp.CVT_S_LU) { res := doIntToFp(64, signed = false, io.rm).resize(64) }
    is(FpOp.CVT_S_D) { res := doD2S(io.rm).resize(64) }
    is(FpOp.CVT_D_S) { res := doS2D(io.rm).resize(64) }
    default { res := io.a }
  }

  io.result := res
  io.flags := Cat(flagNV, flagDZ, flagOF, flagUF, flagNX)
}
