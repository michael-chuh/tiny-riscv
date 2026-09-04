package rv32c.core

import spinal.core._

class RegisterFile(xlen: Int) extends Component {
  val io = new Bundle {
    val rs1 = in UInt(5 bits)
    val rs2 = in UInt(5 bits)
    val rd = in UInt(5 bits)
    val writeData = in Bits(xlen bits)
    val writeEnable = in Bool()
    val rs1Data = out Bits(xlen bits)
    val rs2Data = out Bits(xlen bits)
    val debugRegs = out Vec(Bits(xlen bits), 32)
  }

  val regs = Vec(Reg(Bits(xlen bits)) init B(0, xlen bits), 32)

  when(io.writeEnable && io.rd =/= U(0)) {
    regs(io.rd) := io.writeData
  }

  io.rs1Data := Mux(io.rs1 === U(0), B(0, xlen bits), regs(io.rs1))
  io.rs2Data := Mux(io.rs2 === U(0), B(0, xlen bits), regs(io.rs2))
  io.debugRegs := regs
}
