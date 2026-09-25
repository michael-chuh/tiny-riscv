package rv32c.core

import spinal.core._

/** Floating-point register file: 32 registers of `flen` bits each.
  *
  * Unlike the integer file there is no hardwired zero register: f0 is an
  * ordinary register. Three read ports (rs1/rs2/rs3) feed the FPU operands and
  * the FP store data path; a single write port (rd) is the only way a value
  * enters the file, mirroring the integer register file's one-writer rule.
  */
class FpRegisterFile(flen: Int) extends Component {
  val io = new Bundle {
    val rs1 = in UInt(5 bits)
    val rs2 = in UInt(5 bits)
    val rs3 = in UInt(5 bits)
    val rd = in UInt(5 bits)
    val writeData = in Bits(flen bits)
    val writeEnable = in Bool()
    val rs1Data = out Bits(flen bits)
    val rs2Data = out Bits(flen bits)
    val rs3Data = out Bits(flen bits)
    val debugRegs = out Vec(Bits(flen bits), 32)
  }

  val regs = Vec(Reg(Bits(flen bits)) init B(0, flen bits), 32)

  when(io.writeEnable) {
    regs(io.rd) := io.writeData
  }

  io.rs1Data := regs(io.rs1)
  io.rs2Data := regs(io.rs2)
  io.rs3Data := regs(io.rs3)
  io.debugRegs := regs
}
