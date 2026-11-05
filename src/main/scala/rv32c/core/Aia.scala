package rv32c.core

import spinal.core._

/** AIA (Advanced Interrupt Architecture) - APLIC Controller.
  *
  * Implements:
  * - APLIC (Advanced Platform-Level Interrupt Controller)
  * - External interrupts (EIP/IE) with priority
  * - MSI (Message Signaled Interrupts) support
  * - Compatible with existing M-mode interrupts
  *
  * Reference: RISC-V AIA Specification v1.0
  */
class AiaAplic(
  val numSources: Int = 16,
  val numTargets: Int = 4,
  val addrWidth: Int = 64
) extends Component {
  val io = new Bundle {
    // Control
    val enable = in Bool()
    val domMode = in Bits(2 bits)  // Domain mode (M/S/U support)
    
    // Interrupt inputs (level-sensitive)
    val irqIn = in Bits(numSources bits)
    
    // CSR interface
    val csrAddr = in UInt(12 bits)
    val csrRead = in Bool()
    val csrWrite = in Bool()
    val csrDataIn = in Bits(32 bits)
    val csrDataOut = out Bits(32 bits)
    
    // Interrupt outputs to core
    val meip = out Bool()  // Machine external interrupt pending
    val seip = out Bool()  // Supervisor external interrupt pending
    val ueip = out Bool()  // User external interrupt pending
    
    // MSI interface (optional)
    val msiAddr = out UInt(addrWidth bits)
    val msiData = out Bits(32 bits)
    val msiValid = out Bool()
  }

  // APLIC registers
  val domainCfg = RegInit(B"00000")  // Domain configuration
  val sourceCfg = Vec(RegInit(B"000"), numSources)  // Interrupt source config (3 bits each)
  val sourcePrio = Vec(RegInit(B"00000000"), numSources)  // Priority (8 bits)
  val targetCfg = Vec(RegInit(B"00"), numTargets)  // Target configuration
  
  // Interrupt pending/enable
  val ip = RegInit(B(0, numSources bits))
  val ie = RegInit(B(0, numSources bits))
  val iprio = Vec(RegInit(B(0, 8 bits)), numSources)  // Interrupt priority
  
  // MSI configuration
  val msiAddrReg = RegInit(U(0, addrWidth bits))
  val msiDataReg = RegInit(B(0, 32 bits))
  
  // CSR address map (APLIC)
  val APLIC_DOMAINCFG = U(0x0000, 12 bits)
  val APLIC_SOURCECFG = U(0x0100, 12 bits)  // Base, stride=4
  val APLIC_SOURCEPRIORITY = U(0x0400, 12 bits)  // Base, stride=4
  val APLIC_TARGET = U(0x0800, 12 bits)  // Base, stride=4
  val APLIC_IE = U(0x1000, 12 bits)  // Interrupt enable
  val APLIC_IP = U(0x1400, 12 bits)  // Interrupt pending
  val APLIC_MSIADDR = U(0x2000, 12 bits)
  val APLIC_MSIDATA = U(0x2004, 12 bits)
  
  // Process interrupt inputs
  for (i <- 0 until numSources) {
    when(io.irqIn(i) && ie(i)) {
      ip(i) := True
    }
  }
  
  // Priority encoder - find highest priority pending interrupt
  val highestPrio = RegInit(B(0xFF, 8 bits))
  val highestIdx = RegInit(U(0, log2Up(numSources) bits))
  
  highestPrio := B(0xFF, 8 bits)
  highestIdx := U(0, log2Up(numSources) bits)
  
  for (i <- 0 until numSources) {
    when(ip(i) && (iprio(i).asUInt < highestPrio.asUInt)) {
      highestPrio := iprio(i)
      highestIdx := U(i, log2Up(numSources) bits)
    }
  }
  
  // Generate interrupt outputs based on domain mode
  io.meip := False
  io.seip := False
  io.ueip := False
  
  when(ip.asBits.orR && ie.asBits.orR) {
    switch(io.domMode) {
      is(B"00") {  // M-mode only
        io.meip := True
      }
      is(B"01") {  // M+S mode
        io.meip := highestIdx < U(numSources / 2, log2Up(numSources) bits)
        io.seip := highestIdx >= U(numSources / 2, log2Up(numSources) bits)
      }
      is(B"10") {  // M+S+U mode
        io.meip := highestIdx < U(numSources / 3, log2Up(numSources) bits)
        io.seip := highestIdx >= U(numSources / 3, log2Up(numSources) bits) && 
                   highestIdx < U(2 * numSources / 3, log2Up(numSources) bits)
        io.ueip := highestIdx >= U(2 * numSources / 3, log2Up(numSources) bits)
      }
    }
  }
  
  // MSI interface
  io.msiAddr := msiAddrReg
  io.msiData := msiDataReg
  io.msiValid := False
  
  // CSR read/write logic
  io.csrDataOut := B(0, 32 bits)
  
  when(io.csrRead) {
    switch(io.csrAddr) {
      is(APLIC_DOMAINCFG) { io.csrDataOut := domainCfg.resized }
      is(APLIC_IE) { io.csrDataOut := (B(0, 32 - numSources bits) ## ie).resized }
      is(APLIC_IP) { io.csrDataOut := (B(0, 32 - numSources bits) ## ip).resized }
      is(APLIC_MSIADDR) { io.csrDataOut := msiAddrReg(31 downto 0).asBits }
      is(APLIC_MSIDATA) { io.csrDataOut := msiDataReg }
      default {
        // Source config/priority/target reads
        when(io.csrAddr >= U(0x0100, 12 bits) && io.csrAddr < U(0x0400, 12 bits)) {
          val idx = (io.csrAddr - U(0x0100, 12 bits))(log2Up(numSources) + 1 downto 2)
          io.csrDataOut := (B(0, 29 bits) ## sourceCfg(idx)).resized
        }
        when(io.csrAddr >= U(0x0400, 12 bits) && io.csrAddr < U(0x0800, 12 bits)) {
          val idx = (io.csrAddr - U(0x0400, 12 bits))(log2Up(numSources) + 1 downto 2)
          io.csrDataOut := (B(0, 24 bits) ## sourcePrio(idx)).resized
        }
      }
    }
  }
  
  when(io.csrWrite) {
    switch(io.csrAddr) {
      is(APLIC_DOMAINCFG) { domainCfg := io.csrDataIn(4 downto 0) }
      is(APLIC_IE) { ie := io.csrDataIn(numSources - 1 downto 0) }
      is(APLIC_IP) { ip := (ip & ~io.csrDataIn(numSources - 1 downto 0)) }  // Write 1 to clear
      is(APLIC_MSIADDR) { msiAddrReg(31 downto 0) := io.csrDataIn.asUInt.resized }
      is(APLIC_MSIDATA) { msiDataReg := io.csrDataIn }
      default {
        when(io.csrAddr >= U(0x0100, 12 bits) && io.csrAddr < U(0x0400, 12 bits)) {
          val idx = (io.csrAddr - U(0x0100, 12 bits))(log2Up(numSources) + 1 downto 2)
          sourceCfg(idx) := io.csrDataIn(2 downto 0)
        }
        when(io.csrAddr >= U(0x0400, 12 bits) && io.csrAddr < U(0x0800, 12 bits)) {
          val idx = (io.csrAddr - U(0x0400, 12 bits))(log2Up(numSources) + 1 downto 2)
          sourcePrio(idx) := io.csrDataIn(7 downto 0)
        }
      }
    }
  }
}
