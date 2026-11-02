package rv32c.core

import spinal.core._

/** Data Cache for RV32/RV64 cores.
  *
  * Specifications:
  * - Capacity: 4KB
  * - Associativity: 4-way set associative
  * - Line size: 64 bytes (8 dwords)
  * - Replacement: Pseudo-LRU (tree-based)
  * - Write policy: Write-back with write-allocate
  * - Addressing: Physical address (placed after MMU)
  */
class DCache(
  val addrWidth: Int = 64,
  val dataWidth: Int = 64,
  val setSize: Int = 64,
  val waySize: Int = 4,
  val lineSize: Int = 8
) extends Component {
  val io = new Bundle {
    val req = in Bool()
    val reqWrite = in Bool()
    val reqAddr = in UInt(addrWidth bits)
    val reqData = in Bits(dataWidth bits)
    val reqMask = in Bits(dataWidth / 8 bits)
    val reqSize = in UInt(3 bits)
    val respReady = out Bool()
    val respData = out Bits(dataWidth bits)
    val respException = out Bool()

    val memValid = out Bool()
    val memWrite = out Bool()
    val memAddr = out UInt(addrWidth bits)
    val memData = out Bits(dataWidth bits)
    val memMask = out Bits(dataWidth / 8 bits)
    val memReady = in Bool()
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
  val dirty = Vec(Vec(Reg(Bool()) init False, waySize), setSize)
  val data = Vec(Vec(Reg(Bits(dataWidth bits)) init B(0, dataWidth bits), lineSize), setSize * waySize)
  val lru = Vec(Reg(Bits(3 bits)) init B"000", setSize)

  val setIndex = getSetIndex(io.reqAddr)
  val reqTag = getTag(io.reqAddr)
  val tagMatch = Vec(False, waySize)
  for (w <- 0 until waySize) {
    tagMatch(w) := valid(setIndex)(w) && (tags(setIndex)(w) === reqTag)
  }
  val hit = tagMatch.asBits.orR

  val hitWay = UInt(2 bits)
  switch(U(0, 2 bits)) {
    default {
      when(tagMatch(0)) { hitWay := U(0, 2 bits) }
      when(tagMatch(1)) { hitWay := U(1, 2 bits) }
      when(tagMatch(2)) { hitWay := U(2, 2 bits) }
      when(tagMatch(3)) { hitWay := U(3, 2 bits) }
    }
  }

  object CacheState extends SpinalEnum {
    val IDLE, EVICT, FETCH, FILL = newElement()
  }
  import CacheState._
  val state = RegInit(IDLE)
  val missAddr = Reg(UInt(addrWidth bits))
  val fillIdx = Reg(UInt(log2Up(lineSize) bits))
  val fillWay = Reg(UInt(2 bits))
  val evictWay = Reg(UInt(2 bits))

  evictWay := Mux(lru(setIndex)(0).asBits === B"0", U(2, 2 bits), U(0, 2 bits))

  when(io.req && !hit && state === IDLE) {
    state := Mux(dirty(setIndex)(evictWay), CacheState.EVICT, CacheState.FETCH)
    missAddr := getLineAddr(io.reqAddr)
    fillWay := evictWay
  }
  when(io.req && hit && io.reqWrite && state === IDLE) {
    data(setIndex * waySize + hitWay)(io.reqAddr(offsetBits - 1 downto byteOffsetBits)) := io.reqData
    dirty(setIndex)(hitWay) := True
  }

  io.memValid := state === CacheState.EVICT || state === CacheState.FETCH
  io.memWrite := state === CacheState.EVICT
  io.memAddr := missAddr + (fillIdx << log2Up(dataWidth / 8))
  io.memData := data(setIndex * waySize + evictWay)(fillIdx)
  io.memMask := B((BigInt(1) << (dataWidth / 8)) - 1, dataWidth / 8 bits)

  when(state === CacheState.EVICT && io.memReady) {
    state := CacheState.FETCH
  }
  when(state === CacheState.FETCH && io.memReady) {
    state := CacheState.FILL
  }
  when(state === CacheState.FILL) {
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

  io.respReady := (state === IDLE && hit && !io.reqWrite) || (state === CacheState.FILL && fillIdx >= io.reqAddr(offsetBits - 1 downto byteOffsetBits) + 1)
  io.respData := Mux(state === IDLE,
    data(setIndex * waySize + hitWay)(io.reqAddr(offsetBits - 1 downto byteOffsetBits)),
    io.memData)
  io.respException := False
}
