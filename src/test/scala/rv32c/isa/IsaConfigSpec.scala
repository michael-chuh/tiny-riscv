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

  test("rv32imzbkb exposes Zbkb without a reserved misa B bit") {
    val isa = IsaConfig.rv32imzbkb
    assert(isa.hasZbkb && isa.hasMulDiv && !isa.hasZbc && !isa.hasZbkx)
    assert(isa.misaValue == IsaConfig.rv32im.misaValue)
    assert(isa.canonicalName == "RV32IM_Zbkb_Zicsr  M/U")
  }

  test("rv64imzbkb exposes Zbkb on an RV64 hart") {
    val isa = IsaConfig.rv64imzbkb
    assert(isa.isRV64 && isa.hasMulDiv && isa.hasZbkb)
    assert(isa.canonicalName == "RV64IM_Zbkb_Zicsr  M/U")
  }

  test("rv32imzbkc exposes Zbkc without the full Zbc set") {
    val isa = IsaConfig.rv32imzbkc
    assert(isa.hasZbkc && !isa.hasZbc && !isa.hasZbkb && !isa.hasZbkx)
    assert(isa.misaValue == IsaConfig.rv32im.misaValue)
    assert(isa.canonicalName == "RV32IM_Zbkc_Zicsr  M/U")
  }

  test("rv32imzbkx exposes Zbkx without a reserved misa B bit") {
    val isa = IsaConfig.rv32imzbkx
    assert(isa.hasZbkx && !isa.hasZbkb && !isa.hasZbkc)
    assert(isa.misaValue == IsaConfig.rv32im.misaValue)
    assert(isa.canonicalName == "RV32IM_Zbkx_Zicsr  M/U")
  }

  test("rv32imzbk combines Zbkb, Zbkc and Zbkx") {
    val isa = IsaConfig.rv32imzbk
    assert(isa.hasZbkb && isa.hasZbkc && isa.hasZbkx && !isa.hasZbc)
    assert(isa.misaValue == IsaConfig.rv32im.misaValue)
    assert(isa.canonicalName == "RV32IM_Zbkb_Zbkc_Zbkx_Zicsr  M/U")
  }

  test("rv64imzbk combines Zbkb, Zbkc and Zbkx on an RV64 hart") {
    val isa = IsaConfig.rv64imzbk
    assert(isa.isRV64 && isa.hasZbkb && isa.hasZbkc && isa.hasZbkx)
    assert(isa.canonicalName == "RV64IM_Zbkb_Zbkc_Zbkx_Zicsr  M/U")
  }

  test("rv32imzknh exposes Zknh without a reserved misa B bit") {
    val isa = IsaConfig.rv32imzknh
    assert(isa.hasZknh && isa.hasMulDiv && !isa.hasZbkb && !isa.hasZbc)
    assert(isa.misaValue == IsaConfig.rv32im.misaValue)
    assert(isa.canonicalName == "RV32IM_Zicsr_Zknh  M/U")
  }

  test("rv64imzknh exposes Zknh on an RV64 hart") {
    val isa = IsaConfig.rv64imzknh
    assert(isa.isRV64 && isa.hasZknh && isa.hasMulDiv)
    assert(isa.canonicalName == "RV64IM_Zicsr_Zknh  M/U")
  }

  test("rv32imzksh exposes Zksh without a reserved misa B bit") {
    val isa = IsaConfig.rv32imzksh
    assert(isa.hasZksh && isa.hasMulDiv && !isa.hasZksed && !isa.hasZknh)
    assert(isa.misaValue == IsaConfig.rv32im.misaValue)
    assert(isa.canonicalName == "RV32IM_Zicsr_Zksh  M/U")
  }

  test("rv64imzksh exposes Zksh on an RV64 hart") {
    val isa = IsaConfig.rv64imzksh
    assert(isa.isRV64 && isa.hasZksh && isa.hasMulDiv)
    assert(isa.canonicalName == "RV64IM_Zicsr_Zksh  M/U")
  }

  test("rv32imzksed exposes Zksed without a reserved misa B bit") {
    val isa = IsaConfig.rv32imzksed
    assert(isa.hasZksed && isa.hasMulDiv && !isa.hasZksh)
    assert(isa.canonicalName == "RV32IM_Zicsr_Zksed  M/U")
  }

  test("rv32imzks combines Zksh and Zksed") {
    val isa = IsaConfig.rv32imzks
    assert(isa.hasZksh && isa.hasZksed && !isa.hasZknh)
    assert(isa.canonicalName == "RV32IM_Zicsr_Zksed_Zksh  M/U")
  }

  test("rv64imzks combines Zksh and Zksed on an RV64 hart") {
    val isa = IsaConfig.rv64imzks
    assert(isa.isRV64 && isa.hasZksh && isa.hasZksed)
    assert(isa.canonicalName == "RV64IM_Zicsr_Zksed_Zksh  M/U")
  }

  test("rv32imzkne exposes Zkne without a reserved misa B bit") {
    val isa = IsaConfig.rv32imzkne
    assert(isa.hasZkne && isa.hasMulDiv && !isa.hasZknd && !isa.hasZksed)
    assert(isa.misaValue == IsaConfig.rv32im.misaValue)
    assert(isa.canonicalName == "RV32IM_Zicsr_Zkne  M/U")
  }

  test("rv64imzkne exposes Zkne on an RV64 hart") {
    val isa = IsaConfig.rv64imzkne
    assert(isa.isRV64 && isa.hasZkne && isa.hasMulDiv)
    assert(isa.canonicalName == "RV64IM_Zicsr_Zkne  M/U")
  }

  test("rv32imzknd exposes Zknd without a reserved misa B bit") {
    val isa = IsaConfig.rv32imzknd
    assert(isa.hasZknd && isa.hasMulDiv && !isa.hasZkne)
    assert(isa.canonicalName == "RV32IM_Zicsr_Zknd  M/U")
  }

  test("rv64imzknd exposes Zknd on an RV64 hart") {
    val isa = IsaConfig.rv64imzknd
    assert(isa.isRV64 && isa.hasZknd && isa.hasMulDiv)
    assert(isa.canonicalName == "RV64IM_Zicsr_Zknd  M/U")
  }

  test("rv32imzkn combines Zkne and Zknd") {
    val isa = IsaConfig.rv32imzkn
    assert(isa.hasZkne && isa.hasZknd && !isa.hasZksed)
    assert(isa.canonicalName == "RV32IM_Zicsr_Zknd_Zkne  M/U")
  }

  test("rv64imzkn combines Zkne and Zknd on an RV64 hart") {
    val isa = IsaConfig.rv64imzkn
    assert(isa.isRV64 && isa.hasZkne && isa.hasZknd)
    assert(isa.canonicalName == "RV64IM_Zicsr_Zknd_Zkne  M/U")
  }

  test("rv32imzicond exposes Zicond without a reserved misa B bit") {
    val isa = IsaConfig.rv32imzicond
    assert(isa.hasZicond && isa.hasMulDiv && !isa.hasZkne && !isa.hasZknd)
    assert(isa.misaValue == IsaConfig.rv32im.misaValue)
    assert(isa.canonicalName == "RV32IM_Zicond_Zicsr  M/U")
  }

  test("rv64imzicond exposes Zicond on an RV64 hart") {
    val isa = IsaConfig.rv64imzicond
    assert(isa.isRV64 && isa.hasZicond && isa.hasMulDiv)
    assert(isa.canonicalName == "RV64IM_Zicond_Zicsr  M/U")
  }

  test("rv32imzcb adds Zcb on a compressed RV32IMC_Zbb hart") {
    val isa = IsaConfig.rv32imzcb
    assert(isa.hasZcb && isa.hasCompressed && isa.hasZbb && isa.hasMulDiv)
    assert(!isa.hasZba && !isa.isRV64)
    assert(isa.misaValue == IsaConfig.rv32imc.misaValue)
    assert(isa.canonicalName == "RV32IMC_Zbb_Zcb_Zicsr  M/U")
  }

  test("rv32imzifencei exposes Zifencei without a reserved misa bit") {
    val isa = IsaConfig.rv32imzifencei
    assert(isa.hasZifencei && isa.hasMulDiv && !isa.hasZicond)
    assert(isa.misaValue == IsaConfig.rv32im.misaValue)
    assert(isa.canonicalName == "RV32IM_Zicsr_Zifencei  M/U")
  }

  test("rv64imzifencei exposes Zifencei on an RV64 hart") {
    val isa = IsaConfig.rv64imzifencei
    assert(isa.isRV64 && isa.hasZifencei && isa.hasMulDiv)
    assert(isa.canonicalName == "RV64IM_Zicsr_Zifencei  M/U")
  }

  test("no extension is left in the reserved set") {
    assert(RvExtension.reserved.isEmpty)
    assert(RvExtension.implemented.contains(RvExtension.Zifencei))
  }

  test("rv64imzcb adds Zcb with Zba and Zbb on an RV64 hart") {
    val isa = IsaConfig.rv64imzcb
    assert(isa.isRV64 && isa.hasZcb && isa.hasCompressed && isa.hasZba && isa.hasZbb)
    assert(isa.canonicalName == "RV64IMC_Zba_Zbb_Zcb_Zicsr  M/U")
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
    val zbkb = CoreConfig.rv32imzbkb
    assert(zbkb.hasZbkb && !zbkb.hasZbc && !zbkb.hasZbkx)
    assert(!plain.hasZbkb)
    val zbkc = CoreConfig.rv32imzbkc
    assert(zbkc.hasZbkc && !zbkc.hasZbc)
    assert(!plain.hasZbkc)
    val zbkx = CoreConfig.rv32imzbkx
    assert(zbkx.hasZbkx && !zbkx.hasZbkb)
    assert(!plain.hasZbkx)
    val zbk = CoreConfig.rv32imzbk
    assert(zbk.hasZbkb && zbk.hasZbkc && zbk.hasZbkx)
    assert(!plain.hasZbkb && !plain.hasZbkc && !plain.hasZbkx)
    val zknh = CoreConfig.rv32imzknh
    assert(zknh.hasZknh && CoreConfig.rv64imzknh.hasZknh)
    assert(!plain.hasZknh)
    val zkne = CoreConfig.rv32imzkne
    assert(zkne.hasZkne && CoreConfig.rv64imzkne.hasZkne && !zkne.hasZknd)
    assert(!plain.hasZkne)
    val zknd = CoreConfig.rv32imzknd
    assert(zknd.hasZknd && CoreConfig.rv64imzknd.hasZknd && !zknd.hasZkne)
    assert(!plain.hasZknd)
    val zkn = CoreConfig.rv32imzkn
    assert(zkn.hasZkne && zkn.hasZknd)
    assert(!plain.hasZkne && !plain.hasZknd)
    val zicond = CoreConfig.rv32imzicond
    assert(zicond.hasZicond && CoreConfig.rv64imzicond.hasZicond)
    assert(!plain.hasZicond)
    assert(CoreConfig.rv32imzcb.hasZcb && CoreConfig.rv64imzcb.hasZcb)
    assert(!plain.hasZcb)
    assert(CoreConfig.rv32imzifencei.hasZifencei && CoreConfig.rv64imzifencei.hasZifencei)
    assert(!plain.hasZifencei)
  }
}
