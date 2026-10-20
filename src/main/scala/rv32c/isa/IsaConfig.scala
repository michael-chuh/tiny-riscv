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
  def hasZbkb: Boolean = extensions.contains(RvExtension.Zbkb)
  def hasZbkc: Boolean = extensions.contains(RvExtension.Zbkc)
  def hasZbkx: Boolean = extensions.contains(RvExtension.Zbkx)
  def hasZknh: Boolean = extensions.contains(RvExtension.Zknh)
  def hasZksh: Boolean = extensions.contains(RvExtension.Zksh)
  def hasZksed: Boolean = extensions.contains(RvExtension.Zksed)
  def hasZkne: Boolean = extensions.contains(RvExtension.Zkne)
  def hasZknd: Boolean = extensions.contains(RvExtension.Zknd)
  def hasZicond: Boolean = extensions.contains(RvExtension.Zicond)
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

  /** RV32 with Zbkb (RV32IM_Zbkb_Zicsr, M/U): crypto bit-manipulation MCU. */
  val rv32imzbkb: IsaConfig =
    IsaConfig(32, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zbkb), PrivConfig.MU)

  /** RV64 with Zbkb (RV64IM_Zbkb_Zicsr, M/U): crypto bit-manipulation hart. */
  val rv64imzbkb: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zbkb), PrivConfig.MU)

  /** RV32 with Zbkc (RV32IM_Zbkc_Zicsr, M/U): crypto carry-less multiply MCU. */
  val rv32imzbkc: IsaConfig =
    IsaConfig(32, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zbkc), PrivConfig.MU)

  /** RV64 with Zbkc (RV64IM_Zbkc_Zicsr, M/U): crypto carry-less multiply hart. */
  val rv64imzbkc: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zbkc), PrivConfig.MU)

  /** RV32 with Zbkx (RV32IM_Zbkx_Zicsr, M/U): crossbar permutations MCU. */
  val rv32imzbkx: IsaConfig =
    IsaConfig(32, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zbkx), PrivConfig.MU)

  /** RV64 with Zbkx (RV64IM_Zbkx_Zicsr, M/U): crossbar permutations hart. */
  val rv64imzbkx: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zbkx), PrivConfig.MU)

  /** RV32IM + Zbkb + Zbkc + Zbkx (the combined Zbk crypto bit-manipulation set). */
  val rv32imzbk: IsaConfig =
    IsaConfig(32, Set(RvExtension.Zicsr, RvExtension.MulDiv,
      RvExtension.Zbkb, RvExtension.Zbkc, RvExtension.Zbkx), PrivConfig.MU)

  /** RV64IM + Zbkb + Zbkc + Zbkx (the combined Zbk crypto bit-manipulation set). */
  val rv64imzbk: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.MulDiv,
      RvExtension.Zbkb, RvExtension.Zbkc, RvExtension.Zbkx), PrivConfig.MU)

  /** RV32 with Zknh (RV32IM_Zicsr_Zknh, M/U): SHA-2 hash bit manipulation MCU. */
  val rv32imzknh: IsaConfig =
    IsaConfig(32, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zknh), PrivConfig.MU)

  /** RV64 with Zknh (RV64IM_Zicsr_Zknh, M/U): SHA-2 hash bit-manipulation hart. */
  val rv64imzknh: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zknh), PrivConfig.MU)

  /** RV32 with Zksh (RV32IM_Zicsr_Zksh, M/U): SM3 hash bit-manipulation MCU. */
  val rv32imzksh: IsaConfig =
    IsaConfig(32, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zksh), PrivConfig.MU)

  /** RV64 with Zksh (RV64IM_Zicsr_Zksh, M/U): SM3 hash bit-manipulation hart. */
  val rv64imzksh: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zksh), PrivConfig.MU)

  /** RV32 with Zksed (RV32IM_Zicsr_Zksed, M/U): SM4 S-box transform MCU. */
  val rv32imzksed: IsaConfig =
    IsaConfig(32, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zksed), PrivConfig.MU)

  /** RV64 with Zksed (RV64IM_Zicsr_Zksed, M/U): SM4 S-box transform hart. */
  val rv64imzksed: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zksed), PrivConfig.MU)

  /** RV32 with the full Zks set (RV32IM_Zicsr_Zksh_Zksed, M/U): SM3 + SM4. */
  val rv32imzks: IsaConfig =
    IsaConfig(32, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zksh, RvExtension.Zksed), PrivConfig.MU)

  /** RV64 with the full Zks set (RV64IM_Zicsr_Zksh_Zksed, M/U): SM3 + SM4. */
  val rv64imzks: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zksh, RvExtension.Zksed), PrivConfig.MU)

  /** RV32 with Zkne (RV32IM_Zicsr_Zkne, M/U): AES encryption round MCU. */
  val rv32imzkne: IsaConfig =
    IsaConfig(32, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zkne), PrivConfig.MU)

  /** RV64 with Zkne (RV64IM_Zicsr_Zkne, M/U): AES encryption round hart. */
  val rv64imzkne: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zkne), PrivConfig.MU)

  /** RV32 with Zknd (RV32IM_Zicsr_Zknd, M/U): AES decryption round MCU. */
  val rv32imzknd: IsaConfig =
    IsaConfig(32, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zknd), PrivConfig.MU)

  /** RV64 with Zknd (RV64IM_Zicsr_Zknd, M/U): AES decryption round hart. */
  val rv64imzknd: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zknd), PrivConfig.MU)

  /** RV32 with the full Zkn set (RV32IM_Zicsr_Zknd_Zkne, M/U): AES enc + dec. */
  val rv32imzkn: IsaConfig =
    IsaConfig(32, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zkne, RvExtension.Zknd), PrivConfig.MU)

  /** RV64 with the full Zkn set (RV64IM_Zicsr_Zknd_Zkne, M/U): AES enc + dec. */
  val rv64imzkn: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zkne, RvExtension.Zknd), PrivConfig.MU)

  /** RV32 with Zicond (RV32IM_Zicond_Zicsr, M/U): conditional zero MCU. */
  val rv32imzicond: IsaConfig =
    IsaConfig(32, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zicond), PrivConfig.MU)

  /** RV64 with Zicond (RV64IM_Zicond_Zicsr, M/U): conditional zero hart. */
  val rv64imzicond: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.MulDiv, RvExtension.Zicond), PrivConfig.MU)

  /** RV64 baseline by roadmap: RV64I + Zicsr, M/S/U. S/H hardware is future
    * work; constructing this now yields an RV64 hart the current RTL rejects. */
  val rv64: IsaConfig =
    IsaConfig(64, Set(RvExtension.Zicsr), PrivConfig.MSU)
}
