package rv32c.isa

/** The full ISA configuration of a hart.
  *
  * A hart is described by three orthogonal axes:
  *   - `xlen`         : 32 (RV32I) or 64 (RV64I) base integer width. "I" is
  *                      implicit and never repeated in `extensions`.
  *   - `extensions`   : named extensions enabled for this hart (M, Zicsr, ...).
  *   - `priv`         : privilege stack (M, M/U, M/S/U, ...).
  *
  * Everything the rest of the design needs (misa value, "does this hart have
  * M", readable stack name) is derived here so there is a single source of
  * truth. Structural rules (xlen consistency, S requires U, S/H are RV64-only
  * by roadmap) are enforced by `require`; whether the *current* RTL can run a
  * given configuration is checked separately at core instantiation.
  */
case class IsaConfig(
    xlen: Int = 32,
    extensions: Set[RvExtension] = Set(RvExtension.Zicsr),
    priv: PrivConfig = PrivConfig.MU
) {
  require(xlen == 32 || xlen == 64, s"xlen must be 32 or 64, got $xlen")
  require(!priv.hasSupervisor || xlen == 64, "S mode is an RV64 roadmap feature")
  require(!priv.hasHypervisor || xlen == 64, "H mode is an RV64 roadmap feature")
  require(!priv.hasHypervisor || priv.hasSupervisor, "H mode builds on S mode")

  // ---- convenience probes -------------------------------------------------
  def hasMulDiv: Boolean = extensions.contains(RvExtension.MulDiv)
  def hasAtomic: Boolean = extensions.contains(RvExtension.Atomic)
  def hasCompressed: Boolean = extensions.contains(RvExtension.Compressed)
  def hasSingleFloat: Boolean = extensions.contains(RvExtension.SingleFloat)
  def hasDoubleFloat: Boolean = extensions.contains(RvExtension.DoubleFloat)
  def hasFpu: Boolean = hasSingleFloat || hasDoubleFloat
  def hasZicsr: Boolean = extensions.contains(RvExtension.Zicsr)
  def hasZifencei: Boolean = extensions.contains(RvExtension.Zifencei)

  def isRV32: Boolean = xlen == 32
  def isRV64: Boolean = xlen == 64

  // ---- names --------------------------------------------------------------
  def baseName: String = s"RV${xlen}I"

  /** Canonical name, e.g. "RV32IM_Zicsr  M/U". */
  def canonicalName: String = {
    val letters = extensions.flatMap(_.misaLetter).toSeq.sorted.mkString
    val zExts = extensions.filter(_.misaLetter.isEmpty).map(_.name).toSeq.sorted
    val ext = letters + (if (zExts.nonEmpty) "_" + zExts.mkString("_") else "")
    s"$baseName$ext  ${priv.name}"
  }

  override def toString: String = canonicalName

  // ---- misa ----------------------------------------------------------------
  /** MXL field: 1 for RV32, 2 for RV64, placed in the top two bits. */
  private def mxl: Int = if (isRV32) 1 else 2

  private def letterBit(c: Char): Int = c - 'A'

  /** misa value reflecting exactly this configuration: MXL + I base + enabled
    * single-letter extensions + U/S bits when those modes are in the stack.
    */
  def misaValue: BigInt = {
    var v = BigInt(mxl) << (xlen - 2)
    v |= BigInt(1) << letterBit('I')
    if (priv.hasUser) v |= BigInt(1) << letterBit('U')
    if (priv.hasSupervisor) v |= BigInt(1) << letterBit('S')
    extensions.flatMap(_.misaLetter).foreach { c =>
      v |= BigInt(1) << letterBit(c)
    }
    v
  }
}

object IsaConfig {
  /** RV32 baseline: RV32I + Zicsr, M/U (the rv32 MCU privilege target). */
  val rv32: IsaConfig = IsaConfig()

  /** RV32 with the multiply/divide extension (RV32IM_Zicsr, M/U). */
  val rv32im: IsaConfig =
    IsaConfig(32, Set(RvExtension.Zicsr, RvExtension.MulDiv), PrivConfig.MU)

  /** RV64 baseline by roadmap: RV64I + Zicsr, M/S/U. S/H hardware is future
    * work; constructing this now yields an RV64 hart the current RTL rejects. */
  val rv64: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr), PrivConfig.MSU)
}
