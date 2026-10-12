package rv32c.isa

/** Named ISA extensions beyond the base integer set (RV32I / RV64I).
  *
  * Extensions with a single-letter encoding (M/A/C/F/D/...) contribute a MISA
  * capability bit; "Z"-prefixed extensions (Zicsr/Zifencei) modify CSR and
  * decode behavior without a MISA bit. The base "I" is implicit in the xlen and
  * is never listed here.
  *
  * `implemented` names the extensions the current RTL actually decodes and
  * executes; `reserved` documents the rest of the roadmap so configurations can
  * name them before the hardware lands.
  */
sealed abstract class RvExtension(val name: String) {
  def misaLetter: Option[Char] = None
  override def toString: String = name
}

object RvExtension {
  /** M: multiply/divide. Implemented. */
  case object MulDiv extends RvExtension("M") {
    override val misaLetter: Option[Char] = Some('M')
  }
  /** A: atomics (LR/SC + AMO). Implemented (rv32/rv64). */
  case object Atomic extends RvExtension("A") {
    override val misaLetter: Option[Char] = Some('A')
  }
  /** C: compressed 16-bit instructions. Implemented on both RV32 (rv32 MCU
    * target) and RV64. */
  case object Compressed extends RvExtension("C") {
    override val misaLetter: Option[Char] = Some('C')
  }
  /** F: single-precision float. Implemented (FLEN=32). */
  case object SingleFloat extends RvExtension("F") {
    override val misaLetter: Option[Char] = Some('F')
  }
  /** D: double-precision float. Implemented on RV64 (FLEN=64); D implies F. */
  case object DoubleFloat extends RvExtension("D") {
    override val misaLetter: Option[Char] = Some('D')
  }
  /** Zbb: basic bit manipulation (clz/ctz/cpop, sext/zext, min/max, rol/ror,
    * andn/orn/xnor, orc.b, rev8). Implemented on both RV32 and RV64. */
  case object Zbb extends RvExtension("Zbb")
  /** Zbs: single-bit operations (bset/bclr/binv/bext and their immediate
    * forms). Implemented on both RV32 (5-bit shamt) and RV64 (6-bit shamt). */
  case object Zbs extends RvExtension("Zbs")
  /** Zba: address-generation bit manipulation (sh1add/sh2add/sh3add plus the
    * RV64 word forms add.uw/slli.uw/sh*add.uw). Implemented on both RV32 and
    * RV64. */
  case object Zba extends RvExtension("Zba")
  /** Zbc: carry-less multiplication (clmul/clmulh/clmulr). Implemented on both
    * RV32 and RV64. */
  case object Zbc extends RvExtension("Zbc")
  /** Zbkb: bit manipulation for cryptography (pack/packh/packw, brev8, rev8,
    * zip/unzip, plus the andn/orn/xnor/rol/ror family). Implemented on both RV32
    * and RV64 (zip/unzip are RV32-only by encoding). */
  case object Zbkb extends RvExtension("Zbkb")
  /** Zbkc: carry-less multiply for cryptography (clmul/clmulh). A subset of Zbc
    * without clmulr. Implemented on both RV32 and RV64. */
  case object Zbkc extends RvExtension("Zbkc")
  /** Zbkx: crossbar permutations (xperm4/xperm8). Implemented on both RV32 and
    * RV64. */
  case object Zbkx extends RvExtension("Zbkx")
  /** Zicsr: CSR instructions. Implemented (always enabled by default). */
  case object Zicsr extends RvExtension("Zicsr")
  /** Zifencei: instruction-fence. Reserved (fence.i handled as NOP today). */
  case object Zifencei extends RvExtension("Zifencei")

  /** Extensions the current RTL can execute (M, A, F, D, Zicsr, C, Zbb, Zbs,
    * Zba, Zbc, Zbkb, Zbkc, Zbkx). */
  val implemented: Set[RvExtension] =
    Set(MulDiv, Atomic, SingleFloat, DoubleFloat, Zbb, Zbs, Zba, Zbc,
      Zbkb, Zbkc, Zbkx, Zicsr, Compressed)
  /** Roadmap extensions the model can express but the RTL cannot run yet. */
  val reserved: Set[RvExtension] =
    Set(Zifencei)

  private val byName: Map[String, RvExtension] =
    (implemented ++ reserved).map(e => e.name -> e).toMap

  def fromName(name: String): Option[RvExtension] = byName.get(name)

  /** Deterministic ordering for messages and specs: by mnemonic name. */
  implicit val ordering: Ordering[RvExtension] = Ordering.by(_.name)
}
