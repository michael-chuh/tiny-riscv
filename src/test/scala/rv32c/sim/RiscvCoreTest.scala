package rv32c.sim

import org.scalatest.funsuite.AnyFunSuite
import spinal.core._
import spinal.core.sim._
import rv32c._
import rv32c.isa._

class RiscvCoreTest extends AnyFunSuite {
  // Minimal instruction encoders used by the RV64M program (avoids hand-computing
  // field layouts for the W-suffix opcode, which shares funct7 with RV32M).
  private def encR(f7: Int, rs2: Int, rs1: Int, f3: Int, rd: Int, opc: Int = 0x3b): Long =
    ((f7 & 0x7f).toLong << 25) | ((rs2 & 0x1f).toLong << 20) | ((rs1 & 0x1f).toLong << 15) |
      ((f3 & 0x7).toLong << 12) | ((rd & 0x1f).toLong << 7) | (opc & 0x7f).toLong
  private def encI(imm: Int, rs1: Int, f3: Int, rd: Int, opc: Int = 0x13): Long =
    ((imm & 0xfff).toLong << 20) | ((rs1 & 0x1f).toLong << 15) |
      ((f3 & 0x7).toLong << 12) | ((rd & 0x1f).toLong << 7) | (opc & 0x7f).toLong
  private def encU(imm: Int, rd: Int, opc: Int = 0x37): Long =
    ((imm & 0xfffff).toLong << 12) | ((rd & 0x1f).toLong << 7) | (opc & 0x7f).toLong
  private def encS(imm: Int, rs2: Int, rs1: Int, f3: Int, opc: Int = 0x23): Long =
    (((imm >> 5) & 0x7f).toLong << 25) | ((rs2 & 0x1f).toLong << 20) | ((rs1 & 0x1f).toLong << 15) |
      ((f3 & 0x7).toLong << 12) | ((imm & 0x1f).toLong << 7) | (opc & 0x7f).toLong
  // A-extension R-type: funct5[31:27], aq[26], rl[25], opcode 0x2f.
  private def encAmo(funct5: Int, rs2: Int, rs1: Int, f3: Int, rd: Int, aq: Int = 0, rl: Int = 0): Long =
    ((funct5 & 0x1f).toLong << 27) | ((aq & 1).toLong << 26) | ((rl & 1).toLong << 25) |
      ((rs2 & 0x1f).toLong << 20) | ((rs1 & 0x1f).toLong << 15) |
      ((f3 & 0x7).toLong << 12) | ((rd & 0x1f).toLong << 7) | 0x2fL

  // ---- RV32C (16-bit) encoders ----
  // Each helper takes logical operands and places them in the RVC bit fields as
  // extracted by Decoder.scala. Register-prime operands are the 3-bit index
  // (0 => x8). C.LI/C.ADDI/C.LUI immediates are 6-bit signed, so values must be
  // in -32..31.
  private def cCI(op: Int, f3: Int, rd: Int, imm6: Int): Int =
    (op & 3) | ((f3 & 7) << 13) | (((imm6 >> 5) & 1) << 12) | ((rd & 0x1f) << 7) | ((imm6 & 0x1f) << 2)

  private def cADDI16SP(imm: Int): Int = {
    val i = imm & 0x3ff
    (1) | (3 << 13) | (2 << 7) |
      (((i >> 9) & 1) << 12) | (((i >> 8) & 1) << 4) | (((i >> 7) & 1) << 3) |
      (((i >> 6) & 1) << 5) | (((i >> 5) & 1) << 2) | (((i >> 4) & 1) << 6)
  }

  private def cJ(op: Int, f3: Int, imm: Int): Int = {
    val i = imm & 0xfff
    (op & 3) | ((f3 & 7) << 13) |
      (((i >> 11) & 1) << 12) | (((i >> 10) & 1) << 8) | (((i >> 9) & 1) << 10) |
      (((i >> 8) & 1) << 9) | (((i >> 7) & 1) << 6) | (((i >> 6) & 1) << 7) |
      (((i >> 5) & 1) << 2) | (((i >> 4) & 1) << 11) | (((i >> 3) & 1) << 5) |
      (((i >> 2) & 1) << 4) | (((i >> 1) & 1) << 3)
  }

  private def cB(f3: Int, rs1p: Int, imm: Int): Int = {
    val i = imm & 0x1ff
    (1) | ((f3 & 7) << 13) | ((rs1p & 7) << 7) |
      (((i >> 8) & 1) << 12) | (((i >> 7) & 1) << 6) | (((i >> 6) & 1) << 5) |
      (((i >> 5) & 1) << 2) | (((i >> 4) & 1) << 11) | (((i >> 3) & 1) << 10) |
      (((i >> 2) & 1) << 4) | (((i >> 1) & 1) << 3)
  }

  private def cLwImmBits(imm: Int): Int = {
    val i = imm & 0x7f
    (((i >> 6) & 1) << 5) | (((i >> 5) & 1) << 12) | (((i >> 4) & 1) << 11) |
      (((i >> 3) & 1) << 10) | (((i >> 2) & 1) << 6)
  }

  private def cADDI4SPN(rdp: Int, imm: Int): Int = {
    val i = imm & 0x3ff
    ((rdp & 7) << 2) |
      (((i >> 9) & 1) << 10) | (((i >> 8) & 1) << 9) | (((i >> 7) & 1) << 8) | (((i >> 6) & 1) << 7) |
      (((i >> 5) & 1) << 12) | (((i >> 4) & 1) << 11) | (((i >> 3) & 1) << 5) | (((i >> 2) & 1) << 6)
  }

  private def cLW(rdp: Int, rs1p: Int, imm: Int): Int =
    (2 << 13) | ((rs1p & 7) << 7) | ((rdp & 7) << 2) | cLwImmBits(imm)

  private def cSW(rs2p: Int, rs1p: Int, imm: Int): Int =
    (6 << 13) | ((rs1p & 7) << 7) | ((rs2p & 7) << 2) | cLwImmBits(imm)

  private def cShift(sel: Int, rdp: Int, shamt: Int): Int =
    (1) | (4 << 13) | ((sel & 3) << 10) | ((rdp & 7) << 7) |
      (((shamt >> 5) & 1) << 12) | ((shamt & 0x1f) << 2)

  private def cSLLI(rd: Int, shamt: Int): Int =
    (2) | (0 << 13) | ((rd & 0x1f) << 7) |
      (((shamt >> 5) & 1) << 12) | ((shamt & 0x1f) << 2)

