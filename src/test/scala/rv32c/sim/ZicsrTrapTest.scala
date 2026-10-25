package rv32c.sim

import scala.collection.mutable
import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinal.core.sim._
import rv32c._

/** Two-pass RV32I+Zicsr mini assembler used to build the trap/interrupt/CSR
  * test programs. Each instruction word occupies one index (address = 4*index).
  */
object TAsm {
  val MSTATUS = 0x300
  val MISA = 0x301
  val MIE = 0x304
  val MTVEC = 0x305
  val MSCRATCH = 0x340
  val MEPC = 0x341
  val MCAUSE = 0x342
  val MTVAL = 0x343
  val MIP = 0x344
  val MHARTID = 0xF14
  val MEDELEG = 0x302
  val MIDELEG = 0x303
  val SSTATUS = 0x100
  val SIE = 0x104
  val STVEC = 0x105
  val SSCRATCH = 0x140
  val SEPC = 0x141
  val SCAUSE = 0x142
  val STVAL = 0x143
  val SIP = 0x144
  val SATP = 0x180
  val MCOUNTEREN = 0x306
  val MCYCLE = 0xB00
  val MINSTRET = 0xB02
  val SCOUNTEREN = 0x106
  val CYCLE = 0xC00
  val TIME = 0xC01
  val INSTRET = 0xC02
  val CYCLEH = 0xC80
  val TIMEH = 0xC81
  val INSTRETH = 0xC82

  val ECALL = 0x00000073L
  val EBREAK = 0x00100073L
  val MRET = 0x30200073L
  val SRET = 0x10200073L
  val WFI = 0x10500073L
  val ILLEGAL_WORD = 0xFFFFFFFFL

  type F = (Int, mutable.Map[String, Int]) => Long

  def encR(f7: Int, rs2: Int, rs1: Int, f3: Int, rd: Int, op: Int): Long =
    ((f7.toLong & 0x7f) << 25) | ((rs2.toLong & 0x1f) << 20) | ((rs1.toLong & 0x1f) << 15) |
      ((f3.toLong & 0x7) << 12) | ((rd.toLong & 0x1f) << 7) | (op.toLong & 0x7f)

  def encI(imm: Int, rs1: Int, f3: Int, rd: Int, op: Int): Long =
    ((imm.toLong & 0xfff) << 20) | ((rs1.toLong & 0x1f) << 15) | ((f3.toLong & 0x7) << 12) |
      ((rd.toLong & 0x1f) << 7) | (op.toLong & 0x7f)

  def encS(imm: Int, rs2: Int, rs1: Int, f3: Int, op: Int): Long =
    (((imm >> 5).toLong & 0x7f) << 25) | ((rs2.toLong & 0x1f) << 20) | ((rs1.toLong & 0x1f) << 15) |
      ((f3.toLong & 0x7) << 12) | ((imm.toLong & 0x1f) << 7) | (op.toLong & 0x7f)

  def encB(imm: Int, rs2: Int, rs1: Int, f3: Int): Long =
    ((imm >> 12).toLong & 1) << 31 | (((imm >> 5).toLong & 0x3f) << 25) | ((rs2.toLong & 0x1f) << 20) |
      ((rs1.toLong & 0x1f) << 15) | ((f3.toLong & 0x7) << 12) | (((imm >> 1).toLong & 0xf) << 8) |
      (((imm >> 11).toLong & 1) << 7) | 0x63

  def encU(imm: Int, rd: Int, op: Int): Long =
    ((imm.toLong & 0xfffff) << 12) | ((rd.toLong & 0x1f) << 7) | (op.toLong & 0x7f)

  def encJ(imm: Int, rd: Int): Long =
    ((imm >> 20).toLong & 1) << 31 | (((imm >> 1).toLong & 0x3ff) << 21) | (((imm >> 11).toLong & 1) << 20) |
      (((imm >> 12).toLong & 0xff) << 12) | ((rd.toLong & 0x1f) << 7) | 0x6f
}

class TAsm {
  import TAsm._

  private val labels = mutable.Map.empty[String, Int]
  private val lines = mutable.ArrayBuffer.empty[F]
  private def emit(f: F): Unit = lines += f

  def label(name: String): Unit = labels(name) = lines.length

  def raw(word: Long): Unit = emit((_, _) => word)

  // ---- RV32I ---- //
  def addi(rd: Int, rs1: Int, imm: Int): Unit = emit((_, _) => encI(imm, rs1, 0, rd, 0x13))
  def andi(rd: Int, rs1: Int, imm: Int): Unit = emit((_, _) => encI(imm, rs1, 7, rd, 0x13))
  def add(rd: Int, rs1: Int, rs2: Int): Unit = emit((_, _) => encR(0, rs2, rs1, 0, rd, 0x33))
  def lui(rd: Int, imm20: Int): Unit = emit((_, _) => encU(imm20, rd, 0x37))
  def li(rd: Int, v: Int): Unit = {
    if (v >= -2048 && v < 2048) addi(rd, 0, v)
    else {
      val hi = (v >> 12) & 0xfffff
      val lo = v & 0xfff
      if (lo < 0x800) { lui(rd, hi); addi(rd, rd, lo) }
      else { lui(rd, (hi + 1) & 0xfffff); addi(rd, rd, lo - 0x1000) }
    }
  }
  def beq(rs1: Int, rs2: Int, tgt: String): Unit =
    emit((i, lb) => encB((lb(tgt) - i) * 4, rs2, rs1, 0))
  def bne(rs1: Int, rs2: Int, tgt: String): Unit =
    emit((i, lb) => encB((lb(tgt) - i) * 4, rs2, rs1, 1))
  def j(tgt: String): Unit = beq(0, 0, tgt)
  def jal(rd: Int, tgt: String): Unit = emit((i, lb) => encJ((lb(tgt) - i) * 4, rd))
  def nop(): Unit = addi(0, 0, 0)

