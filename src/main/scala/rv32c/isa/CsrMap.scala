package rv32c.isa

/** Metadata for one CSR implemented by the hart.
  *
  * `addr` is the 12-bit CSR number, `readOnly` marks CSRs where any write intent
  * (CSRRW/CSRRWI, or a masked set/clear that actually touches bits) is illegal,
  * and `minPriv` is the lowest privilege level from which the CSR may be
  * accessed. Supervisor CSRs are filtered in automatically when the
  * configuration's privilege stack contains S mode.
  */
case class CsrDef(addr: Int, name: String, readOnly: Boolean, minPriv: PrivMode,
    requiresFpu: Boolean = false, requiresSupervisor: Boolean = false,
    requiresZicntr: Boolean = false, isRv32Only: Boolean = false)

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
  val medeleg  = CsrDef(0x302, "medeleg",  readOnly = false, PrivMode.M, requiresSupervisor = true)
  val mideleg  = CsrDef(0x303, "mideleg",  readOnly = false, PrivMode.M, requiresSupervisor = true)
  val mcounteren = CsrDef(0x306, "mcounteren", readOnly = false, PrivMode.M, requiresZicntr = true)

  // ---- Supervisor-level CSRs (only present on an M/S/U hart) ----
  val sstatus  = CsrDef(0x100, "sstatus",  readOnly = false, PrivMode.S)
  val sie      = CsrDef(0x104, "sie",      readOnly = false, PrivMode.S)
  val stvec    = CsrDef(0x105, "stvec",    readOnly = false, PrivMode.S)
  val sscratch = CsrDef(0x140, "sscratch", readOnly = false, PrivMode.S)
  val sepc     = CsrDef(0x141, "sepc",     readOnly = false, PrivMode.S)
  val scause   = CsrDef(0x142, "scause",   readOnly = false, PrivMode.S)
  val stval    = CsrDef(0x143, "stval",    readOnly = false, PrivMode.S)
  val sip      = CsrDef(0x144, "sip",      readOnly = true,  PrivMode.S)
  val satp     = CsrDef(0x180, "satp",     readOnly = false, PrivMode.S)
  val scounteren = CsrDef(0x106, "scounteren", readOnly = false, PrivMode.S, requiresZicntr = true)

  // ---- Counters (Zicntr) ----
  // Machine counter aliases; writes replace the underlying 64-bit counter.
  val mcycle     = CsrDef(0xB00, "mcycle",     readOnly = false, PrivMode.M, requiresZicntr = true)
  val minstret   = CsrDef(0xB02, "minstret",   readOnly = false, PrivMode.M, requiresZicntr = true)
  val mcycleh    = CsrDef(0xB80, "mcycleh",    readOnly = false, PrivMode.M, requiresZicntr = true, isRv32Only = true)
  val minstreth  = CsrDef(0xB82, "minstreth",  readOnly = false, PrivMode.M, requiresZicntr = true, isRv32Only = true)
  // ---- User counters (Zicntr) ----
  // cycle/time/instret are read-only views of the hart counters; RV32 also
  // implements the high halves (cycleh/timeh/instreth), RV64 does not.
  val cycle    = CsrDef(0xC00, "cycle",    readOnly = true, PrivMode.U, requiresZicntr = true)
  val time     = CsrDef(0xC01, "time",     readOnly = true, PrivMode.U, requiresZicntr = true)
  val instret  = CsrDef(0xC02, "instret",  readOnly = true, PrivMode.U, requiresZicntr = true)
  val cycleh   = CsrDef(0xC80, "cycleh",   readOnly = true, PrivMode.U, requiresZicntr = true, isRv32Only = true)
  val timeh    = CsrDef(0xC81, "timeh",    readOnly = true, PrivMode.U, requiresZicntr = true, isRv32Only = true)
  val instreth = CsrDef(0xC82, "instreth", readOnly = true, PrivMode.U, requiresZicntr = true, isRv32Only = true)

  // ---- Floating-point CSRs (specs/fp-extension/requirements.md R2) ----
  // Non-privileged (U-accessible) and only present when the hart has an FPU.
  val fflags = CsrDef(0x001, "fflags", readOnly = false, PrivMode.U, requiresFpu = true)
  val frm    = CsrDef(0x002, "frm",    readOnly = false, PrivMode.U, requiresFpu = true)
  val fcsr   = CsrDef(0x003, "fcsr",   readOnly = false, PrivMode.U, requiresFpu = true)

  /** Every CSR this design family knows about. */
  val all: Seq[CsrDef] = Seq(
    mstatus, misa, mie, mtvec, mscratch, mepc, mcause, mtval, mip, mhartid,
    medeleg, mideleg, mcounteren,
    sstatus, sie, stvec, sscratch, sepc, scause, stval, sip, satp, scounteren,
    mcycle, minstret, mcycleh, minstreth,
    cycle, time, instret, cycleh, timeh, instreth,
    fflags, frm, fcsr
  )

  require(all.map(_.addr).distinct.size == all.size, "duplicate CSR address")

  val byAddr: Map[Int, CsrDef] = all.map(d => d.addr -> d).toMap

  /** CSRs accessible on a hart built from `isa`: a CSR is present when the hart
    * implements its minimum privilege level and, for FP CSRs, an FPU. */
  def implementedFor(isa: IsaConfig): Seq[CsrDef] =
    all.filter(d => isa.priv.modes.contains(d.minPriv) &&
      (!d.requiresFpu || isa.hasFpu) &&
      (!d.requiresSupervisor || isa.priv.hasSupervisor) &&
      (!d.requiresZicntr || isa.hasZicntr) &&
      (!d.isRv32Only || !isa.isRV64))

  /** Subset of `implementedFor` that rejects any write intent. */
  def readOnlyFor(isa: IsaConfig): Seq[CsrDef] =
    implementedFor(isa).filter(_.readOnly)
}
