package rv32c.sim

import spinal.core._
import rv32c._

/** Minimal simulation harness: RiscvCore + instruction RAM + data RAM.
  *
  * The program is loaded into the instruction memory at reset, then the core
  * starts fetching from the configured reset vector. Both memories are
  * zero-wait-state (combinational read), which models an ideal system for
  * functional testing of the core pipeline.
  */
class CpuTb(config: CoreConfig, program: Seq[Long]) extends Component {
  val io = new Bundle {
    val timerInterrupt = in Bool()
    val debugPc = out UInt(config.xlen bits)
    val debugRegs = out Vec(Bits(config.xlen bits), 32)
    val debugMepc = out UInt(config.xlen bits)
    val debugMcause = out Bits(config.xlen bits)
    val debugMode = out UInt(2 bits)
  }

  val core = new RiscvCore(config)
  core.io.timerInterrupt := io.timerInterrupt

  val iMem = new SyncRamSim(config.xlen, 1 << 12)
  val dMem = new SyncRamSim(config.xlen, 1 << 12)

  // ---- Instruction bus: core as master, iMem as slave ----
  iMem.io.valid := True
  iMem.io.write := False
  iMem.io.address := core.io.iBus.pc
  iMem.io.writeData := B(0, config.xlen bits)
  iMem.io.writeMask := B(0, config.xlen / 8 bits)
  core.io.iBus.ready := iMem.io.ready
  core.io.iBus.instruction := iMem.io.readData

  // ---- Data bus: core as master, dMem as slave ----
  dMem.io.valid := core.io.dBus.valid
  dMem.io.write := core.io.dBus.write
  dMem.io.address := core.io.dBus.address
  dMem.io.writeData := core.io.dBus.writeData
  dMem.io.writeMask := core.io.dBus.writeMask
  core.io.dBus.ready := dMem.io.ready
  core.io.dBus.readData := dMem.io.readData

  // ---- Load program into instruction memory ----
  val programWords = Array.fill[BigInt](iMem.mem.wordCount)(BigInt(0))
  for ((instr, i) <- program.zipWithIndex) {
    if (i < programWords.length) programWords(i) = BigInt(instr)
  }
  iMem.mem.initBigInt(programWords.toSeq)

  io.debugPc := core.io.debugPc
  io.debugRegs := core.io.debugRegs
  io.debugMepc := core.io.debugMepc
  io.debugMcause := core.io.debugMcause
  io.debugMode := core.io.debugMode
}
