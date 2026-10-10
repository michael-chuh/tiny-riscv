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
  require(!extensions.contains(RvExtension.DoubleFloat) || extensions.contains(RvExtension.SingleFloat),
    "D implies F: enable SingleFloat together with DoubleFloat")
  require(!extensions.contains(RvExtension.DoubleFloat) || xlen == 64,
    "D (double-precision float) is an RV64 feature in this core")

  // ---- convenience probes -------------------------------------------------
  def hasMulDiv: Boolean = extensions.contains(RvExtension.MulDiv)
  def hasAtomic: Boolean = extensions.contains(RvExtension.Atomic)
  def hasCompressed: Boolean = extensions.contains(RvExtension.Compressed)
  def hasSingleFloat: Boolean = extensions.contains(RvExtension.SingleFloat)
  def hasDoubleFloat: Boolean = extensions.contains(RvExtension.DoubleFloat)
  def hasZbb: Boolean = extensions.contains(RvExtension.Zbb)
  def hasZbs: Boolean = extensions.contains(RvExtension.Zbs)
  def hasZba: Boolean = extensions.contains(RvExtension.Zba)
  def hasZbc: Boolean = extensions.contains(RvExtension.Zbc)
  def hasFpu: Boolean = hasSingleFloat
  def hasZicsr: Boolean = extensions.contains(RvExtension.Zicsr)
  def hasZifencei: Boolean = extensions.contains(RvExtension.Zifencei)

  /** Floating-point register width (FLEN): 64 with D, 32 with F only, 0 without
    * a floating-point unit. */
  def flen: Int = if (hasDoubleFloat) 64 else if (hasSingleFloat) 32 else 0

  def isRV32: Boolean = xlen == 32
  def isRV64: Boolean = xlen == 64

  // ---- names --------------------------------------------------------------
  def baseName: String = s"RV${xlen}I"

  /** Canonical name, e.g. "RV32IM_Zicsr  M/U". Single-letter extensions follow
    * the standard "IMAFDQLCB..." ordering; Z-extensions are sorted by name. */
  def canonicalName: String = {
    val order = "MAFDQLCBJTPVN"
    val letters = extensions.flatMap(_.misaLetter).toSeq
      .sortBy(c => { val i = order.indexOf(c); if (i >= 0) i else 100 + (c - 'A') }).mkString
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

  /** RV32 with M and C (RV32IMC_Zicsr, M/U): the compact rv32 MCU target. */
  val rv32imc: IsaConfig =
    IsaConfig(32, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Compressed), PrivConfig.MU)

  /** RV64 with M and C (RV64IMC_Zicsr, M/U): the compressed rv64 target. */
  val rv64imc: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Compressed), PrivConfig.MU)

  /** RV32 with M and A (RV32IMA_Zicsr, M/U): atomic-enabled rv32 hart. */
  val rv32ima: IsaConfig =
    IsaConfig(32, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Atomic), PrivConfig.MU)

  /** RV64 with M and A (RV64IMA_Zicsr, M/U): atomic-enabled rv64 hart. */
  val rv64ima: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Atomic), PrivConfig.MU)

  /** RV32 with F (RV32F_Zicsr, M/U): single-precision float rv32 hart. */
  val rv32f: IsaConfig =
    IsaConfig(32, Set(RvExtension.Zicsr, RvExtension.SingleFloat), PrivConfig.MU)

  /** RV64 with F (RV64F_Zicsr, M/U): single-precision float rv64 hart. */
  val rv64f: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.SingleFloat), PrivConfig.MU)

  /** RV64 with F and D (RV64D_Zicsr, M/U): double-precision float rv64 hart. */
  val rv64d: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.SingleFloat, RvExtension.DoubleFloat), PrivConfig.MU)

  /** RV32 with Zbb (RV32IM_Zbb_Zicsr, M/U): the bit-manipulation rv32 MCU hart. */
  val rv32imzbb: IsaConfig =
    IsaConfig(32, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zbb), PrivConfig.MU)

  /** RV64 with Zbb (RV64IM_Zbb_Zicsr, M/U): the bit-manipulation rv64 hart. */
  val rv64imzbb: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zbb), PrivConfig.MU)

  /** RV32 with Zbs (RV32IM_Zbs_Zicsr, M/U): single-bit rv32 MCU hart. */
  val rv32imzbs: IsaConfig =
    IsaConfig(32, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zbs), PrivConfig.MU)

  /** RV64 with Zbs (RV64IM_Zbs_Zicsr, M/U): single-bit rv64 hart. */
  val rv64imzbs: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zbs), PrivConfig.MU)

  /** RV32 with Zba (RV32IM_Zba_Zicsr, M/U): address-generation rv32 MCU hart. */
  val rv32imzba: IsaConfig =
    IsaConfig(32, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zba), PrivConfig.MU)

  /** RV64 with Zba (RV64IM_Zba_Zicsr, M/U): address-generation rv64 hart. */
  val rv64imzba: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zba), PrivConfig.MU)

  /** RV32 with Zbc (RV32IM_Zbc_Zicsr, M/U): carry-less multiply rv32 MCU hart. */
  val rv32imzbc: IsaConfig =
    IsaConfig(32, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zbc), PrivConfig.MU)

  /** RV64 with Zbc (RV64IM_Zbc_Zicsr, M/U): carry-less multiply rv64 hart. */
  val rv64imzbc: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zbc), PrivConfig.MU)

  /** RV64 baseline by roadmap: RV64I + Zicsr, M/S/U. S/H hardware is future
    * work; constructing this now yields an RV64 hart the current RTL rejects. */
  val rv64: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr), PrivConfig.MSU)
}
