package rv32c

import spinal.core._

object RiscvCoreGen {
  private def gen(config: CoreConfig, name: String): Unit = {
    SpinalConfig(
      targetDirectory = "rtl",
      defaultConfigForClockDomains = ClockDomainConfig(resetKind = ASYNC)
    ).generateVerilog {
      val top = new RiscvCore(config.copy(withDebug = true))
      top.setDefinitionName(name)
      top
    }
  }

  def main(args: Array[String]): Unit = {
    // Default hart (no compressed) and the RV32IMC variant are both elaborated
    // so the C-off / C-on RTL paths stay buildable.
    gen(CoreConfig.rv32im, "RiscvCore")
    gen(CoreConfig.rv32imc, "RiscvCoreC")
    println("Generated rtl/RiscvCore.v and rtl/RiscvCoreC.v")
  }
}
