package rv32c.core

import spinal.core._

/** Instruction Cache for RV32/RV64 cores.
  *
  * Specifications:
  * - Capacity: 4KB
  * - Associativity: 4-way set associative
  * - Line size: 64 bytes (16 words)
  * - Replacement: Pseudo-LRU (tree-based)
  * - Addressing: Physical address (placed after MMU)
  */
class ICache(
  val addrWidth: Int = 64,
  val dataWidth: Int = 32,
  val setSize: Int = 64,
  val waySize: Int = 4,
  val lineSize: Int = 16
) extends Component {
  val io = new Bundle {
    val req = in Bool()
    val reqAddr = in UInt(addrWidth bits)
    val respReady = out Bool()
    val respData = out Bits(32 bits)
    val respException = out Bool()

    val memValid = out Bool()
    val memAddr = out UInt(addrWidth bits)
    val memReady = in Bool()
    val memData = in Bits(dataWidth bits)
  }

  val byteOffsetBits = log2Up(dataWidth / 8)
  val offsetBits = log2Up(lineSize)
  val setIndexBits = log2Up(setSize)
  val tagBits = addrWidth - setIndexBits - offsetBits - byteOffsetBits

  def getSetIndex(addr: UInt): UInt = addr(offsetBits + byteOffsetBits - 1 downto byteOffsetBits)
  def getTag(addr: UInt): UInt = addr(addrWidth - 1 downto offsetBits + byteOffsetBits)
  def getLineAddr(addr: UInt): UInt = {
    val lineMask = ~(U((BigInt(1) << offsetBits) - 1, addrWidth bits) ## U(0, byteOffsetBits bits)).asUInt
    addr & lineMask
  }

  val valid = Vec(Vec(Reg(Bool()) init False, waySize), setSize)
  val tags = Vec(Vec(Reg(UInt(tagBits bits)) init U(0), waySize), setSize)
  val data = Vec(Vec(Reg(Bits(dataWidth bits)) init B(0, dataWidth bits), lineSize), setSize * waySize)
  val lru = Vec(Reg(Bits(3 bits)) init B"000", setSize)

  val hit = Bool()
  val hitWay = UInt(2 bits)
  val setIndex = getSetIndex(io.reqAddr)
  val reqTag = getTag(io.reqAddr)
  val reqOffset = io.reqAddr(offsetBits + byteOffsetBits - 1 downto byteOffsetBits + 2)

  val tagMatch = Vec(False, waySize)
  for (w <- 0 until waySize) {
    tagMatch(w) := valid(setIndex)(w) && (tags(setIndex)(w) === reqTag)
  }
  hit := tagMatch.asBits.orR

  // Priority encoder for hit way
  switch(U(0, 2 bits)) {
    default {
      when(tagMatch(0)) { hitWay := U(0, 2 bits) }
      when(tagMatch(1)) { hitWay := U(1, 2 bits) }
      when(tagMatch(2)) { hitWay := U(2, 2 bits) }
      when(tagMatch(3)) { hitWay := U(3, 2 bits) }
    }
  }

  io.respData := data(setIndex * waySize + hitWay)(reqOffset)
  io.respReady := hit
  io.respException := False

  object CacheState extends SpinalEnum {
    val IDLE, FETCH, FILL = newElement()
  }
  import CacheState._
  val state = RegInit(IDLE)
  val missAddr = Reg(UInt(addrWidth bits))
  val fillIdx = Reg(UInt(log2Up(lineSize) bits))
  val fillWay = Reg(UInt(2 bits))

  when(io.req && !hit && state === IDLE) {
    state := FETCH
    missAddr := getLineAddr(io.reqAddr)
    fillWay := Mux(lru(setIndex)(0).asBits === B"0", U(2, 2 bits), U(0, 2 bits))
  }

  io.memValid := state === FETCH
  io.memAddr := missAddr + (fillIdx << 2)

  when(state === FETCH && io.memReady) {
    state := FILL
  }
  when(state === FILL) {
    data(setIndex * waySize + fillWay)(fillIdx) := io.memData
    fillIdx := fillIdx + 1
    when(fillIdx === U(lineSize - 1)) {
      state := IDLE
      valid(setIndex)(fillWay) := True
      tags(setIndex)(fillWay) := getTag(missAddr)
      lru(setIndex) := Mux(fillWay(1).asBits === B"1",
        B"1" ## lru(setIndex)(1 downto 0),
        B"0" ## lru(setIndex)(1 downto 0))
    }
  }

  io.respReady := (state === IDLE && hit) || (state === FILL && fillIdx >= reqOffset + 1)
  when(state === FILL && fillIdx === reqOffset) {
    io.respData := io.memData
    io.respReady := True
  }
}