  private def cANDI(rdp: Int, imm6: Int): Int =
    (1) | (4 << 13) | (2 << 10) | ((rdp & 7) << 7) |
      (((imm6 >> 5) & 1) << 12) | ((imm6 & 0x1f) << 2)

  private def cALU(rdp: Int, rs2p: Int, op2: Int): Int =
    (1) | (4 << 13) | (3 << 10) | ((rdp & 7) << 7) | ((op2 & 3) << 5) | ((rs2p & 7) << 2)

  private def cLWSP(rd: Int, imm: Int): Int = {
    val i = imm & 0xff
    (2) | (2 << 13) | ((rd & 0x1f) << 7) |
      (((i >> 7) & 1) << 3) | (((i >> 6) & 1) << 2) |
      (((i >> 5) & 1) << 12) | (((i >> 4) & 1) << 6) | (((i >> 3) & 1) << 5) | (((i >> 2) & 1) << 4)
  }

  private def cSWSP(rs2: Int, imm: Int): Int = {
    val i = imm & 0xff
    (2) | (6 << 13) | ((rs2 & 0x1f) << 2) |
      (((i >> 7) & 1) << 8) | (((i >> 6) & 1) << 7) |
      (((i >> 5) & 1) << 12) | (((i >> 4) & 1) << 11) | (((i >> 3) & 1) << 10) | (((i >> 2) & 1) << 9)
  }

  private def cMV(rd: Int, rs2: Int): Int =
    (2) | (4 << 13) | ((rd & 0x1f) << 7) | ((rs2 & 0x1f) << 2)

  private def cADD(rd: Int, rs2: Int): Int =
    (2) | (4 << 13) | (1 << 12) | ((rd & 0x1f) << 7) | ((rs2 & 0x1f) << 2)

  private def cJR(rs1: Int): Int = (2) | (4 << 13) | ((rs1 & 0x1f) << 7)

  private def cJALR(rs1: Int): Int = (2) | (4 << 13) | (1 << 12) | ((rs1 & 0x1f) << 7)

  // ---- RV64C (16-bit) encoders ----
  private def cLD(rdp: Int, rs1p: Int, off: Int): Int =
    (3 << 13) | ((rs1p & 7) << 7) | ((rdp & 7) << 2) |
      (((off >> 5) & 1) << 12) | (((off >> 4) & 1) << 11) | (((off >> 3) & 1) << 10) |
      (((off >> 7) & 1) << 6) | (((off >> 6) & 1) << 5)

  private def cSD(rs2p: Int, rs1p: Int, off: Int): Int =
    (7 << 13) | ((rs1p & 7) << 7) | ((rs2p & 7) << 2) |
      (((off >> 5) & 1) << 12) | (((off >> 4) & 1) << 11) | (((off >> 3) & 1) << 10) |
      (((off >> 7) & 1) << 6) | (((off >> 6) & 1) << 5)

  private def cLDSP(rd: Int, off: Int): Int =
    (2) | (3 << 13) | ((rd & 0x1f) << 7) |
      (((off >> 5) & 1) << 12) | (((off >> 4) & 1) << 6) | (((off >> 3) & 1) << 5) |
      (((off >> 8) & 1) << 4) | (((off >> 7) & 1) << 3) | (((off >> 6) & 1) << 2)

  private def cSDSP(rs2: Int, off: Int): Int =
    (2) | (7 << 13) | ((rs2 & 0x1f) << 2) |
      (((off >> 5) & 1) << 12) | (((off >> 4) & 1) << 11) | (((off >> 3) & 1) << 10) |
      (((off >> 8) & 1) << 9) | (((off >> 7) & 1) << 8) | (((off >> 6) & 1) << 7)

  private def cADDIW(rd: Int, imm6: Int): Int = cCI(1, 1, rd, imm6)

  private def cALUW(rdp: Int, rs2p: Int, op2: Int): Int = cALU(rdp, rs2p, op2) | (1 << 12)

  private def cNop: Int = cCI(1, 0, 0, 0)

  private def packHalfwords(hws: Seq[Int]): Seq[Long] = {
    val padded = if (hws.length % 2 == 0) hws else hws :+ cNop
    padded.grouped(2).map { case Seq(lo, hi) =>
      (lo & 0xffff).toLong | ((hi & 0xffff).toLong << 16)
    }.toSeq
  }

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

  // RV64M program: MULW/DIVW/DIVUW/REMW/REMUW on 32-bit-sign-extended operands.
  // Covers truncation, signed overflow, unsigned results whose bit 31 is set (to
  // pin the spec's sign-extension of W results), div/rem by zero, and forwarding
  // of a divider result into a following add. Opcode 0x3b, funct7 0x01.
  val rv64mProgram = Seq[Long](
    encU(0x80000, 1),        // lui   x1,0x80000      x1 = 0xffffffff80000000 (-2^31)
    encI(-1, 0, 0, 2),       // addi  x2,x0,-1        x2 = -1 (low32 0xffffffff)
    encI(2, 0, 0, 3),        // addi  x3,x0,2
    encI(3, 0, 0, 4),        // addi  x4,x0,3
    encI(1, 0, 0, 7),        // addi  x7,x0,1
    encI(-7, 0, 0, 5),       // addi  x5,x0,-7
    encI(6, 0, 0, 6),        // addi  x6,x0,6
    encR(1, 3, 1, 0, 8),     // mulw  x8,x1,x3        (-2^31*2) low32 = 0
    encR(1, 2, 2, 0, 9),     // mulw  x9,x2,x2        (-1*-1) = 1
    encR(1, 2, 1, 0, 10),    // mulw  x10,x1,x2       (-2^31*-1) = 0x80000000 -> sign-ext
    encR(1, 3, 1, 4, 11),    // divw  x11,x1,x3       -2^31/2 = -2^30
    encR(1, 2, 1, 4, 12),    // divw  x12,x1,x2       -2^31/-1 overflow = -2^31
    encR(1, 2, 1, 6, 13),    // remw  x13,x1,x2       overflow remainder = 0
    encR(1, 6, 5, 4, 14),    // divw  x14,x5,x6       -7/6 = -1
    encR(1, 6, 5, 6, 15),    // remw  x15,x5,x6       -7%6 = -1
    encR(1, 3, 2, 5, 16),    // divuw x16,x2,x3       0xffffffff/2 = 0x7fffffff
    encR(1, 3, 2, 7, 17),    // remuw x17,x2,x3       0xffffffff%2 = 1
    encR(1, 4, 2, 5, 18),    // divuw x18,x2,x4       0xffffffff/3 = 0x55555555
    encR(1, 7, 2, 5, 19),    // divuw x19,x2,x7       0xffffffff/1 -> sign-ext all ones
    encR(1, 4, 2, 7, 20),    // remuw x20,x2,x4       0xffffffff%3 = 0
    encR(1, 3, 2, 4, 21),    // divw  x21,x2,x3       -1/2 = 0
    encR(1, 3, 2, 6, 22),    // remw  x22,x2,x3       -1%2 = -1
    encR(1, 0, 2, 4, 23),    // divw  x23,x2,x0       div-by-zero -> -1
    encR(1, 0, 2, 6, 24),    // remw  x24,x2,x0       rem-by-zero -> dividend (-1)
    encR(1, 0, 5, 5, 25),    // divuw x25,x5,x0       div-by-zero -> 0xffffffff
    encR(1, 0, 5, 7, 26),    // remuw x26,x5,x0       rem-by-zero -> low32(-7) sign-ext
    encR(1, 5, 1, 4, 27),    // divw  x27,x1,x5       -2^31/-7 = 306783378
    encR(0, 3, 8, 0, 28, 0x33), // add x28,x8,x3      0+2 = 2
    encR(0, 7, 27, 0, 29, 0x33), // add x29,x27,x7    forward divider result
    0x0000006FL              // jal   x0,0            self-loop at 0x74
  )

