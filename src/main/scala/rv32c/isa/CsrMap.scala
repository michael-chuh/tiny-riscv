package rv32c.isa

/** Metadata for one CSR implemented by the hart.
  *
  * `addr` is the 12-bit CSR number, `readOnly` marks CSRs where any write intent
  * (CSRRW/CSRRWI, or a masked set/clear that actually touches bits) is illegal,
  * and `minPriv` is the lowest privilege level from which the CSR may be
  * accessed. The current RTL implements machine CSRs only, so every entry is
  * `PrivMode.M`; supervisor/hypervisor CSRs are a roadmap item and would be
  * filtered in automatically once `isa.priv` carries the mode.
  */
case class CsrDef(addr: Int, name: String, readOnly: Boolean, minPriv: PrivMode)

/** Single source of truth for which CSRs exist and how they may be accessed.
  *
  * Both the CSR file read path and the EX-stage legality checks derive their
  * address sets from here, so adding a CSR is a one-line change instead of
  * editing parallel hard-coded lists.
  */
object CsrMap {

  // ---- Machine-level CSRs (specs/zicsr-exceptions/requirements.md R2) ----
  val mstatus  = CsrDef(0x300, "mstatus",  readOnly = false, PrivMode.M)
  val misa     = CsrDef(0x301, "misa",     readOnly = true,  PrivMode.M)
  val mie      = CsrDef(0x304, "mie",      readOnly = false, PrivMode.M)
  val mtvec    = CsrDef(0x305, "mtvec",    readOnly = false, PrivMode.M)
  val mscratch = CsrDef(0x340, "mscratch", readOnly = false, PrivMode.M)
  val mepc     = CsrDef(0x341, "mepc",     readOnly = false, PrivMode.M)
  val mcause   = CsrDef(0x342, "mcause",   readOnly = false, PrivMode.M)
  val mtval    = CsrDef(0x343, "mtval",    readOnly = false, PrivMode.M)
  val mip      = CsrDef(0x344, "mip",      readOnly = true,  PrivMode.M)
  val mhartid  = CsrDef(0xF14, "mhartid",  readOnly = true,  PrivMode.M)

  /** Every CSR this design family knows about. */
  val all: Seq[CsrDef] = Seq(
    mstatus, misa, mie, mtvec, mscratch, mepc, mcause, mtval, mip, mhartid
  )

  require(all.map(_.addr).distinct.size == all.size, "duplicate CSR address")

  val byAddr: Map[Int, CsrDef] = all.map(d => d.addr -> d).toMap

  /** CSRs accessible on a hart built from `isa`: a CSR is present when the hart
    * implements its minimum privilege level. */
  def implementedFor(isa: IsaConfig): Seq[CsrDef] =
    all.filter(d => isa.priv.modes.contains(d.minPriv))

  /** Subset of `implementedFor` that rejects any write intent. */
  def readOnlyFor(isa: IsaConfig): Seq[CsrDef] =
    implementedFor(isa).filter(_.readOnly)
}
