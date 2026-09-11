package rv32c.isa

/** ISA-defined synchronous exception codes for `mcause` (RISC-V privileged
  * spec), named to keep the trap path free of magic numbers. Interrupt codes
  * carry the MSB set and are handled separately in the core.
  */
object ExceptionCode {
  def instructionIllegal = 2
  def breakpoint = 3
  def ecallFromU = 8
  def ecallFromS = 9
  def ecallFromM = 11
}