  // RV32C program: mixes 16-bit compressed instructions with a 32-bit
  // instruction that starts at an odd halfword (pc[1]=1), exercising the
  // misaligned-32 splice path, quadrant 0 (C.ADDI4SPN/C.SW/C.LW), quadrant 1
  // (C.LI) and quadrant 2 (C.SWSP/C.LWSP/C.ADD) instructions.
  // Layout (addresses are byte offsets; each word holds two halfwords):
  //   addr0: C.LI  x1,3            addr2: addi x1,x1,4  (32-bit, spans words)
  //   addr6: C.SWSP x1,4(x2)       addr8: C.LWSP x3,4(x2)
  //   addr10: C.LI x4,20           addr12: C.ADD x1,x4
  //   addr14: C.NOP                addr16: C.LI x9,7
  //   addr18: C.ADDI4SPN x8,4      addr20: C.SW x9,0(x8)
  //   addr22: C.LW x10,0(x8)       addr24: jal x0,0 (self-loop)
  val rv32cProgram = Seq[Long](
    0x8093408DL, // C.LI x1,3            | addi x1,x1,4 low half
    0xC2060040L, // addi x1,x1,4 hi half | C.SWSP x1,4(x2)
    0x42514192L, // C.LWSP x3,4(x2)      | C.LI x4,20
    0x00019092L, // C.ADD x1,x4          | C.NOP
    0x0040449DL, // C.LI x9,7            | C.ADDI4SPN x8,4
    0x4008C004L, // C.SW x9,0(x8)        | C.LW x10,0(x8)
    0x0000006FL  // jal x0,0             (self-loop at 0x18)
  )

  // A reserved RV64C shift encoding (C.SRLI with shamt[5]=1, 0x9001) is
  // illegal on RV32 and must raise cause 2 without side effects.
  val rv32cIllegalProgram = Seq[Long](0x00009001L)

  // RV32C arithmetic/immediate/register coverage: C.ADDI, C.LUI, C.ADDI16SP,
  // C.ANDI, C.SRLI, C.SRAI, C.SLLI, C.MV, C.ADD, C.SUB, C.XOR, C.OR, C.AND,
  // plus a C.SW/C.LW pair at immediate 64 to pin the CRS2' and uimm[6] fields.
  // All 16-bit; self-loop (jal x0,0) at 0x40.
  val rv32cArithProgram = packHalfwords(Seq(
    cCI(1, 2, 1, 5),      // C.LI x1,5            x1=5
    cCI(1, 0, 1, 3),      // C.ADDI x1,3          x1=8
    cCI(1, 3, 16, 1),     // C.LUI x16,1          x16=0x1000
    cCI(1, 2, 2, 20),     // C.LI x2,20           x2=20
    cADDI16SP(16),        // C.ADDI16SP 16        x2=36
    cCI(1, 2, 8, 31),     // C.LI x8,31           x8=31
    cANDI(0, 13),         // C.ANDI x8,13         x8=13
    cCI(1, 2, 9, 30),     // C.LI x9,30           x9=30
    cShift(0, 1, 2),      // C.SRLI x9,2          x9=7
    cCI(1, 2, 10, -8),    // C.LI x10,-8          x10=-8
    cShift(1, 2, 2),      // C.SRAI x10,2         x10=-2
    cCI(1, 2, 11, 1),     // C.LI x11,1           x11=1
    cSLLI(11, 5),         // C.SLLI x11,5         x11=32
    cMV(12, 11),          // C.MV x12,x11         x12=32
    cCI(1, 2, 13, 3),     // C.LI x13,3           x13=3
    cADD(12, 13),         // C.ADD x12,x13        x12=35
    cCI(1, 2, 13, 20),    // C.LI x13,20
    cCI(1, 2, 14, 5),     // C.LI x14,5
    cALU(5, 6, 0),        // C.SUB x13,x14        x13=15
    cCI(1, 2, 13, 12),    // C.LI x13,12
    cCI(1, 2, 14, 10),    // C.LI x14,10
    cALU(5, 6, 1),        // C.XOR x13,x14        x13=6
    cCI(1, 2, 13, 12),    // C.LI x13,12
    cCI(1, 2, 14, 10),    // C.LI x14,10
    cALU(5, 6, 2),        // C.OR  x13,x14        x13=14
    cCI(1, 2, 13, 12),    // C.LI x13,12
    cCI(1, 2, 14, 10),    // C.LI x14,10
    cALU(5, 6, 3),        // C.AND x13,x14        x13=8
    cCI(1, 2, 15, 20),    // C.LI x15,20          x15=20 (store value)
    cCI(1, 2, 8, 0),      // C.LI x8,0            x8=0  (base)
    cSW(7, 0, 64),        // C.SW x15,64(x8)      mem[64]=20
    cLW(0, 0, 64)         // C.LW x8,64(x8)       x8=20
  )) ++ Seq(0x0000006FL) // jal x0,0             self-loop at 0x40

