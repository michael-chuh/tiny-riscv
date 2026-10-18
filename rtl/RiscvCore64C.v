// Generator : SpinalHDL v1.14.2    git head : 78f29dc66110fc099a777992b6daa2f803ab445e
// Component : RiscvCore64C
// Git hash  : e2c9257a777aa49e3655581caf821735a72b832c

`timescale 1ns/1ps

module RiscvCore64C (
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
  localparam AluOp_PACK = 7'd60;
  localparam AluOp_PACKH = 7'd61;
  localparam AluOp_PACKW = 7'd62;
  localparam AluOp_BREV8 = 7'd63;
  localparam AluOp_ZIP = 7'd64;
  localparam AluOp_UNZIP = 7'd65;
  localparam AluOp_XPERM4 = 7'd66;
  localparam AluOp_XPERM8 = 7'd67;
  localparam AluOp_CLZW = 7'd68;
  localparam AluOp_CTZW = 7'd69;
  localparam AluOp_CPOPW = 7'd70;
  localparam AluOp_ROLW = 7'd71;
  localparam AluOp_RORW = 7'd72;
  localparam AluOp_SHA256SUM0 = 7'd73;
  localparam AluOp_SHA256SUM1 = 7'd74;
  localparam AluOp_SHA256SIG0 = 7'd75;
  localparam AluOp_SHA256SIG1 = 7'd76;
  localparam AluOp_SHA512SUM0 = 7'd77;
  localparam AluOp_SHA512SUM1 = 7'd78;
  localparam AluOp_SHA512SIG0 = 7'd79;
  localparam AluOp_SHA512SIG1 = 7'd80;
  localparam AluOp_SHA512SUM0R = 7'd81;
  localparam AluOp_SHA512SUM1R = 7'd82;
  localparam AluOp_SHA512SIG0L = 7'd83;
  localparam AluOp_SHA512SIG0H = 7'd84;
  localparam AluOp_SHA512SIG1L = 7'd85;
  localparam AluOp_SHA512SIG1H = 7'd86;
  localparam AluOp_SM3P0 = 7'd87;
  localparam AluOp_SM3P1 = 7'd88;
  localparam AluOp_SM4ED = 7'd89;
  localparam AluOp_SM4KS = 7'd90;
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
  wire                csrFile_1_io_csrWe;
  wire       [63:0]   csrFile_1_io_trapEpc;
  wire       [63:0]   csrFile_1_io_trapCause;
  wire       [63:0]   csrFile_1_io_trapTval;
  wire                divider_1_io_start;
  wire       [63:0]   divider_1_io_a;
  wire       [63:0]   divider_1_io_b;
  wire                divider_1_io_ack;
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
  wire       [1:0]    decoder_1_io_output_bs;
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
  wire                divider_1_io_busy;
  wire                divider_1_io_done;
  wire       [63:0]   divider_1_io_quotient;
  wire       [63:0]   divider_1_io_remainder;
  wire       [63:0]   _zz_io_iBus_pc_1;
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
  wire       [63:0]   _zz_io_a_2;
  wire       [31:0]   _zz_io_a_3;
  wire       [63:0]   _zz_io_a_4;
  wire       [63:0]   _zz_io_b_2;
  wire       [31:0]   _zz_io_b_3;
  wire       [63:0]   _zz_io_b_4;
  wire       [63:0]   _zz_exAluResult_1;
  wire       [31:0]   _zz_exAluResult_2;
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
  reg                 mis32;
  reg        [15:0]   hiReg;
  wire                mis32Start;
  wire                mis32Stall;
  reg        [31:0]   fetchInstr;
  reg        [2:0]    fetchLen;
  reg                 fetchCompressed;
  wire       [63:0]   _zz_io_iBus_pc;
  wire       [15:0]   _zz_fetchInstr;
  wire       [15:0]   _zz_hiReg;
  wire                when_RiscvCore_l295;
  wire                when_RiscvCore_l299;
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
  reg        [1:0]    idEx_bs;
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
  wire       [0:0]    fpRs1Data;
  wire       [0:0]    fpRs2Data;
  wire       [0:0]    fpRs3Data;
  wire       [63:0]   wbWriteData;
  reg        [63:0]   forwardRs1;
  wire                when_RiscvCore_l397;
  wire                when_RiscvCore_l399;
  reg        [63:0]   forwardRs2;
  wire                when_RiscvCore_l412;
  wire                when_RiscvCore_l414;
  wire       [0:0]    fpFwdRs1;
  wire       [0:0]    fpFwdRs2;
  wire       [0:0]    fpFwdRs3;
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
  wire                when_RiscvCore_l565;
  wire                when_RiscvCore_l569;
  wire                when_RiscvCore_l573;
  wire                when_RiscvCore_l582;
  wire                when_RiscvCore_l588;
  wire                when_RiscvCore_l591;
  wire                when_RiscvCore_l600;
  wire                when_RiscvCore_l605;
  wire                when_RiscvCore_l608;
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
  wire       [63:0]   _zz_io_a;
  wire       [63:0]   _zz_io_b;
  wire       [31:0]   _zz_io_a_1;
  wire       [31:0]   _zz_io_b_1;
  wire       [63:0]   _zz_exAluResult;
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
  wire                when_RiscvCore_l947;
  wire                when_RiscvCore_l954;
  wire                when_RiscvCore_l962;
  wire                when_RiscvCore_l963;
  wire                when_RiscvCore_l976;
  wire                when_RiscvCore_l977;
  wire                when_RiscvCore_l1024;
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
  wire       [0:0]    fpLoadData;
  wire                when_RiscvCore_l1135;
  `ifndef SYNTHESIS
  reg [87:0] idEx_aluOp_string;
  reg [31:0] idEx_branchType_string;
  reg [39:0] idEx_csrOp_string;
  reg [55:0] idEx_sysOp_string;
  reg [39:0] exMem_csrOp_string;
  reg [39:0] memWb_csrOp_string;
  `endif


  assign _zz_io_iBus_pc_1 = (_zz_io_iBus_pc + 64'h0000000000000004);
  assign _zz_aluResult = (idEx_pc + instrLenEx);
  assign _zz_csrWrDataEx = {59'd0, idEx_rs1};
  assign _zz_branchCond = forwardRs1;
  assign _zz_branchCond_1 = forwardRs2;
  assign _zz_branchCond_2 = forwardRs2;
  assign _zz_branchCond_3 = forwardRs1;
  assign _zz_ctrlTarget = (forwardRs1 + idEx_imm);
  assign _zz_exTrapCause = ((csrFile_1_io_curMode == MODE_U) ? 4'b1000 : ((csrFile_1_io_curMode == 2'b01) ? 4'b1001 : 4'b1011));
  assign _zz_exTrapTval = {52'd0, idEx_csrAddr};
  assign _zz_io_a_3 = _zz_io_a_1;
  assign _zz_io_a_2 = {{32{_zz_io_a_3[31]}}, _zz_io_a_3};
  assign _zz_io_a_4 = {32'd0, _zz_io_a_1};
  assign _zz_io_b_3 = _zz_io_b_1;
  assign _zz_io_b_2 = {{32{_zz_io_b_3[31]}}, _zz_io_b_3};
  assign _zz_io_b_4 = {32'd0, _zz_io_b_1};
  assign _zz_exAluResult_2 = _zz_exAluResult[31 : 0];
  assign _zz_exAluResult_1 = {{32{_zz_exAluResult_2[31]}}, _zz_exAluResult_2};
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
  assign _zz_csrImplemented = (idEx_csrAddr == 12'h300);
  assign _zz_csrImplemented_1 = (idEx_csrAddr == 12'h301);
  assign _zz_csrImplemented_2 = 12'h304;
  assign _zz_csrPrivIllegal = (((! (2'b11 <= csrFile_1_io_curMode)) || (! (2'b11 <= csrFile_1_io_curMode))) || (! (2'b11 <= csrFile_1_io_curMode)));
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
    .io_output_bs         (decoder_1_io_output_bs[1:0]        ), //o
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
    .io_fpDirty        (1'b0                          ), //i
    .io_fpFlagsWe      (1'b0                          ), //i
    .io_fpFlags        (5'h0                          ), //i
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
    .io_bs     (idEx_bs[1:0]         ), //i
    .io_result (alu_1_io_result[63:0])  //o
  );
  Divider divider_1 (
    .io_start     (divider_1_io_start          ), //i
    .io_a         (divider_1_io_a[63:0]        ), //i
    .io_b         (divider_1_io_b[63:0]        ), //i
    .io_signed    (divSigned                   ), //i
    .io_ack       (divider_1_io_ack            ), //i
    .io_busy      (divider_1_io_busy           ), //o
    .io_done      (divider_1_io_done           ), //o
    .io_quotient  (divider_1_io_quotient[63:0] ), //o
    .io_remainder (divider_1_io_remainder[63:0]), //o
    .clk          (clk                         ), //i
    .reset        (reset                       )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(idEx_aluOp)
      AluOp_ADD : idEx_aluOp_string = "ADD        ";
      AluOp_SUB : idEx_aluOp_string = "SUB        ";
      AluOp_SLL_1 : idEx_aluOp_string = "SLL_1      ";
      AluOp_SLT : idEx_aluOp_string = "SLT        ";
      AluOp_SLTU : idEx_aluOp_string = "SLTU       ";
      AluOp_XOR_1 : idEx_aluOp_string = "XOR_1      ";
      AluOp_SRL_1 : idEx_aluOp_string = "SRL_1      ";
      AluOp_SRA_1 : idEx_aluOp_string = "SRA_1      ";
      AluOp_OR_1 : idEx_aluOp_string = "OR_1       ";
      AluOp_AND_1 : idEx_aluOp_string = "AND_1      ";
      AluOp_ADDW : idEx_aluOp_string = "ADDW       ";
      AluOp_SUBW : idEx_aluOp_string = "SUBW       ";
      AluOp_SLLW : idEx_aluOp_string = "SLLW       ";
      AluOp_SRLW : idEx_aluOp_string = "SRLW       ";
      AluOp_SRAW : idEx_aluOp_string = "SRAW       ";
      AluOp_MUL : idEx_aluOp_string = "MUL        ";
      AluOp_MULH : idEx_aluOp_string = "MULH       ";
      AluOp_MULHSU : idEx_aluOp_string = "MULHSU     ";
      AluOp_MULHU : idEx_aluOp_string = "MULHU      ";
      AluOp_DIV : idEx_aluOp_string = "DIV        ";
      AluOp_DIVU : idEx_aluOp_string = "DIVU       ";
      AluOp_REM_1 : idEx_aluOp_string = "REM_1      ";
      AluOp_REMU : idEx_aluOp_string = "REMU       ";
      AluOp_MULW : idEx_aluOp_string = "MULW       ";
      AluOp_DIVW : idEx_aluOp_string = "DIVW       ";
      AluOp_DIVUW : idEx_aluOp_string = "DIVUW      ";
      AluOp_REMW : idEx_aluOp_string = "REMW       ";
      AluOp_REMUW : idEx_aluOp_string = "REMUW      ";
      AluOp_ANDN : idEx_aluOp_string = "ANDN       ";
      AluOp_ORN : idEx_aluOp_string = "ORN        ";
      AluOp_XNOR_1 : idEx_aluOp_string = "XNOR_1     ";
      AluOp_CLZ : idEx_aluOp_string = "CLZ        ";
      AluOp_CTZ : idEx_aluOp_string = "CTZ        ";
      AluOp_CPOP : idEx_aluOp_string = "CPOP       ";
      AluOp_SEXTB : idEx_aluOp_string = "SEXTB      ";
      AluOp_SEXTH : idEx_aluOp_string = "SEXTH      ";
      AluOp_ZEXTH : idEx_aluOp_string = "ZEXTH      ";
      AluOp_ORCB : idEx_aluOp_string = "ORCB       ";
      AluOp_REV8 : idEx_aluOp_string = "REV8       ";
      AluOp_ROL_1 : idEx_aluOp_string = "ROL_1      ";
      AluOp_ROR_1 : idEx_aluOp_string = "ROR_1      ";
      AluOp_MIN : idEx_aluOp_string = "MIN        ";
      AluOp_MINU : idEx_aluOp_string = "MINU       ";
      AluOp_MAX : idEx_aluOp_string = "MAX        ";
      AluOp_MAXU : idEx_aluOp_string = "MAXU       ";
      AluOp_BSET : idEx_aluOp_string = "BSET       ";
      AluOp_BCLR : idEx_aluOp_string = "BCLR       ";
      AluOp_BINV : idEx_aluOp_string = "BINV       ";
      AluOp_BEXT : idEx_aluOp_string = "BEXT       ";
      AluOp_SH1ADD : idEx_aluOp_string = "SH1ADD     ";
      AluOp_SH2ADD : idEx_aluOp_string = "SH2ADD     ";
      AluOp_SH3ADD : idEx_aluOp_string = "SH3ADD     ";
      AluOp_ADDUW : idEx_aluOp_string = "ADDUW      ";
      AluOp_SH1ADDUW : idEx_aluOp_string = "SH1ADDUW   ";
      AluOp_SH2ADDUW : idEx_aluOp_string = "SH2ADDUW   ";
      AluOp_SH3ADDUW : idEx_aluOp_string = "SH3ADDUW   ";
      AluOp_SLLIUW : idEx_aluOp_string = "SLLIUW     ";
      AluOp_CLMUL : idEx_aluOp_string = "CLMUL      ";
      AluOp_CLMULH : idEx_aluOp_string = "CLMULH     ";
      AluOp_CLMULR : idEx_aluOp_string = "CLMULR     ";
      AluOp_PACK : idEx_aluOp_string = "PACK       ";
      AluOp_PACKH : idEx_aluOp_string = "PACKH      ";
      AluOp_PACKW : idEx_aluOp_string = "PACKW      ";
      AluOp_BREV8 : idEx_aluOp_string = "BREV8      ";
      AluOp_ZIP : idEx_aluOp_string = "ZIP        ";
      AluOp_UNZIP : idEx_aluOp_string = "UNZIP      ";
      AluOp_XPERM4 : idEx_aluOp_string = "XPERM4     ";
      AluOp_XPERM8 : idEx_aluOp_string = "XPERM8     ";
      AluOp_CLZW : idEx_aluOp_string = "CLZW       ";
      AluOp_CTZW : idEx_aluOp_string = "CTZW       ";
      AluOp_CPOPW : idEx_aluOp_string = "CPOPW      ";
      AluOp_ROLW : idEx_aluOp_string = "ROLW       ";
      AluOp_RORW : idEx_aluOp_string = "RORW       ";
      AluOp_SHA256SUM0 : idEx_aluOp_string = "SHA256SUM0 ";
      AluOp_SHA256SUM1 : idEx_aluOp_string = "SHA256SUM1 ";
      AluOp_SHA256SIG0 : idEx_aluOp_string = "SHA256SIG0 ";
      AluOp_SHA256SIG1 : idEx_aluOp_string = "SHA256SIG1 ";
      AluOp_SHA512SUM0 : idEx_aluOp_string = "SHA512SUM0 ";
      AluOp_SHA512SUM1 : idEx_aluOp_string = "SHA512SUM1 ";
      AluOp_SHA512SIG0 : idEx_aluOp_string = "SHA512SIG0 ";
      AluOp_SHA512SIG1 : idEx_aluOp_string = "SHA512SIG1 ";
      AluOp_SHA512SUM0R : idEx_aluOp_string = "SHA512SUM0R";
      AluOp_SHA512SUM1R : idEx_aluOp_string = "SHA512SUM1R";
      AluOp_SHA512SIG0L : idEx_aluOp_string = "SHA512SIG0L";
      AluOp_SHA512SIG0H : idEx_aluOp_string = "SHA512SIG0H";
      AluOp_SHA512SIG1L : idEx_aluOp_string = "SHA512SIG1L";
      AluOp_SHA512SIG1H : idEx_aluOp_string = "SHA512SIG1H";
      AluOp_SM3P0 : idEx_aluOp_string = "SM3P0      ";
      AluOp_SM3P1 : idEx_aluOp_string = "SM3P1      ";
      AluOp_SM4ED : idEx_aluOp_string = "SM4ED      ";
      AluOp_SM4KS : idEx_aluOp_string = "SM4KS      ";
      default : idEx_aluOp_string = "???????????";
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
  assign io_iBus_valid = 1'b1;
  assign _zz_io_iBus_pc = {pcReg[63 : 2],2'b00};
  assign io_iBus_pc = (mis32 ? _zz_io_iBus_pc_1 : _zz_io_iBus_pc);
  assign _zz_fetchInstr = io_iBus_instruction[15 : 0];
  assign _zz_hiReg = io_iBus_instruction[31 : 16];
  assign mis32Start = (((! mis32) && pcReg[1]) && (_zz_hiReg[1 : 0] == 2'b11));
  assign mis32Stall = mis32Start;
  always @(*) begin
    if(mis32) begin
      fetchInstr = {io_iBus_instruction[15 : 0],hiReg};
    end else begin
      if(when_RiscvCore_l295) begin
        fetchInstr = {16'h0,_zz_hiReg};
      end else begin
        if(when_RiscvCore_l299) begin
          fetchInstr = io_iBus_instruction;
        end else begin
          fetchInstr = {16'h0,_zz_fetchInstr};
        end
      end
    end
  end

  always @(*) begin
    if(mis32) begin
      fetchLen = 3'b100;
    end else begin
      if(when_RiscvCore_l295) begin
        fetchLen = 3'b010;
      end else begin
        if(when_RiscvCore_l299) begin
          fetchLen = 3'b100;
        end else begin
          fetchLen = 3'b010;
        end
      end
    end
  end

  always @(*) begin
    if(mis32) begin
      fetchCompressed = 1'b0;
    end else begin
      if(when_RiscvCore_l295) begin
        fetchCompressed = 1'b1;
      end else begin
        if(when_RiscvCore_l299) begin
          fetchCompressed = 1'b0;
        end else begin
          fetchCompressed = 1'b1;
        end
      end
    end
  end

  assign when_RiscvCore_l295 = pcReg[1];
  assign when_RiscvCore_l299 = (_zz_fetchInstr[1 : 0] == 2'b11);
  assign fpRs1Data = 1'b0;
  assign fpRs2Data = 1'b0;
  assign fpRs3Data = 1'b0;
  assign wbWriteData = ((memWb_wbSel == 3'b011) ? csrFile_1_io_rdData : memWb_wbData);
  assign when_RiscvCore_l397 = ((((((exMem_valid && exMem_regWrite) && (exMem_rd != 5'h0)) && (! exMem_memRead)) && (! exMem_atomic)) && (exMem_wbSel != 3'b011)) && (exMem_rd == idEx_rs1));
  always @(*) begin
    if(when_RiscvCore_l397) begin
      forwardRs1 = exMem_aluResult;
    end else begin
      if(when_RiscvCore_l399) begin
        forwardRs1 = wbWriteData;
      end else begin
        forwardRs1 = regFile_io_rs1Data;
      end
    end
  end

  assign when_RiscvCore_l399 = (((memWb_valid && memWb_regWrite) && (memWb_rd != 5'h0)) && (memWb_rd == idEx_rs1));
  assign when_RiscvCore_l412 = ((((((exMem_valid && exMem_regWrite) && (exMem_rd != 5'h0)) && (! exMem_memRead)) && (! exMem_atomic)) && (exMem_wbSel != 3'b011)) && (exMem_rd == idEx_rs2));
  always @(*) begin
    if(when_RiscvCore_l412) begin
      forwardRs2 = exMem_aluResult;
    end else begin
      if(when_RiscvCore_l414) begin
        forwardRs2 = wbWriteData;
      end else begin
        forwardRs2 = regFile_io_rs2Data;
      end
    end
  end

  assign when_RiscvCore_l414 = (((memWb_valid && memWb_regWrite) && (memWb_rd != 5'h0)) && (memWb_rd == idEx_rs2));
  assign fpFwdRs1 = 1'b0;
  assign fpFwdRs2 = 1'b0;
  assign fpFwdRs3 = 1'b0;
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
  assign csrImplemented = (((((((((_zz_csrImplemented || _zz_csrImplemented_1) || (idEx_csrAddr == _zz_csrImplemented_2)) || (idEx_csrAddr == 12'h305)) || (idEx_csrAddr == 12'h340)) || (idEx_csrAddr == 12'h341)) || (idEx_csrAddr == 12'h342)) || (idEx_csrAddr == 12'h343)) || (idEx_csrAddr == 12'h344)) || (idEx_csrAddr == 12'hf14));
  assign csrReadOnly = (((idEx_csrAddr == 12'h301) || (idEx_csrAddr == 12'h344)) || (idEx_csrAddr == 12'hf14));
  assign csrRoWrite = (((isCsrInst && csrReadOnly) && (idEx_csrOp == CsrOp_WRITE)) && idEx_csrWe);
  assign csrUnimpl = (isCsrInst && (! csrImplemented));
  assign csrFsOff = 1'b0;
  assign csrPrivIllegal = (isCsrInst && (((((((_zz_csrPrivIllegal || _zz_csrPrivIllegal_1) || (! _zz_csrPrivIllegal_2)) || (! (_zz_csrPrivIllegal_3 <= csrFile_1_io_curMode))) || (! (2'b11 <= csrFile_1_io_curMode))) || (! (2'b11 <= csrFile_1_io_curMode))) || (! (2'b11 <= csrFile_1_io_curMode))) || (! (2'b11 <= csrFile_1_io_curMode))));
  assign mtvecModeBad = ((((isCsrInst && idEx_csrWe) && (idEx_csrAddr == 12'h305)) && ((idEx_csrOp == CsrOp_WRITE) || (idEx_csrOp == CsrOp_SET))) && (csrWrDataEx[1 : 0] != 2'b00));
  assign csrIllegal = (((((csrRoWrite || csrUnimpl) || csrPrivIllegal) || mtvecModeBad) || csrFsOff) && idEx_valid);
  always @(*) begin
    exTrapEna = 1'b0;
    if(idEx_valid) begin
      if(when_RiscvCore_l565) begin
        exTrapEna = 1'b1;
      end
      if(when_RiscvCore_l569) begin
        exTrapEna = 1'b1;
      end
      if(when_RiscvCore_l573) begin
        exTrapEna = 1'b1;
      end
      if(csrIllegal) begin
        exTrapEna = 1'b1;
      end
      if(when_RiscvCore_l582) begin
        exTrapEna = 1'b1;
      end
      if(when_RiscvCore_l588) begin
        if(when_RiscvCore_l591) begin
          exTrapEna = 1'b1;
        end
      end
      if(when_RiscvCore_l600) begin
        exTrapEna = 1'b1;
      end
      if(when_RiscvCore_l605) begin
        if(when_RiscvCore_l608) begin
          exTrapEna = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    exTrapCause = 64'h0;
    if(idEx_valid) begin
      if(when_RiscvCore_l565) begin
        exTrapCause = {60'd0, _zz_exTrapCause};
      end
      if(when_RiscvCore_l569) begin
        exTrapCause = 64'h0000000000000003;
      end
      if(when_RiscvCore_l573) begin
        exTrapCause = 64'h0000000000000002;
      end
      if(csrIllegal) begin
        exTrapCause = 64'h0000000000000002;
      end
      if(when_RiscvCore_l582) begin
        exTrapCause = 64'h0000000000000002;
      end
      if(when_RiscvCore_l588) begin
        if(when_RiscvCore_l591) begin
          exTrapCause = (idEx_isLr ? 64'h0000000000000004 : 64'h0000000000000006);
        end
      end
      if(when_RiscvCore_l600) begin
        exTrapCause = 64'h0000000000000002;
      end
      if(when_RiscvCore_l605) begin
        if(when_RiscvCore_l608) begin
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
      if(when_RiscvCore_l588) begin
        if(when_RiscvCore_l591) begin
          exTrapTval = aluResult;
        end
      end
      if(when_RiscvCore_l605) begin
        if(when_RiscvCore_l608) begin
          exTrapTval = aluResult;
        end
      end
    end
  end

  assign mppSupported = ((csrFile_1_io_mstatusMpp == 2'b00) || (csrFile_1_io_mstatusMpp == 2'b11));
  assign when_RiscvCore_l565 = (idEx_sysOp == SysOp_ECALL);
  assign when_RiscvCore_l569 = (idEx_sysOp == SysOp_EBREAK);
  assign when_RiscvCore_l573 = ((idEx_sysOp == SysOp_MRET) && ((csrFile_1_io_curMode != MODE_M) || (! mppSupported)));
  assign when_RiscvCore_l582 = (idEx_illegal || (idEx_sysOp == SysOp_ILLEGAL));
  assign when_RiscvCore_l588 = (idEx_atomic || idEx_isLr);
  assign when_RiscvCore_l591 = (! ((idEx_memSize == 2'b10) ? (aluResult[1 : 0] == 2'b00) : (aluResult[2 : 0] == 3'b000)));
  assign when_RiscvCore_l600 = (idEx_fp && (csrFile_1_io_mstatusFs == 2'b00));
  assign when_RiscvCore_l605 = (idEx_fpLoad || idEx_fpStore);
  assign when_RiscvCore_l608 = (! ((idEx_memSize == 2'b11) ? (aluResult[2 : 0] == 3'b000) : (aluResult[1 : 0] == 2'b00)));
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
  assign _zz_io_a = aluA;
  assign _zz_io_b = aluB;
  assign _zz_io_a_1 = _zz_io_a[31 : 0];
  assign _zz_io_b_1 = _zz_io_b[31 : 0];
  assign divider_1_io_a = (divIsW ? (divSigned ? _zz_io_a_2 : _zz_io_a_4) : _zz_io_a);
  assign divider_1_io_b = (divIsW ? (divSigned ? _zz_io_b_2 : _zz_io_b_4) : _zz_io_b);
  assign divider_1_io_start = (((divInEx && (! divider_1_io_busy)) && (! divider_1_io_done)) && (! (memStall || fetchStall)));
  assign divider_1_io_ack = ((divInEx && divider_1_io_done) && (! (memStall || fetchStall)));
  assign _zz_exAluResult = (divIsRem ? divider_1_io_remainder : divider_1_io_quotient);
  assign divStall = ((divInEx && (! divider_1_io_done)) && (! (memStall || fetchStall)));
  assign exAluResult = ((divInEx && divider_1_io_done) ? (divIsW ? _zz_exAluResult_1 : _zz_exAluResult) : aluResult);
  assign isFpCompute = (((idEx_valid && idEx_fp) && (! idEx_fpLoad)) && (! idEx_fpStore));
  assign isFpFromInt = (((((idEx_fpOp == 6'h14) || (idEx_fpOp == 6'h15)) || (idEx_fpOp == 6'h16)) || (idEx_fpOp == 6'h17)) || (idEx_fpOp == 6'h0f));
  assign isFpMvW = (idEx_fpOp == 6'h0f);
  assign isFpMvX = (idEx_fpOp == 6'h0e);
  assign fpRmEx = ((idEx_fpRm == 3'b111) ? csrFile_1_io_frm : idEx_fpRm);
  assign fpuResult = 64'h0;
  assign fpuFlags = 5'h0;
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
  assign flushYounger = (((ctrlFlush || trapCommit) || exMret) || intrTake);
  assign bubbleEx = ((trapCommit || exMret) || csrMretStall);
  assign when_RiscvCore_l947 = (! freezeAll);
  assign when_RiscvCore_l954 = (stallData || csrMretStall);
  assign when_RiscvCore_l962 = (! freezeAll);
  assign when_RiscvCore_l963 = (stallData || csrMretStall);
  assign when_RiscvCore_l976 = ((! freezeAll) && (! csrMretStall));
  assign when_RiscvCore_l977 = (stallData || flushYounger);
  assign when_RiscvCore_l1024 = (! freezeAll);
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
  assign fpLoadData = 1'b0;
  assign when_RiscvCore_l1135 = (! freezeAll);
  assign regFile_io_writeEnable = (memWb_valid && memWb_regWrite);
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
      mis32 <= 1'b0;
      hiReg <= 16'h0;
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
      idEx_bs <= 2'b00;
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
      if(mis32) begin
        mis32 <= 1'b0;
      end else begin
        if(mis32Start) begin
          mis32 <= 1'b1;
        end
      end
      if(mis32Start) begin
        hiReg <= _zz_hiReg;
      end
      if(when_RiscvCore_l947) begin
        if(trapCommit) begin
          pcReg <= trapEntry;
        end else begin
          if(exMret) begin
            pcReg <= csrFile_1_io_mepc;
          end else begin
            if(ctrlFlush) begin
              pcReg <= ctrlTarget;
            end else begin
              if(when_RiscvCore_l954) begin
                pcReg <= pcReg;
              end else begin
                pcReg <= (pcReg + _zz_pcReg);
              end
            end
          end
        end
      end
      if(when_RiscvCore_l962) begin
        if(!when_RiscvCore_l963) begin
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
      if(when_RiscvCore_l976) begin
        if(when_RiscvCore_l977) begin
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
        idEx_bs <= decoder_1_io_output_bs;
        idEx_illegal <= decoder_1_io_output_illegal;
        idEx_csrOp <= decoder_1_io_output_csrOp;
        idEx_csrImm <= decoder_1_io_output_csrImm;
        idEx_csrAddr <= decoder_1_io_output_csrAddr;
        idEx_csrWe <= decoder_1_io_output_csrWe;
        idEx_sysOp <= decoder_1_io_output_sysOp;
      end
      if(when_RiscvCore_l1024) begin
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
        exMem_fpRs2Data <= {63'd0, fpFwdRs2};
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
      if(when_RiscvCore_l1135) begin
        memWb_valid <= exMem_valid;
        memWb_regWrite <= exMem_regWrite;
        memWb_rd <= exMem_rd;
        memWb_wbSel <= exMem_wbSel;
        memWb_fp <= exMem_fp;
        memWb_fpWrite <= exMem_fpWrite;
        memWb_fpFlags <= exMem_fpFlags;
        if(exMem_fpLoad) begin
          memWb_wbData <= {63'd0, fpLoadData};
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

module Divider (
  input  wire          io_start,
  input  wire [63:0]   io_a,
  input  wire [63:0]   io_b,
  input  wire          io_signed,
  input  wire          io_ack,
  output wire          io_busy,
  output wire          io_done,
  output wire [63:0]   io_quotient,
  output wire [63:0]   io_remainder,
  input  wire          clk,
  input  wire          reset
);

  wire       [63:0]   _zz_nextQ;
  wire       [64:0]   _zz_nextQ_1;
  wire       [63:0]   _zz_nextQ_2;
  wire       [0:0]    _zz_nextQ_3;
  wire       [63:0]   _zz_aMagIn;
  wire       [63:0]   _zz_bMagIn;
  wire       [63:0]   _zz_qFinal;
  wire       [63:0]   _zz_rFinal;
  wire       [64:0]   _zz_dSh;
  reg        [63:0]   aMagReg;
  reg        [63:0]   bMagReg;
  reg        [63:0]   aRawReg;
  reg                 signA;
  reg                 signB;
  reg                 signedOp;
  reg                 bIsZero;
  reg        [63:0]   qOut;
  reg        [63:0]   rOut;
  reg        [1:0]    state;
  reg        [6:0]    cnt;
  reg        [64:0]   rRem;
  reg        [63:0]   qAcc;
  reg        [63:0]   dSh;
  wire       [64:0]   stepRem;
  wire       [64:0]   bExt;
  wire                ge;
  wire       [64:0]   subRem;
  wire       [64:0]   nextRem;
  wire       [63:0]   nextQ;
  wire                lastStep;
  wire                aNegIn;
  wire                bNegIn;
  wire       [63:0]   aMagIn;
  wire       [63:0]   bMagIn;
  wire                qNeg;
  wire       [63:0]   qFinal;
  wire       [63:0]   rMag;
  wire       [63:0]   rFinal;
  wire       [63:0]   allOnes;
  wire       [63:0]   qRes;
  wire       [63:0]   rRes;

  assign _zz_nextQ_1 = ({1'd0,qAcc} <<< 1'd1);
  assign _zz_nextQ = _zz_nextQ_1[63:0];
  assign _zz_nextQ_3 = (ge ? 1'b1 : 1'b0);
  assign _zz_nextQ_2 = {63'd0, _zz_nextQ_3};
  assign _zz_aMagIn = (64'h0 - io_a);
  assign _zz_bMagIn = (64'h0 - io_b);
  assign _zz_qFinal = (64'h0 - nextQ);
  assign _zz_rFinal = (64'h0 - rMag);
  assign _zz_dSh = ({1'd0,dSh} <<< 1'd1);
  assign stepRem = {rRem[63 : 0],dSh[63]};
  assign bExt = {1'd0, bMagReg};
  assign ge = (bExt <= stepRem);
  assign subRem = (stepRem - bExt);
  assign nextRem = (ge ? subRem : stepRem);
  assign nextQ = (_zz_nextQ | _zz_nextQ_2);
  assign lastStep = (cnt == 7'h3f);
  assign aNegIn = io_a[63];
  assign bNegIn = io_b[63];
  assign aMagIn = ((io_signed && aNegIn) ? _zz_aMagIn : io_a);
  assign bMagIn = ((io_signed && bNegIn) ? _zz_bMagIn : io_b);
  assign qNeg = (signA ^ signB);
  assign qFinal = ((qNeg && signedOp) ? _zz_qFinal : nextQ);
  assign rMag = nextRem[63 : 0];
  assign rFinal = ((signA && signedOp) ? _zz_rFinal : rMag);
  assign allOnes = 64'hffffffffffffffff;
  assign qRes = (bIsZero ? allOnes : qFinal);
  assign rRes = (bIsZero ? aRawReg : rFinal);
  assign io_busy = (state == 2'b01);
  assign io_done = (state == 2'b10);
  assign io_quotient = qOut;
  assign io_remainder = rOut;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      state <= 2'b00;
    end else begin
      case(state)
        2'b00 : begin
          if(io_start) begin
            state <= 2'b01;
          end
        end
        2'b01 : begin
          if(bIsZero) begin
            state <= 2'b10;
          end else begin
            if(lastStep) begin
              state <= 2'b10;
            end
          end
        end
        default : begin
          if(io_start) begin
            state <= 2'b01;
          end else begin
            if(io_ack) begin
              state <= 2'b00;
            end
          end
        end
      endcase
    end
  end

  always @(posedge clk) begin
    case(state)
      2'b00 : begin
        if(io_start) begin
          aMagReg <= aMagIn;
          bMagReg <= bMagIn;
          aRawReg <= io_a;
          signA <= aNegIn;
          signB <= bNegIn;
          signedOp <= io_signed;
          bIsZero <= (io_b == 64'h0);
          rRem <= 65'h0;
          qAcc <= 64'h0;
          dSh <= aMagIn;
          cnt <= 7'h0;
        end
      end
      2'b01 : begin
        if(bIsZero) begin
          qOut <= allOnes;
          rOut <= aRawReg;
        end else begin
          if(lastStep) begin
            qOut <= qRes;
            rOut <= rRes;
          end else begin
            rRem <= nextRem;
            qAcc <= nextQ;
            dSh <= _zz_dSh[63:0];
            cnt <= (cnt + 7'h01);
          end
        end
      end
      default : begin
        if(io_start) begin
          aMagReg <= aMagIn;
          bMagReg <= bMagIn;
          aRawReg <= io_a;
          signA <= aNegIn;
          signB <= bNegIn;
          signedOp <= io_signed;
          bIsZero <= (io_b == 64'h0);
          rRem <= 65'h0;
          qAcc <= 64'h0;
          dSh <= aMagIn;
          cnt <= 7'h0;
        end
      end
    endcase
  end


endmodule

module Alu (
  input  wire [63:0]   io_a,
  input  wire [63:0]   io_b,
  input  wire [6:0]    io_op,
  input  wire [1:0]    io_bs,
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
  localparam AluOp_PACK = 7'd60;
  localparam AluOp_PACKH = 7'd61;
  localparam AluOp_PACKW = 7'd62;
  localparam AluOp_BREV8 = 7'd63;
  localparam AluOp_ZIP = 7'd64;
  localparam AluOp_UNZIP = 7'd65;
  localparam AluOp_XPERM4 = 7'd66;
  localparam AluOp_XPERM8 = 7'd67;
  localparam AluOp_CLZW = 7'd68;
  localparam AluOp_CTZW = 7'd69;
  localparam AluOp_CPOPW = 7'd70;
  localparam AluOp_ROLW = 7'd71;
  localparam AluOp_RORW = 7'd72;
  localparam AluOp_SHA256SUM0 = 7'd73;
  localparam AluOp_SHA256SUM1 = 7'd74;
  localparam AluOp_SHA256SIG0 = 7'd75;
  localparam AluOp_SHA256SIG1 = 7'd76;
  localparam AluOp_SHA512SUM0 = 7'd77;
  localparam AluOp_SHA512SUM1 = 7'd78;
  localparam AluOp_SHA512SIG0 = 7'd79;
  localparam AluOp_SHA512SIG1 = 7'd80;
  localparam AluOp_SHA512SUM0R = 7'd81;
  localparam AluOp_SHA512SUM1R = 7'd82;
  localparam AluOp_SHA512SIG0L = 7'd83;
  localparam AluOp_SHA512SIG0H = 7'd84;
  localparam AluOp_SHA512SIG1L = 7'd85;
  localparam AluOp_SHA512SIG1H = 7'd86;
  localparam AluOp_SM3P0 = 7'd87;
  localparam AluOp_SM3P1 = 7'd88;
  localparam AluOp_SM4ED = 7'd89;
  localparam AluOp_SM4KS = 7'd90;

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
  wire       [63:0]   _zz_result_254;
  wire       [63:0]   _zz_result_255;
  wire       [63:0]   _zz_result_256;
  wire       [126:0]  _zz_result_257;
  wire       [63:0]   _zz_result_258;
  wire       [63:0]   _zz_result_259;
  wire       [63:0]   _zz_result_260;
  wire       [31:0]   _zz_result_261;
  wire       [63:0]   _zz_result_262;
  wire       [31:0]   _zz_result_263;
  wire       [63:0]   _zz_result_264;
  wire       [31:0]   _zz_result_265;
  wire       [31:0]   _zz_result_266;
  wire       [62:0]   _zz_result_267;
  wire       [63:0]   _zz_result_268;
  wire       [31:0]   _zz_result_269;
  wire       [31:0]   _zz_result_270;
  wire       [63:0]   _zz_result_271;
  wire       [31:0]   _zz_result_272;
  wire       [63:0]   _zz_result_273;
  wire       [31:0]   _zz_result_274;
  wire       [63:0]   _zz_result_275;
  wire       [63:0]   _zz_result_276;
  wire       [6:0]    _zz_result_277;
  wire                _zz_result_278;
  wire                _zz_result_279;
  wire       [6:0]    _zz_result_280;
  wire       [6:0]    _zz_result_281;
  wire                _zz_result_282;
  wire                _zz_result_283;
  wire       [6:0]    _zz_result_284;
  wire       [6:0]    _zz_result_285;
  wire                _zz_result_286;
  wire                _zz_result_287;
  wire       [6:0]    _zz_result_288;
  wire       [6:0]    _zz_result_289;
  wire                _zz_result_290;
  wire                _zz_result_291;
  wire       [6:0]    _zz_result_292;
  wire       [6:0]    _zz_result_293;
  wire                _zz_result_294;
  wire                _zz_result_295;
  wire       [6:0]    _zz_result_296;
  wire       [6:0]    _zz_result_297;
  wire                _zz_result_298;
  wire                _zz_result_299;
  wire       [6:0]    _zz_result_300;
  wire       [6:0]    _zz_result_301;
  wire                _zz_result_302;
  wire                _zz_result_303;
  wire       [6:0]    _zz_result_304;
  wire       [6:0]    _zz_result_305;
  wire                _zz_result_306;
  wire                _zz_result_307;
  wire       [6:0]    _zz_result_308;
  wire       [6:0]    _zz_result_309;
  wire                _zz_result_310;
  wire                _zz_result_311;
  wire       [6:0]    _zz_result_312;
  wire       [6:0]    _zz_result_313;
  wire       [63:0]   _zz_result_314;
  wire       [6:0]    _zz_result_315;
  wire                _zz_result_316;
  wire                _zz_result_317;
  wire       [6:0]    _zz_result_318;
  wire       [6:0]    _zz_result_319;
  wire                _zz_result_320;
  wire                _zz_result_321;
  wire       [6:0]    _zz_result_322;
  wire       [6:0]    _zz_result_323;
  wire                _zz_result_324;
  wire                _zz_result_325;
  wire       [6:0]    _zz_result_326;
  wire       [6:0]    _zz_result_327;
  wire                _zz_result_328;
  wire                _zz_result_329;
  wire       [6:0]    _zz_result_330;
  wire       [6:0]    _zz_result_331;
  wire                _zz_result_332;
  wire                _zz_result_333;
  wire       [6:0]    _zz_result_334;
  wire       [6:0]    _zz_result_335;
  wire                _zz_result_336;
  wire                _zz_result_337;
  wire       [6:0]    _zz_result_338;
  wire       [6:0]    _zz_result_339;
  wire                _zz_result_340;
  wire                _zz_result_341;
  wire       [6:0]    _zz_result_342;
  wire       [6:0]    _zz_result_343;
  wire                _zz_result_344;
  wire                _zz_result_345;
  wire       [6:0]    _zz_result_346;
  wire       [6:0]    _zz_result_347;
  wire                _zz_result_348;
  wire                _zz_result_349;
  wire       [6:0]    _zz_result_350;
  wire       [6:0]    _zz_result_351;
  wire       [63:0]   _zz_result_352;
  wire       [6:0]    _zz_result_353;
  wire       [7:0]    _zz_result_354;
  wire       [6:0]    _zz_result_355;
  wire       [7:0]    _zz_result_356;
  wire       [6:0]    _zz_result_357;
  wire       [7:0]    _zz_result_358;
  wire       [6:0]    _zz_result_359;
  wire       [7:0]    _zz_result_360;
  wire       [6:0]    _zz_result_361;
  wire       [7:0]    _zz_result_362;
  wire       [6:0]    _zz_result_363;
  wire       [7:0]    _zz_result_364;
  wire       [6:0]    _zz_result_365;
  wire       [7:0]    _zz_result_366;
  wire       [6:0]    _zz_result_367;
  wire       [7:0]    _zz_result_368;
  wire       [6:0]    _zz_result_369;
  wire       [7:0]    _zz_result_370;
  wire       [6:0]    _zz_result_371;
  wire       [7:0]    _zz_result_372;
  wire       [6:0]    _zz_result_373;
  wire       [7:0]    _zz_result_374;
  wire       [6:0]    _zz_result_375;
  wire       [7:0]    _zz_result_376;
  wire       [6:0]    _zz_result_377;
  wire       [7:0]    _zz_result_378;
  wire       [6:0]    _zz_result_379;
  wire       [7:0]    _zz_result_380;
  wire       [6:0]    _zz_result_381;
  wire       [7:0]    _zz_result_382;
  wire       [6:0]    _zz_result_383;
  wire       [7:0]    _zz_result_384;
  wire       [6:0]    _zz_result_385;
  wire       [7:0]    _zz_result_386;
  wire       [6:0]    _zz_result_387;
  wire       [7:0]    _zz_result_388;
  wire       [6:0]    _zz_result_389;
  wire       [7:0]    _zz_result_390;
  wire       [6:0]    _zz_result_391;
  wire       [7:0]    _zz_result_392;
  wire       [6:0]    _zz_result_393;
  wire       [7:0]    _zz_result_394;
  wire       [6:0]    _zz_result_395;
  wire       [7:0]    _zz_result_396;
  wire       [6:0]    _zz_result_397;
  wire       [7:0]    _zz_result_398;
  wire       [6:0]    _zz_result_399;
  wire       [7:0]    _zz_result_400;
  wire       [6:0]    _zz_result_401;
  wire       [7:0]    _zz_result_402;
  wire       [6:0]    _zz_result_403;
  wire       [7:0]    _zz_result_404;
  wire       [6:0]    _zz_result_405;
  wire       [7:0]    _zz_result_406;
  wire       [6:0]    _zz_result_407;
  wire       [7:0]    _zz_result_408;
  wire       [6:0]    _zz_result_409;
  wire       [7:0]    _zz_result_410;
  wire       [6:0]    _zz_result_411;
  wire       [7:0]    _zz_result_412;
  wire       [6:0]    _zz_result_413;
  wire       [7:0]    _zz_result_414;
  wire       [6:0]    _zz_result_415;
  wire       [7:0]    _zz_result_416;
  wire       [6:0]    _zz_result_417;
  wire       [7:0]    _zz_result_418;
  wire       [6:0]    _zz_result_419;
  wire       [7:0]    _zz_result_420;
  wire       [6:0]    _zz_result_421;
  wire       [7:0]    _zz_result_422;
  wire       [6:0]    _zz_result_423;
  wire       [7:0]    _zz_result_424;
  wire       [6:0]    _zz_result_425;
  wire       [7:0]    _zz_result_426;
  wire       [6:0]    _zz_result_427;
  wire       [7:0]    _zz_result_428;
  wire       [6:0]    _zz_result_429;
  wire       [7:0]    _zz_result_430;
  wire       [6:0]    _zz_result_431;
  wire       [7:0]    _zz_result_432;
  wire       [6:0]    _zz_result_433;
  wire       [7:0]    _zz_result_434;
  wire       [6:0]    _zz_result_435;
  wire       [7:0]    _zz_result_436;
  wire       [6:0]    _zz_result_437;
  wire       [7:0]    _zz_result_438;
  wire       [6:0]    _zz_result_439;
  wire       [7:0]    _zz_result_440;
  wire       [6:0]    _zz_result_441;
  wire       [7:0]    _zz_result_442;
  wire       [6:0]    _zz_result_443;
  wire       [7:0]    _zz_result_444;
  wire       [6:0]    _zz_result_445;
  wire       [7:0]    _zz_result_446;
  wire       [6:0]    _zz_result_447;
  wire       [7:0]    _zz_result_448;
  wire       [6:0]    _zz_result_449;
  wire       [7:0]    _zz_result_450;
  wire       [6:0]    _zz_result_451;
  wire       [7:0]    _zz_result_452;
  wire       [6:0]    _zz_result_453;
  wire       [7:0]    _zz_result_454;
  wire       [6:0]    _zz_result_455;
  wire       [7:0]    _zz_result_456;
  wire       [6:0]    _zz_result_457;
  wire       [7:0]    _zz_result_458;
  wire       [6:0]    _zz_result_459;
  wire       [7:0]    _zz_result_460;
  wire       [6:0]    _zz_result_461;
  wire       [7:0]    _zz_result_462;
  wire       [6:0]    _zz_result_463;
  wire       [7:0]    _zz_result_464;
  wire       [6:0]    _zz_result_465;
  wire       [7:0]    _zz_result_466;
  wire       [6:0]    _zz_result_467;
  wire       [7:0]    _zz_result_468;
  wire       [6:0]    _zz_result_469;
  wire       [7:0]    _zz_result_470;
  wire       [6:0]    _zz_result_471;
  wire       [7:0]    _zz_result_472;
  wire       [6:0]    _zz_result_473;
  wire       [7:0]    _zz_result_474;
  wire       [6:0]    _zz_result_475;
  wire       [7:0]    _zz_result_476;
  wire       [6:0]    _zz_result_477;
  wire       [7:0]    _zz_result_478;
  wire       [6:0]    _zz_result_479;
  wire       [7:0]    _zz_result_480;
  wire       [7:0]    _zz_result_481;
  wire       [1:0]    _zz_result_482;
  wire       [7:0]    _zz_result_483;
  wire       [1:0]    _zz_result_484;
  wire       [7:0]    _zz_result_485;
  wire       [1:0]    _zz_result_486;
  wire       [7:0]    _zz_result_487;
  wire       [1:0]    _zz_result_488;
  wire       [7:0]    _zz_result_489;
  wire       [1:0]    _zz_result_490;
  wire       [7:0]    _zz_result_491;
  wire       [1:0]    _zz_result_492;
  wire       [7:0]    _zz_result_493;
  wire       [1:0]    _zz_result_494;
  wire       [7:0]    _zz_result_495;
  wire       [1:0]    _zz_result_496;
  wire       [7:0]    _zz_result_497;
  wire       [1:0]    _zz_result_498;
  wire       [7:0]    _zz_result_499;
  wire       [1:0]    _zz_result_500;
  wire       [7:0]    _zz_result_501;
  wire       [1:0]    _zz_result_502;
  wire       [7:0]    _zz_result_503;
  wire       [1:0]    _zz_result_504;
  wire       [7:0]    _zz_result_505;
  wire       [1:0]    _zz_result_506;
  wire       [7:0]    _zz_result_507;
  wire       [1:0]    _zz_result_508;
  wire       [7:0]    _zz_result_509;
  wire       [1:0]    _zz_result_510;
  wire       [7:0]    _zz_result_511;
  wire       [1:0]    _zz_result_512;
  wire       [7:0]    _zz_result_513;
  wire       [1:0]    _zz_result_514;
  wire       [7:0]    _zz_result_515;
  wire       [1:0]    _zz_result_516;
  wire       [7:0]    _zz_result_517;
  wire       [1:0]    _zz_result_518;
  wire       [7:0]    _zz_result_519;
  wire       [1:0]    _zz_result_520;
  wire       [7:0]    _zz_result_521;
  wire       [1:0]    _zz_result_522;
  wire       [7:0]    _zz_result_523;
  wire       [1:0]    _zz_result_524;
  wire       [7:0]    _zz_result_525;
  wire       [1:0]    _zz_result_526;
  wire       [7:0]    _zz_result_527;
  wire       [1:0]    _zz_result_528;
  wire       [7:0]    _zz_result_529;
  wire       [1:0]    _zz_result_530;
  wire       [7:0]    _zz_result_531;
  wire       [1:0]    _zz_result_532;
  wire       [7:0]    _zz_result_533;
  wire       [1:0]    _zz_result_534;
  wire       [7:0]    _zz_result_535;
  wire       [1:0]    _zz_result_536;
  wire       [7:0]    _zz_result_537;
  wire       [1:0]    _zz_result_538;
  wire       [7:0]    _zz_result_539;
  wire       [1:0]    _zz_result_540;
  wire       [7:0]    _zz_result_541;
  wire       [1:0]    _zz_result_542;
  wire       [7:0]    _zz_result_543;
  wire       [1:0]    _zz_result_544;
  wire       [7:0]    _zz_result_545;
  wire       [1:0]    _zz_result_546;
  wire       [7:0]    _zz_result_547;
  wire       [1:0]    _zz_result_548;
  wire       [7:0]    _zz_result_549;
  wire       [1:0]    _zz_result_550;
  wire       [7:0]    _zz_result_551;
  wire       [1:0]    _zz_result_552;
  wire       [7:0]    _zz_result_553;
  wire       [1:0]    _zz_result_554;
  wire       [7:0]    _zz_result_555;
  wire       [1:0]    _zz_result_556;
  wire       [7:0]    _zz_result_557;
  wire       [1:0]    _zz_result_558;
  wire       [7:0]    _zz_result_559;
  wire       [1:0]    _zz_result_560;
  wire       [7:0]    _zz_result_561;
  wire       [1:0]    _zz_result_562;
  wire       [7:0]    _zz_result_563;
  wire       [1:0]    _zz_result_564;
  wire       [7:0]    _zz_result_565;
  wire       [1:0]    _zz_result_566;
  wire       [7:0]    _zz_result_567;
  wire       [1:0]    _zz_result_568;
  wire       [7:0]    _zz_result_569;
  wire       [1:0]    _zz_result_570;
  wire       [7:0]    _zz_result_571;
  wire       [1:0]    _zz_result_572;
  wire       [7:0]    _zz_result_573;
  wire       [1:0]    _zz_result_574;
  wire       [7:0]    _zz_result_575;
  wire       [1:0]    _zz_result_576;
  wire       [7:0]    _zz_result_577;
  wire       [1:0]    _zz_result_578;
  wire       [7:0]    _zz_result_579;
  wire       [1:0]    _zz_result_580;
  wire       [7:0]    _zz_result_581;
  wire       [1:0]    _zz_result_582;
  wire       [7:0]    _zz_result_583;
  wire       [1:0]    _zz_result_584;
  wire       [7:0]    _zz_result_585;
  wire       [1:0]    _zz_result_586;
  wire       [7:0]    _zz_result_587;
  wire       [1:0]    _zz_result_588;
  wire       [7:0]    _zz_result_589;
  wire       [1:0]    _zz_result_590;
  wire       [7:0]    _zz_result_591;
  wire       [1:0]    _zz_result_592;
  wire       [7:0]    _zz_result_593;
  wire       [1:0]    _zz_result_594;
  wire       [7:0]    _zz_result_595;
  wire       [1:0]    _zz_result_596;
  wire       [7:0]    _zz_result_597;
  wire       [1:0]    _zz_result_598;
  wire       [7:0]    _zz_result_599;
  wire       [1:0]    _zz_result_600;
  wire       [7:0]    _zz_result_601;
  wire       [1:0]    _zz_result_602;
  wire       [7:0]    _zz_result_603;
  wire       [1:0]    _zz_result_604;
  wire       [7:0]    _zz_result_605;
  wire       [1:0]    _zz_result_606;
  wire       [7:0]    _zz_result_607;
  wire       [1:0]    _zz_result_608;
  wire       [63:0]   _zz_result_609;
  wire       [7:0]    _zz_result_610;
  wire       [63:0]   _zz_result_611;
  wire       [15:0]   _zz_result_612;
  wire       [63:0]   _zz_result_613;
  wire       [15:0]   _zz_result_614;
  wire       [7:0]    _zz_result_615;
  wire                _zz_result_616;
  wire       [7:0]    _zz_result_617;
  wire       [7:0]    _zz_result_618;
  wire       [7:0]    _zz_result_619;
  wire       [15:0]   _zz_result_620;
  wire       [63:0]   _zz_result_621;
  wire       [126:0]  _zz_result_622;
  wire       [5:0]    _zz_result_623;
  wire       [63:0]   _zz_result_624;
  wire       [6:0]    _zz_result_625;
  wire       [63:0]   _zz_result_626;
  wire       [63:0]   _zz_result_627;
  wire       [190:0]  _zz_result_628;
  wire       [6:0]    _zz_result_629;
  wire       [63:0]   _zz_result_630;
  wire       [64:0]   _zz_result_631;
  wire       [64:0]   _zz_result_632;
  wire       [64:0]   _zz_result_633;
  wire       [63:0]   _zz_result_634;
  wire       [65:0]   _zz_result_635;
  wire       [65:0]   _zz_result_636;
  wire       [65:0]   _zz_result_637;
  wire       [63:0]   _zz_result_638;
  wire       [66:0]   _zz_result_639;
  wire       [66:0]   _zz_result_640;
  wire       [66:0]   _zz_result_641;
  wire       [63:0]   _zz_result_642;
  wire       [63:0]   _zz_result_643;
  wire       [64:0]   _zz_result_644;
  wire       [64:0]   _zz_result_645;
  wire       [64:0]   _zz_result_646;
  wire       [63:0]   _zz_result_647;
  wire       [65:0]   _zz_result_648;
  wire       [65:0]   _zz_result_649;
  wire       [65:0]   _zz_result_650;
  wire       [63:0]   _zz_result_651;
  wire       [66:0]   _zz_result_652;
  wire       [66:0]   _zz_result_653;
  wire       [66:0]   _zz_result_654;
  wire       [63:0]   _zz_result_655;
  wire       [126:0]  _zz_result_656;
  wire       [63:0]   _zz_result_657;
  wire       [63:0]   _zz_result_658;
  wire       [31:0]   _zz_result_659;
  wire       [63:0]   _zz_result_660;
  wire       [15:0]   _zz_result_661;
  wire       [63:0]   _zz_result_662;
  wire       [7:0]    _zz_result_663;
  wire       [63:0]   _zz_result_664;
  wire       [31:0]   _zz_result_665;
  wire       [31:0]   _zz_result_666;
  wire       [15:0]   _zz_result_667;
  wire       [31:0]   _zz_result_668;
  wire       [47:0]   _zz_result_669;
  wire       [31:0]   _zz_result_670;
  wire       [15:0]   _zz_result_671;
  wire       [3:0]    _zz__zz_result_131;
  wire                _zz__zz_result_131_1;
  wire       [3:0]    _zz__zz_result_131_2;
  wire       [3:0]    _zz__zz_result_131_3;
  wire       [3:0]    _zz__zz_result_131_4;
  wire                _zz__zz_result_131_5;
  wire       [3:0]    _zz__zz_result_131_6;
  wire       [3:0]    _zz__zz_result_131_7;
  wire       [3:0]    _zz__zz_result_131_8;
  wire                _zz__zz_result_131_9;
  wire       [3:0]    _zz__zz_result_131_10;
  wire       [3:0]    _zz__zz_result_131_11;
  wire       [3:0]    _zz__zz_result_131_12;
  wire                _zz__zz_result_131_13;
  wire       [3:0]    _zz__zz_result_131_14;
  wire       [3:0]    _zz__zz_result_131_15;
  wire       [3:0]    _zz__zz_result_131_16;
  wire                _zz__zz_result_131_17;
  wire       [3:0]    _zz__zz_result_131_18;
  wire       [3:0]    _zz__zz_result_131_19;
  wire       [3:0]    _zz__zz_result_131_20;
  wire                _zz__zz_result_131_21;
  wire       [3:0]    _zz__zz_result_131_22;
  wire       [3:0]    _zz__zz_result_131_23;
  wire       [3:0]    _zz__zz_result_131_24;
  wire                _zz__zz_result_131_25;
  wire       [3:0]    _zz__zz_result_131_26;
  wire       [3:0]    _zz__zz_result_131_27;
  wire       [3:0]    _zz__zz_result_131_28;
  wire                _zz__zz_result_131_29;
  wire       [3:0]    _zz__zz_result_131_30;
  wire       [3:0]    _zz__zz_result_131_31;
  wire       [3:0]    _zz__zz_result_131_32;
  wire                _zz__zz_result_131_33;
  wire       [3:0]    _zz__zz_result_131_34;
  wire       [3:0]    _zz__zz_result_131_35;
  wire       [3:0]    _zz__zz_result_131_36;
  wire                _zz__zz_result_131_37;
  wire       [3:0]    _zz__zz_result_131_38;
  wire       [3:0]    _zz__zz_result_131_39;
  wire       [3:0]    _zz__zz_result_131_40;
  wire                _zz__zz_result_131_41;
  wire       [3:0]    _zz__zz_result_131_42;
  wire       [3:0]    _zz__zz_result_131_43;
  wire       [3:0]    _zz__zz_result_131_44;
  wire                _zz__zz_result_131_45;
  wire       [3:0]    _zz__zz_result_131_46;
  wire       [3:0]    _zz__zz_result_131_47;
  wire       [3:0]    _zz__zz_result_131_48;
  wire                _zz__zz_result_131_49;
  wire       [3:0]    _zz__zz_result_131_50;
  wire       [3:0]    _zz__zz_result_131_51;
  wire       [3:0]    _zz__zz_result_131_52;
  wire                _zz__zz_result_131_53;
  wire       [3:0]    _zz__zz_result_131_54;
  wire       [3:0]    _zz__zz_result_131_55;
  wire       [3:0]    _zz__zz_result_131_56;
  wire                _zz__zz_result_131_57;
  wire       [3:0]    _zz__zz_result_131_58;
  wire       [3:0]    _zz__zz_result_131_59;
  wire       [3:0]    _zz__zz_result_131_60;
  wire                _zz__zz_result_131_61;
  wire       [3:0]    _zz__zz_result_131_62;
  wire       [3:0]    _zz__zz_result_131_63;
  wire       [3:0]    _zz__zz_result_131_64;
  wire                _zz__zz_result_131_65;
  wire       [3:0]    _zz__zz_result_131_66;
  wire       [3:0]    _zz__zz_result_131_67;
  wire       [3:0]    _zz__zz_result_131_68;
  wire                _zz__zz_result_131_69;
  wire       [3:0]    _zz__zz_result_131_70;
  wire       [3:0]    _zz__zz_result_131_71;
  wire       [3:0]    _zz__zz_result_131_72;
  wire                _zz__zz_result_131_73;
  wire       [3:0]    _zz__zz_result_131_74;
  wire       [3:0]    _zz__zz_result_131_75;
  wire       [3:0]    _zz__zz_result_131_76;
  wire                _zz__zz_result_131_77;
  wire       [3:0]    _zz__zz_result_131_78;
  wire       [3:0]    _zz__zz_result_131_79;
  wire       [3:0]    _zz__zz_result_131_80;
  wire                _zz__zz_result_131_81;
  wire       [3:0]    _zz__zz_result_131_82;
  wire       [3:0]    _zz__zz_result_131_83;
  wire       [3:0]    _zz__zz_result_131_84;
  wire                _zz__zz_result_131_85;
  wire       [3:0]    _zz__zz_result_131_86;
  wire       [3:0]    _zz__zz_result_131_87;
  wire       [3:0]    _zz__zz_result_131_88;
  wire                _zz__zz_result_131_89;
  wire       [3:0]    _zz__zz_result_131_90;
  wire       [3:0]    _zz__zz_result_131_91;
  wire       [3:0]    _zz__zz_result_131_92;
  wire                _zz__zz_result_131_93;
  wire       [3:0]    _zz__zz_result_131_94;
  wire       [3:0]    _zz__zz_result_131_95;
  wire       [3:0]    _zz__zz_result_131_96;
  wire                _zz__zz_result_131_97;
  wire       [3:0]    _zz__zz_result_131_98;
  wire       [3:0]    _zz__zz_result_131_99;
  wire       [3:0]    _zz__zz_result_131_100;
  wire                _zz__zz_result_131_101;
  wire       [3:0]    _zz__zz_result_131_102;
  wire       [3:0]    _zz__zz_result_131_103;
  wire       [3:0]    _zz__zz_result_131_104;
  wire                _zz__zz_result_131_105;
  wire       [3:0]    _zz__zz_result_131_106;
  wire       [3:0]    _zz__zz_result_131_107;
  wire       [3:0]    _zz__zz_result_131_108;
  wire                _zz__zz_result_131_109;
  wire       [3:0]    _zz__zz_result_131_110;
  wire       [3:0]    _zz__zz_result_131_111;
  wire       [3:0]    _zz__zz_result_131_112;
  wire                _zz__zz_result_131_113;
  wire       [3:0]    _zz__zz_result_131_114;
  wire       [3:0]    _zz__zz_result_131_115;
  wire       [3:0]    _zz__zz_result_131_116;
  wire                _zz__zz_result_131_117;
  wire       [3:0]    _zz__zz_result_131_118;
  wire       [3:0]    _zz__zz_result_131_119;
  wire       [3:0]    _zz__zz_result_131_120;
  wire                _zz__zz_result_131_121;
  wire       [3:0]    _zz__zz_result_131_122;
  wire       [3:0]    _zz__zz_result_131_123;
  wire       [3:0]    _zz__zz_result_131_124;
  wire                _zz__zz_result_131_125;
  wire       [3:0]    _zz__zz_result_131_126;
  wire       [3:0]    _zz__zz_result_131_127;
  wire       [7:0]    _zz__zz_result_148;
  wire                _zz__zz_result_148_1;
  wire       [7:0]    _zz__zz_result_148_2;
  wire       [7:0]    _zz__zz_result_148_3;
  wire       [7:0]    _zz__zz_result_148_4;
  wire                _zz__zz_result_148_5;
  wire       [7:0]    _zz__zz_result_148_6;
  wire       [7:0]    _zz__zz_result_148_7;
  wire       [7:0]    _zz__zz_result_148_8;
  wire                _zz__zz_result_148_9;
  wire       [7:0]    _zz__zz_result_148_10;
  wire       [7:0]    _zz__zz_result_148_11;
  wire       [7:0]    _zz__zz_result_148_12;
  wire                _zz__zz_result_148_13;
  wire       [7:0]    _zz__zz_result_148_14;
  wire       [7:0]    _zz__zz_result_148_15;
  wire       [7:0]    _zz__zz_result_148_16;
  wire                _zz__zz_result_148_17;
  wire       [7:0]    _zz__zz_result_148_18;
  wire       [7:0]    _zz__zz_result_148_19;
  wire       [7:0]    _zz__zz_result_148_20;
  wire                _zz__zz_result_148_21;
  wire       [7:0]    _zz__zz_result_148_22;
  wire       [7:0]    _zz__zz_result_148_23;
  wire       [7:0]    _zz__zz_result_148_24;
  wire                _zz__zz_result_148_25;
  wire       [7:0]    _zz__zz_result_148_26;
  wire       [7:0]    _zz__zz_result_148_27;
  wire       [7:0]    _zz__zz_result_148_28;
  wire                _zz__zz_result_148_29;
  wire       [7:0]    _zz__zz_result_148_30;
  wire       [7:0]    _zz__zz_result_148_31;
  wire       [63:0]   _zz_result_672;
  wire       [5:0]    _zz_result_673;
  wire                _zz_result_674;
  wire                _zz_result_675;
  wire       [5:0]    _zz_result_676;
  wire       [5:0]    _zz_result_677;
  wire                _zz_result_678;
  wire                _zz_result_679;
  wire       [5:0]    _zz_result_680;
  wire       [5:0]    _zz_result_681;
  wire                _zz_result_682;
  wire                _zz_result_683;
  wire       [5:0]    _zz_result_684;
  wire       [5:0]    _zz_result_685;
  wire                _zz_result_686;
  wire                _zz_result_687;
  wire       [5:0]    _zz_result_688;
  wire       [5:0]    _zz_result_689;
  wire       [63:0]   _zz_result_690;
  wire       [5:0]    _zz_result_691;
  wire                _zz_result_692;
  wire                _zz_result_693;
  wire       [5:0]    _zz_result_694;
  wire       [5:0]    _zz_result_695;
  wire                _zz_result_696;
  wire                _zz_result_697;
  wire       [5:0]    _zz_result_698;
  wire       [5:0]    _zz_result_699;
  wire                _zz_result_700;
  wire                _zz_result_701;
  wire       [5:0]    _zz_result_702;
  wire       [5:0]    _zz_result_703;
  wire                _zz_result_704;
  wire                _zz_result_705;
  wire       [5:0]    _zz_result_706;
  wire       [5:0]    _zz_result_707;
  wire       [63:0]   _zz_result_708;
  wire       [5:0]    _zz_result_709;
  wire       [6:0]    _zz_result_710;
  wire       [5:0]    _zz_result_711;
  wire       [6:0]    _zz_result_712;
  wire       [5:0]    _zz_result_713;
  wire       [6:0]    _zz_result_714;
  wire       [5:0]    _zz_result_715;
  wire       [6:0]    _zz_result_716;
  wire       [5:0]    _zz_result_717;
  wire       [6:0]    _zz_result_718;
  wire       [5:0]    _zz_result_719;
  wire       [6:0]    _zz_result_720;
  wire       [5:0]    _zz_result_721;
  wire       [6:0]    _zz_result_722;
  wire       [5:0]    _zz_result_723;
  wire       [6:0]    _zz_result_724;
  wire       [5:0]    _zz_result_725;
  wire       [6:0]    _zz_result_726;
  wire       [5:0]    _zz_result_727;
  wire       [6:0]    _zz_result_728;
  wire       [5:0]    _zz_result_729;
  wire       [6:0]    _zz_result_730;
  wire       [5:0]    _zz_result_731;
  wire       [6:0]    _zz_result_732;
  wire       [5:0]    _zz_result_733;
  wire       [6:0]    _zz_result_734;
  wire       [5:0]    _zz_result_735;
  wire       [6:0]    _zz_result_736;
  wire       [5:0]    _zz_result_737;
  wire       [6:0]    _zz_result_738;
  wire       [5:0]    _zz_result_739;
  wire       [6:0]    _zz_result_740;
  wire       [5:0]    _zz_result_741;
  wire       [6:0]    _zz_result_742;
  wire       [5:0]    _zz_result_743;
  wire       [6:0]    _zz_result_744;
  wire       [5:0]    _zz_result_745;
  wire       [6:0]    _zz_result_746;
  wire       [5:0]    _zz_result_747;
  wire       [6:0]    _zz_result_748;
  wire       [5:0]    _zz_result_749;
  wire       [6:0]    _zz_result_750;
  wire       [5:0]    _zz_result_751;
  wire       [6:0]    _zz_result_752;
  wire       [5:0]    _zz_result_753;
  wire       [6:0]    _zz_result_754;
  wire       [5:0]    _zz_result_755;
  wire       [6:0]    _zz_result_756;
  wire       [5:0]    _zz_result_757;
  wire       [6:0]    _zz_result_758;
  wire       [5:0]    _zz_result_759;
  wire       [6:0]    _zz_result_760;
  wire       [5:0]    _zz_result_761;
  wire       [6:0]    _zz_result_762;
  wire       [5:0]    _zz_result_763;
  wire       [6:0]    _zz_result_764;
  wire       [5:0]    _zz_result_765;
  wire       [6:0]    _zz_result_766;
  wire       [5:0]    _zz_result_767;
  wire       [6:0]    _zz_result_768;
  wire       [5:0]    _zz_result_769;
  wire       [6:0]    _zz_result_770;
  wire       [5:0]    _zz_result_771;
  wire       [6:0]    _zz_result_772;
  wire       [6:0]    _zz_result_773;
  wire       [1:0]    _zz_result_774;
  wire       [6:0]    _zz_result_775;
  wire       [1:0]    _zz_result_776;
  wire       [6:0]    _zz_result_777;
  wire       [1:0]    _zz_result_778;
  wire       [6:0]    _zz_result_779;
  wire       [1:0]    _zz_result_780;
  wire       [6:0]    _zz_result_781;
  wire       [1:0]    _zz_result_782;
  wire       [6:0]    _zz_result_783;
  wire       [1:0]    _zz_result_784;
  wire       [6:0]    _zz_result_785;
  wire       [1:0]    _zz_result_786;
  wire       [6:0]    _zz_result_787;
  wire       [1:0]    _zz_result_788;
  wire       [6:0]    _zz_result_789;
  wire       [1:0]    _zz_result_790;
  wire       [6:0]    _zz_result_791;
  wire       [1:0]    _zz_result_792;
  wire       [6:0]    _zz_result_793;
  wire       [1:0]    _zz_result_794;
  wire       [6:0]    _zz_result_795;
  wire       [1:0]    _zz_result_796;
  wire       [6:0]    _zz_result_797;
  wire       [1:0]    _zz_result_798;
  wire       [6:0]    _zz_result_799;
  wire       [1:0]    _zz_result_800;
  wire       [6:0]    _zz_result_801;
  wire       [1:0]    _zz_result_802;
  wire       [6:0]    _zz_result_803;
  wire       [1:0]    _zz_result_804;
  wire       [6:0]    _zz_result_805;
  wire       [1:0]    _zz_result_806;
  wire       [6:0]    _zz_result_807;
  wire       [1:0]    _zz_result_808;
  wire       [6:0]    _zz_result_809;
  wire       [1:0]    _zz_result_810;
  wire       [6:0]    _zz_result_811;
  wire       [1:0]    _zz_result_812;
  wire       [6:0]    _zz_result_813;
  wire       [1:0]    _zz_result_814;
  wire       [6:0]    _zz_result_815;
  wire       [1:0]    _zz_result_816;
  wire       [6:0]    _zz_result_817;
  wire       [1:0]    _zz_result_818;
  wire       [6:0]    _zz_result_819;
  wire       [1:0]    _zz_result_820;
  wire       [6:0]    _zz_result_821;
  wire       [1:0]    _zz_result_822;
  wire       [6:0]    _zz_result_823;
  wire       [1:0]    _zz_result_824;
  wire       [6:0]    _zz_result_825;
  wire       [1:0]    _zz_result_826;
  wire       [6:0]    _zz_result_827;
  wire       [1:0]    _zz_result_828;
  wire       [6:0]    _zz_result_829;
  wire       [1:0]    _zz_result_830;
  wire       [6:0]    _zz_result_831;
  wire       [1:0]    _zz_result_832;
  wire       [6:0]    _zz_result_833;
  wire       [1:0]    _zz_result_834;
  wire       [6:0]    _zz_result_835;
  wire       [1:0]    _zz_result_836;
  wire       [63:0]   _zz_result_837;
  wire       [31:0]   _zz_result_838;
  wire       [31:0]   _zz_result_839;
  wire       [62:0]   _zz_result_840;
  wire       [4:0]    _zz_result_841;
  wire       [31:0]   _zz_result_842;
  wire       [5:0]    _zz_result_843;
  wire       [63:0]   _zz_result_844;
  wire       [31:0]   _zz_result_845;
  wire       [31:0]   _zz_result_846;
  wire       [31:0]   _zz_result_847;
  wire       [94:0]   _zz_result_848;
  wire       [5:0]    _zz_result_849;
  wire       [63:0]   _zz_result_850;
  wire       [31:0]   _zz_result_851;
  wire       [31:0]   _zz_result_852;
  wire       [29:0]   _zz_result_853;
  wire       [31:0]   _zz_result_854;
  wire       [61:0]   _zz_result_855;
  wire       [31:0]   _zz_result_856;
  wire       [18:0]   _zz_result_857;
  wire       [31:0]   _zz_result_858;
  wire       [50:0]   _zz_result_859;
  wire       [31:0]   _zz_result_860;
  wire       [9:0]    _zz_result_861;
  wire       [31:0]   _zz_result_862;
  wire       [41:0]   _zz_result_863;
  wire       [63:0]   _zz_result_864;
  wire       [31:0]   _zz_result_865;
  wire       [31:0]   _zz_result_866;
  wire       [25:0]   _zz_result_867;
  wire       [31:0]   _zz_result_868;
  wire       [57:0]   _zz_result_869;
  wire       [31:0]   _zz_result_870;
  wire       [20:0]   _zz_result_871;
  wire       [31:0]   _zz_result_872;
  wire       [52:0]   _zz_result_873;
  wire       [31:0]   _zz_result_874;
  wire       [6:0]    _zz_result_875;
  wire       [31:0]   _zz_result_876;
  wire       [38:0]   _zz_result_877;
  wire       [63:0]   _zz_result_878;
  wire       [31:0]   _zz_result_879;
  wire       [31:0]   _zz_result_880;
  wire       [24:0]   _zz_result_881;
  wire       [31:0]   _zz_result_882;
  wire       [56:0]   _zz_result_883;
  wire       [31:0]   _zz_result_884;
  wire       [13:0]   _zz_result_885;
  wire       [31:0]   _zz_result_886;
  wire       [45:0]   _zz_result_887;
  wire       [31:0]   _zz_result_888;
  wire       [28:0]   _zz_result_889;
  wire       [63:0]   _zz_result_890;
  wire       [31:0]   _zz_result_891;
  wire       [31:0]   _zz_result_892;
  wire       [14:0]   _zz_result_893;
  wire       [31:0]   _zz_result_894;
  wire       [46:0]   _zz_result_895;
  wire       [31:0]   _zz_result_896;
  wire       [12:0]   _zz_result_897;
  wire       [31:0]   _zz_result_898;
  wire       [44:0]   _zz_result_899;
  wire       [31:0]   _zz_result_900;
  wire       [21:0]   _zz_result_901;
  wire       [63:0]   _zz_result_902;
  wire       [35:0]   _zz_result_903;
  wire       [63:0]   _zz_result_904;
  wire       [99:0]   _zz_result_905;
  wire       [63:0]   _zz_result_906;
  wire       [29:0]   _zz_result_907;
  wire       [63:0]   _zz_result_908;
  wire       [93:0]   _zz_result_909;
  wire       [63:0]   _zz_result_910;
  wire       [24:0]   _zz_result_911;
  wire       [63:0]   _zz_result_912;
  wire       [88:0]   _zz_result_913;
  wire       [63:0]   _zz_result_914;
  wire       [49:0]   _zz_result_915;
  wire       [63:0]   _zz_result_916;
  wire       [113:0]  _zz_result_917;
  wire       [63:0]   _zz_result_918;
  wire       [45:0]   _zz_result_919;
  wire       [63:0]   _zz_result_920;
  wire       [109:0]  _zz_result_921;
  wire       [63:0]   _zz_result_922;
  wire       [22:0]   _zz_result_923;
  wire       [63:0]   _zz_result_924;
  wire       [86:0]   _zz_result_925;
  wire       [63:0]   _zz_result_926;
  wire       [62:0]   _zz_result_927;
  wire       [63:0]   _zz_result_928;
  wire       [126:0]  _zz_result_929;
  wire       [63:0]   _zz_result_930;
  wire       [55:0]   _zz_result_931;
  wire       [63:0]   _zz_result_932;
  wire       [119:0]  _zz_result_933;
  wire       [63:0]   _zz_result_934;
  wire       [56:0]   _zz_result_935;
  wire       [63:0]   _zz_result_936;
  wire       [44:0]   _zz_result_937;
  wire       [63:0]   _zz_result_938;
  wire       [108:0]  _zz_result_939;
  wire       [63:0]   _zz_result_940;
  wire       [2:0]    _zz_result_941;
  wire       [63:0]   _zz_result_942;
  wire       [66:0]   _zz_result_943;
  wire       [63:0]   _zz_result_944;
  wire       [57:0]   _zz_result_945;
  wire       [63:0]   _zz_result_946;
  wire       [31:0]   _zz_result_947;
  wire       [31:0]   _zz_result_948;
  wire       [56:0]   _zz_result_949;
  wire       [31:0]   _zz_result_950;
  wire       [61:0]   _zz_result_951;
  wire       [31:0]   _zz_result_952;
  wire       [3:0]    _zz_result_953;
  wire       [31:0]   _zz_result_954;
  wire       [24:0]   _zz_result_955;
  wire       [31:0]   _zz_result_956;
  wire       [29:0]   _zz_result_957;
  wire       [31:0]   _zz_result_958;
  wire       [35:0]   _zz_result_959;
  wire       [63:0]   _zz_result_960;
  wire       [31:0]   _zz_result_961;
  wire       [31:0]   _zz_result_962;
  wire       [54:0]   _zz_result_963;
  wire       [31:0]   _zz_result_964;
  wire       [17:0]   _zz_result_965;
  wire       [31:0]   _zz_result_966;
  wire       [13:0]   _zz_result_967;
  wire       [31:0]   _zz_result_968;
  wire       [22:0]   _zz_result_969;
  wire       [31:0]   _zz_result_970;
  wire       [49:0]   _zz_result_971;
  wire       [31:0]   _zz_result_972;
  wire       [45:0]   _zz_result_973;
  wire       [63:0]   _zz_result_974;
  wire       [31:0]   _zz_result_975;
  wire       [31:0]   _zz_result_976;
  wire       [30:0]   _zz_result_977;
  wire       [31:0]   _zz_result_978;
  wire       [24:0]   _zz_result_979;
  wire       [31:0]   _zz_result_980;
  wire       [23:0]   _zz_result_981;
  wire       [31:0]   _zz_result_982;
  wire       [62:0]   _zz_result_983;
  wire       [31:0]   _zz_result_984;
  wire       [56:0]   _zz_result_985;
  wire       [31:0]   _zz_result_986;
  wire       [55:0]   _zz_result_987;
  wire       [63:0]   _zz_result_988;
  wire       [31:0]   _zz_result_989;
  wire       [31:0]   _zz_result_990;
  wire       [30:0]   _zz_result_991;
  wire       [31:0]   _zz_result_992;
  wire       [24:0]   _zz_result_993;
  wire       [31:0]   _zz_result_994;
  wire       [23:0]   _zz_result_995;
  wire       [31:0]   _zz_result_996;
  wire       [62:0]   _zz_result_997;
  wire       [31:0]   _zz_result_998;
  wire       [55:0]   _zz_result_999;
  wire       [63:0]   _zz_result_1000;
  wire       [31:0]   _zz_result_1001;
  wire       [31:0]   _zz_result_1002;
  wire       [34:0]   _zz_result_1003;
  wire       [31:0]   _zz_result_1004;
  wire       [25:0]   _zz_result_1005;
  wire       [31:0]   _zz_result_1006;
  wire       [12:0]   _zz_result_1007;
  wire       [31:0]   _zz_result_1008;
  wire       [2:0]    _zz_result_1009;
  wire       [31:0]   _zz_result_1010;
  wire       [57:0]   _zz_result_1011;
  wire       [31:0]   _zz_result_1012;
  wire       [44:0]   _zz_result_1013;
  wire       [63:0]   _zz_result_1014;
  wire       [31:0]   _zz_result_1015;
  wire       [31:0]   _zz_result_1016;
  wire       [34:0]   _zz_result_1017;
  wire       [31:0]   _zz_result_1018;
  wire       [25:0]   _zz_result_1019;
  wire       [31:0]   _zz_result_1020;
  wire       [12:0]   _zz_result_1021;
  wire       [31:0]   _zz_result_1022;
  wire       [2:0]    _zz_result_1023;
  wire       [31:0]   _zz_result_1024;
  wire       [44:0]   _zz_result_1025;
  wire       [63:0]   _zz_result_1026;
  wire       [31:0]   _zz_result_1027;
  wire       [31:0]   _zz_result_1028;
  wire       [40:0]   _zz_result_1029;
  wire       [31:0]   _zz_result_1030;
  wire       [8:0]    _zz_result_1031;
  wire       [31:0]   _zz_result_1032;
  wire       [48:0]   _zz_result_1033;
  wire       [31:0]   _zz_result_1034;
  wire       [16:0]   _zz_result_1035;
  wire       [63:0]   _zz_result_1036;
  wire       [31:0]   _zz_result_1037;
  wire       [31:0]   _zz_result_1038;
  wire       [46:0]   _zz_result_1039;
  wire       [31:0]   _zz_result_1040;
  wire       [14:0]   _zz_result_1041;
  wire       [31:0]   _zz_result_1042;
  wire       [54:0]   _zz_result_1043;
  wire       [31:0]   _zz_result_1044;
  wire       [22:0]   _zz_result_1045;
  reg        [7:0]    _zz__zz_result_247;
  wire       [7:0]    _zz__zz_result_247_1;
  wire       [31:0]   _zz__zz_result_247_2;
  wire       [31:0]   _zz__zz_result_247_3;
  wire       [31:0]   _zz__zz_result_248;
  wire       [39:0]   _zz__zz_result_248_1;
  wire       [31:0]   _zz__zz_result_248_2;
  wire       [33:0]   _zz__zz_result_248_3;
  wire       [31:0]   _zz__zz_result_248_4;
  wire       [49:0]   _zz__zz_result_248_5;
  wire       [31:0]   _zz__zz_result_248_6;
  wire       [57:0]   _zz__zz_result_248_7;
  wire       [31:0]   _zz__zz_result_248_8;
  wire       [41:0]   _zz__zz_result_248_9;
  wire       [63:0]   _zz_result_1046;
  wire       [31:0]   _zz_result_1047;
  wire       [31:0]   _zz_result_1048;
  wire       [62:0]   _zz_result_1049;
  wire       [4:0]    _zz_result_1050;
  wire       [31:0]   _zz_result_1051;
  wire       [5:0]    _zz_result_1052;
  wire       [31:0]   _zz_result_1053;
  reg        [7:0]    _zz__zz_result_251;
  wire       [7:0]    _zz__zz_result_251_1;
  wire       [31:0]   _zz__zz_result_251_2;
  wire       [31:0]   _zz__zz_result_251_3;
  wire       [31:0]   _zz__zz_result_252;
  wire       [60:0]   _zz__zz_result_252_1;
  wire       [31:0]   _zz__zz_result_252_2;
  wire       [38:0]   _zz__zz_result_252_3;
  wire       [31:0]   _zz__zz_result_252_4;
  wire       [54:0]   _zz__zz_result_252_5;
  wire       [31:0]   _zz__zz_result_252_6;
  wire       [44:0]   _zz__zz_result_252_7;
  wire       [63:0]   _zz_result_1054;
  wire       [31:0]   _zz_result_1055;
  wire       [31:0]   _zz_result_1056;
  wire       [62:0]   _zz_result_1057;
  wire       [4:0]    _zz_result_1058;
  wire       [31:0]   _zz_result_1059;
  wire       [5:0]    _zz_result_1060;
  wire       [31:0]   _zz_result_1061;
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
  wire       [7:0]    sm4SboxVec_0;
  wire       [7:0]    sm4SboxVec_1;
  wire       [7:0]    sm4SboxVec_2;
  wire       [7:0]    sm4SboxVec_3;
  wire       [7:0]    sm4SboxVec_4;
  wire       [7:0]    sm4SboxVec_5;
  wire       [7:0]    sm4SboxVec_6;
  wire       [7:0]    sm4SboxVec_7;
  wire       [7:0]    sm4SboxVec_8;
  wire       [7:0]    sm4SboxVec_9;
  wire       [7:0]    sm4SboxVec_10;
  wire       [7:0]    sm4SboxVec_11;
  wire       [7:0]    sm4SboxVec_12;
  wire       [7:0]    sm4SboxVec_13;
  wire       [7:0]    sm4SboxVec_14;
  wire       [7:0]    sm4SboxVec_15;
  wire       [7:0]    sm4SboxVec_16;
  wire       [7:0]    sm4SboxVec_17;
  wire       [7:0]    sm4SboxVec_18;
  wire       [7:0]    sm4SboxVec_19;
  wire       [7:0]    sm4SboxVec_20;
  wire       [7:0]    sm4SboxVec_21;
  wire       [7:0]    sm4SboxVec_22;
  wire       [7:0]    sm4SboxVec_23;
  wire       [7:0]    sm4SboxVec_24;
  wire       [7:0]    sm4SboxVec_25;
  wire       [7:0]    sm4SboxVec_26;
  wire       [7:0]    sm4SboxVec_27;
  wire       [7:0]    sm4SboxVec_28;
  wire       [7:0]    sm4SboxVec_29;
  wire       [7:0]    sm4SboxVec_30;
  wire       [7:0]    sm4SboxVec_31;
  wire       [7:0]    sm4SboxVec_32;
  wire       [7:0]    sm4SboxVec_33;
  wire       [7:0]    sm4SboxVec_34;
  wire       [7:0]    sm4SboxVec_35;
  wire       [7:0]    sm4SboxVec_36;
  wire       [7:0]    sm4SboxVec_37;
  wire       [7:0]    sm4SboxVec_38;
  wire       [7:0]    sm4SboxVec_39;
  wire       [7:0]    sm4SboxVec_40;
  wire       [7:0]    sm4SboxVec_41;
  wire       [7:0]    sm4SboxVec_42;
  wire       [7:0]    sm4SboxVec_43;
  wire       [7:0]    sm4SboxVec_44;
  wire       [7:0]    sm4SboxVec_45;
  wire       [7:0]    sm4SboxVec_46;
  wire       [7:0]    sm4SboxVec_47;
  wire       [7:0]    sm4SboxVec_48;
  wire       [7:0]    sm4SboxVec_49;
  wire       [7:0]    sm4SboxVec_50;
  wire       [7:0]    sm4SboxVec_51;
  wire       [7:0]    sm4SboxVec_52;
  wire       [7:0]    sm4SboxVec_53;
  wire       [7:0]    sm4SboxVec_54;
  wire       [7:0]    sm4SboxVec_55;
  wire       [7:0]    sm4SboxVec_56;
  wire       [7:0]    sm4SboxVec_57;
  wire       [7:0]    sm4SboxVec_58;
  wire       [7:0]    sm4SboxVec_59;
  wire       [7:0]    sm4SboxVec_60;
  wire       [7:0]    sm4SboxVec_61;
  wire       [7:0]    sm4SboxVec_62;
  wire       [7:0]    sm4SboxVec_63;
  wire       [7:0]    sm4SboxVec_64;
  wire       [7:0]    sm4SboxVec_65;
  wire       [7:0]    sm4SboxVec_66;
  wire       [7:0]    sm4SboxVec_67;
  wire       [7:0]    sm4SboxVec_68;
  wire       [7:0]    sm4SboxVec_69;
  wire       [7:0]    sm4SboxVec_70;
  wire       [7:0]    sm4SboxVec_71;
  wire       [7:0]    sm4SboxVec_72;
  wire       [7:0]    sm4SboxVec_73;
  wire       [7:0]    sm4SboxVec_74;
  wire       [7:0]    sm4SboxVec_75;
  wire       [7:0]    sm4SboxVec_76;
  wire       [7:0]    sm4SboxVec_77;
  wire       [7:0]    sm4SboxVec_78;
  wire       [7:0]    sm4SboxVec_79;
  wire       [7:0]    sm4SboxVec_80;
  wire       [7:0]    sm4SboxVec_81;
  wire       [7:0]    sm4SboxVec_82;
  wire       [7:0]    sm4SboxVec_83;
  wire       [7:0]    sm4SboxVec_84;
  wire       [7:0]    sm4SboxVec_85;
  wire       [7:0]    sm4SboxVec_86;
  wire       [7:0]    sm4SboxVec_87;
  wire       [7:0]    sm4SboxVec_88;
  wire       [7:0]    sm4SboxVec_89;
  wire       [7:0]    sm4SboxVec_90;
  wire       [7:0]    sm4SboxVec_91;
  wire       [7:0]    sm4SboxVec_92;
  wire       [7:0]    sm4SboxVec_93;
  wire       [7:0]    sm4SboxVec_94;
  wire       [7:0]    sm4SboxVec_95;
  wire       [7:0]    sm4SboxVec_96;
  wire       [7:0]    sm4SboxVec_97;
  wire       [7:0]    sm4SboxVec_98;
  wire       [7:0]    sm4SboxVec_99;
  wire       [7:0]    sm4SboxVec_100;
  wire       [7:0]    sm4SboxVec_101;
  wire       [7:0]    sm4SboxVec_102;
  wire       [7:0]    sm4SboxVec_103;
  wire       [7:0]    sm4SboxVec_104;
  wire       [7:0]    sm4SboxVec_105;
  wire       [7:0]    sm4SboxVec_106;
  wire       [7:0]    sm4SboxVec_107;
  wire       [7:0]    sm4SboxVec_108;
  wire       [7:0]    sm4SboxVec_109;
  wire       [7:0]    sm4SboxVec_110;
  wire       [7:0]    sm4SboxVec_111;
  wire       [7:0]    sm4SboxVec_112;
  wire       [7:0]    sm4SboxVec_113;
  wire       [7:0]    sm4SboxVec_114;
  wire       [7:0]    sm4SboxVec_115;
  wire       [7:0]    sm4SboxVec_116;
  wire       [7:0]    sm4SboxVec_117;
  wire       [7:0]    sm4SboxVec_118;
  wire       [7:0]    sm4SboxVec_119;
  wire       [7:0]    sm4SboxVec_120;
  wire       [7:0]    sm4SboxVec_121;
  wire       [7:0]    sm4SboxVec_122;
  wire       [7:0]    sm4SboxVec_123;
  wire       [7:0]    sm4SboxVec_124;
  wire       [7:0]    sm4SboxVec_125;
  wire       [7:0]    sm4SboxVec_126;
  wire       [7:0]    sm4SboxVec_127;
  wire       [7:0]    sm4SboxVec_128;
  wire       [7:0]    sm4SboxVec_129;
  wire       [7:0]    sm4SboxVec_130;
  wire       [7:0]    sm4SboxVec_131;
  wire       [7:0]    sm4SboxVec_132;
  wire       [7:0]    sm4SboxVec_133;
  wire       [7:0]    sm4SboxVec_134;
  wire       [7:0]    sm4SboxVec_135;
  wire       [7:0]    sm4SboxVec_136;
  wire       [7:0]    sm4SboxVec_137;
  wire       [7:0]    sm4SboxVec_138;
  wire       [7:0]    sm4SboxVec_139;
  wire       [7:0]    sm4SboxVec_140;
  wire       [7:0]    sm4SboxVec_141;
  wire       [7:0]    sm4SboxVec_142;
  wire       [7:0]    sm4SboxVec_143;
  wire       [7:0]    sm4SboxVec_144;
  wire       [7:0]    sm4SboxVec_145;
  wire       [7:0]    sm4SboxVec_146;
  wire       [7:0]    sm4SboxVec_147;
  wire       [7:0]    sm4SboxVec_148;
  wire       [7:0]    sm4SboxVec_149;
  wire       [7:0]    sm4SboxVec_150;
  wire       [7:0]    sm4SboxVec_151;
  wire       [7:0]    sm4SboxVec_152;
  wire       [7:0]    sm4SboxVec_153;
  wire       [7:0]    sm4SboxVec_154;
  wire       [7:0]    sm4SboxVec_155;
  wire       [7:0]    sm4SboxVec_156;
  wire       [7:0]    sm4SboxVec_157;
  wire       [7:0]    sm4SboxVec_158;
  wire       [7:0]    sm4SboxVec_159;
  wire       [7:0]    sm4SboxVec_160;
  wire       [7:0]    sm4SboxVec_161;
  wire       [7:0]    sm4SboxVec_162;
  wire       [7:0]    sm4SboxVec_163;
  wire       [7:0]    sm4SboxVec_164;
  wire       [7:0]    sm4SboxVec_165;
  wire       [7:0]    sm4SboxVec_166;
  wire       [7:0]    sm4SboxVec_167;
  wire       [7:0]    sm4SboxVec_168;
  wire       [7:0]    sm4SboxVec_169;
  wire       [7:0]    sm4SboxVec_170;
  wire       [7:0]    sm4SboxVec_171;
  wire       [7:0]    sm4SboxVec_172;
  wire       [7:0]    sm4SboxVec_173;
  wire       [7:0]    sm4SboxVec_174;
  wire       [7:0]    sm4SboxVec_175;
  wire       [7:0]    sm4SboxVec_176;
  wire       [7:0]    sm4SboxVec_177;
  wire       [7:0]    sm4SboxVec_178;
  wire       [7:0]    sm4SboxVec_179;
  wire       [7:0]    sm4SboxVec_180;
  wire       [7:0]    sm4SboxVec_181;
  wire       [7:0]    sm4SboxVec_182;
  wire       [7:0]    sm4SboxVec_183;
  wire       [7:0]    sm4SboxVec_184;
  wire       [7:0]    sm4SboxVec_185;
  wire       [7:0]    sm4SboxVec_186;
  wire       [7:0]    sm4SboxVec_187;
  wire       [7:0]    sm4SboxVec_188;
  wire       [7:0]    sm4SboxVec_189;
  wire       [7:0]    sm4SboxVec_190;
  wire       [7:0]    sm4SboxVec_191;
  wire       [7:0]    sm4SboxVec_192;
  wire       [7:0]    sm4SboxVec_193;
  wire       [7:0]    sm4SboxVec_194;
  wire       [7:0]    sm4SboxVec_195;
  wire       [7:0]    sm4SboxVec_196;
  wire       [7:0]    sm4SboxVec_197;
  wire       [7:0]    sm4SboxVec_198;
  wire       [7:0]    sm4SboxVec_199;
  wire       [7:0]    sm4SboxVec_200;
  wire       [7:0]    sm4SboxVec_201;
  wire       [7:0]    sm4SboxVec_202;
  wire       [7:0]    sm4SboxVec_203;
  wire       [7:0]    sm4SboxVec_204;
  wire       [7:0]    sm4SboxVec_205;
  wire       [7:0]    sm4SboxVec_206;
  wire       [7:0]    sm4SboxVec_207;
  wire       [7:0]    sm4SboxVec_208;
  wire       [7:0]    sm4SboxVec_209;
  wire       [7:0]    sm4SboxVec_210;
  wire       [7:0]    sm4SboxVec_211;
  wire       [7:0]    sm4SboxVec_212;
  wire       [7:0]    sm4SboxVec_213;
  wire       [7:0]    sm4SboxVec_214;
  wire       [7:0]    sm4SboxVec_215;
  wire       [7:0]    sm4SboxVec_216;
  wire       [7:0]    sm4SboxVec_217;
  wire       [7:0]    sm4SboxVec_218;
  wire       [7:0]    sm4SboxVec_219;
  wire       [7:0]    sm4SboxVec_220;
  wire       [7:0]    sm4SboxVec_221;
  wire       [7:0]    sm4SboxVec_222;
  wire       [7:0]    sm4SboxVec_223;
  wire       [7:0]    sm4SboxVec_224;
  wire       [7:0]    sm4SboxVec_225;
  wire       [7:0]    sm4SboxVec_226;
  wire       [7:0]    sm4SboxVec_227;
  wire       [7:0]    sm4SboxVec_228;
  wire       [7:0]    sm4SboxVec_229;
  wire       [7:0]    sm4SboxVec_230;
  wire       [7:0]    sm4SboxVec_231;
  wire       [7:0]    sm4SboxVec_232;
  wire       [7:0]    sm4SboxVec_233;
  wire       [7:0]    sm4SboxVec_234;
  wire       [7:0]    sm4SboxVec_235;
  wire       [7:0]    sm4SboxVec_236;
  wire       [7:0]    sm4SboxVec_237;
  wire       [7:0]    sm4SboxVec_238;
  wire       [7:0]    sm4SboxVec_239;
  wire       [7:0]    sm4SboxVec_240;
  wire       [7:0]    sm4SboxVec_241;
  wire       [7:0]    sm4SboxVec_242;
  wire       [7:0]    sm4SboxVec_243;
  wire       [7:0]    sm4SboxVec_244;
  wire       [7:0]    sm4SboxVec_245;
  wire       [7:0]    sm4SboxVec_246;
  wire       [7:0]    sm4SboxVec_247;
  wire       [7:0]    sm4SboxVec_248;
  wire       [7:0]    sm4SboxVec_249;
  wire       [7:0]    sm4SboxVec_250;
  wire       [7:0]    sm4SboxVec_251;
  wire       [7:0]    sm4SboxVec_252;
  wire       [7:0]    sm4SboxVec_253;
  wire       [7:0]    sm4SboxVec_254;
  wire       [7:0]    sm4SboxVec_255;
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
  reg        [63:0]   _zz_result_128;
  reg        [63:0]   _zz_result_129;
  reg        [63:0]   _zz_result_130;
  reg        [63:0]   _zz_result_131;
  wire       [3:0]    _zz_result_132;
  wire       [3:0]    _zz_result_133;
  wire       [3:0]    _zz_result_134;
  wire       [3:0]    _zz_result_135;
  wire       [3:0]    _zz_result_136;
  wire       [3:0]    _zz_result_137;
  wire       [3:0]    _zz_result_138;
  wire       [3:0]    _zz_result_139;
  wire       [3:0]    _zz_result_140;
  wire       [3:0]    _zz_result_141;
  wire       [3:0]    _zz_result_142;
  wire       [3:0]    _zz_result_143;
  wire       [3:0]    _zz_result_144;
  wire       [3:0]    _zz_result_145;
  wire       [3:0]    _zz_result_146;
  wire       [3:0]    _zz_result_147;
  reg        [63:0]   _zz_result_148;
  wire       [7:0]    _zz_result_149;
  wire       [7:0]    _zz_result_150;
  wire       [7:0]    _zz_result_151;
  wire       [7:0]    _zz_result_152;
  wire       [7:0]    _zz_result_153;
  wire       [7:0]    _zz_result_154;
  wire       [7:0]    _zz_result_155;
  wire       [7:0]    _zz_result_156;
  wire       [31:0]   _zz_result_157;
  wire                _zz_result_158;
  wire                _zz_result_159;
  wire                _zz_result_160;
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
  wire       [31:0]   _zz_result_189;
  wire                _zz_result_190;
  wire                _zz_result_191;
  wire                _zz_result_192;
  wire                _zz_result_193;
  wire                _zz_result_194;
  wire                _zz_result_195;
  wire                _zz_result_196;
  wire                _zz_result_197;
  wire                _zz_result_198;
  wire                _zz_result_199;
  wire                _zz_result_200;
  wire                _zz_result_201;
  wire                _zz_result_202;
  wire                _zz_result_203;
  wire                _zz_result_204;
  wire                _zz_result_205;
  wire                _zz_result_206;
  wire                _zz_result_207;
  wire                _zz_result_208;
  wire                _zz_result_209;
  wire                _zz_result_210;
  wire                _zz_result_211;
  wire                _zz_result_212;
  wire                _zz_result_213;
  wire                _zz_result_214;
  wire                _zz_result_215;
  wire                _zz_result_216;
  wire                _zz_result_217;
  wire                _zz_result_218;
  wire                _zz_result_219;
  wire                _zz_result_220;
  wire       [31:0]   _zz_result_221;
  wire       [5:0]    _zz_result_222;
  wire       [5:0]    _zz_result_223;
  wire       [31:0]   _zz_result_224;
  wire       [31:0]   _zz_result_225;
  wire       [31:0]   _zz_result_226;
  wire       [31:0]   _zz_result_227;
  wire       [63:0]   _zz_result_228;
  wire       [63:0]   _zz_result_229;
  wire       [63:0]   _zz_result_230;
  wire       [63:0]   _zz_result_231;
  wire       [31:0]   _zz_result_232;
  wire       [31:0]   _zz_result_233;
  wire       [31:0]   _zz_result_234;
  wire       [31:0]   _zz_result_235;
  wire       [31:0]   _zz_result_236;
  wire       [31:0]   _zz_result_237;
  wire       [31:0]   _zz_result_238;
  wire       [31:0]   _zz_result_239;
  wire       [31:0]   _zz_result_240;
  wire       [31:0]   _zz_result_241;
  wire       [31:0]   _zz_result_242;
  wire       [31:0]   _zz_result_243;
  wire       [31:0]   _zz_result_244;
  wire       [31:0]   _zz_result_245;
  wire       [4:0]    _zz_result_246;
  wire       [31:0]   _zz_result_247;
  wire       [31:0]   _zz_result_248;
  wire       [5:0]    _zz_result_249;
  wire       [4:0]    _zz_result_250;
  wire       [31:0]   _zz_result_251;
  wire       [31:0]   _zz_result_252;
  wire       [5:0]    _zz_result_253;
  `ifndef SYNTHESIS
  reg [87:0] io_op_string;
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
  assign _zz_result_254 = (aU + bU);
  assign _zz_result_255 = (aU - bU);
  assign _zz_result_257 = ({63'd0,aU} <<< shamt);
  assign _zz_result_256 = _zz_result_257[63:0];
  assign _zz_result_258 = (aU >>> shamt);
  assign _zz_result_259 = ($signed(aS) >>> shamt);
  assign _zz_result_261 = ($signed(aW) + $signed(bW));
  assign _zz_result_260 = {{32{_zz_result_261[31]}}, _zz_result_261};
  assign _zz_result_263 = ($signed(aW) - $signed(bW));
  assign _zz_result_262 = {{32{_zz_result_263[31]}}, _zz_result_263};
  assign _zz_result_265 = _zz_result_266;
  assign _zz_result_264 = {{32{_zz_result_265[31]}}, _zz_result_265};
  assign _zz_result_267 = ({31'd0,aWU} <<< shamtW);
  assign _zz_result_266 = _zz_result_267[31:0];
  assign _zz_result_269 = _zz_result_270;
  assign _zz_result_268 = {{32{_zz_result_269[31]}}, _zz_result_269};
  assign _zz_result_270 = (aWU >>> shamtW);
  assign _zz_result_272 = ($signed(aW) >>> shamtW);
  assign _zz_result_271 = {{32{_zz_result_272[31]}}, _zz_result_272};
  assign _zz_result_274 = _zz_result_275[31:0];
  assign _zz_result_273 = {{32{_zz_result_274[31]}}, _zz_result_274};
  assign _zz_result_275 = ($signed(aW) * $signed(bW));
  assign _zz_result_277 = (((_zz_result_62 && (! io_a[1])) && io_a[0]) ? 7'h3f : ((_zz_result_62 && io_a[1]) ? 7'h3e : ((_zz_result_61 && io_a[2]) ? 7'h3d : ((_zz_result_60 && io_a[3]) ? 7'h3c : ((_zz_result_59 && _zz_result_278) ? 7'h3b : (_zz_result_279 ? _zz_result_280 : _zz_result_281))))));
  assign _zz_result_276 = {57'd0, _zz_result_277};
  assign _zz_result_315 = (((_zz_result_125 && (! io_a[62])) && io_a[63]) ? 7'h3f : ((_zz_result_125 && io_a[62]) ? 7'h3e : ((_zz_result_124 && io_a[61]) ? 7'h3d : ((_zz_result_123 && io_a[60]) ? 7'h3c : ((_zz_result_122 && _zz_result_316) ? 7'h3b : (_zz_result_317 ? _zz_result_318 : _zz_result_319))))));
  assign _zz_result_314 = {57'd0, _zz_result_315};
  assign _zz_result_353 = _zz_result_354[6:0];
  assign _zz_result_352 = {57'd0, _zz_result_353};
  assign _zz_result_354 = ({1'b0,_zz_result_355} + _zz_result_607);
  assign _zz_result_356 = ({1'b0,_zz_result_357} + _zz_result_605);
  assign _zz_result_355 = _zz_result_356[6:0];
  assign _zz_result_358 = ({1'b0,_zz_result_359} + _zz_result_603);
  assign _zz_result_357 = _zz_result_358[6:0];
  assign _zz_result_360 = ({1'b0,_zz_result_361} + _zz_result_601);
  assign _zz_result_359 = _zz_result_360[6:0];
  assign _zz_result_362 = ({1'b0,_zz_result_363} + _zz_result_599);
  assign _zz_result_361 = _zz_result_362[6:0];
  assign _zz_result_364 = ({1'b0,_zz_result_365} + _zz_result_597);
  assign _zz_result_363 = _zz_result_364[6:0];
  assign _zz_result_366 = ({1'b0,_zz_result_367} + _zz_result_595);
  assign _zz_result_365 = _zz_result_366[6:0];
  assign _zz_result_368 = ({1'b0,_zz_result_369} + _zz_result_593);
  assign _zz_result_367 = _zz_result_368[6:0];
  assign _zz_result_370 = ({1'b0,_zz_result_371} + _zz_result_591);
  assign _zz_result_369 = _zz_result_370[6:0];
  assign _zz_result_372 = ({1'b0,_zz_result_373} + _zz_result_589);
  assign _zz_result_371 = _zz_result_372[6:0];
  assign _zz_result_374 = ({1'b0,_zz_result_375} + _zz_result_587);
  assign _zz_result_373 = _zz_result_374[6:0];
  assign _zz_result_376 = ({1'b0,_zz_result_377} + _zz_result_585);
  assign _zz_result_375 = _zz_result_376[6:0];
  assign _zz_result_378 = ({1'b0,_zz_result_379} + _zz_result_583);
  assign _zz_result_377 = _zz_result_378[6:0];
  assign _zz_result_380 = ({1'b0,_zz_result_381} + _zz_result_581);
  assign _zz_result_379 = _zz_result_380[6:0];
  assign _zz_result_382 = ({1'b0,_zz_result_383} + _zz_result_579);
  assign _zz_result_381 = _zz_result_382[6:0];
  assign _zz_result_384 = ({1'b0,_zz_result_385} + _zz_result_577);
  assign _zz_result_383 = _zz_result_384[6:0];
  assign _zz_result_386 = ({1'b0,_zz_result_387} + _zz_result_575);
  assign _zz_result_385 = _zz_result_386[6:0];
  assign _zz_result_388 = ({1'b0,_zz_result_389} + _zz_result_573);
  assign _zz_result_387 = _zz_result_388[6:0];
  assign _zz_result_390 = ({1'b0,_zz_result_391} + _zz_result_571);
  assign _zz_result_389 = _zz_result_390[6:0];
  assign _zz_result_392 = ({1'b0,_zz_result_393} + _zz_result_569);
  assign _zz_result_391 = _zz_result_392[6:0];
  assign _zz_result_394 = ({1'b0,_zz_result_395} + _zz_result_567);
  assign _zz_result_393 = _zz_result_394[6:0];
  assign _zz_result_396 = ({1'b0,_zz_result_397} + _zz_result_565);
  assign _zz_result_395 = _zz_result_396[6:0];
  assign _zz_result_398 = ({1'b0,_zz_result_399} + _zz_result_563);
  assign _zz_result_397 = _zz_result_398[6:0];
  assign _zz_result_400 = ({1'b0,_zz_result_401} + _zz_result_561);
  assign _zz_result_399 = _zz_result_400[6:0];
  assign _zz_result_402 = ({1'b0,_zz_result_403} + _zz_result_559);
  assign _zz_result_401 = _zz_result_402[6:0];
  assign _zz_result_404 = ({1'b0,_zz_result_405} + _zz_result_557);
  assign _zz_result_403 = _zz_result_404[6:0];
  assign _zz_result_406 = ({1'b0,_zz_result_407} + _zz_result_555);
  assign _zz_result_405 = _zz_result_406[6:0];
  assign _zz_result_408 = ({1'b0,_zz_result_409} + _zz_result_553);
  assign _zz_result_407 = _zz_result_408[6:0];
  assign _zz_result_410 = ({1'b0,_zz_result_411} + _zz_result_551);
  assign _zz_result_409 = _zz_result_410[6:0];
  assign _zz_result_412 = ({1'b0,_zz_result_413} + _zz_result_549);
  assign _zz_result_411 = _zz_result_412[6:0];
  assign _zz_result_414 = ({1'b0,_zz_result_415} + _zz_result_547);
  assign _zz_result_413 = _zz_result_414[6:0];
  assign _zz_result_416 = ({1'b0,_zz_result_417} + _zz_result_545);
  assign _zz_result_415 = _zz_result_416[6:0];
  assign _zz_result_418 = ({1'b0,_zz_result_419} + _zz_result_543);
  assign _zz_result_417 = _zz_result_418[6:0];
  assign _zz_result_420 = ({1'b0,_zz_result_421} + _zz_result_541);
  assign _zz_result_419 = _zz_result_420[6:0];
  assign _zz_result_422 = ({1'b0,_zz_result_423} + _zz_result_539);
  assign _zz_result_421 = _zz_result_422[6:0];
  assign _zz_result_424 = ({1'b0,_zz_result_425} + _zz_result_537);
  assign _zz_result_423 = _zz_result_424[6:0];
  assign _zz_result_426 = ({1'b0,_zz_result_427} + _zz_result_535);
  assign _zz_result_425 = _zz_result_426[6:0];
  assign _zz_result_428 = ({1'b0,_zz_result_429} + _zz_result_533);
  assign _zz_result_427 = _zz_result_428[6:0];
  assign _zz_result_430 = ({1'b0,_zz_result_431} + _zz_result_531);
  assign _zz_result_429 = _zz_result_430[6:0];
  assign _zz_result_432 = ({1'b0,_zz_result_433} + _zz_result_529);
  assign _zz_result_431 = _zz_result_432[6:0];
  assign _zz_result_434 = ({1'b0,_zz_result_435} + _zz_result_527);
  assign _zz_result_433 = _zz_result_434[6:0];
  assign _zz_result_436 = ({1'b0,_zz_result_437} + _zz_result_525);
  assign _zz_result_435 = _zz_result_436[6:0];
  assign _zz_result_438 = ({1'b0,_zz_result_439} + _zz_result_523);
  assign _zz_result_437 = _zz_result_438[6:0];
  assign _zz_result_440 = ({1'b0,_zz_result_441} + _zz_result_521);
  assign _zz_result_439 = _zz_result_440[6:0];
  assign _zz_result_442 = ({1'b0,_zz_result_443} + _zz_result_519);
  assign _zz_result_441 = _zz_result_442[6:0];
  assign _zz_result_444 = ({1'b0,_zz_result_445} + _zz_result_517);
  assign _zz_result_443 = _zz_result_444[6:0];
  assign _zz_result_446 = ({1'b0,_zz_result_447} + _zz_result_515);
  assign _zz_result_445 = _zz_result_446[6:0];
  assign _zz_result_448 = ({1'b0,_zz_result_449} + _zz_result_513);
  assign _zz_result_447 = _zz_result_448[6:0];
  assign _zz_result_450 = ({1'b0,_zz_result_451} + _zz_result_511);
  assign _zz_result_449 = _zz_result_450[6:0];
  assign _zz_result_452 = ({1'b0,_zz_result_453} + _zz_result_509);
  assign _zz_result_451 = _zz_result_452[6:0];
  assign _zz_result_454 = ({1'b0,_zz_result_455} + _zz_result_507);
  assign _zz_result_453 = _zz_result_454[6:0];
  assign _zz_result_456 = ({1'b0,_zz_result_457} + _zz_result_505);
  assign _zz_result_455 = _zz_result_456[6:0];
  assign _zz_result_458 = ({1'b0,_zz_result_459} + _zz_result_503);
  assign _zz_result_457 = _zz_result_458[6:0];
  assign _zz_result_460 = ({1'b0,_zz_result_461} + _zz_result_501);
  assign _zz_result_459 = _zz_result_460[6:0];
  assign _zz_result_462 = ({1'b0,_zz_result_463} + _zz_result_499);
  assign _zz_result_461 = _zz_result_462[6:0];
  assign _zz_result_464 = ({1'b0,_zz_result_465} + _zz_result_497);
  assign _zz_result_463 = _zz_result_464[6:0];
  assign _zz_result_466 = ({1'b0,_zz_result_467} + _zz_result_495);
  assign _zz_result_465 = _zz_result_466[6:0];
  assign _zz_result_468 = ({1'b0,_zz_result_469} + _zz_result_493);
  assign _zz_result_467 = _zz_result_468[6:0];
  assign _zz_result_470 = ({1'b0,_zz_result_471} + _zz_result_491);
  assign _zz_result_469 = _zz_result_470[6:0];
  assign _zz_result_472 = ({1'b0,_zz_result_473} + _zz_result_489);
  assign _zz_result_471 = _zz_result_472[6:0];
  assign _zz_result_474 = ({1'b0,_zz_result_475} + _zz_result_487);
  assign _zz_result_473 = _zz_result_474[6:0];
  assign _zz_result_476 = ({1'b0,_zz_result_477} + _zz_result_485);
  assign _zz_result_475 = _zz_result_476[6:0];
  assign _zz_result_478 = ({1'b0,_zz_result_479} + _zz_result_483);
  assign _zz_result_477 = _zz_result_478[6:0];
  assign _zz_result_480 = ({1'b0,7'h0} + _zz_result_481);
  assign _zz_result_479 = _zz_result_480[6:0];
  assign _zz_result_482 = {1'b0,io_a[0]};
  assign _zz_result_481 = {6'd0, _zz_result_482};
  assign _zz_result_484 = {1'b0,io_a[1]};
  assign _zz_result_483 = {6'd0, _zz_result_484};
  assign _zz_result_486 = {1'b0,io_a[2]};
  assign _zz_result_485 = {6'd0, _zz_result_486};
  assign _zz_result_488 = {1'b0,io_a[3]};
  assign _zz_result_487 = {6'd0, _zz_result_488};
  assign _zz_result_490 = {1'b0,io_a[4]};
  assign _zz_result_489 = {6'd0, _zz_result_490};
  assign _zz_result_492 = {1'b0,io_a[5]};
  assign _zz_result_491 = {6'd0, _zz_result_492};
  assign _zz_result_494 = {1'b0,io_a[6]};
  assign _zz_result_493 = {6'd0, _zz_result_494};
  assign _zz_result_496 = {1'b0,io_a[7]};
  assign _zz_result_495 = {6'd0, _zz_result_496};
  assign _zz_result_498 = {1'b0,io_a[8]};
  assign _zz_result_497 = {6'd0, _zz_result_498};
  assign _zz_result_500 = {1'b0,io_a[9]};
  assign _zz_result_499 = {6'd0, _zz_result_500};
  assign _zz_result_502 = {1'b0,io_a[10]};
  assign _zz_result_501 = {6'd0, _zz_result_502};
  assign _zz_result_504 = {1'b0,io_a[11]};
  assign _zz_result_503 = {6'd0, _zz_result_504};
  assign _zz_result_506 = {1'b0,io_a[12]};
  assign _zz_result_505 = {6'd0, _zz_result_506};
  assign _zz_result_508 = {1'b0,io_a[13]};
  assign _zz_result_507 = {6'd0, _zz_result_508};
  assign _zz_result_510 = {1'b0,io_a[14]};
  assign _zz_result_509 = {6'd0, _zz_result_510};
  assign _zz_result_512 = {1'b0,io_a[15]};
  assign _zz_result_511 = {6'd0, _zz_result_512};
  assign _zz_result_514 = {1'b0,io_a[16]};
  assign _zz_result_513 = {6'd0, _zz_result_514};
  assign _zz_result_516 = {1'b0,io_a[17]};
  assign _zz_result_515 = {6'd0, _zz_result_516};
  assign _zz_result_518 = {1'b0,io_a[18]};
  assign _zz_result_517 = {6'd0, _zz_result_518};
  assign _zz_result_520 = {1'b0,io_a[19]};
  assign _zz_result_519 = {6'd0, _zz_result_520};
  assign _zz_result_522 = {1'b0,io_a[20]};
  assign _zz_result_521 = {6'd0, _zz_result_522};
  assign _zz_result_524 = {1'b0,io_a[21]};
  assign _zz_result_523 = {6'd0, _zz_result_524};
  assign _zz_result_526 = {1'b0,io_a[22]};
  assign _zz_result_525 = {6'd0, _zz_result_526};
  assign _zz_result_528 = {1'b0,io_a[23]};
  assign _zz_result_527 = {6'd0, _zz_result_528};
  assign _zz_result_530 = {1'b0,io_a[24]};
  assign _zz_result_529 = {6'd0, _zz_result_530};
  assign _zz_result_532 = {1'b0,io_a[25]};
  assign _zz_result_531 = {6'd0, _zz_result_532};
  assign _zz_result_534 = {1'b0,io_a[26]};
  assign _zz_result_533 = {6'd0, _zz_result_534};
  assign _zz_result_536 = {1'b0,io_a[27]};
  assign _zz_result_535 = {6'd0, _zz_result_536};
  assign _zz_result_538 = {1'b0,io_a[28]};
  assign _zz_result_537 = {6'd0, _zz_result_538};
  assign _zz_result_540 = {1'b0,io_a[29]};
  assign _zz_result_539 = {6'd0, _zz_result_540};
  assign _zz_result_542 = {1'b0,io_a[30]};
  assign _zz_result_541 = {6'd0, _zz_result_542};
  assign _zz_result_544 = {1'b0,io_a[31]};
  assign _zz_result_543 = {6'd0, _zz_result_544};
  assign _zz_result_546 = {1'b0,io_a[32]};
  assign _zz_result_545 = {6'd0, _zz_result_546};
  assign _zz_result_548 = {1'b0,io_a[33]};
  assign _zz_result_547 = {6'd0, _zz_result_548};
  assign _zz_result_550 = {1'b0,io_a[34]};
  assign _zz_result_549 = {6'd0, _zz_result_550};
  assign _zz_result_552 = {1'b0,io_a[35]};
  assign _zz_result_551 = {6'd0, _zz_result_552};
  assign _zz_result_554 = {1'b0,io_a[36]};
  assign _zz_result_553 = {6'd0, _zz_result_554};
  assign _zz_result_556 = {1'b0,io_a[37]};
  assign _zz_result_555 = {6'd0, _zz_result_556};
  assign _zz_result_558 = {1'b0,io_a[38]};
  assign _zz_result_557 = {6'd0, _zz_result_558};
  assign _zz_result_560 = {1'b0,io_a[39]};
  assign _zz_result_559 = {6'd0, _zz_result_560};
  assign _zz_result_562 = {1'b0,io_a[40]};
  assign _zz_result_561 = {6'd0, _zz_result_562};
  assign _zz_result_564 = {1'b0,io_a[41]};
  assign _zz_result_563 = {6'd0, _zz_result_564};
  assign _zz_result_566 = {1'b0,io_a[42]};
  assign _zz_result_565 = {6'd0, _zz_result_566};
  assign _zz_result_568 = {1'b0,io_a[43]};
  assign _zz_result_567 = {6'd0, _zz_result_568};
  assign _zz_result_570 = {1'b0,io_a[44]};
  assign _zz_result_569 = {6'd0, _zz_result_570};
  assign _zz_result_572 = {1'b0,io_a[45]};
  assign _zz_result_571 = {6'd0, _zz_result_572};
  assign _zz_result_574 = {1'b0,io_a[46]};
  assign _zz_result_573 = {6'd0, _zz_result_574};
  assign _zz_result_576 = {1'b0,io_a[47]};
  assign _zz_result_575 = {6'd0, _zz_result_576};
  assign _zz_result_578 = {1'b0,io_a[48]};
  assign _zz_result_577 = {6'd0, _zz_result_578};
  assign _zz_result_580 = {1'b0,io_a[49]};
  assign _zz_result_579 = {6'd0, _zz_result_580};
  assign _zz_result_582 = {1'b0,io_a[50]};
  assign _zz_result_581 = {6'd0, _zz_result_582};
  assign _zz_result_584 = {1'b0,io_a[51]};
  assign _zz_result_583 = {6'd0, _zz_result_584};
  assign _zz_result_586 = {1'b0,io_a[52]};
  assign _zz_result_585 = {6'd0, _zz_result_586};
  assign _zz_result_588 = {1'b0,io_a[53]};
  assign _zz_result_587 = {6'd0, _zz_result_588};
  assign _zz_result_590 = {1'b0,io_a[54]};
  assign _zz_result_589 = {6'd0, _zz_result_590};
  assign _zz_result_592 = {1'b0,io_a[55]};
  assign _zz_result_591 = {6'd0, _zz_result_592};
  assign _zz_result_594 = {1'b0,io_a[56]};
  assign _zz_result_593 = {6'd0, _zz_result_594};
  assign _zz_result_596 = {1'b0,io_a[57]};
  assign _zz_result_595 = {6'd0, _zz_result_596};
  assign _zz_result_598 = {1'b0,io_a[58]};
  assign _zz_result_597 = {6'd0, _zz_result_598};
  assign _zz_result_600 = {1'b0,io_a[59]};
  assign _zz_result_599 = {6'd0, _zz_result_600};
  assign _zz_result_602 = {1'b0,io_a[60]};
  assign _zz_result_601 = {6'd0, _zz_result_602};
  assign _zz_result_604 = {1'b0,io_a[61]};
  assign _zz_result_603 = {6'd0, _zz_result_604};
  assign _zz_result_606 = {1'b0,io_a[62]};
  assign _zz_result_605 = {6'd0, _zz_result_606};
  assign _zz_result_608 = {1'b0,io_a[63]};
  assign _zz_result_607 = {6'd0, _zz_result_608};
  assign _zz_result_610 = io_a[7 : 0];
  assign _zz_result_609 = {{56{_zz_result_610[7]}}, _zz_result_610};
  assign _zz_result_612 = io_a[15 : 0];
  assign _zz_result_611 = {{48{_zz_result_612[15]}}, _zz_result_612};
  assign _zz_result_614 = io_a[15 : 0];
  assign _zz_result_613 = {48'd0, _zz_result_614};
  assign _zz_result_622 = ({63'd0,aU} <<< _zz_result_623);
  assign _zz_result_621 = _zz_result_622[63:0];
  assign _zz_result_623 = _zz_result_126[5:0];
  assign _zz_result_624 = (aU >>> _zz_result_625);
  assign _zz_result_625 = (7'h40 - _zz_result_126);
  assign _zz_result_626 = (aU >>> _zz_result_127);
  assign _zz_result_628 = ({127'd0,aU} <<< _zz_result_629);
  assign _zz_result_627 = _zz_result_628[63:0];
  assign _zz_result_629 = (7'h40 - _zz_result_127);
  assign _zz_result_631 = (_zz_result_632 + _zz_result_633);
  assign _zz_result_630 = _zz_result_631[63:0];
  assign _zz_result_632 = ({1'd0,aU} <<< 1'd1);
  assign _zz_result_633 = {1'd0, bU};
  assign _zz_result_635 = (_zz_result_636 + _zz_result_637);
  assign _zz_result_634 = _zz_result_635[63:0];
  assign _zz_result_636 = ({2'd0,aU} <<< 2'd2);
  assign _zz_result_637 = {2'd0, bU};
  assign _zz_result_639 = (_zz_result_640 + _zz_result_641);
  assign _zz_result_638 = _zz_result_639[63:0];
  assign _zz_result_640 = ({3'd0,aU} <<< 2'd3);
  assign _zz_result_641 = {3'd0, bU};
  assign _zz_result_642 = (aZext + bU);
  assign _zz_result_644 = (_zz_result_645 + _zz_result_646);
  assign _zz_result_643 = _zz_result_644[63:0];
  assign _zz_result_645 = ({1'd0,aZext} <<< 1'd1);
  assign _zz_result_646 = {1'd0, bU};
  assign _zz_result_648 = (_zz_result_649 + _zz_result_650);
  assign _zz_result_647 = _zz_result_648[63:0];
  assign _zz_result_649 = ({2'd0,aZext} <<< 2'd2);
  assign _zz_result_650 = {2'd0, bU};
  assign _zz_result_652 = (_zz_result_653 + _zz_result_654);
  assign _zz_result_651 = _zz_result_652[63:0];
  assign _zz_result_653 = ({3'd0,aZext} <<< 2'd3);
  assign _zz_result_654 = {3'd0, bU};
  assign _zz_result_656 = ({63'd0,aZext} <<< shamt);
  assign _zz_result_655 = _zz_result_656[63:0];
  assign _zz_result_657 = ({32'd0,bU[31 : 0]} <<< 6'd32);
  assign _zz_result_659 = aU[31 : 0];
  assign _zz_result_658 = {32'd0, _zz_result_659};
  assign _zz_result_661 = ({8'd0,bU[7 : 0]} <<< 4'd8);
  assign _zz_result_660 = {48'd0, _zz_result_661};
  assign _zz_result_663 = aU[7 : 0];
  assign _zz_result_662 = {56'd0, _zz_result_663};
  assign _zz_result_665 = (_zz_result_666 | _zz_result_668);
  assign _zz_result_664 = {{32{_zz_result_665[31]}}, _zz_result_665};
  assign _zz_result_667 = aU[15 : 0];
  assign _zz_result_666 = {16'd0, _zz_result_667};
  assign _zz_result_669 = ({16'd0,_zz_result_670} <<< 5'd16);
  assign _zz_result_668 = _zz_result_669[31:0];
  assign _zz_result_671 = bU[15 : 0];
  assign _zz_result_670 = {16'd0, _zz_result_671};
  assign _zz_result_673 = (((_zz_result_188 && (! _zz_result_157[1])) && _zz_result_157[0]) ? 6'h1f : ((_zz_result_188 && _zz_result_157[1]) ? 6'h1e : ((_zz_result_187 && _zz_result_157[2]) ? 6'h1d : ((_zz_result_186 && _zz_result_157[3]) ? 6'h1c : ((_zz_result_185 && _zz_result_674) ? 6'h1b : (_zz_result_675 ? _zz_result_676 : _zz_result_677))))));
  assign _zz_result_672 = {58'd0, _zz_result_673};
  assign _zz_result_691 = (((_zz_result_220 && (! _zz_result_189[30])) && _zz_result_189[31]) ? 6'h1f : ((_zz_result_220 && _zz_result_189[30]) ? 6'h1e : ((_zz_result_219 && _zz_result_189[29]) ? 6'h1d : ((_zz_result_218 && _zz_result_189[28]) ? 6'h1c : ((_zz_result_217 && _zz_result_692) ? 6'h1b : (_zz_result_693 ? _zz_result_694 : _zz_result_695))))));
  assign _zz_result_690 = {58'd0, _zz_result_691};
  assign _zz_result_709 = _zz_result_710[5:0];
  assign _zz_result_708 = {58'd0, _zz_result_709};
  assign _zz_result_710 = ({1'b0,_zz_result_711} + _zz_result_835);
  assign _zz_result_712 = ({1'b0,_zz_result_713} + _zz_result_833);
  assign _zz_result_711 = _zz_result_712[5:0];
  assign _zz_result_714 = ({1'b0,_zz_result_715} + _zz_result_831);
  assign _zz_result_713 = _zz_result_714[5:0];
  assign _zz_result_716 = ({1'b0,_zz_result_717} + _zz_result_829);
  assign _zz_result_715 = _zz_result_716[5:0];
  assign _zz_result_718 = ({1'b0,_zz_result_719} + _zz_result_827);
  assign _zz_result_717 = _zz_result_718[5:0];
  assign _zz_result_720 = ({1'b0,_zz_result_721} + _zz_result_825);
  assign _zz_result_719 = _zz_result_720[5:0];
  assign _zz_result_722 = ({1'b0,_zz_result_723} + _zz_result_823);
  assign _zz_result_721 = _zz_result_722[5:0];
  assign _zz_result_724 = ({1'b0,_zz_result_725} + _zz_result_821);
  assign _zz_result_723 = _zz_result_724[5:0];
  assign _zz_result_726 = ({1'b0,_zz_result_727} + _zz_result_819);
  assign _zz_result_725 = _zz_result_726[5:0];
  assign _zz_result_728 = ({1'b0,_zz_result_729} + _zz_result_817);
  assign _zz_result_727 = _zz_result_728[5:0];
  assign _zz_result_730 = ({1'b0,_zz_result_731} + _zz_result_815);
  assign _zz_result_729 = _zz_result_730[5:0];
  assign _zz_result_732 = ({1'b0,_zz_result_733} + _zz_result_813);
  assign _zz_result_731 = _zz_result_732[5:0];
  assign _zz_result_734 = ({1'b0,_zz_result_735} + _zz_result_811);
  assign _zz_result_733 = _zz_result_734[5:0];
  assign _zz_result_736 = ({1'b0,_zz_result_737} + _zz_result_809);
  assign _zz_result_735 = _zz_result_736[5:0];
  assign _zz_result_738 = ({1'b0,_zz_result_739} + _zz_result_807);
  assign _zz_result_737 = _zz_result_738[5:0];
  assign _zz_result_740 = ({1'b0,_zz_result_741} + _zz_result_805);
  assign _zz_result_739 = _zz_result_740[5:0];
  assign _zz_result_742 = ({1'b0,_zz_result_743} + _zz_result_803);
  assign _zz_result_741 = _zz_result_742[5:0];
  assign _zz_result_744 = ({1'b0,_zz_result_745} + _zz_result_801);
  assign _zz_result_743 = _zz_result_744[5:0];
  assign _zz_result_746 = ({1'b0,_zz_result_747} + _zz_result_799);
  assign _zz_result_745 = _zz_result_746[5:0];
  assign _zz_result_748 = ({1'b0,_zz_result_749} + _zz_result_797);
  assign _zz_result_747 = _zz_result_748[5:0];
  assign _zz_result_750 = ({1'b0,_zz_result_751} + _zz_result_795);
  assign _zz_result_749 = _zz_result_750[5:0];
  assign _zz_result_752 = ({1'b0,_zz_result_753} + _zz_result_793);
  assign _zz_result_751 = _zz_result_752[5:0];
  assign _zz_result_754 = ({1'b0,_zz_result_755} + _zz_result_791);
  assign _zz_result_753 = _zz_result_754[5:0];
  assign _zz_result_756 = ({1'b0,_zz_result_757} + _zz_result_789);
  assign _zz_result_755 = _zz_result_756[5:0];
  assign _zz_result_758 = ({1'b0,_zz_result_759} + _zz_result_787);
  assign _zz_result_757 = _zz_result_758[5:0];
  assign _zz_result_760 = ({1'b0,_zz_result_761} + _zz_result_785);
  assign _zz_result_759 = _zz_result_760[5:0];
  assign _zz_result_762 = ({1'b0,_zz_result_763} + _zz_result_783);
  assign _zz_result_761 = _zz_result_762[5:0];
  assign _zz_result_764 = ({1'b0,_zz_result_765} + _zz_result_781);
  assign _zz_result_763 = _zz_result_764[5:0];
  assign _zz_result_766 = ({1'b0,_zz_result_767} + _zz_result_779);
  assign _zz_result_765 = _zz_result_766[5:0];
  assign _zz_result_768 = ({1'b0,_zz_result_769} + _zz_result_777);
  assign _zz_result_767 = _zz_result_768[5:0];
  assign _zz_result_770 = ({1'b0,_zz_result_771} + _zz_result_775);
  assign _zz_result_769 = _zz_result_770[5:0];
  assign _zz_result_772 = ({1'b0,6'h0} + _zz_result_773);
  assign _zz_result_771 = _zz_result_772[5:0];
  assign _zz_result_774 = {1'b0,_zz_result_221[0]};
  assign _zz_result_773 = {5'd0, _zz_result_774};
  assign _zz_result_776 = {1'b0,_zz_result_221[1]};
  assign _zz_result_775 = {5'd0, _zz_result_776};
  assign _zz_result_778 = {1'b0,_zz_result_221[2]};
  assign _zz_result_777 = {5'd0, _zz_result_778};
  assign _zz_result_780 = {1'b0,_zz_result_221[3]};
  assign _zz_result_779 = {5'd0, _zz_result_780};
  assign _zz_result_782 = {1'b0,_zz_result_221[4]};
  assign _zz_result_781 = {5'd0, _zz_result_782};
  assign _zz_result_784 = {1'b0,_zz_result_221[5]};
  assign _zz_result_783 = {5'd0, _zz_result_784};
  assign _zz_result_786 = {1'b0,_zz_result_221[6]};
  assign _zz_result_785 = {5'd0, _zz_result_786};
  assign _zz_result_788 = {1'b0,_zz_result_221[7]};
  assign _zz_result_787 = {5'd0, _zz_result_788};
  assign _zz_result_790 = {1'b0,_zz_result_221[8]};
  assign _zz_result_789 = {5'd0, _zz_result_790};
  assign _zz_result_792 = {1'b0,_zz_result_221[9]};
  assign _zz_result_791 = {5'd0, _zz_result_792};
  assign _zz_result_794 = {1'b0,_zz_result_221[10]};
  assign _zz_result_793 = {5'd0, _zz_result_794};
  assign _zz_result_796 = {1'b0,_zz_result_221[11]};
  assign _zz_result_795 = {5'd0, _zz_result_796};
  assign _zz_result_798 = {1'b0,_zz_result_221[12]};
  assign _zz_result_797 = {5'd0, _zz_result_798};
  assign _zz_result_800 = {1'b0,_zz_result_221[13]};
  assign _zz_result_799 = {5'd0, _zz_result_800};
  assign _zz_result_802 = {1'b0,_zz_result_221[14]};
  assign _zz_result_801 = {5'd0, _zz_result_802};
  assign _zz_result_804 = {1'b0,_zz_result_221[15]};
  assign _zz_result_803 = {5'd0, _zz_result_804};
  assign _zz_result_806 = {1'b0,_zz_result_221[16]};
  assign _zz_result_805 = {5'd0, _zz_result_806};
  assign _zz_result_808 = {1'b0,_zz_result_221[17]};
  assign _zz_result_807 = {5'd0, _zz_result_808};
  assign _zz_result_810 = {1'b0,_zz_result_221[18]};
  assign _zz_result_809 = {5'd0, _zz_result_810};
  assign _zz_result_812 = {1'b0,_zz_result_221[19]};
  assign _zz_result_811 = {5'd0, _zz_result_812};
  assign _zz_result_814 = {1'b0,_zz_result_221[20]};
  assign _zz_result_813 = {5'd0, _zz_result_814};
  assign _zz_result_816 = {1'b0,_zz_result_221[21]};
  assign _zz_result_815 = {5'd0, _zz_result_816};
  assign _zz_result_818 = {1'b0,_zz_result_221[22]};
  assign _zz_result_817 = {5'd0, _zz_result_818};
  assign _zz_result_820 = {1'b0,_zz_result_221[23]};
  assign _zz_result_819 = {5'd0, _zz_result_820};
  assign _zz_result_822 = {1'b0,_zz_result_221[24]};
  assign _zz_result_821 = {5'd0, _zz_result_822};
  assign _zz_result_824 = {1'b0,_zz_result_221[25]};
  assign _zz_result_823 = {5'd0, _zz_result_824};
  assign _zz_result_826 = {1'b0,_zz_result_221[26]};
  assign _zz_result_825 = {5'd0, _zz_result_826};
  assign _zz_result_828 = {1'b0,_zz_result_221[27]};
  assign _zz_result_827 = {5'd0, _zz_result_828};
  assign _zz_result_830 = {1'b0,_zz_result_221[28]};
  assign _zz_result_829 = {5'd0, _zz_result_830};
  assign _zz_result_832 = {1'b0,_zz_result_221[29]};
  assign _zz_result_831 = {5'd0, _zz_result_832};
  assign _zz_result_834 = {1'b0,_zz_result_221[30]};
  assign _zz_result_833 = {5'd0, _zz_result_834};
  assign _zz_result_836 = {1'b0,_zz_result_221[31]};
  assign _zz_result_835 = {5'd0, _zz_result_836};
  assign _zz_result_838 = ((shamtW == 5'h0) ? aWU : (_zz_result_839 | _zz_result_842));
  assign _zz_result_837 = {{32{_zz_result_838[31]}}, _zz_result_838};
  assign _zz_result_840 = ({31'd0,aWU} <<< _zz_result_841);
  assign _zz_result_839 = _zz_result_840[31:0];
  assign _zz_result_841 = _zz_result_222[4:0];
  assign _zz_result_842 = (aWU >>> _zz_result_843);
  assign _zz_result_843 = (6'h20 - _zz_result_222);
  assign _zz_result_845 = ((shamtW == 5'h0) ? aWU : (_zz_result_846 | _zz_result_847));
  assign _zz_result_844 = {{32{_zz_result_845[31]}}, _zz_result_845};
  assign _zz_result_846 = (aWU >>> _zz_result_223);
  assign _zz_result_848 = ({63'd0,aWU} <<< _zz_result_849);
  assign _zz_result_847 = _zz_result_848[31:0];
  assign _zz_result_849 = (6'h20 - _zz_result_223);
  assign _zz_result_851 = (((_zz_result_852 | _zz_result_854) ^ (_zz_result_856 | _zz_result_858)) ^ (_zz_result_860 | _zz_result_862));
  assign _zz_result_850 = {{32{_zz_result_851[31]}}, _zz_result_851};
  assign _zz_result_853 = (_zz_result_224 >>> 2'd2);
  assign _zz_result_852 = {2'd0, _zz_result_853};
  assign _zz_result_855 = ({30'd0,_zz_result_224} <<< 5'd30);
  assign _zz_result_854 = _zz_result_855[31:0];
  assign _zz_result_857 = (_zz_result_224 >>> 4'd13);
  assign _zz_result_856 = {13'd0, _zz_result_857};
  assign _zz_result_859 = ({19'd0,_zz_result_224} <<< 5'd19);
  assign _zz_result_858 = _zz_result_859[31:0];
  assign _zz_result_861 = (_zz_result_224 >>> 5'd22);
  assign _zz_result_860 = {22'd0, _zz_result_861};
  assign _zz_result_863 = ({10'd0,_zz_result_224} <<< 4'd10);
  assign _zz_result_862 = _zz_result_863[31:0];
  assign _zz_result_865 = (((_zz_result_866 | _zz_result_868) ^ (_zz_result_870 | _zz_result_872)) ^ (_zz_result_874 | _zz_result_876));
  assign _zz_result_864 = {{32{_zz_result_865[31]}}, _zz_result_865};
  assign _zz_result_867 = (_zz_result_225 >>> 3'd6);
  assign _zz_result_866 = {6'd0, _zz_result_867};
  assign _zz_result_869 = ({26'd0,_zz_result_225} <<< 5'd26);
  assign _zz_result_868 = _zz_result_869[31:0];
  assign _zz_result_871 = (_zz_result_225 >>> 4'd11);
  assign _zz_result_870 = {11'd0, _zz_result_871};
  assign _zz_result_873 = ({21'd0,_zz_result_225} <<< 5'd21);
  assign _zz_result_872 = _zz_result_873[31:0];
  assign _zz_result_875 = (_zz_result_225 >>> 5'd25);
  assign _zz_result_874 = {25'd0, _zz_result_875};
  assign _zz_result_877 = ({7'd0,_zz_result_225} <<< 3'd7);
  assign _zz_result_876 = _zz_result_877[31:0];
  assign _zz_result_879 = (((_zz_result_880 | _zz_result_882) ^ (_zz_result_884 | _zz_result_886)) ^ _zz_result_888);
  assign _zz_result_878 = {{32{_zz_result_879[31]}}, _zz_result_879};
  assign _zz_result_881 = (_zz_result_226 >>> 3'd7);
  assign _zz_result_880 = {7'd0, _zz_result_881};
  assign _zz_result_883 = ({25'd0,_zz_result_226} <<< 5'd25);
  assign _zz_result_882 = _zz_result_883[31:0];
  assign _zz_result_885 = (_zz_result_226 >>> 5'd18);
  assign _zz_result_884 = {18'd0, _zz_result_885};
  assign _zz_result_887 = ({14'd0,_zz_result_226} <<< 4'd14);
  assign _zz_result_886 = _zz_result_887[31:0];
  assign _zz_result_889 = (_zz_result_226 >>> 2'd3);
  assign _zz_result_888 = {3'd0, _zz_result_889};
  assign _zz_result_891 = (((_zz_result_892 | _zz_result_894) ^ (_zz_result_896 | _zz_result_898)) ^ _zz_result_900);
  assign _zz_result_890 = {{32{_zz_result_891[31]}}, _zz_result_891};
  assign _zz_result_893 = (_zz_result_227 >>> 5'd17);
  assign _zz_result_892 = {17'd0, _zz_result_893};
  assign _zz_result_895 = ({15'd0,_zz_result_227} <<< 4'd15);
  assign _zz_result_894 = _zz_result_895[31:0];
  assign _zz_result_897 = (_zz_result_227 >>> 5'd19);
  assign _zz_result_896 = {19'd0, _zz_result_897};
  assign _zz_result_899 = ({13'd0,_zz_result_227} <<< 4'd13);
  assign _zz_result_898 = _zz_result_899[31:0];
  assign _zz_result_901 = (_zz_result_227 >>> 4'd10);
  assign _zz_result_900 = {10'd0, _zz_result_901};
  assign _zz_result_903 = (_zz_result_228 >>> 5'd28);
  assign _zz_result_902 = {28'd0, _zz_result_903};
  assign _zz_result_905 = ({36'd0,_zz_result_228} <<< 6'd36);
  assign _zz_result_904 = _zz_result_905[63:0];
  assign _zz_result_907 = (_zz_result_228 >>> 6'd34);
  assign _zz_result_906 = {34'd0, _zz_result_907};
  assign _zz_result_909 = ({30'd0,_zz_result_228} <<< 5'd30);
  assign _zz_result_908 = _zz_result_909[63:0];
  assign _zz_result_911 = (_zz_result_228 >>> 6'd39);
  assign _zz_result_910 = {39'd0, _zz_result_911};
  assign _zz_result_913 = ({25'd0,_zz_result_228} <<< 5'd25);
  assign _zz_result_912 = _zz_result_913[63:0];
  assign _zz_result_915 = (_zz_result_229 >>> 4'd14);
  assign _zz_result_914 = {14'd0, _zz_result_915};
  assign _zz_result_917 = ({50'd0,_zz_result_229} <<< 6'd50);
  assign _zz_result_916 = _zz_result_917[63:0];
  assign _zz_result_919 = (_zz_result_229 >>> 5'd18);
  assign _zz_result_918 = {18'd0, _zz_result_919};
  assign _zz_result_921 = ({46'd0,_zz_result_229} <<< 6'd46);
  assign _zz_result_920 = _zz_result_921[63:0];
  assign _zz_result_923 = (_zz_result_229 >>> 6'd41);
  assign _zz_result_922 = {41'd0, _zz_result_923};
  assign _zz_result_925 = ({23'd0,_zz_result_229} <<< 5'd23);
  assign _zz_result_924 = _zz_result_925[63:0];
  assign _zz_result_927 = (_zz_result_230 >>> 1'd1);
  assign _zz_result_926 = {1'd0, _zz_result_927};
  assign _zz_result_929 = ({63'd0,_zz_result_230} <<< 6'd63);
  assign _zz_result_928 = _zz_result_929[63:0];
  assign _zz_result_931 = (_zz_result_230 >>> 4'd8);
  assign _zz_result_930 = {8'd0, _zz_result_931};
  assign _zz_result_933 = ({56'd0,_zz_result_230} <<< 6'd56);
  assign _zz_result_932 = _zz_result_933[63:0];
  assign _zz_result_935 = (_zz_result_230 >>> 3'd7);
  assign _zz_result_934 = {7'd0, _zz_result_935};
  assign _zz_result_937 = (_zz_result_231 >>> 5'd19);
  assign _zz_result_936 = {19'd0, _zz_result_937};
  assign _zz_result_939 = ({45'd0,_zz_result_231} <<< 6'd45);
  assign _zz_result_938 = _zz_result_939[63:0];
  assign _zz_result_941 = (_zz_result_231 >>> 6'd61);
  assign _zz_result_940 = {61'd0, _zz_result_941};
  assign _zz_result_943 = ({3'd0,_zz_result_231} <<< 2'd3);
  assign _zz_result_942 = _zz_result_943[63:0];
  assign _zz_result_945 = (_zz_result_231 >>> 3'd6);
  assign _zz_result_944 = {6'd0, _zz_result_945};
  assign _zz_result_947 = (((((_zz_result_948 ^ _zz_result_950) ^ _zz_result_952) ^ _zz_result_954) ^ _zz_result_956) ^ _zz_result_958);
  assign _zz_result_946 = {{32{_zz_result_947[31]}}, _zz_result_947};
  assign _zz_result_949 = ({25'd0,_zz_result_232} <<< 5'd25);
  assign _zz_result_948 = _zz_result_949[31:0];
  assign _zz_result_951 = ({30'd0,_zz_result_232} <<< 5'd30);
  assign _zz_result_950 = _zz_result_951[31:0];
  assign _zz_result_953 = (_zz_result_232 >>> 5'd28);
  assign _zz_result_952 = {28'd0, _zz_result_953};
  assign _zz_result_955 = (_zz_result_233 >>> 3'd7);
  assign _zz_result_954 = {7'd0, _zz_result_955};
  assign _zz_result_957 = (_zz_result_233 >>> 2'd2);
  assign _zz_result_956 = {2'd0, _zz_result_957};
  assign _zz_result_959 = ({4'd0,_zz_result_233} <<< 3'd4);
  assign _zz_result_958 = _zz_result_959[31:0];
  assign _zz_result_961 = (((((_zz_result_962 ^ _zz_result_964) ^ _zz_result_966) ^ _zz_result_968) ^ _zz_result_970) ^ _zz_result_972);
  assign _zz_result_960 = {{32{_zz_result_961[31]}}, _zz_result_961};
  assign _zz_result_963 = ({23'd0,_zz_result_234} <<< 5'd23);
  assign _zz_result_962 = _zz_result_963[31:0];
  assign _zz_result_965 = (_zz_result_234 >>> 4'd14);
  assign _zz_result_964 = {14'd0, _zz_result_965};
  assign _zz_result_967 = (_zz_result_234 >>> 5'd18);
  assign _zz_result_966 = {18'd0, _zz_result_967};
  assign _zz_result_969 = (_zz_result_235 >>> 4'd9);
  assign _zz_result_968 = {9'd0, _zz_result_969};
  assign _zz_result_971 = ({18'd0,_zz_result_235} <<< 5'd18);
  assign _zz_result_970 = _zz_result_971[31:0];
  assign _zz_result_973 = ({14'd0,_zz_result_235} <<< 4'd14);
  assign _zz_result_972 = _zz_result_973[31:0];
  assign _zz_result_975 = (((((_zz_result_976 ^ _zz_result_978) ^ _zz_result_980) ^ _zz_result_982) ^ _zz_result_984) ^ _zz_result_986);
  assign _zz_result_974 = {{32{_zz_result_975[31]}}, _zz_result_975};
  assign _zz_result_977 = (_zz_result_236 >>> 1'd1);
  assign _zz_result_976 = {1'd0, _zz_result_977};
  assign _zz_result_979 = (_zz_result_236 >>> 3'd7);
  assign _zz_result_978 = {7'd0, _zz_result_979};
  assign _zz_result_981 = (_zz_result_236 >>> 4'd8);
  assign _zz_result_980 = {8'd0, _zz_result_981};
  assign _zz_result_983 = ({31'd0,_zz_result_237} <<< 5'd31);
  assign _zz_result_982 = _zz_result_983[31:0];
  assign _zz_result_985 = ({25'd0,_zz_result_237} <<< 5'd25);
  assign _zz_result_984 = _zz_result_985[31:0];
  assign _zz_result_987 = ({24'd0,_zz_result_237} <<< 5'd24);
  assign _zz_result_986 = _zz_result_987[31:0];
  assign _zz_result_989 = ((((_zz_result_990 ^ _zz_result_992) ^ _zz_result_994) ^ _zz_result_996) ^ _zz_result_998);
  assign _zz_result_988 = {{32{_zz_result_989[31]}}, _zz_result_989};
  assign _zz_result_991 = (_zz_result_238 >>> 1'd1);
  assign _zz_result_990 = {1'd0, _zz_result_991};
  assign _zz_result_993 = (_zz_result_238 >>> 3'd7);
  assign _zz_result_992 = {7'd0, _zz_result_993};
  assign _zz_result_995 = (_zz_result_238 >>> 4'd8);
  assign _zz_result_994 = {8'd0, _zz_result_995};
  assign _zz_result_997 = ({31'd0,_zz_result_239} <<< 5'd31);
  assign _zz_result_996 = _zz_result_997[31:0];
  assign _zz_result_999 = ({24'd0,_zz_result_239} <<< 5'd24);
  assign _zz_result_998 = _zz_result_999[31:0];
  assign _zz_result_1001 = (((((_zz_result_1002 ^ _zz_result_1004) ^ _zz_result_1006) ^ _zz_result_1008) ^ _zz_result_1010) ^ _zz_result_1012);
  assign _zz_result_1000 = {{32{_zz_result_1001[31]}}, _zz_result_1001};
  assign _zz_result_1003 = ({3'd0,_zz_result_240} <<< 2'd3);
  assign _zz_result_1002 = _zz_result_1003[31:0];
  assign _zz_result_1005 = (_zz_result_240 >>> 3'd6);
  assign _zz_result_1004 = {6'd0, _zz_result_1005};
  assign _zz_result_1007 = (_zz_result_240 >>> 5'd19);
  assign _zz_result_1006 = {19'd0, _zz_result_1007};
  assign _zz_result_1009 = (_zz_result_241 >>> 5'd29);
  assign _zz_result_1008 = {29'd0, _zz_result_1009};
  assign _zz_result_1011 = ({26'd0,_zz_result_241} <<< 5'd26);
  assign _zz_result_1010 = _zz_result_1011[31:0];
  assign _zz_result_1013 = ({13'd0,_zz_result_241} <<< 4'd13);
  assign _zz_result_1012 = _zz_result_1013[31:0];
  assign _zz_result_1015 = ((((_zz_result_1016 ^ _zz_result_1018) ^ _zz_result_1020) ^ _zz_result_1022) ^ _zz_result_1024);
  assign _zz_result_1014 = {{32{_zz_result_1015[31]}}, _zz_result_1015};
  assign _zz_result_1017 = ({3'd0,_zz_result_242} <<< 2'd3);
  assign _zz_result_1016 = _zz_result_1017[31:0];
  assign _zz_result_1019 = (_zz_result_242 >>> 3'd6);
  assign _zz_result_1018 = {6'd0, _zz_result_1019};
  assign _zz_result_1021 = (_zz_result_242 >>> 5'd19);
  assign _zz_result_1020 = {19'd0, _zz_result_1021};
  assign _zz_result_1023 = (_zz_result_243 >>> 5'd29);
  assign _zz_result_1022 = {29'd0, _zz_result_1023};
  assign _zz_result_1025 = ({13'd0,_zz_result_243} <<< 4'd13);
  assign _zz_result_1024 = _zz_result_1025[31:0];
  assign _zz_result_1027 = ((_zz_result_244 ^ (_zz_result_1028 | _zz_result_1030)) ^ (_zz_result_1032 | _zz_result_1034));
  assign _zz_result_1026 = {{32{_zz_result_1027[31]}}, _zz_result_1027};
  assign _zz_result_1029 = ({9'd0,_zz_result_244} <<< 4'd9);
  assign _zz_result_1028 = _zz_result_1029[31:0];
  assign _zz_result_1031 = (_zz_result_244 >>> 5'd23);
  assign _zz_result_1030 = {23'd0, _zz_result_1031};
  assign _zz_result_1033 = ({17'd0,_zz_result_244} <<< 5'd17);
  assign _zz_result_1032 = _zz_result_1033[31:0];
  assign _zz_result_1035 = (_zz_result_244 >>> 4'd15);
  assign _zz_result_1034 = {15'd0, _zz_result_1035};
  assign _zz_result_1037 = ((_zz_result_245 ^ (_zz_result_1038 | _zz_result_1040)) ^ (_zz_result_1042 | _zz_result_1044));
  assign _zz_result_1036 = {{32{_zz_result_1037[31]}}, _zz_result_1037};
  assign _zz_result_1039 = ({15'd0,_zz_result_245} <<< 4'd15);
  assign _zz_result_1038 = _zz_result_1039[31:0];
  assign _zz_result_1041 = (_zz_result_245 >>> 5'd17);
  assign _zz_result_1040 = {17'd0, _zz_result_1041};
  assign _zz_result_1043 = ({23'd0,_zz_result_245} <<< 5'd23);
  assign _zz_result_1042 = _zz_result_1043[31:0];
  assign _zz_result_1045 = (_zz_result_245 >>> 4'd9);
  assign _zz_result_1044 = {9'd0, _zz_result_1045};
  assign _zz__zz_result_247_2 = (_zz__zz_result_247_3 >>> _zz_result_246);
  assign _zz__zz_result_247_1 = _zz__zz_result_247_2[7:0];
  assign _zz__zz_result_247_3 = bU[31:0];
  assign _zz__zz_result_248_1 = ({8'd0,_zz_result_247} <<< 4'd8);
  assign _zz__zz_result_248 = _zz__zz_result_248_1[31:0];
  assign _zz__zz_result_248_3 = ({2'd0,_zz_result_247} <<< 2'd2);
  assign _zz__zz_result_248_2 = _zz__zz_result_248_3[31:0];
  assign _zz__zz_result_248_5 = ({18'd0,_zz_result_247} <<< 5'd18);
  assign _zz__zz_result_248_4 = _zz__zz_result_248_5[31:0];
  assign _zz__zz_result_248_7 = ({26'd0,(_zz_result_247 & 32'h0000003f)} <<< 5'd26);
  assign _zz__zz_result_248_6 = _zz__zz_result_248_7[31:0];
  assign _zz__zz_result_248_9 = ({10'd0,(_zz_result_247 & 32'h000000c0)} <<< 4'd10);
  assign _zz__zz_result_248_8 = _zz__zz_result_248_9[31:0];
  assign _zz_result_1047 = (((_zz_result_246 == 5'h0) ? _zz_result_248 : (_zz_result_1048 | _zz_result_1051)) ^ _zz_result_1053);
  assign _zz_result_1046 = {{32{_zz_result_1047[31]}}, _zz_result_1047};
  assign _zz_result_1049 = ({31'd0,_zz_result_248} <<< _zz_result_1050);
  assign _zz_result_1048 = _zz_result_1049[31:0];
  assign _zz_result_1050 = _zz_result_249[4:0];
  assign _zz_result_1051 = (_zz_result_248 >>> _zz_result_1052);
  assign _zz_result_1052 = (6'h20 - _zz_result_249);
  assign _zz_result_1053 = aU[31:0];
  assign _zz__zz_result_251_2 = (_zz__zz_result_251_3 >>> _zz_result_250);
  assign _zz__zz_result_251_1 = _zz__zz_result_251_2[7:0];
  assign _zz__zz_result_251_3 = bU[31:0];
  assign _zz__zz_result_252_1 = ({29'd0,(_zz_result_251 & 32'h00000007)} <<< 5'd29);
  assign _zz__zz_result_252 = _zz__zz_result_252_1[31:0];
  assign _zz__zz_result_252_3 = ({7'd0,(_zz_result_251 & 32'h000000fe)} <<< 3'd7);
  assign _zz__zz_result_252_2 = _zz__zz_result_252_3[31:0];
  assign _zz__zz_result_252_5 = ({23'd0,(_zz_result_251 & 32'h00000001)} <<< 5'd23);
  assign _zz__zz_result_252_4 = _zz__zz_result_252_5[31:0];
  assign _zz__zz_result_252_7 = ({13'd0,(_zz_result_251 & 32'h000000f8)} <<< 4'd13);
  assign _zz__zz_result_252_6 = _zz__zz_result_252_7[31:0];
  assign _zz_result_1055 = (((_zz_result_250 == 5'h0) ? _zz_result_252 : (_zz_result_1056 | _zz_result_1059)) ^ _zz_result_1061);
  assign _zz_result_1054 = {{32{_zz_result_1055[31]}}, _zz_result_1055};
  assign _zz_result_1057 = ({31'd0,_zz_result_252} <<< _zz_result_1058);
  assign _zz_result_1056 = _zz_result_1057[31:0];
  assign _zz_result_1058 = _zz_result_253[4:0];
  assign _zz_result_1059 = (_zz_result_252 >>> _zz_result_1060);
  assign _zz_result_1060 = (6'h20 - _zz_result_253);
  assign _zz_result_1061 = aU[31:0];
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
  assign _zz_result_278 = io_a[4];
  assign _zz_result_279 = (_zz_result_58 && io_a[5]);
  assign _zz_result_280 = 7'h3a;
  assign _zz_result_281 = ((_zz_result_57 && io_a[6]) ? 7'h39 : ((_zz_result_56 && io_a[7]) ? 7'h38 : ((_zz_result_55 && io_a[8]) ? 7'h37 : ((_zz_result_54 && io_a[9]) ? 7'h36 : ((_zz_result_53 && io_a[10]) ? 7'h35 : ((_zz_result_52 && _zz_result_282) ? 7'h34 : (_zz_result_283 ? _zz_result_284 : _zz_result_285)))))));
  assign _zz_result_282 = io_a[11];
  assign _zz_result_283 = (_zz_result_51 && io_a[12]);
  assign _zz_result_284 = 7'h33;
  assign _zz_result_285 = ((_zz_result_50 && io_a[13]) ? 7'h32 : ((_zz_result_49 && io_a[14]) ? 7'h31 : ((_zz_result_48 && io_a[15]) ? 7'h30 : ((_zz_result_47 && io_a[16]) ? 7'h2f : ((_zz_result_46 && io_a[17]) ? 7'h2e : ((_zz_result_45 && _zz_result_286) ? 7'h2d : (_zz_result_287 ? _zz_result_288 : _zz_result_289)))))));
  assign _zz_result_286 = io_a[18];
  assign _zz_result_287 = (_zz_result_44 && io_a[19]);
  assign _zz_result_288 = 7'h2c;
  assign _zz_result_289 = ((_zz_result_43 && io_a[20]) ? 7'h2b : ((_zz_result_42 && io_a[21]) ? 7'h2a : ((_zz_result_41 && io_a[22]) ? 7'h29 : ((_zz_result_40 && io_a[23]) ? 7'h28 : ((_zz_result_39 && io_a[24]) ? 7'h27 : ((_zz_result_38 && _zz_result_290) ? 7'h26 : (_zz_result_291 ? _zz_result_292 : _zz_result_293)))))));
  assign _zz_result_290 = io_a[25];
  assign _zz_result_291 = (_zz_result_37 && io_a[26]);
  assign _zz_result_292 = 7'h25;
  assign _zz_result_293 = ((_zz_result_36 && io_a[27]) ? 7'h24 : ((_zz_result_35 && io_a[28]) ? 7'h23 : ((_zz_result_34 && io_a[29]) ? 7'h22 : ((_zz_result_33 && io_a[30]) ? 7'h21 : ((_zz_result_32 && io_a[31]) ? 7'h20 : ((_zz_result_31 && _zz_result_294) ? 7'h1f : (_zz_result_295 ? _zz_result_296 : _zz_result_297)))))));
  assign _zz_result_294 = io_a[32];
  assign _zz_result_295 = (_zz_result_30 && io_a[33]);
  assign _zz_result_296 = 7'h1e;
  assign _zz_result_297 = ((_zz_result_29 && io_a[34]) ? 7'h1d : ((_zz_result_28 && io_a[35]) ? 7'h1c : ((_zz_result_27 && io_a[36]) ? 7'h1b : ((_zz_result_26 && io_a[37]) ? 7'h1a : ((_zz_result_25 && io_a[38]) ? 7'h19 : ((_zz_result_24 && _zz_result_298) ? 7'h18 : (_zz_result_299 ? _zz_result_300 : _zz_result_301)))))));
  assign _zz_result_298 = io_a[39];
  assign _zz_result_299 = (_zz_result_23 && io_a[40]);
  assign _zz_result_300 = 7'h17;
  assign _zz_result_301 = ((_zz_result_22 && io_a[41]) ? 7'h16 : ((_zz_result_21 && io_a[42]) ? 7'h15 : ((_zz_result_20 && io_a[43]) ? 7'h14 : ((_zz_result_19 && io_a[44]) ? 7'h13 : ((_zz_result_18 && io_a[45]) ? 7'h12 : ((_zz_result_17 && _zz_result_302) ? 7'h11 : (_zz_result_303 ? _zz_result_304 : _zz_result_305)))))));
  assign _zz_result_302 = io_a[46];
  assign _zz_result_303 = (_zz_result_16 && io_a[47]);
  assign _zz_result_304 = 7'h10;
  assign _zz_result_305 = ((_zz_result_15 && io_a[48]) ? 7'h0f : ((_zz_result_14 && io_a[49]) ? 7'h0e : ((_zz_result_13 && io_a[50]) ? 7'h0d : ((_zz_result_12 && io_a[51]) ? 7'h0c : ((_zz_result_11 && io_a[52]) ? 7'h0b : ((_zz_result_10 && _zz_result_306) ? 7'h0a : (_zz_result_307 ? _zz_result_308 : _zz_result_309)))))));
  assign _zz_result_306 = io_a[53];
  assign _zz_result_307 = (_zz_result_9 && io_a[54]);
  assign _zz_result_308 = 7'h09;
  assign _zz_result_309 = ((_zz_result_8 && io_a[55]) ? 7'h08 : ((_zz_result_7 && io_a[56]) ? 7'h07 : ((_zz_result_6 && io_a[57]) ? 7'h06 : ((_zz_result_5 && io_a[58]) ? 7'h05 : ((_zz_result_4 && io_a[59]) ? 7'h04 : ((_zz_result_3 && _zz_result_310) ? 7'h03 : (_zz_result_311 ? _zz_result_312 : _zz_result_313)))))));
  assign _zz_result_310 = io_a[60];
  assign _zz_result_311 = (_zz_result_2 && io_a[61]);
  assign _zz_result_312 = 7'h02;
  assign _zz_result_313 = ((_zz_result_1 && io_a[62]) ? 7'h01 : ((_zz_result && io_a[63]) ? 7'h0 : 7'h40));
  assign _zz_result_316 = io_a[59];
  assign _zz_result_317 = (_zz_result_121 && io_a[58]);
  assign _zz_result_318 = 7'h3a;
  assign _zz_result_319 = ((_zz_result_120 && io_a[57]) ? 7'h39 : ((_zz_result_119 && io_a[56]) ? 7'h38 : ((_zz_result_118 && io_a[55]) ? 7'h37 : ((_zz_result_117 && io_a[54]) ? 7'h36 : ((_zz_result_116 && io_a[53]) ? 7'h35 : ((_zz_result_115 && _zz_result_320) ? 7'h34 : (_zz_result_321 ? _zz_result_322 : _zz_result_323)))))));
  assign _zz_result_320 = io_a[52];
  assign _zz_result_321 = (_zz_result_114 && io_a[51]);
  assign _zz_result_322 = 7'h33;
  assign _zz_result_323 = ((_zz_result_113 && io_a[50]) ? 7'h32 : ((_zz_result_112 && io_a[49]) ? 7'h31 : ((_zz_result_111 && io_a[48]) ? 7'h30 : ((_zz_result_110 && io_a[47]) ? 7'h2f : ((_zz_result_109 && io_a[46]) ? 7'h2e : ((_zz_result_108 && _zz_result_324) ? 7'h2d : (_zz_result_325 ? _zz_result_326 : _zz_result_327)))))));
  assign _zz_result_324 = io_a[45];
  assign _zz_result_325 = (_zz_result_107 && io_a[44]);
  assign _zz_result_326 = 7'h2c;
  assign _zz_result_327 = ((_zz_result_106 && io_a[43]) ? 7'h2b : ((_zz_result_105 && io_a[42]) ? 7'h2a : ((_zz_result_104 && io_a[41]) ? 7'h29 : ((_zz_result_103 && io_a[40]) ? 7'h28 : ((_zz_result_102 && io_a[39]) ? 7'h27 : ((_zz_result_101 && _zz_result_328) ? 7'h26 : (_zz_result_329 ? _zz_result_330 : _zz_result_331)))))));
  assign _zz_result_328 = io_a[38];
  assign _zz_result_329 = (_zz_result_100 && io_a[37]);
  assign _zz_result_330 = 7'h25;
  assign _zz_result_331 = ((_zz_result_99 && io_a[36]) ? 7'h24 : ((_zz_result_98 && io_a[35]) ? 7'h23 : ((_zz_result_97 && io_a[34]) ? 7'h22 : ((_zz_result_96 && io_a[33]) ? 7'h21 : ((_zz_result_95 && io_a[32]) ? 7'h20 : ((_zz_result_94 && _zz_result_332) ? 7'h1f : (_zz_result_333 ? _zz_result_334 : _zz_result_335)))))));
  assign _zz_result_332 = io_a[31];
  assign _zz_result_333 = (_zz_result_93 && io_a[30]);
  assign _zz_result_334 = 7'h1e;
  assign _zz_result_335 = ((_zz_result_92 && io_a[29]) ? 7'h1d : ((_zz_result_91 && io_a[28]) ? 7'h1c : ((_zz_result_90 && io_a[27]) ? 7'h1b : ((_zz_result_89 && io_a[26]) ? 7'h1a : ((_zz_result_88 && io_a[25]) ? 7'h19 : ((_zz_result_87 && _zz_result_336) ? 7'h18 : (_zz_result_337 ? _zz_result_338 : _zz_result_339)))))));
  assign _zz_result_336 = io_a[24];
  assign _zz_result_337 = (_zz_result_86 && io_a[23]);
  assign _zz_result_338 = 7'h17;
  assign _zz_result_339 = ((_zz_result_85 && io_a[22]) ? 7'h16 : ((_zz_result_84 && io_a[21]) ? 7'h15 : ((_zz_result_83 && io_a[20]) ? 7'h14 : ((_zz_result_82 && io_a[19]) ? 7'h13 : ((_zz_result_81 && io_a[18]) ? 7'h12 : ((_zz_result_80 && _zz_result_340) ? 7'h11 : (_zz_result_341 ? _zz_result_342 : _zz_result_343)))))));
  assign _zz_result_340 = io_a[17];
  assign _zz_result_341 = (_zz_result_79 && io_a[16]);
  assign _zz_result_342 = 7'h10;
  assign _zz_result_343 = ((_zz_result_78 && io_a[15]) ? 7'h0f : ((_zz_result_77 && io_a[14]) ? 7'h0e : ((_zz_result_76 && io_a[13]) ? 7'h0d : ((_zz_result_75 && io_a[12]) ? 7'h0c : ((_zz_result_74 && io_a[11]) ? 7'h0b : ((_zz_result_73 && _zz_result_344) ? 7'h0a : (_zz_result_345 ? _zz_result_346 : _zz_result_347)))))));
  assign _zz_result_344 = io_a[10];
  assign _zz_result_345 = (_zz_result_72 && io_a[9]);
  assign _zz_result_346 = 7'h09;
  assign _zz_result_347 = ((_zz_result_71 && io_a[8]) ? 7'h08 : ((_zz_result_70 && io_a[7]) ? 7'h07 : ((_zz_result_69 && io_a[6]) ? 7'h06 : ((_zz_result_68 && io_a[5]) ? 7'h05 : ((_zz_result_67 && io_a[4]) ? 7'h04 : ((_zz_result_66 && _zz_result_348) ? 7'h03 : (_zz_result_349 ? _zz_result_350 : _zz_result_351)))))));
  assign _zz_result_348 = io_a[3];
  assign _zz_result_349 = (_zz_result_65 && io_a[2]);
  assign _zz_result_350 = 7'h02;
  assign _zz_result_351 = ((_zz_result_64 && io_a[1]) ? 7'h01 : ((_zz_result_63 && io_a[0]) ? 7'h0 : 7'h40));
  assign _zz_result_615 = io_a[39 : 32];
  assign _zz_result_616 = (|io_a[31 : 24]);
  assign _zz_result_617 = 8'hff;
  assign _zz_result_618 = 8'h0;
  assign _zz_result_619 = ((|io_a[23 : 16]) ? 8'hff : 8'h0);
  assign _zz_result_620 = {((|io_a[15 : 8]) ? 8'hff : 8'h0),((|io_a[7 : 0]) ? 8'hff : 8'h0)};
  assign _zz__zz_result_131 = 4'b1010;
  assign _zz__zz_result_131_1 = (_zz_result_132 == 4'b1001);
  assign _zz__zz_result_131_2 = io_a[39 : 36];
  assign _zz__zz_result_131_3 = ((_zz_result_132 == 4'b1000) ? io_a[35 : 32] : ((_zz_result_132 == 4'b0111) ? io_a[31 : 28] : ((_zz_result_132 == 4'b0110) ? io_a[27 : 24] : ((_zz_result_132 == 4'b0101) ? io_a[23 : 20] : ((_zz_result_132 == 4'b0100) ? io_a[19 : 16] : ((_zz_result_132 == 4'b0011) ? io_a[15 : 12] : ((_zz_result_132 == _zz__zz_result_131_4) ? io_a[11 : 8] : (_zz__zz_result_131_5 ? _zz__zz_result_131_6 : _zz__zz_result_131_7))))))));
  assign _zz__zz_result_131_4 = 4'b0010;
  assign _zz__zz_result_131_5 = (_zz_result_132 == 4'b0001);
  assign _zz__zz_result_131_6 = io_a[7 : 4];
  assign _zz__zz_result_131_7 = ((_zz_result_132 == 4'b0000) ? io_a[3 : 0] : 4'b0000);
  assign _zz__zz_result_131_8 = 4'b1010;
  assign _zz__zz_result_131_9 = (_zz_result_133 == 4'b1001);
  assign _zz__zz_result_131_10 = io_a[39 : 36];
  assign _zz__zz_result_131_11 = ((_zz_result_133 == 4'b1000) ? io_a[35 : 32] : ((_zz_result_133 == 4'b0111) ? io_a[31 : 28] : ((_zz_result_133 == 4'b0110) ? io_a[27 : 24] : ((_zz_result_133 == 4'b0101) ? io_a[23 : 20] : ((_zz_result_133 == 4'b0100) ? io_a[19 : 16] : ((_zz_result_133 == 4'b0011) ? io_a[15 : 12] : ((_zz_result_133 == _zz__zz_result_131_12) ? io_a[11 : 8] : (_zz__zz_result_131_13 ? _zz__zz_result_131_14 : _zz__zz_result_131_15))))))));
  assign _zz__zz_result_131_12 = 4'b0010;
  assign _zz__zz_result_131_13 = (_zz_result_133 == 4'b0001);
  assign _zz__zz_result_131_14 = io_a[7 : 4];
  assign _zz__zz_result_131_15 = ((_zz_result_133 == 4'b0000) ? io_a[3 : 0] : 4'b0000);
  assign _zz__zz_result_131_16 = 4'b1010;
  assign _zz__zz_result_131_17 = (_zz_result_134 == 4'b1001);
  assign _zz__zz_result_131_18 = io_a[39 : 36];
  assign _zz__zz_result_131_19 = ((_zz_result_134 == 4'b1000) ? io_a[35 : 32] : ((_zz_result_134 == 4'b0111) ? io_a[31 : 28] : ((_zz_result_134 == 4'b0110) ? io_a[27 : 24] : ((_zz_result_134 == 4'b0101) ? io_a[23 : 20] : ((_zz_result_134 == 4'b0100) ? io_a[19 : 16] : ((_zz_result_134 == 4'b0011) ? io_a[15 : 12] : ((_zz_result_134 == _zz__zz_result_131_20) ? io_a[11 : 8] : (_zz__zz_result_131_21 ? _zz__zz_result_131_22 : _zz__zz_result_131_23))))))));
  assign _zz__zz_result_131_20 = 4'b0010;
  assign _zz__zz_result_131_21 = (_zz_result_134 == 4'b0001);
  assign _zz__zz_result_131_22 = io_a[7 : 4];
  assign _zz__zz_result_131_23 = ((_zz_result_134 == 4'b0000) ? io_a[3 : 0] : 4'b0000);
  assign _zz__zz_result_131_24 = 4'b1010;
  assign _zz__zz_result_131_25 = (_zz_result_135 == 4'b1001);
  assign _zz__zz_result_131_26 = io_a[39 : 36];
  assign _zz__zz_result_131_27 = ((_zz_result_135 == 4'b1000) ? io_a[35 : 32] : ((_zz_result_135 == 4'b0111) ? io_a[31 : 28] : ((_zz_result_135 == 4'b0110) ? io_a[27 : 24] : ((_zz_result_135 == 4'b0101) ? io_a[23 : 20] : ((_zz_result_135 == 4'b0100) ? io_a[19 : 16] : ((_zz_result_135 == 4'b0011) ? io_a[15 : 12] : ((_zz_result_135 == _zz__zz_result_131_28) ? io_a[11 : 8] : (_zz__zz_result_131_29 ? _zz__zz_result_131_30 : _zz__zz_result_131_31))))))));
  assign _zz__zz_result_131_28 = 4'b0010;
  assign _zz__zz_result_131_29 = (_zz_result_135 == 4'b0001);
  assign _zz__zz_result_131_30 = io_a[7 : 4];
  assign _zz__zz_result_131_31 = ((_zz_result_135 == 4'b0000) ? io_a[3 : 0] : 4'b0000);
  assign _zz__zz_result_131_32 = 4'b1010;
  assign _zz__zz_result_131_33 = (_zz_result_136 == 4'b1001);
  assign _zz__zz_result_131_34 = io_a[39 : 36];
  assign _zz__zz_result_131_35 = ((_zz_result_136 == 4'b1000) ? io_a[35 : 32] : ((_zz_result_136 == 4'b0111) ? io_a[31 : 28] : ((_zz_result_136 == 4'b0110) ? io_a[27 : 24] : ((_zz_result_136 == 4'b0101) ? io_a[23 : 20] : ((_zz_result_136 == 4'b0100) ? io_a[19 : 16] : ((_zz_result_136 == 4'b0011) ? io_a[15 : 12] : ((_zz_result_136 == _zz__zz_result_131_36) ? io_a[11 : 8] : (_zz__zz_result_131_37 ? _zz__zz_result_131_38 : _zz__zz_result_131_39))))))));
  assign _zz__zz_result_131_36 = 4'b0010;
  assign _zz__zz_result_131_37 = (_zz_result_136 == 4'b0001);
  assign _zz__zz_result_131_38 = io_a[7 : 4];
  assign _zz__zz_result_131_39 = ((_zz_result_136 == 4'b0000) ? io_a[3 : 0] : 4'b0000);
  assign _zz__zz_result_131_40 = 4'b1010;
  assign _zz__zz_result_131_41 = (_zz_result_137 == 4'b1001);
  assign _zz__zz_result_131_42 = io_a[39 : 36];
  assign _zz__zz_result_131_43 = ((_zz_result_137 == 4'b1000) ? io_a[35 : 32] : ((_zz_result_137 == 4'b0111) ? io_a[31 : 28] : ((_zz_result_137 == 4'b0110) ? io_a[27 : 24] : ((_zz_result_137 == 4'b0101) ? io_a[23 : 20] : ((_zz_result_137 == 4'b0100) ? io_a[19 : 16] : ((_zz_result_137 == 4'b0011) ? io_a[15 : 12] : ((_zz_result_137 == _zz__zz_result_131_44) ? io_a[11 : 8] : (_zz__zz_result_131_45 ? _zz__zz_result_131_46 : _zz__zz_result_131_47))))))));
  assign _zz__zz_result_131_44 = 4'b0010;
  assign _zz__zz_result_131_45 = (_zz_result_137 == 4'b0001);
  assign _zz__zz_result_131_46 = io_a[7 : 4];
  assign _zz__zz_result_131_47 = ((_zz_result_137 == 4'b0000) ? io_a[3 : 0] : 4'b0000);
  assign _zz__zz_result_131_48 = 4'b1010;
  assign _zz__zz_result_131_49 = (_zz_result_138 == 4'b1001);
  assign _zz__zz_result_131_50 = io_a[39 : 36];
  assign _zz__zz_result_131_51 = ((_zz_result_138 == 4'b1000) ? io_a[35 : 32] : ((_zz_result_138 == 4'b0111) ? io_a[31 : 28] : ((_zz_result_138 == 4'b0110) ? io_a[27 : 24] : ((_zz_result_138 == 4'b0101) ? io_a[23 : 20] : ((_zz_result_138 == 4'b0100) ? io_a[19 : 16] : ((_zz_result_138 == 4'b0011) ? io_a[15 : 12] : ((_zz_result_138 == _zz__zz_result_131_52) ? io_a[11 : 8] : (_zz__zz_result_131_53 ? _zz__zz_result_131_54 : _zz__zz_result_131_55))))))));
  assign _zz__zz_result_131_52 = 4'b0010;
  assign _zz__zz_result_131_53 = (_zz_result_138 == 4'b0001);
  assign _zz__zz_result_131_54 = io_a[7 : 4];
  assign _zz__zz_result_131_55 = ((_zz_result_138 == 4'b0000) ? io_a[3 : 0] : 4'b0000);
  assign _zz__zz_result_131_56 = 4'b1010;
  assign _zz__zz_result_131_57 = (_zz_result_139 == 4'b1001);
  assign _zz__zz_result_131_58 = io_a[39 : 36];
  assign _zz__zz_result_131_59 = ((_zz_result_139 == 4'b1000) ? io_a[35 : 32] : ((_zz_result_139 == 4'b0111) ? io_a[31 : 28] : ((_zz_result_139 == 4'b0110) ? io_a[27 : 24] : ((_zz_result_139 == 4'b0101) ? io_a[23 : 20] : ((_zz_result_139 == 4'b0100) ? io_a[19 : 16] : ((_zz_result_139 == 4'b0011) ? io_a[15 : 12] : ((_zz_result_139 == _zz__zz_result_131_60) ? io_a[11 : 8] : (_zz__zz_result_131_61 ? _zz__zz_result_131_62 : _zz__zz_result_131_63))))))));
  assign _zz__zz_result_131_60 = 4'b0010;
  assign _zz__zz_result_131_61 = (_zz_result_139 == 4'b0001);
  assign _zz__zz_result_131_62 = io_a[7 : 4];
  assign _zz__zz_result_131_63 = ((_zz_result_139 == 4'b0000) ? io_a[3 : 0] : 4'b0000);
  assign _zz__zz_result_131_64 = 4'b1010;
  assign _zz__zz_result_131_65 = (_zz_result_140 == 4'b1001);
  assign _zz__zz_result_131_66 = io_a[39 : 36];
  assign _zz__zz_result_131_67 = ((_zz_result_140 == 4'b1000) ? io_a[35 : 32] : ((_zz_result_140 == 4'b0111) ? io_a[31 : 28] : ((_zz_result_140 == 4'b0110) ? io_a[27 : 24] : ((_zz_result_140 == 4'b0101) ? io_a[23 : 20] : ((_zz_result_140 == 4'b0100) ? io_a[19 : 16] : ((_zz_result_140 == 4'b0011) ? io_a[15 : 12] : ((_zz_result_140 == _zz__zz_result_131_68) ? io_a[11 : 8] : (_zz__zz_result_131_69 ? _zz__zz_result_131_70 : _zz__zz_result_131_71))))))));
  assign _zz__zz_result_131_68 = 4'b0010;
  assign _zz__zz_result_131_69 = (_zz_result_140 == 4'b0001);
  assign _zz__zz_result_131_70 = io_a[7 : 4];
  assign _zz__zz_result_131_71 = ((_zz_result_140 == 4'b0000) ? io_a[3 : 0] : 4'b0000);
  assign _zz__zz_result_131_72 = 4'b1010;
  assign _zz__zz_result_131_73 = (_zz_result_141 == 4'b1001);
  assign _zz__zz_result_131_74 = io_a[39 : 36];
  assign _zz__zz_result_131_75 = ((_zz_result_141 == 4'b1000) ? io_a[35 : 32] : ((_zz_result_141 == 4'b0111) ? io_a[31 : 28] : ((_zz_result_141 == 4'b0110) ? io_a[27 : 24] : ((_zz_result_141 == 4'b0101) ? io_a[23 : 20] : ((_zz_result_141 == 4'b0100) ? io_a[19 : 16] : ((_zz_result_141 == 4'b0011) ? io_a[15 : 12] : ((_zz_result_141 == _zz__zz_result_131_76) ? io_a[11 : 8] : (_zz__zz_result_131_77 ? _zz__zz_result_131_78 : _zz__zz_result_131_79))))))));
  assign _zz__zz_result_131_76 = 4'b0010;
  assign _zz__zz_result_131_77 = (_zz_result_141 == 4'b0001);
  assign _zz__zz_result_131_78 = io_a[7 : 4];
  assign _zz__zz_result_131_79 = ((_zz_result_141 == 4'b0000) ? io_a[3 : 0] : 4'b0000);
  assign _zz__zz_result_131_80 = 4'b1010;
  assign _zz__zz_result_131_81 = (_zz_result_142 == 4'b1001);
  assign _zz__zz_result_131_82 = io_a[39 : 36];
  assign _zz__zz_result_131_83 = ((_zz_result_142 == 4'b1000) ? io_a[35 : 32] : ((_zz_result_142 == 4'b0111) ? io_a[31 : 28] : ((_zz_result_142 == 4'b0110) ? io_a[27 : 24] : ((_zz_result_142 == 4'b0101) ? io_a[23 : 20] : ((_zz_result_142 == 4'b0100) ? io_a[19 : 16] : ((_zz_result_142 == 4'b0011) ? io_a[15 : 12] : ((_zz_result_142 == _zz__zz_result_131_84) ? io_a[11 : 8] : (_zz__zz_result_131_85 ? _zz__zz_result_131_86 : _zz__zz_result_131_87))))))));
  assign _zz__zz_result_131_84 = 4'b0010;
  assign _zz__zz_result_131_85 = (_zz_result_142 == 4'b0001);
  assign _zz__zz_result_131_86 = io_a[7 : 4];
  assign _zz__zz_result_131_87 = ((_zz_result_142 == 4'b0000) ? io_a[3 : 0] : 4'b0000);
  assign _zz__zz_result_131_88 = 4'b1010;
  assign _zz__zz_result_131_89 = (_zz_result_143 == 4'b1001);
  assign _zz__zz_result_131_90 = io_a[39 : 36];
  assign _zz__zz_result_131_91 = ((_zz_result_143 == 4'b1000) ? io_a[35 : 32] : ((_zz_result_143 == 4'b0111) ? io_a[31 : 28] : ((_zz_result_143 == 4'b0110) ? io_a[27 : 24] : ((_zz_result_143 == 4'b0101) ? io_a[23 : 20] : ((_zz_result_143 == 4'b0100) ? io_a[19 : 16] : ((_zz_result_143 == 4'b0011) ? io_a[15 : 12] : ((_zz_result_143 == _zz__zz_result_131_92) ? io_a[11 : 8] : (_zz__zz_result_131_93 ? _zz__zz_result_131_94 : _zz__zz_result_131_95))))))));
  assign _zz__zz_result_131_92 = 4'b0010;
  assign _zz__zz_result_131_93 = (_zz_result_143 == 4'b0001);
  assign _zz__zz_result_131_94 = io_a[7 : 4];
  assign _zz__zz_result_131_95 = ((_zz_result_143 == 4'b0000) ? io_a[3 : 0] : 4'b0000);
  assign _zz__zz_result_131_96 = 4'b1010;
  assign _zz__zz_result_131_97 = (_zz_result_144 == 4'b1001);
  assign _zz__zz_result_131_98 = io_a[39 : 36];
  assign _zz__zz_result_131_99 = ((_zz_result_144 == 4'b1000) ? io_a[35 : 32] : ((_zz_result_144 == 4'b0111) ? io_a[31 : 28] : ((_zz_result_144 == 4'b0110) ? io_a[27 : 24] : ((_zz_result_144 == 4'b0101) ? io_a[23 : 20] : ((_zz_result_144 == 4'b0100) ? io_a[19 : 16] : ((_zz_result_144 == 4'b0011) ? io_a[15 : 12] : ((_zz_result_144 == _zz__zz_result_131_100) ? io_a[11 : 8] : (_zz__zz_result_131_101 ? _zz__zz_result_131_102 : _zz__zz_result_131_103))))))));
  assign _zz__zz_result_131_100 = 4'b0010;
  assign _zz__zz_result_131_101 = (_zz_result_144 == 4'b0001);
  assign _zz__zz_result_131_102 = io_a[7 : 4];
  assign _zz__zz_result_131_103 = ((_zz_result_144 == 4'b0000) ? io_a[3 : 0] : 4'b0000);
  assign _zz__zz_result_131_104 = 4'b1010;
  assign _zz__zz_result_131_105 = (_zz_result_145 == 4'b1001);
  assign _zz__zz_result_131_106 = io_a[39 : 36];
  assign _zz__zz_result_131_107 = ((_zz_result_145 == 4'b1000) ? io_a[35 : 32] : ((_zz_result_145 == 4'b0111) ? io_a[31 : 28] : ((_zz_result_145 == 4'b0110) ? io_a[27 : 24] : ((_zz_result_145 == 4'b0101) ? io_a[23 : 20] : ((_zz_result_145 == 4'b0100) ? io_a[19 : 16] : ((_zz_result_145 == 4'b0011) ? io_a[15 : 12] : ((_zz_result_145 == _zz__zz_result_131_108) ? io_a[11 : 8] : (_zz__zz_result_131_109 ? _zz__zz_result_131_110 : _zz__zz_result_131_111))))))));
  assign _zz__zz_result_131_108 = 4'b0010;
  assign _zz__zz_result_131_109 = (_zz_result_145 == 4'b0001);
  assign _zz__zz_result_131_110 = io_a[7 : 4];
  assign _zz__zz_result_131_111 = ((_zz_result_145 == 4'b0000) ? io_a[3 : 0] : 4'b0000);
  assign _zz__zz_result_131_112 = 4'b1010;
  assign _zz__zz_result_131_113 = (_zz_result_146 == 4'b1001);
  assign _zz__zz_result_131_114 = io_a[39 : 36];
  assign _zz__zz_result_131_115 = ((_zz_result_146 == 4'b1000) ? io_a[35 : 32] : ((_zz_result_146 == 4'b0111) ? io_a[31 : 28] : ((_zz_result_146 == 4'b0110) ? io_a[27 : 24] : ((_zz_result_146 == 4'b0101) ? io_a[23 : 20] : ((_zz_result_146 == 4'b0100) ? io_a[19 : 16] : ((_zz_result_146 == 4'b0011) ? io_a[15 : 12] : ((_zz_result_146 == _zz__zz_result_131_116) ? io_a[11 : 8] : (_zz__zz_result_131_117 ? _zz__zz_result_131_118 : _zz__zz_result_131_119))))))));
  assign _zz__zz_result_131_116 = 4'b0010;
  assign _zz__zz_result_131_117 = (_zz_result_146 == 4'b0001);
  assign _zz__zz_result_131_118 = io_a[7 : 4];
  assign _zz__zz_result_131_119 = ((_zz_result_146 == 4'b0000) ? io_a[3 : 0] : 4'b0000);
  assign _zz__zz_result_131_120 = 4'b1010;
  assign _zz__zz_result_131_121 = (_zz_result_147 == 4'b1001);
  assign _zz__zz_result_131_122 = io_a[39 : 36];
  assign _zz__zz_result_131_123 = ((_zz_result_147 == 4'b1000) ? io_a[35 : 32] : ((_zz_result_147 == 4'b0111) ? io_a[31 : 28] : ((_zz_result_147 == 4'b0110) ? io_a[27 : 24] : ((_zz_result_147 == 4'b0101) ? io_a[23 : 20] : ((_zz_result_147 == 4'b0100) ? io_a[19 : 16] : ((_zz_result_147 == 4'b0011) ? io_a[15 : 12] : ((_zz_result_147 == _zz__zz_result_131_124) ? io_a[11 : 8] : (_zz__zz_result_131_125 ? _zz__zz_result_131_126 : _zz__zz_result_131_127))))))));
  assign _zz__zz_result_131_124 = 4'b0010;
  assign _zz__zz_result_131_125 = (_zz_result_147 == 4'b0001);
  assign _zz__zz_result_131_126 = io_a[7 : 4];
  assign _zz__zz_result_131_127 = ((_zz_result_147 == 4'b0000) ? io_a[3 : 0] : 4'b0000);
  assign _zz__zz_result_148 = 8'h02;
  assign _zz__zz_result_148_1 = (_zz_result_149 == 8'h01);
  assign _zz__zz_result_148_2 = io_a[15 : 8];
  assign _zz__zz_result_148_3 = ((_zz_result_149 == 8'h0) ? io_a[7 : 0] : 8'h0);
  assign _zz__zz_result_148_4 = 8'h02;
  assign _zz__zz_result_148_5 = (_zz_result_150 == 8'h01);
  assign _zz__zz_result_148_6 = io_a[15 : 8];
  assign _zz__zz_result_148_7 = ((_zz_result_150 == 8'h0) ? io_a[7 : 0] : 8'h0);
  assign _zz__zz_result_148_8 = 8'h02;
  assign _zz__zz_result_148_9 = (_zz_result_151 == 8'h01);
  assign _zz__zz_result_148_10 = io_a[15 : 8];
  assign _zz__zz_result_148_11 = ((_zz_result_151 == 8'h0) ? io_a[7 : 0] : 8'h0);
  assign _zz__zz_result_148_12 = 8'h02;
  assign _zz__zz_result_148_13 = (_zz_result_152 == 8'h01);
  assign _zz__zz_result_148_14 = io_a[15 : 8];
  assign _zz__zz_result_148_15 = ((_zz_result_152 == 8'h0) ? io_a[7 : 0] : 8'h0);
  assign _zz__zz_result_148_16 = 8'h02;
  assign _zz__zz_result_148_17 = (_zz_result_153 == 8'h01);
  assign _zz__zz_result_148_18 = io_a[15 : 8];
  assign _zz__zz_result_148_19 = ((_zz_result_153 == 8'h0) ? io_a[7 : 0] : 8'h0);
  assign _zz__zz_result_148_20 = 8'h02;
  assign _zz__zz_result_148_21 = (_zz_result_154 == 8'h01);
  assign _zz__zz_result_148_22 = io_a[15 : 8];
  assign _zz__zz_result_148_23 = ((_zz_result_154 == 8'h0) ? io_a[7 : 0] : 8'h0);
  assign _zz__zz_result_148_24 = 8'h02;
  assign _zz__zz_result_148_25 = (_zz_result_155 == 8'h01);
  assign _zz__zz_result_148_26 = io_a[15 : 8];
  assign _zz__zz_result_148_27 = ((_zz_result_155 == 8'h0) ? io_a[7 : 0] : 8'h0);
  assign _zz__zz_result_148_28 = 8'h02;
  assign _zz__zz_result_148_29 = (_zz_result_156 == 8'h01);
  assign _zz__zz_result_148_30 = io_a[15 : 8];
  assign _zz__zz_result_148_31 = ((_zz_result_156 == 8'h0) ? io_a[7 : 0] : 8'h0);
  assign _zz_result_674 = _zz_result_157[4];
  assign _zz_result_675 = (_zz_result_184 && _zz_result_157[5]);
  assign _zz_result_676 = 6'h1a;
  assign _zz_result_677 = ((_zz_result_183 && _zz_result_157[6]) ? 6'h19 : ((_zz_result_182 && _zz_result_157[7]) ? 6'h18 : ((_zz_result_181 && _zz_result_157[8]) ? 6'h17 : ((_zz_result_180 && _zz_result_157[9]) ? 6'h16 : ((_zz_result_179 && _zz_result_157[10]) ? 6'h15 : ((_zz_result_178 && _zz_result_678) ? 6'h14 : (_zz_result_679 ? _zz_result_680 : _zz_result_681)))))));
  assign _zz_result_678 = _zz_result_157[11];
  assign _zz_result_679 = (_zz_result_177 && _zz_result_157[12]);
  assign _zz_result_680 = 6'h13;
  assign _zz_result_681 = ((_zz_result_176 && _zz_result_157[13]) ? 6'h12 : ((_zz_result_175 && _zz_result_157[14]) ? 6'h11 : ((_zz_result_174 && _zz_result_157[15]) ? 6'h10 : ((_zz_result_173 && _zz_result_157[16]) ? 6'h0f : ((_zz_result_172 && _zz_result_157[17]) ? 6'h0e : ((_zz_result_171 && _zz_result_682) ? 6'h0d : (_zz_result_683 ? _zz_result_684 : _zz_result_685)))))));
  assign _zz_result_682 = _zz_result_157[18];
  assign _zz_result_683 = (_zz_result_170 && _zz_result_157[19]);
  assign _zz_result_684 = 6'h0c;
  assign _zz_result_685 = ((_zz_result_169 && _zz_result_157[20]) ? 6'h0b : ((_zz_result_168 && _zz_result_157[21]) ? 6'h0a : ((_zz_result_167 && _zz_result_157[22]) ? 6'h09 : ((_zz_result_166 && _zz_result_157[23]) ? 6'h08 : ((_zz_result_165 && _zz_result_157[24]) ? 6'h07 : ((_zz_result_164 && _zz_result_686) ? 6'h06 : (_zz_result_687 ? _zz_result_688 : _zz_result_689)))))));
  assign _zz_result_686 = _zz_result_157[25];
  assign _zz_result_687 = (_zz_result_163 && _zz_result_157[26]);
  assign _zz_result_688 = 6'h05;
  assign _zz_result_689 = ((_zz_result_162 && _zz_result_157[27]) ? 6'h04 : ((_zz_result_161 && _zz_result_157[28]) ? 6'h03 : ((_zz_result_160 && _zz_result_157[29]) ? 6'h02 : ((_zz_result_159 && _zz_result_157[30]) ? 6'h01 : ((_zz_result_158 && _zz_result_157[31]) ? 6'h0 : 6'h20)))));
  assign _zz_result_692 = _zz_result_189[27];
  assign _zz_result_693 = (_zz_result_216 && _zz_result_189[26]);
  assign _zz_result_694 = 6'h1a;
  assign _zz_result_695 = ((_zz_result_215 && _zz_result_189[25]) ? 6'h19 : ((_zz_result_214 && _zz_result_189[24]) ? 6'h18 : ((_zz_result_213 && _zz_result_189[23]) ? 6'h17 : ((_zz_result_212 && _zz_result_189[22]) ? 6'h16 : ((_zz_result_211 && _zz_result_189[21]) ? 6'h15 : ((_zz_result_210 && _zz_result_696) ? 6'h14 : (_zz_result_697 ? _zz_result_698 : _zz_result_699)))))));
  assign _zz_result_696 = _zz_result_189[20];
  assign _zz_result_697 = (_zz_result_209 && _zz_result_189[19]);
  assign _zz_result_698 = 6'h13;
  assign _zz_result_699 = ((_zz_result_208 && _zz_result_189[18]) ? 6'h12 : ((_zz_result_207 && _zz_result_189[17]) ? 6'h11 : ((_zz_result_206 && _zz_result_189[16]) ? 6'h10 : ((_zz_result_205 && _zz_result_189[15]) ? 6'h0f : ((_zz_result_204 && _zz_result_189[14]) ? 6'h0e : ((_zz_result_203 && _zz_result_700) ? 6'h0d : (_zz_result_701 ? _zz_result_702 : _zz_result_703)))))));
  assign _zz_result_700 = _zz_result_189[13];
  assign _zz_result_701 = (_zz_result_202 && _zz_result_189[12]);
  assign _zz_result_702 = 6'h0c;
  assign _zz_result_703 = ((_zz_result_201 && _zz_result_189[11]) ? 6'h0b : ((_zz_result_200 && _zz_result_189[10]) ? 6'h0a : ((_zz_result_199 && _zz_result_189[9]) ? 6'h09 : ((_zz_result_198 && _zz_result_189[8]) ? 6'h08 : ((_zz_result_197 && _zz_result_189[7]) ? 6'h07 : ((_zz_result_196 && _zz_result_704) ? 6'h06 : (_zz_result_705 ? _zz_result_706 : _zz_result_707)))))));
  assign _zz_result_704 = _zz_result_189[6];
  assign _zz_result_705 = (_zz_result_195 && _zz_result_189[5]);
  assign _zz_result_706 = 6'h05;
  assign _zz_result_707 = ((_zz_result_194 && _zz_result_189[4]) ? 6'h04 : ((_zz_result_193 && _zz_result_189[3]) ? 6'h03 : ((_zz_result_192 && _zz_result_189[2]) ? 6'h02 : ((_zz_result_191 && _zz_result_189[1]) ? 6'h01 : ((_zz_result_190 && _zz_result_189[0]) ? 6'h0 : 6'h20)))));
  always @(*) begin
    case(_zz__zz_result_247_1)
      8'b00000000 : _zz__zz_result_247 = sm4SboxVec_0;
      8'b00000001 : _zz__zz_result_247 = sm4SboxVec_1;
      8'b00000010 : _zz__zz_result_247 = sm4SboxVec_2;
      8'b00000011 : _zz__zz_result_247 = sm4SboxVec_3;
      8'b00000100 : _zz__zz_result_247 = sm4SboxVec_4;
      8'b00000101 : _zz__zz_result_247 = sm4SboxVec_5;
      8'b00000110 : _zz__zz_result_247 = sm4SboxVec_6;
      8'b00000111 : _zz__zz_result_247 = sm4SboxVec_7;
      8'b00001000 : _zz__zz_result_247 = sm4SboxVec_8;
      8'b00001001 : _zz__zz_result_247 = sm4SboxVec_9;
      8'b00001010 : _zz__zz_result_247 = sm4SboxVec_10;
      8'b00001011 : _zz__zz_result_247 = sm4SboxVec_11;
      8'b00001100 : _zz__zz_result_247 = sm4SboxVec_12;
      8'b00001101 : _zz__zz_result_247 = sm4SboxVec_13;
      8'b00001110 : _zz__zz_result_247 = sm4SboxVec_14;
      8'b00001111 : _zz__zz_result_247 = sm4SboxVec_15;
      8'b00010000 : _zz__zz_result_247 = sm4SboxVec_16;
      8'b00010001 : _zz__zz_result_247 = sm4SboxVec_17;
      8'b00010010 : _zz__zz_result_247 = sm4SboxVec_18;
      8'b00010011 : _zz__zz_result_247 = sm4SboxVec_19;
      8'b00010100 : _zz__zz_result_247 = sm4SboxVec_20;
      8'b00010101 : _zz__zz_result_247 = sm4SboxVec_21;
      8'b00010110 : _zz__zz_result_247 = sm4SboxVec_22;
      8'b00010111 : _zz__zz_result_247 = sm4SboxVec_23;
      8'b00011000 : _zz__zz_result_247 = sm4SboxVec_24;
      8'b00011001 : _zz__zz_result_247 = sm4SboxVec_25;
      8'b00011010 : _zz__zz_result_247 = sm4SboxVec_26;
      8'b00011011 : _zz__zz_result_247 = sm4SboxVec_27;
      8'b00011100 : _zz__zz_result_247 = sm4SboxVec_28;
      8'b00011101 : _zz__zz_result_247 = sm4SboxVec_29;
      8'b00011110 : _zz__zz_result_247 = sm4SboxVec_30;
      8'b00011111 : _zz__zz_result_247 = sm4SboxVec_31;
      8'b00100000 : _zz__zz_result_247 = sm4SboxVec_32;
      8'b00100001 : _zz__zz_result_247 = sm4SboxVec_33;
      8'b00100010 : _zz__zz_result_247 = sm4SboxVec_34;
      8'b00100011 : _zz__zz_result_247 = sm4SboxVec_35;
      8'b00100100 : _zz__zz_result_247 = sm4SboxVec_36;
      8'b00100101 : _zz__zz_result_247 = sm4SboxVec_37;
      8'b00100110 : _zz__zz_result_247 = sm4SboxVec_38;
      8'b00100111 : _zz__zz_result_247 = sm4SboxVec_39;
      8'b00101000 : _zz__zz_result_247 = sm4SboxVec_40;
      8'b00101001 : _zz__zz_result_247 = sm4SboxVec_41;
      8'b00101010 : _zz__zz_result_247 = sm4SboxVec_42;
      8'b00101011 : _zz__zz_result_247 = sm4SboxVec_43;
      8'b00101100 : _zz__zz_result_247 = sm4SboxVec_44;
      8'b00101101 : _zz__zz_result_247 = sm4SboxVec_45;
      8'b00101110 : _zz__zz_result_247 = sm4SboxVec_46;
      8'b00101111 : _zz__zz_result_247 = sm4SboxVec_47;
      8'b00110000 : _zz__zz_result_247 = sm4SboxVec_48;
      8'b00110001 : _zz__zz_result_247 = sm4SboxVec_49;
      8'b00110010 : _zz__zz_result_247 = sm4SboxVec_50;
      8'b00110011 : _zz__zz_result_247 = sm4SboxVec_51;
      8'b00110100 : _zz__zz_result_247 = sm4SboxVec_52;
      8'b00110101 : _zz__zz_result_247 = sm4SboxVec_53;
      8'b00110110 : _zz__zz_result_247 = sm4SboxVec_54;
      8'b00110111 : _zz__zz_result_247 = sm4SboxVec_55;
      8'b00111000 : _zz__zz_result_247 = sm4SboxVec_56;
      8'b00111001 : _zz__zz_result_247 = sm4SboxVec_57;
      8'b00111010 : _zz__zz_result_247 = sm4SboxVec_58;
      8'b00111011 : _zz__zz_result_247 = sm4SboxVec_59;
      8'b00111100 : _zz__zz_result_247 = sm4SboxVec_60;
      8'b00111101 : _zz__zz_result_247 = sm4SboxVec_61;
      8'b00111110 : _zz__zz_result_247 = sm4SboxVec_62;
      8'b00111111 : _zz__zz_result_247 = sm4SboxVec_63;
      8'b01000000 : _zz__zz_result_247 = sm4SboxVec_64;
      8'b01000001 : _zz__zz_result_247 = sm4SboxVec_65;
      8'b01000010 : _zz__zz_result_247 = sm4SboxVec_66;
      8'b01000011 : _zz__zz_result_247 = sm4SboxVec_67;
      8'b01000100 : _zz__zz_result_247 = sm4SboxVec_68;
      8'b01000101 : _zz__zz_result_247 = sm4SboxVec_69;
      8'b01000110 : _zz__zz_result_247 = sm4SboxVec_70;
      8'b01000111 : _zz__zz_result_247 = sm4SboxVec_71;
      8'b01001000 : _zz__zz_result_247 = sm4SboxVec_72;
      8'b01001001 : _zz__zz_result_247 = sm4SboxVec_73;
      8'b01001010 : _zz__zz_result_247 = sm4SboxVec_74;
      8'b01001011 : _zz__zz_result_247 = sm4SboxVec_75;
      8'b01001100 : _zz__zz_result_247 = sm4SboxVec_76;
      8'b01001101 : _zz__zz_result_247 = sm4SboxVec_77;
      8'b01001110 : _zz__zz_result_247 = sm4SboxVec_78;
      8'b01001111 : _zz__zz_result_247 = sm4SboxVec_79;
      8'b01010000 : _zz__zz_result_247 = sm4SboxVec_80;
      8'b01010001 : _zz__zz_result_247 = sm4SboxVec_81;
      8'b01010010 : _zz__zz_result_247 = sm4SboxVec_82;
      8'b01010011 : _zz__zz_result_247 = sm4SboxVec_83;
      8'b01010100 : _zz__zz_result_247 = sm4SboxVec_84;
      8'b01010101 : _zz__zz_result_247 = sm4SboxVec_85;
      8'b01010110 : _zz__zz_result_247 = sm4SboxVec_86;
      8'b01010111 : _zz__zz_result_247 = sm4SboxVec_87;
      8'b01011000 : _zz__zz_result_247 = sm4SboxVec_88;
      8'b01011001 : _zz__zz_result_247 = sm4SboxVec_89;
      8'b01011010 : _zz__zz_result_247 = sm4SboxVec_90;
      8'b01011011 : _zz__zz_result_247 = sm4SboxVec_91;
      8'b01011100 : _zz__zz_result_247 = sm4SboxVec_92;
      8'b01011101 : _zz__zz_result_247 = sm4SboxVec_93;
      8'b01011110 : _zz__zz_result_247 = sm4SboxVec_94;
      8'b01011111 : _zz__zz_result_247 = sm4SboxVec_95;
      8'b01100000 : _zz__zz_result_247 = sm4SboxVec_96;
      8'b01100001 : _zz__zz_result_247 = sm4SboxVec_97;
      8'b01100010 : _zz__zz_result_247 = sm4SboxVec_98;
      8'b01100011 : _zz__zz_result_247 = sm4SboxVec_99;
      8'b01100100 : _zz__zz_result_247 = sm4SboxVec_100;
      8'b01100101 : _zz__zz_result_247 = sm4SboxVec_101;
      8'b01100110 : _zz__zz_result_247 = sm4SboxVec_102;
      8'b01100111 : _zz__zz_result_247 = sm4SboxVec_103;
      8'b01101000 : _zz__zz_result_247 = sm4SboxVec_104;
      8'b01101001 : _zz__zz_result_247 = sm4SboxVec_105;
      8'b01101010 : _zz__zz_result_247 = sm4SboxVec_106;
      8'b01101011 : _zz__zz_result_247 = sm4SboxVec_107;
      8'b01101100 : _zz__zz_result_247 = sm4SboxVec_108;
      8'b01101101 : _zz__zz_result_247 = sm4SboxVec_109;
      8'b01101110 : _zz__zz_result_247 = sm4SboxVec_110;
      8'b01101111 : _zz__zz_result_247 = sm4SboxVec_111;
      8'b01110000 : _zz__zz_result_247 = sm4SboxVec_112;
      8'b01110001 : _zz__zz_result_247 = sm4SboxVec_113;
      8'b01110010 : _zz__zz_result_247 = sm4SboxVec_114;
      8'b01110011 : _zz__zz_result_247 = sm4SboxVec_115;
      8'b01110100 : _zz__zz_result_247 = sm4SboxVec_116;
      8'b01110101 : _zz__zz_result_247 = sm4SboxVec_117;
      8'b01110110 : _zz__zz_result_247 = sm4SboxVec_118;
      8'b01110111 : _zz__zz_result_247 = sm4SboxVec_119;
      8'b01111000 : _zz__zz_result_247 = sm4SboxVec_120;
      8'b01111001 : _zz__zz_result_247 = sm4SboxVec_121;
      8'b01111010 : _zz__zz_result_247 = sm4SboxVec_122;
      8'b01111011 : _zz__zz_result_247 = sm4SboxVec_123;
      8'b01111100 : _zz__zz_result_247 = sm4SboxVec_124;
      8'b01111101 : _zz__zz_result_247 = sm4SboxVec_125;
      8'b01111110 : _zz__zz_result_247 = sm4SboxVec_126;
      8'b01111111 : _zz__zz_result_247 = sm4SboxVec_127;
      8'b10000000 : _zz__zz_result_247 = sm4SboxVec_128;
      8'b10000001 : _zz__zz_result_247 = sm4SboxVec_129;
      8'b10000010 : _zz__zz_result_247 = sm4SboxVec_130;
      8'b10000011 : _zz__zz_result_247 = sm4SboxVec_131;
      8'b10000100 : _zz__zz_result_247 = sm4SboxVec_132;
      8'b10000101 : _zz__zz_result_247 = sm4SboxVec_133;
      8'b10000110 : _zz__zz_result_247 = sm4SboxVec_134;
      8'b10000111 : _zz__zz_result_247 = sm4SboxVec_135;
      8'b10001000 : _zz__zz_result_247 = sm4SboxVec_136;
      8'b10001001 : _zz__zz_result_247 = sm4SboxVec_137;
      8'b10001010 : _zz__zz_result_247 = sm4SboxVec_138;
      8'b10001011 : _zz__zz_result_247 = sm4SboxVec_139;
      8'b10001100 : _zz__zz_result_247 = sm4SboxVec_140;
      8'b10001101 : _zz__zz_result_247 = sm4SboxVec_141;
      8'b10001110 : _zz__zz_result_247 = sm4SboxVec_142;
      8'b10001111 : _zz__zz_result_247 = sm4SboxVec_143;
      8'b10010000 : _zz__zz_result_247 = sm4SboxVec_144;
      8'b10010001 : _zz__zz_result_247 = sm4SboxVec_145;
      8'b10010010 : _zz__zz_result_247 = sm4SboxVec_146;
      8'b10010011 : _zz__zz_result_247 = sm4SboxVec_147;
      8'b10010100 : _zz__zz_result_247 = sm4SboxVec_148;
      8'b10010101 : _zz__zz_result_247 = sm4SboxVec_149;
      8'b10010110 : _zz__zz_result_247 = sm4SboxVec_150;
      8'b10010111 : _zz__zz_result_247 = sm4SboxVec_151;
      8'b10011000 : _zz__zz_result_247 = sm4SboxVec_152;
      8'b10011001 : _zz__zz_result_247 = sm4SboxVec_153;
      8'b10011010 : _zz__zz_result_247 = sm4SboxVec_154;
      8'b10011011 : _zz__zz_result_247 = sm4SboxVec_155;
      8'b10011100 : _zz__zz_result_247 = sm4SboxVec_156;
      8'b10011101 : _zz__zz_result_247 = sm4SboxVec_157;
      8'b10011110 : _zz__zz_result_247 = sm4SboxVec_158;
      8'b10011111 : _zz__zz_result_247 = sm4SboxVec_159;
      8'b10100000 : _zz__zz_result_247 = sm4SboxVec_160;
      8'b10100001 : _zz__zz_result_247 = sm4SboxVec_161;
      8'b10100010 : _zz__zz_result_247 = sm4SboxVec_162;
      8'b10100011 : _zz__zz_result_247 = sm4SboxVec_163;
      8'b10100100 : _zz__zz_result_247 = sm4SboxVec_164;
      8'b10100101 : _zz__zz_result_247 = sm4SboxVec_165;
      8'b10100110 : _zz__zz_result_247 = sm4SboxVec_166;
      8'b10100111 : _zz__zz_result_247 = sm4SboxVec_167;
      8'b10101000 : _zz__zz_result_247 = sm4SboxVec_168;
      8'b10101001 : _zz__zz_result_247 = sm4SboxVec_169;
      8'b10101010 : _zz__zz_result_247 = sm4SboxVec_170;
      8'b10101011 : _zz__zz_result_247 = sm4SboxVec_171;
      8'b10101100 : _zz__zz_result_247 = sm4SboxVec_172;
      8'b10101101 : _zz__zz_result_247 = sm4SboxVec_173;
      8'b10101110 : _zz__zz_result_247 = sm4SboxVec_174;
      8'b10101111 : _zz__zz_result_247 = sm4SboxVec_175;
      8'b10110000 : _zz__zz_result_247 = sm4SboxVec_176;
      8'b10110001 : _zz__zz_result_247 = sm4SboxVec_177;
      8'b10110010 : _zz__zz_result_247 = sm4SboxVec_178;
      8'b10110011 : _zz__zz_result_247 = sm4SboxVec_179;
      8'b10110100 : _zz__zz_result_247 = sm4SboxVec_180;
      8'b10110101 : _zz__zz_result_247 = sm4SboxVec_181;
      8'b10110110 : _zz__zz_result_247 = sm4SboxVec_182;
      8'b10110111 : _zz__zz_result_247 = sm4SboxVec_183;
      8'b10111000 : _zz__zz_result_247 = sm4SboxVec_184;
      8'b10111001 : _zz__zz_result_247 = sm4SboxVec_185;
      8'b10111010 : _zz__zz_result_247 = sm4SboxVec_186;
      8'b10111011 : _zz__zz_result_247 = sm4SboxVec_187;
      8'b10111100 : _zz__zz_result_247 = sm4SboxVec_188;
      8'b10111101 : _zz__zz_result_247 = sm4SboxVec_189;
      8'b10111110 : _zz__zz_result_247 = sm4SboxVec_190;
      8'b10111111 : _zz__zz_result_247 = sm4SboxVec_191;
      8'b11000000 : _zz__zz_result_247 = sm4SboxVec_192;
      8'b11000001 : _zz__zz_result_247 = sm4SboxVec_193;
      8'b11000010 : _zz__zz_result_247 = sm4SboxVec_194;
      8'b11000011 : _zz__zz_result_247 = sm4SboxVec_195;
      8'b11000100 : _zz__zz_result_247 = sm4SboxVec_196;
      8'b11000101 : _zz__zz_result_247 = sm4SboxVec_197;
      8'b11000110 : _zz__zz_result_247 = sm4SboxVec_198;
      8'b11000111 : _zz__zz_result_247 = sm4SboxVec_199;
      8'b11001000 : _zz__zz_result_247 = sm4SboxVec_200;
      8'b11001001 : _zz__zz_result_247 = sm4SboxVec_201;
      8'b11001010 : _zz__zz_result_247 = sm4SboxVec_202;
      8'b11001011 : _zz__zz_result_247 = sm4SboxVec_203;
      8'b11001100 : _zz__zz_result_247 = sm4SboxVec_204;
      8'b11001101 : _zz__zz_result_247 = sm4SboxVec_205;
      8'b11001110 : _zz__zz_result_247 = sm4SboxVec_206;
      8'b11001111 : _zz__zz_result_247 = sm4SboxVec_207;
      8'b11010000 : _zz__zz_result_247 = sm4SboxVec_208;
      8'b11010001 : _zz__zz_result_247 = sm4SboxVec_209;
      8'b11010010 : _zz__zz_result_247 = sm4SboxVec_210;
      8'b11010011 : _zz__zz_result_247 = sm4SboxVec_211;
      8'b11010100 : _zz__zz_result_247 = sm4SboxVec_212;
      8'b11010101 : _zz__zz_result_247 = sm4SboxVec_213;
      8'b11010110 : _zz__zz_result_247 = sm4SboxVec_214;
      8'b11010111 : _zz__zz_result_247 = sm4SboxVec_215;
      8'b11011000 : _zz__zz_result_247 = sm4SboxVec_216;
      8'b11011001 : _zz__zz_result_247 = sm4SboxVec_217;
      8'b11011010 : _zz__zz_result_247 = sm4SboxVec_218;
      8'b11011011 : _zz__zz_result_247 = sm4SboxVec_219;
      8'b11011100 : _zz__zz_result_247 = sm4SboxVec_220;
      8'b11011101 : _zz__zz_result_247 = sm4SboxVec_221;
      8'b11011110 : _zz__zz_result_247 = sm4SboxVec_222;
      8'b11011111 : _zz__zz_result_247 = sm4SboxVec_223;
      8'b11100000 : _zz__zz_result_247 = sm4SboxVec_224;
      8'b11100001 : _zz__zz_result_247 = sm4SboxVec_225;
      8'b11100010 : _zz__zz_result_247 = sm4SboxVec_226;
      8'b11100011 : _zz__zz_result_247 = sm4SboxVec_227;
      8'b11100100 : _zz__zz_result_247 = sm4SboxVec_228;
      8'b11100101 : _zz__zz_result_247 = sm4SboxVec_229;
      8'b11100110 : _zz__zz_result_247 = sm4SboxVec_230;
      8'b11100111 : _zz__zz_result_247 = sm4SboxVec_231;
      8'b11101000 : _zz__zz_result_247 = sm4SboxVec_232;
      8'b11101001 : _zz__zz_result_247 = sm4SboxVec_233;
      8'b11101010 : _zz__zz_result_247 = sm4SboxVec_234;
      8'b11101011 : _zz__zz_result_247 = sm4SboxVec_235;
      8'b11101100 : _zz__zz_result_247 = sm4SboxVec_236;
      8'b11101101 : _zz__zz_result_247 = sm4SboxVec_237;
      8'b11101110 : _zz__zz_result_247 = sm4SboxVec_238;
      8'b11101111 : _zz__zz_result_247 = sm4SboxVec_239;
      8'b11110000 : _zz__zz_result_247 = sm4SboxVec_240;
      8'b11110001 : _zz__zz_result_247 = sm4SboxVec_241;
      8'b11110010 : _zz__zz_result_247 = sm4SboxVec_242;
      8'b11110011 : _zz__zz_result_247 = sm4SboxVec_243;
      8'b11110100 : _zz__zz_result_247 = sm4SboxVec_244;
      8'b11110101 : _zz__zz_result_247 = sm4SboxVec_245;
      8'b11110110 : _zz__zz_result_247 = sm4SboxVec_246;
      8'b11110111 : _zz__zz_result_247 = sm4SboxVec_247;
      8'b11111000 : _zz__zz_result_247 = sm4SboxVec_248;
      8'b11111001 : _zz__zz_result_247 = sm4SboxVec_249;
      8'b11111010 : _zz__zz_result_247 = sm4SboxVec_250;
      8'b11111011 : _zz__zz_result_247 = sm4SboxVec_251;
      8'b11111100 : _zz__zz_result_247 = sm4SboxVec_252;
      8'b11111101 : _zz__zz_result_247 = sm4SboxVec_253;
      8'b11111110 : _zz__zz_result_247 = sm4SboxVec_254;
      default : _zz__zz_result_247 = sm4SboxVec_255;
    endcase
  end

  always @(*) begin
    case(_zz__zz_result_251_1)
      8'b00000000 : _zz__zz_result_251 = sm4SboxVec_0;
      8'b00000001 : _zz__zz_result_251 = sm4SboxVec_1;
      8'b00000010 : _zz__zz_result_251 = sm4SboxVec_2;
      8'b00000011 : _zz__zz_result_251 = sm4SboxVec_3;
      8'b00000100 : _zz__zz_result_251 = sm4SboxVec_4;
      8'b00000101 : _zz__zz_result_251 = sm4SboxVec_5;
      8'b00000110 : _zz__zz_result_251 = sm4SboxVec_6;
      8'b00000111 : _zz__zz_result_251 = sm4SboxVec_7;
      8'b00001000 : _zz__zz_result_251 = sm4SboxVec_8;
      8'b00001001 : _zz__zz_result_251 = sm4SboxVec_9;
      8'b00001010 : _zz__zz_result_251 = sm4SboxVec_10;
      8'b00001011 : _zz__zz_result_251 = sm4SboxVec_11;
      8'b00001100 : _zz__zz_result_251 = sm4SboxVec_12;
      8'b00001101 : _zz__zz_result_251 = sm4SboxVec_13;
      8'b00001110 : _zz__zz_result_251 = sm4SboxVec_14;
      8'b00001111 : _zz__zz_result_251 = sm4SboxVec_15;
      8'b00010000 : _zz__zz_result_251 = sm4SboxVec_16;
      8'b00010001 : _zz__zz_result_251 = sm4SboxVec_17;
      8'b00010010 : _zz__zz_result_251 = sm4SboxVec_18;
      8'b00010011 : _zz__zz_result_251 = sm4SboxVec_19;
      8'b00010100 : _zz__zz_result_251 = sm4SboxVec_20;
      8'b00010101 : _zz__zz_result_251 = sm4SboxVec_21;
      8'b00010110 : _zz__zz_result_251 = sm4SboxVec_22;
      8'b00010111 : _zz__zz_result_251 = sm4SboxVec_23;
      8'b00011000 : _zz__zz_result_251 = sm4SboxVec_24;
      8'b00011001 : _zz__zz_result_251 = sm4SboxVec_25;
      8'b00011010 : _zz__zz_result_251 = sm4SboxVec_26;
      8'b00011011 : _zz__zz_result_251 = sm4SboxVec_27;
      8'b00011100 : _zz__zz_result_251 = sm4SboxVec_28;
      8'b00011101 : _zz__zz_result_251 = sm4SboxVec_29;
      8'b00011110 : _zz__zz_result_251 = sm4SboxVec_30;
      8'b00011111 : _zz__zz_result_251 = sm4SboxVec_31;
      8'b00100000 : _zz__zz_result_251 = sm4SboxVec_32;
      8'b00100001 : _zz__zz_result_251 = sm4SboxVec_33;
      8'b00100010 : _zz__zz_result_251 = sm4SboxVec_34;
      8'b00100011 : _zz__zz_result_251 = sm4SboxVec_35;
      8'b00100100 : _zz__zz_result_251 = sm4SboxVec_36;
      8'b00100101 : _zz__zz_result_251 = sm4SboxVec_37;
      8'b00100110 : _zz__zz_result_251 = sm4SboxVec_38;
      8'b00100111 : _zz__zz_result_251 = sm4SboxVec_39;
      8'b00101000 : _zz__zz_result_251 = sm4SboxVec_40;
      8'b00101001 : _zz__zz_result_251 = sm4SboxVec_41;
      8'b00101010 : _zz__zz_result_251 = sm4SboxVec_42;
      8'b00101011 : _zz__zz_result_251 = sm4SboxVec_43;
      8'b00101100 : _zz__zz_result_251 = sm4SboxVec_44;
      8'b00101101 : _zz__zz_result_251 = sm4SboxVec_45;
      8'b00101110 : _zz__zz_result_251 = sm4SboxVec_46;
      8'b00101111 : _zz__zz_result_251 = sm4SboxVec_47;
      8'b00110000 : _zz__zz_result_251 = sm4SboxVec_48;
      8'b00110001 : _zz__zz_result_251 = sm4SboxVec_49;
      8'b00110010 : _zz__zz_result_251 = sm4SboxVec_50;
      8'b00110011 : _zz__zz_result_251 = sm4SboxVec_51;
      8'b00110100 : _zz__zz_result_251 = sm4SboxVec_52;
      8'b00110101 : _zz__zz_result_251 = sm4SboxVec_53;
      8'b00110110 : _zz__zz_result_251 = sm4SboxVec_54;
      8'b00110111 : _zz__zz_result_251 = sm4SboxVec_55;
      8'b00111000 : _zz__zz_result_251 = sm4SboxVec_56;
      8'b00111001 : _zz__zz_result_251 = sm4SboxVec_57;
      8'b00111010 : _zz__zz_result_251 = sm4SboxVec_58;
      8'b00111011 : _zz__zz_result_251 = sm4SboxVec_59;
      8'b00111100 : _zz__zz_result_251 = sm4SboxVec_60;
      8'b00111101 : _zz__zz_result_251 = sm4SboxVec_61;
      8'b00111110 : _zz__zz_result_251 = sm4SboxVec_62;
      8'b00111111 : _zz__zz_result_251 = sm4SboxVec_63;
      8'b01000000 : _zz__zz_result_251 = sm4SboxVec_64;
      8'b01000001 : _zz__zz_result_251 = sm4SboxVec_65;
      8'b01000010 : _zz__zz_result_251 = sm4SboxVec_66;
      8'b01000011 : _zz__zz_result_251 = sm4SboxVec_67;
      8'b01000100 : _zz__zz_result_251 = sm4SboxVec_68;
      8'b01000101 : _zz__zz_result_251 = sm4SboxVec_69;
      8'b01000110 : _zz__zz_result_251 = sm4SboxVec_70;
      8'b01000111 : _zz__zz_result_251 = sm4SboxVec_71;
      8'b01001000 : _zz__zz_result_251 = sm4SboxVec_72;
      8'b01001001 : _zz__zz_result_251 = sm4SboxVec_73;
      8'b01001010 : _zz__zz_result_251 = sm4SboxVec_74;
      8'b01001011 : _zz__zz_result_251 = sm4SboxVec_75;
      8'b01001100 : _zz__zz_result_251 = sm4SboxVec_76;
      8'b01001101 : _zz__zz_result_251 = sm4SboxVec_77;
      8'b01001110 : _zz__zz_result_251 = sm4SboxVec_78;
      8'b01001111 : _zz__zz_result_251 = sm4SboxVec_79;
      8'b01010000 : _zz__zz_result_251 = sm4SboxVec_80;
      8'b01010001 : _zz__zz_result_251 = sm4SboxVec_81;
      8'b01010010 : _zz__zz_result_251 = sm4SboxVec_82;
      8'b01010011 : _zz__zz_result_251 = sm4SboxVec_83;
      8'b01010100 : _zz__zz_result_251 = sm4SboxVec_84;
      8'b01010101 : _zz__zz_result_251 = sm4SboxVec_85;
      8'b01010110 : _zz__zz_result_251 = sm4SboxVec_86;
      8'b01010111 : _zz__zz_result_251 = sm4SboxVec_87;
      8'b01011000 : _zz__zz_result_251 = sm4SboxVec_88;
      8'b01011001 : _zz__zz_result_251 = sm4SboxVec_89;
      8'b01011010 : _zz__zz_result_251 = sm4SboxVec_90;
      8'b01011011 : _zz__zz_result_251 = sm4SboxVec_91;
      8'b01011100 : _zz__zz_result_251 = sm4SboxVec_92;
      8'b01011101 : _zz__zz_result_251 = sm4SboxVec_93;
      8'b01011110 : _zz__zz_result_251 = sm4SboxVec_94;
      8'b01011111 : _zz__zz_result_251 = sm4SboxVec_95;
      8'b01100000 : _zz__zz_result_251 = sm4SboxVec_96;
      8'b01100001 : _zz__zz_result_251 = sm4SboxVec_97;
      8'b01100010 : _zz__zz_result_251 = sm4SboxVec_98;
      8'b01100011 : _zz__zz_result_251 = sm4SboxVec_99;
      8'b01100100 : _zz__zz_result_251 = sm4SboxVec_100;
      8'b01100101 : _zz__zz_result_251 = sm4SboxVec_101;
      8'b01100110 : _zz__zz_result_251 = sm4SboxVec_102;
      8'b01100111 : _zz__zz_result_251 = sm4SboxVec_103;
      8'b01101000 : _zz__zz_result_251 = sm4SboxVec_104;
      8'b01101001 : _zz__zz_result_251 = sm4SboxVec_105;
      8'b01101010 : _zz__zz_result_251 = sm4SboxVec_106;
      8'b01101011 : _zz__zz_result_251 = sm4SboxVec_107;
      8'b01101100 : _zz__zz_result_251 = sm4SboxVec_108;
      8'b01101101 : _zz__zz_result_251 = sm4SboxVec_109;
      8'b01101110 : _zz__zz_result_251 = sm4SboxVec_110;
      8'b01101111 : _zz__zz_result_251 = sm4SboxVec_111;
      8'b01110000 : _zz__zz_result_251 = sm4SboxVec_112;
      8'b01110001 : _zz__zz_result_251 = sm4SboxVec_113;
      8'b01110010 : _zz__zz_result_251 = sm4SboxVec_114;
      8'b01110011 : _zz__zz_result_251 = sm4SboxVec_115;
      8'b01110100 : _zz__zz_result_251 = sm4SboxVec_116;
      8'b01110101 : _zz__zz_result_251 = sm4SboxVec_117;
      8'b01110110 : _zz__zz_result_251 = sm4SboxVec_118;
      8'b01110111 : _zz__zz_result_251 = sm4SboxVec_119;
      8'b01111000 : _zz__zz_result_251 = sm4SboxVec_120;
      8'b01111001 : _zz__zz_result_251 = sm4SboxVec_121;
      8'b01111010 : _zz__zz_result_251 = sm4SboxVec_122;
      8'b01111011 : _zz__zz_result_251 = sm4SboxVec_123;
      8'b01111100 : _zz__zz_result_251 = sm4SboxVec_124;
      8'b01111101 : _zz__zz_result_251 = sm4SboxVec_125;
      8'b01111110 : _zz__zz_result_251 = sm4SboxVec_126;
      8'b01111111 : _zz__zz_result_251 = sm4SboxVec_127;
      8'b10000000 : _zz__zz_result_251 = sm4SboxVec_128;
      8'b10000001 : _zz__zz_result_251 = sm4SboxVec_129;
      8'b10000010 : _zz__zz_result_251 = sm4SboxVec_130;
      8'b10000011 : _zz__zz_result_251 = sm4SboxVec_131;
      8'b10000100 : _zz__zz_result_251 = sm4SboxVec_132;
      8'b10000101 : _zz__zz_result_251 = sm4SboxVec_133;
      8'b10000110 : _zz__zz_result_251 = sm4SboxVec_134;
      8'b10000111 : _zz__zz_result_251 = sm4SboxVec_135;
      8'b10001000 : _zz__zz_result_251 = sm4SboxVec_136;
      8'b10001001 : _zz__zz_result_251 = sm4SboxVec_137;
      8'b10001010 : _zz__zz_result_251 = sm4SboxVec_138;
      8'b10001011 : _zz__zz_result_251 = sm4SboxVec_139;
      8'b10001100 : _zz__zz_result_251 = sm4SboxVec_140;
      8'b10001101 : _zz__zz_result_251 = sm4SboxVec_141;
      8'b10001110 : _zz__zz_result_251 = sm4SboxVec_142;
      8'b10001111 : _zz__zz_result_251 = sm4SboxVec_143;
      8'b10010000 : _zz__zz_result_251 = sm4SboxVec_144;
      8'b10010001 : _zz__zz_result_251 = sm4SboxVec_145;
      8'b10010010 : _zz__zz_result_251 = sm4SboxVec_146;
      8'b10010011 : _zz__zz_result_251 = sm4SboxVec_147;
      8'b10010100 : _zz__zz_result_251 = sm4SboxVec_148;
      8'b10010101 : _zz__zz_result_251 = sm4SboxVec_149;
      8'b10010110 : _zz__zz_result_251 = sm4SboxVec_150;
      8'b10010111 : _zz__zz_result_251 = sm4SboxVec_151;
      8'b10011000 : _zz__zz_result_251 = sm4SboxVec_152;
      8'b10011001 : _zz__zz_result_251 = sm4SboxVec_153;
      8'b10011010 : _zz__zz_result_251 = sm4SboxVec_154;
      8'b10011011 : _zz__zz_result_251 = sm4SboxVec_155;
      8'b10011100 : _zz__zz_result_251 = sm4SboxVec_156;
      8'b10011101 : _zz__zz_result_251 = sm4SboxVec_157;
      8'b10011110 : _zz__zz_result_251 = sm4SboxVec_158;
      8'b10011111 : _zz__zz_result_251 = sm4SboxVec_159;
      8'b10100000 : _zz__zz_result_251 = sm4SboxVec_160;
      8'b10100001 : _zz__zz_result_251 = sm4SboxVec_161;
      8'b10100010 : _zz__zz_result_251 = sm4SboxVec_162;
      8'b10100011 : _zz__zz_result_251 = sm4SboxVec_163;
      8'b10100100 : _zz__zz_result_251 = sm4SboxVec_164;
      8'b10100101 : _zz__zz_result_251 = sm4SboxVec_165;
      8'b10100110 : _zz__zz_result_251 = sm4SboxVec_166;
      8'b10100111 : _zz__zz_result_251 = sm4SboxVec_167;
      8'b10101000 : _zz__zz_result_251 = sm4SboxVec_168;
      8'b10101001 : _zz__zz_result_251 = sm4SboxVec_169;
      8'b10101010 : _zz__zz_result_251 = sm4SboxVec_170;
      8'b10101011 : _zz__zz_result_251 = sm4SboxVec_171;
      8'b10101100 : _zz__zz_result_251 = sm4SboxVec_172;
      8'b10101101 : _zz__zz_result_251 = sm4SboxVec_173;
      8'b10101110 : _zz__zz_result_251 = sm4SboxVec_174;
      8'b10101111 : _zz__zz_result_251 = sm4SboxVec_175;
      8'b10110000 : _zz__zz_result_251 = sm4SboxVec_176;
      8'b10110001 : _zz__zz_result_251 = sm4SboxVec_177;
      8'b10110010 : _zz__zz_result_251 = sm4SboxVec_178;
      8'b10110011 : _zz__zz_result_251 = sm4SboxVec_179;
      8'b10110100 : _zz__zz_result_251 = sm4SboxVec_180;
      8'b10110101 : _zz__zz_result_251 = sm4SboxVec_181;
      8'b10110110 : _zz__zz_result_251 = sm4SboxVec_182;
      8'b10110111 : _zz__zz_result_251 = sm4SboxVec_183;
      8'b10111000 : _zz__zz_result_251 = sm4SboxVec_184;
      8'b10111001 : _zz__zz_result_251 = sm4SboxVec_185;
      8'b10111010 : _zz__zz_result_251 = sm4SboxVec_186;
      8'b10111011 : _zz__zz_result_251 = sm4SboxVec_187;
      8'b10111100 : _zz__zz_result_251 = sm4SboxVec_188;
      8'b10111101 : _zz__zz_result_251 = sm4SboxVec_189;
      8'b10111110 : _zz__zz_result_251 = sm4SboxVec_190;
      8'b10111111 : _zz__zz_result_251 = sm4SboxVec_191;
      8'b11000000 : _zz__zz_result_251 = sm4SboxVec_192;
      8'b11000001 : _zz__zz_result_251 = sm4SboxVec_193;
      8'b11000010 : _zz__zz_result_251 = sm4SboxVec_194;
      8'b11000011 : _zz__zz_result_251 = sm4SboxVec_195;
      8'b11000100 : _zz__zz_result_251 = sm4SboxVec_196;
      8'b11000101 : _zz__zz_result_251 = sm4SboxVec_197;
      8'b11000110 : _zz__zz_result_251 = sm4SboxVec_198;
      8'b11000111 : _zz__zz_result_251 = sm4SboxVec_199;
      8'b11001000 : _zz__zz_result_251 = sm4SboxVec_200;
      8'b11001001 : _zz__zz_result_251 = sm4SboxVec_201;
      8'b11001010 : _zz__zz_result_251 = sm4SboxVec_202;
      8'b11001011 : _zz__zz_result_251 = sm4SboxVec_203;
      8'b11001100 : _zz__zz_result_251 = sm4SboxVec_204;
      8'b11001101 : _zz__zz_result_251 = sm4SboxVec_205;
      8'b11001110 : _zz__zz_result_251 = sm4SboxVec_206;
      8'b11001111 : _zz__zz_result_251 = sm4SboxVec_207;
      8'b11010000 : _zz__zz_result_251 = sm4SboxVec_208;
      8'b11010001 : _zz__zz_result_251 = sm4SboxVec_209;
      8'b11010010 : _zz__zz_result_251 = sm4SboxVec_210;
      8'b11010011 : _zz__zz_result_251 = sm4SboxVec_211;
      8'b11010100 : _zz__zz_result_251 = sm4SboxVec_212;
      8'b11010101 : _zz__zz_result_251 = sm4SboxVec_213;
      8'b11010110 : _zz__zz_result_251 = sm4SboxVec_214;
      8'b11010111 : _zz__zz_result_251 = sm4SboxVec_215;
      8'b11011000 : _zz__zz_result_251 = sm4SboxVec_216;
      8'b11011001 : _zz__zz_result_251 = sm4SboxVec_217;
      8'b11011010 : _zz__zz_result_251 = sm4SboxVec_218;
      8'b11011011 : _zz__zz_result_251 = sm4SboxVec_219;
      8'b11011100 : _zz__zz_result_251 = sm4SboxVec_220;
      8'b11011101 : _zz__zz_result_251 = sm4SboxVec_221;
      8'b11011110 : _zz__zz_result_251 = sm4SboxVec_222;
      8'b11011111 : _zz__zz_result_251 = sm4SboxVec_223;
      8'b11100000 : _zz__zz_result_251 = sm4SboxVec_224;
      8'b11100001 : _zz__zz_result_251 = sm4SboxVec_225;
      8'b11100010 : _zz__zz_result_251 = sm4SboxVec_226;
      8'b11100011 : _zz__zz_result_251 = sm4SboxVec_227;
      8'b11100100 : _zz__zz_result_251 = sm4SboxVec_228;
      8'b11100101 : _zz__zz_result_251 = sm4SboxVec_229;
      8'b11100110 : _zz__zz_result_251 = sm4SboxVec_230;
      8'b11100111 : _zz__zz_result_251 = sm4SboxVec_231;
      8'b11101000 : _zz__zz_result_251 = sm4SboxVec_232;
      8'b11101001 : _zz__zz_result_251 = sm4SboxVec_233;
      8'b11101010 : _zz__zz_result_251 = sm4SboxVec_234;
      8'b11101011 : _zz__zz_result_251 = sm4SboxVec_235;
      8'b11101100 : _zz__zz_result_251 = sm4SboxVec_236;
      8'b11101101 : _zz__zz_result_251 = sm4SboxVec_237;
      8'b11101110 : _zz__zz_result_251 = sm4SboxVec_238;
      8'b11101111 : _zz__zz_result_251 = sm4SboxVec_239;
      8'b11110000 : _zz__zz_result_251 = sm4SboxVec_240;
      8'b11110001 : _zz__zz_result_251 = sm4SboxVec_241;
      8'b11110010 : _zz__zz_result_251 = sm4SboxVec_242;
      8'b11110011 : _zz__zz_result_251 = sm4SboxVec_243;
      8'b11110100 : _zz__zz_result_251 = sm4SboxVec_244;
      8'b11110101 : _zz__zz_result_251 = sm4SboxVec_245;
      8'b11110110 : _zz__zz_result_251 = sm4SboxVec_246;
      8'b11110111 : _zz__zz_result_251 = sm4SboxVec_247;
      8'b11111000 : _zz__zz_result_251 = sm4SboxVec_248;
      8'b11111001 : _zz__zz_result_251 = sm4SboxVec_249;
      8'b11111010 : _zz__zz_result_251 = sm4SboxVec_250;
      8'b11111011 : _zz__zz_result_251 = sm4SboxVec_251;
      8'b11111100 : _zz__zz_result_251 = sm4SboxVec_252;
      8'b11111101 : _zz__zz_result_251 = sm4SboxVec_253;
      8'b11111110 : _zz__zz_result_251 = sm4SboxVec_254;
      default : _zz__zz_result_251 = sm4SboxVec_255;
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(io_op)
      AluOp_ADD : io_op_string = "ADD        ";
      AluOp_SUB : io_op_string = "SUB        ";
      AluOp_SLL_1 : io_op_string = "SLL_1      ";
      AluOp_SLT : io_op_string = "SLT        ";
      AluOp_SLTU : io_op_string = "SLTU       ";
      AluOp_XOR_1 : io_op_string = "XOR_1      ";
      AluOp_SRL_1 : io_op_string = "SRL_1      ";
      AluOp_SRA_1 : io_op_string = "SRA_1      ";
      AluOp_OR_1 : io_op_string = "OR_1       ";
      AluOp_AND_1 : io_op_string = "AND_1      ";
      AluOp_ADDW : io_op_string = "ADDW       ";
      AluOp_SUBW : io_op_string = "SUBW       ";
      AluOp_SLLW : io_op_string = "SLLW       ";
      AluOp_SRLW : io_op_string = "SRLW       ";
      AluOp_SRAW : io_op_string = "SRAW       ";
      AluOp_MUL : io_op_string = "MUL        ";
      AluOp_MULH : io_op_string = "MULH       ";
      AluOp_MULHSU : io_op_string = "MULHSU     ";
      AluOp_MULHU : io_op_string = "MULHU      ";
      AluOp_DIV : io_op_string = "DIV        ";
      AluOp_DIVU : io_op_string = "DIVU       ";
      AluOp_REM_1 : io_op_string = "REM_1      ";
      AluOp_REMU : io_op_string = "REMU       ";
      AluOp_MULW : io_op_string = "MULW       ";
      AluOp_DIVW : io_op_string = "DIVW       ";
      AluOp_DIVUW : io_op_string = "DIVUW      ";
      AluOp_REMW : io_op_string = "REMW       ";
      AluOp_REMUW : io_op_string = "REMUW      ";
      AluOp_ANDN : io_op_string = "ANDN       ";
      AluOp_ORN : io_op_string = "ORN        ";
      AluOp_XNOR_1 : io_op_string = "XNOR_1     ";
      AluOp_CLZ : io_op_string = "CLZ        ";
      AluOp_CTZ : io_op_string = "CTZ        ";
      AluOp_CPOP : io_op_string = "CPOP       ";
      AluOp_SEXTB : io_op_string = "SEXTB      ";
      AluOp_SEXTH : io_op_string = "SEXTH      ";
      AluOp_ZEXTH : io_op_string = "ZEXTH      ";
      AluOp_ORCB : io_op_string = "ORCB       ";
      AluOp_REV8 : io_op_string = "REV8       ";
      AluOp_ROL_1 : io_op_string = "ROL_1      ";
      AluOp_ROR_1 : io_op_string = "ROR_1      ";
      AluOp_MIN : io_op_string = "MIN        ";
      AluOp_MINU : io_op_string = "MINU       ";
      AluOp_MAX : io_op_string = "MAX        ";
      AluOp_MAXU : io_op_string = "MAXU       ";
      AluOp_BSET : io_op_string = "BSET       ";
      AluOp_BCLR : io_op_string = "BCLR       ";
      AluOp_BINV : io_op_string = "BINV       ";
      AluOp_BEXT : io_op_string = "BEXT       ";
      AluOp_SH1ADD : io_op_string = "SH1ADD     ";
      AluOp_SH2ADD : io_op_string = "SH2ADD     ";
      AluOp_SH3ADD : io_op_string = "SH3ADD     ";
      AluOp_ADDUW : io_op_string = "ADDUW      ";
      AluOp_SH1ADDUW : io_op_string = "SH1ADDUW   ";
      AluOp_SH2ADDUW : io_op_string = "SH2ADDUW   ";
      AluOp_SH3ADDUW : io_op_string = "SH3ADDUW   ";
      AluOp_SLLIUW : io_op_string = "SLLIUW     ";
      AluOp_CLMUL : io_op_string = "CLMUL      ";
      AluOp_CLMULH : io_op_string = "CLMULH     ";
      AluOp_CLMULR : io_op_string = "CLMULR     ";
      AluOp_PACK : io_op_string = "PACK       ";
      AluOp_PACKH : io_op_string = "PACKH      ";
      AluOp_PACKW : io_op_string = "PACKW      ";
      AluOp_BREV8 : io_op_string = "BREV8      ";
      AluOp_ZIP : io_op_string = "ZIP        ";
      AluOp_UNZIP : io_op_string = "UNZIP      ";
      AluOp_XPERM4 : io_op_string = "XPERM4     ";
      AluOp_XPERM8 : io_op_string = "XPERM8     ";
      AluOp_CLZW : io_op_string = "CLZW       ";
      AluOp_CTZW : io_op_string = "CTZW       ";
      AluOp_CPOPW : io_op_string = "CPOPW      ";
      AluOp_ROLW : io_op_string = "ROLW       ";
      AluOp_RORW : io_op_string = "RORW       ";
      AluOp_SHA256SUM0 : io_op_string = "SHA256SUM0 ";
      AluOp_SHA256SUM1 : io_op_string = "SHA256SUM1 ";
      AluOp_SHA256SIG0 : io_op_string = "SHA256SIG0 ";
      AluOp_SHA256SIG1 : io_op_string = "SHA256SIG1 ";
      AluOp_SHA512SUM0 : io_op_string = "SHA512SUM0 ";
      AluOp_SHA512SUM1 : io_op_string = "SHA512SUM1 ";
      AluOp_SHA512SIG0 : io_op_string = "SHA512SIG0 ";
      AluOp_SHA512SIG1 : io_op_string = "SHA512SIG1 ";
      AluOp_SHA512SUM0R : io_op_string = "SHA512SUM0R";
      AluOp_SHA512SUM1R : io_op_string = "SHA512SUM1R";
      AluOp_SHA512SIG0L : io_op_string = "SHA512SIG0L";
      AluOp_SHA512SIG0H : io_op_string = "SHA512SIG0H";
      AluOp_SHA512SIG1L : io_op_string = "SHA512SIG1L";
      AluOp_SHA512SIG1H : io_op_string = "SHA512SIG1H";
      AluOp_SM3P0 : io_op_string = "SM3P0      ";
      AluOp_SM3P1 : io_op_string = "SM3P1      ";
      AluOp_SM4ED : io_op_string = "SM4ED      ";
      AluOp_SM4KS : io_op_string = "SM4KS      ";
      default : io_op_string = "???????????";
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
  assign sm4SboxVec_0 = 8'hd6;
  assign sm4SboxVec_1 = 8'h90;
  assign sm4SboxVec_2 = 8'he9;
  assign sm4SboxVec_3 = 8'hfe;
  assign sm4SboxVec_4 = 8'hcc;
  assign sm4SboxVec_5 = 8'he1;
  assign sm4SboxVec_6 = 8'h3d;
  assign sm4SboxVec_7 = 8'hb7;
  assign sm4SboxVec_8 = 8'h16;
  assign sm4SboxVec_9 = 8'hb6;
  assign sm4SboxVec_10 = 8'h14;
  assign sm4SboxVec_11 = 8'hc2;
  assign sm4SboxVec_12 = 8'h28;
  assign sm4SboxVec_13 = 8'hfb;
  assign sm4SboxVec_14 = 8'h2c;
  assign sm4SboxVec_15 = 8'h05;
  assign sm4SboxVec_16 = 8'h2b;
  assign sm4SboxVec_17 = 8'h67;
  assign sm4SboxVec_18 = 8'h9a;
  assign sm4SboxVec_19 = 8'h76;
  assign sm4SboxVec_20 = 8'h2a;
  assign sm4SboxVec_21 = 8'hbe;
  assign sm4SboxVec_22 = 8'h04;
  assign sm4SboxVec_23 = 8'hc3;
  assign sm4SboxVec_24 = 8'haa;
  assign sm4SboxVec_25 = 8'h44;
  assign sm4SboxVec_26 = 8'h13;
  assign sm4SboxVec_27 = 8'h26;
  assign sm4SboxVec_28 = 8'h49;
  assign sm4SboxVec_29 = 8'h86;
  assign sm4SboxVec_30 = 8'h06;
  assign sm4SboxVec_31 = 8'h99;
  assign sm4SboxVec_32 = 8'h9c;
  assign sm4SboxVec_33 = 8'h42;
  assign sm4SboxVec_34 = 8'h50;
  assign sm4SboxVec_35 = 8'hf4;
  assign sm4SboxVec_36 = 8'h91;
  assign sm4SboxVec_37 = 8'hef;
  assign sm4SboxVec_38 = 8'h98;
  assign sm4SboxVec_39 = 8'h7a;
  assign sm4SboxVec_40 = 8'h33;
  assign sm4SboxVec_41 = 8'h54;
  assign sm4SboxVec_42 = 8'h0b;
  assign sm4SboxVec_43 = 8'h43;
  assign sm4SboxVec_44 = 8'hed;
  assign sm4SboxVec_45 = 8'hcf;
  assign sm4SboxVec_46 = 8'hac;
  assign sm4SboxVec_47 = 8'h62;
  assign sm4SboxVec_48 = 8'he4;
  assign sm4SboxVec_49 = 8'hb3;
  assign sm4SboxVec_50 = 8'h1c;
  assign sm4SboxVec_51 = 8'ha9;
  assign sm4SboxVec_52 = 8'hc9;
  assign sm4SboxVec_53 = 8'h08;
  assign sm4SboxVec_54 = 8'he8;
  assign sm4SboxVec_55 = 8'h95;
  assign sm4SboxVec_56 = 8'h80;
  assign sm4SboxVec_57 = 8'hdf;
  assign sm4SboxVec_58 = 8'h94;
  assign sm4SboxVec_59 = 8'hfa;
  assign sm4SboxVec_60 = 8'h75;
  assign sm4SboxVec_61 = 8'h8f;
  assign sm4SboxVec_62 = 8'h3f;
  assign sm4SboxVec_63 = 8'ha6;
  assign sm4SboxVec_64 = 8'h47;
  assign sm4SboxVec_65 = 8'h07;
  assign sm4SboxVec_66 = 8'ha7;
  assign sm4SboxVec_67 = 8'hfc;
  assign sm4SboxVec_68 = 8'hf3;
  assign sm4SboxVec_69 = 8'h73;
  assign sm4SboxVec_70 = 8'h17;
  assign sm4SboxVec_71 = 8'hba;
  assign sm4SboxVec_72 = 8'h83;
  assign sm4SboxVec_73 = 8'h59;
  assign sm4SboxVec_74 = 8'h3c;
  assign sm4SboxVec_75 = 8'h19;
  assign sm4SboxVec_76 = 8'he6;
  assign sm4SboxVec_77 = 8'h85;
  assign sm4SboxVec_78 = 8'h4f;
  assign sm4SboxVec_79 = 8'ha8;
  assign sm4SboxVec_80 = 8'h68;
  assign sm4SboxVec_81 = 8'h6b;
  assign sm4SboxVec_82 = 8'h81;
  assign sm4SboxVec_83 = 8'hb2;
  assign sm4SboxVec_84 = 8'h71;
  assign sm4SboxVec_85 = 8'h64;
  assign sm4SboxVec_86 = 8'hda;
  assign sm4SboxVec_87 = 8'h8b;
  assign sm4SboxVec_88 = 8'hf8;
  assign sm4SboxVec_89 = 8'heb;
  assign sm4SboxVec_90 = 8'h0f;
  assign sm4SboxVec_91 = 8'h4b;
  assign sm4SboxVec_92 = 8'h70;
  assign sm4SboxVec_93 = 8'h56;
  assign sm4SboxVec_94 = 8'h9d;
  assign sm4SboxVec_95 = 8'h35;
  assign sm4SboxVec_96 = 8'h1e;
  assign sm4SboxVec_97 = 8'h24;
  assign sm4SboxVec_98 = 8'h0e;
  assign sm4SboxVec_99 = 8'h5e;
  assign sm4SboxVec_100 = 8'h63;
  assign sm4SboxVec_101 = 8'h58;
  assign sm4SboxVec_102 = 8'hd1;
  assign sm4SboxVec_103 = 8'ha2;
  assign sm4SboxVec_104 = 8'h25;
  assign sm4SboxVec_105 = 8'h22;
  assign sm4SboxVec_106 = 8'h7c;
  assign sm4SboxVec_107 = 8'h3b;
  assign sm4SboxVec_108 = 8'h01;
  assign sm4SboxVec_109 = 8'h21;
  assign sm4SboxVec_110 = 8'h78;
  assign sm4SboxVec_111 = 8'h87;
  assign sm4SboxVec_112 = 8'hd4;
  assign sm4SboxVec_113 = 8'h0;
  assign sm4SboxVec_114 = 8'h46;
  assign sm4SboxVec_115 = 8'h57;
  assign sm4SboxVec_116 = 8'h9f;
  assign sm4SboxVec_117 = 8'hd3;
  assign sm4SboxVec_118 = 8'h27;
  assign sm4SboxVec_119 = 8'h52;
  assign sm4SboxVec_120 = 8'h4c;
  assign sm4SboxVec_121 = 8'h36;
  assign sm4SboxVec_122 = 8'h02;
  assign sm4SboxVec_123 = 8'he7;
  assign sm4SboxVec_124 = 8'ha0;
  assign sm4SboxVec_125 = 8'hc4;
  assign sm4SboxVec_126 = 8'hc8;
  assign sm4SboxVec_127 = 8'h9e;
  assign sm4SboxVec_128 = 8'hea;
  assign sm4SboxVec_129 = 8'hbf;
  assign sm4SboxVec_130 = 8'h8a;
  assign sm4SboxVec_131 = 8'hd2;
  assign sm4SboxVec_132 = 8'h40;
  assign sm4SboxVec_133 = 8'hc7;
  assign sm4SboxVec_134 = 8'h38;
  assign sm4SboxVec_135 = 8'hb5;
  assign sm4SboxVec_136 = 8'ha3;
  assign sm4SboxVec_137 = 8'hf7;
  assign sm4SboxVec_138 = 8'hf2;
  assign sm4SboxVec_139 = 8'hce;
  assign sm4SboxVec_140 = 8'hf9;
  assign sm4SboxVec_141 = 8'h61;
  assign sm4SboxVec_142 = 8'h15;
  assign sm4SboxVec_143 = 8'ha1;
  assign sm4SboxVec_144 = 8'he0;
  assign sm4SboxVec_145 = 8'hae;
  assign sm4SboxVec_146 = 8'h5d;
  assign sm4SboxVec_147 = 8'ha4;
  assign sm4SboxVec_148 = 8'h9b;
  assign sm4SboxVec_149 = 8'h34;
  assign sm4SboxVec_150 = 8'h1a;
  assign sm4SboxVec_151 = 8'h55;
  assign sm4SboxVec_152 = 8'had;
  assign sm4SboxVec_153 = 8'h93;
  assign sm4SboxVec_154 = 8'h32;
  assign sm4SboxVec_155 = 8'h30;
  assign sm4SboxVec_156 = 8'hf5;
  assign sm4SboxVec_157 = 8'h8c;
  assign sm4SboxVec_158 = 8'hb1;
  assign sm4SboxVec_159 = 8'he3;
  assign sm4SboxVec_160 = 8'h1d;
  assign sm4SboxVec_161 = 8'hf6;
  assign sm4SboxVec_162 = 8'he2;
  assign sm4SboxVec_163 = 8'h2e;
  assign sm4SboxVec_164 = 8'h82;
  assign sm4SboxVec_165 = 8'h66;
  assign sm4SboxVec_166 = 8'hca;
  assign sm4SboxVec_167 = 8'h60;
  assign sm4SboxVec_168 = 8'hc0;
  assign sm4SboxVec_169 = 8'h29;
  assign sm4SboxVec_170 = 8'h23;
  assign sm4SboxVec_171 = 8'hab;
  assign sm4SboxVec_172 = 8'h0d;
  assign sm4SboxVec_173 = 8'h53;
  assign sm4SboxVec_174 = 8'h4e;
  assign sm4SboxVec_175 = 8'h6f;
  assign sm4SboxVec_176 = 8'hd5;
  assign sm4SboxVec_177 = 8'hdb;
  assign sm4SboxVec_178 = 8'h37;
  assign sm4SboxVec_179 = 8'h45;
  assign sm4SboxVec_180 = 8'hde;
  assign sm4SboxVec_181 = 8'hfd;
  assign sm4SboxVec_182 = 8'h8e;
  assign sm4SboxVec_183 = 8'h2f;
  assign sm4SboxVec_184 = 8'h03;
  assign sm4SboxVec_185 = 8'hff;
  assign sm4SboxVec_186 = 8'h6a;
  assign sm4SboxVec_187 = 8'h72;
  assign sm4SboxVec_188 = 8'h6d;
  assign sm4SboxVec_189 = 8'h6c;
  assign sm4SboxVec_190 = 8'h5b;
  assign sm4SboxVec_191 = 8'h51;
  assign sm4SboxVec_192 = 8'h8d;
  assign sm4SboxVec_193 = 8'h1b;
  assign sm4SboxVec_194 = 8'haf;
  assign sm4SboxVec_195 = 8'h92;
  assign sm4SboxVec_196 = 8'hbb;
  assign sm4SboxVec_197 = 8'hdd;
  assign sm4SboxVec_198 = 8'hbc;
  assign sm4SboxVec_199 = 8'h7f;
  assign sm4SboxVec_200 = 8'h11;
  assign sm4SboxVec_201 = 8'hd9;
  assign sm4SboxVec_202 = 8'h5c;
  assign sm4SboxVec_203 = 8'h41;
  assign sm4SboxVec_204 = 8'h1f;
  assign sm4SboxVec_205 = 8'h10;
  assign sm4SboxVec_206 = 8'h5a;
  assign sm4SboxVec_207 = 8'hd8;
  assign sm4SboxVec_208 = 8'h0a;
  assign sm4SboxVec_209 = 8'hc1;
  assign sm4SboxVec_210 = 8'h31;
  assign sm4SboxVec_211 = 8'h88;
  assign sm4SboxVec_212 = 8'ha5;
  assign sm4SboxVec_213 = 8'hcd;
  assign sm4SboxVec_214 = 8'h7b;
  assign sm4SboxVec_215 = 8'hbd;
  assign sm4SboxVec_216 = 8'h2d;
  assign sm4SboxVec_217 = 8'h74;
  assign sm4SboxVec_218 = 8'hd0;
  assign sm4SboxVec_219 = 8'h12;
  assign sm4SboxVec_220 = 8'hb8;
  assign sm4SboxVec_221 = 8'he5;
  assign sm4SboxVec_222 = 8'hb4;
  assign sm4SboxVec_223 = 8'hb0;
  assign sm4SboxVec_224 = 8'h89;
  assign sm4SboxVec_225 = 8'h69;
  assign sm4SboxVec_226 = 8'h97;
  assign sm4SboxVec_227 = 8'h4a;
  assign sm4SboxVec_228 = 8'h0c;
  assign sm4SboxVec_229 = 8'h96;
  assign sm4SboxVec_230 = 8'h77;
  assign sm4SboxVec_231 = 8'h7e;
  assign sm4SboxVec_232 = 8'h65;
  assign sm4SboxVec_233 = 8'hb9;
  assign sm4SboxVec_234 = 8'hf1;
  assign sm4SboxVec_235 = 8'h09;
  assign sm4SboxVec_236 = 8'hc5;
  assign sm4SboxVec_237 = 8'h6e;
  assign sm4SboxVec_238 = 8'hc6;
  assign sm4SboxVec_239 = 8'h84;
  assign sm4SboxVec_240 = 8'h18;
  assign sm4SboxVec_241 = 8'hf0;
  assign sm4SboxVec_242 = 8'h7d;
  assign sm4SboxVec_243 = 8'hec;
  assign sm4SboxVec_244 = 8'h3a;
  assign sm4SboxVec_245 = 8'hdc;
  assign sm4SboxVec_246 = 8'h4d;
  assign sm4SboxVec_247 = 8'h20;
  assign sm4SboxVec_248 = 8'h79;
  assign sm4SboxVec_249 = 8'hee;
  assign sm4SboxVec_250 = 8'h5f;
  assign sm4SboxVec_251 = 8'h3e;
  assign sm4SboxVec_252 = 8'hd7;
  assign sm4SboxVec_253 = 8'hcb;
  assign sm4SboxVec_254 = 8'h39;
  assign sm4SboxVec_255 = 8'h48;
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
        result = _zz_result_254;
      end
      AluOp_SUB : begin
        result = _zz_result_255;
      end
      AluOp_SLL_1 : begin
        result = _zz_result_256;
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
        result = _zz_result_258;
      end
      AluOp_SRA_1 : begin
        result = _zz_result_259;
      end
      AluOp_OR_1 : begin
        result = (io_a | io_b);
      end
      AluOp_AND_1 : begin
        result = (io_a & io_b);
      end
      AluOp_ADDW : begin
        result = _zz_result_260;
      end
      AluOp_SUBW : begin
        result = _zz_result_262;
      end
      AluOp_SLLW : begin
        result = _zz_result_264;
      end
      AluOp_SRLW : begin
        result = _zz_result_268;
      end
      AluOp_SRAW : begin
        result = _zz_result_271;
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
        result = _zz_result_273;
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
        result = _zz_result_276;
      end
      AluOp_CTZ : begin
        result = _zz_result_314;
      end
      AluOp_CPOP : begin
        result = _zz_result_352;
      end
      AluOp_SEXTB : begin
        result = _zz_result_609;
      end
      AluOp_SEXTH : begin
        result = _zz_result_611;
      end
      AluOp_ZEXTH : begin
        result = _zz_result_613;
      end
      AluOp_ORCB : begin
        result = {((|io_a[63 : 56]) ? 8'hff : 8'h0),{((|io_a[55 : 48]) ? 8'hff : 8'h0),{((|io_a[47 : 40]) ? 8'hff : 8'h0),{((|_zz_result_615) ? 8'hff : 8'h0),{(_zz_result_616 ? _zz_result_617 : _zz_result_618),{_zz_result_619,_zz_result_620}}}}}};
      end
      AluOp_REV8 : begin
        result = {io_a[7 : 0],{io_a[15 : 8],{io_a[23 : 16],{io_a[31 : 24],{io_a[39 : 32],{io_a[47 : 40],{io_a[55 : 48],io_a[63 : 56]}}}}}}};
      end
      AluOp_ROL_1 : begin
        result = ((shamt == 6'h0) ? aU : (_zz_result_621 | _zz_result_624));
      end
      AluOp_ROR_1 : begin
        result = ((shamt == 6'h0) ? aU : (_zz_result_626 | _zz_result_627));
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
        result = _zz_result_630;
      end
      AluOp_SH2ADD : begin
        result = _zz_result_634;
      end
      AluOp_SH3ADD : begin
        result = _zz_result_638;
      end
      AluOp_ADDUW : begin
        result = _zz_result_642;
      end
      AluOp_SH1ADDUW : begin
        result = _zz_result_643;
      end
      AluOp_SH2ADDUW : begin
        result = _zz_result_647;
      end
      AluOp_SH3ADDUW : begin
        result = _zz_result_651;
      end
      AluOp_SLLIUW : begin
        result = _zz_result_655;
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
      AluOp_PACK : begin
        result = (_zz_result_657 | _zz_result_658);
      end
      AluOp_PACKH : begin
        result = (_zz_result_660 | _zz_result_662);
      end
      AluOp_PACKW : begin
        result = _zz_result_664;
      end
      AluOp_BREV8 : begin
        result = _zz_result_128;
      end
      AluOp_ZIP : begin
        result = _zz_result_129;
      end
      AluOp_UNZIP : begin
        result = _zz_result_130;
      end
      AluOp_XPERM4 : begin
        result = _zz_result_131;
      end
      AluOp_XPERM8 : begin
        result = _zz_result_148;
      end
      AluOp_CLZW : begin
        result = _zz_result_672;
      end
      AluOp_CTZW : begin
        result = _zz_result_690;
      end
      AluOp_CPOPW : begin
        result = _zz_result_708;
      end
      AluOp_ROLW : begin
        result = _zz_result_837;
      end
      AluOp_RORW : begin
        result = _zz_result_844;
      end
      AluOp_SHA256SUM0 : begin
        result = _zz_result_850;
      end
      AluOp_SHA256SUM1 : begin
        result = _zz_result_864;
      end
      AluOp_SHA256SIG0 : begin
        result = _zz_result_878;
      end
      AluOp_SHA256SIG1 : begin
        result = _zz_result_890;
      end
      AluOp_SHA512SUM0 : begin
        result = (((_zz_result_902 | _zz_result_904) ^ (_zz_result_906 | _zz_result_908)) ^ (_zz_result_910 | _zz_result_912));
      end
      AluOp_SHA512SUM1 : begin
        result = (((_zz_result_914 | _zz_result_916) ^ (_zz_result_918 | _zz_result_920)) ^ (_zz_result_922 | _zz_result_924));
      end
      AluOp_SHA512SIG0 : begin
        result = (((_zz_result_926 | _zz_result_928) ^ (_zz_result_930 | _zz_result_932)) ^ _zz_result_934);
      end
      AluOp_SHA512SIG1 : begin
        result = (((_zz_result_936 | _zz_result_938) ^ (_zz_result_940 | _zz_result_942)) ^ _zz_result_944);
      end
      AluOp_SHA512SUM0R : begin
        result = _zz_result_946;
      end
      AluOp_SHA512SUM1R : begin
        result = _zz_result_960;
      end
      AluOp_SHA512SIG0L : begin
        result = _zz_result_974;
      end
      AluOp_SHA512SIG0H : begin
        result = _zz_result_988;
      end
      AluOp_SHA512SIG1L : begin
        result = _zz_result_1000;
      end
      AluOp_SHA512SIG1H : begin
        result = _zz_result_1014;
      end
      AluOp_SM3P0 : begin
        result = _zz_result_1026;
      end
      AluOp_SM3P1 : begin
        result = _zz_result_1036;
      end
      AluOp_SM4ED : begin
        result = _zz_result_1046;
      end
      default : begin
        result = _zz_result_1054;
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
  always @(*) begin
    _zz_result_128[0] = io_a[7];
    _zz_result_128[1] = io_a[6];
    _zz_result_128[2] = io_a[5];
    _zz_result_128[3] = io_a[4];
    _zz_result_128[4] = io_a[3];
    _zz_result_128[5] = io_a[2];
    _zz_result_128[6] = io_a[1];
    _zz_result_128[7] = io_a[0];
    _zz_result_128[8] = io_a[15];
    _zz_result_128[9] = io_a[14];
    _zz_result_128[10] = io_a[13];
    _zz_result_128[11] = io_a[12];
    _zz_result_128[12] = io_a[11];
    _zz_result_128[13] = io_a[10];
    _zz_result_128[14] = io_a[9];
    _zz_result_128[15] = io_a[8];
    _zz_result_128[16] = io_a[23];
    _zz_result_128[17] = io_a[22];
    _zz_result_128[18] = io_a[21];
    _zz_result_128[19] = io_a[20];
    _zz_result_128[20] = io_a[19];
    _zz_result_128[21] = io_a[18];
    _zz_result_128[22] = io_a[17];
    _zz_result_128[23] = io_a[16];
    _zz_result_128[24] = io_a[31];
    _zz_result_128[25] = io_a[30];
    _zz_result_128[26] = io_a[29];
    _zz_result_128[27] = io_a[28];
    _zz_result_128[28] = io_a[27];
    _zz_result_128[29] = io_a[26];
    _zz_result_128[30] = io_a[25];
    _zz_result_128[31] = io_a[24];
    _zz_result_128[32] = io_a[39];
    _zz_result_128[33] = io_a[38];
    _zz_result_128[34] = io_a[37];
    _zz_result_128[35] = io_a[36];
    _zz_result_128[36] = io_a[35];
    _zz_result_128[37] = io_a[34];
    _zz_result_128[38] = io_a[33];
    _zz_result_128[39] = io_a[32];
    _zz_result_128[40] = io_a[47];
    _zz_result_128[41] = io_a[46];
    _zz_result_128[42] = io_a[45];
    _zz_result_128[43] = io_a[44];
    _zz_result_128[44] = io_a[43];
    _zz_result_128[45] = io_a[42];
    _zz_result_128[46] = io_a[41];
    _zz_result_128[47] = io_a[40];
    _zz_result_128[48] = io_a[55];
    _zz_result_128[49] = io_a[54];
    _zz_result_128[50] = io_a[53];
    _zz_result_128[51] = io_a[52];
    _zz_result_128[52] = io_a[51];
    _zz_result_128[53] = io_a[50];
    _zz_result_128[54] = io_a[49];
    _zz_result_128[55] = io_a[48];
    _zz_result_128[56] = io_a[63];
    _zz_result_128[57] = io_a[62];
    _zz_result_128[58] = io_a[61];
    _zz_result_128[59] = io_a[60];
    _zz_result_128[60] = io_a[59];
    _zz_result_128[61] = io_a[58];
    _zz_result_128[62] = io_a[57];
    _zz_result_128[63] = io_a[56];
  end

  always @(*) begin
    _zz_result_129[0] = io_a[0];
    _zz_result_129[1] = io_a[32];
    _zz_result_129[2] = io_a[1];
    _zz_result_129[3] = io_a[33];
    _zz_result_129[4] = io_a[2];
    _zz_result_129[5] = io_a[34];
    _zz_result_129[6] = io_a[3];
    _zz_result_129[7] = io_a[35];
    _zz_result_129[8] = io_a[4];
    _zz_result_129[9] = io_a[36];
    _zz_result_129[10] = io_a[5];
    _zz_result_129[11] = io_a[37];
    _zz_result_129[12] = io_a[6];
    _zz_result_129[13] = io_a[38];
    _zz_result_129[14] = io_a[7];
    _zz_result_129[15] = io_a[39];
    _zz_result_129[16] = io_a[8];
    _zz_result_129[17] = io_a[40];
    _zz_result_129[18] = io_a[9];
    _zz_result_129[19] = io_a[41];
    _zz_result_129[20] = io_a[10];
    _zz_result_129[21] = io_a[42];
    _zz_result_129[22] = io_a[11];
    _zz_result_129[23] = io_a[43];
    _zz_result_129[24] = io_a[12];
    _zz_result_129[25] = io_a[44];
    _zz_result_129[26] = io_a[13];
    _zz_result_129[27] = io_a[45];
    _zz_result_129[28] = io_a[14];
    _zz_result_129[29] = io_a[46];
    _zz_result_129[30] = io_a[15];
    _zz_result_129[31] = io_a[47];
    _zz_result_129[32] = io_a[16];
    _zz_result_129[33] = io_a[48];
    _zz_result_129[34] = io_a[17];
    _zz_result_129[35] = io_a[49];
    _zz_result_129[36] = io_a[18];
    _zz_result_129[37] = io_a[50];
    _zz_result_129[38] = io_a[19];
    _zz_result_129[39] = io_a[51];
    _zz_result_129[40] = io_a[20];
    _zz_result_129[41] = io_a[52];
    _zz_result_129[42] = io_a[21];
    _zz_result_129[43] = io_a[53];
    _zz_result_129[44] = io_a[22];
    _zz_result_129[45] = io_a[54];
    _zz_result_129[46] = io_a[23];
    _zz_result_129[47] = io_a[55];
    _zz_result_129[48] = io_a[24];
    _zz_result_129[49] = io_a[56];
    _zz_result_129[50] = io_a[25];
    _zz_result_129[51] = io_a[57];
    _zz_result_129[52] = io_a[26];
    _zz_result_129[53] = io_a[58];
    _zz_result_129[54] = io_a[27];
    _zz_result_129[55] = io_a[59];
    _zz_result_129[56] = io_a[28];
    _zz_result_129[57] = io_a[60];
    _zz_result_129[58] = io_a[29];
    _zz_result_129[59] = io_a[61];
    _zz_result_129[60] = io_a[30];
    _zz_result_129[61] = io_a[62];
    _zz_result_129[62] = io_a[31];
    _zz_result_129[63] = io_a[63];
  end

  always @(*) begin
    _zz_result_130[0] = io_a[0];
    _zz_result_130[32] = io_a[1];
    _zz_result_130[1] = io_a[2];
    _zz_result_130[33] = io_a[3];
    _zz_result_130[2] = io_a[4];
    _zz_result_130[34] = io_a[5];
    _zz_result_130[3] = io_a[6];
    _zz_result_130[35] = io_a[7];
    _zz_result_130[4] = io_a[8];
    _zz_result_130[36] = io_a[9];
    _zz_result_130[5] = io_a[10];
    _zz_result_130[37] = io_a[11];
    _zz_result_130[6] = io_a[12];
    _zz_result_130[38] = io_a[13];
    _zz_result_130[7] = io_a[14];
    _zz_result_130[39] = io_a[15];
    _zz_result_130[8] = io_a[16];
    _zz_result_130[40] = io_a[17];
    _zz_result_130[9] = io_a[18];
    _zz_result_130[41] = io_a[19];
    _zz_result_130[10] = io_a[20];
    _zz_result_130[42] = io_a[21];
    _zz_result_130[11] = io_a[22];
    _zz_result_130[43] = io_a[23];
    _zz_result_130[12] = io_a[24];
    _zz_result_130[44] = io_a[25];
    _zz_result_130[13] = io_a[26];
    _zz_result_130[45] = io_a[27];
    _zz_result_130[14] = io_a[28];
    _zz_result_130[46] = io_a[29];
    _zz_result_130[15] = io_a[30];
    _zz_result_130[47] = io_a[31];
    _zz_result_130[16] = io_a[32];
    _zz_result_130[48] = io_a[33];
    _zz_result_130[17] = io_a[34];
    _zz_result_130[49] = io_a[35];
    _zz_result_130[18] = io_a[36];
    _zz_result_130[50] = io_a[37];
    _zz_result_130[19] = io_a[38];
    _zz_result_130[51] = io_a[39];
    _zz_result_130[20] = io_a[40];
    _zz_result_130[52] = io_a[41];
    _zz_result_130[21] = io_a[42];
    _zz_result_130[53] = io_a[43];
    _zz_result_130[22] = io_a[44];
    _zz_result_130[54] = io_a[45];
    _zz_result_130[23] = io_a[46];
    _zz_result_130[55] = io_a[47];
    _zz_result_130[24] = io_a[48];
    _zz_result_130[56] = io_a[49];
    _zz_result_130[25] = io_a[50];
    _zz_result_130[57] = io_a[51];
    _zz_result_130[26] = io_a[52];
    _zz_result_130[58] = io_a[53];
    _zz_result_130[27] = io_a[54];
    _zz_result_130[59] = io_a[55];
    _zz_result_130[28] = io_a[56];
    _zz_result_130[60] = io_a[57];
    _zz_result_130[29] = io_a[58];
    _zz_result_130[61] = io_a[59];
    _zz_result_130[30] = io_a[60];
    _zz_result_130[62] = io_a[61];
    _zz_result_130[31] = io_a[62];
    _zz_result_130[63] = io_a[63];
  end

  assign _zz_result_132 = io_b[3 : 0];
  always @(*) begin
    _zz_result_131[3 : 0] = ((_zz_result_132 == 4'b1111) ? io_a[63 : 60] : ((_zz_result_132 == 4'b1110) ? io_a[59 : 56] : ((_zz_result_132 == 4'b1101) ? io_a[55 : 52] : ((_zz_result_132 == 4'b1100) ? io_a[51 : 48] : ((_zz_result_132 == 4'b1011) ? io_a[47 : 44] : ((_zz_result_132 == _zz__zz_result_131) ? io_a[43 : 40] : (_zz__zz_result_131_1 ? _zz__zz_result_131_2 : _zz__zz_result_131_3)))))));
    _zz_result_131[7 : 4] = ((_zz_result_133 == 4'b1111) ? io_a[63 : 60] : ((_zz_result_133 == 4'b1110) ? io_a[59 : 56] : ((_zz_result_133 == 4'b1101) ? io_a[55 : 52] : ((_zz_result_133 == 4'b1100) ? io_a[51 : 48] : ((_zz_result_133 == 4'b1011) ? io_a[47 : 44] : ((_zz_result_133 == _zz__zz_result_131_8) ? io_a[43 : 40] : (_zz__zz_result_131_9 ? _zz__zz_result_131_10 : _zz__zz_result_131_11)))))));
    _zz_result_131[11 : 8] = ((_zz_result_134 == 4'b1111) ? io_a[63 : 60] : ((_zz_result_134 == 4'b1110) ? io_a[59 : 56] : ((_zz_result_134 == 4'b1101) ? io_a[55 : 52] : ((_zz_result_134 == 4'b1100) ? io_a[51 : 48] : ((_zz_result_134 == 4'b1011) ? io_a[47 : 44] : ((_zz_result_134 == _zz__zz_result_131_16) ? io_a[43 : 40] : (_zz__zz_result_131_17 ? _zz__zz_result_131_18 : _zz__zz_result_131_19)))))));
    _zz_result_131[15 : 12] = ((_zz_result_135 == 4'b1111) ? io_a[63 : 60] : ((_zz_result_135 == 4'b1110) ? io_a[59 : 56] : ((_zz_result_135 == 4'b1101) ? io_a[55 : 52] : ((_zz_result_135 == 4'b1100) ? io_a[51 : 48] : ((_zz_result_135 == 4'b1011) ? io_a[47 : 44] : ((_zz_result_135 == _zz__zz_result_131_24) ? io_a[43 : 40] : (_zz__zz_result_131_25 ? _zz__zz_result_131_26 : _zz__zz_result_131_27)))))));
    _zz_result_131[19 : 16] = ((_zz_result_136 == 4'b1111) ? io_a[63 : 60] : ((_zz_result_136 == 4'b1110) ? io_a[59 : 56] : ((_zz_result_136 == 4'b1101) ? io_a[55 : 52] : ((_zz_result_136 == 4'b1100) ? io_a[51 : 48] : ((_zz_result_136 == 4'b1011) ? io_a[47 : 44] : ((_zz_result_136 == _zz__zz_result_131_32) ? io_a[43 : 40] : (_zz__zz_result_131_33 ? _zz__zz_result_131_34 : _zz__zz_result_131_35)))))));
    _zz_result_131[23 : 20] = ((_zz_result_137 == 4'b1111) ? io_a[63 : 60] : ((_zz_result_137 == 4'b1110) ? io_a[59 : 56] : ((_zz_result_137 == 4'b1101) ? io_a[55 : 52] : ((_zz_result_137 == 4'b1100) ? io_a[51 : 48] : ((_zz_result_137 == 4'b1011) ? io_a[47 : 44] : ((_zz_result_137 == _zz__zz_result_131_40) ? io_a[43 : 40] : (_zz__zz_result_131_41 ? _zz__zz_result_131_42 : _zz__zz_result_131_43)))))));
    _zz_result_131[27 : 24] = ((_zz_result_138 == 4'b1111) ? io_a[63 : 60] : ((_zz_result_138 == 4'b1110) ? io_a[59 : 56] : ((_zz_result_138 == 4'b1101) ? io_a[55 : 52] : ((_zz_result_138 == 4'b1100) ? io_a[51 : 48] : ((_zz_result_138 == 4'b1011) ? io_a[47 : 44] : ((_zz_result_138 == _zz__zz_result_131_48) ? io_a[43 : 40] : (_zz__zz_result_131_49 ? _zz__zz_result_131_50 : _zz__zz_result_131_51)))))));
    _zz_result_131[31 : 28] = ((_zz_result_139 == 4'b1111) ? io_a[63 : 60] : ((_zz_result_139 == 4'b1110) ? io_a[59 : 56] : ((_zz_result_139 == 4'b1101) ? io_a[55 : 52] : ((_zz_result_139 == 4'b1100) ? io_a[51 : 48] : ((_zz_result_139 == 4'b1011) ? io_a[47 : 44] : ((_zz_result_139 == _zz__zz_result_131_56) ? io_a[43 : 40] : (_zz__zz_result_131_57 ? _zz__zz_result_131_58 : _zz__zz_result_131_59)))))));
    _zz_result_131[35 : 32] = ((_zz_result_140 == 4'b1111) ? io_a[63 : 60] : ((_zz_result_140 == 4'b1110) ? io_a[59 : 56] : ((_zz_result_140 == 4'b1101) ? io_a[55 : 52] : ((_zz_result_140 == 4'b1100) ? io_a[51 : 48] : ((_zz_result_140 == 4'b1011) ? io_a[47 : 44] : ((_zz_result_140 == _zz__zz_result_131_64) ? io_a[43 : 40] : (_zz__zz_result_131_65 ? _zz__zz_result_131_66 : _zz__zz_result_131_67)))))));
    _zz_result_131[39 : 36] = ((_zz_result_141 == 4'b1111) ? io_a[63 : 60] : ((_zz_result_141 == 4'b1110) ? io_a[59 : 56] : ((_zz_result_141 == 4'b1101) ? io_a[55 : 52] : ((_zz_result_141 == 4'b1100) ? io_a[51 : 48] : ((_zz_result_141 == 4'b1011) ? io_a[47 : 44] : ((_zz_result_141 == _zz__zz_result_131_72) ? io_a[43 : 40] : (_zz__zz_result_131_73 ? _zz__zz_result_131_74 : _zz__zz_result_131_75)))))));
    _zz_result_131[43 : 40] = ((_zz_result_142 == 4'b1111) ? io_a[63 : 60] : ((_zz_result_142 == 4'b1110) ? io_a[59 : 56] : ((_zz_result_142 == 4'b1101) ? io_a[55 : 52] : ((_zz_result_142 == 4'b1100) ? io_a[51 : 48] : ((_zz_result_142 == 4'b1011) ? io_a[47 : 44] : ((_zz_result_142 == _zz__zz_result_131_80) ? io_a[43 : 40] : (_zz__zz_result_131_81 ? _zz__zz_result_131_82 : _zz__zz_result_131_83)))))));
    _zz_result_131[47 : 44] = ((_zz_result_143 == 4'b1111) ? io_a[63 : 60] : ((_zz_result_143 == 4'b1110) ? io_a[59 : 56] : ((_zz_result_143 == 4'b1101) ? io_a[55 : 52] : ((_zz_result_143 == 4'b1100) ? io_a[51 : 48] : ((_zz_result_143 == 4'b1011) ? io_a[47 : 44] : ((_zz_result_143 == _zz__zz_result_131_88) ? io_a[43 : 40] : (_zz__zz_result_131_89 ? _zz__zz_result_131_90 : _zz__zz_result_131_91)))))));
    _zz_result_131[51 : 48] = ((_zz_result_144 == 4'b1111) ? io_a[63 : 60] : ((_zz_result_144 == 4'b1110) ? io_a[59 : 56] : ((_zz_result_144 == 4'b1101) ? io_a[55 : 52] : ((_zz_result_144 == 4'b1100) ? io_a[51 : 48] : ((_zz_result_144 == 4'b1011) ? io_a[47 : 44] : ((_zz_result_144 == _zz__zz_result_131_96) ? io_a[43 : 40] : (_zz__zz_result_131_97 ? _zz__zz_result_131_98 : _zz__zz_result_131_99)))))));
    _zz_result_131[55 : 52] = ((_zz_result_145 == 4'b1111) ? io_a[63 : 60] : ((_zz_result_145 == 4'b1110) ? io_a[59 : 56] : ((_zz_result_145 == 4'b1101) ? io_a[55 : 52] : ((_zz_result_145 == 4'b1100) ? io_a[51 : 48] : ((_zz_result_145 == 4'b1011) ? io_a[47 : 44] : ((_zz_result_145 == _zz__zz_result_131_104) ? io_a[43 : 40] : (_zz__zz_result_131_105 ? _zz__zz_result_131_106 : _zz__zz_result_131_107)))))));
    _zz_result_131[59 : 56] = ((_zz_result_146 == 4'b1111) ? io_a[63 : 60] : ((_zz_result_146 == 4'b1110) ? io_a[59 : 56] : ((_zz_result_146 == 4'b1101) ? io_a[55 : 52] : ((_zz_result_146 == 4'b1100) ? io_a[51 : 48] : ((_zz_result_146 == 4'b1011) ? io_a[47 : 44] : ((_zz_result_146 == _zz__zz_result_131_112) ? io_a[43 : 40] : (_zz__zz_result_131_113 ? _zz__zz_result_131_114 : _zz__zz_result_131_115)))))));
    _zz_result_131[63 : 60] = ((_zz_result_147 == 4'b1111) ? io_a[63 : 60] : ((_zz_result_147 == 4'b1110) ? io_a[59 : 56] : ((_zz_result_147 == 4'b1101) ? io_a[55 : 52] : ((_zz_result_147 == 4'b1100) ? io_a[51 : 48] : ((_zz_result_147 == 4'b1011) ? io_a[47 : 44] : ((_zz_result_147 == _zz__zz_result_131_120) ? io_a[43 : 40] : (_zz__zz_result_131_121 ? _zz__zz_result_131_122 : _zz__zz_result_131_123)))))));
  end

  assign _zz_result_133 = io_b[7 : 4];
  assign _zz_result_134 = io_b[11 : 8];
  assign _zz_result_135 = io_b[15 : 12];
  assign _zz_result_136 = io_b[19 : 16];
  assign _zz_result_137 = io_b[23 : 20];
  assign _zz_result_138 = io_b[27 : 24];
  assign _zz_result_139 = io_b[31 : 28];
  assign _zz_result_140 = io_b[35 : 32];
  assign _zz_result_141 = io_b[39 : 36];
  assign _zz_result_142 = io_b[43 : 40];
  assign _zz_result_143 = io_b[47 : 44];
  assign _zz_result_144 = io_b[51 : 48];
  assign _zz_result_145 = io_b[55 : 52];
  assign _zz_result_146 = io_b[59 : 56];
  assign _zz_result_147 = io_b[63 : 60];
  assign _zz_result_149 = io_b[7 : 0];
  always @(*) begin
    _zz_result_148[7 : 0] = ((_zz_result_149 == 8'h07) ? io_a[63 : 56] : ((_zz_result_149 == 8'h06) ? io_a[55 : 48] : ((_zz_result_149 == 8'h05) ? io_a[47 : 40] : ((_zz_result_149 == 8'h04) ? io_a[39 : 32] : ((_zz_result_149 == 8'h03) ? io_a[31 : 24] : ((_zz_result_149 == _zz__zz_result_148) ? io_a[23 : 16] : (_zz__zz_result_148_1 ? _zz__zz_result_148_2 : _zz__zz_result_148_3)))))));
    _zz_result_148[15 : 8] = ((_zz_result_150 == 8'h07) ? io_a[63 : 56] : ((_zz_result_150 == 8'h06) ? io_a[55 : 48] : ((_zz_result_150 == 8'h05) ? io_a[47 : 40] : ((_zz_result_150 == 8'h04) ? io_a[39 : 32] : ((_zz_result_150 == 8'h03) ? io_a[31 : 24] : ((_zz_result_150 == _zz__zz_result_148_4) ? io_a[23 : 16] : (_zz__zz_result_148_5 ? _zz__zz_result_148_6 : _zz__zz_result_148_7)))))));
    _zz_result_148[23 : 16] = ((_zz_result_151 == 8'h07) ? io_a[63 : 56] : ((_zz_result_151 == 8'h06) ? io_a[55 : 48] : ((_zz_result_151 == 8'h05) ? io_a[47 : 40] : ((_zz_result_151 == 8'h04) ? io_a[39 : 32] : ((_zz_result_151 == 8'h03) ? io_a[31 : 24] : ((_zz_result_151 == _zz__zz_result_148_8) ? io_a[23 : 16] : (_zz__zz_result_148_9 ? _zz__zz_result_148_10 : _zz__zz_result_148_11)))))));
    _zz_result_148[31 : 24] = ((_zz_result_152 == 8'h07) ? io_a[63 : 56] : ((_zz_result_152 == 8'h06) ? io_a[55 : 48] : ((_zz_result_152 == 8'h05) ? io_a[47 : 40] : ((_zz_result_152 == 8'h04) ? io_a[39 : 32] : ((_zz_result_152 == 8'h03) ? io_a[31 : 24] : ((_zz_result_152 == _zz__zz_result_148_12) ? io_a[23 : 16] : (_zz__zz_result_148_13 ? _zz__zz_result_148_14 : _zz__zz_result_148_15)))))));
    _zz_result_148[39 : 32] = ((_zz_result_153 == 8'h07) ? io_a[63 : 56] : ((_zz_result_153 == 8'h06) ? io_a[55 : 48] : ((_zz_result_153 == 8'h05) ? io_a[47 : 40] : ((_zz_result_153 == 8'h04) ? io_a[39 : 32] : ((_zz_result_153 == 8'h03) ? io_a[31 : 24] : ((_zz_result_153 == _zz__zz_result_148_16) ? io_a[23 : 16] : (_zz__zz_result_148_17 ? _zz__zz_result_148_18 : _zz__zz_result_148_19)))))));
    _zz_result_148[47 : 40] = ((_zz_result_154 == 8'h07) ? io_a[63 : 56] : ((_zz_result_154 == 8'h06) ? io_a[55 : 48] : ((_zz_result_154 == 8'h05) ? io_a[47 : 40] : ((_zz_result_154 == 8'h04) ? io_a[39 : 32] : ((_zz_result_154 == 8'h03) ? io_a[31 : 24] : ((_zz_result_154 == _zz__zz_result_148_20) ? io_a[23 : 16] : (_zz__zz_result_148_21 ? _zz__zz_result_148_22 : _zz__zz_result_148_23)))))));
    _zz_result_148[55 : 48] = ((_zz_result_155 == 8'h07) ? io_a[63 : 56] : ((_zz_result_155 == 8'h06) ? io_a[55 : 48] : ((_zz_result_155 == 8'h05) ? io_a[47 : 40] : ((_zz_result_155 == 8'h04) ? io_a[39 : 32] : ((_zz_result_155 == 8'h03) ? io_a[31 : 24] : ((_zz_result_155 == _zz__zz_result_148_24) ? io_a[23 : 16] : (_zz__zz_result_148_25 ? _zz__zz_result_148_26 : _zz__zz_result_148_27)))))));
    _zz_result_148[63 : 56] = ((_zz_result_156 == 8'h07) ? io_a[63 : 56] : ((_zz_result_156 == 8'h06) ? io_a[55 : 48] : ((_zz_result_156 == 8'h05) ? io_a[47 : 40] : ((_zz_result_156 == 8'h04) ? io_a[39 : 32] : ((_zz_result_156 == 8'h03) ? io_a[31 : 24] : ((_zz_result_156 == _zz__zz_result_148_28) ? io_a[23 : 16] : (_zz__zz_result_148_29 ? _zz__zz_result_148_30 : _zz__zz_result_148_31)))))));
  end

  assign _zz_result_150 = io_b[15 : 8];
  assign _zz_result_151 = io_b[23 : 16];
  assign _zz_result_152 = io_b[31 : 24];
  assign _zz_result_153 = io_b[39 : 32];
  assign _zz_result_154 = io_b[47 : 40];
  assign _zz_result_155 = io_b[55 : 48];
  assign _zz_result_156 = io_b[63 : 56];
  assign _zz_result_157 = io_a[31 : 0];
  assign _zz_result_158 = 1'b1;
  assign _zz_result_159 = (_zz_result_158 && (! _zz_result_157[31]));
  assign _zz_result_160 = (_zz_result_159 && (! _zz_result_157[30]));
  assign _zz_result_161 = (_zz_result_160 && (! _zz_result_157[29]));
  assign _zz_result_162 = (_zz_result_161 && (! _zz_result_157[28]));
  assign _zz_result_163 = (_zz_result_162 && (! _zz_result_157[27]));
  assign _zz_result_164 = (_zz_result_163 && (! _zz_result_157[26]));
  assign _zz_result_165 = (_zz_result_164 && (! _zz_result_157[25]));
  assign _zz_result_166 = (_zz_result_165 && (! _zz_result_157[24]));
  assign _zz_result_167 = (_zz_result_166 && (! _zz_result_157[23]));
  assign _zz_result_168 = (_zz_result_167 && (! _zz_result_157[22]));
  assign _zz_result_169 = (_zz_result_168 && (! _zz_result_157[21]));
  assign _zz_result_170 = (_zz_result_169 && (! _zz_result_157[20]));
  assign _zz_result_171 = (_zz_result_170 && (! _zz_result_157[19]));
  assign _zz_result_172 = (_zz_result_171 && (! _zz_result_157[18]));
  assign _zz_result_173 = (_zz_result_172 && (! _zz_result_157[17]));
  assign _zz_result_174 = (_zz_result_173 && (! _zz_result_157[16]));
  assign _zz_result_175 = (_zz_result_174 && (! _zz_result_157[15]));
  assign _zz_result_176 = (_zz_result_175 && (! _zz_result_157[14]));
  assign _zz_result_177 = (_zz_result_176 && (! _zz_result_157[13]));
  assign _zz_result_178 = (_zz_result_177 && (! _zz_result_157[12]));
  assign _zz_result_179 = (_zz_result_178 && (! _zz_result_157[11]));
  assign _zz_result_180 = (_zz_result_179 && (! _zz_result_157[10]));
  assign _zz_result_181 = (_zz_result_180 && (! _zz_result_157[9]));
  assign _zz_result_182 = (_zz_result_181 && (! _zz_result_157[8]));
  assign _zz_result_183 = (_zz_result_182 && (! _zz_result_157[7]));
  assign _zz_result_184 = (_zz_result_183 && (! _zz_result_157[6]));
  assign _zz_result_185 = (_zz_result_184 && (! _zz_result_157[5]));
  assign _zz_result_186 = (_zz_result_185 && (! _zz_result_157[4]));
  assign _zz_result_187 = (_zz_result_186 && (! _zz_result_157[3]));
  assign _zz_result_188 = (_zz_result_187 && (! _zz_result_157[2]));
  assign _zz_result_189 = io_a[31 : 0];
  assign _zz_result_190 = 1'b1;
  assign _zz_result_191 = (_zz_result_190 && (! _zz_result_189[0]));
  assign _zz_result_192 = (_zz_result_191 && (! _zz_result_189[1]));
  assign _zz_result_193 = (_zz_result_192 && (! _zz_result_189[2]));
  assign _zz_result_194 = (_zz_result_193 && (! _zz_result_189[3]));
  assign _zz_result_195 = (_zz_result_194 && (! _zz_result_189[4]));
  assign _zz_result_196 = (_zz_result_195 && (! _zz_result_189[5]));
  assign _zz_result_197 = (_zz_result_196 && (! _zz_result_189[6]));
  assign _zz_result_198 = (_zz_result_197 && (! _zz_result_189[7]));
  assign _zz_result_199 = (_zz_result_198 && (! _zz_result_189[8]));
  assign _zz_result_200 = (_zz_result_199 && (! _zz_result_189[9]));
  assign _zz_result_201 = (_zz_result_200 && (! _zz_result_189[10]));
  assign _zz_result_202 = (_zz_result_201 && (! _zz_result_189[11]));
  assign _zz_result_203 = (_zz_result_202 && (! _zz_result_189[12]));
  assign _zz_result_204 = (_zz_result_203 && (! _zz_result_189[13]));
  assign _zz_result_205 = (_zz_result_204 && (! _zz_result_189[14]));
  assign _zz_result_206 = (_zz_result_205 && (! _zz_result_189[15]));
  assign _zz_result_207 = (_zz_result_206 && (! _zz_result_189[16]));
  assign _zz_result_208 = (_zz_result_207 && (! _zz_result_189[17]));
  assign _zz_result_209 = (_zz_result_208 && (! _zz_result_189[18]));
  assign _zz_result_210 = (_zz_result_209 && (! _zz_result_189[19]));
  assign _zz_result_211 = (_zz_result_210 && (! _zz_result_189[20]));
  assign _zz_result_212 = (_zz_result_211 && (! _zz_result_189[21]));
  assign _zz_result_213 = (_zz_result_212 && (! _zz_result_189[22]));
  assign _zz_result_214 = (_zz_result_213 && (! _zz_result_189[23]));
  assign _zz_result_215 = (_zz_result_214 && (! _zz_result_189[24]));
  assign _zz_result_216 = (_zz_result_215 && (! _zz_result_189[25]));
  assign _zz_result_217 = (_zz_result_216 && (! _zz_result_189[26]));
  assign _zz_result_218 = (_zz_result_217 && (! _zz_result_189[27]));
  assign _zz_result_219 = (_zz_result_218 && (! _zz_result_189[28]));
  assign _zz_result_220 = (_zz_result_219 && (! _zz_result_189[29]));
  assign _zz_result_221 = io_a[31 : 0];
  assign _zz_result_222 = {1'd0, shamtW};
  assign _zz_result_223 = {1'd0, shamtW};
  assign _zz_result_224 = aU[31:0];
  assign _zz_result_225 = aU[31:0];
  assign _zz_result_226 = aU[31:0];
  assign _zz_result_227 = aU[31:0];
  assign _zz_result_228 = aU;
  assign _zz_result_229 = aU;
  assign _zz_result_230 = aU;
  assign _zz_result_231 = aU;
  assign _zz_result_232 = aU[31:0];
  assign _zz_result_233 = bU[31:0];
  assign _zz_result_234 = aU[31:0];
  assign _zz_result_235 = bU[31:0];
  assign _zz_result_236 = aU[31:0];
  assign _zz_result_237 = bU[31:0];
  assign _zz_result_238 = aU[31:0];
  assign _zz_result_239 = bU[31:0];
  assign _zz_result_240 = aU[31:0];
  assign _zz_result_241 = bU[31:0];
  assign _zz_result_242 = aU[31:0];
  assign _zz_result_243 = bU[31:0];
  assign _zz_result_244 = aU[31:0];
  assign _zz_result_245 = aU[31:0];
  assign _zz_result_246 = {io_bs,3'b000};
  assign _zz_result_247 = {24'd0, _zz__zz_result_247};
  assign _zz_result_248 = (((((_zz_result_247 ^ _zz__zz_result_248) ^ _zz__zz_result_248_2) ^ _zz__zz_result_248_4) ^ _zz__zz_result_248_6) ^ _zz__zz_result_248_8);
  assign _zz_result_249 = {1'd0, _zz_result_246};
  assign _zz_result_250 = {io_bs,3'b000};
  assign _zz_result_251 = {24'd0, _zz__zz_result_251};
  assign _zz_result_252 = ((((_zz_result_251 ^ _zz__zz_result_252) ^ _zz__zz_result_252_2) ^ _zz__zz_result_252_4) ^ _zz__zz_result_252_6);
  assign _zz_result_253 = {1'd0, _zz_result_250};
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
  wire       [2:0]    frmNext;
  `ifndef SYNTHESIS
  reg [39:0] io_csrOp_string;
  `endif


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
        readData = 64'h8000000000101104;
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
  end

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

  assign fflagsNext = fflagsReg;
  assign frmNext = frmReg;
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
  output wire          io_output_fp,
  output wire          io_output_fpWrite,
  output wire          io_output_fpLoad,
  output wire          io_output_fpStore,
  output wire          io_output_fpIntRd,
  output wire [5:0]    io_output_fpOp,
  output wire [2:0]    io_output_fpRm,
  output wire          io_output_fpFmt,
  output wire [4:0]    io_output_rs3,
  output reg  [4:0]    io_output_rs1,
  output reg  [4:0]    io_output_rs2,
  output reg  [4:0]    io_output_rd,
  output reg  [63:0]   io_output_imm,
  output wire [1:0]    io_output_bs,
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
  localparam AluOp_PACK = 7'd60;
  localparam AluOp_PACKH = 7'd61;
  localparam AluOp_PACKW = 7'd62;
  localparam AluOp_BREV8 = 7'd63;
  localparam AluOp_ZIP = 7'd64;
  localparam AluOp_UNZIP = 7'd65;
  localparam AluOp_XPERM4 = 7'd66;
  localparam AluOp_XPERM8 = 7'd67;
  localparam AluOp_CLZW = 7'd68;
  localparam AluOp_CTZW = 7'd69;
  localparam AluOp_CPOPW = 7'd70;
  localparam AluOp_ROLW = 7'd71;
  localparam AluOp_RORW = 7'd72;
  localparam AluOp_SHA256SUM0 = 7'd73;
  localparam AluOp_SHA256SUM1 = 7'd74;
  localparam AluOp_SHA256SIG0 = 7'd75;
  localparam AluOp_SHA256SIG1 = 7'd76;
  localparam AluOp_SHA512SUM0 = 7'd77;
  localparam AluOp_SHA512SUM1 = 7'd78;
  localparam AluOp_SHA512SIG0 = 7'd79;
  localparam AluOp_SHA512SIG1 = 7'd80;
  localparam AluOp_SHA512SUM0R = 7'd81;
  localparam AluOp_SHA512SUM1R = 7'd82;
  localparam AluOp_SHA512SIG0L = 7'd83;
  localparam AluOp_SHA512SIG0H = 7'd84;
  localparam AluOp_SHA512SIG1L = 7'd85;
  localparam AluOp_SHA512SIG1H = 7'd86;
  localparam AluOp_SM3P0 = 7'd87;
  localparam AluOp_SM3P1 = 7'd88;
  localparam AluOp_SM4ED = 7'd89;
  localparam AluOp_SM4KS = 7'd90;
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
  wire                when_Decoder_l163;
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
  wire       [1:0]    switch_Decoder_l200;
  wire                when_Decoder_l204;
  wire                when_Decoder_l251;
  wire                when_Decoder_l267;
  wire                when_Decoder_l272;
  wire       [1:0]    switch_Decoder_l282;
  wire                when_Decoder_l310;
  wire       [1:0]    switch_Decoder_l312;
  wire       [6:0]    _zz_io_output_aluOp;
  wire       [6:0]    _zz_io_output_aluOp_1;
  wire       [6:0]    _zz_io_output_aluOp_2;
  wire                when_Decoder_l364;
  wire                when_Decoder_l372;
  wire                when_Decoder_l382;
  wire                when_Decoder_l383;
  wire                when_Decoder_l384;
  wire                when_Decoder_l395;
  wire                when_Decoder_l396;
  wire       [6:0]    _zz_io_output_aluOp_3;
  wire       [6:0]    _zz_io_output_aluOp_4;
  wire                when_Decoder_l946;
  wire       [6:0]    _zz_io_output_aluOp_5;
  wire       [6:0]    _zz_io_output_aluOp_6;
  wire       [11:0]   switch_Decoder_l1128;
  `ifndef SYNTHESIS
  reg [87:0] io_output_aluOp_string;
  reg [31:0] io_output_branchType_string;
  reg [39:0] io_output_csrOp_string;
  reg [55:0] io_output_sysOp_string;
  reg [87:0] _zz_io_output_aluOp_string;
  reg [87:0] _zz_io_output_aluOp_1_string;
  reg [87:0] _zz_io_output_aluOp_2_string;
  reg [87:0] _zz_io_output_aluOp_3_string;
  reg [87:0] _zz_io_output_aluOp_4_string;
  reg [87:0] _zz_io_output_aluOp_5_string;
  reg [87:0] _zz_io_output_aluOp_6_string;
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
      AluOp_ADD : io_output_aluOp_string = "ADD        ";
      AluOp_SUB : io_output_aluOp_string = "SUB        ";
      AluOp_SLL_1 : io_output_aluOp_string = "SLL_1      ";
      AluOp_SLT : io_output_aluOp_string = "SLT        ";
      AluOp_SLTU : io_output_aluOp_string = "SLTU       ";
      AluOp_XOR_1 : io_output_aluOp_string = "XOR_1      ";
      AluOp_SRL_1 : io_output_aluOp_string = "SRL_1      ";
      AluOp_SRA_1 : io_output_aluOp_string = "SRA_1      ";
      AluOp_OR_1 : io_output_aluOp_string = "OR_1       ";
      AluOp_AND_1 : io_output_aluOp_string = "AND_1      ";
      AluOp_ADDW : io_output_aluOp_string = "ADDW       ";
      AluOp_SUBW : io_output_aluOp_string = "SUBW       ";
      AluOp_SLLW : io_output_aluOp_string = "SLLW       ";
      AluOp_SRLW : io_output_aluOp_string = "SRLW       ";
      AluOp_SRAW : io_output_aluOp_string = "SRAW       ";
      AluOp_MUL : io_output_aluOp_string = "MUL        ";
      AluOp_MULH : io_output_aluOp_string = "MULH       ";
      AluOp_MULHSU : io_output_aluOp_string = "MULHSU     ";
      AluOp_MULHU : io_output_aluOp_string = "MULHU      ";
      AluOp_DIV : io_output_aluOp_string = "DIV        ";
      AluOp_DIVU : io_output_aluOp_string = "DIVU       ";
      AluOp_REM_1 : io_output_aluOp_string = "REM_1      ";
      AluOp_REMU : io_output_aluOp_string = "REMU       ";
      AluOp_MULW : io_output_aluOp_string = "MULW       ";
      AluOp_DIVW : io_output_aluOp_string = "DIVW       ";
      AluOp_DIVUW : io_output_aluOp_string = "DIVUW      ";
      AluOp_REMW : io_output_aluOp_string = "REMW       ";
      AluOp_REMUW : io_output_aluOp_string = "REMUW      ";
      AluOp_ANDN : io_output_aluOp_string = "ANDN       ";
      AluOp_ORN : io_output_aluOp_string = "ORN        ";
      AluOp_XNOR_1 : io_output_aluOp_string = "XNOR_1     ";
      AluOp_CLZ : io_output_aluOp_string = "CLZ        ";
      AluOp_CTZ : io_output_aluOp_string = "CTZ        ";
      AluOp_CPOP : io_output_aluOp_string = "CPOP       ";
      AluOp_SEXTB : io_output_aluOp_string = "SEXTB      ";
      AluOp_SEXTH : io_output_aluOp_string = "SEXTH      ";
      AluOp_ZEXTH : io_output_aluOp_string = "ZEXTH      ";
      AluOp_ORCB : io_output_aluOp_string = "ORCB       ";
      AluOp_REV8 : io_output_aluOp_string = "REV8       ";
      AluOp_ROL_1 : io_output_aluOp_string = "ROL_1      ";
      AluOp_ROR_1 : io_output_aluOp_string = "ROR_1      ";
      AluOp_MIN : io_output_aluOp_string = "MIN        ";
      AluOp_MINU : io_output_aluOp_string = "MINU       ";
      AluOp_MAX : io_output_aluOp_string = "MAX        ";
      AluOp_MAXU : io_output_aluOp_string = "MAXU       ";
      AluOp_BSET : io_output_aluOp_string = "BSET       ";
      AluOp_BCLR : io_output_aluOp_string = "BCLR       ";
      AluOp_BINV : io_output_aluOp_string = "BINV       ";
      AluOp_BEXT : io_output_aluOp_string = "BEXT       ";
      AluOp_SH1ADD : io_output_aluOp_string = "SH1ADD     ";
      AluOp_SH2ADD : io_output_aluOp_string = "SH2ADD     ";
      AluOp_SH3ADD : io_output_aluOp_string = "SH3ADD     ";
      AluOp_ADDUW : io_output_aluOp_string = "ADDUW      ";
      AluOp_SH1ADDUW : io_output_aluOp_string = "SH1ADDUW   ";
      AluOp_SH2ADDUW : io_output_aluOp_string = "SH2ADDUW   ";
      AluOp_SH3ADDUW : io_output_aluOp_string = "SH3ADDUW   ";
      AluOp_SLLIUW : io_output_aluOp_string = "SLLIUW     ";
      AluOp_CLMUL : io_output_aluOp_string = "CLMUL      ";
      AluOp_CLMULH : io_output_aluOp_string = "CLMULH     ";
      AluOp_CLMULR : io_output_aluOp_string = "CLMULR     ";
      AluOp_PACK : io_output_aluOp_string = "PACK       ";
      AluOp_PACKH : io_output_aluOp_string = "PACKH      ";
      AluOp_PACKW : io_output_aluOp_string = "PACKW      ";
      AluOp_BREV8 : io_output_aluOp_string = "BREV8      ";
      AluOp_ZIP : io_output_aluOp_string = "ZIP        ";
      AluOp_UNZIP : io_output_aluOp_string = "UNZIP      ";
      AluOp_XPERM4 : io_output_aluOp_string = "XPERM4     ";
      AluOp_XPERM8 : io_output_aluOp_string = "XPERM8     ";
      AluOp_CLZW : io_output_aluOp_string = "CLZW       ";
      AluOp_CTZW : io_output_aluOp_string = "CTZW       ";
      AluOp_CPOPW : io_output_aluOp_string = "CPOPW      ";
      AluOp_ROLW : io_output_aluOp_string = "ROLW       ";
      AluOp_RORW : io_output_aluOp_string = "RORW       ";
      AluOp_SHA256SUM0 : io_output_aluOp_string = "SHA256SUM0 ";
      AluOp_SHA256SUM1 : io_output_aluOp_string = "SHA256SUM1 ";
      AluOp_SHA256SIG0 : io_output_aluOp_string = "SHA256SIG0 ";
      AluOp_SHA256SIG1 : io_output_aluOp_string = "SHA256SIG1 ";
      AluOp_SHA512SUM0 : io_output_aluOp_string = "SHA512SUM0 ";
      AluOp_SHA512SUM1 : io_output_aluOp_string = "SHA512SUM1 ";
      AluOp_SHA512SIG0 : io_output_aluOp_string = "SHA512SIG0 ";
      AluOp_SHA512SIG1 : io_output_aluOp_string = "SHA512SIG1 ";
      AluOp_SHA512SUM0R : io_output_aluOp_string = "SHA512SUM0R";
      AluOp_SHA512SUM1R : io_output_aluOp_string = "SHA512SUM1R";
      AluOp_SHA512SIG0L : io_output_aluOp_string = "SHA512SIG0L";
      AluOp_SHA512SIG0H : io_output_aluOp_string = "SHA512SIG0H";
      AluOp_SHA512SIG1L : io_output_aluOp_string = "SHA512SIG1L";
      AluOp_SHA512SIG1H : io_output_aluOp_string = "SHA512SIG1H";
      AluOp_SM3P0 : io_output_aluOp_string = "SM3P0      ";
      AluOp_SM3P1 : io_output_aluOp_string = "SM3P1      ";
      AluOp_SM4ED : io_output_aluOp_string = "SM4ED      ";
      AluOp_SM4KS : io_output_aluOp_string = "SM4KS      ";
      default : io_output_aluOp_string = "???????????";
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
      AluOp_ADD : _zz_io_output_aluOp_string = "ADD        ";
      AluOp_SUB : _zz_io_output_aluOp_string = "SUB        ";
      AluOp_SLL_1 : _zz_io_output_aluOp_string = "SLL_1      ";
      AluOp_SLT : _zz_io_output_aluOp_string = "SLT        ";
      AluOp_SLTU : _zz_io_output_aluOp_string = "SLTU       ";
      AluOp_XOR_1 : _zz_io_output_aluOp_string = "XOR_1      ";
      AluOp_SRL_1 : _zz_io_output_aluOp_string = "SRL_1      ";
      AluOp_SRA_1 : _zz_io_output_aluOp_string = "SRA_1      ";
      AluOp_OR_1 : _zz_io_output_aluOp_string = "OR_1       ";
      AluOp_AND_1 : _zz_io_output_aluOp_string = "AND_1      ";
      AluOp_ADDW : _zz_io_output_aluOp_string = "ADDW       ";
      AluOp_SUBW : _zz_io_output_aluOp_string = "SUBW       ";
      AluOp_SLLW : _zz_io_output_aluOp_string = "SLLW       ";
      AluOp_SRLW : _zz_io_output_aluOp_string = "SRLW       ";
      AluOp_SRAW : _zz_io_output_aluOp_string = "SRAW       ";
      AluOp_MUL : _zz_io_output_aluOp_string = "MUL        ";
      AluOp_MULH : _zz_io_output_aluOp_string = "MULH       ";
      AluOp_MULHSU : _zz_io_output_aluOp_string = "MULHSU     ";
      AluOp_MULHU : _zz_io_output_aluOp_string = "MULHU      ";
      AluOp_DIV : _zz_io_output_aluOp_string = "DIV        ";
      AluOp_DIVU : _zz_io_output_aluOp_string = "DIVU       ";
      AluOp_REM_1 : _zz_io_output_aluOp_string = "REM_1      ";
      AluOp_REMU : _zz_io_output_aluOp_string = "REMU       ";
      AluOp_MULW : _zz_io_output_aluOp_string = "MULW       ";
      AluOp_DIVW : _zz_io_output_aluOp_string = "DIVW       ";
      AluOp_DIVUW : _zz_io_output_aluOp_string = "DIVUW      ";
      AluOp_REMW : _zz_io_output_aluOp_string = "REMW       ";
      AluOp_REMUW : _zz_io_output_aluOp_string = "REMUW      ";
      AluOp_ANDN : _zz_io_output_aluOp_string = "ANDN       ";
      AluOp_ORN : _zz_io_output_aluOp_string = "ORN        ";
      AluOp_XNOR_1 : _zz_io_output_aluOp_string = "XNOR_1     ";
      AluOp_CLZ : _zz_io_output_aluOp_string = "CLZ        ";
      AluOp_CTZ : _zz_io_output_aluOp_string = "CTZ        ";
      AluOp_CPOP : _zz_io_output_aluOp_string = "CPOP       ";
      AluOp_SEXTB : _zz_io_output_aluOp_string = "SEXTB      ";
      AluOp_SEXTH : _zz_io_output_aluOp_string = "SEXTH      ";
      AluOp_ZEXTH : _zz_io_output_aluOp_string = "ZEXTH      ";
      AluOp_ORCB : _zz_io_output_aluOp_string = "ORCB       ";
      AluOp_REV8 : _zz_io_output_aluOp_string = "REV8       ";
      AluOp_ROL_1 : _zz_io_output_aluOp_string = "ROL_1      ";
      AluOp_ROR_1 : _zz_io_output_aluOp_string = "ROR_1      ";
      AluOp_MIN : _zz_io_output_aluOp_string = "MIN        ";
      AluOp_MINU : _zz_io_output_aluOp_string = "MINU       ";
      AluOp_MAX : _zz_io_output_aluOp_string = "MAX        ";
      AluOp_MAXU : _zz_io_output_aluOp_string = "MAXU       ";
      AluOp_BSET : _zz_io_output_aluOp_string = "BSET       ";
      AluOp_BCLR : _zz_io_output_aluOp_string = "BCLR       ";
      AluOp_BINV : _zz_io_output_aluOp_string = "BINV       ";
      AluOp_BEXT : _zz_io_output_aluOp_string = "BEXT       ";
      AluOp_SH1ADD : _zz_io_output_aluOp_string = "SH1ADD     ";
      AluOp_SH2ADD : _zz_io_output_aluOp_string = "SH2ADD     ";
      AluOp_SH3ADD : _zz_io_output_aluOp_string = "SH3ADD     ";
      AluOp_ADDUW : _zz_io_output_aluOp_string = "ADDUW      ";
      AluOp_SH1ADDUW : _zz_io_output_aluOp_string = "SH1ADDUW   ";
      AluOp_SH2ADDUW : _zz_io_output_aluOp_string = "SH2ADDUW   ";
      AluOp_SH3ADDUW : _zz_io_output_aluOp_string = "SH3ADDUW   ";
      AluOp_SLLIUW : _zz_io_output_aluOp_string = "SLLIUW     ";
      AluOp_CLMUL : _zz_io_output_aluOp_string = "CLMUL      ";
      AluOp_CLMULH : _zz_io_output_aluOp_string = "CLMULH     ";
      AluOp_CLMULR : _zz_io_output_aluOp_string = "CLMULR     ";
      AluOp_PACK : _zz_io_output_aluOp_string = "PACK       ";
      AluOp_PACKH : _zz_io_output_aluOp_string = "PACKH      ";
      AluOp_PACKW : _zz_io_output_aluOp_string = "PACKW      ";
      AluOp_BREV8 : _zz_io_output_aluOp_string = "BREV8      ";
      AluOp_ZIP : _zz_io_output_aluOp_string = "ZIP        ";
      AluOp_UNZIP : _zz_io_output_aluOp_string = "UNZIP      ";
      AluOp_XPERM4 : _zz_io_output_aluOp_string = "XPERM4     ";
      AluOp_XPERM8 : _zz_io_output_aluOp_string = "XPERM8     ";
      AluOp_CLZW : _zz_io_output_aluOp_string = "CLZW       ";
      AluOp_CTZW : _zz_io_output_aluOp_string = "CTZW       ";
      AluOp_CPOPW : _zz_io_output_aluOp_string = "CPOPW      ";
      AluOp_ROLW : _zz_io_output_aluOp_string = "ROLW       ";
      AluOp_RORW : _zz_io_output_aluOp_string = "RORW       ";
      AluOp_SHA256SUM0 : _zz_io_output_aluOp_string = "SHA256SUM0 ";
      AluOp_SHA256SUM1 : _zz_io_output_aluOp_string = "SHA256SUM1 ";
      AluOp_SHA256SIG0 : _zz_io_output_aluOp_string = "SHA256SIG0 ";
      AluOp_SHA256SIG1 : _zz_io_output_aluOp_string = "SHA256SIG1 ";
      AluOp_SHA512SUM0 : _zz_io_output_aluOp_string = "SHA512SUM0 ";
      AluOp_SHA512SUM1 : _zz_io_output_aluOp_string = "SHA512SUM1 ";
      AluOp_SHA512SIG0 : _zz_io_output_aluOp_string = "SHA512SIG0 ";
      AluOp_SHA512SIG1 : _zz_io_output_aluOp_string = "SHA512SIG1 ";
      AluOp_SHA512SUM0R : _zz_io_output_aluOp_string = "SHA512SUM0R";
      AluOp_SHA512SUM1R : _zz_io_output_aluOp_string = "SHA512SUM1R";
      AluOp_SHA512SIG0L : _zz_io_output_aluOp_string = "SHA512SIG0L";
      AluOp_SHA512SIG0H : _zz_io_output_aluOp_string = "SHA512SIG0H";
      AluOp_SHA512SIG1L : _zz_io_output_aluOp_string = "SHA512SIG1L";
      AluOp_SHA512SIG1H : _zz_io_output_aluOp_string = "SHA512SIG1H";
      AluOp_SM3P0 : _zz_io_output_aluOp_string = "SM3P0      ";
      AluOp_SM3P1 : _zz_io_output_aluOp_string = "SM3P1      ";
      AluOp_SM4ED : _zz_io_output_aluOp_string = "SM4ED      ";
      AluOp_SM4KS : _zz_io_output_aluOp_string = "SM4KS      ";
      default : _zz_io_output_aluOp_string = "???????????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_aluOp_1)
      AluOp_ADD : _zz_io_output_aluOp_1_string = "ADD        ";
      AluOp_SUB : _zz_io_output_aluOp_1_string = "SUB        ";
      AluOp_SLL_1 : _zz_io_output_aluOp_1_string = "SLL_1      ";
      AluOp_SLT : _zz_io_output_aluOp_1_string = "SLT        ";
      AluOp_SLTU : _zz_io_output_aluOp_1_string = "SLTU       ";
      AluOp_XOR_1 : _zz_io_output_aluOp_1_string = "XOR_1      ";
      AluOp_SRL_1 : _zz_io_output_aluOp_1_string = "SRL_1      ";
      AluOp_SRA_1 : _zz_io_output_aluOp_1_string = "SRA_1      ";
      AluOp_OR_1 : _zz_io_output_aluOp_1_string = "OR_1       ";
      AluOp_AND_1 : _zz_io_output_aluOp_1_string = "AND_1      ";
      AluOp_ADDW : _zz_io_output_aluOp_1_string = "ADDW       ";
      AluOp_SUBW : _zz_io_output_aluOp_1_string = "SUBW       ";
      AluOp_SLLW : _zz_io_output_aluOp_1_string = "SLLW       ";
      AluOp_SRLW : _zz_io_output_aluOp_1_string = "SRLW       ";
      AluOp_SRAW : _zz_io_output_aluOp_1_string = "SRAW       ";
      AluOp_MUL : _zz_io_output_aluOp_1_string = "MUL        ";
      AluOp_MULH : _zz_io_output_aluOp_1_string = "MULH       ";
      AluOp_MULHSU : _zz_io_output_aluOp_1_string = "MULHSU     ";
      AluOp_MULHU : _zz_io_output_aluOp_1_string = "MULHU      ";
      AluOp_DIV : _zz_io_output_aluOp_1_string = "DIV        ";
      AluOp_DIVU : _zz_io_output_aluOp_1_string = "DIVU       ";
      AluOp_REM_1 : _zz_io_output_aluOp_1_string = "REM_1      ";
      AluOp_REMU : _zz_io_output_aluOp_1_string = "REMU       ";
      AluOp_MULW : _zz_io_output_aluOp_1_string = "MULW       ";
      AluOp_DIVW : _zz_io_output_aluOp_1_string = "DIVW       ";
      AluOp_DIVUW : _zz_io_output_aluOp_1_string = "DIVUW      ";
      AluOp_REMW : _zz_io_output_aluOp_1_string = "REMW       ";
      AluOp_REMUW : _zz_io_output_aluOp_1_string = "REMUW      ";
      AluOp_ANDN : _zz_io_output_aluOp_1_string = "ANDN       ";
      AluOp_ORN : _zz_io_output_aluOp_1_string = "ORN        ";
      AluOp_XNOR_1 : _zz_io_output_aluOp_1_string = "XNOR_1     ";
      AluOp_CLZ : _zz_io_output_aluOp_1_string = "CLZ        ";
      AluOp_CTZ : _zz_io_output_aluOp_1_string = "CTZ        ";
      AluOp_CPOP : _zz_io_output_aluOp_1_string = "CPOP       ";
      AluOp_SEXTB : _zz_io_output_aluOp_1_string = "SEXTB      ";
      AluOp_SEXTH : _zz_io_output_aluOp_1_string = "SEXTH      ";
      AluOp_ZEXTH : _zz_io_output_aluOp_1_string = "ZEXTH      ";
      AluOp_ORCB : _zz_io_output_aluOp_1_string = "ORCB       ";
      AluOp_REV8 : _zz_io_output_aluOp_1_string = "REV8       ";
      AluOp_ROL_1 : _zz_io_output_aluOp_1_string = "ROL_1      ";
      AluOp_ROR_1 : _zz_io_output_aluOp_1_string = "ROR_1      ";
      AluOp_MIN : _zz_io_output_aluOp_1_string = "MIN        ";
      AluOp_MINU : _zz_io_output_aluOp_1_string = "MINU       ";
      AluOp_MAX : _zz_io_output_aluOp_1_string = "MAX        ";
      AluOp_MAXU : _zz_io_output_aluOp_1_string = "MAXU       ";
      AluOp_BSET : _zz_io_output_aluOp_1_string = "BSET       ";
      AluOp_BCLR : _zz_io_output_aluOp_1_string = "BCLR       ";
      AluOp_BINV : _zz_io_output_aluOp_1_string = "BINV       ";
      AluOp_BEXT : _zz_io_output_aluOp_1_string = "BEXT       ";
      AluOp_SH1ADD : _zz_io_output_aluOp_1_string = "SH1ADD     ";
      AluOp_SH2ADD : _zz_io_output_aluOp_1_string = "SH2ADD     ";
      AluOp_SH3ADD : _zz_io_output_aluOp_1_string = "SH3ADD     ";
      AluOp_ADDUW : _zz_io_output_aluOp_1_string = "ADDUW      ";
      AluOp_SH1ADDUW : _zz_io_output_aluOp_1_string = "SH1ADDUW   ";
      AluOp_SH2ADDUW : _zz_io_output_aluOp_1_string = "SH2ADDUW   ";
      AluOp_SH3ADDUW : _zz_io_output_aluOp_1_string = "SH3ADDUW   ";
      AluOp_SLLIUW : _zz_io_output_aluOp_1_string = "SLLIUW     ";
      AluOp_CLMUL : _zz_io_output_aluOp_1_string = "CLMUL      ";
      AluOp_CLMULH : _zz_io_output_aluOp_1_string = "CLMULH     ";
      AluOp_CLMULR : _zz_io_output_aluOp_1_string = "CLMULR     ";
      AluOp_PACK : _zz_io_output_aluOp_1_string = "PACK       ";
      AluOp_PACKH : _zz_io_output_aluOp_1_string = "PACKH      ";
      AluOp_PACKW : _zz_io_output_aluOp_1_string = "PACKW      ";
      AluOp_BREV8 : _zz_io_output_aluOp_1_string = "BREV8      ";
      AluOp_ZIP : _zz_io_output_aluOp_1_string = "ZIP        ";
      AluOp_UNZIP : _zz_io_output_aluOp_1_string = "UNZIP      ";
      AluOp_XPERM4 : _zz_io_output_aluOp_1_string = "XPERM4     ";
      AluOp_XPERM8 : _zz_io_output_aluOp_1_string = "XPERM8     ";
      AluOp_CLZW : _zz_io_output_aluOp_1_string = "CLZW       ";
      AluOp_CTZW : _zz_io_output_aluOp_1_string = "CTZW       ";
      AluOp_CPOPW : _zz_io_output_aluOp_1_string = "CPOPW      ";
      AluOp_ROLW : _zz_io_output_aluOp_1_string = "ROLW       ";
      AluOp_RORW : _zz_io_output_aluOp_1_string = "RORW       ";
      AluOp_SHA256SUM0 : _zz_io_output_aluOp_1_string = "SHA256SUM0 ";
      AluOp_SHA256SUM1 : _zz_io_output_aluOp_1_string = "SHA256SUM1 ";
      AluOp_SHA256SIG0 : _zz_io_output_aluOp_1_string = "SHA256SIG0 ";
      AluOp_SHA256SIG1 : _zz_io_output_aluOp_1_string = "SHA256SIG1 ";
      AluOp_SHA512SUM0 : _zz_io_output_aluOp_1_string = "SHA512SUM0 ";
      AluOp_SHA512SUM1 : _zz_io_output_aluOp_1_string = "SHA512SUM1 ";
      AluOp_SHA512SIG0 : _zz_io_output_aluOp_1_string = "SHA512SIG0 ";
      AluOp_SHA512SIG1 : _zz_io_output_aluOp_1_string = "SHA512SIG1 ";
      AluOp_SHA512SUM0R : _zz_io_output_aluOp_1_string = "SHA512SUM0R";
      AluOp_SHA512SUM1R : _zz_io_output_aluOp_1_string = "SHA512SUM1R";
      AluOp_SHA512SIG0L : _zz_io_output_aluOp_1_string = "SHA512SIG0L";
      AluOp_SHA512SIG0H : _zz_io_output_aluOp_1_string = "SHA512SIG0H";
      AluOp_SHA512SIG1L : _zz_io_output_aluOp_1_string = "SHA512SIG1L";
      AluOp_SHA512SIG1H : _zz_io_output_aluOp_1_string = "SHA512SIG1H";
      AluOp_SM3P0 : _zz_io_output_aluOp_1_string = "SM3P0      ";
      AluOp_SM3P1 : _zz_io_output_aluOp_1_string = "SM3P1      ";
      AluOp_SM4ED : _zz_io_output_aluOp_1_string = "SM4ED      ";
      AluOp_SM4KS : _zz_io_output_aluOp_1_string = "SM4KS      ";
      default : _zz_io_output_aluOp_1_string = "???????????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_aluOp_2)
      AluOp_ADD : _zz_io_output_aluOp_2_string = "ADD        ";
      AluOp_SUB : _zz_io_output_aluOp_2_string = "SUB        ";
      AluOp_SLL_1 : _zz_io_output_aluOp_2_string = "SLL_1      ";
      AluOp_SLT : _zz_io_output_aluOp_2_string = "SLT        ";
      AluOp_SLTU : _zz_io_output_aluOp_2_string = "SLTU       ";
      AluOp_XOR_1 : _zz_io_output_aluOp_2_string = "XOR_1      ";
      AluOp_SRL_1 : _zz_io_output_aluOp_2_string = "SRL_1      ";
      AluOp_SRA_1 : _zz_io_output_aluOp_2_string = "SRA_1      ";
      AluOp_OR_1 : _zz_io_output_aluOp_2_string = "OR_1       ";
      AluOp_AND_1 : _zz_io_output_aluOp_2_string = "AND_1      ";
      AluOp_ADDW : _zz_io_output_aluOp_2_string = "ADDW       ";
      AluOp_SUBW : _zz_io_output_aluOp_2_string = "SUBW       ";
      AluOp_SLLW : _zz_io_output_aluOp_2_string = "SLLW       ";
      AluOp_SRLW : _zz_io_output_aluOp_2_string = "SRLW       ";
      AluOp_SRAW : _zz_io_output_aluOp_2_string = "SRAW       ";
      AluOp_MUL : _zz_io_output_aluOp_2_string = "MUL        ";
      AluOp_MULH : _zz_io_output_aluOp_2_string = "MULH       ";
      AluOp_MULHSU : _zz_io_output_aluOp_2_string = "MULHSU     ";
      AluOp_MULHU : _zz_io_output_aluOp_2_string = "MULHU      ";
      AluOp_DIV : _zz_io_output_aluOp_2_string = "DIV        ";
      AluOp_DIVU : _zz_io_output_aluOp_2_string = "DIVU       ";
      AluOp_REM_1 : _zz_io_output_aluOp_2_string = "REM_1      ";
      AluOp_REMU : _zz_io_output_aluOp_2_string = "REMU       ";
      AluOp_MULW : _zz_io_output_aluOp_2_string = "MULW       ";
      AluOp_DIVW : _zz_io_output_aluOp_2_string = "DIVW       ";
      AluOp_DIVUW : _zz_io_output_aluOp_2_string = "DIVUW      ";
      AluOp_REMW : _zz_io_output_aluOp_2_string = "REMW       ";
      AluOp_REMUW : _zz_io_output_aluOp_2_string = "REMUW      ";
      AluOp_ANDN : _zz_io_output_aluOp_2_string = "ANDN       ";
      AluOp_ORN : _zz_io_output_aluOp_2_string = "ORN        ";
      AluOp_XNOR_1 : _zz_io_output_aluOp_2_string = "XNOR_1     ";
      AluOp_CLZ : _zz_io_output_aluOp_2_string = "CLZ        ";
      AluOp_CTZ : _zz_io_output_aluOp_2_string = "CTZ        ";
      AluOp_CPOP : _zz_io_output_aluOp_2_string = "CPOP       ";
      AluOp_SEXTB : _zz_io_output_aluOp_2_string = "SEXTB      ";
      AluOp_SEXTH : _zz_io_output_aluOp_2_string = "SEXTH      ";
      AluOp_ZEXTH : _zz_io_output_aluOp_2_string = "ZEXTH      ";
      AluOp_ORCB : _zz_io_output_aluOp_2_string = "ORCB       ";
      AluOp_REV8 : _zz_io_output_aluOp_2_string = "REV8       ";
      AluOp_ROL_1 : _zz_io_output_aluOp_2_string = "ROL_1      ";
      AluOp_ROR_1 : _zz_io_output_aluOp_2_string = "ROR_1      ";
      AluOp_MIN : _zz_io_output_aluOp_2_string = "MIN        ";
      AluOp_MINU : _zz_io_output_aluOp_2_string = "MINU       ";
      AluOp_MAX : _zz_io_output_aluOp_2_string = "MAX        ";
      AluOp_MAXU : _zz_io_output_aluOp_2_string = "MAXU       ";
      AluOp_BSET : _zz_io_output_aluOp_2_string = "BSET       ";
      AluOp_BCLR : _zz_io_output_aluOp_2_string = "BCLR       ";
      AluOp_BINV : _zz_io_output_aluOp_2_string = "BINV       ";
      AluOp_BEXT : _zz_io_output_aluOp_2_string = "BEXT       ";
      AluOp_SH1ADD : _zz_io_output_aluOp_2_string = "SH1ADD     ";
      AluOp_SH2ADD : _zz_io_output_aluOp_2_string = "SH2ADD     ";
      AluOp_SH3ADD : _zz_io_output_aluOp_2_string = "SH3ADD     ";
      AluOp_ADDUW : _zz_io_output_aluOp_2_string = "ADDUW      ";
      AluOp_SH1ADDUW : _zz_io_output_aluOp_2_string = "SH1ADDUW   ";
      AluOp_SH2ADDUW : _zz_io_output_aluOp_2_string = "SH2ADDUW   ";
      AluOp_SH3ADDUW : _zz_io_output_aluOp_2_string = "SH3ADDUW   ";
      AluOp_SLLIUW : _zz_io_output_aluOp_2_string = "SLLIUW     ";
      AluOp_CLMUL : _zz_io_output_aluOp_2_string = "CLMUL      ";
      AluOp_CLMULH : _zz_io_output_aluOp_2_string = "CLMULH     ";
      AluOp_CLMULR : _zz_io_output_aluOp_2_string = "CLMULR     ";
      AluOp_PACK : _zz_io_output_aluOp_2_string = "PACK       ";
      AluOp_PACKH : _zz_io_output_aluOp_2_string = "PACKH      ";
      AluOp_PACKW : _zz_io_output_aluOp_2_string = "PACKW      ";
      AluOp_BREV8 : _zz_io_output_aluOp_2_string = "BREV8      ";
      AluOp_ZIP : _zz_io_output_aluOp_2_string = "ZIP        ";
      AluOp_UNZIP : _zz_io_output_aluOp_2_string = "UNZIP      ";
      AluOp_XPERM4 : _zz_io_output_aluOp_2_string = "XPERM4     ";
      AluOp_XPERM8 : _zz_io_output_aluOp_2_string = "XPERM8     ";
      AluOp_CLZW : _zz_io_output_aluOp_2_string = "CLZW       ";
      AluOp_CTZW : _zz_io_output_aluOp_2_string = "CTZW       ";
      AluOp_CPOPW : _zz_io_output_aluOp_2_string = "CPOPW      ";
      AluOp_ROLW : _zz_io_output_aluOp_2_string = "ROLW       ";
      AluOp_RORW : _zz_io_output_aluOp_2_string = "RORW       ";
      AluOp_SHA256SUM0 : _zz_io_output_aluOp_2_string = "SHA256SUM0 ";
      AluOp_SHA256SUM1 : _zz_io_output_aluOp_2_string = "SHA256SUM1 ";
      AluOp_SHA256SIG0 : _zz_io_output_aluOp_2_string = "SHA256SIG0 ";
      AluOp_SHA256SIG1 : _zz_io_output_aluOp_2_string = "SHA256SIG1 ";
      AluOp_SHA512SUM0 : _zz_io_output_aluOp_2_string = "SHA512SUM0 ";
      AluOp_SHA512SUM1 : _zz_io_output_aluOp_2_string = "SHA512SUM1 ";
      AluOp_SHA512SIG0 : _zz_io_output_aluOp_2_string = "SHA512SIG0 ";
      AluOp_SHA512SIG1 : _zz_io_output_aluOp_2_string = "SHA512SIG1 ";
      AluOp_SHA512SUM0R : _zz_io_output_aluOp_2_string = "SHA512SUM0R";
      AluOp_SHA512SUM1R : _zz_io_output_aluOp_2_string = "SHA512SUM1R";
      AluOp_SHA512SIG0L : _zz_io_output_aluOp_2_string = "SHA512SIG0L";
      AluOp_SHA512SIG0H : _zz_io_output_aluOp_2_string = "SHA512SIG0H";
      AluOp_SHA512SIG1L : _zz_io_output_aluOp_2_string = "SHA512SIG1L";
      AluOp_SHA512SIG1H : _zz_io_output_aluOp_2_string = "SHA512SIG1H";
      AluOp_SM3P0 : _zz_io_output_aluOp_2_string = "SM3P0      ";
      AluOp_SM3P1 : _zz_io_output_aluOp_2_string = "SM3P1      ";
      AluOp_SM4ED : _zz_io_output_aluOp_2_string = "SM4ED      ";
      AluOp_SM4KS : _zz_io_output_aluOp_2_string = "SM4KS      ";
      default : _zz_io_output_aluOp_2_string = "???????????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_aluOp_3)
      AluOp_ADD : _zz_io_output_aluOp_3_string = "ADD        ";
      AluOp_SUB : _zz_io_output_aluOp_3_string = "SUB        ";
      AluOp_SLL_1 : _zz_io_output_aluOp_3_string = "SLL_1      ";
      AluOp_SLT : _zz_io_output_aluOp_3_string = "SLT        ";
      AluOp_SLTU : _zz_io_output_aluOp_3_string = "SLTU       ";
      AluOp_XOR_1 : _zz_io_output_aluOp_3_string = "XOR_1      ";
      AluOp_SRL_1 : _zz_io_output_aluOp_3_string = "SRL_1      ";
      AluOp_SRA_1 : _zz_io_output_aluOp_3_string = "SRA_1      ";
      AluOp_OR_1 : _zz_io_output_aluOp_3_string = "OR_1       ";
      AluOp_AND_1 : _zz_io_output_aluOp_3_string = "AND_1      ";
      AluOp_ADDW : _zz_io_output_aluOp_3_string = "ADDW       ";
      AluOp_SUBW : _zz_io_output_aluOp_3_string = "SUBW       ";
      AluOp_SLLW : _zz_io_output_aluOp_3_string = "SLLW       ";
      AluOp_SRLW : _zz_io_output_aluOp_3_string = "SRLW       ";
      AluOp_SRAW : _zz_io_output_aluOp_3_string = "SRAW       ";
      AluOp_MUL : _zz_io_output_aluOp_3_string = "MUL        ";
      AluOp_MULH : _zz_io_output_aluOp_3_string = "MULH       ";
      AluOp_MULHSU : _zz_io_output_aluOp_3_string = "MULHSU     ";
      AluOp_MULHU : _zz_io_output_aluOp_3_string = "MULHU      ";
      AluOp_DIV : _zz_io_output_aluOp_3_string = "DIV        ";
      AluOp_DIVU : _zz_io_output_aluOp_3_string = "DIVU       ";
      AluOp_REM_1 : _zz_io_output_aluOp_3_string = "REM_1      ";
      AluOp_REMU : _zz_io_output_aluOp_3_string = "REMU       ";
      AluOp_MULW : _zz_io_output_aluOp_3_string = "MULW       ";
      AluOp_DIVW : _zz_io_output_aluOp_3_string = "DIVW       ";
      AluOp_DIVUW : _zz_io_output_aluOp_3_string = "DIVUW      ";
      AluOp_REMW : _zz_io_output_aluOp_3_string = "REMW       ";
      AluOp_REMUW : _zz_io_output_aluOp_3_string = "REMUW      ";
      AluOp_ANDN : _zz_io_output_aluOp_3_string = "ANDN       ";
      AluOp_ORN : _zz_io_output_aluOp_3_string = "ORN        ";
      AluOp_XNOR_1 : _zz_io_output_aluOp_3_string = "XNOR_1     ";
      AluOp_CLZ : _zz_io_output_aluOp_3_string = "CLZ        ";
      AluOp_CTZ : _zz_io_output_aluOp_3_string = "CTZ        ";
      AluOp_CPOP : _zz_io_output_aluOp_3_string = "CPOP       ";
      AluOp_SEXTB : _zz_io_output_aluOp_3_string = "SEXTB      ";
      AluOp_SEXTH : _zz_io_output_aluOp_3_string = "SEXTH      ";
      AluOp_ZEXTH : _zz_io_output_aluOp_3_string = "ZEXTH      ";
      AluOp_ORCB : _zz_io_output_aluOp_3_string = "ORCB       ";
      AluOp_REV8 : _zz_io_output_aluOp_3_string = "REV8       ";
      AluOp_ROL_1 : _zz_io_output_aluOp_3_string = "ROL_1      ";
      AluOp_ROR_1 : _zz_io_output_aluOp_3_string = "ROR_1      ";
      AluOp_MIN : _zz_io_output_aluOp_3_string = "MIN        ";
      AluOp_MINU : _zz_io_output_aluOp_3_string = "MINU       ";
      AluOp_MAX : _zz_io_output_aluOp_3_string = "MAX        ";
      AluOp_MAXU : _zz_io_output_aluOp_3_string = "MAXU       ";
      AluOp_BSET : _zz_io_output_aluOp_3_string = "BSET       ";
      AluOp_BCLR : _zz_io_output_aluOp_3_string = "BCLR       ";
      AluOp_BINV : _zz_io_output_aluOp_3_string = "BINV       ";
      AluOp_BEXT : _zz_io_output_aluOp_3_string = "BEXT       ";
      AluOp_SH1ADD : _zz_io_output_aluOp_3_string = "SH1ADD     ";
      AluOp_SH2ADD : _zz_io_output_aluOp_3_string = "SH2ADD     ";
      AluOp_SH3ADD : _zz_io_output_aluOp_3_string = "SH3ADD     ";
      AluOp_ADDUW : _zz_io_output_aluOp_3_string = "ADDUW      ";
      AluOp_SH1ADDUW : _zz_io_output_aluOp_3_string = "SH1ADDUW   ";
      AluOp_SH2ADDUW : _zz_io_output_aluOp_3_string = "SH2ADDUW   ";
      AluOp_SH3ADDUW : _zz_io_output_aluOp_3_string = "SH3ADDUW   ";
      AluOp_SLLIUW : _zz_io_output_aluOp_3_string = "SLLIUW     ";
      AluOp_CLMUL : _zz_io_output_aluOp_3_string = "CLMUL      ";
      AluOp_CLMULH : _zz_io_output_aluOp_3_string = "CLMULH     ";
      AluOp_CLMULR : _zz_io_output_aluOp_3_string = "CLMULR     ";
      AluOp_PACK : _zz_io_output_aluOp_3_string = "PACK       ";
      AluOp_PACKH : _zz_io_output_aluOp_3_string = "PACKH      ";
      AluOp_PACKW : _zz_io_output_aluOp_3_string = "PACKW      ";
      AluOp_BREV8 : _zz_io_output_aluOp_3_string = "BREV8      ";
      AluOp_ZIP : _zz_io_output_aluOp_3_string = "ZIP        ";
      AluOp_UNZIP : _zz_io_output_aluOp_3_string = "UNZIP      ";
      AluOp_XPERM4 : _zz_io_output_aluOp_3_string = "XPERM4     ";
      AluOp_XPERM8 : _zz_io_output_aluOp_3_string = "XPERM8     ";
      AluOp_CLZW : _zz_io_output_aluOp_3_string = "CLZW       ";
      AluOp_CTZW : _zz_io_output_aluOp_3_string = "CTZW       ";
      AluOp_CPOPW : _zz_io_output_aluOp_3_string = "CPOPW      ";
      AluOp_ROLW : _zz_io_output_aluOp_3_string = "ROLW       ";
      AluOp_RORW : _zz_io_output_aluOp_3_string = "RORW       ";
      AluOp_SHA256SUM0 : _zz_io_output_aluOp_3_string = "SHA256SUM0 ";
      AluOp_SHA256SUM1 : _zz_io_output_aluOp_3_string = "SHA256SUM1 ";
      AluOp_SHA256SIG0 : _zz_io_output_aluOp_3_string = "SHA256SIG0 ";
      AluOp_SHA256SIG1 : _zz_io_output_aluOp_3_string = "SHA256SIG1 ";
      AluOp_SHA512SUM0 : _zz_io_output_aluOp_3_string = "SHA512SUM0 ";
      AluOp_SHA512SUM1 : _zz_io_output_aluOp_3_string = "SHA512SUM1 ";
      AluOp_SHA512SIG0 : _zz_io_output_aluOp_3_string = "SHA512SIG0 ";
      AluOp_SHA512SIG1 : _zz_io_output_aluOp_3_string = "SHA512SIG1 ";
      AluOp_SHA512SUM0R : _zz_io_output_aluOp_3_string = "SHA512SUM0R";
      AluOp_SHA512SUM1R : _zz_io_output_aluOp_3_string = "SHA512SUM1R";
      AluOp_SHA512SIG0L : _zz_io_output_aluOp_3_string = "SHA512SIG0L";
      AluOp_SHA512SIG0H : _zz_io_output_aluOp_3_string = "SHA512SIG0H";
      AluOp_SHA512SIG1L : _zz_io_output_aluOp_3_string = "SHA512SIG1L";
      AluOp_SHA512SIG1H : _zz_io_output_aluOp_3_string = "SHA512SIG1H";
      AluOp_SM3P0 : _zz_io_output_aluOp_3_string = "SM3P0      ";
      AluOp_SM3P1 : _zz_io_output_aluOp_3_string = "SM3P1      ";
      AluOp_SM4ED : _zz_io_output_aluOp_3_string = "SM4ED      ";
      AluOp_SM4KS : _zz_io_output_aluOp_3_string = "SM4KS      ";
      default : _zz_io_output_aluOp_3_string = "???????????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_aluOp_4)
      AluOp_ADD : _zz_io_output_aluOp_4_string = "ADD        ";
      AluOp_SUB : _zz_io_output_aluOp_4_string = "SUB        ";
      AluOp_SLL_1 : _zz_io_output_aluOp_4_string = "SLL_1      ";
      AluOp_SLT : _zz_io_output_aluOp_4_string = "SLT        ";
      AluOp_SLTU : _zz_io_output_aluOp_4_string = "SLTU       ";
      AluOp_XOR_1 : _zz_io_output_aluOp_4_string = "XOR_1      ";
      AluOp_SRL_1 : _zz_io_output_aluOp_4_string = "SRL_1      ";
      AluOp_SRA_1 : _zz_io_output_aluOp_4_string = "SRA_1      ";
      AluOp_OR_1 : _zz_io_output_aluOp_4_string = "OR_1       ";
      AluOp_AND_1 : _zz_io_output_aluOp_4_string = "AND_1      ";
      AluOp_ADDW : _zz_io_output_aluOp_4_string = "ADDW       ";
      AluOp_SUBW : _zz_io_output_aluOp_4_string = "SUBW       ";
      AluOp_SLLW : _zz_io_output_aluOp_4_string = "SLLW       ";
      AluOp_SRLW : _zz_io_output_aluOp_4_string = "SRLW       ";
      AluOp_SRAW : _zz_io_output_aluOp_4_string = "SRAW       ";
      AluOp_MUL : _zz_io_output_aluOp_4_string = "MUL        ";
      AluOp_MULH : _zz_io_output_aluOp_4_string = "MULH       ";
      AluOp_MULHSU : _zz_io_output_aluOp_4_string = "MULHSU     ";
      AluOp_MULHU : _zz_io_output_aluOp_4_string = "MULHU      ";
      AluOp_DIV : _zz_io_output_aluOp_4_string = "DIV        ";
      AluOp_DIVU : _zz_io_output_aluOp_4_string = "DIVU       ";
      AluOp_REM_1 : _zz_io_output_aluOp_4_string = "REM_1      ";
      AluOp_REMU : _zz_io_output_aluOp_4_string = "REMU       ";
      AluOp_MULW : _zz_io_output_aluOp_4_string = "MULW       ";
      AluOp_DIVW : _zz_io_output_aluOp_4_string = "DIVW       ";
      AluOp_DIVUW : _zz_io_output_aluOp_4_string = "DIVUW      ";
      AluOp_REMW : _zz_io_output_aluOp_4_string = "REMW       ";
      AluOp_REMUW : _zz_io_output_aluOp_4_string = "REMUW      ";
      AluOp_ANDN : _zz_io_output_aluOp_4_string = "ANDN       ";
      AluOp_ORN : _zz_io_output_aluOp_4_string = "ORN        ";
      AluOp_XNOR_1 : _zz_io_output_aluOp_4_string = "XNOR_1     ";
      AluOp_CLZ : _zz_io_output_aluOp_4_string = "CLZ        ";
      AluOp_CTZ : _zz_io_output_aluOp_4_string = "CTZ        ";
      AluOp_CPOP : _zz_io_output_aluOp_4_string = "CPOP       ";
      AluOp_SEXTB : _zz_io_output_aluOp_4_string = "SEXTB      ";
      AluOp_SEXTH : _zz_io_output_aluOp_4_string = "SEXTH      ";
      AluOp_ZEXTH : _zz_io_output_aluOp_4_string = "ZEXTH      ";
      AluOp_ORCB : _zz_io_output_aluOp_4_string = "ORCB       ";
      AluOp_REV8 : _zz_io_output_aluOp_4_string = "REV8       ";
      AluOp_ROL_1 : _zz_io_output_aluOp_4_string = "ROL_1      ";
      AluOp_ROR_1 : _zz_io_output_aluOp_4_string = "ROR_1      ";
      AluOp_MIN : _zz_io_output_aluOp_4_string = "MIN        ";
      AluOp_MINU : _zz_io_output_aluOp_4_string = "MINU       ";
      AluOp_MAX : _zz_io_output_aluOp_4_string = "MAX        ";
      AluOp_MAXU : _zz_io_output_aluOp_4_string = "MAXU       ";
      AluOp_BSET : _zz_io_output_aluOp_4_string = "BSET       ";
      AluOp_BCLR : _zz_io_output_aluOp_4_string = "BCLR       ";
      AluOp_BINV : _zz_io_output_aluOp_4_string = "BINV       ";
      AluOp_BEXT : _zz_io_output_aluOp_4_string = "BEXT       ";
      AluOp_SH1ADD : _zz_io_output_aluOp_4_string = "SH1ADD     ";
      AluOp_SH2ADD : _zz_io_output_aluOp_4_string = "SH2ADD     ";
      AluOp_SH3ADD : _zz_io_output_aluOp_4_string = "SH3ADD     ";
      AluOp_ADDUW : _zz_io_output_aluOp_4_string = "ADDUW      ";
      AluOp_SH1ADDUW : _zz_io_output_aluOp_4_string = "SH1ADDUW   ";
      AluOp_SH2ADDUW : _zz_io_output_aluOp_4_string = "SH2ADDUW   ";
      AluOp_SH3ADDUW : _zz_io_output_aluOp_4_string = "SH3ADDUW   ";
      AluOp_SLLIUW : _zz_io_output_aluOp_4_string = "SLLIUW     ";
      AluOp_CLMUL : _zz_io_output_aluOp_4_string = "CLMUL      ";
      AluOp_CLMULH : _zz_io_output_aluOp_4_string = "CLMULH     ";
      AluOp_CLMULR : _zz_io_output_aluOp_4_string = "CLMULR     ";
      AluOp_PACK : _zz_io_output_aluOp_4_string = "PACK       ";
      AluOp_PACKH : _zz_io_output_aluOp_4_string = "PACKH      ";
      AluOp_PACKW : _zz_io_output_aluOp_4_string = "PACKW      ";
      AluOp_BREV8 : _zz_io_output_aluOp_4_string = "BREV8      ";
      AluOp_ZIP : _zz_io_output_aluOp_4_string = "ZIP        ";
      AluOp_UNZIP : _zz_io_output_aluOp_4_string = "UNZIP      ";
      AluOp_XPERM4 : _zz_io_output_aluOp_4_string = "XPERM4     ";
      AluOp_XPERM8 : _zz_io_output_aluOp_4_string = "XPERM8     ";
      AluOp_CLZW : _zz_io_output_aluOp_4_string = "CLZW       ";
      AluOp_CTZW : _zz_io_output_aluOp_4_string = "CTZW       ";
      AluOp_CPOPW : _zz_io_output_aluOp_4_string = "CPOPW      ";
      AluOp_ROLW : _zz_io_output_aluOp_4_string = "ROLW       ";
      AluOp_RORW : _zz_io_output_aluOp_4_string = "RORW       ";
      AluOp_SHA256SUM0 : _zz_io_output_aluOp_4_string = "SHA256SUM0 ";
      AluOp_SHA256SUM1 : _zz_io_output_aluOp_4_string = "SHA256SUM1 ";
      AluOp_SHA256SIG0 : _zz_io_output_aluOp_4_string = "SHA256SIG0 ";
      AluOp_SHA256SIG1 : _zz_io_output_aluOp_4_string = "SHA256SIG1 ";
      AluOp_SHA512SUM0 : _zz_io_output_aluOp_4_string = "SHA512SUM0 ";
      AluOp_SHA512SUM1 : _zz_io_output_aluOp_4_string = "SHA512SUM1 ";
      AluOp_SHA512SIG0 : _zz_io_output_aluOp_4_string = "SHA512SIG0 ";
      AluOp_SHA512SIG1 : _zz_io_output_aluOp_4_string = "SHA512SIG1 ";
      AluOp_SHA512SUM0R : _zz_io_output_aluOp_4_string = "SHA512SUM0R";
      AluOp_SHA512SUM1R : _zz_io_output_aluOp_4_string = "SHA512SUM1R";
      AluOp_SHA512SIG0L : _zz_io_output_aluOp_4_string = "SHA512SIG0L";
      AluOp_SHA512SIG0H : _zz_io_output_aluOp_4_string = "SHA512SIG0H";
      AluOp_SHA512SIG1L : _zz_io_output_aluOp_4_string = "SHA512SIG1L";
      AluOp_SHA512SIG1H : _zz_io_output_aluOp_4_string = "SHA512SIG1H";
      AluOp_SM3P0 : _zz_io_output_aluOp_4_string = "SM3P0      ";
      AluOp_SM3P1 : _zz_io_output_aluOp_4_string = "SM3P1      ";
      AluOp_SM4ED : _zz_io_output_aluOp_4_string = "SM4ED      ";
      AluOp_SM4KS : _zz_io_output_aluOp_4_string = "SM4KS      ";
      default : _zz_io_output_aluOp_4_string = "???????????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_aluOp_5)
      AluOp_ADD : _zz_io_output_aluOp_5_string = "ADD        ";
      AluOp_SUB : _zz_io_output_aluOp_5_string = "SUB        ";
      AluOp_SLL_1 : _zz_io_output_aluOp_5_string = "SLL_1      ";
      AluOp_SLT : _zz_io_output_aluOp_5_string = "SLT        ";
      AluOp_SLTU : _zz_io_output_aluOp_5_string = "SLTU       ";
      AluOp_XOR_1 : _zz_io_output_aluOp_5_string = "XOR_1      ";
      AluOp_SRL_1 : _zz_io_output_aluOp_5_string = "SRL_1      ";
      AluOp_SRA_1 : _zz_io_output_aluOp_5_string = "SRA_1      ";
      AluOp_OR_1 : _zz_io_output_aluOp_5_string = "OR_1       ";
      AluOp_AND_1 : _zz_io_output_aluOp_5_string = "AND_1      ";
      AluOp_ADDW : _zz_io_output_aluOp_5_string = "ADDW       ";
      AluOp_SUBW : _zz_io_output_aluOp_5_string = "SUBW       ";
      AluOp_SLLW : _zz_io_output_aluOp_5_string = "SLLW       ";
      AluOp_SRLW : _zz_io_output_aluOp_5_string = "SRLW       ";
      AluOp_SRAW : _zz_io_output_aluOp_5_string = "SRAW       ";
      AluOp_MUL : _zz_io_output_aluOp_5_string = "MUL        ";
      AluOp_MULH : _zz_io_output_aluOp_5_string = "MULH       ";
      AluOp_MULHSU : _zz_io_output_aluOp_5_string = "MULHSU     ";
      AluOp_MULHU : _zz_io_output_aluOp_5_string = "MULHU      ";
      AluOp_DIV : _zz_io_output_aluOp_5_string = "DIV        ";
      AluOp_DIVU : _zz_io_output_aluOp_5_string = "DIVU       ";
      AluOp_REM_1 : _zz_io_output_aluOp_5_string = "REM_1      ";
      AluOp_REMU : _zz_io_output_aluOp_5_string = "REMU       ";
      AluOp_MULW : _zz_io_output_aluOp_5_string = "MULW       ";
      AluOp_DIVW : _zz_io_output_aluOp_5_string = "DIVW       ";
      AluOp_DIVUW : _zz_io_output_aluOp_5_string = "DIVUW      ";
      AluOp_REMW : _zz_io_output_aluOp_5_string = "REMW       ";
      AluOp_REMUW : _zz_io_output_aluOp_5_string = "REMUW      ";
      AluOp_ANDN : _zz_io_output_aluOp_5_string = "ANDN       ";
      AluOp_ORN : _zz_io_output_aluOp_5_string = "ORN        ";
      AluOp_XNOR_1 : _zz_io_output_aluOp_5_string = "XNOR_1     ";
      AluOp_CLZ : _zz_io_output_aluOp_5_string = "CLZ        ";
      AluOp_CTZ : _zz_io_output_aluOp_5_string = "CTZ        ";
      AluOp_CPOP : _zz_io_output_aluOp_5_string = "CPOP       ";
      AluOp_SEXTB : _zz_io_output_aluOp_5_string = "SEXTB      ";
      AluOp_SEXTH : _zz_io_output_aluOp_5_string = "SEXTH      ";
      AluOp_ZEXTH : _zz_io_output_aluOp_5_string = "ZEXTH      ";
      AluOp_ORCB : _zz_io_output_aluOp_5_string = "ORCB       ";
      AluOp_REV8 : _zz_io_output_aluOp_5_string = "REV8       ";
      AluOp_ROL_1 : _zz_io_output_aluOp_5_string = "ROL_1      ";
      AluOp_ROR_1 : _zz_io_output_aluOp_5_string = "ROR_1      ";
      AluOp_MIN : _zz_io_output_aluOp_5_string = "MIN        ";
      AluOp_MINU : _zz_io_output_aluOp_5_string = "MINU       ";
      AluOp_MAX : _zz_io_output_aluOp_5_string = "MAX        ";
      AluOp_MAXU : _zz_io_output_aluOp_5_string = "MAXU       ";
      AluOp_BSET : _zz_io_output_aluOp_5_string = "BSET       ";
      AluOp_BCLR : _zz_io_output_aluOp_5_string = "BCLR       ";
      AluOp_BINV : _zz_io_output_aluOp_5_string = "BINV       ";
      AluOp_BEXT : _zz_io_output_aluOp_5_string = "BEXT       ";
      AluOp_SH1ADD : _zz_io_output_aluOp_5_string = "SH1ADD     ";
      AluOp_SH2ADD : _zz_io_output_aluOp_5_string = "SH2ADD     ";
      AluOp_SH3ADD : _zz_io_output_aluOp_5_string = "SH3ADD     ";
      AluOp_ADDUW : _zz_io_output_aluOp_5_string = "ADDUW      ";
      AluOp_SH1ADDUW : _zz_io_output_aluOp_5_string = "SH1ADDUW   ";
      AluOp_SH2ADDUW : _zz_io_output_aluOp_5_string = "SH2ADDUW   ";
      AluOp_SH3ADDUW : _zz_io_output_aluOp_5_string = "SH3ADDUW   ";
      AluOp_SLLIUW : _zz_io_output_aluOp_5_string = "SLLIUW     ";
      AluOp_CLMUL : _zz_io_output_aluOp_5_string = "CLMUL      ";
      AluOp_CLMULH : _zz_io_output_aluOp_5_string = "CLMULH     ";
      AluOp_CLMULR : _zz_io_output_aluOp_5_string = "CLMULR     ";
      AluOp_PACK : _zz_io_output_aluOp_5_string = "PACK       ";
      AluOp_PACKH : _zz_io_output_aluOp_5_string = "PACKH      ";
      AluOp_PACKW : _zz_io_output_aluOp_5_string = "PACKW      ";
      AluOp_BREV8 : _zz_io_output_aluOp_5_string = "BREV8      ";
      AluOp_ZIP : _zz_io_output_aluOp_5_string = "ZIP        ";
      AluOp_UNZIP : _zz_io_output_aluOp_5_string = "UNZIP      ";
      AluOp_XPERM4 : _zz_io_output_aluOp_5_string = "XPERM4     ";
      AluOp_XPERM8 : _zz_io_output_aluOp_5_string = "XPERM8     ";
      AluOp_CLZW : _zz_io_output_aluOp_5_string = "CLZW       ";
      AluOp_CTZW : _zz_io_output_aluOp_5_string = "CTZW       ";
      AluOp_CPOPW : _zz_io_output_aluOp_5_string = "CPOPW      ";
      AluOp_ROLW : _zz_io_output_aluOp_5_string = "ROLW       ";
      AluOp_RORW : _zz_io_output_aluOp_5_string = "RORW       ";
      AluOp_SHA256SUM0 : _zz_io_output_aluOp_5_string = "SHA256SUM0 ";
      AluOp_SHA256SUM1 : _zz_io_output_aluOp_5_string = "SHA256SUM1 ";
      AluOp_SHA256SIG0 : _zz_io_output_aluOp_5_string = "SHA256SIG0 ";
      AluOp_SHA256SIG1 : _zz_io_output_aluOp_5_string = "SHA256SIG1 ";
      AluOp_SHA512SUM0 : _zz_io_output_aluOp_5_string = "SHA512SUM0 ";
      AluOp_SHA512SUM1 : _zz_io_output_aluOp_5_string = "SHA512SUM1 ";
      AluOp_SHA512SIG0 : _zz_io_output_aluOp_5_string = "SHA512SIG0 ";
      AluOp_SHA512SIG1 : _zz_io_output_aluOp_5_string = "SHA512SIG1 ";
      AluOp_SHA512SUM0R : _zz_io_output_aluOp_5_string = "SHA512SUM0R";
      AluOp_SHA512SUM1R : _zz_io_output_aluOp_5_string = "SHA512SUM1R";
      AluOp_SHA512SIG0L : _zz_io_output_aluOp_5_string = "SHA512SIG0L";
      AluOp_SHA512SIG0H : _zz_io_output_aluOp_5_string = "SHA512SIG0H";
      AluOp_SHA512SIG1L : _zz_io_output_aluOp_5_string = "SHA512SIG1L";
      AluOp_SHA512SIG1H : _zz_io_output_aluOp_5_string = "SHA512SIG1H";
      AluOp_SM3P0 : _zz_io_output_aluOp_5_string = "SM3P0      ";
      AluOp_SM3P1 : _zz_io_output_aluOp_5_string = "SM3P1      ";
      AluOp_SM4ED : _zz_io_output_aluOp_5_string = "SM4ED      ";
      AluOp_SM4KS : _zz_io_output_aluOp_5_string = "SM4KS      ";
      default : _zz_io_output_aluOp_5_string = "???????????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_aluOp_6)
      AluOp_ADD : _zz_io_output_aluOp_6_string = "ADD        ";
      AluOp_SUB : _zz_io_output_aluOp_6_string = "SUB        ";
      AluOp_SLL_1 : _zz_io_output_aluOp_6_string = "SLL_1      ";
      AluOp_SLT : _zz_io_output_aluOp_6_string = "SLT        ";
      AluOp_SLTU : _zz_io_output_aluOp_6_string = "SLTU       ";
      AluOp_XOR_1 : _zz_io_output_aluOp_6_string = "XOR_1      ";
      AluOp_SRL_1 : _zz_io_output_aluOp_6_string = "SRL_1      ";
      AluOp_SRA_1 : _zz_io_output_aluOp_6_string = "SRA_1      ";
      AluOp_OR_1 : _zz_io_output_aluOp_6_string = "OR_1       ";
      AluOp_AND_1 : _zz_io_output_aluOp_6_string = "AND_1      ";
      AluOp_ADDW : _zz_io_output_aluOp_6_string = "ADDW       ";
      AluOp_SUBW : _zz_io_output_aluOp_6_string = "SUBW       ";
      AluOp_SLLW : _zz_io_output_aluOp_6_string = "SLLW       ";
      AluOp_SRLW : _zz_io_output_aluOp_6_string = "SRLW       ";
      AluOp_SRAW : _zz_io_output_aluOp_6_string = "SRAW       ";
      AluOp_MUL : _zz_io_output_aluOp_6_string = "MUL        ";
      AluOp_MULH : _zz_io_output_aluOp_6_string = "MULH       ";
      AluOp_MULHSU : _zz_io_output_aluOp_6_string = "MULHSU     ";
      AluOp_MULHU : _zz_io_output_aluOp_6_string = "MULHU      ";
      AluOp_DIV : _zz_io_output_aluOp_6_string = "DIV        ";
      AluOp_DIVU : _zz_io_output_aluOp_6_string = "DIVU       ";
      AluOp_REM_1 : _zz_io_output_aluOp_6_string = "REM_1      ";
      AluOp_REMU : _zz_io_output_aluOp_6_string = "REMU       ";
      AluOp_MULW : _zz_io_output_aluOp_6_string = "MULW       ";
      AluOp_DIVW : _zz_io_output_aluOp_6_string = "DIVW       ";
      AluOp_DIVUW : _zz_io_output_aluOp_6_string = "DIVUW      ";
      AluOp_REMW : _zz_io_output_aluOp_6_string = "REMW       ";
      AluOp_REMUW : _zz_io_output_aluOp_6_string = "REMUW      ";
      AluOp_ANDN : _zz_io_output_aluOp_6_string = "ANDN       ";
      AluOp_ORN : _zz_io_output_aluOp_6_string = "ORN        ";
      AluOp_XNOR_1 : _zz_io_output_aluOp_6_string = "XNOR_1     ";
      AluOp_CLZ : _zz_io_output_aluOp_6_string = "CLZ        ";
      AluOp_CTZ : _zz_io_output_aluOp_6_string = "CTZ        ";
      AluOp_CPOP : _zz_io_output_aluOp_6_string = "CPOP       ";
      AluOp_SEXTB : _zz_io_output_aluOp_6_string = "SEXTB      ";
      AluOp_SEXTH : _zz_io_output_aluOp_6_string = "SEXTH      ";
      AluOp_ZEXTH : _zz_io_output_aluOp_6_string = "ZEXTH      ";
      AluOp_ORCB : _zz_io_output_aluOp_6_string = "ORCB       ";
      AluOp_REV8 : _zz_io_output_aluOp_6_string = "REV8       ";
      AluOp_ROL_1 : _zz_io_output_aluOp_6_string = "ROL_1      ";
      AluOp_ROR_1 : _zz_io_output_aluOp_6_string = "ROR_1      ";
      AluOp_MIN : _zz_io_output_aluOp_6_string = "MIN        ";
      AluOp_MINU : _zz_io_output_aluOp_6_string = "MINU       ";
      AluOp_MAX : _zz_io_output_aluOp_6_string = "MAX        ";
      AluOp_MAXU : _zz_io_output_aluOp_6_string = "MAXU       ";
      AluOp_BSET : _zz_io_output_aluOp_6_string = "BSET       ";
      AluOp_BCLR : _zz_io_output_aluOp_6_string = "BCLR       ";
      AluOp_BINV : _zz_io_output_aluOp_6_string = "BINV       ";
      AluOp_BEXT : _zz_io_output_aluOp_6_string = "BEXT       ";
      AluOp_SH1ADD : _zz_io_output_aluOp_6_string = "SH1ADD     ";
      AluOp_SH2ADD : _zz_io_output_aluOp_6_string = "SH2ADD     ";
      AluOp_SH3ADD : _zz_io_output_aluOp_6_string = "SH3ADD     ";
      AluOp_ADDUW : _zz_io_output_aluOp_6_string = "ADDUW      ";
      AluOp_SH1ADDUW : _zz_io_output_aluOp_6_string = "SH1ADDUW   ";
      AluOp_SH2ADDUW : _zz_io_output_aluOp_6_string = "SH2ADDUW   ";
      AluOp_SH3ADDUW : _zz_io_output_aluOp_6_string = "SH3ADDUW   ";
      AluOp_SLLIUW : _zz_io_output_aluOp_6_string = "SLLIUW     ";
      AluOp_CLMUL : _zz_io_output_aluOp_6_string = "CLMUL      ";
      AluOp_CLMULH : _zz_io_output_aluOp_6_string = "CLMULH     ";
      AluOp_CLMULR : _zz_io_output_aluOp_6_string = "CLMULR     ";
      AluOp_PACK : _zz_io_output_aluOp_6_string = "PACK       ";
      AluOp_PACKH : _zz_io_output_aluOp_6_string = "PACKH      ";
      AluOp_PACKW : _zz_io_output_aluOp_6_string = "PACKW      ";
      AluOp_BREV8 : _zz_io_output_aluOp_6_string = "BREV8      ";
      AluOp_ZIP : _zz_io_output_aluOp_6_string = "ZIP        ";
      AluOp_UNZIP : _zz_io_output_aluOp_6_string = "UNZIP      ";
      AluOp_XPERM4 : _zz_io_output_aluOp_6_string = "XPERM4     ";
      AluOp_XPERM8 : _zz_io_output_aluOp_6_string = "XPERM8     ";
      AluOp_CLZW : _zz_io_output_aluOp_6_string = "CLZW       ";
      AluOp_CTZW : _zz_io_output_aluOp_6_string = "CTZW       ";
      AluOp_CPOPW : _zz_io_output_aluOp_6_string = "CPOPW      ";
      AluOp_ROLW : _zz_io_output_aluOp_6_string = "ROLW       ";
      AluOp_RORW : _zz_io_output_aluOp_6_string = "RORW       ";
      AluOp_SHA256SUM0 : _zz_io_output_aluOp_6_string = "SHA256SUM0 ";
      AluOp_SHA256SUM1 : _zz_io_output_aluOp_6_string = "SHA256SUM1 ";
      AluOp_SHA256SIG0 : _zz_io_output_aluOp_6_string = "SHA256SIG0 ";
      AluOp_SHA256SIG1 : _zz_io_output_aluOp_6_string = "SHA256SIG1 ";
      AluOp_SHA512SUM0 : _zz_io_output_aluOp_6_string = "SHA512SUM0 ";
      AluOp_SHA512SUM1 : _zz_io_output_aluOp_6_string = "SHA512SUM1 ";
      AluOp_SHA512SIG0 : _zz_io_output_aluOp_6_string = "SHA512SIG0 ";
      AluOp_SHA512SIG1 : _zz_io_output_aluOp_6_string = "SHA512SIG1 ";
      AluOp_SHA512SUM0R : _zz_io_output_aluOp_6_string = "SHA512SUM0R";
      AluOp_SHA512SUM1R : _zz_io_output_aluOp_6_string = "SHA512SUM1R";
      AluOp_SHA512SIG0L : _zz_io_output_aluOp_6_string = "SHA512SIG0L";
      AluOp_SHA512SIG0H : _zz_io_output_aluOp_6_string = "SHA512SIG0H";
      AluOp_SHA512SIG1L : _zz_io_output_aluOp_6_string = "SHA512SIG1L";
      AluOp_SHA512SIG1H : _zz_io_output_aluOp_6_string = "SHA512SIG1H";
      AluOp_SM3P0 : _zz_io_output_aluOp_6_string = "SM3P0      ";
      AluOp_SM3P1 : _zz_io_output_aluOp_6_string = "SM3P1      ";
      AluOp_SM4ED : _zz_io_output_aluOp_6_string = "SM4ED      ";
      AluOp_SM4KS : _zz_io_output_aluOp_6_string = "SM4KS      ";
      default : _zz_io_output_aluOp_6_string = "???????????";
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
      case(switch_Decoder_l200)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l204) begin
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
              if(!when_Decoder_l251) begin
                io_output_regWrite = 1'b1;
              end
            end
            3'b010 : begin
              io_output_regWrite = 1'b1;
            end
            3'b011 : begin
              if(when_Decoder_l267) begin
                io_output_regWrite = 1'b1;
              end else begin
                if(!when_Decoder_l272) begin
                  io_output_regWrite = 1'b1;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l282)
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
                  if(when_Decoder_l310) begin
                    case(switch_Decoder_l312)
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
              if(!when_Decoder_l364) begin
                io_output_regWrite = 1'b1;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l372) begin
                io_output_regWrite = 1'b1;
              end
            end
            3'b100 : begin
              if(when_Decoder_l382) begin
                if(!when_Decoder_l383) begin
                  io_output_regWrite = 1'b1;
                end
              end else begin
                if(when_Decoder_l395) begin
                  if(!when_Decoder_l396) begin
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
          if(when_Decoder_l946) begin
            io_output_regWrite = 1'b1;
          end else begin
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
      case(switch_Decoder_l200)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l204) begin
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
              if(!when_Decoder_l251) begin
                io_output_aluSrc = 1'b1;
              end
            end
            3'b010 : begin
              io_output_aluSrc = 1'b1;
            end
            3'b011 : begin
              if(when_Decoder_l267) begin
                io_output_aluSrc = 1'b1;
              end else begin
                if(!when_Decoder_l272) begin
                  io_output_aluSrc = 1'b1;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l282)
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
              if(!when_Decoder_l364) begin
                io_output_aluSrc = 1'b1;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l372) begin
                io_output_aluSrc = 1'b1;
              end
            end
            3'b100 : begin
              if(when_Decoder_l382) begin
                if(when_Decoder_l383) begin
                  if(!when_Decoder_l384) begin
                    io_output_aluSrc = 1'b1;
                  end
                end
              end else begin
                if(when_Decoder_l395) begin
                  if(!when_Decoder_l396) begin
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
      case(switch_Decoder_l200)
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
              if(!when_Decoder_l364) begin
                io_output_wbSel = 3'b001;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l372) begin
                io_output_wbSel = 3'b001;
              end
            end
            3'b100 : begin
              if(when_Decoder_l382) begin
                if(when_Decoder_l383) begin
                  if(!when_Decoder_l384) begin
                    io_output_wbSel = 3'b010;
                  end
                end
              end else begin
                if(when_Decoder_l395) begin
                  if(!when_Decoder_l396) begin
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
      case(switch_Decoder_l200)
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
      case(switch_Decoder_l200)
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
              if(when_Decoder_l382) begin
                if(when_Decoder_l383) begin
                  if(!when_Decoder_l384) begin
                    io_output_jump = 1'b1;
                  end
                end
              end else begin
                if(when_Decoder_l395) begin
                  if(!when_Decoder_l396) begin
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
      case(switch_Decoder_l200)
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
              if(when_Decoder_l382) begin
                if(when_Decoder_l383) begin
                  if(!when_Decoder_l384) begin
                    io_output_jalr = 1'b1;
                  end
                end
              end else begin
                if(when_Decoder_l395) begin
                  if(!when_Decoder_l396) begin
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
      case(switch_Decoder_l200)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l204) begin
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
              if(!when_Decoder_l251) begin
                io_output_aluOp = AluOp_ADDW;
              end
            end
            3'b010 : begin
              io_output_aluOp = AluOp_ADD;
            end
            3'b011 : begin
              if(when_Decoder_l267) begin
                io_output_aluOp = AluOp_ADD;
              end else begin
                if(!when_Decoder_l272) begin
                  io_output_aluOp = AluOp_ADD;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l282)
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
                  if(when_Decoder_l310) begin
                    case(switch_Decoder_l312)
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
              if(!when_Decoder_l364) begin
                io_output_aluOp = AluOp_ADD;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l372) begin
                io_output_aluOp = AluOp_ADD;
              end
            end
            3'b100 : begin
              if(when_Decoder_l382) begin
                if(!when_Decoder_l383) begin
                  io_output_aluOp = AluOp_ADD;
                end
              end else begin
                if(!when_Decoder_l395) begin
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
              casez(funct3)
                3'b000 : begin
                  io_output_aluOp = AluOp_MULW;
                end
                3'b100 : begin
                  io_output_aluOp = AluOp_DIVW;
                end
                3'b101 : begin
                  io_output_aluOp = AluOp_DIVUW;
                end
                3'b110 : begin
                  io_output_aluOp = AluOp_REMW;
                end
                3'b111 : begin
                  io_output_aluOp = AluOp_REMUW;
                end
                default : begin
                end
              endcase
            end
            default : begin
            end
          endcase
        end
        7'b0110011 : begin
          if(when_Decoder_l946) begin
            casez(funct3)
              3'b000 : begin
                io_output_aluOp = AluOp_MUL;
              end
              3'b001 : begin
                io_output_aluOp = AluOp_MULH;
              end
              3'b010 : begin
                io_output_aluOp = AluOp_MULHSU;
              end
              3'b011 : begin
                io_output_aluOp = AluOp_MULHU;
              end
              3'b100 : begin
                io_output_aluOp = AluOp_DIV;
              end
              3'b101 : begin
                io_output_aluOp = AluOp_DIVU;
              end
              3'b110 : begin
                io_output_aluOp = AluOp_REM_1;
              end
              3'b111 : begin
                io_output_aluOp = AluOp_REMU;
              end
              default : begin
              end
            endcase
          end else begin
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
      case(switch_Decoder_l200)
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
      case(switch_Decoder_l200)
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
              if(!when_Decoder_l267) begin
                if(!when_Decoder_l272) begin
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
              if(when_Decoder_l382) begin
                if(!when_Decoder_l383) begin
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
      case(switch_Decoder_l200)
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
              if(!when_Decoder_l364) begin
                io_output_memRead = 1'b1;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l372) begin
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
      case(switch_Decoder_l200)
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
      case(switch_Decoder_l200)
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
              if(!when_Decoder_l364) begin
                io_output_memSize = 2'b10;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l372) begin
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
  assign io_output_fp = 1'b0;
  assign io_output_fpWrite = 1'b0;
  assign io_output_fpLoad = 1'b0;
  assign io_output_fpStore = 1'b0;
  assign io_output_fpIntRd = 1'b0;
  assign io_output_fpOp = 6'h0;
  assign io_output_fpRm = 3'b000;
  assign io_output_fpFmt = 1'b0;
  assign io_output_rs3 = io_instruction[31 : 27];
  always @(*) begin
    io_output_rs1 = rs1Num;
    if(isComp) begin
      case(switch_Decoder_l200)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l204) begin
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
              if(!when_Decoder_l251) begin
                io_output_rs1 = crd;
              end
            end
            3'b010 : begin
              io_output_rs1 = 5'h0;
            end
            3'b011 : begin
              if(when_Decoder_l267) begin
                io_output_rs1 = 5'h02;
              end
            end
            3'b100 : begin
              case(switch_Decoder_l282)
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
                  if(when_Decoder_l310) begin
                    case(switch_Decoder_l312)
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
              if(!when_Decoder_l364) begin
                io_output_rs1 = 5'h02;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l372) begin
                io_output_rs1 = 5'h02;
              end
            end
            3'b100 : begin
              if(when_Decoder_l382) begin
                if(when_Decoder_l383) begin
                  if(!when_Decoder_l384) begin
                    io_output_rs1 = crd;
                  end
                end
              end else begin
                if(when_Decoder_l395) begin
                  if(!when_Decoder_l396) begin
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
    end
  end

  always @(*) begin
    io_output_rs2 = io_instruction[24 : 20];
    if(isComp) begin
      case(switch_Decoder_l200)
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
              case(switch_Decoder_l282)
                2'b00 : begin
                end
                2'b01 : begin
                end
                2'b10 : begin
                end
                default : begin
                  if(when_Decoder_l310) begin
                    case(switch_Decoder_l312)
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
              if(when_Decoder_l382) begin
                if(!when_Decoder_l383) begin
                  io_output_rs2 = crs2;
                end
              end else begin
                if(!when_Decoder_l395) begin
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
    end
  end

  always @(*) begin
    io_output_rd = rdNum;
    if(isComp) begin
      case(switch_Decoder_l200)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l204) begin
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
              if(!when_Decoder_l251) begin
                io_output_rd = crd;
              end
            end
            3'b010 : begin
              io_output_rd = crd;
            end
            3'b011 : begin
              if(when_Decoder_l267) begin
                io_output_rd = 5'h02;
              end else begin
                if(!when_Decoder_l272) begin
                  io_output_rd = crd;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l282)
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
                  if(when_Decoder_l310) begin
                    case(switch_Decoder_l312)
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
              if(!when_Decoder_l364) begin
                io_output_rd = crd;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l372) begin
                io_output_rd = crd;
              end
            end
            3'b100 : begin
              if(when_Decoder_l382) begin
                if(!when_Decoder_l383) begin
                  io_output_rd = crd;
                end
              end else begin
                if(when_Decoder_l395) begin
                  if(!when_Decoder_l396) begin
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
    end
  end

  always @(*) begin
    io_output_imm = immI;
    if(isComp) begin
      case(switch_Decoder_l200)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l204) begin
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
              if(!when_Decoder_l251) begin
                io_output_imm = {{58{c6S[5]}}, c6S};
              end
            end
            3'b010 : begin
              io_output_imm = {{58{c6S[5]}}, c6S};
            end
            3'b011 : begin
              if(when_Decoder_l267) begin
                io_output_imm = {{54{cAddi16sp[9]}}, cAddi16sp};
              end else begin
                if(!when_Decoder_l272) begin
                  io_output_imm = {{46{_zz_io_output_imm_3[17]}}, _zz_io_output_imm_3};
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l282)
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
              if(!when_Decoder_l364) begin
                io_output_imm = _zz_io_output_imm_4;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l372) begin
                io_output_imm = {{55{cLdspImm[8]}}, cLdspImm};
              end
            end
            3'b100 : begin
              if(when_Decoder_l382) begin
                if(when_Decoder_l383) begin
                  if(!when_Decoder_l384) begin
                    io_output_imm = 64'h0;
                  end
                end
              end else begin
                if(when_Decoder_l395) begin
                  if(!when_Decoder_l396) begin
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

  assign io_output_bs = 2'b00;
  always @(*) begin
    io_output_illegal = 1'b0;
    if(isComp) begin
      case(switch_Decoder_l200)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(when_Decoder_l204) begin
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
              if(when_Decoder_l251) begin
                io_output_illegal = 1'b1;
              end
            end
            3'b010 : begin
            end
            3'b011 : begin
              if(!when_Decoder_l267) begin
                if(when_Decoder_l272) begin
                  io_output_illegal = 1'b1;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l282)
                2'b00 : begin
                end
                2'b01 : begin
                end
                2'b10 : begin
                end
                default : begin
                  if(when_Decoder_l310) begin
                    case(switch_Decoder_l312)
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
              if(when_Decoder_l364) begin
                io_output_illegal = 1'b1;
              end
            end
            3'b011 : begin
              if(when_Decoder_l372) begin
                io_output_illegal = 1'b1;
              end
            end
            3'b100 : begin
              if(when_Decoder_l382) begin
                if(when_Decoder_l383) begin
                  if(when_Decoder_l384) begin
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
          io_output_illegal = 1'b1;
        end
        7'b0100111 : begin
          io_output_illegal = 1'b1;
        end
        7'b1010011 : begin
          io_output_illegal = 1'b1;
        end
        7'b1000011 : begin
          io_output_illegal = 1'b1;
        end
        7'b1000111 : begin
          io_output_illegal = 1'b1;
        end
        7'b1001011 : begin
          io_output_illegal = 1'b1;
        end
        7'b1001111 : begin
          io_output_illegal = 1'b1;
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
              casez(funct3)
                3'b000 : begin
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
            default : begin
              io_output_illegal = 1'b1;
            end
          endcase
        end
        7'b0110011 : begin
          if(when_Decoder_l946) begin
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
      case(switch_Decoder_l200)
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
              if(!when_Decoder_l382) begin
                if(when_Decoder_l395) begin
                  if(when_Decoder_l396) begin
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
              casez(switch_Decoder_l1128)
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
      case(switch_Decoder_l200)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(when_Decoder_l204) begin
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
              if(when_Decoder_l251) begin
                io_output_valid = 1'b0;
              end
            end
            3'b010 : begin
            end
            3'b011 : begin
              if(!when_Decoder_l267) begin
                if(when_Decoder_l272) begin
                  io_output_valid = 1'b0;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l282)
                2'b00 : begin
                end
                2'b01 : begin
                end
                2'b10 : begin
                end
                default : begin
                  if(when_Decoder_l310) begin
                    case(switch_Decoder_l312)
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
              if(when_Decoder_l364) begin
                io_output_valid = 1'b0;
              end
            end
            3'b011 : begin
              if(when_Decoder_l372) begin
                io_output_valid = 1'b0;
              end
            end
            3'b100 : begin
              if(when_Decoder_l382) begin
                if(when_Decoder_l383) begin
                  if(when_Decoder_l384) begin
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
          io_output_valid = 1'b0;
        end
        7'b0100111 : begin
          io_output_valid = 1'b0;
        end
        7'b1010011 : begin
          io_output_valid = 1'b0;
        end
        7'b1000011 : begin
          io_output_valid = 1'b0;
        end
        7'b1000111 : begin
          io_output_valid = 1'b0;
        end
        7'b1001011 : begin
          io_output_valid = 1'b0;
        end
        7'b1001111 : begin
          io_output_valid = 1'b0;
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
              casez(funct3)
                3'b000 : begin
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
            default : begin
              io_output_valid = 1'b0;
            end
          endcase
        end
        7'b0110011 : begin
          if(when_Decoder_l946) begin
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
              casez(switch_Decoder_l1128)
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

  assign when_Decoder_l163 = (io_output_csrOp == CsrOp_WRITE);
  always @(*) begin
    if(when_Decoder_l163) begin
      csrWrite = (io_output_csrImm ? 1'b1 : (rs1Num != 5'h0));
    end else begin
      csrWrite = (rs1Num != 5'h0);
    end
  end

  assign isComp = (io_instruction[1 : 0] != 2'b11);
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
  assign switch_Decoder_l200 = io_instruction[1 : 0];
  assign when_Decoder_l204 = (cAddi4spn == 10'h0);
  assign when_Decoder_l251 = (crd == 5'h0);
  assign when_Decoder_l267 = (crd == 5'h02);
  assign when_Decoder_l272 = ((crd == 5'h0) || (c6 == 6'h0));
  assign switch_Decoder_l282 = io_instruction[11 : 10];
  assign when_Decoder_l310 = io_instruction[12];
  assign switch_Decoder_l312 = io_instruction[6 : 5];
  assign _zz_io_output_aluOp = (io_instruction[5] ? AluOp_AND_1 : AluOp_OR_1);
  assign _zz_io_output_aluOp_1 = (io_instruction[5] ? AluOp_XOR_1 : AluOp_SUB);
  assign _zz_io_output_aluOp_2 = (io_instruction[6] ? _zz_io_output_aluOp : _zz_io_output_aluOp_1);
  assign when_Decoder_l364 = (crd == 5'h0);
  assign when_Decoder_l372 = (crd == 5'h0);
  assign when_Decoder_l382 = (io_instruction[12] == 1'b0);
  assign when_Decoder_l383 = (crs2 == 5'h0);
  assign when_Decoder_l384 = (crd == 5'h0);
  assign when_Decoder_l395 = (crs2 == 5'h0);
  assign when_Decoder_l396 = (crd == 5'h0);
  assign _zz_io_output_aluOp_3 = (io_instruction[30] ? AluOp_SRA_1 : AluOp_SRL_1);
  assign _zz_io_output_aluOp_4 = (io_instruction[30] ? AluOp_SRAW : AluOp_SRLW);
  assign when_Decoder_l946 = ((funct7 & 7'h7f) == 7'h01);
  assign _zz_io_output_aluOp_5 = (io_instruction[30] ? AluOp_SUB : AluOp_ADD);
  assign _zz_io_output_aluOp_6 = (io_instruction[30] ? AluOp_SRA_1 : AluOp_SRL_1);
  assign switch_Decoder_l1128 = io_instruction[31 : 20];

endmodule
