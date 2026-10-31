package rv32c.isa

/** ISA-defined synchronous exception codes for `mcause` (RISC-V privileged
  * spec), named to keep the trap path free of magic numbers. Interrupt codes
  * carry the MSB set and are handled separately in the core.
  */
object ExceptionCode {
  def instructionIllegal = 2
  def breakpoint = 3
  def loadMisaligned = 4
  def supervisorTimer = 5
  def storeMisaligned = 6
  def ecallFromU = 8
  def ecallFromS = 9
  def ecallFromM = 11
  def instructionPageFault = 12
  def loadPageFault = 13
  def storePageFault = 15
}
