package rv32c.sim

import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinal.core.sim._
import rv32c._
import rv32c.isa._

class RiscvCoreTest extends AnyFunSuite {
  val program = Seq[Long](
    0x00500093L, // addi x1,x0,5
    0x00700113L, // addi x2,x0,7
    0x002081B3L, // add x3,x1,x2     (x3=12, forwarding)
    0x00302023L, // sw x3,0(x0)
    0x00002203L, // lw x4,0(x0)      (x4=12)
    0x00120333L, // add x6,x4,x1     (x6=17, load-use hazard)
    0x00320463L, // beq x4,x3,+8     (taken -> skip addi x7)
    0x06300393L, // addi x7,x0,99    (skipped)
    0x0000006FL  // jal x0,0         (self-loop at 0x20)
  )

  // RV32M program: exercises mul/mulh/mulhsu/mulhu, div/divu/rem/remu (signed &
  // unsigned, negatives, div-by-zero, min/-1 overflow), and forwarding of a
  // divider result into a following instruction (x30 = x12 + x1).
  val mProgram = Seq[Long](
    0x00d00093L, // addi x1,x0,13
    0x00500113L, // addi x2,x0,5
    0xff900193L, // addi x3,x0,-7
    0x00600213L, // addi x4,x0,6
    0xffe00293L, // addi x5,x0,-2
    0xfff00313L, // addi x6,x0,-1
    0x800003b7L, // lui  x7,0x80000       (x7 = 0x80000000)
    0x02208433L, // mul   x8,x1,x2
    0x024194b3L, // mulh  x9,x3,x4
    0x0261a533L, // mulhsu x10,x3,x6
    0x0262b5b3L, // mulhu x11,x5,x6
    0x0220c633L, // div   x12,x1,x2       (2)
    0x0220e6b3L, // rem   x13,x1,x2       (3)
    0x00160f33L, // add   x30,x12,x1      (15, forward divider result)
    0x0241d733L, // divu  x14,x3,x4
    0x0241f7b3L, // remu  x15,x3,x4
    0x0230c833L, // div   x16,x1,x3       (13/-7 = -1)
    0x0230e8b3L, // rem   x17,x1,x3       (13%-7 = 6)
    0x0241c933L, // div   x18,x3,x4       (-7/6 = -1)
    0x0241e9b3L, // rem   x19,x3,x4       (-7%6 = -1)
    0x02315a33L, // divu  x20,x2,x3       (5/0xfffffff9 = 0)
    0x02317ab3L, // remu  x21,x2,x3       (5)
    0x0263cb33L, // div   x22,x7,x6       (0x80000000/-1 overflow)
    0x0263ebb3L, // rem   x23,x7,x6       (0)
    0x0200cc33L, // div   x24,x1,x0       (div-by-zero -> all ones)
    0x0200ecb3L, // rem   x25,x1,x0       (rem-by-zero -> 13)
    0x0200dd33L, // divu  x26,x1,x0       (all ones)
    0x0200fdb3L, // remu  x27,x1,x0       (13)
    0x0211ce33L, // div   x28,x3,x1       (-7/13 = 0)
    0x0211eeb3L, // rem   x29,x3,x1       (-7%13 = -7)
    0x0000006fL  // jal x0,0              (self-loop at 0x78)
  )

