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
    gen(CoreConfig.rv32imzbc, "RiscvCoreBC")
    gen(CoreConfig.rv64imzbc, "RiscvCore64BC")
    gen(CoreConfig.rv32imzbkb, "RiscvCoreBKB")
    gen(CoreConfig.rv64imzbkb, "RiscvCore64BKB")
    gen(CoreConfig.rv32imzbkc, "RiscvCoreBKC")
    gen(CoreConfig.rv64imzbkc, "RiscvCore64BKC")
    gen(CoreConfig.rv32imzbkx, "RiscvCoreBKX")
    gen(CoreConfig.rv64imzbkx, "RiscvCore64BKX")
    gen(CoreConfig.rv32imzbk, "RiscvCoreBK")
    gen(CoreConfig.rv64imzbk, "RiscvCore64BK")
    gen(CoreConfig.rv32imzknh, "RiscvCoreKNH")
    gen(CoreConfig.rv64imzknh, "RiscvCore64KNH")
    gen(CoreConfig.rv32imzksh, "RiscvCoreKSH")
    gen(CoreConfig.rv64imzksh, "RiscvCore64KSH")
    gen(CoreConfig.rv32imzksed, "RiscvCoreKSED")
    gen(CoreConfig.rv64imzksed, "RiscvCore64KSED")
    gen(CoreConfig.rv32imzks, "RiscvCoreKS")
    gen(CoreConfig.rv64imzks, "RiscvCore64KS")
    gen(CoreConfig.rv32imzkne, "RiscvCoreKNE")
    gen(CoreConfig.rv64imzkne, "RiscvCore64KNE")
    gen(CoreConfig.rv32imzknd, "RiscvCoreKND")
    gen(CoreConfig.rv64imzknd, "RiscvCore64KND")
    gen(CoreConfig.rv32imzkn, "RiscvCoreKN")
    gen(CoreConfig.rv64imzkn, "RiscvCore64KN")
    gen(CoreConfig.rv32imzicond, "RiscvCoreZICOND")
    gen(CoreConfig.rv64imzicond, "RiscvCore64ZICOND")
    println("Generated rtl/RiscvCore.v, RiscvCoreC.v, RiscvCore64C.v, " +
      "RiscvCoreA.v, RiscvCore64A.v, RiscvCoreF.v, RiscvCore64F.v, " +
      "RiscvCore64D.v, RiscvCoreB.v, RiscvCore64B.v, RiscvCoreBS.v, " +
      "RiscvCore64BS.v, RiscvCoreBA.v, RiscvCore64BA.v, RiscvCoreBC.v, " +
      "RiscvCore64BC.v, RiscvCoreBKB.v, RiscvCore64BKB.v, RiscvCoreBKC.v, " +
      "RiscvCore64BKC.v, RiscvCoreBKX.v, RiscvCore64BKX.v, RiscvCoreBK.v, " +
      "RiscvCore64BK.v, RiscvCoreKNH.v, RiscvCore64KNH.v, RiscvCoreKSH.v, " +
      "RiscvCore64KSH.v, RiscvCoreKSED.v, RiscvCore64KSED.v, RiscvCoreKS.v, " +
      "RiscvCore64KS.v, RiscvCoreKNE.v, RiscvCore64KNE.v, RiscvCoreKND.v, " +
      "RiscvCore64KND.v, RiscvCoreKN.v, RiscvCore64KN.v, RiscvCoreZICOND.v " +
      "and RiscvCore64ZICOND.v")
  }
}
