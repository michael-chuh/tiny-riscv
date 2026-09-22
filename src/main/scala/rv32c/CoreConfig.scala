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
}
