package rv32c.core

import spinal.core._

/** Multi-cycle restoring divider used by the RV32M DIV/DIVU/REM/REMU
  * instructions.
  *
  * Computes both quotient and remainder of |a| / |b| over `xlen` clock cycles
  * using the classic restoring long-division algorithm, then applies the sign
  * corrections required by the RISC-V spec (division truncates toward zero, so
  * the remainder takes the sign of the dividend).
  *
  * Pipeline handshake:
  *   - `start` pulses once to begin a new division (operands are latched).
  *   - `busy` is high while the divider is running.
  *   - `done` is high while the result in `quotient`/`remainder` is valid and
  *     waiting to be consumed.
  *   - `ack` acknowledges consumption and returns the divider to idle so it can
  *     accept the next operation.
  *
  * Special cases (RISC-V spec):
  *   - divisor == 0       => quotient = all ones, remainder = dividend
  *   - signed |min| / -1  => quotient = min (wraps back to the dividend)
  */
class Divider(xlen: Int) extends Component {
  val io = new Bundle {
    val start = in Bool()             // pulse: latch operands and begin
    val a = in UInt (xlen bits)       // dividend
    val b = in UInt (xlen bits)       // divisor
    val signed = in Bool()            // DIV/REM (vs DIVU/REMU)
    val ack = in Bool()               // core consumed the result
    val busy = out Bool()
    val done = out Bool()
    val quotient = out UInt (xlen bits)
    val remainder = out UInt (xlen bits)
  }

  // ----- Latched operands / flags (stable for the whole operation) -----
  val aMagReg = Reg(UInt(xlen bits))  // magnitude of dividend
  val bMagReg = Reg(UInt(xlen bits))  // magnitude of divisor
  val aRawReg = Reg(UInt(xlen bits))  // raw dividend (div-by-zero remainder)
  val signA = Reg(Bool())
  val signB = Reg(Bool())
  val signedOp = Reg(Bool())
  val bIsZero = Reg(Bool())

  val qOut = Reg(UInt(xlen bits))     // final quotient
  val rOut = Reg(UInt(xlen bits))     // final remainder

  // ----- Restoring-iteration state -----
  val state = RegInit(U(0, 2 bits))   // 0 idle, 1 running, 2 done
  val cnt = Reg(UInt(log2Up(xlen + 1) bits))
  val rRem = Reg(UInt(xlen + 1 bits)) // running remainder (one extra bit)
  val qAcc = Reg(UInt(xlen bits))     // running quotient accumulator
  val dSh = Reg(UInt(xlen bits))      // dividend bit shifter (MSB first)

  // One restoring step:
  //   remainder = (remainder << 1) | next_dividend_bit
  //   if remainder >= divisor: remainder -= divisor; quotient bit = 1
  val stepRem = (rRem(xlen - 1 downto 0) ## dSh(xlen - 1)).asUInt
  val bExt = bMagReg.resize(xlen + 1)
  val ge = stepRem >= bExt
  val subRem = stepRem - bExt
  val nextRem = Mux(ge, subRem, stepRem)
  val nextQ = ((qAcc << 1).resize(xlen)) | Mux(ge, U(1), U(0)).resize(xlen)

  val lastStep = cnt === U(xlen - 1)

  // Magnitudes taken on accept. Two's-complement negation yields |x| even for
  // the min-signed case, where |min| == 2^(xlen-1) as an unsigned value.
  val aNegIn = io.a(xlen - 1)
  val bNegIn = io.b(xlen - 1)
  val aMagIn = Mux(io.signed && aNegIn, U(0, xlen bits) - io.a, io.a)
  val bMagIn = Mux(io.signed && bNegIn, U(0, xlen bits) - io.b, io.b)

  // Final sign fixups (division truncates toward zero):
  //   quotient sign  = aNeg ^ bNeg
  //   remainder sign = aNeg
  val qNeg = signA ^ signB
  val qFinal = Mux(qNeg && signedOp, U(0, xlen bits) - nextQ, nextQ)
  val rMag = nextRem(xlen - 1 downto 0)
  val rFinal = Mux(signA && signedOp, U(0, xlen bits) - rMag, rMag)

  val allOnes = U((BigInt(1) << xlen) - 1, xlen bits)
  val qRes = Mux(bIsZero, allOnes, qFinal)
  val rRes = Mux(bIsZero, aRawReg, rFinal)

  switch(state) {
    is(U(0)) { // idle: accept a new division
      when(io.start) {
        state := U(1)
        aMagReg := aMagIn
        bMagReg := bMagIn
        aRawReg := io.a
        signA := aNegIn
        signB := bNegIn
        signedOp := io.signed
        bIsZero := io.b === U(0)
        rRem := U(0, xlen + 1 bits)
        qAcc := U(0, xlen bits)
        dSh := aMagIn
        cnt := U(0)
      }
    }
    is(U(1)) { // running: one restoring step per cycle
      when(bIsZero) { // div by zero: finish immediately
        qOut := allOnes
        rOut := aRawReg
        state := U(2)
      } elsewhen (lastStep) {
        qOut := qRes
        rOut := rRes
        state := U(2)
      } otherwise {
        rRem := nextRem
        qAcc := nextQ
        dSh := (dSh << 1).resize(xlen)
        cnt := cnt + U(1)
      }
    }
    default { // done: hold the result until acked, or start a new operation
      when(io.start) {
        state := U(1)
        aMagReg := aMagIn
        bMagReg := bMagIn
        aRawReg := io.a
        signA := aNegIn
        signB := bNegIn
        signedOp := io.signed
        bIsZero := io.b === U(0)
        rRem := U(0, xlen + 1 bits)
        qAcc := U(0, xlen bits)
        dSh := aMagIn
        cnt := U(0)
      } elsewhen (io.ack) {
        state := U(0)
      }
    }
  }

  io.busy := state === U(1)
  io.done := state === U(2)
  io.quotient := qOut
  io.remainder := rOut
}
