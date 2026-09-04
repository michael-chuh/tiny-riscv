package rv32c.bus

import spinal.core._
import spinal.lib._

case class IBusInterface(xlen: Int) extends Bundle with IMasterSlave {
  val valid = Bool()
  val pc = UInt(xlen bits)
  val ready = Bool()
  val instruction = Bits(32 bits)

  override def asMaster(): Unit = {
    out(valid, pc)
    in(ready, instruction)
  }
}

case class DBusInterface(xlen: Int) extends Bundle with IMasterSlave {
  val valid = Bool()
  val write = Bool()
  val size = UInt(2 bits)
  val address = UInt(xlen bits)
  val writeData = Bits(xlen bits)
  val writeMask = Bits(xlen / 8 bits)
  val ready = Bool()
  val readData = Bits(xlen bits)

  override def asMaster(): Unit = {
    out(valid, write, size, address, writeData, writeMask)
    in(ready, readData)
  }
}
