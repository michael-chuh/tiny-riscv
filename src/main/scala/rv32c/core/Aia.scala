package rv32c.core

import spinal.core._

/** AIA (Advanced Interrupt Architecture) - Simplified APLIC Controller.
  *
  * Minimal implementation:
  * - 16 external interrupt inputs
  * - Simple OR-tree for interrupt pending
  * - Direct meip/seip output
  */
class AiaAplic(
  val numSources: Int = 16,
  val addrWidth: Int
) extends Component {
  val io = new Bundle {
    val enable = in Bool()
    val irqIn = in Bits(numSources bits)
    val meip = out Bool()
    val seip = out Bool()
  }

  // Interrupt pending
  val ip = io.irqIn
  
  // Any interrupt sets meip
  io.meip := io.enable && (ip.asBits.orR)
  io.seip := False
}
