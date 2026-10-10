// Generator : SpinalHDL v1.14.2    git head : 78f29dc66110fc099a777992b6daa2f803ab445e
// Component : RiscvCore64F
// Git hash  : 1b09f33b8a48a8760471c5ca3293a4221c6c4fdd

`timescale 1ns/1ps

module RiscvCore64F (
  output wire          io_iBus_valid,
  output wire [63:0]   io_iBus_pc,
  input  wire          io_iBus_ready,
  input  wire [31:0]   io_iBus_instruction,
  output wire          io_dBus_valid,
  output wire          io_dBus_write,
  output wire [1:0]    io_dBus_size,
  output wire [63:0]   io_dBus_address,
  output reg  [63:0]   io_dBus_writeData,
  output reg  [7:0]    io_dBus_writeMask,
  input  wire          io_dBus_ready,
  input  wire [63:0]   io_dBus_readData,
  input  wire          io_timerInterrupt,
  output wire [63:0]   io_debugPc,
  output wire [63:0]   io_debugRegs_0,
  output wire [63:0]   io_debugRegs_1,
  output wire [63:0]   io_debugRegs_2,
  output wire [63:0]   io_debugRegs_3,
  output wire [63:0]   io_debugRegs_4,
  output wire [63:0]   io_debugRegs_5,
  output wire [63:0]   io_debugRegs_6,
  output wire [63:0]   io_debugRegs_7,
  output wire [63:0]   io_debugRegs_8,
  output wire [63:0]   io_debugRegs_9,
  output wire [63:0]   io_debugRegs_10,
  output wire [63:0]   io_debugRegs_11,
  output wire [63:0]   io_debugRegs_12,
  output wire [63:0]   io_debugRegs_13,
  output wire [63:0]   io_debugRegs_14,
  output wire [63:0]   io_debugRegs_15,
  output wire [63:0]   io_debugRegs_16,
  output wire [63:0]   io_debugRegs_17,
  output wire [63:0]   io_debugRegs_18,
  output wire [63:0]   io_debugRegs_19,
  output wire [63:0]   io_debugRegs_20,
  output wire [63:0]   io_debugRegs_21,
  output wire [63:0]   io_debugRegs_22,
  output wire [63:0]   io_debugRegs_23,
  output wire [63:0]   io_debugRegs_24,
  output wire [63:0]   io_debugRegs_25,
  output wire [63:0]   io_debugRegs_26,
  output wire [63:0]   io_debugRegs_27,
  output wire [63:0]   io_debugRegs_28,
  output wire [63:0]   io_debugRegs_29,
  output wire [63:0]   io_debugRegs_30,
  output wire [63:0]   io_debugRegs_31,
  output wire [63:0]   io_debugMepc,
  output wire [63:0]   io_debugMcause,
  output wire [1:0]    io_debugMode,
  input  wire          clk,
  input  wire          reset
);
  localparam AluOp_ADD = 7'd0;
  localparam AluOp_SUB = 7'd1;
  localparam AluOp_SLL_1 = 7'd2;
  localparam AluOp_SLT = 7'd3;
  localparam AluOp_SLTU = 7'd4;
  localparam AluOp_XOR_1 = 7'd5;
  localparam AluOp_SRL_1 = 7'd6;
  localparam AluOp_SRA_1 = 7'd7;
  localparam AluOp_OR_1 = 7'd8;
  localparam AluOp_AND_1 = 7'd9;
  localparam AluOp_ADDW = 7'd10;
  localparam AluOp_SUBW = 7'd11;
  localparam AluOp_SLLW = 7'd12;
  localparam AluOp_SRLW = 7'd13;
  localparam AluOp_SRAW = 7'd14;
  localparam AluOp_MUL = 7'd15;
  localparam AluOp_MULH = 7'd16;
  localparam AluOp_MULHSU = 7'd17;
  localparam AluOp_MULHU = 7'd18;
  localparam AluOp_DIV = 7'd19;
  localparam AluOp_DIVU = 7'd20;
  localparam AluOp_REM_1 = 7'd21;
  localparam AluOp_REMU = 7'd22;
  localparam AluOp_MULW = 7'd23;
  localparam AluOp_DIVW = 7'd24;
  localparam AluOp_DIVUW = 7'd25;
  localparam AluOp_REMW = 7'd26;
  localparam AluOp_REMUW = 7'd27;
  localparam AluOp_ANDN = 7'd28;
  localparam AluOp_ORN = 7'd29;
  localparam AluOp_XNOR_1 = 7'd30;
  localparam AluOp_CLZ = 7'd31;
  localparam AluOp_CTZ = 7'd32;
  localparam AluOp_CPOP = 7'd33;
  localparam AluOp_SEXTB = 7'd34;
  localparam AluOp_SEXTH = 7'd35;
  localparam AluOp_ZEXTH = 7'd36;
  localparam AluOp_ORCB = 7'd37;
  localparam AluOp_REV8 = 7'd38;
  localparam AluOp_ROL_1 = 7'd39;
  localparam AluOp_ROR_1 = 7'd40;
  localparam AluOp_MIN = 7'd41;
  localparam AluOp_MINU = 7'd42;
  localparam AluOp_MAX = 7'd43;
  localparam AluOp_MAXU = 7'd44;
  localparam AluOp_BSET = 7'd45;
  localparam AluOp_BCLR = 7'd46;
  localparam AluOp_BINV = 7'd47;
  localparam AluOp_BEXT = 7'd48;
  localparam AluOp_SH1ADD = 7'd49;
  localparam AluOp_SH2ADD = 7'd50;
  localparam AluOp_SH3ADD = 7'd51;
  localparam AluOp_ADDUW = 7'd52;
  localparam AluOp_SH1ADDUW = 7'd53;
  localparam AluOp_SH2ADDUW = 7'd54;
  localparam AluOp_SH3ADDUW = 7'd55;
  localparam AluOp_SLLIUW = 7'd56;
  localparam AluOp_CLMUL = 7'd57;
  localparam AluOp_CLMULH = 7'd58;
  localparam AluOp_CLMULR = 7'd59;
  localparam AluOp_CLZW = 7'd60;
  localparam AluOp_CTZW = 7'd61;
  localparam AluOp_CPOPW = 7'd62;
  localparam AluOp_ROLW = 7'd63;
  localparam AluOp_RORW = 7'd64;
  localparam BranchOp_NONE = 3'd0;
  localparam BranchOp_BEQ = 3'd1;
  localparam BranchOp_BNE = 3'd2;
  localparam BranchOp_BLT = 3'd3;
  localparam BranchOp_BGE = 3'd4;
  localparam BranchOp_BLTU = 3'd5;
  localparam BranchOp_BGEU = 3'd6;
  localparam CsrOp_NONE = 2'd0;
  localparam CsrOp_WRITE = 2'd1;
  localparam CsrOp_SET = 2'd2;
  localparam CsrOp_CLEAR = 2'd3;
  localparam SysOp_NONE = 3'd0;
  localparam SysOp_ECALL = 3'd1;
  localparam SysOp_EBREAK = 3'd2;
  localparam SysOp_MRET = 3'd3;
  localparam SysOp_WFI = 3'd4;
  localparam SysOp_ILLEGAL = 3'd5;

  wire                regFile_io_writeEnable;
  wire       [31:0]   fpRegFile_io_writeData;
  wire                fpRegFile_io_writeEnable;
  wire       [63:0]   fpUnit32_io_a;
  wire       [63:0]   fpUnit32_io_b;
  wire       [63:0]   fpUnit32_io_c;
  wire                csrFile_1_io_csrWe;
  wire       [63:0]   csrFile_1_io_trapEpc;
  wire       [63:0]   csrFile_1_io_trapCause;
  wire       [63:0]   csrFile_1_io_trapTval;
  wire                csrFile_1_io_fpDirty;
  wire                csrFile_1_io_fpFlagsWe;
  wire                decoder_1_io_output_regWrite;
  wire                decoder_1_io_output_aluSrc;
  wire       [2:0]    decoder_1_io_output_wbSel;
  wire                decoder_1_io_output_branch;
  wire                decoder_1_io_output_jump;
  wire                decoder_1_io_output_jalr;
  wire       [6:0]    decoder_1_io_output_aluOp;
  wire       [2:0]    decoder_1_io_output_branchType;
  wire       [1:0]    decoder_1_io_output_aluASrc;
  wire                decoder_1_io_output_memRead;
  wire                decoder_1_io_output_memWrite;
  wire       [1:0]    decoder_1_io_output_memSize;
  wire                decoder_1_io_output_memSign;
  wire                decoder_1_io_output_atomic;
  wire                decoder_1_io_output_isLr;
  wire                decoder_1_io_output_isSc;
  wire       [4:0]    decoder_1_io_output_amoOp;
  wire                decoder_1_io_output_fp;
  wire                decoder_1_io_output_fpWrite;
  wire                decoder_1_io_output_fpLoad;
  wire                decoder_1_io_output_fpStore;
  wire                decoder_1_io_output_fpIntRd;
  wire       [5:0]    decoder_1_io_output_fpOp;
  wire       [2:0]    decoder_1_io_output_fpRm;
  wire                decoder_1_io_output_fpFmt;
  wire       [4:0]    decoder_1_io_output_rs3;
  wire       [4:0]    decoder_1_io_output_rs1;
  wire       [4:0]    decoder_1_io_output_rs2;
  wire       [4:0]    decoder_1_io_output_rd;
  wire       [63:0]   decoder_1_io_output_imm;
  wire                decoder_1_io_output_illegal;
  wire       [1:0]    decoder_1_io_output_csrOp;
  wire       [11:0]   decoder_1_io_output_csrAddr;
  wire                decoder_1_io_output_csrImm;
  wire                decoder_1_io_output_csrWe;
  wire       [2:0]    decoder_1_io_output_sysOp;
  wire                decoder_1_io_output_valid;
  wire       [63:0]   regFile_io_rs1Data;
  wire       [63:0]   regFile_io_rs2Data;
  wire       [63:0]   regFile_io_debugRegs_0;
  wire       [63:0]   regFile_io_debugRegs_1;
  wire       [63:0]   regFile_io_debugRegs_2;
  wire       [63:0]   regFile_io_debugRegs_3;
  wire       [63:0]   regFile_io_debugRegs_4;
  wire       [63:0]   regFile_io_debugRegs_5;
  wire       [63:0]   regFile_io_debugRegs_6;
  wire       [63:0]   regFile_io_debugRegs_7;
  wire       [63:0]   regFile_io_debugRegs_8;
  wire       [63:0]   regFile_io_debugRegs_9;
  wire       [63:0]   regFile_io_debugRegs_10;
  wire       [63:0]   regFile_io_debugRegs_11;
  wire       [63:0]   regFile_io_debugRegs_12;
  wire       [63:0]   regFile_io_debugRegs_13;
  wire       [63:0]   regFile_io_debugRegs_14;
  wire       [63:0]   regFile_io_debugRegs_15;
  wire       [63:0]   regFile_io_debugRegs_16;
  wire       [63:0]   regFile_io_debugRegs_17;
  wire       [63:0]   regFile_io_debugRegs_18;
  wire       [63:0]   regFile_io_debugRegs_19;
  wire       [63:0]   regFile_io_debugRegs_20;
  wire       [63:0]   regFile_io_debugRegs_21;
  wire       [63:0]   regFile_io_debugRegs_22;
  wire       [63:0]   regFile_io_debugRegs_23;
  wire       [63:0]   regFile_io_debugRegs_24;
  wire       [63:0]   regFile_io_debugRegs_25;
  wire       [63:0]   regFile_io_debugRegs_26;
  wire       [63:0]   regFile_io_debugRegs_27;
  wire       [63:0]   regFile_io_debugRegs_28;
  wire       [63:0]   regFile_io_debugRegs_29;
  wire       [63:0]   regFile_io_debugRegs_30;
  wire       [63:0]   regFile_io_debugRegs_31;
  wire       [31:0]   fpRegFile_io_rs1Data;
  wire       [31:0]   fpRegFile_io_rs2Data;
  wire       [31:0]   fpRegFile_io_rs3Data;
  wire       [31:0]   fpRegFile_io_debugRegs_0;
  wire       [31:0]   fpRegFile_io_debugRegs_1;
  wire       [31:0]   fpRegFile_io_debugRegs_2;
  wire       [31:0]   fpRegFile_io_debugRegs_3;
  wire       [31:0]   fpRegFile_io_debugRegs_4;
  wire       [31:0]   fpRegFile_io_debugRegs_5;
  wire       [31:0]   fpRegFile_io_debugRegs_6;
  wire       [31:0]   fpRegFile_io_debugRegs_7;
  wire       [31:0]   fpRegFile_io_debugRegs_8;
  wire       [31:0]   fpRegFile_io_debugRegs_9;
  wire       [31:0]   fpRegFile_io_debugRegs_10;
  wire       [31:0]   fpRegFile_io_debugRegs_11;
  wire       [31:0]   fpRegFile_io_debugRegs_12;
  wire       [31:0]   fpRegFile_io_debugRegs_13;
  wire       [31:0]   fpRegFile_io_debugRegs_14;
  wire       [31:0]   fpRegFile_io_debugRegs_15;
  wire       [31:0]   fpRegFile_io_debugRegs_16;
  wire       [31:0]   fpRegFile_io_debugRegs_17;
  wire       [31:0]   fpRegFile_io_debugRegs_18;
  wire       [31:0]   fpRegFile_io_debugRegs_19;
  wire       [31:0]   fpRegFile_io_debugRegs_20;
  wire       [31:0]   fpRegFile_io_debugRegs_21;
  wire       [31:0]   fpRegFile_io_debugRegs_22;
  wire       [31:0]   fpRegFile_io_debugRegs_23;
  wire       [31:0]   fpRegFile_io_debugRegs_24;
  wire       [31:0]   fpRegFile_io_debugRegs_25;
  wire       [31:0]   fpRegFile_io_debugRegs_26;
  wire       [31:0]   fpRegFile_io_debugRegs_27;
  wire       [31:0]   fpRegFile_io_debugRegs_28;
  wire       [31:0]   fpRegFile_io_debugRegs_29;
  wire       [31:0]   fpRegFile_io_debugRegs_30;
  wire       [31:0]   fpRegFile_io_debugRegs_31;
  wire       [63:0]   fpUnit32_io_result;
  wire       [4:0]    fpUnit32_io_flags;
  wire       [63:0]   csrFile_1_io_rdData;
  wire       [1:0]    csrFile_1_io_curMode;
  wire                csrFile_1_io_mstatusMie;
  wire       [1:0]    csrFile_1_io_mstatusMpp;
  wire       [1:0]    csrFile_1_io_mstatusFs;
  wire       [2:0]    csrFile_1_io_frm;
  wire                csrFile_1_io_mieMtie;
  wire       [63:0]   csrFile_1_io_mtvec;
  wire       [63:0]   csrFile_1_io_mepc;
  wire       [63:0]   csrFile_1_io_debugMepc;
  wire       [63:0]   csrFile_1_io_debugMcause;
  wire       [1:0]    csrFile_1_io_debugMode;
  wire       [63:0]   alu_1_io_result;
  wire       [31:0]   _zz_fpFwdRs1_1;
  wire       [31:0]   _zz_fpFwdRs2;
  wire       [31:0]   _zz_fpFwdRs3;
  wire       [63:0]   _zz_aluResult;
  wire       [63:0]   _zz_csrWrDataEx;
  wire       [63:0]   _zz_branchCond;
  wire       [63:0]   _zz_branchCond_1;
  wire       [63:0]   _zz_branchCond_2;
  wire       [63:0]   _zz_branchCond_3;
  wire       [63:0]   _zz_ctrlTarget;
  wire       [6:0]    _zz_divInEx;
  wire       [6:0]    _zz_divInEx_1;
  wire                _zz_csrImplemented;
  wire                _zz_csrImplemented_1;
  wire       [11:0]   _zz_csrImplemented_2;
  wire                _zz_csrPrivIllegal;
  wire                _zz_csrPrivIllegal_1;
  wire                _zz_csrPrivIllegal_2;
  wire       [1:0]    _zz_csrPrivIllegal_3;
  wire       [3:0]    _zz_exTrapCause;
  wire       [63:0]   _zz_exTrapTval;
  wire       [63:0]   _zz_io_a;
  wire       [63:0]   _zz_fpToIntResult;
  wire       [31:0]   _zz_fpToIntResult_1;
  wire       [63:0]   _zz_pcReg;
  wire       [190:0]  _zz_io_dBus_writeData;
  wire       [6:0]    _zz_io_dBus_writeData_1;
  wire       [7:0]    _zz_io_dBus_writeMask;
  wire       [14:0]   _zz_io_dBus_writeMask_1;
  wire       [190:0]  _zz_io_dBus_writeData_2;
  wire       [6:0]    _zz_io_dBus_writeData_3;
  wire       [7:0]    _zz_io_dBus_writeMask_2;
  wire       [14:0]   _zz_io_dBus_writeMask_3;
  wire       [190:0]  _zz_io_dBus_writeData_4;
  wire       [6:0]    _zz_io_dBus_writeData_5;
  wire       [7:0]    _zz_io_dBus_writeMask_4;
  wire       [14:0]   _zz_io_dBus_writeMask_5;
  wire       [63:0]   _zz__zz_loadResult;
  wire       [6:0]    _zz__zz_loadResult_1;
  wire       [63:0]   _zz_loadResult_3;
  wire       [7:0]    _zz_loadResult_4;
  wire       [63:0]   _zz_loadResult_5;
  wire       [63:0]   _zz__zz_loadResult_1_1;
  wire       [6:0]    _zz__zz_loadResult_1_2;
  wire       [63:0]   _zz_loadResult_6;
  wire       [15:0]   _zz_loadResult_7;
  wire       [63:0]   _zz_loadResult_8;
  wire       [63:0]   _zz__zz_loadResult_2;
  wire       [6:0]    _zz__zz_loadResult_2_1;
  wire       [63:0]   _zz_loadResult_9;
  wire       [31:0]   _zz_loadResult_10;
  wire       [63:0]   _zz_loadResult_11;
  wire       [1:0]    MODE_U;
  wire       [1:0]    MODE_M;
  reg        [63:0]   pcReg;
  wire                mis32;
  wire       [15:0]   hiReg;
  wire                mis32Start;
  wire                mis32Stall;
  wire       [31:0]   fetchInstr;
  wire       [2:0]    fetchLen;
  wire                fetchCompressed;
  reg                 ifId_valid;
  reg        [63:0]   ifId_pc;
  reg        [31:0]   ifId_instruction;
  reg                 ifId_compressed;
  reg                 idEx_valid;
  reg        [63:0]   idEx_pc;
  reg                 idEx_compressed;
  reg                 idEx_regWrite;
  reg                 idEx_aluSrc;
  reg        [2:0]    idEx_wbSel;
  reg                 idEx_branch;
  reg                 idEx_jump;
  reg                 idEx_jalr;
  reg        [6:0]    idEx_aluOp;
  reg        [2:0]    idEx_branchType;
  reg        [1:0]    idEx_aluASrc;
  reg                 idEx_memRead;
  reg                 idEx_memWrite;
  reg        [1:0]    idEx_memSize;
  reg                 idEx_memSign;
  reg                 idEx_atomic;
  reg                 idEx_isLr;
  reg                 idEx_isSc;
  reg        [4:0]    idEx_amoOp;
  reg                 idEx_fp;
  reg                 idEx_fpWrite;
  reg                 idEx_fpLoad;
  reg                 idEx_fpStore;
  reg                 idEx_fpIntRd;
  reg        [5:0]    idEx_fpOp;
  reg        [2:0]    idEx_fpRm;
  reg                 idEx_fpFmt;
  reg        [4:0]    idEx_rs1;
  reg        [4:0]    idEx_rs2;
  reg        [4:0]    idEx_rs3;
  reg        [4:0]    idEx_rd;
  reg        [63:0]   idEx_imm;
  reg                 idEx_illegal;
  reg        [1:0]    idEx_csrOp;
  reg                 idEx_csrImm;
  reg        [11:0]   idEx_csrAddr;
  reg                 idEx_csrWe;
  reg        [2:0]    idEx_sysOp;
  reg                 exMem_valid;
  reg                 exMem_memRead;
  reg                 exMem_memWrite;
  reg        [1:0]    exMem_memSize;
  reg                 exMem_memSign;
  reg                 exMem_atomic;
  reg                 exMem_isLr;
  reg                 exMem_isSc;
  reg        [4:0]    exMem_amoOp;
  reg                 exMem_fp;
  reg                 exMem_fpWrite;
  reg                 exMem_fpLoad;
  reg                 exMem_fpStore;
  reg        [4:0]    exMem_fpFlags;
  reg        [63:0]   exMem_fpRs2Data;
  reg                 exMem_regWrite;
  reg        [4:0]    exMem_rd;
  reg        [2:0]    exMem_wbSel;
  reg        [63:0]   exMem_aluResult;
  reg        [63:0]   exMem_rs2Data;
  reg        [1:0]    exMem_csrOp;
  reg                 exMem_csrWe;
  reg        [11:0]   exMem_csrAddr;
  reg        [63:0]   exMem_csrWrData;
  reg                 memWb_valid;
  reg                 memWb_regWrite;
  reg        [4:0]    memWb_rd;
  reg        [2:0]    memWb_wbSel;
  reg        [63:0]   memWb_wbData;
  reg                 memWb_fp;
  reg                 memWb_fpWrite;
  reg        [4:0]    memWb_fpFlags;
  reg        [1:0]    memWb_csrOp;
  reg                 memWb_csrWe;
  reg        [11:0]   memWb_csrAddr;
  reg        [63:0]   memWb_csrWrData;
  wire       [31:0]   fpRs1Data;
  wire       [31:0]   fpRs2Data;
  wire       [31:0]   fpRs3Data;
  wire       [63:0]   wbWriteData;
  reg        [63:0]   forwardRs1;
  wire                when_RiscvCore_l395;
  wire                when_RiscvCore_l397;
  reg        [63:0]   forwardRs2;
  wire                when_RiscvCore_l410;
  wire                when_RiscvCore_l412;
  wire       [31:0]   fpFwdRs1;
  wire       [31:0]   fpFwdRs2;
  wire       [31:0]   fpFwdRs3;
  wire                _zz_fpFwdRs1;
  reg        [63:0]   aluA;
  wire       [63:0]   aluB;
  wire       [63:0]   instrLenEx;
  reg        [63:0]   aluResult;
  reg        [63:0]   csrWrDataEx;
  reg                 branchCond;
  wire                branchTaken;
  wire                jumpTaken;
  wire                ctrlFlush;
  reg        [63:0]   ctrlTarget;
  wire                divInEx;
  wire                isCsrInst;
  wire                csrImplemented;
  wire                csrReadOnly;
  wire                csrRoWrite;
  wire                csrUnimpl;
  wire                csrFsOff;
  wire                csrPrivIllegal;
  wire                mtvecModeBad;
  wire                csrIllegal;
  reg                 exTrapEna;
  reg        [63:0]   exTrapCause;
  reg        [63:0]   exTrapTval;
  wire                mppSupported;
  wire                when_RiscvCore_l562;
  wire                when_RiscvCore_l566;
  wire                when_RiscvCore_l570;
  wire                when_RiscvCore_l579;
  wire                when_RiscvCore_l585;
  wire                when_RiscvCore_l588;
  wire                when_RiscvCore_l597;
  wire                when_RiscvCore_l602;
  wire                when_RiscvCore_l605;
  wire                mretLegal;
  wire                csrAffectsMret;
  wire                csrMretStall;
  wire                exMretRaw;
  wire                intrReq;
  wire                intStallData;
  wire                fpProducerEx;
  wire                fpProducerMem;
  wire                fpStallData;
  wire                stallData;
  wire                fetchStall;
  wire                memStall;
  wire                divIsDiv;
  wire                divIsRem;
  wire                divSigned;
  wire                divIsW;
  wire                divStall;
  wire       [63:0]   exAluResult;
  wire                isFpCompute;
  wire                isFpFromInt;
  wire                isFpMvW;
  wire                isFpMvX;
  wire       [2:0]    fpRmEx;
  wire       [63:0]   fpuResult;
  wire       [4:0]    fpuFlags;
  wire       [63:0]   fpToIntResult;
  wire       [63:0]   fpToFpResult;
  wire                fpResultIsSingle;
  wire       [63:0]   exAluResultFp;
  wire                scSuccess;
  wire                amoStall;
  wire                amoDriveRead;
  wire                amoDriveWrite;
  wire       [63:0]   amoNewValue;
  wire       [63:0]   amoOldValue;
  wire                otherFreeze;
  wire                freezeAll;
  wire                intrTake;
  reg        [63:0]   intrEpc;
  wire                trapCommit;
  wire                exMret;
  wire       [63:0]   trapEntry;
  wire                flushYounger;
  wire                bubbleEx;
  wire                when_RiscvCore_l944;
  wire                when_RiscvCore_l951;
  wire                when_RiscvCore_l959;
  wire                when_RiscvCore_l960;
  wire                when_RiscvCore_l973;
  wire                when_RiscvCore_l974;
  wire                when_RiscvCore_l1020;
  wire                effMemWrite;
  wire                normalRead;
  wire                normalWrite;
  wire       [2:0]    storeOffset;
  wire       [63:0]   intStoreValue;
  wire       [63:0]   storeValue;
  reg        [63:0]   loadResult;
  wire       [7:0]    _zz_loadResult;
  wire       [15:0]   _zz_loadResult_1;
  wire       [31:0]   _zz_loadResult_2;
  wire       [31:0]   fpLoadData;
  wire                when_RiscvCore_l1131;
  `ifndef SYNTHESIS
  reg [63:0] idEx_aluOp_string;
  reg [31:0] idEx_branchType_string;
  reg [39:0] idEx_csrOp_string;
  reg [55:0] idEx_sysOp_string;
  reg [39:0] exMem_csrOp_string;
  reg [39:0] memWb_csrOp_string;
  `endif


  assign _zz_fpFwdRs1_1 = memWb_wbData[31:0];
  assign _zz_fpFwdRs2 = memWb_wbData[31:0];
  assign _zz_fpFwdRs3 = memWb_wbData[31:0];
  assign _zz_aluResult = (idEx_pc + instrLenEx);
  assign _zz_csrWrDataEx = {59'd0, idEx_rs1};
  assign _zz_branchCond = forwardRs1;
  assign _zz_branchCond_1 = forwardRs2;
  assign _zz_branchCond_2 = forwardRs2;
  assign _zz_branchCond_3 = forwardRs1;
  assign _zz_ctrlTarget = (forwardRs1 + idEx_imm);
  assign _zz_exTrapCause = ((csrFile_1_io_curMode == MODE_U) ? 4'b1000 : ((csrFile_1_io_curMode == 2'b01) ? 4'b1001 : 4'b1011));
  assign _zz_exTrapTval = {52'd0, idEx_csrAddr};
  assign _zz_io_a = {32'd0, fpFwdRs1};
  assign _zz_fpToIntResult_1 = fpuResult[31 : 0];
  assign _zz_fpToIntResult = {{32{_zz_fpToIntResult_1[31]}}, _zz_fpToIntResult_1};
  assign _zz_pcReg = {61'd0, fetchLen};
  assign _zz_io_dBus_writeData = ({127'd0,storeValue} <<< _zz_io_dBus_writeData_1);
  assign _zz_io_dBus_writeData_1 = (storeOffset * 4'b1000);
  assign _zz_io_dBus_writeMask_1 = ({7'd0,8'h01} <<< storeOffset);
  assign _zz_io_dBus_writeMask = _zz_io_dBus_writeMask_1[7:0];
  assign _zz_io_dBus_writeData_2 = ({127'd0,storeValue} <<< _zz_io_dBus_writeData_3);
  assign _zz_io_dBus_writeData_3 = (storeOffset * 4'b1000);
  assign _zz_io_dBus_writeMask_3 = ({7'd0,8'h03} <<< storeOffset);
  assign _zz_io_dBus_writeMask_2 = _zz_io_dBus_writeMask_3[7:0];
  assign _zz_io_dBus_writeData_4 = ({127'd0,storeValue} <<< _zz_io_dBus_writeData_5);
  assign _zz_io_dBus_writeData_5 = (storeOffset * 4'b1000);
  assign _zz_io_dBus_writeMask_5 = ({7'd0,8'h0f} <<< storeOffset);
  assign _zz_io_dBus_writeMask_4 = _zz_io_dBus_writeMask_5[7:0];
  assign _zz__zz_loadResult = (io_dBus_readData >>> _zz__zz_loadResult_1);
  assign _zz__zz_loadResult_1 = (storeOffset * 4'b1000);
  assign _zz_loadResult_4 = _zz_loadResult;
  assign _zz_loadResult_3 = {{56{_zz_loadResult_4[7]}}, _zz_loadResult_4};
  assign _zz_loadResult_5 = {56'd0, _zz_loadResult};
  assign _zz__zz_loadResult_1_1 = (io_dBus_readData >>> _zz__zz_loadResult_1_2);
  assign _zz__zz_loadResult_1_2 = (storeOffset * 4'b1000);
  assign _zz_loadResult_7 = _zz_loadResult_1;
  assign _zz_loadResult_6 = {{48{_zz_loadResult_7[15]}}, _zz_loadResult_7};
  assign _zz_loadResult_8 = {48'd0, _zz_loadResult_1};
  assign _zz__zz_loadResult_2 = (io_dBus_readData >>> _zz__zz_loadResult_2_1);
  assign _zz__zz_loadResult_2_1 = (storeOffset * 4'b1000);
  assign _zz_loadResult_10 = _zz_loadResult_2;
  assign _zz_loadResult_9 = {{32{_zz_loadResult_10[31]}}, _zz_loadResult_10};
  assign _zz_loadResult_11 = {32'd0, _zz_loadResult_2};
  assign _zz_divInEx = AluOp_DIV;
  assign _zz_divInEx_1 = AluOp_DIVU;
  assign _zz_csrImplemented = ((((idEx_csrAddr == 12'h300) || (idEx_csrAddr == 12'h301)) || (idEx_csrAddr == 12'h304)) || (idEx_csrAddr == 12'h305));
  assign _zz_csrImplemented_1 = (idEx_csrAddr == 12'h340);
  assign _zz_csrImplemented_2 = 12'h341;
  assign _zz_csrPrivIllegal = ((((((! (2'b11 <= csrFile_1_io_curMode)) || (! (2'b11 <= csrFile_1_io_curMode))) || (! (2'b11 <= csrFile_1_io_curMode))) || (! (2'b11 <= csrFile_1_io_curMode))) || (! (2'b11 <= csrFile_1_io_curMode))) || (! (2'b11 <= csrFile_1_io_curMode)));
  assign _zz_csrPrivIllegal_1 = (! (2'b11 <= csrFile_1_io_curMode));
  assign _zz_csrPrivIllegal_2 = (2'b11 <= csrFile_1_io_curMode);
  assign _zz_csrPrivIllegal_3 = 2'b11;
  Decoder decoder_1 (
    .io_instruction       (ifId_instruction[31:0]             ), //i
    .io_output_regWrite   (decoder_1_io_output_regWrite       ), //o
    .io_output_aluSrc     (decoder_1_io_output_aluSrc         ), //o
    .io_output_wbSel      (decoder_1_io_output_wbSel[2:0]     ), //o
    .io_output_branch     (decoder_1_io_output_branch         ), //o
    .io_output_jump       (decoder_1_io_output_jump           ), //o
    .io_output_jalr       (decoder_1_io_output_jalr           ), //o
    .io_output_aluOp      (decoder_1_io_output_aluOp[6:0]     ), //o
    .io_output_branchType (decoder_1_io_output_branchType[2:0]), //o
    .io_output_aluASrc    (decoder_1_io_output_aluASrc[1:0]   ), //o
    .io_output_memRead    (decoder_1_io_output_memRead        ), //o
    .io_output_memWrite   (decoder_1_io_output_memWrite       ), //o
    .io_output_memSize    (decoder_1_io_output_memSize[1:0]   ), //o
    .io_output_memSign    (decoder_1_io_output_memSign        ), //o
    .io_output_atomic     (decoder_1_io_output_atomic         ), //o
    .io_output_isLr       (decoder_1_io_output_isLr           ), //o
    .io_output_isSc       (decoder_1_io_output_isSc           ), //o
    .io_output_amoOp      (decoder_1_io_output_amoOp[4:0]     ), //o
    .io_output_fp         (decoder_1_io_output_fp             ), //o
    .io_output_fpWrite    (decoder_1_io_output_fpWrite        ), //o
    .io_output_fpLoad     (decoder_1_io_output_fpLoad         ), //o
    .io_output_fpStore    (decoder_1_io_output_fpStore        ), //o
    .io_output_fpIntRd    (decoder_1_io_output_fpIntRd        ), //o
    .io_output_fpOp       (decoder_1_io_output_fpOp[5:0]      ), //o
    .io_output_fpRm       (decoder_1_io_output_fpRm[2:0]      ), //o
    .io_output_fpFmt      (decoder_1_io_output_fpFmt          ), //o
    .io_output_rs3        (decoder_1_io_output_rs3[4:0]       ), //o
    .io_output_rs1        (decoder_1_io_output_rs1[4:0]       ), //o
    .io_output_rs2        (decoder_1_io_output_rs2[4:0]       ), //o
    .io_output_rd         (decoder_1_io_output_rd[4:0]        ), //o
    .io_output_imm        (decoder_1_io_output_imm[63:0]      ), //o
    .io_output_illegal    (decoder_1_io_output_illegal        ), //o
    .io_output_csrOp      (decoder_1_io_output_csrOp[1:0]     ), //o
    .io_output_csrAddr    (decoder_1_io_output_csrAddr[11:0]  ), //o
    .io_output_csrImm     (decoder_1_io_output_csrImm         ), //o
    .io_output_csrWe      (decoder_1_io_output_csrWe          ), //o
    .io_output_sysOp      (decoder_1_io_output_sysOp[2:0]     ), //o
    .io_output_valid      (decoder_1_io_output_valid          )  //o
  );
  RegisterFile regFile (
    .io_rs1          (idEx_rs1[4:0]                ), //i
    .io_rs2          (idEx_rs2[4:0]                ), //i
    .io_rd           (memWb_rd[4:0]                ), //i
    .io_writeData    (wbWriteData[63:0]            ), //i
    .io_writeEnable  (regFile_io_writeEnable       ), //i
    .io_rs1Data      (regFile_io_rs1Data[63:0]     ), //o
    .io_rs2Data      (regFile_io_rs2Data[63:0]     ), //o
    .io_debugRegs_0  (regFile_io_debugRegs_0[63:0] ), //o
    .io_debugRegs_1  (regFile_io_debugRegs_1[63:0] ), //o
    .io_debugRegs_2  (regFile_io_debugRegs_2[63:0] ), //o
    .io_debugRegs_3  (regFile_io_debugRegs_3[63:0] ), //o
    .io_debugRegs_4  (regFile_io_debugRegs_4[63:0] ), //o
    .io_debugRegs_5  (regFile_io_debugRegs_5[63:0] ), //o
    .io_debugRegs_6  (regFile_io_debugRegs_6[63:0] ), //o
    .io_debugRegs_7  (regFile_io_debugRegs_7[63:0] ), //o
    .io_debugRegs_8  (regFile_io_debugRegs_8[63:0] ), //o
    .io_debugRegs_9  (regFile_io_debugRegs_9[63:0] ), //o
    .io_debugRegs_10 (regFile_io_debugRegs_10[63:0]), //o
    .io_debugRegs_11 (regFile_io_debugRegs_11[63:0]), //o
    .io_debugRegs_12 (regFile_io_debugRegs_12[63:0]), //o
    .io_debugRegs_13 (regFile_io_debugRegs_13[63:0]), //o
    .io_debugRegs_14 (regFile_io_debugRegs_14[63:0]), //o
    .io_debugRegs_15 (regFile_io_debugRegs_15[63:0]), //o
    .io_debugRegs_16 (regFile_io_debugRegs_16[63:0]), //o
    .io_debugRegs_17 (regFile_io_debugRegs_17[63:0]), //o
    .io_debugRegs_18 (regFile_io_debugRegs_18[63:0]), //o
    .io_debugRegs_19 (regFile_io_debugRegs_19[63:0]), //o
    .io_debugRegs_20 (regFile_io_debugRegs_20[63:0]), //o
    .io_debugRegs_21 (regFile_io_debugRegs_21[63:0]), //o
    .io_debugRegs_22 (regFile_io_debugRegs_22[63:0]), //o
    .io_debugRegs_23 (regFile_io_debugRegs_23[63:0]), //o
    .io_debugRegs_24 (regFile_io_debugRegs_24[63:0]), //o
    .io_debugRegs_25 (regFile_io_debugRegs_25[63:0]), //o
    .io_debugRegs_26 (regFile_io_debugRegs_26[63:0]), //o
    .io_debugRegs_27 (regFile_io_debugRegs_27[63:0]), //o
    .io_debugRegs_28 (regFile_io_debugRegs_28[63:0]), //o
    .io_debugRegs_29 (regFile_io_debugRegs_29[63:0]), //o
    .io_debugRegs_30 (regFile_io_debugRegs_30[63:0]), //o
    .io_debugRegs_31 (regFile_io_debugRegs_31[63:0]), //o
    .clk             (clk                          ), //i
    .reset           (reset                        )  //i
  );
  FpRegisterFile fpRegFile (
    .io_rs1          (idEx_rs1[4:0]                  ), //i
    .io_rs2          (idEx_rs2[4:0]                  ), //i
    .io_rs3          (idEx_rs3[4:0]                  ), //i
    .io_rd           (memWb_rd[4:0]                  ), //i
    .io_writeData    (fpRegFile_io_writeData[31:0]   ), //i
    .io_writeEnable  (fpRegFile_io_writeEnable       ), //i
    .io_rs1Data      (fpRegFile_io_rs1Data[31:0]     ), //o
    .io_rs2Data      (fpRegFile_io_rs2Data[31:0]     ), //o
    .io_rs3Data      (fpRegFile_io_rs3Data[31:0]     ), //o
    .io_debugRegs_0  (fpRegFile_io_debugRegs_0[31:0] ), //o
    .io_debugRegs_1  (fpRegFile_io_debugRegs_1[31:0] ), //o
    .io_debugRegs_2  (fpRegFile_io_debugRegs_2[31:0] ), //o
    .io_debugRegs_3  (fpRegFile_io_debugRegs_3[31:0] ), //o
    .io_debugRegs_4  (fpRegFile_io_debugRegs_4[31:0] ), //o
    .io_debugRegs_5  (fpRegFile_io_debugRegs_5[31:0] ), //o
    .io_debugRegs_6  (fpRegFile_io_debugRegs_6[31:0] ), //o
    .io_debugRegs_7  (fpRegFile_io_debugRegs_7[31:0] ), //o
    .io_debugRegs_8  (fpRegFile_io_debugRegs_8[31:0] ), //o
    .io_debugRegs_9  (fpRegFile_io_debugRegs_9[31:0] ), //o
    .io_debugRegs_10 (fpRegFile_io_debugRegs_10[31:0]), //o
    .io_debugRegs_11 (fpRegFile_io_debugRegs_11[31:0]), //o
    .io_debugRegs_12 (fpRegFile_io_debugRegs_12[31:0]), //o
    .io_debugRegs_13 (fpRegFile_io_debugRegs_13[31:0]), //o
    .io_debugRegs_14 (fpRegFile_io_debugRegs_14[31:0]), //o
    .io_debugRegs_15 (fpRegFile_io_debugRegs_15[31:0]), //o
    .io_debugRegs_16 (fpRegFile_io_debugRegs_16[31:0]), //o
    .io_debugRegs_17 (fpRegFile_io_debugRegs_17[31:0]), //o
    .io_debugRegs_18 (fpRegFile_io_debugRegs_18[31:0]), //o
    .io_debugRegs_19 (fpRegFile_io_debugRegs_19[31:0]), //o
    .io_debugRegs_20 (fpRegFile_io_debugRegs_20[31:0]), //o
    .io_debugRegs_21 (fpRegFile_io_debugRegs_21[31:0]), //o
    .io_debugRegs_22 (fpRegFile_io_debugRegs_22[31:0]), //o
    .io_debugRegs_23 (fpRegFile_io_debugRegs_23[31:0]), //o
    .io_debugRegs_24 (fpRegFile_io_debugRegs_24[31:0]), //o
    .io_debugRegs_25 (fpRegFile_io_debugRegs_25[31:0]), //o
    .io_debugRegs_26 (fpRegFile_io_debugRegs_26[31:0]), //o
    .io_debugRegs_27 (fpRegFile_io_debugRegs_27[31:0]), //o
    .io_debugRegs_28 (fpRegFile_io_debugRegs_28[31:0]), //o
    .io_debugRegs_29 (fpRegFile_io_debugRegs_29[31:0]), //o
    .io_debugRegs_30 (fpRegFile_io_debugRegs_30[31:0]), //o
    .io_debugRegs_31 (fpRegFile_io_debugRegs_31[31:0]), //o
    .clk             (clk                            ), //i
    .reset           (reset                          )  //i
  );
  FpUnit fpUnit32 (
    .io_op     (idEx_fpOp[5:0]          ), //i
    .io_rm     (fpRmEx[2:0]             ), //i
    .io_a      (fpUnit32_io_a[63:0]     ), //i
    .io_b      (fpUnit32_io_b[63:0]     ), //i
    .io_c      (fpUnit32_io_c[63:0]     ), //i
    .io_result (fpUnit32_io_result[63:0]), //o
    .io_flags  (fpUnit32_io_flags[4:0]  )  //o
  );
  CsrFile csrFile_1 (
    .io_timerInterrupt (io_timerInterrupt             ), //i
    .io_csrAddr        (memWb_csrAddr[11:0]           ), //i
    .io_csrOp          (memWb_csrOp[1:0]              ), //i
    .io_csrWe          (csrFile_1_io_csrWe            ), //i
    .io_csrWrData      (memWb_csrWrData[63:0]         ), //i
    .io_rdData         (csrFile_1_io_rdData[63:0]     ), //o
    .io_trapEna        (trapCommit                    ), //i
    .io_trapEpc        (csrFile_1_io_trapEpc[63:0]    ), //i
    .io_trapCause      (csrFile_1_io_trapCause[63:0]  ), //i
    .io_trapTval       (csrFile_1_io_trapTval[63:0]   ), //i
    .io_mretEna        (exMret                        ), //i
    .io_fpDirty        (csrFile_1_io_fpDirty          ), //i
    .io_fpFlagsWe      (csrFile_1_io_fpFlagsWe        ), //i
    .io_fpFlags        (memWb_fpFlags[4:0]            ), //i
    .io_curMode        (csrFile_1_io_curMode[1:0]     ), //o
    .io_mstatusMie     (csrFile_1_io_mstatusMie       ), //o
    .io_mstatusMpp     (csrFile_1_io_mstatusMpp[1:0]  ), //o
    .io_mstatusFs      (csrFile_1_io_mstatusFs[1:0]   ), //o
    .io_frm            (csrFile_1_io_frm[2:0]         ), //o
    .io_mieMtie        (csrFile_1_io_mieMtie          ), //o
    .io_mtvec          (csrFile_1_io_mtvec[63:0]      ), //o
    .io_mepc           (csrFile_1_io_mepc[63:0]       ), //o
    .io_debugMepc      (csrFile_1_io_debugMepc[63:0]  ), //o
    .io_debugMcause    (csrFile_1_io_debugMcause[63:0]), //o
    .io_debugMode      (csrFile_1_io_debugMode[1:0]   ), //o
    .clk               (clk                           ), //i
    .reset             (reset                         )  //i
  );
  Alu alu_1 (
    .io_a      (aluA[63:0]           ), //i
    .io_b      (aluB[63:0]           ), //i
    .io_op     (idEx_aluOp[6:0]      ), //i
    .io_result (alu_1_io_result[63:0])  //o
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(idEx_aluOp)
      AluOp_ADD : idEx_aluOp_string = "ADD     ";
      AluOp_SUB : idEx_aluOp_string = "SUB     ";
      AluOp_SLL_1 : idEx_aluOp_string = "SLL_1   ";
      AluOp_SLT : idEx_aluOp_string = "SLT     ";
      AluOp_SLTU : idEx_aluOp_string = "SLTU    ";
      AluOp_XOR_1 : idEx_aluOp_string = "XOR_1   ";
      AluOp_SRL_1 : idEx_aluOp_string = "SRL_1   ";
      AluOp_SRA_1 : idEx_aluOp_string = "SRA_1   ";
      AluOp_OR_1 : idEx_aluOp_string = "OR_1    ";
      AluOp_AND_1 : idEx_aluOp_string = "AND_1   ";
      AluOp_ADDW : idEx_aluOp_string = "ADDW    ";
      AluOp_SUBW : idEx_aluOp_string = "SUBW    ";
      AluOp_SLLW : idEx_aluOp_string = "SLLW    ";
      AluOp_SRLW : idEx_aluOp_string = "SRLW    ";
      AluOp_SRAW : idEx_aluOp_string = "SRAW    ";
      AluOp_MUL : idEx_aluOp_string = "MUL     ";
      AluOp_MULH : idEx_aluOp_string = "MULH    ";
      AluOp_MULHSU : idEx_aluOp_string = "MULHSU  ";
      AluOp_MULHU : idEx_aluOp_string = "MULHU   ";
      AluOp_DIV : idEx_aluOp_string = "DIV     ";
      AluOp_DIVU : idEx_aluOp_string = "DIVU    ";
      AluOp_REM_1 : idEx_aluOp_string = "REM_1   ";
      AluOp_REMU : idEx_aluOp_string = "REMU    ";
      AluOp_MULW : idEx_aluOp_string = "MULW    ";
      AluOp_DIVW : idEx_aluOp_string = "DIVW    ";
      AluOp_DIVUW : idEx_aluOp_string = "DIVUW   ";
      AluOp_REMW : idEx_aluOp_string = "REMW    ";
      AluOp_REMUW : idEx_aluOp_string = "REMUW   ";
      AluOp_ANDN : idEx_aluOp_string = "ANDN    ";
      AluOp_ORN : idEx_aluOp_string = "ORN     ";
      AluOp_XNOR_1 : idEx_aluOp_string = "XNOR_1  ";
      AluOp_CLZ : idEx_aluOp_string = "CLZ     ";
      AluOp_CTZ : idEx_aluOp_string = "CTZ     ";
      AluOp_CPOP : idEx_aluOp_string = "CPOP    ";
      AluOp_SEXTB : idEx_aluOp_string = "SEXTB   ";
      AluOp_SEXTH : idEx_aluOp_string = "SEXTH   ";
      AluOp_ZEXTH : idEx_aluOp_string = "ZEXTH   ";
      AluOp_ORCB : idEx_aluOp_string = "ORCB    ";
      AluOp_REV8 : idEx_aluOp_string = "REV8    ";
      AluOp_ROL_1 : idEx_aluOp_string = "ROL_1   ";
      AluOp_ROR_1 : idEx_aluOp_string = "ROR_1   ";
      AluOp_MIN : idEx_aluOp_string = "MIN     ";
      AluOp_MINU : idEx_aluOp_string = "MINU    ";
      AluOp_MAX : idEx_aluOp_string = "MAX     ";
      AluOp_MAXU : idEx_aluOp_string = "MAXU    ";
      AluOp_BSET : idEx_aluOp_string = "BSET    ";
      AluOp_BCLR : idEx_aluOp_string = "BCLR    ";
      AluOp_BINV : idEx_aluOp_string = "BINV    ";
      AluOp_BEXT : idEx_aluOp_string = "BEXT    ";
      AluOp_SH1ADD : idEx_aluOp_string = "SH1ADD  ";
      AluOp_SH2ADD : idEx_aluOp_string = "SH2ADD  ";
      AluOp_SH3ADD : idEx_aluOp_string = "SH3ADD  ";
      AluOp_ADDUW : idEx_aluOp_string = "ADDUW   ";
      AluOp_SH1ADDUW : idEx_aluOp_string = "SH1ADDUW";
      AluOp_SH2ADDUW : idEx_aluOp_string = "SH2ADDUW";
      AluOp_SH3ADDUW : idEx_aluOp_string = "SH3ADDUW";
      AluOp_SLLIUW : idEx_aluOp_string = "SLLIUW  ";
      AluOp_CLMUL : idEx_aluOp_string = "CLMUL   ";
      AluOp_CLMULH : idEx_aluOp_string = "CLMULH  ";
      AluOp_CLMULR : idEx_aluOp_string = "CLMULR  ";
      AluOp_CLZW : idEx_aluOp_string = "CLZW    ";
      AluOp_CTZW : idEx_aluOp_string = "CTZW    ";
      AluOp_CPOPW : idEx_aluOp_string = "CPOPW   ";
      AluOp_ROLW : idEx_aluOp_string = "ROLW    ";
      AluOp_RORW : idEx_aluOp_string = "RORW    ";
      default : idEx_aluOp_string = "????????";
    endcase
  end
  always @(*) begin
    case(idEx_branchType)
      BranchOp_NONE : idEx_branchType_string = "NONE";
      BranchOp_BEQ : idEx_branchType_string = "BEQ ";
      BranchOp_BNE : idEx_branchType_string = "BNE ";
      BranchOp_BLT : idEx_branchType_string = "BLT ";
      BranchOp_BGE : idEx_branchType_string = "BGE ";
      BranchOp_BLTU : idEx_branchType_string = "BLTU";
      BranchOp_BGEU : idEx_branchType_string = "BGEU";
      default : idEx_branchType_string = "????";
    endcase
  end
  always @(*) begin
    case(idEx_csrOp)
      CsrOp_NONE : idEx_csrOp_string = "NONE ";
      CsrOp_WRITE : idEx_csrOp_string = "WRITE";
      CsrOp_SET : idEx_csrOp_string = "SET  ";
      CsrOp_CLEAR : idEx_csrOp_string = "CLEAR";
      default : idEx_csrOp_string = "?????";
    endcase
  end
  always @(*) begin
    case(idEx_sysOp)
      SysOp_NONE : idEx_sysOp_string = "NONE   ";
      SysOp_ECALL : idEx_sysOp_string = "ECALL  ";
      SysOp_EBREAK : idEx_sysOp_string = "EBREAK ";
      SysOp_MRET : idEx_sysOp_string = "MRET   ";
      SysOp_WFI : idEx_sysOp_string = "WFI    ";
      SysOp_ILLEGAL : idEx_sysOp_string = "ILLEGAL";
      default : idEx_sysOp_string = "???????";
    endcase
  end
  always @(*) begin
    case(exMem_csrOp)
      CsrOp_NONE : exMem_csrOp_string = "NONE ";
      CsrOp_WRITE : exMem_csrOp_string = "WRITE";
      CsrOp_SET : exMem_csrOp_string = "SET  ";
      CsrOp_CLEAR : exMem_csrOp_string = "CLEAR";
      default : exMem_csrOp_string = "?????";
    endcase
  end
  always @(*) begin
    case(memWb_csrOp)
      CsrOp_NONE : memWb_csrOp_string = "NONE ";
      CsrOp_WRITE : memWb_csrOp_string = "WRITE";
      CsrOp_SET : memWb_csrOp_string = "SET  ";
      CsrOp_CLEAR : memWb_csrOp_string = "CLEAR";
      default : memWb_csrOp_string = "?????";
    endcase
  end
  `endif

  assign MODE_U = 2'b00;
  assign MODE_M = 2'b11;
  assign mis32 = 1'b0;
  assign hiReg = 16'h0;
  assign io_iBus_valid = 1'b1;
  assign io_iBus_pc = pcReg;
  assign mis32Start = 1'b0;
  assign mis32Stall = 1'b0;
  assign fetchInstr = io_iBus_instruction;
  assign fetchLen = 3'b100;
  assign fetchCompressed = 1'b0;
  assign fpRs1Data = fpRegFile_io_rs1Data;
  assign fpRs2Data = fpRegFile_io_rs2Data;
  assign fpRs3Data = fpRegFile_io_rs3Data;
  assign wbWriteData = ((memWb_wbSel == 3'b011) ? csrFile_1_io_rdData : memWb_wbData);
  assign when_RiscvCore_l395 = ((((((exMem_valid && exMem_regWrite) && (exMem_rd != 5'h0)) && (! exMem_memRead)) && (! exMem_atomic)) && (exMem_wbSel != 3'b011)) && (exMem_rd == idEx_rs1));
  always @(*) begin
    if(when_RiscvCore_l395) begin
      forwardRs1 = exMem_aluResult;
    end else begin
      if(when_RiscvCore_l397) begin
        forwardRs1 = wbWriteData;
      end else begin
        forwardRs1 = regFile_io_rs1Data;
      end
    end
  end

  assign when_RiscvCore_l397 = (((memWb_valid && memWb_regWrite) && (memWb_rd != 5'h0)) && (memWb_rd == idEx_rs1));
  assign when_RiscvCore_l410 = ((((((exMem_valid && exMem_regWrite) && (exMem_rd != 5'h0)) && (! exMem_memRead)) && (! exMem_atomic)) && (exMem_wbSel != 3'b011)) && (exMem_rd == idEx_rs2));
  always @(*) begin
    if(when_RiscvCore_l410) begin
      forwardRs2 = exMem_aluResult;
    end else begin
      if(when_RiscvCore_l412) begin
        forwardRs2 = wbWriteData;
      end else begin
        forwardRs2 = regFile_io_rs2Data;
      end
    end
  end

  assign when_RiscvCore_l412 = (((memWb_valid && memWb_regWrite) && (memWb_rd != 5'h0)) && (memWb_rd == idEx_rs2));
  assign _zz_fpFwdRs1 = ((memWb_valid && memWb_fpWrite) && (memWb_rd != 5'h0));
  assign fpFwdRs1 = ((_zz_fpFwdRs1 && (memWb_rd == idEx_rs1)) ? _zz_fpFwdRs1_1 : fpRs1Data);
  assign fpFwdRs2 = ((_zz_fpFwdRs1 && (memWb_rd == idEx_rs2)) ? _zz_fpFwdRs2 : fpRs2Data);
  assign fpFwdRs3 = ((_zz_fpFwdRs1 && (memWb_rd == idEx_rs3)) ? _zz_fpFwdRs3 : fpRs3Data);
  always @(*) begin
    case(idEx_aluASrc)
      2'b00 : begin
        aluA = forwardRs1;
      end
      2'b01 : begin
        aluA = idEx_pc;
      end
      default : begin
        aluA = 64'h0;
      end
    endcase
  end

  assign aluB = (idEx_aluSrc ? idEx_imm : forwardRs2);
  assign instrLenEx = (idEx_compressed ? 64'h0000000000000002 : 64'h0000000000000004);
  always @(*) begin
    if(idEx_jump) begin
      aluResult = _zz_aluResult;
    end else begin
      aluResult = alu_1_io_result;
    end
  end

  always @(*) begin
    if(idEx_csrImm) begin
      csrWrDataEx = _zz_csrWrDataEx;
    end else begin
      csrWrDataEx = forwardRs1;
    end
  end

  always @(*) begin
    case(idEx_branchType)
      BranchOp_BEQ : begin
        branchCond = (forwardRs1 == forwardRs2);
      end
      BranchOp_BNE : begin
        branchCond = (forwardRs1 != forwardRs2);
      end
      BranchOp_BLT : begin
        branchCond = ($signed(_zz_branchCond) < $signed(_zz_branchCond_1));
      end
      BranchOp_BGE : begin
        branchCond = ($signed(_zz_branchCond_2) <= $signed(_zz_branchCond_3));
      end
      BranchOp_BLTU : begin
        branchCond = (forwardRs1 < forwardRs2);
      end
      BranchOp_BGEU : begin
        branchCond = (forwardRs2 <= forwardRs1);
      end
      default : begin
        branchCond = 1'b0;
      end
    endcase
  end

  assign branchTaken = ((idEx_valid && idEx_branch) && branchCond);
  assign jumpTaken = (idEx_valid && idEx_jump);
  assign ctrlFlush = (branchTaken || jumpTaken);
  always @(*) begin
    if(idEx_jalr) begin
      ctrlTarget = (_zz_ctrlTarget & (~ 64'h0000000000000001));
    end else begin
      ctrlTarget = (idEx_pc + idEx_imm);
    end
  end

  assign divInEx = (idEx_valid && ((((((((idEx_aluOp == _zz_divInEx) || (idEx_aluOp == _zz_divInEx_1)) || (idEx_aluOp == AluOp_REM_1)) || (idEx_aluOp == AluOp_REMU)) || (idEx_aluOp == AluOp_DIVW)) || (idEx_aluOp == AluOp_DIVUW)) || (idEx_aluOp == AluOp_REMW)) || (idEx_aluOp == AluOp_REMUW)));
  assign isCsrInst = (idEx_csrOp != CsrOp_NONE);
  assign csrImplemented = (((((((((_zz_csrImplemented || _zz_csrImplemented_1) || (idEx_csrAddr == _zz_csrImplemented_2)) || (idEx_csrAddr == 12'h342)) || (idEx_csrAddr == 12'h343)) || (idEx_csrAddr == 12'h344)) || (idEx_csrAddr == 12'hf14)) || (idEx_csrAddr == 12'h001)) || (idEx_csrAddr == 12'h002)) || (idEx_csrAddr == 12'h003));
  assign csrReadOnly = (((idEx_csrAddr == 12'h301) || (idEx_csrAddr == 12'h344)) || (idEx_csrAddr == 12'hf14));
  assign csrRoWrite = (((isCsrInst && csrReadOnly) && (idEx_csrOp == CsrOp_WRITE)) && idEx_csrWe);
  assign csrUnimpl = (isCsrInst && (! csrImplemented));
  assign csrFsOff = ((isCsrInst && (csrFile_1_io_mstatusFs == 2'b00)) && (((idEx_csrAddr == 12'h001) || (idEx_csrAddr == 12'h002)) || (idEx_csrAddr == 12'h003)));
  assign csrPrivIllegal = (isCsrInst && (((((((_zz_csrPrivIllegal || _zz_csrPrivIllegal_1) || (! _zz_csrPrivIllegal_2)) || (! (_zz_csrPrivIllegal_3 <= csrFile_1_io_curMode))) || (! (2'b11 <= csrFile_1_io_curMode))) || (! (2'b00 <= csrFile_1_io_curMode))) || (! (2'b00 <= csrFile_1_io_curMode))) || (! (2'b00 <= csrFile_1_io_curMode))));
  assign mtvecModeBad = ((((isCsrInst && idEx_csrWe) && (idEx_csrAddr == 12'h305)) && ((idEx_csrOp == CsrOp_WRITE) || (idEx_csrOp == CsrOp_SET))) && (csrWrDataEx[1 : 0] != 2'b00));
  assign csrIllegal = (((((csrRoWrite || csrUnimpl) || csrPrivIllegal) || mtvecModeBad) || csrFsOff) && idEx_valid);
  always @(*) begin
    exTrapEna = 1'b0;
    if(idEx_valid) begin
      if(when_RiscvCore_l562) begin
        exTrapEna = 1'b1;
      end
      if(when_RiscvCore_l566) begin
        exTrapEna = 1'b1;
      end
      if(when_RiscvCore_l570) begin
        exTrapEna = 1'b1;
      end
      if(csrIllegal) begin
        exTrapEna = 1'b1;
      end
      if(when_RiscvCore_l579) begin
        exTrapEna = 1'b1;
      end
      if(when_RiscvCore_l585) begin
        if(when_RiscvCore_l588) begin
          exTrapEna = 1'b1;
        end
      end
      if(when_RiscvCore_l597) begin
        exTrapEna = 1'b1;
      end
      if(when_RiscvCore_l602) begin
        if(when_RiscvCore_l605) begin
          exTrapEna = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    exTrapCause = 64'h0;
    if(idEx_valid) begin
      if(when_RiscvCore_l562) begin
        exTrapCause = {60'd0, _zz_exTrapCause};
      end
      if(when_RiscvCore_l566) begin
        exTrapCause = 64'h0000000000000003;
      end
      if(when_RiscvCore_l570) begin
        exTrapCause = 64'h0000000000000002;
      end
      if(csrIllegal) begin
        exTrapCause = 64'h0000000000000002;
      end
      if(when_RiscvCore_l579) begin
        exTrapCause = 64'h0000000000000002;
      end
      if(when_RiscvCore_l585) begin
        if(when_RiscvCore_l588) begin
          exTrapCause = (idEx_isLr ? 64'h0000000000000004 : 64'h0000000000000006);
        end
      end
      if(when_RiscvCore_l597) begin
        exTrapCause = 64'h0000000000000002;
      end
      if(when_RiscvCore_l602) begin
        if(when_RiscvCore_l605) begin
          exTrapCause = (idEx_fpLoad ? 64'h0000000000000004 : 64'h0000000000000006);
        end
      end
    end
  end

  always @(*) begin
    exTrapTval = 64'h0;
    if(idEx_valid) begin
      if(csrIllegal) begin
        exTrapTval = _zz_exTrapTval;
      end
      if(when_RiscvCore_l585) begin
        if(when_RiscvCore_l588) begin
          exTrapTval = aluResult;
        end
      end
      if(when_RiscvCore_l602) begin
        if(when_RiscvCore_l605) begin
          exTrapTval = aluResult;
        end
      end
    end
  end

  assign mppSupported = ((csrFile_1_io_mstatusMpp == 2'b00) || (csrFile_1_io_mstatusMpp == 2'b11));
  assign when_RiscvCore_l562 = (idEx_sysOp == SysOp_ECALL);
  assign when_RiscvCore_l566 = (idEx_sysOp == SysOp_EBREAK);
  assign when_RiscvCore_l570 = ((idEx_sysOp == SysOp_MRET) && ((csrFile_1_io_curMode != MODE_M) || (! mppSupported)));
  assign when_RiscvCore_l579 = (idEx_illegal || (idEx_sysOp == SysOp_ILLEGAL));
  assign when_RiscvCore_l585 = (idEx_atomic || idEx_isLr);
  assign when_RiscvCore_l588 = (! ((idEx_memSize == 2'b10) ? (aluResult[1 : 0] == 2'b00) : (aluResult[2 : 0] == 3'b000)));
  assign when_RiscvCore_l597 = (idEx_fp && (csrFile_1_io_mstatusFs == 2'b00));
  assign when_RiscvCore_l602 = (idEx_fpLoad || idEx_fpStore);
  assign when_RiscvCore_l605 = (! ((idEx_memSize == 2'b11) ? (aluResult[2 : 0] == 3'b000) : (aluResult[1 : 0] == 2'b00)));
  assign mretLegal = (((idEx_valid && (idEx_sysOp == SysOp_MRET)) && (csrFile_1_io_curMode == MODE_M)) && mppSupported);
  assign csrAffectsMret = (((memWb_valid && memWb_csrWe) && ((memWb_csrAddr == 12'h300) || (memWb_csrAddr == 12'h341))) || ((exMem_valid && exMem_csrWe) && ((exMem_csrAddr == 12'h300) || (exMem_csrAddr == 12'h341))));
  assign csrMretStall = (mretLegal && csrAffectsMret);
  assign exMretRaw = (mretLegal && (! csrMretStall));
  assign intrReq = (((io_timerInterrupt && csrFile_1_io_mieMtie) && csrFile_1_io_mstatusMie) && (csrFile_1_io_curMode == MODE_M));
  assign intStallData = ((((idEx_valid && (! idEx_fpWrite)) && (idEx_rd != 5'h0)) && ((idEx_memRead || idEx_atomic) || ((idEx_wbSel == 3'b011) && idEx_regWrite))) && ((idEx_rd == decoder_1_io_output_rs1) || (idEx_rd == decoder_1_io_output_rs2)));
  assign fpProducerEx = ((idEx_valid && idEx_fpWrite) && (idEx_rd != 5'h0));
  assign fpProducerMem = ((exMem_valid && exMem_fpWrite) && (exMem_rd != 5'h0));
  assign fpStallData = ((fpProducerEx && (decoder_1_io_output_fp && (((idEx_rd == decoder_1_io_output_rs1) || (idEx_rd == decoder_1_io_output_rs2)) || (idEx_rd == decoder_1_io_output_rs3)))) || (fpProducerMem && (decoder_1_io_output_fp && (((exMem_rd == decoder_1_io_output_rs1) || (exMem_rd == decoder_1_io_output_rs2)) || (exMem_rd == decoder_1_io_output_rs3)))));
  assign stallData = (intStallData || fpStallData);
  assign fetchStall = (! io_iBus_ready);
  assign memStall = (((exMem_valid && (exMem_memRead || exMem_memWrite)) && (! exMem_atomic)) && (! io_dBus_ready));
  assign divIsDiv = ((((idEx_aluOp == AluOp_DIV) || (idEx_aluOp == AluOp_DIVU)) || (idEx_aluOp == AluOp_DIVW)) || (idEx_aluOp == AluOp_DIVUW));
  assign divIsRem = ((((idEx_aluOp == AluOp_REM_1) || (idEx_aluOp == AluOp_REMU)) || (idEx_aluOp == AluOp_REMW)) || (idEx_aluOp == AluOp_REMUW));
  assign divSigned = ((((idEx_aluOp == AluOp_DIV) || (idEx_aluOp == AluOp_REM_1)) || (idEx_aluOp == AluOp_DIVW)) || (idEx_aluOp == AluOp_REMW));
  assign divIsW = ((((idEx_aluOp == AluOp_DIVW) || (idEx_aluOp == AluOp_DIVUW)) || (idEx_aluOp == AluOp_REMW)) || (idEx_aluOp == AluOp_REMUW));
  assign divStall = 1'b0;
  assign exAluResult = aluResult;
  assign isFpCompute = (((idEx_valid && idEx_fp) && (! idEx_fpLoad)) && (! idEx_fpStore));
  assign isFpFromInt = (((((idEx_fpOp == 6'h14) || (idEx_fpOp == 6'h15)) || (idEx_fpOp == 6'h16)) || (idEx_fpOp == 6'h17)) || (idEx_fpOp == 6'h0f));
  assign isFpMvW = (idEx_fpOp == 6'h0f);
  assign isFpMvX = (idEx_fpOp == 6'h0e);
  assign fpRmEx = ((idEx_fpRm == 3'b111) ? csrFile_1_io_frm : idEx_fpRm);
  assign fpUnit32_io_a = (isFpFromInt ? forwardRs1 : _zz_io_a);
  assign fpUnit32_io_b = {32'd0, fpFwdRs2};
  assign fpUnit32_io_c = {32'd0, fpFwdRs3};
  assign fpuResult = fpUnit32_io_result;
  assign fpuFlags = fpUnit32_io_flags;
  assign fpToIntResult = (isFpMvX ? _zz_fpToIntResult : fpuResult);
  assign fpResultIsSingle = ((isFpCompute && (! idEx_fpIntRd)) && (! idEx_fpFmt));
  assign fpToFpResult = fpuResult;
  assign exAluResultFp = (isFpCompute ? (idEx_fpIntRd ? fpToIntResult : fpToFpResult) : exAluResult);
  assign otherFreeze = (((memStall || fetchStall) || divStall) || mis32Stall);
  assign amoStall = 1'b0;
  assign amoDriveRead = 1'b0;
  assign amoDriveWrite = 1'b0;
  assign amoNewValue = 64'h0;
  assign amoOldValue = 64'h0;
  assign scSuccess = 1'b0;
  assign freezeAll = (otherFreeze || amoStall);
  assign intrTake = (((((((intrReq && (! exTrapEna)) && (! ctrlFlush)) && (! exMretRaw)) && (! csrMretStall)) && (! divInEx)) && (! stallData)) && (! freezeAll));
  always @(*) begin
    if(idEx_valid) begin
      intrEpc = idEx_pc;
    end else begin
      if(ifId_valid) begin
        intrEpc = ifId_pc;
      end else begin
        intrEpc = pcReg;
      end
    end
  end

  assign trapCommit = ((exTrapEna || intrTake) && (! freezeAll));
  assign exMret = (exMretRaw && (! freezeAll));
  assign trapEntry = (csrFile_1_io_mtvec & 64'hfffffffffffffffc);
  assign csrFile_1_io_csrWe = (memWb_valid && memWb_csrWe);
  assign csrFile_1_io_trapEpc = (intrTake ? intrEpc : idEx_pc);
  assign csrFile_1_io_trapCause = (intrTake ? 64'h8000000000000007 : exTrapCause);
  assign csrFile_1_io_trapTval = (intrTake ? 64'h0 : exTrapTval);
  assign csrFile_1_io_fpDirty = (memWb_valid && (memWb_fpWrite || (memWb_csrWe && (((memWb_csrAddr == 12'h001) || (memWb_csrAddr == 12'h002)) || (memWb_csrAddr == 12'h003)))));
  assign csrFile_1_io_fpFlagsWe = (memWb_valid && memWb_fpWrite);
  assign flushYounger = (((ctrlFlush || trapCommit) || exMret) || intrTake);
  assign bubbleEx = ((trapCommit || exMret) || csrMretStall);
  assign when_RiscvCore_l944 = (! freezeAll);
  assign when_RiscvCore_l951 = (stallData || csrMretStall);
  assign when_RiscvCore_l959 = (! freezeAll);
  assign when_RiscvCore_l960 = (stallData || csrMretStall);
  assign when_RiscvCore_l973 = ((! freezeAll) && (! csrMretStall));
  assign when_RiscvCore_l974 = (stallData || flushYounger);
  assign when_RiscvCore_l1020 = (! freezeAll);
  assign effMemWrite = (exMem_memWrite && (exMem_isSc ? scSuccess : 1'b1));
  assign normalRead = ((exMem_valid && exMem_memRead) && (! exMem_atomic));
  assign normalWrite = (exMem_valid && effMemWrite);
  assign io_dBus_valid = (((normalRead || normalWrite) || amoDriveRead) || amoDriveWrite);
  assign io_dBus_write = (normalWrite || amoDriveWrite);
  assign io_dBus_size = exMem_memSize;
  assign io_dBus_address = exMem_aluResult;
  assign storeOffset = exMem_aluResult[2 : 0];
  assign intStoreValue = (amoDriveWrite ? amoNewValue : exMem_rs2Data);
  assign storeValue = (exMem_fpStore ? exMem_fpRs2Data : intStoreValue);
  always @(*) begin
    io_dBus_writeData = 64'h0;
    case(exMem_memSize)
      2'b00 : begin
        io_dBus_writeData = _zz_io_dBus_writeData[63:0];
      end
      2'b01 : begin
        io_dBus_writeData = _zz_io_dBus_writeData_2[63:0];
      end
      2'b10 : begin
        io_dBus_writeData = _zz_io_dBus_writeData_4[63:0];
      end
      default : begin
        io_dBus_writeData = storeValue;
      end
    endcase
  end

  always @(*) begin
    io_dBus_writeMask = 8'h0;
    case(exMem_memSize)
      2'b00 : begin
        io_dBus_writeMask = _zz_io_dBus_writeMask;
      end
      2'b01 : begin
        io_dBus_writeMask = _zz_io_dBus_writeMask_2;
      end
      2'b10 : begin
        io_dBus_writeMask = _zz_io_dBus_writeMask_4;
      end
      default : begin
        io_dBus_writeMask = 8'hff;
      end
    endcase
  end

  assign _zz_loadResult = _zz__zz_loadResult[7 : 0];
  always @(*) begin
    case(exMem_memSize)
      2'b00 : begin
        loadResult = (exMem_memSign ? _zz_loadResult_3 : _zz_loadResult_5);
      end
      2'b01 : begin
        loadResult = (exMem_memSign ? _zz_loadResult_6 : _zz_loadResult_8);
      end
      2'b10 : begin
        loadResult = (exMem_memSign ? _zz_loadResult_9 : _zz_loadResult_11);
      end
      default : begin
        loadResult = io_dBus_readData;
      end
    endcase
  end

  assign _zz_loadResult_1 = _zz__zz_loadResult_1_1[15 : 0];
  assign _zz_loadResult_2 = _zz__zz_loadResult_2[31 : 0];
  assign fpLoadData = loadResult[31 : 0];
  assign when_RiscvCore_l1131 = (! freezeAll);
  assign regFile_io_writeEnable = (memWb_valid && memWb_regWrite);
  assign fpRegFile_io_writeData = memWb_wbData[31:0];
  assign fpRegFile_io_writeEnable = (memWb_valid && memWb_fpWrite);
  assign io_debugPc = pcReg;
  assign io_debugRegs_0 = regFile_io_debugRegs_0;
  assign io_debugRegs_1 = regFile_io_debugRegs_1;
  assign io_debugRegs_2 = regFile_io_debugRegs_2;
  assign io_debugRegs_3 = regFile_io_debugRegs_3;
  assign io_debugRegs_4 = regFile_io_debugRegs_4;
  assign io_debugRegs_5 = regFile_io_debugRegs_5;
  assign io_debugRegs_6 = regFile_io_debugRegs_6;
  assign io_debugRegs_7 = regFile_io_debugRegs_7;
  assign io_debugRegs_8 = regFile_io_debugRegs_8;
  assign io_debugRegs_9 = regFile_io_debugRegs_9;
  assign io_debugRegs_10 = regFile_io_debugRegs_10;
  assign io_debugRegs_11 = regFile_io_debugRegs_11;
  assign io_debugRegs_12 = regFile_io_debugRegs_12;
  assign io_debugRegs_13 = regFile_io_debugRegs_13;
  assign io_debugRegs_14 = regFile_io_debugRegs_14;
  assign io_debugRegs_15 = regFile_io_debugRegs_15;
  assign io_debugRegs_16 = regFile_io_debugRegs_16;
  assign io_debugRegs_17 = regFile_io_debugRegs_17;
  assign io_debugRegs_18 = regFile_io_debugRegs_18;
  assign io_debugRegs_19 = regFile_io_debugRegs_19;
  assign io_debugRegs_20 = regFile_io_debugRegs_20;
  assign io_debugRegs_21 = regFile_io_debugRegs_21;
  assign io_debugRegs_22 = regFile_io_debugRegs_22;
  assign io_debugRegs_23 = regFile_io_debugRegs_23;
  assign io_debugRegs_24 = regFile_io_debugRegs_24;
  assign io_debugRegs_25 = regFile_io_debugRegs_25;
  assign io_debugRegs_26 = regFile_io_debugRegs_26;
  assign io_debugRegs_27 = regFile_io_debugRegs_27;
  assign io_debugRegs_28 = regFile_io_debugRegs_28;
  assign io_debugRegs_29 = regFile_io_debugRegs_29;
  assign io_debugRegs_30 = regFile_io_debugRegs_30;
  assign io_debugRegs_31 = regFile_io_debugRegs_31;
  assign io_debugMepc = csrFile_1_io_debugMepc;
  assign io_debugMcause = csrFile_1_io_debugMcause;
  assign io_debugMode = csrFile_1_io_debugMode;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      pcReg <= 64'h0;
      ifId_valid <= 1'b0;
      ifId_pc <= 64'h0;
      ifId_instruction <= 32'h0;
      ifId_compressed <= 1'b0;
      idEx_valid <= 1'b0;
      idEx_pc <= 64'h0;
      idEx_compressed <= 1'b0;
      idEx_regWrite <= 1'b0;
      idEx_aluSrc <= 1'b0;
      idEx_wbSel <= 3'b000;
      idEx_branch <= 1'b0;
      idEx_jump <= 1'b0;
      idEx_jalr <= 1'b0;
      idEx_aluOp <= AluOp_ADD;
      idEx_branchType <= BranchOp_NONE;
      idEx_aluASrc <= 2'b00;
      idEx_memRead <= 1'b0;
      idEx_memWrite <= 1'b0;
      idEx_memSize <= 2'b00;
      idEx_memSign <= 1'b0;
      idEx_atomic <= 1'b0;
      idEx_isLr <= 1'b0;
      idEx_isSc <= 1'b0;
      idEx_amoOp <= 5'h0;
      idEx_fp <= 1'b0;
      idEx_fpWrite <= 1'b0;
      idEx_fpLoad <= 1'b0;
      idEx_fpStore <= 1'b0;
      idEx_fpIntRd <= 1'b0;
      idEx_fpOp <= 6'h0;
      idEx_fpRm <= 3'b000;
      idEx_fpFmt <= 1'b0;
      idEx_rs1 <= 5'h0;
      idEx_rs2 <= 5'h0;
      idEx_rs3 <= 5'h0;
      idEx_rd <= 5'h0;
      idEx_imm <= 64'h0;
      idEx_illegal <= 1'b0;
      idEx_csrOp <= CsrOp_NONE;
      idEx_csrImm <= 1'b0;
      idEx_csrAddr <= 12'h0;
      idEx_csrWe <= 1'b0;
      idEx_sysOp <= SysOp_NONE;
      exMem_valid <= 1'b0;
      exMem_memRead <= 1'b0;
      exMem_memWrite <= 1'b0;
      exMem_memSize <= 2'b00;
      exMem_memSign <= 1'b0;
      exMem_atomic <= 1'b0;
      exMem_isLr <= 1'b0;
      exMem_isSc <= 1'b0;
      exMem_amoOp <= 5'h0;
      exMem_fp <= 1'b0;
      exMem_fpWrite <= 1'b0;
      exMem_fpLoad <= 1'b0;
      exMem_fpStore <= 1'b0;
      exMem_fpFlags <= 5'h0;
      exMem_fpRs2Data <= 64'h0;
      exMem_regWrite <= 1'b0;
      exMem_rd <= 5'h0;
      exMem_wbSel <= 3'b000;
      exMem_aluResult <= 64'h0;
      exMem_rs2Data <= 64'h0;
      exMem_csrOp <= CsrOp_NONE;
      exMem_csrWe <= 1'b0;
      exMem_csrAddr <= 12'h0;
      exMem_csrWrData <= 64'h0;
      memWb_valid <= 1'b0;
      memWb_regWrite <= 1'b0;
      memWb_rd <= 5'h0;
      memWb_wbSel <= 3'b000;
      memWb_wbData <= 64'h0;
      memWb_fp <= 1'b0;
      memWb_fpWrite <= 1'b0;
      memWb_fpFlags <= 5'h0;
      memWb_csrOp <= CsrOp_NONE;
      memWb_csrWe <= 1'b0;
      memWb_csrAddr <= 12'h0;
      memWb_csrWrData <= 64'h0;
    end else begin
      if(when_RiscvCore_l944) begin
        if(trapCommit) begin
          pcReg <= trapEntry;
        end else begin
          if(exMret) begin
            pcReg <= csrFile_1_io_mepc;
          end else begin
            if(ctrlFlush) begin
              pcReg <= ctrlTarget;
            end else begin
              if(when_RiscvCore_l951) begin
                pcReg <= pcReg;
              end else begin
                pcReg <= (pcReg + _zz_pcReg);
              end
            end
          end
        end
      end
      if(when_RiscvCore_l959) begin
        if(!when_RiscvCore_l960) begin
          if(flushYounger) begin
            ifId_valid <= 1'b0;
          end else begin
            ifId_pc <= pcReg;
            ifId_instruction <= fetchInstr;
            ifId_compressed <= fetchCompressed;
            ifId_valid <= 1'b1;
          end
        end
      end
      if(when_RiscvCore_l973) begin
        if(when_RiscvCore_l974) begin
          idEx_valid <= 1'b0;
        end else begin
          idEx_valid <= ifId_valid;
        end
        idEx_pc <= ifId_pc;
        idEx_compressed <= ifId_compressed;
        idEx_regWrite <= decoder_1_io_output_regWrite;
        idEx_aluSrc <= decoder_1_io_output_aluSrc;
        idEx_wbSel <= decoder_1_io_output_wbSel;
        idEx_branch <= decoder_1_io_output_branch;
        idEx_jump <= decoder_1_io_output_jump;
        idEx_jalr <= decoder_1_io_output_jalr;
        idEx_aluOp <= decoder_1_io_output_aluOp;
        idEx_branchType <= decoder_1_io_output_branchType;
        idEx_aluASrc <= decoder_1_io_output_aluASrc;
        idEx_memRead <= decoder_1_io_output_memRead;
        idEx_memWrite <= decoder_1_io_output_memWrite;
        idEx_memSize <= decoder_1_io_output_memSize;
        idEx_memSign <= decoder_1_io_output_memSign;
        idEx_atomic <= decoder_1_io_output_atomic;
        idEx_isLr <= decoder_1_io_output_isLr;
        idEx_isSc <= decoder_1_io_output_isSc;
        idEx_amoOp <= decoder_1_io_output_amoOp;
        idEx_fp <= decoder_1_io_output_fp;
        idEx_fpWrite <= decoder_1_io_output_fpWrite;
        idEx_fpLoad <= decoder_1_io_output_fpLoad;
        idEx_fpStore <= decoder_1_io_output_fpStore;
        idEx_fpIntRd <= decoder_1_io_output_fpIntRd;
        idEx_fpOp <= decoder_1_io_output_fpOp;
        idEx_fpRm <= decoder_1_io_output_fpRm;
        idEx_fpFmt <= decoder_1_io_output_fpFmt;
        idEx_rs1 <= decoder_1_io_output_rs1;
        idEx_rs2 <= decoder_1_io_output_rs2;
        idEx_rs3 <= decoder_1_io_output_rs3;
        idEx_rd <= decoder_1_io_output_rd;
        idEx_imm <= decoder_1_io_output_imm;
        idEx_illegal <= decoder_1_io_output_illegal;
        idEx_csrOp <= decoder_1_io_output_csrOp;
        idEx_csrImm <= decoder_1_io_output_csrImm;
        idEx_csrAddr <= decoder_1_io_output_csrAddr;
        idEx_csrWe <= decoder_1_io_output_csrWe;
        idEx_sysOp <= decoder_1_io_output_sysOp;
      end
      if(when_RiscvCore_l1020) begin
        if(bubbleEx) begin
          exMem_valid <= 1'b0;
        end else begin
          exMem_valid <= idEx_valid;
        end
        exMem_memRead <= idEx_memRead;
        exMem_memWrite <= idEx_memWrite;
        exMem_memSize <= idEx_memSize;
        exMem_memSign <= idEx_memSign;
        exMem_atomic <= idEx_atomic;
        exMem_isLr <= idEx_isLr;
        exMem_isSc <= idEx_isSc;
        exMem_amoOp <= idEx_amoOp;
        exMem_fp <= idEx_fp;
        exMem_fpWrite <= idEx_fpWrite;
        exMem_fpLoad <= idEx_fpLoad;
        exMem_fpStore <= idEx_fpStore;
        exMem_fpFlags <= fpuFlags;
        exMem_fpRs2Data <= {32'd0, fpFwdRs2};
        exMem_regWrite <= idEx_regWrite;
        exMem_rd <= idEx_rd;
        exMem_wbSel <= idEx_wbSel;
        exMem_aluResult <= exAluResultFp;
        exMem_rs2Data <= forwardRs2;
        exMem_csrOp <= idEx_csrOp;
        exMem_csrWe <= idEx_csrWe;
        exMem_csrAddr <= idEx_csrAddr;
        exMem_csrWrData <= csrWrDataEx;
      end
      if(when_RiscvCore_l1131) begin
        memWb_valid <= exMem_valid;
        memWb_regWrite <= exMem_regWrite;
        memWb_rd <= exMem_rd;
        memWb_wbSel <= exMem_wbSel;
        memWb_fp <= exMem_fp;
        memWb_fpWrite <= exMem_fpWrite;
        memWb_fpFlags <= exMem_fpFlags;
        if(exMem_fpLoad) begin
          memWb_wbData <= {32'd0, fpLoadData};
        end else begin
          if(exMem_atomic) begin
            memWb_wbData <= (exMem_isSc ? (scSuccess ? 64'h0 : 64'h0000000000000001) : amoOldValue);
          end else begin
            if(exMem_memRead) begin
              memWb_wbData <= loadResult;
            end else begin
              memWb_wbData <= exMem_aluResult;
            end
          end
        end
        memWb_csrOp <= exMem_csrOp;
        memWb_csrWe <= exMem_csrWe;
        memWb_csrAddr <= exMem_csrAddr;
        memWb_csrWrData <= exMem_csrWrData;
      end
    end
  end


endmodule

module Alu (
  input  wire [63:0]   io_a,
  input  wire [63:0]   io_b,
  input  wire [6:0]    io_op,
  output wire [63:0]   io_result
);
  localparam AluOp_ADD = 7'd0;
  localparam AluOp_SUB = 7'd1;
  localparam AluOp_SLL_1 = 7'd2;
  localparam AluOp_SLT = 7'd3;
  localparam AluOp_SLTU = 7'd4;
  localparam AluOp_XOR_1 = 7'd5;
  localparam AluOp_SRL_1 = 7'd6;
  localparam AluOp_SRA_1 = 7'd7;
  localparam AluOp_OR_1 = 7'd8;
  localparam AluOp_AND_1 = 7'd9;
  localparam AluOp_ADDW = 7'd10;
  localparam AluOp_SUBW = 7'd11;
  localparam AluOp_SLLW = 7'd12;
  localparam AluOp_SRLW = 7'd13;
  localparam AluOp_SRAW = 7'd14;
  localparam AluOp_MUL = 7'd15;
  localparam AluOp_MULH = 7'd16;
  localparam AluOp_MULHSU = 7'd17;
  localparam AluOp_MULHU = 7'd18;
  localparam AluOp_DIV = 7'd19;
  localparam AluOp_DIVU = 7'd20;
  localparam AluOp_REM_1 = 7'd21;
  localparam AluOp_REMU = 7'd22;
  localparam AluOp_MULW = 7'd23;
  localparam AluOp_DIVW = 7'd24;
  localparam AluOp_DIVUW = 7'd25;
  localparam AluOp_REMW = 7'd26;
  localparam AluOp_REMUW = 7'd27;
  localparam AluOp_ANDN = 7'd28;
  localparam AluOp_ORN = 7'd29;
  localparam AluOp_XNOR_1 = 7'd30;
  localparam AluOp_CLZ = 7'd31;
  localparam AluOp_CTZ = 7'd32;
  localparam AluOp_CPOP = 7'd33;
  localparam AluOp_SEXTB = 7'd34;
  localparam AluOp_SEXTH = 7'd35;
  localparam AluOp_ZEXTH = 7'd36;
  localparam AluOp_ORCB = 7'd37;
  localparam AluOp_REV8 = 7'd38;
  localparam AluOp_ROL_1 = 7'd39;
  localparam AluOp_ROR_1 = 7'd40;
  localparam AluOp_MIN = 7'd41;
  localparam AluOp_MINU = 7'd42;
  localparam AluOp_MAX = 7'd43;
  localparam AluOp_MAXU = 7'd44;
  localparam AluOp_BSET = 7'd45;
  localparam AluOp_BCLR = 7'd46;
  localparam AluOp_BINV = 7'd47;
  localparam AluOp_BEXT = 7'd48;
  localparam AluOp_SH1ADD = 7'd49;
  localparam AluOp_SH2ADD = 7'd50;
  localparam AluOp_SH3ADD = 7'd51;
  localparam AluOp_ADDUW = 7'd52;
  localparam AluOp_SH1ADDUW = 7'd53;
  localparam AluOp_SH2ADDUW = 7'd54;
  localparam AluOp_SH3ADDUW = 7'd55;
  localparam AluOp_SLLIUW = 7'd56;
  localparam AluOp_CLMUL = 7'd57;
  localparam AluOp_CLMULH = 7'd58;
  localparam AluOp_CLMULR = 7'd59;
  localparam AluOp_CLZW = 7'd60;
  localparam AluOp_CTZW = 7'd61;
  localparam AluOp_CPOPW = 7'd62;
  localparam AluOp_ROLW = 7'd63;
  localparam AluOp_RORW = 7'd64;

  wire       [126:0]  _zz_bitOneHot;
  wire       [31:0]   _zz_aZext;
  wire       [127:0]  _zz_clmulFull;
  wire       [127:0]  _zz_clmulFull_1;
  wire       [127:0]  _zz_clmulFull_2;
  wire       [127:0]  _zz_clmulFull_3;
  wire       [127:0]  _zz_clmulFull_4;
  wire       [127:0]  _zz_clmulFull_5;
  wire       [127:0]  _zz_clmulFull_6;
  wire       [127:0]  _zz_clmulFull_7;
  wire       [127:0]  _zz_clmulFull_8;
  wire       [127:0]  _zz_clmulFull_9;
  wire       [127:0]  _zz_clmulFull_10;
  wire       [64:0]   _zz_clmulFull_11;
  wire                _zz_clmulFull_12;
  wire       [127:0]  _zz_clmulFull_13;
  wire       [65:0]   _zz_clmulFull_14;
  wire       [127:0]  _zz_clmulFull_15;
  wire       [127:0]  _zz_clmulFull_16;
  wire       [66:0]   _zz_clmulFull_17;
  wire       [127:0]  _zz_clmulFull_18;
  wire       [67:0]   _zz_clmulFull_19;
  wire       [127:0]  _zz_clmulFull_20;
  wire       [68:0]   _zz_clmulFull_21;
  wire       [127:0]  _zz_clmulFull_22;
  wire       [69:0]   _zz_clmulFull_23;
  wire       [127:0]  _zz_clmulFull_24;
  wire       [70:0]   _zz_clmulFull_25;
  wire       [127:0]  _zz_clmulFull_26;
  wire       [71:0]   _zz_clmulFull_27;
  wire       [127:0]  _zz_clmulFull_28;
  wire       [127:0]  _zz_clmulFull_29;
  wire       [72:0]   _zz_clmulFull_30;
  wire                _zz_clmulFull_31;
  wire       [127:0]  _zz_clmulFull_32;
  wire       [73:0]   _zz_clmulFull_33;
  wire       [127:0]  _zz_clmulFull_34;
  wire       [127:0]  _zz_clmulFull_35;
  wire       [74:0]   _zz_clmulFull_36;
  wire       [127:0]  _zz_clmulFull_37;
  wire       [75:0]   _zz_clmulFull_38;
  wire       [127:0]  _zz_clmulFull_39;
  wire       [76:0]   _zz_clmulFull_40;
  wire       [127:0]  _zz_clmulFull_41;
  wire       [77:0]   _zz_clmulFull_42;
  wire       [127:0]  _zz_clmulFull_43;
  wire       [78:0]   _zz_clmulFull_44;
  wire       [127:0]  _zz_clmulFull_45;
  wire       [79:0]   _zz_clmulFull_46;
  wire       [127:0]  _zz_clmulFull_47;
  wire       [127:0]  _zz_clmulFull_48;
  wire       [80:0]   _zz_clmulFull_49;
  wire                _zz_clmulFull_50;
  wire       [127:0]  _zz_clmulFull_51;
  wire       [81:0]   _zz_clmulFull_52;
  wire       [127:0]  _zz_clmulFull_53;
  wire       [127:0]  _zz_clmulFull_54;
  wire       [82:0]   _zz_clmulFull_55;
  wire       [127:0]  _zz_clmulFull_56;
  wire       [83:0]   _zz_clmulFull_57;
  wire       [127:0]  _zz_clmulFull_58;
  wire       [84:0]   _zz_clmulFull_59;
  wire       [127:0]  _zz_clmulFull_60;
  wire       [85:0]   _zz_clmulFull_61;
  wire       [127:0]  _zz_clmulFull_62;
  wire       [86:0]   _zz_clmulFull_63;
  wire       [127:0]  _zz_clmulFull_64;
  wire       [87:0]   _zz_clmulFull_65;
  wire       [127:0]  _zz_clmulFull_66;
  wire       [127:0]  _zz_clmulFull_67;
  wire       [88:0]   _zz_clmulFull_68;
  wire                _zz_clmulFull_69;
  wire       [127:0]  _zz_clmulFull_70;
  wire       [89:0]   _zz_clmulFull_71;
  wire       [127:0]  _zz_clmulFull_72;
  wire       [127:0]  _zz_clmulFull_73;
  wire       [90:0]   _zz_clmulFull_74;
  wire       [127:0]  _zz_clmulFull_75;
  wire       [91:0]   _zz_clmulFull_76;
  wire       [127:0]  _zz_clmulFull_77;
  wire       [92:0]   _zz_clmulFull_78;
  wire       [127:0]  _zz_clmulFull_79;
  wire       [93:0]   _zz_clmulFull_80;
  wire       [127:0]  _zz_clmulFull_81;
  wire       [94:0]   _zz_clmulFull_82;
  wire       [127:0]  _zz_clmulFull_83;
  wire       [95:0]   _zz_clmulFull_84;
  wire       [127:0]  _zz_clmulFull_85;
  wire       [127:0]  _zz_clmulFull_86;
  wire       [96:0]   _zz_clmulFull_87;
  wire                _zz_clmulFull_88;
  wire       [127:0]  _zz_clmulFull_89;
  wire       [97:0]   _zz_clmulFull_90;
  wire       [127:0]  _zz_clmulFull_91;
  wire       [127:0]  _zz_clmulFull_92;
  wire       [98:0]   _zz_clmulFull_93;
  wire       [127:0]  _zz_clmulFull_94;
  wire       [99:0]   _zz_clmulFull_95;
  wire       [127:0]  _zz_clmulFull_96;
  wire       [100:0]  _zz_clmulFull_97;
  wire       [127:0]  _zz_clmulFull_98;
  wire       [101:0]  _zz_clmulFull_99;
  wire       [127:0]  _zz_clmulFull_100;
  wire       [102:0]  _zz_clmulFull_101;
  wire       [127:0]  _zz_clmulFull_102;
  wire       [103:0]  _zz_clmulFull_103;
  wire       [127:0]  _zz_clmulFull_104;
  wire       [127:0]  _zz_clmulFull_105;
  wire       [104:0]  _zz_clmulFull_106;
  wire                _zz_clmulFull_107;
  wire       [127:0]  _zz_clmulFull_108;
  wire       [105:0]  _zz_clmulFull_109;
  wire       [127:0]  _zz_clmulFull_110;
  wire       [127:0]  _zz_clmulFull_111;
  wire       [106:0]  _zz_clmulFull_112;
  wire       [127:0]  _zz_clmulFull_113;
  wire       [107:0]  _zz_clmulFull_114;
  wire       [127:0]  _zz_clmulFull_115;
  wire       [108:0]  _zz_clmulFull_116;
  wire       [127:0]  _zz_clmulFull_117;
  wire       [109:0]  _zz_clmulFull_118;
  wire       [127:0]  _zz_clmulFull_119;
  wire       [110:0]  _zz_clmulFull_120;
  wire       [127:0]  _zz_clmulFull_121;
  wire       [111:0]  _zz_clmulFull_122;
  wire       [127:0]  _zz_clmulFull_123;
  wire       [127:0]  _zz_clmulFull_124;
  wire       [112:0]  _zz_clmulFull_125;
  wire                _zz_clmulFull_126;
  wire       [127:0]  _zz_clmulFull_127;
  wire       [113:0]  _zz_clmulFull_128;
  wire       [127:0]  _zz_clmulFull_129;
  wire       [127:0]  _zz_clmulFull_130;
  wire       [114:0]  _zz_clmulFull_131;
  wire       [127:0]  _zz_clmulFull_132;
  wire       [115:0]  _zz_clmulFull_133;
  wire       [127:0]  _zz_clmulFull_134;
  wire       [116:0]  _zz_clmulFull_135;
  wire       [127:0]  _zz_clmulFull_136;
  wire       [117:0]  _zz_clmulFull_137;
  wire       [127:0]  _zz_clmulFull_138;
  wire       [118:0]  _zz_clmulFull_139;
  wire       [127:0]  _zz_clmulFull_140;
  wire       [119:0]  _zz_clmulFull_141;
  wire       [127:0]  _zz_clmulFull_142;
  wire       [127:0]  _zz_clmulFull_143;
  wire       [120:0]  _zz_clmulFull_144;
  wire                _zz_clmulFull_145;
  wire       [127:0]  _zz_clmulFull_146;
  wire       [121:0]  _zz_clmulFull_147;
  wire       [127:0]  _zz_clmulFull_148;
  wire       [127:0]  _zz_clmulFull_149;
  wire       [122:0]  _zz_clmulFull_150;
  wire       [127:0]  _zz_clmulFull_151;
  wire       [123:0]  _zz_clmulFull_152;
  wire       [127:0]  _zz_clmulFull_153;
  wire       [124:0]  _zz_clmulFull_154;
  wire       [127:0]  _zz_clmulFull_155;
  wire       [125:0]  _zz_clmulFull_156;
  wire       [127:0]  _zz_clmulFull_157;
  wire       [126:0]  _zz_clmulFull_158;
  wire       [64:0]   _zz_bUE;
  wire       [127:0]  _zz_mulLow;
  wire       [127:0]  _zz_mulHighS;
  wire       [129:0]  _zz_mulHighSu;
  wire       [127:0]  _zz_mulHighU;
  wire       [63:0]   _zz_result_195;
  wire       [63:0]   _zz_result_196;
  wire       [63:0]   _zz_result_197;
  wire       [126:0]  _zz_result_198;
  wire       [63:0]   _zz_result_199;
  wire       [63:0]   _zz_result_200;
  wire       [63:0]   _zz_result_201;
  wire       [31:0]   _zz_result_202;
  wire       [63:0]   _zz_result_203;
  wire       [31:0]   _zz_result_204;
  wire       [63:0]   _zz_result_205;
  wire       [31:0]   _zz_result_206;
  wire       [31:0]   _zz_result_207;
  wire       [62:0]   _zz_result_208;
  wire       [63:0]   _zz_result_209;
  wire       [31:0]   _zz_result_210;
  wire       [31:0]   _zz_result_211;
  wire       [63:0]   _zz_result_212;
  wire       [31:0]   _zz_result_213;
  wire       [63:0]   _zz_result_214;
  wire       [31:0]   _zz_result_215;
  wire       [63:0]   _zz_result_216;
  wire       [63:0]   _zz_result_217;
  wire       [6:0]    _zz_result_218;
  wire                _zz_result_219;
  wire                _zz_result_220;
  wire       [6:0]    _zz_result_221;
  wire       [6:0]    _zz_result_222;
  wire                _zz_result_223;
  wire                _zz_result_224;
  wire       [6:0]    _zz_result_225;
  wire       [6:0]    _zz_result_226;
  wire                _zz_result_227;
  wire                _zz_result_228;
  wire       [6:0]    _zz_result_229;
  wire       [6:0]    _zz_result_230;
  wire                _zz_result_231;
  wire                _zz_result_232;
  wire       [6:0]    _zz_result_233;
  wire       [6:0]    _zz_result_234;
  wire                _zz_result_235;
  wire                _zz_result_236;
  wire       [6:0]    _zz_result_237;
  wire       [6:0]    _zz_result_238;
  wire                _zz_result_239;
  wire                _zz_result_240;
  wire       [6:0]    _zz_result_241;
  wire       [6:0]    _zz_result_242;
  wire                _zz_result_243;
  wire                _zz_result_244;
  wire       [6:0]    _zz_result_245;
  wire       [6:0]    _zz_result_246;
  wire                _zz_result_247;
  wire                _zz_result_248;
  wire       [6:0]    _zz_result_249;
  wire       [6:0]    _zz_result_250;
  wire                _zz_result_251;
  wire                _zz_result_252;
  wire       [6:0]    _zz_result_253;
  wire       [6:0]    _zz_result_254;
  wire       [63:0]   _zz_result_255;
  wire       [6:0]    _zz_result_256;
  wire                _zz_result_257;
  wire                _zz_result_258;
  wire       [6:0]    _zz_result_259;
  wire       [6:0]    _zz_result_260;
  wire                _zz_result_261;
  wire                _zz_result_262;
  wire       [6:0]    _zz_result_263;
  wire       [6:0]    _zz_result_264;
  wire                _zz_result_265;
  wire                _zz_result_266;
  wire       [6:0]    _zz_result_267;
  wire       [6:0]    _zz_result_268;
  wire                _zz_result_269;
  wire                _zz_result_270;
  wire       [6:0]    _zz_result_271;
  wire       [6:0]    _zz_result_272;
  wire                _zz_result_273;
  wire                _zz_result_274;
  wire       [6:0]    _zz_result_275;
  wire       [6:0]    _zz_result_276;
  wire                _zz_result_277;
  wire                _zz_result_278;
  wire       [6:0]    _zz_result_279;
  wire       [6:0]    _zz_result_280;
  wire                _zz_result_281;
  wire                _zz_result_282;
  wire       [6:0]    _zz_result_283;
  wire       [6:0]    _zz_result_284;
  wire                _zz_result_285;
  wire                _zz_result_286;
  wire       [6:0]    _zz_result_287;
  wire       [6:0]    _zz_result_288;
  wire                _zz_result_289;
  wire                _zz_result_290;
  wire       [6:0]    _zz_result_291;
  wire       [6:0]    _zz_result_292;
  wire       [63:0]   _zz_result_293;
  wire       [6:0]    _zz_result_294;
  wire       [7:0]    _zz_result_295;
  wire       [6:0]    _zz_result_296;
  wire       [7:0]    _zz_result_297;
  wire       [6:0]    _zz_result_298;
  wire       [7:0]    _zz_result_299;
  wire       [6:0]    _zz_result_300;
  wire       [7:0]    _zz_result_301;
  wire       [6:0]    _zz_result_302;
  wire       [7:0]    _zz_result_303;
  wire       [6:0]    _zz_result_304;
  wire       [7:0]    _zz_result_305;
  wire       [6:0]    _zz_result_306;
  wire       [7:0]    _zz_result_307;
  wire       [6:0]    _zz_result_308;
  wire       [7:0]    _zz_result_309;
  wire       [6:0]    _zz_result_310;
  wire       [7:0]    _zz_result_311;
  wire       [6:0]    _zz_result_312;
  wire       [7:0]    _zz_result_313;
  wire       [6:0]    _zz_result_314;
  wire       [7:0]    _zz_result_315;
  wire       [6:0]    _zz_result_316;
  wire       [7:0]    _zz_result_317;
  wire       [6:0]    _zz_result_318;
  wire       [7:0]    _zz_result_319;
  wire       [6:0]    _zz_result_320;
  wire       [7:0]    _zz_result_321;
  wire       [6:0]    _zz_result_322;
  wire       [7:0]    _zz_result_323;
  wire       [6:0]    _zz_result_324;
  wire       [7:0]    _zz_result_325;
  wire       [6:0]    _zz_result_326;
  wire       [7:0]    _zz_result_327;
  wire       [6:0]    _zz_result_328;
  wire       [7:0]    _zz_result_329;
  wire       [6:0]    _zz_result_330;
  wire       [7:0]    _zz_result_331;
  wire       [6:0]    _zz_result_332;
  wire       [7:0]    _zz_result_333;
  wire       [6:0]    _zz_result_334;
  wire       [7:0]    _zz_result_335;
  wire       [6:0]    _zz_result_336;
  wire       [7:0]    _zz_result_337;
  wire       [6:0]    _zz_result_338;
  wire       [7:0]    _zz_result_339;
  wire       [6:0]    _zz_result_340;
  wire       [7:0]    _zz_result_341;
  wire       [6:0]    _zz_result_342;
  wire       [7:0]    _zz_result_343;
  wire       [6:0]    _zz_result_344;
  wire       [7:0]    _zz_result_345;
  wire       [6:0]    _zz_result_346;
  wire       [7:0]    _zz_result_347;
  wire       [6:0]    _zz_result_348;
  wire       [7:0]    _zz_result_349;
  wire       [6:0]    _zz_result_350;
  wire       [7:0]    _zz_result_351;
  wire       [6:0]    _zz_result_352;
  wire       [7:0]    _zz_result_353;
  wire       [6:0]    _zz_result_354;
  wire       [7:0]    _zz_result_355;
  wire       [6:0]    _zz_result_356;
  wire       [7:0]    _zz_result_357;
  wire       [6:0]    _zz_result_358;
  wire       [7:0]    _zz_result_359;
  wire       [6:0]    _zz_result_360;
  wire       [7:0]    _zz_result_361;
  wire       [6:0]    _zz_result_362;
  wire       [7:0]    _zz_result_363;
  wire       [6:0]    _zz_result_364;
  wire       [7:0]    _zz_result_365;
  wire       [6:0]    _zz_result_366;
  wire       [7:0]    _zz_result_367;
  wire       [6:0]    _zz_result_368;
  wire       [7:0]    _zz_result_369;
  wire       [6:0]    _zz_result_370;
  wire       [7:0]    _zz_result_371;
  wire       [6:0]    _zz_result_372;
  wire       [7:0]    _zz_result_373;
  wire       [6:0]    _zz_result_374;
  wire       [7:0]    _zz_result_375;
  wire       [6:0]    _zz_result_376;
  wire       [7:0]    _zz_result_377;
  wire       [6:0]    _zz_result_378;
  wire       [7:0]    _zz_result_379;
  wire       [6:0]    _zz_result_380;
  wire       [7:0]    _zz_result_381;
  wire       [6:0]    _zz_result_382;
  wire       [7:0]    _zz_result_383;
  wire       [6:0]    _zz_result_384;
  wire       [7:0]    _zz_result_385;
  wire       [6:0]    _zz_result_386;
  wire       [7:0]    _zz_result_387;
  wire       [6:0]    _zz_result_388;
  wire       [7:0]    _zz_result_389;
  wire       [6:0]    _zz_result_390;
  wire       [7:0]    _zz_result_391;
  wire       [6:0]    _zz_result_392;
  wire       [7:0]    _zz_result_393;
  wire       [6:0]    _zz_result_394;
  wire       [7:0]    _zz_result_395;
  wire       [6:0]    _zz_result_396;
  wire       [7:0]    _zz_result_397;
  wire       [6:0]    _zz_result_398;
  wire       [7:0]    _zz_result_399;
  wire       [6:0]    _zz_result_400;
  wire       [7:0]    _zz_result_401;
  wire       [6:0]    _zz_result_402;
  wire       [7:0]    _zz_result_403;
  wire       [6:0]    _zz_result_404;
  wire       [7:0]    _zz_result_405;
  wire       [6:0]    _zz_result_406;
  wire       [7:0]    _zz_result_407;
  wire       [6:0]    _zz_result_408;
  wire       [7:0]    _zz_result_409;
  wire       [6:0]    _zz_result_410;
  wire       [7:0]    _zz_result_411;
  wire       [6:0]    _zz_result_412;
  wire       [7:0]    _zz_result_413;
  wire       [6:0]    _zz_result_414;
  wire       [7:0]    _zz_result_415;
  wire       [6:0]    _zz_result_416;
  wire       [7:0]    _zz_result_417;
  wire       [6:0]    _zz_result_418;
  wire       [7:0]    _zz_result_419;
  wire       [6:0]    _zz_result_420;
  wire       [7:0]    _zz_result_421;
  wire       [7:0]    _zz_result_422;
  wire       [1:0]    _zz_result_423;
  wire       [7:0]    _zz_result_424;
  wire       [1:0]    _zz_result_425;
  wire       [7:0]    _zz_result_426;
  wire       [1:0]    _zz_result_427;
  wire       [7:0]    _zz_result_428;
  wire       [1:0]    _zz_result_429;
  wire       [7:0]    _zz_result_430;
  wire       [1:0]    _zz_result_431;
  wire       [7:0]    _zz_result_432;
  wire       [1:0]    _zz_result_433;
  wire       [7:0]    _zz_result_434;
  wire       [1:0]    _zz_result_435;
  wire       [7:0]    _zz_result_436;
  wire       [1:0]    _zz_result_437;
  wire       [7:0]    _zz_result_438;
  wire       [1:0]    _zz_result_439;
  wire       [7:0]    _zz_result_440;
  wire       [1:0]    _zz_result_441;
  wire       [7:0]    _zz_result_442;
  wire       [1:0]    _zz_result_443;
  wire       [7:0]    _zz_result_444;
  wire       [1:0]    _zz_result_445;
  wire       [7:0]    _zz_result_446;
  wire       [1:0]    _zz_result_447;
  wire       [7:0]    _zz_result_448;
  wire       [1:0]    _zz_result_449;
  wire       [7:0]    _zz_result_450;
  wire       [1:0]    _zz_result_451;
  wire       [7:0]    _zz_result_452;
  wire       [1:0]    _zz_result_453;
  wire       [7:0]    _zz_result_454;
  wire       [1:0]    _zz_result_455;
  wire       [7:0]    _zz_result_456;
  wire       [1:0]    _zz_result_457;
  wire       [7:0]    _zz_result_458;
  wire       [1:0]    _zz_result_459;
  wire       [7:0]    _zz_result_460;
  wire       [1:0]    _zz_result_461;
  wire       [7:0]    _zz_result_462;
  wire       [1:0]    _zz_result_463;
  wire       [7:0]    _zz_result_464;
  wire       [1:0]    _zz_result_465;
  wire       [7:0]    _zz_result_466;
  wire       [1:0]    _zz_result_467;
  wire       [7:0]    _zz_result_468;
  wire       [1:0]    _zz_result_469;
  wire       [7:0]    _zz_result_470;
  wire       [1:0]    _zz_result_471;
  wire       [7:0]    _zz_result_472;
  wire       [1:0]    _zz_result_473;
  wire       [7:0]    _zz_result_474;
  wire       [1:0]    _zz_result_475;
  wire       [7:0]    _zz_result_476;
  wire       [1:0]    _zz_result_477;
  wire       [7:0]    _zz_result_478;
  wire       [1:0]    _zz_result_479;
  wire       [7:0]    _zz_result_480;
  wire       [1:0]    _zz_result_481;
  wire       [7:0]    _zz_result_482;
  wire       [1:0]    _zz_result_483;
  wire       [7:0]    _zz_result_484;
  wire       [1:0]    _zz_result_485;
  wire       [7:0]    _zz_result_486;
  wire       [1:0]    _zz_result_487;
  wire       [7:0]    _zz_result_488;
  wire       [1:0]    _zz_result_489;
  wire       [7:0]    _zz_result_490;
  wire       [1:0]    _zz_result_491;
  wire       [7:0]    _zz_result_492;
  wire       [1:0]    _zz_result_493;
  wire       [7:0]    _zz_result_494;
  wire       [1:0]    _zz_result_495;
  wire       [7:0]    _zz_result_496;
  wire       [1:0]    _zz_result_497;
  wire       [7:0]    _zz_result_498;
  wire       [1:0]    _zz_result_499;
  wire       [7:0]    _zz_result_500;
  wire       [1:0]    _zz_result_501;
  wire       [7:0]    _zz_result_502;
  wire       [1:0]    _zz_result_503;
  wire       [7:0]    _zz_result_504;
  wire       [1:0]    _zz_result_505;
  wire       [7:0]    _zz_result_506;
  wire       [1:0]    _zz_result_507;
  wire       [7:0]    _zz_result_508;
  wire       [1:0]    _zz_result_509;
  wire       [7:0]    _zz_result_510;
  wire       [1:0]    _zz_result_511;
  wire       [7:0]    _zz_result_512;
  wire       [1:0]    _zz_result_513;
  wire       [7:0]    _zz_result_514;
  wire       [1:0]    _zz_result_515;
  wire       [7:0]    _zz_result_516;
  wire       [1:0]    _zz_result_517;
  wire       [7:0]    _zz_result_518;
  wire       [1:0]    _zz_result_519;
  wire       [7:0]    _zz_result_520;
  wire       [1:0]    _zz_result_521;
  wire       [7:0]    _zz_result_522;
  wire       [1:0]    _zz_result_523;
  wire       [7:0]    _zz_result_524;
  wire       [1:0]    _zz_result_525;
  wire       [7:0]    _zz_result_526;
  wire       [1:0]    _zz_result_527;
  wire       [7:0]    _zz_result_528;
  wire       [1:0]    _zz_result_529;
  wire       [7:0]    _zz_result_530;
  wire       [1:0]    _zz_result_531;
  wire       [7:0]    _zz_result_532;
  wire       [1:0]    _zz_result_533;
  wire       [7:0]    _zz_result_534;
  wire       [1:0]    _zz_result_535;
  wire       [7:0]    _zz_result_536;
  wire       [1:0]    _zz_result_537;
  wire       [7:0]    _zz_result_538;
  wire       [1:0]    _zz_result_539;
  wire       [7:0]    _zz_result_540;
  wire       [1:0]    _zz_result_541;
  wire       [7:0]    _zz_result_542;
  wire       [1:0]    _zz_result_543;
  wire       [7:0]    _zz_result_544;
  wire       [1:0]    _zz_result_545;
  wire       [7:0]    _zz_result_546;
  wire       [1:0]    _zz_result_547;
  wire       [7:0]    _zz_result_548;
  wire       [1:0]    _zz_result_549;
  wire       [63:0]   _zz_result_550;
  wire       [7:0]    _zz_result_551;
  wire       [63:0]   _zz_result_552;
  wire       [15:0]   _zz_result_553;
  wire       [63:0]   _zz_result_554;
  wire       [15:0]   _zz_result_555;
  wire       [7:0]    _zz_result_556;
  wire                _zz_result_557;
  wire       [7:0]    _zz_result_558;
  wire       [7:0]    _zz_result_559;
  wire       [7:0]    _zz_result_560;
  wire       [15:0]   _zz_result_561;
  wire       [63:0]   _zz_result_562;
  wire       [126:0]  _zz_result_563;
  wire       [5:0]    _zz_result_564;
  wire       [63:0]   _zz_result_565;
  wire       [6:0]    _zz_result_566;
  wire       [63:0]   _zz_result_567;
  wire       [63:0]   _zz_result_568;
  wire       [190:0]  _zz_result_569;
  wire       [6:0]    _zz_result_570;
  wire       [63:0]   _zz_result_571;
  wire       [64:0]   _zz_result_572;
  wire       [64:0]   _zz_result_573;
  wire       [64:0]   _zz_result_574;
  wire       [63:0]   _zz_result_575;
  wire       [65:0]   _zz_result_576;
  wire       [65:0]   _zz_result_577;
  wire       [65:0]   _zz_result_578;
  wire       [63:0]   _zz_result_579;
  wire       [66:0]   _zz_result_580;
  wire       [66:0]   _zz_result_581;
  wire       [66:0]   _zz_result_582;
  wire       [63:0]   _zz_result_583;
  wire       [63:0]   _zz_result_584;
  wire       [64:0]   _zz_result_585;
  wire       [64:0]   _zz_result_586;
  wire       [64:0]   _zz_result_587;
  wire       [63:0]   _zz_result_588;
  wire       [65:0]   _zz_result_589;
  wire       [65:0]   _zz_result_590;
  wire       [65:0]   _zz_result_591;
  wire       [63:0]   _zz_result_592;
  wire       [66:0]   _zz_result_593;
  wire       [66:0]   _zz_result_594;
  wire       [66:0]   _zz_result_595;
  wire       [63:0]   _zz_result_596;
  wire       [126:0]  _zz_result_597;
  wire       [63:0]   _zz_result_598;
  wire       [5:0]    _zz_result_599;
  wire                _zz_result_600;
  wire                _zz_result_601;
  wire       [5:0]    _zz_result_602;
  wire       [5:0]    _zz_result_603;
  wire                _zz_result_604;
  wire                _zz_result_605;
  wire       [5:0]    _zz_result_606;
  wire       [5:0]    _zz_result_607;
  wire                _zz_result_608;
  wire                _zz_result_609;
  wire       [5:0]    _zz_result_610;
  wire       [5:0]    _zz_result_611;
  wire                _zz_result_612;
  wire                _zz_result_613;
  wire       [5:0]    _zz_result_614;
  wire       [5:0]    _zz_result_615;
  wire       [63:0]   _zz_result_616;
  wire       [5:0]    _zz_result_617;
  wire                _zz_result_618;
  wire                _zz_result_619;
  wire       [5:0]    _zz_result_620;
  wire       [5:0]    _zz_result_621;
  wire                _zz_result_622;
  wire                _zz_result_623;
  wire       [5:0]    _zz_result_624;
  wire       [5:0]    _zz_result_625;
  wire                _zz_result_626;
  wire                _zz_result_627;
  wire       [5:0]    _zz_result_628;
  wire       [5:0]    _zz_result_629;
  wire                _zz_result_630;
  wire                _zz_result_631;
  wire       [5:0]    _zz_result_632;
  wire       [5:0]    _zz_result_633;
  wire       [63:0]   _zz_result_634;
  wire       [5:0]    _zz_result_635;
  wire       [6:0]    _zz_result_636;
  wire       [5:0]    _zz_result_637;
  wire       [6:0]    _zz_result_638;
  wire       [5:0]    _zz_result_639;
  wire       [6:0]    _zz_result_640;
  wire       [5:0]    _zz_result_641;
  wire       [6:0]    _zz_result_642;
  wire       [5:0]    _zz_result_643;
  wire       [6:0]    _zz_result_644;
  wire       [5:0]    _zz_result_645;
  wire       [6:0]    _zz_result_646;
  wire       [5:0]    _zz_result_647;
  wire       [6:0]    _zz_result_648;
  wire       [5:0]    _zz_result_649;
  wire       [6:0]    _zz_result_650;
  wire       [5:0]    _zz_result_651;
  wire       [6:0]    _zz_result_652;
  wire       [5:0]    _zz_result_653;
  wire       [6:0]    _zz_result_654;
  wire       [5:0]    _zz_result_655;
  wire       [6:0]    _zz_result_656;
  wire       [5:0]    _zz_result_657;
  wire       [6:0]    _zz_result_658;
  wire       [5:0]    _zz_result_659;
  wire       [6:0]    _zz_result_660;
  wire       [5:0]    _zz_result_661;
  wire       [6:0]    _zz_result_662;
  wire       [5:0]    _zz_result_663;
  wire       [6:0]    _zz_result_664;
  wire       [5:0]    _zz_result_665;
  wire       [6:0]    _zz_result_666;
  wire       [5:0]    _zz_result_667;
  wire       [6:0]    _zz_result_668;
  wire       [5:0]    _zz_result_669;
  wire       [6:0]    _zz_result_670;
  wire       [5:0]    _zz_result_671;
  wire       [6:0]    _zz_result_672;
  wire       [5:0]    _zz_result_673;
  wire       [6:0]    _zz_result_674;
  wire       [5:0]    _zz_result_675;
  wire       [6:0]    _zz_result_676;
  wire       [5:0]    _zz_result_677;
  wire       [6:0]    _zz_result_678;
  wire       [5:0]    _zz_result_679;
  wire       [6:0]    _zz_result_680;
  wire       [5:0]    _zz_result_681;
  wire       [6:0]    _zz_result_682;
  wire       [5:0]    _zz_result_683;
  wire       [6:0]    _zz_result_684;
  wire       [5:0]    _zz_result_685;
  wire       [6:0]    _zz_result_686;
  wire       [5:0]    _zz_result_687;
  wire       [6:0]    _zz_result_688;
  wire       [5:0]    _zz_result_689;
  wire       [6:0]    _zz_result_690;
  wire       [5:0]    _zz_result_691;
  wire       [6:0]    _zz_result_692;
  wire       [5:0]    _zz_result_693;
  wire       [6:0]    _zz_result_694;
  wire       [5:0]    _zz_result_695;
  wire       [6:0]    _zz_result_696;
  wire       [5:0]    _zz_result_697;
  wire       [6:0]    _zz_result_698;
  wire       [6:0]    _zz_result_699;
  wire       [1:0]    _zz_result_700;
  wire       [6:0]    _zz_result_701;
  wire       [1:0]    _zz_result_702;
  wire       [6:0]    _zz_result_703;
  wire       [1:0]    _zz_result_704;
  wire       [6:0]    _zz_result_705;
  wire       [1:0]    _zz_result_706;
  wire       [6:0]    _zz_result_707;
  wire       [1:0]    _zz_result_708;
  wire       [6:0]    _zz_result_709;
  wire       [1:0]    _zz_result_710;
  wire       [6:0]    _zz_result_711;
  wire       [1:0]    _zz_result_712;
  wire       [6:0]    _zz_result_713;
  wire       [1:0]    _zz_result_714;
  wire       [6:0]    _zz_result_715;
  wire       [1:0]    _zz_result_716;
  wire       [6:0]    _zz_result_717;
  wire       [1:0]    _zz_result_718;
  wire       [6:0]    _zz_result_719;
  wire       [1:0]    _zz_result_720;
  wire       [6:0]    _zz_result_721;
  wire       [1:0]    _zz_result_722;
  wire       [6:0]    _zz_result_723;
  wire       [1:0]    _zz_result_724;
  wire       [6:0]    _zz_result_725;
  wire       [1:0]    _zz_result_726;
  wire       [6:0]    _zz_result_727;
  wire       [1:0]    _zz_result_728;
  wire       [6:0]    _zz_result_729;
  wire       [1:0]    _zz_result_730;
  wire       [6:0]    _zz_result_731;
  wire       [1:0]    _zz_result_732;
  wire       [6:0]    _zz_result_733;
  wire       [1:0]    _zz_result_734;
  wire       [6:0]    _zz_result_735;
  wire       [1:0]    _zz_result_736;
  wire       [6:0]    _zz_result_737;
  wire       [1:0]    _zz_result_738;
  wire       [6:0]    _zz_result_739;
  wire       [1:0]    _zz_result_740;
  wire       [6:0]    _zz_result_741;
  wire       [1:0]    _zz_result_742;
  wire       [6:0]    _zz_result_743;
  wire       [1:0]    _zz_result_744;
  wire       [6:0]    _zz_result_745;
  wire       [1:0]    _zz_result_746;
  wire       [6:0]    _zz_result_747;
  wire       [1:0]    _zz_result_748;
  wire       [6:0]    _zz_result_749;
  wire       [1:0]    _zz_result_750;
  wire       [6:0]    _zz_result_751;
  wire       [1:0]    _zz_result_752;
  wire       [6:0]    _zz_result_753;
  wire       [1:0]    _zz_result_754;
  wire       [6:0]    _zz_result_755;
  wire       [1:0]    _zz_result_756;
  wire       [6:0]    _zz_result_757;
  wire       [1:0]    _zz_result_758;
  wire       [6:0]    _zz_result_759;
  wire       [1:0]    _zz_result_760;
  wire       [6:0]    _zz_result_761;
  wire       [1:0]    _zz_result_762;
  wire       [63:0]   _zz_result_763;
  wire       [31:0]   _zz_result_764;
  wire       [31:0]   _zz_result_765;
  wire       [62:0]   _zz_result_766;
  wire       [4:0]    _zz_result_767;
  wire       [31:0]   _zz_result_768;
  wire       [5:0]    _zz_result_769;
  wire       [63:0]   _zz_result_770;
  wire       [31:0]   _zz_result_771;
  wire       [31:0]   _zz_result_772;
  wire       [31:0]   _zz_result_773;
  wire       [94:0]   _zz_result_774;
  wire       [5:0]    _zz_result_775;
  wire       [63:0]   aU;
  wire       [63:0]   bU;
  wire       [63:0]   aS;
  wire       [63:0]   bS;
  wire       [5:0]    shamt;
  wire       [31:0]   aW;
  wire       [31:0]   bW;
  wire       [31:0]   aWU;
  wire       [4:0]    shamtW;
  wire       [63:0]   bitOneHot;
  wire       [63:0]   aZext;
  wire       [127:0]  clmulFull;
  wire       [127:0]  mulUU;
  wire       [127:0]  mulSS;
  wire       [64:0]   aSE;
  wire       [64:0]   bUE;
  wire       [129:0]  mulSU;
  wire       [63:0]   mulLow;
  wire       [63:0]   mulHighS;
  wire       [63:0]   mulHighSu;
  wire       [63:0]   mulHighU;
  reg        [63:0]   result;
  wire                _zz_result;
  wire                _zz_result_1;
  wire                _zz_result_2;
  wire                _zz_result_3;
  wire                _zz_result_4;
  wire                _zz_result_5;
  wire                _zz_result_6;
  wire                _zz_result_7;
  wire                _zz_result_8;
  wire                _zz_result_9;
  wire                _zz_result_10;
  wire                _zz_result_11;
  wire                _zz_result_12;
  wire                _zz_result_13;
  wire                _zz_result_14;
  wire                _zz_result_15;
  wire                _zz_result_16;
  wire                _zz_result_17;
  wire                _zz_result_18;
  wire                _zz_result_19;
  wire                _zz_result_20;
  wire                _zz_result_21;
  wire                _zz_result_22;
  wire                _zz_result_23;
  wire                _zz_result_24;
  wire                _zz_result_25;
  wire                _zz_result_26;
  wire                _zz_result_27;
  wire                _zz_result_28;
  wire                _zz_result_29;
  wire                _zz_result_30;
  wire                _zz_result_31;
  wire                _zz_result_32;
  wire                _zz_result_33;
  wire                _zz_result_34;
  wire                _zz_result_35;
  wire                _zz_result_36;
  wire                _zz_result_37;
  wire                _zz_result_38;
  wire                _zz_result_39;
  wire                _zz_result_40;
  wire                _zz_result_41;
  wire                _zz_result_42;
  wire                _zz_result_43;
  wire                _zz_result_44;
  wire                _zz_result_45;
  wire                _zz_result_46;
  wire                _zz_result_47;
  wire                _zz_result_48;
  wire                _zz_result_49;
  wire                _zz_result_50;
  wire                _zz_result_51;
  wire                _zz_result_52;
  wire                _zz_result_53;
  wire                _zz_result_54;
  wire                _zz_result_55;
  wire                _zz_result_56;
  wire                _zz_result_57;
  wire                _zz_result_58;
  wire                _zz_result_59;
  wire                _zz_result_60;
  wire                _zz_result_61;
  wire                _zz_result_62;
  wire                _zz_result_63;
  wire                _zz_result_64;
  wire                _zz_result_65;
  wire                _zz_result_66;
  wire                _zz_result_67;
  wire                _zz_result_68;
  wire                _zz_result_69;
  wire                _zz_result_70;
  wire                _zz_result_71;
  wire                _zz_result_72;
  wire                _zz_result_73;
  wire                _zz_result_74;
  wire                _zz_result_75;
  wire                _zz_result_76;
  wire                _zz_result_77;
  wire                _zz_result_78;
  wire                _zz_result_79;
  wire                _zz_result_80;
  wire                _zz_result_81;
  wire                _zz_result_82;
  wire                _zz_result_83;
  wire                _zz_result_84;
  wire                _zz_result_85;
  wire                _zz_result_86;
  wire                _zz_result_87;
  wire                _zz_result_88;
  wire                _zz_result_89;
  wire                _zz_result_90;
  wire                _zz_result_91;
  wire                _zz_result_92;
  wire                _zz_result_93;
  wire                _zz_result_94;
  wire                _zz_result_95;
  wire                _zz_result_96;
  wire                _zz_result_97;
  wire                _zz_result_98;
  wire                _zz_result_99;
  wire                _zz_result_100;
  wire                _zz_result_101;
  wire                _zz_result_102;
  wire                _zz_result_103;
  wire                _zz_result_104;
  wire                _zz_result_105;
  wire                _zz_result_106;
  wire                _zz_result_107;
  wire                _zz_result_108;
  wire                _zz_result_109;
  wire                _zz_result_110;
  wire                _zz_result_111;
  wire                _zz_result_112;
  wire                _zz_result_113;
  wire                _zz_result_114;
  wire                _zz_result_115;
  wire                _zz_result_116;
  wire                _zz_result_117;
  wire                _zz_result_118;
  wire                _zz_result_119;
  wire                _zz_result_120;
  wire                _zz_result_121;
  wire                _zz_result_122;
  wire                _zz_result_123;
  wire                _zz_result_124;
  wire                _zz_result_125;
  wire       [6:0]    _zz_result_126;
  wire       [6:0]    _zz_result_127;
  wire       [31:0]   _zz_result_128;
  wire                _zz_result_129;
  wire                _zz_result_130;
  wire                _zz_result_131;
  wire                _zz_result_132;
  wire                _zz_result_133;
  wire                _zz_result_134;
  wire                _zz_result_135;
  wire                _zz_result_136;
  wire                _zz_result_137;
  wire                _zz_result_138;
  wire                _zz_result_139;
  wire                _zz_result_140;
  wire                _zz_result_141;
  wire                _zz_result_142;
  wire                _zz_result_143;
  wire                _zz_result_144;
  wire                _zz_result_145;
  wire                _zz_result_146;
  wire                _zz_result_147;
  wire                _zz_result_148;
  wire                _zz_result_149;
  wire                _zz_result_150;
  wire                _zz_result_151;
  wire                _zz_result_152;
  wire                _zz_result_153;
  wire                _zz_result_154;
  wire                _zz_result_155;
  wire                _zz_result_156;
  wire                _zz_result_157;
  wire                _zz_result_158;
  wire                _zz_result_159;
  wire       [31:0]   _zz_result_160;
  wire                _zz_result_161;
  wire                _zz_result_162;
  wire                _zz_result_163;
  wire                _zz_result_164;
  wire                _zz_result_165;
  wire                _zz_result_166;
  wire                _zz_result_167;
  wire                _zz_result_168;
  wire                _zz_result_169;
  wire                _zz_result_170;
  wire                _zz_result_171;
  wire                _zz_result_172;
  wire                _zz_result_173;
  wire                _zz_result_174;
  wire                _zz_result_175;
  wire                _zz_result_176;
  wire                _zz_result_177;
  wire                _zz_result_178;
  wire                _zz_result_179;
  wire                _zz_result_180;
  wire                _zz_result_181;
  wire                _zz_result_182;
  wire                _zz_result_183;
  wire                _zz_result_184;
  wire                _zz_result_185;
  wire                _zz_result_186;
  wire                _zz_result_187;
  wire                _zz_result_188;
  wire                _zz_result_189;
  wire                _zz_result_190;
  wire                _zz_result_191;
  wire       [31:0]   _zz_result_192;
  wire       [5:0]    _zz_result_193;
  wire       [5:0]    _zz_result_194;
  `ifndef SYNTHESIS
  reg [63:0] io_op_string;
  `endif


  assign _zz_bitOneHot = ({63'd0,64'h0000000000000001} <<< shamt);
  assign _zz_aZext = aU[31 : 0];
  assign _zz_clmulFull_8 = {64'd0, aU};
  assign _zz_clmulFull_11 = ({1'd0,aU} <<< 1'd1);
  assign _zz_clmulFull_10 = {63'd0, _zz_clmulFull_11};
  assign _zz_clmulFull_14 = ({2'd0,aU} <<< 2'd2);
  assign _zz_clmulFull_13 = {62'd0, _zz_clmulFull_14};
  assign _zz_clmulFull_17 = ({3'd0,aU} <<< 2'd3);
  assign _zz_clmulFull_16 = {61'd0, _zz_clmulFull_17};
  assign _zz_clmulFull_19 = ({4'd0,aU} <<< 3'd4);
  assign _zz_clmulFull_18 = {60'd0, _zz_clmulFull_19};
  assign _zz_clmulFull_21 = ({5'd0,aU} <<< 3'd5);
  assign _zz_clmulFull_20 = {59'd0, _zz_clmulFull_21};
  assign _zz_clmulFull_23 = ({6'd0,aU} <<< 3'd6);
  assign _zz_clmulFull_22 = {58'd0, _zz_clmulFull_23};
  assign _zz_clmulFull_25 = ({7'd0,aU} <<< 3'd7);
  assign _zz_clmulFull_24 = {57'd0, _zz_clmulFull_25};
  assign _zz_clmulFull_27 = ({8'd0,aU} <<< 4'd8);
  assign _zz_clmulFull_26 = {56'd0, _zz_clmulFull_27};
  assign _zz_clmulFull_30 = ({9'd0,aU} <<< 4'd9);
  assign _zz_clmulFull_29 = {55'd0, _zz_clmulFull_30};
  assign _zz_clmulFull_33 = ({10'd0,aU} <<< 4'd10);
  assign _zz_clmulFull_32 = {54'd0, _zz_clmulFull_33};
  assign _zz_clmulFull_36 = ({11'd0,aU} <<< 4'd11);
  assign _zz_clmulFull_35 = {53'd0, _zz_clmulFull_36};
  assign _zz_clmulFull_38 = ({12'd0,aU} <<< 4'd12);
  assign _zz_clmulFull_37 = {52'd0, _zz_clmulFull_38};
  assign _zz_clmulFull_40 = ({13'd0,aU} <<< 4'd13);
  assign _zz_clmulFull_39 = {51'd0, _zz_clmulFull_40};
  assign _zz_clmulFull_42 = ({14'd0,aU} <<< 4'd14);
  assign _zz_clmulFull_41 = {50'd0, _zz_clmulFull_42};
  assign _zz_clmulFull_44 = ({15'd0,aU} <<< 4'd15);
  assign _zz_clmulFull_43 = {49'd0, _zz_clmulFull_44};
  assign _zz_clmulFull_46 = ({16'd0,aU} <<< 5'd16);
  assign _zz_clmulFull_45 = {48'd0, _zz_clmulFull_46};
  assign _zz_clmulFull_49 = ({17'd0,aU} <<< 5'd17);
  assign _zz_clmulFull_48 = {47'd0, _zz_clmulFull_49};
  assign _zz_clmulFull_52 = ({18'd0,aU} <<< 5'd18);
  assign _zz_clmulFull_51 = {46'd0, _zz_clmulFull_52};
  assign _zz_clmulFull_55 = ({19'd0,aU} <<< 5'd19);
  assign _zz_clmulFull_54 = {45'd0, _zz_clmulFull_55};
  assign _zz_clmulFull_57 = ({20'd0,aU} <<< 5'd20);
  assign _zz_clmulFull_56 = {44'd0, _zz_clmulFull_57};
  assign _zz_clmulFull_59 = ({21'd0,aU} <<< 5'd21);
  assign _zz_clmulFull_58 = {43'd0, _zz_clmulFull_59};
  assign _zz_clmulFull_61 = ({22'd0,aU} <<< 5'd22);
  assign _zz_clmulFull_60 = {42'd0, _zz_clmulFull_61};
  assign _zz_clmulFull_63 = ({23'd0,aU} <<< 5'd23);
  assign _zz_clmulFull_62 = {41'd0, _zz_clmulFull_63};
  assign _zz_clmulFull_65 = ({24'd0,aU} <<< 5'd24);
  assign _zz_clmulFull_64 = {40'd0, _zz_clmulFull_65};
  assign _zz_clmulFull_68 = ({25'd0,aU} <<< 5'd25);
  assign _zz_clmulFull_67 = {39'd0, _zz_clmulFull_68};
  assign _zz_clmulFull_71 = ({26'd0,aU} <<< 5'd26);
  assign _zz_clmulFull_70 = {38'd0, _zz_clmulFull_71};
  assign _zz_clmulFull_74 = ({27'd0,aU} <<< 5'd27);
  assign _zz_clmulFull_73 = {37'd0, _zz_clmulFull_74};
  assign _zz_clmulFull_76 = ({28'd0,aU} <<< 5'd28);
  assign _zz_clmulFull_75 = {36'd0, _zz_clmulFull_76};
  assign _zz_clmulFull_78 = ({29'd0,aU} <<< 5'd29);
  assign _zz_clmulFull_77 = {35'd0, _zz_clmulFull_78};
  assign _zz_clmulFull_80 = ({30'd0,aU} <<< 5'd30);
  assign _zz_clmulFull_79 = {34'd0, _zz_clmulFull_80};
  assign _zz_clmulFull_82 = ({31'd0,aU} <<< 5'd31);
  assign _zz_clmulFull_81 = {33'd0, _zz_clmulFull_82};
  assign _zz_clmulFull_84 = ({32'd0,aU} <<< 6'd32);
  assign _zz_clmulFull_83 = {32'd0, _zz_clmulFull_84};
  assign _zz_clmulFull_87 = ({33'd0,aU} <<< 6'd33);
  assign _zz_clmulFull_86 = {31'd0, _zz_clmulFull_87};
  assign _zz_clmulFull_90 = ({34'd0,aU} <<< 6'd34);
  assign _zz_clmulFull_89 = {30'd0, _zz_clmulFull_90};
  assign _zz_clmulFull_93 = ({35'd0,aU} <<< 6'd35);
  assign _zz_clmulFull_92 = {29'd0, _zz_clmulFull_93};
  assign _zz_clmulFull_95 = ({36'd0,aU} <<< 6'd36);
  assign _zz_clmulFull_94 = {28'd0, _zz_clmulFull_95};
  assign _zz_clmulFull_97 = ({37'd0,aU} <<< 6'd37);
  assign _zz_clmulFull_96 = {27'd0, _zz_clmulFull_97};
  assign _zz_clmulFull_99 = ({38'd0,aU} <<< 6'd38);
  assign _zz_clmulFull_98 = {26'd0, _zz_clmulFull_99};
  assign _zz_clmulFull_101 = ({39'd0,aU} <<< 6'd39);
  assign _zz_clmulFull_100 = {25'd0, _zz_clmulFull_101};
  assign _zz_clmulFull_103 = ({40'd0,aU} <<< 6'd40);
  assign _zz_clmulFull_102 = {24'd0, _zz_clmulFull_103};
  assign _zz_clmulFull_106 = ({41'd0,aU} <<< 6'd41);
  assign _zz_clmulFull_105 = {23'd0, _zz_clmulFull_106};
  assign _zz_clmulFull_109 = ({42'd0,aU} <<< 6'd42);
  assign _zz_clmulFull_108 = {22'd0, _zz_clmulFull_109};
  assign _zz_clmulFull_112 = ({43'd0,aU} <<< 6'd43);
  assign _zz_clmulFull_111 = {21'd0, _zz_clmulFull_112};
  assign _zz_clmulFull_114 = ({44'd0,aU} <<< 6'd44);
  assign _zz_clmulFull_113 = {20'd0, _zz_clmulFull_114};
  assign _zz_clmulFull_116 = ({45'd0,aU} <<< 6'd45);
  assign _zz_clmulFull_115 = {19'd0, _zz_clmulFull_116};
  assign _zz_clmulFull_118 = ({46'd0,aU} <<< 6'd46);
  assign _zz_clmulFull_117 = {18'd0, _zz_clmulFull_118};
  assign _zz_clmulFull_120 = ({47'd0,aU} <<< 6'd47);
  assign _zz_clmulFull_119 = {17'd0, _zz_clmulFull_120};
  assign _zz_clmulFull_122 = ({48'd0,aU} <<< 6'd48);
  assign _zz_clmulFull_121 = {16'd0, _zz_clmulFull_122};
  assign _zz_clmulFull_125 = ({49'd0,aU} <<< 6'd49);
  assign _zz_clmulFull_124 = {15'd0, _zz_clmulFull_125};
  assign _zz_clmulFull_128 = ({50'd0,aU} <<< 6'd50);
  assign _zz_clmulFull_127 = {14'd0, _zz_clmulFull_128};
  assign _zz_clmulFull_131 = ({51'd0,aU} <<< 6'd51);
  assign _zz_clmulFull_130 = {13'd0, _zz_clmulFull_131};
  assign _zz_clmulFull_133 = ({52'd0,aU} <<< 6'd52);
  assign _zz_clmulFull_132 = {12'd0, _zz_clmulFull_133};
  assign _zz_clmulFull_135 = ({53'd0,aU} <<< 6'd53);
  assign _zz_clmulFull_134 = {11'd0, _zz_clmulFull_135};
  assign _zz_clmulFull_137 = ({54'd0,aU} <<< 6'd54);
  assign _zz_clmulFull_136 = {10'd0, _zz_clmulFull_137};
  assign _zz_clmulFull_139 = ({55'd0,aU} <<< 6'd55);
  assign _zz_clmulFull_138 = {9'd0, _zz_clmulFull_139};
  assign _zz_clmulFull_141 = ({56'd0,aU} <<< 6'd56);
  assign _zz_clmulFull_140 = {8'd0, _zz_clmulFull_141};
  assign _zz_clmulFull_144 = ({57'd0,aU} <<< 6'd57);
  assign _zz_clmulFull_143 = {7'd0, _zz_clmulFull_144};
  assign _zz_clmulFull_147 = ({58'd0,aU} <<< 6'd58);
  assign _zz_clmulFull_146 = {6'd0, _zz_clmulFull_147};
  assign _zz_clmulFull_150 = ({59'd0,aU} <<< 6'd59);
  assign _zz_clmulFull_149 = {5'd0, _zz_clmulFull_150};
  assign _zz_clmulFull_152 = ({60'd0,aU} <<< 6'd60);
  assign _zz_clmulFull_151 = {4'd0, _zz_clmulFull_152};
  assign _zz_clmulFull_154 = ({61'd0,aU} <<< 6'd61);
  assign _zz_clmulFull_153 = {3'd0, _zz_clmulFull_154};
  assign _zz_clmulFull_156 = ({62'd0,aU} <<< 6'd62);
  assign _zz_clmulFull_155 = {2'd0, _zz_clmulFull_156};
  assign _zz_clmulFull_158 = ({63'd0,aU} <<< 6'd63);
  assign _zz_clmulFull_157 = {1'd0, _zz_clmulFull_158};
  assign _zz_bUE = {1'd0, bU};
  assign _zz_mulLow = mulUU;
  assign _zz_mulHighS = mulSS;
  assign _zz_mulHighSu = mulSU;
  assign _zz_mulHighU = mulUU;
  assign _zz_result_195 = (aU + bU);
  assign _zz_result_196 = (aU - bU);
  assign _zz_result_198 = ({63'd0,aU} <<< shamt);
  assign _zz_result_197 = _zz_result_198[63:0];
  assign _zz_result_199 = (aU >>> shamt);
  assign _zz_result_200 = ($signed(aS) >>> shamt);
  assign _zz_result_202 = ($signed(aW) + $signed(bW));
  assign _zz_result_201 = {{32{_zz_result_202[31]}}, _zz_result_202};
  assign _zz_result_204 = ($signed(aW) - $signed(bW));
  assign _zz_result_203 = {{32{_zz_result_204[31]}}, _zz_result_204};
  assign _zz_result_206 = _zz_result_207;
  assign _zz_result_205 = {{32{_zz_result_206[31]}}, _zz_result_206};
  assign _zz_result_208 = ({31'd0,aWU} <<< shamtW);
  assign _zz_result_207 = _zz_result_208[31:0];
  assign _zz_result_210 = _zz_result_211;
  assign _zz_result_209 = {{32{_zz_result_210[31]}}, _zz_result_210};
  assign _zz_result_211 = (aWU >>> shamtW);
  assign _zz_result_213 = ($signed(aW) >>> shamtW);
  assign _zz_result_212 = {{32{_zz_result_213[31]}}, _zz_result_213};
  assign _zz_result_215 = _zz_result_216[31:0];
  assign _zz_result_214 = {{32{_zz_result_215[31]}}, _zz_result_215};
  assign _zz_result_216 = ($signed(aW) * $signed(bW));
  assign _zz_result_218 = (((_zz_result_62 && (! io_a[1])) && io_a[0]) ? 7'h3f : ((_zz_result_62 && io_a[1]) ? 7'h3e : ((_zz_result_61 && io_a[2]) ? 7'h3d : ((_zz_result_60 && io_a[3]) ? 7'h3c : ((_zz_result_59 && _zz_result_219) ? 7'h3b : (_zz_result_220 ? _zz_result_221 : _zz_result_222))))));
  assign _zz_result_217 = {57'd0, _zz_result_218};
  assign _zz_result_256 = (((_zz_result_125 && (! io_a[62])) && io_a[63]) ? 7'h3f : ((_zz_result_125 && io_a[62]) ? 7'h3e : ((_zz_result_124 && io_a[61]) ? 7'h3d : ((_zz_result_123 && io_a[60]) ? 7'h3c : ((_zz_result_122 && _zz_result_257) ? 7'h3b : (_zz_result_258 ? _zz_result_259 : _zz_result_260))))));
  assign _zz_result_255 = {57'd0, _zz_result_256};
  assign _zz_result_294 = _zz_result_295[6:0];
  assign _zz_result_293 = {57'd0, _zz_result_294};
  assign _zz_result_295 = ({1'b0,_zz_result_296} + _zz_result_548);
  assign _zz_result_297 = ({1'b0,_zz_result_298} + _zz_result_546);
  assign _zz_result_296 = _zz_result_297[6:0];
  assign _zz_result_299 = ({1'b0,_zz_result_300} + _zz_result_544);
  assign _zz_result_298 = _zz_result_299[6:0];
  assign _zz_result_301 = ({1'b0,_zz_result_302} + _zz_result_542);
  assign _zz_result_300 = _zz_result_301[6:0];
  assign _zz_result_303 = ({1'b0,_zz_result_304} + _zz_result_540);
  assign _zz_result_302 = _zz_result_303[6:0];
  assign _zz_result_305 = ({1'b0,_zz_result_306} + _zz_result_538);
  assign _zz_result_304 = _zz_result_305[6:0];
  assign _zz_result_307 = ({1'b0,_zz_result_308} + _zz_result_536);
  assign _zz_result_306 = _zz_result_307[6:0];
  assign _zz_result_309 = ({1'b0,_zz_result_310} + _zz_result_534);
  assign _zz_result_308 = _zz_result_309[6:0];
  assign _zz_result_311 = ({1'b0,_zz_result_312} + _zz_result_532);
  assign _zz_result_310 = _zz_result_311[6:0];
  assign _zz_result_313 = ({1'b0,_zz_result_314} + _zz_result_530);
  assign _zz_result_312 = _zz_result_313[6:0];
  assign _zz_result_315 = ({1'b0,_zz_result_316} + _zz_result_528);
  assign _zz_result_314 = _zz_result_315[6:0];
  assign _zz_result_317 = ({1'b0,_zz_result_318} + _zz_result_526);
  assign _zz_result_316 = _zz_result_317[6:0];
  assign _zz_result_319 = ({1'b0,_zz_result_320} + _zz_result_524);
  assign _zz_result_318 = _zz_result_319[6:0];
  assign _zz_result_321 = ({1'b0,_zz_result_322} + _zz_result_522);
  assign _zz_result_320 = _zz_result_321[6:0];
  assign _zz_result_323 = ({1'b0,_zz_result_324} + _zz_result_520);
  assign _zz_result_322 = _zz_result_323[6:0];
  assign _zz_result_325 = ({1'b0,_zz_result_326} + _zz_result_518);
  assign _zz_result_324 = _zz_result_325[6:0];
  assign _zz_result_327 = ({1'b0,_zz_result_328} + _zz_result_516);
  assign _zz_result_326 = _zz_result_327[6:0];
  assign _zz_result_329 = ({1'b0,_zz_result_330} + _zz_result_514);
  assign _zz_result_328 = _zz_result_329[6:0];
  assign _zz_result_331 = ({1'b0,_zz_result_332} + _zz_result_512);
  assign _zz_result_330 = _zz_result_331[6:0];
  assign _zz_result_333 = ({1'b0,_zz_result_334} + _zz_result_510);
  assign _zz_result_332 = _zz_result_333[6:0];
  assign _zz_result_335 = ({1'b0,_zz_result_336} + _zz_result_508);
  assign _zz_result_334 = _zz_result_335[6:0];
  assign _zz_result_337 = ({1'b0,_zz_result_338} + _zz_result_506);
  assign _zz_result_336 = _zz_result_337[6:0];
  assign _zz_result_339 = ({1'b0,_zz_result_340} + _zz_result_504);
  assign _zz_result_338 = _zz_result_339[6:0];
  assign _zz_result_341 = ({1'b0,_zz_result_342} + _zz_result_502);
  assign _zz_result_340 = _zz_result_341[6:0];
  assign _zz_result_343 = ({1'b0,_zz_result_344} + _zz_result_500);
  assign _zz_result_342 = _zz_result_343[6:0];
  assign _zz_result_345 = ({1'b0,_zz_result_346} + _zz_result_498);
  assign _zz_result_344 = _zz_result_345[6:0];
  assign _zz_result_347 = ({1'b0,_zz_result_348} + _zz_result_496);
  assign _zz_result_346 = _zz_result_347[6:0];
  assign _zz_result_349 = ({1'b0,_zz_result_350} + _zz_result_494);
  assign _zz_result_348 = _zz_result_349[6:0];
  assign _zz_result_351 = ({1'b0,_zz_result_352} + _zz_result_492);
  assign _zz_result_350 = _zz_result_351[6:0];
  assign _zz_result_353 = ({1'b0,_zz_result_354} + _zz_result_490);
  assign _zz_result_352 = _zz_result_353[6:0];
  assign _zz_result_355 = ({1'b0,_zz_result_356} + _zz_result_488);
  assign _zz_result_354 = _zz_result_355[6:0];
  assign _zz_result_357 = ({1'b0,_zz_result_358} + _zz_result_486);
  assign _zz_result_356 = _zz_result_357[6:0];
  assign _zz_result_359 = ({1'b0,_zz_result_360} + _zz_result_484);
  assign _zz_result_358 = _zz_result_359[6:0];
  assign _zz_result_361 = ({1'b0,_zz_result_362} + _zz_result_482);
  assign _zz_result_360 = _zz_result_361[6:0];
  assign _zz_result_363 = ({1'b0,_zz_result_364} + _zz_result_480);
  assign _zz_result_362 = _zz_result_363[6:0];
  assign _zz_result_365 = ({1'b0,_zz_result_366} + _zz_result_478);
  assign _zz_result_364 = _zz_result_365[6:0];
  assign _zz_result_367 = ({1'b0,_zz_result_368} + _zz_result_476);
  assign _zz_result_366 = _zz_result_367[6:0];
  assign _zz_result_369 = ({1'b0,_zz_result_370} + _zz_result_474);
  assign _zz_result_368 = _zz_result_369[6:0];
  assign _zz_result_371 = ({1'b0,_zz_result_372} + _zz_result_472);
  assign _zz_result_370 = _zz_result_371[6:0];
  assign _zz_result_373 = ({1'b0,_zz_result_374} + _zz_result_470);
  assign _zz_result_372 = _zz_result_373[6:0];
  assign _zz_result_375 = ({1'b0,_zz_result_376} + _zz_result_468);
  assign _zz_result_374 = _zz_result_375[6:0];
  assign _zz_result_377 = ({1'b0,_zz_result_378} + _zz_result_466);
  assign _zz_result_376 = _zz_result_377[6:0];
  assign _zz_result_379 = ({1'b0,_zz_result_380} + _zz_result_464);
  assign _zz_result_378 = _zz_result_379[6:0];
  assign _zz_result_381 = ({1'b0,_zz_result_382} + _zz_result_462);
  assign _zz_result_380 = _zz_result_381[6:0];
  assign _zz_result_383 = ({1'b0,_zz_result_384} + _zz_result_460);
  assign _zz_result_382 = _zz_result_383[6:0];
  assign _zz_result_385 = ({1'b0,_zz_result_386} + _zz_result_458);
  assign _zz_result_384 = _zz_result_385[6:0];
  assign _zz_result_387 = ({1'b0,_zz_result_388} + _zz_result_456);
  assign _zz_result_386 = _zz_result_387[6:0];
  assign _zz_result_389 = ({1'b0,_zz_result_390} + _zz_result_454);
  assign _zz_result_388 = _zz_result_389[6:0];
  assign _zz_result_391 = ({1'b0,_zz_result_392} + _zz_result_452);
  assign _zz_result_390 = _zz_result_391[6:0];
  assign _zz_result_393 = ({1'b0,_zz_result_394} + _zz_result_450);
  assign _zz_result_392 = _zz_result_393[6:0];
  assign _zz_result_395 = ({1'b0,_zz_result_396} + _zz_result_448);
  assign _zz_result_394 = _zz_result_395[6:0];
  assign _zz_result_397 = ({1'b0,_zz_result_398} + _zz_result_446);
  assign _zz_result_396 = _zz_result_397[6:0];
  assign _zz_result_399 = ({1'b0,_zz_result_400} + _zz_result_444);
  assign _zz_result_398 = _zz_result_399[6:0];
  assign _zz_result_401 = ({1'b0,_zz_result_402} + _zz_result_442);
  assign _zz_result_400 = _zz_result_401[6:0];
  assign _zz_result_403 = ({1'b0,_zz_result_404} + _zz_result_440);
  assign _zz_result_402 = _zz_result_403[6:0];
  assign _zz_result_405 = ({1'b0,_zz_result_406} + _zz_result_438);
  assign _zz_result_404 = _zz_result_405[6:0];
  assign _zz_result_407 = ({1'b0,_zz_result_408} + _zz_result_436);
  assign _zz_result_406 = _zz_result_407[6:0];
  assign _zz_result_409 = ({1'b0,_zz_result_410} + _zz_result_434);
  assign _zz_result_408 = _zz_result_409[6:0];
  assign _zz_result_411 = ({1'b0,_zz_result_412} + _zz_result_432);
  assign _zz_result_410 = _zz_result_411[6:0];
  assign _zz_result_413 = ({1'b0,_zz_result_414} + _zz_result_430);
  assign _zz_result_412 = _zz_result_413[6:0];
  assign _zz_result_415 = ({1'b0,_zz_result_416} + _zz_result_428);
  assign _zz_result_414 = _zz_result_415[6:0];
  assign _zz_result_417 = ({1'b0,_zz_result_418} + _zz_result_426);
  assign _zz_result_416 = _zz_result_417[6:0];
  assign _zz_result_419 = ({1'b0,_zz_result_420} + _zz_result_424);
  assign _zz_result_418 = _zz_result_419[6:0];
  assign _zz_result_421 = ({1'b0,7'h0} + _zz_result_422);
  assign _zz_result_420 = _zz_result_421[6:0];
  assign _zz_result_423 = {1'b0,io_a[0]};
  assign _zz_result_422 = {6'd0, _zz_result_423};
  assign _zz_result_425 = {1'b0,io_a[1]};
  assign _zz_result_424 = {6'd0, _zz_result_425};
  assign _zz_result_427 = {1'b0,io_a[2]};
  assign _zz_result_426 = {6'd0, _zz_result_427};
  assign _zz_result_429 = {1'b0,io_a[3]};
  assign _zz_result_428 = {6'd0, _zz_result_429};
  assign _zz_result_431 = {1'b0,io_a[4]};
  assign _zz_result_430 = {6'd0, _zz_result_431};
  assign _zz_result_433 = {1'b0,io_a[5]};
  assign _zz_result_432 = {6'd0, _zz_result_433};
  assign _zz_result_435 = {1'b0,io_a[6]};
  assign _zz_result_434 = {6'd0, _zz_result_435};
  assign _zz_result_437 = {1'b0,io_a[7]};
  assign _zz_result_436 = {6'd0, _zz_result_437};
  assign _zz_result_439 = {1'b0,io_a[8]};
  assign _zz_result_438 = {6'd0, _zz_result_439};
  assign _zz_result_441 = {1'b0,io_a[9]};
  assign _zz_result_440 = {6'd0, _zz_result_441};
  assign _zz_result_443 = {1'b0,io_a[10]};
  assign _zz_result_442 = {6'd0, _zz_result_443};
  assign _zz_result_445 = {1'b0,io_a[11]};
  assign _zz_result_444 = {6'd0, _zz_result_445};
  assign _zz_result_447 = {1'b0,io_a[12]};
  assign _zz_result_446 = {6'd0, _zz_result_447};
  assign _zz_result_449 = {1'b0,io_a[13]};
  assign _zz_result_448 = {6'd0, _zz_result_449};
  assign _zz_result_451 = {1'b0,io_a[14]};
  assign _zz_result_450 = {6'd0, _zz_result_451};
  assign _zz_result_453 = {1'b0,io_a[15]};
  assign _zz_result_452 = {6'd0, _zz_result_453};
  assign _zz_result_455 = {1'b0,io_a[16]};
  assign _zz_result_454 = {6'd0, _zz_result_455};
  assign _zz_result_457 = {1'b0,io_a[17]};
  assign _zz_result_456 = {6'd0, _zz_result_457};
  assign _zz_result_459 = {1'b0,io_a[18]};
  assign _zz_result_458 = {6'd0, _zz_result_459};
  assign _zz_result_461 = {1'b0,io_a[19]};
  assign _zz_result_460 = {6'd0, _zz_result_461};
  assign _zz_result_463 = {1'b0,io_a[20]};
  assign _zz_result_462 = {6'd0, _zz_result_463};
  assign _zz_result_465 = {1'b0,io_a[21]};
  assign _zz_result_464 = {6'd0, _zz_result_465};
  assign _zz_result_467 = {1'b0,io_a[22]};
  assign _zz_result_466 = {6'd0, _zz_result_467};
  assign _zz_result_469 = {1'b0,io_a[23]};
  assign _zz_result_468 = {6'd0, _zz_result_469};
  assign _zz_result_471 = {1'b0,io_a[24]};
  assign _zz_result_470 = {6'd0, _zz_result_471};
  assign _zz_result_473 = {1'b0,io_a[25]};
  assign _zz_result_472 = {6'd0, _zz_result_473};
  assign _zz_result_475 = {1'b0,io_a[26]};
  assign _zz_result_474 = {6'd0, _zz_result_475};
  assign _zz_result_477 = {1'b0,io_a[27]};
  assign _zz_result_476 = {6'd0, _zz_result_477};
  assign _zz_result_479 = {1'b0,io_a[28]};
  assign _zz_result_478 = {6'd0, _zz_result_479};
  assign _zz_result_481 = {1'b0,io_a[29]};
  assign _zz_result_480 = {6'd0, _zz_result_481};
  assign _zz_result_483 = {1'b0,io_a[30]};
  assign _zz_result_482 = {6'd0, _zz_result_483};
  assign _zz_result_485 = {1'b0,io_a[31]};
  assign _zz_result_484 = {6'd0, _zz_result_485};
  assign _zz_result_487 = {1'b0,io_a[32]};
  assign _zz_result_486 = {6'd0, _zz_result_487};
  assign _zz_result_489 = {1'b0,io_a[33]};
  assign _zz_result_488 = {6'd0, _zz_result_489};
  assign _zz_result_491 = {1'b0,io_a[34]};
  assign _zz_result_490 = {6'd0, _zz_result_491};
  assign _zz_result_493 = {1'b0,io_a[35]};
  assign _zz_result_492 = {6'd0, _zz_result_493};
  assign _zz_result_495 = {1'b0,io_a[36]};
  assign _zz_result_494 = {6'd0, _zz_result_495};
  assign _zz_result_497 = {1'b0,io_a[37]};
  assign _zz_result_496 = {6'd0, _zz_result_497};
  assign _zz_result_499 = {1'b0,io_a[38]};
  assign _zz_result_498 = {6'd0, _zz_result_499};
  assign _zz_result_501 = {1'b0,io_a[39]};
  assign _zz_result_500 = {6'd0, _zz_result_501};
  assign _zz_result_503 = {1'b0,io_a[40]};
  assign _zz_result_502 = {6'd0, _zz_result_503};
  assign _zz_result_505 = {1'b0,io_a[41]};
  assign _zz_result_504 = {6'd0, _zz_result_505};
  assign _zz_result_507 = {1'b0,io_a[42]};
  assign _zz_result_506 = {6'd0, _zz_result_507};
  assign _zz_result_509 = {1'b0,io_a[43]};
  assign _zz_result_508 = {6'd0, _zz_result_509};
  assign _zz_result_511 = {1'b0,io_a[44]};
  assign _zz_result_510 = {6'd0, _zz_result_511};
  assign _zz_result_513 = {1'b0,io_a[45]};
  assign _zz_result_512 = {6'd0, _zz_result_513};
  assign _zz_result_515 = {1'b0,io_a[46]};
  assign _zz_result_514 = {6'd0, _zz_result_515};
  assign _zz_result_517 = {1'b0,io_a[47]};
  assign _zz_result_516 = {6'd0, _zz_result_517};
  assign _zz_result_519 = {1'b0,io_a[48]};
  assign _zz_result_518 = {6'd0, _zz_result_519};
  assign _zz_result_521 = {1'b0,io_a[49]};
  assign _zz_result_520 = {6'd0, _zz_result_521};
  assign _zz_result_523 = {1'b0,io_a[50]};
  assign _zz_result_522 = {6'd0, _zz_result_523};
  assign _zz_result_525 = {1'b0,io_a[51]};
  assign _zz_result_524 = {6'd0, _zz_result_525};
  assign _zz_result_527 = {1'b0,io_a[52]};
  assign _zz_result_526 = {6'd0, _zz_result_527};
  assign _zz_result_529 = {1'b0,io_a[53]};
  assign _zz_result_528 = {6'd0, _zz_result_529};
  assign _zz_result_531 = {1'b0,io_a[54]};
  assign _zz_result_530 = {6'd0, _zz_result_531};
  assign _zz_result_533 = {1'b0,io_a[55]};
  assign _zz_result_532 = {6'd0, _zz_result_533};
  assign _zz_result_535 = {1'b0,io_a[56]};
  assign _zz_result_534 = {6'd0, _zz_result_535};
  assign _zz_result_537 = {1'b0,io_a[57]};
  assign _zz_result_536 = {6'd0, _zz_result_537};
  assign _zz_result_539 = {1'b0,io_a[58]};
  assign _zz_result_538 = {6'd0, _zz_result_539};
  assign _zz_result_541 = {1'b0,io_a[59]};
  assign _zz_result_540 = {6'd0, _zz_result_541};
  assign _zz_result_543 = {1'b0,io_a[60]};
  assign _zz_result_542 = {6'd0, _zz_result_543};
  assign _zz_result_545 = {1'b0,io_a[61]};
  assign _zz_result_544 = {6'd0, _zz_result_545};
  assign _zz_result_547 = {1'b0,io_a[62]};
  assign _zz_result_546 = {6'd0, _zz_result_547};
  assign _zz_result_549 = {1'b0,io_a[63]};
  assign _zz_result_548 = {6'd0, _zz_result_549};
  assign _zz_result_551 = io_a[7 : 0];
  assign _zz_result_550 = {{56{_zz_result_551[7]}}, _zz_result_551};
  assign _zz_result_553 = io_a[15 : 0];
  assign _zz_result_552 = {{48{_zz_result_553[15]}}, _zz_result_553};
  assign _zz_result_555 = io_a[15 : 0];
  assign _zz_result_554 = {48'd0, _zz_result_555};
  assign _zz_result_563 = ({63'd0,aU} <<< _zz_result_564);
  assign _zz_result_562 = _zz_result_563[63:0];
  assign _zz_result_564 = _zz_result_126[5:0];
  assign _zz_result_565 = (aU >>> _zz_result_566);
  assign _zz_result_566 = (7'h40 - _zz_result_126);
  assign _zz_result_567 = (aU >>> _zz_result_127);
  assign _zz_result_569 = ({127'd0,aU} <<< _zz_result_570);
  assign _zz_result_568 = _zz_result_569[63:0];
  assign _zz_result_570 = (7'h40 - _zz_result_127);
  assign _zz_result_572 = (_zz_result_573 + _zz_result_574);
  assign _zz_result_571 = _zz_result_572[63:0];
  assign _zz_result_573 = ({1'd0,aU} <<< 1'd1);
  assign _zz_result_574 = {1'd0, bU};
  assign _zz_result_576 = (_zz_result_577 + _zz_result_578);
  assign _zz_result_575 = _zz_result_576[63:0];
  assign _zz_result_577 = ({2'd0,aU} <<< 2'd2);
  assign _zz_result_578 = {2'd0, bU};
  assign _zz_result_580 = (_zz_result_581 + _zz_result_582);
  assign _zz_result_579 = _zz_result_580[63:0];
  assign _zz_result_581 = ({3'd0,aU} <<< 2'd3);
  assign _zz_result_582 = {3'd0, bU};
  assign _zz_result_583 = (aZext + bU);
  assign _zz_result_585 = (_zz_result_586 + _zz_result_587);
  assign _zz_result_584 = _zz_result_585[63:0];
  assign _zz_result_586 = ({1'd0,aZext} <<< 1'd1);
  assign _zz_result_587 = {1'd0, bU};
  assign _zz_result_589 = (_zz_result_590 + _zz_result_591);
  assign _zz_result_588 = _zz_result_589[63:0];
  assign _zz_result_590 = ({2'd0,aZext} <<< 2'd2);
  assign _zz_result_591 = {2'd0, bU};
  assign _zz_result_593 = (_zz_result_594 + _zz_result_595);
  assign _zz_result_592 = _zz_result_593[63:0];
  assign _zz_result_594 = ({3'd0,aZext} <<< 2'd3);
  assign _zz_result_595 = {3'd0, bU};
  assign _zz_result_597 = ({63'd0,aZext} <<< shamt);
  assign _zz_result_596 = _zz_result_597[63:0];
  assign _zz_result_599 = (((_zz_result_159 && (! _zz_result_128[1])) && _zz_result_128[0]) ? 6'h1f : ((_zz_result_159 && _zz_result_128[1]) ? 6'h1e : ((_zz_result_158 && _zz_result_128[2]) ? 6'h1d : ((_zz_result_157 && _zz_result_128[3]) ? 6'h1c : ((_zz_result_156 && _zz_result_600) ? 6'h1b : (_zz_result_601 ? _zz_result_602 : _zz_result_603))))));
  assign _zz_result_598 = {58'd0, _zz_result_599};
  assign _zz_result_617 = (((_zz_result_191 && (! _zz_result_160[30])) && _zz_result_160[31]) ? 6'h1f : ((_zz_result_191 && _zz_result_160[30]) ? 6'h1e : ((_zz_result_190 && _zz_result_160[29]) ? 6'h1d : ((_zz_result_189 && _zz_result_160[28]) ? 6'h1c : ((_zz_result_188 && _zz_result_618) ? 6'h1b : (_zz_result_619 ? _zz_result_620 : _zz_result_621))))));
  assign _zz_result_616 = {58'd0, _zz_result_617};
  assign _zz_result_635 = _zz_result_636[5:0];
  assign _zz_result_634 = {58'd0, _zz_result_635};
  assign _zz_result_636 = ({1'b0,_zz_result_637} + _zz_result_761);
  assign _zz_result_638 = ({1'b0,_zz_result_639} + _zz_result_759);
  assign _zz_result_637 = _zz_result_638[5:0];
  assign _zz_result_640 = ({1'b0,_zz_result_641} + _zz_result_757);
  assign _zz_result_639 = _zz_result_640[5:0];
  assign _zz_result_642 = ({1'b0,_zz_result_643} + _zz_result_755);
  assign _zz_result_641 = _zz_result_642[5:0];
  assign _zz_result_644 = ({1'b0,_zz_result_645} + _zz_result_753);
  assign _zz_result_643 = _zz_result_644[5:0];
  assign _zz_result_646 = ({1'b0,_zz_result_647} + _zz_result_751);
  assign _zz_result_645 = _zz_result_646[5:0];
  assign _zz_result_648 = ({1'b0,_zz_result_649} + _zz_result_749);
  assign _zz_result_647 = _zz_result_648[5:0];
  assign _zz_result_650 = ({1'b0,_zz_result_651} + _zz_result_747);
  assign _zz_result_649 = _zz_result_650[5:0];
  assign _zz_result_652 = ({1'b0,_zz_result_653} + _zz_result_745);
  assign _zz_result_651 = _zz_result_652[5:0];
  assign _zz_result_654 = ({1'b0,_zz_result_655} + _zz_result_743);
  assign _zz_result_653 = _zz_result_654[5:0];
  assign _zz_result_656 = ({1'b0,_zz_result_657} + _zz_result_741);
  assign _zz_result_655 = _zz_result_656[5:0];
  assign _zz_result_658 = ({1'b0,_zz_result_659} + _zz_result_739);
  assign _zz_result_657 = _zz_result_658[5:0];
  assign _zz_result_660 = ({1'b0,_zz_result_661} + _zz_result_737);
  assign _zz_result_659 = _zz_result_660[5:0];
  assign _zz_result_662 = ({1'b0,_zz_result_663} + _zz_result_735);
  assign _zz_result_661 = _zz_result_662[5:0];
  assign _zz_result_664 = ({1'b0,_zz_result_665} + _zz_result_733);
  assign _zz_result_663 = _zz_result_664[5:0];
  assign _zz_result_666 = ({1'b0,_zz_result_667} + _zz_result_731);
  assign _zz_result_665 = _zz_result_666[5:0];
  assign _zz_result_668 = ({1'b0,_zz_result_669} + _zz_result_729);
  assign _zz_result_667 = _zz_result_668[5:0];
  assign _zz_result_670 = ({1'b0,_zz_result_671} + _zz_result_727);
  assign _zz_result_669 = _zz_result_670[5:0];
  assign _zz_result_672 = ({1'b0,_zz_result_673} + _zz_result_725);
  assign _zz_result_671 = _zz_result_672[5:0];
  assign _zz_result_674 = ({1'b0,_zz_result_675} + _zz_result_723);
  assign _zz_result_673 = _zz_result_674[5:0];
  assign _zz_result_676 = ({1'b0,_zz_result_677} + _zz_result_721);
  assign _zz_result_675 = _zz_result_676[5:0];
  assign _zz_result_678 = ({1'b0,_zz_result_679} + _zz_result_719);
  assign _zz_result_677 = _zz_result_678[5:0];
  assign _zz_result_680 = ({1'b0,_zz_result_681} + _zz_result_717);
  assign _zz_result_679 = _zz_result_680[5:0];
  assign _zz_result_682 = ({1'b0,_zz_result_683} + _zz_result_715);
  assign _zz_result_681 = _zz_result_682[5:0];
  assign _zz_result_684 = ({1'b0,_zz_result_685} + _zz_result_713);
  assign _zz_result_683 = _zz_result_684[5:0];
  assign _zz_result_686 = ({1'b0,_zz_result_687} + _zz_result_711);
  assign _zz_result_685 = _zz_result_686[5:0];
  assign _zz_result_688 = ({1'b0,_zz_result_689} + _zz_result_709);
  assign _zz_result_687 = _zz_result_688[5:0];
  assign _zz_result_690 = ({1'b0,_zz_result_691} + _zz_result_707);
  assign _zz_result_689 = _zz_result_690[5:0];
  assign _zz_result_692 = ({1'b0,_zz_result_693} + _zz_result_705);
  assign _zz_result_691 = _zz_result_692[5:0];
  assign _zz_result_694 = ({1'b0,_zz_result_695} + _zz_result_703);
  assign _zz_result_693 = _zz_result_694[5:0];
  assign _zz_result_696 = ({1'b0,_zz_result_697} + _zz_result_701);
  assign _zz_result_695 = _zz_result_696[5:0];
  assign _zz_result_698 = ({1'b0,6'h0} + _zz_result_699);
  assign _zz_result_697 = _zz_result_698[5:0];
  assign _zz_result_700 = {1'b0,_zz_result_192[0]};
  assign _zz_result_699 = {5'd0, _zz_result_700};
  assign _zz_result_702 = {1'b0,_zz_result_192[1]};
  assign _zz_result_701 = {5'd0, _zz_result_702};
  assign _zz_result_704 = {1'b0,_zz_result_192[2]};
  assign _zz_result_703 = {5'd0, _zz_result_704};
  assign _zz_result_706 = {1'b0,_zz_result_192[3]};
  assign _zz_result_705 = {5'd0, _zz_result_706};
  assign _zz_result_708 = {1'b0,_zz_result_192[4]};
  assign _zz_result_707 = {5'd0, _zz_result_708};
  assign _zz_result_710 = {1'b0,_zz_result_192[5]};
  assign _zz_result_709 = {5'd0, _zz_result_710};
  assign _zz_result_712 = {1'b0,_zz_result_192[6]};
  assign _zz_result_711 = {5'd0, _zz_result_712};
  assign _zz_result_714 = {1'b0,_zz_result_192[7]};
  assign _zz_result_713 = {5'd0, _zz_result_714};
  assign _zz_result_716 = {1'b0,_zz_result_192[8]};
  assign _zz_result_715 = {5'd0, _zz_result_716};
  assign _zz_result_718 = {1'b0,_zz_result_192[9]};
  assign _zz_result_717 = {5'd0, _zz_result_718};
  assign _zz_result_720 = {1'b0,_zz_result_192[10]};
  assign _zz_result_719 = {5'd0, _zz_result_720};
  assign _zz_result_722 = {1'b0,_zz_result_192[11]};
  assign _zz_result_721 = {5'd0, _zz_result_722};
  assign _zz_result_724 = {1'b0,_zz_result_192[12]};
  assign _zz_result_723 = {5'd0, _zz_result_724};
  assign _zz_result_726 = {1'b0,_zz_result_192[13]};
  assign _zz_result_725 = {5'd0, _zz_result_726};
  assign _zz_result_728 = {1'b0,_zz_result_192[14]};
  assign _zz_result_727 = {5'd0, _zz_result_728};
  assign _zz_result_730 = {1'b0,_zz_result_192[15]};
  assign _zz_result_729 = {5'd0, _zz_result_730};
  assign _zz_result_732 = {1'b0,_zz_result_192[16]};
  assign _zz_result_731 = {5'd0, _zz_result_732};
  assign _zz_result_734 = {1'b0,_zz_result_192[17]};
  assign _zz_result_733 = {5'd0, _zz_result_734};
  assign _zz_result_736 = {1'b0,_zz_result_192[18]};
  assign _zz_result_735 = {5'd0, _zz_result_736};
  assign _zz_result_738 = {1'b0,_zz_result_192[19]};
  assign _zz_result_737 = {5'd0, _zz_result_738};
  assign _zz_result_740 = {1'b0,_zz_result_192[20]};
  assign _zz_result_739 = {5'd0, _zz_result_740};
  assign _zz_result_742 = {1'b0,_zz_result_192[21]};
  assign _zz_result_741 = {5'd0, _zz_result_742};
  assign _zz_result_744 = {1'b0,_zz_result_192[22]};
  assign _zz_result_743 = {5'd0, _zz_result_744};
  assign _zz_result_746 = {1'b0,_zz_result_192[23]};
  assign _zz_result_745 = {5'd0, _zz_result_746};
  assign _zz_result_748 = {1'b0,_zz_result_192[24]};
  assign _zz_result_747 = {5'd0, _zz_result_748};
  assign _zz_result_750 = {1'b0,_zz_result_192[25]};
  assign _zz_result_749 = {5'd0, _zz_result_750};
  assign _zz_result_752 = {1'b0,_zz_result_192[26]};
  assign _zz_result_751 = {5'd0, _zz_result_752};
  assign _zz_result_754 = {1'b0,_zz_result_192[27]};
  assign _zz_result_753 = {5'd0, _zz_result_754};
  assign _zz_result_756 = {1'b0,_zz_result_192[28]};
  assign _zz_result_755 = {5'd0, _zz_result_756};
  assign _zz_result_758 = {1'b0,_zz_result_192[29]};
  assign _zz_result_757 = {5'd0, _zz_result_758};
  assign _zz_result_760 = {1'b0,_zz_result_192[30]};
  assign _zz_result_759 = {5'd0, _zz_result_760};
  assign _zz_result_762 = {1'b0,_zz_result_192[31]};
  assign _zz_result_761 = {5'd0, _zz_result_762};
  assign _zz_result_764 = ((shamtW == 5'h0) ? aWU : (_zz_result_765 | _zz_result_768));
  assign _zz_result_763 = {{32{_zz_result_764[31]}}, _zz_result_764};
  assign _zz_result_766 = ({31'd0,aWU} <<< _zz_result_767);
  assign _zz_result_765 = _zz_result_766[31:0];
  assign _zz_result_767 = _zz_result_193[4:0];
  assign _zz_result_768 = (aWU >>> _zz_result_769);
  assign _zz_result_769 = (6'h20 - _zz_result_193);
  assign _zz_result_771 = ((shamtW == 5'h0) ? aWU : (_zz_result_772 | _zz_result_773));
  assign _zz_result_770 = {{32{_zz_result_771[31]}}, _zz_result_771};
  assign _zz_result_772 = (aWU >>> _zz_result_194);
  assign _zz_result_774 = ({63'd0,aWU} <<< _zz_result_775);
  assign _zz_result_773 = _zz_result_774[31:0];
  assign _zz_result_775 = (6'h20 - _zz_result_194);
  assign _zz_clmulFull = ((((((((_zz_clmulFull_1 ^ _zz_clmulFull_123) ^ (_zz_clmulFull_126 ? _zz_clmulFull_127 : _zz_clmulFull_129)) ^ (bU[51] ? _zz_clmulFull_130 : 128'h0)) ^ (bU[52] ? _zz_clmulFull_132 : 128'h0)) ^ (bU[53] ? _zz_clmulFull_134 : 128'h0)) ^ (bU[54] ? _zz_clmulFull_136 : 128'h0)) ^ (bU[55] ? _zz_clmulFull_138 : 128'h0)) ^ (bU[56] ? _zz_clmulFull_140 : 128'h0));
  assign _zz_clmulFull_142 = (bU[57] ? _zz_clmulFull_143 : 128'h0);
  assign _zz_clmulFull_145 = bU[58];
  assign _zz_clmulFull_148 = 128'h0;
  assign _zz_clmulFull_1 = ((((((((_zz_clmulFull_2 ^ _zz_clmulFull_104) ^ (_zz_clmulFull_107 ? _zz_clmulFull_108 : _zz_clmulFull_110)) ^ (bU[43] ? _zz_clmulFull_111 : 128'h0)) ^ (bU[44] ? _zz_clmulFull_113 : 128'h0)) ^ (bU[45] ? _zz_clmulFull_115 : 128'h0)) ^ (bU[46] ? _zz_clmulFull_117 : 128'h0)) ^ (bU[47] ? _zz_clmulFull_119 : 128'h0)) ^ (bU[48] ? _zz_clmulFull_121 : 128'h0));
  assign _zz_clmulFull_123 = (bU[49] ? _zz_clmulFull_124 : 128'h0);
  assign _zz_clmulFull_126 = bU[50];
  assign _zz_clmulFull_129 = 128'h0;
  assign _zz_clmulFull_2 = ((((((((_zz_clmulFull_3 ^ _zz_clmulFull_85) ^ (_zz_clmulFull_88 ? _zz_clmulFull_89 : _zz_clmulFull_91)) ^ (bU[35] ? _zz_clmulFull_92 : 128'h0)) ^ (bU[36] ? _zz_clmulFull_94 : 128'h0)) ^ (bU[37] ? _zz_clmulFull_96 : 128'h0)) ^ (bU[38] ? _zz_clmulFull_98 : 128'h0)) ^ (bU[39] ? _zz_clmulFull_100 : 128'h0)) ^ (bU[40] ? _zz_clmulFull_102 : 128'h0));
  assign _zz_clmulFull_104 = (bU[41] ? _zz_clmulFull_105 : 128'h0);
  assign _zz_clmulFull_107 = bU[42];
  assign _zz_clmulFull_110 = 128'h0;
  assign _zz_clmulFull_3 = ((((((((_zz_clmulFull_4 ^ _zz_clmulFull_66) ^ (_zz_clmulFull_69 ? _zz_clmulFull_70 : _zz_clmulFull_72)) ^ (bU[27] ? _zz_clmulFull_73 : 128'h0)) ^ (bU[28] ? _zz_clmulFull_75 : 128'h0)) ^ (bU[29] ? _zz_clmulFull_77 : 128'h0)) ^ (bU[30] ? _zz_clmulFull_79 : 128'h0)) ^ (bU[31] ? _zz_clmulFull_81 : 128'h0)) ^ (bU[32] ? _zz_clmulFull_83 : 128'h0));
  assign _zz_clmulFull_85 = (bU[33] ? _zz_clmulFull_86 : 128'h0);
  assign _zz_clmulFull_88 = bU[34];
  assign _zz_clmulFull_91 = 128'h0;
  assign _zz_clmulFull_4 = ((((((((_zz_clmulFull_5 ^ _zz_clmulFull_47) ^ (_zz_clmulFull_50 ? _zz_clmulFull_51 : _zz_clmulFull_53)) ^ (bU[19] ? _zz_clmulFull_54 : 128'h0)) ^ (bU[20] ? _zz_clmulFull_56 : 128'h0)) ^ (bU[21] ? _zz_clmulFull_58 : 128'h0)) ^ (bU[22] ? _zz_clmulFull_60 : 128'h0)) ^ (bU[23] ? _zz_clmulFull_62 : 128'h0)) ^ (bU[24] ? _zz_clmulFull_64 : 128'h0));
  assign _zz_clmulFull_66 = (bU[25] ? _zz_clmulFull_67 : 128'h0);
  assign _zz_clmulFull_69 = bU[26];
  assign _zz_clmulFull_72 = 128'h0;
  assign _zz_clmulFull_5 = ((((((((_zz_clmulFull_6 ^ _zz_clmulFull_28) ^ (_zz_clmulFull_31 ? _zz_clmulFull_32 : _zz_clmulFull_34)) ^ (bU[11] ? _zz_clmulFull_35 : 128'h0)) ^ (bU[12] ? _zz_clmulFull_37 : 128'h0)) ^ (bU[13] ? _zz_clmulFull_39 : 128'h0)) ^ (bU[14] ? _zz_clmulFull_41 : 128'h0)) ^ (bU[15] ? _zz_clmulFull_43 : 128'h0)) ^ (bU[16] ? _zz_clmulFull_45 : 128'h0));
  assign _zz_clmulFull_47 = (bU[17] ? _zz_clmulFull_48 : 128'h0);
  assign _zz_clmulFull_50 = bU[18];
  assign _zz_clmulFull_53 = 128'h0;
  assign _zz_clmulFull_6 = ((((((((_zz_clmulFull_7 ^ _zz_clmulFull_9) ^ (_zz_clmulFull_12 ? _zz_clmulFull_13 : _zz_clmulFull_15)) ^ (bU[3] ? _zz_clmulFull_16 : 128'h0)) ^ (bU[4] ? _zz_clmulFull_18 : 128'h0)) ^ (bU[5] ? _zz_clmulFull_20 : 128'h0)) ^ (bU[6] ? _zz_clmulFull_22 : 128'h0)) ^ (bU[7] ? _zz_clmulFull_24 : 128'h0)) ^ (bU[8] ? _zz_clmulFull_26 : 128'h0));
  assign _zz_clmulFull_28 = (bU[9] ? _zz_clmulFull_29 : 128'h0);
  assign _zz_clmulFull_31 = bU[10];
  assign _zz_clmulFull_34 = 128'h0;
  assign _zz_clmulFull_7 = (128'h0 ^ (bU[0] ? _zz_clmulFull_8 : 128'h0));
  assign _zz_clmulFull_9 = (bU[1] ? _zz_clmulFull_10 : 128'h0);
  assign _zz_clmulFull_12 = bU[2];
  assign _zz_clmulFull_15 = 128'h0;
  assign _zz_result_219 = io_a[4];
  assign _zz_result_220 = (_zz_result_58 && io_a[5]);
  assign _zz_result_221 = 7'h3a;
  assign _zz_result_222 = ((_zz_result_57 && io_a[6]) ? 7'h39 : ((_zz_result_56 && io_a[7]) ? 7'h38 : ((_zz_result_55 && io_a[8]) ? 7'h37 : ((_zz_result_54 && io_a[9]) ? 7'h36 : ((_zz_result_53 && io_a[10]) ? 7'h35 : ((_zz_result_52 && _zz_result_223) ? 7'h34 : (_zz_result_224 ? _zz_result_225 : _zz_result_226)))))));
  assign _zz_result_223 = io_a[11];
  assign _zz_result_224 = (_zz_result_51 && io_a[12]);
  assign _zz_result_225 = 7'h33;
  assign _zz_result_226 = ((_zz_result_50 && io_a[13]) ? 7'h32 : ((_zz_result_49 && io_a[14]) ? 7'h31 : ((_zz_result_48 && io_a[15]) ? 7'h30 : ((_zz_result_47 && io_a[16]) ? 7'h2f : ((_zz_result_46 && io_a[17]) ? 7'h2e : ((_zz_result_45 && _zz_result_227) ? 7'h2d : (_zz_result_228 ? _zz_result_229 : _zz_result_230)))))));
  assign _zz_result_227 = io_a[18];
  assign _zz_result_228 = (_zz_result_44 && io_a[19]);
  assign _zz_result_229 = 7'h2c;
  assign _zz_result_230 = ((_zz_result_43 && io_a[20]) ? 7'h2b : ((_zz_result_42 && io_a[21]) ? 7'h2a : ((_zz_result_41 && io_a[22]) ? 7'h29 : ((_zz_result_40 && io_a[23]) ? 7'h28 : ((_zz_result_39 && io_a[24]) ? 7'h27 : ((_zz_result_38 && _zz_result_231) ? 7'h26 : (_zz_result_232 ? _zz_result_233 : _zz_result_234)))))));
  assign _zz_result_231 = io_a[25];
  assign _zz_result_232 = (_zz_result_37 && io_a[26]);
  assign _zz_result_233 = 7'h25;
  assign _zz_result_234 = ((_zz_result_36 && io_a[27]) ? 7'h24 : ((_zz_result_35 && io_a[28]) ? 7'h23 : ((_zz_result_34 && io_a[29]) ? 7'h22 : ((_zz_result_33 && io_a[30]) ? 7'h21 : ((_zz_result_32 && io_a[31]) ? 7'h20 : ((_zz_result_31 && _zz_result_235) ? 7'h1f : (_zz_result_236 ? _zz_result_237 : _zz_result_238)))))));
  assign _zz_result_235 = io_a[32];
  assign _zz_result_236 = (_zz_result_30 && io_a[33]);
  assign _zz_result_237 = 7'h1e;
  assign _zz_result_238 = ((_zz_result_29 && io_a[34]) ? 7'h1d : ((_zz_result_28 && io_a[35]) ? 7'h1c : ((_zz_result_27 && io_a[36]) ? 7'h1b : ((_zz_result_26 && io_a[37]) ? 7'h1a : ((_zz_result_25 && io_a[38]) ? 7'h19 : ((_zz_result_24 && _zz_result_239) ? 7'h18 : (_zz_result_240 ? _zz_result_241 : _zz_result_242)))))));
  assign _zz_result_239 = io_a[39];
  assign _zz_result_240 = (_zz_result_23 && io_a[40]);
  assign _zz_result_241 = 7'h17;
  assign _zz_result_242 = ((_zz_result_22 && io_a[41]) ? 7'h16 : ((_zz_result_21 && io_a[42]) ? 7'h15 : ((_zz_result_20 && io_a[43]) ? 7'h14 : ((_zz_result_19 && io_a[44]) ? 7'h13 : ((_zz_result_18 && io_a[45]) ? 7'h12 : ((_zz_result_17 && _zz_result_243) ? 7'h11 : (_zz_result_244 ? _zz_result_245 : _zz_result_246)))))));
  assign _zz_result_243 = io_a[46];
  assign _zz_result_244 = (_zz_result_16 && io_a[47]);
  assign _zz_result_245 = 7'h10;
  assign _zz_result_246 = ((_zz_result_15 && io_a[48]) ? 7'h0f : ((_zz_result_14 && io_a[49]) ? 7'h0e : ((_zz_result_13 && io_a[50]) ? 7'h0d : ((_zz_result_12 && io_a[51]) ? 7'h0c : ((_zz_result_11 && io_a[52]) ? 7'h0b : ((_zz_result_10 && _zz_result_247) ? 7'h0a : (_zz_result_248 ? _zz_result_249 : _zz_result_250)))))));
  assign _zz_result_247 = io_a[53];
  assign _zz_result_248 = (_zz_result_9 && io_a[54]);
  assign _zz_result_249 = 7'h09;
  assign _zz_result_250 = ((_zz_result_8 && io_a[55]) ? 7'h08 : ((_zz_result_7 && io_a[56]) ? 7'h07 : ((_zz_result_6 && io_a[57]) ? 7'h06 : ((_zz_result_5 && io_a[58]) ? 7'h05 : ((_zz_result_4 && io_a[59]) ? 7'h04 : ((_zz_result_3 && _zz_result_251) ? 7'h03 : (_zz_result_252 ? _zz_result_253 : _zz_result_254)))))));
  assign _zz_result_251 = io_a[60];
  assign _zz_result_252 = (_zz_result_2 && io_a[61]);
  assign _zz_result_253 = 7'h02;
  assign _zz_result_254 = ((_zz_result_1 && io_a[62]) ? 7'h01 : ((_zz_result && io_a[63]) ? 7'h0 : 7'h40));
  assign _zz_result_257 = io_a[59];
  assign _zz_result_258 = (_zz_result_121 && io_a[58]);
  assign _zz_result_259 = 7'h3a;
  assign _zz_result_260 = ((_zz_result_120 && io_a[57]) ? 7'h39 : ((_zz_result_119 && io_a[56]) ? 7'h38 : ((_zz_result_118 && io_a[55]) ? 7'h37 : ((_zz_result_117 && io_a[54]) ? 7'h36 : ((_zz_result_116 && io_a[53]) ? 7'h35 : ((_zz_result_115 && _zz_result_261) ? 7'h34 : (_zz_result_262 ? _zz_result_263 : _zz_result_264)))))));
  assign _zz_result_261 = io_a[52];
  assign _zz_result_262 = (_zz_result_114 && io_a[51]);
  assign _zz_result_263 = 7'h33;
  assign _zz_result_264 = ((_zz_result_113 && io_a[50]) ? 7'h32 : ((_zz_result_112 && io_a[49]) ? 7'h31 : ((_zz_result_111 && io_a[48]) ? 7'h30 : ((_zz_result_110 && io_a[47]) ? 7'h2f : ((_zz_result_109 && io_a[46]) ? 7'h2e : ((_zz_result_108 && _zz_result_265) ? 7'h2d : (_zz_result_266 ? _zz_result_267 : _zz_result_268)))))));
  assign _zz_result_265 = io_a[45];
  assign _zz_result_266 = (_zz_result_107 && io_a[44]);
  assign _zz_result_267 = 7'h2c;
  assign _zz_result_268 = ((_zz_result_106 && io_a[43]) ? 7'h2b : ((_zz_result_105 && io_a[42]) ? 7'h2a : ((_zz_result_104 && io_a[41]) ? 7'h29 : ((_zz_result_103 && io_a[40]) ? 7'h28 : ((_zz_result_102 && io_a[39]) ? 7'h27 : ((_zz_result_101 && _zz_result_269) ? 7'h26 : (_zz_result_270 ? _zz_result_271 : _zz_result_272)))))));
  assign _zz_result_269 = io_a[38];
  assign _zz_result_270 = (_zz_result_100 && io_a[37]);
  assign _zz_result_271 = 7'h25;
  assign _zz_result_272 = ((_zz_result_99 && io_a[36]) ? 7'h24 : ((_zz_result_98 && io_a[35]) ? 7'h23 : ((_zz_result_97 && io_a[34]) ? 7'h22 : ((_zz_result_96 && io_a[33]) ? 7'h21 : ((_zz_result_95 && io_a[32]) ? 7'h20 : ((_zz_result_94 && _zz_result_273) ? 7'h1f : (_zz_result_274 ? _zz_result_275 : _zz_result_276)))))));
  assign _zz_result_273 = io_a[31];
  assign _zz_result_274 = (_zz_result_93 && io_a[30]);
  assign _zz_result_275 = 7'h1e;
  assign _zz_result_276 = ((_zz_result_92 && io_a[29]) ? 7'h1d : ((_zz_result_91 && io_a[28]) ? 7'h1c : ((_zz_result_90 && io_a[27]) ? 7'h1b : ((_zz_result_89 && io_a[26]) ? 7'h1a : ((_zz_result_88 && io_a[25]) ? 7'h19 : ((_zz_result_87 && _zz_result_277) ? 7'h18 : (_zz_result_278 ? _zz_result_279 : _zz_result_280)))))));
  assign _zz_result_277 = io_a[24];
  assign _zz_result_278 = (_zz_result_86 && io_a[23]);
  assign _zz_result_279 = 7'h17;
  assign _zz_result_280 = ((_zz_result_85 && io_a[22]) ? 7'h16 : ((_zz_result_84 && io_a[21]) ? 7'h15 : ((_zz_result_83 && io_a[20]) ? 7'h14 : ((_zz_result_82 && io_a[19]) ? 7'h13 : ((_zz_result_81 && io_a[18]) ? 7'h12 : ((_zz_result_80 && _zz_result_281) ? 7'h11 : (_zz_result_282 ? _zz_result_283 : _zz_result_284)))))));
  assign _zz_result_281 = io_a[17];
  assign _zz_result_282 = (_zz_result_79 && io_a[16]);
  assign _zz_result_283 = 7'h10;
  assign _zz_result_284 = ((_zz_result_78 && io_a[15]) ? 7'h0f : ((_zz_result_77 && io_a[14]) ? 7'h0e : ((_zz_result_76 && io_a[13]) ? 7'h0d : ((_zz_result_75 && io_a[12]) ? 7'h0c : ((_zz_result_74 && io_a[11]) ? 7'h0b : ((_zz_result_73 && _zz_result_285) ? 7'h0a : (_zz_result_286 ? _zz_result_287 : _zz_result_288)))))));
  assign _zz_result_285 = io_a[10];
  assign _zz_result_286 = (_zz_result_72 && io_a[9]);
  assign _zz_result_287 = 7'h09;
  assign _zz_result_288 = ((_zz_result_71 && io_a[8]) ? 7'h08 : ((_zz_result_70 && io_a[7]) ? 7'h07 : ((_zz_result_69 && io_a[6]) ? 7'h06 : ((_zz_result_68 && io_a[5]) ? 7'h05 : ((_zz_result_67 && io_a[4]) ? 7'h04 : ((_zz_result_66 && _zz_result_289) ? 7'h03 : (_zz_result_290 ? _zz_result_291 : _zz_result_292)))))));
  assign _zz_result_289 = io_a[3];
  assign _zz_result_290 = (_zz_result_65 && io_a[2]);
  assign _zz_result_291 = 7'h02;
  assign _zz_result_292 = ((_zz_result_64 && io_a[1]) ? 7'h01 : ((_zz_result_63 && io_a[0]) ? 7'h0 : 7'h40));
  assign _zz_result_556 = io_a[39 : 32];
  assign _zz_result_557 = (|io_a[31 : 24]);
  assign _zz_result_558 = 8'hff;
  assign _zz_result_559 = 8'h0;
  assign _zz_result_560 = ((|io_a[23 : 16]) ? 8'hff : 8'h0);
  assign _zz_result_561 = {((|io_a[15 : 8]) ? 8'hff : 8'h0),((|io_a[7 : 0]) ? 8'hff : 8'h0)};
  assign _zz_result_600 = _zz_result_128[4];
  assign _zz_result_601 = (_zz_result_155 && _zz_result_128[5]);
  assign _zz_result_602 = 6'h1a;
  assign _zz_result_603 = ((_zz_result_154 && _zz_result_128[6]) ? 6'h19 : ((_zz_result_153 && _zz_result_128[7]) ? 6'h18 : ((_zz_result_152 && _zz_result_128[8]) ? 6'h17 : ((_zz_result_151 && _zz_result_128[9]) ? 6'h16 : ((_zz_result_150 && _zz_result_128[10]) ? 6'h15 : ((_zz_result_149 && _zz_result_604) ? 6'h14 : (_zz_result_605 ? _zz_result_606 : _zz_result_607)))))));
  assign _zz_result_604 = _zz_result_128[11];
  assign _zz_result_605 = (_zz_result_148 && _zz_result_128[12]);
  assign _zz_result_606 = 6'h13;
  assign _zz_result_607 = ((_zz_result_147 && _zz_result_128[13]) ? 6'h12 : ((_zz_result_146 && _zz_result_128[14]) ? 6'h11 : ((_zz_result_145 && _zz_result_128[15]) ? 6'h10 : ((_zz_result_144 && _zz_result_128[16]) ? 6'h0f : ((_zz_result_143 && _zz_result_128[17]) ? 6'h0e : ((_zz_result_142 && _zz_result_608) ? 6'h0d : (_zz_result_609 ? _zz_result_610 : _zz_result_611)))))));
  assign _zz_result_608 = _zz_result_128[18];
  assign _zz_result_609 = (_zz_result_141 && _zz_result_128[19]);
  assign _zz_result_610 = 6'h0c;
  assign _zz_result_611 = ((_zz_result_140 && _zz_result_128[20]) ? 6'h0b : ((_zz_result_139 && _zz_result_128[21]) ? 6'h0a : ((_zz_result_138 && _zz_result_128[22]) ? 6'h09 : ((_zz_result_137 && _zz_result_128[23]) ? 6'h08 : ((_zz_result_136 && _zz_result_128[24]) ? 6'h07 : ((_zz_result_135 && _zz_result_612) ? 6'h06 : (_zz_result_613 ? _zz_result_614 : _zz_result_615)))))));
  assign _zz_result_612 = _zz_result_128[25];
  assign _zz_result_613 = (_zz_result_134 && _zz_result_128[26]);
  assign _zz_result_614 = 6'h05;
  assign _zz_result_615 = ((_zz_result_133 && _zz_result_128[27]) ? 6'h04 : ((_zz_result_132 && _zz_result_128[28]) ? 6'h03 : ((_zz_result_131 && _zz_result_128[29]) ? 6'h02 : ((_zz_result_130 && _zz_result_128[30]) ? 6'h01 : ((_zz_result_129 && _zz_result_128[31]) ? 6'h0 : 6'h20)))));
  assign _zz_result_618 = _zz_result_160[27];
  assign _zz_result_619 = (_zz_result_187 && _zz_result_160[26]);
  assign _zz_result_620 = 6'h1a;
  assign _zz_result_621 = ((_zz_result_186 && _zz_result_160[25]) ? 6'h19 : ((_zz_result_185 && _zz_result_160[24]) ? 6'h18 : ((_zz_result_184 && _zz_result_160[23]) ? 6'h17 : ((_zz_result_183 && _zz_result_160[22]) ? 6'h16 : ((_zz_result_182 && _zz_result_160[21]) ? 6'h15 : ((_zz_result_181 && _zz_result_622) ? 6'h14 : (_zz_result_623 ? _zz_result_624 : _zz_result_625)))))));
  assign _zz_result_622 = _zz_result_160[20];
  assign _zz_result_623 = (_zz_result_180 && _zz_result_160[19]);
  assign _zz_result_624 = 6'h13;
  assign _zz_result_625 = ((_zz_result_179 && _zz_result_160[18]) ? 6'h12 : ((_zz_result_178 && _zz_result_160[17]) ? 6'h11 : ((_zz_result_177 && _zz_result_160[16]) ? 6'h10 : ((_zz_result_176 && _zz_result_160[15]) ? 6'h0f : ((_zz_result_175 && _zz_result_160[14]) ? 6'h0e : ((_zz_result_174 && _zz_result_626) ? 6'h0d : (_zz_result_627 ? _zz_result_628 : _zz_result_629)))))));
  assign _zz_result_626 = _zz_result_160[13];
  assign _zz_result_627 = (_zz_result_173 && _zz_result_160[12]);
  assign _zz_result_628 = 6'h0c;
  assign _zz_result_629 = ((_zz_result_172 && _zz_result_160[11]) ? 6'h0b : ((_zz_result_171 && _zz_result_160[10]) ? 6'h0a : ((_zz_result_170 && _zz_result_160[9]) ? 6'h09 : ((_zz_result_169 && _zz_result_160[8]) ? 6'h08 : ((_zz_result_168 && _zz_result_160[7]) ? 6'h07 : ((_zz_result_167 && _zz_result_630) ? 6'h06 : (_zz_result_631 ? _zz_result_632 : _zz_result_633)))))));
  assign _zz_result_630 = _zz_result_160[6];
  assign _zz_result_631 = (_zz_result_166 && _zz_result_160[5]);
  assign _zz_result_632 = 6'h05;
  assign _zz_result_633 = ((_zz_result_165 && _zz_result_160[4]) ? 6'h04 : ((_zz_result_164 && _zz_result_160[3]) ? 6'h03 : ((_zz_result_163 && _zz_result_160[2]) ? 6'h02 : ((_zz_result_162 && _zz_result_160[1]) ? 6'h01 : ((_zz_result_161 && _zz_result_160[0]) ? 6'h0 : 6'h20)))));
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_op)
      AluOp_ADD : io_op_string = "ADD     ";
      AluOp_SUB : io_op_string = "SUB     ";
      AluOp_SLL_1 : io_op_string = "SLL_1   ";
      AluOp_SLT : io_op_string = "SLT     ";
      AluOp_SLTU : io_op_string = "SLTU    ";
      AluOp_XOR_1 : io_op_string = "XOR_1   ";
      AluOp_SRL_1 : io_op_string = "SRL_1   ";
      AluOp_SRA_1 : io_op_string = "SRA_1   ";
      AluOp_OR_1 : io_op_string = "OR_1    ";
      AluOp_AND_1 : io_op_string = "AND_1   ";
      AluOp_ADDW : io_op_string = "ADDW    ";
      AluOp_SUBW : io_op_string = "SUBW    ";
      AluOp_SLLW : io_op_string = "SLLW    ";
      AluOp_SRLW : io_op_string = "SRLW    ";
      AluOp_SRAW : io_op_string = "SRAW    ";
      AluOp_MUL : io_op_string = "MUL     ";
      AluOp_MULH : io_op_string = "MULH    ";
      AluOp_MULHSU : io_op_string = "MULHSU  ";
      AluOp_MULHU : io_op_string = "MULHU   ";
      AluOp_DIV : io_op_string = "DIV     ";
      AluOp_DIVU : io_op_string = "DIVU    ";
      AluOp_REM_1 : io_op_string = "REM_1   ";
      AluOp_REMU : io_op_string = "REMU    ";
      AluOp_MULW : io_op_string = "MULW    ";
      AluOp_DIVW : io_op_string = "DIVW    ";
      AluOp_DIVUW : io_op_string = "DIVUW   ";
      AluOp_REMW : io_op_string = "REMW    ";
      AluOp_REMUW : io_op_string = "REMUW   ";
      AluOp_ANDN : io_op_string = "ANDN    ";
      AluOp_ORN : io_op_string = "ORN     ";
      AluOp_XNOR_1 : io_op_string = "XNOR_1  ";
      AluOp_CLZ : io_op_string = "CLZ     ";
      AluOp_CTZ : io_op_string = "CTZ     ";
      AluOp_CPOP : io_op_string = "CPOP    ";
      AluOp_SEXTB : io_op_string = "SEXTB   ";
      AluOp_SEXTH : io_op_string = "SEXTH   ";
      AluOp_ZEXTH : io_op_string = "ZEXTH   ";
      AluOp_ORCB : io_op_string = "ORCB    ";
      AluOp_REV8 : io_op_string = "REV8    ";
      AluOp_ROL_1 : io_op_string = "ROL_1   ";
      AluOp_ROR_1 : io_op_string = "ROR_1   ";
      AluOp_MIN : io_op_string = "MIN     ";
      AluOp_MINU : io_op_string = "MINU    ";
      AluOp_MAX : io_op_string = "MAX     ";
      AluOp_MAXU : io_op_string = "MAXU    ";
      AluOp_BSET : io_op_string = "BSET    ";
      AluOp_BCLR : io_op_string = "BCLR    ";
      AluOp_BINV : io_op_string = "BINV    ";
      AluOp_BEXT : io_op_string = "BEXT    ";
      AluOp_SH1ADD : io_op_string = "SH1ADD  ";
      AluOp_SH2ADD : io_op_string = "SH2ADD  ";
      AluOp_SH3ADD : io_op_string = "SH3ADD  ";
      AluOp_ADDUW : io_op_string = "ADDUW   ";
      AluOp_SH1ADDUW : io_op_string = "SH1ADDUW";
      AluOp_SH2ADDUW : io_op_string = "SH2ADDUW";
      AluOp_SH3ADDUW : io_op_string = "SH3ADDUW";
      AluOp_SLLIUW : io_op_string = "SLLIUW  ";
      AluOp_CLMUL : io_op_string = "CLMUL   ";
      AluOp_CLMULH : io_op_string = "CLMULH  ";
      AluOp_CLMULR : io_op_string = "CLMULR  ";
      AluOp_CLZW : io_op_string = "CLZW    ";
      AluOp_CTZW : io_op_string = "CTZW    ";
      AluOp_CPOPW : io_op_string = "CPOPW   ";
      AluOp_ROLW : io_op_string = "ROLW    ";
      AluOp_RORW : io_op_string = "RORW    ";
      default : io_op_string = "????????";
    endcase
  end
  `endif

  assign aU = io_a;
  assign bU = io_b;
  assign aS = io_a;
  assign bS = io_b;
  assign shamt = io_b[5 : 0];
  assign aW = aS[31 : 0];
  assign bW = bS[31 : 0];
  assign aWU = aU[31 : 0];
  assign shamtW = io_b[4 : 0];
  assign bitOneHot = _zz_bitOneHot[63:0];
  assign aZext = {32'd0, _zz_aZext};
  assign clmulFull = (((((((_zz_clmulFull ^ _zz_clmulFull_142) ^ (_zz_clmulFull_145 ? _zz_clmulFull_146 : _zz_clmulFull_148)) ^ (bU[59] ? _zz_clmulFull_149 : 128'h0)) ^ (bU[60] ? _zz_clmulFull_151 : 128'h0)) ^ (bU[61] ? _zz_clmulFull_153 : 128'h0)) ^ (bU[62] ? _zz_clmulFull_155 : 128'h0)) ^ (bU[63] ? _zz_clmulFull_157 : 128'h0));
  assign mulUU = (aU * bU);
  assign mulSS = ($signed(aS) * $signed(bS));
  assign aSE = {{1{aS[63]}}, aS};
  assign bUE = _zz_bUE;
  assign mulSU = ($signed(aSE) * $signed(bUE));
  assign mulLow = _zz_mulLow[63 : 0];
  assign mulHighS = _zz_mulHighS[127 : 64];
  assign mulHighSu = _zz_mulHighSu[127 : 64];
  assign mulHighU = _zz_mulHighU[127 : 64];
  always @(*) begin
    case(io_op)
      AluOp_ADD : begin
        result = _zz_result_195;
      end
      AluOp_SUB : begin
        result = _zz_result_196;
      end
      AluOp_SLL_1 : begin
        result = _zz_result_197;
      end
      AluOp_SLT : begin
        result = (($signed(aS) < $signed(bS)) ? 64'h0000000000000001 : 64'h0);
      end
      AluOp_SLTU : begin
        result = ((aU < bU) ? 64'h0000000000000001 : 64'h0);
      end
      AluOp_XOR_1 : begin
        result = (io_a ^ io_b);
      end
      AluOp_SRL_1 : begin
        result = _zz_result_199;
      end
      AluOp_SRA_1 : begin
        result = _zz_result_200;
      end
      AluOp_OR_1 : begin
        result = (io_a | io_b);
      end
      AluOp_AND_1 : begin
        result = (io_a & io_b);
      end
      AluOp_ADDW : begin
        result = _zz_result_201;
      end
      AluOp_SUBW : begin
        result = _zz_result_203;
      end
      AluOp_SLLW : begin
        result = _zz_result_205;
      end
      AluOp_SRLW : begin
        result = _zz_result_209;
      end
      AluOp_SRAW : begin
        result = _zz_result_212;
      end
      AluOp_MUL : begin
        result = mulLow;
      end
      AluOp_MULH : begin
        result = mulHighS;
      end
      AluOp_MULHSU : begin
        result = mulHighSu;
      end
      AluOp_MULHU : begin
        result = mulHighU;
      end
      AluOp_DIV : begin
        result = 64'h0;
      end
      AluOp_DIVU : begin
        result = 64'h0;
      end
      AluOp_REM_1 : begin
        result = 64'h0;
      end
      AluOp_REMU : begin
        result = 64'h0;
      end
      AluOp_MULW : begin
        result = _zz_result_214;
      end
      AluOp_DIVW : begin
        result = 64'h0;
      end
      AluOp_DIVUW : begin
        result = 64'h0;
      end
      AluOp_REMW : begin
        result = 64'h0;
      end
      AluOp_REMUW : begin
        result = 64'h0;
      end
      AluOp_ANDN : begin
        result = (io_a & (~ io_b));
      end
      AluOp_ORN : begin
        result = (io_a | (~ io_b));
      end
      AluOp_XNOR_1 : begin
        result = (~ (io_a ^ io_b));
      end
      AluOp_CLZ : begin
        result = _zz_result_217;
      end
      AluOp_CTZ : begin
        result = _zz_result_255;
      end
      AluOp_CPOP : begin
        result = _zz_result_293;
      end
      AluOp_SEXTB : begin
        result = _zz_result_550;
      end
      AluOp_SEXTH : begin
        result = _zz_result_552;
      end
      AluOp_ZEXTH : begin
        result = _zz_result_554;
      end
      AluOp_ORCB : begin
        result = {((|io_a[63 : 56]) ? 8'hff : 8'h0),{((|io_a[55 : 48]) ? 8'hff : 8'h0),{((|io_a[47 : 40]) ? 8'hff : 8'h0),{((|_zz_result_556) ? 8'hff : 8'h0),{(_zz_result_557 ? _zz_result_558 : _zz_result_559),{_zz_result_560,_zz_result_561}}}}}};
      end
      AluOp_REV8 : begin
        result = {io_a[7 : 0],{io_a[15 : 8],{io_a[23 : 16],{io_a[31 : 24],{io_a[39 : 32],{io_a[47 : 40],{io_a[55 : 48],io_a[63 : 56]}}}}}}};
      end
      AluOp_ROL_1 : begin
        result = ((shamt == 6'h0) ? aU : (_zz_result_562 | _zz_result_565));
      end
      AluOp_ROR_1 : begin
        result = ((shamt == 6'h0) ? aU : (_zz_result_567 | _zz_result_568));
      end
      AluOp_MIN : begin
        result = (($signed(aS) < $signed(bS)) ? io_a : io_b);
      end
      AluOp_MINU : begin
        result = ((aU < bU) ? io_a : io_b);
      end
      AluOp_MAX : begin
        result = (($signed(bS) < $signed(aS)) ? io_a : io_b);
      end
      AluOp_MAXU : begin
        result = ((bU < aU) ? io_a : io_b);
      end
      AluOp_BSET : begin
        result = (io_a | bitOneHot);
      end
      AluOp_BCLR : begin
        result = (io_a & (~ bitOneHot));
      end
      AluOp_BINV : begin
        result = (io_a ^ bitOneHot);
      end
      AluOp_BEXT : begin
        result = ((|(aU & bitOneHot)) ? 64'h0000000000000001 : 64'h0);
      end
      AluOp_SH1ADD : begin
        result = _zz_result_571;
      end
      AluOp_SH2ADD : begin
        result = _zz_result_575;
      end
      AluOp_SH3ADD : begin
        result = _zz_result_579;
      end
      AluOp_ADDUW : begin
        result = _zz_result_583;
      end
      AluOp_SH1ADDUW : begin
        result = _zz_result_584;
      end
      AluOp_SH2ADDUW : begin
        result = _zz_result_588;
      end
      AluOp_SH3ADDUW : begin
        result = _zz_result_592;
      end
      AluOp_SLLIUW : begin
        result = _zz_result_596;
      end
      AluOp_CLMUL : begin
        result = clmulFull[63 : 0];
      end
      AluOp_CLMULH : begin
        result = clmulFull[127 : 64];
      end
      AluOp_CLMULR : begin
        result = clmulFull[126 : 63];
      end
      AluOp_CLZW : begin
        result = _zz_result_598;
      end
      AluOp_CTZW : begin
        result = _zz_result_616;
      end
      AluOp_CPOPW : begin
        result = _zz_result_634;
      end
      AluOp_ROLW : begin
        result = _zz_result_763;
      end
      default : begin
        result = _zz_result_770;
      end
    endcase
  end

  assign _zz_result = 1'b1;
  assign _zz_result_1 = (_zz_result && (! io_a[63]));
  assign _zz_result_2 = (_zz_result_1 && (! io_a[62]));
  assign _zz_result_3 = (_zz_result_2 && (! io_a[61]));
  assign _zz_result_4 = (_zz_result_3 && (! io_a[60]));
  assign _zz_result_5 = (_zz_result_4 && (! io_a[59]));
  assign _zz_result_6 = (_zz_result_5 && (! io_a[58]));
  assign _zz_result_7 = (_zz_result_6 && (! io_a[57]));
  assign _zz_result_8 = (_zz_result_7 && (! io_a[56]));
  assign _zz_result_9 = (_zz_result_8 && (! io_a[55]));
  assign _zz_result_10 = (_zz_result_9 && (! io_a[54]));
  assign _zz_result_11 = (_zz_result_10 && (! io_a[53]));
  assign _zz_result_12 = (_zz_result_11 && (! io_a[52]));
  assign _zz_result_13 = (_zz_result_12 && (! io_a[51]));
  assign _zz_result_14 = (_zz_result_13 && (! io_a[50]));
  assign _zz_result_15 = (_zz_result_14 && (! io_a[49]));
  assign _zz_result_16 = (_zz_result_15 && (! io_a[48]));
  assign _zz_result_17 = (_zz_result_16 && (! io_a[47]));
  assign _zz_result_18 = (_zz_result_17 && (! io_a[46]));
  assign _zz_result_19 = (_zz_result_18 && (! io_a[45]));
  assign _zz_result_20 = (_zz_result_19 && (! io_a[44]));
  assign _zz_result_21 = (_zz_result_20 && (! io_a[43]));
  assign _zz_result_22 = (_zz_result_21 && (! io_a[42]));
  assign _zz_result_23 = (_zz_result_22 && (! io_a[41]));
  assign _zz_result_24 = (_zz_result_23 && (! io_a[40]));
  assign _zz_result_25 = (_zz_result_24 && (! io_a[39]));
  assign _zz_result_26 = (_zz_result_25 && (! io_a[38]));
  assign _zz_result_27 = (_zz_result_26 && (! io_a[37]));
  assign _zz_result_28 = (_zz_result_27 && (! io_a[36]));
  assign _zz_result_29 = (_zz_result_28 && (! io_a[35]));
  assign _zz_result_30 = (_zz_result_29 && (! io_a[34]));
  assign _zz_result_31 = (_zz_result_30 && (! io_a[33]));
  assign _zz_result_32 = (_zz_result_31 && (! io_a[32]));
  assign _zz_result_33 = (_zz_result_32 && (! io_a[31]));
  assign _zz_result_34 = (_zz_result_33 && (! io_a[30]));
  assign _zz_result_35 = (_zz_result_34 && (! io_a[29]));
  assign _zz_result_36 = (_zz_result_35 && (! io_a[28]));
  assign _zz_result_37 = (_zz_result_36 && (! io_a[27]));
  assign _zz_result_38 = (_zz_result_37 && (! io_a[26]));
  assign _zz_result_39 = (_zz_result_38 && (! io_a[25]));
  assign _zz_result_40 = (_zz_result_39 && (! io_a[24]));
  assign _zz_result_41 = (_zz_result_40 && (! io_a[23]));
  assign _zz_result_42 = (_zz_result_41 && (! io_a[22]));
  assign _zz_result_43 = (_zz_result_42 && (! io_a[21]));
  assign _zz_result_44 = (_zz_result_43 && (! io_a[20]));
  assign _zz_result_45 = (_zz_result_44 && (! io_a[19]));
  assign _zz_result_46 = (_zz_result_45 && (! io_a[18]));
  assign _zz_result_47 = (_zz_result_46 && (! io_a[17]));
  assign _zz_result_48 = (_zz_result_47 && (! io_a[16]));
  assign _zz_result_49 = (_zz_result_48 && (! io_a[15]));
  assign _zz_result_50 = (_zz_result_49 && (! io_a[14]));
  assign _zz_result_51 = (_zz_result_50 && (! io_a[13]));
  assign _zz_result_52 = (_zz_result_51 && (! io_a[12]));
  assign _zz_result_53 = (_zz_result_52 && (! io_a[11]));
  assign _zz_result_54 = (_zz_result_53 && (! io_a[10]));
  assign _zz_result_55 = (_zz_result_54 && (! io_a[9]));
  assign _zz_result_56 = (_zz_result_55 && (! io_a[8]));
  assign _zz_result_57 = (_zz_result_56 && (! io_a[7]));
  assign _zz_result_58 = (_zz_result_57 && (! io_a[6]));
  assign _zz_result_59 = (_zz_result_58 && (! io_a[5]));
  assign _zz_result_60 = (_zz_result_59 && (! io_a[4]));
  assign _zz_result_61 = (_zz_result_60 && (! io_a[3]));
  assign _zz_result_62 = (_zz_result_61 && (! io_a[2]));
  assign _zz_result_63 = 1'b1;
  assign _zz_result_64 = (_zz_result_63 && (! io_a[0]));
  assign _zz_result_65 = (_zz_result_64 && (! io_a[1]));
  assign _zz_result_66 = (_zz_result_65 && (! io_a[2]));
  assign _zz_result_67 = (_zz_result_66 && (! io_a[3]));
  assign _zz_result_68 = (_zz_result_67 && (! io_a[4]));
  assign _zz_result_69 = (_zz_result_68 && (! io_a[5]));
  assign _zz_result_70 = (_zz_result_69 && (! io_a[6]));
  assign _zz_result_71 = (_zz_result_70 && (! io_a[7]));
  assign _zz_result_72 = (_zz_result_71 && (! io_a[8]));
  assign _zz_result_73 = (_zz_result_72 && (! io_a[9]));
  assign _zz_result_74 = (_zz_result_73 && (! io_a[10]));
  assign _zz_result_75 = (_zz_result_74 && (! io_a[11]));
  assign _zz_result_76 = (_zz_result_75 && (! io_a[12]));
  assign _zz_result_77 = (_zz_result_76 && (! io_a[13]));
  assign _zz_result_78 = (_zz_result_77 && (! io_a[14]));
  assign _zz_result_79 = (_zz_result_78 && (! io_a[15]));
  assign _zz_result_80 = (_zz_result_79 && (! io_a[16]));
  assign _zz_result_81 = (_zz_result_80 && (! io_a[17]));
  assign _zz_result_82 = (_zz_result_81 && (! io_a[18]));
  assign _zz_result_83 = (_zz_result_82 && (! io_a[19]));
  assign _zz_result_84 = (_zz_result_83 && (! io_a[20]));
  assign _zz_result_85 = (_zz_result_84 && (! io_a[21]));
  assign _zz_result_86 = (_zz_result_85 && (! io_a[22]));
  assign _zz_result_87 = (_zz_result_86 && (! io_a[23]));
  assign _zz_result_88 = (_zz_result_87 && (! io_a[24]));
  assign _zz_result_89 = (_zz_result_88 && (! io_a[25]));
  assign _zz_result_90 = (_zz_result_89 && (! io_a[26]));
  assign _zz_result_91 = (_zz_result_90 && (! io_a[27]));
  assign _zz_result_92 = (_zz_result_91 && (! io_a[28]));
  assign _zz_result_93 = (_zz_result_92 && (! io_a[29]));
  assign _zz_result_94 = (_zz_result_93 && (! io_a[30]));
  assign _zz_result_95 = (_zz_result_94 && (! io_a[31]));
  assign _zz_result_96 = (_zz_result_95 && (! io_a[32]));
  assign _zz_result_97 = (_zz_result_96 && (! io_a[33]));
  assign _zz_result_98 = (_zz_result_97 && (! io_a[34]));
  assign _zz_result_99 = (_zz_result_98 && (! io_a[35]));
  assign _zz_result_100 = (_zz_result_99 && (! io_a[36]));
  assign _zz_result_101 = (_zz_result_100 && (! io_a[37]));
  assign _zz_result_102 = (_zz_result_101 && (! io_a[38]));
  assign _zz_result_103 = (_zz_result_102 && (! io_a[39]));
  assign _zz_result_104 = (_zz_result_103 && (! io_a[40]));
  assign _zz_result_105 = (_zz_result_104 && (! io_a[41]));
  assign _zz_result_106 = (_zz_result_105 && (! io_a[42]));
  assign _zz_result_107 = (_zz_result_106 && (! io_a[43]));
  assign _zz_result_108 = (_zz_result_107 && (! io_a[44]));
  assign _zz_result_109 = (_zz_result_108 && (! io_a[45]));
  assign _zz_result_110 = (_zz_result_109 && (! io_a[46]));
  assign _zz_result_111 = (_zz_result_110 && (! io_a[47]));
  assign _zz_result_112 = (_zz_result_111 && (! io_a[48]));
  assign _zz_result_113 = (_zz_result_112 && (! io_a[49]));
  assign _zz_result_114 = (_zz_result_113 && (! io_a[50]));
  assign _zz_result_115 = (_zz_result_114 && (! io_a[51]));
  assign _zz_result_116 = (_zz_result_115 && (! io_a[52]));
  assign _zz_result_117 = (_zz_result_116 && (! io_a[53]));
  assign _zz_result_118 = (_zz_result_117 && (! io_a[54]));
  assign _zz_result_119 = (_zz_result_118 && (! io_a[55]));
  assign _zz_result_120 = (_zz_result_119 && (! io_a[56]));
  assign _zz_result_121 = (_zz_result_120 && (! io_a[57]));
  assign _zz_result_122 = (_zz_result_121 && (! io_a[58]));
  assign _zz_result_123 = (_zz_result_122 && (! io_a[59]));
  assign _zz_result_124 = (_zz_result_123 && (! io_a[60]));
  assign _zz_result_125 = (_zz_result_124 && (! io_a[61]));
  assign _zz_result_126 = {1'd0, shamt};
  assign _zz_result_127 = {1'd0, shamt};
  assign _zz_result_128 = io_a[31 : 0];
  assign _zz_result_129 = 1'b1;
  assign _zz_result_130 = (_zz_result_129 && (! _zz_result_128[31]));
  assign _zz_result_131 = (_zz_result_130 && (! _zz_result_128[30]));
  assign _zz_result_132 = (_zz_result_131 && (! _zz_result_128[29]));
  assign _zz_result_133 = (_zz_result_132 && (! _zz_result_128[28]));
  assign _zz_result_134 = (_zz_result_133 && (! _zz_result_128[27]));
  assign _zz_result_135 = (_zz_result_134 && (! _zz_result_128[26]));
  assign _zz_result_136 = (_zz_result_135 && (! _zz_result_128[25]));
  assign _zz_result_137 = (_zz_result_136 && (! _zz_result_128[24]));
  assign _zz_result_138 = (_zz_result_137 && (! _zz_result_128[23]));
  assign _zz_result_139 = (_zz_result_138 && (! _zz_result_128[22]));
  assign _zz_result_140 = (_zz_result_139 && (! _zz_result_128[21]));
  assign _zz_result_141 = (_zz_result_140 && (! _zz_result_128[20]));
  assign _zz_result_142 = (_zz_result_141 && (! _zz_result_128[19]));
  assign _zz_result_143 = (_zz_result_142 && (! _zz_result_128[18]));
  assign _zz_result_144 = (_zz_result_143 && (! _zz_result_128[17]));
  assign _zz_result_145 = (_zz_result_144 && (! _zz_result_128[16]));
  assign _zz_result_146 = (_zz_result_145 && (! _zz_result_128[15]));
  assign _zz_result_147 = (_zz_result_146 && (! _zz_result_128[14]));
  assign _zz_result_148 = (_zz_result_147 && (! _zz_result_128[13]));
  assign _zz_result_149 = (_zz_result_148 && (! _zz_result_128[12]));
  assign _zz_result_150 = (_zz_result_149 && (! _zz_result_128[11]));
  assign _zz_result_151 = (_zz_result_150 && (! _zz_result_128[10]));
  assign _zz_result_152 = (_zz_result_151 && (! _zz_result_128[9]));
  assign _zz_result_153 = (_zz_result_152 && (! _zz_result_128[8]));
  assign _zz_result_154 = (_zz_result_153 && (! _zz_result_128[7]));
  assign _zz_result_155 = (_zz_result_154 && (! _zz_result_128[6]));
  assign _zz_result_156 = (_zz_result_155 && (! _zz_result_128[5]));
  assign _zz_result_157 = (_zz_result_156 && (! _zz_result_128[4]));
  assign _zz_result_158 = (_zz_result_157 && (! _zz_result_128[3]));
  assign _zz_result_159 = (_zz_result_158 && (! _zz_result_128[2]));
  assign _zz_result_160 = io_a[31 : 0];
  assign _zz_result_161 = 1'b1;
  assign _zz_result_162 = (_zz_result_161 && (! _zz_result_160[0]));
  assign _zz_result_163 = (_zz_result_162 && (! _zz_result_160[1]));
  assign _zz_result_164 = (_zz_result_163 && (! _zz_result_160[2]));
  assign _zz_result_165 = (_zz_result_164 && (! _zz_result_160[3]));
  assign _zz_result_166 = (_zz_result_165 && (! _zz_result_160[4]));
  assign _zz_result_167 = (_zz_result_166 && (! _zz_result_160[5]));
  assign _zz_result_168 = (_zz_result_167 && (! _zz_result_160[6]));
  assign _zz_result_169 = (_zz_result_168 && (! _zz_result_160[7]));
  assign _zz_result_170 = (_zz_result_169 && (! _zz_result_160[8]));
  assign _zz_result_171 = (_zz_result_170 && (! _zz_result_160[9]));
  assign _zz_result_172 = (_zz_result_171 && (! _zz_result_160[10]));
  assign _zz_result_173 = (_zz_result_172 && (! _zz_result_160[11]));
  assign _zz_result_174 = (_zz_result_173 && (! _zz_result_160[12]));
  assign _zz_result_175 = (_zz_result_174 && (! _zz_result_160[13]));
  assign _zz_result_176 = (_zz_result_175 && (! _zz_result_160[14]));
  assign _zz_result_177 = (_zz_result_176 && (! _zz_result_160[15]));
  assign _zz_result_178 = (_zz_result_177 && (! _zz_result_160[16]));
  assign _zz_result_179 = (_zz_result_178 && (! _zz_result_160[17]));
  assign _zz_result_180 = (_zz_result_179 && (! _zz_result_160[18]));
  assign _zz_result_181 = (_zz_result_180 && (! _zz_result_160[19]));
  assign _zz_result_182 = (_zz_result_181 && (! _zz_result_160[20]));
  assign _zz_result_183 = (_zz_result_182 && (! _zz_result_160[21]));
  assign _zz_result_184 = (_zz_result_183 && (! _zz_result_160[22]));
  assign _zz_result_185 = (_zz_result_184 && (! _zz_result_160[23]));
  assign _zz_result_186 = (_zz_result_185 && (! _zz_result_160[24]));
  assign _zz_result_187 = (_zz_result_186 && (! _zz_result_160[25]));
  assign _zz_result_188 = (_zz_result_187 && (! _zz_result_160[26]));
  assign _zz_result_189 = (_zz_result_188 && (! _zz_result_160[27]));
  assign _zz_result_190 = (_zz_result_189 && (! _zz_result_160[28]));
  assign _zz_result_191 = (_zz_result_190 && (! _zz_result_160[29]));
  assign _zz_result_192 = io_a[31 : 0];
  assign _zz_result_193 = {1'd0, shamtW};
  assign _zz_result_194 = {1'd0, shamtW};
  assign io_result = result;

endmodule

module CsrFile (
  input  wire          io_timerInterrupt,
  input  wire [11:0]   io_csrAddr,
  input  wire [1:0]    io_csrOp,
  input  wire          io_csrWe,
  input  wire [63:0]   io_csrWrData,
  output wire [63:0]   io_rdData,
  input  wire          io_trapEna,
  input  wire [63:0]   io_trapEpc,
  input  wire [63:0]   io_trapCause,
  input  wire [63:0]   io_trapTval,
  input  wire          io_mretEna,
  input  wire          io_fpDirty,
  input  wire          io_fpFlagsWe,
  input  wire [4:0]    io_fpFlags,
  output wire [1:0]    io_curMode,
  output wire          io_mstatusMie,
  output wire [1:0]    io_mstatusMpp,
  output wire [1:0]    io_mstatusFs,
  output wire [2:0]    io_frm,
  output wire          io_mieMtie,
  output wire [63:0]   io_mtvec,
  output wire [63:0]   io_mepc,
  output wire [63:0]   io_debugMepc,
  output wire [63:0]   io_debugMcause,
  output wire [1:0]    io_debugMode,
  input  wire          clk,
  input  wire          reset
);
  localparam CsrOp_NONE = 2'd0;
  localparam CsrOp_WRITE = 2'd1;
  localparam CsrOp_SET = 2'd2;
  localparam CsrOp_CLEAR = 2'd3;

  wire       [7:0]    _zz_readData;
  wire       [1:0]    MODE_M;
  wire       [1:0]    MODE_U;
  reg        [63:0]   mstatusReg;
  reg        [63:0]   mieReg;
  reg        [63:0]   mtvecReg;
  reg        [63:0]   mscratchReg;
  reg        [63:0]   mepcReg;
  reg        [63:0]   mcauseReg;
  reg        [63:0]   mtvalReg;
  reg        [1:0]    curModeReg;
  reg        [4:0]    fflagsReg;
  reg        [2:0]    frmReg;
  reg        [63:0]   readData;
  wire       [63:0]   mipBits;
  wire                when_CsrFile_l102;
  wire                when_CsrFile_l103;
  wire                when_CsrFile_l104;
  wire                wbActive;
  reg        [63:0]   opNew;
  reg        [63:0]   mstatusPostWb;
  wire                when_CsrFile_l130;
  wire       [63:0]   _zz_mstatusPostWb;
  reg        [63:0]   mstatusNext;
  reg        [1:0]    curModeNext;
  reg        [63:0]   mepcNext;
  reg        [63:0]   _zz_mepcNext;
  wire                when_CsrFile_l168;
  reg        [63:0]   mcauseNext;
  wire                when_CsrFile_l176;
  reg        [63:0]   mtvalNext;
  wire                when_CsrFile_l180;
  reg        [63:0]   mieNext;
  wire                when_CsrFile_l185;
  wire       [63:0]   _zz_mieNext;
  reg        [63:0]   mtvecNext;
  wire                when_CsrFile_l188;
  wire       [63:0]   _zz_mtvecNext;
  reg        [63:0]   mscratchNext;
  wire                when_CsrFile_l197;
  wire       [4:0]    fflagsNext;
  reg        [2:0]    frmNext;
  wire                when_CsrFile_l204;
  wire                when_CsrFile_l205;
  wire       [4:0]    _zz_fflagsNext;
  `ifndef SYNTHESIS
  reg [39:0] io_csrOp_string;
  `endif


  assign _zz_readData = {frmReg,fflagsReg};
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_csrOp)
      CsrOp_NONE : io_csrOp_string = "NONE ";
      CsrOp_WRITE : io_csrOp_string = "WRITE";
      CsrOp_SET : io_csrOp_string = "SET  ";
      CsrOp_CLEAR : io_csrOp_string = "CLEAR";
      default : io_csrOp_string = "?????";
    endcase
  end
  `endif

  assign MODE_M = 2'b11;
  assign MODE_U = 2'b00;
  assign mipBits = {{56'h0,io_timerInterrupt},7'h0};
  always @(*) begin
    case(io_csrAddr)
      12'h300 : begin
        readData = mstatusReg;
      end
      12'h301 : begin
        readData = 64'h8000000000100120;
      end
      12'h304 : begin
        readData = mieReg;
      end
      12'h305 : begin
        readData = mtvecReg;
      end
      12'h340 : begin
        readData = mscratchReg;
      end
      12'h341 : begin
        readData = mepcReg;
      end
      12'h342 : begin
        readData = mcauseReg;
      end
      12'h343 : begin
        readData = mtvalReg;
      end
      12'h344 : begin
        readData = mipBits;
      end
      12'hf14 : begin
        readData = 64'h0;
      end
      default : begin
        readData = 64'h0;
      end
    endcase
    if(when_CsrFile_l102) begin
      readData = {59'd0, fflagsReg};
    end
    if(when_CsrFile_l103) begin
      readData = {61'd0, frmReg};
    end
    if(when_CsrFile_l104) begin
      readData = {56'd0, _zz_readData};
    end
  end

  assign when_CsrFile_l102 = (io_csrAddr == 12'h001);
  assign when_CsrFile_l103 = (io_csrAddr == 12'h002);
  assign when_CsrFile_l104 = (io_csrAddr == 12'h003);
  assign io_rdData = readData;
  assign wbActive = (io_csrWe && (io_csrOp != CsrOp_NONE));
  always @(*) begin
    case(io_csrOp)
      CsrOp_WRITE : begin
        opNew = io_csrWrData;
      end
      CsrOp_SET : begin
        opNew = (readData | io_csrWrData);
      end
      CsrOp_CLEAR : begin
        opNew = (readData & (~ io_csrWrData));
      end
      default : begin
        opNew = io_csrWrData;
      end
    endcase
  end

  assign when_CsrFile_l130 = (wbActive && (io_csrAddr == 12'h300));
  assign _zz_mstatusPostWb = 64'h0000000000007888;
  always @(*) begin
    if(when_CsrFile_l130) begin
      mstatusPostWb = ((mstatusReg & (~ _zz_mstatusPostWb)) | (opNew & _zz_mstatusPostWb));
    end else begin
      mstatusPostWb = mstatusReg;
    end
  end

  always @(*) begin
    if(io_trapEna) begin
      mstatusNext = mstatusPostWb;
      mstatusNext[7] = mstatusPostWb[3];
      mstatusNext[3] = 1'b0;
      mstatusNext[12 : 11] = curModeReg;
    end else begin
      if(io_mretEna) begin
        mstatusNext = mstatusPostWb;
        mstatusNext[3] = mstatusPostWb[7];
        mstatusNext[7] = 1'b1;
        mstatusNext[12 : 11] = MODE_M;
      end else begin
        mstatusNext = mstatusPostWb;
      end
    end
    if(io_fpDirty) begin
      mstatusNext[14 : 13] = 2'b11;
    end
  end

  always @(*) begin
    if(io_trapEna) begin
      curModeNext = MODE_M;
    end else begin
      if(io_mretEna) begin
        curModeNext = mstatusPostWb[12 : 11];
      end else begin
        curModeNext = curModeReg;
      end
    end
  end

  assign when_CsrFile_l168 = (wbActive && (io_csrAddr == 12'h341));
  always @(*) begin
    if(when_CsrFile_l168) begin
      _zz_mepcNext = opNew;
    end else begin
      _zz_mepcNext = mepcReg;
    end
  end

  always @(*) begin
    mepcNext = _zz_mepcNext;
    if(io_trapEna) begin
      mepcNext = io_trapEpc;
    end
  end

  assign when_CsrFile_l176 = (wbActive && (io_csrAddr == 12'h342));
  always @(*) begin
    if(when_CsrFile_l176) begin
      mcauseNext = opNew;
    end else begin
      mcauseNext = mcauseReg;
    end
    if(io_trapEna) begin
      mcauseNext = io_trapCause;
    end
  end

  assign when_CsrFile_l180 = (wbActive && (io_csrAddr == 12'h343));
  always @(*) begin
    if(when_CsrFile_l180) begin
      mtvalNext = opNew;
    end else begin
      mtvalNext = mtvalReg;
    end
    if(io_trapEna) begin
      mtvalNext = io_trapTval;
    end
  end

  assign when_CsrFile_l185 = (wbActive && (io_csrAddr == 12'h304));
  assign _zz_mieNext = 64'h0000000000000080;
  always @(*) begin
    if(when_CsrFile_l185) begin
      mieNext = ((mieReg & (~ _zz_mieNext)) | (opNew & _zz_mieNext));
    end else begin
      mieNext = mieReg;
    end
  end

  assign when_CsrFile_l188 = (wbActive && (io_csrAddr == 12'h305));
  assign _zz_mtvecNext = 64'hfffffffffffffffc;
  always @(*) begin
    if(when_CsrFile_l188) begin
      mtvecNext = ((mtvecReg & (~ _zz_mtvecNext)) | (opNew & _zz_mtvecNext));
    end else begin
      mtvecNext = mtvecReg;
    end
  end

  assign when_CsrFile_l197 = (wbActive && (io_csrAddr == 12'h340));
  always @(*) begin
    if(when_CsrFile_l197) begin
      mscratchNext = opNew;
    end else begin
      mscratchNext = mscratchReg;
    end
  end

  always @(*) begin
    frmNext = frmReg;
    if(when_CsrFile_l204) begin
      frmNext = opNew[7 : 5];
    end
    if(when_CsrFile_l205) begin
      frmNext = opNew[7 : 5];
    end
  end

  assign when_CsrFile_l204 = (wbActive && (io_csrAddr == 12'h002));
  assign when_CsrFile_l205 = (wbActive && (io_csrAddr == 12'h003));
  assign _zz_fflagsNext = (((wbActive && (io_csrAddr == 12'h003)) || (wbActive && (io_csrAddr == 12'h001))) ? opNew[4 : 0] : fflagsReg);
  assign fflagsNext = (io_fpFlagsWe ? (_zz_fflagsNext | io_fpFlags) : _zz_fflagsNext);
  assign io_curMode = curModeReg;
  assign io_mstatusMie = mstatusReg[3];
  assign io_mstatusMpp = mstatusReg[12 : 11];
  assign io_mstatusFs = mstatusReg[14 : 13];
  assign io_frm = frmReg;
  assign io_mieMtie = mieReg[7];
  assign io_mtvec = mtvecReg;
  assign io_mepc = mepcReg;
  assign io_debugMepc = mepcReg;
  assign io_debugMcause = mcauseReg;
  assign io_debugMode = curModeReg;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      mstatusReg <= 64'h0;
      mieReg <= 64'h0;
      mtvecReg <= 64'h0;
      mscratchReg <= 64'h0;
      mepcReg <= 64'h0;
      mcauseReg <= 64'h0;
      mtvalReg <= 64'h0;
      curModeReg <= MODE_M;
      fflagsReg <= 5'h0;
      frmReg <= 3'b000;
    end else begin
      mstatusReg <= mstatusNext;
      mieReg <= mieNext;
      mtvecReg <= mtvecNext;
      mscratchReg <= mscratchNext;
      mepcReg <= mepcNext;
      mcauseReg <= mcauseNext;
      mtvalReg <= mtvalNext;
      curModeReg <= curModeNext;
      fflagsReg <= fflagsNext;
      frmReg <= frmNext;
    end
  end


endmodule

module FpUnit (
  input  wire [5:0]    io_op,
  input  wire [2:0]    io_rm,
  input  wire [63:0]   io_a,
  input  wire [63:0]   io_b,
  input  wire [63:0]   io_c,
  output wire [63:0]   io_result,
  output wire [4:0]    io_flags
);

  wire       [9:0]    _zz__zz_when_FpUnit_l218;
  wire       [9:0]    _zz__zz_when_FpUnit_l218_1;
  wire       [9:0]    _zz__zz_when_FpUnit_l218_2;
  wire       [7:0]    _zz__zz_when_FpUnit_l218_3;
  wire       [23:0]   _zz__zz_when_FpUnit_l88;
  wire       [9:0]    _zz__zz_when_FpUnit_l218_1_1;
  wire       [9:0]    _zz__zz_when_FpUnit_l218_1_2;
  wire       [9:0]    _zz__zz_when_FpUnit_l218_1_3;
  wire       [7:0]    _zz__zz_when_FpUnit_l218_1_4;
  wire       [23:0]   _zz__zz_when_FpUnit_l88_1;
  wire       [9:0]    _zz__zz_when_FpUnit_l367_1;
  wire       [9:0]    _zz__zz_when_FpUnit_l367_1_1;
  wire       [9:0]    _zz__zz_when_FpUnit_l367_1_2;
  wire       [7:0]    _zz__zz_when_FpUnit_l367_1_3;
  wire       [23:0]   _zz__zz_when_FpUnit_l88_2;
  wire       [31:0]   _zz_res_86;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_5;
  wire       [27:0]   _zz__zz_when_FpUnit_l88_5_1;
  wire       [23:0]   _zz__zz_when_FpUnit_l88_5_2;
  wire       [9:0]    _zz__zz_when_FpUnit_l218_4;
  wire       [9:0]    _zz__zz_when_FpUnit_l218_4_1;
  wire       [27:0]   _zz__zz_when_FpUnit_l88_6;
  wire       [27:0]   _zz__zz_when_FpUnit_l88_6_1;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_6_2;
  wire       [27:0]   _zz__zz_when_FpUnit_l88_6_3;
  wire       [23:0]   _zz__zz_when_FpUnit_l88_6_4;
  wire       [27:0]   _zz__zz_when_FpUnit_l88_10;
  wire       [27:0]   _zz__zz_when_FpUnit_l88_10_1;
  wire       [27:0]   _zz__zz_when_FpUnit_l88_10_2;
  wire       [11:0]   _zz__zz_flagUF_2;
  wire       [11:0]   _zz__zz_flagUF_2_1;
  wire       [11:0]   _zz__zz_flagUF_2_2;
  wire       [11:0]   _zz__zz_flagUF_2_3;
  wire       [26:0]   _zz__zz_flagUF;
  wire       [27:0]   _zz__zz_flagUF_1;
  wire       [27:0]   _zz__zz_flagUF_1_1;
  wire       [27:0]   _zz__zz_flagUF_1_2;
  wire       [58:0]   _zz__zz_flagUF_1_3;
  wire       [26:0]   _zz__zz_flagUF_3;
  wire       [58:0]   _zz__zz_flagUF_4;
  wire       [4:0]    _zz__zz_flagUF_5;
  wire       [28:0]   _zz__zz_flagUF_4_1;
  wire       [11:0]   _zz__zz_flagUF_7;
  wire       [11:0]   _zz__zz_when_FpUnit_l147;
  wire       [26:0]   _zz__zz_flagUF_8;
  wire       [26:0]   _zz__zz_flagUF_8_1;
  wire       [28:0]   _zz__zz_flagUF_8_2;
  wire       [4:0]    _zz__zz_flagUF_8_3;
  wire       [28:0]   _zz__zz_flagUF_9;
  wire       [28:0]   _zz__zz_flagUF_9_1;
  wire       [59:0]   _zz__zz_flagUF_9_2;
  wire       [4:0]    _zz__zz_flagUF_9_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_1;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_1_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_1_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l190_1_3;
  wire                _zz__zz_when_FpUnit_l190_1_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l190_1_5;
  wire                _zz__zz_when_FpUnit_l190_1_6;
  wire                _zz__zz_when_FpUnit_l190_1_7;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_2;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_2_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_2;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_2_1;
  wire       [7:0]    _zz__zz_res_4;
  wire       [11:0]   _zz__zz_res_4_1;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_13;
  wire       [27:0]   _zz__zz_when_FpUnit_l88_13_1;
  wire       [23:0]   _zz__zz_when_FpUnit_l88_13_2;
  wire       [9:0]    _zz__zz_when_FpUnit_l218_7;
  wire       [9:0]    _zz__zz_when_FpUnit_l218_7_1;
  wire       [27:0]   _zz__zz_when_FpUnit_l88_14;
  wire       [27:0]   _zz__zz_when_FpUnit_l88_14_1;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_14_2;
  wire       [27:0]   _zz__zz_when_FpUnit_l88_14_3;
  wire       [23:0]   _zz__zz_when_FpUnit_l88_14_4;
  wire       [27:0]   _zz__zz_when_FpUnit_l88_18;
  wire       [27:0]   _zz__zz_when_FpUnit_l88_18_1;
  wire       [27:0]   _zz__zz_when_FpUnit_l88_18_2;
  wire       [11:0]   _zz__zz_flagUF_16;
  wire       [11:0]   _zz__zz_flagUF_16_1;
  wire       [11:0]   _zz__zz_flagUF_16_2;
  wire       [11:0]   _zz__zz_flagUF_16_3;
  wire       [26:0]   _zz__zz_flagUF_14;
  wire       [27:0]   _zz__zz_flagUF_14_1;
  wire       [27:0]   _zz__zz_flagUF_15;
  wire       [27:0]   _zz__zz_flagUF_15_1;
  wire       [58:0]   _zz__zz_flagUF_15_2;
  wire       [26:0]   _zz__zz_flagUF_14_2;
  wire       [58:0]   _zz__zz_flagUF_14_3;
  wire       [4:0]    _zz__zz_flagUF_14_4;
  wire       [28:0]   _zz__zz_flagUF_18;
  wire       [11:0]   _zz__zz_flagUF_21;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_1;
  wire       [26:0]   _zz__zz_flagUF_22;
  wire       [26:0]   _zz__zz_flagUF_22_1;
  wire       [28:0]   _zz__zz_flagUF_22_2;
  wire       [4:0]    _zz__zz_flagUF_22_3;
  wire       [28:0]   _zz__zz_flagUF_23;
  wire       [28:0]   _zz__zz_flagUF_23_1;
  wire       [59:0]   _zz__zz_flagUF_23_2;
  wire       [4:0]    _zz__zz_flagUF_23_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_4;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_4_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_4_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l190_4_3;
  wire                _zz__zz_when_FpUnit_l190_4_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l190_4_5;
  wire                _zz__zz_when_FpUnit_l190_4_6;
  wire                _zz__zz_when_FpUnit_l190_4_7;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_5;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_5_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_5;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_5_1;
  wire       [7:0]    _zz__zz_res_9;
  wire       [11:0]   _zz__zz_res_9_1;
  wire       [11:0]   _zz__zz_flagUF_30;
  wire       [11:0]   _zz__zz_flagUF_30_1;
  wire       [11:0]   _zz__zz_flagUF_30_2;
  wire       [11:0]   _zz__zz_flagUF_30_3;
  wire       [9:0]    _zz__zz_flagUF_30_4;
  wire       [26:0]   _zz__zz_flagUF_28;
  wire       [47:0]   _zz__zz_flagUF_28_1;
  wire       [47:0]   _zz__zz_flagUF_29;
  wire       [47:0]   _zz__zz_flagUF_29_1;
  wire       [110:0]  _zz__zz_flagUF_29_2;
  wire       [26:0]   _zz__zz_flagUF_28_2;
  wire       [110:0]  _zz__zz_flagUF_28_3;
  wire       [5:0]    _zz__zz_flagUF_28_4;
  wire       [28:0]   _zz__zz_flagUF_32;
  wire       [11:0]   _zz__zz_flagUF_35;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_2;
  wire       [26:0]   _zz__zz_flagUF_36;
  wire       [26:0]   _zz__zz_flagUF_36_1;
  wire       [28:0]   _zz__zz_flagUF_36_2;
  wire       [4:0]    _zz__zz_flagUF_36_3;
  wire       [28:0]   _zz__zz_flagUF_37;
  wire       [28:0]   _zz__zz_flagUF_37_1;
  wire       [59:0]   _zz__zz_flagUF_37_2;
  wire       [4:0]    _zz__zz_flagUF_37_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_7;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_7_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_7_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l190_7_3;
  wire                _zz__zz_when_FpUnit_l190_7_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l190_7_5;
  wire                _zz__zz_when_FpUnit_l190_7_6;
  wire                _zz__zz_when_FpUnit_l190_7_7;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_8;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_8_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_8;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_8_1;
  wire       [7:0]    _zz__zz_res_14;
  wire       [11:0]   _zz__zz_res_14_1;
  wire       [52:0]   _zz__zz_when_FpUnit_l88_20;
  wire       [79:0]   _zz__zz_when_FpUnit_l88_21;
  wire       [52:0]   _zz__zz_when_FpUnit_l88_21_1;
  wire       [11:0]   _zz__zz_flagUF_44;
  wire       [11:0]   _zz__zz_flagUF_44_1;
  wire       [11:0]   _zz__zz_flagUF_44_2;
  wire       [11:0]   _zz__zz_flagUF_44_3;
  wire       [9:0]    _zz__zz_flagUF_44_4;
  wire       [26:0]   _zz__zz_flagUF_42;
  wire       [28:0]   _zz__zz_flagUF_42_1;
  wire       [28:0]   _zz__zz_flagUF_43;
  wire       [28:0]   _zz__zz_flagUF_43_1;
  wire       [59:0]   _zz__zz_flagUF_43_2;
  wire       [26:0]   _zz__zz_flagUF_42_2;
  wire       [59:0]   _zz__zz_flagUF_42_3;
  wire       [4:0]    _zz__zz_flagUF_42_4;
  wire       [28:0]   _zz__zz_flagUF_46;
  wire       [105:0]  _zz__zz_flagUF_48;
  wire       [105:0]  _zz__zz_flagUF_48_1;
  wire       [105:0]  _zz__zz_flagUF_48_2;
  wire       [52:0]   _zz__zz_flagUF_48_3;
  wire       [52:0]   _zz__zz_flagUF_48_4;
  wire       [11:0]   _zz__zz_flagUF_49;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_3;
  wire       [26:0]   _zz__zz_flagUF_50;
  wire       [26:0]   _zz__zz_flagUF_50_1;
  wire       [28:0]   _zz__zz_flagUF_50_2;
  wire       [4:0]    _zz__zz_flagUF_50_3;
  wire       [28:0]   _zz__zz_flagUF_51;
  wire       [28:0]   _zz__zz_flagUF_51_1;
  wire       [59:0]   _zz__zz_flagUF_51_2;
  wire       [4:0]    _zz__zz_flagUF_51_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_10;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_10_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_10_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l190_10_3;
  wire                _zz__zz_when_FpUnit_l190_10_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l190_10_5;
  wire                _zz__zz_when_FpUnit_l190_10_6;
  wire                _zz__zz_when_FpUnit_l190_10_7;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_11;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_11_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_11;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_11_1;
  wire       [7:0]    _zz__zz_res_19;
  wire       [11:0]   _zz__zz_res_19_1;
  wire       [84:0]   _zz__zz_when_FpUnit_l88_22;
  wire       [55:0]   _zz__zz_when_FpUnit_l88_22_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l88_22_2;
  wire       [24:0]   _zz__zz_when_FpUnit_l88_22_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l88_22_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_24;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_24_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_24_2;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_24_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_25;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_25_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_27;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_27_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_27_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_27_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_28;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_28_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_28_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_28_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_28_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_29;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_29_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_31;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_31_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_31_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_31_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_32;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_32_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_32_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_32_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_32_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_33;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_33_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_35;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_35_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_35_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_35_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_36;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_36_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_36_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_36_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_36_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_37;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_37_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_39;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_39_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_39_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_39_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_40;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_40_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_40_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_40_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_40_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_41;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_41_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_43;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_43_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_43_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_43_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_44;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_44_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_44_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_44_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_44_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_45;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_45_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_47;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_47_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_47_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_47_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_48;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_48_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_48_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_48_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_48_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_49;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_49_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_51;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_51_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_51_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_51_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_52;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_52_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_52_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_52_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_52_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_53;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_53_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_55;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_55_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_55_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_55_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_56;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_56_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_56_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_56_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_56_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_57;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_57_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_59;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_59_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_59_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_59_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_60;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_60_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_60_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_60_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_60_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_61;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_61_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_63;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_63_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_63_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_63_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_64;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_64_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_64_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_64_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_64_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_65;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_65_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_67;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_67_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_67_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_67_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_68;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_68_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_68_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_68_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_68_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_69;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_69_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_71;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_71_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_71_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_71_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_72;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_72_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_72_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_72_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_72_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_73;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_73_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_75;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_75_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_75_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_75_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_76;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_76_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_76_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_76_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_76_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_77;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_77_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_79;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_79_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_79_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_79_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_80;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_80_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_80_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_80_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_80_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_81;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_81_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_83;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_83_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_83_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_83_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_84;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_84_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_84_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_84_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_84_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_85;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_85_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_87;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_87_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_87_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_87_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_88;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_88_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_88_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_88_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_88_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_89;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_89_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_91;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_91_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_91_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_91_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_92;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_92_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_92_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_92_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_92_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_93;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_93_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_95;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_95_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_95_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_95_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_96;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_96_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_96_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_96_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_96_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_97;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_97_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_99;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_99_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_99_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_99_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_100;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_100_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_100_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_100_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_100_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_101;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_101_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_103;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_103_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_103_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_103_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_104;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_104_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_104_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_104_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_104_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_105;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_105_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_107;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_107_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_107_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_107_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_108;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_108_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_108_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_108_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_108_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_109;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_109_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_111;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_111_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_111_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_111_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_112;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_112_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_112_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_112_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_112_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_113;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_113_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_115;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_115_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_115_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_115_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_116;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_116_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_116_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_116_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_116_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_117;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_117_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_119;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_119_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_119_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_119_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_120;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_120_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_120_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_120_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_120_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_121;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_121_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_123;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_123_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_123_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_123_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_124;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_124_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_124_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_124_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_124_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_125;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_125_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_127;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_127_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_127_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_127_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_128;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_128_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_128_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_128_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_128_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_129;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_129_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_131;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_131_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_131_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_131_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_132;
  wire       [59:0]   _zz__zz_when_FpUnit_l88_132_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_132_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_132_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l88_132_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l88_133;
  wire       [31:0]   _zz__zz_when_FpUnit_l88_133_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_135;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_135_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l88_135_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l88_135_3;
  wire       [11:0]   _zz__zz_flagUF_59;
  wire       [11:0]   _zz__zz_flagUF_59_1;
  wire       [11:0]   _zz__zz_flagUF_59_2;
  wire       [11:0]   _zz__zz_flagUF_59_3;
  wire       [10:0]   _zz__zz_flagUF_59_4;
  wire       [11:0]   _zz__zz_flagUF_59_5;
  wire       [11:0]   _zz__zz_flagUF_59_6;
  wire       [11:0]   _zz__zz_flagUF_59_7;
  wire       [11:0]   _zz__zz_flagUF_59_8;
  wire       [26:0]   _zz__zz_flagUF_57;
  wire       [29:0]   _zz__zz_flagUF_57_1;
  wire       [29:0]   _zz__zz_flagUF_58;
  wire       [29:0]   _zz__zz_flagUF_58_1;
  wire       [60:0]   _zz__zz_flagUF_58_2;
  wire       [26:0]   _zz__zz_flagUF_57_2;
  wire       [60:0]   _zz__zz_flagUF_57_3;
  wire       [4:0]    _zz__zz_flagUF_57_4;
  wire       [28:0]   _zz__zz_flagUF_61;
  wire       [57:0]   _zz__zz_flagUF_63;
  wire       [11:0]   _zz__zz_flagUF_64;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_4;
  wire       [26:0]   _zz__zz_flagUF_65;
  wire       [26:0]   _zz__zz_flagUF_65_1;
  wire       [28:0]   _zz__zz_flagUF_65_2;
  wire       [4:0]    _zz__zz_flagUF_65_3;
  wire       [28:0]   _zz__zz_flagUF_66;
  wire       [28:0]   _zz__zz_flagUF_66_1;
  wire       [59:0]   _zz__zz_flagUF_66_2;
  wire       [4:0]    _zz__zz_flagUF_66_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_13;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_13_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_13_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l190_13_3;
  wire                _zz__zz_when_FpUnit_l190_13_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l190_13_5;
  wire                _zz__zz_when_FpUnit_l190_13_6;
  wire                _zz__zz_when_FpUnit_l190_13_7;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_14;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_14_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_14;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_14_1;
  wire       [7:0]    _zz__zz_res_24;
  wire       [11:0]   _zz__zz_res_24_1;
  wire       [31:0]   _zz_res_87;
  wire       [11:0]   _zz__zz_when_FpUnit_l367_2;
  wire       [9:0]    _zz__zz_when_FpUnit_l367_2_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l367_3;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_137;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_137_1;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_137_2;
  wire       [53:0]   _zz__zz_flagUF_71;
  wire       [53:0]   _zz__zz_flagUF_71_1;
  wire       [53:0]   _zz__zz_flagUF_71_2;
  wire       [116:0]  _zz__zz_flagUF_71_3;
  wire       [5:0]    _zz__zz_flagUF_71_4;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_138;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_138_1;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_138_2;
  wire       [53:0]   _zz__zz_flagUF_72;
  wire       [53:0]   _zz__zz_flagUF_72_1;
  wire       [53:0]   _zz__zz_flagUF_72_2;
  wire       [116:0]  _zz__zz_flagUF_72_3;
  wire       [5:0]    _zz__zz_flagUF_72_4;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_139;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_139_1;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_140;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_140_1;
  wire       [55:0]   _zz__zz_when_FpUnit_l88_141;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_141_1;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_141_2;
  wire       [55:0]   _zz__zz_when_FpUnit_l88_141_3;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_141_4;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_141_5;
  wire       [55:0]   _zz__zz_when_FpUnit_l88_143;
  wire       [11:0]   _zz__zz_flagUF_75;
  wire       [11:0]   _zz__zz_flagUF_75_1;
  wire       [26:0]   _zz__zz_flagUF_73;
  wire       [55:0]   _zz__zz_flagUF_73_1;
  wire       [55:0]   _zz__zz_flagUF_74;
  wire       [55:0]   _zz__zz_flagUF_74_1;
  wire       [118:0]  _zz__zz_flagUF_74_2;
  wire       [26:0]   _zz__zz_flagUF_73_2;
  wire       [118:0]  _zz__zz_flagUF_73_3;
  wire       [5:0]    _zz__zz_flagUF_73_4;
  wire       [28:0]   _zz__zz_flagUF_77;
  wire       [11:0]   _zz__zz_flagUF_80;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_5;
  wire       [26:0]   _zz__zz_flagUF_81;
  wire       [26:0]   _zz__zz_flagUF_81_1;
  wire       [28:0]   _zz__zz_flagUF_81_2;
  wire       [4:0]    _zz__zz_flagUF_81_3;
  wire       [28:0]   _zz__zz_flagUF_82;
  wire       [28:0]   _zz__zz_flagUF_82_1;
  wire       [59:0]   _zz__zz_flagUF_82_2;
  wire       [4:0]    _zz__zz_flagUF_82_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_16;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_16_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_16_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l190_16_3;
  wire                _zz__zz_when_FpUnit_l190_16_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l190_16_5;
  wire                _zz__zz_when_FpUnit_l190_16_6;
  wire                _zz__zz_when_FpUnit_l190_16_7;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_17;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_17_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_17;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_17_1;
  wire       [7:0]    _zz__zz_res_39;
  wire       [11:0]   _zz__zz_res_39_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l367_7;
  wire       [9:0]    _zz__zz_when_FpUnit_l367_7_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l367_8;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_145;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_145_1;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_145_2;
  wire       [53:0]   _zz__zz_flagUF_87;
  wire       [53:0]   _zz__zz_flagUF_87_1;
  wire       [53:0]   _zz__zz_flagUF_87_2;
  wire       [116:0]  _zz__zz_flagUF_87_3;
  wire       [5:0]    _zz__zz_flagUF_87_4;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_146;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_146_1;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_146_2;
  wire       [53:0]   _zz__zz_flagUF_88;
  wire       [53:0]   _zz__zz_flagUF_88_1;
  wire       [53:0]   _zz__zz_flagUF_88_2;
  wire       [116:0]  _zz__zz_flagUF_88_3;
  wire       [5:0]    _zz__zz_flagUF_88_4;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_147;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_147_1;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_148;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_148_1;
  wire       [55:0]   _zz__zz_when_FpUnit_l88_149;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_149_1;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_149_2;
  wire       [55:0]   _zz__zz_when_FpUnit_l88_149_3;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_149_4;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_149_5;
  wire       [55:0]   _zz__zz_when_FpUnit_l88_151;
  wire       [11:0]   _zz__zz_flagUF_91;
  wire       [11:0]   _zz__zz_flagUF_91_1;
  wire       [26:0]   _zz__zz_flagUF_89;
  wire       [55:0]   _zz__zz_flagUF_89_1;
  wire       [55:0]   _zz__zz_flagUF_90;
  wire       [55:0]   _zz__zz_flagUF_90_1;
  wire       [118:0]  _zz__zz_flagUF_90_2;
  wire       [26:0]   _zz__zz_flagUF_89_2;
  wire       [118:0]  _zz__zz_flagUF_89_3;
  wire       [5:0]    _zz__zz_flagUF_89_4;
  wire       [28:0]   _zz__zz_flagUF_93;
  wire       [11:0]   _zz__zz_flagUF_96;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_6;
  wire       [26:0]   _zz__zz_flagUF_97;
  wire       [26:0]   _zz__zz_flagUF_97_1;
  wire       [28:0]   _zz__zz_flagUF_97_2;
  wire       [4:0]    _zz__zz_flagUF_97_3;
  wire       [28:0]   _zz__zz_flagUF_98;
  wire       [28:0]   _zz__zz_flagUF_98_1;
  wire       [59:0]   _zz__zz_flagUF_98_2;
  wire       [4:0]    _zz__zz_flagUF_98_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_19;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_19_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_19_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l190_19_3;
  wire                _zz__zz_when_FpUnit_l190_19_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l190_19_5;
  wire                _zz__zz_when_FpUnit_l190_19_6;
  wire                _zz__zz_when_FpUnit_l190_19_7;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_20;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_20_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_20;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_20_1;
  wire       [7:0]    _zz__zz_res_43;
  wire       [11:0]   _zz__zz_res_43_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l367_12;
  wire       [9:0]    _zz__zz_when_FpUnit_l367_12_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l367_13;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_153;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_153_1;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_153_2;
  wire       [53:0]   _zz__zz_flagUF_103;
  wire       [53:0]   _zz__zz_flagUF_103_1;
  wire       [53:0]   _zz__zz_flagUF_103_2;
  wire       [116:0]  _zz__zz_flagUF_103_3;
  wire       [5:0]    _zz__zz_flagUF_103_4;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_154;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_154_1;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_154_2;
  wire       [53:0]   _zz__zz_flagUF_104;
  wire       [53:0]   _zz__zz_flagUF_104_1;
  wire       [53:0]   _zz__zz_flagUF_104_2;
  wire       [116:0]  _zz__zz_flagUF_104_3;
  wire       [5:0]    _zz__zz_flagUF_104_4;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_155;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_155_1;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_156;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_156_1;
  wire       [55:0]   _zz__zz_when_FpUnit_l88_157;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_157_1;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_157_2;
  wire       [55:0]   _zz__zz_when_FpUnit_l88_157_3;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_157_4;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_157_5;
  wire       [55:0]   _zz__zz_when_FpUnit_l88_159;
  wire       [11:0]   _zz__zz_flagUF_107;
  wire       [11:0]   _zz__zz_flagUF_107_1;
  wire       [26:0]   _zz__zz_flagUF_105;
  wire       [55:0]   _zz__zz_flagUF_105_1;
  wire       [55:0]   _zz__zz_flagUF_106;
  wire       [55:0]   _zz__zz_flagUF_106_1;
  wire       [118:0]  _zz__zz_flagUF_106_2;
  wire       [26:0]   _zz__zz_flagUF_105_2;
  wire       [118:0]  _zz__zz_flagUF_105_3;
  wire       [5:0]    _zz__zz_flagUF_105_4;
  wire       [28:0]   _zz__zz_flagUF_109;
  wire       [11:0]   _zz__zz_flagUF_112;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_7;
  wire       [26:0]   _zz__zz_flagUF_113;
  wire       [26:0]   _zz__zz_flagUF_113_1;
  wire       [28:0]   _zz__zz_flagUF_113_2;
  wire       [4:0]    _zz__zz_flagUF_113_3;
  wire       [28:0]   _zz__zz_flagUF_114;
  wire       [28:0]   _zz__zz_flagUF_114_1;
  wire       [59:0]   _zz__zz_flagUF_114_2;
  wire       [4:0]    _zz__zz_flagUF_114_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_22;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_22_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_22_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l190_22_3;
  wire                _zz__zz_when_FpUnit_l190_22_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l190_22_5;
  wire                _zz__zz_when_FpUnit_l190_22_6;
  wire                _zz__zz_when_FpUnit_l190_22_7;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_23;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_23_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_23;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_23_1;
  wire       [7:0]    _zz__zz_res_47;
  wire       [11:0]   _zz__zz_res_47_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l367_17;
  wire       [9:0]    _zz__zz_when_FpUnit_l367_17_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l367_18;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_161;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_161_1;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_161_2;
  wire       [53:0]   _zz__zz_flagUF_119;
  wire       [53:0]   _zz__zz_flagUF_119_1;
  wire       [53:0]   _zz__zz_flagUF_119_2;
  wire       [116:0]  _zz__zz_flagUF_119_3;
  wire       [5:0]    _zz__zz_flagUF_119_4;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_162;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_162_1;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_162_2;
  wire       [53:0]   _zz__zz_flagUF_120;
  wire       [53:0]   _zz__zz_flagUF_120_1;
  wire       [53:0]   _zz__zz_flagUF_120_2;
  wire       [116:0]  _zz__zz_flagUF_120_3;
  wire       [5:0]    _zz__zz_flagUF_120_4;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_163;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_163_1;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_164;
  wire       [53:0]   _zz__zz_when_FpUnit_l88_164_1;
  wire       [55:0]   _zz__zz_when_FpUnit_l88_165;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_165_1;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_165_2;
  wire       [55:0]   _zz__zz_when_FpUnit_l88_165_3;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_165_4;
  wire       [54:0]   _zz__zz_when_FpUnit_l88_165_5;
  wire       [55:0]   _zz__zz_when_FpUnit_l88_167;
  wire       [11:0]   _zz__zz_flagUF_123;
  wire       [11:0]   _zz__zz_flagUF_123_1;
  wire       [26:0]   _zz__zz_flagUF_121;
  wire       [55:0]   _zz__zz_flagUF_121_1;
  wire       [55:0]   _zz__zz_flagUF_122;
  wire       [55:0]   _zz__zz_flagUF_122_1;
  wire       [118:0]  _zz__zz_flagUF_122_2;
  wire       [26:0]   _zz__zz_flagUF_121_2;
  wire       [118:0]  _zz__zz_flagUF_121_3;
  wire       [5:0]    _zz__zz_flagUF_121_4;
  wire       [28:0]   _zz__zz_flagUF_125;
  wire       [11:0]   _zz__zz_flagUF_128;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_8;
  wire       [26:0]   _zz__zz_flagUF_129;
  wire       [26:0]   _zz__zz_flagUF_129_1;
  wire       [28:0]   _zz__zz_flagUF_129_2;
  wire       [4:0]    _zz__zz_flagUF_129_3;
  wire       [28:0]   _zz__zz_flagUF_130;
  wire       [28:0]   _zz__zz_flagUF_130_1;
  wire       [59:0]   _zz__zz_flagUF_130_2;
  wire       [4:0]    _zz__zz_flagUF_130_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_25;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_25_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_25_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l190_25_3;
  wire                _zz__zz_when_FpUnit_l190_25_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l190_25_5;
  wire                _zz__zz_when_FpUnit_l190_25_6;
  wire                _zz__zz_when_FpUnit_l190_25_7;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_26;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_26_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_26;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_26_1;
  wire       [7:0]    _zz__zz_res_51;
  wire       [11:0]   _zz__zz_res_51_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l485;
  wire       [11:0]   _zz__zz_flagNX_1;
  wire       [23:0]   _zz__zz_when_FpUnit_l512;
  wire       [23:0]   _zz__zz_flagNX;
  wire       [23:0]   _zz__zz_flagNX_2;
  wire       [54:0]   _zz__zz_flagNX_3;
  wire       [4:0]    _zz__zz_flagNX_4;
  wire       [96:0]   _zz__zz_when_FpUnit_l512_1;
  wire       [33:0]   _zz__zz_when_FpUnit_l512_2;
  wire       [5:0]    _zz__zz_when_FpUnit_l512_3;
  wire       [11:0]   _zz__zz_when_FpUnit_l512_4;
  wire       [33:0]   _zz__zz_when_FpUnit_l512_1_1;
  wire       [0:0]    _zz__zz_when_FpUnit_l512_1_2;
  wire       [31:0]   _zz__zz_res_53;
  wire       [63:0]   _zz_res_88;
  wire       [31:0]   _zz_res_89;
  wire       [11:0]   _zz__zz_when_FpUnit_l485_1;
  wire       [11:0]   _zz__zz_flagNX_3_1;
  wire       [23:0]   _zz__zz_when_FpUnit_l512_2_1;
  wire       [23:0]   _zz__zz_flagNX_2_1;
  wire       [23:0]   _zz__zz_flagNX_2_2;
  wire       [54:0]   _zz__zz_flagNX_2_3;
  wire       [4:0]    _zz__zz_flagNX_2_4;
  wire       [96:0]   _zz__zz_when_FpUnit_l512_2_2;
  wire       [33:0]   _zz__zz_when_FpUnit_l512_2_3;
  wire       [5:0]    _zz__zz_when_FpUnit_l512_2_4;
  wire       [11:0]   _zz__zz_when_FpUnit_l512_2_5;
  wire       [33:0]   _zz__zz_when_FpUnit_l512_3_1;
  wire       [0:0]    _zz__zz_when_FpUnit_l512_3_2;
  wire       [31:0]   _zz__zz_res_54;
  wire       [63:0]   _zz_res_90;
  wire       [11:0]   _zz__zz_when_FpUnit_l485_2;
  wire       [11:0]   _zz__zz_flagNX_5;
  wire       [23:0]   _zz__zz_when_FpUnit_l512_4_1;
  wire       [23:0]   _zz__zz_flagNX_4_1;
  wire       [23:0]   _zz__zz_flagNX_4_2;
  wire       [54:0]   _zz__zz_flagNX_4_3;
  wire       [4:0]    _zz__zz_flagNX_4_4;
  wire       [192:0]  _zz__zz_when_FpUnit_l512_4_2;
  wire       [65:0]   _zz__zz_when_FpUnit_l512_4_3;
  wire       [6:0]    _zz__zz_when_FpUnit_l512_4_4;
  wire       [11:0]   _zz__zz_when_FpUnit_l512_4_5;
  wire       [65:0]   _zz__zz_when_FpUnit_l512_5;
  wire       [0:0]    _zz__zz_when_FpUnit_l512_5_1;
  wire       [63:0]   _zz__zz_res_55;
  wire       [63:0]   _zz_res_91;
  wire       [11:0]   _zz__zz_when_FpUnit_l485_3;
  wire       [11:0]   _zz__zz_flagNX_7;
  wire       [23:0]   _zz__zz_when_FpUnit_l512_6;
  wire       [23:0]   _zz__zz_flagNX_6;
  wire       [23:0]   _zz__zz_flagNX_6_1;
  wire       [54:0]   _zz__zz_flagNX_6_2;
  wire       [4:0]    _zz__zz_flagNX_6_3;
  wire       [192:0]  _zz__zz_when_FpUnit_l512_6_1;
  wire       [65:0]   _zz__zz_when_FpUnit_l512_6_2;
  wire       [6:0]    _zz__zz_when_FpUnit_l512_6_3;
  wire       [11:0]   _zz__zz_when_FpUnit_l512_6_4;
  wire       [65:0]   _zz__zz_when_FpUnit_l512_7;
  wire       [0:0]    _zz__zz_when_FpUnit_l512_7_1;
  wire       [63:0]   _zz__zz_res_56;
  wire       [55:0]   _zz__zz_when_FpUnit_l88_169;
  wire       [55:0]   _zz__zz_when_FpUnit_l88_169_1;
  wire       [55:0]   _zz__zz_when_FpUnit_l88_169_2;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_9;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_9_1;
  wire       [26:0]   _zz__zz_flagNX_8;
  wire       [55:0]   _zz__zz_flagNX_8_1;
  wire       [55:0]   _zz__zz_flagNX_9;
  wire       [55:0]   _zz__zz_flagNX_9_1;
  wire       [118:0]  _zz__zz_flagNX_9_2;
  wire       [26:0]   _zz__zz_flagNX_8_2;
  wire       [118:0]  _zz__zz_flagNX_8_3;
  wire       [5:0]    _zz__zz_flagNX_8_4;
  wire       [28:0]   _zz__zz_flagNX_11;
  wire       [11:0]   _zz__zz_when_FpUnit_l190_27;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_10;
  wire       [26:0]   _zz__zz_flagNX_14;
  wire       [26:0]   _zz__zz_flagNX_14_1;
  wire       [28:0]   _zz__zz_flagNX_14_2;
  wire       [4:0]    _zz__zz_flagNX_14_3;
  wire       [28:0]   _zz__zz_flagNX_15;
  wire       [28:0]   _zz__zz_flagNX_15_1;
  wire       [59:0]   _zz__zz_flagNX_15_2;
  wire       [4:0]    _zz__zz_flagNX_15_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_29;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_29_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_29_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l190_29_3;
  wire                _zz__zz_when_FpUnit_l190_29_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l190_29_5;
  wire                _zz__zz_when_FpUnit_l190_29_6;
  wire                _zz__zz_when_FpUnit_l190_29_7;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_30;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_30_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_29;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_29_1;
  wire       [7:0]    _zz__zz_res_60;
  wire       [11:0]   _zz__zz_res_60_1;
  wire       [55:0]   _zz__zz_when_FpUnit_l88_171;
  wire       [55:0]   _zz__zz_when_FpUnit_l88_171_1;
  wire       [55:0]   _zz__zz_when_FpUnit_l88_171_2;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_11;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_11_1;
  wire       [26:0]   _zz__zz_flagNX_19;
  wire       [55:0]   _zz__zz_flagNX_19_1;
  wire       [55:0]   _zz__zz_flagNX_20;
  wire       [55:0]   _zz__zz_flagNX_20_1;
  wire       [118:0]  _zz__zz_flagNX_20_2;
  wire       [26:0]   _zz__zz_flagNX_19_2;
  wire       [118:0]  _zz__zz_flagNX_19_3;
  wire       [5:0]    _zz__zz_flagNX_19_4;
  wire       [28:0]   _zz__zz_flagNX_22;
  wire       [11:0]   _zz__zz_when_FpUnit_l190_31;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_12;
  wire       [26:0]   _zz__zz_flagNX_25;
  wire       [26:0]   _zz__zz_flagNX_25_1;
  wire       [28:0]   _zz__zz_flagNX_25_2;
  wire       [4:0]    _zz__zz_flagNX_25_3;
  wire       [28:0]   _zz__zz_flagNX_26;
  wire       [28:0]   _zz__zz_flagNX_26_1;
  wire       [59:0]   _zz__zz_flagNX_26_2;
  wire       [4:0]    _zz__zz_flagNX_26_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_33;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_33_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_33_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l190_33_3;
  wire                _zz__zz_when_FpUnit_l190_33_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l190_33_5;
  wire                _zz__zz_when_FpUnit_l190_33_6;
  wire                _zz__zz_when_FpUnit_l190_33_7;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_34;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_34_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_32;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_32_1;
  wire       [7:0]    _zz__zz_res_65;
  wire       [11:0]   _zz__zz_res_65_1;
  wire       [87:0]   _zz__zz_when_FpUnit_l88_173;
  wire       [87:0]   _zz__zz_when_FpUnit_l88_173_1;
  wire       [87:0]   _zz__zz_when_FpUnit_l88_173_2;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_13;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_13_1;
  wire       [26:0]   _zz__zz_flagNX_30;
  wire       [87:0]   _zz__zz_flagNX_30_1;
  wire       [87:0]   _zz__zz_flagNX_31;
  wire       [87:0]   _zz__zz_flagNX_31_1;
  wire       [214:0]  _zz__zz_flagNX_31_2;
  wire       [26:0]   _zz__zz_flagNX_30_2;
  wire       [214:0]  _zz__zz_flagNX_30_3;
  wire       [6:0]    _zz__zz_flagNX_30_4;
  wire       [28:0]   _zz__zz_flagNX_33;
  wire       [11:0]   _zz__zz_when_FpUnit_l190_35;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_14;
  wire       [26:0]   _zz__zz_flagNX_36;
  wire       [26:0]   _zz__zz_flagNX_36_1;
  wire       [28:0]   _zz__zz_flagNX_36_2;
  wire       [4:0]    _zz__zz_flagNX_36_3;
  wire       [28:0]   _zz__zz_flagNX_37;
  wire       [28:0]   _zz__zz_flagNX_37_1;
  wire       [59:0]   _zz__zz_flagNX_37_2;
  wire       [4:0]    _zz__zz_flagNX_37_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_37;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_37_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_37_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l190_37_3;
  wire                _zz__zz_when_FpUnit_l190_37_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l190_37_5;
  wire                _zz__zz_when_FpUnit_l190_37_6;
  wire                _zz__zz_when_FpUnit_l190_37_7;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_38;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_38_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_35;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_35_1;
  wire       [7:0]    _zz__zz_res_70;
  wire       [11:0]   _zz__zz_res_70_1;
  wire       [87:0]   _zz__zz_when_FpUnit_l88_175;
  wire       [87:0]   _zz__zz_when_FpUnit_l88_175_1;
  wire       [87:0]   _zz__zz_when_FpUnit_l88_175_2;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_15;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_15_1;
  wire       [26:0]   _zz__zz_flagNX_41;
  wire       [87:0]   _zz__zz_flagNX_41_1;
  wire       [87:0]   _zz__zz_flagNX_42;
  wire       [87:0]   _zz__zz_flagNX_42_1;
  wire       [214:0]  _zz__zz_flagNX_42_2;
  wire       [26:0]   _zz__zz_flagNX_41_2;
  wire       [214:0]  _zz__zz_flagNX_41_3;
  wire       [6:0]    _zz__zz_flagNX_41_4;
  wire       [28:0]   _zz__zz_flagNX_44;
  wire       [11:0]   _zz__zz_when_FpUnit_l190_39;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_16;
  wire       [26:0]   _zz__zz_flagNX_47;
  wire       [26:0]   _zz__zz_flagNX_47_1;
  wire       [28:0]   _zz__zz_flagNX_47_2;
  wire       [4:0]    _zz__zz_flagNX_47_3;
  wire       [28:0]   _zz__zz_flagNX_48;
  wire       [28:0]   _zz__zz_flagNX_48_1;
  wire       [59:0]   _zz__zz_flagNX_48_2;
  wire       [4:0]    _zz__zz_flagNX_48_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_41;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_41_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_41_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l190_41_3;
  wire                _zz__zz_when_FpUnit_l190_41_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l190_41_5;
  wire                _zz__zz_when_FpUnit_l190_41_6;
  wire                _zz__zz_when_FpUnit_l190_41_7;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_42;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_42_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_38;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_38_1;
  wire       [7:0]    _zz__zz_res_75;
  wire       [11:0]   _zz__zz_res_75_1;
  wire       [11:0]   _zz__zz_flagUF_137;
  wire       [11:0]   _zz__zz_flagUF_137_1;
  wire       [11:0]   _zz__zz_flagUF_137_2;
  wire       [11:0]   _zz__zz_flagUF_137_3;
  wire       [26:0]   _zz__zz_flagUF_135;
  wire       [23:0]   _zz__zz_flagUF_135_1;
  wire       [23:0]   _zz__zz_flagUF_136;
  wire       [23:0]   _zz__zz_flagUF_136_1;
  wire       [54:0]   _zz__zz_flagUF_136_2;
  wire       [26:0]   _zz__zz_flagUF_135_2;
  wire       [54:0]   _zz__zz_flagUF_135_3;
  wire       [4:0]    _zz__zz_flagUF_135_4;
  wire       [28:0]   _zz__zz_flagUF_139;
  wire       [11:0]   _zz__zz_flagUF_142;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_17;
  wire       [26:0]   _zz__zz_flagUF_143;
  wire       [26:0]   _zz__zz_flagUF_143_1;
  wire       [28:0]   _zz__zz_flagUF_143_2;
  wire       [4:0]    _zz__zz_flagUF_143_3;
  wire       [28:0]   _zz__zz_flagUF_144;
  wire       [28:0]   _zz__zz_flagUF_144_1;
  wire       [59:0]   _zz__zz_flagUF_144_2;
  wire       [4:0]    _zz__zz_flagUF_144_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_44;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_44_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_44_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l190_44_3;
  wire                _zz__zz_when_FpUnit_l190_44_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l190_44_5;
  wire                _zz__zz_when_FpUnit_l190_44_6;
  wire                _zz__zz_when_FpUnit_l190_44_7;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_45;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_45_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_41;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_41_1;
  wire       [7:0]    _zz__zz_res_79;
  wire       [11:0]   _zz__zz_res_79_1;
  wire       [23:0]   _zz__zz_when_FpUnit_l88_177;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_18;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_18_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_18_2;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_18_3;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_18_4;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_18_5;
  wire       [7:0]    _zz__zz_when_FpUnit_l147_18_6;
  wire       [26:0]   _zz__zz_when_FpUnit_l190_46;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_46_1;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_47;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_47_1;
  wire       [54:0]   _zz__zz_when_FpUnit_l190_47_2;
  wire       [26:0]   _zz__zz_when_FpUnit_l190_46_2;
  wire       [54:0]   _zz__zz_when_FpUnit_l190_46_3;
  wire       [4:0]    _zz__zz_when_FpUnit_l190_46_4;
  wire       [28:0]   _zz__zz_when_FpUnit_l190_49;
  wire       [11:0]   _zz__zz_when_FpUnit_l190_52;
  wire       [11:0]   _zz__zz_when_FpUnit_l147_19;
  wire       [26:0]   _zz__zz_when_FpUnit_l190_53;
  wire       [26:0]   _zz__zz_when_FpUnit_l190_53_1;
  wire       [28:0]   _zz__zz_when_FpUnit_l190_53_2;
  wire       [4:0]    _zz__zz_when_FpUnit_l190_53_3;
  wire       [28:0]   _zz__zz_when_FpUnit_l190_54;
  wire       [28:0]   _zz__zz_when_FpUnit_l190_54_1;
  wire       [59:0]   _zz__zz_when_FpUnit_l190_54_2;
  wire       [4:0]    _zz__zz_when_FpUnit_l190_54_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_59;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_59_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l190_59_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l190_59_3;
  wire                _zz__zz_when_FpUnit_l190_59_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l190_59_5;
  wire                _zz__zz_when_FpUnit_l190_59_6;
  wire                _zz__zz_when_FpUnit_l190_59_7;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_60;
  wire       [23:0]   _zz__zz_when_FpUnit_l190_60_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_44;
  wire       [11:0]   _zz__zz_when_FpUnit_l186_44_1;
  wire       [7:0]    _zz__zz_res_84;
  wire       [11:0]   _zz__zz_res_84_1;
  wire                when_FpUnit_l519;
  wire       [7:0]    _zz_when_FpUnit_l308;
  wire       [22:0]   _zz_when_FpUnit_l308_1;
  wire                _zz_when_FpUnit_l308_2;
  wire                _zz_when_FpUnit_l244;
  wire                _zz_when_FpUnit_l308_3;
  wire                when_FpUnit_l308;
  wire                when_FpUnit_l244;
  wire                when_FpUnit_l342;
  wire                _zz_flagNV;
  wire                _zz_res;
  wire       [9:0]    _zz_when_FpUnit_l218;
  wire       [23:0]   _zz_when_FpUnit_l88;
  wire                _zz_when_FpUnit_l243;
  wire       [7:0]    _zz_when_FpUnit_l305;
  wire       [22:0]   _zz_when_FpUnit_l305_1;
  wire                _zz_when_FpUnit_l305_2;
  wire                _zz_when_FpUnit_l245;
  wire                _zz_when_FpUnit_l305_3;
  wire                when_FpUnit_l305;
  wire                when_FpUnit_l245;
  wire                when_FpUnit_l431;
  wire                _zz_flagNV_1;
  wire       [9:0]    _zz_when_FpUnit_l218_1;
  wire       [23:0]   _zz_when_FpUnit_l88_1;
  wire                _zz_when_FpUnit_l397;
  wire       [7:0]    _zz_when_FpUnit_l399;
  wire       [22:0]   _zz_when_FpUnit_l399_1;
  wire                _zz_when_FpUnit_l367;
  wire                _zz_when_FpUnit_l399_2;
  wire                _zz_when_FpUnit_l399_3;
  wire                when_FpUnit_l399;
  wire                _zz_when_FpUnit_l395;
  wire                _zz_flagNV_2;
  wire       [9:0]    _zz_when_FpUnit_l367_1;
  wire       [23:0]   _zz_when_FpUnit_l88_2;
  reg        [63:0]   res;
  reg                 flagNV;
  reg                 flagDZ;
  reg                 flagOF;
  reg                 flagUF;
  reg                 flagNX;
  wire                _zz_when_FpUnit_l243_1;
  wire                _zz_when_FpUnit_l218_2;
  wire                _zz_when_FpUnit_l88_3;
  wire                _zz_when_FpUnit_l88_4;
  wire       [9:0]    _zz_when_FpUnit_l218_3;
  wire       [27:0]   _zz_when_FpUnit_l88_5;
  wire       [9:0]    _zz_when_FpUnit_l218_4;
  reg        [27:0]   _zz_when_FpUnit_l88_6;
  wire                when_FpUnit_l218;
  wire                _zz_when_FpUnit_l88_7;
  wire       [27:0]   _zz_when_FpUnit_l88_8;
  wire                _zz_when_FpUnit_l88_9;
  wire       [27:0]   _zz_when_FpUnit_l88_10;
  wire                _zz_res_1;
  reg        [4:0]    _zz_when_FpUnit_l95;
  wire                when_FpUnit_l88;
  wire                when_FpUnit_l88_1;
  wire                when_FpUnit_l88_2;
  wire                when_FpUnit_l88_3;
  wire                when_FpUnit_l88_4;
  wire                when_FpUnit_l88_5;
  wire                when_FpUnit_l88_6;
  wire                when_FpUnit_l88_7;
  wire                when_FpUnit_l88_8;
  wire                when_FpUnit_l88_9;
  wire                when_FpUnit_l88_10;
  wire                when_FpUnit_l88_11;
  wire                when_FpUnit_l88_12;
  wire                when_FpUnit_l88_13;
  wire                when_FpUnit_l88_14;
  wire                when_FpUnit_l88_15;
  wire                when_FpUnit_l88_16;
  wire                when_FpUnit_l88_17;
  wire                when_FpUnit_l88_18;
  wire                when_FpUnit_l88_19;
  wire                when_FpUnit_l88_20;
  wire                when_FpUnit_l88_21;
  wire                when_FpUnit_l88_22;
  wire                when_FpUnit_l88_23;
  wire                when_FpUnit_l88_24;
  wire                when_FpUnit_l88_25;
  wire                when_FpUnit_l88_26;
  wire                when_FpUnit_l88_27;
  reg        [26:0]   _zz_flagUF;
  reg                 _zz_flagUF_1;
  wire       [11:0]   _zz_flagUF_2;
  wire                when_FpUnit_l94;
  wire                when_FpUnit_l95;
  wire       [4:0]    _zz_flagUF_3;
  wire                when_FpUnit_l246;
  wire       [28:0]   _zz_flagUF_4;
  wire       [28:0]   _zz_flagUF_5;
  wire                _zz_flagUF_6;
  wire                _zz_flagUF_7;
  wire       [11:0]   _zz_when_FpUnit_l147;
  wire       [11:0]   _zz_when_FpUnit_l150;
  reg        [26:0]   _zz_flagUF_8;
  reg                 _zz_flagUF_9;
  wire                when_FpUnit_l147;
  wire                when_FpUnit_l150;
  wire       [11:0]   _zz_when_FpUnit_l186;
  wire                _zz_flagUF_10;
  wire                _zz_flagUF_11;
  wire                _zz_flagUF_12;
  wire       [23:0]   _zz_when_FpUnit_l190;
  wire       [24:0]   _zz_when_FpUnit_l190_1;
  wire                _zz_when_FpUnit_l186_1;
  wire       [23:0]   _zz_when_FpUnit_l190_2;
  wire       [11:0]   _zz_when_FpUnit_l186_2;
  wire                _zz_flagUF_13;
  wire                when_FpUnit_l186;
  wire       [31:0]   _zz_res_2;
  wire       [31:0]   _zz_res_3;
  reg        [31:0]   _zz_res_4;
  wire                when_FpUnit_l190;
  wire                when_FpUnit_l192;
  reg        [31:0]   _zz_res_5;
  wire                when_FpUnit_l242;
  wire                when_FpUnit_l243;
  wire                _zz_when_FpUnit_l243_2;
  wire                _zz_when_FpUnit_l218_5;
  wire                _zz_when_FpUnit_l88_11;
  wire                _zz_when_FpUnit_l88_12;
  wire       [9:0]    _zz_when_FpUnit_l218_6;
  wire       [27:0]   _zz_when_FpUnit_l88_13;
  wire       [9:0]    _zz_when_FpUnit_l218_7;
  reg        [27:0]   _zz_when_FpUnit_l88_14;
  wire                when_FpUnit_l218_1;
  wire                _zz_when_FpUnit_l88_15;
  wire       [27:0]   _zz_when_FpUnit_l88_16;
  wire                _zz_when_FpUnit_l88_17;
  wire       [27:0]   _zz_when_FpUnit_l88_18;
  wire                _zz_res_6;
  reg        [4:0]    _zz_when_FpUnit_l95_1;
  wire                when_FpUnit_l88_28;
  wire                when_FpUnit_l88_29;
  wire                when_FpUnit_l88_30;
  wire                when_FpUnit_l88_31;
  wire                when_FpUnit_l88_32;
  wire                when_FpUnit_l88_33;
  wire                when_FpUnit_l88_34;
  wire                when_FpUnit_l88_35;
  wire                when_FpUnit_l88_36;
  wire                when_FpUnit_l88_37;
  wire                when_FpUnit_l88_38;
  wire                when_FpUnit_l88_39;
  wire                when_FpUnit_l88_40;
  wire                when_FpUnit_l88_41;
  wire                when_FpUnit_l88_42;
  wire                when_FpUnit_l88_43;
  wire                when_FpUnit_l88_44;
  wire                when_FpUnit_l88_45;
  wire                when_FpUnit_l88_46;
  wire                when_FpUnit_l88_47;
  wire                when_FpUnit_l88_48;
  wire                when_FpUnit_l88_49;
  wire                when_FpUnit_l88_50;
  wire                when_FpUnit_l88_51;
  wire                when_FpUnit_l88_52;
  wire                when_FpUnit_l88_53;
  wire                when_FpUnit_l88_54;
  wire                when_FpUnit_l88_55;
  reg        [26:0]   _zz_flagUF_14;
  reg                 _zz_flagUF_15;
  wire       [11:0]   _zz_flagUF_16;
  wire                when_FpUnit_l94_1;
  wire                when_FpUnit_l95_1;
  wire       [4:0]    _zz_flagUF_17;
  wire                when_FpUnit_l246_1;
  wire       [28:0]   _zz_flagUF_18;
  wire       [28:0]   _zz_flagUF_19;
  wire                _zz_flagUF_20;
  wire                _zz_flagUF_21;
  wire       [11:0]   _zz_when_FpUnit_l147_1;
  wire       [11:0]   _zz_when_FpUnit_l150_1;
  reg        [26:0]   _zz_flagUF_22;
  reg                 _zz_flagUF_23;
  wire                when_FpUnit_l147_1;
  wire                when_FpUnit_l150_1;
  wire       [11:0]   _zz_when_FpUnit_l186_3;
  wire                _zz_flagUF_24;
  wire                _zz_flagUF_25;
  wire                _zz_flagUF_26;
  wire       [23:0]   _zz_when_FpUnit_l190_3;
  wire       [24:0]   _zz_when_FpUnit_l190_4;
  wire                _zz_when_FpUnit_l186_4;
  wire       [23:0]   _zz_when_FpUnit_l190_5;
  wire       [11:0]   _zz_when_FpUnit_l186_5;
  wire                _zz_flagUF_27;
  wire                when_FpUnit_l186_1;
  wire       [31:0]   _zz_res_7;
  wire       [31:0]   _zz_res_8;
  reg        [31:0]   _zz_res_9;
  wire                when_FpUnit_l190_1;
  wire                when_FpUnit_l192_1;
  reg        [31:0]   _zz_res_10;
  wire                when_FpUnit_l242_1;
  wire                when_FpUnit_l243_1;
  wire                _zz_res_11;
  wire       [47:0]   _zz_when_FpUnit_l88_19;
  reg        [5:0]    _zz_when_FpUnit_l95_2;
  wire                when_FpUnit_l88_56;
  wire                when_FpUnit_l88_57;
  wire                when_FpUnit_l88_58;
  wire                when_FpUnit_l88_59;
  wire                when_FpUnit_l88_60;
  wire                when_FpUnit_l88_61;
  wire                when_FpUnit_l88_62;
  wire                when_FpUnit_l88_63;
  wire                when_FpUnit_l88_64;
  wire                when_FpUnit_l88_65;
  wire                when_FpUnit_l88_66;
  wire                when_FpUnit_l88_67;
  wire                when_FpUnit_l88_68;
  wire                when_FpUnit_l88_69;
  wire                when_FpUnit_l88_70;
  wire                when_FpUnit_l88_71;
  wire                when_FpUnit_l88_72;
  wire                when_FpUnit_l88_73;
  wire                when_FpUnit_l88_74;
  wire                when_FpUnit_l88_75;
  wire                when_FpUnit_l88_76;
  wire                when_FpUnit_l88_77;
  wire                when_FpUnit_l88_78;
  wire                when_FpUnit_l88_79;
  wire                when_FpUnit_l88_80;
  wire                when_FpUnit_l88_81;
  wire                when_FpUnit_l88_82;
  wire                when_FpUnit_l88_83;
  wire                when_FpUnit_l88_84;
  wire                when_FpUnit_l88_85;
  wire                when_FpUnit_l88_86;
  wire                when_FpUnit_l88_87;
  wire                when_FpUnit_l88_88;
  wire                when_FpUnit_l88_89;
  wire                when_FpUnit_l88_90;
  wire                when_FpUnit_l88_91;
  wire                when_FpUnit_l88_92;
  wire                when_FpUnit_l88_93;
  wire                when_FpUnit_l88_94;
  wire                when_FpUnit_l88_95;
  wire                when_FpUnit_l88_96;
  wire                when_FpUnit_l88_97;
  wire                when_FpUnit_l88_98;
  wire                when_FpUnit_l88_99;
  wire                when_FpUnit_l88_100;
  wire                when_FpUnit_l88_101;
  wire                when_FpUnit_l88_102;
  wire                when_FpUnit_l88_103;
  reg        [26:0]   _zz_flagUF_28;
  reg                 _zz_flagUF_29;
  wire       [11:0]   _zz_flagUF_30;
  wire                when_FpUnit_l94_2;
  wire                when_FpUnit_l95_2;
  wire       [5:0]    _zz_flagUF_31;
  wire       [28:0]   _zz_flagUF_32;
  wire       [28:0]   _zz_flagUF_33;
  wire                _zz_flagUF_34;
  wire                _zz_flagUF_35;
  wire       [11:0]   _zz_when_FpUnit_l147_2;
  wire       [11:0]   _zz_when_FpUnit_l150_2;
  reg        [26:0]   _zz_flagUF_36;
  reg                 _zz_flagUF_37;
  wire                when_FpUnit_l147_2;
  wire                when_FpUnit_l150_2;
  wire       [11:0]   _zz_when_FpUnit_l186_6;
  wire                _zz_flagUF_38;
  wire                _zz_flagUF_39;
  wire                _zz_flagUF_40;
  wire       [23:0]   _zz_when_FpUnit_l190_6;
  wire       [24:0]   _zz_when_FpUnit_l190_7;
  wire                _zz_when_FpUnit_l186_7;
  wire       [23:0]   _zz_when_FpUnit_l190_8;
  wire       [11:0]   _zz_when_FpUnit_l186_8;
  wire                _zz_flagUF_41;
  wire                when_FpUnit_l186_2;
  wire       [31:0]   _zz_res_12;
  wire       [31:0]   _zz_res_13;
  reg        [31:0]   _zz_res_14;
  wire                when_FpUnit_l190_2;
  wire                when_FpUnit_l192_2;
  reg        [31:0]   _zz_res_15;
  wire                when_FpUnit_l272;
  wire                when_FpUnit_l273;
  wire                when_FpUnit_l274;
  wire                when_FpUnit_l275;
  wire                _zz_res_16;
  wire       [79:0]   _zz_when_FpUnit_l88_20;
  wire       [28:0]   _zz_when_FpUnit_l88_21;
  reg        [4:0]    _zz_when_FpUnit_l95_3;
  wire                when_FpUnit_l88_104;
  wire                when_FpUnit_l88_105;
  wire                when_FpUnit_l88_106;
  wire                when_FpUnit_l88_107;
  wire                when_FpUnit_l88_108;
  wire                when_FpUnit_l88_109;
  wire                when_FpUnit_l88_110;
  wire                when_FpUnit_l88_111;
  wire                when_FpUnit_l88_112;
  wire                when_FpUnit_l88_113;
  wire                when_FpUnit_l88_114;
  wire                when_FpUnit_l88_115;
  wire                when_FpUnit_l88_116;
  wire                when_FpUnit_l88_117;
  wire                when_FpUnit_l88_118;
  wire                when_FpUnit_l88_119;
  wire                when_FpUnit_l88_120;
  wire                when_FpUnit_l88_121;
  wire                when_FpUnit_l88_122;
  wire                when_FpUnit_l88_123;
  wire                when_FpUnit_l88_124;
  wire                when_FpUnit_l88_125;
  wire                when_FpUnit_l88_126;
  wire                when_FpUnit_l88_127;
  wire                when_FpUnit_l88_128;
  wire                when_FpUnit_l88_129;
  wire                when_FpUnit_l88_130;
  wire                when_FpUnit_l88_131;
  wire                when_FpUnit_l88_132;
  reg        [26:0]   _zz_flagUF_42;
  reg                 _zz_flagUF_43;
  wire       [11:0]   _zz_flagUF_44;
  wire                when_FpUnit_l94_3;
  wire                when_FpUnit_l95_3;
  wire       [4:0]    _zz_flagUF_45;
  wire       [28:0]   _zz_flagUF_46;
  wire       [28:0]   _zz_flagUF_47;
  wire                _zz_flagUF_48;
  wire                _zz_flagUF_49;
  wire       [11:0]   _zz_when_FpUnit_l147_3;
  wire       [11:0]   _zz_when_FpUnit_l150_3;
  reg        [26:0]   _zz_flagUF_50;
  reg                 _zz_flagUF_51;
  wire                when_FpUnit_l147_3;
  wire                when_FpUnit_l150_3;
  wire       [11:0]   _zz_when_FpUnit_l186_9;
  wire                _zz_flagUF_52;
  wire                _zz_flagUF_53;
  wire                _zz_flagUF_54;
  wire       [23:0]   _zz_when_FpUnit_l190_9;
  wire       [24:0]   _zz_when_FpUnit_l190_10;
  wire                _zz_when_FpUnit_l186_10;
  wire       [23:0]   _zz_when_FpUnit_l190_11;
  wire       [11:0]   _zz_when_FpUnit_l186_11;
  wire                _zz_flagUF_55;
  wire                when_FpUnit_l186_3;
  wire       [31:0]   _zz_res_17;
  wire       [31:0]   _zz_res_18;
  reg        [31:0]   _zz_res_19;
  wire                when_FpUnit_l190_3;
  wire                when_FpUnit_l192_3;
  reg        [31:0]   _zz_res_20;
  wire                when_FpUnit_l299;
  wire                when_FpUnit_l300;
  wire                _zz_flagUF_56;
  wire       [55:0]   _zz_when_FpUnit_l88_22;
  wire       [29:0]   _zz_when_FpUnit_l88_23;
  wire       [57:0]   _zz_when_FpUnit_l88_24;
  wire       [57:0]   _zz_when_FpUnit_l88_25;
  wire                _zz_when_FpUnit_l88_26;
  wire       [29:0]   _zz_when_FpUnit_l88_27;
  wire       [57:0]   _zz_when_FpUnit_l88_28;
  wire       [57:0]   _zz_when_FpUnit_l88_29;
  wire                _zz_when_FpUnit_l88_30;
  wire       [29:0]   _zz_when_FpUnit_l88_31;
  wire       [57:0]   _zz_when_FpUnit_l88_32;
  wire       [57:0]   _zz_when_FpUnit_l88_33;
  wire                _zz_when_FpUnit_l88_34;
  wire       [29:0]   _zz_when_FpUnit_l88_35;
  wire       [57:0]   _zz_when_FpUnit_l88_36;
  wire       [57:0]   _zz_when_FpUnit_l88_37;
  wire                _zz_when_FpUnit_l88_38;
  wire       [29:0]   _zz_when_FpUnit_l88_39;
  wire       [57:0]   _zz_when_FpUnit_l88_40;
  wire       [57:0]   _zz_when_FpUnit_l88_41;
  wire                _zz_when_FpUnit_l88_42;
  wire       [29:0]   _zz_when_FpUnit_l88_43;
  wire       [57:0]   _zz_when_FpUnit_l88_44;
  wire       [57:0]   _zz_when_FpUnit_l88_45;
  wire                _zz_when_FpUnit_l88_46;
  wire       [29:0]   _zz_when_FpUnit_l88_47;
  wire       [57:0]   _zz_when_FpUnit_l88_48;
  wire       [57:0]   _zz_when_FpUnit_l88_49;
  wire                _zz_when_FpUnit_l88_50;
  wire       [29:0]   _zz_when_FpUnit_l88_51;
  wire       [57:0]   _zz_when_FpUnit_l88_52;
  wire       [57:0]   _zz_when_FpUnit_l88_53;
  wire                _zz_when_FpUnit_l88_54;
  wire       [29:0]   _zz_when_FpUnit_l88_55;
  wire       [57:0]   _zz_when_FpUnit_l88_56;
  wire       [57:0]   _zz_when_FpUnit_l88_57;
  wire                _zz_when_FpUnit_l88_58;
  wire       [29:0]   _zz_when_FpUnit_l88_59;
  wire       [57:0]   _zz_when_FpUnit_l88_60;
  wire       [57:0]   _zz_when_FpUnit_l88_61;
  wire                _zz_when_FpUnit_l88_62;
  wire       [29:0]   _zz_when_FpUnit_l88_63;
  wire       [57:0]   _zz_when_FpUnit_l88_64;
  wire       [57:0]   _zz_when_FpUnit_l88_65;
  wire                _zz_when_FpUnit_l88_66;
  wire       [29:0]   _zz_when_FpUnit_l88_67;
  wire       [57:0]   _zz_when_FpUnit_l88_68;
  wire       [57:0]   _zz_when_FpUnit_l88_69;
  wire                _zz_when_FpUnit_l88_70;
  wire       [29:0]   _zz_when_FpUnit_l88_71;
  wire       [57:0]   _zz_when_FpUnit_l88_72;
  wire       [57:0]   _zz_when_FpUnit_l88_73;
  wire                _zz_when_FpUnit_l88_74;
  wire       [29:0]   _zz_when_FpUnit_l88_75;
  wire       [57:0]   _zz_when_FpUnit_l88_76;
  wire       [57:0]   _zz_when_FpUnit_l88_77;
  wire                _zz_when_FpUnit_l88_78;
  wire       [29:0]   _zz_when_FpUnit_l88_79;
  wire       [57:0]   _zz_when_FpUnit_l88_80;
  wire       [57:0]   _zz_when_FpUnit_l88_81;
  wire                _zz_when_FpUnit_l88_82;
  wire       [29:0]   _zz_when_FpUnit_l88_83;
  wire       [57:0]   _zz_when_FpUnit_l88_84;
  wire       [57:0]   _zz_when_FpUnit_l88_85;
  wire                _zz_when_FpUnit_l88_86;
  wire       [29:0]   _zz_when_FpUnit_l88_87;
  wire       [57:0]   _zz_when_FpUnit_l88_88;
  wire       [57:0]   _zz_when_FpUnit_l88_89;
  wire                _zz_when_FpUnit_l88_90;
  wire       [29:0]   _zz_when_FpUnit_l88_91;
  wire       [57:0]   _zz_when_FpUnit_l88_92;
  wire       [57:0]   _zz_when_FpUnit_l88_93;
  wire                _zz_when_FpUnit_l88_94;
  wire       [29:0]   _zz_when_FpUnit_l88_95;
  wire       [57:0]   _zz_when_FpUnit_l88_96;
  wire       [57:0]   _zz_when_FpUnit_l88_97;
  wire                _zz_when_FpUnit_l88_98;
  wire       [29:0]   _zz_when_FpUnit_l88_99;
  wire       [57:0]   _zz_when_FpUnit_l88_100;
  wire       [57:0]   _zz_when_FpUnit_l88_101;
  wire                _zz_when_FpUnit_l88_102;
  wire       [29:0]   _zz_when_FpUnit_l88_103;
  wire       [57:0]   _zz_when_FpUnit_l88_104;
  wire       [57:0]   _zz_when_FpUnit_l88_105;
  wire                _zz_when_FpUnit_l88_106;
  wire       [29:0]   _zz_when_FpUnit_l88_107;
  wire       [57:0]   _zz_when_FpUnit_l88_108;
  wire       [57:0]   _zz_when_FpUnit_l88_109;
  wire                _zz_when_FpUnit_l88_110;
  wire       [29:0]   _zz_when_FpUnit_l88_111;
  wire       [57:0]   _zz_when_FpUnit_l88_112;
  wire       [57:0]   _zz_when_FpUnit_l88_113;
  wire                _zz_when_FpUnit_l88_114;
  wire       [29:0]   _zz_when_FpUnit_l88_115;
  wire       [57:0]   _zz_when_FpUnit_l88_116;
  wire       [57:0]   _zz_when_FpUnit_l88_117;
  wire                _zz_when_FpUnit_l88_118;
  wire       [29:0]   _zz_when_FpUnit_l88_119;
  wire       [57:0]   _zz_when_FpUnit_l88_120;
  wire       [57:0]   _zz_when_FpUnit_l88_121;
  wire                _zz_when_FpUnit_l88_122;
  wire       [29:0]   _zz_when_FpUnit_l88_123;
  wire       [57:0]   _zz_when_FpUnit_l88_124;
  wire       [57:0]   _zz_when_FpUnit_l88_125;
  wire                _zz_when_FpUnit_l88_126;
  wire       [29:0]   _zz_when_FpUnit_l88_127;
  wire       [57:0]   _zz_when_FpUnit_l88_128;
  wire       [57:0]   _zz_when_FpUnit_l88_129;
  wire                _zz_when_FpUnit_l88_130;
  wire       [29:0]   _zz_when_FpUnit_l88_131;
  wire       [57:0]   _zz_when_FpUnit_l88_132;
  wire       [57:0]   _zz_when_FpUnit_l88_133;
  wire                _zz_when_FpUnit_l88_134;
  wire       [29:0]   _zz_when_FpUnit_l88_135;
  reg        [4:0]    _zz_when_FpUnit_l95_4;
  wire                when_FpUnit_l88_133;
  wire                when_FpUnit_l88_134;
  wire                when_FpUnit_l88_135;
  wire                when_FpUnit_l88_136;
  wire                when_FpUnit_l88_137;
  wire                when_FpUnit_l88_138;
  wire                when_FpUnit_l88_139;
  wire                when_FpUnit_l88_140;
  wire                when_FpUnit_l88_141;
  wire                when_FpUnit_l88_142;
  wire                when_FpUnit_l88_143;
  wire                when_FpUnit_l88_144;
  wire                when_FpUnit_l88_145;
  wire                when_FpUnit_l88_146;
  wire                when_FpUnit_l88_147;
  wire                when_FpUnit_l88_148;
  wire                when_FpUnit_l88_149;
  wire                when_FpUnit_l88_150;
  wire                when_FpUnit_l88_151;
  wire                when_FpUnit_l88_152;
  wire                when_FpUnit_l88_153;
  wire                when_FpUnit_l88_154;
  wire                when_FpUnit_l88_155;
  wire                when_FpUnit_l88_156;
  wire                when_FpUnit_l88_157;
  wire                when_FpUnit_l88_158;
  wire                when_FpUnit_l88_159;
  wire                when_FpUnit_l88_160;
  wire                when_FpUnit_l88_161;
  wire                when_FpUnit_l88_162;
  reg        [26:0]   _zz_flagUF_57;
  reg                 _zz_flagUF_58;
  wire       [11:0]   _zz_flagUF_59;
  wire                when_FpUnit_l94_4;
  wire                when_FpUnit_l95_4;
  wire       [4:0]    _zz_flagUF_60;
  wire                _zz_res_21;
  wire       [28:0]   _zz_flagUF_61;
  wire       [28:0]   _zz_flagUF_62;
  wire                _zz_flagUF_63;
  wire                _zz_flagUF_64;
  wire       [11:0]   _zz_when_FpUnit_l147_4;
  wire       [11:0]   _zz_when_FpUnit_l150_4;
  reg        [26:0]   _zz_flagUF_65;
  reg                 _zz_flagUF_66;
  wire                when_FpUnit_l147_4;
  wire                when_FpUnit_l150_4;
  wire       [11:0]   _zz_when_FpUnit_l186_12;
  wire                _zz_flagUF_67;
  wire                _zz_flagUF_68;
  wire                _zz_flagUF_69;
  wire       [23:0]   _zz_when_FpUnit_l190_12;
  wire       [24:0]   _zz_when_FpUnit_l190_13;
  wire                _zz_when_FpUnit_l186_13;
  wire       [23:0]   _zz_when_FpUnit_l190_14;
  wire       [11:0]   _zz_when_FpUnit_l186_14;
  wire                _zz_flagUF_70;
  wire                when_FpUnit_l186_4;
  wire       [31:0]   _zz_res_22;
  wire       [31:0]   _zz_res_23;
  reg        [31:0]   _zz_res_24;
  wire                when_FpUnit_l190_4;
  wire                when_FpUnit_l192_4;
  reg        [31:0]   _zz_res_25;
  wire                when_FpUnit_l343;
  wire                when_FpUnit_l434;
  wire                when_FpUnit_l432;
  wire                _zz_res_26;
  wire                _zz_res_27;
  reg        [31:0]   _zz_res_28;
  wire                when_FpUnit_l429;
  wire                when_FpUnit_l434_1;
  wire                when_FpUnit_l432_1;
  wire                _zz_res_29;
  wire                _zz_res_30;
  reg        [31:0]   _zz_res_31;
  wire                when_FpUnit_l429_1;
  reg        [31:0]   _zz_res_32;
  wire                _zz_res_33;
  wire                _zz_res_34;
  reg        [31:0]   _zz_res_35;
  reg        [9:0]    _zz_res_36;
  wire                _zz_when_FpUnit_l397_1;
  wire                _zz_when_FpUnit_l397_2;
  wire       [47:0]   _zz_when_FpUnit_l88_136;
  wire       [11:0]   _zz_when_FpUnit_l367_2;
  wire       [11:0]   _zz_when_FpUnit_l367_3;
  wire       [11:0]   _zz_when_FpUnit_l367_4;
  wire       [11:0]   _zz_when_FpUnit_l367_5;
  wire       [11:0]   _zz_when_FpUnit_l368;
  reg        [53:0]   _zz_when_FpUnit_l88_137;
  reg                 _zz_flagUF_71;
  wire                when_FpUnit_l367;
  wire                when_FpUnit_l368;
  wire       [11:0]   _zz_when_FpUnit_l367_6;
  wire       [11:0]   _zz_when_FpUnit_l368_1;
  reg        [53:0]   _zz_when_FpUnit_l88_138;
  reg                 _zz_flagUF_72;
  wire                when_FpUnit_l367_1;
  wire                when_FpUnit_l368_1;
  wire       [54:0]   _zz_when_FpUnit_l88_139;
  wire       [54:0]   _zz_when_FpUnit_l88_140;
  wire       [55:0]   _zz_when_FpUnit_l88_141;
  wire                _zz_when_FpUnit_l88_142;
  wire       [55:0]   _zz_when_FpUnit_l88_143;
  reg        [5:0]    _zz_when_FpUnit_l95_5;
  wire                when_FpUnit_l88_163;
  wire                when_FpUnit_l88_164;
  wire                when_FpUnit_l88_165;
  wire                when_FpUnit_l88_166;
  wire                when_FpUnit_l88_167;
  wire                when_FpUnit_l88_168;
  wire                when_FpUnit_l88_169;
  wire                when_FpUnit_l88_170;
  wire                when_FpUnit_l88_171;
  wire                when_FpUnit_l88_172;
  wire                when_FpUnit_l88_173;
  wire                when_FpUnit_l88_174;
  wire                when_FpUnit_l88_175;
  wire                when_FpUnit_l88_176;
  wire                when_FpUnit_l88_177;
  wire                when_FpUnit_l88_178;
  wire                when_FpUnit_l88_179;
  wire                when_FpUnit_l88_180;
  wire                when_FpUnit_l88_181;
  wire                when_FpUnit_l88_182;
  wire                when_FpUnit_l88_183;
  wire                when_FpUnit_l88_184;
  wire                when_FpUnit_l88_185;
  wire                when_FpUnit_l88_186;
  wire                when_FpUnit_l88_187;
  wire                when_FpUnit_l88_188;
  wire                when_FpUnit_l88_189;
  wire                when_FpUnit_l88_190;
  wire                when_FpUnit_l88_191;
  wire                when_FpUnit_l88_192;
  wire                when_FpUnit_l88_193;
  wire                when_FpUnit_l88_194;
  wire                when_FpUnit_l88_195;
  wire                when_FpUnit_l88_196;
  wire                when_FpUnit_l88_197;
  wire                when_FpUnit_l88_198;
  wire                when_FpUnit_l88_199;
  wire                when_FpUnit_l88_200;
  wire                when_FpUnit_l88_201;
  wire                when_FpUnit_l88_202;
  wire                when_FpUnit_l88_203;
  wire                when_FpUnit_l88_204;
  wire                when_FpUnit_l88_205;
  wire                when_FpUnit_l88_206;
  wire                when_FpUnit_l88_207;
  wire                when_FpUnit_l88_208;
  wire                when_FpUnit_l88_209;
  wire                when_FpUnit_l88_210;
  wire                when_FpUnit_l88_211;
  wire                when_FpUnit_l88_212;
  wire                when_FpUnit_l88_213;
  wire                when_FpUnit_l88_214;
  wire                when_FpUnit_l88_215;
  wire                when_FpUnit_l88_216;
  wire                when_FpUnit_l88_217;
  wire                when_FpUnit_l88_218;
  reg        [26:0]   _zz_flagUF_73;
  reg                 _zz_flagUF_74;
  wire       [11:0]   _zz_flagUF_75;
  wire                when_FpUnit_l94_5;
  wire                when_FpUnit_l95_5;
  wire       [5:0]    _zz_flagUF_76;
  wire       [28:0]   _zz_flagUF_77;
  wire       [28:0]   _zz_flagUF_78;
  wire                _zz_flagUF_79;
  wire                _zz_flagUF_80;
  wire       [11:0]   _zz_when_FpUnit_l147_5;
  wire       [11:0]   _zz_when_FpUnit_l150_5;
  reg        [26:0]   _zz_flagUF_81;
  reg                 _zz_flagUF_82;
  wire                when_FpUnit_l147_5;
  wire                when_FpUnit_l150_5;
  wire       [11:0]   _zz_when_FpUnit_l186_15;
  wire                _zz_flagUF_83;
  wire                _zz_flagUF_84;
  wire                _zz_flagUF_85;
  wire       [23:0]   _zz_when_FpUnit_l190_15;
  wire       [24:0]   _zz_when_FpUnit_l190_16;
  wire                _zz_when_FpUnit_l186_16;
  wire       [23:0]   _zz_when_FpUnit_l190_17;
  wire       [11:0]   _zz_when_FpUnit_l186_17;
  wire                _zz_flagUF_86;
  wire                when_FpUnit_l186_5;
  wire       [31:0]   _zz_res_37;
  wire       [31:0]   _zz_res_38;
  reg        [31:0]   _zz_res_39;
  wire                when_FpUnit_l190_5;
  wire                when_FpUnit_l192_5;
  reg        [31:0]   _zz_res_40;
  wire                when_FpUnit_l395;
  wire                when_FpUnit_l396;
  wire                when_FpUnit_l397;
  wire                when_FpUnit_l398;
  wire                _zz_when_FpUnit_l397_3;
  wire                _zz_when_FpUnit_l397_4;
  wire       [47:0]   _zz_when_FpUnit_l88_144;
  wire       [11:0]   _zz_when_FpUnit_l367_7;
  wire       [11:0]   _zz_when_FpUnit_l367_8;
  wire       [11:0]   _zz_when_FpUnit_l367_9;
  wire       [11:0]   _zz_when_FpUnit_l367_10;
  wire       [11:0]   _zz_when_FpUnit_l368_2;
  reg        [53:0]   _zz_when_FpUnit_l88_145;
  reg                 _zz_flagUF_87;
  wire                when_FpUnit_l367_2;
  wire                when_FpUnit_l368_2;
  wire       [11:0]   _zz_when_FpUnit_l367_11;
  wire       [11:0]   _zz_when_FpUnit_l368_3;
  reg        [53:0]   _zz_when_FpUnit_l88_146;
  reg                 _zz_flagUF_88;
  wire                when_FpUnit_l367_3;
  wire                when_FpUnit_l368_3;
  wire       [54:0]   _zz_when_FpUnit_l88_147;
  wire       [54:0]   _zz_when_FpUnit_l88_148;
  wire       [55:0]   _zz_when_FpUnit_l88_149;
  wire                _zz_when_FpUnit_l88_150;
  wire       [55:0]   _zz_when_FpUnit_l88_151;
  reg        [5:0]    _zz_when_FpUnit_l95_6;
  wire                when_FpUnit_l88_219;
  wire                when_FpUnit_l88_220;
  wire                when_FpUnit_l88_221;
  wire                when_FpUnit_l88_222;
  wire                when_FpUnit_l88_223;
  wire                when_FpUnit_l88_224;
  wire                when_FpUnit_l88_225;
  wire                when_FpUnit_l88_226;
  wire                when_FpUnit_l88_227;
  wire                when_FpUnit_l88_228;
  wire                when_FpUnit_l88_229;
  wire                when_FpUnit_l88_230;
  wire                when_FpUnit_l88_231;
  wire                when_FpUnit_l88_232;
  wire                when_FpUnit_l88_233;
  wire                when_FpUnit_l88_234;
  wire                when_FpUnit_l88_235;
  wire                when_FpUnit_l88_236;
  wire                when_FpUnit_l88_237;
  wire                when_FpUnit_l88_238;
  wire                when_FpUnit_l88_239;
  wire                when_FpUnit_l88_240;
  wire                when_FpUnit_l88_241;
  wire                when_FpUnit_l88_242;
  wire                when_FpUnit_l88_243;
  wire                when_FpUnit_l88_244;
  wire                when_FpUnit_l88_245;
  wire                when_FpUnit_l88_246;
  wire                when_FpUnit_l88_247;
  wire                when_FpUnit_l88_248;
  wire                when_FpUnit_l88_249;
  wire                when_FpUnit_l88_250;
  wire                when_FpUnit_l88_251;
  wire                when_FpUnit_l88_252;
  wire                when_FpUnit_l88_253;
  wire                when_FpUnit_l88_254;
  wire                when_FpUnit_l88_255;
  wire                when_FpUnit_l88_256;
  wire                when_FpUnit_l88_257;
  wire                when_FpUnit_l88_258;
  wire                when_FpUnit_l88_259;
  wire                when_FpUnit_l88_260;
  wire                when_FpUnit_l88_261;
  wire                when_FpUnit_l88_262;
  wire                when_FpUnit_l88_263;
  wire                when_FpUnit_l88_264;
  wire                when_FpUnit_l88_265;
  wire                when_FpUnit_l88_266;
  wire                when_FpUnit_l88_267;
  wire                when_FpUnit_l88_268;
  wire                when_FpUnit_l88_269;
  wire                when_FpUnit_l88_270;
  wire                when_FpUnit_l88_271;
  wire                when_FpUnit_l88_272;
  wire                when_FpUnit_l88_273;
  wire                when_FpUnit_l88_274;
  reg        [26:0]   _zz_flagUF_89;
  reg                 _zz_flagUF_90;
  wire       [11:0]   _zz_flagUF_91;
  wire                when_FpUnit_l94_6;
  wire                when_FpUnit_l95_6;
  wire       [5:0]    _zz_flagUF_92;
  wire       [28:0]   _zz_flagUF_93;
  wire       [28:0]   _zz_flagUF_94;
  wire                _zz_flagUF_95;
  wire                _zz_flagUF_96;
  wire       [11:0]   _zz_when_FpUnit_l147_6;
  wire       [11:0]   _zz_when_FpUnit_l150_6;
  reg        [26:0]   _zz_flagUF_97;
  reg                 _zz_flagUF_98;
  wire                when_FpUnit_l147_6;
  wire                when_FpUnit_l150_6;
  wire       [11:0]   _zz_when_FpUnit_l186_18;
  wire                _zz_flagUF_99;
  wire                _zz_flagUF_100;
  wire                _zz_flagUF_101;
  wire       [23:0]   _zz_when_FpUnit_l190_18;
  wire       [24:0]   _zz_when_FpUnit_l190_19;
  wire                _zz_when_FpUnit_l186_19;
  wire       [23:0]   _zz_when_FpUnit_l190_20;
  wire       [11:0]   _zz_when_FpUnit_l186_20;
  wire                _zz_flagUF_102;
  wire                when_FpUnit_l186_6;
  wire       [31:0]   _zz_res_41;
  wire       [31:0]   _zz_res_42;
  reg        [31:0]   _zz_res_43;
  wire                when_FpUnit_l190_6;
  wire                when_FpUnit_l192_6;
  reg        [31:0]   _zz_res_44;
  wire                when_FpUnit_l395_1;
  wire                when_FpUnit_l396_1;
  wire                when_FpUnit_l397_1;
  wire                when_FpUnit_l398_1;
  wire                _zz_when_FpUnit_l397_5;
  wire                _zz_when_FpUnit_l397_6;
  wire       [47:0]   _zz_when_FpUnit_l88_152;
  wire       [11:0]   _zz_when_FpUnit_l367_12;
  wire       [11:0]   _zz_when_FpUnit_l367_13;
  wire       [11:0]   _zz_when_FpUnit_l367_14;
  wire       [11:0]   _zz_when_FpUnit_l367_15;
  wire       [11:0]   _zz_when_FpUnit_l368_4;
  reg        [53:0]   _zz_when_FpUnit_l88_153;
  reg                 _zz_flagUF_103;
  wire                when_FpUnit_l367_4;
  wire                when_FpUnit_l368_4;
  wire       [11:0]   _zz_when_FpUnit_l367_16;
  wire       [11:0]   _zz_when_FpUnit_l368_5;
  reg        [53:0]   _zz_when_FpUnit_l88_154;
  reg                 _zz_flagUF_104;
  wire                when_FpUnit_l367_5;
  wire                when_FpUnit_l368_5;
  wire       [54:0]   _zz_when_FpUnit_l88_155;
  wire       [54:0]   _zz_when_FpUnit_l88_156;
  wire       [55:0]   _zz_when_FpUnit_l88_157;
  wire                _zz_when_FpUnit_l88_158;
  wire       [55:0]   _zz_when_FpUnit_l88_159;
  reg        [5:0]    _zz_when_FpUnit_l95_7;
  wire                when_FpUnit_l88_275;
  wire                when_FpUnit_l88_276;
  wire                when_FpUnit_l88_277;
  wire                when_FpUnit_l88_278;
  wire                when_FpUnit_l88_279;
  wire                when_FpUnit_l88_280;
  wire                when_FpUnit_l88_281;
  wire                when_FpUnit_l88_282;
  wire                when_FpUnit_l88_283;
  wire                when_FpUnit_l88_284;
  wire                when_FpUnit_l88_285;
  wire                when_FpUnit_l88_286;
  wire                when_FpUnit_l88_287;
  wire                when_FpUnit_l88_288;
  wire                when_FpUnit_l88_289;
  wire                when_FpUnit_l88_290;
  wire                when_FpUnit_l88_291;
  wire                when_FpUnit_l88_292;
  wire                when_FpUnit_l88_293;
  wire                when_FpUnit_l88_294;
  wire                when_FpUnit_l88_295;
  wire                when_FpUnit_l88_296;
  wire                when_FpUnit_l88_297;
  wire                when_FpUnit_l88_298;
  wire                when_FpUnit_l88_299;
  wire                when_FpUnit_l88_300;
  wire                when_FpUnit_l88_301;
  wire                when_FpUnit_l88_302;
  wire                when_FpUnit_l88_303;
  wire                when_FpUnit_l88_304;
  wire                when_FpUnit_l88_305;
  wire                when_FpUnit_l88_306;
  wire                when_FpUnit_l88_307;
  wire                when_FpUnit_l88_308;
  wire                when_FpUnit_l88_309;
  wire                when_FpUnit_l88_310;
  wire                when_FpUnit_l88_311;
  wire                when_FpUnit_l88_312;
  wire                when_FpUnit_l88_313;
  wire                when_FpUnit_l88_314;
  wire                when_FpUnit_l88_315;
  wire                when_FpUnit_l88_316;
  wire                when_FpUnit_l88_317;
  wire                when_FpUnit_l88_318;
  wire                when_FpUnit_l88_319;
  wire                when_FpUnit_l88_320;
  wire                when_FpUnit_l88_321;
  wire                when_FpUnit_l88_322;
  wire                when_FpUnit_l88_323;
  wire                when_FpUnit_l88_324;
  wire                when_FpUnit_l88_325;
  wire                when_FpUnit_l88_326;
  wire                when_FpUnit_l88_327;
  wire                when_FpUnit_l88_328;
  wire                when_FpUnit_l88_329;
  wire                when_FpUnit_l88_330;
  reg        [26:0]   _zz_flagUF_105;
  reg                 _zz_flagUF_106;
  wire       [11:0]   _zz_flagUF_107;
  wire                when_FpUnit_l94_7;
  wire                when_FpUnit_l95_7;
  wire       [5:0]    _zz_flagUF_108;
  wire       [28:0]   _zz_flagUF_109;
  wire       [28:0]   _zz_flagUF_110;
  wire                _zz_flagUF_111;
  wire                _zz_flagUF_112;
  wire       [11:0]   _zz_when_FpUnit_l147_7;
  wire       [11:0]   _zz_when_FpUnit_l150_7;
  reg        [26:0]   _zz_flagUF_113;
  reg                 _zz_flagUF_114;
  wire                when_FpUnit_l147_7;
  wire                when_FpUnit_l150_7;
  wire       [11:0]   _zz_when_FpUnit_l186_21;
  wire                _zz_flagUF_115;
  wire                _zz_flagUF_116;
  wire                _zz_flagUF_117;
  wire       [23:0]   _zz_when_FpUnit_l190_21;
  wire       [24:0]   _zz_when_FpUnit_l190_22;
  wire                _zz_when_FpUnit_l186_22;
  wire       [23:0]   _zz_when_FpUnit_l190_23;
  wire       [11:0]   _zz_when_FpUnit_l186_23;
  wire                _zz_flagUF_118;
  wire                when_FpUnit_l186_7;
  wire       [31:0]   _zz_res_45;
  wire       [31:0]   _zz_res_46;
  reg        [31:0]   _zz_res_47;
  wire                when_FpUnit_l190_7;
  wire                when_FpUnit_l192_7;
  reg        [31:0]   _zz_res_48;
  wire                when_FpUnit_l395_2;
  wire                when_FpUnit_l396_2;
  wire                when_FpUnit_l397_2;
  wire                when_FpUnit_l398_2;
  wire                _zz_when_FpUnit_l397_7;
  wire                _zz_when_FpUnit_l397_8;
  wire       [47:0]   _zz_when_FpUnit_l88_160;
  wire       [11:0]   _zz_when_FpUnit_l367_17;
  wire       [11:0]   _zz_when_FpUnit_l367_18;
  wire       [11:0]   _zz_when_FpUnit_l367_19;
  wire       [11:0]   _zz_when_FpUnit_l367_20;
  wire       [11:0]   _zz_when_FpUnit_l368_6;
  reg        [53:0]   _zz_when_FpUnit_l88_161;
  reg                 _zz_flagUF_119;
  wire                when_FpUnit_l367_6;
  wire                when_FpUnit_l368_6;
  wire       [11:0]   _zz_when_FpUnit_l367_21;
  wire       [11:0]   _zz_when_FpUnit_l368_7;
  reg        [53:0]   _zz_when_FpUnit_l88_162;
  reg                 _zz_flagUF_120;
  wire                when_FpUnit_l367_7;
  wire                when_FpUnit_l368_7;
  wire       [54:0]   _zz_when_FpUnit_l88_163;
  wire       [54:0]   _zz_when_FpUnit_l88_164;
  wire       [55:0]   _zz_when_FpUnit_l88_165;
  wire                _zz_when_FpUnit_l88_166;
  wire       [55:0]   _zz_when_FpUnit_l88_167;
  reg        [5:0]    _zz_when_FpUnit_l95_8;
  wire                when_FpUnit_l88_331;
  wire                when_FpUnit_l88_332;
  wire                when_FpUnit_l88_333;
  wire                when_FpUnit_l88_334;
  wire                when_FpUnit_l88_335;
  wire                when_FpUnit_l88_336;
  wire                when_FpUnit_l88_337;
  wire                when_FpUnit_l88_338;
  wire                when_FpUnit_l88_339;
  wire                when_FpUnit_l88_340;
  wire                when_FpUnit_l88_341;
  wire                when_FpUnit_l88_342;
  wire                when_FpUnit_l88_343;
  wire                when_FpUnit_l88_344;
  wire                when_FpUnit_l88_345;
  wire                when_FpUnit_l88_346;
  wire                when_FpUnit_l88_347;
  wire                when_FpUnit_l88_348;
  wire                when_FpUnit_l88_349;
  wire                when_FpUnit_l88_350;
  wire                when_FpUnit_l88_351;
  wire                when_FpUnit_l88_352;
  wire                when_FpUnit_l88_353;
  wire                when_FpUnit_l88_354;
  wire                when_FpUnit_l88_355;
  wire                when_FpUnit_l88_356;
  wire                when_FpUnit_l88_357;
  wire                when_FpUnit_l88_358;
  wire                when_FpUnit_l88_359;
  wire                when_FpUnit_l88_360;
  wire                when_FpUnit_l88_361;
  wire                when_FpUnit_l88_362;
  wire                when_FpUnit_l88_363;
  wire                when_FpUnit_l88_364;
  wire                when_FpUnit_l88_365;
  wire                when_FpUnit_l88_366;
  wire                when_FpUnit_l88_367;
  wire                when_FpUnit_l88_368;
  wire                when_FpUnit_l88_369;
  wire                when_FpUnit_l88_370;
  wire                when_FpUnit_l88_371;
  wire                when_FpUnit_l88_372;
  wire                when_FpUnit_l88_373;
  wire                when_FpUnit_l88_374;
  wire                when_FpUnit_l88_375;
  wire                when_FpUnit_l88_376;
  wire                when_FpUnit_l88_377;
  wire                when_FpUnit_l88_378;
  wire                when_FpUnit_l88_379;
  wire                when_FpUnit_l88_380;
  wire                when_FpUnit_l88_381;
  wire                when_FpUnit_l88_382;
  wire                when_FpUnit_l88_383;
  wire                when_FpUnit_l88_384;
  wire                when_FpUnit_l88_385;
  wire                when_FpUnit_l88_386;
  reg        [26:0]   _zz_flagUF_121;
  reg                 _zz_flagUF_122;
  wire       [11:0]   _zz_flagUF_123;
  wire                when_FpUnit_l94_8;
  wire                when_FpUnit_l95_8;
  wire       [5:0]    _zz_flagUF_124;
  wire       [28:0]   _zz_flagUF_125;
  wire       [28:0]   _zz_flagUF_126;
  wire                _zz_flagUF_127;
  wire                _zz_flagUF_128;
  wire       [11:0]   _zz_when_FpUnit_l147_8;
  wire       [11:0]   _zz_when_FpUnit_l150_8;
  reg        [26:0]   _zz_flagUF_129;
  reg                 _zz_flagUF_130;
  wire                when_FpUnit_l147_8;
  wire                when_FpUnit_l150_8;
  wire       [11:0]   _zz_when_FpUnit_l186_24;
  wire                _zz_flagUF_131;
  wire                _zz_flagUF_132;
  wire                _zz_flagUF_133;
  wire       [23:0]   _zz_when_FpUnit_l190_24;
  wire       [24:0]   _zz_when_FpUnit_l190_25;
  wire                _zz_when_FpUnit_l186_25;
  wire       [23:0]   _zz_when_FpUnit_l190_26;
  wire       [11:0]   _zz_when_FpUnit_l186_26;
  wire                _zz_flagUF_134;
  wire                when_FpUnit_l186_8;
  wire       [31:0]   _zz_res_49;
  wire       [31:0]   _zz_res_50;
  reg        [31:0]   _zz_res_51;
  wire                when_FpUnit_l190_8;
  wire                when_FpUnit_l192_8;
  reg        [31:0]   _zz_res_52;
  wire                when_FpUnit_l395_3;
  wire                when_FpUnit_l396_3;
  wire                when_FpUnit_l397_3;
  wire                when_FpUnit_l398_3;
  wire       [11:0]   _zz_when_FpUnit_l485;
  reg        [33:0]   _zz_when_FpUnit_l512;
  reg                 _zz_flagNX;
  wire                when_FpUnit_l485;
  wire       [11:0]   _zz_flagNX_1;
  wire                when_FpUnit_l488;
  wire                when_FpUnit_l491;
  wire       [33:0]   _zz_when_FpUnit_l512_1;
  wire                when_FpUnit_l512;
  reg        [31:0]   _zz_res_53;
  wire                when_FpUnit_l517;
  wire       [11:0]   _zz_when_FpUnit_l485_1;
  reg        [33:0]   _zz_when_FpUnit_l512_2;
  reg                 _zz_flagNX_2;
  wire                when_FpUnit_l485_1;
  wire       [11:0]   _zz_flagNX_3;
  wire                when_FpUnit_l488_1;
  wire                when_FpUnit_l491_1;
  wire       [33:0]   _zz_when_FpUnit_l512_3;
  wire                when_FpUnit_l512_1;
  reg        [31:0]   _zz_res_54;
  wire                when_FpUnit_l517_1;
  wire       [11:0]   _zz_when_FpUnit_l485_2;
  reg        [65:0]   _zz_when_FpUnit_l512_4;
  reg                 _zz_flagNX_4;
  wire                when_FpUnit_l485_2;
  wire       [11:0]   _zz_flagNX_5;
  wire                when_FpUnit_l488_2;
  wire                when_FpUnit_l491_2;
  wire       [65:0]   _zz_when_FpUnit_l512_5;
  wire                when_FpUnit_l512_2;
  reg        [63:0]   _zz_res_55;
  wire                when_FpUnit_l517_2;
  wire       [11:0]   _zz_when_FpUnit_l485_3;
  reg        [65:0]   _zz_when_FpUnit_l512_6;
  reg                 _zz_flagNX_6;
  wire                when_FpUnit_l485_3;
  wire       [11:0]   _zz_flagNX_7;
  wire                when_FpUnit_l488_3;
  wire                when_FpUnit_l491_3;
  wire       [65:0]   _zz_when_FpUnit_l512_7;
  wire                when_FpUnit_l512_3;
  reg        [63:0]   _zz_res_56;
  wire                when_FpUnit_l517_3;
  wire                _zz_res_57;
  wire       [31:0]   _zz_when_FpUnit_l88_168;
  wire       [55:0]   _zz_when_FpUnit_l88_169;
  reg        [5:0]    _zz_when_FpUnit_l95_9;
  wire                when_FpUnit_l88_387;
  wire                when_FpUnit_l88_388;
  wire                when_FpUnit_l88_389;
  wire                when_FpUnit_l88_390;
  wire                when_FpUnit_l88_391;
  wire                when_FpUnit_l88_392;
  wire                when_FpUnit_l88_393;
  wire                when_FpUnit_l88_394;
  wire                when_FpUnit_l88_395;
  wire                when_FpUnit_l88_396;
  wire                when_FpUnit_l88_397;
  wire                when_FpUnit_l88_398;
  wire                when_FpUnit_l88_399;
  wire                when_FpUnit_l88_400;
  wire                when_FpUnit_l88_401;
  wire                when_FpUnit_l88_402;
  wire                when_FpUnit_l88_403;
  wire                when_FpUnit_l88_404;
  wire                when_FpUnit_l88_405;
  wire                when_FpUnit_l88_406;
  wire                when_FpUnit_l88_407;
  wire                when_FpUnit_l88_408;
  wire                when_FpUnit_l88_409;
  wire                when_FpUnit_l88_410;
  wire                when_FpUnit_l88_411;
  wire                when_FpUnit_l88_412;
  wire                when_FpUnit_l88_413;
  wire                when_FpUnit_l88_414;
  wire                when_FpUnit_l88_415;
  wire                when_FpUnit_l88_416;
  wire                when_FpUnit_l88_417;
  wire                when_FpUnit_l88_418;
  wire                when_FpUnit_l88_419;
  wire                when_FpUnit_l88_420;
  wire                when_FpUnit_l88_421;
  wire                when_FpUnit_l88_422;
  wire                when_FpUnit_l88_423;
  wire                when_FpUnit_l88_424;
  wire                when_FpUnit_l88_425;
  wire                when_FpUnit_l88_426;
  wire                when_FpUnit_l88_427;
  wire                when_FpUnit_l88_428;
  wire                when_FpUnit_l88_429;
  wire                when_FpUnit_l88_430;
  wire                when_FpUnit_l88_431;
  wire                when_FpUnit_l88_432;
  wire                when_FpUnit_l88_433;
  wire                when_FpUnit_l88_434;
  wire                when_FpUnit_l88_435;
  wire                when_FpUnit_l88_436;
  wire                when_FpUnit_l88_437;
  wire                when_FpUnit_l88_438;
  wire                when_FpUnit_l88_439;
  wire                when_FpUnit_l88_440;
  wire                when_FpUnit_l88_441;
  wire                when_FpUnit_l88_442;
  reg        [26:0]   _zz_flagNX_8;
  reg                 _zz_flagNX_9;
  wire       [11:0]   _zz_when_FpUnit_l147_9;
  wire                when_FpUnit_l94_9;
  wire                when_FpUnit_l95_9;
  wire       [5:0]    _zz_flagNX_10;
  wire       [28:0]   _zz_flagNX_11;
  wire       [28:0]   _zz_flagNX_12;
  wire                _zz_flagNX_13;
  wire                _zz_when_FpUnit_l190_27;
  wire       [11:0]   _zz_when_FpUnit_l147_10;
  wire       [11:0]   _zz_when_FpUnit_l150_9;
  reg        [26:0]   _zz_flagNX_14;
  reg                 _zz_flagNX_15;
  wire                when_FpUnit_l147_9;
  wire                when_FpUnit_l150_9;
  wire       [11:0]   _zz_when_FpUnit_l186_27;
  wire                _zz_flagNX_16;
  wire                _zz_flagNX_17;
  wire                _zz_flagNX_18;
  wire       [23:0]   _zz_when_FpUnit_l190_28;
  wire       [24:0]   _zz_when_FpUnit_l190_29;
  wire                _zz_when_FpUnit_l186_28;
  wire       [23:0]   _zz_when_FpUnit_l190_30;
  wire       [11:0]   _zz_when_FpUnit_l186_29;
  wire                when_FpUnit_l186_9;
  wire       [31:0]   _zz_res_58;
  wire       [31:0]   _zz_res_59;
  reg        [31:0]   _zz_res_60;
  wire                when_FpUnit_l190_9;
  wire                when_FpUnit_l192_9;
  reg        [31:0]   _zz_res_61;
  wire                when_FpUnit_l536;
  wire                _zz_res_62;
  wire       [31:0]   _zz_when_FpUnit_l88_170;
  wire       [55:0]   _zz_when_FpUnit_l88_171;
  reg        [5:0]    _zz_when_FpUnit_l95_10;
  wire                when_FpUnit_l88_443;
  wire                when_FpUnit_l88_444;
  wire                when_FpUnit_l88_445;
  wire                when_FpUnit_l88_446;
  wire                when_FpUnit_l88_447;
  wire                when_FpUnit_l88_448;
  wire                when_FpUnit_l88_449;
  wire                when_FpUnit_l88_450;
  wire                when_FpUnit_l88_451;
  wire                when_FpUnit_l88_452;
  wire                when_FpUnit_l88_453;
  wire                when_FpUnit_l88_454;
  wire                when_FpUnit_l88_455;
  wire                when_FpUnit_l88_456;
  wire                when_FpUnit_l88_457;
  wire                when_FpUnit_l88_458;
  wire                when_FpUnit_l88_459;
  wire                when_FpUnit_l88_460;
  wire                when_FpUnit_l88_461;
  wire                when_FpUnit_l88_462;
  wire                when_FpUnit_l88_463;
  wire                when_FpUnit_l88_464;
  wire                when_FpUnit_l88_465;
  wire                when_FpUnit_l88_466;
  wire                when_FpUnit_l88_467;
  wire                when_FpUnit_l88_468;
  wire                when_FpUnit_l88_469;
  wire                when_FpUnit_l88_470;
  wire                when_FpUnit_l88_471;
  wire                when_FpUnit_l88_472;
  wire                when_FpUnit_l88_473;
  wire                when_FpUnit_l88_474;
  wire                when_FpUnit_l88_475;
  wire                when_FpUnit_l88_476;
  wire                when_FpUnit_l88_477;
  wire                when_FpUnit_l88_478;
  wire                when_FpUnit_l88_479;
  wire                when_FpUnit_l88_480;
  wire                when_FpUnit_l88_481;
  wire                when_FpUnit_l88_482;
  wire                when_FpUnit_l88_483;
  wire                when_FpUnit_l88_484;
  wire                when_FpUnit_l88_485;
  wire                when_FpUnit_l88_486;
  wire                when_FpUnit_l88_487;
  wire                when_FpUnit_l88_488;
  wire                when_FpUnit_l88_489;
  wire                when_FpUnit_l88_490;
  wire                when_FpUnit_l88_491;
  wire                when_FpUnit_l88_492;
  wire                when_FpUnit_l88_493;
  wire                when_FpUnit_l88_494;
  wire                when_FpUnit_l88_495;
  wire                when_FpUnit_l88_496;
  wire                when_FpUnit_l88_497;
  wire                when_FpUnit_l88_498;
  reg        [26:0]   _zz_flagNX_19;
  reg                 _zz_flagNX_20;
  wire       [11:0]   _zz_when_FpUnit_l147_11;
  wire                when_FpUnit_l94_10;
  wire                when_FpUnit_l95_10;
  wire       [5:0]    _zz_flagNX_21;
  wire       [28:0]   _zz_flagNX_22;
  wire       [28:0]   _zz_flagNX_23;
  wire                _zz_flagNX_24;
  wire                _zz_when_FpUnit_l190_31;
  wire       [11:0]   _zz_when_FpUnit_l147_12;
  wire       [11:0]   _zz_when_FpUnit_l150_10;
  reg        [26:0]   _zz_flagNX_25;
  reg                 _zz_flagNX_26;
  wire                when_FpUnit_l147_10;
  wire                when_FpUnit_l150_10;
  wire       [11:0]   _zz_when_FpUnit_l186_30;
  wire                _zz_flagNX_27;
  wire                _zz_flagNX_28;
  wire                _zz_flagNX_29;
  wire       [23:0]   _zz_when_FpUnit_l190_32;
  wire       [24:0]   _zz_when_FpUnit_l190_33;
  wire                _zz_when_FpUnit_l186_31;
  wire       [23:0]   _zz_when_FpUnit_l190_34;
  wire       [11:0]   _zz_when_FpUnit_l186_32;
  wire                when_FpUnit_l186_10;
  wire       [31:0]   _zz_res_63;
  wire       [31:0]   _zz_res_64;
  reg        [31:0]   _zz_res_65;
  wire                when_FpUnit_l190_10;
  wire                when_FpUnit_l192_10;
  reg        [31:0]   _zz_res_66;
  wire                when_FpUnit_l536_1;
  wire                _zz_res_67;
  wire       [63:0]   _zz_when_FpUnit_l88_172;
  wire       [87:0]   _zz_when_FpUnit_l88_173;
  reg        [6:0]    _zz_when_FpUnit_l95_11;
  wire                when_FpUnit_l88_499;
  wire                when_FpUnit_l88_500;
  wire                when_FpUnit_l88_501;
  wire                when_FpUnit_l88_502;
  wire                when_FpUnit_l88_503;
  wire                when_FpUnit_l88_504;
  wire                when_FpUnit_l88_505;
  wire                when_FpUnit_l88_506;
  wire                when_FpUnit_l88_507;
  wire                when_FpUnit_l88_508;
  wire                when_FpUnit_l88_509;
  wire                when_FpUnit_l88_510;
  wire                when_FpUnit_l88_511;
  wire                when_FpUnit_l88_512;
  wire                when_FpUnit_l88_513;
  wire                when_FpUnit_l88_514;
  wire                when_FpUnit_l88_515;
  wire                when_FpUnit_l88_516;
  wire                when_FpUnit_l88_517;
  wire                when_FpUnit_l88_518;
  wire                when_FpUnit_l88_519;
  wire                when_FpUnit_l88_520;
  wire                when_FpUnit_l88_521;
  wire                when_FpUnit_l88_522;
  wire                when_FpUnit_l88_523;
  wire                when_FpUnit_l88_524;
  wire                when_FpUnit_l88_525;
  wire                when_FpUnit_l88_526;
  wire                when_FpUnit_l88_527;
  wire                when_FpUnit_l88_528;
  wire                when_FpUnit_l88_529;
  wire                when_FpUnit_l88_530;
  wire                when_FpUnit_l88_531;
  wire                when_FpUnit_l88_532;
  wire                when_FpUnit_l88_533;
  wire                when_FpUnit_l88_534;
  wire                when_FpUnit_l88_535;
  wire                when_FpUnit_l88_536;
  wire                when_FpUnit_l88_537;
  wire                when_FpUnit_l88_538;
  wire                when_FpUnit_l88_539;
  wire                when_FpUnit_l88_540;
  wire                when_FpUnit_l88_541;
  wire                when_FpUnit_l88_542;
  wire                when_FpUnit_l88_543;
  wire                when_FpUnit_l88_544;
  wire                when_FpUnit_l88_545;
  wire                when_FpUnit_l88_546;
  wire                when_FpUnit_l88_547;
  wire                when_FpUnit_l88_548;
  wire                when_FpUnit_l88_549;
  wire                when_FpUnit_l88_550;
  wire                when_FpUnit_l88_551;
  wire                when_FpUnit_l88_552;
  wire                when_FpUnit_l88_553;
  wire                when_FpUnit_l88_554;
  wire                when_FpUnit_l88_555;
  wire                when_FpUnit_l88_556;
  wire                when_FpUnit_l88_557;
  wire                when_FpUnit_l88_558;
  wire                when_FpUnit_l88_559;
  wire                when_FpUnit_l88_560;
  wire                when_FpUnit_l88_561;
  wire                when_FpUnit_l88_562;
  wire                when_FpUnit_l88_563;
  wire                when_FpUnit_l88_564;
  wire                when_FpUnit_l88_565;
  wire                when_FpUnit_l88_566;
  wire                when_FpUnit_l88_567;
  wire                when_FpUnit_l88_568;
  wire                when_FpUnit_l88_569;
  wire                when_FpUnit_l88_570;
  wire                when_FpUnit_l88_571;
  wire                when_FpUnit_l88_572;
  wire                when_FpUnit_l88_573;
  wire                when_FpUnit_l88_574;
  wire                when_FpUnit_l88_575;
  wire                when_FpUnit_l88_576;
  wire                when_FpUnit_l88_577;
  wire                when_FpUnit_l88_578;
  wire                when_FpUnit_l88_579;
  wire                when_FpUnit_l88_580;
  wire                when_FpUnit_l88_581;
  wire                when_FpUnit_l88_582;
  wire                when_FpUnit_l88_583;
  wire                when_FpUnit_l88_584;
  wire                when_FpUnit_l88_585;
  wire                when_FpUnit_l88_586;
  reg        [26:0]   _zz_flagNX_30;
  reg                 _zz_flagNX_31;
  wire       [11:0]   _zz_when_FpUnit_l147_13;
  wire                when_FpUnit_l94_11;
  wire                when_FpUnit_l95_11;
  wire       [6:0]    _zz_flagNX_32;
  wire       [28:0]   _zz_flagNX_33;
  wire       [28:0]   _zz_flagNX_34;
  wire                _zz_flagNX_35;
  wire                _zz_when_FpUnit_l190_35;
  wire       [11:0]   _zz_when_FpUnit_l147_14;
  wire       [11:0]   _zz_when_FpUnit_l150_11;
  reg        [26:0]   _zz_flagNX_36;
  reg                 _zz_flagNX_37;
  wire                when_FpUnit_l147_11;
  wire                when_FpUnit_l150_11;
  wire       [11:0]   _zz_when_FpUnit_l186_33;
  wire                _zz_flagNX_38;
  wire                _zz_flagNX_39;
  wire                _zz_flagNX_40;
  wire       [23:0]   _zz_when_FpUnit_l190_36;
  wire       [24:0]   _zz_when_FpUnit_l190_37;
  wire                _zz_when_FpUnit_l186_34;
  wire       [23:0]   _zz_when_FpUnit_l190_38;
  wire       [11:0]   _zz_when_FpUnit_l186_35;
  wire                when_FpUnit_l186_11;
  wire       [31:0]   _zz_res_68;
  wire       [31:0]   _zz_res_69;
  reg        [31:0]   _zz_res_70;
  wire                when_FpUnit_l190_11;
  wire                when_FpUnit_l192_11;
  reg        [31:0]   _zz_res_71;
  wire                when_FpUnit_l536_2;
  wire                _zz_res_72;
  wire       [63:0]   _zz_when_FpUnit_l88_174;
  wire       [87:0]   _zz_when_FpUnit_l88_175;
  reg        [6:0]    _zz_when_FpUnit_l95_12;
  wire                when_FpUnit_l88_587;
  wire                when_FpUnit_l88_588;
  wire                when_FpUnit_l88_589;
  wire                when_FpUnit_l88_590;
  wire                when_FpUnit_l88_591;
  wire                when_FpUnit_l88_592;
  wire                when_FpUnit_l88_593;
  wire                when_FpUnit_l88_594;
  wire                when_FpUnit_l88_595;
  wire                when_FpUnit_l88_596;
  wire                when_FpUnit_l88_597;
  wire                when_FpUnit_l88_598;
  wire                when_FpUnit_l88_599;
  wire                when_FpUnit_l88_600;
  wire                when_FpUnit_l88_601;
  wire                when_FpUnit_l88_602;
  wire                when_FpUnit_l88_603;
  wire                when_FpUnit_l88_604;
  wire                when_FpUnit_l88_605;
  wire                when_FpUnit_l88_606;
  wire                when_FpUnit_l88_607;
  wire                when_FpUnit_l88_608;
  wire                when_FpUnit_l88_609;
  wire                when_FpUnit_l88_610;
  wire                when_FpUnit_l88_611;
  wire                when_FpUnit_l88_612;
  wire                when_FpUnit_l88_613;
  wire                when_FpUnit_l88_614;
  wire                when_FpUnit_l88_615;
  wire                when_FpUnit_l88_616;
  wire                when_FpUnit_l88_617;
  wire                when_FpUnit_l88_618;
  wire                when_FpUnit_l88_619;
  wire                when_FpUnit_l88_620;
  wire                when_FpUnit_l88_621;
  wire                when_FpUnit_l88_622;
  wire                when_FpUnit_l88_623;
  wire                when_FpUnit_l88_624;
  wire                when_FpUnit_l88_625;
  wire                when_FpUnit_l88_626;
  wire                when_FpUnit_l88_627;
  wire                when_FpUnit_l88_628;
  wire                when_FpUnit_l88_629;
  wire                when_FpUnit_l88_630;
  wire                when_FpUnit_l88_631;
  wire                when_FpUnit_l88_632;
  wire                when_FpUnit_l88_633;
  wire                when_FpUnit_l88_634;
  wire                when_FpUnit_l88_635;
  wire                when_FpUnit_l88_636;
  wire                when_FpUnit_l88_637;
  wire                when_FpUnit_l88_638;
  wire                when_FpUnit_l88_639;
  wire                when_FpUnit_l88_640;
  wire                when_FpUnit_l88_641;
  wire                when_FpUnit_l88_642;
  wire                when_FpUnit_l88_643;
  wire                when_FpUnit_l88_644;
  wire                when_FpUnit_l88_645;
  wire                when_FpUnit_l88_646;
  wire                when_FpUnit_l88_647;
  wire                when_FpUnit_l88_648;
  wire                when_FpUnit_l88_649;
  wire                when_FpUnit_l88_650;
  wire                when_FpUnit_l88_651;
  wire                when_FpUnit_l88_652;
  wire                when_FpUnit_l88_653;
  wire                when_FpUnit_l88_654;
  wire                when_FpUnit_l88_655;
  wire                when_FpUnit_l88_656;
  wire                when_FpUnit_l88_657;
  wire                when_FpUnit_l88_658;
  wire                when_FpUnit_l88_659;
  wire                when_FpUnit_l88_660;
  wire                when_FpUnit_l88_661;
  wire                when_FpUnit_l88_662;
  wire                when_FpUnit_l88_663;
  wire                when_FpUnit_l88_664;
  wire                when_FpUnit_l88_665;
  wire                when_FpUnit_l88_666;
  wire                when_FpUnit_l88_667;
  wire                when_FpUnit_l88_668;
  wire                when_FpUnit_l88_669;
  wire                when_FpUnit_l88_670;
  wire                when_FpUnit_l88_671;
  wire                when_FpUnit_l88_672;
  wire                when_FpUnit_l88_673;
  wire                when_FpUnit_l88_674;
  reg        [26:0]   _zz_flagNX_41;
  reg                 _zz_flagNX_42;
  wire       [11:0]   _zz_when_FpUnit_l147_15;
  wire                when_FpUnit_l94_12;
  wire                when_FpUnit_l95_12;
  wire       [6:0]    _zz_flagNX_43;
  wire       [28:0]   _zz_flagNX_44;
  wire       [28:0]   _zz_flagNX_45;
  wire                _zz_flagNX_46;
  wire                _zz_when_FpUnit_l190_39;
  wire       [11:0]   _zz_when_FpUnit_l147_16;
  wire       [11:0]   _zz_when_FpUnit_l150_12;
  reg        [26:0]   _zz_flagNX_47;
  reg                 _zz_flagNX_48;
  wire                when_FpUnit_l147_12;
  wire                when_FpUnit_l150_12;
  wire       [11:0]   _zz_when_FpUnit_l186_36;
  wire                _zz_flagNX_49;
  wire                _zz_flagNX_50;
  wire                _zz_flagNX_51;
  wire       [23:0]   _zz_when_FpUnit_l190_40;
  wire       [24:0]   _zz_when_FpUnit_l190_41;
  wire                _zz_when_FpUnit_l186_37;
  wire       [23:0]   _zz_when_FpUnit_l190_42;
  wire       [11:0]   _zz_when_FpUnit_l186_38;
  wire                when_FpUnit_l186_12;
  wire       [31:0]   _zz_res_73;
  wire       [31:0]   _zz_res_74;
  reg        [31:0]   _zz_res_75;
  wire                when_FpUnit_l190_12;
  wire                when_FpUnit_l192_12;
  reg        [31:0]   _zz_res_76;
  wire                when_FpUnit_l536_3;
  reg        [4:0]    _zz_when_FpUnit_l95_13;
  wire                when_FpUnit_l88_675;
  wire                when_FpUnit_l88_676;
  wire                when_FpUnit_l88_677;
  wire                when_FpUnit_l88_678;
  wire                when_FpUnit_l88_679;
  wire                when_FpUnit_l88_680;
  wire                when_FpUnit_l88_681;
  wire                when_FpUnit_l88_682;
  wire                when_FpUnit_l88_683;
  wire                when_FpUnit_l88_684;
  wire                when_FpUnit_l88_685;
  wire                when_FpUnit_l88_686;
  wire                when_FpUnit_l88_687;
  wire                when_FpUnit_l88_688;
  wire                when_FpUnit_l88_689;
  wire                when_FpUnit_l88_690;
  wire                when_FpUnit_l88_691;
  wire                when_FpUnit_l88_692;
  wire                when_FpUnit_l88_693;
  wire                when_FpUnit_l88_694;
  wire                when_FpUnit_l88_695;
  wire                when_FpUnit_l88_696;
  wire                when_FpUnit_l88_697;
  wire                when_FpUnit_l88_698;
  reg        [26:0]   _zz_flagUF_135;
  reg                 _zz_flagUF_136;
  wire       [11:0]   _zz_flagUF_137;
  wire                when_FpUnit_l94_13;
  wire                when_FpUnit_l95_13;
  wire       [4:0]    _zz_flagUF_138;
  wire       [28:0]   _zz_flagUF_139;
  wire       [28:0]   _zz_flagUF_140;
  wire                _zz_flagUF_141;
  wire                _zz_flagUF_142;
  wire       [11:0]   _zz_when_FpUnit_l147_17;
  wire       [11:0]   _zz_when_FpUnit_l150_13;
  reg        [26:0]   _zz_flagUF_143;
  reg                 _zz_flagUF_144;
  wire                when_FpUnit_l147_13;
  wire                when_FpUnit_l150_13;
  wire       [11:0]   _zz_when_FpUnit_l186_39;
  wire                _zz_flagUF_145;
  wire                _zz_flagUF_146;
  wire                _zz_flagUF_147;
  wire       [23:0]   _zz_when_FpUnit_l190_43;
  wire       [24:0]   _zz_when_FpUnit_l190_44;
  wire                _zz_when_FpUnit_l186_40;
  wire       [23:0]   _zz_when_FpUnit_l190_45;
  wire       [11:0]   _zz_when_FpUnit_l186_41;
  wire                _zz_flagUF_148;
  wire                when_FpUnit_l186_13;
  wire       [31:0]   _zz_res_77;
  wire       [31:0]   _zz_res_78;
  reg        [31:0]   _zz_res_79;
  wire                when_FpUnit_l190_13;
  wire                when_FpUnit_l192_13;
  reg        [31:0]   _zz_res_80;
  wire                _zz_res_81;
  wire       [7:0]    _zz_when_FpUnit_l563;
  wire       [22:0]   _zz_flagNV_3;
  wire                when_FpUnit_l563;
  wire                when_FpUnit_l562;
  wire                when_FpUnit_l561;
  wire                _zz_when_FpUnit_l88_176;
  wire       [23:0]   _zz_when_FpUnit_l88_177;
  reg        [4:0]    _zz_when_FpUnit_l95_14;
  wire                when_FpUnit_l88_699;
  wire                when_FpUnit_l88_700;
  wire                when_FpUnit_l88_701;
  wire                when_FpUnit_l88_702;
  wire                when_FpUnit_l88_703;
  wire                when_FpUnit_l88_704;
  wire                when_FpUnit_l88_705;
  wire                when_FpUnit_l88_706;
  wire                when_FpUnit_l88_707;
  wire                when_FpUnit_l88_708;
  wire                when_FpUnit_l88_709;
  wire                when_FpUnit_l88_710;
  wire                when_FpUnit_l88_711;
  wire                when_FpUnit_l88_712;
  wire                when_FpUnit_l88_713;
  wire                when_FpUnit_l88_714;
  wire                when_FpUnit_l88_715;
  wire                when_FpUnit_l88_716;
  wire                when_FpUnit_l88_717;
  wire                when_FpUnit_l88_718;
  wire                when_FpUnit_l88_719;
  wire                when_FpUnit_l88_720;
  wire                when_FpUnit_l88_721;
  wire                when_FpUnit_l88_722;
  reg        [26:0]   _zz_when_FpUnit_l190_46;
  reg                 _zz_when_FpUnit_l190_47;
  wire       [11:0]   _zz_when_FpUnit_l147_18;
  wire                when_FpUnit_l94_14;
  wire                when_FpUnit_l95_14;
  wire       [4:0]    _zz_when_FpUnit_l190_48;
  wire       [28:0]   _zz_when_FpUnit_l190_49;
  wire       [28:0]   _zz_when_FpUnit_l190_50;
  wire                _zz_when_FpUnit_l190_51;
  wire                _zz_when_FpUnit_l190_52;
  wire       [11:0]   _zz_when_FpUnit_l147_19;
  wire       [11:0]   _zz_when_FpUnit_l150_14;
  reg        [26:0]   _zz_when_FpUnit_l190_53;
  reg                 _zz_when_FpUnit_l190_54;
  wire                when_FpUnit_l147_14;
  wire                when_FpUnit_l150_14;
  wire       [11:0]   _zz_when_FpUnit_l186_42;
  wire                _zz_when_FpUnit_l190_55;
  wire                _zz_when_FpUnit_l190_56;
  wire                _zz_when_FpUnit_l190_57;
  wire       [23:0]   _zz_when_FpUnit_l190_58;
  wire       [24:0]   _zz_when_FpUnit_l190_59;
  wire                _zz_when_FpUnit_l186_43;
  wire       [23:0]   _zz_when_FpUnit_l190_60;
  wire       [11:0]   _zz_when_FpUnit_l186_44;
  wire                when_FpUnit_l186_14;
  wire       [31:0]   _zz_res_82;
  wire       [31:0]   _zz_res_83;
  reg        [31:0]   _zz_res_84;
  wire                when_FpUnit_l190_14;
  wire                when_FpUnit_l192_14;
  reg        [31:0]   _zz_res_85;

  assign _zz__zz_when_FpUnit_l218 = ($signed(_zz__zz_when_FpUnit_l218_1) - $signed(10'h07f));
  assign _zz__zz_when_FpUnit_l218_1 = _zz__zz_when_FpUnit_l218_2;
  assign _zz__zz_when_FpUnit_l218_3 = _zz_when_FpUnit_l308;
  assign _zz__zz_when_FpUnit_l218_2 = {2'd0, _zz__zz_when_FpUnit_l218_3};
  assign _zz__zz_when_FpUnit_l88 = {1'd0, _zz_when_FpUnit_l308_1};
  assign _zz__zz_when_FpUnit_l218_1_1 = ($signed(_zz__zz_when_FpUnit_l218_1_2) - $signed(10'h07f));
  assign _zz__zz_when_FpUnit_l218_1_2 = _zz__zz_when_FpUnit_l218_1_3;
  assign _zz__zz_when_FpUnit_l218_1_4 = _zz_when_FpUnit_l305;
  assign _zz__zz_when_FpUnit_l218_1_3 = {2'd0, _zz__zz_when_FpUnit_l218_1_4};
  assign _zz__zz_when_FpUnit_l88_1 = {1'd0, _zz_when_FpUnit_l305_1};
  assign _zz__zz_when_FpUnit_l367_1 = ($signed(_zz__zz_when_FpUnit_l367_1_1) - $signed(10'h07f));
  assign _zz__zz_when_FpUnit_l367_1_1 = _zz__zz_when_FpUnit_l367_1_2;
  assign _zz__zz_when_FpUnit_l367_1_3 = _zz_when_FpUnit_l399;
  assign _zz__zz_when_FpUnit_l367_1_2 = {2'd0, _zz__zz_when_FpUnit_l367_1_3};
  assign _zz__zz_when_FpUnit_l88_2 = {1'd0, _zz_when_FpUnit_l399_1};
  assign _zz_res_86 = 32'h7fc00000;
  assign _zz__zz_when_FpUnit_l88_5 = ({3'd0,_zz__zz_when_FpUnit_l88_5_1} <<< 2'd3);
  assign _zz__zz_when_FpUnit_l88_5_2 = (_zz_when_FpUnit_l218_2 ? _zz_when_FpUnit_l88_1 : _zz_when_FpUnit_l88);
  assign _zz__zz_when_FpUnit_l88_5_1 = {4'd0, _zz__zz_when_FpUnit_l88_5_2};
  assign _zz__zz_when_FpUnit_l218_4 = ($signed(_zz_when_FpUnit_l218_3) - $signed(_zz__zz_when_FpUnit_l218_4_1));
  assign _zz__zz_when_FpUnit_l218_4_1 = (_zz_when_FpUnit_l218_2 ? _zz_when_FpUnit_l218 : _zz_when_FpUnit_l218_1);
  assign _zz__zz_when_FpUnit_l88_6 = (_zz__zz_when_FpUnit_l88_6_1 >>> _zz_when_FpUnit_l218_4);
  assign _zz__zz_when_FpUnit_l88_6_2 = ({3'd0,_zz__zz_when_FpUnit_l88_6_3} <<< 2'd3);
  assign _zz__zz_when_FpUnit_l88_6_1 = _zz__zz_when_FpUnit_l88_6_2[27:0];
  assign _zz__zz_when_FpUnit_l88_6_4 = (_zz_when_FpUnit_l218_2 ? _zz_when_FpUnit_l88 : _zz_when_FpUnit_l88_1);
  assign _zz__zz_when_FpUnit_l88_6_3 = {4'd0, _zz__zz_when_FpUnit_l88_6_4};
  assign _zz__zz_when_FpUnit_l88_10 = (_zz_when_FpUnit_l88_8 - _zz_when_FpUnit_l88_5);
  assign _zz__zz_when_FpUnit_l88_10_1 = (_zz_when_FpUnit_l88_5 - _zz_when_FpUnit_l88_8);
  assign _zz__zz_when_FpUnit_l88_10_2 = (_zz_when_FpUnit_l88_5 + _zz_when_FpUnit_l88_8);
  assign _zz__zz_flagUF_2 = _zz__zz_flagUF_2_1;
  assign _zz__zz_flagUF_2_1 = {7'd0, _zz_when_FpUnit_l95};
  assign _zz__zz_flagUF_2_2 = ($signed(_zz__zz_flagUF_2_3) - $signed(12'h01a));
  assign _zz__zz_flagUF_2_3 = {{2{_zz_when_FpUnit_l218_3[9]}}, _zz_when_FpUnit_l218_3};
  assign _zz__zz_flagUF_1 = (_zz_when_FpUnit_l88_10 >>> _zz_flagUF_3);
  assign _zz__zz_flagUF = _zz__zz_flagUF_1[26:0];
  assign _zz__zz_flagUF_1_1 = (_zz__zz_flagUF_1_2 - 28'h0000001);
  assign _zz__zz_flagUF_1_3 = ({31'd0,28'h0000001} <<< _zz_flagUF_3);
  assign _zz__zz_flagUF_1_2 = _zz__zz_flagUF_1_3[27:0];
  assign _zz__zz_flagUF_4 = ({31'd0,_zz_when_FpUnit_l88_10} <<< _zz__zz_flagUF_5);
  assign _zz__zz_flagUF_3 = _zz__zz_flagUF_4[26:0];
  assign _zz__zz_flagUF_5 = (5'h1a - _zz_when_FpUnit_l95);
  assign _zz__zz_flagUF_4_1 = {2'd0, _zz_flagUF};
  assign _zz__zz_flagUF_7 = ($signed(_zz_flagUF_2) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l147 = ($signed(12'hf82) - $signed(_zz_flagUF_2));
  assign _zz__zz_flagUF_8 = _zz_flagUF_5[26:0];
  assign _zz__zz_flagUF_8_2 = (_zz_flagUF_5 >>> _zz__zz_flagUF_8_3);
  assign _zz__zz_flagUF_8_1 = _zz__zz_flagUF_8_2[26:0];
  assign _zz__zz_flagUF_8_3 = _zz_when_FpUnit_l150[4:0];
  assign _zz__zz_flagUF_9 = (_zz__zz_flagUF_9_1 - 29'h00000001);
  assign _zz__zz_flagUF_9_2 = ({31'd0,29'h00000001} <<< _zz__zz_flagUF_9_3);
  assign _zz__zz_flagUF_9_1 = _zz__zz_flagUF_9_2[28:0];
  assign _zz__zz_flagUF_9_3 = _zz_when_FpUnit_l150[4:0];
  assign _zz__zz_when_FpUnit_l190_1_1 = _zz_when_FpUnit_l190;
  assign _zz__zz_when_FpUnit_l190_1 = {1'd0, _zz__zz_when_FpUnit_l190_1_1};
  assign _zz__zz_when_FpUnit_l190_1_3 = ((io_rm == 3'b000) ? (_zz_flagUF_10 && ((_zz_flagUF_11 || _zz_flagUF_12) || _zz_when_FpUnit_l190[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_res_1 && (_zz__zz_when_FpUnit_l190_1_4 || _zz_flagUF_12)) : ((io_rm == _zz__zz_when_FpUnit_l190_1_5) ? (_zz__zz_when_FpUnit_l190_1_6 && _zz__zz_when_FpUnit_l190_1_7) : _zz_flagUF_10))));
  assign _zz__zz_when_FpUnit_l190_1_2 = {24'd0, _zz__zz_when_FpUnit_l190_1_3};
  assign _zz__zz_when_FpUnit_l190_2 = (_zz_when_FpUnit_l190_1 >>> 1'd1);
  assign _zz__zz_when_FpUnit_l190_2_1 = _zz_when_FpUnit_l190_1[23:0];
  assign _zz__zz_when_FpUnit_l186_2 = (_zz_when_FpUnit_l186_1 ? _zz__zz_when_FpUnit_l186_2_1 : _zz_when_FpUnit_l186);
  assign _zz__zz_when_FpUnit_l186_2_1 = ($signed(_zz_when_FpUnit_l186) + $signed(12'h001));
  assign _zz__zz_res_4_1 = _zz_when_FpUnit_l186_2;
  assign _zz__zz_res_4 = _zz__zz_res_4_1[7:0];
  assign _zz__zz_when_FpUnit_l88_13 = ({3'd0,_zz__zz_when_FpUnit_l88_13_1} <<< 2'd3);
  assign _zz__zz_when_FpUnit_l88_13_2 = (_zz_when_FpUnit_l218_5 ? _zz_when_FpUnit_l88_1 : _zz_when_FpUnit_l88);
  assign _zz__zz_when_FpUnit_l88_13_1 = {4'd0, _zz__zz_when_FpUnit_l88_13_2};
  assign _zz__zz_when_FpUnit_l218_7 = ($signed(_zz_when_FpUnit_l218_6) - $signed(_zz__zz_when_FpUnit_l218_7_1));
  assign _zz__zz_when_FpUnit_l218_7_1 = (_zz_when_FpUnit_l218_5 ? _zz_when_FpUnit_l218 : _zz_when_FpUnit_l218_1);
  assign _zz__zz_when_FpUnit_l88_14 = (_zz__zz_when_FpUnit_l88_14_1 >>> _zz_when_FpUnit_l218_7);
  assign _zz__zz_when_FpUnit_l88_14_2 = ({3'd0,_zz__zz_when_FpUnit_l88_14_3} <<< 2'd3);
  assign _zz__zz_when_FpUnit_l88_14_1 = _zz__zz_when_FpUnit_l88_14_2[27:0];
  assign _zz__zz_when_FpUnit_l88_14_4 = (_zz_when_FpUnit_l218_5 ? _zz_when_FpUnit_l88 : _zz_when_FpUnit_l88_1);
  assign _zz__zz_when_FpUnit_l88_14_3 = {4'd0, _zz__zz_when_FpUnit_l88_14_4};
  assign _zz__zz_when_FpUnit_l88_18 = (_zz_when_FpUnit_l88_16 - _zz_when_FpUnit_l88_13);
  assign _zz__zz_when_FpUnit_l88_18_1 = (_zz_when_FpUnit_l88_13 - _zz_when_FpUnit_l88_16);
  assign _zz__zz_when_FpUnit_l88_18_2 = (_zz_when_FpUnit_l88_13 + _zz_when_FpUnit_l88_16);
  assign _zz__zz_flagUF_16 = _zz__zz_flagUF_16_1;
  assign _zz__zz_flagUF_16_1 = {7'd0, _zz_when_FpUnit_l95_1};
  assign _zz__zz_flagUF_16_2 = ($signed(_zz__zz_flagUF_16_3) - $signed(12'h01a));
  assign _zz__zz_flagUF_16_3 = {{2{_zz_when_FpUnit_l218_6[9]}}, _zz_when_FpUnit_l218_6};
  assign _zz__zz_flagUF_14_1 = (_zz_when_FpUnit_l88_18 >>> _zz_flagUF_17);
  assign _zz__zz_flagUF_14 = _zz__zz_flagUF_14_1[26:0];
  assign _zz__zz_flagUF_15 = (_zz__zz_flagUF_15_1 - 28'h0000001);
  assign _zz__zz_flagUF_15_2 = ({31'd0,28'h0000001} <<< _zz_flagUF_17);
  assign _zz__zz_flagUF_15_1 = _zz__zz_flagUF_15_2[27:0];
  assign _zz__zz_flagUF_14_3 = ({31'd0,_zz_when_FpUnit_l88_18} <<< _zz__zz_flagUF_14_4);
  assign _zz__zz_flagUF_14_2 = _zz__zz_flagUF_14_3[26:0];
  assign _zz__zz_flagUF_14_4 = (5'h1a - _zz_when_FpUnit_l95_1);
  assign _zz__zz_flagUF_18 = {2'd0, _zz_flagUF_14};
  assign _zz__zz_flagUF_21 = ($signed(_zz_flagUF_16) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l147_1 = ($signed(12'hf82) - $signed(_zz_flagUF_16));
  assign _zz__zz_flagUF_22 = _zz_flagUF_19[26:0];
  assign _zz__zz_flagUF_22_2 = (_zz_flagUF_19 >>> _zz__zz_flagUF_22_3);
  assign _zz__zz_flagUF_22_1 = _zz__zz_flagUF_22_2[26:0];
  assign _zz__zz_flagUF_22_3 = _zz_when_FpUnit_l150_1[4:0];
  assign _zz__zz_flagUF_23 = (_zz__zz_flagUF_23_1 - 29'h00000001);
  assign _zz__zz_flagUF_23_2 = ({31'd0,29'h00000001} <<< _zz__zz_flagUF_23_3);
  assign _zz__zz_flagUF_23_1 = _zz__zz_flagUF_23_2[28:0];
  assign _zz__zz_flagUF_23_3 = _zz_when_FpUnit_l150_1[4:0];
  assign _zz__zz_when_FpUnit_l190_4_1 = _zz_when_FpUnit_l190_3;
  assign _zz__zz_when_FpUnit_l190_4 = {1'd0, _zz__zz_when_FpUnit_l190_4_1};
  assign _zz__zz_when_FpUnit_l190_4_3 = ((io_rm == 3'b000) ? (_zz_flagUF_24 && ((_zz_flagUF_25 || _zz_flagUF_26) || _zz_when_FpUnit_l190_3[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_res_6 && (_zz__zz_when_FpUnit_l190_4_4 || _zz_flagUF_26)) : ((io_rm == _zz__zz_when_FpUnit_l190_4_5) ? (_zz__zz_when_FpUnit_l190_4_6 && _zz__zz_when_FpUnit_l190_4_7) : _zz_flagUF_24))));
  assign _zz__zz_when_FpUnit_l190_4_2 = {24'd0, _zz__zz_when_FpUnit_l190_4_3};
  assign _zz__zz_when_FpUnit_l190_5 = (_zz_when_FpUnit_l190_4 >>> 1'd1);
  assign _zz__zz_when_FpUnit_l190_5_1 = _zz_when_FpUnit_l190_4[23:0];
  assign _zz__zz_when_FpUnit_l186_5 = (_zz_when_FpUnit_l186_4 ? _zz__zz_when_FpUnit_l186_5_1 : _zz_when_FpUnit_l186_3);
  assign _zz__zz_when_FpUnit_l186_5_1 = ($signed(_zz_when_FpUnit_l186_3) + $signed(12'h001));
  assign _zz__zz_res_9_1 = _zz_when_FpUnit_l186_5;
  assign _zz__zz_res_9 = _zz__zz_res_9_1[7:0];
  assign _zz__zz_flagUF_30 = _zz__zz_flagUF_30_1;
  assign _zz__zz_flagUF_30_1 = {6'd0, _zz_when_FpUnit_l95_2};
  assign _zz__zz_flagUF_30_2 = ($signed(_zz__zz_flagUF_30_3) - $signed(12'h02e));
  assign _zz__zz_flagUF_30_4 = ($signed(_zz_when_FpUnit_l218) + $signed(_zz_when_FpUnit_l218_1));
  assign _zz__zz_flagUF_30_3 = {{2{_zz__zz_flagUF_30_4[9]}}, _zz__zz_flagUF_30_4};
  assign _zz__zz_flagUF_28_1 = (_zz_when_FpUnit_l88_19 >>> _zz_flagUF_31);
  assign _zz__zz_flagUF_28 = _zz__zz_flagUF_28_1[26:0];
  assign _zz__zz_flagUF_29 = (_zz__zz_flagUF_29_1 - 48'h000000000001);
  assign _zz__zz_flagUF_29_2 = ({63'd0,48'h000000000001} <<< _zz_flagUF_31);
  assign _zz__zz_flagUF_29_1 = _zz__zz_flagUF_29_2[47:0];
  assign _zz__zz_flagUF_28_3 = ({63'd0,_zz_when_FpUnit_l88_19} <<< _zz__zz_flagUF_28_4);
  assign _zz__zz_flagUF_28_2 = _zz__zz_flagUF_28_3[26:0];
  assign _zz__zz_flagUF_28_4 = (6'h1a - _zz_when_FpUnit_l95_2);
  assign _zz__zz_flagUF_32 = {2'd0, _zz_flagUF_28};
  assign _zz__zz_flagUF_35 = ($signed(_zz_flagUF_30) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l147_2 = ($signed(12'hf82) - $signed(_zz_flagUF_30));
  assign _zz__zz_flagUF_36 = _zz_flagUF_33[26:0];
  assign _zz__zz_flagUF_36_2 = (_zz_flagUF_33 >>> _zz__zz_flagUF_36_3);
  assign _zz__zz_flagUF_36_1 = _zz__zz_flagUF_36_2[26:0];
  assign _zz__zz_flagUF_36_3 = _zz_when_FpUnit_l150_2[4:0];
  assign _zz__zz_flagUF_37 = (_zz__zz_flagUF_37_1 - 29'h00000001);
  assign _zz__zz_flagUF_37_2 = ({31'd0,29'h00000001} <<< _zz__zz_flagUF_37_3);
  assign _zz__zz_flagUF_37_1 = _zz__zz_flagUF_37_2[28:0];
  assign _zz__zz_flagUF_37_3 = _zz_when_FpUnit_l150_2[4:0];
  assign _zz__zz_when_FpUnit_l190_7_1 = _zz_when_FpUnit_l190_6;
  assign _zz__zz_when_FpUnit_l190_7 = {1'd0, _zz__zz_when_FpUnit_l190_7_1};
  assign _zz__zz_when_FpUnit_l190_7_3 = ((io_rm == 3'b000) ? (_zz_flagUF_38 && ((_zz_flagUF_39 || _zz_flagUF_40) || _zz_when_FpUnit_l190_6[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_res_11 && (_zz__zz_when_FpUnit_l190_7_4 || _zz_flagUF_40)) : ((io_rm == _zz__zz_when_FpUnit_l190_7_5) ? (_zz__zz_when_FpUnit_l190_7_6 && _zz__zz_when_FpUnit_l190_7_7) : _zz_flagUF_38))));
  assign _zz__zz_when_FpUnit_l190_7_2 = {24'd0, _zz__zz_when_FpUnit_l190_7_3};
  assign _zz__zz_when_FpUnit_l190_8 = (_zz_when_FpUnit_l190_7 >>> 1'd1);
  assign _zz__zz_when_FpUnit_l190_8_1 = _zz_when_FpUnit_l190_7[23:0];
  assign _zz__zz_when_FpUnit_l186_8 = (_zz_when_FpUnit_l186_7 ? _zz__zz_when_FpUnit_l186_8_1 : _zz_when_FpUnit_l186_6);
  assign _zz__zz_when_FpUnit_l186_8_1 = ($signed(_zz_when_FpUnit_l186_6) + $signed(12'h001));
  assign _zz__zz_res_14_1 = _zz_when_FpUnit_l186_8;
  assign _zz__zz_res_14 = _zz__zz_res_14_1[7:0];
  assign _zz__zz_when_FpUnit_l88_20 = {29'd0, _zz_when_FpUnit_l88};
  assign _zz__zz_when_FpUnit_l88_21 = (_zz_when_FpUnit_l88_20 / _zz__zz_when_FpUnit_l88_21_1);
  assign _zz__zz_when_FpUnit_l88_21_1 = {29'd0, _zz_when_FpUnit_l88_1};
  assign _zz__zz_flagUF_44 = _zz__zz_flagUF_44_1;
  assign _zz__zz_flagUF_44_1 = {7'd0, _zz_when_FpUnit_l95_3};
  assign _zz__zz_flagUF_44_2 = ($signed(_zz__zz_flagUF_44_3) - $signed(12'h01b));
  assign _zz__zz_flagUF_44_4 = ($signed(_zz_when_FpUnit_l218) - $signed(_zz_when_FpUnit_l218_1));
  assign _zz__zz_flagUF_44_3 = {{2{_zz__zz_flagUF_44_4[9]}}, _zz__zz_flagUF_44_4};
  assign _zz__zz_flagUF_42_1 = (_zz_when_FpUnit_l88_21 >>> _zz_flagUF_45);
  assign _zz__zz_flagUF_42 = _zz__zz_flagUF_42_1[26:0];
  assign _zz__zz_flagUF_43 = (_zz__zz_flagUF_43_1 - 29'h00000001);
  assign _zz__zz_flagUF_43_2 = ({31'd0,29'h00000001} <<< _zz_flagUF_45);
  assign _zz__zz_flagUF_43_1 = _zz__zz_flagUF_43_2[28:0];
  assign _zz__zz_flagUF_42_3 = ({31'd0,_zz_when_FpUnit_l88_21} <<< _zz__zz_flagUF_42_4);
  assign _zz__zz_flagUF_42_2 = _zz__zz_flagUF_42_3[26:0];
  assign _zz__zz_flagUF_42_4 = (5'h1a - _zz_when_FpUnit_l95_3);
  assign _zz__zz_flagUF_46 = {2'd0, _zz_flagUF_42};
  assign _zz__zz_flagUF_48 = (_zz__zz_flagUF_48_1 - _zz__zz_flagUF_48_2);
  assign _zz__zz_flagUF_48_1 = {26'd0, _zz_when_FpUnit_l88_20};
  assign _zz__zz_flagUF_48_2 = (_zz__zz_flagUF_48_3 * _zz__zz_flagUF_48_4);
  assign _zz__zz_flagUF_48_3 = {24'd0, _zz_when_FpUnit_l88_21};
  assign _zz__zz_flagUF_48_4 = {29'd0, _zz_when_FpUnit_l88_1};
  assign _zz__zz_flagUF_49 = ($signed(_zz_flagUF_44) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l147_3 = ($signed(12'hf82) - $signed(_zz_flagUF_44));
  assign _zz__zz_flagUF_50 = _zz_flagUF_47[26:0];
  assign _zz__zz_flagUF_50_2 = (_zz_flagUF_47 >>> _zz__zz_flagUF_50_3);
  assign _zz__zz_flagUF_50_1 = _zz__zz_flagUF_50_2[26:0];
  assign _zz__zz_flagUF_50_3 = _zz_when_FpUnit_l150_3[4:0];
  assign _zz__zz_flagUF_51 = (_zz__zz_flagUF_51_1 - 29'h00000001);
  assign _zz__zz_flagUF_51_2 = ({31'd0,29'h00000001} <<< _zz__zz_flagUF_51_3);
  assign _zz__zz_flagUF_51_1 = _zz__zz_flagUF_51_2[28:0];
  assign _zz__zz_flagUF_51_3 = _zz_when_FpUnit_l150_3[4:0];
  assign _zz__zz_when_FpUnit_l190_10_1 = _zz_when_FpUnit_l190_9;
  assign _zz__zz_when_FpUnit_l190_10 = {1'd0, _zz__zz_when_FpUnit_l190_10_1};
  assign _zz__zz_when_FpUnit_l190_10_3 = ((io_rm == 3'b000) ? (_zz_flagUF_52 && ((_zz_flagUF_53 || _zz_flagUF_54) || _zz_when_FpUnit_l190_9[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_res_16 && (_zz__zz_when_FpUnit_l190_10_4 || _zz_flagUF_54)) : ((io_rm == _zz__zz_when_FpUnit_l190_10_5) ? (_zz__zz_when_FpUnit_l190_10_6 && _zz__zz_when_FpUnit_l190_10_7) : _zz_flagUF_52))));
  assign _zz__zz_when_FpUnit_l190_10_2 = {24'd0, _zz__zz_when_FpUnit_l190_10_3};
  assign _zz__zz_when_FpUnit_l190_11 = (_zz_when_FpUnit_l190_10 >>> 1'd1);
  assign _zz__zz_when_FpUnit_l190_11_1 = _zz_when_FpUnit_l190_10[23:0];
  assign _zz__zz_when_FpUnit_l186_11 = (_zz_when_FpUnit_l186_10 ? _zz__zz_when_FpUnit_l186_11_1 : _zz_when_FpUnit_l186_9);
  assign _zz__zz_when_FpUnit_l186_11_1 = ($signed(_zz_when_FpUnit_l186_9) + $signed(12'h001));
  assign _zz__zz_res_19_1 = _zz_when_FpUnit_l186_11;
  assign _zz__zz_res_19 = _zz__zz_res_19_1[7:0];
  assign _zz__zz_when_FpUnit_l88_22 = ({29'd0,_zz__zz_when_FpUnit_l88_22_1} <<< 5'd29);
  assign _zz__zz_when_FpUnit_l88_22_2 = (_zz_flagUF_56 ? _zz__zz_when_FpUnit_l88_22_3 : _zz__zz_when_FpUnit_l88_22_4);
  assign _zz__zz_when_FpUnit_l88_22_1 = {31'd0, _zz__zz_when_FpUnit_l88_22_2};
  assign _zz__zz_when_FpUnit_l88_22_3 = ({1'd0,_zz_when_FpUnit_l88} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_22_4 = {1'd0, _zz_when_FpUnit_l88};
  assign _zz__zz_when_FpUnit_l88_24_1 = ({2'd0,58'h0} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_24 = _zz__zz_when_FpUnit_l88_24_1[57:0];
  assign _zz__zz_when_FpUnit_l88_24_3 = _zz_when_FpUnit_l88_22[55 : 54];
  assign _zz__zz_when_FpUnit_l88_24_2 = {56'd0, _zz__zz_when_FpUnit_l88_24_3};
  assign _zz__zz_when_FpUnit_l88_25_1 = ({2'd0,_zz_when_FpUnit_l88_23} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_25 = {26'd0, _zz__zz_when_FpUnit_l88_25_1};
  assign _zz__zz_when_FpUnit_l88_27_1 = ({1'd0,_zz_when_FpUnit_l88_23} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_27 = _zz__zz_when_FpUnit_l88_27_1[29:0];
  assign _zz__zz_when_FpUnit_l88_27_3 = ({1'd0,_zz_when_FpUnit_l88_23} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_27_2 = _zz__zz_when_FpUnit_l88_27_3[29:0];
  assign _zz__zz_when_FpUnit_l88_28_1 = ({2'd0,(_zz_when_FpUnit_l88_26 ? _zz__zz_when_FpUnit_l88_28_2 : _zz_when_FpUnit_l88_24)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_28 = _zz__zz_when_FpUnit_l88_28_1[57:0];
  assign _zz__zz_when_FpUnit_l88_28_2 = (_zz_when_FpUnit_l88_24 - _zz_when_FpUnit_l88_25);
  assign _zz__zz_when_FpUnit_l88_28_4 = _zz_when_FpUnit_l88_22[53 : 52];
  assign _zz__zz_when_FpUnit_l88_28_3 = {56'd0, _zz__zz_when_FpUnit_l88_28_4};
  assign _zz__zz_when_FpUnit_l88_29_1 = ({2'd0,_zz_when_FpUnit_l88_27} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_29 = {26'd0, _zz__zz_when_FpUnit_l88_29_1};
  assign _zz__zz_when_FpUnit_l88_31_1 = ({1'd0,_zz_when_FpUnit_l88_27} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_31 = _zz__zz_when_FpUnit_l88_31_1[29:0];
  assign _zz__zz_when_FpUnit_l88_31_3 = ({1'd0,_zz_when_FpUnit_l88_27} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_31_2 = _zz__zz_when_FpUnit_l88_31_3[29:0];
  assign _zz__zz_when_FpUnit_l88_32_1 = ({2'd0,(_zz_when_FpUnit_l88_30 ? _zz__zz_when_FpUnit_l88_32_2 : _zz_when_FpUnit_l88_28)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_32 = _zz__zz_when_FpUnit_l88_32_1[57:0];
  assign _zz__zz_when_FpUnit_l88_32_2 = (_zz_when_FpUnit_l88_28 - _zz_when_FpUnit_l88_29);
  assign _zz__zz_when_FpUnit_l88_32_4 = _zz_when_FpUnit_l88_22[51 : 50];
  assign _zz__zz_when_FpUnit_l88_32_3 = {56'd0, _zz__zz_when_FpUnit_l88_32_4};
  assign _zz__zz_when_FpUnit_l88_33_1 = ({2'd0,_zz_when_FpUnit_l88_31} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_33 = {26'd0, _zz__zz_when_FpUnit_l88_33_1};
  assign _zz__zz_when_FpUnit_l88_35_1 = ({1'd0,_zz_when_FpUnit_l88_31} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_35 = _zz__zz_when_FpUnit_l88_35_1[29:0];
  assign _zz__zz_when_FpUnit_l88_35_3 = ({1'd0,_zz_when_FpUnit_l88_31} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_35_2 = _zz__zz_when_FpUnit_l88_35_3[29:0];
  assign _zz__zz_when_FpUnit_l88_36_1 = ({2'd0,(_zz_when_FpUnit_l88_34 ? _zz__zz_when_FpUnit_l88_36_2 : _zz_when_FpUnit_l88_32)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_36 = _zz__zz_when_FpUnit_l88_36_1[57:0];
  assign _zz__zz_when_FpUnit_l88_36_2 = (_zz_when_FpUnit_l88_32 - _zz_when_FpUnit_l88_33);
  assign _zz__zz_when_FpUnit_l88_36_4 = _zz_when_FpUnit_l88_22[49 : 48];
  assign _zz__zz_when_FpUnit_l88_36_3 = {56'd0, _zz__zz_when_FpUnit_l88_36_4};
  assign _zz__zz_when_FpUnit_l88_37_1 = ({2'd0,_zz_when_FpUnit_l88_35} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_37 = {26'd0, _zz__zz_when_FpUnit_l88_37_1};
  assign _zz__zz_when_FpUnit_l88_39_1 = ({1'd0,_zz_when_FpUnit_l88_35} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_39 = _zz__zz_when_FpUnit_l88_39_1[29:0];
  assign _zz__zz_when_FpUnit_l88_39_3 = ({1'd0,_zz_when_FpUnit_l88_35} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_39_2 = _zz__zz_when_FpUnit_l88_39_3[29:0];
  assign _zz__zz_when_FpUnit_l88_40_1 = ({2'd0,(_zz_when_FpUnit_l88_38 ? _zz__zz_when_FpUnit_l88_40_2 : _zz_when_FpUnit_l88_36)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_40 = _zz__zz_when_FpUnit_l88_40_1[57:0];
  assign _zz__zz_when_FpUnit_l88_40_2 = (_zz_when_FpUnit_l88_36 - _zz_when_FpUnit_l88_37);
  assign _zz__zz_when_FpUnit_l88_40_4 = _zz_when_FpUnit_l88_22[47 : 46];
  assign _zz__zz_when_FpUnit_l88_40_3 = {56'd0, _zz__zz_when_FpUnit_l88_40_4};
  assign _zz__zz_when_FpUnit_l88_41_1 = ({2'd0,_zz_when_FpUnit_l88_39} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_41 = {26'd0, _zz__zz_when_FpUnit_l88_41_1};
  assign _zz__zz_when_FpUnit_l88_43_1 = ({1'd0,_zz_when_FpUnit_l88_39} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_43 = _zz__zz_when_FpUnit_l88_43_1[29:0];
  assign _zz__zz_when_FpUnit_l88_43_3 = ({1'd0,_zz_when_FpUnit_l88_39} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_43_2 = _zz__zz_when_FpUnit_l88_43_3[29:0];
  assign _zz__zz_when_FpUnit_l88_44_1 = ({2'd0,(_zz_when_FpUnit_l88_42 ? _zz__zz_when_FpUnit_l88_44_2 : _zz_when_FpUnit_l88_40)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_44 = _zz__zz_when_FpUnit_l88_44_1[57:0];
  assign _zz__zz_when_FpUnit_l88_44_2 = (_zz_when_FpUnit_l88_40 - _zz_when_FpUnit_l88_41);
  assign _zz__zz_when_FpUnit_l88_44_4 = _zz_when_FpUnit_l88_22[45 : 44];
  assign _zz__zz_when_FpUnit_l88_44_3 = {56'd0, _zz__zz_when_FpUnit_l88_44_4};
  assign _zz__zz_when_FpUnit_l88_45_1 = ({2'd0,_zz_when_FpUnit_l88_43} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_45 = {26'd0, _zz__zz_when_FpUnit_l88_45_1};
  assign _zz__zz_when_FpUnit_l88_47_1 = ({1'd0,_zz_when_FpUnit_l88_43} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_47 = _zz__zz_when_FpUnit_l88_47_1[29:0];
  assign _zz__zz_when_FpUnit_l88_47_3 = ({1'd0,_zz_when_FpUnit_l88_43} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_47_2 = _zz__zz_when_FpUnit_l88_47_3[29:0];
  assign _zz__zz_when_FpUnit_l88_48_1 = ({2'd0,(_zz_when_FpUnit_l88_46 ? _zz__zz_when_FpUnit_l88_48_2 : _zz_when_FpUnit_l88_44)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_48 = _zz__zz_when_FpUnit_l88_48_1[57:0];
  assign _zz__zz_when_FpUnit_l88_48_2 = (_zz_when_FpUnit_l88_44 - _zz_when_FpUnit_l88_45);
  assign _zz__zz_when_FpUnit_l88_48_4 = _zz_when_FpUnit_l88_22[43 : 42];
  assign _zz__zz_when_FpUnit_l88_48_3 = {56'd0, _zz__zz_when_FpUnit_l88_48_4};
  assign _zz__zz_when_FpUnit_l88_49_1 = ({2'd0,_zz_when_FpUnit_l88_47} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_49 = {26'd0, _zz__zz_when_FpUnit_l88_49_1};
  assign _zz__zz_when_FpUnit_l88_51_1 = ({1'd0,_zz_when_FpUnit_l88_47} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_51 = _zz__zz_when_FpUnit_l88_51_1[29:0];
  assign _zz__zz_when_FpUnit_l88_51_3 = ({1'd0,_zz_when_FpUnit_l88_47} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_51_2 = _zz__zz_when_FpUnit_l88_51_3[29:0];
  assign _zz__zz_when_FpUnit_l88_52_1 = ({2'd0,(_zz_when_FpUnit_l88_50 ? _zz__zz_when_FpUnit_l88_52_2 : _zz_when_FpUnit_l88_48)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_52 = _zz__zz_when_FpUnit_l88_52_1[57:0];
  assign _zz__zz_when_FpUnit_l88_52_2 = (_zz_when_FpUnit_l88_48 - _zz_when_FpUnit_l88_49);
  assign _zz__zz_when_FpUnit_l88_52_4 = _zz_when_FpUnit_l88_22[41 : 40];
  assign _zz__zz_when_FpUnit_l88_52_3 = {56'd0, _zz__zz_when_FpUnit_l88_52_4};
  assign _zz__zz_when_FpUnit_l88_53_1 = ({2'd0,_zz_when_FpUnit_l88_51} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_53 = {26'd0, _zz__zz_when_FpUnit_l88_53_1};
  assign _zz__zz_when_FpUnit_l88_55_1 = ({1'd0,_zz_when_FpUnit_l88_51} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_55 = _zz__zz_when_FpUnit_l88_55_1[29:0];
  assign _zz__zz_when_FpUnit_l88_55_3 = ({1'd0,_zz_when_FpUnit_l88_51} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_55_2 = _zz__zz_when_FpUnit_l88_55_3[29:0];
  assign _zz__zz_when_FpUnit_l88_56_1 = ({2'd0,(_zz_when_FpUnit_l88_54 ? _zz__zz_when_FpUnit_l88_56_2 : _zz_when_FpUnit_l88_52)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_56 = _zz__zz_when_FpUnit_l88_56_1[57:0];
  assign _zz__zz_when_FpUnit_l88_56_2 = (_zz_when_FpUnit_l88_52 - _zz_when_FpUnit_l88_53);
  assign _zz__zz_when_FpUnit_l88_56_4 = _zz_when_FpUnit_l88_22[39 : 38];
  assign _zz__zz_when_FpUnit_l88_56_3 = {56'd0, _zz__zz_when_FpUnit_l88_56_4};
  assign _zz__zz_when_FpUnit_l88_57_1 = ({2'd0,_zz_when_FpUnit_l88_55} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_57 = {26'd0, _zz__zz_when_FpUnit_l88_57_1};
  assign _zz__zz_when_FpUnit_l88_59_1 = ({1'd0,_zz_when_FpUnit_l88_55} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_59 = _zz__zz_when_FpUnit_l88_59_1[29:0];
  assign _zz__zz_when_FpUnit_l88_59_3 = ({1'd0,_zz_when_FpUnit_l88_55} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_59_2 = _zz__zz_when_FpUnit_l88_59_3[29:0];
  assign _zz__zz_when_FpUnit_l88_60_1 = ({2'd0,(_zz_when_FpUnit_l88_58 ? _zz__zz_when_FpUnit_l88_60_2 : _zz_when_FpUnit_l88_56)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_60 = _zz__zz_when_FpUnit_l88_60_1[57:0];
  assign _zz__zz_when_FpUnit_l88_60_2 = (_zz_when_FpUnit_l88_56 - _zz_when_FpUnit_l88_57);
  assign _zz__zz_when_FpUnit_l88_60_4 = _zz_when_FpUnit_l88_22[37 : 36];
  assign _zz__zz_when_FpUnit_l88_60_3 = {56'd0, _zz__zz_when_FpUnit_l88_60_4};
  assign _zz__zz_when_FpUnit_l88_61_1 = ({2'd0,_zz_when_FpUnit_l88_59} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_61 = {26'd0, _zz__zz_when_FpUnit_l88_61_1};
  assign _zz__zz_when_FpUnit_l88_63_1 = ({1'd0,_zz_when_FpUnit_l88_59} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_63 = _zz__zz_when_FpUnit_l88_63_1[29:0];
  assign _zz__zz_when_FpUnit_l88_63_3 = ({1'd0,_zz_when_FpUnit_l88_59} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_63_2 = _zz__zz_when_FpUnit_l88_63_3[29:0];
  assign _zz__zz_when_FpUnit_l88_64_1 = ({2'd0,(_zz_when_FpUnit_l88_62 ? _zz__zz_when_FpUnit_l88_64_2 : _zz_when_FpUnit_l88_60)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_64 = _zz__zz_when_FpUnit_l88_64_1[57:0];
  assign _zz__zz_when_FpUnit_l88_64_2 = (_zz_when_FpUnit_l88_60 - _zz_when_FpUnit_l88_61);
  assign _zz__zz_when_FpUnit_l88_64_4 = _zz_when_FpUnit_l88_22[35 : 34];
  assign _zz__zz_when_FpUnit_l88_64_3 = {56'd0, _zz__zz_when_FpUnit_l88_64_4};
  assign _zz__zz_when_FpUnit_l88_65_1 = ({2'd0,_zz_when_FpUnit_l88_63} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_65 = {26'd0, _zz__zz_when_FpUnit_l88_65_1};
  assign _zz__zz_when_FpUnit_l88_67_1 = ({1'd0,_zz_when_FpUnit_l88_63} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_67 = _zz__zz_when_FpUnit_l88_67_1[29:0];
  assign _zz__zz_when_FpUnit_l88_67_3 = ({1'd0,_zz_when_FpUnit_l88_63} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_67_2 = _zz__zz_when_FpUnit_l88_67_3[29:0];
  assign _zz__zz_when_FpUnit_l88_68_1 = ({2'd0,(_zz_when_FpUnit_l88_66 ? _zz__zz_when_FpUnit_l88_68_2 : _zz_when_FpUnit_l88_64)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_68 = _zz__zz_when_FpUnit_l88_68_1[57:0];
  assign _zz__zz_when_FpUnit_l88_68_2 = (_zz_when_FpUnit_l88_64 - _zz_when_FpUnit_l88_65);
  assign _zz__zz_when_FpUnit_l88_68_4 = _zz_when_FpUnit_l88_22[33 : 32];
  assign _zz__zz_when_FpUnit_l88_68_3 = {56'd0, _zz__zz_when_FpUnit_l88_68_4};
  assign _zz__zz_when_FpUnit_l88_69_1 = ({2'd0,_zz_when_FpUnit_l88_67} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_69 = {26'd0, _zz__zz_when_FpUnit_l88_69_1};
  assign _zz__zz_when_FpUnit_l88_71_1 = ({1'd0,_zz_when_FpUnit_l88_67} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_71 = _zz__zz_when_FpUnit_l88_71_1[29:0];
  assign _zz__zz_when_FpUnit_l88_71_3 = ({1'd0,_zz_when_FpUnit_l88_67} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_71_2 = _zz__zz_when_FpUnit_l88_71_3[29:0];
  assign _zz__zz_when_FpUnit_l88_72_1 = ({2'd0,(_zz_when_FpUnit_l88_70 ? _zz__zz_when_FpUnit_l88_72_2 : _zz_when_FpUnit_l88_68)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_72 = _zz__zz_when_FpUnit_l88_72_1[57:0];
  assign _zz__zz_when_FpUnit_l88_72_2 = (_zz_when_FpUnit_l88_68 - _zz_when_FpUnit_l88_69);
  assign _zz__zz_when_FpUnit_l88_72_4 = _zz_when_FpUnit_l88_22[31 : 30];
  assign _zz__zz_when_FpUnit_l88_72_3 = {56'd0, _zz__zz_when_FpUnit_l88_72_4};
  assign _zz__zz_when_FpUnit_l88_73_1 = ({2'd0,_zz_when_FpUnit_l88_71} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_73 = {26'd0, _zz__zz_when_FpUnit_l88_73_1};
  assign _zz__zz_when_FpUnit_l88_75_1 = ({1'd0,_zz_when_FpUnit_l88_71} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_75 = _zz__zz_when_FpUnit_l88_75_1[29:0];
  assign _zz__zz_when_FpUnit_l88_75_3 = ({1'd0,_zz_when_FpUnit_l88_71} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_75_2 = _zz__zz_when_FpUnit_l88_75_3[29:0];
  assign _zz__zz_when_FpUnit_l88_76_1 = ({2'd0,(_zz_when_FpUnit_l88_74 ? _zz__zz_when_FpUnit_l88_76_2 : _zz_when_FpUnit_l88_72)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_76 = _zz__zz_when_FpUnit_l88_76_1[57:0];
  assign _zz__zz_when_FpUnit_l88_76_2 = (_zz_when_FpUnit_l88_72 - _zz_when_FpUnit_l88_73);
  assign _zz__zz_when_FpUnit_l88_76_4 = _zz_when_FpUnit_l88_22[29 : 28];
  assign _zz__zz_when_FpUnit_l88_76_3 = {56'd0, _zz__zz_when_FpUnit_l88_76_4};
  assign _zz__zz_when_FpUnit_l88_77_1 = ({2'd0,_zz_when_FpUnit_l88_75} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_77 = {26'd0, _zz__zz_when_FpUnit_l88_77_1};
  assign _zz__zz_when_FpUnit_l88_79_1 = ({1'd0,_zz_when_FpUnit_l88_75} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_79 = _zz__zz_when_FpUnit_l88_79_1[29:0];
  assign _zz__zz_when_FpUnit_l88_79_3 = ({1'd0,_zz_when_FpUnit_l88_75} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_79_2 = _zz__zz_when_FpUnit_l88_79_3[29:0];
  assign _zz__zz_when_FpUnit_l88_80_1 = ({2'd0,(_zz_when_FpUnit_l88_78 ? _zz__zz_when_FpUnit_l88_80_2 : _zz_when_FpUnit_l88_76)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_80 = _zz__zz_when_FpUnit_l88_80_1[57:0];
  assign _zz__zz_when_FpUnit_l88_80_2 = (_zz_when_FpUnit_l88_76 - _zz_when_FpUnit_l88_77);
  assign _zz__zz_when_FpUnit_l88_80_4 = _zz_when_FpUnit_l88_22[27 : 26];
  assign _zz__zz_when_FpUnit_l88_80_3 = {56'd0, _zz__zz_when_FpUnit_l88_80_4};
  assign _zz__zz_when_FpUnit_l88_81_1 = ({2'd0,_zz_when_FpUnit_l88_79} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_81 = {26'd0, _zz__zz_when_FpUnit_l88_81_1};
  assign _zz__zz_when_FpUnit_l88_83_1 = ({1'd0,_zz_when_FpUnit_l88_79} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_83 = _zz__zz_when_FpUnit_l88_83_1[29:0];
  assign _zz__zz_when_FpUnit_l88_83_3 = ({1'd0,_zz_when_FpUnit_l88_79} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_83_2 = _zz__zz_when_FpUnit_l88_83_3[29:0];
  assign _zz__zz_when_FpUnit_l88_84_1 = ({2'd0,(_zz_when_FpUnit_l88_82 ? _zz__zz_when_FpUnit_l88_84_2 : _zz_when_FpUnit_l88_80)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_84 = _zz__zz_when_FpUnit_l88_84_1[57:0];
  assign _zz__zz_when_FpUnit_l88_84_2 = (_zz_when_FpUnit_l88_80 - _zz_when_FpUnit_l88_81);
  assign _zz__zz_when_FpUnit_l88_84_4 = _zz_when_FpUnit_l88_22[25 : 24];
  assign _zz__zz_when_FpUnit_l88_84_3 = {56'd0, _zz__zz_when_FpUnit_l88_84_4};
  assign _zz__zz_when_FpUnit_l88_85_1 = ({2'd0,_zz_when_FpUnit_l88_83} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_85 = {26'd0, _zz__zz_when_FpUnit_l88_85_1};
  assign _zz__zz_when_FpUnit_l88_87_1 = ({1'd0,_zz_when_FpUnit_l88_83} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_87 = _zz__zz_when_FpUnit_l88_87_1[29:0];
  assign _zz__zz_when_FpUnit_l88_87_3 = ({1'd0,_zz_when_FpUnit_l88_83} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_87_2 = _zz__zz_when_FpUnit_l88_87_3[29:0];
  assign _zz__zz_when_FpUnit_l88_88_1 = ({2'd0,(_zz_when_FpUnit_l88_86 ? _zz__zz_when_FpUnit_l88_88_2 : _zz_when_FpUnit_l88_84)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_88 = _zz__zz_when_FpUnit_l88_88_1[57:0];
  assign _zz__zz_when_FpUnit_l88_88_2 = (_zz_when_FpUnit_l88_84 - _zz_when_FpUnit_l88_85);
  assign _zz__zz_when_FpUnit_l88_88_4 = _zz_when_FpUnit_l88_22[23 : 22];
  assign _zz__zz_when_FpUnit_l88_88_3 = {56'd0, _zz__zz_when_FpUnit_l88_88_4};
  assign _zz__zz_when_FpUnit_l88_89_1 = ({2'd0,_zz_when_FpUnit_l88_87} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_89 = {26'd0, _zz__zz_when_FpUnit_l88_89_1};
  assign _zz__zz_when_FpUnit_l88_91_1 = ({1'd0,_zz_when_FpUnit_l88_87} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_91 = _zz__zz_when_FpUnit_l88_91_1[29:0];
  assign _zz__zz_when_FpUnit_l88_91_3 = ({1'd0,_zz_when_FpUnit_l88_87} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_91_2 = _zz__zz_when_FpUnit_l88_91_3[29:0];
  assign _zz__zz_when_FpUnit_l88_92_1 = ({2'd0,(_zz_when_FpUnit_l88_90 ? _zz__zz_when_FpUnit_l88_92_2 : _zz_when_FpUnit_l88_88)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_92 = _zz__zz_when_FpUnit_l88_92_1[57:0];
  assign _zz__zz_when_FpUnit_l88_92_2 = (_zz_when_FpUnit_l88_88 - _zz_when_FpUnit_l88_89);
  assign _zz__zz_when_FpUnit_l88_92_4 = _zz_when_FpUnit_l88_22[21 : 20];
  assign _zz__zz_when_FpUnit_l88_92_3 = {56'd0, _zz__zz_when_FpUnit_l88_92_4};
  assign _zz__zz_when_FpUnit_l88_93_1 = ({2'd0,_zz_when_FpUnit_l88_91} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_93 = {26'd0, _zz__zz_when_FpUnit_l88_93_1};
  assign _zz__zz_when_FpUnit_l88_95_1 = ({1'd0,_zz_when_FpUnit_l88_91} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_95 = _zz__zz_when_FpUnit_l88_95_1[29:0];
  assign _zz__zz_when_FpUnit_l88_95_3 = ({1'd0,_zz_when_FpUnit_l88_91} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_95_2 = _zz__zz_when_FpUnit_l88_95_3[29:0];
  assign _zz__zz_when_FpUnit_l88_96_1 = ({2'd0,(_zz_when_FpUnit_l88_94 ? _zz__zz_when_FpUnit_l88_96_2 : _zz_when_FpUnit_l88_92)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_96 = _zz__zz_when_FpUnit_l88_96_1[57:0];
  assign _zz__zz_when_FpUnit_l88_96_2 = (_zz_when_FpUnit_l88_92 - _zz_when_FpUnit_l88_93);
  assign _zz__zz_when_FpUnit_l88_96_4 = _zz_when_FpUnit_l88_22[19 : 18];
  assign _zz__zz_when_FpUnit_l88_96_3 = {56'd0, _zz__zz_when_FpUnit_l88_96_4};
  assign _zz__zz_when_FpUnit_l88_97_1 = ({2'd0,_zz_when_FpUnit_l88_95} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_97 = {26'd0, _zz__zz_when_FpUnit_l88_97_1};
  assign _zz__zz_when_FpUnit_l88_99_1 = ({1'd0,_zz_when_FpUnit_l88_95} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_99 = _zz__zz_when_FpUnit_l88_99_1[29:0];
  assign _zz__zz_when_FpUnit_l88_99_3 = ({1'd0,_zz_when_FpUnit_l88_95} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_99_2 = _zz__zz_when_FpUnit_l88_99_3[29:0];
  assign _zz__zz_when_FpUnit_l88_100_1 = ({2'd0,(_zz_when_FpUnit_l88_98 ? _zz__zz_when_FpUnit_l88_100_2 : _zz_when_FpUnit_l88_96)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_100 = _zz__zz_when_FpUnit_l88_100_1[57:0];
  assign _zz__zz_when_FpUnit_l88_100_2 = (_zz_when_FpUnit_l88_96 - _zz_when_FpUnit_l88_97);
  assign _zz__zz_when_FpUnit_l88_100_4 = _zz_when_FpUnit_l88_22[17 : 16];
  assign _zz__zz_when_FpUnit_l88_100_3 = {56'd0, _zz__zz_when_FpUnit_l88_100_4};
  assign _zz__zz_when_FpUnit_l88_101_1 = ({2'd0,_zz_when_FpUnit_l88_99} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_101 = {26'd0, _zz__zz_when_FpUnit_l88_101_1};
  assign _zz__zz_when_FpUnit_l88_103_1 = ({1'd0,_zz_when_FpUnit_l88_99} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_103 = _zz__zz_when_FpUnit_l88_103_1[29:0];
  assign _zz__zz_when_FpUnit_l88_103_3 = ({1'd0,_zz_when_FpUnit_l88_99} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_103_2 = _zz__zz_when_FpUnit_l88_103_3[29:0];
  assign _zz__zz_when_FpUnit_l88_104_1 = ({2'd0,(_zz_when_FpUnit_l88_102 ? _zz__zz_when_FpUnit_l88_104_2 : _zz_when_FpUnit_l88_100)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_104 = _zz__zz_when_FpUnit_l88_104_1[57:0];
  assign _zz__zz_when_FpUnit_l88_104_2 = (_zz_when_FpUnit_l88_100 - _zz_when_FpUnit_l88_101);
  assign _zz__zz_when_FpUnit_l88_104_4 = _zz_when_FpUnit_l88_22[15 : 14];
  assign _zz__zz_when_FpUnit_l88_104_3 = {56'd0, _zz__zz_when_FpUnit_l88_104_4};
  assign _zz__zz_when_FpUnit_l88_105_1 = ({2'd0,_zz_when_FpUnit_l88_103} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_105 = {26'd0, _zz__zz_when_FpUnit_l88_105_1};
  assign _zz__zz_when_FpUnit_l88_107_1 = ({1'd0,_zz_when_FpUnit_l88_103} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_107 = _zz__zz_when_FpUnit_l88_107_1[29:0];
  assign _zz__zz_when_FpUnit_l88_107_3 = ({1'd0,_zz_when_FpUnit_l88_103} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_107_2 = _zz__zz_when_FpUnit_l88_107_3[29:0];
  assign _zz__zz_when_FpUnit_l88_108_1 = ({2'd0,(_zz_when_FpUnit_l88_106 ? _zz__zz_when_FpUnit_l88_108_2 : _zz_when_FpUnit_l88_104)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_108 = _zz__zz_when_FpUnit_l88_108_1[57:0];
  assign _zz__zz_when_FpUnit_l88_108_2 = (_zz_when_FpUnit_l88_104 - _zz_when_FpUnit_l88_105);
  assign _zz__zz_when_FpUnit_l88_108_4 = _zz_when_FpUnit_l88_22[13 : 12];
  assign _zz__zz_when_FpUnit_l88_108_3 = {56'd0, _zz__zz_when_FpUnit_l88_108_4};
  assign _zz__zz_when_FpUnit_l88_109_1 = ({2'd0,_zz_when_FpUnit_l88_107} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_109 = {26'd0, _zz__zz_when_FpUnit_l88_109_1};
  assign _zz__zz_when_FpUnit_l88_111_1 = ({1'd0,_zz_when_FpUnit_l88_107} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_111 = _zz__zz_when_FpUnit_l88_111_1[29:0];
  assign _zz__zz_when_FpUnit_l88_111_3 = ({1'd0,_zz_when_FpUnit_l88_107} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_111_2 = _zz__zz_when_FpUnit_l88_111_3[29:0];
  assign _zz__zz_when_FpUnit_l88_112_1 = ({2'd0,(_zz_when_FpUnit_l88_110 ? _zz__zz_when_FpUnit_l88_112_2 : _zz_when_FpUnit_l88_108)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_112 = _zz__zz_when_FpUnit_l88_112_1[57:0];
  assign _zz__zz_when_FpUnit_l88_112_2 = (_zz_when_FpUnit_l88_108 - _zz_when_FpUnit_l88_109);
  assign _zz__zz_when_FpUnit_l88_112_4 = _zz_when_FpUnit_l88_22[11 : 10];
  assign _zz__zz_when_FpUnit_l88_112_3 = {56'd0, _zz__zz_when_FpUnit_l88_112_4};
  assign _zz__zz_when_FpUnit_l88_113_1 = ({2'd0,_zz_when_FpUnit_l88_111} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_113 = {26'd0, _zz__zz_when_FpUnit_l88_113_1};
  assign _zz__zz_when_FpUnit_l88_115_1 = ({1'd0,_zz_when_FpUnit_l88_111} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_115 = _zz__zz_when_FpUnit_l88_115_1[29:0];
  assign _zz__zz_when_FpUnit_l88_115_3 = ({1'd0,_zz_when_FpUnit_l88_111} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_115_2 = _zz__zz_when_FpUnit_l88_115_3[29:0];
  assign _zz__zz_when_FpUnit_l88_116_1 = ({2'd0,(_zz_when_FpUnit_l88_114 ? _zz__zz_when_FpUnit_l88_116_2 : _zz_when_FpUnit_l88_112)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_116 = _zz__zz_when_FpUnit_l88_116_1[57:0];
  assign _zz__zz_when_FpUnit_l88_116_2 = (_zz_when_FpUnit_l88_112 - _zz_when_FpUnit_l88_113);
  assign _zz__zz_when_FpUnit_l88_116_4 = _zz_when_FpUnit_l88_22[9 : 8];
  assign _zz__zz_when_FpUnit_l88_116_3 = {56'd0, _zz__zz_when_FpUnit_l88_116_4};
  assign _zz__zz_when_FpUnit_l88_117_1 = ({2'd0,_zz_when_FpUnit_l88_115} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_117 = {26'd0, _zz__zz_when_FpUnit_l88_117_1};
  assign _zz__zz_when_FpUnit_l88_119_1 = ({1'd0,_zz_when_FpUnit_l88_115} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_119 = _zz__zz_when_FpUnit_l88_119_1[29:0];
  assign _zz__zz_when_FpUnit_l88_119_3 = ({1'd0,_zz_when_FpUnit_l88_115} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_119_2 = _zz__zz_when_FpUnit_l88_119_3[29:0];
  assign _zz__zz_when_FpUnit_l88_120_1 = ({2'd0,(_zz_when_FpUnit_l88_118 ? _zz__zz_when_FpUnit_l88_120_2 : _zz_when_FpUnit_l88_116)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_120 = _zz__zz_when_FpUnit_l88_120_1[57:0];
  assign _zz__zz_when_FpUnit_l88_120_2 = (_zz_when_FpUnit_l88_116 - _zz_when_FpUnit_l88_117);
  assign _zz__zz_when_FpUnit_l88_120_4 = _zz_when_FpUnit_l88_22[7 : 6];
  assign _zz__zz_when_FpUnit_l88_120_3 = {56'd0, _zz__zz_when_FpUnit_l88_120_4};
  assign _zz__zz_when_FpUnit_l88_121_1 = ({2'd0,_zz_when_FpUnit_l88_119} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_121 = {26'd0, _zz__zz_when_FpUnit_l88_121_1};
  assign _zz__zz_when_FpUnit_l88_123_1 = ({1'd0,_zz_when_FpUnit_l88_119} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_123 = _zz__zz_when_FpUnit_l88_123_1[29:0];
  assign _zz__zz_when_FpUnit_l88_123_3 = ({1'd0,_zz_when_FpUnit_l88_119} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_123_2 = _zz__zz_when_FpUnit_l88_123_3[29:0];
  assign _zz__zz_when_FpUnit_l88_124_1 = ({2'd0,(_zz_when_FpUnit_l88_122 ? _zz__zz_when_FpUnit_l88_124_2 : _zz_when_FpUnit_l88_120)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_124 = _zz__zz_when_FpUnit_l88_124_1[57:0];
  assign _zz__zz_when_FpUnit_l88_124_2 = (_zz_when_FpUnit_l88_120 - _zz_when_FpUnit_l88_121);
  assign _zz__zz_when_FpUnit_l88_124_4 = _zz_when_FpUnit_l88_22[5 : 4];
  assign _zz__zz_when_FpUnit_l88_124_3 = {56'd0, _zz__zz_when_FpUnit_l88_124_4};
  assign _zz__zz_when_FpUnit_l88_125_1 = ({2'd0,_zz_when_FpUnit_l88_123} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_125 = {26'd0, _zz__zz_when_FpUnit_l88_125_1};
  assign _zz__zz_when_FpUnit_l88_127_1 = ({1'd0,_zz_when_FpUnit_l88_123} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_127 = _zz__zz_when_FpUnit_l88_127_1[29:0];
  assign _zz__zz_when_FpUnit_l88_127_3 = ({1'd0,_zz_when_FpUnit_l88_123} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_127_2 = _zz__zz_when_FpUnit_l88_127_3[29:0];
  assign _zz__zz_when_FpUnit_l88_128_1 = ({2'd0,(_zz_when_FpUnit_l88_126 ? _zz__zz_when_FpUnit_l88_128_2 : _zz_when_FpUnit_l88_124)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_128 = _zz__zz_when_FpUnit_l88_128_1[57:0];
  assign _zz__zz_when_FpUnit_l88_128_2 = (_zz_when_FpUnit_l88_124 - _zz_when_FpUnit_l88_125);
  assign _zz__zz_when_FpUnit_l88_128_4 = _zz_when_FpUnit_l88_22[3 : 2];
  assign _zz__zz_when_FpUnit_l88_128_3 = {56'd0, _zz__zz_when_FpUnit_l88_128_4};
  assign _zz__zz_when_FpUnit_l88_129_1 = ({2'd0,_zz_when_FpUnit_l88_127} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_129 = {26'd0, _zz__zz_when_FpUnit_l88_129_1};
  assign _zz__zz_when_FpUnit_l88_131_1 = ({1'd0,_zz_when_FpUnit_l88_127} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_131 = _zz__zz_when_FpUnit_l88_131_1[29:0];
  assign _zz__zz_when_FpUnit_l88_131_3 = ({1'd0,_zz_when_FpUnit_l88_127} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_131_2 = _zz__zz_when_FpUnit_l88_131_3[29:0];
  assign _zz__zz_when_FpUnit_l88_132_1 = ({2'd0,(_zz_when_FpUnit_l88_130 ? _zz__zz_when_FpUnit_l88_132_2 : _zz_when_FpUnit_l88_128)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_132 = _zz__zz_when_FpUnit_l88_132_1[57:0];
  assign _zz__zz_when_FpUnit_l88_132_2 = (_zz_when_FpUnit_l88_128 - _zz_when_FpUnit_l88_129);
  assign _zz__zz_when_FpUnit_l88_132_4 = _zz_when_FpUnit_l88_22[1 : 0];
  assign _zz__zz_when_FpUnit_l88_132_3 = {56'd0, _zz__zz_when_FpUnit_l88_132_4};
  assign _zz__zz_when_FpUnit_l88_133_1 = ({2'd0,_zz_when_FpUnit_l88_131} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l88_133 = {26'd0, _zz__zz_when_FpUnit_l88_133_1};
  assign _zz__zz_when_FpUnit_l88_135_1 = ({1'd0,_zz_when_FpUnit_l88_131} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_135 = _zz__zz_when_FpUnit_l88_135_1[29:0];
  assign _zz__zz_when_FpUnit_l88_135_3 = ({1'd0,_zz_when_FpUnit_l88_131} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l88_135_2 = _zz__zz_when_FpUnit_l88_135_3[29:0];
  assign _zz__zz_flagUF_59 = _zz__zz_flagUF_59_1;
  assign _zz__zz_flagUF_59_1 = {7'd0, _zz_when_FpUnit_l95_4};
  assign _zz__zz_flagUF_59_2 = ($signed(_zz__zz_flagUF_59_3) - $signed(12'h01a));
  assign _zz__zz_flagUF_59_4 = (_zz__zz_flagUF_59_5 >>> 1'd1);
  assign _zz__zz_flagUF_59_3 = {{1{_zz__zz_flagUF_59_4[10]}}, _zz__zz_flagUF_59_4};
  assign _zz__zz_flagUF_59_5 = (_zz_flagUF_56 ? _zz__zz_flagUF_59_6 : _zz__zz_flagUF_59_8);
  assign _zz__zz_flagUF_59_6 = ($signed(_zz__zz_flagUF_59_7) - $signed(12'h001));
  assign _zz__zz_flagUF_59_7 = {{2{_zz_when_FpUnit_l218[9]}}, _zz_when_FpUnit_l218};
  assign _zz__zz_flagUF_59_8 = {{2{_zz_when_FpUnit_l218[9]}}, _zz_when_FpUnit_l218};
  assign _zz__zz_flagUF_57_1 = (_zz_when_FpUnit_l88_135 >>> _zz_flagUF_60);
  assign _zz__zz_flagUF_57 = _zz__zz_flagUF_57_1[26:0];
  assign _zz__zz_flagUF_58 = (_zz__zz_flagUF_58_1 - 30'h00000001);
  assign _zz__zz_flagUF_58_2 = ({31'd0,30'h00000001} <<< _zz_flagUF_60);
  assign _zz__zz_flagUF_58_1 = _zz__zz_flagUF_58_2[29:0];
  assign _zz__zz_flagUF_57_3 = ({31'd0,_zz_when_FpUnit_l88_135} <<< _zz__zz_flagUF_57_4);
  assign _zz__zz_flagUF_57_2 = _zz__zz_flagUF_57_3[26:0];
  assign _zz__zz_flagUF_57_4 = (5'h1a - _zz_when_FpUnit_l95_4);
  assign _zz__zz_flagUF_61 = {2'd0, _zz_flagUF_57};
  assign _zz__zz_flagUF_63 = (_zz_when_FpUnit_l88_132 - _zz_when_FpUnit_l88_133);
  assign _zz__zz_flagUF_64 = ($signed(_zz_flagUF_59) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l147_4 = ($signed(12'hf82) - $signed(_zz_flagUF_59));
  assign _zz__zz_flagUF_65 = _zz_flagUF_62[26:0];
  assign _zz__zz_flagUF_65_2 = (_zz_flagUF_62 >>> _zz__zz_flagUF_65_3);
  assign _zz__zz_flagUF_65_1 = _zz__zz_flagUF_65_2[26:0];
  assign _zz__zz_flagUF_65_3 = _zz_when_FpUnit_l150_4[4:0];
  assign _zz__zz_flagUF_66 = (_zz__zz_flagUF_66_1 - 29'h00000001);
  assign _zz__zz_flagUF_66_2 = ({31'd0,29'h00000001} <<< _zz__zz_flagUF_66_3);
  assign _zz__zz_flagUF_66_1 = _zz__zz_flagUF_66_2[28:0];
  assign _zz__zz_flagUF_66_3 = _zz_when_FpUnit_l150_4[4:0];
  assign _zz__zz_when_FpUnit_l190_13_1 = _zz_when_FpUnit_l190_12;
  assign _zz__zz_when_FpUnit_l190_13 = {1'd0, _zz__zz_when_FpUnit_l190_13_1};
  assign _zz__zz_when_FpUnit_l190_13_3 = ((io_rm == 3'b000) ? (_zz_flagUF_67 && ((_zz_flagUF_68 || _zz_flagUF_69) || _zz_when_FpUnit_l190_12[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_res_21 && (_zz__zz_when_FpUnit_l190_13_4 || _zz_flagUF_69)) : ((io_rm == _zz__zz_when_FpUnit_l190_13_5) ? (_zz__zz_when_FpUnit_l190_13_6 && _zz__zz_when_FpUnit_l190_13_7) : _zz_flagUF_67))));
  assign _zz__zz_when_FpUnit_l190_13_2 = {24'd0, _zz__zz_when_FpUnit_l190_13_3};
  assign _zz__zz_when_FpUnit_l190_14 = (_zz_when_FpUnit_l190_13 >>> 1'd1);
  assign _zz__zz_when_FpUnit_l190_14_1 = _zz_when_FpUnit_l190_13[23:0];
  assign _zz__zz_when_FpUnit_l186_14 = (_zz_when_FpUnit_l186_13 ? _zz__zz_when_FpUnit_l186_14_1 : _zz_when_FpUnit_l186_12);
  assign _zz__zz_when_FpUnit_l186_14_1 = ($signed(_zz_when_FpUnit_l186_12) + $signed(12'h001));
  assign _zz__zz_res_24_1 = _zz_when_FpUnit_l186_14;
  assign _zz__zz_res_24 = _zz__zz_res_24_1[7:0];
  assign _zz_res_87 = {22'd0, _zz_res_36};
  assign _zz__zz_when_FpUnit_l367_2_1 = ($signed(_zz_when_FpUnit_l218) + $signed(_zz_when_FpUnit_l218_1));
  assign _zz__zz_when_FpUnit_l367_2 = {{2{_zz__zz_when_FpUnit_l367_2_1[9]}}, _zz__zz_when_FpUnit_l367_2_1};
  assign _zz__zz_when_FpUnit_l367_3 = {{2{_zz_when_FpUnit_l367_1[9]}}, _zz_when_FpUnit_l367_1};
  assign _zz__zz_when_FpUnit_l88_137 = {6'd0, _zz_when_FpUnit_l88_136};
  assign _zz__zz_when_FpUnit_l88_137_1 = (_zz__zz_when_FpUnit_l88_137_2 >>> _zz_when_FpUnit_l368);
  assign _zz__zz_when_FpUnit_l88_137_2 = {6'd0, _zz_when_FpUnit_l88_136};
  assign _zz__zz_flagUF_71 = {6'd0, _zz_when_FpUnit_l88_136};
  assign _zz__zz_flagUF_71_1 = (_zz__zz_flagUF_71_2 - 54'h00000000000001);
  assign _zz__zz_flagUF_71_3 = ({63'd0,54'h00000000000001} <<< _zz__zz_flagUF_71_4);
  assign _zz__zz_flagUF_71_2 = _zz__zz_flagUF_71_3[53:0];
  assign _zz__zz_flagUF_71_4 = _zz_when_FpUnit_l368[5:0];
  assign _zz__zz_when_FpUnit_l88_138 = {30'd0, _zz_when_FpUnit_l88_2};
  assign _zz__zz_when_FpUnit_l88_138_1 = (_zz__zz_when_FpUnit_l88_138_2 >>> _zz_when_FpUnit_l368_1);
  assign _zz__zz_when_FpUnit_l88_138_2 = {30'd0, _zz_when_FpUnit_l88_2};
  assign _zz__zz_flagUF_72 = {30'd0, _zz_when_FpUnit_l88_2};
  assign _zz__zz_flagUF_72_1 = (_zz__zz_flagUF_72_2 - 54'h00000000000001);
  assign _zz__zz_flagUF_72_3 = ({63'd0,54'h00000000000001} <<< _zz__zz_flagUF_72_4);
  assign _zz__zz_flagUF_72_2 = _zz__zz_flagUF_72_3[53:0];
  assign _zz__zz_flagUF_72_4 = _zz_when_FpUnit_l368_1[5:0];
  assign _zz__zz_when_FpUnit_l88_139_1 = _zz_when_FpUnit_l88_137;
  assign _zz__zz_when_FpUnit_l88_139 = {1'd0, _zz__zz_when_FpUnit_l88_139_1};
  assign _zz__zz_when_FpUnit_l88_140_1 = _zz_when_FpUnit_l88_138;
  assign _zz__zz_when_FpUnit_l88_140 = {1'd0, _zz__zz_when_FpUnit_l88_140_1};
  assign _zz__zz_when_FpUnit_l88_141_1 = (_zz_when_FpUnit_l397_1 ? _zz__zz_when_FpUnit_l88_141_2 : _zz_when_FpUnit_l88_139);
  assign _zz__zz_when_FpUnit_l88_141 = {{1{_zz__zz_when_FpUnit_l88_141_1[54]}}, _zz__zz_when_FpUnit_l88_141_1};
  assign _zz__zz_when_FpUnit_l88_141_2 = (- _zz_when_FpUnit_l88_139);
  assign _zz__zz_when_FpUnit_l88_141_4 = (_zz_when_FpUnit_l397_2 ? _zz__zz_when_FpUnit_l88_141_5 : _zz_when_FpUnit_l88_140);
  assign _zz__zz_when_FpUnit_l88_141_3 = {{1{_zz__zz_when_FpUnit_l88_141_4[54]}}, _zz__zz_when_FpUnit_l88_141_4};
  assign _zz__zz_when_FpUnit_l88_141_5 = (- _zz_when_FpUnit_l88_140);
  assign _zz__zz_when_FpUnit_l88_143 = (- _zz_when_FpUnit_l88_141);
  assign _zz__zz_flagUF_75 = _zz__zz_flagUF_75_1;
  assign _zz__zz_flagUF_75_1 = {6'd0, _zz_when_FpUnit_l95_5};
  assign _zz__zz_flagUF_73_1 = (_zz_when_FpUnit_l88_143 >>> _zz_flagUF_76);
  assign _zz__zz_flagUF_73 = _zz__zz_flagUF_73_1[26:0];
  assign _zz__zz_flagUF_74 = (_zz__zz_flagUF_74_1 - 56'h00000000000001);
  assign _zz__zz_flagUF_74_2 = ({63'd0,56'h00000000000001} <<< _zz_flagUF_76);
  assign _zz__zz_flagUF_74_1 = _zz__zz_flagUF_74_2[55:0];
  assign _zz__zz_flagUF_73_3 = ({63'd0,_zz_when_FpUnit_l88_143} <<< _zz__zz_flagUF_73_4);
  assign _zz__zz_flagUF_73_2 = _zz__zz_flagUF_73_3[26:0];
  assign _zz__zz_flagUF_73_4 = (6'h1a - _zz_when_FpUnit_l95_5);
  assign _zz__zz_flagUF_77 = {2'd0, _zz_flagUF_73};
  assign _zz__zz_flagUF_80 = ($signed(_zz_flagUF_75) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l147_5 = ($signed(12'hf82) - $signed(_zz_flagUF_75));
  assign _zz__zz_flagUF_81 = _zz_flagUF_78[26:0];
  assign _zz__zz_flagUF_81_2 = (_zz_flagUF_78 >>> _zz__zz_flagUF_81_3);
  assign _zz__zz_flagUF_81_1 = _zz__zz_flagUF_81_2[26:0];
  assign _zz__zz_flagUF_81_3 = _zz_when_FpUnit_l150_5[4:0];
  assign _zz__zz_flagUF_82 = (_zz__zz_flagUF_82_1 - 29'h00000001);
  assign _zz__zz_flagUF_82_2 = ({31'd0,29'h00000001} <<< _zz__zz_flagUF_82_3);
  assign _zz__zz_flagUF_82_1 = _zz__zz_flagUF_82_2[28:0];
  assign _zz__zz_flagUF_82_3 = _zz_when_FpUnit_l150_5[4:0];
  assign _zz__zz_when_FpUnit_l190_16_1 = _zz_when_FpUnit_l190_15;
  assign _zz__zz_when_FpUnit_l190_16 = {1'd0, _zz__zz_when_FpUnit_l190_16_1};
  assign _zz__zz_when_FpUnit_l190_16_3 = ((io_rm == 3'b000) ? (_zz_flagUF_83 && ((_zz_flagUF_84 || _zz_flagUF_85) || _zz_when_FpUnit_l190_15[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_when_FpUnit_l88_142 && (_zz__zz_when_FpUnit_l190_16_4 || _zz_flagUF_85)) : ((io_rm == _zz__zz_when_FpUnit_l190_16_5) ? (_zz__zz_when_FpUnit_l190_16_6 && _zz__zz_when_FpUnit_l190_16_7) : _zz_flagUF_83))));
  assign _zz__zz_when_FpUnit_l190_16_2 = {24'd0, _zz__zz_when_FpUnit_l190_16_3};
  assign _zz__zz_when_FpUnit_l190_17 = (_zz_when_FpUnit_l190_16 >>> 1'd1);
  assign _zz__zz_when_FpUnit_l190_17_1 = _zz_when_FpUnit_l190_16[23:0];
  assign _zz__zz_when_FpUnit_l186_17 = (_zz_when_FpUnit_l186_16 ? _zz__zz_when_FpUnit_l186_17_1 : _zz_when_FpUnit_l186_15);
  assign _zz__zz_when_FpUnit_l186_17_1 = ($signed(_zz_when_FpUnit_l186_15) + $signed(12'h001));
  assign _zz__zz_res_39_1 = _zz_when_FpUnit_l186_17;
  assign _zz__zz_res_39 = _zz__zz_res_39_1[7:0];
  assign _zz__zz_when_FpUnit_l367_7_1 = ($signed(_zz_when_FpUnit_l218) + $signed(_zz_when_FpUnit_l218_1));
  assign _zz__zz_when_FpUnit_l367_7 = {{2{_zz__zz_when_FpUnit_l367_7_1[9]}}, _zz__zz_when_FpUnit_l367_7_1};
  assign _zz__zz_when_FpUnit_l367_8 = {{2{_zz_when_FpUnit_l367_1[9]}}, _zz_when_FpUnit_l367_1};
  assign _zz__zz_when_FpUnit_l88_145 = {6'd0, _zz_when_FpUnit_l88_144};
  assign _zz__zz_when_FpUnit_l88_145_1 = (_zz__zz_when_FpUnit_l88_145_2 >>> _zz_when_FpUnit_l368_2);
  assign _zz__zz_when_FpUnit_l88_145_2 = {6'd0, _zz_when_FpUnit_l88_144};
  assign _zz__zz_flagUF_87 = {6'd0, _zz_when_FpUnit_l88_144};
  assign _zz__zz_flagUF_87_1 = (_zz__zz_flagUF_87_2 - 54'h00000000000001);
  assign _zz__zz_flagUF_87_3 = ({63'd0,54'h00000000000001} <<< _zz__zz_flagUF_87_4);
  assign _zz__zz_flagUF_87_2 = _zz__zz_flagUF_87_3[53:0];
  assign _zz__zz_flagUF_87_4 = _zz_when_FpUnit_l368_2[5:0];
  assign _zz__zz_when_FpUnit_l88_146 = {30'd0, _zz_when_FpUnit_l88_2};
  assign _zz__zz_when_FpUnit_l88_146_1 = (_zz__zz_when_FpUnit_l88_146_2 >>> _zz_when_FpUnit_l368_3);
  assign _zz__zz_when_FpUnit_l88_146_2 = {30'd0, _zz_when_FpUnit_l88_2};
  assign _zz__zz_flagUF_88 = {30'd0, _zz_when_FpUnit_l88_2};
  assign _zz__zz_flagUF_88_1 = (_zz__zz_flagUF_88_2 - 54'h00000000000001);
  assign _zz__zz_flagUF_88_3 = ({63'd0,54'h00000000000001} <<< _zz__zz_flagUF_88_4);
  assign _zz__zz_flagUF_88_2 = _zz__zz_flagUF_88_3[53:0];
  assign _zz__zz_flagUF_88_4 = _zz_when_FpUnit_l368_3[5:0];
  assign _zz__zz_when_FpUnit_l88_147_1 = _zz_when_FpUnit_l88_145;
  assign _zz__zz_when_FpUnit_l88_147 = {1'd0, _zz__zz_when_FpUnit_l88_147_1};
  assign _zz__zz_when_FpUnit_l88_148_1 = _zz_when_FpUnit_l88_146;
  assign _zz__zz_when_FpUnit_l88_148 = {1'd0, _zz__zz_when_FpUnit_l88_148_1};
  assign _zz__zz_when_FpUnit_l88_149_1 = (_zz_when_FpUnit_l397_3 ? _zz__zz_when_FpUnit_l88_149_2 : _zz_when_FpUnit_l88_147);
  assign _zz__zz_when_FpUnit_l88_149 = {{1{_zz__zz_when_FpUnit_l88_149_1[54]}}, _zz__zz_when_FpUnit_l88_149_1};
  assign _zz__zz_when_FpUnit_l88_149_2 = (- _zz_when_FpUnit_l88_147);
  assign _zz__zz_when_FpUnit_l88_149_4 = (_zz_when_FpUnit_l397_4 ? _zz__zz_when_FpUnit_l88_149_5 : _zz_when_FpUnit_l88_148);
  assign _zz__zz_when_FpUnit_l88_149_3 = {{1{_zz__zz_when_FpUnit_l88_149_4[54]}}, _zz__zz_when_FpUnit_l88_149_4};
  assign _zz__zz_when_FpUnit_l88_149_5 = (- _zz_when_FpUnit_l88_148);
  assign _zz__zz_when_FpUnit_l88_151 = (- _zz_when_FpUnit_l88_149);
  assign _zz__zz_flagUF_91 = _zz__zz_flagUF_91_1;
  assign _zz__zz_flagUF_91_1 = {6'd0, _zz_when_FpUnit_l95_6};
  assign _zz__zz_flagUF_89_1 = (_zz_when_FpUnit_l88_151 >>> _zz_flagUF_92);
  assign _zz__zz_flagUF_89 = _zz__zz_flagUF_89_1[26:0];
  assign _zz__zz_flagUF_90 = (_zz__zz_flagUF_90_1 - 56'h00000000000001);
  assign _zz__zz_flagUF_90_2 = ({63'd0,56'h00000000000001} <<< _zz_flagUF_92);
  assign _zz__zz_flagUF_90_1 = _zz__zz_flagUF_90_2[55:0];
  assign _zz__zz_flagUF_89_3 = ({63'd0,_zz_when_FpUnit_l88_151} <<< _zz__zz_flagUF_89_4);
  assign _zz__zz_flagUF_89_2 = _zz__zz_flagUF_89_3[26:0];
  assign _zz__zz_flagUF_89_4 = (6'h1a - _zz_when_FpUnit_l95_6);
  assign _zz__zz_flagUF_93 = {2'd0, _zz_flagUF_89};
  assign _zz__zz_flagUF_96 = ($signed(_zz_flagUF_91) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l147_6 = ($signed(12'hf82) - $signed(_zz_flagUF_91));
  assign _zz__zz_flagUF_97 = _zz_flagUF_94[26:0];
  assign _zz__zz_flagUF_97_2 = (_zz_flagUF_94 >>> _zz__zz_flagUF_97_3);
  assign _zz__zz_flagUF_97_1 = _zz__zz_flagUF_97_2[26:0];
  assign _zz__zz_flagUF_97_3 = _zz_when_FpUnit_l150_6[4:0];
  assign _zz__zz_flagUF_98 = (_zz__zz_flagUF_98_1 - 29'h00000001);
  assign _zz__zz_flagUF_98_2 = ({31'd0,29'h00000001} <<< _zz__zz_flagUF_98_3);
  assign _zz__zz_flagUF_98_1 = _zz__zz_flagUF_98_2[28:0];
  assign _zz__zz_flagUF_98_3 = _zz_when_FpUnit_l150_6[4:0];
  assign _zz__zz_when_FpUnit_l190_19_1 = _zz_when_FpUnit_l190_18;
  assign _zz__zz_when_FpUnit_l190_19 = {1'd0, _zz__zz_when_FpUnit_l190_19_1};
  assign _zz__zz_when_FpUnit_l190_19_3 = ((io_rm == 3'b000) ? (_zz_flagUF_99 && ((_zz_flagUF_100 || _zz_flagUF_101) || _zz_when_FpUnit_l190_18[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_when_FpUnit_l88_150 && (_zz__zz_when_FpUnit_l190_19_4 || _zz_flagUF_101)) : ((io_rm == _zz__zz_when_FpUnit_l190_19_5) ? (_zz__zz_when_FpUnit_l190_19_6 && _zz__zz_when_FpUnit_l190_19_7) : _zz_flagUF_99))));
  assign _zz__zz_when_FpUnit_l190_19_2 = {24'd0, _zz__zz_when_FpUnit_l190_19_3};
  assign _zz__zz_when_FpUnit_l190_20 = (_zz_when_FpUnit_l190_19 >>> 1'd1);
  assign _zz__zz_when_FpUnit_l190_20_1 = _zz_when_FpUnit_l190_19[23:0];
  assign _zz__zz_when_FpUnit_l186_20 = (_zz_when_FpUnit_l186_19 ? _zz__zz_when_FpUnit_l186_20_1 : _zz_when_FpUnit_l186_18);
  assign _zz__zz_when_FpUnit_l186_20_1 = ($signed(_zz_when_FpUnit_l186_18) + $signed(12'h001));
  assign _zz__zz_res_43_1 = _zz_when_FpUnit_l186_20;
  assign _zz__zz_res_43 = _zz__zz_res_43_1[7:0];
  assign _zz__zz_when_FpUnit_l367_12_1 = ($signed(_zz_when_FpUnit_l218) + $signed(_zz_when_FpUnit_l218_1));
  assign _zz__zz_when_FpUnit_l367_12 = {{2{_zz__zz_when_FpUnit_l367_12_1[9]}}, _zz__zz_when_FpUnit_l367_12_1};
  assign _zz__zz_when_FpUnit_l367_13 = {{2{_zz_when_FpUnit_l367_1[9]}}, _zz_when_FpUnit_l367_1};
  assign _zz__zz_when_FpUnit_l88_153 = {6'd0, _zz_when_FpUnit_l88_152};
  assign _zz__zz_when_FpUnit_l88_153_1 = (_zz__zz_when_FpUnit_l88_153_2 >>> _zz_when_FpUnit_l368_4);
  assign _zz__zz_when_FpUnit_l88_153_2 = {6'd0, _zz_when_FpUnit_l88_152};
  assign _zz__zz_flagUF_103 = {6'd0, _zz_when_FpUnit_l88_152};
  assign _zz__zz_flagUF_103_1 = (_zz__zz_flagUF_103_2 - 54'h00000000000001);
  assign _zz__zz_flagUF_103_3 = ({63'd0,54'h00000000000001} <<< _zz__zz_flagUF_103_4);
  assign _zz__zz_flagUF_103_2 = _zz__zz_flagUF_103_3[53:0];
  assign _zz__zz_flagUF_103_4 = _zz_when_FpUnit_l368_4[5:0];
  assign _zz__zz_when_FpUnit_l88_154 = {30'd0, _zz_when_FpUnit_l88_2};
  assign _zz__zz_when_FpUnit_l88_154_1 = (_zz__zz_when_FpUnit_l88_154_2 >>> _zz_when_FpUnit_l368_5);
  assign _zz__zz_when_FpUnit_l88_154_2 = {30'd0, _zz_when_FpUnit_l88_2};
  assign _zz__zz_flagUF_104 = {30'd0, _zz_when_FpUnit_l88_2};
  assign _zz__zz_flagUF_104_1 = (_zz__zz_flagUF_104_2 - 54'h00000000000001);
  assign _zz__zz_flagUF_104_3 = ({63'd0,54'h00000000000001} <<< _zz__zz_flagUF_104_4);
  assign _zz__zz_flagUF_104_2 = _zz__zz_flagUF_104_3[53:0];
  assign _zz__zz_flagUF_104_4 = _zz_when_FpUnit_l368_5[5:0];
  assign _zz__zz_when_FpUnit_l88_155_1 = _zz_when_FpUnit_l88_153;
  assign _zz__zz_when_FpUnit_l88_155 = {1'd0, _zz__zz_when_FpUnit_l88_155_1};
  assign _zz__zz_when_FpUnit_l88_156_1 = _zz_when_FpUnit_l88_154;
  assign _zz__zz_when_FpUnit_l88_156 = {1'd0, _zz__zz_when_FpUnit_l88_156_1};
  assign _zz__zz_when_FpUnit_l88_157_1 = (_zz_when_FpUnit_l397_5 ? _zz__zz_when_FpUnit_l88_157_2 : _zz_when_FpUnit_l88_155);
  assign _zz__zz_when_FpUnit_l88_157 = {{1{_zz__zz_when_FpUnit_l88_157_1[54]}}, _zz__zz_when_FpUnit_l88_157_1};
  assign _zz__zz_when_FpUnit_l88_157_2 = (- _zz_when_FpUnit_l88_155);
  assign _zz__zz_when_FpUnit_l88_157_4 = (_zz_when_FpUnit_l397_6 ? _zz__zz_when_FpUnit_l88_157_5 : _zz_when_FpUnit_l88_156);
  assign _zz__zz_when_FpUnit_l88_157_3 = {{1{_zz__zz_when_FpUnit_l88_157_4[54]}}, _zz__zz_when_FpUnit_l88_157_4};
  assign _zz__zz_when_FpUnit_l88_157_5 = (- _zz_when_FpUnit_l88_156);
  assign _zz__zz_when_FpUnit_l88_159 = (- _zz_when_FpUnit_l88_157);
  assign _zz__zz_flagUF_107 = _zz__zz_flagUF_107_1;
  assign _zz__zz_flagUF_107_1 = {6'd0, _zz_when_FpUnit_l95_7};
  assign _zz__zz_flagUF_105_1 = (_zz_when_FpUnit_l88_159 >>> _zz_flagUF_108);
  assign _zz__zz_flagUF_105 = _zz__zz_flagUF_105_1[26:0];
  assign _zz__zz_flagUF_106 = (_zz__zz_flagUF_106_1 - 56'h00000000000001);
  assign _zz__zz_flagUF_106_2 = ({63'd0,56'h00000000000001} <<< _zz_flagUF_108);
  assign _zz__zz_flagUF_106_1 = _zz__zz_flagUF_106_2[55:0];
  assign _zz__zz_flagUF_105_3 = ({63'd0,_zz_when_FpUnit_l88_159} <<< _zz__zz_flagUF_105_4);
  assign _zz__zz_flagUF_105_2 = _zz__zz_flagUF_105_3[26:0];
  assign _zz__zz_flagUF_105_4 = (6'h1a - _zz_when_FpUnit_l95_7);
  assign _zz__zz_flagUF_109 = {2'd0, _zz_flagUF_105};
  assign _zz__zz_flagUF_112 = ($signed(_zz_flagUF_107) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l147_7 = ($signed(12'hf82) - $signed(_zz_flagUF_107));
  assign _zz__zz_flagUF_113 = _zz_flagUF_110[26:0];
  assign _zz__zz_flagUF_113_2 = (_zz_flagUF_110 >>> _zz__zz_flagUF_113_3);
  assign _zz__zz_flagUF_113_1 = _zz__zz_flagUF_113_2[26:0];
  assign _zz__zz_flagUF_113_3 = _zz_when_FpUnit_l150_7[4:0];
  assign _zz__zz_flagUF_114 = (_zz__zz_flagUF_114_1 - 29'h00000001);
  assign _zz__zz_flagUF_114_2 = ({31'd0,29'h00000001} <<< _zz__zz_flagUF_114_3);
  assign _zz__zz_flagUF_114_1 = _zz__zz_flagUF_114_2[28:0];
  assign _zz__zz_flagUF_114_3 = _zz_when_FpUnit_l150_7[4:0];
  assign _zz__zz_when_FpUnit_l190_22_1 = _zz_when_FpUnit_l190_21;
  assign _zz__zz_when_FpUnit_l190_22 = {1'd0, _zz__zz_when_FpUnit_l190_22_1};
  assign _zz__zz_when_FpUnit_l190_22_3 = ((io_rm == 3'b000) ? (_zz_flagUF_115 && ((_zz_flagUF_116 || _zz_flagUF_117) || _zz_when_FpUnit_l190_21[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_when_FpUnit_l88_158 && (_zz__zz_when_FpUnit_l190_22_4 || _zz_flagUF_117)) : ((io_rm == _zz__zz_when_FpUnit_l190_22_5) ? (_zz__zz_when_FpUnit_l190_22_6 && _zz__zz_when_FpUnit_l190_22_7) : _zz_flagUF_115))));
  assign _zz__zz_when_FpUnit_l190_22_2 = {24'd0, _zz__zz_when_FpUnit_l190_22_3};
  assign _zz__zz_when_FpUnit_l190_23 = (_zz_when_FpUnit_l190_22 >>> 1'd1);
  assign _zz__zz_when_FpUnit_l190_23_1 = _zz_when_FpUnit_l190_22[23:0];
  assign _zz__zz_when_FpUnit_l186_23 = (_zz_when_FpUnit_l186_22 ? _zz__zz_when_FpUnit_l186_23_1 : _zz_when_FpUnit_l186_21);
  assign _zz__zz_when_FpUnit_l186_23_1 = ($signed(_zz_when_FpUnit_l186_21) + $signed(12'h001));
  assign _zz__zz_res_47_1 = _zz_when_FpUnit_l186_23;
  assign _zz__zz_res_47 = _zz__zz_res_47_1[7:0];
  assign _zz__zz_when_FpUnit_l367_17_1 = ($signed(_zz_when_FpUnit_l218) + $signed(_zz_when_FpUnit_l218_1));
  assign _zz__zz_when_FpUnit_l367_17 = {{2{_zz__zz_when_FpUnit_l367_17_1[9]}}, _zz__zz_when_FpUnit_l367_17_1};
  assign _zz__zz_when_FpUnit_l367_18 = {{2{_zz_when_FpUnit_l367_1[9]}}, _zz_when_FpUnit_l367_1};
  assign _zz__zz_when_FpUnit_l88_161 = {6'd0, _zz_when_FpUnit_l88_160};
  assign _zz__zz_when_FpUnit_l88_161_1 = (_zz__zz_when_FpUnit_l88_161_2 >>> _zz_when_FpUnit_l368_6);
  assign _zz__zz_when_FpUnit_l88_161_2 = {6'd0, _zz_when_FpUnit_l88_160};
  assign _zz__zz_flagUF_119 = {6'd0, _zz_when_FpUnit_l88_160};
  assign _zz__zz_flagUF_119_1 = (_zz__zz_flagUF_119_2 - 54'h00000000000001);
  assign _zz__zz_flagUF_119_3 = ({63'd0,54'h00000000000001} <<< _zz__zz_flagUF_119_4);
  assign _zz__zz_flagUF_119_2 = _zz__zz_flagUF_119_3[53:0];
  assign _zz__zz_flagUF_119_4 = _zz_when_FpUnit_l368_6[5:0];
  assign _zz__zz_when_FpUnit_l88_162 = {30'd0, _zz_when_FpUnit_l88_2};
  assign _zz__zz_when_FpUnit_l88_162_1 = (_zz__zz_when_FpUnit_l88_162_2 >>> _zz_when_FpUnit_l368_7);
  assign _zz__zz_when_FpUnit_l88_162_2 = {30'd0, _zz_when_FpUnit_l88_2};
  assign _zz__zz_flagUF_120 = {30'd0, _zz_when_FpUnit_l88_2};
  assign _zz__zz_flagUF_120_1 = (_zz__zz_flagUF_120_2 - 54'h00000000000001);
  assign _zz__zz_flagUF_120_3 = ({63'd0,54'h00000000000001} <<< _zz__zz_flagUF_120_4);
  assign _zz__zz_flagUF_120_2 = _zz__zz_flagUF_120_3[53:0];
  assign _zz__zz_flagUF_120_4 = _zz_when_FpUnit_l368_7[5:0];
  assign _zz__zz_when_FpUnit_l88_163_1 = _zz_when_FpUnit_l88_161;
  assign _zz__zz_when_FpUnit_l88_163 = {1'd0, _zz__zz_when_FpUnit_l88_163_1};
  assign _zz__zz_when_FpUnit_l88_164_1 = _zz_when_FpUnit_l88_162;
  assign _zz__zz_when_FpUnit_l88_164 = {1'd0, _zz__zz_when_FpUnit_l88_164_1};
  assign _zz__zz_when_FpUnit_l88_165_1 = (_zz_when_FpUnit_l397_7 ? _zz__zz_when_FpUnit_l88_165_2 : _zz_when_FpUnit_l88_163);
  assign _zz__zz_when_FpUnit_l88_165 = {{1{_zz__zz_when_FpUnit_l88_165_1[54]}}, _zz__zz_when_FpUnit_l88_165_1};
  assign _zz__zz_when_FpUnit_l88_165_2 = (- _zz_when_FpUnit_l88_163);
  assign _zz__zz_when_FpUnit_l88_165_4 = (_zz_when_FpUnit_l397_8 ? _zz__zz_when_FpUnit_l88_165_5 : _zz_when_FpUnit_l88_164);
  assign _zz__zz_when_FpUnit_l88_165_3 = {{1{_zz__zz_when_FpUnit_l88_165_4[54]}}, _zz__zz_when_FpUnit_l88_165_4};
  assign _zz__zz_when_FpUnit_l88_165_5 = (- _zz_when_FpUnit_l88_164);
  assign _zz__zz_when_FpUnit_l88_167 = (- _zz_when_FpUnit_l88_165);
  assign _zz__zz_flagUF_123 = _zz__zz_flagUF_123_1;
  assign _zz__zz_flagUF_123_1 = {6'd0, _zz_when_FpUnit_l95_8};
  assign _zz__zz_flagUF_121_1 = (_zz_when_FpUnit_l88_167 >>> _zz_flagUF_124);
  assign _zz__zz_flagUF_121 = _zz__zz_flagUF_121_1[26:0];
  assign _zz__zz_flagUF_122 = (_zz__zz_flagUF_122_1 - 56'h00000000000001);
  assign _zz__zz_flagUF_122_2 = ({63'd0,56'h00000000000001} <<< _zz_flagUF_124);
  assign _zz__zz_flagUF_122_1 = _zz__zz_flagUF_122_2[55:0];
  assign _zz__zz_flagUF_121_3 = ({63'd0,_zz_when_FpUnit_l88_167} <<< _zz__zz_flagUF_121_4);
  assign _zz__zz_flagUF_121_2 = _zz__zz_flagUF_121_3[26:0];
  assign _zz__zz_flagUF_121_4 = (6'h1a - _zz_when_FpUnit_l95_8);
  assign _zz__zz_flagUF_125 = {2'd0, _zz_flagUF_121};
  assign _zz__zz_flagUF_128 = ($signed(_zz_flagUF_123) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l147_8 = ($signed(12'hf82) - $signed(_zz_flagUF_123));
  assign _zz__zz_flagUF_129 = _zz_flagUF_126[26:0];
  assign _zz__zz_flagUF_129_2 = (_zz_flagUF_126 >>> _zz__zz_flagUF_129_3);
  assign _zz__zz_flagUF_129_1 = _zz__zz_flagUF_129_2[26:0];
  assign _zz__zz_flagUF_129_3 = _zz_when_FpUnit_l150_8[4:0];
  assign _zz__zz_flagUF_130 = (_zz__zz_flagUF_130_1 - 29'h00000001);
  assign _zz__zz_flagUF_130_2 = ({31'd0,29'h00000001} <<< _zz__zz_flagUF_130_3);
  assign _zz__zz_flagUF_130_1 = _zz__zz_flagUF_130_2[28:0];
  assign _zz__zz_flagUF_130_3 = _zz_when_FpUnit_l150_8[4:0];
  assign _zz__zz_when_FpUnit_l190_25_1 = _zz_when_FpUnit_l190_24;
  assign _zz__zz_when_FpUnit_l190_25 = {1'd0, _zz__zz_when_FpUnit_l190_25_1};
  assign _zz__zz_when_FpUnit_l190_25_3 = ((io_rm == 3'b000) ? (_zz_flagUF_131 && ((_zz_flagUF_132 || _zz_flagUF_133) || _zz_when_FpUnit_l190_24[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_when_FpUnit_l88_166 && (_zz__zz_when_FpUnit_l190_25_4 || _zz_flagUF_133)) : ((io_rm == _zz__zz_when_FpUnit_l190_25_5) ? (_zz__zz_when_FpUnit_l190_25_6 && _zz__zz_when_FpUnit_l190_25_7) : _zz_flagUF_131))));
  assign _zz__zz_when_FpUnit_l190_25_2 = {24'd0, _zz__zz_when_FpUnit_l190_25_3};
  assign _zz__zz_when_FpUnit_l190_26 = (_zz_when_FpUnit_l190_25 >>> 1'd1);
  assign _zz__zz_when_FpUnit_l190_26_1 = _zz_when_FpUnit_l190_25[23:0];
  assign _zz__zz_when_FpUnit_l186_26 = (_zz_when_FpUnit_l186_25 ? _zz__zz_when_FpUnit_l186_26_1 : _zz_when_FpUnit_l186_24);
  assign _zz__zz_when_FpUnit_l186_26_1 = ($signed(_zz_when_FpUnit_l186_24) + $signed(12'h001));
  assign _zz__zz_res_51_1 = _zz_when_FpUnit_l186_26;
  assign _zz__zz_res_51 = _zz__zz_res_51_1[7:0];
  assign _zz__zz_when_FpUnit_l485 = {{2{_zz_when_FpUnit_l218[9]}}, _zz_when_FpUnit_l218};
  assign _zz__zz_flagNX_1 = (- _zz_when_FpUnit_l485);
  assign _zz__zz_when_FpUnit_l512 = (_zz_when_FpUnit_l88 >>> _zz_flagNX_1);
  assign _zz__zz_flagNX = (_zz__zz_flagNX_2 - 24'h000001);
  assign _zz__zz_flagNX_3 = ({31'd0,24'h000001} <<< _zz__zz_flagNX_4);
  assign _zz__zz_flagNX_2 = _zz__zz_flagNX_3[23:0];
  assign _zz__zz_flagNX_4 = _zz_flagNX_1[4:0];
  assign _zz__zz_when_FpUnit_l512_1 = ({63'd0,_zz__zz_when_FpUnit_l512_2} <<< _zz__zz_when_FpUnit_l512_3);
  assign _zz__zz_when_FpUnit_l512_2 = {10'd0, _zz_when_FpUnit_l88};
  assign _zz__zz_when_FpUnit_l512_4 = _zz_when_FpUnit_l485;
  assign _zz__zz_when_FpUnit_l512_3 = _zz__zz_when_FpUnit_l512_4[5:0];
  assign _zz__zz_when_FpUnit_l512_1_2 = ((io_rm == 3'b000) ? (_zz_flagNX && _zz_when_FpUnit_l512[0]) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (when_FpUnit_l519 && _zz_flagNX) : ((io_rm == 3'b011) ? ((! when_FpUnit_l519) && _zz_flagNX) : _zz_flagNX))));
  assign _zz__zz_when_FpUnit_l512_1_1 = {33'd0, _zz__zz_when_FpUnit_l512_1_2};
  assign _zz__zz_res_53 = _zz_when_FpUnit_l512_1[31:0];
  assign _zz_res_89 = _zz_res_53;
  assign _zz_res_88 = {{32{_zz_res_89[31]}}, _zz_res_89};
  assign _zz__zz_when_FpUnit_l485_1 = {{2{_zz_when_FpUnit_l218[9]}}, _zz_when_FpUnit_l218};
  assign _zz__zz_flagNX_3_1 = (- _zz_when_FpUnit_l485_1);
  assign _zz__zz_when_FpUnit_l512_2_1 = (_zz_when_FpUnit_l88 >>> _zz_flagNX_3);
  assign _zz__zz_flagNX_2_1 = (_zz__zz_flagNX_2_2 - 24'h000001);
  assign _zz__zz_flagNX_2_3 = ({31'd0,24'h000001} <<< _zz__zz_flagNX_2_4);
  assign _zz__zz_flagNX_2_2 = _zz__zz_flagNX_2_3[23:0];
  assign _zz__zz_flagNX_2_4 = _zz_flagNX_3[4:0];
  assign _zz__zz_when_FpUnit_l512_2_2 = ({63'd0,_zz__zz_when_FpUnit_l512_2_3} <<< _zz__zz_when_FpUnit_l512_2_4);
  assign _zz__zz_when_FpUnit_l512_2_3 = {10'd0, _zz_when_FpUnit_l88};
  assign _zz__zz_when_FpUnit_l512_2_5 = _zz_when_FpUnit_l485_1;
  assign _zz__zz_when_FpUnit_l512_2_4 = _zz__zz_when_FpUnit_l512_2_5[5:0];
  assign _zz__zz_when_FpUnit_l512_3_2 = ((io_rm == 3'b000) ? (_zz_flagNX_2 && _zz_when_FpUnit_l512_2[0]) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (when_FpUnit_l519 && _zz_flagNX_2) : ((io_rm == 3'b011) ? ((! when_FpUnit_l519) && _zz_flagNX_2) : _zz_flagNX_2))));
  assign _zz__zz_when_FpUnit_l512_3_1 = {33'd0, _zz__zz_when_FpUnit_l512_3_2};
  assign _zz__zz_res_54 = _zz_when_FpUnit_l512_3[31:0];
  assign _zz_res_90 = {32'd0, _zz_res_54};
  assign _zz__zz_when_FpUnit_l485_2 = {{2{_zz_when_FpUnit_l218[9]}}, _zz_when_FpUnit_l218};
  assign _zz__zz_flagNX_5 = (- _zz_when_FpUnit_l485_2);
  assign _zz__zz_when_FpUnit_l512_4_1 = (_zz_when_FpUnit_l88 >>> _zz_flagNX_5);
  assign _zz__zz_flagNX_4_1 = (_zz__zz_flagNX_4_2 - 24'h000001);
  assign _zz__zz_flagNX_4_3 = ({31'd0,24'h000001} <<< _zz__zz_flagNX_4_4);
  assign _zz__zz_flagNX_4_2 = _zz__zz_flagNX_4_3[23:0];
  assign _zz__zz_flagNX_4_4 = _zz_flagNX_5[4:0];
  assign _zz__zz_when_FpUnit_l512_4_2 = ({127'd0,_zz__zz_when_FpUnit_l512_4_3} <<< _zz__zz_when_FpUnit_l512_4_4);
  assign _zz__zz_when_FpUnit_l512_4_3 = {42'd0, _zz_when_FpUnit_l88};
  assign _zz__zz_when_FpUnit_l512_4_5 = _zz_when_FpUnit_l485_2;
  assign _zz__zz_when_FpUnit_l512_4_4 = _zz__zz_when_FpUnit_l512_4_5[6:0];
  assign _zz__zz_when_FpUnit_l512_5_1 = ((io_rm == 3'b000) ? (_zz_flagNX_4 && _zz_when_FpUnit_l512_4[0]) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (when_FpUnit_l519 && _zz_flagNX_4) : ((io_rm == 3'b011) ? ((! when_FpUnit_l519) && _zz_flagNX_4) : _zz_flagNX_4))));
  assign _zz__zz_when_FpUnit_l512_5 = {65'd0, _zz__zz_when_FpUnit_l512_5_1};
  assign _zz__zz_res_55 = _zz_when_FpUnit_l512_5[63:0];
  assign _zz_res_91 = _zz_res_55;
  assign _zz__zz_when_FpUnit_l485_3 = {{2{_zz_when_FpUnit_l218[9]}}, _zz_when_FpUnit_l218};
  assign _zz__zz_flagNX_7 = (- _zz_when_FpUnit_l485_3);
  assign _zz__zz_when_FpUnit_l512_6 = (_zz_when_FpUnit_l88 >>> _zz_flagNX_7);
  assign _zz__zz_flagNX_6 = (_zz__zz_flagNX_6_1 - 24'h000001);
  assign _zz__zz_flagNX_6_2 = ({31'd0,24'h000001} <<< _zz__zz_flagNX_6_3);
  assign _zz__zz_flagNX_6_1 = _zz__zz_flagNX_6_2[23:0];
  assign _zz__zz_flagNX_6_3 = _zz_flagNX_7[4:0];
  assign _zz__zz_when_FpUnit_l512_6_1 = ({127'd0,_zz__zz_when_FpUnit_l512_6_2} <<< _zz__zz_when_FpUnit_l512_6_3);
  assign _zz__zz_when_FpUnit_l512_6_2 = {42'd0, _zz_when_FpUnit_l88};
  assign _zz__zz_when_FpUnit_l512_6_4 = _zz_when_FpUnit_l485_3;
  assign _zz__zz_when_FpUnit_l512_6_3 = _zz__zz_when_FpUnit_l512_6_4[6:0];
  assign _zz__zz_when_FpUnit_l512_7_1 = ((io_rm == 3'b000) ? (_zz_flagNX_6 && _zz_when_FpUnit_l512_6[0]) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (when_FpUnit_l519 && _zz_flagNX_6) : ((io_rm == 3'b011) ? ((! when_FpUnit_l519) && _zz_flagNX_6) : _zz_flagNX_6))));
  assign _zz__zz_when_FpUnit_l512_7 = {65'd0, _zz__zz_when_FpUnit_l512_7_1};
  assign _zz__zz_res_56 = _zz_when_FpUnit_l512_7[63:0];
  assign _zz__zz_when_FpUnit_l88_169 = (56'h0 - _zz__zz_when_FpUnit_l88_169_1);
  assign _zz__zz_when_FpUnit_l88_169_1 = {24'd0, _zz_when_FpUnit_l88_168};
  assign _zz__zz_when_FpUnit_l88_169_2 = {24'd0, _zz_when_FpUnit_l88_168};
  assign _zz__zz_when_FpUnit_l147_9 = _zz__zz_when_FpUnit_l147_9_1;
  assign _zz__zz_when_FpUnit_l147_9_1 = {6'd0, _zz_when_FpUnit_l95_9};
  assign _zz__zz_flagNX_8_1 = (_zz_when_FpUnit_l88_169 >>> _zz_flagNX_10);
  assign _zz__zz_flagNX_8 = _zz__zz_flagNX_8_1[26:0];
  assign _zz__zz_flagNX_9 = (_zz__zz_flagNX_9_1 - 56'h00000000000001);
  assign _zz__zz_flagNX_9_2 = ({63'd0,56'h00000000000001} <<< _zz_flagNX_10);
  assign _zz__zz_flagNX_9_1 = _zz__zz_flagNX_9_2[55:0];
  assign _zz__zz_flagNX_8_3 = ({63'd0,_zz_when_FpUnit_l88_169} <<< _zz__zz_flagNX_8_4);
  assign _zz__zz_flagNX_8_2 = _zz__zz_flagNX_8_3[26:0];
  assign _zz__zz_flagNX_8_4 = (6'h1a - _zz_when_FpUnit_l95_9);
  assign _zz__zz_flagNX_11 = {2'd0, _zz_flagNX_8};
  assign _zz__zz_when_FpUnit_l190_27 = ($signed(_zz_when_FpUnit_l147_9) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l147_10 = ($signed(12'hf82) - $signed(_zz_when_FpUnit_l147_9));
  assign _zz__zz_flagNX_14 = _zz_flagNX_12[26:0];
  assign _zz__zz_flagNX_14_2 = (_zz_flagNX_12 >>> _zz__zz_flagNX_14_3);
  assign _zz__zz_flagNX_14_1 = _zz__zz_flagNX_14_2[26:0];
  assign _zz__zz_flagNX_14_3 = _zz_when_FpUnit_l150_9[4:0];
  assign _zz__zz_flagNX_15 = (_zz__zz_flagNX_15_1 - 29'h00000001);
  assign _zz__zz_flagNX_15_2 = ({31'd0,29'h00000001} <<< _zz__zz_flagNX_15_3);
  assign _zz__zz_flagNX_15_1 = _zz__zz_flagNX_15_2[28:0];
  assign _zz__zz_flagNX_15_3 = _zz_when_FpUnit_l150_9[4:0];
  assign _zz__zz_when_FpUnit_l190_29_1 = _zz_when_FpUnit_l190_28;
  assign _zz__zz_when_FpUnit_l190_29 = {1'd0, _zz__zz_when_FpUnit_l190_29_1};
  assign _zz__zz_when_FpUnit_l190_29_3 = ((io_rm == 3'b000) ? (_zz_flagNX_16 && ((_zz_flagNX_17 || _zz_flagNX_18) || _zz_when_FpUnit_l190_28[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_res_57 && (_zz__zz_when_FpUnit_l190_29_4 || _zz_flagNX_18)) : ((io_rm == _zz__zz_when_FpUnit_l190_29_5) ? (_zz__zz_when_FpUnit_l190_29_6 && _zz__zz_when_FpUnit_l190_29_7) : _zz_flagNX_16))));
  assign _zz__zz_when_FpUnit_l190_29_2 = {24'd0, _zz__zz_when_FpUnit_l190_29_3};
  assign _zz__zz_when_FpUnit_l190_30 = (_zz_when_FpUnit_l190_29 >>> 1'd1);
  assign _zz__zz_when_FpUnit_l190_30_1 = _zz_when_FpUnit_l190_29[23:0];
  assign _zz__zz_when_FpUnit_l186_29 = (_zz_when_FpUnit_l186_28 ? _zz__zz_when_FpUnit_l186_29_1 : _zz_when_FpUnit_l186_27);
  assign _zz__zz_when_FpUnit_l186_29_1 = ($signed(_zz_when_FpUnit_l186_27) + $signed(12'h001));
  assign _zz__zz_res_60_1 = _zz_when_FpUnit_l186_29;
  assign _zz__zz_res_60 = _zz__zz_res_60_1[7:0];
  assign _zz__zz_when_FpUnit_l88_171 = (56'h0 - _zz__zz_when_FpUnit_l88_171_1);
  assign _zz__zz_when_FpUnit_l88_171_1 = {24'd0, _zz_when_FpUnit_l88_170};
  assign _zz__zz_when_FpUnit_l88_171_2 = {24'd0, _zz_when_FpUnit_l88_170};
  assign _zz__zz_when_FpUnit_l147_11 = _zz__zz_when_FpUnit_l147_11_1;
  assign _zz__zz_when_FpUnit_l147_11_1 = {6'd0, _zz_when_FpUnit_l95_10};
  assign _zz__zz_flagNX_19_1 = (_zz_when_FpUnit_l88_171 >>> _zz_flagNX_21);
  assign _zz__zz_flagNX_19 = _zz__zz_flagNX_19_1[26:0];
  assign _zz__zz_flagNX_20 = (_zz__zz_flagNX_20_1 - 56'h00000000000001);
  assign _zz__zz_flagNX_20_2 = ({63'd0,56'h00000000000001} <<< _zz_flagNX_21);
  assign _zz__zz_flagNX_20_1 = _zz__zz_flagNX_20_2[55:0];
  assign _zz__zz_flagNX_19_3 = ({63'd0,_zz_when_FpUnit_l88_171} <<< _zz__zz_flagNX_19_4);
  assign _zz__zz_flagNX_19_2 = _zz__zz_flagNX_19_3[26:0];
  assign _zz__zz_flagNX_19_4 = (6'h1a - _zz_when_FpUnit_l95_10);
  assign _zz__zz_flagNX_22 = {2'd0, _zz_flagNX_19};
  assign _zz__zz_when_FpUnit_l190_31 = ($signed(_zz_when_FpUnit_l147_11) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l147_12 = ($signed(12'hf82) - $signed(_zz_when_FpUnit_l147_11));
  assign _zz__zz_flagNX_25 = _zz_flagNX_23[26:0];
  assign _zz__zz_flagNX_25_2 = (_zz_flagNX_23 >>> _zz__zz_flagNX_25_3);
  assign _zz__zz_flagNX_25_1 = _zz__zz_flagNX_25_2[26:0];
  assign _zz__zz_flagNX_25_3 = _zz_when_FpUnit_l150_10[4:0];
  assign _zz__zz_flagNX_26 = (_zz__zz_flagNX_26_1 - 29'h00000001);
  assign _zz__zz_flagNX_26_2 = ({31'd0,29'h00000001} <<< _zz__zz_flagNX_26_3);
  assign _zz__zz_flagNX_26_1 = _zz__zz_flagNX_26_2[28:0];
  assign _zz__zz_flagNX_26_3 = _zz_when_FpUnit_l150_10[4:0];
  assign _zz__zz_when_FpUnit_l190_33_1 = _zz_when_FpUnit_l190_32;
  assign _zz__zz_when_FpUnit_l190_33 = {1'd0, _zz__zz_when_FpUnit_l190_33_1};
  assign _zz__zz_when_FpUnit_l190_33_3 = ((io_rm == 3'b000) ? (_zz_flagNX_27 && ((_zz_flagNX_28 || _zz_flagNX_29) || _zz_when_FpUnit_l190_32[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_res_62 && (_zz__zz_when_FpUnit_l190_33_4 || _zz_flagNX_29)) : ((io_rm == _zz__zz_when_FpUnit_l190_33_5) ? (_zz__zz_when_FpUnit_l190_33_6 && _zz__zz_when_FpUnit_l190_33_7) : _zz_flagNX_27))));
  assign _zz__zz_when_FpUnit_l190_33_2 = {24'd0, _zz__zz_when_FpUnit_l190_33_3};
  assign _zz__zz_when_FpUnit_l190_34 = (_zz_when_FpUnit_l190_33 >>> 1'd1);
  assign _zz__zz_when_FpUnit_l190_34_1 = _zz_when_FpUnit_l190_33[23:0];
  assign _zz__zz_when_FpUnit_l186_32 = (_zz_when_FpUnit_l186_31 ? _zz__zz_when_FpUnit_l186_32_1 : _zz_when_FpUnit_l186_30);
  assign _zz__zz_when_FpUnit_l186_32_1 = ($signed(_zz_when_FpUnit_l186_30) + $signed(12'h001));
  assign _zz__zz_res_65_1 = _zz_when_FpUnit_l186_32;
  assign _zz__zz_res_65 = _zz__zz_res_65_1[7:0];
  assign _zz__zz_when_FpUnit_l88_173 = (88'h0 - _zz__zz_when_FpUnit_l88_173_1);
  assign _zz__zz_when_FpUnit_l88_173_1 = {24'd0, _zz_when_FpUnit_l88_172};
  assign _zz__zz_when_FpUnit_l88_173_2 = {24'd0, _zz_when_FpUnit_l88_172};
  assign _zz__zz_when_FpUnit_l147_13 = _zz__zz_when_FpUnit_l147_13_1;
  assign _zz__zz_when_FpUnit_l147_13_1 = {5'd0, _zz_when_FpUnit_l95_11};
  assign _zz__zz_flagNX_30_1 = (_zz_when_FpUnit_l88_173 >>> _zz_flagNX_32);
  assign _zz__zz_flagNX_30 = _zz__zz_flagNX_30_1[26:0];
  assign _zz__zz_flagNX_31 = (_zz__zz_flagNX_31_1 - 88'h0000000000000000000001);
  assign _zz__zz_flagNX_31_2 = ({127'd0,88'h0000000000000000000001} <<< _zz_flagNX_32);
  assign _zz__zz_flagNX_31_1 = _zz__zz_flagNX_31_2[87:0];
  assign _zz__zz_flagNX_30_3 = ({127'd0,_zz_when_FpUnit_l88_173} <<< _zz__zz_flagNX_30_4);
  assign _zz__zz_flagNX_30_2 = _zz__zz_flagNX_30_3[26:0];
  assign _zz__zz_flagNX_30_4 = (7'h1a - _zz_when_FpUnit_l95_11);
  assign _zz__zz_flagNX_33 = {2'd0, _zz_flagNX_30};
  assign _zz__zz_when_FpUnit_l190_35 = ($signed(_zz_when_FpUnit_l147_13) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l147_14 = ($signed(12'hf82) - $signed(_zz_when_FpUnit_l147_13));
  assign _zz__zz_flagNX_36 = _zz_flagNX_34[26:0];
  assign _zz__zz_flagNX_36_2 = (_zz_flagNX_34 >>> _zz__zz_flagNX_36_3);
  assign _zz__zz_flagNX_36_1 = _zz__zz_flagNX_36_2[26:0];
  assign _zz__zz_flagNX_36_3 = _zz_when_FpUnit_l150_11[4:0];
  assign _zz__zz_flagNX_37 = (_zz__zz_flagNX_37_1 - 29'h00000001);
  assign _zz__zz_flagNX_37_2 = ({31'd0,29'h00000001} <<< _zz__zz_flagNX_37_3);
  assign _zz__zz_flagNX_37_1 = _zz__zz_flagNX_37_2[28:0];
  assign _zz__zz_flagNX_37_3 = _zz_when_FpUnit_l150_11[4:0];
  assign _zz__zz_when_FpUnit_l190_37_1 = _zz_when_FpUnit_l190_36;
  assign _zz__zz_when_FpUnit_l190_37 = {1'd0, _zz__zz_when_FpUnit_l190_37_1};
  assign _zz__zz_when_FpUnit_l190_37_3 = ((io_rm == 3'b000) ? (_zz_flagNX_38 && ((_zz_flagNX_39 || _zz_flagNX_40) || _zz_when_FpUnit_l190_36[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_res_67 && (_zz__zz_when_FpUnit_l190_37_4 || _zz_flagNX_40)) : ((io_rm == _zz__zz_when_FpUnit_l190_37_5) ? (_zz__zz_when_FpUnit_l190_37_6 && _zz__zz_when_FpUnit_l190_37_7) : _zz_flagNX_38))));
  assign _zz__zz_when_FpUnit_l190_37_2 = {24'd0, _zz__zz_when_FpUnit_l190_37_3};
  assign _zz__zz_when_FpUnit_l190_38 = (_zz_when_FpUnit_l190_37 >>> 1'd1);
  assign _zz__zz_when_FpUnit_l190_38_1 = _zz_when_FpUnit_l190_37[23:0];
  assign _zz__zz_when_FpUnit_l186_35 = (_zz_when_FpUnit_l186_34 ? _zz__zz_when_FpUnit_l186_35_1 : _zz_when_FpUnit_l186_33);
  assign _zz__zz_when_FpUnit_l186_35_1 = ($signed(_zz_when_FpUnit_l186_33) + $signed(12'h001));
  assign _zz__zz_res_70_1 = _zz_when_FpUnit_l186_35;
  assign _zz__zz_res_70 = _zz__zz_res_70_1[7:0];
  assign _zz__zz_when_FpUnit_l88_175 = (88'h0 - _zz__zz_when_FpUnit_l88_175_1);
  assign _zz__zz_when_FpUnit_l88_175_1 = {24'd0, _zz_when_FpUnit_l88_174};
  assign _zz__zz_when_FpUnit_l88_175_2 = {24'd0, _zz_when_FpUnit_l88_174};
  assign _zz__zz_when_FpUnit_l147_15 = _zz__zz_when_FpUnit_l147_15_1;
  assign _zz__zz_when_FpUnit_l147_15_1 = {5'd0, _zz_when_FpUnit_l95_12};
  assign _zz__zz_flagNX_41_1 = (_zz_when_FpUnit_l88_175 >>> _zz_flagNX_43);
  assign _zz__zz_flagNX_41 = _zz__zz_flagNX_41_1[26:0];
  assign _zz__zz_flagNX_42 = (_zz__zz_flagNX_42_1 - 88'h0000000000000000000001);
  assign _zz__zz_flagNX_42_2 = ({127'd0,88'h0000000000000000000001} <<< _zz_flagNX_43);
  assign _zz__zz_flagNX_42_1 = _zz__zz_flagNX_42_2[87:0];
  assign _zz__zz_flagNX_41_3 = ({127'd0,_zz_when_FpUnit_l88_175} <<< _zz__zz_flagNX_41_4);
  assign _zz__zz_flagNX_41_2 = _zz__zz_flagNX_41_3[26:0];
  assign _zz__zz_flagNX_41_4 = (7'h1a - _zz_when_FpUnit_l95_12);
  assign _zz__zz_flagNX_44 = {2'd0, _zz_flagNX_41};
  assign _zz__zz_when_FpUnit_l190_39 = ($signed(_zz_when_FpUnit_l147_15) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l147_16 = ($signed(12'hf82) - $signed(_zz_when_FpUnit_l147_15));
  assign _zz__zz_flagNX_47 = _zz_flagNX_45[26:0];
  assign _zz__zz_flagNX_47_2 = (_zz_flagNX_45 >>> _zz__zz_flagNX_47_3);
  assign _zz__zz_flagNX_47_1 = _zz__zz_flagNX_47_2[26:0];
  assign _zz__zz_flagNX_47_3 = _zz_when_FpUnit_l150_12[4:0];
  assign _zz__zz_flagNX_48 = (_zz__zz_flagNX_48_1 - 29'h00000001);
  assign _zz__zz_flagNX_48_2 = ({31'd0,29'h00000001} <<< _zz__zz_flagNX_48_3);
  assign _zz__zz_flagNX_48_1 = _zz__zz_flagNX_48_2[28:0];
  assign _zz__zz_flagNX_48_3 = _zz_when_FpUnit_l150_12[4:0];
  assign _zz__zz_when_FpUnit_l190_41_1 = _zz_when_FpUnit_l190_40;
  assign _zz__zz_when_FpUnit_l190_41 = {1'd0, _zz__zz_when_FpUnit_l190_41_1};
  assign _zz__zz_when_FpUnit_l190_41_3 = ((io_rm == 3'b000) ? (_zz_flagNX_49 && ((_zz_flagNX_50 || _zz_flagNX_51) || _zz_when_FpUnit_l190_40[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_res_72 && (_zz__zz_when_FpUnit_l190_41_4 || _zz_flagNX_51)) : ((io_rm == _zz__zz_when_FpUnit_l190_41_5) ? (_zz__zz_when_FpUnit_l190_41_6 && _zz__zz_when_FpUnit_l190_41_7) : _zz_flagNX_49))));
  assign _zz__zz_when_FpUnit_l190_41_2 = {24'd0, _zz__zz_when_FpUnit_l190_41_3};
  assign _zz__zz_when_FpUnit_l190_42 = (_zz_when_FpUnit_l190_41 >>> 1'd1);
  assign _zz__zz_when_FpUnit_l190_42_1 = _zz_when_FpUnit_l190_41[23:0];
  assign _zz__zz_when_FpUnit_l186_38 = (_zz_when_FpUnit_l186_37 ? _zz__zz_when_FpUnit_l186_38_1 : _zz_when_FpUnit_l186_36);
  assign _zz__zz_when_FpUnit_l186_38_1 = ($signed(_zz_when_FpUnit_l186_36) + $signed(12'h001));
  assign _zz__zz_res_75_1 = _zz_when_FpUnit_l186_38;
  assign _zz__zz_res_75 = _zz__zz_res_75_1[7:0];
  assign _zz__zz_flagUF_137 = _zz__zz_flagUF_137_1;
  assign _zz__zz_flagUF_137_1 = {7'd0, _zz_when_FpUnit_l95_13};
  assign _zz__zz_flagUF_137_2 = ($signed(_zz__zz_flagUF_137_3) - $signed(12'h017));
  assign _zz__zz_flagUF_137_3 = {{2{_zz_when_FpUnit_l218[9]}}, _zz_when_FpUnit_l218};
  assign _zz__zz_flagUF_135_1 = (_zz_when_FpUnit_l88 >>> _zz_flagUF_138);
  assign _zz__zz_flagUF_135 = {3'd0, _zz__zz_flagUF_135_1};
  assign _zz__zz_flagUF_136 = (_zz__zz_flagUF_136_1 - 24'h000001);
  assign _zz__zz_flagUF_136_2 = ({31'd0,24'h000001} <<< _zz_flagUF_138);
  assign _zz__zz_flagUF_136_1 = _zz__zz_flagUF_136_2[23:0];
  assign _zz__zz_flagUF_135_3 = ({31'd0,_zz_when_FpUnit_l88} <<< _zz__zz_flagUF_135_4);
  assign _zz__zz_flagUF_135_2 = _zz__zz_flagUF_135_3[26:0];
  assign _zz__zz_flagUF_135_4 = (5'h1a - _zz_when_FpUnit_l95_13);
  assign _zz__zz_flagUF_139 = {2'd0, _zz_flagUF_135};
  assign _zz__zz_flagUF_142 = ($signed(_zz_flagUF_137) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l147_17 = ($signed(12'hf82) - $signed(_zz_flagUF_137));
  assign _zz__zz_flagUF_143 = _zz_flagUF_140[26:0];
  assign _zz__zz_flagUF_143_2 = (_zz_flagUF_140 >>> _zz__zz_flagUF_143_3);
  assign _zz__zz_flagUF_143_1 = _zz__zz_flagUF_143_2[26:0];
  assign _zz__zz_flagUF_143_3 = _zz_when_FpUnit_l150_13[4:0];
  assign _zz__zz_flagUF_144 = (_zz__zz_flagUF_144_1 - 29'h00000001);
  assign _zz__zz_flagUF_144_2 = ({31'd0,29'h00000001} <<< _zz__zz_flagUF_144_3);
  assign _zz__zz_flagUF_144_1 = _zz__zz_flagUF_144_2[28:0];
  assign _zz__zz_flagUF_144_3 = _zz_when_FpUnit_l150_13[4:0];
  assign _zz__zz_when_FpUnit_l190_44_1 = _zz_when_FpUnit_l190_43;
  assign _zz__zz_when_FpUnit_l190_44 = {1'd0, _zz__zz_when_FpUnit_l190_44_1};
  assign _zz__zz_when_FpUnit_l190_44_3 = ((io_rm == 3'b000) ? (_zz_flagUF_145 && ((_zz_flagUF_146 || _zz_flagUF_147) || _zz_when_FpUnit_l190_43[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (when_FpUnit_l519 && (_zz__zz_when_FpUnit_l190_44_4 || _zz_flagUF_147)) : ((io_rm == _zz__zz_when_FpUnit_l190_44_5) ? (_zz__zz_when_FpUnit_l190_44_6 && _zz__zz_when_FpUnit_l190_44_7) : _zz_flagUF_145))));
  assign _zz__zz_when_FpUnit_l190_44_2 = {24'd0, _zz__zz_when_FpUnit_l190_44_3};
  assign _zz__zz_when_FpUnit_l190_45 = (_zz_when_FpUnit_l190_44 >>> 1'd1);
  assign _zz__zz_when_FpUnit_l190_45_1 = _zz_when_FpUnit_l190_44[23:0];
  assign _zz__zz_when_FpUnit_l186_41 = (_zz_when_FpUnit_l186_40 ? _zz__zz_when_FpUnit_l186_41_1 : _zz_when_FpUnit_l186_39);
  assign _zz__zz_when_FpUnit_l186_41_1 = ($signed(_zz_when_FpUnit_l186_39) + $signed(12'h001));
  assign _zz__zz_res_79_1 = _zz_when_FpUnit_l186_41;
  assign _zz__zz_res_79 = _zz__zz_res_79_1[7:0];
  assign _zz__zz_when_FpUnit_l88_177 = {1'd0, _zz_flagNV_3};
  assign _zz__zz_when_FpUnit_l147_18 = _zz__zz_when_FpUnit_l147_18_1;
  assign _zz__zz_when_FpUnit_l147_18_1 = {7'd0, _zz_when_FpUnit_l95_14};
  assign _zz__zz_when_FpUnit_l147_18_2 = (_zz_when_FpUnit_l88_176 ? 12'hf6b : _zz__zz_when_FpUnit_l147_18_3);
  assign _zz__zz_when_FpUnit_l147_18_3 = ($signed(_zz__zz_when_FpUnit_l147_18_4) - $signed(12'h096));
  assign _zz__zz_when_FpUnit_l147_18_4 = _zz__zz_when_FpUnit_l147_18_5;
  assign _zz__zz_when_FpUnit_l147_18_6 = _zz_when_FpUnit_l563;
  assign _zz__zz_when_FpUnit_l147_18_5 = {4'd0, _zz__zz_when_FpUnit_l147_18_6};
  assign _zz__zz_when_FpUnit_l190_46_1 = (_zz_when_FpUnit_l88_177 >>> _zz_when_FpUnit_l190_48);
  assign _zz__zz_when_FpUnit_l190_46 = {3'd0, _zz__zz_when_FpUnit_l190_46_1};
  assign _zz__zz_when_FpUnit_l190_47 = (_zz__zz_when_FpUnit_l190_47_1 - 24'h000001);
  assign _zz__zz_when_FpUnit_l190_47_2 = ({31'd0,24'h000001} <<< _zz_when_FpUnit_l190_48);
  assign _zz__zz_when_FpUnit_l190_47_1 = _zz__zz_when_FpUnit_l190_47_2[23:0];
  assign _zz__zz_when_FpUnit_l190_46_3 = ({31'd0,_zz_when_FpUnit_l88_177} <<< _zz__zz_when_FpUnit_l190_46_4);
  assign _zz__zz_when_FpUnit_l190_46_2 = _zz__zz_when_FpUnit_l190_46_3[26:0];
  assign _zz__zz_when_FpUnit_l190_46_4 = (5'h1a - _zz_when_FpUnit_l95_14);
  assign _zz__zz_when_FpUnit_l190_49 = {2'd0, _zz_when_FpUnit_l190_46};
  assign _zz__zz_when_FpUnit_l190_52 = ($signed(_zz_when_FpUnit_l147_18) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l147_19 = ($signed(12'hf82) - $signed(_zz_when_FpUnit_l147_18));
  assign _zz__zz_when_FpUnit_l190_53 = _zz_when_FpUnit_l190_50[26:0];
  assign _zz__zz_when_FpUnit_l190_53_2 = (_zz_when_FpUnit_l190_50 >>> _zz__zz_when_FpUnit_l190_53_3);
  assign _zz__zz_when_FpUnit_l190_53_1 = _zz__zz_when_FpUnit_l190_53_2[26:0];
  assign _zz__zz_when_FpUnit_l190_53_3 = _zz_when_FpUnit_l150_14[4:0];
  assign _zz__zz_when_FpUnit_l190_54 = (_zz__zz_when_FpUnit_l190_54_1 - 29'h00000001);
  assign _zz__zz_when_FpUnit_l190_54_2 = ({31'd0,29'h00000001} <<< _zz__zz_when_FpUnit_l190_54_3);
  assign _zz__zz_when_FpUnit_l190_54_1 = _zz__zz_when_FpUnit_l190_54_2[28:0];
  assign _zz__zz_when_FpUnit_l190_54_3 = _zz_when_FpUnit_l150_14[4:0];
  assign _zz__zz_when_FpUnit_l190_59_1 = _zz_when_FpUnit_l190_58;
  assign _zz__zz_when_FpUnit_l190_59 = {1'd0, _zz__zz_when_FpUnit_l190_59_1};
  assign _zz__zz_when_FpUnit_l190_59_3 = ((io_rm == 3'b000) ? (_zz_when_FpUnit_l190_55 && ((_zz_when_FpUnit_l190_56 || _zz_when_FpUnit_l190_57) || _zz_when_FpUnit_l190_58[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_res_81 && (_zz__zz_when_FpUnit_l190_59_4 || _zz_when_FpUnit_l190_57)) : ((io_rm == _zz__zz_when_FpUnit_l190_59_5) ? (_zz__zz_when_FpUnit_l190_59_6 && _zz__zz_when_FpUnit_l190_59_7) : _zz_when_FpUnit_l190_55))));
  assign _zz__zz_when_FpUnit_l190_59_2 = {24'd0, _zz__zz_when_FpUnit_l190_59_3};
  assign _zz__zz_when_FpUnit_l190_60 = (_zz_when_FpUnit_l190_59 >>> 1'd1);
  assign _zz__zz_when_FpUnit_l190_60_1 = _zz_when_FpUnit_l190_59[23:0];
  assign _zz__zz_when_FpUnit_l186_44 = (_zz_when_FpUnit_l186_43 ? _zz__zz_when_FpUnit_l186_44_1 : _zz_when_FpUnit_l186_42);
  assign _zz__zz_when_FpUnit_l186_44_1 = ($signed(_zz_when_FpUnit_l186_42) + $signed(12'h001));
  assign _zz__zz_res_84_1 = _zz_when_FpUnit_l186_44;
  assign _zz__zz_res_84 = _zz__zz_res_84_1[7:0];
  assign _zz__zz_when_FpUnit_l190_1_4 = (_zz_flagUF_10 || _zz_flagUF_11);
  assign _zz__zz_when_FpUnit_l190_1_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l190_1_6 = (! _zz_res_1);
  assign _zz__zz_when_FpUnit_l190_1_7 = ((_zz_flagUF_10 || _zz_flagUF_11) || _zz_flagUF_12);
  assign _zz__zz_when_FpUnit_l190_4_4 = (_zz_flagUF_24 || _zz_flagUF_25);
  assign _zz__zz_when_FpUnit_l190_4_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l190_4_6 = (! _zz_res_6);
  assign _zz__zz_when_FpUnit_l190_4_7 = ((_zz_flagUF_24 || _zz_flagUF_25) || _zz_flagUF_26);
  assign _zz__zz_when_FpUnit_l190_7_4 = (_zz_flagUF_38 || _zz_flagUF_39);
  assign _zz__zz_when_FpUnit_l190_7_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l190_7_6 = (! _zz_res_11);
  assign _zz__zz_when_FpUnit_l190_7_7 = ((_zz_flagUF_38 || _zz_flagUF_39) || _zz_flagUF_40);
  assign _zz__zz_when_FpUnit_l190_10_4 = (_zz_flagUF_52 || _zz_flagUF_53);
  assign _zz__zz_when_FpUnit_l190_10_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l190_10_6 = (! _zz_res_16);
  assign _zz__zz_when_FpUnit_l190_10_7 = ((_zz_flagUF_52 || _zz_flagUF_53) || _zz_flagUF_54);
  assign _zz__zz_when_FpUnit_l190_13_4 = (_zz_flagUF_67 || _zz_flagUF_68);
  assign _zz__zz_when_FpUnit_l190_13_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l190_13_6 = (! _zz_res_21);
  assign _zz__zz_when_FpUnit_l190_13_7 = ((_zz_flagUF_67 || _zz_flagUF_68) || _zz_flagUF_69);
  assign _zz__zz_when_FpUnit_l190_16_4 = (_zz_flagUF_83 || _zz_flagUF_84);
  assign _zz__zz_when_FpUnit_l190_16_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l190_16_6 = (! _zz_when_FpUnit_l88_142);
  assign _zz__zz_when_FpUnit_l190_16_7 = ((_zz_flagUF_83 || _zz_flagUF_84) || _zz_flagUF_85);
  assign _zz__zz_when_FpUnit_l190_19_4 = (_zz_flagUF_99 || _zz_flagUF_100);
  assign _zz__zz_when_FpUnit_l190_19_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l190_19_6 = (! _zz_when_FpUnit_l88_150);
  assign _zz__zz_when_FpUnit_l190_19_7 = ((_zz_flagUF_99 || _zz_flagUF_100) || _zz_flagUF_101);
  assign _zz__zz_when_FpUnit_l190_22_4 = (_zz_flagUF_115 || _zz_flagUF_116);
  assign _zz__zz_when_FpUnit_l190_22_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l190_22_6 = (! _zz_when_FpUnit_l88_158);
  assign _zz__zz_when_FpUnit_l190_22_7 = ((_zz_flagUF_115 || _zz_flagUF_116) || _zz_flagUF_117);
  assign _zz__zz_when_FpUnit_l190_25_4 = (_zz_flagUF_131 || _zz_flagUF_132);
  assign _zz__zz_when_FpUnit_l190_25_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l190_25_6 = (! _zz_when_FpUnit_l88_166);
  assign _zz__zz_when_FpUnit_l190_25_7 = ((_zz_flagUF_131 || _zz_flagUF_132) || _zz_flagUF_133);
  assign _zz__zz_when_FpUnit_l190_29_4 = (_zz_flagNX_16 || _zz_flagNX_17);
  assign _zz__zz_when_FpUnit_l190_29_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l190_29_6 = (! _zz_res_57);
  assign _zz__zz_when_FpUnit_l190_29_7 = ((_zz_flagNX_16 || _zz_flagNX_17) || _zz_flagNX_18);
  assign _zz__zz_when_FpUnit_l190_33_4 = (_zz_flagNX_27 || _zz_flagNX_28);
  assign _zz__zz_when_FpUnit_l190_33_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l190_33_6 = (! _zz_res_62);
  assign _zz__zz_when_FpUnit_l190_33_7 = ((_zz_flagNX_27 || _zz_flagNX_28) || _zz_flagNX_29);
  assign _zz__zz_when_FpUnit_l190_37_4 = (_zz_flagNX_38 || _zz_flagNX_39);
  assign _zz__zz_when_FpUnit_l190_37_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l190_37_6 = (! _zz_res_67);
  assign _zz__zz_when_FpUnit_l190_37_7 = ((_zz_flagNX_38 || _zz_flagNX_39) || _zz_flagNX_40);
  assign _zz__zz_when_FpUnit_l190_41_4 = (_zz_flagNX_49 || _zz_flagNX_50);
  assign _zz__zz_when_FpUnit_l190_41_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l190_41_6 = (! _zz_res_72);
  assign _zz__zz_when_FpUnit_l190_41_7 = ((_zz_flagNX_49 || _zz_flagNX_50) || _zz_flagNX_51);
  assign _zz__zz_when_FpUnit_l190_44_4 = (_zz_flagUF_145 || _zz_flagUF_146);
  assign _zz__zz_when_FpUnit_l190_44_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l190_44_6 = (! when_FpUnit_l519);
  assign _zz__zz_when_FpUnit_l190_44_7 = ((_zz_flagUF_145 || _zz_flagUF_146) || _zz_flagUF_147);
  assign _zz__zz_when_FpUnit_l190_59_4 = (_zz_when_FpUnit_l190_55 || _zz_when_FpUnit_l190_56);
  assign _zz__zz_when_FpUnit_l190_59_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l190_59_6 = (! _zz_res_81);
  assign _zz__zz_when_FpUnit_l190_59_7 = ((_zz_when_FpUnit_l190_55 || _zz_when_FpUnit_l190_56) || _zz_when_FpUnit_l190_57);
  assign when_FpUnit_l519 = io_a[31];
  assign _zz_when_FpUnit_l308 = io_a[30 : 23];
  assign _zz_when_FpUnit_l308_1 = io_a[22 : 0];
  assign _zz_when_FpUnit_l308_2 = (_zz_when_FpUnit_l308 == 8'h0);
  assign _zz_when_FpUnit_l244 = (&_zz_when_FpUnit_l308);
  assign _zz_when_FpUnit_l308_3 = (_zz_when_FpUnit_l308_1 == 23'h0);
  assign when_FpUnit_l308 = (_zz_when_FpUnit_l308_2 && _zz_when_FpUnit_l308_3);
  assign when_FpUnit_l244 = (_zz_when_FpUnit_l244 && _zz_when_FpUnit_l308_3);
  assign when_FpUnit_l342 = (_zz_when_FpUnit_l244 && (! _zz_when_FpUnit_l308_3));
  assign _zz_flagNV = (when_FpUnit_l342 && (! _zz_when_FpUnit_l308_1[22]));
  assign _zz_res = (_zz_when_FpUnit_l308_2 && (! _zz_when_FpUnit_l308_3));
  assign _zz_when_FpUnit_l218 = (_zz_when_FpUnit_l308_2 ? 10'h382 : _zz__zz_when_FpUnit_l218);
  assign _zz_when_FpUnit_l88 = (_zz_when_FpUnit_l308_2 ? _zz__zz_when_FpUnit_l88 : {1'b1,_zz_when_FpUnit_l308_1});
  assign _zz_when_FpUnit_l243 = io_b[31];
  assign _zz_when_FpUnit_l305 = io_b[30 : 23];
  assign _zz_when_FpUnit_l305_1 = io_b[22 : 0];
  assign _zz_when_FpUnit_l305_2 = (_zz_when_FpUnit_l305 == 8'h0);
  assign _zz_when_FpUnit_l245 = (&_zz_when_FpUnit_l305);
  assign _zz_when_FpUnit_l305_3 = (_zz_when_FpUnit_l305_1 == 23'h0);
  assign when_FpUnit_l305 = (_zz_when_FpUnit_l305_2 && _zz_when_FpUnit_l305_3);
  assign when_FpUnit_l245 = (_zz_when_FpUnit_l245 && _zz_when_FpUnit_l305_3);
  assign when_FpUnit_l431 = (_zz_when_FpUnit_l245 && (! _zz_when_FpUnit_l305_3));
  assign _zz_flagNV_1 = (when_FpUnit_l431 && (! _zz_when_FpUnit_l305_1[22]));
  assign _zz_when_FpUnit_l218_1 = (_zz_when_FpUnit_l305_2 ? 10'h382 : _zz__zz_when_FpUnit_l218_1_1);
  assign _zz_when_FpUnit_l88_1 = (_zz_when_FpUnit_l305_2 ? _zz__zz_when_FpUnit_l88_1 : {1'b1,_zz_when_FpUnit_l305_1});
  assign _zz_when_FpUnit_l397 = io_c[31];
  assign _zz_when_FpUnit_l399 = io_c[30 : 23];
  assign _zz_when_FpUnit_l399_1 = io_c[22 : 0];
  assign _zz_when_FpUnit_l367 = (_zz_when_FpUnit_l399 == 8'h0);
  assign _zz_when_FpUnit_l399_2 = (&_zz_when_FpUnit_l399);
  assign _zz_when_FpUnit_l399_3 = (_zz_when_FpUnit_l399_1 == 23'h0);
  assign when_FpUnit_l399 = (_zz_when_FpUnit_l399_2 && _zz_when_FpUnit_l399_3);
  assign _zz_when_FpUnit_l395 = (_zz_when_FpUnit_l399_2 && (! _zz_when_FpUnit_l399_3));
  assign _zz_flagNV_2 = (_zz_when_FpUnit_l395 && (! _zz_when_FpUnit_l399_1[22]));
  assign _zz_when_FpUnit_l367_1 = (_zz_when_FpUnit_l367 ? 10'h382 : _zz__zz_when_FpUnit_l367_1);
  assign _zz_when_FpUnit_l88_2 = (_zz_when_FpUnit_l367 ? _zz__zz_when_FpUnit_l88_2 : {1'b1,_zz_when_FpUnit_l399_1});
  always @(*) begin
    res = {32'd0, _zz_res_86};
    case(io_op)
      6'h0 : begin
        res = {32'd0, _zz_res_5};
      end
      6'h01 : begin
        res = {32'd0, _zz_res_10};
      end
      6'h02 : begin
        res = {32'd0, _zz_res_15};
      end
      6'h03 : begin
        res = {32'd0, _zz_res_20};
      end
      6'h04 : begin
        res = {32'd0, _zz_res_25};
      end
      6'h05 : begin
        res = {32'd0, _zz_res_28};
      end
      6'h06 : begin
        res = {32'd0, _zz_res_31};
      end
      6'h07, 6'h08, 6'h09 : begin
        res = {32'd0, _zz_res_32};
      end
      6'h0a, 6'h0b, 6'h0c : begin
        res = {32'd0, _zz_res_35};
      end
      6'h0d : begin
        res = {32'd0, _zz_res_87};
      end
      6'h0e : begin
        res = io_a;
      end
      6'h0f : begin
        res = io_a;
      end
      6'h18 : begin
        res = {32'd0, _zz_res_40};
      end
      6'h19 : begin
        res = {32'd0, _zz_res_44};
      end
      6'h1a : begin
        res = {32'd0, _zz_res_48};
      end
      6'h1b : begin
        res = {32'd0, _zz_res_52};
      end
      6'h10 : begin
        res = _zz_res_88;
      end
      6'h11 : begin
        res = _zz_res_90;
      end
      6'h12 : begin
        res = _zz_res_91;
      end
      6'h13 : begin
        res = _zz_res_56;
      end
      6'h14 : begin
        res = {32'd0, _zz_res_61};
      end
      6'h15 : begin
        res = {32'd0, _zz_res_66};
      end
      6'h16 : begin
        res = {32'd0, _zz_res_71};
      end
      6'h17 : begin
        res = {32'd0, _zz_res_76};
      end
      6'h1c : begin
        res = {32'd0, _zz_res_80};
      end
      6'h1d : begin
        res = {32'd0, _zz_res_85};
      end
      default : begin
        res = io_a;
      end
    endcase
  end

  always @(*) begin
    flagNV = 1'b0;
    case(io_op)
      6'h0 : begin
        if(when_FpUnit_l242) begin
          flagNV = (_zz_flagNV || _zz_flagNV_1);
        end else begin
          if(when_FpUnit_l243) begin
            flagNV = 1'b1;
          end
        end
      end
      6'h01 : begin
        if(when_FpUnit_l242_1) begin
          flagNV = (_zz_flagNV || _zz_flagNV_1);
        end else begin
          if(when_FpUnit_l243_1) begin
            flagNV = 1'b1;
          end
        end
      end
      6'h02 : begin
        if(when_FpUnit_l272) begin
          flagNV = (_zz_flagNV || _zz_flagNV_1);
        end else begin
          if(when_FpUnit_l273) begin
            flagNV = 1'b1;
          end
        end
      end
      6'h03 : begin
        if(when_FpUnit_l299) begin
          flagNV = (_zz_flagNV || _zz_flagNV_1);
        end else begin
          if(when_FpUnit_l300) begin
            flagNV = 1'b1;
          end
        end
      end
      6'h04 : begin
        if(when_FpUnit_l342) begin
          flagNV = _zz_flagNV;
        end else begin
          if(when_FpUnit_l343) begin
            flagNV = 1'b1;
          end
        end
      end
      6'h05 : begin
        flagNV = (_zz_flagNV || _zz_flagNV_1);
      end
      6'h06 : begin
        flagNV = (_zz_flagNV || _zz_flagNV_1);
      end
      6'h07, 6'h08, 6'h09 : begin
      end
      6'h0a, 6'h0b, 6'h0c : begin
        case(io_op)
          6'h0b : begin
            flagNV = (when_FpUnit_l342 || when_FpUnit_l431);
          end
          6'h0c : begin
            flagNV = (when_FpUnit_l342 || when_FpUnit_l431);
          end
          default : begin
          end
        endcase
      end
      6'h0d : begin
      end
      6'h0e : begin
      end
      6'h0f : begin
      end
      6'h18 : begin
        if(when_FpUnit_l395) begin
          flagNV = ((_zz_flagNV || _zz_flagNV_1) || _zz_flagNV_2);
        end else begin
          if(when_FpUnit_l396) begin
            flagNV = 1'b1;
          end else begin
            if(when_FpUnit_l397) begin
              flagNV = 1'b1;
            end
          end
        end
      end
      6'h19 : begin
        if(when_FpUnit_l395_1) begin
          flagNV = ((_zz_flagNV || _zz_flagNV_1) || _zz_flagNV_2);
        end else begin
          if(when_FpUnit_l396_1) begin
            flagNV = 1'b1;
          end else begin
            if(when_FpUnit_l397_1) begin
              flagNV = 1'b1;
            end
          end
        end
      end
      6'h1a : begin
        if(when_FpUnit_l395_2) begin
          flagNV = ((_zz_flagNV || _zz_flagNV_1) || _zz_flagNV_2);
        end else begin
          if(when_FpUnit_l396_2) begin
            flagNV = 1'b1;
          end else begin
            if(when_FpUnit_l397_2) begin
              flagNV = 1'b1;
            end
          end
        end
      end
      6'h1b : begin
        if(when_FpUnit_l395_3) begin
          flagNV = ((_zz_flagNV || _zz_flagNV_1) || _zz_flagNV_2);
        end else begin
          if(when_FpUnit_l396_3) begin
            flagNV = 1'b1;
          end else begin
            if(when_FpUnit_l397_3) begin
              flagNV = 1'b1;
            end
          end
        end
      end
      6'h10 : begin
        if(when_FpUnit_l512) begin
          flagNV = 1'b1;
        end
      end
      6'h11 : begin
        if(when_FpUnit_l512_1) begin
          flagNV = 1'b1;
        end
      end
      6'h12 : begin
        if(when_FpUnit_l512_2) begin
          flagNV = 1'b1;
        end
      end
      6'h13 : begin
        if(when_FpUnit_l512_3) begin
          flagNV = 1'b1;
        end
      end
      6'h14 : begin
      end
      6'h15 : begin
      end
      6'h16 : begin
      end
      6'h17 : begin
      end
      6'h1c : begin
        if(when_FpUnit_l342) begin
          flagNV = _zz_flagNV;
        end
      end
      6'h1d : begin
        if(when_FpUnit_l561) begin
          flagNV = (when_FpUnit_l561 && (! _zz_flagNV_3[22]));
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    flagDZ = 1'b0;
    case(io_op)
      6'h0 : begin
      end
      6'h01 : begin
      end
      6'h02 : begin
      end
      6'h03 : begin
        if(!when_FpUnit_l299) begin
          if(!when_FpUnit_l300) begin
            if(!when_FpUnit_l244) begin
              if(!when_FpUnit_l245) begin
                if(when_FpUnit_l305) begin
                  flagDZ = 1'b1;
                end
              end
            end
          end
        end
      end
      6'h04 : begin
      end
      6'h05 : begin
      end
      6'h06 : begin
      end
      6'h07, 6'h08, 6'h09 : begin
      end
      6'h0a, 6'h0b, 6'h0c : begin
      end
      6'h0d : begin
      end
      6'h0e : begin
      end
      6'h0f : begin
      end
      6'h18 : begin
      end
      6'h19 : begin
      end
      6'h1a : begin
      end
      6'h1b : begin
      end
      6'h10 : begin
      end
      6'h11 : begin
      end
      6'h12 : begin
      end
      6'h13 : begin
      end
      6'h14 : begin
      end
      6'h15 : begin
      end
      6'h16 : begin
      end
      6'h17 : begin
      end
      6'h1c : begin
      end
      6'h1d : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    flagOF = 1'b0;
    case(io_op)
      6'h0 : begin
        if(!when_FpUnit_l242) begin
          if(!when_FpUnit_l243) begin
            if(!when_FpUnit_l244) begin
              if(!when_FpUnit_l245) begin
                if(!when_FpUnit_l246) begin
                  flagOF = when_FpUnit_l186;
                end
              end
            end
          end
        end
      end
      6'h01 : begin
        if(!when_FpUnit_l242_1) begin
          if(!when_FpUnit_l243_1) begin
            if(!when_FpUnit_l244) begin
              if(!when_FpUnit_l245) begin
                if(!when_FpUnit_l246_1) begin
                  flagOF = when_FpUnit_l186_1;
                end
              end
            end
          end
        end
      end
      6'h02 : begin
        if(!when_FpUnit_l272) begin
          if(!when_FpUnit_l273) begin
            if(!when_FpUnit_l274) begin
              if(!when_FpUnit_l275) begin
                flagOF = when_FpUnit_l186_2;
              end
            end
          end
        end
      end
      6'h03 : begin
        if(!when_FpUnit_l299) begin
          if(!when_FpUnit_l300) begin
            if(!when_FpUnit_l244) begin
              if(!when_FpUnit_l245) begin
                if(!when_FpUnit_l305) begin
                  if(!when_FpUnit_l308) begin
                    flagOF = when_FpUnit_l186_3;
                  end
                end
              end
            end
          end
        end
      end
      6'h04 : begin
        if(!when_FpUnit_l342) begin
          if(!when_FpUnit_l343) begin
            if(!when_FpUnit_l244) begin
              if(!when_FpUnit_l308) begin
                flagOF = when_FpUnit_l186_4;
              end
            end
          end
        end
      end
      6'h05 : begin
      end
      6'h06 : begin
      end
      6'h07, 6'h08, 6'h09 : begin
      end
      6'h0a, 6'h0b, 6'h0c : begin
      end
      6'h0d : begin
      end
      6'h0e : begin
      end
      6'h0f : begin
      end
      6'h18 : begin
        if(!when_FpUnit_l395) begin
          if(!when_FpUnit_l396) begin
            if(!when_FpUnit_l397) begin
              if(!when_FpUnit_l398) begin
                if(!when_FpUnit_l399) begin
                  flagOF = when_FpUnit_l186_5;
                end
              end
            end
          end
        end
      end
      6'h19 : begin
        if(!when_FpUnit_l395_1) begin
          if(!when_FpUnit_l396_1) begin
            if(!when_FpUnit_l397_1) begin
              if(!when_FpUnit_l398_1) begin
                if(!when_FpUnit_l399) begin
                  flagOF = when_FpUnit_l186_6;
                end
              end
            end
          end
        end
      end
      6'h1a : begin
        if(!when_FpUnit_l395_2) begin
          if(!when_FpUnit_l396_2) begin
            if(!when_FpUnit_l397_2) begin
              if(!when_FpUnit_l398_2) begin
                if(!when_FpUnit_l399) begin
                  flagOF = when_FpUnit_l186_7;
                end
              end
            end
          end
        end
      end
      6'h1b : begin
        if(!when_FpUnit_l395_3) begin
          if(!when_FpUnit_l396_3) begin
            if(!when_FpUnit_l397_3) begin
              if(!when_FpUnit_l398_3) begin
                if(!when_FpUnit_l399) begin
                  flagOF = when_FpUnit_l186_8;
                end
              end
            end
          end
        end
      end
      6'h10 : begin
      end
      6'h11 : begin
      end
      6'h12 : begin
      end
      6'h13 : begin
      end
      6'h14 : begin
        if(!when_FpUnit_l536) begin
          flagOF = when_FpUnit_l186_9;
        end
      end
      6'h15 : begin
        if(!when_FpUnit_l536_1) begin
          flagOF = when_FpUnit_l186_10;
        end
      end
      6'h16 : begin
        if(!when_FpUnit_l536_2) begin
          flagOF = when_FpUnit_l186_11;
        end
      end
      6'h17 : begin
        if(!when_FpUnit_l536_3) begin
          flagOF = when_FpUnit_l186_12;
        end
      end
      6'h1c : begin
        if(!when_FpUnit_l342) begin
          if(!when_FpUnit_l244) begin
            if(!when_FpUnit_l308) begin
              flagOF = when_FpUnit_l186_13;
            end
          end
        end
      end
      6'h1d : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    flagUF = 1'b0;
    case(io_op)
      6'h0 : begin
        if(!when_FpUnit_l242) begin
          if(!when_FpUnit_l243) begin
            if(!when_FpUnit_l244) begin
              if(!when_FpUnit_l245) begin
                if(!when_FpUnit_l246) begin
                  flagUF = (_zz_flagUF_7 && _zz_flagUF_13);
                end
              end
            end
          end
        end
      end
      6'h01 : begin
        if(!when_FpUnit_l242_1) begin
          if(!when_FpUnit_l243_1) begin
            if(!when_FpUnit_l244) begin
              if(!when_FpUnit_l245) begin
                if(!when_FpUnit_l246_1) begin
                  flagUF = (_zz_flagUF_21 && _zz_flagUF_27);
                end
              end
            end
          end
        end
      end
      6'h02 : begin
        if(!when_FpUnit_l272) begin
          if(!when_FpUnit_l273) begin
            if(!when_FpUnit_l274) begin
              if(!when_FpUnit_l275) begin
                flagUF = (_zz_flagUF_35 && _zz_flagUF_41);
              end
            end
          end
        end
      end
      6'h03 : begin
        if(!when_FpUnit_l299) begin
          if(!when_FpUnit_l300) begin
            if(!when_FpUnit_l244) begin
              if(!when_FpUnit_l245) begin
                if(!when_FpUnit_l305) begin
                  if(!when_FpUnit_l308) begin
                    flagUF = (_zz_flagUF_49 && _zz_flagUF_55);
                  end
                end
              end
            end
          end
        end
      end
      6'h04 : begin
        if(!when_FpUnit_l342) begin
          if(!when_FpUnit_l343) begin
            if(!when_FpUnit_l244) begin
              if(!when_FpUnit_l308) begin
                flagUF = (_zz_flagUF_64 && _zz_flagUF_70);
              end
            end
          end
        end
      end
      6'h05 : begin
      end
      6'h06 : begin
      end
      6'h07, 6'h08, 6'h09 : begin
      end
      6'h0a, 6'h0b, 6'h0c : begin
      end
      6'h0d : begin
      end
      6'h0e : begin
      end
      6'h0f : begin
      end
      6'h18 : begin
        if(!when_FpUnit_l395) begin
          if(!when_FpUnit_l396) begin
            if(!when_FpUnit_l397) begin
              if(!when_FpUnit_l398) begin
                if(!when_FpUnit_l399) begin
                  flagUF = (_zz_flagUF_80 && _zz_flagUF_86);
                end
              end
            end
          end
        end
      end
      6'h19 : begin
        if(!when_FpUnit_l395_1) begin
          if(!when_FpUnit_l396_1) begin
            if(!when_FpUnit_l397_1) begin
              if(!when_FpUnit_l398_1) begin
                if(!when_FpUnit_l399) begin
                  flagUF = (_zz_flagUF_96 && _zz_flagUF_102);
                end
              end
            end
          end
        end
      end
      6'h1a : begin
        if(!when_FpUnit_l395_2) begin
          if(!when_FpUnit_l396_2) begin
            if(!when_FpUnit_l397_2) begin
              if(!when_FpUnit_l398_2) begin
                if(!when_FpUnit_l399) begin
                  flagUF = (_zz_flagUF_112 && _zz_flagUF_118);
                end
              end
            end
          end
        end
      end
      6'h1b : begin
        if(!when_FpUnit_l395_3) begin
          if(!when_FpUnit_l396_3) begin
            if(!when_FpUnit_l397_3) begin
              if(!when_FpUnit_l398_3) begin
                if(!when_FpUnit_l399) begin
                  flagUF = (_zz_flagUF_128 && _zz_flagUF_134);
                end
              end
            end
          end
        end
      end
      6'h10 : begin
      end
      6'h11 : begin
      end
      6'h12 : begin
      end
      6'h13 : begin
      end
      6'h14 : begin
      end
      6'h15 : begin
      end
      6'h16 : begin
      end
      6'h17 : begin
      end
      6'h1c : begin
        if(!when_FpUnit_l342) begin
          if(!when_FpUnit_l244) begin
            if(!when_FpUnit_l308) begin
              flagUF = (_zz_flagUF_142 && _zz_flagUF_148);
            end
          end
        end
      end
      6'h1d : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    flagNX = 1'b0;
    case(io_op)
      6'h0 : begin
        if(!when_FpUnit_l242) begin
          if(!when_FpUnit_l243) begin
            if(!when_FpUnit_l244) begin
              if(!when_FpUnit_l245) begin
                if(!when_FpUnit_l246) begin
                  flagNX = _zz_flagUF_13;
                end
              end
            end
          end
        end
      end
      6'h01 : begin
        if(!when_FpUnit_l242_1) begin
          if(!when_FpUnit_l243_1) begin
            if(!when_FpUnit_l244) begin
              if(!when_FpUnit_l245) begin
                if(!when_FpUnit_l246_1) begin
                  flagNX = _zz_flagUF_27;
                end
              end
            end
          end
        end
      end
      6'h02 : begin
        if(!when_FpUnit_l272) begin
          if(!when_FpUnit_l273) begin
            if(!when_FpUnit_l274) begin
              if(!when_FpUnit_l275) begin
                flagNX = _zz_flagUF_41;
              end
            end
          end
        end
      end
      6'h03 : begin
        if(!when_FpUnit_l299) begin
          if(!when_FpUnit_l300) begin
            if(!when_FpUnit_l244) begin
              if(!when_FpUnit_l245) begin
                if(!when_FpUnit_l305) begin
                  if(!when_FpUnit_l308) begin
                    flagNX = _zz_flagUF_55;
                  end
                end
              end
            end
          end
        end
      end
      6'h04 : begin
        if(!when_FpUnit_l342) begin
          if(!when_FpUnit_l343) begin
            if(!when_FpUnit_l244) begin
              if(!when_FpUnit_l308) begin
                flagNX = _zz_flagUF_70;
              end
            end
          end
        end
      end
      6'h05 : begin
      end
      6'h06 : begin
      end
      6'h07, 6'h08, 6'h09 : begin
      end
      6'h0a, 6'h0b, 6'h0c : begin
      end
      6'h0d : begin
      end
      6'h0e : begin
      end
      6'h0f : begin
      end
      6'h18 : begin
        if(!when_FpUnit_l395) begin
          if(!when_FpUnit_l396) begin
            if(!when_FpUnit_l397) begin
              if(!when_FpUnit_l398) begin
                if(!when_FpUnit_l399) begin
                  flagNX = _zz_flagUF_86;
                end
              end
            end
          end
        end
      end
      6'h19 : begin
        if(!when_FpUnit_l395_1) begin
          if(!when_FpUnit_l396_1) begin
            if(!when_FpUnit_l397_1) begin
              if(!when_FpUnit_l398_1) begin
                if(!when_FpUnit_l399) begin
                  flagNX = _zz_flagUF_102;
                end
              end
            end
          end
        end
      end
      6'h1a : begin
        if(!when_FpUnit_l395_2) begin
          if(!when_FpUnit_l396_2) begin
            if(!when_FpUnit_l397_2) begin
              if(!when_FpUnit_l398_2) begin
                if(!when_FpUnit_l399) begin
                  flagNX = _zz_flagUF_118;
                end
              end
            end
          end
        end
      end
      6'h1b : begin
        if(!when_FpUnit_l395_3) begin
          if(!when_FpUnit_l396_3) begin
            if(!when_FpUnit_l397_3) begin
              if(!when_FpUnit_l398_3) begin
                if(!when_FpUnit_l399) begin
                  flagNX = _zz_flagUF_134;
                end
              end
            end
          end
        end
      end
      6'h10 : begin
        if(!when_FpUnit_l512) begin
          flagNX = _zz_flagNX;
        end
      end
      6'h11 : begin
        if(!when_FpUnit_l512_1) begin
          flagNX = _zz_flagNX_2;
        end
      end
      6'h12 : begin
        if(!when_FpUnit_l512_2) begin
          flagNX = _zz_flagNX_4;
        end
      end
      6'h13 : begin
        if(!when_FpUnit_l512_3) begin
          flagNX = _zz_flagNX_6;
        end
      end
      6'h14 : begin
        if(!when_FpUnit_l536) begin
          flagNX = ((_zz_flagNX_16 || _zz_flagNX_17) || _zz_flagNX_18);
        end
      end
      6'h15 : begin
        if(!when_FpUnit_l536_1) begin
          flagNX = ((_zz_flagNX_27 || _zz_flagNX_28) || _zz_flagNX_29);
        end
      end
      6'h16 : begin
        if(!when_FpUnit_l536_2) begin
          flagNX = ((_zz_flagNX_38 || _zz_flagNX_39) || _zz_flagNX_40);
        end
      end
      6'h17 : begin
        if(!when_FpUnit_l536_3) begin
          flagNX = ((_zz_flagNX_49 || _zz_flagNX_50) || _zz_flagNX_51);
        end
      end
      6'h1c : begin
        if(!when_FpUnit_l342) begin
          if(!when_FpUnit_l244) begin
            if(!when_FpUnit_l308) begin
              flagNX = _zz_flagUF_148;
            end
          end
        end
      end
      6'h1d : begin
      end
      default : begin
      end
    endcase
  end

  assign _zz_when_FpUnit_l243_1 = (_zz_when_FpUnit_l243 ^ 1'b0);
  assign _zz_when_FpUnit_l218_2 = ($signed(_zz_when_FpUnit_l218) < $signed(_zz_when_FpUnit_l218_1));
  assign _zz_when_FpUnit_l88_3 = (_zz_when_FpUnit_l218_2 ? _zz_when_FpUnit_l243_1 : when_FpUnit_l519);
  assign _zz_when_FpUnit_l88_4 = (_zz_when_FpUnit_l218_2 ? when_FpUnit_l519 : _zz_when_FpUnit_l243_1);
  assign _zz_when_FpUnit_l218_3 = (_zz_when_FpUnit_l218_2 ? _zz_when_FpUnit_l218_1 : _zz_when_FpUnit_l218);
  assign _zz_when_FpUnit_l88_5 = _zz__zz_when_FpUnit_l88_5[27:0];
  assign _zz_when_FpUnit_l218_4 = _zz__zz_when_FpUnit_l218_4;
  assign when_FpUnit_l218 = (10'h01c <= _zz_when_FpUnit_l218_4);
  always @(*) begin
    if(when_FpUnit_l218) begin
      _zz_when_FpUnit_l88_6 = 28'h0;
    end else begin
      _zz_when_FpUnit_l88_6 = _zz__zz_when_FpUnit_l88_6;
    end
  end

  assign _zz_when_FpUnit_l88_7 = (! (_zz_when_FpUnit_l88_3 == _zz_when_FpUnit_l88_4));
  assign _zz_when_FpUnit_l88_8 = _zz_when_FpUnit_l88_6;
  assign _zz_when_FpUnit_l88_9 = (_zz_when_FpUnit_l88_7 && (_zz_when_FpUnit_l88_5 < _zz_when_FpUnit_l88_8));
  assign _zz_when_FpUnit_l88_10 = (_zz_when_FpUnit_l88_7 ? (_zz_when_FpUnit_l88_9 ? _zz__zz_when_FpUnit_l88_10 : _zz__zz_when_FpUnit_l88_10_1) : _zz__zz_when_FpUnit_l88_10_2);
  assign _zz_res_1 = (_zz_when_FpUnit_l88_9 ? _zz_when_FpUnit_l88_4 : _zz_when_FpUnit_l88_3);
  always @(*) begin
    _zz_when_FpUnit_l95 = 5'h0;
    if(when_FpUnit_l88) begin
      _zz_when_FpUnit_l95 = 5'h0;
    end
    if(when_FpUnit_l88_1) begin
      _zz_when_FpUnit_l95 = 5'h01;
    end
    if(when_FpUnit_l88_2) begin
      _zz_when_FpUnit_l95 = 5'h02;
    end
    if(when_FpUnit_l88_3) begin
      _zz_when_FpUnit_l95 = 5'h03;
    end
    if(when_FpUnit_l88_4) begin
      _zz_when_FpUnit_l95 = 5'h04;
    end
    if(when_FpUnit_l88_5) begin
      _zz_when_FpUnit_l95 = 5'h05;
    end
    if(when_FpUnit_l88_6) begin
      _zz_when_FpUnit_l95 = 5'h06;
    end
    if(when_FpUnit_l88_7) begin
      _zz_when_FpUnit_l95 = 5'h07;
    end
    if(when_FpUnit_l88_8) begin
      _zz_when_FpUnit_l95 = 5'h08;
    end
    if(when_FpUnit_l88_9) begin
      _zz_when_FpUnit_l95 = 5'h09;
    end
    if(when_FpUnit_l88_10) begin
      _zz_when_FpUnit_l95 = 5'h0a;
    end
    if(when_FpUnit_l88_11) begin
      _zz_when_FpUnit_l95 = 5'h0b;
    end
    if(when_FpUnit_l88_12) begin
      _zz_when_FpUnit_l95 = 5'h0c;
    end
    if(when_FpUnit_l88_13) begin
      _zz_when_FpUnit_l95 = 5'h0d;
    end
    if(when_FpUnit_l88_14) begin
      _zz_when_FpUnit_l95 = 5'h0e;
    end
    if(when_FpUnit_l88_15) begin
      _zz_when_FpUnit_l95 = 5'h0f;
    end
    if(when_FpUnit_l88_16) begin
      _zz_when_FpUnit_l95 = 5'h10;
    end
    if(when_FpUnit_l88_17) begin
      _zz_when_FpUnit_l95 = 5'h11;
    end
    if(when_FpUnit_l88_18) begin
      _zz_when_FpUnit_l95 = 5'h12;
    end
    if(when_FpUnit_l88_19) begin
      _zz_when_FpUnit_l95 = 5'h13;
    end
    if(when_FpUnit_l88_20) begin
      _zz_when_FpUnit_l95 = 5'h14;
    end
    if(when_FpUnit_l88_21) begin
      _zz_when_FpUnit_l95 = 5'h15;
    end
    if(when_FpUnit_l88_22) begin
      _zz_when_FpUnit_l95 = 5'h16;
    end
    if(when_FpUnit_l88_23) begin
      _zz_when_FpUnit_l95 = 5'h17;
    end
    if(when_FpUnit_l88_24) begin
      _zz_when_FpUnit_l95 = 5'h18;
    end
    if(when_FpUnit_l88_25) begin
      _zz_when_FpUnit_l95 = 5'h19;
    end
    if(when_FpUnit_l88_26) begin
      _zz_when_FpUnit_l95 = 5'h1a;
    end
    if(when_FpUnit_l88_27) begin
      _zz_when_FpUnit_l95 = 5'h1b;
    end
  end

  assign when_FpUnit_l88 = _zz_when_FpUnit_l88_10[0];
  assign when_FpUnit_l88_1 = _zz_when_FpUnit_l88_10[1];
  assign when_FpUnit_l88_2 = _zz_when_FpUnit_l88_10[2];
  assign when_FpUnit_l88_3 = _zz_when_FpUnit_l88_10[3];
  assign when_FpUnit_l88_4 = _zz_when_FpUnit_l88_10[4];
  assign when_FpUnit_l88_5 = _zz_when_FpUnit_l88_10[5];
  assign when_FpUnit_l88_6 = _zz_when_FpUnit_l88_10[6];
  assign when_FpUnit_l88_7 = _zz_when_FpUnit_l88_10[7];
  assign when_FpUnit_l88_8 = _zz_when_FpUnit_l88_10[8];
  assign when_FpUnit_l88_9 = _zz_when_FpUnit_l88_10[9];
  assign when_FpUnit_l88_10 = _zz_when_FpUnit_l88_10[10];
  assign when_FpUnit_l88_11 = _zz_when_FpUnit_l88_10[11];
  assign when_FpUnit_l88_12 = _zz_when_FpUnit_l88_10[12];
  assign when_FpUnit_l88_13 = _zz_when_FpUnit_l88_10[13];
  assign when_FpUnit_l88_14 = _zz_when_FpUnit_l88_10[14];
  assign when_FpUnit_l88_15 = _zz_when_FpUnit_l88_10[15];
  assign when_FpUnit_l88_16 = _zz_when_FpUnit_l88_10[16];
  assign when_FpUnit_l88_17 = _zz_when_FpUnit_l88_10[17];
  assign when_FpUnit_l88_18 = _zz_when_FpUnit_l88_10[18];
  assign when_FpUnit_l88_19 = _zz_when_FpUnit_l88_10[19];
  assign when_FpUnit_l88_20 = _zz_when_FpUnit_l88_10[20];
  assign when_FpUnit_l88_21 = _zz_when_FpUnit_l88_10[21];
  assign when_FpUnit_l88_22 = _zz_when_FpUnit_l88_10[22];
  assign when_FpUnit_l88_23 = _zz_when_FpUnit_l88_10[23];
  assign when_FpUnit_l88_24 = _zz_when_FpUnit_l88_10[24];
  assign when_FpUnit_l88_25 = _zz_when_FpUnit_l88_10[25];
  assign when_FpUnit_l88_26 = _zz_when_FpUnit_l88_10[26];
  assign when_FpUnit_l88_27 = _zz_when_FpUnit_l88_10[27];
  always @(*) begin
    _zz_flagUF = 27'h0;
    if(when_FpUnit_l94) begin
      if(when_FpUnit_l95) begin
        _zz_flagUF = _zz__zz_flagUF;
      end else begin
        _zz_flagUF = _zz__zz_flagUF_3;
      end
    end
  end

  always @(*) begin
    _zz_flagUF_1 = 1'b0;
    if(when_FpUnit_l94) begin
      if(when_FpUnit_l95) begin
        _zz_flagUF_1 = (|(_zz_when_FpUnit_l88_10 & _zz__zz_flagUF_1_1));
      end else begin
        _zz_flagUF_1 = 1'b0;
      end
    end
  end

  assign _zz_flagUF_2 = ($signed(_zz__zz_flagUF_2) + $signed(_zz__zz_flagUF_2_2));
  assign when_FpUnit_l94 = (_zz_when_FpUnit_l88_10 != 28'h0);
  assign when_FpUnit_l95 = (5'h1a < _zz_when_FpUnit_l95);
  assign _zz_flagUF_3 = (_zz_when_FpUnit_l95 - 5'h1a);
  assign when_FpUnit_l246 = (_zz_when_FpUnit_l88_10 == 28'h0);
  assign _zz_flagUF_4 = _zz__zz_flagUF_4_1;
  assign _zz_flagUF_5 = _zz_flagUF_4;
  assign _zz_flagUF_6 = (_zz_flagUF_1 || (|(_zz_flagUF_4 & 29'h0)));
  assign _zz_flagUF_7 = ($signed(_zz__zz_flagUF_7) < $signed(12'h001));
  assign _zz_when_FpUnit_l147 = (_zz_flagUF_7 ? _zz__zz_when_FpUnit_l147 : 12'h0);
  assign _zz_when_FpUnit_l150 = _zz_when_FpUnit_l147;
  assign when_FpUnit_l147 = ($signed(_zz_when_FpUnit_l147) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l147) begin
      _zz_flagUF_8 = _zz__zz_flagUF_8;
    end else begin
      if(when_FpUnit_l150) begin
        _zz_flagUF_8 = 27'h0;
      end else begin
        _zz_flagUF_8 = _zz__zz_flagUF_8_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l147) begin
      _zz_flagUF_9 = _zz_flagUF_6;
    end else begin
      if(when_FpUnit_l150) begin
        _zz_flagUF_9 = ((|_zz_flagUF_5) || _zz_flagUF_6);
      end else begin
        _zz_flagUF_9 = ((|(_zz_flagUF_5 & _zz__zz_flagUF_9)) || _zz_flagUF_6);
      end
    end
  end

  assign when_FpUnit_l150 = (12'h01b <= _zz_when_FpUnit_l150);
  assign _zz_when_FpUnit_l186 = (_zz_flagUF_7 ? 12'hf82 : _zz_flagUF_2);
  assign _zz_flagUF_10 = _zz_flagUF_8[2];
  assign _zz_flagUF_11 = _zz_flagUF_8[1];
  assign _zz_flagUF_12 = (_zz_flagUF_8[0] || _zz_flagUF_9);
  assign _zz_when_FpUnit_l190 = _zz_flagUF_8[26 : 3];
  assign _zz_when_FpUnit_l190_1 = (_zz__zz_when_FpUnit_l190_1 + _zz__zz_when_FpUnit_l190_1_2);
  assign _zz_when_FpUnit_l186_1 = _zz_when_FpUnit_l190_1[24];
  assign _zz_when_FpUnit_l190_2 = (_zz_when_FpUnit_l186_1 ? _zz__zz_when_FpUnit_l190_2 : _zz__zz_when_FpUnit_l190_2_1);
  assign _zz_when_FpUnit_l186_2 = ($signed(_zz__zz_when_FpUnit_l186_2) + $signed(12'h07f));
  assign _zz_flagUF_13 = ((_zz_flagUF_10 || _zz_flagUF_11) || _zz_flagUF_12);
  assign when_FpUnit_l186 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l186_2));
  assign _zz_res_2 = {_zz_res_1,{8'hff,23'h0}};
  assign _zz_res_3 = {_zz_res_1,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_4 = 32'h0;
    if(when_FpUnit_l186) begin
      _zz_res_4 = ((io_rm == 3'b001) ? _zz_res_3 : ((io_rm == 3'b010) ? (_zz_res_1 ? _zz_res_2 : _zz_res_3) : ((io_rm == 3'b011) ? (_zz_res_1 ? _zz_res_3 : _zz_res_2) : _zz_res_2)));
    end else begin
      if(when_FpUnit_l190) begin
        _zz_res_4 = {_zz_res_1,{8'h0,23'h0}};
      end else begin
        if(when_FpUnit_l192) begin
          _zz_res_4 = {_zz_res_1,{8'h0,_zz_when_FpUnit_l190_2[22 : 0]}};
        end else begin
          _zz_res_4 = {_zz_res_1,{_zz__zz_res_4,_zz_when_FpUnit_l190_2[22 : 0]}};
        end
      end
    end
  end

  assign when_FpUnit_l190 = (_zz_flagUF_7 && (_zz_when_FpUnit_l190_2 == 24'h0));
  assign when_FpUnit_l192 = ((_zz_flagUF_7 && (_zz_when_FpUnit_l190_2 != 24'h0)) && (! _zz_when_FpUnit_l190_2[23]));
  always @(*) begin
    _zz_res_5 = _zz_res_4;
    if(when_FpUnit_l242) begin
      _zz_res_5 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l243) begin
        _zz_res_5 = 32'h7fc00000;
      end else begin
        if(when_FpUnit_l244) begin
          _zz_res_5 = {when_FpUnit_l519,{8'hff,23'h0}};
        end else begin
          if(when_FpUnit_l245) begin
            _zz_res_5 = {_zz_when_FpUnit_l243_1,{8'hff,23'h0}};
          end else begin
            if(when_FpUnit_l246) begin
              _zz_res_5 = {((io_rm == 3'b010) ? 1'b1 : 1'b0),{8'h0,23'h0}};
            end
          end
        end
      end
    end
  end

  assign when_FpUnit_l242 = (when_FpUnit_l342 || when_FpUnit_l431);
  assign when_FpUnit_l243 = ((when_FpUnit_l244 && when_FpUnit_l245) && (when_FpUnit_l519 != _zz_when_FpUnit_l243_1));
  assign _zz_when_FpUnit_l243_2 = (_zz_when_FpUnit_l243 ^ 1'b1);
  assign _zz_when_FpUnit_l218_5 = ($signed(_zz_when_FpUnit_l218) < $signed(_zz_when_FpUnit_l218_1));
  assign _zz_when_FpUnit_l88_11 = (_zz_when_FpUnit_l218_5 ? _zz_when_FpUnit_l243_2 : when_FpUnit_l519);
  assign _zz_when_FpUnit_l88_12 = (_zz_when_FpUnit_l218_5 ? when_FpUnit_l519 : _zz_when_FpUnit_l243_2);
  assign _zz_when_FpUnit_l218_6 = (_zz_when_FpUnit_l218_5 ? _zz_when_FpUnit_l218_1 : _zz_when_FpUnit_l218);
  assign _zz_when_FpUnit_l88_13 = _zz__zz_when_FpUnit_l88_13[27:0];
  assign _zz_when_FpUnit_l218_7 = _zz__zz_when_FpUnit_l218_7;
  assign when_FpUnit_l218_1 = (10'h01c <= _zz_when_FpUnit_l218_7);
  always @(*) begin
    if(when_FpUnit_l218_1) begin
      _zz_when_FpUnit_l88_14 = 28'h0;
    end else begin
      _zz_when_FpUnit_l88_14 = _zz__zz_when_FpUnit_l88_14;
    end
  end

  assign _zz_when_FpUnit_l88_15 = (! (_zz_when_FpUnit_l88_11 == _zz_when_FpUnit_l88_12));
  assign _zz_when_FpUnit_l88_16 = _zz_when_FpUnit_l88_14;
  assign _zz_when_FpUnit_l88_17 = (_zz_when_FpUnit_l88_15 && (_zz_when_FpUnit_l88_13 < _zz_when_FpUnit_l88_16));
  assign _zz_when_FpUnit_l88_18 = (_zz_when_FpUnit_l88_15 ? (_zz_when_FpUnit_l88_17 ? _zz__zz_when_FpUnit_l88_18 : _zz__zz_when_FpUnit_l88_18_1) : _zz__zz_when_FpUnit_l88_18_2);
  assign _zz_res_6 = (_zz_when_FpUnit_l88_17 ? _zz_when_FpUnit_l88_12 : _zz_when_FpUnit_l88_11);
  always @(*) begin
    _zz_when_FpUnit_l95_1 = 5'h0;
    if(when_FpUnit_l88_28) begin
      _zz_when_FpUnit_l95_1 = 5'h0;
    end
    if(when_FpUnit_l88_29) begin
      _zz_when_FpUnit_l95_1 = 5'h01;
    end
    if(when_FpUnit_l88_30) begin
      _zz_when_FpUnit_l95_1 = 5'h02;
    end
    if(when_FpUnit_l88_31) begin
      _zz_when_FpUnit_l95_1 = 5'h03;
    end
    if(when_FpUnit_l88_32) begin
      _zz_when_FpUnit_l95_1 = 5'h04;
    end
    if(when_FpUnit_l88_33) begin
      _zz_when_FpUnit_l95_1 = 5'h05;
    end
    if(when_FpUnit_l88_34) begin
      _zz_when_FpUnit_l95_1 = 5'h06;
    end
    if(when_FpUnit_l88_35) begin
      _zz_when_FpUnit_l95_1 = 5'h07;
    end
    if(when_FpUnit_l88_36) begin
      _zz_when_FpUnit_l95_1 = 5'h08;
    end
    if(when_FpUnit_l88_37) begin
      _zz_when_FpUnit_l95_1 = 5'h09;
    end
    if(when_FpUnit_l88_38) begin
      _zz_when_FpUnit_l95_1 = 5'h0a;
    end
    if(when_FpUnit_l88_39) begin
      _zz_when_FpUnit_l95_1 = 5'h0b;
    end
    if(when_FpUnit_l88_40) begin
      _zz_when_FpUnit_l95_1 = 5'h0c;
    end
    if(when_FpUnit_l88_41) begin
      _zz_when_FpUnit_l95_1 = 5'h0d;
    end
    if(when_FpUnit_l88_42) begin
      _zz_when_FpUnit_l95_1 = 5'h0e;
    end
    if(when_FpUnit_l88_43) begin
      _zz_when_FpUnit_l95_1 = 5'h0f;
    end
    if(when_FpUnit_l88_44) begin
      _zz_when_FpUnit_l95_1 = 5'h10;
    end
    if(when_FpUnit_l88_45) begin
      _zz_when_FpUnit_l95_1 = 5'h11;
    end
    if(when_FpUnit_l88_46) begin
      _zz_when_FpUnit_l95_1 = 5'h12;
    end
    if(when_FpUnit_l88_47) begin
      _zz_when_FpUnit_l95_1 = 5'h13;
    end
    if(when_FpUnit_l88_48) begin
      _zz_when_FpUnit_l95_1 = 5'h14;
    end
    if(when_FpUnit_l88_49) begin
      _zz_when_FpUnit_l95_1 = 5'h15;
    end
    if(when_FpUnit_l88_50) begin
      _zz_when_FpUnit_l95_1 = 5'h16;
    end
    if(when_FpUnit_l88_51) begin
      _zz_when_FpUnit_l95_1 = 5'h17;
    end
    if(when_FpUnit_l88_52) begin
      _zz_when_FpUnit_l95_1 = 5'h18;
    end
    if(when_FpUnit_l88_53) begin
      _zz_when_FpUnit_l95_1 = 5'h19;
    end
    if(when_FpUnit_l88_54) begin
      _zz_when_FpUnit_l95_1 = 5'h1a;
    end
    if(when_FpUnit_l88_55) begin
      _zz_when_FpUnit_l95_1 = 5'h1b;
    end
  end

  assign when_FpUnit_l88_28 = _zz_when_FpUnit_l88_18[0];
  assign when_FpUnit_l88_29 = _zz_when_FpUnit_l88_18[1];
  assign when_FpUnit_l88_30 = _zz_when_FpUnit_l88_18[2];
  assign when_FpUnit_l88_31 = _zz_when_FpUnit_l88_18[3];
  assign when_FpUnit_l88_32 = _zz_when_FpUnit_l88_18[4];
  assign when_FpUnit_l88_33 = _zz_when_FpUnit_l88_18[5];
  assign when_FpUnit_l88_34 = _zz_when_FpUnit_l88_18[6];
  assign when_FpUnit_l88_35 = _zz_when_FpUnit_l88_18[7];
  assign when_FpUnit_l88_36 = _zz_when_FpUnit_l88_18[8];
  assign when_FpUnit_l88_37 = _zz_when_FpUnit_l88_18[9];
  assign when_FpUnit_l88_38 = _zz_when_FpUnit_l88_18[10];
  assign when_FpUnit_l88_39 = _zz_when_FpUnit_l88_18[11];
  assign when_FpUnit_l88_40 = _zz_when_FpUnit_l88_18[12];
  assign when_FpUnit_l88_41 = _zz_when_FpUnit_l88_18[13];
  assign when_FpUnit_l88_42 = _zz_when_FpUnit_l88_18[14];
  assign when_FpUnit_l88_43 = _zz_when_FpUnit_l88_18[15];
  assign when_FpUnit_l88_44 = _zz_when_FpUnit_l88_18[16];
  assign when_FpUnit_l88_45 = _zz_when_FpUnit_l88_18[17];
  assign when_FpUnit_l88_46 = _zz_when_FpUnit_l88_18[18];
  assign when_FpUnit_l88_47 = _zz_when_FpUnit_l88_18[19];
  assign when_FpUnit_l88_48 = _zz_when_FpUnit_l88_18[20];
  assign when_FpUnit_l88_49 = _zz_when_FpUnit_l88_18[21];
  assign when_FpUnit_l88_50 = _zz_when_FpUnit_l88_18[22];
  assign when_FpUnit_l88_51 = _zz_when_FpUnit_l88_18[23];
  assign when_FpUnit_l88_52 = _zz_when_FpUnit_l88_18[24];
  assign when_FpUnit_l88_53 = _zz_when_FpUnit_l88_18[25];
  assign when_FpUnit_l88_54 = _zz_when_FpUnit_l88_18[26];
  assign when_FpUnit_l88_55 = _zz_when_FpUnit_l88_18[27];
  always @(*) begin
    _zz_flagUF_14 = 27'h0;
    if(when_FpUnit_l94_1) begin
      if(when_FpUnit_l95_1) begin
        _zz_flagUF_14 = _zz__zz_flagUF_14;
      end else begin
        _zz_flagUF_14 = _zz__zz_flagUF_14_2;
      end
    end
  end

  always @(*) begin
    _zz_flagUF_15 = 1'b0;
    if(when_FpUnit_l94_1) begin
      if(when_FpUnit_l95_1) begin
        _zz_flagUF_15 = (|(_zz_when_FpUnit_l88_18 & _zz__zz_flagUF_15));
      end else begin
        _zz_flagUF_15 = 1'b0;
      end
    end
  end

  assign _zz_flagUF_16 = ($signed(_zz__zz_flagUF_16) + $signed(_zz__zz_flagUF_16_2));
  assign when_FpUnit_l94_1 = (_zz_when_FpUnit_l88_18 != 28'h0);
  assign when_FpUnit_l95_1 = (5'h1a < _zz_when_FpUnit_l95_1);
  assign _zz_flagUF_17 = (_zz_when_FpUnit_l95_1 - 5'h1a);
  assign when_FpUnit_l246_1 = (_zz_when_FpUnit_l88_18 == 28'h0);
  assign _zz_flagUF_18 = _zz__zz_flagUF_18;
  assign _zz_flagUF_19 = _zz_flagUF_18;
  assign _zz_flagUF_20 = (_zz_flagUF_15 || (|(_zz_flagUF_18 & 29'h0)));
  assign _zz_flagUF_21 = ($signed(_zz__zz_flagUF_21) < $signed(12'h001));
  assign _zz_when_FpUnit_l147_1 = (_zz_flagUF_21 ? _zz__zz_when_FpUnit_l147_1 : 12'h0);
  assign _zz_when_FpUnit_l150_1 = _zz_when_FpUnit_l147_1;
  assign when_FpUnit_l147_1 = ($signed(_zz_when_FpUnit_l147_1) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l147_1) begin
      _zz_flagUF_22 = _zz__zz_flagUF_22;
    end else begin
      if(when_FpUnit_l150_1) begin
        _zz_flagUF_22 = 27'h0;
      end else begin
        _zz_flagUF_22 = _zz__zz_flagUF_22_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l147_1) begin
      _zz_flagUF_23 = _zz_flagUF_20;
    end else begin
      if(when_FpUnit_l150_1) begin
        _zz_flagUF_23 = ((|_zz_flagUF_19) || _zz_flagUF_20);
      end else begin
        _zz_flagUF_23 = ((|(_zz_flagUF_19 & _zz__zz_flagUF_23)) || _zz_flagUF_20);
      end
    end
  end

  assign when_FpUnit_l150_1 = (12'h01b <= _zz_when_FpUnit_l150_1);
  assign _zz_when_FpUnit_l186_3 = (_zz_flagUF_21 ? 12'hf82 : _zz_flagUF_16);
  assign _zz_flagUF_24 = _zz_flagUF_22[2];
  assign _zz_flagUF_25 = _zz_flagUF_22[1];
  assign _zz_flagUF_26 = (_zz_flagUF_22[0] || _zz_flagUF_23);
  assign _zz_when_FpUnit_l190_3 = _zz_flagUF_22[26 : 3];
  assign _zz_when_FpUnit_l190_4 = (_zz__zz_when_FpUnit_l190_4 + _zz__zz_when_FpUnit_l190_4_2);
  assign _zz_when_FpUnit_l186_4 = _zz_when_FpUnit_l190_4[24];
  assign _zz_when_FpUnit_l190_5 = (_zz_when_FpUnit_l186_4 ? _zz__zz_when_FpUnit_l190_5 : _zz__zz_when_FpUnit_l190_5_1);
  assign _zz_when_FpUnit_l186_5 = ($signed(_zz__zz_when_FpUnit_l186_5) + $signed(12'h07f));
  assign _zz_flagUF_27 = ((_zz_flagUF_24 || _zz_flagUF_25) || _zz_flagUF_26);
  assign when_FpUnit_l186_1 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l186_5));
  assign _zz_res_7 = {_zz_res_6,{8'hff,23'h0}};
  assign _zz_res_8 = {_zz_res_6,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_9 = 32'h0;
    if(when_FpUnit_l186_1) begin
      _zz_res_9 = ((io_rm == 3'b001) ? _zz_res_8 : ((io_rm == 3'b010) ? (_zz_res_6 ? _zz_res_7 : _zz_res_8) : ((io_rm == 3'b011) ? (_zz_res_6 ? _zz_res_8 : _zz_res_7) : _zz_res_7)));
    end else begin
      if(when_FpUnit_l190_1) begin
        _zz_res_9 = {_zz_res_6,{8'h0,23'h0}};
      end else begin
        if(when_FpUnit_l192_1) begin
          _zz_res_9 = {_zz_res_6,{8'h0,_zz_when_FpUnit_l190_5[22 : 0]}};
        end else begin
          _zz_res_9 = {_zz_res_6,{_zz__zz_res_9,_zz_when_FpUnit_l190_5[22 : 0]}};
        end
      end
    end
  end

  assign when_FpUnit_l190_1 = (_zz_flagUF_21 && (_zz_when_FpUnit_l190_5 == 24'h0));
  assign when_FpUnit_l192_1 = ((_zz_flagUF_21 && (_zz_when_FpUnit_l190_5 != 24'h0)) && (! _zz_when_FpUnit_l190_5[23]));
  always @(*) begin
    _zz_res_10 = _zz_res_9;
    if(when_FpUnit_l242_1) begin
      _zz_res_10 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l243_1) begin
        _zz_res_10 = 32'h7fc00000;
      end else begin
        if(when_FpUnit_l244) begin
          _zz_res_10 = {when_FpUnit_l519,{8'hff,23'h0}};
        end else begin
          if(when_FpUnit_l245) begin
            _zz_res_10 = {_zz_when_FpUnit_l243_2,{8'hff,23'h0}};
          end else begin
            if(when_FpUnit_l246_1) begin
              _zz_res_10 = {((io_rm == 3'b010) ? 1'b1 : 1'b0),{8'h0,23'h0}};
            end
          end
        end
      end
    end
  end

  assign when_FpUnit_l242_1 = (when_FpUnit_l342 || when_FpUnit_l431);
  assign when_FpUnit_l243_1 = ((when_FpUnit_l244 && when_FpUnit_l245) && (when_FpUnit_l519 != _zz_when_FpUnit_l243_2));
  assign _zz_res_11 = (when_FpUnit_l519 ^ _zz_when_FpUnit_l243);
  assign _zz_when_FpUnit_l88_19 = (_zz_when_FpUnit_l88 * _zz_when_FpUnit_l88_1);
  always @(*) begin
    _zz_when_FpUnit_l95_2 = 6'h0;
    if(when_FpUnit_l88_56) begin
      _zz_when_FpUnit_l95_2 = 6'h0;
    end
    if(when_FpUnit_l88_57) begin
      _zz_when_FpUnit_l95_2 = 6'h01;
    end
    if(when_FpUnit_l88_58) begin
      _zz_when_FpUnit_l95_2 = 6'h02;
    end
    if(when_FpUnit_l88_59) begin
      _zz_when_FpUnit_l95_2 = 6'h03;
    end
    if(when_FpUnit_l88_60) begin
      _zz_when_FpUnit_l95_2 = 6'h04;
    end
    if(when_FpUnit_l88_61) begin
      _zz_when_FpUnit_l95_2 = 6'h05;
    end
    if(when_FpUnit_l88_62) begin
      _zz_when_FpUnit_l95_2 = 6'h06;
    end
    if(when_FpUnit_l88_63) begin
      _zz_when_FpUnit_l95_2 = 6'h07;
    end
    if(when_FpUnit_l88_64) begin
      _zz_when_FpUnit_l95_2 = 6'h08;
    end
    if(when_FpUnit_l88_65) begin
      _zz_when_FpUnit_l95_2 = 6'h09;
    end
    if(when_FpUnit_l88_66) begin
      _zz_when_FpUnit_l95_2 = 6'h0a;
    end
    if(when_FpUnit_l88_67) begin
      _zz_when_FpUnit_l95_2 = 6'h0b;
    end
    if(when_FpUnit_l88_68) begin
      _zz_when_FpUnit_l95_2 = 6'h0c;
    end
    if(when_FpUnit_l88_69) begin
      _zz_when_FpUnit_l95_2 = 6'h0d;
    end
    if(when_FpUnit_l88_70) begin
      _zz_when_FpUnit_l95_2 = 6'h0e;
    end
    if(when_FpUnit_l88_71) begin
      _zz_when_FpUnit_l95_2 = 6'h0f;
    end
    if(when_FpUnit_l88_72) begin
      _zz_when_FpUnit_l95_2 = 6'h10;
    end
    if(when_FpUnit_l88_73) begin
      _zz_when_FpUnit_l95_2 = 6'h11;
    end
    if(when_FpUnit_l88_74) begin
      _zz_when_FpUnit_l95_2 = 6'h12;
    end
    if(when_FpUnit_l88_75) begin
      _zz_when_FpUnit_l95_2 = 6'h13;
    end
    if(when_FpUnit_l88_76) begin
      _zz_when_FpUnit_l95_2 = 6'h14;
    end
    if(when_FpUnit_l88_77) begin
      _zz_when_FpUnit_l95_2 = 6'h15;
    end
    if(when_FpUnit_l88_78) begin
      _zz_when_FpUnit_l95_2 = 6'h16;
    end
    if(when_FpUnit_l88_79) begin
      _zz_when_FpUnit_l95_2 = 6'h17;
    end
    if(when_FpUnit_l88_80) begin
      _zz_when_FpUnit_l95_2 = 6'h18;
    end
    if(when_FpUnit_l88_81) begin
      _zz_when_FpUnit_l95_2 = 6'h19;
    end
    if(when_FpUnit_l88_82) begin
      _zz_when_FpUnit_l95_2 = 6'h1a;
    end
    if(when_FpUnit_l88_83) begin
      _zz_when_FpUnit_l95_2 = 6'h1b;
    end
    if(when_FpUnit_l88_84) begin
      _zz_when_FpUnit_l95_2 = 6'h1c;
    end
    if(when_FpUnit_l88_85) begin
      _zz_when_FpUnit_l95_2 = 6'h1d;
    end
    if(when_FpUnit_l88_86) begin
      _zz_when_FpUnit_l95_2 = 6'h1e;
    end
    if(when_FpUnit_l88_87) begin
      _zz_when_FpUnit_l95_2 = 6'h1f;
    end
    if(when_FpUnit_l88_88) begin
      _zz_when_FpUnit_l95_2 = 6'h20;
    end
    if(when_FpUnit_l88_89) begin
      _zz_when_FpUnit_l95_2 = 6'h21;
    end
    if(when_FpUnit_l88_90) begin
      _zz_when_FpUnit_l95_2 = 6'h22;
    end
    if(when_FpUnit_l88_91) begin
      _zz_when_FpUnit_l95_2 = 6'h23;
    end
    if(when_FpUnit_l88_92) begin
      _zz_when_FpUnit_l95_2 = 6'h24;
    end
    if(when_FpUnit_l88_93) begin
      _zz_when_FpUnit_l95_2 = 6'h25;
    end
    if(when_FpUnit_l88_94) begin
      _zz_when_FpUnit_l95_2 = 6'h26;
    end
    if(when_FpUnit_l88_95) begin
      _zz_when_FpUnit_l95_2 = 6'h27;
    end
    if(when_FpUnit_l88_96) begin
      _zz_when_FpUnit_l95_2 = 6'h28;
    end
    if(when_FpUnit_l88_97) begin
      _zz_when_FpUnit_l95_2 = 6'h29;
    end
    if(when_FpUnit_l88_98) begin
      _zz_when_FpUnit_l95_2 = 6'h2a;
    end
    if(when_FpUnit_l88_99) begin
      _zz_when_FpUnit_l95_2 = 6'h2b;
    end
    if(when_FpUnit_l88_100) begin
      _zz_when_FpUnit_l95_2 = 6'h2c;
    end
    if(when_FpUnit_l88_101) begin
      _zz_when_FpUnit_l95_2 = 6'h2d;
    end
    if(when_FpUnit_l88_102) begin
      _zz_when_FpUnit_l95_2 = 6'h2e;
    end
    if(when_FpUnit_l88_103) begin
      _zz_when_FpUnit_l95_2 = 6'h2f;
    end
  end

  assign when_FpUnit_l88_56 = _zz_when_FpUnit_l88_19[0];
  assign when_FpUnit_l88_57 = _zz_when_FpUnit_l88_19[1];
  assign when_FpUnit_l88_58 = _zz_when_FpUnit_l88_19[2];
  assign when_FpUnit_l88_59 = _zz_when_FpUnit_l88_19[3];
  assign when_FpUnit_l88_60 = _zz_when_FpUnit_l88_19[4];
  assign when_FpUnit_l88_61 = _zz_when_FpUnit_l88_19[5];
  assign when_FpUnit_l88_62 = _zz_when_FpUnit_l88_19[6];
  assign when_FpUnit_l88_63 = _zz_when_FpUnit_l88_19[7];
  assign when_FpUnit_l88_64 = _zz_when_FpUnit_l88_19[8];
  assign when_FpUnit_l88_65 = _zz_when_FpUnit_l88_19[9];
  assign when_FpUnit_l88_66 = _zz_when_FpUnit_l88_19[10];
  assign when_FpUnit_l88_67 = _zz_when_FpUnit_l88_19[11];
  assign when_FpUnit_l88_68 = _zz_when_FpUnit_l88_19[12];
  assign when_FpUnit_l88_69 = _zz_when_FpUnit_l88_19[13];
  assign when_FpUnit_l88_70 = _zz_when_FpUnit_l88_19[14];
  assign when_FpUnit_l88_71 = _zz_when_FpUnit_l88_19[15];
  assign when_FpUnit_l88_72 = _zz_when_FpUnit_l88_19[16];
  assign when_FpUnit_l88_73 = _zz_when_FpUnit_l88_19[17];
  assign when_FpUnit_l88_74 = _zz_when_FpUnit_l88_19[18];
  assign when_FpUnit_l88_75 = _zz_when_FpUnit_l88_19[19];
  assign when_FpUnit_l88_76 = _zz_when_FpUnit_l88_19[20];
  assign when_FpUnit_l88_77 = _zz_when_FpUnit_l88_19[21];
  assign when_FpUnit_l88_78 = _zz_when_FpUnit_l88_19[22];
  assign when_FpUnit_l88_79 = _zz_when_FpUnit_l88_19[23];
  assign when_FpUnit_l88_80 = _zz_when_FpUnit_l88_19[24];
  assign when_FpUnit_l88_81 = _zz_when_FpUnit_l88_19[25];
  assign when_FpUnit_l88_82 = _zz_when_FpUnit_l88_19[26];
  assign when_FpUnit_l88_83 = _zz_when_FpUnit_l88_19[27];
  assign when_FpUnit_l88_84 = _zz_when_FpUnit_l88_19[28];
  assign when_FpUnit_l88_85 = _zz_when_FpUnit_l88_19[29];
  assign when_FpUnit_l88_86 = _zz_when_FpUnit_l88_19[30];
  assign when_FpUnit_l88_87 = _zz_when_FpUnit_l88_19[31];
  assign when_FpUnit_l88_88 = _zz_when_FpUnit_l88_19[32];
  assign when_FpUnit_l88_89 = _zz_when_FpUnit_l88_19[33];
  assign when_FpUnit_l88_90 = _zz_when_FpUnit_l88_19[34];
  assign when_FpUnit_l88_91 = _zz_when_FpUnit_l88_19[35];
  assign when_FpUnit_l88_92 = _zz_when_FpUnit_l88_19[36];
  assign when_FpUnit_l88_93 = _zz_when_FpUnit_l88_19[37];
  assign when_FpUnit_l88_94 = _zz_when_FpUnit_l88_19[38];
  assign when_FpUnit_l88_95 = _zz_when_FpUnit_l88_19[39];
  assign when_FpUnit_l88_96 = _zz_when_FpUnit_l88_19[40];
  assign when_FpUnit_l88_97 = _zz_when_FpUnit_l88_19[41];
  assign when_FpUnit_l88_98 = _zz_when_FpUnit_l88_19[42];
  assign when_FpUnit_l88_99 = _zz_when_FpUnit_l88_19[43];
  assign when_FpUnit_l88_100 = _zz_when_FpUnit_l88_19[44];
  assign when_FpUnit_l88_101 = _zz_when_FpUnit_l88_19[45];
  assign when_FpUnit_l88_102 = _zz_when_FpUnit_l88_19[46];
  assign when_FpUnit_l88_103 = _zz_when_FpUnit_l88_19[47];
  always @(*) begin
    _zz_flagUF_28 = 27'h0;
    if(when_FpUnit_l94_2) begin
      if(when_FpUnit_l95_2) begin
        _zz_flagUF_28 = _zz__zz_flagUF_28;
      end else begin
        _zz_flagUF_28 = _zz__zz_flagUF_28_2;
      end
    end
  end

  always @(*) begin
    _zz_flagUF_29 = 1'b0;
    if(when_FpUnit_l94_2) begin
      if(when_FpUnit_l95_2) begin
        _zz_flagUF_29 = (|(_zz_when_FpUnit_l88_19 & _zz__zz_flagUF_29));
      end else begin
        _zz_flagUF_29 = 1'b0;
      end
    end
  end

  assign _zz_flagUF_30 = ($signed(_zz__zz_flagUF_30) + $signed(_zz__zz_flagUF_30_2));
  assign when_FpUnit_l94_2 = (_zz_when_FpUnit_l88_19 != 48'h0);
  assign when_FpUnit_l95_2 = (6'h1a < _zz_when_FpUnit_l95_2);
  assign _zz_flagUF_31 = (_zz_when_FpUnit_l95_2 - 6'h1a);
  assign _zz_flagUF_32 = _zz__zz_flagUF_32;
  assign _zz_flagUF_33 = _zz_flagUF_32;
  assign _zz_flagUF_34 = (_zz_flagUF_29 || (|(_zz_flagUF_32 & 29'h0)));
  assign _zz_flagUF_35 = ($signed(_zz__zz_flagUF_35) < $signed(12'h001));
  assign _zz_when_FpUnit_l147_2 = (_zz_flagUF_35 ? _zz__zz_when_FpUnit_l147_2 : 12'h0);
  assign _zz_when_FpUnit_l150_2 = _zz_when_FpUnit_l147_2;
  assign when_FpUnit_l147_2 = ($signed(_zz_when_FpUnit_l147_2) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l147_2) begin
      _zz_flagUF_36 = _zz__zz_flagUF_36;
    end else begin
      if(when_FpUnit_l150_2) begin
        _zz_flagUF_36 = 27'h0;
      end else begin
        _zz_flagUF_36 = _zz__zz_flagUF_36_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l147_2) begin
      _zz_flagUF_37 = _zz_flagUF_34;
    end else begin
      if(when_FpUnit_l150_2) begin
        _zz_flagUF_37 = ((|_zz_flagUF_33) || _zz_flagUF_34);
      end else begin
        _zz_flagUF_37 = ((|(_zz_flagUF_33 & _zz__zz_flagUF_37)) || _zz_flagUF_34);
      end
    end
  end

  assign when_FpUnit_l150_2 = (12'h01b <= _zz_when_FpUnit_l150_2);
  assign _zz_when_FpUnit_l186_6 = (_zz_flagUF_35 ? 12'hf82 : _zz_flagUF_30);
  assign _zz_flagUF_38 = _zz_flagUF_36[2];
  assign _zz_flagUF_39 = _zz_flagUF_36[1];
  assign _zz_flagUF_40 = (_zz_flagUF_36[0] || _zz_flagUF_37);
  assign _zz_when_FpUnit_l190_6 = _zz_flagUF_36[26 : 3];
  assign _zz_when_FpUnit_l190_7 = (_zz__zz_when_FpUnit_l190_7 + _zz__zz_when_FpUnit_l190_7_2);
  assign _zz_when_FpUnit_l186_7 = _zz_when_FpUnit_l190_7[24];
  assign _zz_when_FpUnit_l190_8 = (_zz_when_FpUnit_l186_7 ? _zz__zz_when_FpUnit_l190_8 : _zz__zz_when_FpUnit_l190_8_1);
  assign _zz_when_FpUnit_l186_8 = ($signed(_zz__zz_when_FpUnit_l186_8) + $signed(12'h07f));
  assign _zz_flagUF_41 = ((_zz_flagUF_38 || _zz_flagUF_39) || _zz_flagUF_40);
  assign when_FpUnit_l186_2 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l186_8));
  assign _zz_res_12 = {_zz_res_11,{8'hff,23'h0}};
  assign _zz_res_13 = {_zz_res_11,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_14 = 32'h0;
    if(when_FpUnit_l186_2) begin
      _zz_res_14 = ((io_rm == 3'b001) ? _zz_res_13 : ((io_rm == 3'b010) ? (_zz_res_11 ? _zz_res_12 : _zz_res_13) : ((io_rm == 3'b011) ? (_zz_res_11 ? _zz_res_13 : _zz_res_12) : _zz_res_12)));
    end else begin
      if(when_FpUnit_l190_2) begin
        _zz_res_14 = {_zz_res_11,{8'h0,23'h0}};
      end else begin
        if(when_FpUnit_l192_2) begin
          _zz_res_14 = {_zz_res_11,{8'h0,_zz_when_FpUnit_l190_8[22 : 0]}};
        end else begin
          _zz_res_14 = {_zz_res_11,{_zz__zz_res_14,_zz_when_FpUnit_l190_8[22 : 0]}};
        end
      end
    end
  end

  assign when_FpUnit_l190_2 = (_zz_flagUF_35 && (_zz_when_FpUnit_l190_8 == 24'h0));
  assign when_FpUnit_l192_2 = ((_zz_flagUF_35 && (_zz_when_FpUnit_l190_8 != 24'h0)) && (! _zz_when_FpUnit_l190_8[23]));
  always @(*) begin
    _zz_res_15 = _zz_res_14;
    if(when_FpUnit_l272) begin
      _zz_res_15 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l273) begin
        _zz_res_15 = 32'h7fc00000;
      end else begin
        if(when_FpUnit_l274) begin
          _zz_res_15 = {_zz_res_11,{8'hff,23'h0}};
        end else begin
          if(when_FpUnit_l275) begin
            _zz_res_15 = {_zz_res_11,{8'h0,23'h0}};
          end
        end
      end
    end
  end

  assign when_FpUnit_l272 = (when_FpUnit_l342 || when_FpUnit_l431);
  assign when_FpUnit_l273 = ((when_FpUnit_l244 && when_FpUnit_l305) || (when_FpUnit_l308 && when_FpUnit_l245));
  assign when_FpUnit_l274 = (when_FpUnit_l244 || when_FpUnit_l245);
  assign when_FpUnit_l275 = (when_FpUnit_l308 || when_FpUnit_l305);
  assign _zz_res_16 = (when_FpUnit_l519 ^ _zz_when_FpUnit_l243);
  assign _zz_when_FpUnit_l88_20 = ({27'd0,_zz__zz_when_FpUnit_l88_20} <<< 5'd27);
  assign _zz_when_FpUnit_l88_21 = _zz__zz_when_FpUnit_l88_21[28:0];
  always @(*) begin
    _zz_when_FpUnit_l95_3 = 5'h0;
    if(when_FpUnit_l88_104) begin
      _zz_when_FpUnit_l95_3 = 5'h0;
    end
    if(when_FpUnit_l88_105) begin
      _zz_when_FpUnit_l95_3 = 5'h01;
    end
    if(when_FpUnit_l88_106) begin
      _zz_when_FpUnit_l95_3 = 5'h02;
    end
    if(when_FpUnit_l88_107) begin
      _zz_when_FpUnit_l95_3 = 5'h03;
    end
    if(when_FpUnit_l88_108) begin
      _zz_when_FpUnit_l95_3 = 5'h04;
    end
    if(when_FpUnit_l88_109) begin
      _zz_when_FpUnit_l95_3 = 5'h05;
    end
    if(when_FpUnit_l88_110) begin
      _zz_when_FpUnit_l95_3 = 5'h06;
    end
    if(when_FpUnit_l88_111) begin
      _zz_when_FpUnit_l95_3 = 5'h07;
    end
    if(when_FpUnit_l88_112) begin
      _zz_when_FpUnit_l95_3 = 5'h08;
    end
    if(when_FpUnit_l88_113) begin
      _zz_when_FpUnit_l95_3 = 5'h09;
    end
    if(when_FpUnit_l88_114) begin
      _zz_when_FpUnit_l95_3 = 5'h0a;
    end
    if(when_FpUnit_l88_115) begin
      _zz_when_FpUnit_l95_3 = 5'h0b;
    end
    if(when_FpUnit_l88_116) begin
      _zz_when_FpUnit_l95_3 = 5'h0c;
    end
    if(when_FpUnit_l88_117) begin
      _zz_when_FpUnit_l95_3 = 5'h0d;
    end
    if(when_FpUnit_l88_118) begin
      _zz_when_FpUnit_l95_3 = 5'h0e;
    end
    if(when_FpUnit_l88_119) begin
      _zz_when_FpUnit_l95_3 = 5'h0f;
    end
    if(when_FpUnit_l88_120) begin
      _zz_when_FpUnit_l95_3 = 5'h10;
    end
    if(when_FpUnit_l88_121) begin
      _zz_when_FpUnit_l95_3 = 5'h11;
    end
    if(when_FpUnit_l88_122) begin
      _zz_when_FpUnit_l95_3 = 5'h12;
    end
    if(when_FpUnit_l88_123) begin
      _zz_when_FpUnit_l95_3 = 5'h13;
    end
    if(when_FpUnit_l88_124) begin
      _zz_when_FpUnit_l95_3 = 5'h14;
    end
    if(when_FpUnit_l88_125) begin
      _zz_when_FpUnit_l95_3 = 5'h15;
    end
    if(when_FpUnit_l88_126) begin
      _zz_when_FpUnit_l95_3 = 5'h16;
    end
    if(when_FpUnit_l88_127) begin
      _zz_when_FpUnit_l95_3 = 5'h17;
    end
    if(when_FpUnit_l88_128) begin
      _zz_when_FpUnit_l95_3 = 5'h18;
    end
    if(when_FpUnit_l88_129) begin
      _zz_when_FpUnit_l95_3 = 5'h19;
    end
    if(when_FpUnit_l88_130) begin
      _zz_when_FpUnit_l95_3 = 5'h1a;
    end
    if(when_FpUnit_l88_131) begin
      _zz_when_FpUnit_l95_3 = 5'h1b;
    end
    if(when_FpUnit_l88_132) begin
      _zz_when_FpUnit_l95_3 = 5'h1c;
    end
  end

  assign when_FpUnit_l88_104 = _zz_when_FpUnit_l88_21[0];
  assign when_FpUnit_l88_105 = _zz_when_FpUnit_l88_21[1];
  assign when_FpUnit_l88_106 = _zz_when_FpUnit_l88_21[2];
  assign when_FpUnit_l88_107 = _zz_when_FpUnit_l88_21[3];
  assign when_FpUnit_l88_108 = _zz_when_FpUnit_l88_21[4];
  assign when_FpUnit_l88_109 = _zz_when_FpUnit_l88_21[5];
  assign when_FpUnit_l88_110 = _zz_when_FpUnit_l88_21[6];
  assign when_FpUnit_l88_111 = _zz_when_FpUnit_l88_21[7];
  assign when_FpUnit_l88_112 = _zz_when_FpUnit_l88_21[8];
  assign when_FpUnit_l88_113 = _zz_when_FpUnit_l88_21[9];
  assign when_FpUnit_l88_114 = _zz_when_FpUnit_l88_21[10];
  assign when_FpUnit_l88_115 = _zz_when_FpUnit_l88_21[11];
  assign when_FpUnit_l88_116 = _zz_when_FpUnit_l88_21[12];
  assign when_FpUnit_l88_117 = _zz_when_FpUnit_l88_21[13];
  assign when_FpUnit_l88_118 = _zz_when_FpUnit_l88_21[14];
  assign when_FpUnit_l88_119 = _zz_when_FpUnit_l88_21[15];
  assign when_FpUnit_l88_120 = _zz_when_FpUnit_l88_21[16];
  assign when_FpUnit_l88_121 = _zz_when_FpUnit_l88_21[17];
  assign when_FpUnit_l88_122 = _zz_when_FpUnit_l88_21[18];
  assign when_FpUnit_l88_123 = _zz_when_FpUnit_l88_21[19];
  assign when_FpUnit_l88_124 = _zz_when_FpUnit_l88_21[20];
  assign when_FpUnit_l88_125 = _zz_when_FpUnit_l88_21[21];
  assign when_FpUnit_l88_126 = _zz_when_FpUnit_l88_21[22];
  assign when_FpUnit_l88_127 = _zz_when_FpUnit_l88_21[23];
  assign when_FpUnit_l88_128 = _zz_when_FpUnit_l88_21[24];
  assign when_FpUnit_l88_129 = _zz_when_FpUnit_l88_21[25];
  assign when_FpUnit_l88_130 = _zz_when_FpUnit_l88_21[26];
  assign when_FpUnit_l88_131 = _zz_when_FpUnit_l88_21[27];
  assign when_FpUnit_l88_132 = _zz_when_FpUnit_l88_21[28];
  always @(*) begin
    _zz_flagUF_42 = 27'h0;
    if(when_FpUnit_l94_3) begin
      if(when_FpUnit_l95_3) begin
        _zz_flagUF_42 = _zz__zz_flagUF_42;
      end else begin
        _zz_flagUF_42 = _zz__zz_flagUF_42_2;
      end
    end
  end

  always @(*) begin
    _zz_flagUF_43 = 1'b0;
    if(when_FpUnit_l94_3) begin
      if(when_FpUnit_l95_3) begin
        _zz_flagUF_43 = (|(_zz_when_FpUnit_l88_21 & _zz__zz_flagUF_43));
      end else begin
        _zz_flagUF_43 = 1'b0;
      end
    end
  end

  assign _zz_flagUF_44 = ($signed(_zz__zz_flagUF_44) + $signed(_zz__zz_flagUF_44_2));
  assign when_FpUnit_l94_3 = (_zz_when_FpUnit_l88_21 != 29'h0);
  assign when_FpUnit_l95_3 = (5'h1a < _zz_when_FpUnit_l95_3);
  assign _zz_flagUF_45 = (_zz_when_FpUnit_l95_3 - 5'h1a);
  assign _zz_flagUF_46 = _zz__zz_flagUF_46;
  assign _zz_flagUF_47 = _zz_flagUF_46;
  assign _zz_flagUF_48 = ((_zz_flagUF_43 || (_zz__zz_flagUF_48 != 106'h0)) || (|(_zz_flagUF_46 & 29'h0)));
  assign _zz_flagUF_49 = ($signed(_zz__zz_flagUF_49) < $signed(12'h001));
  assign _zz_when_FpUnit_l147_3 = (_zz_flagUF_49 ? _zz__zz_when_FpUnit_l147_3 : 12'h0);
  assign _zz_when_FpUnit_l150_3 = _zz_when_FpUnit_l147_3;
  assign when_FpUnit_l147_3 = ($signed(_zz_when_FpUnit_l147_3) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l147_3) begin
      _zz_flagUF_50 = _zz__zz_flagUF_50;
    end else begin
      if(when_FpUnit_l150_3) begin
        _zz_flagUF_50 = 27'h0;
      end else begin
        _zz_flagUF_50 = _zz__zz_flagUF_50_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l147_3) begin
      _zz_flagUF_51 = _zz_flagUF_48;
    end else begin
      if(when_FpUnit_l150_3) begin
        _zz_flagUF_51 = ((|_zz_flagUF_47) || _zz_flagUF_48);
      end else begin
        _zz_flagUF_51 = ((|(_zz_flagUF_47 & _zz__zz_flagUF_51)) || _zz_flagUF_48);
      end
    end
  end

  assign when_FpUnit_l150_3 = (12'h01b <= _zz_when_FpUnit_l150_3);
  assign _zz_when_FpUnit_l186_9 = (_zz_flagUF_49 ? 12'hf82 : _zz_flagUF_44);
  assign _zz_flagUF_52 = _zz_flagUF_50[2];
  assign _zz_flagUF_53 = _zz_flagUF_50[1];
  assign _zz_flagUF_54 = (_zz_flagUF_50[0] || _zz_flagUF_51);
  assign _zz_when_FpUnit_l190_9 = _zz_flagUF_50[26 : 3];
  assign _zz_when_FpUnit_l190_10 = (_zz__zz_when_FpUnit_l190_10 + _zz__zz_when_FpUnit_l190_10_2);
  assign _zz_when_FpUnit_l186_10 = _zz_when_FpUnit_l190_10[24];
  assign _zz_when_FpUnit_l190_11 = (_zz_when_FpUnit_l186_10 ? _zz__zz_when_FpUnit_l190_11 : _zz__zz_when_FpUnit_l190_11_1);
  assign _zz_when_FpUnit_l186_11 = ($signed(_zz__zz_when_FpUnit_l186_11) + $signed(12'h07f));
  assign _zz_flagUF_55 = ((_zz_flagUF_52 || _zz_flagUF_53) || _zz_flagUF_54);
  assign when_FpUnit_l186_3 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l186_11));
  assign _zz_res_17 = {_zz_res_16,{8'hff,23'h0}};
  assign _zz_res_18 = {_zz_res_16,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_19 = 32'h0;
    if(when_FpUnit_l186_3) begin
      _zz_res_19 = ((io_rm == 3'b001) ? _zz_res_18 : ((io_rm == 3'b010) ? (_zz_res_16 ? _zz_res_17 : _zz_res_18) : ((io_rm == 3'b011) ? (_zz_res_16 ? _zz_res_18 : _zz_res_17) : _zz_res_17)));
    end else begin
      if(when_FpUnit_l190_3) begin
        _zz_res_19 = {_zz_res_16,{8'h0,23'h0}};
      end else begin
        if(when_FpUnit_l192_3) begin
          _zz_res_19 = {_zz_res_16,{8'h0,_zz_when_FpUnit_l190_11[22 : 0]}};
        end else begin
          _zz_res_19 = {_zz_res_16,{_zz__zz_res_19,_zz_when_FpUnit_l190_11[22 : 0]}};
        end
      end
    end
  end

  assign when_FpUnit_l190_3 = (_zz_flagUF_49 && (_zz_when_FpUnit_l190_11 == 24'h0));
  assign when_FpUnit_l192_3 = ((_zz_flagUF_49 && (_zz_when_FpUnit_l190_11 != 24'h0)) && (! _zz_when_FpUnit_l190_11[23]));
  always @(*) begin
    _zz_res_20 = _zz_res_19;
    if(when_FpUnit_l299) begin
      _zz_res_20 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l300) begin
        _zz_res_20 = 32'h7fc00000;
      end else begin
        if(when_FpUnit_l244) begin
          _zz_res_20 = {_zz_res_16,{8'hff,23'h0}};
        end else begin
          if(when_FpUnit_l245) begin
            _zz_res_20 = {_zz_res_16,{8'h0,23'h0}};
          end else begin
            if(when_FpUnit_l305) begin
              _zz_res_20 = {_zz_res_16,{8'hff,23'h0}};
            end else begin
              if(when_FpUnit_l308) begin
                _zz_res_20 = {_zz_res_16,{8'h0,23'h0}};
              end
            end
          end
        end
      end
    end
  end

  assign when_FpUnit_l299 = (when_FpUnit_l342 || when_FpUnit_l431);
  assign when_FpUnit_l300 = ((when_FpUnit_l308 && when_FpUnit_l305) || (when_FpUnit_l244 && when_FpUnit_l245));
  assign _zz_flagUF_56 = _zz_when_FpUnit_l218[0];
  assign _zz_when_FpUnit_l88_22 = _zz__zz_when_FpUnit_l88_22[55:0];
  assign _zz_when_FpUnit_l88_23 = 30'h0;
  assign _zz_when_FpUnit_l88_24 = (_zz__zz_when_FpUnit_l88_24 | _zz__zz_when_FpUnit_l88_24_2);
  assign _zz_when_FpUnit_l88_25 = (_zz__zz_when_FpUnit_l88_25 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_26 = (_zz_when_FpUnit_l88_25 <= _zz_when_FpUnit_l88_24);
  assign _zz_when_FpUnit_l88_27 = (_zz_when_FpUnit_l88_26 ? (_zz__zz_when_FpUnit_l88_27 | 30'h00000001) : _zz__zz_when_FpUnit_l88_27_2);
  assign _zz_when_FpUnit_l88_28 = (_zz__zz_when_FpUnit_l88_28 | _zz__zz_when_FpUnit_l88_28_3);
  assign _zz_when_FpUnit_l88_29 = (_zz__zz_when_FpUnit_l88_29 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_30 = (_zz_when_FpUnit_l88_29 <= _zz_when_FpUnit_l88_28);
  assign _zz_when_FpUnit_l88_31 = (_zz_when_FpUnit_l88_30 ? (_zz__zz_when_FpUnit_l88_31 | 30'h00000001) : _zz__zz_when_FpUnit_l88_31_2);
  assign _zz_when_FpUnit_l88_32 = (_zz__zz_when_FpUnit_l88_32 | _zz__zz_when_FpUnit_l88_32_3);
  assign _zz_when_FpUnit_l88_33 = (_zz__zz_when_FpUnit_l88_33 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_34 = (_zz_when_FpUnit_l88_33 <= _zz_when_FpUnit_l88_32);
  assign _zz_when_FpUnit_l88_35 = (_zz_when_FpUnit_l88_34 ? (_zz__zz_when_FpUnit_l88_35 | 30'h00000001) : _zz__zz_when_FpUnit_l88_35_2);
  assign _zz_when_FpUnit_l88_36 = (_zz__zz_when_FpUnit_l88_36 | _zz__zz_when_FpUnit_l88_36_3);
  assign _zz_when_FpUnit_l88_37 = (_zz__zz_when_FpUnit_l88_37 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_38 = (_zz_when_FpUnit_l88_37 <= _zz_when_FpUnit_l88_36);
  assign _zz_when_FpUnit_l88_39 = (_zz_when_FpUnit_l88_38 ? (_zz__zz_when_FpUnit_l88_39 | 30'h00000001) : _zz__zz_when_FpUnit_l88_39_2);
  assign _zz_when_FpUnit_l88_40 = (_zz__zz_when_FpUnit_l88_40 | _zz__zz_when_FpUnit_l88_40_3);
  assign _zz_when_FpUnit_l88_41 = (_zz__zz_when_FpUnit_l88_41 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_42 = (_zz_when_FpUnit_l88_41 <= _zz_when_FpUnit_l88_40);
  assign _zz_when_FpUnit_l88_43 = (_zz_when_FpUnit_l88_42 ? (_zz__zz_when_FpUnit_l88_43 | 30'h00000001) : _zz__zz_when_FpUnit_l88_43_2);
  assign _zz_when_FpUnit_l88_44 = (_zz__zz_when_FpUnit_l88_44 | _zz__zz_when_FpUnit_l88_44_3);
  assign _zz_when_FpUnit_l88_45 = (_zz__zz_when_FpUnit_l88_45 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_46 = (_zz_when_FpUnit_l88_45 <= _zz_when_FpUnit_l88_44);
  assign _zz_when_FpUnit_l88_47 = (_zz_when_FpUnit_l88_46 ? (_zz__zz_when_FpUnit_l88_47 | 30'h00000001) : _zz__zz_when_FpUnit_l88_47_2);
  assign _zz_when_FpUnit_l88_48 = (_zz__zz_when_FpUnit_l88_48 | _zz__zz_when_FpUnit_l88_48_3);
  assign _zz_when_FpUnit_l88_49 = (_zz__zz_when_FpUnit_l88_49 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_50 = (_zz_when_FpUnit_l88_49 <= _zz_when_FpUnit_l88_48);
  assign _zz_when_FpUnit_l88_51 = (_zz_when_FpUnit_l88_50 ? (_zz__zz_when_FpUnit_l88_51 | 30'h00000001) : _zz__zz_when_FpUnit_l88_51_2);
  assign _zz_when_FpUnit_l88_52 = (_zz__zz_when_FpUnit_l88_52 | _zz__zz_when_FpUnit_l88_52_3);
  assign _zz_when_FpUnit_l88_53 = (_zz__zz_when_FpUnit_l88_53 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_54 = (_zz_when_FpUnit_l88_53 <= _zz_when_FpUnit_l88_52);
  assign _zz_when_FpUnit_l88_55 = (_zz_when_FpUnit_l88_54 ? (_zz__zz_when_FpUnit_l88_55 | 30'h00000001) : _zz__zz_when_FpUnit_l88_55_2);
  assign _zz_when_FpUnit_l88_56 = (_zz__zz_when_FpUnit_l88_56 | _zz__zz_when_FpUnit_l88_56_3);
  assign _zz_when_FpUnit_l88_57 = (_zz__zz_when_FpUnit_l88_57 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_58 = (_zz_when_FpUnit_l88_57 <= _zz_when_FpUnit_l88_56);
  assign _zz_when_FpUnit_l88_59 = (_zz_when_FpUnit_l88_58 ? (_zz__zz_when_FpUnit_l88_59 | 30'h00000001) : _zz__zz_when_FpUnit_l88_59_2);
  assign _zz_when_FpUnit_l88_60 = (_zz__zz_when_FpUnit_l88_60 | _zz__zz_when_FpUnit_l88_60_3);
  assign _zz_when_FpUnit_l88_61 = (_zz__zz_when_FpUnit_l88_61 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_62 = (_zz_when_FpUnit_l88_61 <= _zz_when_FpUnit_l88_60);
  assign _zz_when_FpUnit_l88_63 = (_zz_when_FpUnit_l88_62 ? (_zz__zz_when_FpUnit_l88_63 | 30'h00000001) : _zz__zz_when_FpUnit_l88_63_2);
  assign _zz_when_FpUnit_l88_64 = (_zz__zz_when_FpUnit_l88_64 | _zz__zz_when_FpUnit_l88_64_3);
  assign _zz_when_FpUnit_l88_65 = (_zz__zz_when_FpUnit_l88_65 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_66 = (_zz_when_FpUnit_l88_65 <= _zz_when_FpUnit_l88_64);
  assign _zz_when_FpUnit_l88_67 = (_zz_when_FpUnit_l88_66 ? (_zz__zz_when_FpUnit_l88_67 | 30'h00000001) : _zz__zz_when_FpUnit_l88_67_2);
  assign _zz_when_FpUnit_l88_68 = (_zz__zz_when_FpUnit_l88_68 | _zz__zz_when_FpUnit_l88_68_3);
  assign _zz_when_FpUnit_l88_69 = (_zz__zz_when_FpUnit_l88_69 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_70 = (_zz_when_FpUnit_l88_69 <= _zz_when_FpUnit_l88_68);
  assign _zz_when_FpUnit_l88_71 = (_zz_when_FpUnit_l88_70 ? (_zz__zz_when_FpUnit_l88_71 | 30'h00000001) : _zz__zz_when_FpUnit_l88_71_2);
  assign _zz_when_FpUnit_l88_72 = (_zz__zz_when_FpUnit_l88_72 | _zz__zz_when_FpUnit_l88_72_3);
  assign _zz_when_FpUnit_l88_73 = (_zz__zz_when_FpUnit_l88_73 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_74 = (_zz_when_FpUnit_l88_73 <= _zz_when_FpUnit_l88_72);
  assign _zz_when_FpUnit_l88_75 = (_zz_when_FpUnit_l88_74 ? (_zz__zz_when_FpUnit_l88_75 | 30'h00000001) : _zz__zz_when_FpUnit_l88_75_2);
  assign _zz_when_FpUnit_l88_76 = (_zz__zz_when_FpUnit_l88_76 | _zz__zz_when_FpUnit_l88_76_3);
  assign _zz_when_FpUnit_l88_77 = (_zz__zz_when_FpUnit_l88_77 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_78 = (_zz_when_FpUnit_l88_77 <= _zz_when_FpUnit_l88_76);
  assign _zz_when_FpUnit_l88_79 = (_zz_when_FpUnit_l88_78 ? (_zz__zz_when_FpUnit_l88_79 | 30'h00000001) : _zz__zz_when_FpUnit_l88_79_2);
  assign _zz_when_FpUnit_l88_80 = (_zz__zz_when_FpUnit_l88_80 | _zz__zz_when_FpUnit_l88_80_3);
  assign _zz_when_FpUnit_l88_81 = (_zz__zz_when_FpUnit_l88_81 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_82 = (_zz_when_FpUnit_l88_81 <= _zz_when_FpUnit_l88_80);
  assign _zz_when_FpUnit_l88_83 = (_zz_when_FpUnit_l88_82 ? (_zz__zz_when_FpUnit_l88_83 | 30'h00000001) : _zz__zz_when_FpUnit_l88_83_2);
  assign _zz_when_FpUnit_l88_84 = (_zz__zz_when_FpUnit_l88_84 | _zz__zz_when_FpUnit_l88_84_3);
  assign _zz_when_FpUnit_l88_85 = (_zz__zz_when_FpUnit_l88_85 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_86 = (_zz_when_FpUnit_l88_85 <= _zz_when_FpUnit_l88_84);
  assign _zz_when_FpUnit_l88_87 = (_zz_when_FpUnit_l88_86 ? (_zz__zz_when_FpUnit_l88_87 | 30'h00000001) : _zz__zz_when_FpUnit_l88_87_2);
  assign _zz_when_FpUnit_l88_88 = (_zz__zz_when_FpUnit_l88_88 | _zz__zz_when_FpUnit_l88_88_3);
  assign _zz_when_FpUnit_l88_89 = (_zz__zz_when_FpUnit_l88_89 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_90 = (_zz_when_FpUnit_l88_89 <= _zz_when_FpUnit_l88_88);
  assign _zz_when_FpUnit_l88_91 = (_zz_when_FpUnit_l88_90 ? (_zz__zz_when_FpUnit_l88_91 | 30'h00000001) : _zz__zz_when_FpUnit_l88_91_2);
  assign _zz_when_FpUnit_l88_92 = (_zz__zz_when_FpUnit_l88_92 | _zz__zz_when_FpUnit_l88_92_3);
  assign _zz_when_FpUnit_l88_93 = (_zz__zz_when_FpUnit_l88_93 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_94 = (_zz_when_FpUnit_l88_93 <= _zz_when_FpUnit_l88_92);
  assign _zz_when_FpUnit_l88_95 = (_zz_when_FpUnit_l88_94 ? (_zz__zz_when_FpUnit_l88_95 | 30'h00000001) : _zz__zz_when_FpUnit_l88_95_2);
  assign _zz_when_FpUnit_l88_96 = (_zz__zz_when_FpUnit_l88_96 | _zz__zz_when_FpUnit_l88_96_3);
  assign _zz_when_FpUnit_l88_97 = (_zz__zz_when_FpUnit_l88_97 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_98 = (_zz_when_FpUnit_l88_97 <= _zz_when_FpUnit_l88_96);
  assign _zz_when_FpUnit_l88_99 = (_zz_when_FpUnit_l88_98 ? (_zz__zz_when_FpUnit_l88_99 | 30'h00000001) : _zz__zz_when_FpUnit_l88_99_2);
  assign _zz_when_FpUnit_l88_100 = (_zz__zz_when_FpUnit_l88_100 | _zz__zz_when_FpUnit_l88_100_3);
  assign _zz_when_FpUnit_l88_101 = (_zz__zz_when_FpUnit_l88_101 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_102 = (_zz_when_FpUnit_l88_101 <= _zz_when_FpUnit_l88_100);
  assign _zz_when_FpUnit_l88_103 = (_zz_when_FpUnit_l88_102 ? (_zz__zz_when_FpUnit_l88_103 | 30'h00000001) : _zz__zz_when_FpUnit_l88_103_2);
  assign _zz_when_FpUnit_l88_104 = (_zz__zz_when_FpUnit_l88_104 | _zz__zz_when_FpUnit_l88_104_3);
  assign _zz_when_FpUnit_l88_105 = (_zz__zz_when_FpUnit_l88_105 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_106 = (_zz_when_FpUnit_l88_105 <= _zz_when_FpUnit_l88_104);
  assign _zz_when_FpUnit_l88_107 = (_zz_when_FpUnit_l88_106 ? (_zz__zz_when_FpUnit_l88_107 | 30'h00000001) : _zz__zz_when_FpUnit_l88_107_2);
  assign _zz_when_FpUnit_l88_108 = (_zz__zz_when_FpUnit_l88_108 | _zz__zz_when_FpUnit_l88_108_3);
  assign _zz_when_FpUnit_l88_109 = (_zz__zz_when_FpUnit_l88_109 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_110 = (_zz_when_FpUnit_l88_109 <= _zz_when_FpUnit_l88_108);
  assign _zz_when_FpUnit_l88_111 = (_zz_when_FpUnit_l88_110 ? (_zz__zz_when_FpUnit_l88_111 | 30'h00000001) : _zz__zz_when_FpUnit_l88_111_2);
  assign _zz_when_FpUnit_l88_112 = (_zz__zz_when_FpUnit_l88_112 | _zz__zz_when_FpUnit_l88_112_3);
  assign _zz_when_FpUnit_l88_113 = (_zz__zz_when_FpUnit_l88_113 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_114 = (_zz_when_FpUnit_l88_113 <= _zz_when_FpUnit_l88_112);
  assign _zz_when_FpUnit_l88_115 = (_zz_when_FpUnit_l88_114 ? (_zz__zz_when_FpUnit_l88_115 | 30'h00000001) : _zz__zz_when_FpUnit_l88_115_2);
  assign _zz_when_FpUnit_l88_116 = (_zz__zz_when_FpUnit_l88_116 | _zz__zz_when_FpUnit_l88_116_3);
  assign _zz_when_FpUnit_l88_117 = (_zz__zz_when_FpUnit_l88_117 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_118 = (_zz_when_FpUnit_l88_117 <= _zz_when_FpUnit_l88_116);
  assign _zz_when_FpUnit_l88_119 = (_zz_when_FpUnit_l88_118 ? (_zz__zz_when_FpUnit_l88_119 | 30'h00000001) : _zz__zz_when_FpUnit_l88_119_2);
  assign _zz_when_FpUnit_l88_120 = (_zz__zz_when_FpUnit_l88_120 | _zz__zz_when_FpUnit_l88_120_3);
  assign _zz_when_FpUnit_l88_121 = (_zz__zz_when_FpUnit_l88_121 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_122 = (_zz_when_FpUnit_l88_121 <= _zz_when_FpUnit_l88_120);
  assign _zz_when_FpUnit_l88_123 = (_zz_when_FpUnit_l88_122 ? (_zz__zz_when_FpUnit_l88_123 | 30'h00000001) : _zz__zz_when_FpUnit_l88_123_2);
  assign _zz_when_FpUnit_l88_124 = (_zz__zz_when_FpUnit_l88_124 | _zz__zz_when_FpUnit_l88_124_3);
  assign _zz_when_FpUnit_l88_125 = (_zz__zz_when_FpUnit_l88_125 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_126 = (_zz_when_FpUnit_l88_125 <= _zz_when_FpUnit_l88_124);
  assign _zz_when_FpUnit_l88_127 = (_zz_when_FpUnit_l88_126 ? (_zz__zz_when_FpUnit_l88_127 | 30'h00000001) : _zz__zz_when_FpUnit_l88_127_2);
  assign _zz_when_FpUnit_l88_128 = (_zz__zz_when_FpUnit_l88_128 | _zz__zz_when_FpUnit_l88_128_3);
  assign _zz_when_FpUnit_l88_129 = (_zz__zz_when_FpUnit_l88_129 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_130 = (_zz_when_FpUnit_l88_129 <= _zz_when_FpUnit_l88_128);
  assign _zz_when_FpUnit_l88_131 = (_zz_when_FpUnit_l88_130 ? (_zz__zz_when_FpUnit_l88_131 | 30'h00000001) : _zz__zz_when_FpUnit_l88_131_2);
  assign _zz_when_FpUnit_l88_132 = (_zz__zz_when_FpUnit_l88_132 | _zz__zz_when_FpUnit_l88_132_3);
  assign _zz_when_FpUnit_l88_133 = (_zz__zz_when_FpUnit_l88_133 | 58'h000000000000001);
  assign _zz_when_FpUnit_l88_134 = (_zz_when_FpUnit_l88_133 <= _zz_when_FpUnit_l88_132);
  assign _zz_when_FpUnit_l88_135 = (_zz_when_FpUnit_l88_134 ? (_zz__zz_when_FpUnit_l88_135 | 30'h00000001) : _zz__zz_when_FpUnit_l88_135_2);
  always @(*) begin
    _zz_when_FpUnit_l95_4 = 5'h0;
    if(when_FpUnit_l88_133) begin
      _zz_when_FpUnit_l95_4 = 5'h0;
    end
    if(when_FpUnit_l88_134) begin
      _zz_when_FpUnit_l95_4 = 5'h01;
    end
    if(when_FpUnit_l88_135) begin
      _zz_when_FpUnit_l95_4 = 5'h02;
    end
    if(when_FpUnit_l88_136) begin
      _zz_when_FpUnit_l95_4 = 5'h03;
    end
    if(when_FpUnit_l88_137) begin
      _zz_when_FpUnit_l95_4 = 5'h04;
    end
    if(when_FpUnit_l88_138) begin
      _zz_when_FpUnit_l95_4 = 5'h05;
    end
    if(when_FpUnit_l88_139) begin
      _zz_when_FpUnit_l95_4 = 5'h06;
    end
    if(when_FpUnit_l88_140) begin
      _zz_when_FpUnit_l95_4 = 5'h07;
    end
    if(when_FpUnit_l88_141) begin
      _zz_when_FpUnit_l95_4 = 5'h08;
    end
    if(when_FpUnit_l88_142) begin
      _zz_when_FpUnit_l95_4 = 5'h09;
    end
    if(when_FpUnit_l88_143) begin
      _zz_when_FpUnit_l95_4 = 5'h0a;
    end
    if(when_FpUnit_l88_144) begin
      _zz_when_FpUnit_l95_4 = 5'h0b;
    end
    if(when_FpUnit_l88_145) begin
      _zz_when_FpUnit_l95_4 = 5'h0c;
    end
    if(when_FpUnit_l88_146) begin
      _zz_when_FpUnit_l95_4 = 5'h0d;
    end
    if(when_FpUnit_l88_147) begin
      _zz_when_FpUnit_l95_4 = 5'h0e;
    end
    if(when_FpUnit_l88_148) begin
      _zz_when_FpUnit_l95_4 = 5'h0f;
    end
    if(when_FpUnit_l88_149) begin
      _zz_when_FpUnit_l95_4 = 5'h10;
    end
    if(when_FpUnit_l88_150) begin
      _zz_when_FpUnit_l95_4 = 5'h11;
    end
    if(when_FpUnit_l88_151) begin
      _zz_when_FpUnit_l95_4 = 5'h12;
    end
    if(when_FpUnit_l88_152) begin
      _zz_when_FpUnit_l95_4 = 5'h13;
    end
    if(when_FpUnit_l88_153) begin
      _zz_when_FpUnit_l95_4 = 5'h14;
    end
    if(when_FpUnit_l88_154) begin
      _zz_when_FpUnit_l95_4 = 5'h15;
    end
    if(when_FpUnit_l88_155) begin
      _zz_when_FpUnit_l95_4 = 5'h16;
    end
    if(when_FpUnit_l88_156) begin
      _zz_when_FpUnit_l95_4 = 5'h17;
    end
    if(when_FpUnit_l88_157) begin
      _zz_when_FpUnit_l95_4 = 5'h18;
    end
    if(when_FpUnit_l88_158) begin
      _zz_when_FpUnit_l95_4 = 5'h19;
    end
    if(when_FpUnit_l88_159) begin
      _zz_when_FpUnit_l95_4 = 5'h1a;
    end
    if(when_FpUnit_l88_160) begin
      _zz_when_FpUnit_l95_4 = 5'h1b;
    end
    if(when_FpUnit_l88_161) begin
      _zz_when_FpUnit_l95_4 = 5'h1c;
    end
    if(when_FpUnit_l88_162) begin
      _zz_when_FpUnit_l95_4 = 5'h1d;
    end
  end

  assign when_FpUnit_l88_133 = _zz_when_FpUnit_l88_135[0];
  assign when_FpUnit_l88_134 = _zz_when_FpUnit_l88_135[1];
  assign when_FpUnit_l88_135 = _zz_when_FpUnit_l88_135[2];
  assign when_FpUnit_l88_136 = _zz_when_FpUnit_l88_135[3];
  assign when_FpUnit_l88_137 = _zz_when_FpUnit_l88_135[4];
  assign when_FpUnit_l88_138 = _zz_when_FpUnit_l88_135[5];
  assign when_FpUnit_l88_139 = _zz_when_FpUnit_l88_135[6];
  assign when_FpUnit_l88_140 = _zz_when_FpUnit_l88_135[7];
  assign when_FpUnit_l88_141 = _zz_when_FpUnit_l88_135[8];
  assign when_FpUnit_l88_142 = _zz_when_FpUnit_l88_135[9];
  assign when_FpUnit_l88_143 = _zz_when_FpUnit_l88_135[10];
  assign when_FpUnit_l88_144 = _zz_when_FpUnit_l88_135[11];
  assign when_FpUnit_l88_145 = _zz_when_FpUnit_l88_135[12];
  assign when_FpUnit_l88_146 = _zz_when_FpUnit_l88_135[13];
  assign when_FpUnit_l88_147 = _zz_when_FpUnit_l88_135[14];
  assign when_FpUnit_l88_148 = _zz_when_FpUnit_l88_135[15];
  assign when_FpUnit_l88_149 = _zz_when_FpUnit_l88_135[16];
  assign when_FpUnit_l88_150 = _zz_when_FpUnit_l88_135[17];
  assign when_FpUnit_l88_151 = _zz_when_FpUnit_l88_135[18];
  assign when_FpUnit_l88_152 = _zz_when_FpUnit_l88_135[19];
  assign when_FpUnit_l88_153 = _zz_when_FpUnit_l88_135[20];
  assign when_FpUnit_l88_154 = _zz_when_FpUnit_l88_135[21];
  assign when_FpUnit_l88_155 = _zz_when_FpUnit_l88_135[22];
  assign when_FpUnit_l88_156 = _zz_when_FpUnit_l88_135[23];
  assign when_FpUnit_l88_157 = _zz_when_FpUnit_l88_135[24];
  assign when_FpUnit_l88_158 = _zz_when_FpUnit_l88_135[25];
  assign when_FpUnit_l88_159 = _zz_when_FpUnit_l88_135[26];
  assign when_FpUnit_l88_160 = _zz_when_FpUnit_l88_135[27];
  assign when_FpUnit_l88_161 = _zz_when_FpUnit_l88_135[28];
  assign when_FpUnit_l88_162 = _zz_when_FpUnit_l88_135[29];
  always @(*) begin
    _zz_flagUF_57 = 27'h0;
    if(when_FpUnit_l94_4) begin
      if(when_FpUnit_l95_4) begin
        _zz_flagUF_57 = _zz__zz_flagUF_57;
      end else begin
        _zz_flagUF_57 = _zz__zz_flagUF_57_2;
      end
    end
  end

  always @(*) begin
    _zz_flagUF_58 = 1'b0;
    if(when_FpUnit_l94_4) begin
      if(when_FpUnit_l95_4) begin
        _zz_flagUF_58 = (|(_zz_when_FpUnit_l88_135 & _zz__zz_flagUF_58));
      end else begin
        _zz_flagUF_58 = 1'b0;
      end
    end
  end

  assign _zz_flagUF_59 = ($signed(_zz__zz_flagUF_59) + $signed(_zz__zz_flagUF_59_2));
  assign when_FpUnit_l94_4 = (_zz_when_FpUnit_l88_135 != 30'h0);
  assign when_FpUnit_l95_4 = (5'h1a < _zz_when_FpUnit_l95_4);
  assign _zz_flagUF_60 = (_zz_when_FpUnit_l95_4 - 5'h1a);
  assign _zz_res_21 = 1'b0;
  assign _zz_flagUF_61 = _zz__zz_flagUF_61;
  assign _zz_flagUF_62 = _zz_flagUF_61;
  assign _zz_flagUF_63 = ((_zz_flagUF_58 || ((_zz_when_FpUnit_l88_134 ? _zz__zz_flagUF_63 : _zz_when_FpUnit_l88_132) != 58'h0)) || (|(_zz_flagUF_61 & 29'h0)));
  assign _zz_flagUF_64 = ($signed(_zz__zz_flagUF_64) < $signed(12'h001));
  assign _zz_when_FpUnit_l147_4 = (_zz_flagUF_64 ? _zz__zz_when_FpUnit_l147_4 : 12'h0);
  assign _zz_when_FpUnit_l150_4 = _zz_when_FpUnit_l147_4;
  assign when_FpUnit_l147_4 = ($signed(_zz_when_FpUnit_l147_4) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l147_4) begin
      _zz_flagUF_65 = _zz__zz_flagUF_65;
    end else begin
      if(when_FpUnit_l150_4) begin
        _zz_flagUF_65 = 27'h0;
      end else begin
        _zz_flagUF_65 = _zz__zz_flagUF_65_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l147_4) begin
      _zz_flagUF_66 = _zz_flagUF_63;
    end else begin
      if(when_FpUnit_l150_4) begin
        _zz_flagUF_66 = ((|_zz_flagUF_62) || _zz_flagUF_63);
      end else begin
        _zz_flagUF_66 = ((|(_zz_flagUF_62 & _zz__zz_flagUF_66)) || _zz_flagUF_63);
      end
    end
  end

  assign when_FpUnit_l150_4 = (12'h01b <= _zz_when_FpUnit_l150_4);
  assign _zz_when_FpUnit_l186_12 = (_zz_flagUF_64 ? 12'hf82 : _zz_flagUF_59);
  assign _zz_flagUF_67 = _zz_flagUF_65[2];
  assign _zz_flagUF_68 = _zz_flagUF_65[1];
  assign _zz_flagUF_69 = (_zz_flagUF_65[0] || _zz_flagUF_66);
  assign _zz_when_FpUnit_l190_12 = _zz_flagUF_65[26 : 3];
  assign _zz_when_FpUnit_l190_13 = (_zz__zz_when_FpUnit_l190_13 + _zz__zz_when_FpUnit_l190_13_2);
  assign _zz_when_FpUnit_l186_13 = _zz_when_FpUnit_l190_13[24];
  assign _zz_when_FpUnit_l190_14 = (_zz_when_FpUnit_l186_13 ? _zz__zz_when_FpUnit_l190_14 : _zz__zz_when_FpUnit_l190_14_1);
  assign _zz_when_FpUnit_l186_14 = ($signed(_zz__zz_when_FpUnit_l186_14) + $signed(12'h07f));
  assign _zz_flagUF_70 = ((_zz_flagUF_67 || _zz_flagUF_68) || _zz_flagUF_69);
  assign when_FpUnit_l186_4 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l186_14));
  assign _zz_res_22 = {_zz_res_21,{8'hff,23'h0}};
  assign _zz_res_23 = {_zz_res_21,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_24 = 32'h0;
    if(when_FpUnit_l186_4) begin
      _zz_res_24 = ((io_rm == 3'b001) ? _zz_res_23 : ((io_rm == 3'b010) ? (_zz_res_21 ? _zz_res_22 : _zz_res_23) : ((io_rm == 3'b011) ? (_zz_res_21 ? _zz_res_23 : _zz_res_22) : _zz_res_22)));
    end else begin
      if(when_FpUnit_l190_4) begin
        _zz_res_24 = {_zz_res_21,{8'h0,23'h0}};
      end else begin
        if(when_FpUnit_l192_4) begin
          _zz_res_24 = {_zz_res_21,{8'h0,_zz_when_FpUnit_l190_14[22 : 0]}};
        end else begin
          _zz_res_24 = {_zz_res_21,{_zz__zz_res_24,_zz_when_FpUnit_l190_14[22 : 0]}};
        end
      end
    end
  end

  assign when_FpUnit_l190_4 = (_zz_flagUF_64 && (_zz_when_FpUnit_l190_14 == 24'h0));
  assign when_FpUnit_l192_4 = ((_zz_flagUF_64 && (_zz_when_FpUnit_l190_14 != 24'h0)) && (! _zz_when_FpUnit_l190_14[23]));
  always @(*) begin
    _zz_res_25 = _zz_res_24;
    if(when_FpUnit_l342) begin
      _zz_res_25 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l343) begin
        _zz_res_25 = 32'h7fc00000;
      end else begin
        if(when_FpUnit_l244) begin
          _zz_res_25 = {1'b0,{8'hff,23'h0}};
        end else begin
          if(when_FpUnit_l308) begin
            _zz_res_25 = {when_FpUnit_l519,{8'h0,23'h0}};
          end
        end
      end
    end
  end

  assign when_FpUnit_l343 = (when_FpUnit_l519 && (! when_FpUnit_l308));
  assign when_FpUnit_l434 = 1'b0;
  assign when_FpUnit_l432 = (when_FpUnit_l308 && when_FpUnit_l305);
  assign _zz_res_26 = (($signed(_zz_when_FpUnit_l218) < $signed(_zz_when_FpUnit_l218_1)) || (($signed(_zz_when_FpUnit_l218) == $signed(_zz_when_FpUnit_l218_1)) && (_zz_when_FpUnit_l88 < _zz_when_FpUnit_l88_1)));
  assign _zz_res_27 = ((when_FpUnit_l519 == _zz_when_FpUnit_l243) ? (when_FpUnit_l519 ? ((! _zz_res_26) && (! (($signed(_zz_when_FpUnit_l218) == $signed(_zz_when_FpUnit_l218_1)) && (_zz_when_FpUnit_l88 == _zz_when_FpUnit_l88_1)))) : _zz_res_26) : when_FpUnit_l519);
  always @(*) begin
    _zz_res_28 = io_a[31 : 0];
    if(when_FpUnit_l429) begin
      _zz_res_28 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l342) begin
        _zz_res_28 = io_b[31 : 0];
      end else begin
        if(when_FpUnit_l431) begin
          _zz_res_28 = io_a[31 : 0];
        end else begin
          if(when_FpUnit_l432) begin
            _zz_res_28 = {(when_FpUnit_l434 ? 1'b0 : 1'b1),{8'h0,23'h0}};
          end else begin
            if(when_FpUnit_l434) begin
              _zz_res_28 = (_zz_res_27 ? io_b[31 : 0] : io_a[31 : 0]);
            end else begin
              _zz_res_28 = (_zz_res_27 ? io_a[31 : 0] : io_b[31 : 0]);
            end
          end
        end
      end
    end
  end

  assign when_FpUnit_l429 = (when_FpUnit_l342 && when_FpUnit_l431);
  assign when_FpUnit_l434_1 = 1'b1;
  assign when_FpUnit_l432_1 = (when_FpUnit_l308 && when_FpUnit_l305);
  assign _zz_res_29 = (($signed(_zz_when_FpUnit_l218) < $signed(_zz_when_FpUnit_l218_1)) || (($signed(_zz_when_FpUnit_l218) == $signed(_zz_when_FpUnit_l218_1)) && (_zz_when_FpUnit_l88 < _zz_when_FpUnit_l88_1)));
  assign _zz_res_30 = ((when_FpUnit_l519 == _zz_when_FpUnit_l243) ? (when_FpUnit_l519 ? ((! _zz_res_29) && (! (($signed(_zz_when_FpUnit_l218) == $signed(_zz_when_FpUnit_l218_1)) && (_zz_when_FpUnit_l88 == _zz_when_FpUnit_l88_1)))) : _zz_res_29) : when_FpUnit_l519);
  always @(*) begin
    _zz_res_31 = io_a[31 : 0];
    if(when_FpUnit_l429_1) begin
      _zz_res_31 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l342) begin
        _zz_res_31 = io_b[31 : 0];
      end else begin
        if(when_FpUnit_l431) begin
          _zz_res_31 = io_a[31 : 0];
        end else begin
          if(when_FpUnit_l432_1) begin
            _zz_res_31 = {(when_FpUnit_l434_1 ? 1'b0 : 1'b1),{8'h0,23'h0}};
          end else begin
            if(when_FpUnit_l434_1) begin
              _zz_res_31 = (_zz_res_30 ? io_b[31 : 0] : io_a[31 : 0]);
            end else begin
              _zz_res_31 = (_zz_res_30 ? io_a[31 : 0] : io_b[31 : 0]);
            end
          end
        end
      end
    end
  end

  assign when_FpUnit_l429_1 = (when_FpUnit_l342 && when_FpUnit_l431);
  always @(*) begin
    _zz_res_32 = io_a[31 : 0];
    case(io_op)
      6'h07 : begin
        _zz_res_32[31] = io_b[31];
      end
      6'h08 : begin
        _zz_res_32[31] = (! io_b[31]);
      end
      6'h09 : begin
        _zz_res_32[31] = (io_a[31] ^ io_b[31]);
      end
      default : begin
      end
    endcase
  end

  assign _zz_res_33 = (((! when_FpUnit_l342) && (! when_FpUnit_l431)) && ((when_FpUnit_l308 && when_FpUnit_l305) || (((when_FpUnit_l519 == _zz_when_FpUnit_l243) && ($signed(_zz_when_FpUnit_l218) == $signed(_zz_when_FpUnit_l218_1))) && (_zz_when_FpUnit_l88 == _zz_when_FpUnit_l88_1))));
  assign _zz_res_34 = ((((! when_FpUnit_l342) && (! when_FpUnit_l431)) && (! (when_FpUnit_l308 && when_FpUnit_l305))) && ((when_FpUnit_l519 != _zz_when_FpUnit_l243) ? when_FpUnit_l519 : (when_FpUnit_l519 ? ($signed(_zz_when_FpUnit_l218_1) < $signed(_zz_when_FpUnit_l218)) : ($signed(_zz_when_FpUnit_l218) < $signed(_zz_when_FpUnit_l218_1)))));
  always @(*) begin
    _zz_res_35 = 32'h0;
    case(io_op)
      6'h0a : begin
        _zz_res_35[0] = _zz_res_33;
      end
      6'h0b : begin
        _zz_res_35[0] = _zz_res_34;
      end
      6'h0c : begin
        _zz_res_35[0] = (_zz_res_33 || _zz_res_34);
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    _zz_res_36 = 10'h0;
    _zz_res_36[0] = (when_FpUnit_l519 && when_FpUnit_l244);
    _zz_res_36[1] = ((((when_FpUnit_l519 && (! when_FpUnit_l244)) && (! when_FpUnit_l342)) && (! when_FpUnit_l308)) && (! _zz_res));
    _zz_res_36[2] = (when_FpUnit_l519 && _zz_res);
    _zz_res_36[3] = (when_FpUnit_l519 && when_FpUnit_l308);
    _zz_res_36[4] = ((! when_FpUnit_l519) && when_FpUnit_l308);
    _zz_res_36[5] = ((! when_FpUnit_l519) && _zz_res);
    _zz_res_36[6] = (((((! when_FpUnit_l519) && (! when_FpUnit_l244)) && (! when_FpUnit_l342)) && (! when_FpUnit_l308)) && (! _zz_res));
    _zz_res_36[7] = ((! when_FpUnit_l519) && when_FpUnit_l244);
    _zz_res_36[8] = _zz_flagNV;
    _zz_res_36[9] = (when_FpUnit_l342 && (! _zz_flagNV));
  end

  assign _zz_when_FpUnit_l397_1 = ((when_FpUnit_l519 ^ _zz_when_FpUnit_l243) ^ 1'b0);
  assign _zz_when_FpUnit_l397_2 = (_zz_when_FpUnit_l397 ^ 1'b0);
  assign _zz_when_FpUnit_l88_136 = (_zz_when_FpUnit_l88 * _zz_when_FpUnit_l88_1);
  assign _zz_when_FpUnit_l367_2 = ($signed(_zz__zz_when_FpUnit_l367_2) - $signed(12'h02e));
  assign _zz_when_FpUnit_l367_3 = ($signed(_zz__zz_when_FpUnit_l367_3) - $signed(12'h017));
  assign _zz_when_FpUnit_l367_4 = (($signed(_zz_when_FpUnit_l367_3) <= $signed(_zz_when_FpUnit_l367_2)) ? _zz_when_FpUnit_l367_2 : _zz_when_FpUnit_l367_3);
  assign _zz_when_FpUnit_l367_5 = ($signed(_zz_when_FpUnit_l367_4) - $signed(_zz_when_FpUnit_l367_2));
  assign _zz_when_FpUnit_l368 = _zz_when_FpUnit_l367_5;
  assign when_FpUnit_l367 = ($signed(_zz_when_FpUnit_l367_5) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l367) begin
      _zz_when_FpUnit_l88_137 = _zz__zz_when_FpUnit_l88_137;
    end else begin
      if(when_FpUnit_l368) begin
        _zz_when_FpUnit_l88_137 = 54'h0;
      end else begin
        _zz_when_FpUnit_l88_137 = _zz__zz_when_FpUnit_l88_137_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l367) begin
      _zz_flagUF_71 = 1'b0;
    end else begin
      if(when_FpUnit_l368) begin
        _zz_flagUF_71 = (|_zz_when_FpUnit_l88_136);
      end else begin
        _zz_flagUF_71 = (|(_zz__zz_flagUF_71 & _zz__zz_flagUF_71_1));
      end
    end
  end

  assign when_FpUnit_l368 = (12'h036 <= _zz_when_FpUnit_l368);
  assign _zz_when_FpUnit_l367_6 = ($signed(_zz_when_FpUnit_l367_4) - $signed(_zz_when_FpUnit_l367_3));
  assign _zz_when_FpUnit_l368_1 = _zz_when_FpUnit_l367_6;
  assign when_FpUnit_l367_1 = ($signed(_zz_when_FpUnit_l367_6) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l367_1) begin
      _zz_when_FpUnit_l88_138 = _zz__zz_when_FpUnit_l88_138;
    end else begin
      if(when_FpUnit_l368_1) begin
        _zz_when_FpUnit_l88_138 = 54'h0;
      end else begin
        _zz_when_FpUnit_l88_138 = _zz__zz_when_FpUnit_l88_138_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l367_1) begin
      _zz_flagUF_72 = 1'b0;
    end else begin
      if(when_FpUnit_l368_1) begin
        _zz_flagUF_72 = (|_zz_when_FpUnit_l88_2);
      end else begin
        _zz_flagUF_72 = (|(_zz__zz_flagUF_72 & _zz__zz_flagUF_72_1));
      end
    end
  end

  assign when_FpUnit_l368_1 = (12'h036 <= _zz_when_FpUnit_l368_1);
  assign _zz_when_FpUnit_l88_139 = _zz__zz_when_FpUnit_l88_139;
  assign _zz_when_FpUnit_l88_140 = _zz__zz_when_FpUnit_l88_140;
  assign _zz_when_FpUnit_l88_141 = ($signed(_zz__zz_when_FpUnit_l88_141) + $signed(_zz__zz_when_FpUnit_l88_141_3));
  assign _zz_when_FpUnit_l88_142 = _zz_when_FpUnit_l88_141[55];
  assign _zz_when_FpUnit_l88_143 = (_zz_when_FpUnit_l88_142 ? _zz__zz_when_FpUnit_l88_143 : _zz_when_FpUnit_l88_141);
  always @(*) begin
    _zz_when_FpUnit_l95_5 = 6'h0;
    if(when_FpUnit_l88_163) begin
      _zz_when_FpUnit_l95_5 = 6'h0;
    end
    if(when_FpUnit_l88_164) begin
      _zz_when_FpUnit_l95_5 = 6'h01;
    end
    if(when_FpUnit_l88_165) begin
      _zz_when_FpUnit_l95_5 = 6'h02;
    end
    if(when_FpUnit_l88_166) begin
      _zz_when_FpUnit_l95_5 = 6'h03;
    end
    if(when_FpUnit_l88_167) begin
      _zz_when_FpUnit_l95_5 = 6'h04;
    end
    if(when_FpUnit_l88_168) begin
      _zz_when_FpUnit_l95_5 = 6'h05;
    end
    if(when_FpUnit_l88_169) begin
      _zz_when_FpUnit_l95_5 = 6'h06;
    end
    if(when_FpUnit_l88_170) begin
      _zz_when_FpUnit_l95_5 = 6'h07;
    end
    if(when_FpUnit_l88_171) begin
      _zz_when_FpUnit_l95_5 = 6'h08;
    end
    if(when_FpUnit_l88_172) begin
      _zz_when_FpUnit_l95_5 = 6'h09;
    end
    if(when_FpUnit_l88_173) begin
      _zz_when_FpUnit_l95_5 = 6'h0a;
    end
    if(when_FpUnit_l88_174) begin
      _zz_when_FpUnit_l95_5 = 6'h0b;
    end
    if(when_FpUnit_l88_175) begin
      _zz_when_FpUnit_l95_5 = 6'h0c;
    end
    if(when_FpUnit_l88_176) begin
      _zz_when_FpUnit_l95_5 = 6'h0d;
    end
    if(when_FpUnit_l88_177) begin
      _zz_when_FpUnit_l95_5 = 6'h0e;
    end
    if(when_FpUnit_l88_178) begin
      _zz_when_FpUnit_l95_5 = 6'h0f;
    end
    if(when_FpUnit_l88_179) begin
      _zz_when_FpUnit_l95_5 = 6'h10;
    end
    if(when_FpUnit_l88_180) begin
      _zz_when_FpUnit_l95_5 = 6'h11;
    end
    if(when_FpUnit_l88_181) begin
      _zz_when_FpUnit_l95_5 = 6'h12;
    end
    if(when_FpUnit_l88_182) begin
      _zz_when_FpUnit_l95_5 = 6'h13;
    end
    if(when_FpUnit_l88_183) begin
      _zz_when_FpUnit_l95_5 = 6'h14;
    end
    if(when_FpUnit_l88_184) begin
      _zz_when_FpUnit_l95_5 = 6'h15;
    end
    if(when_FpUnit_l88_185) begin
      _zz_when_FpUnit_l95_5 = 6'h16;
    end
    if(when_FpUnit_l88_186) begin
      _zz_when_FpUnit_l95_5 = 6'h17;
    end
    if(when_FpUnit_l88_187) begin
      _zz_when_FpUnit_l95_5 = 6'h18;
    end
    if(when_FpUnit_l88_188) begin
      _zz_when_FpUnit_l95_5 = 6'h19;
    end
    if(when_FpUnit_l88_189) begin
      _zz_when_FpUnit_l95_5 = 6'h1a;
    end
    if(when_FpUnit_l88_190) begin
      _zz_when_FpUnit_l95_5 = 6'h1b;
    end
    if(when_FpUnit_l88_191) begin
      _zz_when_FpUnit_l95_5 = 6'h1c;
    end
    if(when_FpUnit_l88_192) begin
      _zz_when_FpUnit_l95_5 = 6'h1d;
    end
    if(when_FpUnit_l88_193) begin
      _zz_when_FpUnit_l95_5 = 6'h1e;
    end
    if(when_FpUnit_l88_194) begin
      _zz_when_FpUnit_l95_5 = 6'h1f;
    end
    if(when_FpUnit_l88_195) begin
      _zz_when_FpUnit_l95_5 = 6'h20;
    end
    if(when_FpUnit_l88_196) begin
      _zz_when_FpUnit_l95_5 = 6'h21;
    end
    if(when_FpUnit_l88_197) begin
      _zz_when_FpUnit_l95_5 = 6'h22;
    end
    if(when_FpUnit_l88_198) begin
      _zz_when_FpUnit_l95_5 = 6'h23;
    end
    if(when_FpUnit_l88_199) begin
      _zz_when_FpUnit_l95_5 = 6'h24;
    end
    if(when_FpUnit_l88_200) begin
      _zz_when_FpUnit_l95_5 = 6'h25;
    end
    if(when_FpUnit_l88_201) begin
      _zz_when_FpUnit_l95_5 = 6'h26;
    end
    if(when_FpUnit_l88_202) begin
      _zz_when_FpUnit_l95_5 = 6'h27;
    end
    if(when_FpUnit_l88_203) begin
      _zz_when_FpUnit_l95_5 = 6'h28;
    end
    if(when_FpUnit_l88_204) begin
      _zz_when_FpUnit_l95_5 = 6'h29;
    end
    if(when_FpUnit_l88_205) begin
      _zz_when_FpUnit_l95_5 = 6'h2a;
    end
    if(when_FpUnit_l88_206) begin
      _zz_when_FpUnit_l95_5 = 6'h2b;
    end
    if(when_FpUnit_l88_207) begin
      _zz_when_FpUnit_l95_5 = 6'h2c;
    end
    if(when_FpUnit_l88_208) begin
      _zz_when_FpUnit_l95_5 = 6'h2d;
    end
    if(when_FpUnit_l88_209) begin
      _zz_when_FpUnit_l95_5 = 6'h2e;
    end
    if(when_FpUnit_l88_210) begin
      _zz_when_FpUnit_l95_5 = 6'h2f;
    end
    if(when_FpUnit_l88_211) begin
      _zz_when_FpUnit_l95_5 = 6'h30;
    end
    if(when_FpUnit_l88_212) begin
      _zz_when_FpUnit_l95_5 = 6'h31;
    end
    if(when_FpUnit_l88_213) begin
      _zz_when_FpUnit_l95_5 = 6'h32;
    end
    if(when_FpUnit_l88_214) begin
      _zz_when_FpUnit_l95_5 = 6'h33;
    end
    if(when_FpUnit_l88_215) begin
      _zz_when_FpUnit_l95_5 = 6'h34;
    end
    if(when_FpUnit_l88_216) begin
      _zz_when_FpUnit_l95_5 = 6'h35;
    end
    if(when_FpUnit_l88_217) begin
      _zz_when_FpUnit_l95_5 = 6'h36;
    end
    if(when_FpUnit_l88_218) begin
      _zz_when_FpUnit_l95_5 = 6'h37;
    end
  end

  assign when_FpUnit_l88_163 = _zz_when_FpUnit_l88_143[0];
  assign when_FpUnit_l88_164 = _zz_when_FpUnit_l88_143[1];
  assign when_FpUnit_l88_165 = _zz_when_FpUnit_l88_143[2];
  assign when_FpUnit_l88_166 = _zz_when_FpUnit_l88_143[3];
  assign when_FpUnit_l88_167 = _zz_when_FpUnit_l88_143[4];
  assign when_FpUnit_l88_168 = _zz_when_FpUnit_l88_143[5];
  assign when_FpUnit_l88_169 = _zz_when_FpUnit_l88_143[6];
  assign when_FpUnit_l88_170 = _zz_when_FpUnit_l88_143[7];
  assign when_FpUnit_l88_171 = _zz_when_FpUnit_l88_143[8];
  assign when_FpUnit_l88_172 = _zz_when_FpUnit_l88_143[9];
  assign when_FpUnit_l88_173 = _zz_when_FpUnit_l88_143[10];
  assign when_FpUnit_l88_174 = _zz_when_FpUnit_l88_143[11];
  assign when_FpUnit_l88_175 = _zz_when_FpUnit_l88_143[12];
  assign when_FpUnit_l88_176 = _zz_when_FpUnit_l88_143[13];
  assign when_FpUnit_l88_177 = _zz_when_FpUnit_l88_143[14];
  assign when_FpUnit_l88_178 = _zz_when_FpUnit_l88_143[15];
  assign when_FpUnit_l88_179 = _zz_when_FpUnit_l88_143[16];
  assign when_FpUnit_l88_180 = _zz_when_FpUnit_l88_143[17];
  assign when_FpUnit_l88_181 = _zz_when_FpUnit_l88_143[18];
  assign when_FpUnit_l88_182 = _zz_when_FpUnit_l88_143[19];
  assign when_FpUnit_l88_183 = _zz_when_FpUnit_l88_143[20];
  assign when_FpUnit_l88_184 = _zz_when_FpUnit_l88_143[21];
  assign when_FpUnit_l88_185 = _zz_when_FpUnit_l88_143[22];
  assign when_FpUnit_l88_186 = _zz_when_FpUnit_l88_143[23];
  assign when_FpUnit_l88_187 = _zz_when_FpUnit_l88_143[24];
  assign when_FpUnit_l88_188 = _zz_when_FpUnit_l88_143[25];
  assign when_FpUnit_l88_189 = _zz_when_FpUnit_l88_143[26];
  assign when_FpUnit_l88_190 = _zz_when_FpUnit_l88_143[27];
  assign when_FpUnit_l88_191 = _zz_when_FpUnit_l88_143[28];
  assign when_FpUnit_l88_192 = _zz_when_FpUnit_l88_143[29];
  assign when_FpUnit_l88_193 = _zz_when_FpUnit_l88_143[30];
  assign when_FpUnit_l88_194 = _zz_when_FpUnit_l88_143[31];
  assign when_FpUnit_l88_195 = _zz_when_FpUnit_l88_143[32];
  assign when_FpUnit_l88_196 = _zz_when_FpUnit_l88_143[33];
  assign when_FpUnit_l88_197 = _zz_when_FpUnit_l88_143[34];
  assign when_FpUnit_l88_198 = _zz_when_FpUnit_l88_143[35];
  assign when_FpUnit_l88_199 = _zz_when_FpUnit_l88_143[36];
  assign when_FpUnit_l88_200 = _zz_when_FpUnit_l88_143[37];
  assign when_FpUnit_l88_201 = _zz_when_FpUnit_l88_143[38];
  assign when_FpUnit_l88_202 = _zz_when_FpUnit_l88_143[39];
  assign when_FpUnit_l88_203 = _zz_when_FpUnit_l88_143[40];
  assign when_FpUnit_l88_204 = _zz_when_FpUnit_l88_143[41];
  assign when_FpUnit_l88_205 = _zz_when_FpUnit_l88_143[42];
  assign when_FpUnit_l88_206 = _zz_when_FpUnit_l88_143[43];
  assign when_FpUnit_l88_207 = _zz_when_FpUnit_l88_143[44];
  assign when_FpUnit_l88_208 = _zz_when_FpUnit_l88_143[45];
  assign when_FpUnit_l88_209 = _zz_when_FpUnit_l88_143[46];
  assign when_FpUnit_l88_210 = _zz_when_FpUnit_l88_143[47];
  assign when_FpUnit_l88_211 = _zz_when_FpUnit_l88_143[48];
  assign when_FpUnit_l88_212 = _zz_when_FpUnit_l88_143[49];
  assign when_FpUnit_l88_213 = _zz_when_FpUnit_l88_143[50];
  assign when_FpUnit_l88_214 = _zz_when_FpUnit_l88_143[51];
  assign when_FpUnit_l88_215 = _zz_when_FpUnit_l88_143[52];
  assign when_FpUnit_l88_216 = _zz_when_FpUnit_l88_143[53];
  assign when_FpUnit_l88_217 = _zz_when_FpUnit_l88_143[54];
  assign when_FpUnit_l88_218 = _zz_when_FpUnit_l88_143[55];
  always @(*) begin
    _zz_flagUF_73 = 27'h0;
    if(when_FpUnit_l94_5) begin
      if(when_FpUnit_l95_5) begin
        _zz_flagUF_73 = _zz__zz_flagUF_73;
      end else begin
        _zz_flagUF_73 = _zz__zz_flagUF_73_2;
      end
    end
  end

  always @(*) begin
    _zz_flagUF_74 = 1'b0;
    if(when_FpUnit_l94_5) begin
      if(when_FpUnit_l95_5) begin
        _zz_flagUF_74 = (|(_zz_when_FpUnit_l88_143 & _zz__zz_flagUF_74));
      end else begin
        _zz_flagUF_74 = 1'b0;
      end
    end
  end

  assign _zz_flagUF_75 = ($signed(_zz__zz_flagUF_75) + $signed(_zz_when_FpUnit_l367_4));
  assign when_FpUnit_l94_5 = (_zz_when_FpUnit_l88_143 != 56'h0);
  assign when_FpUnit_l95_5 = (6'h1a < _zz_when_FpUnit_l95_5);
  assign _zz_flagUF_76 = (_zz_when_FpUnit_l95_5 - 6'h1a);
  assign _zz_flagUF_77 = _zz__zz_flagUF_77;
  assign _zz_flagUF_78 = _zz_flagUF_77;
  assign _zz_flagUF_79 = (((_zz_flagUF_74 || _zz_flagUF_71) || _zz_flagUF_72) || (|(_zz_flagUF_77 & 29'h0)));
  assign _zz_flagUF_80 = ($signed(_zz__zz_flagUF_80) < $signed(12'h001));
  assign _zz_when_FpUnit_l147_5 = (_zz_flagUF_80 ? _zz__zz_when_FpUnit_l147_5 : 12'h0);
  assign _zz_when_FpUnit_l150_5 = _zz_when_FpUnit_l147_5;
  assign when_FpUnit_l147_5 = ($signed(_zz_when_FpUnit_l147_5) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l147_5) begin
      _zz_flagUF_81 = _zz__zz_flagUF_81;
    end else begin
      if(when_FpUnit_l150_5) begin
        _zz_flagUF_81 = 27'h0;
      end else begin
        _zz_flagUF_81 = _zz__zz_flagUF_81_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l147_5) begin
      _zz_flagUF_82 = _zz_flagUF_79;
    end else begin
      if(when_FpUnit_l150_5) begin
        _zz_flagUF_82 = ((|_zz_flagUF_78) || _zz_flagUF_79);
      end else begin
        _zz_flagUF_82 = ((|(_zz_flagUF_78 & _zz__zz_flagUF_82)) || _zz_flagUF_79);
      end
    end
  end

  assign when_FpUnit_l150_5 = (12'h01b <= _zz_when_FpUnit_l150_5);
  assign _zz_when_FpUnit_l186_15 = (_zz_flagUF_80 ? 12'hf82 : _zz_flagUF_75);
  assign _zz_flagUF_83 = _zz_flagUF_81[2];
  assign _zz_flagUF_84 = _zz_flagUF_81[1];
  assign _zz_flagUF_85 = (_zz_flagUF_81[0] || _zz_flagUF_82);
  assign _zz_when_FpUnit_l190_15 = _zz_flagUF_81[26 : 3];
  assign _zz_when_FpUnit_l190_16 = (_zz__zz_when_FpUnit_l190_16 + _zz__zz_when_FpUnit_l190_16_2);
  assign _zz_when_FpUnit_l186_16 = _zz_when_FpUnit_l190_16[24];
  assign _zz_when_FpUnit_l190_17 = (_zz_when_FpUnit_l186_16 ? _zz__zz_when_FpUnit_l190_17 : _zz__zz_when_FpUnit_l190_17_1);
  assign _zz_when_FpUnit_l186_17 = ($signed(_zz__zz_when_FpUnit_l186_17) + $signed(12'h07f));
  assign _zz_flagUF_86 = ((_zz_flagUF_83 || _zz_flagUF_84) || _zz_flagUF_85);
  assign when_FpUnit_l186_5 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l186_17));
  assign _zz_res_37 = {_zz_when_FpUnit_l88_142,{8'hff,23'h0}};
  assign _zz_res_38 = {_zz_when_FpUnit_l88_142,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_39 = 32'h0;
    if(when_FpUnit_l186_5) begin
      _zz_res_39 = ((io_rm == 3'b001) ? _zz_res_38 : ((io_rm == 3'b010) ? (_zz_when_FpUnit_l88_142 ? _zz_res_37 : _zz_res_38) : ((io_rm == 3'b011) ? (_zz_when_FpUnit_l88_142 ? _zz_res_38 : _zz_res_37) : _zz_res_37)));
    end else begin
      if(when_FpUnit_l190_5) begin
        _zz_res_39 = {_zz_when_FpUnit_l88_142,{8'h0,23'h0}};
      end else begin
        if(when_FpUnit_l192_5) begin
          _zz_res_39 = {_zz_when_FpUnit_l88_142,{8'h0,_zz_when_FpUnit_l190_17[22 : 0]}};
        end else begin
          _zz_res_39 = {_zz_when_FpUnit_l88_142,{_zz__zz_res_39,_zz_when_FpUnit_l190_17[22 : 0]}};
        end
      end
    end
  end

  assign when_FpUnit_l190_5 = (_zz_flagUF_80 && (_zz_when_FpUnit_l190_17 == 24'h0));
  assign when_FpUnit_l192_5 = ((_zz_flagUF_80 && (_zz_when_FpUnit_l190_17 != 24'h0)) && (! _zz_when_FpUnit_l190_17[23]));
  always @(*) begin
    _zz_res_40 = _zz_res_39;
    if(when_FpUnit_l395) begin
      _zz_res_40 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l396) begin
        _zz_res_40 = 32'h7fc00000;
      end else begin
        if(when_FpUnit_l397) begin
          _zz_res_40 = 32'h7fc00000;
        end else begin
          if(when_FpUnit_l398) begin
            _zz_res_40 = {_zz_when_FpUnit_l397_1,{8'hff,23'h0}};
          end else begin
            if(when_FpUnit_l399) begin
              _zz_res_40 = {_zz_when_FpUnit_l397_2,{8'hff,23'h0}};
            end
          end
        end
      end
    end
  end

  assign when_FpUnit_l395 = ((when_FpUnit_l342 || when_FpUnit_l431) || _zz_when_FpUnit_l395);
  assign when_FpUnit_l396 = ((when_FpUnit_l244 && when_FpUnit_l305) || (when_FpUnit_l308 && when_FpUnit_l245));
  assign when_FpUnit_l397 = (((when_FpUnit_l244 || when_FpUnit_l245) && when_FpUnit_l399) && (_zz_when_FpUnit_l397_1 != _zz_when_FpUnit_l397_2));
  assign when_FpUnit_l398 = (when_FpUnit_l244 || when_FpUnit_l245);
  assign _zz_when_FpUnit_l397_3 = ((when_FpUnit_l519 ^ _zz_when_FpUnit_l243) ^ 1'b0);
  assign _zz_when_FpUnit_l397_4 = (_zz_when_FpUnit_l397 ^ 1'b1);
  assign _zz_when_FpUnit_l88_144 = (_zz_when_FpUnit_l88 * _zz_when_FpUnit_l88_1);
  assign _zz_when_FpUnit_l367_7 = ($signed(_zz__zz_when_FpUnit_l367_7) - $signed(12'h02e));
  assign _zz_when_FpUnit_l367_8 = ($signed(_zz__zz_when_FpUnit_l367_8) - $signed(12'h017));
  assign _zz_when_FpUnit_l367_9 = (($signed(_zz_when_FpUnit_l367_8) <= $signed(_zz_when_FpUnit_l367_7)) ? _zz_when_FpUnit_l367_7 : _zz_when_FpUnit_l367_8);
  assign _zz_when_FpUnit_l367_10 = ($signed(_zz_when_FpUnit_l367_9) - $signed(_zz_when_FpUnit_l367_7));
  assign _zz_when_FpUnit_l368_2 = _zz_when_FpUnit_l367_10;
  assign when_FpUnit_l367_2 = ($signed(_zz_when_FpUnit_l367_10) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l367_2) begin
      _zz_when_FpUnit_l88_145 = _zz__zz_when_FpUnit_l88_145;
    end else begin
      if(when_FpUnit_l368_2) begin
        _zz_when_FpUnit_l88_145 = 54'h0;
      end else begin
        _zz_when_FpUnit_l88_145 = _zz__zz_when_FpUnit_l88_145_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l367_2) begin
      _zz_flagUF_87 = 1'b0;
    end else begin
      if(when_FpUnit_l368_2) begin
        _zz_flagUF_87 = (|_zz_when_FpUnit_l88_144);
      end else begin
        _zz_flagUF_87 = (|(_zz__zz_flagUF_87 & _zz__zz_flagUF_87_1));
      end
    end
  end

  assign when_FpUnit_l368_2 = (12'h036 <= _zz_when_FpUnit_l368_2);
  assign _zz_when_FpUnit_l367_11 = ($signed(_zz_when_FpUnit_l367_9) - $signed(_zz_when_FpUnit_l367_8));
  assign _zz_when_FpUnit_l368_3 = _zz_when_FpUnit_l367_11;
  assign when_FpUnit_l367_3 = ($signed(_zz_when_FpUnit_l367_11) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l367_3) begin
      _zz_when_FpUnit_l88_146 = _zz__zz_when_FpUnit_l88_146;
    end else begin
      if(when_FpUnit_l368_3) begin
        _zz_when_FpUnit_l88_146 = 54'h0;
      end else begin
        _zz_when_FpUnit_l88_146 = _zz__zz_when_FpUnit_l88_146_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l367_3) begin
      _zz_flagUF_88 = 1'b0;
    end else begin
      if(when_FpUnit_l368_3) begin
        _zz_flagUF_88 = (|_zz_when_FpUnit_l88_2);
      end else begin
        _zz_flagUF_88 = (|(_zz__zz_flagUF_88 & _zz__zz_flagUF_88_1));
      end
    end
  end

  assign when_FpUnit_l368_3 = (12'h036 <= _zz_when_FpUnit_l368_3);
  assign _zz_when_FpUnit_l88_147 = _zz__zz_when_FpUnit_l88_147;
  assign _zz_when_FpUnit_l88_148 = _zz__zz_when_FpUnit_l88_148;
  assign _zz_when_FpUnit_l88_149 = ($signed(_zz__zz_when_FpUnit_l88_149) + $signed(_zz__zz_when_FpUnit_l88_149_3));
  assign _zz_when_FpUnit_l88_150 = _zz_when_FpUnit_l88_149[55];
  assign _zz_when_FpUnit_l88_151 = (_zz_when_FpUnit_l88_150 ? _zz__zz_when_FpUnit_l88_151 : _zz_when_FpUnit_l88_149);
  always @(*) begin
    _zz_when_FpUnit_l95_6 = 6'h0;
    if(when_FpUnit_l88_219) begin
      _zz_when_FpUnit_l95_6 = 6'h0;
    end
    if(when_FpUnit_l88_220) begin
      _zz_when_FpUnit_l95_6 = 6'h01;
    end
    if(when_FpUnit_l88_221) begin
      _zz_when_FpUnit_l95_6 = 6'h02;
    end
    if(when_FpUnit_l88_222) begin
      _zz_when_FpUnit_l95_6 = 6'h03;
    end
    if(when_FpUnit_l88_223) begin
      _zz_when_FpUnit_l95_6 = 6'h04;
    end
    if(when_FpUnit_l88_224) begin
      _zz_when_FpUnit_l95_6 = 6'h05;
    end
    if(when_FpUnit_l88_225) begin
      _zz_when_FpUnit_l95_6 = 6'h06;
    end
    if(when_FpUnit_l88_226) begin
      _zz_when_FpUnit_l95_6 = 6'h07;
    end
    if(when_FpUnit_l88_227) begin
      _zz_when_FpUnit_l95_6 = 6'h08;
    end
    if(when_FpUnit_l88_228) begin
      _zz_when_FpUnit_l95_6 = 6'h09;
    end
    if(when_FpUnit_l88_229) begin
      _zz_when_FpUnit_l95_6 = 6'h0a;
    end
    if(when_FpUnit_l88_230) begin
      _zz_when_FpUnit_l95_6 = 6'h0b;
    end
    if(when_FpUnit_l88_231) begin
      _zz_when_FpUnit_l95_6 = 6'h0c;
    end
    if(when_FpUnit_l88_232) begin
      _zz_when_FpUnit_l95_6 = 6'h0d;
    end
    if(when_FpUnit_l88_233) begin
      _zz_when_FpUnit_l95_6 = 6'h0e;
    end
    if(when_FpUnit_l88_234) begin
      _zz_when_FpUnit_l95_6 = 6'h0f;
    end
    if(when_FpUnit_l88_235) begin
      _zz_when_FpUnit_l95_6 = 6'h10;
    end
    if(when_FpUnit_l88_236) begin
      _zz_when_FpUnit_l95_6 = 6'h11;
    end
    if(when_FpUnit_l88_237) begin
      _zz_when_FpUnit_l95_6 = 6'h12;
    end
    if(when_FpUnit_l88_238) begin
      _zz_when_FpUnit_l95_6 = 6'h13;
    end
    if(when_FpUnit_l88_239) begin
      _zz_when_FpUnit_l95_6 = 6'h14;
    end
    if(when_FpUnit_l88_240) begin
      _zz_when_FpUnit_l95_6 = 6'h15;
    end
    if(when_FpUnit_l88_241) begin
      _zz_when_FpUnit_l95_6 = 6'h16;
    end
    if(when_FpUnit_l88_242) begin
      _zz_when_FpUnit_l95_6 = 6'h17;
    end
    if(when_FpUnit_l88_243) begin
      _zz_when_FpUnit_l95_6 = 6'h18;
    end
    if(when_FpUnit_l88_244) begin
      _zz_when_FpUnit_l95_6 = 6'h19;
    end
    if(when_FpUnit_l88_245) begin
      _zz_when_FpUnit_l95_6 = 6'h1a;
    end
    if(when_FpUnit_l88_246) begin
      _zz_when_FpUnit_l95_6 = 6'h1b;
    end
    if(when_FpUnit_l88_247) begin
      _zz_when_FpUnit_l95_6 = 6'h1c;
    end
    if(when_FpUnit_l88_248) begin
      _zz_when_FpUnit_l95_6 = 6'h1d;
    end
    if(when_FpUnit_l88_249) begin
      _zz_when_FpUnit_l95_6 = 6'h1e;
    end
    if(when_FpUnit_l88_250) begin
      _zz_when_FpUnit_l95_6 = 6'h1f;
    end
    if(when_FpUnit_l88_251) begin
      _zz_when_FpUnit_l95_6 = 6'h20;
    end
    if(when_FpUnit_l88_252) begin
      _zz_when_FpUnit_l95_6 = 6'h21;
    end
    if(when_FpUnit_l88_253) begin
      _zz_when_FpUnit_l95_6 = 6'h22;
    end
    if(when_FpUnit_l88_254) begin
      _zz_when_FpUnit_l95_6 = 6'h23;
    end
    if(when_FpUnit_l88_255) begin
      _zz_when_FpUnit_l95_6 = 6'h24;
    end
    if(when_FpUnit_l88_256) begin
      _zz_when_FpUnit_l95_6 = 6'h25;
    end
    if(when_FpUnit_l88_257) begin
      _zz_when_FpUnit_l95_6 = 6'h26;
    end
    if(when_FpUnit_l88_258) begin
      _zz_when_FpUnit_l95_6 = 6'h27;
    end
    if(when_FpUnit_l88_259) begin
      _zz_when_FpUnit_l95_6 = 6'h28;
    end
    if(when_FpUnit_l88_260) begin
      _zz_when_FpUnit_l95_6 = 6'h29;
    end
    if(when_FpUnit_l88_261) begin
      _zz_when_FpUnit_l95_6 = 6'h2a;
    end
    if(when_FpUnit_l88_262) begin
      _zz_when_FpUnit_l95_6 = 6'h2b;
    end
    if(when_FpUnit_l88_263) begin
      _zz_when_FpUnit_l95_6 = 6'h2c;
    end
    if(when_FpUnit_l88_264) begin
      _zz_when_FpUnit_l95_6 = 6'h2d;
    end
    if(when_FpUnit_l88_265) begin
      _zz_when_FpUnit_l95_6 = 6'h2e;
    end
    if(when_FpUnit_l88_266) begin
      _zz_when_FpUnit_l95_6 = 6'h2f;
    end
    if(when_FpUnit_l88_267) begin
      _zz_when_FpUnit_l95_6 = 6'h30;
    end
    if(when_FpUnit_l88_268) begin
      _zz_when_FpUnit_l95_6 = 6'h31;
    end
    if(when_FpUnit_l88_269) begin
      _zz_when_FpUnit_l95_6 = 6'h32;
    end
    if(when_FpUnit_l88_270) begin
      _zz_when_FpUnit_l95_6 = 6'h33;
    end
    if(when_FpUnit_l88_271) begin
      _zz_when_FpUnit_l95_6 = 6'h34;
    end
    if(when_FpUnit_l88_272) begin
      _zz_when_FpUnit_l95_6 = 6'h35;
    end
    if(when_FpUnit_l88_273) begin
      _zz_when_FpUnit_l95_6 = 6'h36;
    end
    if(when_FpUnit_l88_274) begin
      _zz_when_FpUnit_l95_6 = 6'h37;
    end
  end

  assign when_FpUnit_l88_219 = _zz_when_FpUnit_l88_151[0];
  assign when_FpUnit_l88_220 = _zz_when_FpUnit_l88_151[1];
  assign when_FpUnit_l88_221 = _zz_when_FpUnit_l88_151[2];
  assign when_FpUnit_l88_222 = _zz_when_FpUnit_l88_151[3];
  assign when_FpUnit_l88_223 = _zz_when_FpUnit_l88_151[4];
  assign when_FpUnit_l88_224 = _zz_when_FpUnit_l88_151[5];
  assign when_FpUnit_l88_225 = _zz_when_FpUnit_l88_151[6];
  assign when_FpUnit_l88_226 = _zz_when_FpUnit_l88_151[7];
  assign when_FpUnit_l88_227 = _zz_when_FpUnit_l88_151[8];
  assign when_FpUnit_l88_228 = _zz_when_FpUnit_l88_151[9];
  assign when_FpUnit_l88_229 = _zz_when_FpUnit_l88_151[10];
  assign when_FpUnit_l88_230 = _zz_when_FpUnit_l88_151[11];
  assign when_FpUnit_l88_231 = _zz_when_FpUnit_l88_151[12];
  assign when_FpUnit_l88_232 = _zz_when_FpUnit_l88_151[13];
  assign when_FpUnit_l88_233 = _zz_when_FpUnit_l88_151[14];
  assign when_FpUnit_l88_234 = _zz_when_FpUnit_l88_151[15];
  assign when_FpUnit_l88_235 = _zz_when_FpUnit_l88_151[16];
  assign when_FpUnit_l88_236 = _zz_when_FpUnit_l88_151[17];
  assign when_FpUnit_l88_237 = _zz_when_FpUnit_l88_151[18];
  assign when_FpUnit_l88_238 = _zz_when_FpUnit_l88_151[19];
  assign when_FpUnit_l88_239 = _zz_when_FpUnit_l88_151[20];
  assign when_FpUnit_l88_240 = _zz_when_FpUnit_l88_151[21];
  assign when_FpUnit_l88_241 = _zz_when_FpUnit_l88_151[22];
  assign when_FpUnit_l88_242 = _zz_when_FpUnit_l88_151[23];
  assign when_FpUnit_l88_243 = _zz_when_FpUnit_l88_151[24];
  assign when_FpUnit_l88_244 = _zz_when_FpUnit_l88_151[25];
  assign when_FpUnit_l88_245 = _zz_when_FpUnit_l88_151[26];
  assign when_FpUnit_l88_246 = _zz_when_FpUnit_l88_151[27];
  assign when_FpUnit_l88_247 = _zz_when_FpUnit_l88_151[28];
  assign when_FpUnit_l88_248 = _zz_when_FpUnit_l88_151[29];
  assign when_FpUnit_l88_249 = _zz_when_FpUnit_l88_151[30];
  assign when_FpUnit_l88_250 = _zz_when_FpUnit_l88_151[31];
  assign when_FpUnit_l88_251 = _zz_when_FpUnit_l88_151[32];
  assign when_FpUnit_l88_252 = _zz_when_FpUnit_l88_151[33];
  assign when_FpUnit_l88_253 = _zz_when_FpUnit_l88_151[34];
  assign when_FpUnit_l88_254 = _zz_when_FpUnit_l88_151[35];
  assign when_FpUnit_l88_255 = _zz_when_FpUnit_l88_151[36];
  assign when_FpUnit_l88_256 = _zz_when_FpUnit_l88_151[37];
  assign when_FpUnit_l88_257 = _zz_when_FpUnit_l88_151[38];
  assign when_FpUnit_l88_258 = _zz_when_FpUnit_l88_151[39];
  assign when_FpUnit_l88_259 = _zz_when_FpUnit_l88_151[40];
  assign when_FpUnit_l88_260 = _zz_when_FpUnit_l88_151[41];
  assign when_FpUnit_l88_261 = _zz_when_FpUnit_l88_151[42];
  assign when_FpUnit_l88_262 = _zz_when_FpUnit_l88_151[43];
  assign when_FpUnit_l88_263 = _zz_when_FpUnit_l88_151[44];
  assign when_FpUnit_l88_264 = _zz_when_FpUnit_l88_151[45];
  assign when_FpUnit_l88_265 = _zz_when_FpUnit_l88_151[46];
  assign when_FpUnit_l88_266 = _zz_when_FpUnit_l88_151[47];
  assign when_FpUnit_l88_267 = _zz_when_FpUnit_l88_151[48];
  assign when_FpUnit_l88_268 = _zz_when_FpUnit_l88_151[49];
  assign when_FpUnit_l88_269 = _zz_when_FpUnit_l88_151[50];
  assign when_FpUnit_l88_270 = _zz_when_FpUnit_l88_151[51];
  assign when_FpUnit_l88_271 = _zz_when_FpUnit_l88_151[52];
  assign when_FpUnit_l88_272 = _zz_when_FpUnit_l88_151[53];
  assign when_FpUnit_l88_273 = _zz_when_FpUnit_l88_151[54];
  assign when_FpUnit_l88_274 = _zz_when_FpUnit_l88_151[55];
  always @(*) begin
    _zz_flagUF_89 = 27'h0;
    if(when_FpUnit_l94_6) begin
      if(when_FpUnit_l95_6) begin
        _zz_flagUF_89 = _zz__zz_flagUF_89;
      end else begin
        _zz_flagUF_89 = _zz__zz_flagUF_89_2;
      end
    end
  end

  always @(*) begin
    _zz_flagUF_90 = 1'b0;
    if(when_FpUnit_l94_6) begin
      if(when_FpUnit_l95_6) begin
        _zz_flagUF_90 = (|(_zz_when_FpUnit_l88_151 & _zz__zz_flagUF_90));
      end else begin
        _zz_flagUF_90 = 1'b0;
      end
    end
  end

  assign _zz_flagUF_91 = ($signed(_zz__zz_flagUF_91) + $signed(_zz_when_FpUnit_l367_9));
  assign when_FpUnit_l94_6 = (_zz_when_FpUnit_l88_151 != 56'h0);
  assign when_FpUnit_l95_6 = (6'h1a < _zz_when_FpUnit_l95_6);
  assign _zz_flagUF_92 = (_zz_when_FpUnit_l95_6 - 6'h1a);
  assign _zz_flagUF_93 = _zz__zz_flagUF_93;
  assign _zz_flagUF_94 = _zz_flagUF_93;
  assign _zz_flagUF_95 = (((_zz_flagUF_90 || _zz_flagUF_87) || _zz_flagUF_88) || (|(_zz_flagUF_93 & 29'h0)));
  assign _zz_flagUF_96 = ($signed(_zz__zz_flagUF_96) < $signed(12'h001));
  assign _zz_when_FpUnit_l147_6 = (_zz_flagUF_96 ? _zz__zz_when_FpUnit_l147_6 : 12'h0);
  assign _zz_when_FpUnit_l150_6 = _zz_when_FpUnit_l147_6;
  assign when_FpUnit_l147_6 = ($signed(_zz_when_FpUnit_l147_6) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l147_6) begin
      _zz_flagUF_97 = _zz__zz_flagUF_97;
    end else begin
      if(when_FpUnit_l150_6) begin
        _zz_flagUF_97 = 27'h0;
      end else begin
        _zz_flagUF_97 = _zz__zz_flagUF_97_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l147_6) begin
      _zz_flagUF_98 = _zz_flagUF_95;
    end else begin
      if(when_FpUnit_l150_6) begin
        _zz_flagUF_98 = ((|_zz_flagUF_94) || _zz_flagUF_95);
      end else begin
        _zz_flagUF_98 = ((|(_zz_flagUF_94 & _zz__zz_flagUF_98)) || _zz_flagUF_95);
      end
    end
  end

  assign when_FpUnit_l150_6 = (12'h01b <= _zz_when_FpUnit_l150_6);
  assign _zz_when_FpUnit_l186_18 = (_zz_flagUF_96 ? 12'hf82 : _zz_flagUF_91);
  assign _zz_flagUF_99 = _zz_flagUF_97[2];
  assign _zz_flagUF_100 = _zz_flagUF_97[1];
  assign _zz_flagUF_101 = (_zz_flagUF_97[0] || _zz_flagUF_98);
  assign _zz_when_FpUnit_l190_18 = _zz_flagUF_97[26 : 3];
  assign _zz_when_FpUnit_l190_19 = (_zz__zz_when_FpUnit_l190_19 + _zz__zz_when_FpUnit_l190_19_2);
  assign _zz_when_FpUnit_l186_19 = _zz_when_FpUnit_l190_19[24];
  assign _zz_when_FpUnit_l190_20 = (_zz_when_FpUnit_l186_19 ? _zz__zz_when_FpUnit_l190_20 : _zz__zz_when_FpUnit_l190_20_1);
  assign _zz_when_FpUnit_l186_20 = ($signed(_zz__zz_when_FpUnit_l186_20) + $signed(12'h07f));
  assign _zz_flagUF_102 = ((_zz_flagUF_99 || _zz_flagUF_100) || _zz_flagUF_101);
  assign when_FpUnit_l186_6 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l186_20));
  assign _zz_res_41 = {_zz_when_FpUnit_l88_150,{8'hff,23'h0}};
  assign _zz_res_42 = {_zz_when_FpUnit_l88_150,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_43 = 32'h0;
    if(when_FpUnit_l186_6) begin
      _zz_res_43 = ((io_rm == 3'b001) ? _zz_res_42 : ((io_rm == 3'b010) ? (_zz_when_FpUnit_l88_150 ? _zz_res_41 : _zz_res_42) : ((io_rm == 3'b011) ? (_zz_when_FpUnit_l88_150 ? _zz_res_42 : _zz_res_41) : _zz_res_41)));
    end else begin
      if(when_FpUnit_l190_6) begin
        _zz_res_43 = {_zz_when_FpUnit_l88_150,{8'h0,23'h0}};
      end else begin
        if(when_FpUnit_l192_6) begin
          _zz_res_43 = {_zz_when_FpUnit_l88_150,{8'h0,_zz_when_FpUnit_l190_20[22 : 0]}};
        end else begin
          _zz_res_43 = {_zz_when_FpUnit_l88_150,{_zz__zz_res_43,_zz_when_FpUnit_l190_20[22 : 0]}};
        end
      end
    end
  end

  assign when_FpUnit_l190_6 = (_zz_flagUF_96 && (_zz_when_FpUnit_l190_20 == 24'h0));
  assign when_FpUnit_l192_6 = ((_zz_flagUF_96 && (_zz_when_FpUnit_l190_20 != 24'h0)) && (! _zz_when_FpUnit_l190_20[23]));
  always @(*) begin
    _zz_res_44 = _zz_res_43;
    if(when_FpUnit_l395_1) begin
      _zz_res_44 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l396_1) begin
        _zz_res_44 = 32'h7fc00000;
      end else begin
        if(when_FpUnit_l397_1) begin
          _zz_res_44 = 32'h7fc00000;
        end else begin
          if(when_FpUnit_l398_1) begin
            _zz_res_44 = {_zz_when_FpUnit_l397_3,{8'hff,23'h0}};
          end else begin
            if(when_FpUnit_l399) begin
              _zz_res_44 = {_zz_when_FpUnit_l397_4,{8'hff,23'h0}};
            end
          end
        end
      end
    end
  end

  assign when_FpUnit_l395_1 = ((when_FpUnit_l342 || when_FpUnit_l431) || _zz_when_FpUnit_l395);
  assign when_FpUnit_l396_1 = ((when_FpUnit_l244 && when_FpUnit_l305) || (when_FpUnit_l308 && when_FpUnit_l245));
  assign when_FpUnit_l397_1 = (((when_FpUnit_l244 || when_FpUnit_l245) && when_FpUnit_l399) && (_zz_when_FpUnit_l397_3 != _zz_when_FpUnit_l397_4));
  assign when_FpUnit_l398_1 = (when_FpUnit_l244 || when_FpUnit_l245);
  assign _zz_when_FpUnit_l397_5 = ((when_FpUnit_l519 ^ _zz_when_FpUnit_l243) ^ 1'b1);
  assign _zz_when_FpUnit_l397_6 = (_zz_when_FpUnit_l397 ^ 1'b0);
  assign _zz_when_FpUnit_l88_152 = (_zz_when_FpUnit_l88 * _zz_when_FpUnit_l88_1);
  assign _zz_when_FpUnit_l367_12 = ($signed(_zz__zz_when_FpUnit_l367_12) - $signed(12'h02e));
  assign _zz_when_FpUnit_l367_13 = ($signed(_zz__zz_when_FpUnit_l367_13) - $signed(12'h017));
  assign _zz_when_FpUnit_l367_14 = (($signed(_zz_when_FpUnit_l367_13) <= $signed(_zz_when_FpUnit_l367_12)) ? _zz_when_FpUnit_l367_12 : _zz_when_FpUnit_l367_13);
  assign _zz_when_FpUnit_l367_15 = ($signed(_zz_when_FpUnit_l367_14) - $signed(_zz_when_FpUnit_l367_12));
  assign _zz_when_FpUnit_l368_4 = _zz_when_FpUnit_l367_15;
  assign when_FpUnit_l367_4 = ($signed(_zz_when_FpUnit_l367_15) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l367_4) begin
      _zz_when_FpUnit_l88_153 = _zz__zz_when_FpUnit_l88_153;
    end else begin
      if(when_FpUnit_l368_4) begin
        _zz_when_FpUnit_l88_153 = 54'h0;
      end else begin
        _zz_when_FpUnit_l88_153 = _zz__zz_when_FpUnit_l88_153_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l367_4) begin
      _zz_flagUF_103 = 1'b0;
    end else begin
      if(when_FpUnit_l368_4) begin
        _zz_flagUF_103 = (|_zz_when_FpUnit_l88_152);
      end else begin
        _zz_flagUF_103 = (|(_zz__zz_flagUF_103 & _zz__zz_flagUF_103_1));
      end
    end
  end

  assign when_FpUnit_l368_4 = (12'h036 <= _zz_when_FpUnit_l368_4);
  assign _zz_when_FpUnit_l367_16 = ($signed(_zz_when_FpUnit_l367_14) - $signed(_zz_when_FpUnit_l367_13));
  assign _zz_when_FpUnit_l368_5 = _zz_when_FpUnit_l367_16;
  assign when_FpUnit_l367_5 = ($signed(_zz_when_FpUnit_l367_16) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l367_5) begin
      _zz_when_FpUnit_l88_154 = _zz__zz_when_FpUnit_l88_154;
    end else begin
      if(when_FpUnit_l368_5) begin
        _zz_when_FpUnit_l88_154 = 54'h0;
      end else begin
        _zz_when_FpUnit_l88_154 = _zz__zz_when_FpUnit_l88_154_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l367_5) begin
      _zz_flagUF_104 = 1'b0;
    end else begin
      if(when_FpUnit_l368_5) begin
        _zz_flagUF_104 = (|_zz_when_FpUnit_l88_2);
      end else begin
        _zz_flagUF_104 = (|(_zz__zz_flagUF_104 & _zz__zz_flagUF_104_1));
      end
    end
  end

  assign when_FpUnit_l368_5 = (12'h036 <= _zz_when_FpUnit_l368_5);
  assign _zz_when_FpUnit_l88_155 = _zz__zz_when_FpUnit_l88_155;
  assign _zz_when_FpUnit_l88_156 = _zz__zz_when_FpUnit_l88_156;
  assign _zz_when_FpUnit_l88_157 = ($signed(_zz__zz_when_FpUnit_l88_157) + $signed(_zz__zz_when_FpUnit_l88_157_3));
  assign _zz_when_FpUnit_l88_158 = _zz_when_FpUnit_l88_157[55];
  assign _zz_when_FpUnit_l88_159 = (_zz_when_FpUnit_l88_158 ? _zz__zz_when_FpUnit_l88_159 : _zz_when_FpUnit_l88_157);
  always @(*) begin
    _zz_when_FpUnit_l95_7 = 6'h0;
    if(when_FpUnit_l88_275) begin
      _zz_when_FpUnit_l95_7 = 6'h0;
    end
    if(when_FpUnit_l88_276) begin
      _zz_when_FpUnit_l95_7 = 6'h01;
    end
    if(when_FpUnit_l88_277) begin
      _zz_when_FpUnit_l95_7 = 6'h02;
    end
    if(when_FpUnit_l88_278) begin
      _zz_when_FpUnit_l95_7 = 6'h03;
    end
    if(when_FpUnit_l88_279) begin
      _zz_when_FpUnit_l95_7 = 6'h04;
    end
    if(when_FpUnit_l88_280) begin
      _zz_when_FpUnit_l95_7 = 6'h05;
    end
    if(when_FpUnit_l88_281) begin
      _zz_when_FpUnit_l95_7 = 6'h06;
    end
    if(when_FpUnit_l88_282) begin
      _zz_when_FpUnit_l95_7 = 6'h07;
    end
    if(when_FpUnit_l88_283) begin
      _zz_when_FpUnit_l95_7 = 6'h08;
    end
    if(when_FpUnit_l88_284) begin
      _zz_when_FpUnit_l95_7 = 6'h09;
    end
    if(when_FpUnit_l88_285) begin
      _zz_when_FpUnit_l95_7 = 6'h0a;
    end
    if(when_FpUnit_l88_286) begin
      _zz_when_FpUnit_l95_7 = 6'h0b;
    end
    if(when_FpUnit_l88_287) begin
      _zz_when_FpUnit_l95_7 = 6'h0c;
    end
    if(when_FpUnit_l88_288) begin
      _zz_when_FpUnit_l95_7 = 6'h0d;
    end
    if(when_FpUnit_l88_289) begin
      _zz_when_FpUnit_l95_7 = 6'h0e;
    end
    if(when_FpUnit_l88_290) begin
      _zz_when_FpUnit_l95_7 = 6'h0f;
    end
    if(when_FpUnit_l88_291) begin
      _zz_when_FpUnit_l95_7 = 6'h10;
    end
    if(when_FpUnit_l88_292) begin
      _zz_when_FpUnit_l95_7 = 6'h11;
    end
    if(when_FpUnit_l88_293) begin
      _zz_when_FpUnit_l95_7 = 6'h12;
    end
    if(when_FpUnit_l88_294) begin
      _zz_when_FpUnit_l95_7 = 6'h13;
    end
    if(when_FpUnit_l88_295) begin
      _zz_when_FpUnit_l95_7 = 6'h14;
    end
    if(when_FpUnit_l88_296) begin
      _zz_when_FpUnit_l95_7 = 6'h15;
    end
    if(when_FpUnit_l88_297) begin
      _zz_when_FpUnit_l95_7 = 6'h16;
    end
    if(when_FpUnit_l88_298) begin
      _zz_when_FpUnit_l95_7 = 6'h17;
    end
    if(when_FpUnit_l88_299) begin
      _zz_when_FpUnit_l95_7 = 6'h18;
    end
    if(when_FpUnit_l88_300) begin
      _zz_when_FpUnit_l95_7 = 6'h19;
    end
    if(when_FpUnit_l88_301) begin
      _zz_when_FpUnit_l95_7 = 6'h1a;
    end
    if(when_FpUnit_l88_302) begin
      _zz_when_FpUnit_l95_7 = 6'h1b;
    end
    if(when_FpUnit_l88_303) begin
      _zz_when_FpUnit_l95_7 = 6'h1c;
    end
    if(when_FpUnit_l88_304) begin
      _zz_when_FpUnit_l95_7 = 6'h1d;
    end
    if(when_FpUnit_l88_305) begin
      _zz_when_FpUnit_l95_7 = 6'h1e;
    end
    if(when_FpUnit_l88_306) begin
      _zz_when_FpUnit_l95_7 = 6'h1f;
    end
    if(when_FpUnit_l88_307) begin
      _zz_when_FpUnit_l95_7 = 6'h20;
    end
    if(when_FpUnit_l88_308) begin
      _zz_when_FpUnit_l95_7 = 6'h21;
    end
    if(when_FpUnit_l88_309) begin
      _zz_when_FpUnit_l95_7 = 6'h22;
    end
    if(when_FpUnit_l88_310) begin
      _zz_when_FpUnit_l95_7 = 6'h23;
    end
    if(when_FpUnit_l88_311) begin
      _zz_when_FpUnit_l95_7 = 6'h24;
    end
    if(when_FpUnit_l88_312) begin
      _zz_when_FpUnit_l95_7 = 6'h25;
    end
    if(when_FpUnit_l88_313) begin
      _zz_when_FpUnit_l95_7 = 6'h26;
    end
    if(when_FpUnit_l88_314) begin
      _zz_when_FpUnit_l95_7 = 6'h27;
    end
    if(when_FpUnit_l88_315) begin
      _zz_when_FpUnit_l95_7 = 6'h28;
    end
    if(when_FpUnit_l88_316) begin
      _zz_when_FpUnit_l95_7 = 6'h29;
    end
    if(when_FpUnit_l88_317) begin
      _zz_when_FpUnit_l95_7 = 6'h2a;
    end
    if(when_FpUnit_l88_318) begin
      _zz_when_FpUnit_l95_7 = 6'h2b;
    end
    if(when_FpUnit_l88_319) begin
      _zz_when_FpUnit_l95_7 = 6'h2c;
    end
    if(when_FpUnit_l88_320) begin
      _zz_when_FpUnit_l95_7 = 6'h2d;
    end
    if(when_FpUnit_l88_321) begin
      _zz_when_FpUnit_l95_7 = 6'h2e;
    end
    if(when_FpUnit_l88_322) begin
      _zz_when_FpUnit_l95_7 = 6'h2f;
    end
    if(when_FpUnit_l88_323) begin
      _zz_when_FpUnit_l95_7 = 6'h30;
    end
    if(when_FpUnit_l88_324) begin
      _zz_when_FpUnit_l95_7 = 6'h31;
    end
    if(when_FpUnit_l88_325) begin
      _zz_when_FpUnit_l95_7 = 6'h32;
    end
    if(when_FpUnit_l88_326) begin
      _zz_when_FpUnit_l95_7 = 6'h33;
    end
    if(when_FpUnit_l88_327) begin
      _zz_when_FpUnit_l95_7 = 6'h34;
    end
    if(when_FpUnit_l88_328) begin
      _zz_when_FpUnit_l95_7 = 6'h35;
    end
    if(when_FpUnit_l88_329) begin
      _zz_when_FpUnit_l95_7 = 6'h36;
    end
    if(when_FpUnit_l88_330) begin
      _zz_when_FpUnit_l95_7 = 6'h37;
    end
  end

  assign when_FpUnit_l88_275 = _zz_when_FpUnit_l88_159[0];
  assign when_FpUnit_l88_276 = _zz_when_FpUnit_l88_159[1];
  assign when_FpUnit_l88_277 = _zz_when_FpUnit_l88_159[2];
  assign when_FpUnit_l88_278 = _zz_when_FpUnit_l88_159[3];
  assign when_FpUnit_l88_279 = _zz_when_FpUnit_l88_159[4];
  assign when_FpUnit_l88_280 = _zz_when_FpUnit_l88_159[5];
  assign when_FpUnit_l88_281 = _zz_when_FpUnit_l88_159[6];
  assign when_FpUnit_l88_282 = _zz_when_FpUnit_l88_159[7];
  assign when_FpUnit_l88_283 = _zz_when_FpUnit_l88_159[8];
  assign when_FpUnit_l88_284 = _zz_when_FpUnit_l88_159[9];
  assign when_FpUnit_l88_285 = _zz_when_FpUnit_l88_159[10];
  assign when_FpUnit_l88_286 = _zz_when_FpUnit_l88_159[11];
  assign when_FpUnit_l88_287 = _zz_when_FpUnit_l88_159[12];
  assign when_FpUnit_l88_288 = _zz_when_FpUnit_l88_159[13];
  assign when_FpUnit_l88_289 = _zz_when_FpUnit_l88_159[14];
  assign when_FpUnit_l88_290 = _zz_when_FpUnit_l88_159[15];
  assign when_FpUnit_l88_291 = _zz_when_FpUnit_l88_159[16];
  assign when_FpUnit_l88_292 = _zz_when_FpUnit_l88_159[17];
  assign when_FpUnit_l88_293 = _zz_when_FpUnit_l88_159[18];
  assign when_FpUnit_l88_294 = _zz_when_FpUnit_l88_159[19];
  assign when_FpUnit_l88_295 = _zz_when_FpUnit_l88_159[20];
  assign when_FpUnit_l88_296 = _zz_when_FpUnit_l88_159[21];
  assign when_FpUnit_l88_297 = _zz_when_FpUnit_l88_159[22];
  assign when_FpUnit_l88_298 = _zz_when_FpUnit_l88_159[23];
  assign when_FpUnit_l88_299 = _zz_when_FpUnit_l88_159[24];
  assign when_FpUnit_l88_300 = _zz_when_FpUnit_l88_159[25];
  assign when_FpUnit_l88_301 = _zz_when_FpUnit_l88_159[26];
  assign when_FpUnit_l88_302 = _zz_when_FpUnit_l88_159[27];
  assign when_FpUnit_l88_303 = _zz_when_FpUnit_l88_159[28];
  assign when_FpUnit_l88_304 = _zz_when_FpUnit_l88_159[29];
  assign when_FpUnit_l88_305 = _zz_when_FpUnit_l88_159[30];
  assign when_FpUnit_l88_306 = _zz_when_FpUnit_l88_159[31];
  assign when_FpUnit_l88_307 = _zz_when_FpUnit_l88_159[32];
  assign when_FpUnit_l88_308 = _zz_when_FpUnit_l88_159[33];
  assign when_FpUnit_l88_309 = _zz_when_FpUnit_l88_159[34];
  assign when_FpUnit_l88_310 = _zz_when_FpUnit_l88_159[35];
  assign when_FpUnit_l88_311 = _zz_when_FpUnit_l88_159[36];
  assign when_FpUnit_l88_312 = _zz_when_FpUnit_l88_159[37];
  assign when_FpUnit_l88_313 = _zz_when_FpUnit_l88_159[38];
  assign when_FpUnit_l88_314 = _zz_when_FpUnit_l88_159[39];
  assign when_FpUnit_l88_315 = _zz_when_FpUnit_l88_159[40];
  assign when_FpUnit_l88_316 = _zz_when_FpUnit_l88_159[41];
  assign when_FpUnit_l88_317 = _zz_when_FpUnit_l88_159[42];
  assign when_FpUnit_l88_318 = _zz_when_FpUnit_l88_159[43];
  assign when_FpUnit_l88_319 = _zz_when_FpUnit_l88_159[44];
  assign when_FpUnit_l88_320 = _zz_when_FpUnit_l88_159[45];
  assign when_FpUnit_l88_321 = _zz_when_FpUnit_l88_159[46];
  assign when_FpUnit_l88_322 = _zz_when_FpUnit_l88_159[47];
  assign when_FpUnit_l88_323 = _zz_when_FpUnit_l88_159[48];
  assign when_FpUnit_l88_324 = _zz_when_FpUnit_l88_159[49];
  assign when_FpUnit_l88_325 = _zz_when_FpUnit_l88_159[50];
  assign when_FpUnit_l88_326 = _zz_when_FpUnit_l88_159[51];
  assign when_FpUnit_l88_327 = _zz_when_FpUnit_l88_159[52];
  assign when_FpUnit_l88_328 = _zz_when_FpUnit_l88_159[53];
  assign when_FpUnit_l88_329 = _zz_when_FpUnit_l88_159[54];
  assign when_FpUnit_l88_330 = _zz_when_FpUnit_l88_159[55];
  always @(*) begin
    _zz_flagUF_105 = 27'h0;
    if(when_FpUnit_l94_7) begin
      if(when_FpUnit_l95_7) begin
        _zz_flagUF_105 = _zz__zz_flagUF_105;
      end else begin
        _zz_flagUF_105 = _zz__zz_flagUF_105_2;
      end
    end
  end

  always @(*) begin
    _zz_flagUF_106 = 1'b0;
    if(when_FpUnit_l94_7) begin
      if(when_FpUnit_l95_7) begin
        _zz_flagUF_106 = (|(_zz_when_FpUnit_l88_159 & _zz__zz_flagUF_106));
      end else begin
        _zz_flagUF_106 = 1'b0;
      end
    end
  end

  assign _zz_flagUF_107 = ($signed(_zz__zz_flagUF_107) + $signed(_zz_when_FpUnit_l367_14));
  assign when_FpUnit_l94_7 = (_zz_when_FpUnit_l88_159 != 56'h0);
  assign when_FpUnit_l95_7 = (6'h1a < _zz_when_FpUnit_l95_7);
  assign _zz_flagUF_108 = (_zz_when_FpUnit_l95_7 - 6'h1a);
  assign _zz_flagUF_109 = _zz__zz_flagUF_109;
  assign _zz_flagUF_110 = _zz_flagUF_109;
  assign _zz_flagUF_111 = (((_zz_flagUF_106 || _zz_flagUF_103) || _zz_flagUF_104) || (|(_zz_flagUF_109 & 29'h0)));
  assign _zz_flagUF_112 = ($signed(_zz__zz_flagUF_112) < $signed(12'h001));
  assign _zz_when_FpUnit_l147_7 = (_zz_flagUF_112 ? _zz__zz_when_FpUnit_l147_7 : 12'h0);
  assign _zz_when_FpUnit_l150_7 = _zz_when_FpUnit_l147_7;
  assign when_FpUnit_l147_7 = ($signed(_zz_when_FpUnit_l147_7) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l147_7) begin
      _zz_flagUF_113 = _zz__zz_flagUF_113;
    end else begin
      if(when_FpUnit_l150_7) begin
        _zz_flagUF_113 = 27'h0;
      end else begin
        _zz_flagUF_113 = _zz__zz_flagUF_113_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l147_7) begin
      _zz_flagUF_114 = _zz_flagUF_111;
    end else begin
      if(when_FpUnit_l150_7) begin
        _zz_flagUF_114 = ((|_zz_flagUF_110) || _zz_flagUF_111);
      end else begin
        _zz_flagUF_114 = ((|(_zz_flagUF_110 & _zz__zz_flagUF_114)) || _zz_flagUF_111);
      end
    end
  end

  assign when_FpUnit_l150_7 = (12'h01b <= _zz_when_FpUnit_l150_7);
  assign _zz_when_FpUnit_l186_21 = (_zz_flagUF_112 ? 12'hf82 : _zz_flagUF_107);
  assign _zz_flagUF_115 = _zz_flagUF_113[2];
  assign _zz_flagUF_116 = _zz_flagUF_113[1];
  assign _zz_flagUF_117 = (_zz_flagUF_113[0] || _zz_flagUF_114);
  assign _zz_when_FpUnit_l190_21 = _zz_flagUF_113[26 : 3];
  assign _zz_when_FpUnit_l190_22 = (_zz__zz_when_FpUnit_l190_22 + _zz__zz_when_FpUnit_l190_22_2);
  assign _zz_when_FpUnit_l186_22 = _zz_when_FpUnit_l190_22[24];
  assign _zz_when_FpUnit_l190_23 = (_zz_when_FpUnit_l186_22 ? _zz__zz_when_FpUnit_l190_23 : _zz__zz_when_FpUnit_l190_23_1);
  assign _zz_when_FpUnit_l186_23 = ($signed(_zz__zz_when_FpUnit_l186_23) + $signed(12'h07f));
  assign _zz_flagUF_118 = ((_zz_flagUF_115 || _zz_flagUF_116) || _zz_flagUF_117);
  assign when_FpUnit_l186_7 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l186_23));
  assign _zz_res_45 = {_zz_when_FpUnit_l88_158,{8'hff,23'h0}};
  assign _zz_res_46 = {_zz_when_FpUnit_l88_158,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_47 = 32'h0;
    if(when_FpUnit_l186_7) begin
      _zz_res_47 = ((io_rm == 3'b001) ? _zz_res_46 : ((io_rm == 3'b010) ? (_zz_when_FpUnit_l88_158 ? _zz_res_45 : _zz_res_46) : ((io_rm == 3'b011) ? (_zz_when_FpUnit_l88_158 ? _zz_res_46 : _zz_res_45) : _zz_res_45)));
    end else begin
      if(when_FpUnit_l190_7) begin
        _zz_res_47 = {_zz_when_FpUnit_l88_158,{8'h0,23'h0}};
      end else begin
        if(when_FpUnit_l192_7) begin
          _zz_res_47 = {_zz_when_FpUnit_l88_158,{8'h0,_zz_when_FpUnit_l190_23[22 : 0]}};
        end else begin
          _zz_res_47 = {_zz_when_FpUnit_l88_158,{_zz__zz_res_47,_zz_when_FpUnit_l190_23[22 : 0]}};
        end
      end
    end
  end

  assign when_FpUnit_l190_7 = (_zz_flagUF_112 && (_zz_when_FpUnit_l190_23 == 24'h0));
  assign when_FpUnit_l192_7 = ((_zz_flagUF_112 && (_zz_when_FpUnit_l190_23 != 24'h0)) && (! _zz_when_FpUnit_l190_23[23]));
  always @(*) begin
    _zz_res_48 = _zz_res_47;
    if(when_FpUnit_l395_2) begin
      _zz_res_48 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l396_2) begin
        _zz_res_48 = 32'h7fc00000;
      end else begin
        if(when_FpUnit_l397_2) begin
          _zz_res_48 = 32'h7fc00000;
        end else begin
          if(when_FpUnit_l398_2) begin
            _zz_res_48 = {_zz_when_FpUnit_l397_5,{8'hff,23'h0}};
          end else begin
            if(when_FpUnit_l399) begin
              _zz_res_48 = {_zz_when_FpUnit_l397_6,{8'hff,23'h0}};
            end
          end
        end
      end
    end
  end

  assign when_FpUnit_l395_2 = ((when_FpUnit_l342 || when_FpUnit_l431) || _zz_when_FpUnit_l395);
  assign when_FpUnit_l396_2 = ((when_FpUnit_l244 && when_FpUnit_l305) || (when_FpUnit_l308 && when_FpUnit_l245));
  assign when_FpUnit_l397_2 = (((when_FpUnit_l244 || when_FpUnit_l245) && when_FpUnit_l399) && (_zz_when_FpUnit_l397_5 != _zz_when_FpUnit_l397_6));
  assign when_FpUnit_l398_2 = (when_FpUnit_l244 || when_FpUnit_l245);
  assign _zz_when_FpUnit_l397_7 = ((when_FpUnit_l519 ^ _zz_when_FpUnit_l243) ^ 1'b1);
  assign _zz_when_FpUnit_l397_8 = (_zz_when_FpUnit_l397 ^ 1'b1);
  assign _zz_when_FpUnit_l88_160 = (_zz_when_FpUnit_l88 * _zz_when_FpUnit_l88_1);
  assign _zz_when_FpUnit_l367_17 = ($signed(_zz__zz_when_FpUnit_l367_17) - $signed(12'h02e));
  assign _zz_when_FpUnit_l367_18 = ($signed(_zz__zz_when_FpUnit_l367_18) - $signed(12'h017));
  assign _zz_when_FpUnit_l367_19 = (($signed(_zz_when_FpUnit_l367_18) <= $signed(_zz_when_FpUnit_l367_17)) ? _zz_when_FpUnit_l367_17 : _zz_when_FpUnit_l367_18);
  assign _zz_when_FpUnit_l367_20 = ($signed(_zz_when_FpUnit_l367_19) - $signed(_zz_when_FpUnit_l367_17));
  assign _zz_when_FpUnit_l368_6 = _zz_when_FpUnit_l367_20;
  assign when_FpUnit_l367_6 = ($signed(_zz_when_FpUnit_l367_20) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l367_6) begin
      _zz_when_FpUnit_l88_161 = _zz__zz_when_FpUnit_l88_161;
    end else begin
      if(when_FpUnit_l368_6) begin
        _zz_when_FpUnit_l88_161 = 54'h0;
      end else begin
        _zz_when_FpUnit_l88_161 = _zz__zz_when_FpUnit_l88_161_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l367_6) begin
      _zz_flagUF_119 = 1'b0;
    end else begin
      if(when_FpUnit_l368_6) begin
        _zz_flagUF_119 = (|_zz_when_FpUnit_l88_160);
      end else begin
        _zz_flagUF_119 = (|(_zz__zz_flagUF_119 & _zz__zz_flagUF_119_1));
      end
    end
  end

  assign when_FpUnit_l368_6 = (12'h036 <= _zz_when_FpUnit_l368_6);
  assign _zz_when_FpUnit_l367_21 = ($signed(_zz_when_FpUnit_l367_19) - $signed(_zz_when_FpUnit_l367_18));
  assign _zz_when_FpUnit_l368_7 = _zz_when_FpUnit_l367_21;
  assign when_FpUnit_l367_7 = ($signed(_zz_when_FpUnit_l367_21) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l367_7) begin
      _zz_when_FpUnit_l88_162 = _zz__zz_when_FpUnit_l88_162;
    end else begin
      if(when_FpUnit_l368_7) begin
        _zz_when_FpUnit_l88_162 = 54'h0;
      end else begin
        _zz_when_FpUnit_l88_162 = _zz__zz_when_FpUnit_l88_162_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l367_7) begin
      _zz_flagUF_120 = 1'b0;
    end else begin
      if(when_FpUnit_l368_7) begin
        _zz_flagUF_120 = (|_zz_when_FpUnit_l88_2);
      end else begin
        _zz_flagUF_120 = (|(_zz__zz_flagUF_120 & _zz__zz_flagUF_120_1));
      end
    end
  end

  assign when_FpUnit_l368_7 = (12'h036 <= _zz_when_FpUnit_l368_7);
  assign _zz_when_FpUnit_l88_163 = _zz__zz_when_FpUnit_l88_163;
  assign _zz_when_FpUnit_l88_164 = _zz__zz_when_FpUnit_l88_164;
  assign _zz_when_FpUnit_l88_165 = ($signed(_zz__zz_when_FpUnit_l88_165) + $signed(_zz__zz_when_FpUnit_l88_165_3));
  assign _zz_when_FpUnit_l88_166 = _zz_when_FpUnit_l88_165[55];
  assign _zz_when_FpUnit_l88_167 = (_zz_when_FpUnit_l88_166 ? _zz__zz_when_FpUnit_l88_167 : _zz_when_FpUnit_l88_165);
  always @(*) begin
    _zz_when_FpUnit_l95_8 = 6'h0;
    if(when_FpUnit_l88_331) begin
      _zz_when_FpUnit_l95_8 = 6'h0;
    end
    if(when_FpUnit_l88_332) begin
      _zz_when_FpUnit_l95_8 = 6'h01;
    end
    if(when_FpUnit_l88_333) begin
      _zz_when_FpUnit_l95_8 = 6'h02;
    end
    if(when_FpUnit_l88_334) begin
      _zz_when_FpUnit_l95_8 = 6'h03;
    end
    if(when_FpUnit_l88_335) begin
      _zz_when_FpUnit_l95_8 = 6'h04;
    end
    if(when_FpUnit_l88_336) begin
      _zz_when_FpUnit_l95_8 = 6'h05;
    end
    if(when_FpUnit_l88_337) begin
      _zz_when_FpUnit_l95_8 = 6'h06;
    end
    if(when_FpUnit_l88_338) begin
      _zz_when_FpUnit_l95_8 = 6'h07;
    end
    if(when_FpUnit_l88_339) begin
      _zz_when_FpUnit_l95_8 = 6'h08;
    end
    if(when_FpUnit_l88_340) begin
      _zz_when_FpUnit_l95_8 = 6'h09;
    end
    if(when_FpUnit_l88_341) begin
      _zz_when_FpUnit_l95_8 = 6'h0a;
    end
    if(when_FpUnit_l88_342) begin
      _zz_when_FpUnit_l95_8 = 6'h0b;
    end
    if(when_FpUnit_l88_343) begin
      _zz_when_FpUnit_l95_8 = 6'h0c;
    end
    if(when_FpUnit_l88_344) begin
      _zz_when_FpUnit_l95_8 = 6'h0d;
    end
    if(when_FpUnit_l88_345) begin
      _zz_when_FpUnit_l95_8 = 6'h0e;
    end
    if(when_FpUnit_l88_346) begin
      _zz_when_FpUnit_l95_8 = 6'h0f;
    end
    if(when_FpUnit_l88_347) begin
      _zz_when_FpUnit_l95_8 = 6'h10;
    end
    if(when_FpUnit_l88_348) begin
      _zz_when_FpUnit_l95_8 = 6'h11;
    end
    if(when_FpUnit_l88_349) begin
      _zz_when_FpUnit_l95_8 = 6'h12;
    end
    if(when_FpUnit_l88_350) begin
      _zz_when_FpUnit_l95_8 = 6'h13;
    end
    if(when_FpUnit_l88_351) begin
      _zz_when_FpUnit_l95_8 = 6'h14;
    end
    if(when_FpUnit_l88_352) begin
      _zz_when_FpUnit_l95_8 = 6'h15;
    end
    if(when_FpUnit_l88_353) begin
      _zz_when_FpUnit_l95_8 = 6'h16;
    end
    if(when_FpUnit_l88_354) begin
      _zz_when_FpUnit_l95_8 = 6'h17;
    end
    if(when_FpUnit_l88_355) begin
      _zz_when_FpUnit_l95_8 = 6'h18;
    end
    if(when_FpUnit_l88_356) begin
      _zz_when_FpUnit_l95_8 = 6'h19;
    end
    if(when_FpUnit_l88_357) begin
      _zz_when_FpUnit_l95_8 = 6'h1a;
    end
    if(when_FpUnit_l88_358) begin
      _zz_when_FpUnit_l95_8 = 6'h1b;
    end
    if(when_FpUnit_l88_359) begin
      _zz_when_FpUnit_l95_8 = 6'h1c;
    end
    if(when_FpUnit_l88_360) begin
      _zz_when_FpUnit_l95_8 = 6'h1d;
    end
    if(when_FpUnit_l88_361) begin
      _zz_when_FpUnit_l95_8 = 6'h1e;
    end
    if(when_FpUnit_l88_362) begin
      _zz_when_FpUnit_l95_8 = 6'h1f;
    end
    if(when_FpUnit_l88_363) begin
      _zz_when_FpUnit_l95_8 = 6'h20;
    end
    if(when_FpUnit_l88_364) begin
      _zz_when_FpUnit_l95_8 = 6'h21;
    end
    if(when_FpUnit_l88_365) begin
      _zz_when_FpUnit_l95_8 = 6'h22;
    end
    if(when_FpUnit_l88_366) begin
      _zz_when_FpUnit_l95_8 = 6'h23;
    end
    if(when_FpUnit_l88_367) begin
      _zz_when_FpUnit_l95_8 = 6'h24;
    end
    if(when_FpUnit_l88_368) begin
      _zz_when_FpUnit_l95_8 = 6'h25;
    end
    if(when_FpUnit_l88_369) begin
      _zz_when_FpUnit_l95_8 = 6'h26;
    end
    if(when_FpUnit_l88_370) begin
      _zz_when_FpUnit_l95_8 = 6'h27;
    end
    if(when_FpUnit_l88_371) begin
      _zz_when_FpUnit_l95_8 = 6'h28;
    end
    if(when_FpUnit_l88_372) begin
      _zz_when_FpUnit_l95_8 = 6'h29;
    end
    if(when_FpUnit_l88_373) begin
      _zz_when_FpUnit_l95_8 = 6'h2a;
    end
    if(when_FpUnit_l88_374) begin
      _zz_when_FpUnit_l95_8 = 6'h2b;
    end
    if(when_FpUnit_l88_375) begin
      _zz_when_FpUnit_l95_8 = 6'h2c;
    end
    if(when_FpUnit_l88_376) begin
      _zz_when_FpUnit_l95_8 = 6'h2d;
    end
    if(when_FpUnit_l88_377) begin
      _zz_when_FpUnit_l95_8 = 6'h2e;
    end
    if(when_FpUnit_l88_378) begin
      _zz_when_FpUnit_l95_8 = 6'h2f;
    end
    if(when_FpUnit_l88_379) begin
      _zz_when_FpUnit_l95_8 = 6'h30;
    end
    if(when_FpUnit_l88_380) begin
      _zz_when_FpUnit_l95_8 = 6'h31;
    end
    if(when_FpUnit_l88_381) begin
      _zz_when_FpUnit_l95_8 = 6'h32;
    end
    if(when_FpUnit_l88_382) begin
      _zz_when_FpUnit_l95_8 = 6'h33;
    end
    if(when_FpUnit_l88_383) begin
      _zz_when_FpUnit_l95_8 = 6'h34;
    end
    if(when_FpUnit_l88_384) begin
      _zz_when_FpUnit_l95_8 = 6'h35;
    end
    if(when_FpUnit_l88_385) begin
      _zz_when_FpUnit_l95_8 = 6'h36;
    end
    if(when_FpUnit_l88_386) begin
      _zz_when_FpUnit_l95_8 = 6'h37;
    end
  end

  assign when_FpUnit_l88_331 = _zz_when_FpUnit_l88_167[0];
  assign when_FpUnit_l88_332 = _zz_when_FpUnit_l88_167[1];
  assign when_FpUnit_l88_333 = _zz_when_FpUnit_l88_167[2];
  assign when_FpUnit_l88_334 = _zz_when_FpUnit_l88_167[3];
  assign when_FpUnit_l88_335 = _zz_when_FpUnit_l88_167[4];
  assign when_FpUnit_l88_336 = _zz_when_FpUnit_l88_167[5];
  assign when_FpUnit_l88_337 = _zz_when_FpUnit_l88_167[6];
  assign when_FpUnit_l88_338 = _zz_when_FpUnit_l88_167[7];
  assign when_FpUnit_l88_339 = _zz_when_FpUnit_l88_167[8];
  assign when_FpUnit_l88_340 = _zz_when_FpUnit_l88_167[9];
  assign when_FpUnit_l88_341 = _zz_when_FpUnit_l88_167[10];
  assign when_FpUnit_l88_342 = _zz_when_FpUnit_l88_167[11];
  assign when_FpUnit_l88_343 = _zz_when_FpUnit_l88_167[12];
  assign when_FpUnit_l88_344 = _zz_when_FpUnit_l88_167[13];
  assign when_FpUnit_l88_345 = _zz_when_FpUnit_l88_167[14];
  assign when_FpUnit_l88_346 = _zz_when_FpUnit_l88_167[15];
  assign when_FpUnit_l88_347 = _zz_when_FpUnit_l88_167[16];
  assign when_FpUnit_l88_348 = _zz_when_FpUnit_l88_167[17];
  assign when_FpUnit_l88_349 = _zz_when_FpUnit_l88_167[18];
  assign when_FpUnit_l88_350 = _zz_when_FpUnit_l88_167[19];
  assign when_FpUnit_l88_351 = _zz_when_FpUnit_l88_167[20];
  assign when_FpUnit_l88_352 = _zz_when_FpUnit_l88_167[21];
  assign when_FpUnit_l88_353 = _zz_when_FpUnit_l88_167[22];
  assign when_FpUnit_l88_354 = _zz_when_FpUnit_l88_167[23];
  assign when_FpUnit_l88_355 = _zz_when_FpUnit_l88_167[24];
  assign when_FpUnit_l88_356 = _zz_when_FpUnit_l88_167[25];
  assign when_FpUnit_l88_357 = _zz_when_FpUnit_l88_167[26];
  assign when_FpUnit_l88_358 = _zz_when_FpUnit_l88_167[27];
  assign when_FpUnit_l88_359 = _zz_when_FpUnit_l88_167[28];
  assign when_FpUnit_l88_360 = _zz_when_FpUnit_l88_167[29];
  assign when_FpUnit_l88_361 = _zz_when_FpUnit_l88_167[30];
  assign when_FpUnit_l88_362 = _zz_when_FpUnit_l88_167[31];
  assign when_FpUnit_l88_363 = _zz_when_FpUnit_l88_167[32];
  assign when_FpUnit_l88_364 = _zz_when_FpUnit_l88_167[33];
  assign when_FpUnit_l88_365 = _zz_when_FpUnit_l88_167[34];
  assign when_FpUnit_l88_366 = _zz_when_FpUnit_l88_167[35];
  assign when_FpUnit_l88_367 = _zz_when_FpUnit_l88_167[36];
  assign when_FpUnit_l88_368 = _zz_when_FpUnit_l88_167[37];
  assign when_FpUnit_l88_369 = _zz_when_FpUnit_l88_167[38];
  assign when_FpUnit_l88_370 = _zz_when_FpUnit_l88_167[39];
  assign when_FpUnit_l88_371 = _zz_when_FpUnit_l88_167[40];
  assign when_FpUnit_l88_372 = _zz_when_FpUnit_l88_167[41];
  assign when_FpUnit_l88_373 = _zz_when_FpUnit_l88_167[42];
  assign when_FpUnit_l88_374 = _zz_when_FpUnit_l88_167[43];
  assign when_FpUnit_l88_375 = _zz_when_FpUnit_l88_167[44];
  assign when_FpUnit_l88_376 = _zz_when_FpUnit_l88_167[45];
  assign when_FpUnit_l88_377 = _zz_when_FpUnit_l88_167[46];
  assign when_FpUnit_l88_378 = _zz_when_FpUnit_l88_167[47];
  assign when_FpUnit_l88_379 = _zz_when_FpUnit_l88_167[48];
  assign when_FpUnit_l88_380 = _zz_when_FpUnit_l88_167[49];
  assign when_FpUnit_l88_381 = _zz_when_FpUnit_l88_167[50];
  assign when_FpUnit_l88_382 = _zz_when_FpUnit_l88_167[51];
  assign when_FpUnit_l88_383 = _zz_when_FpUnit_l88_167[52];
  assign when_FpUnit_l88_384 = _zz_when_FpUnit_l88_167[53];
  assign when_FpUnit_l88_385 = _zz_when_FpUnit_l88_167[54];
  assign when_FpUnit_l88_386 = _zz_when_FpUnit_l88_167[55];
  always @(*) begin
    _zz_flagUF_121 = 27'h0;
    if(when_FpUnit_l94_8) begin
      if(when_FpUnit_l95_8) begin
        _zz_flagUF_121 = _zz__zz_flagUF_121;
      end else begin
        _zz_flagUF_121 = _zz__zz_flagUF_121_2;
      end
    end
  end

  always @(*) begin
    _zz_flagUF_122 = 1'b0;
    if(when_FpUnit_l94_8) begin
      if(when_FpUnit_l95_8) begin
        _zz_flagUF_122 = (|(_zz_when_FpUnit_l88_167 & _zz__zz_flagUF_122));
      end else begin
        _zz_flagUF_122 = 1'b0;
      end
    end
  end

  assign _zz_flagUF_123 = ($signed(_zz__zz_flagUF_123) + $signed(_zz_when_FpUnit_l367_19));
  assign when_FpUnit_l94_8 = (_zz_when_FpUnit_l88_167 != 56'h0);
  assign when_FpUnit_l95_8 = (6'h1a < _zz_when_FpUnit_l95_8);
  assign _zz_flagUF_124 = (_zz_when_FpUnit_l95_8 - 6'h1a);
  assign _zz_flagUF_125 = _zz__zz_flagUF_125;
  assign _zz_flagUF_126 = _zz_flagUF_125;
  assign _zz_flagUF_127 = (((_zz_flagUF_122 || _zz_flagUF_119) || _zz_flagUF_120) || (|(_zz_flagUF_125 & 29'h0)));
  assign _zz_flagUF_128 = ($signed(_zz__zz_flagUF_128) < $signed(12'h001));
  assign _zz_when_FpUnit_l147_8 = (_zz_flagUF_128 ? _zz__zz_when_FpUnit_l147_8 : 12'h0);
  assign _zz_when_FpUnit_l150_8 = _zz_when_FpUnit_l147_8;
  assign when_FpUnit_l147_8 = ($signed(_zz_when_FpUnit_l147_8) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l147_8) begin
      _zz_flagUF_129 = _zz__zz_flagUF_129;
    end else begin
      if(when_FpUnit_l150_8) begin
        _zz_flagUF_129 = 27'h0;
      end else begin
        _zz_flagUF_129 = _zz__zz_flagUF_129_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l147_8) begin
      _zz_flagUF_130 = _zz_flagUF_127;
    end else begin
      if(when_FpUnit_l150_8) begin
        _zz_flagUF_130 = ((|_zz_flagUF_126) || _zz_flagUF_127);
      end else begin
        _zz_flagUF_130 = ((|(_zz_flagUF_126 & _zz__zz_flagUF_130)) || _zz_flagUF_127);
      end
    end
  end

  assign when_FpUnit_l150_8 = (12'h01b <= _zz_when_FpUnit_l150_8);
  assign _zz_when_FpUnit_l186_24 = (_zz_flagUF_128 ? 12'hf82 : _zz_flagUF_123);
  assign _zz_flagUF_131 = _zz_flagUF_129[2];
  assign _zz_flagUF_132 = _zz_flagUF_129[1];
  assign _zz_flagUF_133 = (_zz_flagUF_129[0] || _zz_flagUF_130);
  assign _zz_when_FpUnit_l190_24 = _zz_flagUF_129[26 : 3];
  assign _zz_when_FpUnit_l190_25 = (_zz__zz_when_FpUnit_l190_25 + _zz__zz_when_FpUnit_l190_25_2);
  assign _zz_when_FpUnit_l186_25 = _zz_when_FpUnit_l190_25[24];
  assign _zz_when_FpUnit_l190_26 = (_zz_when_FpUnit_l186_25 ? _zz__zz_when_FpUnit_l190_26 : _zz__zz_when_FpUnit_l190_26_1);
  assign _zz_when_FpUnit_l186_26 = ($signed(_zz__zz_when_FpUnit_l186_26) + $signed(12'h07f));
  assign _zz_flagUF_134 = ((_zz_flagUF_131 || _zz_flagUF_132) || _zz_flagUF_133);
  assign when_FpUnit_l186_8 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l186_26));
  assign _zz_res_49 = {_zz_when_FpUnit_l88_166,{8'hff,23'h0}};
  assign _zz_res_50 = {_zz_when_FpUnit_l88_166,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_51 = 32'h0;
    if(when_FpUnit_l186_8) begin
      _zz_res_51 = ((io_rm == 3'b001) ? _zz_res_50 : ((io_rm == 3'b010) ? (_zz_when_FpUnit_l88_166 ? _zz_res_49 : _zz_res_50) : ((io_rm == 3'b011) ? (_zz_when_FpUnit_l88_166 ? _zz_res_50 : _zz_res_49) : _zz_res_49)));
    end else begin
      if(when_FpUnit_l190_8) begin
        _zz_res_51 = {_zz_when_FpUnit_l88_166,{8'h0,23'h0}};
      end else begin
        if(when_FpUnit_l192_8) begin
          _zz_res_51 = {_zz_when_FpUnit_l88_166,{8'h0,_zz_when_FpUnit_l190_26[22 : 0]}};
        end else begin
          _zz_res_51 = {_zz_when_FpUnit_l88_166,{_zz__zz_res_51,_zz_when_FpUnit_l190_26[22 : 0]}};
        end
      end
    end
  end

  assign when_FpUnit_l190_8 = (_zz_flagUF_128 && (_zz_when_FpUnit_l190_26 == 24'h0));
  assign when_FpUnit_l192_8 = ((_zz_flagUF_128 && (_zz_when_FpUnit_l190_26 != 24'h0)) && (! _zz_when_FpUnit_l190_26[23]));
  always @(*) begin
    _zz_res_52 = _zz_res_51;
    if(when_FpUnit_l395_3) begin
      _zz_res_52 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l396_3) begin
        _zz_res_52 = 32'h7fc00000;
      end else begin
        if(when_FpUnit_l397_3) begin
          _zz_res_52 = 32'h7fc00000;
        end else begin
          if(when_FpUnit_l398_3) begin
            _zz_res_52 = {_zz_when_FpUnit_l397_7,{8'hff,23'h0}};
          end else begin
            if(when_FpUnit_l399) begin
              _zz_res_52 = {_zz_when_FpUnit_l397_8,{8'hff,23'h0}};
            end
          end
        end
      end
    end
  end

  assign when_FpUnit_l395_3 = ((when_FpUnit_l342 || when_FpUnit_l431) || _zz_when_FpUnit_l395);
  assign when_FpUnit_l396_3 = ((when_FpUnit_l244 && when_FpUnit_l305) || (when_FpUnit_l308 && when_FpUnit_l245));
  assign when_FpUnit_l397_3 = (((when_FpUnit_l244 || when_FpUnit_l245) && when_FpUnit_l399) && (_zz_when_FpUnit_l397_7 != _zz_when_FpUnit_l397_8));
  assign when_FpUnit_l398_3 = (when_FpUnit_l244 || when_FpUnit_l245);
  assign _zz_when_FpUnit_l485 = ($signed(_zz__zz_when_FpUnit_l485) - $signed(12'h017));
  assign when_FpUnit_l485 = ($signed(12'h022) <= $signed(_zz_when_FpUnit_l485));
  always @(*) begin
    if(when_FpUnit_l485) begin
      _zz_when_FpUnit_l512 = 34'h1ffffffff;
    end else begin
      if(when_FpUnit_l488) begin
        _zz_when_FpUnit_l512 = 34'h0;
      end else begin
        if(when_FpUnit_l491) begin
          _zz_when_FpUnit_l512 = {10'd0, _zz__zz_when_FpUnit_l512};
        end else begin
          _zz_when_FpUnit_l512 = _zz__zz_when_FpUnit_l512_1[33:0];
        end
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l485) begin
      _zz_flagNX = 1'b1;
    end else begin
      if(when_FpUnit_l488) begin
        _zz_flagNX = (_zz_when_FpUnit_l88 != 24'h0);
      end else begin
        if(when_FpUnit_l491) begin
          _zz_flagNX = ((_zz_when_FpUnit_l88 & _zz__zz_flagNX) != 24'h0);
        end else begin
          _zz_flagNX = 1'b0;
        end
      end
    end
  end

  assign _zz_flagNX_1 = _zz__zz_flagNX_1;
  assign when_FpUnit_l488 = ($signed(_zz_when_FpUnit_l485) <= $signed(12'hfe8));
  assign when_FpUnit_l491 = ($signed(_zz_when_FpUnit_l485) < $signed(12'h0));
  assign _zz_when_FpUnit_l512_1 = (_zz_when_FpUnit_l512 + _zz__zz_when_FpUnit_l512_1_1);
  assign when_FpUnit_l512 = (((when_FpUnit_l342 || when_FpUnit_l244) || (((! when_FpUnit_l342) && (! when_FpUnit_l244)) && (34'h080000000 < _zz_when_FpUnit_l512_1))) || 1'b0);
  always @(*) begin
    if(when_FpUnit_l512) begin
      _zz_res_53 = 32'h7fffffff;
      if(when_FpUnit_l517) begin
        _zz_res_53 = 32'h80000000;
      end
    end else begin
      if(when_FpUnit_l519) begin
        _zz_res_53 = (32'h0 - _zz__zz_res_53);
      end else begin
        _zz_res_53 = _zz_when_FpUnit_l512_1[31:0];
      end
    end
  end

  assign when_FpUnit_l517 = (when_FpUnit_l519 && (! when_FpUnit_l342));
  assign _zz_when_FpUnit_l485_1 = ($signed(_zz__zz_when_FpUnit_l485_1) - $signed(12'h017));
  assign when_FpUnit_l485_1 = ($signed(12'h022) <= $signed(_zz_when_FpUnit_l485_1));
  always @(*) begin
    if(when_FpUnit_l485_1) begin
      _zz_when_FpUnit_l512_2 = 34'h1ffffffff;
    end else begin
      if(when_FpUnit_l488_1) begin
        _zz_when_FpUnit_l512_2 = 34'h0;
      end else begin
        if(when_FpUnit_l491_1) begin
          _zz_when_FpUnit_l512_2 = {10'd0, _zz__zz_when_FpUnit_l512_2_1};
        end else begin
          _zz_when_FpUnit_l512_2 = _zz__zz_when_FpUnit_l512_2_2[33:0];
        end
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l485_1) begin
      _zz_flagNX_2 = 1'b1;
    end else begin
      if(when_FpUnit_l488_1) begin
        _zz_flagNX_2 = (_zz_when_FpUnit_l88 != 24'h0);
      end else begin
        if(when_FpUnit_l491_1) begin
          _zz_flagNX_2 = ((_zz_when_FpUnit_l88 & _zz__zz_flagNX_2_1) != 24'h0);
        end else begin
          _zz_flagNX_2 = 1'b0;
        end
      end
    end
  end

  assign _zz_flagNX_3 = _zz__zz_flagNX_3_1;
  assign when_FpUnit_l488_1 = ($signed(_zz_when_FpUnit_l485_1) <= $signed(12'hfe8));
  assign when_FpUnit_l491_1 = ($signed(_zz_when_FpUnit_l485_1) < $signed(12'h0));
  assign _zz_when_FpUnit_l512_3 = (_zz_when_FpUnit_l512_2 + _zz__zz_when_FpUnit_l512_3_1);
  assign when_FpUnit_l512_1 = (((when_FpUnit_l342 || when_FpUnit_l244) || (((! when_FpUnit_l342) && (! when_FpUnit_l244)) && (34'h0ffffffff < _zz_when_FpUnit_l512_3))) || ((when_FpUnit_l519 && (! when_FpUnit_l308)) && (! when_FpUnit_l342)));
  always @(*) begin
    if(when_FpUnit_l512_1) begin
      _zz_res_54 = 32'hffffffff;
      if(when_FpUnit_l517_1) begin
        _zz_res_54 = 32'h0;
      end
    end else begin
      if(when_FpUnit_l519) begin
        _zz_res_54 = (32'h0 - _zz__zz_res_54);
      end else begin
        _zz_res_54 = _zz_when_FpUnit_l512_3[31:0];
      end
    end
  end

  assign when_FpUnit_l517_1 = (when_FpUnit_l519 && (! when_FpUnit_l342));
  assign _zz_when_FpUnit_l485_2 = ($signed(_zz__zz_when_FpUnit_l485_2) - $signed(12'h017));
  assign when_FpUnit_l485_2 = ($signed(12'h042) <= $signed(_zz_when_FpUnit_l485_2));
  always @(*) begin
    if(when_FpUnit_l485_2) begin
      _zz_when_FpUnit_l512_4 = 66'h1ffffffffffffffff;
    end else begin
      if(when_FpUnit_l488_2) begin
        _zz_when_FpUnit_l512_4 = 66'h0;
      end else begin
        if(when_FpUnit_l491_2) begin
          _zz_when_FpUnit_l512_4 = {42'd0, _zz__zz_when_FpUnit_l512_4_1};
        end else begin
          _zz_when_FpUnit_l512_4 = _zz__zz_when_FpUnit_l512_4_2[65:0];
        end
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l485_2) begin
      _zz_flagNX_4 = 1'b1;
    end else begin
      if(when_FpUnit_l488_2) begin
        _zz_flagNX_4 = (_zz_when_FpUnit_l88 != 24'h0);
      end else begin
        if(when_FpUnit_l491_2) begin
          _zz_flagNX_4 = ((_zz_when_FpUnit_l88 & _zz__zz_flagNX_4_1) != 24'h0);
        end else begin
          _zz_flagNX_4 = 1'b0;
        end
      end
    end
  end

  assign _zz_flagNX_5 = _zz__zz_flagNX_5;
  assign when_FpUnit_l488_2 = ($signed(_zz_when_FpUnit_l485_2) <= $signed(12'hfe8));
  assign when_FpUnit_l491_2 = ($signed(_zz_when_FpUnit_l485_2) < $signed(12'h0));
  assign _zz_when_FpUnit_l512_5 = (_zz_when_FpUnit_l512_4 + _zz__zz_when_FpUnit_l512_5);
  assign when_FpUnit_l512_2 = (((when_FpUnit_l342 || when_FpUnit_l244) || (((! when_FpUnit_l342) && (! when_FpUnit_l244)) && (66'h08000000000000000 < _zz_when_FpUnit_l512_5))) || 1'b0);
  always @(*) begin
    if(when_FpUnit_l512_2) begin
      _zz_res_55 = 64'h7fffffffffffffff;
      if(when_FpUnit_l517_2) begin
        _zz_res_55 = 64'h8000000000000000;
      end
    end else begin
      if(when_FpUnit_l519) begin
        _zz_res_55 = (64'h0 - _zz__zz_res_55);
      end else begin
        _zz_res_55 = _zz_when_FpUnit_l512_5[63:0];
      end
    end
  end

  assign when_FpUnit_l517_2 = (when_FpUnit_l519 && (! when_FpUnit_l342));
  assign _zz_when_FpUnit_l485_3 = ($signed(_zz__zz_when_FpUnit_l485_3) - $signed(12'h017));
  assign when_FpUnit_l485_3 = ($signed(12'h042) <= $signed(_zz_when_FpUnit_l485_3));
  always @(*) begin
    if(when_FpUnit_l485_3) begin
      _zz_when_FpUnit_l512_6 = 66'h1ffffffffffffffff;
    end else begin
      if(when_FpUnit_l488_3) begin
        _zz_when_FpUnit_l512_6 = 66'h0;
      end else begin
        if(when_FpUnit_l491_3) begin
          _zz_when_FpUnit_l512_6 = {42'd0, _zz__zz_when_FpUnit_l512_6};
        end else begin
          _zz_when_FpUnit_l512_6 = _zz__zz_when_FpUnit_l512_6_1[65:0];
        end
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l485_3) begin
      _zz_flagNX_6 = 1'b1;
    end else begin
      if(when_FpUnit_l488_3) begin
        _zz_flagNX_6 = (_zz_when_FpUnit_l88 != 24'h0);
      end else begin
        if(when_FpUnit_l491_3) begin
          _zz_flagNX_6 = ((_zz_when_FpUnit_l88 & _zz__zz_flagNX_6) != 24'h0);
        end else begin
          _zz_flagNX_6 = 1'b0;
        end
      end
    end
  end

  assign _zz_flagNX_7 = _zz__zz_flagNX_7;
  assign when_FpUnit_l488_3 = ($signed(_zz_when_FpUnit_l485_3) <= $signed(12'hfe8));
  assign when_FpUnit_l491_3 = ($signed(_zz_when_FpUnit_l485_3) < $signed(12'h0));
  assign _zz_when_FpUnit_l512_7 = (_zz_when_FpUnit_l512_6 + _zz__zz_when_FpUnit_l512_7);
  assign when_FpUnit_l512_3 = (((when_FpUnit_l342 || when_FpUnit_l244) || (((! when_FpUnit_l342) && (! when_FpUnit_l244)) && (66'h0ffffffffffffffff < _zz_when_FpUnit_l512_7))) || ((when_FpUnit_l519 && (! when_FpUnit_l308)) && (! when_FpUnit_l342)));
  always @(*) begin
    if(when_FpUnit_l512_3) begin
      _zz_res_56 = 64'hffffffffffffffff;
      if(when_FpUnit_l517_3) begin
        _zz_res_56 = 64'h0;
      end
    end else begin
      if(when_FpUnit_l519) begin
        _zz_res_56 = (64'h0 - _zz__zz_res_56);
      end else begin
        _zz_res_56 = _zz_when_FpUnit_l512_7[63:0];
      end
    end
  end

  assign when_FpUnit_l517_3 = (when_FpUnit_l519 && (! when_FpUnit_l342));
  assign _zz_res_57 = io_a[31];
  assign _zz_when_FpUnit_l88_168 = io_a[31 : 0];
  assign _zz_when_FpUnit_l88_169 = (_zz_res_57 ? _zz__zz_when_FpUnit_l88_169 : _zz__zz_when_FpUnit_l88_169_2);
  always @(*) begin
    _zz_when_FpUnit_l95_9 = 6'h0;
    if(when_FpUnit_l88_387) begin
      _zz_when_FpUnit_l95_9 = 6'h0;
    end
    if(when_FpUnit_l88_388) begin
      _zz_when_FpUnit_l95_9 = 6'h01;
    end
    if(when_FpUnit_l88_389) begin
      _zz_when_FpUnit_l95_9 = 6'h02;
    end
    if(when_FpUnit_l88_390) begin
      _zz_when_FpUnit_l95_9 = 6'h03;
    end
    if(when_FpUnit_l88_391) begin
      _zz_when_FpUnit_l95_9 = 6'h04;
    end
    if(when_FpUnit_l88_392) begin
      _zz_when_FpUnit_l95_9 = 6'h05;
    end
    if(when_FpUnit_l88_393) begin
      _zz_when_FpUnit_l95_9 = 6'h06;
    end
    if(when_FpUnit_l88_394) begin
      _zz_when_FpUnit_l95_9 = 6'h07;
    end
    if(when_FpUnit_l88_395) begin
      _zz_when_FpUnit_l95_9 = 6'h08;
    end
    if(when_FpUnit_l88_396) begin
      _zz_when_FpUnit_l95_9 = 6'h09;
    end
    if(when_FpUnit_l88_397) begin
      _zz_when_FpUnit_l95_9 = 6'h0a;
    end
    if(when_FpUnit_l88_398) begin
      _zz_when_FpUnit_l95_9 = 6'h0b;
    end
    if(when_FpUnit_l88_399) begin
      _zz_when_FpUnit_l95_9 = 6'h0c;
    end
    if(when_FpUnit_l88_400) begin
      _zz_when_FpUnit_l95_9 = 6'h0d;
    end
    if(when_FpUnit_l88_401) begin
      _zz_when_FpUnit_l95_9 = 6'h0e;
    end
    if(when_FpUnit_l88_402) begin
      _zz_when_FpUnit_l95_9 = 6'h0f;
    end
    if(when_FpUnit_l88_403) begin
      _zz_when_FpUnit_l95_9 = 6'h10;
    end
    if(when_FpUnit_l88_404) begin
      _zz_when_FpUnit_l95_9 = 6'h11;
    end
    if(when_FpUnit_l88_405) begin
      _zz_when_FpUnit_l95_9 = 6'h12;
    end
    if(when_FpUnit_l88_406) begin
      _zz_when_FpUnit_l95_9 = 6'h13;
    end
    if(when_FpUnit_l88_407) begin
      _zz_when_FpUnit_l95_9 = 6'h14;
    end
    if(when_FpUnit_l88_408) begin
      _zz_when_FpUnit_l95_9 = 6'h15;
    end
    if(when_FpUnit_l88_409) begin
      _zz_when_FpUnit_l95_9 = 6'h16;
    end
    if(when_FpUnit_l88_410) begin
      _zz_when_FpUnit_l95_9 = 6'h17;
    end
    if(when_FpUnit_l88_411) begin
      _zz_when_FpUnit_l95_9 = 6'h18;
    end
    if(when_FpUnit_l88_412) begin
      _zz_when_FpUnit_l95_9 = 6'h19;
    end
    if(when_FpUnit_l88_413) begin
      _zz_when_FpUnit_l95_9 = 6'h1a;
    end
    if(when_FpUnit_l88_414) begin
      _zz_when_FpUnit_l95_9 = 6'h1b;
    end
    if(when_FpUnit_l88_415) begin
      _zz_when_FpUnit_l95_9 = 6'h1c;
    end
    if(when_FpUnit_l88_416) begin
      _zz_when_FpUnit_l95_9 = 6'h1d;
    end
    if(when_FpUnit_l88_417) begin
      _zz_when_FpUnit_l95_9 = 6'h1e;
    end
    if(when_FpUnit_l88_418) begin
      _zz_when_FpUnit_l95_9 = 6'h1f;
    end
    if(when_FpUnit_l88_419) begin
      _zz_when_FpUnit_l95_9 = 6'h20;
    end
    if(when_FpUnit_l88_420) begin
      _zz_when_FpUnit_l95_9 = 6'h21;
    end
    if(when_FpUnit_l88_421) begin
      _zz_when_FpUnit_l95_9 = 6'h22;
    end
    if(when_FpUnit_l88_422) begin
      _zz_when_FpUnit_l95_9 = 6'h23;
    end
    if(when_FpUnit_l88_423) begin
      _zz_when_FpUnit_l95_9 = 6'h24;
    end
    if(when_FpUnit_l88_424) begin
      _zz_when_FpUnit_l95_9 = 6'h25;
    end
    if(when_FpUnit_l88_425) begin
      _zz_when_FpUnit_l95_9 = 6'h26;
    end
    if(when_FpUnit_l88_426) begin
      _zz_when_FpUnit_l95_9 = 6'h27;
    end
    if(when_FpUnit_l88_427) begin
      _zz_when_FpUnit_l95_9 = 6'h28;
    end
    if(when_FpUnit_l88_428) begin
      _zz_when_FpUnit_l95_9 = 6'h29;
    end
    if(when_FpUnit_l88_429) begin
      _zz_when_FpUnit_l95_9 = 6'h2a;
    end
    if(when_FpUnit_l88_430) begin
      _zz_when_FpUnit_l95_9 = 6'h2b;
    end
    if(when_FpUnit_l88_431) begin
      _zz_when_FpUnit_l95_9 = 6'h2c;
    end
    if(when_FpUnit_l88_432) begin
      _zz_when_FpUnit_l95_9 = 6'h2d;
    end
    if(when_FpUnit_l88_433) begin
      _zz_when_FpUnit_l95_9 = 6'h2e;
    end
    if(when_FpUnit_l88_434) begin
      _zz_when_FpUnit_l95_9 = 6'h2f;
    end
    if(when_FpUnit_l88_435) begin
      _zz_when_FpUnit_l95_9 = 6'h30;
    end
    if(when_FpUnit_l88_436) begin
      _zz_when_FpUnit_l95_9 = 6'h31;
    end
    if(when_FpUnit_l88_437) begin
      _zz_when_FpUnit_l95_9 = 6'h32;
    end
    if(when_FpUnit_l88_438) begin
      _zz_when_FpUnit_l95_9 = 6'h33;
    end
    if(when_FpUnit_l88_439) begin
      _zz_when_FpUnit_l95_9 = 6'h34;
    end
    if(when_FpUnit_l88_440) begin
      _zz_when_FpUnit_l95_9 = 6'h35;
    end
    if(when_FpUnit_l88_441) begin
      _zz_when_FpUnit_l95_9 = 6'h36;
    end
    if(when_FpUnit_l88_442) begin
      _zz_when_FpUnit_l95_9 = 6'h37;
    end
  end

  assign when_FpUnit_l88_387 = _zz_when_FpUnit_l88_169[0];
  assign when_FpUnit_l88_388 = _zz_when_FpUnit_l88_169[1];
  assign when_FpUnit_l88_389 = _zz_when_FpUnit_l88_169[2];
  assign when_FpUnit_l88_390 = _zz_when_FpUnit_l88_169[3];
  assign when_FpUnit_l88_391 = _zz_when_FpUnit_l88_169[4];
  assign when_FpUnit_l88_392 = _zz_when_FpUnit_l88_169[5];
  assign when_FpUnit_l88_393 = _zz_when_FpUnit_l88_169[6];
  assign when_FpUnit_l88_394 = _zz_when_FpUnit_l88_169[7];
  assign when_FpUnit_l88_395 = _zz_when_FpUnit_l88_169[8];
  assign when_FpUnit_l88_396 = _zz_when_FpUnit_l88_169[9];
  assign when_FpUnit_l88_397 = _zz_when_FpUnit_l88_169[10];
  assign when_FpUnit_l88_398 = _zz_when_FpUnit_l88_169[11];
  assign when_FpUnit_l88_399 = _zz_when_FpUnit_l88_169[12];
  assign when_FpUnit_l88_400 = _zz_when_FpUnit_l88_169[13];
  assign when_FpUnit_l88_401 = _zz_when_FpUnit_l88_169[14];
  assign when_FpUnit_l88_402 = _zz_when_FpUnit_l88_169[15];
  assign when_FpUnit_l88_403 = _zz_when_FpUnit_l88_169[16];
  assign when_FpUnit_l88_404 = _zz_when_FpUnit_l88_169[17];
  assign when_FpUnit_l88_405 = _zz_when_FpUnit_l88_169[18];
  assign when_FpUnit_l88_406 = _zz_when_FpUnit_l88_169[19];
  assign when_FpUnit_l88_407 = _zz_when_FpUnit_l88_169[20];
  assign when_FpUnit_l88_408 = _zz_when_FpUnit_l88_169[21];
  assign when_FpUnit_l88_409 = _zz_when_FpUnit_l88_169[22];
  assign when_FpUnit_l88_410 = _zz_when_FpUnit_l88_169[23];
  assign when_FpUnit_l88_411 = _zz_when_FpUnit_l88_169[24];
  assign when_FpUnit_l88_412 = _zz_when_FpUnit_l88_169[25];
  assign when_FpUnit_l88_413 = _zz_when_FpUnit_l88_169[26];
  assign when_FpUnit_l88_414 = _zz_when_FpUnit_l88_169[27];
  assign when_FpUnit_l88_415 = _zz_when_FpUnit_l88_169[28];
  assign when_FpUnit_l88_416 = _zz_when_FpUnit_l88_169[29];
  assign when_FpUnit_l88_417 = _zz_when_FpUnit_l88_169[30];
  assign when_FpUnit_l88_418 = _zz_when_FpUnit_l88_169[31];
  assign when_FpUnit_l88_419 = _zz_when_FpUnit_l88_169[32];
  assign when_FpUnit_l88_420 = _zz_when_FpUnit_l88_169[33];
  assign when_FpUnit_l88_421 = _zz_when_FpUnit_l88_169[34];
  assign when_FpUnit_l88_422 = _zz_when_FpUnit_l88_169[35];
  assign when_FpUnit_l88_423 = _zz_when_FpUnit_l88_169[36];
  assign when_FpUnit_l88_424 = _zz_when_FpUnit_l88_169[37];
  assign when_FpUnit_l88_425 = _zz_when_FpUnit_l88_169[38];
  assign when_FpUnit_l88_426 = _zz_when_FpUnit_l88_169[39];
  assign when_FpUnit_l88_427 = _zz_when_FpUnit_l88_169[40];
  assign when_FpUnit_l88_428 = _zz_when_FpUnit_l88_169[41];
  assign when_FpUnit_l88_429 = _zz_when_FpUnit_l88_169[42];
  assign when_FpUnit_l88_430 = _zz_when_FpUnit_l88_169[43];
  assign when_FpUnit_l88_431 = _zz_when_FpUnit_l88_169[44];
  assign when_FpUnit_l88_432 = _zz_when_FpUnit_l88_169[45];
  assign when_FpUnit_l88_433 = _zz_when_FpUnit_l88_169[46];
  assign when_FpUnit_l88_434 = _zz_when_FpUnit_l88_169[47];
  assign when_FpUnit_l88_435 = _zz_when_FpUnit_l88_169[48];
  assign when_FpUnit_l88_436 = _zz_when_FpUnit_l88_169[49];
  assign when_FpUnit_l88_437 = _zz_when_FpUnit_l88_169[50];
  assign when_FpUnit_l88_438 = _zz_when_FpUnit_l88_169[51];
  assign when_FpUnit_l88_439 = _zz_when_FpUnit_l88_169[52];
  assign when_FpUnit_l88_440 = _zz_when_FpUnit_l88_169[53];
  assign when_FpUnit_l88_441 = _zz_when_FpUnit_l88_169[54];
  assign when_FpUnit_l88_442 = _zz_when_FpUnit_l88_169[55];
  always @(*) begin
    _zz_flagNX_8 = 27'h0;
    if(when_FpUnit_l94_9) begin
      if(when_FpUnit_l95_9) begin
        _zz_flagNX_8 = _zz__zz_flagNX_8;
      end else begin
        _zz_flagNX_8 = _zz__zz_flagNX_8_2;
      end
    end
  end

  always @(*) begin
    _zz_flagNX_9 = 1'b0;
    if(when_FpUnit_l94_9) begin
      if(when_FpUnit_l95_9) begin
        _zz_flagNX_9 = (|(_zz_when_FpUnit_l88_169 & _zz__zz_flagNX_9));
      end else begin
        _zz_flagNX_9 = 1'b0;
      end
    end
  end

  assign _zz_when_FpUnit_l147_9 = ($signed(_zz__zz_when_FpUnit_l147_9) + $signed(12'h0));
  assign when_FpUnit_l94_9 = (_zz_when_FpUnit_l88_169 != 56'h0);
  assign when_FpUnit_l95_9 = (6'h1a < _zz_when_FpUnit_l95_9);
  assign _zz_flagNX_10 = (_zz_when_FpUnit_l95_9 - 6'h1a);
  assign _zz_flagNX_11 = _zz__zz_flagNX_11;
  assign _zz_flagNX_12 = _zz_flagNX_11;
  assign _zz_flagNX_13 = (_zz_flagNX_9 || (|(_zz_flagNX_11 & 29'h0)));
  assign _zz_when_FpUnit_l190_27 = ($signed(_zz__zz_when_FpUnit_l190_27) < $signed(12'h001));
  assign _zz_when_FpUnit_l147_10 = (_zz_when_FpUnit_l190_27 ? _zz__zz_when_FpUnit_l147_10 : 12'h0);
  assign _zz_when_FpUnit_l150_9 = _zz_when_FpUnit_l147_10;
  assign when_FpUnit_l147_9 = ($signed(_zz_when_FpUnit_l147_10) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l147_9) begin
      _zz_flagNX_14 = _zz__zz_flagNX_14;
    end else begin
      if(when_FpUnit_l150_9) begin
        _zz_flagNX_14 = 27'h0;
      end else begin
        _zz_flagNX_14 = _zz__zz_flagNX_14_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l147_9) begin
      _zz_flagNX_15 = _zz_flagNX_13;
    end else begin
      if(when_FpUnit_l150_9) begin
        _zz_flagNX_15 = ((|_zz_flagNX_12) || _zz_flagNX_13);
      end else begin
        _zz_flagNX_15 = ((|(_zz_flagNX_12 & _zz__zz_flagNX_15)) || _zz_flagNX_13);
      end
    end
  end

  assign when_FpUnit_l150_9 = (12'h01b <= _zz_when_FpUnit_l150_9);
  assign _zz_when_FpUnit_l186_27 = (_zz_when_FpUnit_l190_27 ? 12'hf82 : _zz_when_FpUnit_l147_9);
  assign _zz_flagNX_16 = _zz_flagNX_14[2];
  assign _zz_flagNX_17 = _zz_flagNX_14[1];
  assign _zz_flagNX_18 = (_zz_flagNX_14[0] || _zz_flagNX_15);
  assign _zz_when_FpUnit_l190_28 = _zz_flagNX_14[26 : 3];
  assign _zz_when_FpUnit_l190_29 = (_zz__zz_when_FpUnit_l190_29 + _zz__zz_when_FpUnit_l190_29_2);
  assign _zz_when_FpUnit_l186_28 = _zz_when_FpUnit_l190_29[24];
  assign _zz_when_FpUnit_l190_30 = (_zz_when_FpUnit_l186_28 ? _zz__zz_when_FpUnit_l190_30 : _zz__zz_when_FpUnit_l190_30_1);
  assign _zz_when_FpUnit_l186_29 = ($signed(_zz__zz_when_FpUnit_l186_29) + $signed(12'h07f));
  assign when_FpUnit_l186_9 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l186_29));
  assign _zz_res_58 = {_zz_res_57,{8'hff,23'h0}};
  assign _zz_res_59 = {_zz_res_57,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_60 = 32'h0;
    if(when_FpUnit_l186_9) begin
      _zz_res_60 = ((io_rm == 3'b001) ? _zz_res_59 : ((io_rm == 3'b010) ? (_zz_res_57 ? _zz_res_58 : _zz_res_59) : ((io_rm == 3'b011) ? (_zz_res_57 ? _zz_res_59 : _zz_res_58) : _zz_res_58)));
    end else begin
      if(when_FpUnit_l190_9) begin
        _zz_res_60 = {_zz_res_57,{8'h0,23'h0}};
      end else begin
        if(when_FpUnit_l192_9) begin
          _zz_res_60 = {_zz_res_57,{8'h0,_zz_when_FpUnit_l190_30[22 : 0]}};
        end else begin
          _zz_res_60 = {_zz_res_57,{_zz__zz_res_60,_zz_when_FpUnit_l190_30[22 : 0]}};
        end
      end
    end
  end

  assign when_FpUnit_l190_9 = (_zz_when_FpUnit_l190_27 && (_zz_when_FpUnit_l190_30 == 24'h0));
  assign when_FpUnit_l192_9 = ((_zz_when_FpUnit_l190_27 && (_zz_when_FpUnit_l190_30 != 24'h0)) && (! _zz_when_FpUnit_l190_30[23]));
  always @(*) begin
    _zz_res_61 = _zz_res_60;
    if(when_FpUnit_l536) begin
      _zz_res_61 = {_zz_res_57,{8'h0,23'h0}};
    end
  end

  assign when_FpUnit_l536 = (_zz_when_FpUnit_l88_169 == 56'h0);
  assign _zz_res_62 = 1'b0;
  assign _zz_when_FpUnit_l88_170 = io_a[31 : 0];
  assign _zz_when_FpUnit_l88_171 = (_zz_res_62 ? _zz__zz_when_FpUnit_l88_171 : _zz__zz_when_FpUnit_l88_171_2);
  always @(*) begin
    _zz_when_FpUnit_l95_10 = 6'h0;
    if(when_FpUnit_l88_443) begin
      _zz_when_FpUnit_l95_10 = 6'h0;
    end
    if(when_FpUnit_l88_444) begin
      _zz_when_FpUnit_l95_10 = 6'h01;
    end
    if(when_FpUnit_l88_445) begin
      _zz_when_FpUnit_l95_10 = 6'h02;
    end
    if(when_FpUnit_l88_446) begin
      _zz_when_FpUnit_l95_10 = 6'h03;
    end
    if(when_FpUnit_l88_447) begin
      _zz_when_FpUnit_l95_10 = 6'h04;
    end
    if(when_FpUnit_l88_448) begin
      _zz_when_FpUnit_l95_10 = 6'h05;
    end
    if(when_FpUnit_l88_449) begin
      _zz_when_FpUnit_l95_10 = 6'h06;
    end
    if(when_FpUnit_l88_450) begin
      _zz_when_FpUnit_l95_10 = 6'h07;
    end
    if(when_FpUnit_l88_451) begin
      _zz_when_FpUnit_l95_10 = 6'h08;
    end
    if(when_FpUnit_l88_452) begin
      _zz_when_FpUnit_l95_10 = 6'h09;
    end
    if(when_FpUnit_l88_453) begin
      _zz_when_FpUnit_l95_10 = 6'h0a;
    end
    if(when_FpUnit_l88_454) begin
      _zz_when_FpUnit_l95_10 = 6'h0b;
    end
    if(when_FpUnit_l88_455) begin
      _zz_when_FpUnit_l95_10 = 6'h0c;
    end
    if(when_FpUnit_l88_456) begin
      _zz_when_FpUnit_l95_10 = 6'h0d;
    end
    if(when_FpUnit_l88_457) begin
      _zz_when_FpUnit_l95_10 = 6'h0e;
    end
    if(when_FpUnit_l88_458) begin
      _zz_when_FpUnit_l95_10 = 6'h0f;
    end
    if(when_FpUnit_l88_459) begin
      _zz_when_FpUnit_l95_10 = 6'h10;
    end
    if(when_FpUnit_l88_460) begin
      _zz_when_FpUnit_l95_10 = 6'h11;
    end
    if(when_FpUnit_l88_461) begin
      _zz_when_FpUnit_l95_10 = 6'h12;
    end
    if(when_FpUnit_l88_462) begin
      _zz_when_FpUnit_l95_10 = 6'h13;
    end
    if(when_FpUnit_l88_463) begin
      _zz_when_FpUnit_l95_10 = 6'h14;
    end
    if(when_FpUnit_l88_464) begin
      _zz_when_FpUnit_l95_10 = 6'h15;
    end
    if(when_FpUnit_l88_465) begin
      _zz_when_FpUnit_l95_10 = 6'h16;
    end
    if(when_FpUnit_l88_466) begin
      _zz_when_FpUnit_l95_10 = 6'h17;
    end
    if(when_FpUnit_l88_467) begin
      _zz_when_FpUnit_l95_10 = 6'h18;
    end
    if(when_FpUnit_l88_468) begin
      _zz_when_FpUnit_l95_10 = 6'h19;
    end
    if(when_FpUnit_l88_469) begin
      _zz_when_FpUnit_l95_10 = 6'h1a;
    end
    if(when_FpUnit_l88_470) begin
      _zz_when_FpUnit_l95_10 = 6'h1b;
    end
    if(when_FpUnit_l88_471) begin
      _zz_when_FpUnit_l95_10 = 6'h1c;
    end
    if(when_FpUnit_l88_472) begin
      _zz_when_FpUnit_l95_10 = 6'h1d;
    end
    if(when_FpUnit_l88_473) begin
      _zz_when_FpUnit_l95_10 = 6'h1e;
    end
    if(when_FpUnit_l88_474) begin
      _zz_when_FpUnit_l95_10 = 6'h1f;
    end
    if(when_FpUnit_l88_475) begin
      _zz_when_FpUnit_l95_10 = 6'h20;
    end
    if(when_FpUnit_l88_476) begin
      _zz_when_FpUnit_l95_10 = 6'h21;
    end
    if(when_FpUnit_l88_477) begin
      _zz_when_FpUnit_l95_10 = 6'h22;
    end
    if(when_FpUnit_l88_478) begin
      _zz_when_FpUnit_l95_10 = 6'h23;
    end
    if(when_FpUnit_l88_479) begin
      _zz_when_FpUnit_l95_10 = 6'h24;
    end
    if(when_FpUnit_l88_480) begin
      _zz_when_FpUnit_l95_10 = 6'h25;
    end
    if(when_FpUnit_l88_481) begin
      _zz_when_FpUnit_l95_10 = 6'h26;
    end
    if(when_FpUnit_l88_482) begin
      _zz_when_FpUnit_l95_10 = 6'h27;
    end
    if(when_FpUnit_l88_483) begin
      _zz_when_FpUnit_l95_10 = 6'h28;
    end
    if(when_FpUnit_l88_484) begin
      _zz_when_FpUnit_l95_10 = 6'h29;
    end
    if(when_FpUnit_l88_485) begin
      _zz_when_FpUnit_l95_10 = 6'h2a;
    end
    if(when_FpUnit_l88_486) begin
      _zz_when_FpUnit_l95_10 = 6'h2b;
    end
    if(when_FpUnit_l88_487) begin
      _zz_when_FpUnit_l95_10 = 6'h2c;
    end
    if(when_FpUnit_l88_488) begin
      _zz_when_FpUnit_l95_10 = 6'h2d;
    end
    if(when_FpUnit_l88_489) begin
      _zz_when_FpUnit_l95_10 = 6'h2e;
    end
    if(when_FpUnit_l88_490) begin
      _zz_when_FpUnit_l95_10 = 6'h2f;
    end
    if(when_FpUnit_l88_491) begin
      _zz_when_FpUnit_l95_10 = 6'h30;
    end
    if(when_FpUnit_l88_492) begin
      _zz_when_FpUnit_l95_10 = 6'h31;
    end
    if(when_FpUnit_l88_493) begin
      _zz_when_FpUnit_l95_10 = 6'h32;
    end
    if(when_FpUnit_l88_494) begin
      _zz_when_FpUnit_l95_10 = 6'h33;
    end
    if(when_FpUnit_l88_495) begin
      _zz_when_FpUnit_l95_10 = 6'h34;
    end
    if(when_FpUnit_l88_496) begin
      _zz_when_FpUnit_l95_10 = 6'h35;
    end
    if(when_FpUnit_l88_497) begin
      _zz_when_FpUnit_l95_10 = 6'h36;
    end
    if(when_FpUnit_l88_498) begin
      _zz_when_FpUnit_l95_10 = 6'h37;
    end
  end

  assign when_FpUnit_l88_443 = _zz_when_FpUnit_l88_171[0];
  assign when_FpUnit_l88_444 = _zz_when_FpUnit_l88_171[1];
  assign when_FpUnit_l88_445 = _zz_when_FpUnit_l88_171[2];
  assign when_FpUnit_l88_446 = _zz_when_FpUnit_l88_171[3];
  assign when_FpUnit_l88_447 = _zz_when_FpUnit_l88_171[4];
  assign when_FpUnit_l88_448 = _zz_when_FpUnit_l88_171[5];
  assign when_FpUnit_l88_449 = _zz_when_FpUnit_l88_171[6];
  assign when_FpUnit_l88_450 = _zz_when_FpUnit_l88_171[7];
  assign when_FpUnit_l88_451 = _zz_when_FpUnit_l88_171[8];
  assign when_FpUnit_l88_452 = _zz_when_FpUnit_l88_171[9];
  assign when_FpUnit_l88_453 = _zz_when_FpUnit_l88_171[10];
  assign when_FpUnit_l88_454 = _zz_when_FpUnit_l88_171[11];
  assign when_FpUnit_l88_455 = _zz_when_FpUnit_l88_171[12];
  assign when_FpUnit_l88_456 = _zz_when_FpUnit_l88_171[13];
  assign when_FpUnit_l88_457 = _zz_when_FpUnit_l88_171[14];
  assign when_FpUnit_l88_458 = _zz_when_FpUnit_l88_171[15];
  assign when_FpUnit_l88_459 = _zz_when_FpUnit_l88_171[16];
  assign when_FpUnit_l88_460 = _zz_when_FpUnit_l88_171[17];
  assign when_FpUnit_l88_461 = _zz_when_FpUnit_l88_171[18];
  assign when_FpUnit_l88_462 = _zz_when_FpUnit_l88_171[19];
  assign when_FpUnit_l88_463 = _zz_when_FpUnit_l88_171[20];
  assign when_FpUnit_l88_464 = _zz_when_FpUnit_l88_171[21];
  assign when_FpUnit_l88_465 = _zz_when_FpUnit_l88_171[22];
  assign when_FpUnit_l88_466 = _zz_when_FpUnit_l88_171[23];
  assign when_FpUnit_l88_467 = _zz_when_FpUnit_l88_171[24];
  assign when_FpUnit_l88_468 = _zz_when_FpUnit_l88_171[25];
  assign when_FpUnit_l88_469 = _zz_when_FpUnit_l88_171[26];
  assign when_FpUnit_l88_470 = _zz_when_FpUnit_l88_171[27];
  assign when_FpUnit_l88_471 = _zz_when_FpUnit_l88_171[28];
  assign when_FpUnit_l88_472 = _zz_when_FpUnit_l88_171[29];
  assign when_FpUnit_l88_473 = _zz_when_FpUnit_l88_171[30];
  assign when_FpUnit_l88_474 = _zz_when_FpUnit_l88_171[31];
  assign when_FpUnit_l88_475 = _zz_when_FpUnit_l88_171[32];
  assign when_FpUnit_l88_476 = _zz_when_FpUnit_l88_171[33];
  assign when_FpUnit_l88_477 = _zz_when_FpUnit_l88_171[34];
  assign when_FpUnit_l88_478 = _zz_when_FpUnit_l88_171[35];
  assign when_FpUnit_l88_479 = _zz_when_FpUnit_l88_171[36];
  assign when_FpUnit_l88_480 = _zz_when_FpUnit_l88_171[37];
  assign when_FpUnit_l88_481 = _zz_when_FpUnit_l88_171[38];
  assign when_FpUnit_l88_482 = _zz_when_FpUnit_l88_171[39];
  assign when_FpUnit_l88_483 = _zz_when_FpUnit_l88_171[40];
  assign when_FpUnit_l88_484 = _zz_when_FpUnit_l88_171[41];
  assign when_FpUnit_l88_485 = _zz_when_FpUnit_l88_171[42];
  assign when_FpUnit_l88_486 = _zz_when_FpUnit_l88_171[43];
  assign when_FpUnit_l88_487 = _zz_when_FpUnit_l88_171[44];
  assign when_FpUnit_l88_488 = _zz_when_FpUnit_l88_171[45];
  assign when_FpUnit_l88_489 = _zz_when_FpUnit_l88_171[46];
  assign when_FpUnit_l88_490 = _zz_when_FpUnit_l88_171[47];
  assign when_FpUnit_l88_491 = _zz_when_FpUnit_l88_171[48];
  assign when_FpUnit_l88_492 = _zz_when_FpUnit_l88_171[49];
  assign when_FpUnit_l88_493 = _zz_when_FpUnit_l88_171[50];
  assign when_FpUnit_l88_494 = _zz_when_FpUnit_l88_171[51];
  assign when_FpUnit_l88_495 = _zz_when_FpUnit_l88_171[52];
  assign when_FpUnit_l88_496 = _zz_when_FpUnit_l88_171[53];
  assign when_FpUnit_l88_497 = _zz_when_FpUnit_l88_171[54];
  assign when_FpUnit_l88_498 = _zz_when_FpUnit_l88_171[55];
  always @(*) begin
    _zz_flagNX_19 = 27'h0;
    if(when_FpUnit_l94_10) begin
      if(when_FpUnit_l95_10) begin
        _zz_flagNX_19 = _zz__zz_flagNX_19;
      end else begin
        _zz_flagNX_19 = _zz__zz_flagNX_19_2;
      end
    end
  end

  always @(*) begin
    _zz_flagNX_20 = 1'b0;
    if(when_FpUnit_l94_10) begin
      if(when_FpUnit_l95_10) begin
        _zz_flagNX_20 = (|(_zz_when_FpUnit_l88_171 & _zz__zz_flagNX_20));
      end else begin
        _zz_flagNX_20 = 1'b0;
      end
    end
  end

  assign _zz_when_FpUnit_l147_11 = ($signed(_zz__zz_when_FpUnit_l147_11) + $signed(12'h0));
  assign when_FpUnit_l94_10 = (_zz_when_FpUnit_l88_171 != 56'h0);
  assign when_FpUnit_l95_10 = (6'h1a < _zz_when_FpUnit_l95_10);
  assign _zz_flagNX_21 = (_zz_when_FpUnit_l95_10 - 6'h1a);
  assign _zz_flagNX_22 = _zz__zz_flagNX_22;
  assign _zz_flagNX_23 = _zz_flagNX_22;
  assign _zz_flagNX_24 = (_zz_flagNX_20 || (|(_zz_flagNX_22 & 29'h0)));
  assign _zz_when_FpUnit_l190_31 = ($signed(_zz__zz_when_FpUnit_l190_31) < $signed(12'h001));
  assign _zz_when_FpUnit_l147_12 = (_zz_when_FpUnit_l190_31 ? _zz__zz_when_FpUnit_l147_12 : 12'h0);
  assign _zz_when_FpUnit_l150_10 = _zz_when_FpUnit_l147_12;
  assign when_FpUnit_l147_10 = ($signed(_zz_when_FpUnit_l147_12) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l147_10) begin
      _zz_flagNX_25 = _zz__zz_flagNX_25;
    end else begin
      if(when_FpUnit_l150_10) begin
        _zz_flagNX_25 = 27'h0;
      end else begin
        _zz_flagNX_25 = _zz__zz_flagNX_25_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l147_10) begin
      _zz_flagNX_26 = _zz_flagNX_24;
    end else begin
      if(when_FpUnit_l150_10) begin
        _zz_flagNX_26 = ((|_zz_flagNX_23) || _zz_flagNX_24);
      end else begin
        _zz_flagNX_26 = ((|(_zz_flagNX_23 & _zz__zz_flagNX_26)) || _zz_flagNX_24);
      end
    end
  end

  assign when_FpUnit_l150_10 = (12'h01b <= _zz_when_FpUnit_l150_10);
  assign _zz_when_FpUnit_l186_30 = (_zz_when_FpUnit_l190_31 ? 12'hf82 : _zz_when_FpUnit_l147_11);
  assign _zz_flagNX_27 = _zz_flagNX_25[2];
  assign _zz_flagNX_28 = _zz_flagNX_25[1];
  assign _zz_flagNX_29 = (_zz_flagNX_25[0] || _zz_flagNX_26);
  assign _zz_when_FpUnit_l190_32 = _zz_flagNX_25[26 : 3];
  assign _zz_when_FpUnit_l190_33 = (_zz__zz_when_FpUnit_l190_33 + _zz__zz_when_FpUnit_l190_33_2);
  assign _zz_when_FpUnit_l186_31 = _zz_when_FpUnit_l190_33[24];
  assign _zz_when_FpUnit_l190_34 = (_zz_when_FpUnit_l186_31 ? _zz__zz_when_FpUnit_l190_34 : _zz__zz_when_FpUnit_l190_34_1);
  assign _zz_when_FpUnit_l186_32 = ($signed(_zz__zz_when_FpUnit_l186_32) + $signed(12'h07f));
  assign when_FpUnit_l186_10 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l186_32));
  assign _zz_res_63 = {_zz_res_62,{8'hff,23'h0}};
  assign _zz_res_64 = {_zz_res_62,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_65 = 32'h0;
    if(when_FpUnit_l186_10) begin
      _zz_res_65 = ((io_rm == 3'b001) ? _zz_res_64 : ((io_rm == 3'b010) ? (_zz_res_62 ? _zz_res_63 : _zz_res_64) : ((io_rm == 3'b011) ? (_zz_res_62 ? _zz_res_64 : _zz_res_63) : _zz_res_63)));
    end else begin
      if(when_FpUnit_l190_10) begin
        _zz_res_65 = {_zz_res_62,{8'h0,23'h0}};
      end else begin
        if(when_FpUnit_l192_10) begin
          _zz_res_65 = {_zz_res_62,{8'h0,_zz_when_FpUnit_l190_34[22 : 0]}};
        end else begin
          _zz_res_65 = {_zz_res_62,{_zz__zz_res_65,_zz_when_FpUnit_l190_34[22 : 0]}};
        end
      end
    end
  end

  assign when_FpUnit_l190_10 = (_zz_when_FpUnit_l190_31 && (_zz_when_FpUnit_l190_34 == 24'h0));
  assign when_FpUnit_l192_10 = ((_zz_when_FpUnit_l190_31 && (_zz_when_FpUnit_l190_34 != 24'h0)) && (! _zz_when_FpUnit_l190_34[23]));
  always @(*) begin
    _zz_res_66 = _zz_res_65;
    if(when_FpUnit_l536_1) begin
      _zz_res_66 = {_zz_res_62,{8'h0,23'h0}};
    end
  end

  assign when_FpUnit_l536_1 = (_zz_when_FpUnit_l88_171 == 56'h0);
  assign _zz_res_67 = io_a[63];
  assign _zz_when_FpUnit_l88_172 = io_a[63 : 0];
  assign _zz_when_FpUnit_l88_173 = (_zz_res_67 ? _zz__zz_when_FpUnit_l88_173 : _zz__zz_when_FpUnit_l88_173_2);
  always @(*) begin
    _zz_when_FpUnit_l95_11 = 7'h0;
    if(when_FpUnit_l88_499) begin
      _zz_when_FpUnit_l95_11 = 7'h0;
    end
    if(when_FpUnit_l88_500) begin
      _zz_when_FpUnit_l95_11 = 7'h01;
    end
    if(when_FpUnit_l88_501) begin
      _zz_when_FpUnit_l95_11 = 7'h02;
    end
    if(when_FpUnit_l88_502) begin
      _zz_when_FpUnit_l95_11 = 7'h03;
    end
    if(when_FpUnit_l88_503) begin
      _zz_when_FpUnit_l95_11 = 7'h04;
    end
    if(when_FpUnit_l88_504) begin
      _zz_when_FpUnit_l95_11 = 7'h05;
    end
    if(when_FpUnit_l88_505) begin
      _zz_when_FpUnit_l95_11 = 7'h06;
    end
    if(when_FpUnit_l88_506) begin
      _zz_when_FpUnit_l95_11 = 7'h07;
    end
    if(when_FpUnit_l88_507) begin
      _zz_when_FpUnit_l95_11 = 7'h08;
    end
    if(when_FpUnit_l88_508) begin
      _zz_when_FpUnit_l95_11 = 7'h09;
    end
    if(when_FpUnit_l88_509) begin
      _zz_when_FpUnit_l95_11 = 7'h0a;
    end
    if(when_FpUnit_l88_510) begin
      _zz_when_FpUnit_l95_11 = 7'h0b;
    end
    if(when_FpUnit_l88_511) begin
      _zz_when_FpUnit_l95_11 = 7'h0c;
    end
    if(when_FpUnit_l88_512) begin
      _zz_when_FpUnit_l95_11 = 7'h0d;
    end
    if(when_FpUnit_l88_513) begin
      _zz_when_FpUnit_l95_11 = 7'h0e;
    end
    if(when_FpUnit_l88_514) begin
      _zz_when_FpUnit_l95_11 = 7'h0f;
    end
    if(when_FpUnit_l88_515) begin
      _zz_when_FpUnit_l95_11 = 7'h10;
    end
    if(when_FpUnit_l88_516) begin
      _zz_when_FpUnit_l95_11 = 7'h11;
    end
    if(when_FpUnit_l88_517) begin
      _zz_when_FpUnit_l95_11 = 7'h12;
    end
    if(when_FpUnit_l88_518) begin
      _zz_when_FpUnit_l95_11 = 7'h13;
    end
    if(when_FpUnit_l88_519) begin
      _zz_when_FpUnit_l95_11 = 7'h14;
    end
    if(when_FpUnit_l88_520) begin
      _zz_when_FpUnit_l95_11 = 7'h15;
    end
    if(when_FpUnit_l88_521) begin
      _zz_when_FpUnit_l95_11 = 7'h16;
    end
    if(when_FpUnit_l88_522) begin
      _zz_when_FpUnit_l95_11 = 7'h17;
    end
    if(when_FpUnit_l88_523) begin
      _zz_when_FpUnit_l95_11 = 7'h18;
    end
    if(when_FpUnit_l88_524) begin
      _zz_when_FpUnit_l95_11 = 7'h19;
    end
    if(when_FpUnit_l88_525) begin
      _zz_when_FpUnit_l95_11 = 7'h1a;
    end
    if(when_FpUnit_l88_526) begin
      _zz_when_FpUnit_l95_11 = 7'h1b;
    end
    if(when_FpUnit_l88_527) begin
      _zz_when_FpUnit_l95_11 = 7'h1c;
    end
    if(when_FpUnit_l88_528) begin
      _zz_when_FpUnit_l95_11 = 7'h1d;
    end
    if(when_FpUnit_l88_529) begin
      _zz_when_FpUnit_l95_11 = 7'h1e;
    end
    if(when_FpUnit_l88_530) begin
      _zz_when_FpUnit_l95_11 = 7'h1f;
    end
    if(when_FpUnit_l88_531) begin
      _zz_when_FpUnit_l95_11 = 7'h20;
    end
    if(when_FpUnit_l88_532) begin
      _zz_when_FpUnit_l95_11 = 7'h21;
    end
    if(when_FpUnit_l88_533) begin
      _zz_when_FpUnit_l95_11 = 7'h22;
    end
    if(when_FpUnit_l88_534) begin
      _zz_when_FpUnit_l95_11 = 7'h23;
    end
    if(when_FpUnit_l88_535) begin
      _zz_when_FpUnit_l95_11 = 7'h24;
    end
    if(when_FpUnit_l88_536) begin
      _zz_when_FpUnit_l95_11 = 7'h25;
    end
    if(when_FpUnit_l88_537) begin
      _zz_when_FpUnit_l95_11 = 7'h26;
    end
    if(when_FpUnit_l88_538) begin
      _zz_when_FpUnit_l95_11 = 7'h27;
    end
    if(when_FpUnit_l88_539) begin
      _zz_when_FpUnit_l95_11 = 7'h28;
    end
    if(when_FpUnit_l88_540) begin
      _zz_when_FpUnit_l95_11 = 7'h29;
    end
    if(when_FpUnit_l88_541) begin
      _zz_when_FpUnit_l95_11 = 7'h2a;
    end
    if(when_FpUnit_l88_542) begin
      _zz_when_FpUnit_l95_11 = 7'h2b;
    end
    if(when_FpUnit_l88_543) begin
      _zz_when_FpUnit_l95_11 = 7'h2c;
    end
    if(when_FpUnit_l88_544) begin
      _zz_when_FpUnit_l95_11 = 7'h2d;
    end
    if(when_FpUnit_l88_545) begin
      _zz_when_FpUnit_l95_11 = 7'h2e;
    end
    if(when_FpUnit_l88_546) begin
      _zz_when_FpUnit_l95_11 = 7'h2f;
    end
    if(when_FpUnit_l88_547) begin
      _zz_when_FpUnit_l95_11 = 7'h30;
    end
    if(when_FpUnit_l88_548) begin
      _zz_when_FpUnit_l95_11 = 7'h31;
    end
    if(when_FpUnit_l88_549) begin
      _zz_when_FpUnit_l95_11 = 7'h32;
    end
    if(when_FpUnit_l88_550) begin
      _zz_when_FpUnit_l95_11 = 7'h33;
    end
    if(when_FpUnit_l88_551) begin
      _zz_when_FpUnit_l95_11 = 7'h34;
    end
    if(when_FpUnit_l88_552) begin
      _zz_when_FpUnit_l95_11 = 7'h35;
    end
    if(when_FpUnit_l88_553) begin
      _zz_when_FpUnit_l95_11 = 7'h36;
    end
    if(when_FpUnit_l88_554) begin
      _zz_when_FpUnit_l95_11 = 7'h37;
    end
    if(when_FpUnit_l88_555) begin
      _zz_when_FpUnit_l95_11 = 7'h38;
    end
    if(when_FpUnit_l88_556) begin
      _zz_when_FpUnit_l95_11 = 7'h39;
    end
    if(when_FpUnit_l88_557) begin
      _zz_when_FpUnit_l95_11 = 7'h3a;
    end
    if(when_FpUnit_l88_558) begin
      _zz_when_FpUnit_l95_11 = 7'h3b;
    end
    if(when_FpUnit_l88_559) begin
      _zz_when_FpUnit_l95_11 = 7'h3c;
    end
    if(when_FpUnit_l88_560) begin
      _zz_when_FpUnit_l95_11 = 7'h3d;
    end
    if(when_FpUnit_l88_561) begin
      _zz_when_FpUnit_l95_11 = 7'h3e;
    end
    if(when_FpUnit_l88_562) begin
      _zz_when_FpUnit_l95_11 = 7'h3f;
    end
    if(when_FpUnit_l88_563) begin
      _zz_when_FpUnit_l95_11 = 7'h40;
    end
    if(when_FpUnit_l88_564) begin
      _zz_when_FpUnit_l95_11 = 7'h41;
    end
    if(when_FpUnit_l88_565) begin
      _zz_when_FpUnit_l95_11 = 7'h42;
    end
    if(when_FpUnit_l88_566) begin
      _zz_when_FpUnit_l95_11 = 7'h43;
    end
    if(when_FpUnit_l88_567) begin
      _zz_when_FpUnit_l95_11 = 7'h44;
    end
    if(when_FpUnit_l88_568) begin
      _zz_when_FpUnit_l95_11 = 7'h45;
    end
    if(when_FpUnit_l88_569) begin
      _zz_when_FpUnit_l95_11 = 7'h46;
    end
    if(when_FpUnit_l88_570) begin
      _zz_when_FpUnit_l95_11 = 7'h47;
    end
    if(when_FpUnit_l88_571) begin
      _zz_when_FpUnit_l95_11 = 7'h48;
    end
    if(when_FpUnit_l88_572) begin
      _zz_when_FpUnit_l95_11 = 7'h49;
    end
    if(when_FpUnit_l88_573) begin
      _zz_when_FpUnit_l95_11 = 7'h4a;
    end
    if(when_FpUnit_l88_574) begin
      _zz_when_FpUnit_l95_11 = 7'h4b;
    end
    if(when_FpUnit_l88_575) begin
      _zz_when_FpUnit_l95_11 = 7'h4c;
    end
    if(when_FpUnit_l88_576) begin
      _zz_when_FpUnit_l95_11 = 7'h4d;
    end
    if(when_FpUnit_l88_577) begin
      _zz_when_FpUnit_l95_11 = 7'h4e;
    end
    if(when_FpUnit_l88_578) begin
      _zz_when_FpUnit_l95_11 = 7'h4f;
    end
    if(when_FpUnit_l88_579) begin
      _zz_when_FpUnit_l95_11 = 7'h50;
    end
    if(when_FpUnit_l88_580) begin
      _zz_when_FpUnit_l95_11 = 7'h51;
    end
    if(when_FpUnit_l88_581) begin
      _zz_when_FpUnit_l95_11 = 7'h52;
    end
    if(when_FpUnit_l88_582) begin
      _zz_when_FpUnit_l95_11 = 7'h53;
    end
    if(when_FpUnit_l88_583) begin
      _zz_when_FpUnit_l95_11 = 7'h54;
    end
    if(when_FpUnit_l88_584) begin
      _zz_when_FpUnit_l95_11 = 7'h55;
    end
    if(when_FpUnit_l88_585) begin
      _zz_when_FpUnit_l95_11 = 7'h56;
    end
    if(when_FpUnit_l88_586) begin
      _zz_when_FpUnit_l95_11 = 7'h57;
    end
  end

  assign when_FpUnit_l88_499 = _zz_when_FpUnit_l88_173[0];
  assign when_FpUnit_l88_500 = _zz_when_FpUnit_l88_173[1];
  assign when_FpUnit_l88_501 = _zz_when_FpUnit_l88_173[2];
  assign when_FpUnit_l88_502 = _zz_when_FpUnit_l88_173[3];
  assign when_FpUnit_l88_503 = _zz_when_FpUnit_l88_173[4];
  assign when_FpUnit_l88_504 = _zz_when_FpUnit_l88_173[5];
  assign when_FpUnit_l88_505 = _zz_when_FpUnit_l88_173[6];
  assign when_FpUnit_l88_506 = _zz_when_FpUnit_l88_173[7];
  assign when_FpUnit_l88_507 = _zz_when_FpUnit_l88_173[8];
  assign when_FpUnit_l88_508 = _zz_when_FpUnit_l88_173[9];
  assign when_FpUnit_l88_509 = _zz_when_FpUnit_l88_173[10];
  assign when_FpUnit_l88_510 = _zz_when_FpUnit_l88_173[11];
  assign when_FpUnit_l88_511 = _zz_when_FpUnit_l88_173[12];
  assign when_FpUnit_l88_512 = _zz_when_FpUnit_l88_173[13];
  assign when_FpUnit_l88_513 = _zz_when_FpUnit_l88_173[14];
  assign when_FpUnit_l88_514 = _zz_when_FpUnit_l88_173[15];
  assign when_FpUnit_l88_515 = _zz_when_FpUnit_l88_173[16];
  assign when_FpUnit_l88_516 = _zz_when_FpUnit_l88_173[17];
  assign when_FpUnit_l88_517 = _zz_when_FpUnit_l88_173[18];
  assign when_FpUnit_l88_518 = _zz_when_FpUnit_l88_173[19];
  assign when_FpUnit_l88_519 = _zz_when_FpUnit_l88_173[20];
  assign when_FpUnit_l88_520 = _zz_when_FpUnit_l88_173[21];
  assign when_FpUnit_l88_521 = _zz_when_FpUnit_l88_173[22];
  assign when_FpUnit_l88_522 = _zz_when_FpUnit_l88_173[23];
  assign when_FpUnit_l88_523 = _zz_when_FpUnit_l88_173[24];
  assign when_FpUnit_l88_524 = _zz_when_FpUnit_l88_173[25];
  assign when_FpUnit_l88_525 = _zz_when_FpUnit_l88_173[26];
  assign when_FpUnit_l88_526 = _zz_when_FpUnit_l88_173[27];
  assign when_FpUnit_l88_527 = _zz_when_FpUnit_l88_173[28];
  assign when_FpUnit_l88_528 = _zz_when_FpUnit_l88_173[29];
  assign when_FpUnit_l88_529 = _zz_when_FpUnit_l88_173[30];
  assign when_FpUnit_l88_530 = _zz_when_FpUnit_l88_173[31];
  assign when_FpUnit_l88_531 = _zz_when_FpUnit_l88_173[32];
  assign when_FpUnit_l88_532 = _zz_when_FpUnit_l88_173[33];
  assign when_FpUnit_l88_533 = _zz_when_FpUnit_l88_173[34];
  assign when_FpUnit_l88_534 = _zz_when_FpUnit_l88_173[35];
  assign when_FpUnit_l88_535 = _zz_when_FpUnit_l88_173[36];
  assign when_FpUnit_l88_536 = _zz_when_FpUnit_l88_173[37];
  assign when_FpUnit_l88_537 = _zz_when_FpUnit_l88_173[38];
  assign when_FpUnit_l88_538 = _zz_when_FpUnit_l88_173[39];
  assign when_FpUnit_l88_539 = _zz_when_FpUnit_l88_173[40];
  assign when_FpUnit_l88_540 = _zz_when_FpUnit_l88_173[41];
  assign when_FpUnit_l88_541 = _zz_when_FpUnit_l88_173[42];
  assign when_FpUnit_l88_542 = _zz_when_FpUnit_l88_173[43];
  assign when_FpUnit_l88_543 = _zz_when_FpUnit_l88_173[44];
  assign when_FpUnit_l88_544 = _zz_when_FpUnit_l88_173[45];
  assign when_FpUnit_l88_545 = _zz_when_FpUnit_l88_173[46];
  assign when_FpUnit_l88_546 = _zz_when_FpUnit_l88_173[47];
  assign when_FpUnit_l88_547 = _zz_when_FpUnit_l88_173[48];
  assign when_FpUnit_l88_548 = _zz_when_FpUnit_l88_173[49];
  assign when_FpUnit_l88_549 = _zz_when_FpUnit_l88_173[50];
  assign when_FpUnit_l88_550 = _zz_when_FpUnit_l88_173[51];
  assign when_FpUnit_l88_551 = _zz_when_FpUnit_l88_173[52];
  assign when_FpUnit_l88_552 = _zz_when_FpUnit_l88_173[53];
  assign when_FpUnit_l88_553 = _zz_when_FpUnit_l88_173[54];
  assign when_FpUnit_l88_554 = _zz_when_FpUnit_l88_173[55];
  assign when_FpUnit_l88_555 = _zz_when_FpUnit_l88_173[56];
  assign when_FpUnit_l88_556 = _zz_when_FpUnit_l88_173[57];
  assign when_FpUnit_l88_557 = _zz_when_FpUnit_l88_173[58];
  assign when_FpUnit_l88_558 = _zz_when_FpUnit_l88_173[59];
  assign when_FpUnit_l88_559 = _zz_when_FpUnit_l88_173[60];
  assign when_FpUnit_l88_560 = _zz_when_FpUnit_l88_173[61];
  assign when_FpUnit_l88_561 = _zz_when_FpUnit_l88_173[62];
  assign when_FpUnit_l88_562 = _zz_when_FpUnit_l88_173[63];
  assign when_FpUnit_l88_563 = _zz_when_FpUnit_l88_173[64];
  assign when_FpUnit_l88_564 = _zz_when_FpUnit_l88_173[65];
  assign when_FpUnit_l88_565 = _zz_when_FpUnit_l88_173[66];
  assign when_FpUnit_l88_566 = _zz_when_FpUnit_l88_173[67];
  assign when_FpUnit_l88_567 = _zz_when_FpUnit_l88_173[68];
  assign when_FpUnit_l88_568 = _zz_when_FpUnit_l88_173[69];
  assign when_FpUnit_l88_569 = _zz_when_FpUnit_l88_173[70];
  assign when_FpUnit_l88_570 = _zz_when_FpUnit_l88_173[71];
  assign when_FpUnit_l88_571 = _zz_when_FpUnit_l88_173[72];
  assign when_FpUnit_l88_572 = _zz_when_FpUnit_l88_173[73];
  assign when_FpUnit_l88_573 = _zz_when_FpUnit_l88_173[74];
  assign when_FpUnit_l88_574 = _zz_when_FpUnit_l88_173[75];
  assign when_FpUnit_l88_575 = _zz_when_FpUnit_l88_173[76];
  assign when_FpUnit_l88_576 = _zz_when_FpUnit_l88_173[77];
  assign when_FpUnit_l88_577 = _zz_when_FpUnit_l88_173[78];
  assign when_FpUnit_l88_578 = _zz_when_FpUnit_l88_173[79];
  assign when_FpUnit_l88_579 = _zz_when_FpUnit_l88_173[80];
  assign when_FpUnit_l88_580 = _zz_when_FpUnit_l88_173[81];
  assign when_FpUnit_l88_581 = _zz_when_FpUnit_l88_173[82];
  assign when_FpUnit_l88_582 = _zz_when_FpUnit_l88_173[83];
  assign when_FpUnit_l88_583 = _zz_when_FpUnit_l88_173[84];
  assign when_FpUnit_l88_584 = _zz_when_FpUnit_l88_173[85];
  assign when_FpUnit_l88_585 = _zz_when_FpUnit_l88_173[86];
  assign when_FpUnit_l88_586 = _zz_when_FpUnit_l88_173[87];
  always @(*) begin
    _zz_flagNX_30 = 27'h0;
    if(when_FpUnit_l94_11) begin
      if(when_FpUnit_l95_11) begin
        _zz_flagNX_30 = _zz__zz_flagNX_30;
      end else begin
        _zz_flagNX_30 = _zz__zz_flagNX_30_2;
      end
    end
  end

  always @(*) begin
    _zz_flagNX_31 = 1'b0;
    if(when_FpUnit_l94_11) begin
      if(when_FpUnit_l95_11) begin
        _zz_flagNX_31 = (|(_zz_when_FpUnit_l88_173 & _zz__zz_flagNX_31));
      end else begin
        _zz_flagNX_31 = 1'b0;
      end
    end
  end

  assign _zz_when_FpUnit_l147_13 = ($signed(_zz__zz_when_FpUnit_l147_13) + $signed(12'h0));
  assign when_FpUnit_l94_11 = (_zz_when_FpUnit_l88_173 != 88'h0);
  assign when_FpUnit_l95_11 = (7'h1a < _zz_when_FpUnit_l95_11);
  assign _zz_flagNX_32 = (_zz_when_FpUnit_l95_11 - 7'h1a);
  assign _zz_flagNX_33 = _zz__zz_flagNX_33;
  assign _zz_flagNX_34 = _zz_flagNX_33;
  assign _zz_flagNX_35 = (_zz_flagNX_31 || (|(_zz_flagNX_33 & 29'h0)));
  assign _zz_when_FpUnit_l190_35 = ($signed(_zz__zz_when_FpUnit_l190_35) < $signed(12'h001));
  assign _zz_when_FpUnit_l147_14 = (_zz_when_FpUnit_l190_35 ? _zz__zz_when_FpUnit_l147_14 : 12'h0);
  assign _zz_when_FpUnit_l150_11 = _zz_when_FpUnit_l147_14;
  assign when_FpUnit_l147_11 = ($signed(_zz_when_FpUnit_l147_14) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l147_11) begin
      _zz_flagNX_36 = _zz__zz_flagNX_36;
    end else begin
      if(when_FpUnit_l150_11) begin
        _zz_flagNX_36 = 27'h0;
      end else begin
        _zz_flagNX_36 = _zz__zz_flagNX_36_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l147_11) begin
      _zz_flagNX_37 = _zz_flagNX_35;
    end else begin
      if(when_FpUnit_l150_11) begin
        _zz_flagNX_37 = ((|_zz_flagNX_34) || _zz_flagNX_35);
      end else begin
        _zz_flagNX_37 = ((|(_zz_flagNX_34 & _zz__zz_flagNX_37)) || _zz_flagNX_35);
      end
    end
  end

  assign when_FpUnit_l150_11 = (12'h01b <= _zz_when_FpUnit_l150_11);
  assign _zz_when_FpUnit_l186_33 = (_zz_when_FpUnit_l190_35 ? 12'hf82 : _zz_when_FpUnit_l147_13);
  assign _zz_flagNX_38 = _zz_flagNX_36[2];
  assign _zz_flagNX_39 = _zz_flagNX_36[1];
  assign _zz_flagNX_40 = (_zz_flagNX_36[0] || _zz_flagNX_37);
  assign _zz_when_FpUnit_l190_36 = _zz_flagNX_36[26 : 3];
  assign _zz_when_FpUnit_l190_37 = (_zz__zz_when_FpUnit_l190_37 + _zz__zz_when_FpUnit_l190_37_2);
  assign _zz_when_FpUnit_l186_34 = _zz_when_FpUnit_l190_37[24];
  assign _zz_when_FpUnit_l190_38 = (_zz_when_FpUnit_l186_34 ? _zz__zz_when_FpUnit_l190_38 : _zz__zz_when_FpUnit_l190_38_1);
  assign _zz_when_FpUnit_l186_35 = ($signed(_zz__zz_when_FpUnit_l186_35) + $signed(12'h07f));
  assign when_FpUnit_l186_11 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l186_35));
  assign _zz_res_68 = {_zz_res_67,{8'hff,23'h0}};
  assign _zz_res_69 = {_zz_res_67,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_70 = 32'h0;
    if(when_FpUnit_l186_11) begin
      _zz_res_70 = ((io_rm == 3'b001) ? _zz_res_69 : ((io_rm == 3'b010) ? (_zz_res_67 ? _zz_res_68 : _zz_res_69) : ((io_rm == 3'b011) ? (_zz_res_67 ? _zz_res_69 : _zz_res_68) : _zz_res_68)));
    end else begin
      if(when_FpUnit_l190_11) begin
        _zz_res_70 = {_zz_res_67,{8'h0,23'h0}};
      end else begin
        if(when_FpUnit_l192_11) begin
          _zz_res_70 = {_zz_res_67,{8'h0,_zz_when_FpUnit_l190_38[22 : 0]}};
        end else begin
          _zz_res_70 = {_zz_res_67,{_zz__zz_res_70,_zz_when_FpUnit_l190_38[22 : 0]}};
        end
      end
    end
  end

  assign when_FpUnit_l190_11 = (_zz_when_FpUnit_l190_35 && (_zz_when_FpUnit_l190_38 == 24'h0));
  assign when_FpUnit_l192_11 = ((_zz_when_FpUnit_l190_35 && (_zz_when_FpUnit_l190_38 != 24'h0)) && (! _zz_when_FpUnit_l190_38[23]));
  always @(*) begin
    _zz_res_71 = _zz_res_70;
    if(when_FpUnit_l536_2) begin
      _zz_res_71 = {_zz_res_67,{8'h0,23'h0}};
    end
  end

  assign when_FpUnit_l536_2 = (_zz_when_FpUnit_l88_173 == 88'h0);
  assign _zz_res_72 = 1'b0;
  assign _zz_when_FpUnit_l88_174 = io_a[63 : 0];
  assign _zz_when_FpUnit_l88_175 = (_zz_res_72 ? _zz__zz_when_FpUnit_l88_175 : _zz__zz_when_FpUnit_l88_175_2);
  always @(*) begin
    _zz_when_FpUnit_l95_12 = 7'h0;
    if(when_FpUnit_l88_587) begin
      _zz_when_FpUnit_l95_12 = 7'h0;
    end
    if(when_FpUnit_l88_588) begin
      _zz_when_FpUnit_l95_12 = 7'h01;
    end
    if(when_FpUnit_l88_589) begin
      _zz_when_FpUnit_l95_12 = 7'h02;
    end
    if(when_FpUnit_l88_590) begin
      _zz_when_FpUnit_l95_12 = 7'h03;
    end
    if(when_FpUnit_l88_591) begin
      _zz_when_FpUnit_l95_12 = 7'h04;
    end
    if(when_FpUnit_l88_592) begin
      _zz_when_FpUnit_l95_12 = 7'h05;
    end
    if(when_FpUnit_l88_593) begin
      _zz_when_FpUnit_l95_12 = 7'h06;
    end
    if(when_FpUnit_l88_594) begin
      _zz_when_FpUnit_l95_12 = 7'h07;
    end
    if(when_FpUnit_l88_595) begin
      _zz_when_FpUnit_l95_12 = 7'h08;
    end
    if(when_FpUnit_l88_596) begin
      _zz_when_FpUnit_l95_12 = 7'h09;
    end
    if(when_FpUnit_l88_597) begin
      _zz_when_FpUnit_l95_12 = 7'h0a;
    end
    if(when_FpUnit_l88_598) begin
      _zz_when_FpUnit_l95_12 = 7'h0b;
    end
    if(when_FpUnit_l88_599) begin
      _zz_when_FpUnit_l95_12 = 7'h0c;
    end
    if(when_FpUnit_l88_600) begin
      _zz_when_FpUnit_l95_12 = 7'h0d;
    end
    if(when_FpUnit_l88_601) begin
      _zz_when_FpUnit_l95_12 = 7'h0e;
    end
    if(when_FpUnit_l88_602) begin
      _zz_when_FpUnit_l95_12 = 7'h0f;
    end
    if(when_FpUnit_l88_603) begin
      _zz_when_FpUnit_l95_12 = 7'h10;
    end
    if(when_FpUnit_l88_604) begin
      _zz_when_FpUnit_l95_12 = 7'h11;
    end
    if(when_FpUnit_l88_605) begin
      _zz_when_FpUnit_l95_12 = 7'h12;
    end
    if(when_FpUnit_l88_606) begin
      _zz_when_FpUnit_l95_12 = 7'h13;
    end
    if(when_FpUnit_l88_607) begin
      _zz_when_FpUnit_l95_12 = 7'h14;
    end
    if(when_FpUnit_l88_608) begin
      _zz_when_FpUnit_l95_12 = 7'h15;
    end
    if(when_FpUnit_l88_609) begin
      _zz_when_FpUnit_l95_12 = 7'h16;
    end
    if(when_FpUnit_l88_610) begin
      _zz_when_FpUnit_l95_12 = 7'h17;
    end
    if(when_FpUnit_l88_611) begin
      _zz_when_FpUnit_l95_12 = 7'h18;
    end
    if(when_FpUnit_l88_612) begin
      _zz_when_FpUnit_l95_12 = 7'h19;
    end
    if(when_FpUnit_l88_613) begin
      _zz_when_FpUnit_l95_12 = 7'h1a;
    end
    if(when_FpUnit_l88_614) begin
      _zz_when_FpUnit_l95_12 = 7'h1b;
    end
    if(when_FpUnit_l88_615) begin
      _zz_when_FpUnit_l95_12 = 7'h1c;
    end
    if(when_FpUnit_l88_616) begin
      _zz_when_FpUnit_l95_12 = 7'h1d;
    end
    if(when_FpUnit_l88_617) begin
      _zz_when_FpUnit_l95_12 = 7'h1e;
    end
    if(when_FpUnit_l88_618) begin
      _zz_when_FpUnit_l95_12 = 7'h1f;
    end
    if(when_FpUnit_l88_619) begin
      _zz_when_FpUnit_l95_12 = 7'h20;
    end
    if(when_FpUnit_l88_620) begin
      _zz_when_FpUnit_l95_12 = 7'h21;
    end
    if(when_FpUnit_l88_621) begin
      _zz_when_FpUnit_l95_12 = 7'h22;
    end
    if(when_FpUnit_l88_622) begin
      _zz_when_FpUnit_l95_12 = 7'h23;
    end
    if(when_FpUnit_l88_623) begin
      _zz_when_FpUnit_l95_12 = 7'h24;
    end
    if(when_FpUnit_l88_624) begin
      _zz_when_FpUnit_l95_12 = 7'h25;
    end
    if(when_FpUnit_l88_625) begin
      _zz_when_FpUnit_l95_12 = 7'h26;
    end
    if(when_FpUnit_l88_626) begin
      _zz_when_FpUnit_l95_12 = 7'h27;
    end
    if(when_FpUnit_l88_627) begin
      _zz_when_FpUnit_l95_12 = 7'h28;
    end
    if(when_FpUnit_l88_628) begin
      _zz_when_FpUnit_l95_12 = 7'h29;
    end
    if(when_FpUnit_l88_629) begin
      _zz_when_FpUnit_l95_12 = 7'h2a;
    end
    if(when_FpUnit_l88_630) begin
      _zz_when_FpUnit_l95_12 = 7'h2b;
    end
    if(when_FpUnit_l88_631) begin
      _zz_when_FpUnit_l95_12 = 7'h2c;
    end
    if(when_FpUnit_l88_632) begin
      _zz_when_FpUnit_l95_12 = 7'h2d;
    end
    if(when_FpUnit_l88_633) begin
      _zz_when_FpUnit_l95_12 = 7'h2e;
    end
    if(when_FpUnit_l88_634) begin
      _zz_when_FpUnit_l95_12 = 7'h2f;
    end
    if(when_FpUnit_l88_635) begin
      _zz_when_FpUnit_l95_12 = 7'h30;
    end
    if(when_FpUnit_l88_636) begin
      _zz_when_FpUnit_l95_12 = 7'h31;
    end
    if(when_FpUnit_l88_637) begin
      _zz_when_FpUnit_l95_12 = 7'h32;
    end
    if(when_FpUnit_l88_638) begin
      _zz_when_FpUnit_l95_12 = 7'h33;
    end
    if(when_FpUnit_l88_639) begin
      _zz_when_FpUnit_l95_12 = 7'h34;
    end
    if(when_FpUnit_l88_640) begin
      _zz_when_FpUnit_l95_12 = 7'h35;
    end
    if(when_FpUnit_l88_641) begin
      _zz_when_FpUnit_l95_12 = 7'h36;
    end
    if(when_FpUnit_l88_642) begin
      _zz_when_FpUnit_l95_12 = 7'h37;
    end
    if(when_FpUnit_l88_643) begin
      _zz_when_FpUnit_l95_12 = 7'h38;
    end
    if(when_FpUnit_l88_644) begin
      _zz_when_FpUnit_l95_12 = 7'h39;
    end
    if(when_FpUnit_l88_645) begin
      _zz_when_FpUnit_l95_12 = 7'h3a;
    end
    if(when_FpUnit_l88_646) begin
      _zz_when_FpUnit_l95_12 = 7'h3b;
    end
    if(when_FpUnit_l88_647) begin
      _zz_when_FpUnit_l95_12 = 7'h3c;
    end
    if(when_FpUnit_l88_648) begin
      _zz_when_FpUnit_l95_12 = 7'h3d;
    end
    if(when_FpUnit_l88_649) begin
      _zz_when_FpUnit_l95_12 = 7'h3e;
    end
    if(when_FpUnit_l88_650) begin
      _zz_when_FpUnit_l95_12 = 7'h3f;
    end
    if(when_FpUnit_l88_651) begin
      _zz_when_FpUnit_l95_12 = 7'h40;
    end
    if(when_FpUnit_l88_652) begin
      _zz_when_FpUnit_l95_12 = 7'h41;
    end
    if(when_FpUnit_l88_653) begin
      _zz_when_FpUnit_l95_12 = 7'h42;
    end
    if(when_FpUnit_l88_654) begin
      _zz_when_FpUnit_l95_12 = 7'h43;
    end
    if(when_FpUnit_l88_655) begin
      _zz_when_FpUnit_l95_12 = 7'h44;
    end
    if(when_FpUnit_l88_656) begin
      _zz_when_FpUnit_l95_12 = 7'h45;
    end
    if(when_FpUnit_l88_657) begin
      _zz_when_FpUnit_l95_12 = 7'h46;
    end
    if(when_FpUnit_l88_658) begin
      _zz_when_FpUnit_l95_12 = 7'h47;
    end
    if(when_FpUnit_l88_659) begin
      _zz_when_FpUnit_l95_12 = 7'h48;
    end
    if(when_FpUnit_l88_660) begin
      _zz_when_FpUnit_l95_12 = 7'h49;
    end
    if(when_FpUnit_l88_661) begin
      _zz_when_FpUnit_l95_12 = 7'h4a;
    end
    if(when_FpUnit_l88_662) begin
      _zz_when_FpUnit_l95_12 = 7'h4b;
    end
    if(when_FpUnit_l88_663) begin
      _zz_when_FpUnit_l95_12 = 7'h4c;
    end
    if(when_FpUnit_l88_664) begin
      _zz_when_FpUnit_l95_12 = 7'h4d;
    end
    if(when_FpUnit_l88_665) begin
      _zz_when_FpUnit_l95_12 = 7'h4e;
    end
    if(when_FpUnit_l88_666) begin
      _zz_when_FpUnit_l95_12 = 7'h4f;
    end
    if(when_FpUnit_l88_667) begin
      _zz_when_FpUnit_l95_12 = 7'h50;
    end
    if(when_FpUnit_l88_668) begin
      _zz_when_FpUnit_l95_12 = 7'h51;
    end
    if(when_FpUnit_l88_669) begin
      _zz_when_FpUnit_l95_12 = 7'h52;
    end
    if(when_FpUnit_l88_670) begin
      _zz_when_FpUnit_l95_12 = 7'h53;
    end
    if(when_FpUnit_l88_671) begin
      _zz_when_FpUnit_l95_12 = 7'h54;
    end
    if(when_FpUnit_l88_672) begin
      _zz_when_FpUnit_l95_12 = 7'h55;
    end
    if(when_FpUnit_l88_673) begin
      _zz_when_FpUnit_l95_12 = 7'h56;
    end
    if(when_FpUnit_l88_674) begin
      _zz_when_FpUnit_l95_12 = 7'h57;
    end
  end

  assign when_FpUnit_l88_587 = _zz_when_FpUnit_l88_175[0];
  assign when_FpUnit_l88_588 = _zz_when_FpUnit_l88_175[1];
  assign when_FpUnit_l88_589 = _zz_when_FpUnit_l88_175[2];
  assign when_FpUnit_l88_590 = _zz_when_FpUnit_l88_175[3];
  assign when_FpUnit_l88_591 = _zz_when_FpUnit_l88_175[4];
  assign when_FpUnit_l88_592 = _zz_when_FpUnit_l88_175[5];
  assign when_FpUnit_l88_593 = _zz_when_FpUnit_l88_175[6];
  assign when_FpUnit_l88_594 = _zz_when_FpUnit_l88_175[7];
  assign when_FpUnit_l88_595 = _zz_when_FpUnit_l88_175[8];
  assign when_FpUnit_l88_596 = _zz_when_FpUnit_l88_175[9];
  assign when_FpUnit_l88_597 = _zz_when_FpUnit_l88_175[10];
  assign when_FpUnit_l88_598 = _zz_when_FpUnit_l88_175[11];
  assign when_FpUnit_l88_599 = _zz_when_FpUnit_l88_175[12];
  assign when_FpUnit_l88_600 = _zz_when_FpUnit_l88_175[13];
  assign when_FpUnit_l88_601 = _zz_when_FpUnit_l88_175[14];
  assign when_FpUnit_l88_602 = _zz_when_FpUnit_l88_175[15];
  assign when_FpUnit_l88_603 = _zz_when_FpUnit_l88_175[16];
  assign when_FpUnit_l88_604 = _zz_when_FpUnit_l88_175[17];
  assign when_FpUnit_l88_605 = _zz_when_FpUnit_l88_175[18];
  assign when_FpUnit_l88_606 = _zz_when_FpUnit_l88_175[19];
  assign when_FpUnit_l88_607 = _zz_when_FpUnit_l88_175[20];
  assign when_FpUnit_l88_608 = _zz_when_FpUnit_l88_175[21];
  assign when_FpUnit_l88_609 = _zz_when_FpUnit_l88_175[22];
  assign when_FpUnit_l88_610 = _zz_when_FpUnit_l88_175[23];
  assign when_FpUnit_l88_611 = _zz_when_FpUnit_l88_175[24];
  assign when_FpUnit_l88_612 = _zz_when_FpUnit_l88_175[25];
  assign when_FpUnit_l88_613 = _zz_when_FpUnit_l88_175[26];
  assign when_FpUnit_l88_614 = _zz_when_FpUnit_l88_175[27];
  assign when_FpUnit_l88_615 = _zz_when_FpUnit_l88_175[28];
  assign when_FpUnit_l88_616 = _zz_when_FpUnit_l88_175[29];
  assign when_FpUnit_l88_617 = _zz_when_FpUnit_l88_175[30];
  assign when_FpUnit_l88_618 = _zz_when_FpUnit_l88_175[31];
  assign when_FpUnit_l88_619 = _zz_when_FpUnit_l88_175[32];
  assign when_FpUnit_l88_620 = _zz_when_FpUnit_l88_175[33];
  assign when_FpUnit_l88_621 = _zz_when_FpUnit_l88_175[34];
  assign when_FpUnit_l88_622 = _zz_when_FpUnit_l88_175[35];
  assign when_FpUnit_l88_623 = _zz_when_FpUnit_l88_175[36];
  assign when_FpUnit_l88_624 = _zz_when_FpUnit_l88_175[37];
  assign when_FpUnit_l88_625 = _zz_when_FpUnit_l88_175[38];
  assign when_FpUnit_l88_626 = _zz_when_FpUnit_l88_175[39];
  assign when_FpUnit_l88_627 = _zz_when_FpUnit_l88_175[40];
  assign when_FpUnit_l88_628 = _zz_when_FpUnit_l88_175[41];
  assign when_FpUnit_l88_629 = _zz_when_FpUnit_l88_175[42];
  assign when_FpUnit_l88_630 = _zz_when_FpUnit_l88_175[43];
  assign when_FpUnit_l88_631 = _zz_when_FpUnit_l88_175[44];
  assign when_FpUnit_l88_632 = _zz_when_FpUnit_l88_175[45];
  assign when_FpUnit_l88_633 = _zz_when_FpUnit_l88_175[46];
  assign when_FpUnit_l88_634 = _zz_when_FpUnit_l88_175[47];
  assign when_FpUnit_l88_635 = _zz_when_FpUnit_l88_175[48];
  assign when_FpUnit_l88_636 = _zz_when_FpUnit_l88_175[49];
  assign when_FpUnit_l88_637 = _zz_when_FpUnit_l88_175[50];
  assign when_FpUnit_l88_638 = _zz_when_FpUnit_l88_175[51];
  assign when_FpUnit_l88_639 = _zz_when_FpUnit_l88_175[52];
  assign when_FpUnit_l88_640 = _zz_when_FpUnit_l88_175[53];
  assign when_FpUnit_l88_641 = _zz_when_FpUnit_l88_175[54];
  assign when_FpUnit_l88_642 = _zz_when_FpUnit_l88_175[55];
  assign when_FpUnit_l88_643 = _zz_when_FpUnit_l88_175[56];
  assign when_FpUnit_l88_644 = _zz_when_FpUnit_l88_175[57];
  assign when_FpUnit_l88_645 = _zz_when_FpUnit_l88_175[58];
  assign when_FpUnit_l88_646 = _zz_when_FpUnit_l88_175[59];
  assign when_FpUnit_l88_647 = _zz_when_FpUnit_l88_175[60];
  assign when_FpUnit_l88_648 = _zz_when_FpUnit_l88_175[61];
  assign when_FpUnit_l88_649 = _zz_when_FpUnit_l88_175[62];
  assign when_FpUnit_l88_650 = _zz_when_FpUnit_l88_175[63];
  assign when_FpUnit_l88_651 = _zz_when_FpUnit_l88_175[64];
  assign when_FpUnit_l88_652 = _zz_when_FpUnit_l88_175[65];
  assign when_FpUnit_l88_653 = _zz_when_FpUnit_l88_175[66];
  assign when_FpUnit_l88_654 = _zz_when_FpUnit_l88_175[67];
  assign when_FpUnit_l88_655 = _zz_when_FpUnit_l88_175[68];
  assign when_FpUnit_l88_656 = _zz_when_FpUnit_l88_175[69];
  assign when_FpUnit_l88_657 = _zz_when_FpUnit_l88_175[70];
  assign when_FpUnit_l88_658 = _zz_when_FpUnit_l88_175[71];
  assign when_FpUnit_l88_659 = _zz_when_FpUnit_l88_175[72];
  assign when_FpUnit_l88_660 = _zz_when_FpUnit_l88_175[73];
  assign when_FpUnit_l88_661 = _zz_when_FpUnit_l88_175[74];
  assign when_FpUnit_l88_662 = _zz_when_FpUnit_l88_175[75];
  assign when_FpUnit_l88_663 = _zz_when_FpUnit_l88_175[76];
  assign when_FpUnit_l88_664 = _zz_when_FpUnit_l88_175[77];
  assign when_FpUnit_l88_665 = _zz_when_FpUnit_l88_175[78];
  assign when_FpUnit_l88_666 = _zz_when_FpUnit_l88_175[79];
  assign when_FpUnit_l88_667 = _zz_when_FpUnit_l88_175[80];
  assign when_FpUnit_l88_668 = _zz_when_FpUnit_l88_175[81];
  assign when_FpUnit_l88_669 = _zz_when_FpUnit_l88_175[82];
  assign when_FpUnit_l88_670 = _zz_when_FpUnit_l88_175[83];
  assign when_FpUnit_l88_671 = _zz_when_FpUnit_l88_175[84];
  assign when_FpUnit_l88_672 = _zz_when_FpUnit_l88_175[85];
  assign when_FpUnit_l88_673 = _zz_when_FpUnit_l88_175[86];
  assign when_FpUnit_l88_674 = _zz_when_FpUnit_l88_175[87];
  always @(*) begin
    _zz_flagNX_41 = 27'h0;
    if(when_FpUnit_l94_12) begin
      if(when_FpUnit_l95_12) begin
        _zz_flagNX_41 = _zz__zz_flagNX_41;
      end else begin
        _zz_flagNX_41 = _zz__zz_flagNX_41_2;
      end
    end
  end

  always @(*) begin
    _zz_flagNX_42 = 1'b0;
    if(when_FpUnit_l94_12) begin
      if(when_FpUnit_l95_12) begin
        _zz_flagNX_42 = (|(_zz_when_FpUnit_l88_175 & _zz__zz_flagNX_42));
      end else begin
        _zz_flagNX_42 = 1'b0;
      end
    end
  end

  assign _zz_when_FpUnit_l147_15 = ($signed(_zz__zz_when_FpUnit_l147_15) + $signed(12'h0));
  assign when_FpUnit_l94_12 = (_zz_when_FpUnit_l88_175 != 88'h0);
  assign when_FpUnit_l95_12 = (7'h1a < _zz_when_FpUnit_l95_12);
  assign _zz_flagNX_43 = (_zz_when_FpUnit_l95_12 - 7'h1a);
  assign _zz_flagNX_44 = _zz__zz_flagNX_44;
  assign _zz_flagNX_45 = _zz_flagNX_44;
  assign _zz_flagNX_46 = (_zz_flagNX_42 || (|(_zz_flagNX_44 & 29'h0)));
  assign _zz_when_FpUnit_l190_39 = ($signed(_zz__zz_when_FpUnit_l190_39) < $signed(12'h001));
  assign _zz_when_FpUnit_l147_16 = (_zz_when_FpUnit_l190_39 ? _zz__zz_when_FpUnit_l147_16 : 12'h0);
  assign _zz_when_FpUnit_l150_12 = _zz_when_FpUnit_l147_16;
  assign when_FpUnit_l147_12 = ($signed(_zz_when_FpUnit_l147_16) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l147_12) begin
      _zz_flagNX_47 = _zz__zz_flagNX_47;
    end else begin
      if(when_FpUnit_l150_12) begin
        _zz_flagNX_47 = 27'h0;
      end else begin
        _zz_flagNX_47 = _zz__zz_flagNX_47_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l147_12) begin
      _zz_flagNX_48 = _zz_flagNX_46;
    end else begin
      if(when_FpUnit_l150_12) begin
        _zz_flagNX_48 = ((|_zz_flagNX_45) || _zz_flagNX_46);
      end else begin
        _zz_flagNX_48 = ((|(_zz_flagNX_45 & _zz__zz_flagNX_48)) || _zz_flagNX_46);
      end
    end
  end

  assign when_FpUnit_l150_12 = (12'h01b <= _zz_when_FpUnit_l150_12);
  assign _zz_when_FpUnit_l186_36 = (_zz_when_FpUnit_l190_39 ? 12'hf82 : _zz_when_FpUnit_l147_15);
  assign _zz_flagNX_49 = _zz_flagNX_47[2];
  assign _zz_flagNX_50 = _zz_flagNX_47[1];
  assign _zz_flagNX_51 = (_zz_flagNX_47[0] || _zz_flagNX_48);
  assign _zz_when_FpUnit_l190_40 = _zz_flagNX_47[26 : 3];
  assign _zz_when_FpUnit_l190_41 = (_zz__zz_when_FpUnit_l190_41 + _zz__zz_when_FpUnit_l190_41_2);
  assign _zz_when_FpUnit_l186_37 = _zz_when_FpUnit_l190_41[24];
  assign _zz_when_FpUnit_l190_42 = (_zz_when_FpUnit_l186_37 ? _zz__zz_when_FpUnit_l190_42 : _zz__zz_when_FpUnit_l190_42_1);
  assign _zz_when_FpUnit_l186_38 = ($signed(_zz__zz_when_FpUnit_l186_38) + $signed(12'h07f));
  assign when_FpUnit_l186_12 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l186_38));
  assign _zz_res_73 = {_zz_res_72,{8'hff,23'h0}};
  assign _zz_res_74 = {_zz_res_72,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_75 = 32'h0;
    if(when_FpUnit_l186_12) begin
      _zz_res_75 = ((io_rm == 3'b001) ? _zz_res_74 : ((io_rm == 3'b010) ? (_zz_res_72 ? _zz_res_73 : _zz_res_74) : ((io_rm == 3'b011) ? (_zz_res_72 ? _zz_res_74 : _zz_res_73) : _zz_res_73)));
    end else begin
      if(when_FpUnit_l190_12) begin
        _zz_res_75 = {_zz_res_72,{8'h0,23'h0}};
      end else begin
        if(when_FpUnit_l192_12) begin
          _zz_res_75 = {_zz_res_72,{8'h0,_zz_when_FpUnit_l190_42[22 : 0]}};
        end else begin
          _zz_res_75 = {_zz_res_72,{_zz__zz_res_75,_zz_when_FpUnit_l190_42[22 : 0]}};
        end
      end
    end
  end

  assign when_FpUnit_l190_12 = (_zz_when_FpUnit_l190_39 && (_zz_when_FpUnit_l190_42 == 24'h0));
  assign when_FpUnit_l192_12 = ((_zz_when_FpUnit_l190_39 && (_zz_when_FpUnit_l190_42 != 24'h0)) && (! _zz_when_FpUnit_l190_42[23]));
  always @(*) begin
    _zz_res_76 = _zz_res_75;
    if(when_FpUnit_l536_3) begin
      _zz_res_76 = {_zz_res_72,{8'h0,23'h0}};
    end
  end

  assign when_FpUnit_l536_3 = (_zz_when_FpUnit_l88_175 == 88'h0);
  always @(*) begin
    _zz_when_FpUnit_l95_13 = 5'h0;
    if(when_FpUnit_l88_675) begin
      _zz_when_FpUnit_l95_13 = 5'h0;
    end
    if(when_FpUnit_l88_676) begin
      _zz_when_FpUnit_l95_13 = 5'h01;
    end
    if(when_FpUnit_l88_677) begin
      _zz_when_FpUnit_l95_13 = 5'h02;
    end
    if(when_FpUnit_l88_678) begin
      _zz_when_FpUnit_l95_13 = 5'h03;
    end
    if(when_FpUnit_l88_679) begin
      _zz_when_FpUnit_l95_13 = 5'h04;
    end
    if(when_FpUnit_l88_680) begin
      _zz_when_FpUnit_l95_13 = 5'h05;
    end
    if(when_FpUnit_l88_681) begin
      _zz_when_FpUnit_l95_13 = 5'h06;
    end
    if(when_FpUnit_l88_682) begin
      _zz_when_FpUnit_l95_13 = 5'h07;
    end
    if(when_FpUnit_l88_683) begin
      _zz_when_FpUnit_l95_13 = 5'h08;
    end
    if(when_FpUnit_l88_684) begin
      _zz_when_FpUnit_l95_13 = 5'h09;
    end
    if(when_FpUnit_l88_685) begin
      _zz_when_FpUnit_l95_13 = 5'h0a;
    end
    if(when_FpUnit_l88_686) begin
      _zz_when_FpUnit_l95_13 = 5'h0b;
    end
    if(when_FpUnit_l88_687) begin
      _zz_when_FpUnit_l95_13 = 5'h0c;
    end
    if(when_FpUnit_l88_688) begin
      _zz_when_FpUnit_l95_13 = 5'h0d;
    end
    if(when_FpUnit_l88_689) begin
      _zz_when_FpUnit_l95_13 = 5'h0e;
    end
    if(when_FpUnit_l88_690) begin
      _zz_when_FpUnit_l95_13 = 5'h0f;
    end
    if(when_FpUnit_l88_691) begin
      _zz_when_FpUnit_l95_13 = 5'h10;
    end
    if(when_FpUnit_l88_692) begin
      _zz_when_FpUnit_l95_13 = 5'h11;
    end
    if(when_FpUnit_l88_693) begin
      _zz_when_FpUnit_l95_13 = 5'h12;
    end
    if(when_FpUnit_l88_694) begin
      _zz_when_FpUnit_l95_13 = 5'h13;
    end
    if(when_FpUnit_l88_695) begin
      _zz_when_FpUnit_l95_13 = 5'h14;
    end
    if(when_FpUnit_l88_696) begin
      _zz_when_FpUnit_l95_13 = 5'h15;
    end
    if(when_FpUnit_l88_697) begin
      _zz_when_FpUnit_l95_13 = 5'h16;
    end
    if(when_FpUnit_l88_698) begin
      _zz_when_FpUnit_l95_13 = 5'h17;
    end
  end

  assign when_FpUnit_l88_675 = _zz_when_FpUnit_l88[0];
  assign when_FpUnit_l88_676 = _zz_when_FpUnit_l88[1];
  assign when_FpUnit_l88_677 = _zz_when_FpUnit_l88[2];
  assign when_FpUnit_l88_678 = _zz_when_FpUnit_l88[3];
  assign when_FpUnit_l88_679 = _zz_when_FpUnit_l88[4];
  assign when_FpUnit_l88_680 = _zz_when_FpUnit_l88[5];
  assign when_FpUnit_l88_681 = _zz_when_FpUnit_l88[6];
  assign when_FpUnit_l88_682 = _zz_when_FpUnit_l88[7];
  assign when_FpUnit_l88_683 = _zz_when_FpUnit_l88[8];
  assign when_FpUnit_l88_684 = _zz_when_FpUnit_l88[9];
  assign when_FpUnit_l88_685 = _zz_when_FpUnit_l88[10];
  assign when_FpUnit_l88_686 = _zz_when_FpUnit_l88[11];
  assign when_FpUnit_l88_687 = _zz_when_FpUnit_l88[12];
  assign when_FpUnit_l88_688 = _zz_when_FpUnit_l88[13];
  assign when_FpUnit_l88_689 = _zz_when_FpUnit_l88[14];
  assign when_FpUnit_l88_690 = _zz_when_FpUnit_l88[15];
  assign when_FpUnit_l88_691 = _zz_when_FpUnit_l88[16];
  assign when_FpUnit_l88_692 = _zz_when_FpUnit_l88[17];
  assign when_FpUnit_l88_693 = _zz_when_FpUnit_l88[18];
  assign when_FpUnit_l88_694 = _zz_when_FpUnit_l88[19];
  assign when_FpUnit_l88_695 = _zz_when_FpUnit_l88[20];
  assign when_FpUnit_l88_696 = _zz_when_FpUnit_l88[21];
  assign when_FpUnit_l88_697 = _zz_when_FpUnit_l88[22];
  assign when_FpUnit_l88_698 = _zz_when_FpUnit_l88[23];
  always @(*) begin
    _zz_flagUF_135 = 27'h0;
    if(when_FpUnit_l94_13) begin
      if(when_FpUnit_l95_13) begin
        _zz_flagUF_135 = _zz__zz_flagUF_135;
      end else begin
        _zz_flagUF_135 = _zz__zz_flagUF_135_2;
      end
    end
  end

  always @(*) begin
    _zz_flagUF_136 = 1'b0;
    if(when_FpUnit_l94_13) begin
      if(when_FpUnit_l95_13) begin
        _zz_flagUF_136 = (|(_zz_when_FpUnit_l88 & _zz__zz_flagUF_136));
      end else begin
        _zz_flagUF_136 = 1'b0;
      end
    end
  end

  assign _zz_flagUF_137 = ($signed(_zz__zz_flagUF_137) + $signed(_zz__zz_flagUF_137_2));
  assign when_FpUnit_l94_13 = (_zz_when_FpUnit_l88 != 24'h0);
  assign when_FpUnit_l95_13 = (5'h1a < _zz_when_FpUnit_l95_13);
  assign _zz_flagUF_138 = (_zz_when_FpUnit_l95_13 - 5'h1a);
  assign _zz_flagUF_139 = _zz__zz_flagUF_139;
  assign _zz_flagUF_140 = _zz_flagUF_139;
  assign _zz_flagUF_141 = (_zz_flagUF_136 || (|(_zz_flagUF_139 & 29'h0)));
  assign _zz_flagUF_142 = ($signed(_zz__zz_flagUF_142) < $signed(12'h001));
  assign _zz_when_FpUnit_l147_17 = (_zz_flagUF_142 ? _zz__zz_when_FpUnit_l147_17 : 12'h0);
  assign _zz_when_FpUnit_l150_13 = _zz_when_FpUnit_l147_17;
  assign when_FpUnit_l147_13 = ($signed(_zz_when_FpUnit_l147_17) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l147_13) begin
      _zz_flagUF_143 = _zz__zz_flagUF_143;
    end else begin
      if(when_FpUnit_l150_13) begin
        _zz_flagUF_143 = 27'h0;
      end else begin
        _zz_flagUF_143 = _zz__zz_flagUF_143_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l147_13) begin
      _zz_flagUF_144 = _zz_flagUF_141;
    end else begin
      if(when_FpUnit_l150_13) begin
        _zz_flagUF_144 = ((|_zz_flagUF_140) || _zz_flagUF_141);
      end else begin
        _zz_flagUF_144 = ((|(_zz_flagUF_140 & _zz__zz_flagUF_144)) || _zz_flagUF_141);
      end
    end
  end

  assign when_FpUnit_l150_13 = (12'h01b <= _zz_when_FpUnit_l150_13);
  assign _zz_when_FpUnit_l186_39 = (_zz_flagUF_142 ? 12'hf82 : _zz_flagUF_137);
  assign _zz_flagUF_145 = _zz_flagUF_143[2];
  assign _zz_flagUF_146 = _zz_flagUF_143[1];
  assign _zz_flagUF_147 = (_zz_flagUF_143[0] || _zz_flagUF_144);
  assign _zz_when_FpUnit_l190_43 = _zz_flagUF_143[26 : 3];
  assign _zz_when_FpUnit_l190_44 = (_zz__zz_when_FpUnit_l190_44 + _zz__zz_when_FpUnit_l190_44_2);
  assign _zz_when_FpUnit_l186_40 = _zz_when_FpUnit_l190_44[24];
  assign _zz_when_FpUnit_l190_45 = (_zz_when_FpUnit_l186_40 ? _zz__zz_when_FpUnit_l190_45 : _zz__zz_when_FpUnit_l190_45_1);
  assign _zz_when_FpUnit_l186_41 = ($signed(_zz__zz_when_FpUnit_l186_41) + $signed(12'h07f));
  assign _zz_flagUF_148 = ((_zz_flagUF_145 || _zz_flagUF_146) || _zz_flagUF_147);
  assign when_FpUnit_l186_13 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l186_41));
  assign _zz_res_77 = {when_FpUnit_l519,{8'hff,23'h0}};
  assign _zz_res_78 = {when_FpUnit_l519,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_79 = 32'h0;
    if(when_FpUnit_l186_13) begin
      _zz_res_79 = ((io_rm == 3'b001) ? _zz_res_78 : ((io_rm == 3'b010) ? (when_FpUnit_l519 ? _zz_res_77 : _zz_res_78) : ((io_rm == 3'b011) ? (when_FpUnit_l519 ? _zz_res_78 : _zz_res_77) : _zz_res_77)));
    end else begin
      if(when_FpUnit_l190_13) begin
        _zz_res_79 = {when_FpUnit_l519,{8'h0,23'h0}};
      end else begin
        if(when_FpUnit_l192_13) begin
          _zz_res_79 = {when_FpUnit_l519,{8'h0,_zz_when_FpUnit_l190_45[22 : 0]}};
        end else begin
          _zz_res_79 = {when_FpUnit_l519,{_zz__zz_res_79,_zz_when_FpUnit_l190_45[22 : 0]}};
        end
      end
    end
  end

  assign when_FpUnit_l190_13 = (_zz_flagUF_142 && (_zz_when_FpUnit_l190_45 == 24'h0));
  assign when_FpUnit_l192_13 = ((_zz_flagUF_142 && (_zz_when_FpUnit_l190_45 != 24'h0)) && (! _zz_when_FpUnit_l190_45[23]));
  always @(*) begin
    _zz_res_80 = _zz_res_79;
    if(when_FpUnit_l342) begin
      _zz_res_80 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l244) begin
        _zz_res_80 = {when_FpUnit_l519,{8'hff,23'h0}};
      end else begin
        if(when_FpUnit_l308) begin
          _zz_res_80 = {when_FpUnit_l519,{8'h0,23'h0}};
        end
      end
    end
  end

  assign _zz_res_81 = io_a[31];
  assign _zz_when_FpUnit_l563 = io_a[30 : 23];
  assign _zz_flagNV_3 = io_a[22 : 0];
  assign when_FpUnit_l563 = ((_zz_when_FpUnit_l563 == 8'h0) && (_zz_flagNV_3 == 23'h0));
  assign when_FpUnit_l562 = ((_zz_when_FpUnit_l563 == 8'hff) && (_zz_flagNV_3 == 23'h0));
  assign when_FpUnit_l561 = ((_zz_when_FpUnit_l563 == 8'hff) && (_zz_flagNV_3 != 23'h0));
  assign _zz_when_FpUnit_l88_176 = ((_zz_when_FpUnit_l563 == 8'h0) && (_zz_flagNV_3 != 23'h0));
  assign _zz_when_FpUnit_l88_177 = (_zz_when_FpUnit_l88_176 ? _zz__zz_when_FpUnit_l88_177 : {1'b1,_zz_flagNV_3});
  always @(*) begin
    _zz_when_FpUnit_l95_14 = 5'h0;
    if(when_FpUnit_l88_699) begin
      _zz_when_FpUnit_l95_14 = 5'h0;
    end
    if(when_FpUnit_l88_700) begin
      _zz_when_FpUnit_l95_14 = 5'h01;
    end
    if(when_FpUnit_l88_701) begin
      _zz_when_FpUnit_l95_14 = 5'h02;
    end
    if(when_FpUnit_l88_702) begin
      _zz_when_FpUnit_l95_14 = 5'h03;
    end
    if(when_FpUnit_l88_703) begin
      _zz_when_FpUnit_l95_14 = 5'h04;
    end
    if(when_FpUnit_l88_704) begin
      _zz_when_FpUnit_l95_14 = 5'h05;
    end
    if(when_FpUnit_l88_705) begin
      _zz_when_FpUnit_l95_14 = 5'h06;
    end
    if(when_FpUnit_l88_706) begin
      _zz_when_FpUnit_l95_14 = 5'h07;
    end
    if(when_FpUnit_l88_707) begin
      _zz_when_FpUnit_l95_14 = 5'h08;
    end
    if(when_FpUnit_l88_708) begin
      _zz_when_FpUnit_l95_14 = 5'h09;
    end
    if(when_FpUnit_l88_709) begin
      _zz_when_FpUnit_l95_14 = 5'h0a;
    end
    if(when_FpUnit_l88_710) begin
      _zz_when_FpUnit_l95_14 = 5'h0b;
    end
    if(when_FpUnit_l88_711) begin
      _zz_when_FpUnit_l95_14 = 5'h0c;
    end
    if(when_FpUnit_l88_712) begin
      _zz_when_FpUnit_l95_14 = 5'h0d;
    end
    if(when_FpUnit_l88_713) begin
      _zz_when_FpUnit_l95_14 = 5'h0e;
    end
    if(when_FpUnit_l88_714) begin
      _zz_when_FpUnit_l95_14 = 5'h0f;
    end
    if(when_FpUnit_l88_715) begin
      _zz_when_FpUnit_l95_14 = 5'h10;
    end
    if(when_FpUnit_l88_716) begin
      _zz_when_FpUnit_l95_14 = 5'h11;
    end
    if(when_FpUnit_l88_717) begin
      _zz_when_FpUnit_l95_14 = 5'h12;
    end
    if(when_FpUnit_l88_718) begin
      _zz_when_FpUnit_l95_14 = 5'h13;
    end
    if(when_FpUnit_l88_719) begin
      _zz_when_FpUnit_l95_14 = 5'h14;
    end
    if(when_FpUnit_l88_720) begin
      _zz_when_FpUnit_l95_14 = 5'h15;
    end
    if(when_FpUnit_l88_721) begin
      _zz_when_FpUnit_l95_14 = 5'h16;
    end
    if(when_FpUnit_l88_722) begin
      _zz_when_FpUnit_l95_14 = 5'h17;
    end
  end

  assign when_FpUnit_l88_699 = _zz_when_FpUnit_l88_177[0];
  assign when_FpUnit_l88_700 = _zz_when_FpUnit_l88_177[1];
  assign when_FpUnit_l88_701 = _zz_when_FpUnit_l88_177[2];
  assign when_FpUnit_l88_702 = _zz_when_FpUnit_l88_177[3];
  assign when_FpUnit_l88_703 = _zz_when_FpUnit_l88_177[4];
  assign when_FpUnit_l88_704 = _zz_when_FpUnit_l88_177[5];
  assign when_FpUnit_l88_705 = _zz_when_FpUnit_l88_177[6];
  assign when_FpUnit_l88_706 = _zz_when_FpUnit_l88_177[7];
  assign when_FpUnit_l88_707 = _zz_when_FpUnit_l88_177[8];
  assign when_FpUnit_l88_708 = _zz_when_FpUnit_l88_177[9];
  assign when_FpUnit_l88_709 = _zz_when_FpUnit_l88_177[10];
  assign when_FpUnit_l88_710 = _zz_when_FpUnit_l88_177[11];
  assign when_FpUnit_l88_711 = _zz_when_FpUnit_l88_177[12];
  assign when_FpUnit_l88_712 = _zz_when_FpUnit_l88_177[13];
  assign when_FpUnit_l88_713 = _zz_when_FpUnit_l88_177[14];
  assign when_FpUnit_l88_714 = _zz_when_FpUnit_l88_177[15];
  assign when_FpUnit_l88_715 = _zz_when_FpUnit_l88_177[16];
  assign when_FpUnit_l88_716 = _zz_when_FpUnit_l88_177[17];
  assign when_FpUnit_l88_717 = _zz_when_FpUnit_l88_177[18];
  assign when_FpUnit_l88_718 = _zz_when_FpUnit_l88_177[19];
  assign when_FpUnit_l88_719 = _zz_when_FpUnit_l88_177[20];
  assign when_FpUnit_l88_720 = _zz_when_FpUnit_l88_177[21];
  assign when_FpUnit_l88_721 = _zz_when_FpUnit_l88_177[22];
  assign when_FpUnit_l88_722 = _zz_when_FpUnit_l88_177[23];
  always @(*) begin
    _zz_when_FpUnit_l190_46 = 27'h0;
    if(when_FpUnit_l94_14) begin
      if(when_FpUnit_l95_14) begin
        _zz_when_FpUnit_l190_46 = _zz__zz_when_FpUnit_l190_46;
      end else begin
        _zz_when_FpUnit_l190_46 = _zz__zz_when_FpUnit_l190_46_2;
      end
    end
  end

  always @(*) begin
    _zz_when_FpUnit_l190_47 = 1'b0;
    if(when_FpUnit_l94_14) begin
      if(when_FpUnit_l95_14) begin
        _zz_when_FpUnit_l190_47 = (|(_zz_when_FpUnit_l88_177 & _zz__zz_when_FpUnit_l190_47));
      end else begin
        _zz_when_FpUnit_l190_47 = 1'b0;
      end
    end
  end

  assign _zz_when_FpUnit_l147_18 = ($signed(_zz__zz_when_FpUnit_l147_18) + $signed(_zz__zz_when_FpUnit_l147_18_2));
  assign when_FpUnit_l94_14 = (_zz_when_FpUnit_l88_177 != 24'h0);
  assign when_FpUnit_l95_14 = (5'h1a < _zz_when_FpUnit_l95_14);
  assign _zz_when_FpUnit_l190_48 = (_zz_when_FpUnit_l95_14 - 5'h1a);
  assign _zz_when_FpUnit_l190_49 = _zz__zz_when_FpUnit_l190_49;
  assign _zz_when_FpUnit_l190_50 = _zz_when_FpUnit_l190_49;
  assign _zz_when_FpUnit_l190_51 = (_zz_when_FpUnit_l190_47 || (|(_zz_when_FpUnit_l190_49 & 29'h0)));
  assign _zz_when_FpUnit_l190_52 = ($signed(_zz__zz_when_FpUnit_l190_52) < $signed(12'h001));
  assign _zz_when_FpUnit_l147_19 = (_zz_when_FpUnit_l190_52 ? _zz__zz_when_FpUnit_l147_19 : 12'h0);
  assign _zz_when_FpUnit_l150_14 = _zz_when_FpUnit_l147_19;
  assign when_FpUnit_l147_14 = ($signed(_zz_when_FpUnit_l147_19) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l147_14) begin
      _zz_when_FpUnit_l190_53 = _zz__zz_when_FpUnit_l190_53;
    end else begin
      if(when_FpUnit_l150_14) begin
        _zz_when_FpUnit_l190_53 = 27'h0;
      end else begin
        _zz_when_FpUnit_l190_53 = _zz__zz_when_FpUnit_l190_53_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l147_14) begin
      _zz_when_FpUnit_l190_54 = _zz_when_FpUnit_l190_51;
    end else begin
      if(when_FpUnit_l150_14) begin
        _zz_when_FpUnit_l190_54 = ((|_zz_when_FpUnit_l190_50) || _zz_when_FpUnit_l190_51);
      end else begin
        _zz_when_FpUnit_l190_54 = ((|(_zz_when_FpUnit_l190_50 & _zz__zz_when_FpUnit_l190_54)) || _zz_when_FpUnit_l190_51);
      end
    end
  end

  assign when_FpUnit_l150_14 = (12'h01b <= _zz_when_FpUnit_l150_14);
  assign _zz_when_FpUnit_l186_42 = (_zz_when_FpUnit_l190_52 ? 12'hf82 : _zz_when_FpUnit_l147_18);
  assign _zz_when_FpUnit_l190_55 = _zz_when_FpUnit_l190_53[2];
  assign _zz_when_FpUnit_l190_56 = _zz_when_FpUnit_l190_53[1];
  assign _zz_when_FpUnit_l190_57 = (_zz_when_FpUnit_l190_53[0] || _zz_when_FpUnit_l190_54);
  assign _zz_when_FpUnit_l190_58 = _zz_when_FpUnit_l190_53[26 : 3];
  assign _zz_when_FpUnit_l190_59 = (_zz__zz_when_FpUnit_l190_59 + _zz__zz_when_FpUnit_l190_59_2);
  assign _zz_when_FpUnit_l186_43 = _zz_when_FpUnit_l190_59[24];
  assign _zz_when_FpUnit_l190_60 = (_zz_when_FpUnit_l186_43 ? _zz__zz_when_FpUnit_l190_60 : _zz__zz_when_FpUnit_l190_60_1);
  assign _zz_when_FpUnit_l186_44 = ($signed(_zz__zz_when_FpUnit_l186_44) + $signed(12'h07f));
  assign when_FpUnit_l186_14 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l186_44));
  assign _zz_res_82 = {_zz_res_81,{8'hff,23'h0}};
  assign _zz_res_83 = {_zz_res_81,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_84 = 32'h0;
    if(when_FpUnit_l186_14) begin
      _zz_res_84 = ((io_rm == 3'b001) ? _zz_res_83 : ((io_rm == 3'b010) ? (_zz_res_81 ? _zz_res_82 : _zz_res_83) : ((io_rm == 3'b011) ? (_zz_res_81 ? _zz_res_83 : _zz_res_82) : _zz_res_82)));
    end else begin
      if(when_FpUnit_l190_14) begin
        _zz_res_84 = {_zz_res_81,{8'h0,23'h0}};
      end else begin
        if(when_FpUnit_l192_14) begin
          _zz_res_84 = {_zz_res_81,{8'h0,_zz_when_FpUnit_l190_60[22 : 0]}};
        end else begin
          _zz_res_84 = {_zz_res_81,{_zz__zz_res_84,_zz_when_FpUnit_l190_60[22 : 0]}};
        end
      end
    end
  end

  assign when_FpUnit_l190_14 = (_zz_when_FpUnit_l190_52 && (_zz_when_FpUnit_l190_60 == 24'h0));
  assign when_FpUnit_l192_14 = ((_zz_when_FpUnit_l190_52 && (_zz_when_FpUnit_l190_60 != 24'h0)) && (! _zz_when_FpUnit_l190_60[23]));
  always @(*) begin
    _zz_res_85 = _zz_res_84;
    if(when_FpUnit_l561) begin
      _zz_res_85 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l562) begin
        _zz_res_85 = {_zz_res_81,{8'hff,23'h0}};
      end else begin
        if(when_FpUnit_l563) begin
          _zz_res_85 = {_zz_res_81,{8'h0,23'h0}};
        end
      end
    end
  end

  assign io_result = res;
  assign io_flags = {flagNV,{flagDZ,{flagOF,{flagUF,flagNX}}}};

endmodule

module FpRegisterFile (
  input  wire [4:0]    io_rs1,
  input  wire [4:0]    io_rs2,
  input  wire [4:0]    io_rs3,
  input  wire [4:0]    io_rd,
  input  wire [31:0]   io_writeData,
  input  wire          io_writeEnable,
  output wire [31:0]   io_rs1Data,
  output wire [31:0]   io_rs2Data,
  output wire [31:0]   io_rs3Data,
  output wire [31:0]   io_debugRegs_0,
  output wire [31:0]   io_debugRegs_1,
  output wire [31:0]   io_debugRegs_2,
  output wire [31:0]   io_debugRegs_3,
  output wire [31:0]   io_debugRegs_4,
  output wire [31:0]   io_debugRegs_5,
  output wire [31:0]   io_debugRegs_6,
  output wire [31:0]   io_debugRegs_7,
  output wire [31:0]   io_debugRegs_8,
  output wire [31:0]   io_debugRegs_9,
  output wire [31:0]   io_debugRegs_10,
  output wire [31:0]   io_debugRegs_11,
  output wire [31:0]   io_debugRegs_12,
  output wire [31:0]   io_debugRegs_13,
  output wire [31:0]   io_debugRegs_14,
  output wire [31:0]   io_debugRegs_15,
  output wire [31:0]   io_debugRegs_16,
  output wire [31:0]   io_debugRegs_17,
  output wire [31:0]   io_debugRegs_18,
  output wire [31:0]   io_debugRegs_19,
  output wire [31:0]   io_debugRegs_20,
  output wire [31:0]   io_debugRegs_21,
  output wire [31:0]   io_debugRegs_22,
  output wire [31:0]   io_debugRegs_23,
  output wire [31:0]   io_debugRegs_24,
  output wire [31:0]   io_debugRegs_25,
  output wire [31:0]   io_debugRegs_26,
  output wire [31:0]   io_debugRegs_27,
  output wire [31:0]   io_debugRegs_28,
  output wire [31:0]   io_debugRegs_29,
  output wire [31:0]   io_debugRegs_30,
  output wire [31:0]   io_debugRegs_31,
  input  wire          clk,
  input  wire          reset
);

  reg        [31:0]   _zz_io_rs1Data;
  reg        [31:0]   _zz_io_rs2Data;
  reg        [31:0]   _zz_io_rs3Data;
  reg        [31:0]   regs_0;
  reg        [31:0]   regs_1;
  reg        [31:0]   regs_2;
  reg        [31:0]   regs_3;
  reg        [31:0]   regs_4;
  reg        [31:0]   regs_5;
  reg        [31:0]   regs_6;
  reg        [31:0]   regs_7;
  reg        [31:0]   regs_8;
  reg        [31:0]   regs_9;
  reg        [31:0]   regs_10;
  reg        [31:0]   regs_11;
  reg        [31:0]   regs_12;
  reg        [31:0]   regs_13;
  reg        [31:0]   regs_14;
  reg        [31:0]   regs_15;
  reg        [31:0]   regs_16;
  reg        [31:0]   regs_17;
  reg        [31:0]   regs_18;
  reg        [31:0]   regs_19;
  reg        [31:0]   regs_20;
  reg        [31:0]   regs_21;
  reg        [31:0]   regs_22;
  reg        [31:0]   regs_23;
  reg        [31:0]   regs_24;
  reg        [31:0]   regs_25;
  reg        [31:0]   regs_26;
  reg        [31:0]   regs_27;
  reg        [31:0]   regs_28;
  reg        [31:0]   regs_29;
  reg        [31:0]   regs_30;
  reg        [31:0]   regs_31;
  wire       [31:0]   _zz_1;

  always @(*) begin
    case(io_rs1)
      5'b00000 : _zz_io_rs1Data = regs_0;
      5'b00001 : _zz_io_rs1Data = regs_1;
      5'b00010 : _zz_io_rs1Data = regs_2;
      5'b00011 : _zz_io_rs1Data = regs_3;
      5'b00100 : _zz_io_rs1Data = regs_4;
      5'b00101 : _zz_io_rs1Data = regs_5;
      5'b00110 : _zz_io_rs1Data = regs_6;
      5'b00111 : _zz_io_rs1Data = regs_7;
      5'b01000 : _zz_io_rs1Data = regs_8;
      5'b01001 : _zz_io_rs1Data = regs_9;
      5'b01010 : _zz_io_rs1Data = regs_10;
      5'b01011 : _zz_io_rs1Data = regs_11;
      5'b01100 : _zz_io_rs1Data = regs_12;
      5'b01101 : _zz_io_rs1Data = regs_13;
      5'b01110 : _zz_io_rs1Data = regs_14;
      5'b01111 : _zz_io_rs1Data = regs_15;
      5'b10000 : _zz_io_rs1Data = regs_16;
      5'b10001 : _zz_io_rs1Data = regs_17;
      5'b10010 : _zz_io_rs1Data = regs_18;
      5'b10011 : _zz_io_rs1Data = regs_19;
      5'b10100 : _zz_io_rs1Data = regs_20;
      5'b10101 : _zz_io_rs1Data = regs_21;
      5'b10110 : _zz_io_rs1Data = regs_22;
      5'b10111 : _zz_io_rs1Data = regs_23;
      5'b11000 : _zz_io_rs1Data = regs_24;
      5'b11001 : _zz_io_rs1Data = regs_25;
      5'b11010 : _zz_io_rs1Data = regs_26;
      5'b11011 : _zz_io_rs1Data = regs_27;
      5'b11100 : _zz_io_rs1Data = regs_28;
      5'b11101 : _zz_io_rs1Data = regs_29;
      5'b11110 : _zz_io_rs1Data = regs_30;
      default : _zz_io_rs1Data = regs_31;
    endcase
  end

  always @(*) begin
    case(io_rs2)
      5'b00000 : _zz_io_rs2Data = regs_0;
      5'b00001 : _zz_io_rs2Data = regs_1;
      5'b00010 : _zz_io_rs2Data = regs_2;
      5'b00011 : _zz_io_rs2Data = regs_3;
      5'b00100 : _zz_io_rs2Data = regs_4;
      5'b00101 : _zz_io_rs2Data = regs_5;
      5'b00110 : _zz_io_rs2Data = regs_6;
      5'b00111 : _zz_io_rs2Data = regs_7;
      5'b01000 : _zz_io_rs2Data = regs_8;
      5'b01001 : _zz_io_rs2Data = regs_9;
      5'b01010 : _zz_io_rs2Data = regs_10;
      5'b01011 : _zz_io_rs2Data = regs_11;
      5'b01100 : _zz_io_rs2Data = regs_12;
      5'b01101 : _zz_io_rs2Data = regs_13;
      5'b01110 : _zz_io_rs2Data = regs_14;
      5'b01111 : _zz_io_rs2Data = regs_15;
      5'b10000 : _zz_io_rs2Data = regs_16;
      5'b10001 : _zz_io_rs2Data = regs_17;
      5'b10010 : _zz_io_rs2Data = regs_18;
      5'b10011 : _zz_io_rs2Data = regs_19;
      5'b10100 : _zz_io_rs2Data = regs_20;
      5'b10101 : _zz_io_rs2Data = regs_21;
      5'b10110 : _zz_io_rs2Data = regs_22;
      5'b10111 : _zz_io_rs2Data = regs_23;
      5'b11000 : _zz_io_rs2Data = regs_24;
      5'b11001 : _zz_io_rs2Data = regs_25;
      5'b11010 : _zz_io_rs2Data = regs_26;
      5'b11011 : _zz_io_rs2Data = regs_27;
      5'b11100 : _zz_io_rs2Data = regs_28;
      5'b11101 : _zz_io_rs2Data = regs_29;
      5'b11110 : _zz_io_rs2Data = regs_30;
      default : _zz_io_rs2Data = regs_31;
    endcase
  end

  always @(*) begin
    case(io_rs3)
      5'b00000 : _zz_io_rs3Data = regs_0;
      5'b00001 : _zz_io_rs3Data = regs_1;
      5'b00010 : _zz_io_rs3Data = regs_2;
      5'b00011 : _zz_io_rs3Data = regs_3;
      5'b00100 : _zz_io_rs3Data = regs_4;
      5'b00101 : _zz_io_rs3Data = regs_5;
      5'b00110 : _zz_io_rs3Data = regs_6;
      5'b00111 : _zz_io_rs3Data = regs_7;
      5'b01000 : _zz_io_rs3Data = regs_8;
      5'b01001 : _zz_io_rs3Data = regs_9;
      5'b01010 : _zz_io_rs3Data = regs_10;
      5'b01011 : _zz_io_rs3Data = regs_11;
      5'b01100 : _zz_io_rs3Data = regs_12;
      5'b01101 : _zz_io_rs3Data = regs_13;
      5'b01110 : _zz_io_rs3Data = regs_14;
      5'b01111 : _zz_io_rs3Data = regs_15;
      5'b10000 : _zz_io_rs3Data = regs_16;
      5'b10001 : _zz_io_rs3Data = regs_17;
      5'b10010 : _zz_io_rs3Data = regs_18;
      5'b10011 : _zz_io_rs3Data = regs_19;
      5'b10100 : _zz_io_rs3Data = regs_20;
      5'b10101 : _zz_io_rs3Data = regs_21;
      5'b10110 : _zz_io_rs3Data = regs_22;
      5'b10111 : _zz_io_rs3Data = regs_23;
      5'b11000 : _zz_io_rs3Data = regs_24;
      5'b11001 : _zz_io_rs3Data = regs_25;
      5'b11010 : _zz_io_rs3Data = regs_26;
      5'b11011 : _zz_io_rs3Data = regs_27;
      5'b11100 : _zz_io_rs3Data = regs_28;
      5'b11101 : _zz_io_rs3Data = regs_29;
      5'b11110 : _zz_io_rs3Data = regs_30;
      default : _zz_io_rs3Data = regs_31;
    endcase
  end

  assign _zz_1 = ({31'd0,1'b1} <<< io_rd);
  assign io_rs1Data = _zz_io_rs1Data;
  assign io_rs2Data = _zz_io_rs2Data;
  assign io_rs3Data = _zz_io_rs3Data;
  assign io_debugRegs_0 = regs_0;
  assign io_debugRegs_1 = regs_1;
  assign io_debugRegs_2 = regs_2;
  assign io_debugRegs_3 = regs_3;
  assign io_debugRegs_4 = regs_4;
  assign io_debugRegs_5 = regs_5;
  assign io_debugRegs_6 = regs_6;
  assign io_debugRegs_7 = regs_7;
  assign io_debugRegs_8 = regs_8;
  assign io_debugRegs_9 = regs_9;
  assign io_debugRegs_10 = regs_10;
  assign io_debugRegs_11 = regs_11;
  assign io_debugRegs_12 = regs_12;
  assign io_debugRegs_13 = regs_13;
  assign io_debugRegs_14 = regs_14;
  assign io_debugRegs_15 = regs_15;
  assign io_debugRegs_16 = regs_16;
  assign io_debugRegs_17 = regs_17;
  assign io_debugRegs_18 = regs_18;
  assign io_debugRegs_19 = regs_19;
  assign io_debugRegs_20 = regs_20;
  assign io_debugRegs_21 = regs_21;
  assign io_debugRegs_22 = regs_22;
  assign io_debugRegs_23 = regs_23;
  assign io_debugRegs_24 = regs_24;
  assign io_debugRegs_25 = regs_25;
  assign io_debugRegs_26 = regs_26;
  assign io_debugRegs_27 = regs_27;
  assign io_debugRegs_28 = regs_28;
  assign io_debugRegs_29 = regs_29;
  assign io_debugRegs_30 = regs_30;
  assign io_debugRegs_31 = regs_31;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      regs_0 <= 32'h0;
      regs_1 <= 32'h0;
      regs_2 <= 32'h0;
      regs_3 <= 32'h0;
      regs_4 <= 32'h0;
      regs_5 <= 32'h0;
      regs_6 <= 32'h0;
      regs_7 <= 32'h0;
      regs_8 <= 32'h0;
      regs_9 <= 32'h0;
      regs_10 <= 32'h0;
      regs_11 <= 32'h0;
      regs_12 <= 32'h0;
      regs_13 <= 32'h0;
      regs_14 <= 32'h0;
      regs_15 <= 32'h0;
      regs_16 <= 32'h0;
      regs_17 <= 32'h0;
      regs_18 <= 32'h0;
      regs_19 <= 32'h0;
      regs_20 <= 32'h0;
      regs_21 <= 32'h0;
      regs_22 <= 32'h0;
      regs_23 <= 32'h0;
      regs_24 <= 32'h0;
      regs_25 <= 32'h0;
      regs_26 <= 32'h0;
      regs_27 <= 32'h0;
      regs_28 <= 32'h0;
      regs_29 <= 32'h0;
      regs_30 <= 32'h0;
      regs_31 <= 32'h0;
    end else begin
      if(io_writeEnable) begin
        if(_zz_1[0]) begin
          regs_0 <= io_writeData;
        end
        if(_zz_1[1]) begin
          regs_1 <= io_writeData;
        end
        if(_zz_1[2]) begin
          regs_2 <= io_writeData;
        end
        if(_zz_1[3]) begin
          regs_3 <= io_writeData;
        end
        if(_zz_1[4]) begin
          regs_4 <= io_writeData;
        end
        if(_zz_1[5]) begin
          regs_5 <= io_writeData;
        end
        if(_zz_1[6]) begin
          regs_6 <= io_writeData;
        end
        if(_zz_1[7]) begin
          regs_7 <= io_writeData;
        end
        if(_zz_1[8]) begin
          regs_8 <= io_writeData;
        end
        if(_zz_1[9]) begin
          regs_9 <= io_writeData;
        end
        if(_zz_1[10]) begin
          regs_10 <= io_writeData;
        end
        if(_zz_1[11]) begin
          regs_11 <= io_writeData;
        end
        if(_zz_1[12]) begin
          regs_12 <= io_writeData;
        end
        if(_zz_1[13]) begin
          regs_13 <= io_writeData;
        end
        if(_zz_1[14]) begin
          regs_14 <= io_writeData;
        end
        if(_zz_1[15]) begin
          regs_15 <= io_writeData;
        end
        if(_zz_1[16]) begin
          regs_16 <= io_writeData;
        end
        if(_zz_1[17]) begin
          regs_17 <= io_writeData;
        end
        if(_zz_1[18]) begin
          regs_18 <= io_writeData;
        end
        if(_zz_1[19]) begin
          regs_19 <= io_writeData;
        end
        if(_zz_1[20]) begin
          regs_20 <= io_writeData;
        end
        if(_zz_1[21]) begin
          regs_21 <= io_writeData;
        end
        if(_zz_1[22]) begin
          regs_22 <= io_writeData;
        end
        if(_zz_1[23]) begin
          regs_23 <= io_writeData;
        end
        if(_zz_1[24]) begin
          regs_24 <= io_writeData;
        end
        if(_zz_1[25]) begin
          regs_25 <= io_writeData;
        end
        if(_zz_1[26]) begin
          regs_26 <= io_writeData;
        end
        if(_zz_1[27]) begin
          regs_27 <= io_writeData;
        end
        if(_zz_1[28]) begin
          regs_28 <= io_writeData;
        end
        if(_zz_1[29]) begin
          regs_29 <= io_writeData;
        end
        if(_zz_1[30]) begin
          regs_30 <= io_writeData;
        end
        if(_zz_1[31]) begin
          regs_31 <= io_writeData;
        end
      end
    end
  end


endmodule

module RegisterFile (
  input  wire [4:0]    io_rs1,
  input  wire [4:0]    io_rs2,
  input  wire [4:0]    io_rd,
  input  wire [63:0]   io_writeData,
  input  wire          io_writeEnable,
  output wire [63:0]   io_rs1Data,
  output wire [63:0]   io_rs2Data,
  output wire [63:0]   io_debugRegs_0,
  output wire [63:0]   io_debugRegs_1,
  output wire [63:0]   io_debugRegs_2,
  output wire [63:0]   io_debugRegs_3,
  output wire [63:0]   io_debugRegs_4,
  output wire [63:0]   io_debugRegs_5,
  output wire [63:0]   io_debugRegs_6,
  output wire [63:0]   io_debugRegs_7,
  output wire [63:0]   io_debugRegs_8,
  output wire [63:0]   io_debugRegs_9,
  output wire [63:0]   io_debugRegs_10,
  output wire [63:0]   io_debugRegs_11,
  output wire [63:0]   io_debugRegs_12,
  output wire [63:0]   io_debugRegs_13,
  output wire [63:0]   io_debugRegs_14,
  output wire [63:0]   io_debugRegs_15,
  output wire [63:0]   io_debugRegs_16,
  output wire [63:0]   io_debugRegs_17,
  output wire [63:0]   io_debugRegs_18,
  output wire [63:0]   io_debugRegs_19,
  output wire [63:0]   io_debugRegs_20,
  output wire [63:0]   io_debugRegs_21,
  output wire [63:0]   io_debugRegs_22,
  output wire [63:0]   io_debugRegs_23,
  output wire [63:0]   io_debugRegs_24,
  output wire [63:0]   io_debugRegs_25,
  output wire [63:0]   io_debugRegs_26,
  output wire [63:0]   io_debugRegs_27,
  output wire [63:0]   io_debugRegs_28,
  output wire [63:0]   io_debugRegs_29,
  output wire [63:0]   io_debugRegs_30,
  output wire [63:0]   io_debugRegs_31,
  input  wire          clk,
  input  wire          reset
);

  reg        [63:0]   _zz_io_rs1Data;
  reg        [63:0]   _zz_io_rs2Data;
  reg        [63:0]   regs_0;
  reg        [63:0]   regs_1;
  reg        [63:0]   regs_2;
  reg        [63:0]   regs_3;
  reg        [63:0]   regs_4;
  reg        [63:0]   regs_5;
  reg        [63:0]   regs_6;
  reg        [63:0]   regs_7;
  reg        [63:0]   regs_8;
  reg        [63:0]   regs_9;
  reg        [63:0]   regs_10;
  reg        [63:0]   regs_11;
  reg        [63:0]   regs_12;
  reg        [63:0]   regs_13;
  reg        [63:0]   regs_14;
  reg        [63:0]   regs_15;
  reg        [63:0]   regs_16;
  reg        [63:0]   regs_17;
  reg        [63:0]   regs_18;
  reg        [63:0]   regs_19;
  reg        [63:0]   regs_20;
  reg        [63:0]   regs_21;
  reg        [63:0]   regs_22;
  reg        [63:0]   regs_23;
  reg        [63:0]   regs_24;
  reg        [63:0]   regs_25;
  reg        [63:0]   regs_26;
  reg        [63:0]   regs_27;
  reg        [63:0]   regs_28;
  reg        [63:0]   regs_29;
  reg        [63:0]   regs_30;
  reg        [63:0]   regs_31;
  wire                when_RegisterFile_l19;
  wire       [31:0]   _zz_1;

  always @(*) begin
    case(io_rs1)
      5'b00000 : _zz_io_rs1Data = regs_0;
      5'b00001 : _zz_io_rs1Data = regs_1;
      5'b00010 : _zz_io_rs1Data = regs_2;
      5'b00011 : _zz_io_rs1Data = regs_3;
      5'b00100 : _zz_io_rs1Data = regs_4;
      5'b00101 : _zz_io_rs1Data = regs_5;
      5'b00110 : _zz_io_rs1Data = regs_6;
      5'b00111 : _zz_io_rs1Data = regs_7;
      5'b01000 : _zz_io_rs1Data = regs_8;
      5'b01001 : _zz_io_rs1Data = regs_9;
      5'b01010 : _zz_io_rs1Data = regs_10;
      5'b01011 : _zz_io_rs1Data = regs_11;
      5'b01100 : _zz_io_rs1Data = regs_12;
      5'b01101 : _zz_io_rs1Data = regs_13;
      5'b01110 : _zz_io_rs1Data = regs_14;
      5'b01111 : _zz_io_rs1Data = regs_15;
      5'b10000 : _zz_io_rs1Data = regs_16;
      5'b10001 : _zz_io_rs1Data = regs_17;
      5'b10010 : _zz_io_rs1Data = regs_18;
      5'b10011 : _zz_io_rs1Data = regs_19;
      5'b10100 : _zz_io_rs1Data = regs_20;
      5'b10101 : _zz_io_rs1Data = regs_21;
      5'b10110 : _zz_io_rs1Data = regs_22;
      5'b10111 : _zz_io_rs1Data = regs_23;
      5'b11000 : _zz_io_rs1Data = regs_24;
      5'b11001 : _zz_io_rs1Data = regs_25;
      5'b11010 : _zz_io_rs1Data = regs_26;
      5'b11011 : _zz_io_rs1Data = regs_27;
      5'b11100 : _zz_io_rs1Data = regs_28;
      5'b11101 : _zz_io_rs1Data = regs_29;
      5'b11110 : _zz_io_rs1Data = regs_30;
      default : _zz_io_rs1Data = regs_31;
    endcase
  end

  always @(*) begin
    case(io_rs2)
      5'b00000 : _zz_io_rs2Data = regs_0;
      5'b00001 : _zz_io_rs2Data = regs_1;
      5'b00010 : _zz_io_rs2Data = regs_2;
      5'b00011 : _zz_io_rs2Data = regs_3;
      5'b00100 : _zz_io_rs2Data = regs_4;
      5'b00101 : _zz_io_rs2Data = regs_5;
      5'b00110 : _zz_io_rs2Data = regs_6;
      5'b00111 : _zz_io_rs2Data = regs_7;
      5'b01000 : _zz_io_rs2Data = regs_8;
      5'b01001 : _zz_io_rs2Data = regs_9;
      5'b01010 : _zz_io_rs2Data = regs_10;
      5'b01011 : _zz_io_rs2Data = regs_11;
      5'b01100 : _zz_io_rs2Data = regs_12;
      5'b01101 : _zz_io_rs2Data = regs_13;
      5'b01110 : _zz_io_rs2Data = regs_14;
      5'b01111 : _zz_io_rs2Data = regs_15;
      5'b10000 : _zz_io_rs2Data = regs_16;
      5'b10001 : _zz_io_rs2Data = regs_17;
      5'b10010 : _zz_io_rs2Data = regs_18;
      5'b10011 : _zz_io_rs2Data = regs_19;
      5'b10100 : _zz_io_rs2Data = regs_20;
      5'b10101 : _zz_io_rs2Data = regs_21;
      5'b10110 : _zz_io_rs2Data = regs_22;
      5'b10111 : _zz_io_rs2Data = regs_23;
      5'b11000 : _zz_io_rs2Data = regs_24;
      5'b11001 : _zz_io_rs2Data = regs_25;
      5'b11010 : _zz_io_rs2Data = regs_26;
      5'b11011 : _zz_io_rs2Data = regs_27;
      5'b11100 : _zz_io_rs2Data = regs_28;
      5'b11101 : _zz_io_rs2Data = regs_29;
      5'b11110 : _zz_io_rs2Data = regs_30;
      default : _zz_io_rs2Data = regs_31;
    endcase
  end

  assign when_RegisterFile_l19 = (io_writeEnable && (io_rd != 5'h0));
  assign _zz_1 = ({31'd0,1'b1} <<< io_rd);
  assign io_rs1Data = ((io_rs1 == 5'h0) ? 64'h0 : _zz_io_rs1Data);
  assign io_rs2Data = ((io_rs2 == 5'h0) ? 64'h0 : _zz_io_rs2Data);
  assign io_debugRegs_0 = regs_0;
  assign io_debugRegs_1 = regs_1;
  assign io_debugRegs_2 = regs_2;
  assign io_debugRegs_3 = regs_3;
  assign io_debugRegs_4 = regs_4;
  assign io_debugRegs_5 = regs_5;
  assign io_debugRegs_6 = regs_6;
  assign io_debugRegs_7 = regs_7;
  assign io_debugRegs_8 = regs_8;
  assign io_debugRegs_9 = regs_9;
  assign io_debugRegs_10 = regs_10;
  assign io_debugRegs_11 = regs_11;
  assign io_debugRegs_12 = regs_12;
  assign io_debugRegs_13 = regs_13;
  assign io_debugRegs_14 = regs_14;
  assign io_debugRegs_15 = regs_15;
  assign io_debugRegs_16 = regs_16;
  assign io_debugRegs_17 = regs_17;
  assign io_debugRegs_18 = regs_18;
  assign io_debugRegs_19 = regs_19;
  assign io_debugRegs_20 = regs_20;
  assign io_debugRegs_21 = regs_21;
  assign io_debugRegs_22 = regs_22;
  assign io_debugRegs_23 = regs_23;
  assign io_debugRegs_24 = regs_24;
  assign io_debugRegs_25 = regs_25;
  assign io_debugRegs_26 = regs_26;
  assign io_debugRegs_27 = regs_27;
  assign io_debugRegs_28 = regs_28;
  assign io_debugRegs_29 = regs_29;
  assign io_debugRegs_30 = regs_30;
  assign io_debugRegs_31 = regs_31;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      regs_0 <= 64'h0;
      regs_1 <= 64'h0;
      regs_2 <= 64'h0;
      regs_3 <= 64'h0;
      regs_4 <= 64'h0;
      regs_5 <= 64'h0;
      regs_6 <= 64'h0;
      regs_7 <= 64'h0;
      regs_8 <= 64'h0;
      regs_9 <= 64'h0;
      regs_10 <= 64'h0;
      regs_11 <= 64'h0;
      regs_12 <= 64'h0;
      regs_13 <= 64'h0;
      regs_14 <= 64'h0;
      regs_15 <= 64'h0;
      regs_16 <= 64'h0;
      regs_17 <= 64'h0;
      regs_18 <= 64'h0;
      regs_19 <= 64'h0;
      regs_20 <= 64'h0;
      regs_21 <= 64'h0;
      regs_22 <= 64'h0;
      regs_23 <= 64'h0;
      regs_24 <= 64'h0;
      regs_25 <= 64'h0;
      regs_26 <= 64'h0;
      regs_27 <= 64'h0;
      regs_28 <= 64'h0;
      regs_29 <= 64'h0;
      regs_30 <= 64'h0;
      regs_31 <= 64'h0;
    end else begin
      if(when_RegisterFile_l19) begin
        if(_zz_1[0]) begin
          regs_0 <= io_writeData;
        end
        if(_zz_1[1]) begin
          regs_1 <= io_writeData;
        end
        if(_zz_1[2]) begin
          regs_2 <= io_writeData;
        end
        if(_zz_1[3]) begin
          regs_3 <= io_writeData;
        end
        if(_zz_1[4]) begin
          regs_4 <= io_writeData;
        end
        if(_zz_1[5]) begin
          regs_5 <= io_writeData;
        end
        if(_zz_1[6]) begin
          regs_6 <= io_writeData;
        end
        if(_zz_1[7]) begin
          regs_7 <= io_writeData;
        end
        if(_zz_1[8]) begin
          regs_8 <= io_writeData;
        end
        if(_zz_1[9]) begin
          regs_9 <= io_writeData;
        end
        if(_zz_1[10]) begin
          regs_10 <= io_writeData;
        end
        if(_zz_1[11]) begin
          regs_11 <= io_writeData;
        end
        if(_zz_1[12]) begin
          regs_12 <= io_writeData;
        end
        if(_zz_1[13]) begin
          regs_13 <= io_writeData;
        end
        if(_zz_1[14]) begin
          regs_14 <= io_writeData;
        end
        if(_zz_1[15]) begin
          regs_15 <= io_writeData;
        end
        if(_zz_1[16]) begin
          regs_16 <= io_writeData;
        end
        if(_zz_1[17]) begin
          regs_17 <= io_writeData;
        end
        if(_zz_1[18]) begin
          regs_18 <= io_writeData;
        end
        if(_zz_1[19]) begin
          regs_19 <= io_writeData;
        end
        if(_zz_1[20]) begin
          regs_20 <= io_writeData;
        end
        if(_zz_1[21]) begin
          regs_21 <= io_writeData;
        end
        if(_zz_1[22]) begin
          regs_22 <= io_writeData;
        end
        if(_zz_1[23]) begin
          regs_23 <= io_writeData;
        end
        if(_zz_1[24]) begin
          regs_24 <= io_writeData;
        end
        if(_zz_1[25]) begin
          regs_25 <= io_writeData;
        end
        if(_zz_1[26]) begin
          regs_26 <= io_writeData;
        end
        if(_zz_1[27]) begin
          regs_27 <= io_writeData;
        end
        if(_zz_1[28]) begin
          regs_28 <= io_writeData;
        end
        if(_zz_1[29]) begin
          regs_29 <= io_writeData;
        end
        if(_zz_1[30]) begin
          regs_30 <= io_writeData;
        end
        if(_zz_1[31]) begin
          regs_31 <= io_writeData;
        end
      end
    end
  end


endmodule

module Decoder (
  input  wire [31:0]   io_instruction,
  output reg           io_output_regWrite,
  output reg           io_output_aluSrc,
  output reg  [2:0]    io_output_wbSel,
  output reg           io_output_branch,
  output reg           io_output_jump,
  output reg           io_output_jalr,
  output reg  [6:0]    io_output_aluOp,
  output reg  [2:0]    io_output_branchType,
  output reg  [1:0]    io_output_aluASrc,
  output reg           io_output_memRead,
  output reg           io_output_memWrite,
  output reg  [1:0]    io_output_memSize,
  output reg           io_output_memSign,
  output wire          io_output_atomic,
  output wire          io_output_isLr,
  output wire          io_output_isSc,
  output wire [4:0]    io_output_amoOp,
  output reg           io_output_fp,
  output reg           io_output_fpWrite,
  output reg           io_output_fpLoad,
  output reg           io_output_fpStore,
  output reg           io_output_fpIntRd,
  output reg  [5:0]    io_output_fpOp,
  output reg  [2:0]    io_output_fpRm,
  output reg           io_output_fpFmt,
  output reg  [4:0]    io_output_rs3,
  output reg  [4:0]    io_output_rs1,
  output reg  [4:0]    io_output_rs2,
  output reg  [4:0]    io_output_rd,
  output reg  [63:0]   io_output_imm,
  output reg           io_output_illegal,
  output reg  [1:0]    io_output_csrOp,
  output reg  [11:0]   io_output_csrAddr,
  output reg           io_output_csrImm,
  output reg           io_output_csrWe,
  output reg  [2:0]    io_output_sysOp,
  output reg           io_output_valid
);
  localparam AluOp_ADD = 7'd0;
  localparam AluOp_SUB = 7'd1;
  localparam AluOp_SLL_1 = 7'd2;
  localparam AluOp_SLT = 7'd3;
  localparam AluOp_SLTU = 7'd4;
  localparam AluOp_XOR_1 = 7'd5;
  localparam AluOp_SRL_1 = 7'd6;
  localparam AluOp_SRA_1 = 7'd7;
  localparam AluOp_OR_1 = 7'd8;
  localparam AluOp_AND_1 = 7'd9;
  localparam AluOp_ADDW = 7'd10;
  localparam AluOp_SUBW = 7'd11;
  localparam AluOp_SLLW = 7'd12;
  localparam AluOp_SRLW = 7'd13;
  localparam AluOp_SRAW = 7'd14;
  localparam AluOp_MUL = 7'd15;
  localparam AluOp_MULH = 7'd16;
  localparam AluOp_MULHSU = 7'd17;
  localparam AluOp_MULHU = 7'd18;
  localparam AluOp_DIV = 7'd19;
  localparam AluOp_DIVU = 7'd20;
  localparam AluOp_REM_1 = 7'd21;
  localparam AluOp_REMU = 7'd22;
  localparam AluOp_MULW = 7'd23;
  localparam AluOp_DIVW = 7'd24;
  localparam AluOp_DIVUW = 7'd25;
  localparam AluOp_REMW = 7'd26;
  localparam AluOp_REMUW = 7'd27;
  localparam AluOp_ANDN = 7'd28;
  localparam AluOp_ORN = 7'd29;
  localparam AluOp_XNOR_1 = 7'd30;
  localparam AluOp_CLZ = 7'd31;
  localparam AluOp_CTZ = 7'd32;
  localparam AluOp_CPOP = 7'd33;
  localparam AluOp_SEXTB = 7'd34;
  localparam AluOp_SEXTH = 7'd35;
  localparam AluOp_ZEXTH = 7'd36;
  localparam AluOp_ORCB = 7'd37;
  localparam AluOp_REV8 = 7'd38;
  localparam AluOp_ROL_1 = 7'd39;
  localparam AluOp_ROR_1 = 7'd40;
  localparam AluOp_MIN = 7'd41;
  localparam AluOp_MINU = 7'd42;
  localparam AluOp_MAX = 7'd43;
  localparam AluOp_MAXU = 7'd44;
  localparam AluOp_BSET = 7'd45;
  localparam AluOp_BCLR = 7'd46;
  localparam AluOp_BINV = 7'd47;
  localparam AluOp_BEXT = 7'd48;
  localparam AluOp_SH1ADD = 7'd49;
  localparam AluOp_SH2ADD = 7'd50;
  localparam AluOp_SH3ADD = 7'd51;
  localparam AluOp_ADDUW = 7'd52;
  localparam AluOp_SH1ADDUW = 7'd53;
  localparam AluOp_SH2ADDUW = 7'd54;
  localparam AluOp_SH3ADDUW = 7'd55;
  localparam AluOp_SLLIUW = 7'd56;
  localparam AluOp_CLMUL = 7'd57;
  localparam AluOp_CLMULH = 7'd58;
  localparam AluOp_CLMULR = 7'd59;
  localparam AluOp_CLZW = 7'd60;
  localparam AluOp_CTZW = 7'd61;
  localparam AluOp_CPOPW = 7'd62;
  localparam AluOp_ROLW = 7'd63;
  localparam AluOp_RORW = 7'd64;
  localparam BranchOp_NONE = 3'd0;
  localparam BranchOp_BEQ = 3'd1;
  localparam BranchOp_BNE = 3'd2;
  localparam BranchOp_BLT = 3'd3;
  localparam BranchOp_BGE = 3'd4;
  localparam BranchOp_BLTU = 3'd5;
  localparam BranchOp_BGEU = 3'd6;
  localparam CsrOp_NONE = 2'd0;
  localparam CsrOp_WRITE = 2'd1;
  localparam CsrOp_SET = 2'd2;
  localparam CsrOp_CLEAR = 2'd3;
  localparam SysOp_NONE = 3'd0;
  localparam SysOp_ECALL = 3'd1;
  localparam SysOp_EBREAK = 3'd2;
  localparam SysOp_MRET = 3'd3;
  localparam SysOp_WFI = 3'd4;
  localparam SysOp_ILLEGAL = 3'd5;

  wire       [11:0]   _zz_immI;
  wire       [11:0]   _zz_immS;
  wire       [64:0]   _zz_immB;
  wire       [63:0]   _zz_immB_1;
  wire       [11:0]   _zz_immB_2;
  wire       [31:0]   _zz_immU;
  wire       [31:0]   _zz_immU_1;
  wire       [64:0]   _zz_immJ;
  wire       [63:0]   _zz_immJ_1;
  wire       [19:0]   _zz_immJ_2;
  wire       [4:0]    _zz_crdp;
  wire       [2:0]    _zz_crdp_1;
  wire       [4:0]    _zz_crs1p;
  wire       [2:0]    _zz_crs1p_1;
  wire       [4:0]    _zz_crs2p;
  wire       [2:0]    _zz_crs2p_1;
  wire       [63:0]   _zz_cShamt;
  wire       [5:0]    _zz_cShamt_1;
  wire                _zz_cJImm;
  wire       [0:0]    _zz_cJImm_1;
  wire       [2:0]    _zz_cJImm_2;
  wire       [9:0]    _zz_cAddi16sp;
  wire       [7:0]    _zz_cLdImm;
  wire       [8:0]    _zz_cLdspImm;
  wire       [8:0]    _zz_cSdspImm;
  wire       [63:0]   _zz_io_output_imm;
  wire       [63:0]   _zz_io_output_imm_1;
  wire       [63:0]   _zz_io_output_imm_2;
  wire       [17:0]   _zz_io_output_imm_3;
  wire       [63:0]   _zz_io_output_imm_4;
  wire       [63:0]   _zz_io_output_imm_5;
  wire       [6:0]    opcode;
  wire       [2:0]    funct3;
  wire       [6:0]    funct7;
  wire       [4:0]    funct5;
  wire       [5:0]    funct6;
  wire       [1:0]    convSel;
  wire       [4:0]    rs1Num;
  wire       [4:0]    rdNum;
  wire       [63:0]   immI;
  wire       [63:0]   immS;
  wire       [63:0]   immB;
  wire       [63:0]   immU;
  wire       [63:0]   immJ;
  reg                 csrWrite;
  wire                when_Decoder_l155;
  wire                isComp;
  wire       [2:0]    cfunct3;
  wire       [4:0]    crd;
  wire       [4:0]    crs2;
  wire       [4:0]    crdp;
  wire       [4:0]    crs1p;
  wire       [4:0]    crs2p;
  wire       [5:0]    c6;
  wire       [5:0]    c6S;
  wire       [63:0]   cShamt;
  wire       [9:0]    cAddi4spn;
  wire       [6:0]    cLwImm;
  wire       [7:0]    cLwspImm;
  wire       [7:0]    cSwspImm;
  wire       [11:0]   cJImm;
  wire       [8:0]    cBImm;
  wire       [9:0]    cAddi16sp;
  wire       [7:0]    cLdImm;
  wire       [8:0]    cLdspImm;
  wire       [8:0]    cSdspImm;
  wire       [1:0]    switch_Decoder_l192;
  wire                when_Decoder_l196;
  wire                when_Decoder_l243;
  wire                when_Decoder_l259;
  wire                when_Decoder_l264;
  wire       [1:0]    switch_Decoder_l274;
  wire                when_Decoder_l302;
  wire       [1:0]    switch_Decoder_l304;
  wire       [6:0]    _zz_io_output_aluOp;
  wire       [6:0]    _zz_io_output_aluOp_1;
  wire       [6:0]    _zz_io_output_aluOp_2;
  wire                when_Decoder_l356;
  wire                when_Decoder_l364;
  wire                when_Decoder_l374;
  wire                when_Decoder_l375;
  wire                when_Decoder_l376;
  wire                when_Decoder_l387;
  wire                when_Decoder_l388;
  wire                when_Decoder_l544;
  wire                when_Decoder_l590;
  wire                when_Decoder_l644;
  wire                when_Decoder_l653;
  wire                when_Decoder_l662;
  wire                when_Decoder_l671;
  wire       [6:0]    _zz_io_output_aluOp_3;
  wire       [6:0]    _zz_io_output_aluOp_4;
  wire                when_Decoder_l882;
  wire       [6:0]    _zz_io_output_aluOp_5;
  wire       [6:0]    _zz_io_output_aluOp_6;
  wire       [11:0]   switch_Decoder_l1024;
  `ifndef SYNTHESIS
  reg [63:0] io_output_aluOp_string;
  reg [31:0] io_output_branchType_string;
  reg [39:0] io_output_csrOp_string;
  reg [55:0] io_output_sysOp_string;
  reg [63:0] _zz_io_output_aluOp_string;
  reg [63:0] _zz_io_output_aluOp_1_string;
  reg [63:0] _zz_io_output_aluOp_2_string;
  reg [63:0] _zz_io_output_aluOp_3_string;
  reg [63:0] _zz_io_output_aluOp_4_string;
  reg [63:0] _zz_io_output_aluOp_5_string;
  reg [63:0] _zz_io_output_aluOp_6_string;
  `endif


  assign _zz_immI = io_instruction[31 : 20];
  assign _zz_immS = {io_instruction[31 : 25],io_instruction[11 : 7]};
  assign _zz_immB = ({1'd0,_zz_immB_1} <<< 1'd1);
  assign _zz_immB_2 = {io_instruction[31],{io_instruction[7],{io_instruction[30 : 25],io_instruction[11 : 8]}}};
  assign _zz_immB_1 = {{52{_zz_immB_2[11]}}, _zz_immB_2};
  assign _zz_immU = _zz_immU_1;
  assign _zz_immU_1 = ({12'd0,io_instruction[31 : 12]} <<< 4'd12);
  assign _zz_immJ = ({1'd0,_zz_immJ_1} <<< 1'd1);
  assign _zz_immJ_2 = {io_instruction[31],{io_instruction[19 : 12],{io_instruction[20],io_instruction[30 : 21]}}};
  assign _zz_immJ_1 = {{44{_zz_immJ_2[19]}}, _zz_immJ_2};
  assign _zz_crdp_1 = io_instruction[4 : 2];
  assign _zz_crdp = {2'd0, _zz_crdp_1};
  assign _zz_crs1p_1 = io_instruction[9 : 7];
  assign _zz_crs1p = {2'd0, _zz_crs1p_1};
  assign _zz_crs2p_1 = io_instruction[4 : 2];
  assign _zz_crs2p = {2'd0, _zz_crs2p_1};
  assign _zz_cShamt_1 = c6;
  assign _zz_cShamt = {58'd0, _zz_cShamt_1};
  assign _zz_cAddi16sp = ({4'd0,{io_instruction[12],{io_instruction[4],{io_instruction[3],{io_instruction[5],{io_instruction[2],io_instruction[6]}}}}}} <<< 3'd4);
  assign _zz_cLdImm = ({3'd0,{io_instruction[6 : 5],io_instruction[12 : 10]}} <<< 2'd3);
  assign _zz_cLdspImm = ({3'd0,{io_instruction[4 : 2],{io_instruction[12],io_instruction[6 : 5]}}} <<< 2'd3);
  assign _zz_cSdspImm = ({3'd0,{io_instruction[9 : 7],io_instruction[12 : 10]}} <<< 2'd3);
  assign _zz_io_output_imm = {54'd0, cAddi4spn};
  assign _zz_io_output_imm_1 = {57'd0, cLwImm};
  assign _zz_io_output_imm_2 = {57'd0, cLwImm};
  assign _zz_io_output_imm_3 = ({12'd0,c6S} <<< 4'd12);
  assign _zz_io_output_imm_4 = {56'd0, cLwspImm};
  assign _zz_io_output_imm_5 = {56'd0, cSwspImm};
  assign _zz_cJImm = io_instruction[11];
  assign _zz_cJImm_1 = io_instruction[5];
  assign _zz_cJImm_2 = {io_instruction[4],{io_instruction[3],1'b0}};
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_output_aluOp)
      AluOp_ADD : io_output_aluOp_string = "ADD     ";
      AluOp_SUB : io_output_aluOp_string = "SUB     ";
      AluOp_SLL_1 : io_output_aluOp_string = "SLL_1   ";
      AluOp_SLT : io_output_aluOp_string = "SLT     ";
      AluOp_SLTU : io_output_aluOp_string = "SLTU    ";
      AluOp_XOR_1 : io_output_aluOp_string = "XOR_1   ";
      AluOp_SRL_1 : io_output_aluOp_string = "SRL_1   ";
      AluOp_SRA_1 : io_output_aluOp_string = "SRA_1   ";
      AluOp_OR_1 : io_output_aluOp_string = "OR_1    ";
      AluOp_AND_1 : io_output_aluOp_string = "AND_1   ";
      AluOp_ADDW : io_output_aluOp_string = "ADDW    ";
      AluOp_SUBW : io_output_aluOp_string = "SUBW    ";
      AluOp_SLLW : io_output_aluOp_string = "SLLW    ";
      AluOp_SRLW : io_output_aluOp_string = "SRLW    ";
      AluOp_SRAW : io_output_aluOp_string = "SRAW    ";
      AluOp_MUL : io_output_aluOp_string = "MUL     ";
      AluOp_MULH : io_output_aluOp_string = "MULH    ";
      AluOp_MULHSU : io_output_aluOp_string = "MULHSU  ";
      AluOp_MULHU : io_output_aluOp_string = "MULHU   ";
      AluOp_DIV : io_output_aluOp_string = "DIV     ";
      AluOp_DIVU : io_output_aluOp_string = "DIVU    ";
      AluOp_REM_1 : io_output_aluOp_string = "REM_1   ";
      AluOp_REMU : io_output_aluOp_string = "REMU    ";
      AluOp_MULW : io_output_aluOp_string = "MULW    ";
      AluOp_DIVW : io_output_aluOp_string = "DIVW    ";
      AluOp_DIVUW : io_output_aluOp_string = "DIVUW   ";
      AluOp_REMW : io_output_aluOp_string = "REMW    ";
      AluOp_REMUW : io_output_aluOp_string = "REMUW   ";
      AluOp_ANDN : io_output_aluOp_string = "ANDN    ";
      AluOp_ORN : io_output_aluOp_string = "ORN     ";
      AluOp_XNOR_1 : io_output_aluOp_string = "XNOR_1  ";
      AluOp_CLZ : io_output_aluOp_string = "CLZ     ";
      AluOp_CTZ : io_output_aluOp_string = "CTZ     ";
      AluOp_CPOP : io_output_aluOp_string = "CPOP    ";
      AluOp_SEXTB : io_output_aluOp_string = "SEXTB   ";
      AluOp_SEXTH : io_output_aluOp_string = "SEXTH   ";
      AluOp_ZEXTH : io_output_aluOp_string = "ZEXTH   ";
      AluOp_ORCB : io_output_aluOp_string = "ORCB    ";
      AluOp_REV8 : io_output_aluOp_string = "REV8    ";
      AluOp_ROL_1 : io_output_aluOp_string = "ROL_1   ";
      AluOp_ROR_1 : io_output_aluOp_string = "ROR_1   ";
      AluOp_MIN : io_output_aluOp_string = "MIN     ";
      AluOp_MINU : io_output_aluOp_string = "MINU    ";
      AluOp_MAX : io_output_aluOp_string = "MAX     ";
      AluOp_MAXU : io_output_aluOp_string = "MAXU    ";
      AluOp_BSET : io_output_aluOp_string = "BSET    ";
      AluOp_BCLR : io_output_aluOp_string = "BCLR    ";
      AluOp_BINV : io_output_aluOp_string = "BINV    ";
      AluOp_BEXT : io_output_aluOp_string = "BEXT    ";
      AluOp_SH1ADD : io_output_aluOp_string = "SH1ADD  ";
      AluOp_SH2ADD : io_output_aluOp_string = "SH2ADD  ";
      AluOp_SH3ADD : io_output_aluOp_string = "SH3ADD  ";
      AluOp_ADDUW : io_output_aluOp_string = "ADDUW   ";
      AluOp_SH1ADDUW : io_output_aluOp_string = "SH1ADDUW";
      AluOp_SH2ADDUW : io_output_aluOp_string = "SH2ADDUW";
      AluOp_SH3ADDUW : io_output_aluOp_string = "SH3ADDUW";
      AluOp_SLLIUW : io_output_aluOp_string = "SLLIUW  ";
      AluOp_CLMUL : io_output_aluOp_string = "CLMUL   ";
      AluOp_CLMULH : io_output_aluOp_string = "CLMULH  ";
      AluOp_CLMULR : io_output_aluOp_string = "CLMULR  ";
      AluOp_CLZW : io_output_aluOp_string = "CLZW    ";
      AluOp_CTZW : io_output_aluOp_string = "CTZW    ";
      AluOp_CPOPW : io_output_aluOp_string = "CPOPW   ";
      AluOp_ROLW : io_output_aluOp_string = "ROLW    ";
      AluOp_RORW : io_output_aluOp_string = "RORW    ";
      default : io_output_aluOp_string = "????????";
    endcase
  end
  always @(*) begin
    case(io_output_branchType)
      BranchOp_NONE : io_output_branchType_string = "NONE";
      BranchOp_BEQ : io_output_branchType_string = "BEQ ";
      BranchOp_BNE : io_output_branchType_string = "BNE ";
      BranchOp_BLT : io_output_branchType_string = "BLT ";
      BranchOp_BGE : io_output_branchType_string = "BGE ";
      BranchOp_BLTU : io_output_branchType_string = "BLTU";
      BranchOp_BGEU : io_output_branchType_string = "BGEU";
      default : io_output_branchType_string = "????";
    endcase
  end
  always @(*) begin
    case(io_output_csrOp)
      CsrOp_NONE : io_output_csrOp_string = "NONE ";
      CsrOp_WRITE : io_output_csrOp_string = "WRITE";
      CsrOp_SET : io_output_csrOp_string = "SET  ";
      CsrOp_CLEAR : io_output_csrOp_string = "CLEAR";
      default : io_output_csrOp_string = "?????";
    endcase
  end
  always @(*) begin
    case(io_output_sysOp)
      SysOp_NONE : io_output_sysOp_string = "NONE   ";
      SysOp_ECALL : io_output_sysOp_string = "ECALL  ";
      SysOp_EBREAK : io_output_sysOp_string = "EBREAK ";
      SysOp_MRET : io_output_sysOp_string = "MRET   ";
      SysOp_WFI : io_output_sysOp_string = "WFI    ";
      SysOp_ILLEGAL : io_output_sysOp_string = "ILLEGAL";
      default : io_output_sysOp_string = "???????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_aluOp)
      AluOp_ADD : _zz_io_output_aluOp_string = "ADD     ";
      AluOp_SUB : _zz_io_output_aluOp_string = "SUB     ";
      AluOp_SLL_1 : _zz_io_output_aluOp_string = "SLL_1   ";
      AluOp_SLT : _zz_io_output_aluOp_string = "SLT     ";
      AluOp_SLTU : _zz_io_output_aluOp_string = "SLTU    ";
      AluOp_XOR_1 : _zz_io_output_aluOp_string = "XOR_1   ";
      AluOp_SRL_1 : _zz_io_output_aluOp_string = "SRL_1   ";
      AluOp_SRA_1 : _zz_io_output_aluOp_string = "SRA_1   ";
      AluOp_OR_1 : _zz_io_output_aluOp_string = "OR_1    ";
      AluOp_AND_1 : _zz_io_output_aluOp_string = "AND_1   ";
      AluOp_ADDW : _zz_io_output_aluOp_string = "ADDW    ";
      AluOp_SUBW : _zz_io_output_aluOp_string = "SUBW    ";
      AluOp_SLLW : _zz_io_output_aluOp_string = "SLLW    ";
      AluOp_SRLW : _zz_io_output_aluOp_string = "SRLW    ";
      AluOp_SRAW : _zz_io_output_aluOp_string = "SRAW    ";
      AluOp_MUL : _zz_io_output_aluOp_string = "MUL     ";
      AluOp_MULH : _zz_io_output_aluOp_string = "MULH    ";
      AluOp_MULHSU : _zz_io_output_aluOp_string = "MULHSU  ";
      AluOp_MULHU : _zz_io_output_aluOp_string = "MULHU   ";
      AluOp_DIV : _zz_io_output_aluOp_string = "DIV     ";
      AluOp_DIVU : _zz_io_output_aluOp_string = "DIVU    ";
      AluOp_REM_1 : _zz_io_output_aluOp_string = "REM_1   ";
      AluOp_REMU : _zz_io_output_aluOp_string = "REMU    ";
      AluOp_MULW : _zz_io_output_aluOp_string = "MULW    ";
      AluOp_DIVW : _zz_io_output_aluOp_string = "DIVW    ";
      AluOp_DIVUW : _zz_io_output_aluOp_string = "DIVUW   ";
      AluOp_REMW : _zz_io_output_aluOp_string = "REMW    ";
      AluOp_REMUW : _zz_io_output_aluOp_string = "REMUW   ";
      AluOp_ANDN : _zz_io_output_aluOp_string = "ANDN    ";
      AluOp_ORN : _zz_io_output_aluOp_string = "ORN     ";
      AluOp_XNOR_1 : _zz_io_output_aluOp_string = "XNOR_1  ";
      AluOp_CLZ : _zz_io_output_aluOp_string = "CLZ     ";
      AluOp_CTZ : _zz_io_output_aluOp_string = "CTZ     ";
      AluOp_CPOP : _zz_io_output_aluOp_string = "CPOP    ";
      AluOp_SEXTB : _zz_io_output_aluOp_string = "SEXTB   ";
      AluOp_SEXTH : _zz_io_output_aluOp_string = "SEXTH   ";
      AluOp_ZEXTH : _zz_io_output_aluOp_string = "ZEXTH   ";
      AluOp_ORCB : _zz_io_output_aluOp_string = "ORCB    ";
      AluOp_REV8 : _zz_io_output_aluOp_string = "REV8    ";
      AluOp_ROL_1 : _zz_io_output_aluOp_string = "ROL_1   ";
      AluOp_ROR_1 : _zz_io_output_aluOp_string = "ROR_1   ";
      AluOp_MIN : _zz_io_output_aluOp_string = "MIN     ";
      AluOp_MINU : _zz_io_output_aluOp_string = "MINU    ";
      AluOp_MAX : _zz_io_output_aluOp_string = "MAX     ";
      AluOp_MAXU : _zz_io_output_aluOp_string = "MAXU    ";
      AluOp_BSET : _zz_io_output_aluOp_string = "BSET    ";
      AluOp_BCLR : _zz_io_output_aluOp_string = "BCLR    ";
      AluOp_BINV : _zz_io_output_aluOp_string = "BINV    ";
      AluOp_BEXT : _zz_io_output_aluOp_string = "BEXT    ";
      AluOp_SH1ADD : _zz_io_output_aluOp_string = "SH1ADD  ";
      AluOp_SH2ADD : _zz_io_output_aluOp_string = "SH2ADD  ";
      AluOp_SH3ADD : _zz_io_output_aluOp_string = "SH3ADD  ";
      AluOp_ADDUW : _zz_io_output_aluOp_string = "ADDUW   ";
      AluOp_SH1ADDUW : _zz_io_output_aluOp_string = "SH1ADDUW";
      AluOp_SH2ADDUW : _zz_io_output_aluOp_string = "SH2ADDUW";
      AluOp_SH3ADDUW : _zz_io_output_aluOp_string = "SH3ADDUW";
      AluOp_SLLIUW : _zz_io_output_aluOp_string = "SLLIUW  ";
      AluOp_CLMUL : _zz_io_output_aluOp_string = "CLMUL   ";
      AluOp_CLMULH : _zz_io_output_aluOp_string = "CLMULH  ";
      AluOp_CLMULR : _zz_io_output_aluOp_string = "CLMULR  ";
      AluOp_CLZW : _zz_io_output_aluOp_string = "CLZW    ";
      AluOp_CTZW : _zz_io_output_aluOp_string = "CTZW    ";
      AluOp_CPOPW : _zz_io_output_aluOp_string = "CPOPW   ";
      AluOp_ROLW : _zz_io_output_aluOp_string = "ROLW    ";
      AluOp_RORW : _zz_io_output_aluOp_string = "RORW    ";
      default : _zz_io_output_aluOp_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_aluOp_1)
      AluOp_ADD : _zz_io_output_aluOp_1_string = "ADD     ";
      AluOp_SUB : _zz_io_output_aluOp_1_string = "SUB     ";
      AluOp_SLL_1 : _zz_io_output_aluOp_1_string = "SLL_1   ";
      AluOp_SLT : _zz_io_output_aluOp_1_string = "SLT     ";
      AluOp_SLTU : _zz_io_output_aluOp_1_string = "SLTU    ";
      AluOp_XOR_1 : _zz_io_output_aluOp_1_string = "XOR_1   ";
      AluOp_SRL_1 : _zz_io_output_aluOp_1_string = "SRL_1   ";
      AluOp_SRA_1 : _zz_io_output_aluOp_1_string = "SRA_1   ";
      AluOp_OR_1 : _zz_io_output_aluOp_1_string = "OR_1    ";
      AluOp_AND_1 : _zz_io_output_aluOp_1_string = "AND_1   ";
      AluOp_ADDW : _zz_io_output_aluOp_1_string = "ADDW    ";
      AluOp_SUBW : _zz_io_output_aluOp_1_string = "SUBW    ";
      AluOp_SLLW : _zz_io_output_aluOp_1_string = "SLLW    ";
      AluOp_SRLW : _zz_io_output_aluOp_1_string = "SRLW    ";
      AluOp_SRAW : _zz_io_output_aluOp_1_string = "SRAW    ";
      AluOp_MUL : _zz_io_output_aluOp_1_string = "MUL     ";
      AluOp_MULH : _zz_io_output_aluOp_1_string = "MULH    ";
      AluOp_MULHSU : _zz_io_output_aluOp_1_string = "MULHSU  ";
      AluOp_MULHU : _zz_io_output_aluOp_1_string = "MULHU   ";
      AluOp_DIV : _zz_io_output_aluOp_1_string = "DIV     ";
      AluOp_DIVU : _zz_io_output_aluOp_1_string = "DIVU    ";
      AluOp_REM_1 : _zz_io_output_aluOp_1_string = "REM_1   ";
      AluOp_REMU : _zz_io_output_aluOp_1_string = "REMU    ";
      AluOp_MULW : _zz_io_output_aluOp_1_string = "MULW    ";
      AluOp_DIVW : _zz_io_output_aluOp_1_string = "DIVW    ";
      AluOp_DIVUW : _zz_io_output_aluOp_1_string = "DIVUW   ";
      AluOp_REMW : _zz_io_output_aluOp_1_string = "REMW    ";
      AluOp_REMUW : _zz_io_output_aluOp_1_string = "REMUW   ";
      AluOp_ANDN : _zz_io_output_aluOp_1_string = "ANDN    ";
      AluOp_ORN : _zz_io_output_aluOp_1_string = "ORN     ";
      AluOp_XNOR_1 : _zz_io_output_aluOp_1_string = "XNOR_1  ";
      AluOp_CLZ : _zz_io_output_aluOp_1_string = "CLZ     ";
      AluOp_CTZ : _zz_io_output_aluOp_1_string = "CTZ     ";
      AluOp_CPOP : _zz_io_output_aluOp_1_string = "CPOP    ";
      AluOp_SEXTB : _zz_io_output_aluOp_1_string = "SEXTB   ";
      AluOp_SEXTH : _zz_io_output_aluOp_1_string = "SEXTH   ";
      AluOp_ZEXTH : _zz_io_output_aluOp_1_string = "ZEXTH   ";
      AluOp_ORCB : _zz_io_output_aluOp_1_string = "ORCB    ";
      AluOp_REV8 : _zz_io_output_aluOp_1_string = "REV8    ";
      AluOp_ROL_1 : _zz_io_output_aluOp_1_string = "ROL_1   ";
      AluOp_ROR_1 : _zz_io_output_aluOp_1_string = "ROR_1   ";
      AluOp_MIN : _zz_io_output_aluOp_1_string = "MIN     ";
      AluOp_MINU : _zz_io_output_aluOp_1_string = "MINU    ";
      AluOp_MAX : _zz_io_output_aluOp_1_string = "MAX     ";
      AluOp_MAXU : _zz_io_output_aluOp_1_string = "MAXU    ";
      AluOp_BSET : _zz_io_output_aluOp_1_string = "BSET    ";
      AluOp_BCLR : _zz_io_output_aluOp_1_string = "BCLR    ";
      AluOp_BINV : _zz_io_output_aluOp_1_string = "BINV    ";
      AluOp_BEXT : _zz_io_output_aluOp_1_string = "BEXT    ";
      AluOp_SH1ADD : _zz_io_output_aluOp_1_string = "SH1ADD  ";
      AluOp_SH2ADD : _zz_io_output_aluOp_1_string = "SH2ADD  ";
      AluOp_SH3ADD : _zz_io_output_aluOp_1_string = "SH3ADD  ";
      AluOp_ADDUW : _zz_io_output_aluOp_1_string = "ADDUW   ";
      AluOp_SH1ADDUW : _zz_io_output_aluOp_1_string = "SH1ADDUW";
      AluOp_SH2ADDUW : _zz_io_output_aluOp_1_string = "SH2ADDUW";
      AluOp_SH3ADDUW : _zz_io_output_aluOp_1_string = "SH3ADDUW";
      AluOp_SLLIUW : _zz_io_output_aluOp_1_string = "SLLIUW  ";
      AluOp_CLMUL : _zz_io_output_aluOp_1_string = "CLMUL   ";
      AluOp_CLMULH : _zz_io_output_aluOp_1_string = "CLMULH  ";
      AluOp_CLMULR : _zz_io_output_aluOp_1_string = "CLMULR  ";
      AluOp_CLZW : _zz_io_output_aluOp_1_string = "CLZW    ";
      AluOp_CTZW : _zz_io_output_aluOp_1_string = "CTZW    ";
      AluOp_CPOPW : _zz_io_output_aluOp_1_string = "CPOPW   ";
      AluOp_ROLW : _zz_io_output_aluOp_1_string = "ROLW    ";
      AluOp_RORW : _zz_io_output_aluOp_1_string = "RORW    ";
      default : _zz_io_output_aluOp_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_aluOp_2)
      AluOp_ADD : _zz_io_output_aluOp_2_string = "ADD     ";
      AluOp_SUB : _zz_io_output_aluOp_2_string = "SUB     ";
      AluOp_SLL_1 : _zz_io_output_aluOp_2_string = "SLL_1   ";
      AluOp_SLT : _zz_io_output_aluOp_2_string = "SLT     ";
      AluOp_SLTU : _zz_io_output_aluOp_2_string = "SLTU    ";
      AluOp_XOR_1 : _zz_io_output_aluOp_2_string = "XOR_1   ";
      AluOp_SRL_1 : _zz_io_output_aluOp_2_string = "SRL_1   ";
      AluOp_SRA_1 : _zz_io_output_aluOp_2_string = "SRA_1   ";
      AluOp_OR_1 : _zz_io_output_aluOp_2_string = "OR_1    ";
      AluOp_AND_1 : _zz_io_output_aluOp_2_string = "AND_1   ";
      AluOp_ADDW : _zz_io_output_aluOp_2_string = "ADDW    ";
      AluOp_SUBW : _zz_io_output_aluOp_2_string = "SUBW    ";
      AluOp_SLLW : _zz_io_output_aluOp_2_string = "SLLW    ";
      AluOp_SRLW : _zz_io_output_aluOp_2_string = "SRLW    ";
      AluOp_SRAW : _zz_io_output_aluOp_2_string = "SRAW    ";
      AluOp_MUL : _zz_io_output_aluOp_2_string = "MUL     ";
      AluOp_MULH : _zz_io_output_aluOp_2_string = "MULH    ";
      AluOp_MULHSU : _zz_io_output_aluOp_2_string = "MULHSU  ";
      AluOp_MULHU : _zz_io_output_aluOp_2_string = "MULHU   ";
      AluOp_DIV : _zz_io_output_aluOp_2_string = "DIV     ";
      AluOp_DIVU : _zz_io_output_aluOp_2_string = "DIVU    ";
      AluOp_REM_1 : _zz_io_output_aluOp_2_string = "REM_1   ";
      AluOp_REMU : _zz_io_output_aluOp_2_string = "REMU    ";
      AluOp_MULW : _zz_io_output_aluOp_2_string = "MULW    ";
      AluOp_DIVW : _zz_io_output_aluOp_2_string = "DIVW    ";
      AluOp_DIVUW : _zz_io_output_aluOp_2_string = "DIVUW   ";
      AluOp_REMW : _zz_io_output_aluOp_2_string = "REMW    ";
      AluOp_REMUW : _zz_io_output_aluOp_2_string = "REMUW   ";
      AluOp_ANDN : _zz_io_output_aluOp_2_string = "ANDN    ";
      AluOp_ORN : _zz_io_output_aluOp_2_string = "ORN     ";
      AluOp_XNOR_1 : _zz_io_output_aluOp_2_string = "XNOR_1  ";
      AluOp_CLZ : _zz_io_output_aluOp_2_string = "CLZ     ";
      AluOp_CTZ : _zz_io_output_aluOp_2_string = "CTZ     ";
      AluOp_CPOP : _zz_io_output_aluOp_2_string = "CPOP    ";
      AluOp_SEXTB : _zz_io_output_aluOp_2_string = "SEXTB   ";
      AluOp_SEXTH : _zz_io_output_aluOp_2_string = "SEXTH   ";
      AluOp_ZEXTH : _zz_io_output_aluOp_2_string = "ZEXTH   ";
      AluOp_ORCB : _zz_io_output_aluOp_2_string = "ORCB    ";
      AluOp_REV8 : _zz_io_output_aluOp_2_string = "REV8    ";
      AluOp_ROL_1 : _zz_io_output_aluOp_2_string = "ROL_1   ";
      AluOp_ROR_1 : _zz_io_output_aluOp_2_string = "ROR_1   ";
      AluOp_MIN : _zz_io_output_aluOp_2_string = "MIN     ";
      AluOp_MINU : _zz_io_output_aluOp_2_string = "MINU    ";
      AluOp_MAX : _zz_io_output_aluOp_2_string = "MAX     ";
      AluOp_MAXU : _zz_io_output_aluOp_2_string = "MAXU    ";
      AluOp_BSET : _zz_io_output_aluOp_2_string = "BSET    ";
      AluOp_BCLR : _zz_io_output_aluOp_2_string = "BCLR    ";
      AluOp_BINV : _zz_io_output_aluOp_2_string = "BINV    ";
      AluOp_BEXT : _zz_io_output_aluOp_2_string = "BEXT    ";
      AluOp_SH1ADD : _zz_io_output_aluOp_2_string = "SH1ADD  ";
      AluOp_SH2ADD : _zz_io_output_aluOp_2_string = "SH2ADD  ";
      AluOp_SH3ADD : _zz_io_output_aluOp_2_string = "SH3ADD  ";
      AluOp_ADDUW : _zz_io_output_aluOp_2_string = "ADDUW   ";
      AluOp_SH1ADDUW : _zz_io_output_aluOp_2_string = "SH1ADDUW";
      AluOp_SH2ADDUW : _zz_io_output_aluOp_2_string = "SH2ADDUW";
      AluOp_SH3ADDUW : _zz_io_output_aluOp_2_string = "SH3ADDUW";
      AluOp_SLLIUW : _zz_io_output_aluOp_2_string = "SLLIUW  ";
      AluOp_CLMUL : _zz_io_output_aluOp_2_string = "CLMUL   ";
      AluOp_CLMULH : _zz_io_output_aluOp_2_string = "CLMULH  ";
      AluOp_CLMULR : _zz_io_output_aluOp_2_string = "CLMULR  ";
      AluOp_CLZW : _zz_io_output_aluOp_2_string = "CLZW    ";
      AluOp_CTZW : _zz_io_output_aluOp_2_string = "CTZW    ";
      AluOp_CPOPW : _zz_io_output_aluOp_2_string = "CPOPW   ";
      AluOp_ROLW : _zz_io_output_aluOp_2_string = "ROLW    ";
      AluOp_RORW : _zz_io_output_aluOp_2_string = "RORW    ";
      default : _zz_io_output_aluOp_2_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_aluOp_3)
      AluOp_ADD : _zz_io_output_aluOp_3_string = "ADD     ";
      AluOp_SUB : _zz_io_output_aluOp_3_string = "SUB     ";
      AluOp_SLL_1 : _zz_io_output_aluOp_3_string = "SLL_1   ";
      AluOp_SLT : _zz_io_output_aluOp_3_string = "SLT     ";
      AluOp_SLTU : _zz_io_output_aluOp_3_string = "SLTU    ";
      AluOp_XOR_1 : _zz_io_output_aluOp_3_string = "XOR_1   ";
      AluOp_SRL_1 : _zz_io_output_aluOp_3_string = "SRL_1   ";
      AluOp_SRA_1 : _zz_io_output_aluOp_3_string = "SRA_1   ";
      AluOp_OR_1 : _zz_io_output_aluOp_3_string = "OR_1    ";
      AluOp_AND_1 : _zz_io_output_aluOp_3_string = "AND_1   ";
      AluOp_ADDW : _zz_io_output_aluOp_3_string = "ADDW    ";
      AluOp_SUBW : _zz_io_output_aluOp_3_string = "SUBW    ";
      AluOp_SLLW : _zz_io_output_aluOp_3_string = "SLLW    ";
      AluOp_SRLW : _zz_io_output_aluOp_3_string = "SRLW    ";
      AluOp_SRAW : _zz_io_output_aluOp_3_string = "SRAW    ";
      AluOp_MUL : _zz_io_output_aluOp_3_string = "MUL     ";
      AluOp_MULH : _zz_io_output_aluOp_3_string = "MULH    ";
      AluOp_MULHSU : _zz_io_output_aluOp_3_string = "MULHSU  ";
      AluOp_MULHU : _zz_io_output_aluOp_3_string = "MULHU   ";
      AluOp_DIV : _zz_io_output_aluOp_3_string = "DIV     ";
      AluOp_DIVU : _zz_io_output_aluOp_3_string = "DIVU    ";
      AluOp_REM_1 : _zz_io_output_aluOp_3_string = "REM_1   ";
      AluOp_REMU : _zz_io_output_aluOp_3_string = "REMU    ";
      AluOp_MULW : _zz_io_output_aluOp_3_string = "MULW    ";
      AluOp_DIVW : _zz_io_output_aluOp_3_string = "DIVW    ";
      AluOp_DIVUW : _zz_io_output_aluOp_3_string = "DIVUW   ";
      AluOp_REMW : _zz_io_output_aluOp_3_string = "REMW    ";
      AluOp_REMUW : _zz_io_output_aluOp_3_string = "REMUW   ";
      AluOp_ANDN : _zz_io_output_aluOp_3_string = "ANDN    ";
      AluOp_ORN : _zz_io_output_aluOp_3_string = "ORN     ";
      AluOp_XNOR_1 : _zz_io_output_aluOp_3_string = "XNOR_1  ";
      AluOp_CLZ : _zz_io_output_aluOp_3_string = "CLZ     ";
      AluOp_CTZ : _zz_io_output_aluOp_3_string = "CTZ     ";
      AluOp_CPOP : _zz_io_output_aluOp_3_string = "CPOP    ";
      AluOp_SEXTB : _zz_io_output_aluOp_3_string = "SEXTB   ";
      AluOp_SEXTH : _zz_io_output_aluOp_3_string = "SEXTH   ";
      AluOp_ZEXTH : _zz_io_output_aluOp_3_string = "ZEXTH   ";
      AluOp_ORCB : _zz_io_output_aluOp_3_string = "ORCB    ";
      AluOp_REV8 : _zz_io_output_aluOp_3_string = "REV8    ";
      AluOp_ROL_1 : _zz_io_output_aluOp_3_string = "ROL_1   ";
      AluOp_ROR_1 : _zz_io_output_aluOp_3_string = "ROR_1   ";
      AluOp_MIN : _zz_io_output_aluOp_3_string = "MIN     ";
      AluOp_MINU : _zz_io_output_aluOp_3_string = "MINU    ";
      AluOp_MAX : _zz_io_output_aluOp_3_string = "MAX     ";
      AluOp_MAXU : _zz_io_output_aluOp_3_string = "MAXU    ";
      AluOp_BSET : _zz_io_output_aluOp_3_string = "BSET    ";
      AluOp_BCLR : _zz_io_output_aluOp_3_string = "BCLR    ";
      AluOp_BINV : _zz_io_output_aluOp_3_string = "BINV    ";
      AluOp_BEXT : _zz_io_output_aluOp_3_string = "BEXT    ";
      AluOp_SH1ADD : _zz_io_output_aluOp_3_string = "SH1ADD  ";
      AluOp_SH2ADD : _zz_io_output_aluOp_3_string = "SH2ADD  ";
      AluOp_SH3ADD : _zz_io_output_aluOp_3_string = "SH3ADD  ";
      AluOp_ADDUW : _zz_io_output_aluOp_3_string = "ADDUW   ";
      AluOp_SH1ADDUW : _zz_io_output_aluOp_3_string = "SH1ADDUW";
      AluOp_SH2ADDUW : _zz_io_output_aluOp_3_string = "SH2ADDUW";
      AluOp_SH3ADDUW : _zz_io_output_aluOp_3_string = "SH3ADDUW";
      AluOp_SLLIUW : _zz_io_output_aluOp_3_string = "SLLIUW  ";
      AluOp_CLMUL : _zz_io_output_aluOp_3_string = "CLMUL   ";
      AluOp_CLMULH : _zz_io_output_aluOp_3_string = "CLMULH  ";
      AluOp_CLMULR : _zz_io_output_aluOp_3_string = "CLMULR  ";
      AluOp_CLZW : _zz_io_output_aluOp_3_string = "CLZW    ";
      AluOp_CTZW : _zz_io_output_aluOp_3_string = "CTZW    ";
      AluOp_CPOPW : _zz_io_output_aluOp_3_string = "CPOPW   ";
      AluOp_ROLW : _zz_io_output_aluOp_3_string = "ROLW    ";
      AluOp_RORW : _zz_io_output_aluOp_3_string = "RORW    ";
      default : _zz_io_output_aluOp_3_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_aluOp_4)
      AluOp_ADD : _zz_io_output_aluOp_4_string = "ADD     ";
      AluOp_SUB : _zz_io_output_aluOp_4_string = "SUB     ";
      AluOp_SLL_1 : _zz_io_output_aluOp_4_string = "SLL_1   ";
      AluOp_SLT : _zz_io_output_aluOp_4_string = "SLT     ";
      AluOp_SLTU : _zz_io_output_aluOp_4_string = "SLTU    ";
      AluOp_XOR_1 : _zz_io_output_aluOp_4_string = "XOR_1   ";
      AluOp_SRL_1 : _zz_io_output_aluOp_4_string = "SRL_1   ";
      AluOp_SRA_1 : _zz_io_output_aluOp_4_string = "SRA_1   ";
      AluOp_OR_1 : _zz_io_output_aluOp_4_string = "OR_1    ";
      AluOp_AND_1 : _zz_io_output_aluOp_4_string = "AND_1   ";
      AluOp_ADDW : _zz_io_output_aluOp_4_string = "ADDW    ";
      AluOp_SUBW : _zz_io_output_aluOp_4_string = "SUBW    ";
      AluOp_SLLW : _zz_io_output_aluOp_4_string = "SLLW    ";
      AluOp_SRLW : _zz_io_output_aluOp_4_string = "SRLW    ";
      AluOp_SRAW : _zz_io_output_aluOp_4_string = "SRAW    ";
      AluOp_MUL : _zz_io_output_aluOp_4_string = "MUL     ";
      AluOp_MULH : _zz_io_output_aluOp_4_string = "MULH    ";
      AluOp_MULHSU : _zz_io_output_aluOp_4_string = "MULHSU  ";
      AluOp_MULHU : _zz_io_output_aluOp_4_string = "MULHU   ";
      AluOp_DIV : _zz_io_output_aluOp_4_string = "DIV     ";
      AluOp_DIVU : _zz_io_output_aluOp_4_string = "DIVU    ";
      AluOp_REM_1 : _zz_io_output_aluOp_4_string = "REM_1   ";
      AluOp_REMU : _zz_io_output_aluOp_4_string = "REMU    ";
      AluOp_MULW : _zz_io_output_aluOp_4_string = "MULW    ";
      AluOp_DIVW : _zz_io_output_aluOp_4_string = "DIVW    ";
      AluOp_DIVUW : _zz_io_output_aluOp_4_string = "DIVUW   ";
      AluOp_REMW : _zz_io_output_aluOp_4_string = "REMW    ";
      AluOp_REMUW : _zz_io_output_aluOp_4_string = "REMUW   ";
      AluOp_ANDN : _zz_io_output_aluOp_4_string = "ANDN    ";
      AluOp_ORN : _zz_io_output_aluOp_4_string = "ORN     ";
      AluOp_XNOR_1 : _zz_io_output_aluOp_4_string = "XNOR_1  ";
      AluOp_CLZ : _zz_io_output_aluOp_4_string = "CLZ     ";
      AluOp_CTZ : _zz_io_output_aluOp_4_string = "CTZ     ";
      AluOp_CPOP : _zz_io_output_aluOp_4_string = "CPOP    ";
      AluOp_SEXTB : _zz_io_output_aluOp_4_string = "SEXTB   ";
      AluOp_SEXTH : _zz_io_output_aluOp_4_string = "SEXTH   ";
      AluOp_ZEXTH : _zz_io_output_aluOp_4_string = "ZEXTH   ";
      AluOp_ORCB : _zz_io_output_aluOp_4_string = "ORCB    ";
      AluOp_REV8 : _zz_io_output_aluOp_4_string = "REV8    ";
      AluOp_ROL_1 : _zz_io_output_aluOp_4_string = "ROL_1   ";
      AluOp_ROR_1 : _zz_io_output_aluOp_4_string = "ROR_1   ";
      AluOp_MIN : _zz_io_output_aluOp_4_string = "MIN     ";
      AluOp_MINU : _zz_io_output_aluOp_4_string = "MINU    ";
      AluOp_MAX : _zz_io_output_aluOp_4_string = "MAX     ";
      AluOp_MAXU : _zz_io_output_aluOp_4_string = "MAXU    ";
      AluOp_BSET : _zz_io_output_aluOp_4_string = "BSET    ";
      AluOp_BCLR : _zz_io_output_aluOp_4_string = "BCLR    ";
      AluOp_BINV : _zz_io_output_aluOp_4_string = "BINV    ";
      AluOp_BEXT : _zz_io_output_aluOp_4_string = "BEXT    ";
      AluOp_SH1ADD : _zz_io_output_aluOp_4_string = "SH1ADD  ";
      AluOp_SH2ADD : _zz_io_output_aluOp_4_string = "SH2ADD  ";
      AluOp_SH3ADD : _zz_io_output_aluOp_4_string = "SH3ADD  ";
      AluOp_ADDUW : _zz_io_output_aluOp_4_string = "ADDUW   ";
      AluOp_SH1ADDUW : _zz_io_output_aluOp_4_string = "SH1ADDUW";
      AluOp_SH2ADDUW : _zz_io_output_aluOp_4_string = "SH2ADDUW";
      AluOp_SH3ADDUW : _zz_io_output_aluOp_4_string = "SH3ADDUW";
      AluOp_SLLIUW : _zz_io_output_aluOp_4_string = "SLLIUW  ";
      AluOp_CLMUL : _zz_io_output_aluOp_4_string = "CLMUL   ";
      AluOp_CLMULH : _zz_io_output_aluOp_4_string = "CLMULH  ";
      AluOp_CLMULR : _zz_io_output_aluOp_4_string = "CLMULR  ";
      AluOp_CLZW : _zz_io_output_aluOp_4_string = "CLZW    ";
      AluOp_CTZW : _zz_io_output_aluOp_4_string = "CTZW    ";
      AluOp_CPOPW : _zz_io_output_aluOp_4_string = "CPOPW   ";
      AluOp_ROLW : _zz_io_output_aluOp_4_string = "ROLW    ";
      AluOp_RORW : _zz_io_output_aluOp_4_string = "RORW    ";
      default : _zz_io_output_aluOp_4_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_aluOp_5)
      AluOp_ADD : _zz_io_output_aluOp_5_string = "ADD     ";
      AluOp_SUB : _zz_io_output_aluOp_5_string = "SUB     ";
      AluOp_SLL_1 : _zz_io_output_aluOp_5_string = "SLL_1   ";
      AluOp_SLT : _zz_io_output_aluOp_5_string = "SLT     ";
      AluOp_SLTU : _zz_io_output_aluOp_5_string = "SLTU    ";
      AluOp_XOR_1 : _zz_io_output_aluOp_5_string = "XOR_1   ";
      AluOp_SRL_1 : _zz_io_output_aluOp_5_string = "SRL_1   ";
      AluOp_SRA_1 : _zz_io_output_aluOp_5_string = "SRA_1   ";
      AluOp_OR_1 : _zz_io_output_aluOp_5_string = "OR_1    ";
      AluOp_AND_1 : _zz_io_output_aluOp_5_string = "AND_1   ";
      AluOp_ADDW : _zz_io_output_aluOp_5_string = "ADDW    ";
      AluOp_SUBW : _zz_io_output_aluOp_5_string = "SUBW    ";
      AluOp_SLLW : _zz_io_output_aluOp_5_string = "SLLW    ";
      AluOp_SRLW : _zz_io_output_aluOp_5_string = "SRLW    ";
      AluOp_SRAW : _zz_io_output_aluOp_5_string = "SRAW    ";
      AluOp_MUL : _zz_io_output_aluOp_5_string = "MUL     ";
      AluOp_MULH : _zz_io_output_aluOp_5_string = "MULH    ";
      AluOp_MULHSU : _zz_io_output_aluOp_5_string = "MULHSU  ";
      AluOp_MULHU : _zz_io_output_aluOp_5_string = "MULHU   ";
      AluOp_DIV : _zz_io_output_aluOp_5_string = "DIV     ";
      AluOp_DIVU : _zz_io_output_aluOp_5_string = "DIVU    ";
      AluOp_REM_1 : _zz_io_output_aluOp_5_string = "REM_1   ";
      AluOp_REMU : _zz_io_output_aluOp_5_string = "REMU    ";
      AluOp_MULW : _zz_io_output_aluOp_5_string = "MULW    ";
      AluOp_DIVW : _zz_io_output_aluOp_5_string = "DIVW    ";
      AluOp_DIVUW : _zz_io_output_aluOp_5_string = "DIVUW   ";
      AluOp_REMW : _zz_io_output_aluOp_5_string = "REMW    ";
      AluOp_REMUW : _zz_io_output_aluOp_5_string = "REMUW   ";
      AluOp_ANDN : _zz_io_output_aluOp_5_string = "ANDN    ";
      AluOp_ORN : _zz_io_output_aluOp_5_string = "ORN     ";
      AluOp_XNOR_1 : _zz_io_output_aluOp_5_string = "XNOR_1  ";
      AluOp_CLZ : _zz_io_output_aluOp_5_string = "CLZ     ";
      AluOp_CTZ : _zz_io_output_aluOp_5_string = "CTZ     ";
      AluOp_CPOP : _zz_io_output_aluOp_5_string = "CPOP    ";
      AluOp_SEXTB : _zz_io_output_aluOp_5_string = "SEXTB   ";
      AluOp_SEXTH : _zz_io_output_aluOp_5_string = "SEXTH   ";
      AluOp_ZEXTH : _zz_io_output_aluOp_5_string = "ZEXTH   ";
      AluOp_ORCB : _zz_io_output_aluOp_5_string = "ORCB    ";
      AluOp_REV8 : _zz_io_output_aluOp_5_string = "REV8    ";
      AluOp_ROL_1 : _zz_io_output_aluOp_5_string = "ROL_1   ";
      AluOp_ROR_1 : _zz_io_output_aluOp_5_string = "ROR_1   ";
      AluOp_MIN : _zz_io_output_aluOp_5_string = "MIN     ";
      AluOp_MINU : _zz_io_output_aluOp_5_string = "MINU    ";
      AluOp_MAX : _zz_io_output_aluOp_5_string = "MAX     ";
      AluOp_MAXU : _zz_io_output_aluOp_5_string = "MAXU    ";
      AluOp_BSET : _zz_io_output_aluOp_5_string = "BSET    ";
      AluOp_BCLR : _zz_io_output_aluOp_5_string = "BCLR    ";
      AluOp_BINV : _zz_io_output_aluOp_5_string = "BINV    ";
      AluOp_BEXT : _zz_io_output_aluOp_5_string = "BEXT    ";
      AluOp_SH1ADD : _zz_io_output_aluOp_5_string = "SH1ADD  ";
      AluOp_SH2ADD : _zz_io_output_aluOp_5_string = "SH2ADD  ";
      AluOp_SH3ADD : _zz_io_output_aluOp_5_string = "SH3ADD  ";
      AluOp_ADDUW : _zz_io_output_aluOp_5_string = "ADDUW   ";
      AluOp_SH1ADDUW : _zz_io_output_aluOp_5_string = "SH1ADDUW";
      AluOp_SH2ADDUW : _zz_io_output_aluOp_5_string = "SH2ADDUW";
      AluOp_SH3ADDUW : _zz_io_output_aluOp_5_string = "SH3ADDUW";
      AluOp_SLLIUW : _zz_io_output_aluOp_5_string = "SLLIUW  ";
      AluOp_CLMUL : _zz_io_output_aluOp_5_string = "CLMUL   ";
      AluOp_CLMULH : _zz_io_output_aluOp_5_string = "CLMULH  ";
      AluOp_CLMULR : _zz_io_output_aluOp_5_string = "CLMULR  ";
      AluOp_CLZW : _zz_io_output_aluOp_5_string = "CLZW    ";
      AluOp_CTZW : _zz_io_output_aluOp_5_string = "CTZW    ";
      AluOp_CPOPW : _zz_io_output_aluOp_5_string = "CPOPW   ";
      AluOp_ROLW : _zz_io_output_aluOp_5_string = "ROLW    ";
      AluOp_RORW : _zz_io_output_aluOp_5_string = "RORW    ";
      default : _zz_io_output_aluOp_5_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_aluOp_6)
      AluOp_ADD : _zz_io_output_aluOp_6_string = "ADD     ";
      AluOp_SUB : _zz_io_output_aluOp_6_string = "SUB     ";
      AluOp_SLL_1 : _zz_io_output_aluOp_6_string = "SLL_1   ";
      AluOp_SLT : _zz_io_output_aluOp_6_string = "SLT     ";
      AluOp_SLTU : _zz_io_output_aluOp_6_string = "SLTU    ";
      AluOp_XOR_1 : _zz_io_output_aluOp_6_string = "XOR_1   ";
      AluOp_SRL_1 : _zz_io_output_aluOp_6_string = "SRL_1   ";
      AluOp_SRA_1 : _zz_io_output_aluOp_6_string = "SRA_1   ";
      AluOp_OR_1 : _zz_io_output_aluOp_6_string = "OR_1    ";
      AluOp_AND_1 : _zz_io_output_aluOp_6_string = "AND_1   ";
      AluOp_ADDW : _zz_io_output_aluOp_6_string = "ADDW    ";
      AluOp_SUBW : _zz_io_output_aluOp_6_string = "SUBW    ";
      AluOp_SLLW : _zz_io_output_aluOp_6_string = "SLLW    ";
      AluOp_SRLW : _zz_io_output_aluOp_6_string = "SRLW    ";
      AluOp_SRAW : _zz_io_output_aluOp_6_string = "SRAW    ";
      AluOp_MUL : _zz_io_output_aluOp_6_string = "MUL     ";
      AluOp_MULH : _zz_io_output_aluOp_6_string = "MULH    ";
      AluOp_MULHSU : _zz_io_output_aluOp_6_string = "MULHSU  ";
      AluOp_MULHU : _zz_io_output_aluOp_6_string = "MULHU   ";
      AluOp_DIV : _zz_io_output_aluOp_6_string = "DIV     ";
      AluOp_DIVU : _zz_io_output_aluOp_6_string = "DIVU    ";
      AluOp_REM_1 : _zz_io_output_aluOp_6_string = "REM_1   ";
      AluOp_REMU : _zz_io_output_aluOp_6_string = "REMU    ";
      AluOp_MULW : _zz_io_output_aluOp_6_string = "MULW    ";
      AluOp_DIVW : _zz_io_output_aluOp_6_string = "DIVW    ";
      AluOp_DIVUW : _zz_io_output_aluOp_6_string = "DIVUW   ";
      AluOp_REMW : _zz_io_output_aluOp_6_string = "REMW    ";
      AluOp_REMUW : _zz_io_output_aluOp_6_string = "REMUW   ";
      AluOp_ANDN : _zz_io_output_aluOp_6_string = "ANDN    ";
      AluOp_ORN : _zz_io_output_aluOp_6_string = "ORN     ";
      AluOp_XNOR_1 : _zz_io_output_aluOp_6_string = "XNOR_1  ";
      AluOp_CLZ : _zz_io_output_aluOp_6_string = "CLZ     ";
      AluOp_CTZ : _zz_io_output_aluOp_6_string = "CTZ     ";
      AluOp_CPOP : _zz_io_output_aluOp_6_string = "CPOP    ";
      AluOp_SEXTB : _zz_io_output_aluOp_6_string = "SEXTB   ";
      AluOp_SEXTH : _zz_io_output_aluOp_6_string = "SEXTH   ";
      AluOp_ZEXTH : _zz_io_output_aluOp_6_string = "ZEXTH   ";
      AluOp_ORCB : _zz_io_output_aluOp_6_string = "ORCB    ";
      AluOp_REV8 : _zz_io_output_aluOp_6_string = "REV8    ";
      AluOp_ROL_1 : _zz_io_output_aluOp_6_string = "ROL_1   ";
      AluOp_ROR_1 : _zz_io_output_aluOp_6_string = "ROR_1   ";
      AluOp_MIN : _zz_io_output_aluOp_6_string = "MIN     ";
      AluOp_MINU : _zz_io_output_aluOp_6_string = "MINU    ";
      AluOp_MAX : _zz_io_output_aluOp_6_string = "MAX     ";
      AluOp_MAXU : _zz_io_output_aluOp_6_string = "MAXU    ";
      AluOp_BSET : _zz_io_output_aluOp_6_string = "BSET    ";
      AluOp_BCLR : _zz_io_output_aluOp_6_string = "BCLR    ";
      AluOp_BINV : _zz_io_output_aluOp_6_string = "BINV    ";
      AluOp_BEXT : _zz_io_output_aluOp_6_string = "BEXT    ";
      AluOp_SH1ADD : _zz_io_output_aluOp_6_string = "SH1ADD  ";
      AluOp_SH2ADD : _zz_io_output_aluOp_6_string = "SH2ADD  ";
      AluOp_SH3ADD : _zz_io_output_aluOp_6_string = "SH3ADD  ";
      AluOp_ADDUW : _zz_io_output_aluOp_6_string = "ADDUW   ";
      AluOp_SH1ADDUW : _zz_io_output_aluOp_6_string = "SH1ADDUW";
      AluOp_SH2ADDUW : _zz_io_output_aluOp_6_string = "SH2ADDUW";
      AluOp_SH3ADDUW : _zz_io_output_aluOp_6_string = "SH3ADDUW";
      AluOp_SLLIUW : _zz_io_output_aluOp_6_string = "SLLIUW  ";
      AluOp_CLMUL : _zz_io_output_aluOp_6_string = "CLMUL   ";
      AluOp_CLMULH : _zz_io_output_aluOp_6_string = "CLMULH  ";
      AluOp_CLMULR : _zz_io_output_aluOp_6_string = "CLMULR  ";
      AluOp_CLZW : _zz_io_output_aluOp_6_string = "CLZW    ";
      AluOp_CTZW : _zz_io_output_aluOp_6_string = "CTZW    ";
      AluOp_CPOPW : _zz_io_output_aluOp_6_string = "CPOPW   ";
      AluOp_ROLW : _zz_io_output_aluOp_6_string = "ROLW    ";
      AluOp_RORW : _zz_io_output_aluOp_6_string = "RORW    ";
      default : _zz_io_output_aluOp_6_string = "????????";
    endcase
  end
  `endif

  assign opcode = io_instruction[6 : 0];
  assign funct3 = io_instruction[14 : 12];
  assign funct7 = io_instruction[31 : 25];
  assign funct5 = io_instruction[31 : 27];
  assign funct6 = io_instruction[31 : 26];
  assign convSel = io_instruction[21 : 20];
  assign rs1Num = io_instruction[19 : 15];
  assign rdNum = io_instruction[11 : 7];
  assign immI = {{52{_zz_immI[11]}}, _zz_immI};
  assign immS = {{52{_zz_immS[11]}}, _zz_immS};
  assign immB = _zz_immB[63:0];
  assign immU = {{32{_zz_immU[31]}}, _zz_immU};
  assign immJ = _zz_immJ[63:0];
  always @(*) begin
    io_output_regWrite = 1'b0;
    if(isComp) begin
      case(switch_Decoder_l192)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l196) begin
                io_output_regWrite = 1'b1;
              end
            end
            3'b010 : begin
              io_output_regWrite = 1'b1;
            end
            3'b011 : begin
              io_output_regWrite = 1'b1;
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            default : begin
            end
          endcase
        end
        2'b01 : begin
          case(cfunct3)
            3'b000 : begin
              io_output_regWrite = 1'b1;
            end
            3'b001 : begin
              if(!when_Decoder_l243) begin
                io_output_regWrite = 1'b1;
              end
            end
            3'b010 : begin
              io_output_regWrite = 1'b1;
            end
            3'b011 : begin
              if(when_Decoder_l259) begin
                io_output_regWrite = 1'b1;
              end else begin
                if(!when_Decoder_l264) begin
                  io_output_regWrite = 1'b1;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l274)
                2'b00 : begin
                  io_output_regWrite = 1'b1;
                end
                2'b01 : begin
                  io_output_regWrite = 1'b1;
                end
                2'b10 : begin
                  io_output_regWrite = 1'b1;
                end
                default : begin
                  if(when_Decoder_l302) begin
                    case(switch_Decoder_l304)
                      2'b00 : begin
                        io_output_regWrite = 1'b1;
                      end
                      2'b01 : begin
                        io_output_regWrite = 1'b1;
                      end
                      default : begin
                      end
                    endcase
                  end else begin
                    io_output_regWrite = 1'b1;
                  end
                end
              endcase
            end
            3'b101 : begin
            end
            3'b110 : begin
            end
            default : begin
            end
          endcase
        end
        2'b10 : begin
          case(cfunct3)
            3'b000 : begin
              io_output_regWrite = 1'b1;
            end
            3'b010 : begin
              if(!when_Decoder_l356) begin
                io_output_regWrite = 1'b1;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l364) begin
                io_output_regWrite = 1'b1;
              end
            end
            3'b100 : begin
              if(when_Decoder_l374) begin
                if(!when_Decoder_l375) begin
                  io_output_regWrite = 1'b1;
                end
              end else begin
                if(when_Decoder_l387) begin
                  if(!when_Decoder_l388) begin
                    io_output_regWrite = 1'b1;
                  end
                end else begin
                  io_output_regWrite = 1'b1;
                end
              end
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            default : begin
            end
          endcase
        end
        default : begin
        end
      endcase
    end else begin
      casez(opcode)
        7'b0110111 : begin
          io_output_regWrite = 1'b1;
        end
        7'b0010111 : begin
          io_output_regWrite = 1'b1;
        end
        7'b1101111 : begin
          io_output_regWrite = 1'b1;
        end
        7'b1100111 : begin
          io_output_regWrite = 1'b1;
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
          io_output_regWrite = 1'b1;
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
          case(funct6)
            6'h0 : begin
            end
            6'h02 : begin
            end
            6'h04 : begin
            end
            6'h06 : begin
            end
            6'h16 : begin
            end
            6'h08 : begin
            end
            6'h0a : begin
            end
            6'h28 : begin
              io_output_regWrite = 1'b1;
            end
            6'h38 : begin
              io_output_regWrite = 1'b1;
            end
            6'h3c : begin
            end
            6'h30 : begin
              io_output_regWrite = 1'b1;
            end
            6'h34 : begin
            end
            6'h10 : begin
            end
            default : begin
            end
          endcase
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
          io_output_regWrite = 1'b1;
        end
        7'b0011011 : begin
          io_output_regWrite = 1'b1;
        end
        7'b0111011 : begin
          io_output_regWrite = 1'b1;
        end
        7'b0110011 : begin
          if(!when_Decoder_l882) begin
            io_output_regWrite = 1'b1;
          end
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
          casez(funct3)
            3'b001 : begin
              io_output_regWrite = (rdNum != 5'h0);
            end
            3'b010 : begin
              io_output_regWrite = (rdNum != 5'h0);
            end
            3'b011 : begin
              io_output_regWrite = (rdNum != 5'h0);
            end
            3'b101 : begin
              io_output_regWrite = (rdNum != 5'h0);
            end
            3'b110 : begin
              io_output_regWrite = (rdNum != 5'h0);
            end
            3'b111 : begin
              io_output_regWrite = (rdNum != 5'h0);
            end
            3'b000 : begin
            end
            default : begin
            end
          endcase
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_aluSrc = 1'b0;
    if(isComp) begin
      case(switch_Decoder_l192)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l196) begin
                io_output_aluSrc = 1'b1;
              end
            end
            3'b010 : begin
              io_output_aluSrc = 1'b1;
            end
            3'b011 : begin
              io_output_aluSrc = 1'b1;
            end
            3'b110 : begin
              io_output_aluSrc = 1'b1;
            end
            3'b111 : begin
              io_output_aluSrc = 1'b1;
            end
            default : begin
            end
          endcase
        end
        2'b01 : begin
          case(cfunct3)
            3'b000 : begin
              io_output_aluSrc = 1'b1;
            end
            3'b001 : begin
              if(!when_Decoder_l243) begin
                io_output_aluSrc = 1'b1;
              end
            end
            3'b010 : begin
              io_output_aluSrc = 1'b1;
            end
            3'b011 : begin
              if(when_Decoder_l259) begin
                io_output_aluSrc = 1'b1;
              end else begin
                if(!when_Decoder_l264) begin
                  io_output_aluSrc = 1'b1;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l274)
                2'b00 : begin
                  io_output_aluSrc = 1'b1;
                end
                2'b01 : begin
                  io_output_aluSrc = 1'b1;
                end
                2'b10 : begin
                  io_output_aluSrc = 1'b1;
                end
                default : begin
                end
              endcase
            end
            3'b101 : begin
            end
            3'b110 : begin
            end
            default : begin
            end
          endcase
        end
        2'b10 : begin
          case(cfunct3)
            3'b000 : begin
              io_output_aluSrc = 1'b1;
            end
            3'b010 : begin
              if(!when_Decoder_l356) begin
                io_output_aluSrc = 1'b1;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l364) begin
                io_output_aluSrc = 1'b1;
              end
            end
            3'b100 : begin
              if(when_Decoder_l374) begin
                if(when_Decoder_l375) begin
                  if(!when_Decoder_l376) begin
                    io_output_aluSrc = 1'b1;
                  end
                end
              end else begin
                if(when_Decoder_l387) begin
                  if(!when_Decoder_l388) begin
                    io_output_aluSrc = 1'b1;
                  end
                end
              end
            end
            3'b110 : begin
              io_output_aluSrc = 1'b1;
            end
            3'b111 : begin
              io_output_aluSrc = 1'b1;
            end
            default : begin
            end
          endcase
        end
        default : begin
        end
      endcase
    end else begin
      casez(opcode)
        7'b0110111 : begin
          io_output_aluSrc = 1'b1;
        end
        7'b0010111 : begin
          io_output_aluSrc = 1'b1;
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
          io_output_aluSrc = 1'b1;
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
          io_output_aluSrc = 1'b1;
        end
        7'b0100011 : begin
          io_output_aluSrc = 1'b1;
        end
        7'b0000111 : begin
          io_output_aluSrc = 1'b1;
        end
        7'b0100111 : begin
          io_output_aluSrc = 1'b1;
        end
        7'b1010011 : begin
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
          io_output_aluSrc = 1'b1;
        end
        7'b0011011 : begin
          io_output_aluSrc = 1'b1;
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_wbSel = 3'b000;
    if(isComp) begin
      case(switch_Decoder_l192)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b010 : begin
              io_output_wbSel = 3'b001;
            end
            3'b011 : begin
              io_output_wbSel = 3'b001;
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            default : begin
            end
          endcase
        end
        2'b01 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b001 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            3'b100 : begin
            end
            3'b101 : begin
              io_output_wbSel = 3'b010;
            end
            3'b110 : begin
            end
            default : begin
            end
          endcase
        end
        2'b10 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b010 : begin
              if(!when_Decoder_l356) begin
                io_output_wbSel = 3'b001;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l364) begin
                io_output_wbSel = 3'b001;
              end
            end
            3'b100 : begin
              if(when_Decoder_l374) begin
                if(when_Decoder_l375) begin
                  if(!when_Decoder_l376) begin
                    io_output_wbSel = 3'b010;
                  end
                end
              end else begin
                if(when_Decoder_l387) begin
                  if(!when_Decoder_l388) begin
                    io_output_wbSel = 3'b010;
                  end
                end
              end
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            default : begin
            end
          endcase
        end
        default : begin
        end
      endcase
    end else begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
          io_output_wbSel = 3'b010;
        end
        7'b1100111 : begin
          io_output_wbSel = 3'b010;
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
          io_output_wbSel = 3'b001;
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
          casez(funct3)
            3'b010 : begin
              io_output_wbSel = 3'b001;
            end
            3'b011 : begin
            end
            default : begin
            end
          endcase
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
          casez(funct3)
            3'b001 : begin
              io_output_wbSel = 3'b011;
            end
            3'b010 : begin
              io_output_wbSel = 3'b011;
            end
            3'b011 : begin
              io_output_wbSel = 3'b011;
            end
            3'b101 : begin
              io_output_wbSel = 3'b011;
            end
            3'b110 : begin
              io_output_wbSel = 3'b011;
            end
            3'b111 : begin
              io_output_wbSel = 3'b011;
            end
            3'b000 : begin
            end
            default : begin
            end
          endcase
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_branch = 1'b0;
    if(isComp) begin
      case(switch_Decoder_l192)
        2'b00 : begin
        end
        2'b01 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b001 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            3'b100 : begin
            end
            3'b101 : begin
            end
            3'b110 : begin
              io_output_branch = 1'b1;
            end
            default : begin
              io_output_branch = 1'b1;
            end
          endcase
        end
        2'b10 : begin
        end
        default : begin
        end
      endcase
    end else begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
          io_output_branch = 1'b1;
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_jump = 1'b0;
    if(isComp) begin
      case(switch_Decoder_l192)
        2'b00 : begin
        end
        2'b01 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b001 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            3'b100 : begin
            end
            3'b101 : begin
              io_output_jump = 1'b1;
            end
            3'b110 : begin
            end
            default : begin
            end
          endcase
        end
        2'b10 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            3'b100 : begin
              if(when_Decoder_l374) begin
                if(when_Decoder_l375) begin
                  if(!when_Decoder_l376) begin
                    io_output_jump = 1'b1;
                  end
                end
              end else begin
                if(when_Decoder_l387) begin
                  if(!when_Decoder_l388) begin
                    io_output_jump = 1'b1;
                  end
                end
              end
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            default : begin
            end
          endcase
        end
        default : begin
        end
      endcase
    end else begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
          io_output_jump = 1'b1;
        end
        7'b1100111 : begin
          io_output_jump = 1'b1;
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_jalr = 1'b0;
    if(isComp) begin
      case(switch_Decoder_l192)
        2'b00 : begin
        end
        2'b01 : begin
        end
        2'b10 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            3'b100 : begin
              if(when_Decoder_l374) begin
                if(when_Decoder_l375) begin
                  if(!when_Decoder_l376) begin
                    io_output_jalr = 1'b1;
                  end
                end
              end else begin
                if(when_Decoder_l387) begin
                  if(!when_Decoder_l388) begin
                    io_output_jalr = 1'b1;
                  end
                end
              end
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            default : begin
            end
          endcase
        end
        default : begin
        end
      endcase
    end else begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
          io_output_jalr = 1'b1;
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_aluOp = AluOp_ADD;
    if(isComp) begin
      case(switch_Decoder_l192)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l196) begin
                io_output_aluOp = AluOp_ADD;
              end
            end
            3'b010 : begin
              io_output_aluOp = AluOp_ADD;
            end
            3'b011 : begin
              io_output_aluOp = AluOp_ADD;
            end
            3'b110 : begin
              io_output_aluOp = AluOp_ADD;
            end
            3'b111 : begin
              io_output_aluOp = AluOp_ADD;
            end
            default : begin
            end
          endcase
        end
        2'b01 : begin
          case(cfunct3)
            3'b000 : begin
              io_output_aluOp = AluOp_ADD;
            end
            3'b001 : begin
              if(!when_Decoder_l243) begin
                io_output_aluOp = AluOp_ADDW;
              end
            end
            3'b010 : begin
              io_output_aluOp = AluOp_ADD;
            end
            3'b011 : begin
              if(when_Decoder_l259) begin
                io_output_aluOp = AluOp_ADD;
              end else begin
                if(!when_Decoder_l264) begin
                  io_output_aluOp = AluOp_ADD;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l274)
                2'b00 : begin
                  io_output_aluOp = AluOp_SRL_1;
                end
                2'b01 : begin
                  io_output_aluOp = AluOp_SRA_1;
                end
                2'b10 : begin
                  io_output_aluOp = AluOp_AND_1;
                end
                default : begin
                  if(when_Decoder_l302) begin
                    case(switch_Decoder_l304)
                      2'b00 : begin
                        io_output_aluOp = AluOp_SUBW;
                      end
                      2'b01 : begin
                        io_output_aluOp = AluOp_ADDW;
                      end
                      default : begin
                      end
                    endcase
                  end else begin
                    io_output_aluOp = _zz_io_output_aluOp_2;
                  end
                end
              endcase
            end
            3'b101 : begin
            end
            3'b110 : begin
            end
            default : begin
            end
          endcase
        end
        2'b10 : begin
          case(cfunct3)
            3'b000 : begin
              io_output_aluOp = AluOp_SLL_1;
            end
            3'b010 : begin
              if(!when_Decoder_l356) begin
                io_output_aluOp = AluOp_ADD;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l364) begin
                io_output_aluOp = AluOp_ADD;
              end
            end
            3'b100 : begin
              if(when_Decoder_l374) begin
                if(!when_Decoder_l375) begin
                  io_output_aluOp = AluOp_ADD;
                end
              end else begin
                if(!when_Decoder_l387) begin
                  io_output_aluOp = AluOp_ADD;
                end
              end
            end
            3'b110 : begin
              io_output_aluOp = AluOp_ADD;
            end
            3'b111 : begin
              io_output_aluOp = AluOp_ADD;
            end
            default : begin
            end
          endcase
        end
        default : begin
        end
      endcase
    end else begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
          casez(funct3)
            3'b000 : begin
              io_output_aluOp = AluOp_ADD;
            end
            3'b001 : begin
              io_output_aluOp = AluOp_SLL_1;
            end
            3'b010 : begin
              io_output_aluOp = AluOp_SLT;
            end
            3'b011 : begin
              io_output_aluOp = AluOp_SLTU;
            end
            3'b100 : begin
              io_output_aluOp = AluOp_XOR_1;
            end
            3'b101 : begin
              io_output_aluOp = _zz_io_output_aluOp_3;
            end
            3'b110 : begin
              io_output_aluOp = AluOp_OR_1;
            end
            3'b111 : begin
              io_output_aluOp = AluOp_AND_1;
            end
            default : begin
            end
          endcase
        end
        7'b0011011 : begin
          casez(funct3)
            3'b000 : begin
              io_output_aluOp = AluOp_ADDW;
            end
            3'b001 : begin
              io_output_aluOp = AluOp_SLLW;
            end
            3'b101 : begin
              io_output_aluOp = _zz_io_output_aluOp_4;
            end
            default : begin
            end
          endcase
        end
        7'b0111011 : begin
          casez(funct7)
            7'b0000000 : begin
              casez(funct3)
                3'b000 : begin
                  io_output_aluOp = AluOp_ADDW;
                end
                3'b001 : begin
                  io_output_aluOp = AluOp_SLLW;
                end
                3'b101 : begin
                  io_output_aluOp = AluOp_SRLW;
                end
                default : begin
                end
              endcase
            end
            7'b0100000 : begin
              casez(funct3)
                3'b000 : begin
                  io_output_aluOp = AluOp_SUBW;
                end
                3'b101 : begin
                  io_output_aluOp = AluOp_SRAW;
                end
                default : begin
                end
              endcase
            end
            7'b0000001 : begin
            end
            default : begin
            end
          endcase
        end
        7'b0110011 : begin
          if(!when_Decoder_l882) begin
            casez(funct3)
              3'b000 : begin
                io_output_aluOp = _zz_io_output_aluOp_5;
              end
              3'b001 : begin
                io_output_aluOp = AluOp_SLL_1;
              end
              3'b010 : begin
                io_output_aluOp = AluOp_SLT;
              end
              3'b011 : begin
                io_output_aluOp = AluOp_SLTU;
              end
              3'b100 : begin
                io_output_aluOp = AluOp_XOR_1;
              end
              3'b101 : begin
                io_output_aluOp = _zz_io_output_aluOp_6;
              end
              3'b110 : begin
                io_output_aluOp = AluOp_OR_1;
              end
              3'b111 : begin
                io_output_aluOp = AluOp_AND_1;
              end
              default : begin
              end
            endcase
          end
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_branchType = BranchOp_NONE;
    if(isComp) begin
      case(switch_Decoder_l192)
        2'b00 : begin
        end
        2'b01 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b001 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            3'b100 : begin
            end
            3'b101 : begin
            end
            3'b110 : begin
              io_output_branchType = BranchOp_BEQ;
            end
            default : begin
              io_output_branchType = BranchOp_BNE;
            end
          endcase
        end
        2'b10 : begin
        end
        default : begin
        end
      endcase
    end else begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
          casez(funct3)
            3'b000 : begin
              io_output_branchType = BranchOp_BEQ;
            end
            3'b001 : begin
              io_output_branchType = BranchOp_BNE;
            end
            3'b100 : begin
              io_output_branchType = BranchOp_BLT;
            end
            3'b101 : begin
              io_output_branchType = BranchOp_BGE;
            end
            3'b110 : begin
              io_output_branchType = BranchOp_BLTU;
            end
            3'b111 : begin
              io_output_branchType = BranchOp_BGEU;
            end
            default : begin
            end
          endcase
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_aluASrc = 2'b00;
    if(isComp) begin
      case(switch_Decoder_l192)
        2'b00 : begin
        end
        2'b01 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b001 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
              if(!when_Decoder_l259) begin
                if(!when_Decoder_l264) begin
                  io_output_aluASrc = 2'b10;
                end
              end
            end
            3'b100 : begin
            end
            3'b101 : begin
            end
            3'b110 : begin
            end
            default : begin
            end
          endcase
        end
        2'b10 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            3'b100 : begin
              if(when_Decoder_l374) begin
                if(!when_Decoder_l375) begin
                  io_output_aluASrc = 2'b10;
                end
              end
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            default : begin
            end
          endcase
        end
        default : begin
        end
      endcase
    end else begin
      casez(opcode)
        7'b0110111 : begin
          io_output_aluASrc = 2'b10;
        end
        7'b0010111 : begin
          io_output_aluASrc = 2'b01;
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_memRead = 1'b0;
    if(isComp) begin
      case(switch_Decoder_l192)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b010 : begin
              io_output_memRead = 1'b1;
            end
            3'b011 : begin
              io_output_memRead = 1'b1;
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            default : begin
            end
          endcase
        end
        2'b01 : begin
        end
        2'b10 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b010 : begin
              if(!when_Decoder_l356) begin
                io_output_memRead = 1'b1;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l364) begin
                io_output_memRead = 1'b1;
              end
            end
            3'b100 : begin
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            default : begin
            end
          endcase
        end
        default : begin
        end
      endcase
    end else begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
          io_output_memRead = 1'b1;
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
          casez(funct3)
            3'b010 : begin
              io_output_memRead = 1'b1;
            end
            3'b011 : begin
            end
            default : begin
            end
          endcase
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_memWrite = 1'b0;
    if(isComp) begin
      case(switch_Decoder_l192)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            3'b110 : begin
              io_output_memWrite = 1'b1;
            end
            3'b111 : begin
              io_output_memWrite = 1'b1;
            end
            default : begin
            end
          endcase
        end
        2'b01 : begin
        end
        2'b10 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            3'b100 : begin
            end
            3'b110 : begin
              io_output_memWrite = 1'b1;
            end
            3'b111 : begin
              io_output_memWrite = 1'b1;
            end
            default : begin
            end
          endcase
        end
        default : begin
        end
      endcase
    end else begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
          io_output_memWrite = 1'b1;
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
          io_output_memWrite = 1'b1;
        end
        7'b1010011 : begin
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_memSize = 2'b10;
    if(isComp) begin
      case(switch_Decoder_l192)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b010 : begin
              io_output_memSize = 2'b10;
            end
            3'b011 : begin
              io_output_memSize = 2'b11;
            end
            3'b110 : begin
              io_output_memSize = 2'b10;
            end
            3'b111 : begin
              io_output_memSize = 2'b11;
            end
            default : begin
            end
          endcase
        end
        2'b01 : begin
        end
        2'b10 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b010 : begin
              if(!when_Decoder_l356) begin
                io_output_memSize = 2'b10;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l364) begin
                io_output_memSize = 2'b11;
              end
            end
            3'b100 : begin
            end
            3'b110 : begin
              io_output_memSize = 2'b10;
            end
            3'b111 : begin
              io_output_memSize = 2'b11;
            end
            default : begin
            end
          endcase
        end
        default : begin
        end
      endcase
    end else begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
          casez(funct3)
            3'b000 : begin
              io_output_memSize = 2'b00;
            end
            3'b001 : begin
              io_output_memSize = 2'b01;
            end
            3'b010 : begin
              io_output_memSize = 2'b10;
            end
            3'b100 : begin
              io_output_memSize = 2'b00;
            end
            3'b101 : begin
              io_output_memSize = 2'b01;
            end
            3'b011 : begin
              io_output_memSize = 2'b11;
            end
            3'b110 : begin
              io_output_memSize = 2'b10;
            end
            default : begin
            end
          endcase
        end
        7'b0100011 : begin
          casez(funct3)
            3'b000 : begin
              io_output_memSize = 2'b00;
            end
            3'b001 : begin
              io_output_memSize = 2'b01;
            end
            3'b010 : begin
              io_output_memSize = 2'b10;
            end
            3'b011 : begin
              io_output_memSize = 2'b11;
            end
            default : begin
            end
          endcase
        end
        7'b0000111 : begin
          casez(funct3)
            3'b010 : begin
              io_output_memSize = 2'b10;
            end
            3'b011 : begin
            end
            default : begin
            end
          endcase
        end
        7'b0100111 : begin
          casez(funct3)
            3'b010 : begin
              io_output_memSize = 2'b10;
            end
            3'b011 : begin
            end
            default : begin
            end
          endcase
        end
        7'b1010011 : begin
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_memSign = 1'b0;
    if(!isComp) begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
          casez(funct3)
            3'b000 : begin
              io_output_memSign = 1'b1;
            end
            3'b001 : begin
              io_output_memSign = 1'b1;
            end
            3'b010 : begin
              io_output_memSign = 1'b1;
            end
            3'b100 : begin
            end
            3'b101 : begin
            end
            3'b011 : begin
            end
            3'b110 : begin
            end
            default : begin
            end
          endcase
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  assign io_output_atomic = 1'b0;
  assign io_output_isLr = 1'b0;
  assign io_output_isSc = 1'b0;
  assign io_output_amoOp = 5'h0;
  always @(*) begin
    io_output_fp = 1'b0;
    if(!isComp) begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
          io_output_fp = 1'b1;
        end
        7'b0100111 : begin
          io_output_fp = 1'b1;
        end
        7'b1010011 : begin
          io_output_fp = 1'b1;
        end
        7'b1000011 : begin
          io_output_fp = 1'b1;
        end
        7'b1000111 : begin
          io_output_fp = 1'b1;
        end
        7'b1001011 : begin
          io_output_fp = 1'b1;
        end
        7'b1001111 : begin
          io_output_fp = 1'b1;
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_fpWrite = 1'b0;
    if(!isComp) begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
          io_output_fpWrite = 1'b1;
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
          case(funct6)
            6'h0 : begin
              io_output_fpWrite = 1'b1;
            end
            6'h02 : begin
              io_output_fpWrite = 1'b1;
            end
            6'h04 : begin
              io_output_fpWrite = 1'b1;
            end
            6'h06 : begin
              io_output_fpWrite = 1'b1;
            end
            6'h16 : begin
              io_output_fpWrite = 1'b1;
            end
            6'h08 : begin
              io_output_fpWrite = 1'b1;
            end
            6'h0a : begin
              io_output_fpWrite = 1'b1;
            end
            6'h28 : begin
            end
            6'h38 : begin
            end
            6'h3c : begin
              io_output_fpWrite = 1'b1;
            end
            6'h30 : begin
            end
            6'h34 : begin
              io_output_fpWrite = 1'b1;
            end
            6'h10 : begin
            end
            default : begin
            end
          endcase
        end
        7'b1000011 : begin
          io_output_fpWrite = 1'b1;
        end
        7'b1000111 : begin
          io_output_fpWrite = 1'b1;
        end
        7'b1001011 : begin
          io_output_fpWrite = 1'b1;
        end
        7'b1001111 : begin
          io_output_fpWrite = 1'b1;
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_fpLoad = 1'b0;
    if(!isComp) begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
          io_output_fpLoad = 1'b1;
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_fpStore = 1'b0;
    if(!isComp) begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
          io_output_fpStore = 1'b1;
        end
        7'b1010011 : begin
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_fpIntRd = 1'b0;
    if(!isComp) begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
          case(funct6)
            6'h0 : begin
            end
            6'h02 : begin
            end
            6'h04 : begin
            end
            6'h06 : begin
            end
            6'h16 : begin
            end
            6'h08 : begin
            end
            6'h0a : begin
            end
            6'h28 : begin
              io_output_fpIntRd = 1'b1;
            end
            6'h38 : begin
              io_output_fpIntRd = 1'b1;
            end
            6'h3c : begin
            end
            6'h30 : begin
              io_output_fpIntRd = 1'b1;
            end
            6'h34 : begin
            end
            6'h10 : begin
            end
            default : begin
            end
          endcase
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_fpOp = 6'h0;
    if(!isComp) begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
          case(funct6)
            6'h0 : begin
              io_output_fpOp = 6'h0;
            end
            6'h02 : begin
              io_output_fpOp = 6'h01;
            end
            6'h04 : begin
              io_output_fpOp = 6'h02;
            end
            6'h06 : begin
              io_output_fpOp = 6'h03;
            end
            6'h16 : begin
              io_output_fpOp = 6'h04;
            end
            6'h08 : begin
              case(funct3)
                3'b000 : begin
                  io_output_fpOp = 6'h07;
                end
                3'b001 : begin
                  io_output_fpOp = 6'h08;
                end
                3'b010 : begin
                  io_output_fpOp = 6'h09;
                end
                default : begin
                end
              endcase
            end
            6'h0a : begin
              case(funct3)
                3'b000 : begin
                  io_output_fpOp = 6'h05;
                end
                3'b001 : begin
                  io_output_fpOp = 6'h06;
                end
                default : begin
                end
              endcase
            end
            6'h28 : begin
              case(funct3)
                3'b000 : begin
                  io_output_fpOp = 6'h0c;
                end
                3'b001 : begin
                  io_output_fpOp = 6'h0b;
                end
                3'b010 : begin
                  io_output_fpOp = 6'h0a;
                end
                default : begin
                end
              endcase
            end
            6'h38 : begin
              case(funct3)
                3'b000 : begin
                  io_output_fpOp = 6'h0e;
                end
                3'b001 : begin
                  io_output_fpOp = 6'h0d;
                end
                default : begin
                end
              endcase
            end
            6'h3c : begin
              io_output_fpOp = 6'h0f;
            end
            6'h30 : begin
              case(convSel)
                2'b00 : begin
                  io_output_fpOp = 6'h10;
                end
                2'b01 : begin
                  io_output_fpOp = 6'h11;
                end
                2'b10 : begin
                  io_output_fpOp = 6'h12;
                end
                default : begin
                  io_output_fpOp = 6'h13;
                end
              endcase
            end
            6'h34 : begin
              case(convSel)
                2'b00 : begin
                  io_output_fpOp = 6'h14;
                end
                2'b01 : begin
                  io_output_fpOp = 6'h15;
                end
                2'b10 : begin
                  io_output_fpOp = 6'h16;
                end
                default : begin
                  io_output_fpOp = 6'h17;
                end
              endcase
            end
            6'h10 : begin
            end
            default : begin
            end
          endcase
        end
        7'b1000011 : begin
          io_output_fpOp = 6'h18;
        end
        7'b1000111 : begin
          io_output_fpOp = 6'h19;
        end
        7'b1001011 : begin
          io_output_fpOp = 6'h1a;
        end
        7'b1001111 : begin
          io_output_fpOp = 6'h1b;
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_fpRm = 3'b000;
    if(!isComp) begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
          io_output_fpRm = funct3;
        end
        7'b1000011 : begin
          io_output_fpRm = funct3;
        end
        7'b1000111 : begin
          io_output_fpRm = funct3;
        end
        7'b1001011 : begin
          io_output_fpRm = funct3;
        end
        7'b1001111 : begin
          io_output_fpRm = funct3;
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_fpFmt = 1'b0;
    if(!isComp) begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
          io_output_fpFmt = io_instruction[25];
        end
        7'b1000011 : begin
          io_output_fpFmt = io_instruction[25];
        end
        7'b1000111 : begin
          io_output_fpFmt = io_instruction[25];
        end
        7'b1001011 : begin
          io_output_fpFmt = io_instruction[25];
        end
        7'b1001111 : begin
          io_output_fpFmt = io_instruction[25];
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_rs3 = io_instruction[31 : 27];
    if(!isComp) begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
        end
        7'b1000011 : begin
          io_output_rs3 = io_instruction[31 : 27];
        end
        7'b1000111 : begin
          io_output_rs3 = io_instruction[31 : 27];
        end
        7'b1001011 : begin
          io_output_rs3 = io_instruction[31 : 27];
        end
        7'b1001111 : begin
          io_output_rs3 = io_instruction[31 : 27];
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_rs1 = rs1Num;
    if(isComp) begin
      case(switch_Decoder_l192)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l196) begin
                io_output_rs1 = 5'h02;
              end
            end
            3'b010 : begin
              io_output_rs1 = crs1p;
            end
            3'b011 : begin
              io_output_rs1 = crs1p;
            end
            3'b110 : begin
              io_output_rs1 = crs1p;
            end
            3'b111 : begin
              io_output_rs1 = crs1p;
            end
            default : begin
            end
          endcase
        end
        2'b01 : begin
          case(cfunct3)
            3'b000 : begin
              io_output_rs1 = crd;
            end
            3'b001 : begin
              if(!when_Decoder_l243) begin
                io_output_rs1 = crd;
              end
            end
            3'b010 : begin
              io_output_rs1 = 5'h0;
            end
            3'b011 : begin
              if(when_Decoder_l259) begin
                io_output_rs1 = 5'h02;
              end
            end
            3'b100 : begin
              case(switch_Decoder_l274)
                2'b00 : begin
                  io_output_rs1 = crs1p;
                end
                2'b01 : begin
                  io_output_rs1 = crs1p;
                end
                2'b10 : begin
                  io_output_rs1 = crs1p;
                end
                default : begin
                  if(when_Decoder_l302) begin
                    case(switch_Decoder_l304)
                      2'b00 : begin
                        io_output_rs1 = crs1p;
                      end
                      2'b01 : begin
                        io_output_rs1 = crs1p;
                      end
                      default : begin
                      end
                    endcase
                  end else begin
                    io_output_rs1 = crs1p;
                  end
                end
              endcase
            end
            3'b101 : begin
            end
            3'b110 : begin
              io_output_rs1 = crs1p;
            end
            default : begin
              io_output_rs1 = crs1p;
            end
          endcase
        end
        2'b10 : begin
          case(cfunct3)
            3'b000 : begin
              io_output_rs1 = crd;
            end
            3'b010 : begin
              if(!when_Decoder_l356) begin
                io_output_rs1 = 5'h02;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l364) begin
                io_output_rs1 = 5'h02;
              end
            end
            3'b100 : begin
              if(when_Decoder_l374) begin
                if(when_Decoder_l375) begin
                  if(!when_Decoder_l376) begin
                    io_output_rs1 = crd;
                  end
                end
              end else begin
                if(when_Decoder_l387) begin
                  if(!when_Decoder_l388) begin
                    io_output_rs1 = crd;
                  end
                end else begin
                  io_output_rs1 = crd;
                end
              end
            end
            3'b110 : begin
              io_output_rs1 = 5'h02;
            end
            3'b111 : begin
              io_output_rs1 = 5'h02;
            end
            default : begin
            end
          endcase
        end
        default : begin
        end
      endcase
    end else begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
          io_output_rs1 = rs1Num;
        end
        7'b1000011 : begin
          io_output_rs1 = rs1Num;
        end
        7'b1000111 : begin
          io_output_rs1 = rs1Num;
        end
        7'b1001011 : begin
          io_output_rs1 = rs1Num;
        end
        7'b1001111 : begin
          io_output_rs1 = rs1Num;
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_rs2 = io_instruction[24 : 20];
    if(isComp) begin
      case(switch_Decoder_l192)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            3'b110 : begin
              io_output_rs2 = crs2p;
            end
            3'b111 : begin
              io_output_rs2 = crs2p;
            end
            default : begin
            end
          endcase
        end
        2'b01 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b001 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            3'b100 : begin
              case(switch_Decoder_l274)
                2'b00 : begin
                end
                2'b01 : begin
                end
                2'b10 : begin
                end
                default : begin
                  if(when_Decoder_l302) begin
                    case(switch_Decoder_l304)
                      2'b00 : begin
                        io_output_rs2 = crs2p;
                      end
                      2'b01 : begin
                        io_output_rs2 = crs2p;
                      end
                      default : begin
                      end
                    endcase
                  end else begin
                    io_output_rs2 = crs2p;
                  end
                end
              endcase
            end
            3'b101 : begin
            end
            3'b110 : begin
              io_output_rs2 = 5'h0;
            end
            default : begin
              io_output_rs2 = 5'h0;
            end
          endcase
        end
        2'b10 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            3'b100 : begin
              if(when_Decoder_l374) begin
                if(!when_Decoder_l375) begin
                  io_output_rs2 = crs2;
                end
              end else begin
                if(!when_Decoder_l387) begin
                  io_output_rs2 = crs2;
                end
              end
            end
            3'b110 : begin
              io_output_rs2 = crs2;
            end
            3'b111 : begin
              io_output_rs2 = crs2;
            end
            default : begin
            end
          endcase
        end
        default : begin
        end
      endcase
    end else begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
          io_output_rs2 = io_instruction[24 : 20];
        end
        7'b1000011 : begin
          io_output_rs2 = io_instruction[24 : 20];
        end
        7'b1000111 : begin
          io_output_rs2 = io_instruction[24 : 20];
        end
        7'b1001011 : begin
          io_output_rs2 = io_instruction[24 : 20];
        end
        7'b1001111 : begin
          io_output_rs2 = io_instruction[24 : 20];
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_rd = rdNum;
    if(isComp) begin
      case(switch_Decoder_l192)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l196) begin
                io_output_rd = crdp;
              end
            end
            3'b010 : begin
              io_output_rd = crdp;
            end
            3'b011 : begin
              io_output_rd = crdp;
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            default : begin
            end
          endcase
        end
        2'b01 : begin
          case(cfunct3)
            3'b000 : begin
              io_output_rd = crd;
            end
            3'b001 : begin
              if(!when_Decoder_l243) begin
                io_output_rd = crd;
              end
            end
            3'b010 : begin
              io_output_rd = crd;
            end
            3'b011 : begin
              if(when_Decoder_l259) begin
                io_output_rd = 5'h02;
              end else begin
                if(!when_Decoder_l264) begin
                  io_output_rd = crd;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l274)
                2'b00 : begin
                  io_output_rd = crs1p;
                end
                2'b01 : begin
                  io_output_rd = crs1p;
                end
                2'b10 : begin
                  io_output_rd = crs1p;
                end
                default : begin
                  if(when_Decoder_l302) begin
                    case(switch_Decoder_l304)
                      2'b00 : begin
                        io_output_rd = crs1p;
                      end
                      2'b01 : begin
                        io_output_rd = crs1p;
                      end
                      default : begin
                      end
                    endcase
                  end else begin
                    io_output_rd = crs1p;
                  end
                end
              endcase
            end
            3'b101 : begin
              io_output_rd = 5'h0;
            end
            3'b110 : begin
            end
            default : begin
            end
          endcase
        end
        2'b10 : begin
          case(cfunct3)
            3'b000 : begin
              io_output_rd = crd;
            end
            3'b010 : begin
              if(!when_Decoder_l356) begin
                io_output_rd = crd;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l364) begin
                io_output_rd = crd;
              end
            end
            3'b100 : begin
              if(when_Decoder_l374) begin
                if(!when_Decoder_l375) begin
                  io_output_rd = crd;
                end
              end else begin
                if(when_Decoder_l387) begin
                  if(!when_Decoder_l388) begin
                    io_output_rd = 5'h01;
                  end
                end else begin
                  io_output_rd = crd;
                end
              end
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            default : begin
            end
          endcase
        end
        default : begin
        end
      endcase
    end else begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
          casez(funct3)
            3'b010 : begin
              io_output_rd = rdNum;
            end
            3'b011 : begin
            end
            default : begin
            end
          endcase
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
          io_output_rd = rdNum;
        end
        7'b1000011 : begin
          io_output_rd = rdNum;
        end
        7'b1000111 : begin
          io_output_rd = rdNum;
        end
        7'b1001011 : begin
          io_output_rd = rdNum;
        end
        7'b1001111 : begin
          io_output_rd = rdNum;
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_imm = immI;
    if(isComp) begin
      case(switch_Decoder_l192)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l196) begin
                io_output_imm = _zz_io_output_imm;
              end
            end
            3'b010 : begin
              io_output_imm = _zz_io_output_imm_1;
            end
            3'b011 : begin
              io_output_imm = {{56{cLdImm[7]}}, cLdImm};
            end
            3'b110 : begin
              io_output_imm = _zz_io_output_imm_2;
            end
            3'b111 : begin
              io_output_imm = {{56{cLdImm[7]}}, cLdImm};
            end
            default : begin
            end
          endcase
        end
        2'b01 : begin
          case(cfunct3)
            3'b000 : begin
              io_output_imm = {{58{c6S[5]}}, c6S};
            end
            3'b001 : begin
              if(!when_Decoder_l243) begin
                io_output_imm = {{58{c6S[5]}}, c6S};
              end
            end
            3'b010 : begin
              io_output_imm = {{58{c6S[5]}}, c6S};
            end
            3'b011 : begin
              if(when_Decoder_l259) begin
                io_output_imm = {{54{cAddi16sp[9]}}, cAddi16sp};
              end else begin
                if(!when_Decoder_l264) begin
                  io_output_imm = {{46{_zz_io_output_imm_3[17]}}, _zz_io_output_imm_3};
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l274)
                2'b00 : begin
                  io_output_imm = cShamt;
                end
                2'b01 : begin
                  io_output_imm = cShamt;
                end
                2'b10 : begin
                  io_output_imm = {{58{c6S[5]}}, c6S};
                end
                default : begin
                end
              endcase
            end
            3'b101 : begin
              io_output_imm = {{52{cJImm[11]}}, cJImm};
            end
            3'b110 : begin
              io_output_imm = {{55{cBImm[8]}}, cBImm};
            end
            default : begin
              io_output_imm = {{55{cBImm[8]}}, cBImm};
            end
          endcase
        end
        2'b10 : begin
          case(cfunct3)
            3'b000 : begin
              io_output_imm = cShamt;
            end
            3'b010 : begin
              if(!when_Decoder_l356) begin
                io_output_imm = _zz_io_output_imm_4;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l364) begin
                io_output_imm = {{55{cLdspImm[8]}}, cLdspImm};
              end
            end
            3'b100 : begin
              if(when_Decoder_l374) begin
                if(when_Decoder_l375) begin
                  if(!when_Decoder_l376) begin
                    io_output_imm = 64'h0;
                  end
                end
              end else begin
                if(when_Decoder_l387) begin
                  if(!when_Decoder_l388) begin
                    io_output_imm = 64'h0;
                  end
                end
              end
            end
            3'b110 : begin
              io_output_imm = _zz_io_output_imm_5;
            end
            3'b111 : begin
              io_output_imm = {{55{cSdspImm[8]}}, cSdspImm};
            end
            default : begin
            end
          endcase
        end
        default : begin
        end
      endcase
    end else begin
      casez(opcode)
        7'b0110111 : begin
          io_output_imm = immU;
        end
        7'b0010111 : begin
          io_output_imm = immU;
        end
        7'b1101111 : begin
          io_output_imm = immJ;
        end
        7'b1100111 : begin
          io_output_imm = immI;
        end
        7'b1100011 : begin
          io_output_imm = immB;
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
          io_output_imm = immS;
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
          io_output_imm = immS;
        end
        7'b1010011 : begin
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_illegal = 1'b0;
    if(isComp) begin
      case(switch_Decoder_l192)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(when_Decoder_l196) begin
                io_output_illegal = 1'b1;
              end
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            default : begin
              io_output_illegal = 1'b1;
            end
          endcase
        end
        2'b01 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b001 : begin
              if(when_Decoder_l243) begin
                io_output_illegal = 1'b1;
              end
            end
            3'b010 : begin
            end
            3'b011 : begin
              if(!when_Decoder_l259) begin
                if(when_Decoder_l264) begin
                  io_output_illegal = 1'b1;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l274)
                2'b00 : begin
                end
                2'b01 : begin
                end
                2'b10 : begin
                end
                default : begin
                  if(when_Decoder_l302) begin
                    case(switch_Decoder_l304)
                      2'b00 : begin
                      end
                      2'b01 : begin
                      end
                      default : begin
                        io_output_illegal = 1'b1;
                      end
                    endcase
                  end
                end
              endcase
            end
            3'b101 : begin
            end
            3'b110 : begin
            end
            default : begin
            end
          endcase
        end
        2'b10 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b010 : begin
              if(when_Decoder_l356) begin
                io_output_illegal = 1'b1;
              end
            end
            3'b011 : begin
              if(when_Decoder_l364) begin
                io_output_illegal = 1'b1;
              end
            end
            3'b100 : begin
              if(when_Decoder_l374) begin
                if(when_Decoder_l375) begin
                  if(when_Decoder_l376) begin
                    io_output_illegal = 1'b1;
                  end
                end
              end
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            default : begin
              io_output_illegal = 1'b1;
            end
          endcase
        end
        default : begin
          io_output_illegal = 1'b1;
        end
      endcase
    end else begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
          casez(funct3)
            3'b000 : begin
            end
            3'b001 : begin
            end
            3'b100 : begin
            end
            3'b101 : begin
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            default : begin
              io_output_illegal = 1'b1;
            end
          endcase
        end
        7'b0000011 : begin
          casez(funct3)
            3'b000 : begin
            end
            3'b001 : begin
            end
            3'b010 : begin
            end
            3'b100 : begin
            end
            3'b101 : begin
            end
            3'b011 : begin
            end
            3'b110 : begin
            end
            default : begin
              io_output_illegal = 1'b1;
            end
          endcase
        end
        7'b0100011 : begin
          casez(funct3)
            3'b000 : begin
            end
            3'b001 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            default : begin
              io_output_illegal = 1'b1;
            end
          endcase
        end
        7'b0000111 : begin
          casez(funct3)
            3'b010 : begin
            end
            3'b011 : begin
              io_output_illegal = 1'b1;
            end
            default : begin
              io_output_illegal = 1'b1;
            end
          endcase
        end
        7'b0100111 : begin
          casez(funct3)
            3'b010 : begin
            end
            3'b011 : begin
              io_output_illegal = 1'b1;
            end
            default : begin
              io_output_illegal = 1'b1;
            end
          endcase
        end
        7'b1010011 : begin
          if(when_Decoder_l544) begin
            io_output_illegal = 1'b1;
          end
          case(funct6)
            6'h0 : begin
            end
            6'h02 : begin
            end
            6'h04 : begin
            end
            6'h06 : begin
            end
            6'h16 : begin
            end
            6'h08 : begin
              case(funct3)
                3'b000 : begin
                end
                3'b001 : begin
                end
                3'b010 : begin
                end
                default : begin
                  io_output_illegal = 1'b1;
                end
              endcase
            end
            6'h0a : begin
              case(funct3)
                3'b000 : begin
                end
                3'b001 : begin
                end
                default : begin
                  io_output_illegal = 1'b1;
                end
              endcase
            end
            6'h28 : begin
              case(funct3)
                3'b000 : begin
                end
                3'b001 : begin
                end
                3'b010 : begin
                end
                default : begin
                  io_output_illegal = 1'b1;
                end
              endcase
            end
            6'h38 : begin
              case(funct3)
                3'b000 : begin
                end
                3'b001 : begin
                end
                default : begin
                  io_output_illegal = 1'b1;
                end
              endcase
            end
            6'h3c : begin
              if(when_Decoder_l590) begin
                io_output_illegal = 1'b1;
              end
            end
            6'h30 : begin
            end
            6'h34 : begin
            end
            6'h10 : begin
              io_output_illegal = 1'b1;
            end
            default : begin
              io_output_illegal = 1'b1;
            end
          endcase
        end
        7'b1000011 : begin
          if(when_Decoder_l644) begin
            io_output_illegal = 1'b1;
          end
        end
        7'b1000111 : begin
          if(when_Decoder_l653) begin
            io_output_illegal = 1'b1;
          end
        end
        7'b1001011 : begin
          if(when_Decoder_l662) begin
            io_output_illegal = 1'b1;
          end
        end
        7'b1001111 : begin
          if(when_Decoder_l671) begin
            io_output_illegal = 1'b1;
          end
        end
        7'b0101111 : begin
          io_output_illegal = 1'b1;
        end
        7'b0010011 : begin
          casez(funct3)
            3'b000 : begin
            end
            3'b001 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            3'b100 : begin
            end
            3'b101 : begin
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            default : begin
              io_output_illegal = 1'b1;
            end
          endcase
        end
        7'b0011011 : begin
          casez(funct3)
            3'b000 : begin
            end
            3'b001 : begin
            end
            3'b101 : begin
            end
            default : begin
              io_output_illegal = 1'b1;
            end
          endcase
        end
        7'b0111011 : begin
          casez(funct7)
            7'b0000000 : begin
              casez(funct3)
                3'b000 : begin
                end
                3'b001 : begin
                end
                3'b101 : begin
                end
                default : begin
                  io_output_illegal = 1'b1;
                end
              endcase
            end
            7'b0100000 : begin
              casez(funct3)
                3'b000 : begin
                end
                3'b101 : begin
                end
                default : begin
                  io_output_illegal = 1'b1;
                end
              endcase
            end
            7'b0000001 : begin
              io_output_illegal = 1'b1;
            end
            default : begin
              io_output_illegal = 1'b1;
            end
          endcase
        end
        7'b0110011 : begin
          if(when_Decoder_l882) begin
            io_output_illegal = 1'b1;
          end else begin
            casez(funct3)
              3'b000 : begin
              end
              3'b001 : begin
              end
              3'b010 : begin
              end
              3'b011 : begin
              end
              3'b100 : begin
              end
              3'b101 : begin
              end
              3'b110 : begin
              end
              3'b111 : begin
              end
              default : begin
                io_output_illegal = 1'b1;
              end
            endcase
          end
        end
        7'b0001111 : begin
          casez(funct3)
            3'b000 : begin
            end
            3'b001 : begin
            end
            default : begin
              io_output_illegal = 1'b1;
            end
          endcase
        end
        7'b1110011 : begin
          casez(funct3)
            3'b001 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            3'b101 : begin
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            3'b000 : begin
            end
            default : begin
              io_output_illegal = 1'b1;
            end
          endcase
        end
        default : begin
          io_output_illegal = 1'b1;
        end
      endcase
    end
  end

  always @(*) begin
    io_output_csrOp = CsrOp_NONE;
    if(!isComp) begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
          casez(funct3)
            3'b001 : begin
              io_output_csrOp = CsrOp_WRITE;
            end
            3'b010 : begin
              io_output_csrOp = CsrOp_SET;
            end
            3'b011 : begin
              io_output_csrOp = CsrOp_CLEAR;
            end
            3'b101 : begin
              io_output_csrOp = CsrOp_WRITE;
            end
            3'b110 : begin
              io_output_csrOp = CsrOp_SET;
            end
            3'b111 : begin
              io_output_csrOp = CsrOp_CLEAR;
            end
            3'b000 : begin
            end
            default : begin
            end
          endcase
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_csrAddr = 12'h0;
    if(!isComp) begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
          io_output_csrAddr = io_instruction[31 : 20];
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_csrImm = 1'b0;
    if(!isComp) begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
          casez(funct3)
            3'b001 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            3'b101 : begin
              io_output_csrImm = 1'b1;
            end
            3'b110 : begin
              io_output_csrImm = 1'b1;
            end
            3'b111 : begin
              io_output_csrImm = 1'b1;
            end
            3'b000 : begin
            end
            default : begin
            end
          endcase
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_csrWe = 1'b0;
    if(!isComp) begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
          casez(funct3)
            3'b001 : begin
              io_output_csrWe = csrWrite;
            end
            3'b010 : begin
              io_output_csrWe = csrWrite;
            end
            3'b011 : begin
              io_output_csrWe = csrWrite;
            end
            3'b101 : begin
              io_output_csrWe = 1'b1;
            end
            3'b110 : begin
              io_output_csrWe = csrWrite;
            end
            3'b111 : begin
              io_output_csrWe = csrWrite;
            end
            3'b000 : begin
            end
            default : begin
            end
          endcase
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_sysOp = SysOp_NONE;
    if(isComp) begin
      case(switch_Decoder_l192)
        2'b00 : begin
        end
        2'b01 : begin
        end
        2'b10 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            3'b100 : begin
              if(!when_Decoder_l374) begin
                if(when_Decoder_l387) begin
                  if(when_Decoder_l388) begin
                    io_output_sysOp = SysOp_EBREAK;
                  end
                end
              end
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            default : begin
            end
          endcase
        end
        default : begin
        end
      endcase
    end else begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
        end
        7'b0000011 : begin
        end
        7'b0100011 : begin
        end
        7'b0000111 : begin
        end
        7'b0100111 : begin
        end
        7'b1010011 : begin
        end
        7'b1000011 : begin
        end
        7'b1000111 : begin
        end
        7'b1001011 : begin
        end
        7'b1001111 : begin
        end
        7'b0101111 : begin
        end
        7'b0010011 : begin
        end
        7'b0011011 : begin
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
        end
        7'b0001111 : begin
        end
        7'b1110011 : begin
          casez(funct3)
            3'b001 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            3'b101 : begin
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            3'b000 : begin
              casez(switch_Decoder_l1024)
                12'b000000000000 : begin
                  io_output_sysOp = SysOp_ECALL;
                end
                12'b000000000001 : begin
                  io_output_sysOp = SysOp_EBREAK;
                end
                12'b001100000010 : begin
                  io_output_sysOp = SysOp_MRET;
                end
                12'b000100000101 : begin
                  io_output_sysOp = SysOp_WFI;
                end
                default : begin
                  io_output_sysOp = SysOp_ILLEGAL;
                end
              endcase
            end
            default : begin
            end
          endcase
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    io_output_valid = 1'b1;
    if(isComp) begin
      case(switch_Decoder_l192)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(when_Decoder_l196) begin
                io_output_valid = 1'b0;
              end
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            default : begin
              io_output_valid = 1'b0;
            end
          endcase
        end
        2'b01 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b001 : begin
              if(when_Decoder_l243) begin
                io_output_valid = 1'b0;
              end
            end
            3'b010 : begin
            end
            3'b011 : begin
              if(!when_Decoder_l259) begin
                if(when_Decoder_l264) begin
                  io_output_valid = 1'b0;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l274)
                2'b00 : begin
                end
                2'b01 : begin
                end
                2'b10 : begin
                end
                default : begin
                  if(when_Decoder_l302) begin
                    case(switch_Decoder_l304)
                      2'b00 : begin
                      end
                      2'b01 : begin
                      end
                      default : begin
                        io_output_valid = 1'b0;
                      end
                    endcase
                  end
                end
              endcase
            end
            3'b101 : begin
            end
            3'b110 : begin
            end
            default : begin
            end
          endcase
        end
        2'b10 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b010 : begin
              if(when_Decoder_l356) begin
                io_output_valid = 1'b0;
              end
            end
            3'b011 : begin
              if(when_Decoder_l364) begin
                io_output_valid = 1'b0;
              end
            end
            3'b100 : begin
              if(when_Decoder_l374) begin
                if(when_Decoder_l375) begin
                  if(when_Decoder_l376) begin
                    io_output_valid = 1'b0;
                  end
                end
              end
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            default : begin
              io_output_valid = 1'b0;
            end
          endcase
        end
        default : begin
          io_output_valid = 1'b0;
        end
      endcase
    end else begin
      casez(opcode)
        7'b0110111 : begin
        end
        7'b0010111 : begin
        end
        7'b1101111 : begin
        end
        7'b1100111 : begin
        end
        7'b1100011 : begin
          casez(funct3)
            3'b000 : begin
            end
            3'b001 : begin
            end
            3'b100 : begin
            end
            3'b101 : begin
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            default : begin
              io_output_valid = 1'b0;
            end
          endcase
        end
        7'b0000011 : begin
          casez(funct3)
            3'b000 : begin
            end
            3'b001 : begin
            end
            3'b010 : begin
            end
            3'b100 : begin
            end
            3'b101 : begin
            end
            3'b011 : begin
            end
            3'b110 : begin
            end
            default : begin
              io_output_valid = 1'b0;
            end
          endcase
        end
        7'b0100011 : begin
          casez(funct3)
            3'b000 : begin
            end
            3'b001 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            default : begin
              io_output_valid = 1'b0;
            end
          endcase
        end
        7'b0000111 : begin
          casez(funct3)
            3'b010 : begin
            end
            3'b011 : begin
              io_output_valid = 1'b0;
            end
            default : begin
              io_output_valid = 1'b0;
            end
          endcase
        end
        7'b0100111 : begin
          casez(funct3)
            3'b010 : begin
            end
            3'b011 : begin
              io_output_valid = 1'b0;
            end
            default : begin
              io_output_valid = 1'b0;
            end
          endcase
        end
        7'b1010011 : begin
          if(when_Decoder_l544) begin
            io_output_valid = 1'b0;
          end
          case(funct6)
            6'h0 : begin
            end
            6'h02 : begin
            end
            6'h04 : begin
            end
            6'h06 : begin
            end
            6'h16 : begin
            end
            6'h08 : begin
              case(funct3)
                3'b000 : begin
                end
                3'b001 : begin
                end
                3'b010 : begin
                end
                default : begin
                  io_output_valid = 1'b0;
                end
              endcase
            end
            6'h0a : begin
              case(funct3)
                3'b000 : begin
                end
                3'b001 : begin
                end
                default : begin
                  io_output_valid = 1'b0;
                end
              endcase
            end
            6'h28 : begin
              case(funct3)
                3'b000 : begin
                end
                3'b001 : begin
                end
                3'b010 : begin
                end
                default : begin
                  io_output_valid = 1'b0;
                end
              endcase
            end
            6'h38 : begin
              case(funct3)
                3'b000 : begin
                end
                3'b001 : begin
                end
                default : begin
                  io_output_valid = 1'b0;
                end
              endcase
            end
            6'h3c : begin
              if(when_Decoder_l590) begin
                io_output_valid = 1'b0;
              end
            end
            6'h30 : begin
            end
            6'h34 : begin
            end
            6'h10 : begin
              io_output_valid = 1'b0;
            end
            default : begin
              io_output_valid = 1'b0;
            end
          endcase
        end
        7'b1000011 : begin
          if(when_Decoder_l644) begin
            io_output_valid = 1'b0;
          end
        end
        7'b1000111 : begin
          if(when_Decoder_l653) begin
            io_output_valid = 1'b0;
          end
        end
        7'b1001011 : begin
          if(when_Decoder_l662) begin
            io_output_valid = 1'b0;
          end
        end
        7'b1001111 : begin
          if(when_Decoder_l671) begin
            io_output_valid = 1'b0;
          end
        end
        7'b0101111 : begin
          io_output_valid = 1'b0;
        end
        7'b0010011 : begin
          casez(funct3)
            3'b000 : begin
            end
            3'b001 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            3'b100 : begin
            end
            3'b101 : begin
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            default : begin
              io_output_valid = 1'b0;
            end
          endcase
        end
        7'b0011011 : begin
          casez(funct3)
            3'b000 : begin
            end
            3'b001 : begin
            end
            3'b101 : begin
            end
            default : begin
              io_output_valid = 1'b0;
            end
          endcase
        end
        7'b0111011 : begin
          casez(funct7)
            7'b0000000 : begin
              casez(funct3)
                3'b000 : begin
                end
                3'b001 : begin
                end
                3'b101 : begin
                end
                default : begin
                  io_output_valid = 1'b0;
                end
              endcase
            end
            7'b0100000 : begin
              casez(funct3)
                3'b000 : begin
                end
                3'b101 : begin
                end
                default : begin
                  io_output_valid = 1'b0;
                end
              endcase
            end
            7'b0000001 : begin
              io_output_valid = 1'b0;
            end
            default : begin
              io_output_valid = 1'b0;
            end
          endcase
        end
        7'b0110011 : begin
          if(when_Decoder_l882) begin
            io_output_valid = 1'b0;
          end else begin
            casez(funct3)
              3'b000 : begin
              end
              3'b001 : begin
              end
              3'b010 : begin
              end
              3'b011 : begin
              end
              3'b100 : begin
              end
              3'b101 : begin
              end
              3'b110 : begin
              end
              3'b111 : begin
              end
              default : begin
                io_output_valid = 1'b0;
              end
            endcase
          end
        end
        7'b0001111 : begin
          casez(funct3)
            3'b000 : begin
            end
            3'b001 : begin
            end
            default : begin
              io_output_valid = 1'b0;
            end
          endcase
        end
        7'b1110011 : begin
          casez(funct3)
            3'b001 : begin
            end
            3'b010 : begin
            end
            3'b011 : begin
            end
            3'b101 : begin
            end
            3'b110 : begin
            end
            3'b111 : begin
            end
            3'b000 : begin
              casez(switch_Decoder_l1024)
                12'b000000000000 : begin
                end
                12'b000000000001 : begin
                end
                12'b001100000010 : begin
                end
                12'b000100000101 : begin
                end
                default : begin
                  io_output_valid = 1'b0;
                end
              endcase
            end
            default : begin
              io_output_valid = 1'b0;
            end
          endcase
        end
        default : begin
          io_output_valid = 1'b0;
        end
      endcase
    end
  end

  assign when_Decoder_l155 = (io_output_csrOp == CsrOp_WRITE);
  always @(*) begin
    if(when_Decoder_l155) begin
      csrWrite = (io_output_csrImm ? 1'b1 : (rs1Num != 5'h0));
    end else begin
      csrWrite = (rs1Num != 5'h0);
    end
  end

  assign isComp = 1'b0;
  assign cfunct3 = io_instruction[15 : 13];
  assign crd = io_instruction[11 : 7];
  assign crs2 = io_instruction[6 : 2];
  assign crdp = (5'h08 + _zz_crdp);
  assign crs1p = (5'h08 + _zz_crs1p);
  assign crs2p = (5'h08 + _zz_crs2p);
  assign c6 = {io_instruction[12],io_instruction[6 : 2]};
  assign c6S = c6;
  assign cShamt = _zz_cShamt;
  assign cAddi4spn = {io_instruction[10 : 7],{io_instruction[12 : 11],{io_instruction[5],{io_instruction[6],2'b00}}}};
  assign cLwImm = {io_instruction[5],{io_instruction[12 : 10],{io_instruction[6],2'b00}}};
  assign cLwspImm = {io_instruction[3 : 2],{io_instruction[12],{io_instruction[6 : 4],2'b00}}};
  assign cSwspImm = {io_instruction[8 : 7],{io_instruction[12 : 9],2'b00}};
  assign cJImm = {io_instruction[12],{io_instruction[8],{io_instruction[10],{io_instruction[9],{io_instruction[6],{io_instruction[7],{io_instruction[2],{_zz_cJImm,{_zz_cJImm_1,_zz_cJImm_2}}}}}}}}};
  assign cBImm = {io_instruction[12],{io_instruction[6],{io_instruction[5],{io_instruction[2],{io_instruction[11],{io_instruction[10],{io_instruction[4],{io_instruction[3],1'b0}}}}}}}};
  assign cAddi16sp = _zz_cAddi16sp;
  assign cLdImm = _zz_cLdImm;
  assign cLdspImm = _zz_cLdspImm;
  assign cSdspImm = _zz_cSdspImm;
  assign switch_Decoder_l192 = io_instruction[1 : 0];
  assign when_Decoder_l196 = (cAddi4spn == 10'h0);
  assign when_Decoder_l243 = (crd == 5'h0);
  assign when_Decoder_l259 = (crd == 5'h02);
  assign when_Decoder_l264 = ((crd == 5'h0) || (c6 == 6'h0));
  assign switch_Decoder_l274 = io_instruction[11 : 10];
  assign when_Decoder_l302 = io_instruction[12];
  assign switch_Decoder_l304 = io_instruction[6 : 5];
  assign _zz_io_output_aluOp = (io_instruction[5] ? AluOp_AND_1 : AluOp_OR_1);
  assign _zz_io_output_aluOp_1 = (io_instruction[5] ? AluOp_XOR_1 : AluOp_SUB);
  assign _zz_io_output_aluOp_2 = (io_instruction[6] ? _zz_io_output_aluOp : _zz_io_output_aluOp_1);
  assign when_Decoder_l356 = (crd == 5'h0);
  assign when_Decoder_l364 = (crd == 5'h0);
  assign when_Decoder_l374 = (io_instruction[12] == 1'b0);
  assign when_Decoder_l375 = (crs2 == 5'h0);
  assign when_Decoder_l376 = (crd == 5'h0);
  assign when_Decoder_l387 = (crs2 == 5'h0);
  assign when_Decoder_l388 = (crd == 5'h0);
  assign when_Decoder_l544 = io_instruction[25];
  assign when_Decoder_l590 = (funct3 != 3'b000);
  assign when_Decoder_l644 = io_instruction[25];
  assign when_Decoder_l653 = io_instruction[25];
  assign when_Decoder_l662 = io_instruction[25];
  assign when_Decoder_l671 = io_instruction[25];
  assign _zz_io_output_aluOp_3 = (io_instruction[30] ? AluOp_SRA_1 : AluOp_SRL_1);
  assign _zz_io_output_aluOp_4 = (io_instruction[30] ? AluOp_SRAW : AluOp_SRLW);
  assign when_Decoder_l882 = ((funct7 & 7'h7f) == 7'h01);
  assign _zz_io_output_aluOp_5 = (io_instruction[30] ? AluOp_SUB : AluOp_ADD);
  assign _zz_io_output_aluOp_6 = (io_instruction[30] ? AluOp_SRA_1 : AluOp_SRL_1);
  assign switch_Decoder_l1024 = io_instruction[31 : 20];

endmodule
