package rv32c.core

import spinal.core._

/** Instruction Cache (4KB, 4-way, 64B line). */
class ICache(
  val addrWidth: Int = 64,
  val setSize: Int = 64,
  val waySize: Int = 4,
  val lineSize: Int = 16
) extends Component {
  val io = new Bundle {
    val req = in Bool()
    val reqAddr = in UInt(addrWidth bits)
    val respReady = out Bool()
    val respData = out Bits(32 bits)
    val memValid = out Bool()
    val memAddr = out UInt(addrWidth bits)
    val memReady = in Bool()
    val memData = in Bits(32 bits)
  }

  val dataWidth = 32
  val byteOffsetBits = log2Up(dataWidth / 8)
  val offsetBits = log2Up(lineSize)
  val setIndexBits = log2Up(setSize)
  val tagBits = addrWidth - setIndexBits - offsetBits - byteOffsetBits

  val setIndex = io.reqAddr(offsetBits + byteOffsetBits - 1 downto byteOffsetBits)
  val reqTag = io.reqAddr(addrWidth - 1 downto offsetBits + byteOffsetBits)
  val reqOffset = io.reqAddr(offsetBits + byteOffsetBits - 1 downto byteOffsetBits + 2)

  val valid = Vec(RegInit(False), setSize * waySize)
  val tags = Vec(Reg(UInt(tagBits bits)), setSize * waySize)
  val lru = Vec(RegInit(U(0, 3 bits)), setSize)
  val data = Vec.fill(setSize * waySize * lineSize)(Reg(Bits(32 bits)))

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
  io.respReady := hit

  object State extends SpinalEnum { val IDLE, FETCH, FILL = newElement() }
  import State._
  val state = RegInit(IDLE)
  val missAddr = Reg(UInt(addrWidth bits))
  val fillIdx = Reg(UInt(log2Up(lineSize) bits))
  val fillWay = Reg(UInt(2 bits))

  when(io.req && !hit && state === IDLE) {
    state := FETCH
    missAddr := (io.reqAddr >> (offsetBits + byteOffsetBits)) << (offsetBits + byteOffsetBits)
    fillWay := Mux(lru(setIndex)(2 downto 1) === U"00", U(2), U(0))
  }

  io.memValid := state === FETCH
  io.memAddr := missAddr + (fillIdx << byteOffsetBits)

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

  io.respReady := hit || (state === FILL && fillIdx === reqOffset)
  when(state === FILL && fillIdx === reqOffset) {
    io.respData := io.memData
    io.respReady := True
  }
}
