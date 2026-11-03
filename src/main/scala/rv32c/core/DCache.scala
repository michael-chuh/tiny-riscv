package rv32c.core

import spinal.core._

/** Data Cache (4KB, 4-way, 64B line, write-back). */
class DCache(
  val addrWidth: Int = 64,
  val setSize: Int = 64,
  val waySize: Int = 4,
  val lineSize: Int = 8
) extends Component {
  val io = new Bundle {
    val req = in Bool()
    val reqWrite = in Bool()
    val reqAddr = in UInt(addrWidth bits)
    val reqData = in Bits(64 bits)
    val reqMask = in Bits(8 bits)
    val reqSize = in UInt(3 bits)
    val respReady = out Bool()
    val respData = out Bits(64 bits)
    val memValid = out Bool()
    val memWrite = out Bool()
    val memAddr = out UInt(addrWidth bits)
    val memData = out Bits(64 bits)
    val memMask = out Bits(8 bits)
    val memReady = in Bool()
  }

  val dataWidth = 64
  val byteOffsetBits = log2Up(dataWidth / 8)
  val offsetBits = log2Up(lineSize)
  val setIndexBits = log2Up(setSize)
  val tagBits = addrWidth - setIndexBits - offsetBits - byteOffsetBits

  val setIndex = io.reqAddr(offsetBits + byteOffsetBits - 1 downto byteOffsetBits)
  val reqTag = io.reqAddr(addrWidth - 1 downto offsetBits + byteOffsetBits)
  val reqOffset = io.reqAddr(offsetBits + byteOffsetBits - 1 downto byteOffsetBits + 3)

  val valid = Vec(RegInit(False), setSize * waySize)
  val tags = Vec(Reg(UInt(tagBits bits)), setSize * waySize)
  val dirty = Vec(RegInit(False), setSize * waySize)
  val lru = Vec(RegInit(U(0, 3 bits)), setSize)
  val data = Vec.fill(setSize * waySize * lineSize)(Reg(Bits(64 bits)))

  val baseIdx = setIndex * waySize
  val tagMatch = Vec(False, waySize)
  for (w <- 0 until waySize) {
    tagMatch(w) := valid(baseIdx + w) && (tags(baseIdx + w) === reqTag)
  }
  val hit = tagMatch.asBits.orR

  val hitWay = CombInit(U(0, 2 bits))
  when(tagMatch(0)) { hitWay := U(0) }
  when(tagMatch(1)) { hitWay := U(1) }
  when(tagMatch(2)) { hitWay := U(2) }
  when(tagMatch(3)) { hitWay := U(3) }

  val readIdx = (setIndex * waySize + hitWay) * lineSize + reqOffset
  io.respData := data(readIdx)
  io.respReady := hit && !io.reqWrite

  object State extends SpinalEnum { val IDLE, EVICT, FETCH, FILL = newElement() }
  import State._
  val state = RegInit(IDLE)
  val missAddr = Reg(UInt(addrWidth bits))
  val fillIdx = Reg(UInt(log2Up(lineSize) bits))
  val fillWay = Reg(UInt(2 bits))
  val evictWay = Reg(UInt(2 bits))

  evictWay := Mux(lru(setIndex)(2 downto 1) === U"00", U(2), U(0))

  when(io.req && !hit && state === IDLE) {
    state := Mux(dirty(baseIdx + evictWay), EVICT, FETCH)
    missAddr := (io.reqAddr >> (offsetBits + byteOffsetBits)) << (offsetBits + byteOffsetBits)
    fillWay := evictWay
  }
  when(io.req && hit && io.reqWrite && state === IDLE) {
    data(readIdx) := io.reqData
    dirty(baseIdx + hitWay) := True
  }

  io.memValid := state === EVICT || state === FETCH
  io.memWrite := state === EVICT
  io.memAddr := missAddr + (fillIdx << byteOffsetBits)
  io.memData := data((setIndex * waySize + evictWay) * lineSize + fillIdx)
  io.memMask := B(0xFF, 8 bits)

  when(state === EVICT && io.memReady) { state := FETCH }
  when(state === FETCH && io.memReady) { state := FILL }
  when(state === FILL) {
    val writeIdx = (setIndex * waySize + fillWay) * lineSize + fillIdx
    data(writeIdx) := io.memData
    fillIdx := fillIdx + 1
    when(fillIdx === U(lineSize - 1)) {
      state := IDLE
      valid(baseIdx + fillWay) := True
      tags(baseIdx + fillWay) := missAddr >> (offsetBits + byteOffsetBits)
      lru(setIndex) := Mux(fillWay(1), U"100", U"000")
    }
  }

  io.respReady := (state === IDLE && hit && !io.reqWrite) || (state === FILL)
}
