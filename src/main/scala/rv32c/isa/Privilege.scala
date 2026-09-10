package rv32c.isa

/** A single privilege level of the RISC-V privilege stack.
  *
  * `encoding` is the PRV field value (mstatus.MPP / mret target). Level M is
  * mandatory; U/S/H are added per configuration. H is expressed in the model so
  * the stack shape is complete, but no current RTL configuration enables it.
  */
sealed abstract class PrivMode(val encoding: Int, val name: String) {
  override def toString: String = name
}

object PrivMode {
  case object U extends PrivMode(0, "U")
  case object S extends PrivMode(1, "S")
  case object H extends PrivMode(2, "H")
  case object M extends PrivMode(3, "M")

  def fromEncoding(enc: Int): PrivMode = enc match {
    case 0 => U
    case 1 => S
    case 2 => H
    case 3 => M
  }
}

/** The privilege stack a hart is built with.
  *
  * Rules enforced here are structural (subset/layout); whether the RTL actually
  * implements a given stack is a separate capability check done at core
  * instantiation (see `RiscvCore` requires).
  */
case class PrivConfig(modes: Set[PrivMode]) {
  require(modes.contains(PrivMode.M), "machine mode is mandatory")
  require(!modes.contains(PrivMode.S) || modes.contains(PrivMode.U),
    "S mode requires U mode (U is delegated below S)")
  require(!modes.contains(PrivMode.H) || modes.contains(PrivMode.S),
    "H mode requires S mode (S is delegated below H)")

  def hasUser: Boolean = modes.contains(PrivMode.U)
  def hasSupervisor: Boolean = modes.contains(PrivMode.S)
  def hasHypervisor: Boolean = modes.contains(PrivMode.H)

  /** Human stack name, e.g. "M/U", "M/S/U". */
  def name: String = modes.toSeq.sortBy(-_.encoding).map(_.name).mkString("/")
  override def toString: String = name
}

object PrivConfig {
  /** Machine only. */
  val M: PrivConfig = PrivConfig(Set(PrivMode.M))
  /** Machine + user (rv32 MCU target). */
  val MU: PrivConfig = PrivConfig(Set(PrivMode.M, PrivMode.U))
  /** Machine + supervisor + user (rv64 high-performance target). */
  val MSU: PrivConfig = PrivConfig(Set(PrivMode.M, PrivMode.S, PrivMode.U))
}
