package rv32c

import rv32c.isa._

/** Branch-predictor configuration. `staticNotTaken` is the only implemented
  * strategy today; richer predictors are a reserved roadmap item. */
case class BranchPredictorConfig(
    kind: String = "staticNotTaken"
)

/** Cache configuration placeholder. Reserved: caches are not instantiated yet. */
case class CacheConfig(
    sizeBytes: Int = 4096,
    lineBytes: Int = 32,
    ways: Int = 2
)

/** Top-level hart configuration.
  *
  * The ISA axes (width, extensions, privilege stack) live in `isa` and are the
  * single source of truth for anything instruction/CSR/mode related (misa,
  * decode enable, CSR availability). This case class adds the *micro*- and
  * platform-level knobs: reset vector, prediction/cache placeholders, hart id,
  * debug export.
  */
case class CoreConfig(
    isa: IsaConfig = IsaConfig.rv32,
    resetVector: BigInt = 0x00000000L,
    branchPredictor: BranchPredictorConfig = BranchPredictorConfig(),
    withICache: Option[CacheConfig] = None,
    withDCache: Option[CacheConfig] = None,
    numCores: Int = 1,
    hartId: Int = 0,
    withDebug: Boolean = false
) {
  require(numCores >= 1, s"numCores must be >= 1, got $numCores")

  /** Data-path width, forwarded from the ISA config. */
  def xlen: Int = isa.xlen
  def isRV64: Boolean = isa.isRV64
  def bytePerXlen: Int = isa.xlen / 8

  // ---- convenient forwarders used across the RTL ----
  def hasMulDiv: Boolean = isa.hasMulDiv
  def hasAtomic: Boolean = isa.hasAtomic
  def hasCompressed: Boolean = isa.hasCompressed
  def hasSingleFloat: Boolean = isa.hasSingleFloat
  def hasDoubleFloat: Boolean = isa.hasDoubleFloat
  def hasZbb: Boolean = isa.hasZbb
  def hasZbs: Boolean = isa.hasZbs
  def hasZba: Boolean = isa.hasZba
  def hasZbc: Boolean = isa.hasZbc
  def hasZbkb: Boolean = isa.hasZbkb
  def hasZbkc: Boolean = isa.hasZbkc
  def hasZbkx: Boolean = isa.hasZbkx
  def hasZknh: Boolean = isa.hasZknh
  def hasZksh: Boolean = isa.hasZksh
  def hasZksed: Boolean = isa.hasZksed
  def hasFloat: Boolean = isa.hasFpu
  /** Floating-point register width: 64 with D, 32 with F, 0 without an FPU. */
  def flen: Int = isa.flen
  def misaValue: BigInt = isa.misaValue
  def priv: PrivConfig = isa.priv

  override def toString: String =
    s"CoreConfig(${isa.canonicalName}, reset=$resetVector, xlen=$xlen)"
}

object CoreConfig {
  /** RV32IM + Zicsr on the M/U stack: the current default development hart. */
  def rv32im: CoreConfig = CoreConfig(isa = IsaConfig.rv32im)

  /** RV32IMC + Zicsr on the M/U stack: the compact rv32 MCU hart. */
  def rv32imc: CoreConfig = CoreConfig(isa = IsaConfig.rv32imc)

  /** RV64IMC + Zicsr on the M/U stack: the compressed rv64 hart. */
  def rv64imc: CoreConfig = CoreConfig(isa = IsaConfig.rv64imc)

  /** RV32IMA + Zicsr on the M/U stack: the atomic-enabled rv32 hart. */
  def rv32ima: CoreConfig = CoreConfig(isa = IsaConfig.rv32ima)

  /** RV64IMA + Zicsr on the M/U stack: the atomic-enabled rv64 hart. */
  def rv64ima: CoreConfig = CoreConfig(isa = IsaConfig.rv64ima)

  /** RV32F + Zicsr on the M/U stack: single-precision float rv32 hart. */
  def rv32f: CoreConfig = CoreConfig(isa = IsaConfig.rv32f)

  /** RV64F + Zicsr on the M/U stack: single-precision float rv64 hart. */
  def rv64f: CoreConfig = CoreConfig(isa = IsaConfig.rv64f)

  /** RV64D + Zicsr on the M/U stack: double-precision float rv64 hart. */
  def rv64d: CoreConfig = CoreConfig(isa = IsaConfig.rv64d)

  /** RV32IM + Zbb on the M/U stack: the bit-manipulation rv32 MCU hart. */
  def rv32imzbb: CoreConfig = CoreConfig(isa = IsaConfig.rv32imzbb)

  /** RV64IM + Zbb on the M/U stack: the bit-manipulation rv64 hart. */
  def rv64imzbb: CoreConfig = CoreConfig(isa = IsaConfig.rv64imzbb)

