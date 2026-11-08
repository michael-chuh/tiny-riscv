package rv32c.core

import spinal.core._

/** HPM (Hardware Performance Monitor) - RISC-V Performance Counters.
  *
  * Implements:
  * - mcycle/hpmcounter CSRs (0xB00-0xB1F)
  * - mcounteren for user-mode access control
  * - Basic performance events (cycles, instructions, loads, stores)
  *
  * Reference: RISC-V Privileged Spec v1.12
  */
class Hpm(
  val numCounters: Int = 16,
  val xlen: Int = 64
) extends Component {
  val io = new Bundle {
    // Control
    val enable = in Bool()
    
    // Performance events
    val cycleEvent = in Bool()      // Cycle counter
    val instrEvent = in Bool()      // Instruction retired
    val loadEvent = in Bool()       // Load access
    val storeEvent = in Bool()      // Store access
    val stallEvent = in Bool()      // Pipeline stall
    
    // CSR interface
    val csrAddr = in UInt(12 bits)
    val csrRead = in Bool()
    val csrWrite = in Bool()
    val csrDataIn = in Bits(xlen bits)
    val csrDataOut = out Bits(xlen bits)
    
    // User mode access control
    val mcounteren = out Bits(32 bits)
  }

  // mcycle (cycle counter)
  val mcycle = Reg(UInt(xlen bits)) init U(0, xlen bits)
  when(io.enable && io.cycleEvent) {
    mcycle := mcycle + 1
  }

  // mhpmevent (event selectors) - simplified
  val mhpmevent = Vec(Reg(Bits(xlen bits)), numCounters)

  // mhpcounter (hardware performance counters)
  val mhpmcounter = Vec(Reg(UInt(xlen bits)), numCounters)
  
  // Counter event mapping (simplified)
  // counter[0] = cycles (mcycle)
  // counter[1] = time (mirror of mtime)
  // counter[2] = instructions retired
  // counter[3] = dcache access
  // counter[4] = dcache miss
  // counter[5] = icache access
  // counter[6] = icache miss
  // counter[7+] = custom
  
  when(io.enable && io.instrEvent) {
    mhpmcounter(2) := mhpmcounter(2) + 1
  }
  when(io.enable && io.loadEvent) {
    mhpmcounter(3) := mhpmcounter(3) + 1
  }
  when(io.enable && io.storeEvent) {
    mhpmcounter(3) := mhpmcounter(3) + 1
  }
  when(io.enable && io.stallEvent) {
    mhpmcounter(7) := mhpmcounter(7) + 1
  }

  // mcounteren - user mode access control
  val mcounterenReg = RegInit(B(0, 32 bits))
  io.mcounteren := mcounterenReg

  // CSR address map
  val CSR_MCOUNTEREN = U(0x306, 12 bits)
  val CSR_MCYCLE = U(0xB00, 12 bits)
  val CSR_MHPMCOUNTER_BASE = U(0xB03, 12 bits)  // 3-31
  val CSR_MHPMEVENT_BASE = U(0x323, 12 bits)    // 3-31

  // CSR read
  io.csrDataOut := B(0, xlen bits)
  
  when(io.csrRead && io.enable) {
    switch(io.csrAddr) {
      is(CSR_MCOUNTEREN) {
        io.csrDataOut := (B(0, xlen - 32 bits) ## mcounterenReg).resized
      }
      is(CSR_MCYCLE) {
        io.csrDataOut := mcycle.asBits
      }
      default {
        // mhpcounter read
        when(io.csrAddr >= CSR_MHPMCOUNTER_BASE && 
             io.csrAddr < (CSR_MHPMCOUNTER_BASE + U(numCounters, 12 bits))) {
          val idx = (io.csrAddr - CSR_MHPMCOUNTER_BASE).resized
          io.csrDataOut := mhpmcounter(idx).asBits
        }
        // mhpmevent read
        when(io.csrAddr >= CSR_MHPMEVENT_BASE &&
             io.csrAddr < (CSR_MHPMEVENT_BASE + U(numCounters, 12 bits))) {
          val idx = (io.csrAddr - CSR_MHPMEVENT_BASE).resized
          io.csrDataOut := mhpmevent(idx)
        }
      }
    }
  }

  // CSR write
  when(io.csrWrite && io.enable) {
    switch(io.csrAddr) {
      is(CSR_MCOUNTEREN) {
        mcounterenReg := io.csrDataIn(31 downto 0)
      }
      is(CSR_MCYCLE) {
        mcycle := io.csrDataIn.asUInt
      }
      default {
        // mhpmevent write
        when(io.csrAddr >= CSR_MHPMEVENT_BASE &&
             io.csrAddr < (CSR_MHPMEVENT_BASE + U(numCounters, 12 bits))) {
          val idx = (io.csrAddr - CSR_MHPMEVENT_BASE).resized
          mhpmevent(idx) := io.csrDataIn
        }
        // mhpmcounter write
        when(io.csrAddr >= CSR_MHPMCOUNTER_BASE &&
             io.csrAddr < (CSR_MHPMCOUNTER_BASE + U(numCounters, 12 bits))) {
          val idx = (io.csrAddr - CSR_MHPMCOUNTER_BASE).resized
          mhpmcounter(idx) := io.csrDataIn.asUInt
        }
      }
    }
  }
}