  // RV32C control-flow coverage: C.JAL (link = PC+2), C.JR, C.BNEZ taken and
  // not taken, C.BEQZ not taken, C.JALR (link = PC+2), and a C.J self-loop.
  // Layout: 0x00 C.LI x8,5 | 0x02 C.LI x13,16 | 0x04 C.JAL ->0x0A | skips at
  // 0x06/0x08 | 0x0A C.MV x21,x1 (saves link 0x06) | 0x0C C.JR x13 ->0x10 |
  // 0x0E skipped | 0x10 C.LI x9,30 | 0x12 C.BEQZ x8 (not taken) | 0x14 x10=1 |
  // 0x16 C.BNEZ x8 ->0x1A | 0x18 skipped | 0x1A x15=4 | 0x1C/0x1E build x13=0x30
  // | 0x20 C.JALR x13 ->0x30 (link 0x22) | 0x22..0x2E skipped | 0x30 x12=11 |
  // 0x32 C.J 0 (self-loop).
  val rv32cFlowProgram = packHalfwords(Seq(
    cCI(1, 2, 8, 5),      // 0x00 C.LI x8,5
    cCI(1, 2, 13, 16),    // 0x02 C.LI x13,16      (JR target 0x10)
    cJ(1, 1, 6),          // 0x04 C.JAL +6 -> 0x0A
    cCI(1, 2, 9, 21),     // 0x06 skipped
    cCI(1, 2, 9, 22),     // 0x08 skipped
    cMV(21, 1),           // 0x0A x21 = link (0x06)
    cJR(13),              // 0x0C C.JR x13 -> 0x10
    cCI(1, 2, 11, 23),    // 0x0E skipped
    cCI(1, 2, 9, 30),     // 0x10 x9=30
    cB(6, 0, 4),          // 0x12 C.BEQZ x8 -> 0x16 (not taken, x8=5)
    cCI(1, 2, 10, 1),     // 0x14 x10=1
    cB(7, 0, 4),          // 0x16 C.BNEZ x8 -> 0x1A (taken)
    cCI(1, 2, 11, 24),    // 0x18 skipped
    cCI(1, 2, 15, 4),     // 0x1A x15=4
    cCI(1, 2, 13, 12),    // 0x1C x13=12
    cSLLI(13, 2),         // 0x1E C.SLLI x13,2 -> x13=48 (0x30)
    cJALR(13),            // 0x20 C.JALR x13 -> 0x30
    cCI(1, 2, 12, 25),    // 0x22 skipped
    cCI(1, 2, 12, 26),    // 0x24 skipped
    cCI(1, 2, 12, 27),    // 0x26 skipped
    cCI(1, 2, 12, 28),    // 0x28 skipped
    cCI(1, 2, 12, 29),    // 0x2A skipped
    cCI(1, 2, 12, 30),    // 0x2C skipped
    cCI(1, 2, 12, 31),    // 0x2E skipped
    cCI(1, 2, 12, 11),    // 0x30 x12=11 (JALR landing)
    cJ(1, 5, 0)           // 0x32 C.J 0 (self-loop)
  ))

  // RV64C coverage: C.LD/C.SD (Q0 doubleword), C.LDSP/C.SDSP (Q2 doubleword),
  // C.ADDIW, C.SUBW/C.ADDW, and 6-bit shamt shifts (instr[12]=1). The final
  // `addi x1,x0,7` is a 32-bit instruction deliberately placed at pc[1]=1
  // (addr 0x36) so the misaligned-32 splice path is exercised under xlen=64.
  // Self-loop (jal x0,0) at 0x3C.
  val rv64cProgram: Seq[Long] = {
    val body = Seq[Int](
      cCI(1, 2, 9, 1),      // 0x00 C.LI x9,1
      cSLLI(9, 40),         // 0x02 C.SLLI x9,40      x9 = 1<<40 (shamt[5]=1)
      cShift(0, 1, 3),      // 0x04 C.SRLI x9,3       x9 = 1<<37
      cCI(1, 2, 10, -1),    // 0x06 C.LI x10,-1
      cShift(1, 2, 33),     // 0x08 C.SRAI x10,33     x10 = -1 (arith, 6-bit shamt)
      cCI(1, 2, 11, -1),    // 0x0A C.LI x11,-1
      cSLLI(11, 31),        // 0x0C C.SLLI x11,31     x11 = 0xFFFFFFFF80000000
      cADDIW(11, 1),        // 0x0E C.ADDIW x11,1     x11 = 0xFFFFFFFF80000001
      cCI(1, 2, 12, 1),     // 0x10 C.LI x12,1
      cSLLI(12, 32),        // 0x12 C.SLLI x12,32     x12 = 1<<32
      cADDIW(12, 5),        // 0x14 C.ADDIW x12,5     x12 = 5 (low32 truncation)
      cCI(1, 2, 13, 8),     // 0x16 C.LI x13,8
      cALUW(4, 5, 1),       // 0x18 C.ADDW x12,x13    x12 = 13
      cALUW(4, 5, 0),       // 0x1A C.SUBW x12,x13    x12 = 5
      cCI(1, 2, 13, -1),    // 0x1C C.LI x13,-1
      cSLLI(13, 31),        // 0x1E C.SLLI x13,31     x13 = 0xFFFFFFFF80000000
      cCI(1, 2, 14, -1),    // 0x20 C.LI x14,-1
      cALUW(5, 6, 1),       // 0x22 C.ADDW x13,x14    x13 = 0x7FFFFFFF
      cCI(1, 2, 15, 1),     // 0x24 C.LI x15,1
      cSLLI(15, 32),        // 0x26 C.SLLI x15,32     x15 = 1<<32
      cCI(1, 0, 15, 1),     // 0x28 C.ADDI x15,1      x15 = 0x100000001
      cCI(1, 2, 8, 0),      // 0x2A C.LI x8,0         base = 0
      cSD(7, 0, 40),        // 0x2C C.SD x15,40(x8)   mem[40] = 0x100000001
      cLD(6, 0, 40),        // 0x2E C.LD x14,40(x8)   x14 = 0x100000001
      cCI(1, 2, 2, 16),     // 0x30 C.LI x2,16        sp = 16
      cSDSP(15, 16),        // 0x32 C.SDSP x15,16(x2) mem[sp+16] = 0x100000001
      cLDSP(16, 16)         // 0x34 C.LDSP x16,16(x2) x16 = 0x100000001
    )
    // Place a 32-bit `addi x1,x0,7` at addr 0x36 (pc[1]=1): its low half lives
    // in the high halfword of word 0x34, its high half in word 0x38.
    val mixed = encI(7, 0, 0, 1)
    val withMixed = (body :+ (mixed & 0xffff).toInt).grouped(2).map {
      case Seq(lo, hi) => (lo & 0xffff).toLong | ((hi.toLong & 0xffff) << 16)
    }.toSeq
    withMixed ++ Seq(
      ((mixed >>> 16) & 0xffff).toLong | ((cNop.toLong & 0xffff) << 16), // 0x38
      0x0000006FL                                                        // 0x3C jal x0,0
    )
  }

