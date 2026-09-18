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
  /** A: atomics. Reserved (rv64 target). */
  case object Atomic extends RvExtension("A") {
    override val misaLetter: Option[Char] = Some('A')
  }
  /** C: compressed 16-bit instructions. Implemented on both RV32 (rv32 MCU
    * target) and RV64. */
  case object Compressed extends RvExtension("C") {
    override val misaLetter: Option[Char] = Some('C')
  }
  /** F: single-precision float. Reserved. */
  case object SingleFloat extends RvExtension("F") {
    override val misaLetter: Option[Char] = Some('F')
  }
  /** D: double-precision float. Reserved. */
  case object DoubleFloat extends RvExtension("D") {
    override val misaLetter: Option[Char] = Some('D')
  }
  /** Zicsr: CSR instructions. Implemented (always enabled by default). */
  case object Zicsr extends RvExtension("Zicsr")
  /** Zifencei: instruction-fence. Reserved (fence.i handled as NOP today). */
  case object Zifencei extends RvExtension("Zifencei")

  /** Extensions the current RTL can execute (M, Zicsr, C). */
  val implemented: Set[RvExtension] = Set(MulDiv, Zicsr, Compressed)
  /** Roadmap extensions the model can express but the RTL cannot run yet. */
  val reserved: Set[RvExtension] =
    Set(Atomic, SingleFloat, DoubleFloat, Zifencei)

  private val byName: Map[String, RvExtension] =
    (implemented ++ reserved).map(e => e.name -> e).toMap

  def fromName(name: String): Option[RvExtension] = byName.get(name)

  /** Deterministic ordering for messages and specs: by mnemonic name. */
  implicit val ordering: Ordering[RvExtension] = Ordering.by(_.name)
}
