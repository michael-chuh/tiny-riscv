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
    // Default hart (no compressed), the RV32IMC variant, and the RV64IMC variant
    // are elaborated so the C-off / C-on and RV32 / RV64 paths stay buildable.
    gen(CoreConfig.rv32im, "RiscvCore")
    gen(CoreConfig.rv32imc, "RiscvCoreC")
    gen(CoreConfig.rv64imc, "RiscvCore64C")
    println("Generated rtl/RiscvCore.v, rtl/RiscvCoreC.v and rtl/RiscvCore64C.v")
  }
}
