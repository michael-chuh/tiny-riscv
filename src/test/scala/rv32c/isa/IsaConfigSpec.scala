package rv32c.isa

import org.scalatest.funsuite.AnyFunSuite

/** Pure-Scala sanity checks for the ISA configuration model.
  *
  * These run without SpinalHDL elaboration so configuration mistakes (bad
  * misa derivation, illegal privilege stacks) are caught at unit level before
  * any RTL build.
  */
class IsaConfigSpec extends AnyFunSuite {

  // ---- RV32 baseline -------------------------------------------------------
  test("default is RV32I + Zicsr on M/U") {
    val isa = IsaConfig.rv32
    assert(isa.xlen == 32)
    assert(!isa.hasMulDiv)
    assert(isa.hasZicsr)
    assert(isa.priv == PrivConfig.MU)
    assert(isa.baseName == "RV32I")
  }

  // ---- misa derivation -----------------------------------------------------
  test("RV32 base misa is MXL=1 | I | U (no M bit)") {
    val isa = IsaConfig.rv32
    assert(isa.misaValue == 0x40100100L, f"0x${isa.misaValue}%x")
  }

  test("rv32im misa adds the M letter bit") {
    val isa = IsaConfig.rv32im
    assert(isa.hasMulDiv)
    assert(isa.misaValue == 0x40101100L, f"0x${isa.misaValue}%x")
  }

  test("extension letters are bit-indexed from 'A'") {
    def bit(c: Char) = c - 'A'
    assert(bit('I') == 8 && bit('M') == 12 && bit('U') == 20 && bit('S') == 18)
  }

  test("misa tracks which extensions are enabled") {
    val base = IsaConfig.rv32
    val withA = base.copy(extensions = base.extensions + RvExtension.Atomic)
    val withM = withA.copy(extensions = withA.extensions + RvExtension.MulDiv)
    assert((withA.misaValue & (BigInt(1) << ('A' - 'A'))).toInt != 0) // A present
    assert((withA.misaValue & (BigInt(1) << ('M' - 'A'))).toInt == 0) // M absent
    assert((withM.misaValue & (BigInt(1) << ('M' - 'A'))).toInt != 0) // M appears
  }

  test("S mode contributes its misa bit only when present") {
    val mu = IsaConfig.rv32
    assert((mu.misaValue & (BigInt(1) << ('S' - 'A'))).toInt == 0)
    // RV64 roadmap hart with M/S/U carries the S bit.
    val msu = IsaConfig(64, Set(RvExtension.Zicsr), PrivConfig.MSU)
    assert((msu.misaValue & (BigInt(1) << ('S' - 'A'))).toInt != 0)
  }

  // ---- privilege stack rules ----------------------------------------------
  test("S mode requires U mode") {
    intercept[IllegalArgumentException] {
      PrivConfig(Set(PrivMode.M, PrivMode.S))
    }
  }

  test("M is mandatory") {
    intercept[IllegalArgumentException] {
      PrivConfig(Set(PrivMode.U))
    }
  }

  test("S/H on RV32 is rejected (RV64 roadmap)") {
    intercept[IllegalArgumentException] {
      IsaConfig(32, Set(RvExtension.Zicsr), PrivConfig.MSU)
    }
  }

  test("H mode requires S mode") {
    intercept[IllegalArgumentException] {
      IsaConfig(64, Set(RvExtension.Zicsr),
        PrivConfig(Set(PrivMode.M, PrivMode.U, PrivMode.H)))
    }
  }

  // ---- naming ---------------------------------------------------------------
  test("canonical names") {
    assert(IsaConfig.rv32.canonicalName == "RV32I_Zicsr  M/U")
    assert(IsaConfig.rv32im.canonicalName == "RV32IM_Zicsr  M/U")
  }

  // ---- CoreConfig forwarding -----------------------------------------------
  test("CoreConfig forwards ISA-derived knobs") {
    import rv32c.CoreConfig
    val cfg = CoreConfig.rv32im
    assert(cfg.xlen == 32)
    assert(cfg.hasMulDiv)
    assert(cfg.misaValue == 0x40101100L)
    assert(cfg.bytePerXlen == 4)
    val plain = CoreConfig()
    assert(!plain.hasMulDiv && plain.misaValue == 0x40100100L)
  }
}