  // RV32A program: LR/SC success and mismatch-failure, plus all nine AMO
  // operations and a dependent add to exercise AMO-result forwarding. 32-bit
  // instructions; self-loop (jal x0,0) at 0x8C.
  val rv32aProgram = Seq[Long](
    encI(5, 0, 0, 1),             // 0x00 addi x1,x0,5
    encS(0, 1, 0, 2),             // 0x04 sw   x1,0(x0)        mem[0]=5
    encI(3, 0, 0, 3),             // 0x08 addi x3,x0,3
    encAmo(0x00, 3, 0, 2, 2),     // 0x0C AMOADD.W  x2,x3,(x0) x2=5, mem=8
    encR(0, 1, 2, 0, 4, 0x33),    // 0x10 add  x4,x2,x1      x4=10 (AMO result dependency)
    encI(99, 0, 0, 6),            // 0x14 addi x6,x0,99
    encAmo(0x01, 6, 0, 2, 5),     // 0x18 AMOSWAP.W x5,x6,(x0) x5=8, mem=99
    encI(0, 0, 2, 7, 0x03),       // 0x1C lw   x7,0(x0)      x7=99
    encAmo(0x02, 0, 0, 2, 8),     // 0x20 LR.W x8,(x0)       x8=99, reservation=0
    encI(7, 0, 0, 10),            // 0x24 addi x10,x0,7
    encAmo(0x03, 10, 0, 2, 9),    // 0x28 SC.W x9,x10,(x0)   x9=0, mem=7
    encI(0, 0, 2, 11, 0x03),      // 0x2C lw   x11,0(x0)     x11=7
    encAmo(0x02, 0, 0, 2, 12),    // 0x30 LR.W x12,(x0)      x12=7, reservation=0
    encI(4, 0, 0, 15),            // 0x34 addi x15,x0,4
    encI(0x55, 0, 0, 6),          // 0x38 addi x6,x0,0x55
    encS(0, 6, 15, 2),            // 0x3C sw   x6,0(x15)     mem[4]=0x55 sentinel
    encI(1, 0, 0, 14),            // 0x40 addi x14,x0,1
    encAmo(0x03, 14, 15, 2, 13),  // 0x44 SC.W x13,x14,0(x15) x13=1 (mismatch), no store
    encI(0, 15, 2, 15, 0x03),     // 0x48 lw   x15,0(x15)    x15=0x55 (SC failure wrote nothing)
    encI(0xF, 0, 0, 16),          // 0x4C addi x16,x0,15
    encAmo(0x04, 16, 0, 2, 17),   // 0x50 AMOXOR.W  x17,x16,(x0) x17=7, mem=0x08
    encI(0xC, 0, 0, 18),          // 0x54 addi x18,x0,12
    encAmo(0x0c, 18, 0, 2, 19),   // 0x58 AMOAND.W  x19,x18,(x0) x19=8, mem=0x08
    encI(0x30, 0, 0, 20),         // 0x5C addi x20,x0,48
    encAmo(0x08, 20, 0, 2, 21),   // 0x60 AMOOR.W   x21,x20,(x0) x21=8, mem=0x38
    encI(-1, 0, 0, 22),           // 0x64 addi x22,x0,-1
    encAmo(0x10, 22, 0, 2, 23),   // 0x68 AMOMIN.W  x23,x22,(x0) x23=0x38, mem=0xFFFFFFFF
    encI(5, 0, 0, 24),            // 0x6C addi x24,x0,5
    encAmo(0x14, 24, 0, 2, 25),   // 0x70 AMOMAX.W  x25,x24,(x0) x25=0xFFFFFFFF, mem=5
    encI(2, 0, 0, 26),            // 0x74 addi x26,x0,2
    encAmo(0x18, 26, 0, 2, 27),   // 0x78 AMOMINU.W x27,x26,(x0) x27=5, mem=2
    encI(0xA, 0, 0, 28),          // 0x7C addi x28,x0,10
    encAmo(0x1c, 28, 0, 2, 29),   // 0x80 AMOMAXU.W x29,x28,(x0) x29=2, mem=0x0A
    encI(0, 0, 2, 30, 0x03),      // 0x84 lw   x30,0(x0)     x30=0x0A
    encAmo(0x00, 2, 0, 2, 31),    // 0x88 AMOADD.W  x31,x2,(x0) x31=0x0A, mem=0x0F
    0x0000006FL                   // 0x8C jal x0,0
  )

