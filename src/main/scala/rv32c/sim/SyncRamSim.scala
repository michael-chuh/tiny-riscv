package rv32c.sim

import spinal.core._

/** Simple single-port memory slave used in simulation.
  *
  * Reads are combinationally responded (readAsync) so that the core's
  * single-cycle bus handshake works without extra pipeline stages. Writes are
  * synchronous with a byte mask. This models an ideal zero-wait-state memory;
  * a real cache/SRAM would be added later behind the same bus interface.
  *
  * `dataWidth` and `addrWidth` are separate because instruction memory stays
  * 32-bit wide even on an RV64 hart (instructions are always 32 bits), while
  * data memory follows the data-path width.
  */
class SyncRamSim(val dataWidth: Int, val addrWidth: Int, depth: Int) extends Component {
  val io = new Bundle {
    val valid = in Bool()
    val write = in Bool()
    val address = in UInt(addrWidth bits)
    val writeData = in Bits(dataWidth bits)
    val writeMask = in Bits(dataWidth / 8 bits)
    val ready = out Bool()
    val readData = out Bits(dataWidth bits)
  }

  val mem = Mem(Bits(dataWidth bits), depth)
  val wordSel = (io.address >> log2Up(dataWidth / 8)).resize(log2Up(depth))

  io.ready := True
  io.readData := mem.readAsync(wordSel)

  mem.write(wordSel, io.writeData, io.valid && io.write, io.writeMask)
}
