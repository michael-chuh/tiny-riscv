package rv32c.isa

import org.scalatest.funsuite.AnyFunSuite
import rv32c.CoreConfig

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

  test("rv64imc misa is MXL=2 | I | M | C | U") {
    val isa = IsaConfig.rv64imc
    assert(isa.isRV64 && isa.hasMulDiv && isa.hasCompressed)
    val expected = (BigInt(2) << 62) | (BigInt(1) << ('I' - 'A')) |
      (BigInt(1) << ('M' - 'A')) | (BigInt(1) << ('C' - 'A')) | (BigInt(1) << ('U' - 'A'))
    assert(isa.misaValue == expected, f"0x${isa.misaValue}%x")
  }

  test("rv32ima misa is MXL=1 | I | M | A | U") {
    val isa = IsaConfig.rv32ima
    assert(!isa.isRV64 && isa.hasMulDiv && isa.hasAtomic)
    val expected = (BigInt(1) << 30) | (BigInt(1) << ('I' - 'A')) |
      (BigInt(1) << ('M' - 'A')) | (BigInt(1) << ('A' - 'A')) | (BigInt(1) << ('U' - 'A'))
    assert(isa.misaValue == expected, f"0x${isa.misaValue}%x")
  }

  test("rv64ima misa is MXL=2 | I | M | A | U") {
    val isa = IsaConfig.rv64ima
    assert(isa.isRV64 && isa.hasMulDiv && isa.hasAtomic)
    val expected = (BigInt(2) << 62) | (BigInt(1) << ('I' - 'A')) |
      (BigInt(1) << ('M' - 'A')) | (BigInt(1) << ('A' - 'A')) | (BigInt(1) << ('U' - 'A'))
    assert(isa.misaValue == expected, f"0x${isa.misaValue}%x")
  }

  test("extension letters are bit-indexed from 'A'") {
    def bit(c: Char) = c - 'A'
    assert(bit('I') == 8 && bit('M') == 12 && bit('U') == 20 && bit('S') == 18)
  }

  // ---- F/D floating-point configuration ------------------------------------
  test("rv32f misa is MXL=1 | I | F | U") {
    val isa = IsaConfig.rv32f
    assert(!isa.isRV64 && isa.hasSingleFloat && isa.hasFpu)
    assert(!isa.hasDoubleFloat)
    assert(isa.flen == 32)
    val expected = (BigInt(1) << 30) | (BigInt(1) << ('I' - 'A')) |
      (BigInt(1) << ('F' - 'A')) | (BigInt(1) << ('U' - 'A'))
    assert(isa.misaValue == expected, f"0x${isa.misaValue}%x")
  }

  test("rv64d misa is MXL=2 | I | F | D | U and FLEN=64") {
    val isa = IsaConfig.rv64d
    assert(isa.isRV64 && isa.hasSingleFloat && isa.hasDoubleFloat)
    assert(isa.flen == 64)
    val expected = (BigInt(2) << 62) | (BigInt(1) << ('I' - 'A')) |
      (BigInt(1) << ('F' - 'A')) | (BigInt(1) << ('D' - 'A')) | (BigInt(1) << ('U' - 'A'))
    assert(isa.misaValue == expected, f"0x${isa.misaValue}%x")
  }

  // ---- Zbb bit-manipulation configuration ----------------------------------
  test("rv32imzbb exposes Zbb without a reserved misa B bit") {
    val isa = IsaConfig.rv32imzbb
    assert(isa.hasZbb && isa.hasMulDiv)
    assert(isa.misaValue == IsaConfig.rv32im.misaValue)
    assert(isa.canonicalName == "RV32IM_Zbb_Zicsr  M/U")
  }

  test("rv64imzbb exposes Zbb on an RV64 hart") {
    val isa = IsaConfig.rv64imzbb
    assert(isa.isRV64 && isa.hasMulDiv && isa.hasZbb)
    assert(isa.canonicalName == "RV64IM_Zbb_Zicsr  M/U")
  }

  test("rv32imzbs exposes Zbs without a reserved misa B bit") {
    val isa = IsaConfig.rv32imzbs
    assert(isa.hasZbs && isa.hasMulDiv && !isa.hasZbb)
    assert(isa.misaValue == IsaConfig.rv32im.misaValue)
    assert(isa.canonicalName == "RV32IM_Zbs_Zicsr  M/U")
  }

  test("rv64imzbs exposes Zbs on an RV64 hart") {
    val isa = IsaConfig.rv64imzbs
    assert(isa.isRV64 && isa.hasMulDiv && isa.hasZbs)
    assert(isa.canonicalName == "RV64IM_Zbs_Zicsr  M/U")
  }

  test("rv32imzba exposes Zba without a reserved misa B bit") {
    val isa = IsaConfig.rv32imzba
    assert(isa.hasZba && isa.hasMulDiv && !isa.hasZbb && !isa.hasZbs)
    assert(isa.misaValue == IsaConfig.rv32im.misaValue)
    assert(isa.canonicalName == "RV32IM_Zba_Zicsr  M/U")
  }

  test("rv64imzba exposes Zba on an RV64 hart") {
    val isa = IsaConfig.rv64imzba
    assert(isa.isRV64 && isa.hasMulDiv && isa.hasZba)
    assert(isa.canonicalName == "RV64IM_Zba_Zicsr  M/U")
  }

  test("rv32imzbc exposes Zbc without a reserved misa B bit") {
    val isa = IsaConfig.rv32imzbc
    assert(isa.hasZbc && isa.hasMulDiv && !isa.hasZba && !isa.hasZbb)
    assert(isa.misaValue == IsaConfig.rv32im.misaValue)
    assert(isa.canonicalName == "RV32IM_Zbc_Zicsr  M/U")
  }

  test("rv64imzbc exposes Zbc on an RV64 hart") {
    val isa = IsaConfig.rv64imzbc
    assert(isa.isRV64 && isa.hasMulDiv && isa.hasZbc)
    assert(isa.canonicalName == "RV64IM_Zbc_Zicsr  M/U")
  }

  test("D implies F") {
    intercept[IllegalArgumentException] {
      IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.DoubleFloat), PrivConfig.MU)
    }
  }

  test("D on RV32 is rejected") {
    intercept[IllegalArgumentException] {
      IsaConfig(32, Set(RvExtension.Zicsr, RvExtension.SingleFloat, RvExtension.DoubleFloat), PrivConfig.MU)
    }
  }

  test("F/D CSRs appear only when the FPU is enabled") {
    val withF = CoreConfig.rv64d
    val without = CoreConfig()
    assert(CsrMap.implementedFor(without.isa).forall(!_.requiresFpu))
    assert(CsrMap.implementedFor(withF.isa).exists(_.name == "fcsr"))
    assert(CsrMap.implementedFor(withF.isa).exists(_.name == "fflags"))
    assert(CsrMap.implementedFor(withF.isa).exists(_.name == "frm"))
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

  test("PrivConfig exposes membership and supported encodings") {
    assert(PrivConfig.MU.contains(PrivMode.U))
    assert(!PrivConfig.MU.contains(PrivMode.S))
    assert(PrivConfig.MU.supportedEncodings == Set(0, 3))
    assert(PrivConfig.MSU.supportedEncodings == Set(0, 1, 3))
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
    val atomic = CoreConfig.rv32ima
    assert(atomic.hasAtomic && !atomic.hasCompressed)
    assert(!plain.hasAtomic)
    val zbb = CoreConfig.rv32imzbb
    assert(zbb.hasZbb && !zbb.hasAtomic && !zbb.hasFloat)
    assert(!plain.hasZbb)
    val zbs = CoreConfig.rv32imzbs
    assert(zbs.hasZbs && !zbs.hasZbb)
    assert(!plain.hasZbs)
    val zba = CoreConfig.rv32imzba
    assert(zba.hasZba && !zba.hasZbb && !zba.hasZbs)
    assert(!plain.hasZba)
    val zbc = CoreConfig.rv32imzbc
    assert(zbc.hasZbc && !zbc.hasZba)
    assert(!plain.hasZbc)
  }
}