  // RV64A program: LR.D/SC.D, AMO.D 64-bit add, and AMO.W sign-extension /
  // 32-bit unsigned max. Self-loop (jal x0,0) at 0x80.
  val rv64aProgram = Seq[Long](
    encI(5, 0, 0, 1),             // 0x00 addi x1,x0,5
    encS(0, 1, 0, 3),             // 0x04 sd   x1,0(x0)        mem[0]=5
    encI(3, 0, 0, 3),             // 0x08 addi x3,x0,3
    encAmo(0x00, 3, 0, 3, 2),     // 0x0C AMOADD.D x2,x3,(x0)  x2=5, mem=8
    encI(0, 0, 3, 4, 0x03),       // 0x10 ld   x4,0(x0)        x4=8
    encI(1, 0, 0, 6),             // 0x14 addi x6,x0,1
    encI(32, 6, 1, 6),            // 0x18 slli x6,x6,32        x6=1<<32
    encS(8, 6, 0, 3),             // 0x1C sd   x6,8(x0)        mem[8]=0x100000000
    encAmo(0x02, 0, 0, 3, 7),     // 0x20 LR.D x7,(x0)         x7=8
    encI(7, 0, 0, 9),             // 0x24 addi x9,x0,7
    encAmo(0x03, 9, 0, 3, 8),     // 0x28 SC.D x8,x9,(x0)      x8=0, mem[0]=7
    encI(0, 0, 3, 10, 0x03),      // 0x2C ld   x10,0(x0)       x10=7
    encAmo(0x02, 0, 0, 3, 11),    // 0x30 LR.D x11,(x0)        x11=7
    encI(8, 0, 0, 13),            // 0x34 addi x13,x0,8
    encAmo(0x03, 13, 13, 3, 12),  // 0x38 SC.D x12,x13,8(x13)  x12=1 (mismatch), no store
    encI(8, 0, 3, 14, 0x03),      // 0x3C ld   x14,8(x0)       x14=0x100000000
    encI(-1, 0, 0, 15),           // 0x40 addi x15,x0,-1
    encI(31, 15, 1, 15),          // 0x44 slli x15,x15,31      x15=0xFFFFFFFF80000000
    encAmo(0x01, 15, 0, 2, 16),   // 0x48 AMOSWAP.W x16,x15,(x0) x16=7, mem=0x80000000
    encI(0, 0, 3, 17, 0x03),      // 0x4C ld   x17,0(x0)       x17=0x80000000
    encI(1, 0, 0, 18),            // 0x50 addi x18,x0,1
    encAmo(0x14, 18, 0, 2, 19),   // 0x54 AMOMAX.W x19,x18,(x0) x19=signExt(0x80000000), mem=1
    encI(0, 0, 3, 20, 0x03),      // 0x58 ld   x20,0(x0)       x20=1
    encI(-1, 0, 0, 22),           // 0x5C addi x22,x0,-1
    encAmo(0x1c, 22, 0, 2, 21),   // 0x60 AMOMAXU.W x21,x22,(x0) x21=1, mem=0xFFFFFFFF
    encI(0, 0, 3, 23, 0x03),      // 0x64 ld   x23,0(x0)       x23=0xFFFFFFFF
    encAmo(0x00, 1, 0, 3, 24),    // 0x68 AMOADD.D x24,x1,(x0) x24=0xFFFFFFFF, mem=0x100000004
    encI(0, 0, 3, 25, 0x03),      // 0x6C ld   x25,0(x0)       x25=0x100000004
    encI(12, 0, 0, 26),           // 0x70 addi x26,x0,12       high 32 bits of memory word 1
    encI(5, 0, 0, 27),            // 0x74 addi x27,x0,5
    encAmo(0x00, 27, 26, 2, 28),  // 0x78 AMOADD.W x28,x27,0(x26) x28=1 (old high word), mem high=6
    encI(0, 26, 3, 29, 0x03),     // 0x7C ld   x29,0(x26)      x29=0x600000000
    0x0000006FL                   // 0x80 jal x0,0
  )

  // Misaligned A accesses must trap before any memory side effect.
  val rv32aLrMisalignedProgram = Seq[Long](
    encI(2, 0, 0, 1),             // 0x00 addi x1,x0,2
    encAmo(0x02, 0, 1, 2, 2)      // 0x04 LR.W x2,(x1)  misaligned -> cause 4, mepc=4
  )
  val rv32aAmoMisalignedProgram = Seq[Long](
    encI(2, 0, 0, 1),             // 0x00 addi x1,x0,2
    encAmo(0x00, 0, 1, 2, 2)      // 0x04 AMOADD.W x2,x0,(x1) misaligned -> cause 6, mepc=4
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

  test("RV64M W-suffix multiply/divide program") {
    val cfg = CoreConfig(isa = IsaConfig(64, Set(RvExtension.Zicsr, RvExtension.MulDiv), PrivConfig.MU))
    val lastPc = 4 * (rv64mProgram.length - 1)
    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(cfg, rv64mProgram))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5) // flush reset

        val cycles = runUntil(dut, 4000, lastPc, 0, 0)
        assert(cycles < 4000, "program did not finish")
        dut.clockDomain.waitSampling(10) // let the last writes retire