  // RV64I program: 64-bit add/shift sign-extension, W-suffix ops (low 32 bits
  // sign-extended to 64), LD/SD/LW/LWU load-extension. Self-loops at 0x58.
  val rv64Program = Seq[Long](
    0xFFF00093L, // addi  x1,x0,-1        x1 = 0xFFFFFFFFFFFFFFFF
    0x12345137L, // lui   x2,0x12345      x2 = 0x0000000012345000
    0x00400513L, // addi  x10,x0,4        x10 = 4 (shift amount)
    0x00409193L, // slli  x3,x1,4         x3 = 0xFFFFFFFFFFFFFFF0
    0x4040D213L, // srai  x4,x1,4         x4 = 0xFFFFFFFFFFFFFFFF
    0xFFF00293L, // addi  x5,x0,-1        x5 = 0xFFFFFFFFFFFFFFFF
    0x0012831BL, // addiw x6,x5,1         x6 = 0 (32-bit wrap, sign-extend)
    0x800003B7L, // lui   x7,0x80000      x7 = 0xFFFFFFFF80000000
    0x0013841BL, // addiw x8,x7,1         x8 = 0xFFFFFFFF80000001
    0x00A094BBL, // sllw  x9,x1,x10       x9 = 0xFFFFFFFFFFFFFFF0
    0x40A0D5BBL, // sraw  x11,x1,x10      x11 = 0xFFFFFFFFFFFFFFFF
    0x00A0D63BL, // srlw  x12,x1,x10      x12 = 0x000000000FFFFFFF
    0x00103023L, // sd    x1,0(x0)        mem[0] = 0xFFFFFFFFFFFFFFFF
    0x00203423L, // sd    x2,8(x0)        mem[8] = 0x0000000012345000
    0x00703823L, // sd    x7,16(x0)       mem[16] = 0xFFFFFFFF80000000
    0x00003683L, // ld    x13,0(x0)       x13 = 0xFFFFFFFFFFFFFFFF
    0x00806703L, // lwu   x14,8(x0)       x14 = 0x0000000012345000
    0x00802783L, // lw    x15,8(x0)       x15 = 0x0000000012345000
    0x01002803L, // lw    x16,16(x0)      x16 = 0xFFFFFFFF80000000 (sign-ext)
    0x01006883L, // lwu   x17,16(x0)      x17 = 0x0000000080000000
    0x00108913L, // addi  x18,x1,1        x18 = 0 (64-bit wrap)
    0x001089B3L, // add   x19,x1,x1       x19 = 0xFFFFFFFFFFFFFFFE
    0x0000006FL  // jal   x0,0            self-loop at 0x58
  )

  def runUntil(tb: CpuTb, maxCycles: Int, pc: BigInt, reg: Int, value: BigInt): Int = {
    var cycles = 0
    while (cycles < maxCycles) {
      tb.clockDomain.waitSampling()
      cycles += 1
      if (tb.io.debugPc.toBigInt == pc && tb.io.debugRegs(reg).toBigInt == value) {
        return cycles
      }
    }
    cycles
  }

