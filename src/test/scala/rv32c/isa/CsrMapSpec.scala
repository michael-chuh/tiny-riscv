package rv32c.isa

import org.scalatest.funsuite.AnyFunSuite

/** Unit checks for the CSR metadata table that drives both the CSR read path
  * and the EX-stage legality checks. */
class CsrMapSpec extends AnyFunSuite {

  test("CSR addresses are unique") {
    assert(CsrMap.all.map(_.addr).distinct.size == CsrMap.all.size)
  }

  test("byAddr resolves the machine CSRs") {
    assert(CsrMap.byAddr(0x300).name == "mstatus")
    assert(CsrMap.byAddr(0x301).name == "misa")
    assert(CsrMap.byAddr(0xF14).name == "mhartid")
  }

  test("implementedFor includes every machine CSR on an M/U hart") {
    val impl = CsrMap.implementedFor(IsaConfig.rv32)
    // On a hart without an FPU the FP CSRs (fcsr/fflags/frm) are absent, and
    // without S mode the delegation CSRs (medeleg/mideleg) do not exist.
    val expected = CsrMap.all
      .filter(d => !d.requiresFpu && !d.requiresSupervisor && d.minPriv != PrivMode.S)
      .map(_.addr).toSet
    assert(impl.map(_.addr).toSet == expected)
  }

  test("implementedFor exposes the FP CSRs on an FPU hart") {
    val impl = CsrMap.implementedFor(IsaConfig.rv64d).map(_.addr).toSet
    assert(impl.contains(0x001) && impl.contains(0x002) && impl.contains(0x003))
  }

  test("read-only set is exactly misa / mip / mhartid") {
    val ro = CsrMap.readOnlyFor(IsaConfig.rv32).map(_.addr).toSet
    assert(ro == Set(0x301, 0x344, 0xF14))
  }

  test("read-only CSRs are a subset of the implemented CSRs") {
    for (isa <- Seq(IsaConfig.rv32, IsaConfig.rv32im, IsaConfig.rv64)) {
      val impl = CsrMap.implementedFor(isa).map(_.addr).toSet
      val ro = CsrMap.readOnlyFor(isa).map(_.addr).toSet
      assert(ro.subsetOf(impl))
    }
  }

  test("exception codes match the RISC-V privileged spec") {
    assert(ExceptionCode.instructionIllegal == 2)
    assert(ExceptionCode.breakpoint == 3)
    assert(ExceptionCode.ecallFromU == 8)
    assert(ExceptionCode.ecallFromS == 9)
    assert(ExceptionCode.ecallFromM == 11)
  }
}
