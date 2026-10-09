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
    gen(CoreConfig.rv32f, "RiscvCoreF")
    gen(CoreConfig.rv64f, "RiscvCore64F")
    gen(CoreConfig.rv64d, "RiscvCore64D")
    gen(CoreConfig.rv32imzbb, "RiscvCoreB")
    gen(CoreConfig.rv64imzbb, "RiscvCore64B")
    gen(CoreConfig.rv32imzbs, "RiscvCoreBS")
    gen(CoreConfig.rv64imzbs, "RiscvCore64BS")
    gen(CoreConfig.rv32imzba, "RiscvCoreBA")
    gen(CoreConfig.rv64imzba, "RiscvCore64BA")
    println("Generated rtl/RiscvCore.v, RiscvCoreC.v, RiscvCore64C.v, " +
      "RiscvCoreA.v, RiscvCore64A.v, RiscvCoreF.v, RiscvCore64F.v, " +
      "RiscvCore64D.v, RiscvCoreB.v, RiscvCore64B.v, RiscvCoreBS.v, " +
      "RiscvCore64BS.v, RiscvCoreBA.v and RiscvCore64BA.v")
  }
}