  test("RV32I basic program") {
    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(CoreConfig(), program))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5) // flush reset

        val cycles = runUntil(dut, 200, 0x20, 6, 17)
        assert(cycles < 200, "program did not finish")

        assert(dut.io.debugRegs(1).toBigInt == 5, "x1 should be 5")
        assert(dut.io.debugRegs(2).toBigInt == 7, "x2 should be 7")
        assert(dut.io.debugRegs(3).toBigInt == 12, "x3 should be 12 (forwarded add)")
        assert(dut.io.debugRegs(4).toBigInt == 12, "x4 should be 12 (loaded)")
        assert(dut.io.debugRegs(6).toBigInt == 17, "x6 should be 17 (load-use)")
        assert(dut.io.debugRegs(7).toBigInt == 0, "x7 should stay 0 (branch skipped)")
        println(s"PASS: finished in $cycles cycles")
      }
  }

  test("RV32M multiply/divide program") {
    val cfg = CoreConfig.rv32im
    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(cfg, mProgram))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5) // flush reset

        // x29 (last write, from rem x3,x1) is the in-order tail of the program.
        val cycles = runUntil(dut, 3000, 0x78, 29, 0xfffffff9L)
        assert(cycles < 3000, "program did not finish")
        dut.clockDomain.waitSampling(3) // settle

        assert(dut.io.debugRegs(8).toBigInt == 0x41L, "x8 should be 65 (mul)")
        assert(dut.io.debugRegs(9).toBigInt == 0xffffffffL, "x9 should be -1 (mulh)")
        assert(dut.io.debugRegs(10).toBigInt == 0xfffffff9L, "x10 should be -7 (mulhsu)")
        assert(dut.io.debugRegs(11).toBigInt == 0xfffffffdL, "x11 should be 0xfffffffd (mulhu)")
        assert(dut.io.debugRegs(12).toBigInt == 2, "x12 should be 2 (13/5)")
        assert(dut.io.debugRegs(13).toBigInt == 3, "x13 should be 3 (13%5)")
        assert(dut.io.debugRegs(14).toBigInt == 0x2aaaaaa9L, "x14 should be 0x2aaaaaa9 (divu)")
        assert(dut.io.debugRegs(15).toBigInt == 3, "x15 should be 3 (remu)")
        assert(dut.io.debugRegs(16).toBigInt == 0xffffffffL, "x16 should be -1 (13/-7)")
        assert(dut.io.debugRegs(17).toBigInt == 6, "x17 should be 6 (13%-7)")
        assert(dut.io.debugRegs(18).toBigInt == 0xffffffffL, "x18 should be -1 (-7/6)")
        assert(dut.io.debugRegs(19).toBigInt == 0xffffffffL, "x19 should be -1 (-7%6)")
        assert(dut.io.debugRegs(20).toBigInt == 0, "x20 should be 0 (divu 5/0xfffffff9)")
        assert(dut.io.debugRegs(21).toBigInt == 5, "x21 should be 5 (remu)")
        assert(dut.io.debugRegs(22).toBigInt == 0x80000000L, "x22 should be 0x80000000 (min/-1)")
        assert(dut.io.debugRegs(23).toBigInt == 0, "x23 should be 0 (rem min/-1)")
        assert(dut.io.debugRegs(24).toBigInt == 0xffffffffL, "x24 should be all-ones (div/0)")
        assert(dut.io.debugRegs(25).toBigInt == 13, "x25 should be 13 (rem/0)")
        assert(dut.io.debugRegs(26).toBigInt == 0xffffffffL, "x26 should be all-ones (divu/0)")
        assert(dut.io.debugRegs(27).toBigInt == 13, "x27 should be 13 (remu/0)")
        assert(dut.io.debugRegs(28).toBigInt == 0, "x28 should be 0 (-7/13)")
        assert(dut.io.debugRegs(29).toBigInt == 0xfffffff9L, "x29 should be -7 (-7%13)")
        assert(dut.io.debugRegs(30).toBigInt == 15, "x30 should be 15 (div-result forwarding)")
        println(s"PASS: finished in $cycles cycles")
      }
  }

  test("RV64I basic program") {
    val cfg = CoreConfig(isa = IsaConfig(64, Set(RvExtension.Zicsr), PrivConfig.MU))
    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(cfg, rv64Program))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5) // flush reset

        val allOnes = BigInt("FFFFFFFFFFFFFFFF", 16)
        val cycles = runUntil(dut, 400, 0x58, 19, BigInt("FFFFFFFFFFFFFFFE", 16))
        assert(cycles < 400, "program did not finish")
        dut.clockDomain.waitSampling(3) // settle

        assert(dut.io.debugRegs(1).toBigInt == allOnes, "x1 = -1 (64-bit addi)")
        assert(dut.io.debugRegs(2).toBigInt == BigInt("12345000", 16), "x2 = lui")
        assert(dut.io.debugRegs(3).toBigInt == BigInt("FFFFFFFFFFFFFFF0", 16), "x3 = slli 64-bit")
        assert(dut.io.debugRegs(4).toBigInt == allOnes, "x4 = srai 64-bit")
        assert(dut.io.debugRegs(5).toBigInt == allOnes, "x5 = -1")
        assert(dut.io.debugRegs(6).toBigInt == 0, "x6 = addiw 32-bit wrap")
        assert(dut.io.debugRegs(7).toBigInt == BigInt("FFFFFFFF80000000", 16), "x7 = lui sign-extend")
        assert(dut.io.debugRegs(8).toBigInt == BigInt("FFFFFFFF80000001", 16), "x8 = addiw sign-extend")
        assert(dut.io.debugRegs(9).toBigInt == BigInt("FFFFFFFFFFFFFFF0", 16), "x9 = sllw sign-extend")
        assert(dut.io.debugRegs(11).toBigInt == allOnes, "x11 = sraw sign-extend")
        assert(dut.io.debugRegs(12).toBigInt == BigInt("FFFFFFF", 16), "x12 = srlw sign-extend")
        assert(dut.io.debugRegs(13).toBigInt == allOnes, "x13 = ld")
        assert(dut.io.debugRegs(14).toBigInt == BigInt("12345000", 16), "x14 = lwu zero-extend")
        assert(dut.io.debugRegs(15).toBigInt == BigInt("12345000", 16), "x15 = lw (positive)")
        assert(dut.io.debugRegs(16).toBigInt == BigInt("FFFFFFFF80000000", 16), "x16 = lw sign-extend")
        assert(dut.io.debugRegs(17).toBigInt == BigInt("80000000", 16), "x17 = lwu zero-extend")
        assert(dut.io.debugRegs(18).toBigInt == 0, "x18 = 64-bit add wrap")
        assert(dut.io.debugRegs(19).toBigInt == BigInt("FFFFFFFFFFFFFFFE", 16), "x19 = 64-bit add")
        println(s"PASS: RV64I finished in $cycles cycles")
      }
  }
}