  /** RV32IM + Zbs on the M/U stack: the single-bit rv32 MCU hart. */
  def rv32imzbs: CoreConfig = CoreConfig(isa = IsaConfig.rv32imzbs)

  /** RV64IM + Zbs on the M/U stack: the single-bit rv64 hart. */
  def rv64imzbs: CoreConfig = CoreConfig(isa = IsaConfig.rv64imzbs)

  /** RV32IM + Zba on the M/U stack: the address-generation rv32 MCU hart. */
  def rv32imzba: CoreConfig = CoreConfig(isa = IsaConfig.rv32imzba)

  /** RV64IM + Zba on the M/U stack: the address-generation rv64 hart. */
  def rv64imzba: CoreConfig = CoreConfig(isa = IsaConfig.rv64imzba)

  /** RV32IM + Zbc on the M/U stack: the carry-less multiply rv32 MCU hart. */
  def rv32imzbc: CoreConfig = CoreConfig(isa = IsaConfig.rv32imzbc)

  /** RV64IM + Zbc on the M/U stack: the carry-less multiply rv64 hart. */
  def rv64imzbc: CoreConfig = CoreConfig(isa = IsaConfig.rv64imzbc)

  /** RV32IM + Zbkb on the M/U stack: the crypto bit-manipulation rv32 MCU hart. */
  def rv32imzbkb: CoreConfig = CoreConfig(isa = IsaConfig.rv32imzbkb)

  /** RV64IM + Zbkb on the M/U stack: the crypto bit-manipulation rv64 hart. */
  def rv64imzbkb: CoreConfig = CoreConfig(isa = IsaConfig.rv64imzbkb)

  /** RV32IM + Zbkc on the M/U stack: the crypto carry-less multiply rv32 MCU hart. */
  def rv32imzbkc: CoreConfig = CoreConfig(isa = IsaConfig.rv32imzbkc)

  /** RV64IM + Zbkc on the M/U stack: the crypto carry-less multiply rv64 hart. */
  def rv64imzbkc: CoreConfig = CoreConfig(isa = IsaConfig.rv64imzbkc)

  /** RV32IM + Zbkx on the M/U stack: the crossbar-permutation rv32 MCU hart. */
  def rv32imzbkx: CoreConfig = CoreConfig(isa = IsaConfig.rv32imzbkx)

  /** RV64IM + Zbkx on the M/U stack: the crossbar-permutation rv64 hart. */
  def rv64imzbkx: CoreConfig = CoreConfig(isa = IsaConfig.rv64imzbkx)

  /** RV32IM + Zbkb + Zbkc + Zbkx on the M/U stack: the combined crypto rv32 MCU hart. */
  def rv32imzbk: CoreConfig = CoreConfig(isa = IsaConfig.rv32imzbk)

  /** RV64IM + Zbkb + Zbkc + Zbkx on the M/U stack: the combined crypto rv64 hart. */
  def rv64imzbk: CoreConfig = CoreConfig(isa = IsaConfig.rv64imzbk)

  /** RV32IM + Zknh on the M/U stack: SHA-2 hash bit-manipulation rv32 MCU hart. */
  def rv32imzknh: CoreConfig = CoreConfig(isa = IsaConfig.rv32imzknh)

  /** RV64IM + Zknh on the M/U stack: SHA-2 hash bit-manipulation rv64 hart. */
  def rv64imzknh: CoreConfig = CoreConfig(isa = IsaConfig.rv64imzknh)

  /** RV32IM + Zksh on the M/U stack: SM3 hash bit-manipulation rv32 MCU hart. */
  def rv32imzksh: CoreConfig = CoreConfig(isa = IsaConfig.rv32imzksh)

  /** RV64IM + Zksh on the M/U stack: SM3 hash bit-manipulation rv64 hart. */
  def rv64imzksh: CoreConfig = CoreConfig(isa = IsaConfig.rv64imzksh)

  /** RV32IM + Zksed on the M/U stack: SM4 S-box transform rv32 MCU hart. */
  def rv32imzksed: CoreConfig = CoreConfig(isa = IsaConfig.rv32imzksed)

  /** RV64IM + Zksed on the M/U stack: SM4 S-box transform rv64 hart. */
  def rv64imzksed: CoreConfig = CoreConfig(isa = IsaConfig.rv64imzksed)

  /** RV32IM + full Zks (SM3 + SM4) on the M/U stack. */
  def rv32imzks: CoreConfig = CoreConfig(isa = IsaConfig.rv32imzks)

  /** RV64IM + full Zks (SM3 + SM4) on the M/U stack. */
  def rv64imzks: CoreConfig = CoreConfig(isa = IsaConfig.rv64imzks)
}
