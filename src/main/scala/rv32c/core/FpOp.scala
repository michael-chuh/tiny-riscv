package rv32c.core

import spinal.core._

/** FPU operation selector (the `fpOp` field carried through the pipeline).
  *
  * Encodings are internal to this design; the decoder translates F/D
  * instruction encodings into these values and the FPU switches on them.
  */
object FpOp {
  // arithmetic
  def ADD = U(0, 6 bits)
  def SUB = U(1, 6 bits)
  def MUL = U(2, 6 bits)
  def DIV = U(3, 6 bits)
  def SQRT = U(4, 6 bits)
  // sign-injection / min-max
  def MIN = U(5, 6 bits)
  def MAX = U(6, 6 bits)
  def SGNJ = U(7, 6 bits)
  def SGNJN = U(8, 6 bits)
  def SGNJX = U(9, 6 bits)
  // compare (result to integer register)
  def EQ = U(10, 6 bits)
  def LT = U(11, 6 bits)
  def LE = U(12, 6 bits)
  def CLASS = U(13, 6 bits)
  // move between integer and FP register files
  def MV_X_W = U(14, 6 bits) // FP -> integer (raw low bits)
  def MV_W_X = U(15, 6 bits) // integer -> FP (NaN-boxed)
  // conversions FP -> integer
  def CVT_W_S = U(16, 6 bits)
  def CVT_WU_S = U(17, 6 bits)
  def CVT_L_S = U(18, 6 bits)
  def CVT_LU_S = U(19, 6 bits)
  // conversions integer -> FP
  def CVT_S_W = U(20, 6 bits)
  def CVT_S_WU = U(21, 6 bits)
  def CVT_S_L = U(22, 6 bits)
  def CVT_S_LU = U(23, 6 bits)
  // fused multiply-add family (a*b +/- c, with negated variants)
  def FMA = U(24, 6 bits)    // a*b + c
  def FMSUB = U(25, 6 bits)  // a*b - c
  def FNMSUB = U(26, 6 bits) // -(a*b) + c
  def FNMADD = U(27, 6 bits) // -(a*b) - c
  // S <-> D conversions (used by the 64-bit unit only)
  def CVT_S_D = U(28, 6 bits) // D -> S
  def CVT_D_S = U(29, 6 bits) // S -> D

  def isFma(op: UInt): Bool =
    op === FMA || op === FMSUB || op === FNMSUB || op === FNMADD
}