  // ---- Zicsr / SYSTEM ---- //
  def csrrw(rd: Int, csr: Int, rs1: Int): Unit = emit((_, _) => encI(csr, rs1, 1, rd, 0x73))
  def csrrs(rd: Int, csr: Int, rs1: Int): Unit = emit((_, _) => encI(csr, rs1, 2, rd, 0x73))
  def csrrc(rd: Int, csr: Int, rs1: Int): Unit = emit((_, _) => encI(csr, rs1, 3, rd, 0x73))
  def csrrwi(rd: Int, csr: Int, zimm: Int): Unit = emit((_, _) => encI(csr, zimm, 5, rd, 0x73))
  def csrrsi(rd: Int, csr: Int, zimm: Int): Unit = emit((_, _) => encI(csr, zimm, 6, rd, 0x73))
  def csrrci(rd: Int, csr: Int, zimm: Int): Unit = emit((_, _) => encI(csr, zimm, 7, rd, 0x73))
  def ecall(): Unit = raw(ECALL)
  def ebreak(): Unit = raw(EBREAK)
  def mret(): Unit = raw(MRET)
  def sret(): Unit = raw(SRET)
  def wfi(): Unit = raw(WFI)

  def build: Seq[Long] = lines.zipWithIndex.map { case (f, i) => f(i, labels) }.toSeq

  /** Index (word address / 4) of a label, for post-build patching. */
  def indexOf(name: String): Int = labels(name)
}

class ZicsrTrapTest extends AnyFunSuite {
  import TAsm._

  private def u32(v: BigInt): BigInt = v & 0xFFFFFFFFL

  /** Poll until debugRegs(reg)==value (registers only written once, at commit). */
  private def runUntilReg(dut: CpuTb, maxCycles: Int, reg: Int, value: BigInt): Int = {
    var cycles = 0
    while (cycles < maxCycles) {
      dut.clockDomain.waitSampling()
      cycles += 1
      if (u32(dut.io.debugRegs(reg).toBigInt) == u32(value)) {
        return cycles
      }
    }
    cycles
  }

