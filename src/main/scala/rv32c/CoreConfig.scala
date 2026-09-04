package rv32c

case class BranchPredictorConfig(
    kind: String = "staticNotTaken"
)

case class CacheConfig(
    sizeBytes: Int = 4096,
    lineBytes: Int = 32,
    ways: Int = 2
)

case class CoreConfig(
    xlen: Int = 32,
    resetVector: BigInt = 0x00000000L,
    withMulDiv: Boolean = false,
    withFpu: Boolean = false,
    branchPredictor: BranchPredictorConfig = BranchPredictorConfig(),
    withICache: Option[CacheConfig] = None,
    withDCache: Option[CacheConfig] = None,
    numCores: Int = 1,
    hartId: Int = 0,
    withDebug: Boolean = false
) {
  require(xlen == 32 || xlen == 64, s"xlen must be 32 or 64, got $xlen")
  require(numCores >= 1, s"numCores must be >= 1, got $numCores")

  def isRV64: Boolean = xlen == 64
  def bytePerXlen: Int = xlen / 8
}
