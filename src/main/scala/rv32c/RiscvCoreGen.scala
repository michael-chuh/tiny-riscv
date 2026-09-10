package rv32c

import spinal.core._

object RiscvCoreGen {
  def main(args: Array[String]): Unit = {
    val config = CoreConfig.rv32im.copy(withDebug = true)
    SpinalConfig(
      targetDirectory = "rtl",
      defaultConfigForClockDomains = ClockDomainConfig(resetKind = ASYNC)
    ).generateVerilog(new RiscvCore(config))
    println("Generated rtl/RiscvCore.v")
  }
}
