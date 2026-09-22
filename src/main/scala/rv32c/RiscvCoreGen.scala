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
    // Elaborate one hart per capability combination so the C-off / C-on,
    // A-off / A-on, and RV32 / RV64 paths stay buildable.
    gen(CoreConfig.rv32im, "RiscvCore")
    gen(CoreConfig.rv32imc, "RiscvCoreC")
    gen(CoreConfig.rv64imc, "RiscvCore64C")
    gen(CoreConfig.rv32ima, "RiscvCoreA")
    gen(CoreConfig.rv64ima, "RiscvCore64A")
    println("Generated rtl/RiscvCore.v, RiscvCoreC.v, RiscvCore64C.v, RiscvCoreA.v and RiscvCore64A.v")
  }
}
