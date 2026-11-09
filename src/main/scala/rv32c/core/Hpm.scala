package rv32c.core

import spinal.core._

/** HPM (Hardware Performance Monitor) - Simplified: mcycle only.
  *
  * Minimal implementation for stable integration:
  * - mcycle CSR (0xB00)
  * - Simple cycle counter
  */
class Hpm(val xlen: Int = 64) extends Component {
  val io = new Bundle {
    val enable = in Bool()
    val cycleEvent = in Bool()
    val csrAddr = in UInt(12 bits)
    val csrWe = in Bool()
    val csrDataIn = in Bits(xlen bits)
    val csrDataOut = out Bits(xlen bits)
  }

  // mcycle register
  val mcycle = Reg(UInt(xlen bits)) init U(0, xlen bits)
  when(io.enable && io.cycleEvent) {
    mcycle := mcycle + 1
  }

  // CSR access
  io.csrDataOut := B(0, xlen bits)
  when(io.csrAddr === U(0xB00, 12 bits)) {
    io.csrDataOut := mcycle.asBits
  }
  
  when(io.csrWe && io.csrAddr === U(0xB00, 12 bits)) {
    mcycle := io.csrDataIn.asUInt
  }
}