  // =====================================================================
  // Zicsr basic: CSR read/write round trips, mask behavior, RO reads.
  // =====================================================================
  test("Zicsr basic CSR read/write") {
    val a = new TAsm
    a.li(1, 0x0F0F0F0F)          // data
    a.li(2, 0x00FF00FF)          // clear/set mask
    a.csrrwi(3, MSCRATCH, 0)     // x3 = 0 (old); mscratch = 0
    a.csrrs(4, MSCRATCH, 1)      // x4 = 0 (old); mscratch = x1
    a.csrrc(5, MSCRATCH, 2)      // x5 = old; mscratch &= ~x2
    a.csrrsi(6, MSCRATCH, 0x1F)  // x6 = old; mscratch |= 0x1F
    a.csrrs(7, MSCRATCH, 0)      // x7 = mscratch (read-only access)
    a.li(8, 0x1888)
    a.csrrw(9, MSTATUS, 8)       // x9 = old mstatus (0); write WARL-masked
    a.csrrs(10, MSTATUS, 0)      // x10 = mstatus (read-only access)
    a.csrrs(11, MISA, 0)
    a.csrrs(12, MHARTID, 0)
    a.csrrs(13, MIP, 0)
    a.csrrw(14, MSCRATCH, 0)     // rs1=x0: read only, no write
    a.csrrs(15, MSCRATCH, 0)
    a.label("done")
    a.addi(30, 0, 1)
    a.j("loop")
    a.label("loop")
    a.j("loop")

    val prog = a.build
    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(CoreConfig(), prog))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5)
        // reset state: mode M, CSRs zero
        assert(u32(dut.io.debugMode.toBigInt) == 3, "mode should reset to M")
        assert(u32(dut.io.debugMepc.toBigInt) == 0, "mepc should reset to 0")
        assert(u32(dut.io.debugMcause.toBigInt) == 0, "mcause should reset to 0")

        val cyc = runUntilReg(dut, 400, 30, 1)
        assert(cyc < 400, "zicsr program did not finish")
        dut.clockDomain.waitSampling(4)

        assert(u32(dut.io.debugRegs(1).toBigInt) == 0x0F0F0F0FL, "x1")
        assert(u32(dut.io.debugRegs(2).toBigInt) == 0x00FF00FFL, "x2")
        assert(u32(dut.io.debugRegs(3).toBigInt) == 0, "x3 = old mscratch 0")
        assert(u32(dut.io.debugRegs(4).toBigInt) == 0, "x4 = old mscratch 0")
        assert(u32(dut.io.debugRegs(5).toBigInt) == 0x0F0F0F0FL, "x5 = old mscratch")
        assert(u32(dut.io.debugRegs(6).toBigInt) == 0x0F000F00L, "x6 = old mscratch")
        assert(u32(dut.io.debugRegs(7).toBigInt) == 0x0F000F1FL, "x7 = mscratch")
        assert(u32(dut.io.debugRegs(9).toBigInt) == 0, "x9 = old mstatus 0")
        assert(u32(dut.io.debugRegs(10).toBigInt) == 0x1888L, "x10 = mstatus WARL write")
        assert(u32(dut.io.debugRegs(11).toBigInt) == 0x40100100L, "x11 = misa (RV32I + U, no M)")
        assert(u32(dut.io.debugRegs(12).toBigInt) == 0, "x12 = mhartid 0")
        assert(u32(dut.io.debugRegs(13).toBigInt) == 0, "x13 = mip (timer low)")
        assert(u32(dut.io.debugRegs(14).toBigInt) == 0x0F000F1FL, "x14 = old (no write)")
        assert(u32(dut.io.debugRegs(15).toBigInt) == 0x0F000F1FL, "x15 = mscratch unchanged")
        println(s"PASS: zicsr basic in $cyc cycles")
      }
  }

  // =====================================================================
  // Exceptions in M mode: ECALL/EBREAK/illegal instruction/CSR faults,
  // mtvec.MODE!=0, reserved-MPP MRET. Handler bumps mepc and returns.
  // =====================================================================
  private def exceptionProgram: Seq[Long] = {
    val a = new TAsm
    // Main (M mode)
    a.addi(30, 0, 0) // not done
    a.wfi()          // WFI must behave as NOP
    a.li(5, 0)
    a.label("main_mtvec")
    a.addi(5, 0, 0) // placeholder, fixed below
    a.csrrw(0, MTVEC, 5)
    a.ecall()                 // cause 11 -> x21
    a.ebreak()                // cause 3  -> x22
    a.raw(TAsm.ILLEGAL_WORD)  // illegal instruction -> cause2, tval 0
    a.li(5, 1)
    a.csrrw(0, MIP, 5)            // RO write -> cause2, tval 0x344
    a.li(5, 0x100)
    a.csrrw(0, 0x7C0, 5)          // unimplemented CSR -> cause2, tval 0x7C0
    a.li(5, 1)
    a.csrrw(0, MTVEC, 5)          // mtvec.MODE!=0 -> cause2, tval 0x305
    a.li(5, 0x800)
    a.csrrw(0, MSTATUS, 5)        // MPP=1
    a.mret()                      // reserved MPP -> cause2, tval 0
    a.csrrs(16, MISA, 0)          // RO read-only access must NOT trap
    a.csrrc(17, MIP, 0)           // RO read-only access must NOT trap
    a.label("final")
    a.li(30, 0x1234)
    a.j("loop")
    a.label("loop")
    a.j("loop")

    // Handler: mepc += 4, dispatch counters on cause/mtval, then mret.
    a.label("handler")
    a.csrrs(5, MEPC, 0)
    a.addi(5, 5, 4)
    a.csrrw(0, MEPC, 5)
    a.csrrs(6, MCAUSE, 0)
    a.csrrs(7, MTVAL, 0)
    a.li(8, 11)
    a.bne(6, 8, "h3")
    a.addi(21, 21, 1)
    a.j("hdone")
    a.label("h3")
    a.li(8, 3)
    a.bne(6, 8, "hc2")
    a.addi(22, 22, 1)
    a.j("hdone")
    a.label("hc2")
    a.li(8, 0x344)
    a.bne(7, 8, "hc2b")
    a.addi(24, 24, 1)
    a.j("hdone")
    a.label("hc2b")
    a.li(8, 0x7C0)
    a.bne(7, 8, "hc2c")
    a.addi(25, 25, 1)
    a.j("hdone")
    a.label("hc2c")
    a.li(8, 0x305)
    a.bne(7, 8, "hc2d")
    a.addi(26, 26, 1)
    a.j("hdone")
    a.label("hc2d")
    a.addi(23, 23, 1) // tval 0 (illegal instr / reserved-mpp mret)
    a.label("hdone")
    a.addi(20, 20, 1)
    a.mret()

    val prog = a.build
    // Patch mtvec to point at the handler.
    val handlerIdx = a.indexOf("handler")
    val mainMtvecIdx = a.indexOf("main_mtvec")
    // Rebuild with the placeholder replaced by addi x5,x0,handlerAddr.
    val patched = prog.zipWithIndex.map {
      case (_, i) if i == mainMtvecIdx => TAsm.encI(handlerIdx * 4, 0, 0, 5, 0x13)
      case (w, _)                       => w
    }
    patched
  }

  test("M-mode synchronous exceptions") {
    val prog = exceptionProgram
    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(CoreConfig(), prog))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5)
        val cyc = runUntilReg(dut, 1000, 30, 0x1234L)
        if (cyc >= 1000) {
          println(s"TIMEOUT pc=${u32(dut.io.debugPc.toBigInt)} mode=${u32(dut.io.debugMode.toBigInt)}")
          for (r <- Seq(5, 6, 7, 8, 20, 21, 22, 23, 24, 25, 26, 30)) {
            println(s"  x$r = 0x${u32(dut.io.debugRegs(r).toBigInt).toString(16)}")
          }
        }
        assert(cyc < 1000, "exception program did not finish")
        dut.clockDomain.waitSampling(4)

        assert(u32(dut.io.debugRegs(20).toBigInt) == 7, "handler entries")
        assert(u32(dut.io.debugRegs(21).toBigInt) == 1, "ecall(M) count")
        assert(u32(dut.io.debugRegs(22).toBigInt) == 1, "ebreak count")
        assert(u32(dut.io.debugRegs(23).toBigInt) == 2, "cause2 tval0 (illegal instr + reserved-mpp mret)")
        assert(u32(dut.io.debugRegs(24).toBigInt) == 1, "mip RO-write fault count")
        assert(u32(dut.io.debugRegs(25).toBigInt) == 1, "unimplemented CSR fault count")
        assert(u32(dut.io.debugRegs(26).toBigInt) == 1, "mtvec.MODE!=0 fault count")
        assert(u32(dut.io.debugRegs(16).toBigInt) == 0x40100100L, "csrrs misa read (RV32I + U, no M)")
        assert(u32(dut.io.debugRegs(17).toBigInt) == 0, "csrrc mip read (timer low)")
        println(s"PASS: M-mode exceptions in $cyc cycles")
      }
  }

  // =====================================================================
  // Zifencei: fence.i is a legal NOP with the extension enabled and traps as
  // an illegal instruction when it is absent.
  // =====================================================================
  private def fenceIProgram: Seq[Long] = {
    val a = new TAsm
    a.addi(30, 0, 0)
    a.label("main_mtvec")
    a.addi(5, 0, 0)            // patched to the handler address
    a.csrrw(0, MTVEC, 5)
    a.raw(0x0000100FL)         // fence.i
    a.addi(10, 0, 7)           // only reached when fence.i is legal
    a.li(30, 0x1234)
    a.j("loop")
    a.label("loop")
    a.j("loop")

    a.label("handler")
    a.csrrs(11, MCAUSE, 0)     // x11 = cause
    a.csrrs(12, MEPC, 0)       // x12 = trapping pc
    a.addi(13, 13, 1)          // trap count
    a.li(30, 0x1234)
    a.j("loop")

    val prog = a.build
    val handlerIdx = a.indexOf("handler")
    val mainMtvecIdx = a.indexOf("main_mtvec")
    prog.zipWithIndex.map {
      case (_, i) if i == mainMtvecIdx => TAsm.encI(handlerIdx * 4, 0, 0, 5, 0x13)
      case (w, _)                       => w
    }
  }

  private def runFenceI(cfg: CoreConfig)(check: CpuTb => Unit): Unit = {
    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(cfg, fenceIProgram))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5)
        val cyc = runUntilReg(dut, 400, 30, 0x1234L)
        assert(cyc < 400, "fence.i program did not finish")
        dut.clockDomain.waitSampling(4)
        check(dut)
      }
  }

  test("fence.i is a NOP when Zifencei is enabled") {
    runFenceI(CoreConfig.rv32imzifencei) { dut =>
      assert(u32(dut.io.debugRegs(10).toBigInt) == 7, "instruction after fence.i ran")
      assert(u32(dut.io.debugRegs(13).toBigInt) == 0, "no trap taken")
    }
  }

  test("fence.i traps as illegal without Zifencei") {
    runFenceI(CoreConfig()) { dut =>
      assert(u32(dut.io.debugRegs(13).toBigInt) == 1, "one trap taken")
      assert(u32(dut.io.debugRegs(11).toBigInt) == 2, "cause 2 (illegal instruction)")
      assert(u32(dut.io.debugRegs(12).toBigInt) == 0x0C, "mepc points at fence.i")
      assert(u32(dut.io.debugRegs(10).toBigInt) == 0, "instruction after fence.i skipped")
    }
  }

  // =====================================================================
  // Timer interrupt: enable MTIE+MIE, raise the line, check the handler is
  // entered (cause 0x80000007), MRET resumes at the interrupted pc.
  // =====================================================================
  test("timer interrupt + MRET") {
    val a = new TAsm
    a.addi(5, 0, 0x80)
    a.csrrs(0, MIE, 5)          // MTIE = 1
    a.addi(5, 0, 8)
    a.csrrs(0, MSTATUS, 5)      // MIE = 1
    a.label("mtvec_patch")
    a.addi(5, 0, 0)             // placeholder for mtvec (patched below)
    a.csrrw(0, MTVEC, 5)
    a.label("loop_start")
    a.addi(6, 6, 1)             // loop body: increments
    a.addi(7, 7, 2)
    a.addi(8, 8, 3)
    a.csrrs(12, MSTATUS, 0)     // keep mstatus visible in a reg
    a.label("loop_end")
    a.j("loop_start")

    // handler
    a.label("handler")
    a.csrrs(2, MEPC, 0)         // interrupted pc
    a.csrrs(3, MCAUSE, 0)
    a.csrrs(4, MTVAL, 0)
    a.addi(5, 0, 0x80)
    a.csrrc(0, MIE, 5)          // MTIE = 0 (no re-entry; line stays high)
    a.mret()

    val prog = a.build
    val mtvecIdx = a.indexOf("mtvec_patch")
    val patched = prog.zipWithIndex.map {
      case (_, i) if i == mtvecIdx => TAsm.encI(a.indexOf("handler") * 4, 0, 0, 5, 0x13)
      case (w, _)                    => w
    }
    val loopStartPc = a.indexOf("loop_start") * 4L
    val loopEndPc = a.indexOf("loop_end") * 4L

    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(CoreConfig(), patched))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5)
        dut.io.timerInterrupt #= false
        // let setup + some loop iterations run, then assert the timer line
        dut.clockDomain.waitSampling(40)
        var i = 0
        while (i < 200 && u32(dut.io.debugRegs(3).toBigInt) != 0x80000007L) {
          dut.io.timerInterrupt #= true
          dut.clockDomain.waitSampling()
          i += 1
        }
        if (u32(dut.io.debugRegs(3).toBigInt) != 0x80000007L) {
          println(s"INTR-TIMEOUT pc=${u32(dut.io.debugPc.toBigInt)} mode=${u32(dut.io.debugMode.toBigInt)}")
          println(s"  mstatus x12=0x${u32(dut.io.debugRegs(12).toBigInt).toString(16)}")
          println(s"  x2=0x${u32(dut.io.debugRegs(2).toBigInt).toString(16)} x3=0x${u32(dut.io.debugRegs(3).toBigInt).toString(16)} x4=0x${u32(dut.io.debugRegs(4).toBigInt).toString(16)} x6=0x${u32(dut.io.debugRegs(6).toBigInt).toString(16)}")
        }
        assert(u32(dut.io.debugRegs(3).toBigInt) == 0x80000007L, "handler not entered")
        val savedMepc = u32(dut.io.debugRegs(2).toBigInt)
        assert(savedMepc >= loopStartPc && savedMepc <= loopEndPc && (savedMepc - loopStartPc) % 4 == 0,
          s"mepc $savedMepc not in loop [$loopStartPc,$loopEndPc]")
        assert(u32(dut.io.debugRegs(4).toBigInt) == 0, "mtval should be 0 for timer interrupt")
        // keep line high: MRET must resume the loop (interrupted instr re-executes)
        dut.clockDomain.waitSampling(30)
        val resume1 = u32(dut.io.debugRegs(6).toBigInt)
        dut.clockDomain.waitSampling(20)
        val resume2 = u32(dut.io.debugRegs(6).toBigInt)
        assert(resume2 > resume1, "loop did not resume after MRET")
        assert(u32(dut.io.debugRegs(12).toBigInt) == 0x1888L,
          "mstatus after trap+MRET should be MIE|MPIE|MPP=M (0x1888)")
        assert(u32(dut.io.debugMode.toBigInt) == 3, "should stay in M mode")
        println(s"PASS: timer interrupt, mepc=0x$savedMepc, resumed")
      }
  }

  // =====================================================================
  // U mode: M -> U via MPP=0 + MRET, then U CSR access (illegal), U MRET
  // (illegal), U ECALL (cause 8); the last U ECALL returns to M.
  // =====================================================================
  test("U-mode round trip") {
    val a = new TAsm
    // M setup
    a.label("mepc_patch")
    a.addi(5, 0, 0)     // placeholder: mepc = u_start (patched below)
    a.csrrw(0, MEPC, 5)
    a.csrrwi(0, MSTATUS, 0) // MPP=0, MIE=0
    a.label("mtvec_patch2")
    a.addi(5, 0, 0)     // placeholder: mtvec = u_handler (patched below)
    a.csrrw(0, MTVEC, 5)
    a.mret() // -> U at u_start

    a.label("u_start")
    a.addi(10, 0, 0x55)
    a.csrrs(11, MSTATUS, 0) // U-mode M-CSR access -> illegal (x11 not written)
    a.addi(12, 0, 0xAA)
    a.mret()                // U-mode MRET -> illegal
    a.addi(13, 0, 0xBB)
    a.ecall()               // U ECALL -> cause 8
    a.addi(14, 0, 0xCC)
    a.addi(15, 0, 1)        // final marker
    a.ecall()               // final U ECALL -> return to M

    a.label("m_done")
    a.addi(30, 0, 3)
    a.j("loop")
    a.label("loop")
    a.j("loop")

    // U handler (runs in M)
    a.label("uhandler")
    a.csrrs(5, MEPC, 0)
    a.csrrs(6, MCAUSE, 0)
    a.li(8, 8)
    a.bne(6, 8, "uc2")
    // ecall from U
    a.li(8, 1)
    a.bne(15, 8, "uec_ret") // final?
    a.label("done_patch")
    a.addi(5, 0, 0) // placeholder: mepc = m_done (patched below)
    a.csrrw(0, MEPC, 5)
    a.li(8, 0x1800)
    a.csrrw(0, MSTATUS, 8) // MPP=M
    a.mret()
    a.label("uec_ret")
    a.addi(5, 5, 4)
    a.csrrw(0, MEPC, 5)
    a.addi(20, 20, 1)
    a.mret() // back to U (MPP was set to U by the trap)
    a.label("uc2")
    // cause 2 from U (CSR access / U mret)
    a.addi(5, 5, 4)
    a.csrrw(0, MEPC, 5)
    a.addi(21, 21, 1)
    a.mret()

    val prog = a.build
    val mepcIdx = a.indexOf("mepc_patch")
    val mtvecIdx = a.indexOf("mtvec_patch2")
    val doneIdx = a.indexOf("done_patch")
    val patched = prog.zipWithIndex.map {
      case (_, i) if i == mepcIdx  => TAsm.encI(a.indexOf("u_start") * 4, 0, 0, 5, 0x13)
      case (_, i) if i == mtvecIdx => TAsm.encI(a.indexOf("uhandler") * 4, 0, 0, 5, 0x13)
      case (_, i) if i == doneIdx  => TAsm.encI(a.indexOf("m_done") * 4, 0, 0, 5, 0x13)
      case (w, _)                   => w
    }

    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(CoreConfig(), patched))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5)

        // Observe the transition into U before the first trap fires.
        var sawU = false
        var cycles = 0
        while (cycles < 120 && !sawU) {
          dut.clockDomain.waitSampling()
          cycles += 1
          sawU = u32(dut.io.debugMode.toBigInt) == 0 && u32(dut.io.debugRegs(10).toBigInt) == 0x55L
        }
        assert(sawU, "never observed U mode with the U marker")

        val cyc = runUntilReg(dut, 2000, 30, 3)
        assert(cyc < 2000, "U-mode program did not finish")
        dut.clockDomain.waitSampling(4)

        assert(u32(dut.io.debugRegs(10).toBigInt) == 0x55L, "x10 U marker")
        assert(u32(dut.io.debugRegs(11).toBigInt) == 0, "x11 not written (CSR access trapped)")
        assert(u32(dut.io.debugRegs(12).toBigInt) == 0xAAL, "x12 after U CSR fault")
        assert(u32(dut.io.debugRegs(13).toBigInt) == 0xBBL, "x13 after U MRET fault")
        assert(u32(dut.io.debugRegs(14).toBigInt) == 0xCCL, "x14 after U ECALL")
        assert(u32(dut.io.debugRegs(15).toBigInt) == 1, "x15 final marker")
        assert(u32(dut.io.debugRegs(20).toBigInt) == 1, "non-final U ECALL count")
        assert(u32(dut.io.debugRegs(21).toBigInt) == 2, "U illegal (CSR access + MRET) count")
        assert(u32(dut.io.debugMode.toBigInt) == 3, "back in M mode at end")
        println(s"PASS: U-mode round trip in $cyc cycles")
      }
  }

  // =====================================================================
  // S-mode: a delegated ECALL from S enters the S handler (stvec/scause/
  // sepc), SPP records the source mode, and SRET returns into S.
  // =====================================================================
  test("S-mode ECALL delegates to the S handler and SRET returns") {
    val a = new TAsm
    // Machine setup: delegate ECALL-from-S (cause 9), point stvec at the S
    // handler, enter S via MRET with MPP=S.
    a.li(5, 1 << 9)
    a.csrrw(0, MEDELEG, 5)
    a.label("stvec_patch")
    a.addi(5, 0, 0)
    a.csrrw(0, STVEC, 5)
    a.label("mepc_patch")
    a.addi(5, 0, 0)
    a.csrrw(0, MEPC, 5)
    a.li(5, 0x800)              // MPP=S, MIE=0
    a.csrrw(0, MSTATUS, 5)
    a.mret()                    // -> S at s_start

    a.label("s_start")
    a.addi(10, 0, 0x55)
    a.ecall()                   // delegated to S
    a.addi(14, 0, 0x99)         // must be skipped by the handler
    a.label("s_resume")
    a.addi(14, 0, 0x66)
    a.li(30, 0x1234)
    a.j("loop")

    a.label("s_handler")
    a.csrrs(11, SCAUSE, 0)
    a.csrrs(12, SEPC, 0)
    a.addi(13, 13, 1)
    a.csrrs(15, SSTATUS, 0)
    a.andi(15, 15, 0x100)       // SPP bit should be set (trap came from S)
    a.label("sepc_patch")
    a.addi(5, 0, 0)
    a.csrrw(0, SEPC, 5)
    a.sret()

    a.label("loop")
    a.j("loop")

    val prog = a.build
    val stvecIdx = a.indexOf("stvec_patch")
    val mepcIdx = a.indexOf("mepc_patch")
    val sepcIdx = a.indexOf("sepc_patch")
    val ecallPc = a.indexOf("s_start") * 4 + 4
    val patched = prog.zipWithIndex.map {
      case (_, i) if i == stvecIdx => TAsm.encI(a.indexOf("s_handler") * 4, 0, 0, 5, 0x13)
      case (_, i) if i == mepcIdx  => TAsm.encI(a.indexOf("s_start") * 4, 0, 0, 5, 0x13)
      case (_, i) if i == sepcIdx  => TAsm.encI(a.indexOf("s_resume") * 4, 0, 0, 5, 0x13)
      case (w, _)                   => w
    }

    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(CoreConfig.rv32imsu, patched))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5)
        val cyc = runUntilReg(dut, 800, 30, 0x1234L)
        assert(cyc < 800, "S-mode program did not finish")
        dut.clockDomain.waitSampling(4)
        assert(u32(dut.io.debugRegs(13).toBigInt) == 1, "handler entered once")
        assert(u32(dut.io.debugRegs(11).toBigInt) == 9, "scause = ecall from S")
        assert(u32(dut.io.debugRegs(12).toBigInt) == ecallPc, "sepc = ECALL pc")
        assert(u32(dut.io.debugRegs(15).toBigInt) == 0x100, "sstatus.SPP = S")
        assert(u32(dut.io.debugRegs(10).toBigInt) == 0x55, "x10 S marker")
        assert(u32(dut.io.debugRegs(14).toBigInt) == 0x66, "resumed after the trap")
        println(s"PASS: S-mode ECALL delegation/SRET in $cyc cycles")
      }
  }

  // =====================================================================
  // Without medeleg the S ECALL is handled in M, and the S handler is idle.
  // =====================================================================
  test("undelegated S-mode ECALL is taken in M") {
    val a = new TAsm
    a.csrrwi(0, MEDELEG, 0)     // no delegation
    a.label("stvec_patch")
    a.addi(5, 0, 0)
    a.csrrw(0, STVEC, 5)
    a.label("mtvec_patch")
    a.addi(5, 0, 0)
    a.csrrw(0, MTVEC, 5)
    a.label("mepc_patch")
    a.addi(5, 0, 0)
    a.csrrw(0, MEPC, 5)
    a.li(5, 0x800)              // MPP=S
    a.csrrw(0, MSTATUS, 5)
    a.mret()

    a.label("s_start")
    a.addi(10, 0, 0x55)
    a.ecall()
    a.addi(14, 0, 0x99)

    a.label("s_handler")
    a.addi(13, 13, 1)           // must stay 0
    a.j("loop")

    a.label("m_handler")
    a.csrrs(11, MCAUSE, 0)
    a.csrrs(12, MEPC, 0)
    a.label("done_patch")
    a.addi(5, 0, 0)
    a.csrrw(0, MEPC, 5)
    a.li(5, 0x1800)             // MPP=M
    a.csrrw(0, MSTATUS, 5)
    a.mret()

    a.label("m_done")
    a.li(30, 0x1234)
    a.j("loop")
    a.label("loop")
    a.j("loop")

    val prog = a.build
    val stvecIdx = a.indexOf("stvec_patch")
    val mtvecIdx = a.indexOf("mtvec_patch")
    val mepcIdx = a.indexOf("mepc_patch")
    val doneIdx = a.indexOf("done_patch")
    val ecallPc = a.indexOf("s_start") * 4 + 4
    val patched = prog.zipWithIndex.map {
      case (_, i) if i == stvecIdx => TAsm.encI(a.indexOf("s_handler") * 4, 0, 0, 5, 0x13)
      case (_, i) if i == mtvecIdx => TAsm.encI(a.indexOf("m_handler") * 4, 0, 0, 5, 0x13)
      case (_, i) if i == mepcIdx  => TAsm.encI(a.indexOf("s_start") * 4, 0, 0, 5, 0x13)
      case (_, i) if i == doneIdx  => TAsm.encI(a.indexOf("m_done") * 4, 0, 0, 5, 0x13)
      case (w, _)                   => w
    }

    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(CoreConfig.rv32imsu, patched))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5)
        val cyc = runUntilReg(dut, 800, 30, 0x1234L)
        assert(cyc < 800, "program did not finish")
        dut.clockDomain.waitSampling(4)
        assert(u32(dut.io.debugRegs(11).toBigInt) == 9, "mcause = ecall from S")
        assert(u32(dut.io.debugRegs(12).toBigInt) == ecallPc, "mepc = ECALL pc")
        assert(u32(dut.io.debugRegs(13).toBigInt) == 0, "S handler not entered")
        assert(u32(dut.io.debugMode.toBigInt) == 3, "back in M")
      }
  }

  // =====================================================================
  // SRET is M-mode illegal; it traps with cause 2 and mepc at the SRET.
  // =====================================================================
  test("SRET in M mode traps as illegal") {
    val a = new TAsm
    a.label("mtvec_patch")
    a.addi(5, 0, 0)
    a.csrrw(0, MTVEC, 5)
    a.label("sret_addr")
    a.sret()
    a.li(30, 0xBAD)
    a.label("m_handler")
    a.csrrs(11, MCAUSE, 0)
    a.csrrs(12, MEPC, 0)
    a.label("done_patch")
    a.addi(5, 0, 0)
    a.csrrw(0, MEPC, 5)
    a.mret()
    a.label("m_done")
    a.li(30, 0x1234)
    a.j("loop")
    a.label("loop")
    a.j("loop")

    val prog = a.build
    val mtvecIdx = a.indexOf("mtvec_patch")
    val doneIdx = a.indexOf("done_patch")
    val sretPc = a.indexOf("sret_addr") * 4
    val patched = prog.zipWithIndex.map {
      case (_, i) if i == mtvecIdx => TAsm.encI(a.indexOf("m_handler") * 4, 0, 0, 5, 0x13)
      case (_, i) if i == doneIdx  => TAsm.encI(a.indexOf("m_done") * 4, 0, 0, 5, 0x13)
      case (w, _)                   => w
    }

    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(CoreConfig.rv32imsu, patched))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5)
        val cyc = runUntilReg(dut, 400, 30, 0x1234L)
        assert(cyc < 400, "program did not finish")
        dut.clockDomain.waitSampling(4)
        assert(u32(dut.io.debugRegs(11).toBigInt) == 2, "cause 2 (illegal)")
        assert(u32(dut.io.debugRegs(12).toBigInt) == sretPc, "mepc points at SRET")
      }
  }

  // =====================================================================
  // Zicntr: cycle/time/instret advance, RV32 high halves read zero, and
  // instret deltas equal the number of retired instructions between reads.
  // =====================================================================
  test("Zicntr counters count cycles and retired instructions") {
    val a = new TAsm
    a.csrrs(5, CYCLE, 0)
    a.csrrs(6, TIME, 0)
    (1 to 50).foreach(i => a.addi(1, 1, 1))
    a.csrrs(7, CYCLE, 0)
    a.csrrs(8, CYCLEH, 0)
    a.csrrs(9, INSTRET, 0)
    a.addi(2, 0, 1)
    a.addi(3, 0, 1)
    a.csrrs(10, INSTRET, 0)
    a.csrrs(16, INSTRETH, 0)
    a.csrrwi(0, MCYCLE, 0)      // mcycle write alias resets the cycle counter
    a.csrrs(12, MCYCLE, 0)
    a.li(30, 0x1234)
    a.j("loop")
    a.label("loop")
    a.j("loop")

    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(CoreConfig.rv32imzicntr, a.build))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5)
        val cyc = runUntilReg(dut, 500, 30, 0x1234L)
        assert(cyc < 500, "Zicntr program did not finish")
        dut.clockDomain.waitSampling(4)
        val c1 = u32(dut.io.debugRegs(5).toBigInt)
        val t1 = u32(dut.io.debugRegs(6).toBigInt)
        val c2 = u32(dut.io.debugRegs(7).toBigInt)
        assert(c2 > c1, s"cycle did not advance ($c1 -> $c2)")
        assert(c2 - c1 >= 50, s"cycle delta $c2-$c1 smaller than 50 instructions")
        assert(t1 >= c1 || t1 + 1 >= c1, "time should track cycle")
        assert(u32(dut.io.debugRegs(8).toBigInt) == 0, "RV32 cycleh starts at 0")
        assert(u32(dut.io.debugRegs(16).toBigInt) == 0, "RV32 instreth starts at 0")
        val i1 = u32(dut.io.debugRegs(9).toBigInt)
        val i2 = u32(dut.io.debugRegs(10).toBigInt)
        assert(i2 - i1 == 3, s"instret delta ${i2 - i1} != 3")
        val mcy = u32(dut.io.debugRegs(12).toBigInt)
        assert(mcy < 32 && mcy < c1, s"mcycle write did not reset the counter ($mcy)")
        println(s"PASS: Zicntr in $cyc cycles (cycle delta ${c2 - c1})")
      }
  }

  // =====================================================================
  // Zicntr: U-mode counter reads are gated by mcounteren; the trap handler
  // opens the gate and the retried read succeeds.
  // =====================================================================
  test("Zicntr counter access from U is gated by mcounteren") {
    val a = new TAsm
    a.csrrwi(0, MCOUNTEREN, 0)
    a.label("mtvec_patch")
    a.addi(5, 0, 0)
    a.csrrw(0, MTVEC, 5)
    a.label("mepc_patch")
    a.addi(5, 0, 0)
    a.csrrw(0, MEPC, 5)
    a.csrrwi(0, MSTATUS, 0)     // MPP=U
    a.mret()

    a.label("u_start")
    a.csrrs(10, CYCLE, 0)       // denied: mcounteren.CY = 0
    a.addi(14, 0, 0xAA)
    a.csrrs(11, CYCLE, 0)       // allowed after the handler opens the gate
    a.li(30, 0x1234)
    a.j("loop")

    a.label("m_handler")
    a.addi(13, 13, 1)
    a.csrrs(6, MEPC, 0)
    a.addi(6, 6, 4)
    a.csrrw(0, MEPC, 6)
    a.csrrwi(0, MCOUNTEREN, 7)
    a.mret()

    a.label("loop")
    a.j("loop")

    val prog = a.build
    val mtvecIdx = a.indexOf("mtvec_patch")
    val mepcIdx = a.indexOf("mepc_patch")
    val patched = prog.zipWithIndex.map {
      case (_, i) if i == mtvecIdx => TAsm.encI(a.indexOf("m_handler") * 4, 0, 0, 5, 0x13)
      case (_, i) if i == mepcIdx  => TAsm.encI(a.indexOf("u_start") * 4, 0, 0, 5, 0x13)
      case (w, _)                   => w
    }

    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(CoreConfig.rv32imzicntr, patched))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5)
        val cyc = runUntilReg(dut, 500, 30, 0x1234L)
        assert(cyc < 500, "gated counter program did not finish")
        dut.clockDomain.waitSampling(4)
        assert(u32(dut.io.debugRegs(10).toBigInt) == 0, "denied read must not write rd")
        assert(u32(dut.io.debugRegs(13).toBigInt) == 1, "exactly one trap")
        assert(u32(dut.io.debugRegs(14).toBigInt) == 0xAA, "U resumed after the trap")
        assert(u32(dut.io.debugRegs(11).toBigInt) != 0, "permitted read returns cycle")
        assert(u32(dut.io.debugMode.toBigInt) == 0, "still in U at the end")
      }
  }
}
