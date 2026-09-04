package rv32c.sim

import spinal.core._

/** Simple single-port memory slave used in simulation.
  *
  * Reads are combinationally responded (readAsync) so that the core's
  * single-cycle bus handshake works without extra pipeline stages. Writes are
  * synchronous with a byte mask. This models an ideal zero-wait-state memory;
  * a real cache/SRAM would be added later behind the same bus interface.
  */
class SyncRamSim(xlen: Int, depth: Int) extends Component {
  val io = new Bundle {
    val valid = in Bool()
    val write = in Bool()
    val address = in UInt(xlen bits)
    val writeData = in Bits(xlen bits)
    val writeMask = in Bits(xlen / 8 bits)
    val ready = out Bool()
    val readData = out Bits(xlen bits)
  }

  val mem = Mem(Bits(xlen bits), depth)
  val wordSel = (io.address >> log2Up(xlen / 8)).resize(log2Up(depth))

  io.ready := True
  io.readData := mem.readAsync(wordSel)

  mem.write(wordSel, io.writeData, io.valid && io.write, io.writeMask)
}