        val sgn80000000 = BigInt("FFFFFFFF80000000", 16)
        val sgnC0000000 = BigInt("FFFFFFFFC0000000", 16)
        val allOnes = BigInt("FFFFFFFFFFFFFFFF", 16)
        assert(dut.io.debugRegs(8).toBigInt == 0, "x8 = mulw truncation")
        assert(dut.io.debugRegs(9).toBigInt == 1, "x9 = mulw (-1*-1)")
        assert(dut.io.debugRegs(10).toBigInt == sgn80000000, "x10 = mulw sign-extend")
        assert(dut.io.debugRegs(11).toBigInt == sgnC0000000, "x11 = divw -2^31/2")
        assert(dut.io.debugRegs(12).toBigInt == sgn80000000, "x12 = divw overflow")
        assert(dut.io.debugRegs(13).toBigInt == 0, "x13 = remw overflow = 0")
        assert(dut.io.debugRegs(14).toBigInt == allOnes, "x14 = divw -7/6 = -1")
        assert(dut.io.debugRegs(15).toBigInt == allOnes, "x15 = remw -7%6 = -1")
        assert(dut.io.debugRegs(16).toBigInt == BigInt("7FFFFFFF", 16), "x16 = divuw")
        assert(dut.io.debugRegs(17).toBigInt == 1, "x17 = remuw")
        assert(dut.io.debugRegs(18).toBigInt == BigInt("55555555", 16), "x18 = divuw")
        assert(dut.io.debugRegs(19).toBigInt == allOnes, "x19 = divuw sign-extended result")
        assert(dut.io.debugRegs(20).toBigInt == 0, "x20 = remuw = 0")
        assert(dut.io.debugRegs(21).toBigInt == 0, "x21 = divw -1/2 = 0")
        assert(dut.io.debugRegs(22).toBigInt == allOnes, "x22 = remw -1%2 = -1")
        assert(dut.io.debugRegs(23).toBigInt == allOnes, "x23 = divw by zero")
        assert(dut.io.debugRegs(24).toBigInt == allOnes, "x24 = remw by zero")
        assert(dut.io.debugRegs(25).toBigInt == allOnes, "x25 = divuw by zero")
        assert(dut.io.debugRegs(26).toBigInt == BigInt("FFFFFFFFFFFFFFF9", 16), "x26 = remuw by zero")
        assert(dut.io.debugRegs(27).toBigInt == 306783378, "x27 = divw -2^31/-7")
        assert(dut.io.debugRegs(28).toBigInt == 2, "x28 = mulw-result forwarding")
        assert(dut.io.debugRegs(29).toBigInt == 306783379, "x29 = divider-result forwarding")
        println(s"PASS: RV64M finished in $cycles cycles")
      }
  }

  test("RV32C compressed program") {
    val cfg = CoreConfig.rv32imc
    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(cfg, rv32cProgram))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5) // flush reset

        val cycles = runUntil(dut, 400, 0x18, 1, 27)
        assert(cycles < 400, "program did not finish")
        dut.clockDomain.waitSampling(5) // settle

        assert(dut.io.debugRegs(1).toBigInt == 27, "x1 = 3 + 4 + 20 (C.LI/32-bit/C.ADD)")
        assert(dut.io.debugRegs(3).toBigInt == 7, "x3 = stored value via C.LWSP round-trip")
        assert(dut.io.debugRegs(4).toBigInt == 20, "x4 = C.LI 20")
        assert(dut.io.debugRegs(8).toBigInt == 4, "x8 = sp + 4 (C.ADDI4SPN)")
        assert(dut.io.debugRegs(9).toBigInt == 7, "x9 = C.LI 7")
        assert(dut.io.debugRegs(10).toBigInt == 7, "x10 = C.LW round-trip through C.SW")
        println(s"PASS: RV32C finished in $cycles cycles")
      }
  }

  test("RV32C reserved encoding traps (cause 2)") {
    val cfg = CoreConfig.rv32imc
    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(cfg, rv32cIllegalProgram))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(20)

        assert(dut.io.debugMcause.toBigInt == 2, "reserved compressed encoding -> illegal instruction")
        assert(dut.io.debugMepc.toBigInt == 0, "mepc should point at the faulting compressed instruction")
        println("PASS: RV32C reserved encoding traps")
      }
  }

  test("RV32C arithmetic/immediate/register coverage") {
    val cfg = CoreConfig.rv32imc
    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(cfg, rv32cArithProgram))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5) // flush reset

        val cycles = runUntil(dut, 500, 0x40, 8, 20)
        assert(cycles < 500, "program did not finish")
        dut.clockDomain.waitSampling(5) // settle

        assert(dut.io.debugRegs(1).toBigInt == 8, "x1 = 5 + 3 (C.ADDI)")
        assert(dut.io.debugRegs(16).toBigInt == 0x1000L, "x16 = C.LUI 1<<12")
        assert(dut.io.debugRegs(2).toBigInt == 36, "x2 = 20 + 16 (C.ADDI16SP)")
        assert(dut.io.debugRegs(8).toBigInt == 20, "x8 = C.LW x8,64(x8)")
        assert(dut.io.debugRegs(9).toBigInt == 7, "x9 = 30 >>> 2 (C.SRLI)")
        assert(dut.io.debugRegs(10).toBigInt == 0xfffffffeL, "x10 = -8 >> 2 (C.SRAI)")
        assert(dut.io.debugRegs(11).toBigInt == 32, "x11 = 1 << 5 (C.SLLI)")
        assert(dut.io.debugRegs(12).toBigInt == 35, "x12 = C.MV 32 then C.ADD +3")
        assert(dut.io.debugRegs(13).toBigInt == 8, "x13 = last C.AND result")
        assert(dut.io.debugRegs(14).toBigInt == 10, "x14 = 10")
        assert(dut.io.debugRegs(15).toBigInt == 20, "x15 = 20 stored via C.SW at imm 64")
        println(s"PASS: RV32C arith finished in $cycles cycles")
      }
  }

  test("RV32C control-flow coverage") {
    val cfg = CoreConfig.rv32imc
    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(cfg, rv32cFlowProgram))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5) // flush reset

        val cycles = runUntil(dut, 500, 0x32, 12, 11)
        assert(cycles < 500, "program did not finish")
        dut.clockDomain.waitSampling(5) // settle

        assert(dut.io.debugRegs(8).toBigInt == 5, "x8 = 5")
        assert(dut.io.debugRegs(21).toBigInt == 0x06L, "x21 = C.JAL link (PC+2)")
        assert(dut.io.debugRegs(9).toBigInt == 30, "x9 = 30 after C.JR landing")
        assert(dut.io.debugRegs(10).toBigInt == 1, "C.BEQZ not taken (x8!=0)")
        assert(dut.io.debugRegs(11).toBigInt == 0, "skipped by C.JR and C.BNEZ")
        assert(dut.io.debugRegs(15).toBigInt == 4, "x15 = 4 after C.BNEZ taken")
        assert(dut.io.debugRegs(13).toBigInt == 48, "x13 = 12 << 2 (C.SLLI)")
        assert(dut.io.debugRegs(1).toBigInt == 0x22L, "x1 = C.JALR link (PC+2)")
        assert(dut.io.debugRegs(12).toBigInt == 11, "x12 = 11 at C.JALR landing")
        println(s"PASS: RV32C flow finished in $cycles cycles")
      }
  }

  test("RV64C compressed program") {
    val cfg = CoreConfig.rv64imc
    val lastPc = 4 * (rv64cProgram.length - 1)
    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(cfg, rv64cProgram))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5) // flush reset

        val cycles = runUntil(dut, 500, lastPc, 16, BigInt("100000001", 16))
        assert(cycles < 500, "program did not finish")
        dut.clockDomain.waitSampling(5) // settle

        val allOnes = BigInt("FFFFFFFFFFFFFFFF", 16)
        assert(dut.io.debugRegs(9).toBigInt == BigInt("2000000000", 16), "x9 = 1<<40 >>> 3 (6-bit shamt)")
        assert(dut.io.debugRegs(10).toBigInt == allOnes, "x10 = -1 >> 33 (C.SRAI, 6-bit shamt)")
        assert(dut.io.debugRegs(11).toBigInt == BigInt("FFFFFFFF80000001", 16), "x11 = C.ADDIW sign-extend")
        assert(dut.io.debugRegs(12).toBigInt == 5, "x12 = C.ADDW then C.SUBW")
        assert(dut.io.debugRegs(13).toBigInt == BigInt("7FFFFFFF", 16), "x13 = C.ADDW 32-bit overflow")
        assert(dut.io.debugRegs(14).toBigInt == BigInt("100000001", 16), "x14 = C.LD round-trip")
        assert(dut.io.debugRegs(15).toBigInt == BigInt("100000001", 16), "x15 = 1<<32 + 1")
        assert(dut.io.debugRegs(16).toBigInt == BigInt("100000001", 16), "x16 = C.LDSP round-trip")
        assert(dut.io.debugRegs(2).toBigInt == 16, "x2 = sp 16")
        assert(dut.io.debugRegs(1).toBigInt == 7, "x1 = 32-bit instr at pc[1]=1 spliced")
        println(s"PASS: RV64C finished in $cycles cycles")
      }
  }

  test("RV32A atomics program") {
    val cfg = CoreConfig.rv32ima
    val lastPc = 4 * (rv32aProgram.length - 1)
    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(cfg, rv32aProgram))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5) // flush reset

        val cycles = runUntil(dut, 800, lastPc, 31, 0xAL)
        assert(cycles < 800, "program did not finish")
        dut.clockDomain.waitSampling(5) // settle

        assert(dut.io.debugRegs(2).toBigInt == 5, "x2 = AMOADD.W old value")
        assert(dut.io.debugRegs(4).toBigInt == 10, "x4 = x2 + x1 (AMO result forwarded)")
        assert(dut.io.debugRegs(5).toBigInt == 8, "x5 = AMOSWAP.W old value")
        assert(dut.io.debugRegs(7).toBigInt == 99, "x7 = mem after AMOSWAP")
        assert(dut.io.debugRegs(8).toBigInt == 99, "x8 = LR.W old value")
        assert(dut.io.debugRegs(9).toBigInt == 0, "x9 = SC.W success")
        assert(dut.io.debugRegs(11).toBigInt == 7, "x11 = mem after successful SC.W")
        assert(dut.io.debugRegs(12).toBigInt == 7, "x12 = LR.W for mismatch test")
        assert(dut.io.debugRegs(13).toBigInt == 1, "x13 = SC.W failure (address mismatch)")
        assert(dut.io.debugRegs(15).toBigInt == 0x55L, "x15 = failed SC.W left the sentinel untouched")
        assert(dut.io.debugRegs(17).toBigInt == 7, "x17 = AMOXOR.W old value")
        assert(dut.io.debugRegs(19).toBigInt == 8, "x19 = AMOAND.W old value")
        assert(dut.io.debugRegs(21).toBigInt == 8, "x21 = AMOOR.W old value")
        assert(dut.io.debugRegs(23).toBigInt == 0x38L, "x23 = AMOMIN.W old value")
        assert(dut.io.debugRegs(25).toBigInt == 0xFFFFFFFFL, "x25 = AMOMAX.W old value")
        assert(dut.io.debugRegs(27).toBigInt == 5, "x27 = AMOMINU.W old value")
        assert(dut.io.debugRegs(29).toBigInt == 2, "x29 = AMOMAXU.W old value")
        assert(dut.io.debugRegs(30).toBigInt == 0xAL, "x30 = mem after AMOMAXU.W")
        assert(dut.io.debugRegs(31).toBigInt == 0xAL, "x31 = final AMOADD.W old value")
        println(s"PASS: RV32A finished in $cycles cycles")
      }
  }

  test("RV64A atomics program") {
    val cfg = CoreConfig.rv64ima
    val lastPc = 4 * (rv64aProgram.length - 1)
    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(cfg, rv64aProgram))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5) // flush reset

        val cycles = runUntil(dut, 500, lastPc, 25, BigInt("100000004", 16))
        assert(cycles < 500, "program did not finish")
        dut.clockDomain.waitSampling(5) // settle

        assert(dut.io.debugRegs(2).toBigInt == 5, "x2 = AMOADD.D old value")
        assert(dut.io.debugRegs(4).toBigInt == 8, "x4 = mem after AMOADD.D")
        assert(dut.io.debugRegs(7).toBigInt == 8, "x7 = LR.D old value")
        assert(dut.io.debugRegs(8).toBigInt == 0, "x8 = SC.D success")
        assert(dut.io.debugRegs(10).toBigInt == 7, "x10 = mem after successful SC.D")
        assert(dut.io.debugRegs(11).toBigInt == 7, "x11 = LR.D for mismatch test")
        assert(dut.io.debugRegs(12).toBigInt == 1, "x12 = SC.D failure (address mismatch)")
        assert(dut.io.debugRegs(14).toBigInt == BigInt("100000000", 16), "x14 = SC.D failure wrote nothing")
        assert(dut.io.debugRegs(16).toBigInt == 7, "x16 = AMOSWAP.W old value")
        assert(dut.io.debugRegs(17).toBigInt == BigInt("80000000", 16), "x17 = mem low word after AMOSWAP.W")
        assert(dut.io.debugRegs(19).toBigInt == BigInt("FFFFFFFF80000000", 16), "x19 = AMOMAX.W sign-extended old")
        assert(dut.io.debugRegs(20).toBigInt == 1, "x20 = mem after AMOMAX.W")
        assert(dut.io.debugRegs(21).toBigInt == 1, "x21 = AMOMAXU.W old value")
        assert(dut.io.debugRegs(23).toBigInt == BigInt("FFFFFFFF", 16), "x23 = mem low word after AMOMAXU.W")
        assert(dut.io.debugRegs(24).toBigInt == BigInt("FFFFFFFF", 16), "x24 = AMOADD.D old value")
        assert(dut.io.debugRegs(25).toBigInt == BigInt("100000004", 16), "x25 = 64-bit AMOADD.D sum")
        assert(dut.io.debugRegs(28).toBigInt == 1, "x28 = AMOADD.W high-word old value at address 12")
        assert(dut.io.debugRegs(29).toBigInt == BigInt("600000000", 16), "x29 = AMOADD.W wrote the high word")
        println(s"PASS: RV64A finished in $cycles cycles")
      }
  }

  test("RV32A misaligned LR traps (cause 4)") {
    val cfg = CoreConfig.rv32ima
    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(cfg, rv32aLrMisalignedProgram))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5) // flush reset
        dut.clockDomain.waitSampling(20)
        assert(dut.io.debugMcause.toBigInt == 4, "misaligned LR.W -> load address misaligned")
        assert(dut.io.debugMepc.toBigInt == 4, "mepc points at the faulting LR.W")
        println("PASS: RV32A misaligned LR trap")
      }
  }

  test("RV32A misaligned AMO traps (cause 6)") {
    val cfg = CoreConfig.rv32ima
    SimConfig.withIVerilog
      .workspacePath("simWork")
      .compile(new CpuTb(cfg, rv32aAmoMisalignedProgram))
      .doSim { dut =>
        dut.clockDomain.forkStimulus(10)
        dut.clockDomain.waitSampling(5) // flush reset
        dut.clockDomain.waitSampling(20)
        assert(dut.io.debugMcause.toBigInt == 6, "misaligned AMO -> store address misaligned")
        assert(dut.io.debugMepc.toBigInt == 4, "mepc points at the faulting AMO")
        println("PASS: RV32A misaligned AMO trap")
      }
  }
}
