// Generator : SpinalHDL v1.14.2    git head : 78f29dc66110fc099a777992b6daa2f803ab445e
// Component : RiscvCoreBA
// Git hash  : 1b09f33b8a48a8760471c5ca3293a4221c6c4fdd

`timescale 1ns/1ps

module RiscvCoreBA (
  output wire          io_iBus_valid,
  output wire [31:0]   io_iBus_pc,
  input  wire          io_iBus_ready,
  input  wire [31:0]   io_iBus_instruction,
  output wire          io_dBus_valid,
  output wire          io_dBus_write,
  output wire [1:0]    io_dBus_size,
  output wire [31:0]   io_dBus_address,
  output reg  [31:0]   io_dBus_writeData,
  output reg  [3:0]    io_dBus_writeMask,
  input  wire          io_dBus_ready,
  input  wire [31:0]   io_dBus_readData,
  input  wire          io_timerInterrupt,
  output wire [31:0]   io_debugPc,
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
  output wire [31:0]   io_debugMepc,
  output wire [31:0]   io_debugMcause,
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
  wire                csrFile_1_io_csrWe;
  wire       [31:0]   csrFile_1_io_trapEpc;
  wire       [31:0]   csrFile_1_io_trapCause;
  wire       [31:0]   csrFile_1_io_trapTval;
  wire                divider_1_io_start;
  wire       [31:0]   divider_1_io_a;
  wire       [31:0]   divider_1_io_b;
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
  wire       [31:0]   decoder_1_io_output_imm;
  wire                decoder_1_io_output_illegal;
  wire       [1:0]    decoder_1_io_output_csrOp;
  wire       [11:0]   decoder_1_io_output_csrAddr;
  wire                decoder_1_io_output_csrImm;
  wire                decoder_1_io_output_csrWe;
  wire       [2:0]    decoder_1_io_output_sysOp;
  wire                decoder_1_io_output_valid;
  wire       [31:0]   regFile_io_rs1Data;
  wire       [31:0]   regFile_io_rs2Data;
  wire       [31:0]   regFile_io_debugRegs_0;
  wire       [31:0]   regFile_io_debugRegs_1;
  wire       [31:0]   regFile_io_debugRegs_2;
  wire       [31:0]   regFile_io_debugRegs_3;
  wire       [31:0]   regFile_io_debugRegs_4;
  wire       [31:0]   regFile_io_debugRegs_5;
  wire       [31:0]   regFile_io_debugRegs_6;
  wire       [31:0]   regFile_io_debugRegs_7;
  wire       [31:0]   regFile_io_debugRegs_8;
  wire       [31:0]   regFile_io_debugRegs_9;
  wire       [31:0]   regFile_io_debugRegs_10;
  wire       [31:0]   regFile_io_debugRegs_11;
  wire       [31:0]   regFile_io_debugRegs_12;
  wire       [31:0]   regFile_io_debugRegs_13;
  wire       [31:0]   regFile_io_debugRegs_14;
  wire       [31:0]   regFile_io_debugRegs_15;
  wire       [31:0]   regFile_io_debugRegs_16;
  wire       [31:0]   regFile_io_debugRegs_17;
  wire       [31:0]   regFile_io_debugRegs_18;
  wire       [31:0]   regFile_io_debugRegs_19;
  wire       [31:0]   regFile_io_debugRegs_20;
  wire       [31:0]   regFile_io_debugRegs_21;
  wire       [31:0]   regFile_io_debugRegs_22;
  wire       [31:0]   regFile_io_debugRegs_23;
  wire       [31:0]   regFile_io_debugRegs_24;
  wire       [31:0]   regFile_io_debugRegs_25;
  wire       [31:0]   regFile_io_debugRegs_26;
  wire       [31:0]   regFile_io_debugRegs_27;
  wire       [31:0]   regFile_io_debugRegs_28;
  wire       [31:0]   regFile_io_debugRegs_29;
  wire       [31:0]   regFile_io_debugRegs_30;
  wire       [31:0]   regFile_io_debugRegs_31;
  wire       [31:0]   csrFile_1_io_rdData;
  wire       [1:0]    csrFile_1_io_curMode;
  wire                csrFile_1_io_mstatusMie;
  wire       [1:0]    csrFile_1_io_mstatusMpp;
  wire       [1:0]    csrFile_1_io_mstatusFs;
  wire       [2:0]    csrFile_1_io_frm;
  wire                csrFile_1_io_mieMtie;
  wire       [31:0]   csrFile_1_io_mtvec;
  wire       [31:0]   csrFile_1_io_mepc;
  wire       [31:0]   csrFile_1_io_debugMepc;
  wire       [31:0]   csrFile_1_io_debugMcause;
  wire       [1:0]    csrFile_1_io_debugMode;
  wire       [31:0]   alu_1_io_result;
  wire                divider_1_io_busy;
  wire                divider_1_io_done;
  wire       [31:0]   divider_1_io_quotient;
  wire       [31:0]   divider_1_io_remainder;
  wire       [31:0]   _zz_aluResult;
  wire       [31:0]   _zz_csrWrDataEx;
  wire       [31:0]   _zz_branchCond;
  wire       [31:0]   _zz_branchCond_1;
  wire       [31:0]   _zz_branchCond_2;
  wire       [31:0]   _zz_branchCond_3;
  wire       [31:0]   _zz_ctrlTarget;
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
  wire       [31:0]   _zz_exTrapTval;
  wire       [31:0]   _zz_io_a_2;
  wire       [31:0]   _zz_io_b_2;
  wire       [31:0]   _zz_exAluResult_1;
  wire       [31:0]   _zz_fpToIntResult;
  wire       [31:0]   _zz_fpToIntResult_1;
  wire       [31:0]   _zz_pcReg;
  wire       [94:0]   _zz_io_dBus_writeData;
  wire       [5:0]    _zz_io_dBus_writeData_1;
  wire       [3:0]    _zz_io_dBus_writeMask;
  wire       [6:0]    _zz_io_dBus_writeMask_1;
  wire       [94:0]   _zz_io_dBus_writeData_2;
  wire       [5:0]    _zz_io_dBus_writeData_3;
  wire       [3:0]    _zz_io_dBus_writeMask_2;
  wire       [6:0]    _zz_io_dBus_writeMask_3;
  wire       [31:0]   _zz__zz_loadResult;
  wire       [5:0]    _zz__zz_loadResult_1;
  wire       [31:0]   _zz_loadResult_3;
  wire       [7:0]    _zz_loadResult_4;
  wire       [31:0]   _zz_loadResult_5;
  wire       [31:0]   _zz__zz_loadResult_1_1;
  wire       [5:0]    _zz__zz_loadResult_1_2;
  wire       [31:0]   _zz_loadResult_6;
  wire       [15:0]   _zz_loadResult_7;
  wire       [31:0]   _zz_loadResult_8;
  wire       [31:0]   _zz__zz_loadResult_2;
  wire       [5:0]    _zz__zz_loadResult_2_1;
  wire       [31:0]   _zz_loadResult_9;
  wire       [1:0]    MODE_U;
  wire       [1:0]    MODE_M;
  reg        [31:0]   pcReg;
  wire                mis32;
  wire       [15:0]   hiReg;
  wire                mis32Start;
  wire                mis32Stall;
  wire       [31:0]   fetchInstr;
  wire       [2:0]    fetchLen;
  wire                fetchCompressed;
  reg                 ifId_valid;
  reg        [31:0]   ifId_pc;
  reg        [31:0]   ifId_instruction;
  reg                 ifId_compressed;
  reg                 idEx_valid;
  reg        [31:0]   idEx_pc;
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
  reg        [31:0]   idEx_imm;
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
  reg        [31:0]   exMem_fpRs2Data;
  reg                 exMem_regWrite;
  reg        [4:0]    exMem_rd;
  reg        [2:0]    exMem_wbSel;
  reg        [31:0]   exMem_aluResult;
  reg        [31:0]   exMem_rs2Data;
  reg        [1:0]    exMem_csrOp;
  reg                 exMem_csrWe;
  reg        [11:0]   exMem_csrAddr;
  reg        [31:0]   exMem_csrWrData;
  reg                 memWb_valid;
  reg                 memWb_regWrite;
  reg        [4:0]    memWb_rd;
  reg        [2:0]    memWb_wbSel;
  reg        [31:0]   memWb_wbData;
  reg                 memWb_fp;
  reg                 memWb_fpWrite;
  reg        [4:0]    memWb_fpFlags;
  reg        [1:0]    memWb_csrOp;
  reg                 memWb_csrWe;
  reg        [11:0]   memWb_csrAddr;
  reg        [31:0]   memWb_csrWrData;
  wire       [0:0]    fpRs1Data;
  wire       [0:0]    fpRs2Data;
  wire       [0:0]    fpRs3Data;
  wire       [31:0]   wbWriteData;
  reg        [31:0]   forwardRs1;
  wire                when_RiscvCore_l395;
  wire                when_RiscvCore_l397;
  reg        [31:0]   forwardRs2;
  wire                when_RiscvCore_l410;
  wire                when_RiscvCore_l412;
  wire       [0:0]    fpFwdRs1;
  wire       [0:0]    fpFwdRs2;
  wire       [0:0]    fpFwdRs3;
  reg        [31:0]   aluA;
  wire       [31:0]   aluB;
  wire       [31:0]   instrLenEx;
  reg        [31:0]   aluResult;
  reg        [31:0]   csrWrDataEx;
  reg                 branchCond;
  wire                branchTaken;
  wire                jumpTaken;
  wire                ctrlFlush;
  reg        [31:0]   ctrlTarget;
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
  reg        [31:0]   exTrapCause;
  reg        [31:0]   exTrapTval;
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
  wire       [31:0]   exAluResult;
  wire       [31:0]   _zz_io_a;
  wire       [31:0]   _zz_io_b;
  wire       [31:0]   _zz_io_a_1;
  wire       [31:0]   _zz_io_b_1;
  wire       [31:0]   _zz_exAluResult;
  wire                isFpCompute;
  wire                isFpFromInt;
  wire                isFpMvW;
  wire                isFpMvX;
  wire       [2:0]    fpRmEx;
  wire       [63:0]   fpuResult;
  wire       [4:0]    fpuFlags;
  wire       [31:0]   fpToIntResult;
  wire       [31:0]   fpToFpResult;
  wire                fpResultIsSingle;
  wire       [31:0]   exAluResultFp;
  wire                scSuccess;
  wire                amoStall;
  wire                amoDriveRead;
  wire                amoDriveWrite;
  wire       [31:0]   amoNewValue;
  wire       [31:0]   amoOldValue;
  wire                otherFreeze;
  wire                freezeAll;
  wire                intrTake;
  reg        [31:0]   intrEpc;
  wire                trapCommit;
  wire                exMret;
  wire       [31:0]   trapEntry;
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
  wire       [1:0]    storeOffset;
  wire       [31:0]   intStoreValue;
  wire       [31:0]   storeValue;
  reg        [31:0]   loadResult;
  wire       [7:0]    _zz_loadResult;
  wire       [15:0]   _zz_loadResult_1;
  wire       [31:0]   _zz_loadResult_2;
  wire       [0:0]    fpLoadData;
  wire                when_RiscvCore_l1131;
  `ifndef SYNTHESIS
  reg [63:0] idEx_aluOp_string;
  reg [31:0] idEx_branchType_string;
  reg [39:0] idEx_csrOp_string;
  reg [55:0] idEx_sysOp_string;
  reg [39:0] exMem_csrOp_string;
  reg [39:0] memWb_csrOp_string;
  `endif


  assign _zz_aluResult = (idEx_pc + instrLenEx);
  assign _zz_csrWrDataEx = {27'd0, idEx_rs1};
  assign _zz_branchCond = forwardRs1;
  assign _zz_branchCond_1 = forwardRs2;
  assign _zz_branchCond_2 = forwardRs2;
  assign _zz_branchCond_3 = forwardRs1;
  assign _zz_ctrlTarget = (forwardRs1 + idEx_imm);
  assign _zz_exTrapCause = ((csrFile_1_io_curMode == MODE_U) ? 4'b1000 : ((csrFile_1_io_curMode == 2'b01) ? 4'b1001 : 4'b1011));
  assign _zz_exTrapTval = {20'd0, idEx_csrAddr};
  assign _zz_io_a_2 = _zz_io_a_1;
  assign _zz_io_b_2 = _zz_io_b_1;
  assign _zz_exAluResult_1 = _zz_exAluResult[31 : 0];
  assign _zz_fpToIntResult = fpuResult[31 : 0];
  assign _zz_fpToIntResult_1 = fpuResult[31:0];
  assign _zz_pcReg = {29'd0, fetchLen};
  assign _zz_io_dBus_writeData = ({63'd0,storeValue} <<< _zz_io_dBus_writeData_1);
  assign _zz_io_dBus_writeData_1 = (storeOffset * 4'b1000);
  assign _zz_io_dBus_writeMask_1 = ({3'd0,4'b0001} <<< storeOffset);
  assign _zz_io_dBus_writeMask = _zz_io_dBus_writeMask_1[3:0];
  assign _zz_io_dBus_writeData_2 = ({63'd0,storeValue} <<< _zz_io_dBus_writeData_3);
  assign _zz_io_dBus_writeData_3 = (storeOffset * 4'b1000);
  assign _zz_io_dBus_writeMask_3 = ({3'd0,4'b0011} <<< storeOffset);
  assign _zz_io_dBus_writeMask_2 = _zz_io_dBus_writeMask_3[3:0];
  assign _zz__zz_loadResult = (io_dBus_readData >>> _zz__zz_loadResult_1);
  assign _zz__zz_loadResult_1 = (storeOffset * 4'b1000);
  assign _zz_loadResult_4 = _zz_loadResult;
  assign _zz_loadResult_3 = {{24{_zz_loadResult_4[7]}}, _zz_loadResult_4};
  assign _zz_loadResult_5 = {24'd0, _zz_loadResult};
  assign _zz__zz_loadResult_1_1 = (io_dBus_readData >>> _zz__zz_loadResult_1_2);
  assign _zz__zz_loadResult_1_2 = (storeOffset * 4'b1000);
  assign _zz_loadResult_7 = _zz_loadResult_1;
  assign _zz_loadResult_6 = {{16{_zz_loadResult_7[15]}}, _zz_loadResult_7};
  assign _zz_loadResult_8 = {16'd0, _zz_loadResult_1};
  assign _zz__zz_loadResult_2 = (io_dBus_readData >>> _zz__zz_loadResult_2_1);
  assign _zz__zz_loadResult_2_1 = (storeOffset * 4'b1000);
  assign _zz_loadResult_9 = _zz_loadResult_2;
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
    .io_output_imm        (decoder_1_io_output_imm[31:0]      ), //o
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
    .io_writeData    (wbWriteData[31:0]            ), //i
    .io_writeEnable  (regFile_io_writeEnable       ), //i
    .io_rs1Data      (regFile_io_rs1Data[31:0]     ), //o
    .io_rs2Data      (regFile_io_rs2Data[31:0]     ), //o
    .io_debugRegs_0  (regFile_io_debugRegs_0[31:0] ), //o
    .io_debugRegs_1  (regFile_io_debugRegs_1[31:0] ), //o
    .io_debugRegs_2  (regFile_io_debugRegs_2[31:0] ), //o
    .io_debugRegs_3  (regFile_io_debugRegs_3[31:0] ), //o
    .io_debugRegs_4  (regFile_io_debugRegs_4[31:0] ), //o
    .io_debugRegs_5  (regFile_io_debugRegs_5[31:0] ), //o
    .io_debugRegs_6  (regFile_io_debugRegs_6[31:0] ), //o
    .io_debugRegs_7  (regFile_io_debugRegs_7[31:0] ), //o
    .io_debugRegs_8  (regFile_io_debugRegs_8[31:0] ), //o
    .io_debugRegs_9  (regFile_io_debugRegs_9[31:0] ), //o
    .io_debugRegs_10 (regFile_io_debugRegs_10[31:0]), //o
    .io_debugRegs_11 (regFile_io_debugRegs_11[31:0]), //o
    .io_debugRegs_12 (regFile_io_debugRegs_12[31:0]), //o
    .io_debugRegs_13 (regFile_io_debugRegs_13[31:0]), //o
    .io_debugRegs_14 (regFile_io_debugRegs_14[31:0]), //o
    .io_debugRegs_15 (regFile_io_debugRegs_15[31:0]), //o
    .io_debugRegs_16 (regFile_io_debugRegs_16[31:0]), //o
    .io_debugRegs_17 (regFile_io_debugRegs_17[31:0]), //o
    .io_debugRegs_18 (regFile_io_debugRegs_18[31:0]), //o
    .io_debugRegs_19 (regFile_io_debugRegs_19[31:0]), //o
    .io_debugRegs_20 (regFile_io_debugRegs_20[31:0]), //o
    .io_debugRegs_21 (regFile_io_debugRegs_21[31:0]), //o
    .io_debugRegs_22 (regFile_io_debugRegs_22[31:0]), //o
    .io_debugRegs_23 (regFile_io_debugRegs_23[31:0]), //o
    .io_debugRegs_24 (regFile_io_debugRegs_24[31:0]), //o
    .io_debugRegs_25 (regFile_io_debugRegs_25[31:0]), //o
    .io_debugRegs_26 (regFile_io_debugRegs_26[31:0]), //o
    .io_debugRegs_27 (regFile_io_debugRegs_27[31:0]), //o
    .io_debugRegs_28 (regFile_io_debugRegs_28[31:0]), //o
    .io_debugRegs_29 (regFile_io_debugRegs_29[31:0]), //o
    .io_debugRegs_30 (regFile_io_debugRegs_30[31:0]), //o
    .io_debugRegs_31 (regFile_io_debugRegs_31[31:0]), //o
    .clk             (clk                          ), //i
    .reset           (reset                        )  //i
  );
  CsrFile csrFile_1 (
    .io_timerInterrupt (io_timerInterrupt             ), //i
    .io_csrAddr        (memWb_csrAddr[11:0]           ), //i
    .io_csrOp          (memWb_csrOp[1:0]              ), //i
    .io_csrWe          (csrFile_1_io_csrWe            ), //i
    .io_csrWrData      (memWb_csrWrData[31:0]         ), //i
    .io_rdData         (csrFile_1_io_rdData[31:0]     ), //o
    .io_trapEna        (trapCommit                    ), //i
    .io_trapEpc        (csrFile_1_io_trapEpc[31:0]    ), //i
    .io_trapCause      (csrFile_1_io_trapCause[31:0]  ), //i
    .io_trapTval       (csrFile_1_io_trapTval[31:0]   ), //i
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
    .io_mtvec          (csrFile_1_io_mtvec[31:0]      ), //o
    .io_mepc           (csrFile_1_io_mepc[31:0]       ), //o
    .io_debugMepc      (csrFile_1_io_debugMepc[31:0]  ), //o
    .io_debugMcause    (csrFile_1_io_debugMcause[31:0]), //o
    .io_debugMode      (csrFile_1_io_debugMode[1:0]   ), //o
    .clk               (clk                           ), //i
    .reset             (reset                         )  //i
  );
  Alu alu_1 (
    .io_a      (aluA[31:0]           ), //i
    .io_b      (aluB[31:0]           ), //i
    .io_op     (idEx_aluOp[6:0]      ), //i
    .io_result (alu_1_io_result[31:0])  //o
  );
  Divider divider_1 (
    .io_start     (divider_1_io_start          ), //i
    .io_a         (divider_1_io_a[31:0]        ), //i
    .io_b         (divider_1_io_b[31:0]        ), //i
    .io_signed    (divSigned                   ), //i
    .io_ack       (divider_1_io_ack            ), //i
    .io_busy      (divider_1_io_busy           ), //o
    .io_done      (divider_1_io_done           ), //o
    .io_quotient  (divider_1_io_quotient[31:0] ), //o
    .io_remainder (divider_1_io_remainder[31:0]), //o
    .clk          (clk                         ), //i
    .reset        (reset                       )  //i
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
  assign fpRs1Data = 1'b0;
  assign fpRs2Data = 1'b0;
  assign fpRs3Data = 1'b0;
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
        aluA = 32'h0;
      end
    endcase
  end

  assign aluB = (idEx_aluSrc ? idEx_imm : forwardRs2);
  assign instrLenEx = (idEx_compressed ? 32'h00000002 : 32'h00000004);
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
      ctrlTarget = (_zz_ctrlTarget & (~ 32'h00000001));
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
    exTrapCause = 32'h0;
    if(idEx_valid) begin
      if(when_RiscvCore_l562) begin
        exTrapCause = {28'd0, _zz_exTrapCause};
      end
      if(when_RiscvCore_l566) begin
        exTrapCause = 32'h00000003;
      end
      if(when_RiscvCore_l570) begin
        exTrapCause = 32'h00000002;
      end
      if(csrIllegal) begin
        exTrapCause = 32'h00000002;
      end
      if(when_RiscvCore_l579) begin
        exTrapCause = 32'h00000002;
      end
      if(when_RiscvCore_l585) begin
        if(when_RiscvCore_l588) begin
          exTrapCause = (idEx_isLr ? 32'h00000004 : 32'h00000006);
        end
      end
      if(when_RiscvCore_l597) begin
        exTrapCause = 32'h00000002;
      end
      if(when_RiscvCore_l602) begin
        if(when_RiscvCore_l605) begin
          exTrapCause = (idEx_fpLoad ? 32'h00000004 : 32'h00000006);
        end
      end
    end
  end

  always @(*) begin
    exTrapTval = 32'h0;
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
  assign _zz_io_a = aluA;
  assign _zz_io_b = aluB;
  assign _zz_io_a_1 = _zz_io_a[31 : 0];
  assign _zz_io_b_1 = _zz_io_b[31 : 0];
  assign divider_1_io_a = (divIsW ? (divSigned ? _zz_io_a_2 : _zz_io_a_1) : _zz_io_a);
  assign divider_1_io_b = (divIsW ? (divSigned ? _zz_io_b_2 : _zz_io_b_1) : _zz_io_b);
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
  assign fpToIntResult = (isFpMvX ? _zz_fpToIntResult : _zz_fpToIntResult_1);
  assign fpResultIsSingle = ((isFpCompute && (! idEx_fpIntRd)) && (! idEx_fpFmt));
  assign fpToFpResult = fpuResult[31:0];
  assign exAluResultFp = (isFpCompute ? (idEx_fpIntRd ? fpToIntResult : fpToFpResult) : exAluResult);
  assign otherFreeze = (((memStall || fetchStall) || divStall) || mis32Stall);
  assign amoStall = 1'b0;
  assign amoDriveRead = 1'b0;
  assign amoDriveWrite = 1'b0;
  assign amoNewValue = 32'h0;
  assign amoOldValue = 32'h0;
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
  assign trapEntry = (csrFile_1_io_mtvec & 32'hfffffffc);
  assign csrFile_1_io_csrWe = (memWb_valid && memWb_csrWe);
  assign csrFile_1_io_trapEpc = (intrTake ? intrEpc : idEx_pc);
  assign csrFile_1_io_trapCause = (intrTake ? 32'h80000007 : exTrapCause);
  assign csrFile_1_io_trapTval = (intrTake ? 32'h0 : exTrapTval);
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
  assign storeOffset = exMem_aluResult[1 : 0];
  assign intStoreValue = (amoDriveWrite ? amoNewValue : exMem_rs2Data);
  assign storeValue = (exMem_fpStore ? exMem_fpRs2Data : intStoreValue);
  always @(*) begin
    io_dBus_writeData = 32'h0;
    case(exMem_memSize)
      2'b00 : begin
        io_dBus_writeData = _zz_io_dBus_writeData[31:0];
      end
      2'b01 : begin
        io_dBus_writeData = _zz_io_dBus_writeData_2[31:0];
      end
      2'b10 : begin
        io_dBus_writeData = storeValue;
      end
      default : begin
        io_dBus_writeData = storeValue;
      end
    endcase
  end

  always @(*) begin
    io_dBus_writeMask = 4'b0000;
    case(exMem_memSize)
      2'b00 : begin
        io_dBus_writeMask = _zz_io_dBus_writeMask;
      end
      2'b01 : begin
        io_dBus_writeMask = _zz_io_dBus_writeMask_2;
      end
      2'b10 : begin
        io_dBus_writeMask = 4'b1111;
      end
      default : begin
        io_dBus_writeMask = 4'b1111;
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
        loadResult = (exMem_memSign ? _zz_loadResult_9 : _zz_loadResult_2);
      end
      default : begin
        loadResult = io_dBus_readData;
      end
    endcase
  end

  assign _zz_loadResult_1 = _zz__zz_loadResult_1_1[15 : 0];
  assign _zz_loadResult_2 = _zz__zz_loadResult_2[31 : 0];
  assign fpLoadData = 1'b0;
  assign when_RiscvCore_l1131 = (! freezeAll);
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
      pcReg <= 32'h0;
      ifId_valid <= 1'b0;
      ifId_pc <= 32'h0;
      ifId_instruction <= 32'h0;
      ifId_compressed <= 1'b0;
      idEx_valid <= 1'b0;
      idEx_pc <= 32'h0;
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
      idEx_imm <= 32'h0;
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
      exMem_fpRs2Data <= 32'h0;
      exMem_regWrite <= 1'b0;
      exMem_rd <= 5'h0;
      exMem_wbSel <= 3'b000;
      exMem_aluResult <= 32'h0;
      exMem_rs2Data <= 32'h0;
      exMem_csrOp <= CsrOp_NONE;
      exMem_csrWe <= 1'b0;
      exMem_csrAddr <= 12'h0;
      exMem_csrWrData <= 32'h0;
      memWb_valid <= 1'b0;
      memWb_regWrite <= 1'b0;
      memWb_rd <= 5'h0;
      memWb_wbSel <= 3'b000;
      memWb_wbData <= 32'h0;
      memWb_fp <= 1'b0;
      memWb_fpWrite <= 1'b0;
      memWb_fpFlags <= 5'h0;
      memWb_csrOp <= CsrOp_NONE;
      memWb_csrWe <= 1'b0;
      memWb_csrAddr <= 12'h0;
      memWb_csrWrData <= 32'h0;
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
        exMem_fpRs2Data <= {31'd0, fpFwdRs2};
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
          memWb_wbData <= {31'd0, fpLoadData};
        end else begin
          if(exMem_atomic) begin
            memWb_wbData <= (exMem_isSc ? (scSuccess ? 32'h0 : 32'h00000001) : amoOldValue);
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
  input  wire [31:0]   io_a,
  input  wire [31:0]   io_b,
  input  wire          io_signed,
  input  wire          io_ack,
  output wire          io_busy,
  output wire          io_done,
  output wire [31:0]   io_quotient,
  output wire [31:0]   io_remainder,
  input  wire          clk,
  input  wire          reset
);

  wire       [31:0]   _zz_nextQ;
  wire       [32:0]   _zz_nextQ_1;
  wire       [31:0]   _zz_nextQ_2;
  wire       [0:0]    _zz_nextQ_3;
  wire       [31:0]   _zz_aMagIn;
  wire       [31:0]   _zz_bMagIn;
  wire       [31:0]   _zz_qFinal;
  wire       [31:0]   _zz_rFinal;
  wire       [32:0]   _zz_dSh;
  reg        [31:0]   aMagReg;
  reg        [31:0]   bMagReg;
  reg        [31:0]   aRawReg;
  reg                 signA;
  reg                 signB;
  reg                 signedOp;
  reg                 bIsZero;
  reg        [31:0]   qOut;
  reg        [31:0]   rOut;
  reg        [1:0]    state;
  reg        [5:0]    cnt;
  reg        [32:0]   rRem;
  reg        [31:0]   qAcc;
  reg        [31:0]   dSh;
  wire       [32:0]   stepRem;
  wire       [32:0]   bExt;
  wire                ge;
  wire       [32:0]   subRem;
  wire       [32:0]   nextRem;
  wire       [31:0]   nextQ;
  wire                lastStep;
  wire                aNegIn;
  wire                bNegIn;
  wire       [31:0]   aMagIn;
  wire       [31:0]   bMagIn;
  wire                qNeg;
  wire       [31:0]   qFinal;
  wire       [31:0]   rMag;
  wire       [31:0]   rFinal;
  wire       [31:0]   allOnes;
  wire       [31:0]   qRes;
  wire       [31:0]   rRes;

  assign _zz_nextQ_1 = ({1'd0,qAcc} <<< 1'd1);
  assign _zz_nextQ = _zz_nextQ_1[31:0];
  assign _zz_nextQ_3 = (ge ? 1'b1 : 1'b0);
  assign _zz_nextQ_2 = {31'd0, _zz_nextQ_3};
  assign _zz_aMagIn = (32'h0 - io_a);
  assign _zz_bMagIn = (32'h0 - io_b);
  assign _zz_qFinal = (32'h0 - nextQ);
  assign _zz_rFinal = (32'h0 - rMag);
  assign _zz_dSh = ({1'd0,dSh} <<< 1'd1);
  assign stepRem = {rRem[31 : 0],dSh[31]};
  assign bExt = {1'd0, bMagReg};
  assign ge = (bExt <= stepRem);
  assign subRem = (stepRem - bExt);
  assign nextRem = (ge ? subRem : stepRem);
  assign nextQ = (_zz_nextQ | _zz_nextQ_2);
  assign lastStep = (cnt == 6'h1f);
  assign aNegIn = io_a[31];
  assign bNegIn = io_b[31];
  assign aMagIn = ((io_signed && aNegIn) ? _zz_aMagIn : io_a);
  assign bMagIn = ((io_signed && bNegIn) ? _zz_bMagIn : io_b);
  assign qNeg = (signA ^ signB);
  assign qFinal = ((qNeg && signedOp) ? _zz_qFinal : nextQ);
  assign rMag = nextRem[31 : 0];
  assign rFinal = ((signA && signedOp) ? _zz_rFinal : rMag);
  assign allOnes = 32'hffffffff;
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
          bIsZero <= (io_b == 32'h0);
          rRem <= 33'h0;
          qAcc <= 32'h0;
          dSh <= aMagIn;
          cnt <= 6'h0;
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
            dSh <= _zz_dSh[31:0];
            cnt <= (cnt + 6'h01);
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
          bIsZero <= (io_b == 32'h0);
          rRem <= 33'h0;
          qAcc <= 32'h0;
          dSh <= aMagIn;
          cnt <= 6'h0;
        end
      end
    endcase
  end


endmodule

module Alu (
  input  wire [31:0]   io_a,
  input  wire [31:0]   io_b,
  input  wire [6:0]    io_op,
  output wire [31:0]   io_result
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

  wire       [62:0]   _zz_bitOneHot;
  wire       [63:0]   _zz_clmulFull;
  wire       [63:0]   _zz_clmulFull_1;
  wire       [63:0]   _zz_clmulFull_2;
  wire       [63:0]   _zz_clmulFull_3;
  wire       [63:0]   _zz_clmulFull_4;
  wire       [63:0]   _zz_clmulFull_5;
  wire       [63:0]   _zz_clmulFull_6;
  wire       [32:0]   _zz_clmulFull_7;
  wire                _zz_clmulFull_8;
  wire       [63:0]   _zz_clmulFull_9;
  wire       [33:0]   _zz_clmulFull_10;
  wire       [63:0]   _zz_clmulFull_11;
  wire       [63:0]   _zz_clmulFull_12;
  wire       [34:0]   _zz_clmulFull_13;
  wire       [63:0]   _zz_clmulFull_14;
  wire       [35:0]   _zz_clmulFull_15;
  wire       [63:0]   _zz_clmulFull_16;
  wire       [36:0]   _zz_clmulFull_17;
  wire       [63:0]   _zz_clmulFull_18;
  wire       [37:0]   _zz_clmulFull_19;
  wire       [63:0]   _zz_clmulFull_20;
  wire       [38:0]   _zz_clmulFull_21;
  wire       [63:0]   _zz_clmulFull_22;
  wire       [39:0]   _zz_clmulFull_23;
  wire       [63:0]   _zz_clmulFull_24;
  wire       [63:0]   _zz_clmulFull_25;
  wire       [40:0]   _zz_clmulFull_26;
  wire                _zz_clmulFull_27;
  wire       [63:0]   _zz_clmulFull_28;
  wire       [41:0]   _zz_clmulFull_29;
  wire       [63:0]   _zz_clmulFull_30;
  wire       [63:0]   _zz_clmulFull_31;
  wire       [42:0]   _zz_clmulFull_32;
  wire       [63:0]   _zz_clmulFull_33;
  wire       [43:0]   _zz_clmulFull_34;
  wire       [63:0]   _zz_clmulFull_35;
  wire       [44:0]   _zz_clmulFull_36;
  wire       [63:0]   _zz_clmulFull_37;
  wire       [45:0]   _zz_clmulFull_38;
  wire       [63:0]   _zz_clmulFull_39;
  wire       [46:0]   _zz_clmulFull_40;
  wire       [63:0]   _zz_clmulFull_41;
  wire       [47:0]   _zz_clmulFull_42;
  wire       [63:0]   _zz_clmulFull_43;
  wire       [63:0]   _zz_clmulFull_44;
  wire       [48:0]   _zz_clmulFull_45;
  wire                _zz_clmulFull_46;
  wire       [63:0]   _zz_clmulFull_47;
  wire       [49:0]   _zz_clmulFull_48;
  wire       [63:0]   _zz_clmulFull_49;
  wire       [63:0]   _zz_clmulFull_50;
  wire       [50:0]   _zz_clmulFull_51;
  wire       [63:0]   _zz_clmulFull_52;
  wire       [51:0]   _zz_clmulFull_53;
  wire       [63:0]   _zz_clmulFull_54;
  wire       [52:0]   _zz_clmulFull_55;
  wire       [63:0]   _zz_clmulFull_56;
  wire       [53:0]   _zz_clmulFull_57;
  wire       [63:0]   _zz_clmulFull_58;
  wire       [54:0]   _zz_clmulFull_59;
  wire       [63:0]   _zz_clmulFull_60;
  wire       [55:0]   _zz_clmulFull_61;
  wire       [63:0]   _zz_clmulFull_62;
  wire       [63:0]   _zz_clmulFull_63;
  wire       [56:0]   _zz_clmulFull_64;
  wire                _zz_clmulFull_65;
  wire       [63:0]   _zz_clmulFull_66;
  wire       [57:0]   _zz_clmulFull_67;
  wire       [63:0]   _zz_clmulFull_68;
  wire       [63:0]   _zz_clmulFull_69;
  wire       [58:0]   _zz_clmulFull_70;
  wire       [63:0]   _zz_clmulFull_71;
  wire       [59:0]   _zz_clmulFull_72;
  wire       [63:0]   _zz_clmulFull_73;
  wire       [60:0]   _zz_clmulFull_74;
  wire       [63:0]   _zz_clmulFull_75;
  wire       [61:0]   _zz_clmulFull_76;
  wire       [63:0]   _zz_clmulFull_77;
  wire       [62:0]   _zz_clmulFull_78;
  wire       [32:0]   _zz_bUE;
  wire       [63:0]   _zz_mulLow;
  wire       [63:0]   _zz_mulHighS;
  wire       [65:0]   _zz_mulHighSu;
  wire       [63:0]   _zz_mulHighU;
  wire       [31:0]   _zz_result_131;
  wire       [31:0]   _zz_result_132;
  wire       [31:0]   _zz_result_133;
  wire       [62:0]   _zz_result_134;
  wire       [31:0]   _zz_result_135;
  wire       [31:0]   _zz_result_136;
  wire       [31:0]   _zz_result_137;
  wire       [31:0]   _zz_result_138;
  wire       [31:0]   _zz_result_139;
  wire       [31:0]   _zz_result_140;
  wire       [62:0]   _zz_result_141;
  wire       [31:0]   _zz_result_142;
  wire       [31:0]   _zz_result_143;
  wire       [31:0]   _zz_result_144;
  wire       [31:0]   _zz_result_145;
  wire       [63:0]   _zz_result_146;
  wire       [31:0]   _zz_result_147;
  wire       [5:0]    _zz_result_148;
  wire                _zz_result_149;
  wire                _zz_result_150;
  wire       [5:0]    _zz_result_151;
  wire       [5:0]    _zz_result_152;
  wire                _zz_result_153;
  wire                _zz_result_154;
  wire       [5:0]    _zz_result_155;
  wire       [5:0]    _zz_result_156;
  wire                _zz_result_157;
  wire                _zz_result_158;
  wire       [5:0]    _zz_result_159;
  wire       [5:0]    _zz_result_160;
  wire                _zz_result_161;
  wire                _zz_result_162;
  wire       [5:0]    _zz_result_163;
  wire       [5:0]    _zz_result_164;
  wire       [31:0]   _zz_result_165;
  wire       [5:0]    _zz_result_166;
  wire                _zz_result_167;
  wire                _zz_result_168;
  wire       [5:0]    _zz_result_169;
  wire       [5:0]    _zz_result_170;
  wire                _zz_result_171;
  wire                _zz_result_172;
  wire       [5:0]    _zz_result_173;
  wire       [5:0]    _zz_result_174;
  wire                _zz_result_175;
  wire                _zz_result_176;
  wire       [5:0]    _zz_result_177;
  wire       [5:0]    _zz_result_178;
  wire                _zz_result_179;
  wire                _zz_result_180;
  wire       [5:0]    _zz_result_181;
  wire       [5:0]    _zz_result_182;
  wire       [31:0]   _zz_result_183;
  wire       [5:0]    _zz_result_184;
  wire       [6:0]    _zz_result_185;
  wire       [5:0]    _zz_result_186;
  wire       [6:0]    _zz_result_187;
  wire       [5:0]    _zz_result_188;
  wire       [6:0]    _zz_result_189;
  wire       [5:0]    _zz_result_190;
  wire       [6:0]    _zz_result_191;
  wire       [5:0]    _zz_result_192;
  wire       [6:0]    _zz_result_193;
  wire       [5:0]    _zz_result_194;
  wire       [6:0]    _zz_result_195;
  wire       [5:0]    _zz_result_196;
  wire       [6:0]    _zz_result_197;
  wire       [5:0]    _zz_result_198;
  wire       [6:0]    _zz_result_199;
  wire       [5:0]    _zz_result_200;
  wire       [6:0]    _zz_result_201;
  wire       [5:0]    _zz_result_202;
  wire       [6:0]    _zz_result_203;
  wire       [5:0]    _zz_result_204;
  wire       [6:0]    _zz_result_205;
  wire       [5:0]    _zz_result_206;
  wire       [6:0]    _zz_result_207;
  wire       [5:0]    _zz_result_208;
  wire       [6:0]    _zz_result_209;
  wire       [5:0]    _zz_result_210;
  wire       [6:0]    _zz_result_211;
  wire       [5:0]    _zz_result_212;
  wire       [6:0]    _zz_result_213;
  wire       [5:0]    _zz_result_214;
  wire       [6:0]    _zz_result_215;
  wire       [5:0]    _zz_result_216;
  wire       [6:0]    _zz_result_217;
  wire       [5:0]    _zz_result_218;
  wire       [6:0]    _zz_result_219;
  wire       [5:0]    _zz_result_220;
  wire       [6:0]    _zz_result_221;
  wire       [5:0]    _zz_result_222;
  wire       [6:0]    _zz_result_223;
  wire       [5:0]    _zz_result_224;
  wire       [6:0]    _zz_result_225;
  wire       [5:0]    _zz_result_226;
  wire       [6:0]    _zz_result_227;
  wire       [5:0]    _zz_result_228;
  wire       [6:0]    _zz_result_229;
  wire       [5:0]    _zz_result_230;
  wire       [6:0]    _zz_result_231;
  wire       [5:0]    _zz_result_232;
  wire       [6:0]    _zz_result_233;
  wire       [5:0]    _zz_result_234;
  wire       [6:0]    _zz_result_235;
  wire       [5:0]    _zz_result_236;
  wire       [6:0]    _zz_result_237;
  wire       [5:0]    _zz_result_238;
  wire       [6:0]    _zz_result_239;
  wire       [5:0]    _zz_result_240;
  wire       [6:0]    _zz_result_241;
  wire       [5:0]    _zz_result_242;
  wire       [6:0]    _zz_result_243;
  wire       [5:0]    _zz_result_244;
  wire       [6:0]    _zz_result_245;
  wire       [5:0]    _zz_result_246;
  wire       [6:0]    _zz_result_247;
  wire       [6:0]    _zz_result_248;
  wire       [1:0]    _zz_result_249;
  wire       [6:0]    _zz_result_250;
  wire       [1:0]    _zz_result_251;
  wire       [6:0]    _zz_result_252;
  wire       [1:0]    _zz_result_253;
  wire       [6:0]    _zz_result_254;
  wire       [1:0]    _zz_result_255;
  wire       [6:0]    _zz_result_256;
  wire       [1:0]    _zz_result_257;
  wire       [6:0]    _zz_result_258;
  wire       [1:0]    _zz_result_259;
  wire       [6:0]    _zz_result_260;
  wire       [1:0]    _zz_result_261;
  wire       [6:0]    _zz_result_262;
  wire       [1:0]    _zz_result_263;
  wire       [6:0]    _zz_result_264;
  wire       [1:0]    _zz_result_265;
  wire       [6:0]    _zz_result_266;
  wire       [1:0]    _zz_result_267;
  wire       [6:0]    _zz_result_268;
  wire       [1:0]    _zz_result_269;
  wire       [6:0]    _zz_result_270;
  wire       [1:0]    _zz_result_271;
  wire       [6:0]    _zz_result_272;
  wire       [1:0]    _zz_result_273;
  wire       [6:0]    _zz_result_274;
  wire       [1:0]    _zz_result_275;
  wire       [6:0]    _zz_result_276;
  wire       [1:0]    _zz_result_277;
  wire       [6:0]    _zz_result_278;
  wire       [1:0]    _zz_result_279;
  wire       [6:0]    _zz_result_280;
  wire       [1:0]    _zz_result_281;
  wire       [6:0]    _zz_result_282;
  wire       [1:0]    _zz_result_283;
  wire       [6:0]    _zz_result_284;
  wire       [1:0]    _zz_result_285;
  wire       [6:0]    _zz_result_286;
  wire       [1:0]    _zz_result_287;
  wire       [6:0]    _zz_result_288;
  wire       [1:0]    _zz_result_289;
  wire       [6:0]    _zz_result_290;
  wire       [1:0]    _zz_result_291;
  wire       [6:0]    _zz_result_292;
  wire       [1:0]    _zz_result_293;
  wire       [6:0]    _zz_result_294;
  wire       [1:0]    _zz_result_295;
  wire       [6:0]    _zz_result_296;
  wire       [1:0]    _zz_result_297;
  wire       [6:0]    _zz_result_298;
  wire       [1:0]    _zz_result_299;
  wire       [6:0]    _zz_result_300;
  wire       [1:0]    _zz_result_301;
  wire       [6:0]    _zz_result_302;
  wire       [1:0]    _zz_result_303;
  wire       [6:0]    _zz_result_304;
  wire       [1:0]    _zz_result_305;
  wire       [6:0]    _zz_result_306;
  wire       [1:0]    _zz_result_307;
  wire       [6:0]    _zz_result_308;
  wire       [1:0]    _zz_result_309;
  wire       [6:0]    _zz_result_310;
  wire       [1:0]    _zz_result_311;
  wire       [31:0]   _zz_result_312;
  wire       [7:0]    _zz_result_313;
  wire       [31:0]   _zz_result_314;
  wire       [15:0]   _zz_result_315;
  wire       [31:0]   _zz_result_316;
  wire       [15:0]   _zz_result_317;
  wire       [31:0]   _zz_result_318;
  wire       [62:0]   _zz_result_319;
  wire       [4:0]    _zz_result_320;
  wire       [31:0]   _zz_result_321;
  wire       [5:0]    _zz_result_322;
  wire       [31:0]   _zz_result_323;
  wire       [31:0]   _zz_result_324;
  wire       [94:0]   _zz_result_325;
  wire       [5:0]    _zz_result_326;
  wire       [31:0]   _zz_result_327;
  wire       [32:0]   _zz_result_328;
  wire       [32:0]   _zz_result_329;
  wire       [32:0]   _zz_result_330;
  wire       [31:0]   _zz_result_331;
  wire       [33:0]   _zz_result_332;
  wire       [33:0]   _zz_result_333;
  wire       [33:0]   _zz_result_334;
  wire       [31:0]   _zz_result_335;
  wire       [34:0]   _zz_result_336;
  wire       [34:0]   _zz_result_337;
  wire       [34:0]   _zz_result_338;
  wire       [31:0]   _zz_result_339;
  wire       [31:0]   _zz_result_340;
  wire       [32:0]   _zz_result_341;
  wire       [32:0]   _zz_result_342;
  wire       [32:0]   _zz_result_343;
  wire       [31:0]   _zz_result_344;
  wire       [33:0]   _zz_result_345;
  wire       [33:0]   _zz_result_346;
  wire       [33:0]   _zz_result_347;
  wire       [31:0]   _zz_result_348;
  wire       [34:0]   _zz_result_349;
  wire       [34:0]   _zz_result_350;
  wire       [34:0]   _zz_result_351;
  wire       [31:0]   _zz_result_352;
  wire       [62:0]   _zz_result_353;
  wire       [31:0]   _zz_result_354;
  wire       [5:0]    _zz_result_355;
  wire                _zz_result_356;
  wire                _zz_result_357;
  wire       [5:0]    _zz_result_358;
  wire       [5:0]    _zz_result_359;
  wire                _zz_result_360;
  wire                _zz_result_361;
  wire       [5:0]    _zz_result_362;
  wire       [5:0]    _zz_result_363;
  wire                _zz_result_364;
  wire                _zz_result_365;
  wire       [5:0]    _zz_result_366;
  wire       [5:0]    _zz_result_367;
  wire                _zz_result_368;
  wire                _zz_result_369;
  wire       [5:0]    _zz_result_370;
  wire       [5:0]    _zz_result_371;
  wire       [31:0]   _zz_result_372;
  wire       [5:0]    _zz_result_373;
  wire                _zz_result_374;
  wire                _zz_result_375;
  wire       [5:0]    _zz_result_376;
  wire       [5:0]    _zz_result_377;
  wire                _zz_result_378;
  wire                _zz_result_379;
  wire       [5:0]    _zz_result_380;
  wire       [5:0]    _zz_result_381;
  wire                _zz_result_382;
  wire                _zz_result_383;
  wire       [5:0]    _zz_result_384;
  wire       [5:0]    _zz_result_385;
  wire                _zz_result_386;
  wire                _zz_result_387;
  wire       [5:0]    _zz_result_388;
  wire       [5:0]    _zz_result_389;
  wire       [31:0]   _zz_result_390;
  wire       [5:0]    _zz_result_391;
  wire       [6:0]    _zz_result_392;
  wire       [5:0]    _zz_result_393;
  wire       [6:0]    _zz_result_394;
  wire       [5:0]    _zz_result_395;
  wire       [6:0]    _zz_result_396;
  wire       [5:0]    _zz_result_397;
  wire       [6:0]    _zz_result_398;
  wire       [5:0]    _zz_result_399;
  wire       [6:0]    _zz_result_400;
  wire       [5:0]    _zz_result_401;
  wire       [6:0]    _zz_result_402;
  wire       [5:0]    _zz_result_403;
  wire       [6:0]    _zz_result_404;
  wire       [5:0]    _zz_result_405;
  wire       [6:0]    _zz_result_406;
  wire       [5:0]    _zz_result_407;
  wire       [6:0]    _zz_result_408;
  wire       [5:0]    _zz_result_409;
  wire       [6:0]    _zz_result_410;
  wire       [5:0]    _zz_result_411;
  wire       [6:0]    _zz_result_412;
  wire       [5:0]    _zz_result_413;
  wire       [6:0]    _zz_result_414;
  wire       [5:0]    _zz_result_415;
  wire       [6:0]    _zz_result_416;
  wire       [5:0]    _zz_result_417;
  wire       [6:0]    _zz_result_418;
  wire       [5:0]    _zz_result_419;
  wire       [6:0]    _zz_result_420;
  wire       [5:0]    _zz_result_421;
  wire       [6:0]    _zz_result_422;
  wire       [5:0]    _zz_result_423;
  wire       [6:0]    _zz_result_424;
  wire       [5:0]    _zz_result_425;
  wire       [6:0]    _zz_result_426;
  wire       [5:0]    _zz_result_427;
  wire       [6:0]    _zz_result_428;
  wire       [5:0]    _zz_result_429;
  wire       [6:0]    _zz_result_430;
  wire       [5:0]    _zz_result_431;
  wire       [6:0]    _zz_result_432;
  wire       [5:0]    _zz_result_433;
  wire       [6:0]    _zz_result_434;
  wire       [5:0]    _zz_result_435;
  wire       [6:0]    _zz_result_436;
  wire       [5:0]    _zz_result_437;
  wire       [6:0]    _zz_result_438;
  wire       [5:0]    _zz_result_439;
  wire       [6:0]    _zz_result_440;
  wire       [5:0]    _zz_result_441;
  wire       [6:0]    _zz_result_442;
  wire       [5:0]    _zz_result_443;
  wire       [6:0]    _zz_result_444;
  wire       [5:0]    _zz_result_445;
  wire       [6:0]    _zz_result_446;
  wire       [5:0]    _zz_result_447;
  wire       [6:0]    _zz_result_448;
  wire       [5:0]    _zz_result_449;
  wire       [6:0]    _zz_result_450;
  wire       [5:0]    _zz_result_451;
  wire       [6:0]    _zz_result_452;
  wire       [5:0]    _zz_result_453;
  wire       [6:0]    _zz_result_454;
  wire       [6:0]    _zz_result_455;
  wire       [1:0]    _zz_result_456;
  wire       [6:0]    _zz_result_457;
  wire       [1:0]    _zz_result_458;
  wire       [6:0]    _zz_result_459;
  wire       [1:0]    _zz_result_460;
  wire       [6:0]    _zz_result_461;
  wire       [1:0]    _zz_result_462;
  wire       [6:0]    _zz_result_463;
  wire       [1:0]    _zz_result_464;
  wire       [6:0]    _zz_result_465;
  wire       [1:0]    _zz_result_466;
  wire       [6:0]    _zz_result_467;
  wire       [1:0]    _zz_result_468;
  wire       [6:0]    _zz_result_469;
  wire       [1:0]    _zz_result_470;
  wire       [6:0]    _zz_result_471;
  wire       [1:0]    _zz_result_472;
  wire       [6:0]    _zz_result_473;
  wire       [1:0]    _zz_result_474;
  wire       [6:0]    _zz_result_475;
  wire       [1:0]    _zz_result_476;
  wire       [6:0]    _zz_result_477;
  wire       [1:0]    _zz_result_478;
  wire       [6:0]    _zz_result_479;
  wire       [1:0]    _zz_result_480;
  wire       [6:0]    _zz_result_481;
  wire       [1:0]    _zz_result_482;
  wire       [6:0]    _zz_result_483;
  wire       [1:0]    _zz_result_484;
  wire       [6:0]    _zz_result_485;
  wire       [1:0]    _zz_result_486;
  wire       [6:0]    _zz_result_487;
  wire       [1:0]    _zz_result_488;
  wire       [6:0]    _zz_result_489;
  wire       [1:0]    _zz_result_490;
  wire       [6:0]    _zz_result_491;
  wire       [1:0]    _zz_result_492;
  wire       [6:0]    _zz_result_493;
  wire       [1:0]    _zz_result_494;
  wire       [6:0]    _zz_result_495;
  wire       [1:0]    _zz_result_496;
  wire       [6:0]    _zz_result_497;
  wire       [1:0]    _zz_result_498;
  wire       [6:0]    _zz_result_499;
  wire       [1:0]    _zz_result_500;
  wire       [6:0]    _zz_result_501;
  wire       [1:0]    _zz_result_502;
  wire       [6:0]    _zz_result_503;
  wire       [1:0]    _zz_result_504;
  wire       [6:0]    _zz_result_505;
  wire       [1:0]    _zz_result_506;
  wire       [6:0]    _zz_result_507;
  wire       [1:0]    _zz_result_508;
  wire       [6:0]    _zz_result_509;
  wire       [1:0]    _zz_result_510;
  wire       [6:0]    _zz_result_511;
  wire       [1:0]    _zz_result_512;
  wire       [6:0]    _zz_result_513;
  wire       [1:0]    _zz_result_514;
  wire       [6:0]    _zz_result_515;
  wire       [1:0]    _zz_result_516;
  wire       [6:0]    _zz_result_517;
  wire       [1:0]    _zz_result_518;
  wire       [31:0]   _zz_result_519;
  wire       [31:0]   _zz_result_520;
  wire       [62:0]   _zz_result_521;
  wire       [4:0]    _zz_result_522;
  wire       [31:0]   _zz_result_523;
  wire       [5:0]    _zz_result_524;
  wire       [31:0]   _zz_result_525;
  wire       [31:0]   _zz_result_526;
  wire       [31:0]   _zz_result_527;
  wire       [94:0]   _zz_result_528;
  wire       [5:0]    _zz_result_529;
  wire       [31:0]   aU;
  wire       [31:0]   bU;
  wire       [31:0]   aS;
  wire       [31:0]   bS;
  wire       [4:0]    shamt;
  wire       [31:0]   aW;
  wire       [31:0]   bW;
  wire       [31:0]   aWU;
  wire       [4:0]    shamtW;
  wire       [31:0]   bitOneHot;
  wire       [31:0]   aZext;
  wire       [63:0]   clmulFull;
  wire       [63:0]   mulUU;
  wire       [63:0]   mulSS;
  wire       [32:0]   aSE;
  wire       [32:0]   bUE;
  wire       [65:0]   mulSU;
  wire       [31:0]   mulLow;
  wire       [31:0]   mulHighS;
  wire       [31:0]   mulHighSu;
  wire       [31:0]   mulHighU;
  reg        [31:0]   result;
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
  wire       [5:0]    _zz_result_62;
  wire       [5:0]    _zz_result_63;
  wire       [31:0]   _zz_result_64;
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
  wire       [31:0]   _zz_result_96;
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
  wire                _zz_result_126;
  wire                _zz_result_127;
  wire       [31:0]   _zz_result_128;
  wire       [5:0]    _zz_result_129;
  wire       [5:0]    _zz_result_130;
  `ifndef SYNTHESIS
  reg [63:0] io_op_string;
  `endif


  assign _zz_bitOneHot = ({31'd0,32'h00000001} <<< shamt);
  assign _zz_clmulFull_4 = {32'd0, aU};
  assign _zz_clmulFull_7 = ({1'd0,aU} <<< 1'd1);
  assign _zz_clmulFull_6 = {31'd0, _zz_clmulFull_7};
  assign _zz_clmulFull_10 = ({2'd0,aU} <<< 2'd2);
  assign _zz_clmulFull_9 = {30'd0, _zz_clmulFull_10};
  assign _zz_clmulFull_13 = ({3'd0,aU} <<< 2'd3);
  assign _zz_clmulFull_12 = {29'd0, _zz_clmulFull_13};
  assign _zz_clmulFull_15 = ({4'd0,aU} <<< 3'd4);
  assign _zz_clmulFull_14 = {28'd0, _zz_clmulFull_15};
  assign _zz_clmulFull_17 = ({5'd0,aU} <<< 3'd5);
  assign _zz_clmulFull_16 = {27'd0, _zz_clmulFull_17};
  assign _zz_clmulFull_19 = ({6'd0,aU} <<< 3'd6);
  assign _zz_clmulFull_18 = {26'd0, _zz_clmulFull_19};
  assign _zz_clmulFull_21 = ({7'd0,aU} <<< 3'd7);
  assign _zz_clmulFull_20 = {25'd0, _zz_clmulFull_21};
  assign _zz_clmulFull_23 = ({8'd0,aU} <<< 4'd8);
  assign _zz_clmulFull_22 = {24'd0, _zz_clmulFull_23};
  assign _zz_clmulFull_26 = ({9'd0,aU} <<< 4'd9);
  assign _zz_clmulFull_25 = {23'd0, _zz_clmulFull_26};
  assign _zz_clmulFull_29 = ({10'd0,aU} <<< 4'd10);
  assign _zz_clmulFull_28 = {22'd0, _zz_clmulFull_29};
  assign _zz_clmulFull_32 = ({11'd0,aU} <<< 4'd11);
  assign _zz_clmulFull_31 = {21'd0, _zz_clmulFull_32};
  assign _zz_clmulFull_34 = ({12'd0,aU} <<< 4'd12);
  assign _zz_clmulFull_33 = {20'd0, _zz_clmulFull_34};
  assign _zz_clmulFull_36 = ({13'd0,aU} <<< 4'd13);
  assign _zz_clmulFull_35 = {19'd0, _zz_clmulFull_36};
  assign _zz_clmulFull_38 = ({14'd0,aU} <<< 4'd14);
  assign _zz_clmulFull_37 = {18'd0, _zz_clmulFull_38};
  assign _zz_clmulFull_40 = ({15'd0,aU} <<< 4'd15);
  assign _zz_clmulFull_39 = {17'd0, _zz_clmulFull_40};
  assign _zz_clmulFull_42 = ({16'd0,aU} <<< 5'd16);
  assign _zz_clmulFull_41 = {16'd0, _zz_clmulFull_42};
  assign _zz_clmulFull_45 = ({17'd0,aU} <<< 5'd17);
  assign _zz_clmulFull_44 = {15'd0, _zz_clmulFull_45};
  assign _zz_clmulFull_48 = ({18'd0,aU} <<< 5'd18);
  assign _zz_clmulFull_47 = {14'd0, _zz_clmulFull_48};
  assign _zz_clmulFull_51 = ({19'd0,aU} <<< 5'd19);
  assign _zz_clmulFull_50 = {13'd0, _zz_clmulFull_51};
  assign _zz_clmulFull_53 = ({20'd0,aU} <<< 5'd20);
  assign _zz_clmulFull_52 = {12'd0, _zz_clmulFull_53};
  assign _zz_clmulFull_55 = ({21'd0,aU} <<< 5'd21);
  assign _zz_clmulFull_54 = {11'd0, _zz_clmulFull_55};
  assign _zz_clmulFull_57 = ({22'd0,aU} <<< 5'd22);
  assign _zz_clmulFull_56 = {10'd0, _zz_clmulFull_57};
  assign _zz_clmulFull_59 = ({23'd0,aU} <<< 5'd23);
  assign _zz_clmulFull_58 = {9'd0, _zz_clmulFull_59};
  assign _zz_clmulFull_61 = ({24'd0,aU} <<< 5'd24);
  assign _zz_clmulFull_60 = {8'd0, _zz_clmulFull_61};
  assign _zz_clmulFull_64 = ({25'd0,aU} <<< 5'd25);
  assign _zz_clmulFull_63 = {7'd0, _zz_clmulFull_64};
  assign _zz_clmulFull_67 = ({26'd0,aU} <<< 5'd26);
  assign _zz_clmulFull_66 = {6'd0, _zz_clmulFull_67};
  assign _zz_clmulFull_70 = ({27'd0,aU} <<< 5'd27);
  assign _zz_clmulFull_69 = {5'd0, _zz_clmulFull_70};
  assign _zz_clmulFull_72 = ({28'd0,aU} <<< 5'd28);
  assign _zz_clmulFull_71 = {4'd0, _zz_clmulFull_72};
  assign _zz_clmulFull_74 = ({29'd0,aU} <<< 5'd29);
  assign _zz_clmulFull_73 = {3'd0, _zz_clmulFull_74};
  assign _zz_clmulFull_76 = ({30'd0,aU} <<< 5'd30);
  assign _zz_clmulFull_75 = {2'd0, _zz_clmulFull_76};
  assign _zz_clmulFull_78 = ({31'd0,aU} <<< 5'd31);
  assign _zz_clmulFull_77 = {1'd0, _zz_clmulFull_78};
  assign _zz_bUE = {1'd0, bU};
  assign _zz_mulLow = mulUU;
  assign _zz_mulHighS = mulSS;
  assign _zz_mulHighSu = mulSU;
  assign _zz_mulHighU = mulUU;
  assign _zz_result_131 = (aU + bU);
  assign _zz_result_132 = (aU - bU);
  assign _zz_result_134 = ({31'd0,aU} <<< shamt);
  assign _zz_result_133 = _zz_result_134[31:0];
  assign _zz_result_135 = (aU >>> shamt);
  assign _zz_result_136 = ($signed(aS) >>> shamt);
  assign _zz_result_137 = ($signed(aW) + $signed(bW));
  assign _zz_result_138 = ($signed(aW) - $signed(bW));
  assign _zz_result_139 = _zz_result_140;
  assign _zz_result_141 = ({31'd0,aWU} <<< shamtW);
  assign _zz_result_140 = _zz_result_141[31:0];
  assign _zz_result_142 = _zz_result_143;
  assign _zz_result_143 = (aWU >>> shamtW);
  assign _zz_result_144 = ($signed(aW) >>> shamtW);
  assign _zz_result_146 = ($signed(aW) * $signed(bW));
  assign _zz_result_145 = _zz_result_146[31:0];
  assign _zz_result_148 = (((_zz_result_30 && (! io_a[1])) && io_a[0]) ? 6'h1f : ((_zz_result_30 && io_a[1]) ? 6'h1e : ((_zz_result_29 && io_a[2]) ? 6'h1d : ((_zz_result_28 && io_a[3]) ? 6'h1c : ((_zz_result_27 && _zz_result_149) ? 6'h1b : (_zz_result_150 ? _zz_result_151 : _zz_result_152))))));
  assign _zz_result_147 = {26'd0, _zz_result_148};
  assign _zz_result_166 = (((_zz_result_61 && (! io_a[30])) && io_a[31]) ? 6'h1f : ((_zz_result_61 && io_a[30]) ? 6'h1e : ((_zz_result_60 && io_a[29]) ? 6'h1d : ((_zz_result_59 && io_a[28]) ? 6'h1c : ((_zz_result_58 && _zz_result_167) ? 6'h1b : (_zz_result_168 ? _zz_result_169 : _zz_result_170))))));
  assign _zz_result_165 = {26'd0, _zz_result_166};
  assign _zz_result_184 = _zz_result_185[5:0];
  assign _zz_result_183 = {26'd0, _zz_result_184};
  assign _zz_result_185 = ({1'b0,_zz_result_186} + _zz_result_310);
  assign _zz_result_187 = ({1'b0,_zz_result_188} + _zz_result_308);
  assign _zz_result_186 = _zz_result_187[5:0];
  assign _zz_result_189 = ({1'b0,_zz_result_190} + _zz_result_306);
  assign _zz_result_188 = _zz_result_189[5:0];
  assign _zz_result_191 = ({1'b0,_zz_result_192} + _zz_result_304);
  assign _zz_result_190 = _zz_result_191[5:0];
  assign _zz_result_193 = ({1'b0,_zz_result_194} + _zz_result_302);
  assign _zz_result_192 = _zz_result_193[5:0];
  assign _zz_result_195 = ({1'b0,_zz_result_196} + _zz_result_300);
  assign _zz_result_194 = _zz_result_195[5:0];
  assign _zz_result_197 = ({1'b0,_zz_result_198} + _zz_result_298);
  assign _zz_result_196 = _zz_result_197[5:0];
  assign _zz_result_199 = ({1'b0,_zz_result_200} + _zz_result_296);
  assign _zz_result_198 = _zz_result_199[5:0];
  assign _zz_result_201 = ({1'b0,_zz_result_202} + _zz_result_294);
  assign _zz_result_200 = _zz_result_201[5:0];
  assign _zz_result_203 = ({1'b0,_zz_result_204} + _zz_result_292);
  assign _zz_result_202 = _zz_result_203[5:0];
  assign _zz_result_205 = ({1'b0,_zz_result_206} + _zz_result_290);
  assign _zz_result_204 = _zz_result_205[5:0];
  assign _zz_result_207 = ({1'b0,_zz_result_208} + _zz_result_288);
  assign _zz_result_206 = _zz_result_207[5:0];
  assign _zz_result_209 = ({1'b0,_zz_result_210} + _zz_result_286);
  assign _zz_result_208 = _zz_result_209[5:0];
  assign _zz_result_211 = ({1'b0,_zz_result_212} + _zz_result_284);
  assign _zz_result_210 = _zz_result_211[5:0];
  assign _zz_result_213 = ({1'b0,_zz_result_214} + _zz_result_282);
  assign _zz_result_212 = _zz_result_213[5:0];
  assign _zz_result_215 = ({1'b0,_zz_result_216} + _zz_result_280);
  assign _zz_result_214 = _zz_result_215[5:0];
  assign _zz_result_217 = ({1'b0,_zz_result_218} + _zz_result_278);
  assign _zz_result_216 = _zz_result_217[5:0];
  assign _zz_result_219 = ({1'b0,_zz_result_220} + _zz_result_276);
  assign _zz_result_218 = _zz_result_219[5:0];
  assign _zz_result_221 = ({1'b0,_zz_result_222} + _zz_result_274);
  assign _zz_result_220 = _zz_result_221[5:0];
  assign _zz_result_223 = ({1'b0,_zz_result_224} + _zz_result_272);
  assign _zz_result_222 = _zz_result_223[5:0];
  assign _zz_result_225 = ({1'b0,_zz_result_226} + _zz_result_270);
  assign _zz_result_224 = _zz_result_225[5:0];
  assign _zz_result_227 = ({1'b0,_zz_result_228} + _zz_result_268);
  assign _zz_result_226 = _zz_result_227[5:0];
  assign _zz_result_229 = ({1'b0,_zz_result_230} + _zz_result_266);
  assign _zz_result_228 = _zz_result_229[5:0];
  assign _zz_result_231 = ({1'b0,_zz_result_232} + _zz_result_264);
  assign _zz_result_230 = _zz_result_231[5:0];
  assign _zz_result_233 = ({1'b0,_zz_result_234} + _zz_result_262);
  assign _zz_result_232 = _zz_result_233[5:0];
  assign _zz_result_235 = ({1'b0,_zz_result_236} + _zz_result_260);
  assign _zz_result_234 = _zz_result_235[5:0];
  assign _zz_result_237 = ({1'b0,_zz_result_238} + _zz_result_258);
  assign _zz_result_236 = _zz_result_237[5:0];
  assign _zz_result_239 = ({1'b0,_zz_result_240} + _zz_result_256);
  assign _zz_result_238 = _zz_result_239[5:0];
  assign _zz_result_241 = ({1'b0,_zz_result_242} + _zz_result_254);
  assign _zz_result_240 = _zz_result_241[5:0];
  assign _zz_result_243 = ({1'b0,_zz_result_244} + _zz_result_252);
  assign _zz_result_242 = _zz_result_243[5:0];
  assign _zz_result_245 = ({1'b0,_zz_result_246} + _zz_result_250);
  assign _zz_result_244 = _zz_result_245[5:0];
  assign _zz_result_247 = ({1'b0,6'h0} + _zz_result_248);
  assign _zz_result_246 = _zz_result_247[5:0];
  assign _zz_result_249 = {1'b0,io_a[0]};
  assign _zz_result_248 = {5'd0, _zz_result_249};
  assign _zz_result_251 = {1'b0,io_a[1]};
  assign _zz_result_250 = {5'd0, _zz_result_251};
  assign _zz_result_253 = {1'b0,io_a[2]};
  assign _zz_result_252 = {5'd0, _zz_result_253};
  assign _zz_result_255 = {1'b0,io_a[3]};
  assign _zz_result_254 = {5'd0, _zz_result_255};
  assign _zz_result_257 = {1'b0,io_a[4]};
  assign _zz_result_256 = {5'd0, _zz_result_257};
  assign _zz_result_259 = {1'b0,io_a[5]};
  assign _zz_result_258 = {5'd0, _zz_result_259};
  assign _zz_result_261 = {1'b0,io_a[6]};
  assign _zz_result_260 = {5'd0, _zz_result_261};
  assign _zz_result_263 = {1'b0,io_a[7]};
  assign _zz_result_262 = {5'd0, _zz_result_263};
  assign _zz_result_265 = {1'b0,io_a[8]};
  assign _zz_result_264 = {5'd0, _zz_result_265};
  assign _zz_result_267 = {1'b0,io_a[9]};
  assign _zz_result_266 = {5'd0, _zz_result_267};
  assign _zz_result_269 = {1'b0,io_a[10]};
  assign _zz_result_268 = {5'd0, _zz_result_269};
  assign _zz_result_271 = {1'b0,io_a[11]};
  assign _zz_result_270 = {5'd0, _zz_result_271};
  assign _zz_result_273 = {1'b0,io_a[12]};
  assign _zz_result_272 = {5'd0, _zz_result_273};
  assign _zz_result_275 = {1'b0,io_a[13]};
  assign _zz_result_274 = {5'd0, _zz_result_275};
  assign _zz_result_277 = {1'b0,io_a[14]};
  assign _zz_result_276 = {5'd0, _zz_result_277};
  assign _zz_result_279 = {1'b0,io_a[15]};
  assign _zz_result_278 = {5'd0, _zz_result_279};
  assign _zz_result_281 = {1'b0,io_a[16]};
  assign _zz_result_280 = {5'd0, _zz_result_281};
  assign _zz_result_283 = {1'b0,io_a[17]};
  assign _zz_result_282 = {5'd0, _zz_result_283};
  assign _zz_result_285 = {1'b0,io_a[18]};
  assign _zz_result_284 = {5'd0, _zz_result_285};
  assign _zz_result_287 = {1'b0,io_a[19]};
  assign _zz_result_286 = {5'd0, _zz_result_287};
  assign _zz_result_289 = {1'b0,io_a[20]};
  assign _zz_result_288 = {5'd0, _zz_result_289};
  assign _zz_result_291 = {1'b0,io_a[21]};
  assign _zz_result_290 = {5'd0, _zz_result_291};
  assign _zz_result_293 = {1'b0,io_a[22]};
  assign _zz_result_292 = {5'd0, _zz_result_293};
  assign _zz_result_295 = {1'b0,io_a[23]};
  assign _zz_result_294 = {5'd0, _zz_result_295};
  assign _zz_result_297 = {1'b0,io_a[24]};
  assign _zz_result_296 = {5'd0, _zz_result_297};
  assign _zz_result_299 = {1'b0,io_a[25]};
  assign _zz_result_298 = {5'd0, _zz_result_299};
  assign _zz_result_301 = {1'b0,io_a[26]};
  assign _zz_result_300 = {5'd0, _zz_result_301};
  assign _zz_result_303 = {1'b0,io_a[27]};
  assign _zz_result_302 = {5'd0, _zz_result_303};
  assign _zz_result_305 = {1'b0,io_a[28]};
  assign _zz_result_304 = {5'd0, _zz_result_305};
  assign _zz_result_307 = {1'b0,io_a[29]};
  assign _zz_result_306 = {5'd0, _zz_result_307};
  assign _zz_result_309 = {1'b0,io_a[30]};
  assign _zz_result_308 = {5'd0, _zz_result_309};
  assign _zz_result_311 = {1'b0,io_a[31]};
  assign _zz_result_310 = {5'd0, _zz_result_311};
  assign _zz_result_313 = io_a[7 : 0];
  assign _zz_result_312 = {{24{_zz_result_313[7]}}, _zz_result_313};
  assign _zz_result_315 = io_a[15 : 0];
  assign _zz_result_314 = {{16{_zz_result_315[15]}}, _zz_result_315};
  assign _zz_result_317 = io_a[15 : 0];
  assign _zz_result_316 = {16'd0, _zz_result_317};
  assign _zz_result_319 = ({31'd0,aU} <<< _zz_result_320);
  assign _zz_result_318 = _zz_result_319[31:0];
  assign _zz_result_320 = _zz_result_62[4:0];
  assign _zz_result_321 = (aU >>> _zz_result_322);
  assign _zz_result_322 = (6'h20 - _zz_result_62);
  assign _zz_result_323 = (aU >>> _zz_result_63);
  assign _zz_result_325 = ({63'd0,aU} <<< _zz_result_326);
  assign _zz_result_324 = _zz_result_325[31:0];
  assign _zz_result_326 = (6'h20 - _zz_result_63);
  assign _zz_result_328 = (_zz_result_329 + _zz_result_330);
  assign _zz_result_327 = _zz_result_328[31:0];
  assign _zz_result_329 = ({1'd0,aU} <<< 1'd1);
  assign _zz_result_330 = {1'd0, bU};
  assign _zz_result_332 = (_zz_result_333 + _zz_result_334);
  assign _zz_result_331 = _zz_result_332[31:0];
  assign _zz_result_333 = ({2'd0,aU} <<< 2'd2);
  assign _zz_result_334 = {2'd0, bU};
  assign _zz_result_336 = (_zz_result_337 + _zz_result_338);
  assign _zz_result_335 = _zz_result_336[31:0];
  assign _zz_result_337 = ({3'd0,aU} <<< 2'd3);
  assign _zz_result_338 = {3'd0, bU};
  assign _zz_result_339 = (aZext + bU);
  assign _zz_result_341 = (_zz_result_342 + _zz_result_343);
  assign _zz_result_340 = _zz_result_341[31:0];
  assign _zz_result_342 = ({1'd0,aZext} <<< 1'd1);
  assign _zz_result_343 = {1'd0, bU};
  assign _zz_result_345 = (_zz_result_346 + _zz_result_347);
  assign _zz_result_344 = _zz_result_345[31:0];
  assign _zz_result_346 = ({2'd0,aZext} <<< 2'd2);
  assign _zz_result_347 = {2'd0, bU};
  assign _zz_result_349 = (_zz_result_350 + _zz_result_351);
  assign _zz_result_348 = _zz_result_349[31:0];
  assign _zz_result_350 = ({3'd0,aZext} <<< 2'd3);
  assign _zz_result_351 = {3'd0, bU};
  assign _zz_result_353 = ({31'd0,aZext} <<< shamt);
  assign _zz_result_352 = _zz_result_353[31:0];
  assign _zz_result_355 = (((_zz_result_95 && (! _zz_result_64[1])) && _zz_result_64[0]) ? 6'h1f : ((_zz_result_95 && _zz_result_64[1]) ? 6'h1e : ((_zz_result_94 && _zz_result_64[2]) ? 6'h1d : ((_zz_result_93 && _zz_result_64[3]) ? 6'h1c : ((_zz_result_92 && _zz_result_356) ? 6'h1b : (_zz_result_357 ? _zz_result_358 : _zz_result_359))))));
  assign _zz_result_354 = {26'd0, _zz_result_355};
  assign _zz_result_373 = (((_zz_result_127 && (! _zz_result_96[30])) && _zz_result_96[31]) ? 6'h1f : ((_zz_result_127 && _zz_result_96[30]) ? 6'h1e : ((_zz_result_126 && _zz_result_96[29]) ? 6'h1d : ((_zz_result_125 && _zz_result_96[28]) ? 6'h1c : ((_zz_result_124 && _zz_result_374) ? 6'h1b : (_zz_result_375 ? _zz_result_376 : _zz_result_377))))));
  assign _zz_result_372 = {26'd0, _zz_result_373};
  assign _zz_result_391 = _zz_result_392[5:0];
  assign _zz_result_390 = {26'd0, _zz_result_391};
  assign _zz_result_392 = ({1'b0,_zz_result_393} + _zz_result_517);
  assign _zz_result_394 = ({1'b0,_zz_result_395} + _zz_result_515);
  assign _zz_result_393 = _zz_result_394[5:0];
  assign _zz_result_396 = ({1'b0,_zz_result_397} + _zz_result_513);
  assign _zz_result_395 = _zz_result_396[5:0];
  assign _zz_result_398 = ({1'b0,_zz_result_399} + _zz_result_511);
  assign _zz_result_397 = _zz_result_398[5:0];
  assign _zz_result_400 = ({1'b0,_zz_result_401} + _zz_result_509);
  assign _zz_result_399 = _zz_result_400[5:0];
  assign _zz_result_402 = ({1'b0,_zz_result_403} + _zz_result_507);
  assign _zz_result_401 = _zz_result_402[5:0];
  assign _zz_result_404 = ({1'b0,_zz_result_405} + _zz_result_505);
  assign _zz_result_403 = _zz_result_404[5:0];
  assign _zz_result_406 = ({1'b0,_zz_result_407} + _zz_result_503);
  assign _zz_result_405 = _zz_result_406[5:0];
  assign _zz_result_408 = ({1'b0,_zz_result_409} + _zz_result_501);
  assign _zz_result_407 = _zz_result_408[5:0];
  assign _zz_result_410 = ({1'b0,_zz_result_411} + _zz_result_499);
  assign _zz_result_409 = _zz_result_410[5:0];
  assign _zz_result_412 = ({1'b0,_zz_result_413} + _zz_result_497);
  assign _zz_result_411 = _zz_result_412[5:0];
  assign _zz_result_414 = ({1'b0,_zz_result_415} + _zz_result_495);
  assign _zz_result_413 = _zz_result_414[5:0];
  assign _zz_result_416 = ({1'b0,_zz_result_417} + _zz_result_493);
  assign _zz_result_415 = _zz_result_416[5:0];
  assign _zz_result_418 = ({1'b0,_zz_result_419} + _zz_result_491);
  assign _zz_result_417 = _zz_result_418[5:0];
  assign _zz_result_420 = ({1'b0,_zz_result_421} + _zz_result_489);
  assign _zz_result_419 = _zz_result_420[5:0];
  assign _zz_result_422 = ({1'b0,_zz_result_423} + _zz_result_487);
  assign _zz_result_421 = _zz_result_422[5:0];
  assign _zz_result_424 = ({1'b0,_zz_result_425} + _zz_result_485);
  assign _zz_result_423 = _zz_result_424[5:0];
  assign _zz_result_426 = ({1'b0,_zz_result_427} + _zz_result_483);
  assign _zz_result_425 = _zz_result_426[5:0];
  assign _zz_result_428 = ({1'b0,_zz_result_429} + _zz_result_481);
  assign _zz_result_427 = _zz_result_428[5:0];
  assign _zz_result_430 = ({1'b0,_zz_result_431} + _zz_result_479);
  assign _zz_result_429 = _zz_result_430[5:0];
  assign _zz_result_432 = ({1'b0,_zz_result_433} + _zz_result_477);
  assign _zz_result_431 = _zz_result_432[5:0];
  assign _zz_result_434 = ({1'b0,_zz_result_435} + _zz_result_475);
  assign _zz_result_433 = _zz_result_434[5:0];
  assign _zz_result_436 = ({1'b0,_zz_result_437} + _zz_result_473);
  assign _zz_result_435 = _zz_result_436[5:0];
  assign _zz_result_438 = ({1'b0,_zz_result_439} + _zz_result_471);
  assign _zz_result_437 = _zz_result_438[5:0];
  assign _zz_result_440 = ({1'b0,_zz_result_441} + _zz_result_469);
  assign _zz_result_439 = _zz_result_440[5:0];
  assign _zz_result_442 = ({1'b0,_zz_result_443} + _zz_result_467);
  assign _zz_result_441 = _zz_result_442[5:0];
  assign _zz_result_444 = ({1'b0,_zz_result_445} + _zz_result_465);
  assign _zz_result_443 = _zz_result_444[5:0];
  assign _zz_result_446 = ({1'b0,_zz_result_447} + _zz_result_463);
  assign _zz_result_445 = _zz_result_446[5:0];
  assign _zz_result_448 = ({1'b0,_zz_result_449} + _zz_result_461);
  assign _zz_result_447 = _zz_result_448[5:0];
  assign _zz_result_450 = ({1'b0,_zz_result_451} + _zz_result_459);
  assign _zz_result_449 = _zz_result_450[5:0];
  assign _zz_result_452 = ({1'b0,_zz_result_453} + _zz_result_457);
  assign _zz_result_451 = _zz_result_452[5:0];
  assign _zz_result_454 = ({1'b0,6'h0} + _zz_result_455);
  assign _zz_result_453 = _zz_result_454[5:0];
  assign _zz_result_456 = {1'b0,_zz_result_128[0]};
  assign _zz_result_455 = {5'd0, _zz_result_456};
  assign _zz_result_458 = {1'b0,_zz_result_128[1]};
  assign _zz_result_457 = {5'd0, _zz_result_458};
  assign _zz_result_460 = {1'b0,_zz_result_128[2]};
  assign _zz_result_459 = {5'd0, _zz_result_460};
  assign _zz_result_462 = {1'b0,_zz_result_128[3]};
  assign _zz_result_461 = {5'd0, _zz_result_462};
  assign _zz_result_464 = {1'b0,_zz_result_128[4]};
  assign _zz_result_463 = {5'd0, _zz_result_464};
  assign _zz_result_466 = {1'b0,_zz_result_128[5]};
  assign _zz_result_465 = {5'd0, _zz_result_466};
  assign _zz_result_468 = {1'b0,_zz_result_128[6]};
  assign _zz_result_467 = {5'd0, _zz_result_468};
  assign _zz_result_470 = {1'b0,_zz_result_128[7]};
  assign _zz_result_469 = {5'd0, _zz_result_470};
  assign _zz_result_472 = {1'b0,_zz_result_128[8]};
  assign _zz_result_471 = {5'd0, _zz_result_472};
  assign _zz_result_474 = {1'b0,_zz_result_128[9]};
  assign _zz_result_473 = {5'd0, _zz_result_474};
  assign _zz_result_476 = {1'b0,_zz_result_128[10]};
  assign _zz_result_475 = {5'd0, _zz_result_476};
  assign _zz_result_478 = {1'b0,_zz_result_128[11]};
  assign _zz_result_477 = {5'd0, _zz_result_478};
  assign _zz_result_480 = {1'b0,_zz_result_128[12]};
  assign _zz_result_479 = {5'd0, _zz_result_480};
  assign _zz_result_482 = {1'b0,_zz_result_128[13]};
  assign _zz_result_481 = {5'd0, _zz_result_482};
  assign _zz_result_484 = {1'b0,_zz_result_128[14]};
  assign _zz_result_483 = {5'd0, _zz_result_484};
  assign _zz_result_486 = {1'b0,_zz_result_128[15]};
  assign _zz_result_485 = {5'd0, _zz_result_486};
  assign _zz_result_488 = {1'b0,_zz_result_128[16]};
  assign _zz_result_487 = {5'd0, _zz_result_488};
  assign _zz_result_490 = {1'b0,_zz_result_128[17]};
  assign _zz_result_489 = {5'd0, _zz_result_490};
  assign _zz_result_492 = {1'b0,_zz_result_128[18]};
  assign _zz_result_491 = {5'd0, _zz_result_492};
  assign _zz_result_494 = {1'b0,_zz_result_128[19]};
  assign _zz_result_493 = {5'd0, _zz_result_494};
  assign _zz_result_496 = {1'b0,_zz_result_128[20]};
  assign _zz_result_495 = {5'd0, _zz_result_496};
  assign _zz_result_498 = {1'b0,_zz_result_128[21]};
  assign _zz_result_497 = {5'd0, _zz_result_498};
  assign _zz_result_500 = {1'b0,_zz_result_128[22]};
  assign _zz_result_499 = {5'd0, _zz_result_500};
  assign _zz_result_502 = {1'b0,_zz_result_128[23]};
  assign _zz_result_501 = {5'd0, _zz_result_502};
  assign _zz_result_504 = {1'b0,_zz_result_128[24]};
  assign _zz_result_503 = {5'd0, _zz_result_504};
  assign _zz_result_506 = {1'b0,_zz_result_128[25]};
  assign _zz_result_505 = {5'd0, _zz_result_506};
  assign _zz_result_508 = {1'b0,_zz_result_128[26]};
  assign _zz_result_507 = {5'd0, _zz_result_508};
  assign _zz_result_510 = {1'b0,_zz_result_128[27]};
  assign _zz_result_509 = {5'd0, _zz_result_510};
  assign _zz_result_512 = {1'b0,_zz_result_128[28]};
  assign _zz_result_511 = {5'd0, _zz_result_512};
  assign _zz_result_514 = {1'b0,_zz_result_128[29]};
  assign _zz_result_513 = {5'd0, _zz_result_514};
  assign _zz_result_516 = {1'b0,_zz_result_128[30]};
  assign _zz_result_515 = {5'd0, _zz_result_516};
  assign _zz_result_518 = {1'b0,_zz_result_128[31]};
  assign _zz_result_517 = {5'd0, _zz_result_518};
  assign _zz_result_519 = ((shamtW == 5'h0) ? aWU : (_zz_result_520 | _zz_result_523));
  assign _zz_result_521 = ({31'd0,aWU} <<< _zz_result_522);
  assign _zz_result_520 = _zz_result_521[31:0];
  assign _zz_result_522 = _zz_result_129[4:0];
  assign _zz_result_523 = (aWU >>> _zz_result_524);
  assign _zz_result_524 = (6'h20 - _zz_result_129);
  assign _zz_result_525 = ((shamtW == 5'h0) ? aWU : (_zz_result_526 | _zz_result_527));
  assign _zz_result_526 = (aWU >>> _zz_result_130);
  assign _zz_result_528 = ({63'd0,aWU} <<< _zz_result_529);
  assign _zz_result_527 = _zz_result_528[31:0];
  assign _zz_result_529 = (6'h20 - _zz_result_130);
  assign _zz_clmulFull = ((((((((_zz_clmulFull_1 ^ _zz_clmulFull_43) ^ (_zz_clmulFull_46 ? _zz_clmulFull_47 : _zz_clmulFull_49)) ^ (bU[19] ? _zz_clmulFull_50 : 64'h0)) ^ (bU[20] ? _zz_clmulFull_52 : 64'h0)) ^ (bU[21] ? _zz_clmulFull_54 : 64'h0)) ^ (bU[22] ? _zz_clmulFull_56 : 64'h0)) ^ (bU[23] ? _zz_clmulFull_58 : 64'h0)) ^ (bU[24] ? _zz_clmulFull_60 : 64'h0));
  assign _zz_clmulFull_62 = (bU[25] ? _zz_clmulFull_63 : 64'h0);
  assign _zz_clmulFull_65 = bU[26];
  assign _zz_clmulFull_68 = 64'h0;
  assign _zz_clmulFull_1 = ((((((((_zz_clmulFull_2 ^ _zz_clmulFull_24) ^ (_zz_clmulFull_27 ? _zz_clmulFull_28 : _zz_clmulFull_30)) ^ (bU[11] ? _zz_clmulFull_31 : 64'h0)) ^ (bU[12] ? _zz_clmulFull_33 : 64'h0)) ^ (bU[13] ? _zz_clmulFull_35 : 64'h0)) ^ (bU[14] ? _zz_clmulFull_37 : 64'h0)) ^ (bU[15] ? _zz_clmulFull_39 : 64'h0)) ^ (bU[16] ? _zz_clmulFull_41 : 64'h0));
  assign _zz_clmulFull_43 = (bU[17] ? _zz_clmulFull_44 : 64'h0);
  assign _zz_clmulFull_46 = bU[18];
  assign _zz_clmulFull_49 = 64'h0;
  assign _zz_clmulFull_2 = ((((((((_zz_clmulFull_3 ^ _zz_clmulFull_5) ^ (_zz_clmulFull_8 ? _zz_clmulFull_9 : _zz_clmulFull_11)) ^ (bU[3] ? _zz_clmulFull_12 : 64'h0)) ^ (bU[4] ? _zz_clmulFull_14 : 64'h0)) ^ (bU[5] ? _zz_clmulFull_16 : 64'h0)) ^ (bU[6] ? _zz_clmulFull_18 : 64'h0)) ^ (bU[7] ? _zz_clmulFull_20 : 64'h0)) ^ (bU[8] ? _zz_clmulFull_22 : 64'h0));
  assign _zz_clmulFull_24 = (bU[9] ? _zz_clmulFull_25 : 64'h0);
  assign _zz_clmulFull_27 = bU[10];
  assign _zz_clmulFull_30 = 64'h0;
  assign _zz_clmulFull_3 = (64'h0 ^ (bU[0] ? _zz_clmulFull_4 : 64'h0));
  assign _zz_clmulFull_5 = (bU[1] ? _zz_clmulFull_6 : 64'h0);
  assign _zz_clmulFull_8 = bU[2];
  assign _zz_clmulFull_11 = 64'h0;
  assign _zz_result_149 = io_a[4];
  assign _zz_result_150 = (_zz_result_26 && io_a[5]);
  assign _zz_result_151 = 6'h1a;
  assign _zz_result_152 = ((_zz_result_25 && io_a[6]) ? 6'h19 : ((_zz_result_24 && io_a[7]) ? 6'h18 : ((_zz_result_23 && io_a[8]) ? 6'h17 : ((_zz_result_22 && io_a[9]) ? 6'h16 : ((_zz_result_21 && io_a[10]) ? 6'h15 : ((_zz_result_20 && _zz_result_153) ? 6'h14 : (_zz_result_154 ? _zz_result_155 : _zz_result_156)))))));
  assign _zz_result_153 = io_a[11];
  assign _zz_result_154 = (_zz_result_19 && io_a[12]);
  assign _zz_result_155 = 6'h13;
  assign _zz_result_156 = ((_zz_result_18 && io_a[13]) ? 6'h12 : ((_zz_result_17 && io_a[14]) ? 6'h11 : ((_zz_result_16 && io_a[15]) ? 6'h10 : ((_zz_result_15 && io_a[16]) ? 6'h0f : ((_zz_result_14 && io_a[17]) ? 6'h0e : ((_zz_result_13 && _zz_result_157) ? 6'h0d : (_zz_result_158 ? _zz_result_159 : _zz_result_160)))))));
  assign _zz_result_157 = io_a[18];
  assign _zz_result_158 = (_zz_result_12 && io_a[19]);
  assign _zz_result_159 = 6'h0c;
  assign _zz_result_160 = ((_zz_result_11 && io_a[20]) ? 6'h0b : ((_zz_result_10 && io_a[21]) ? 6'h0a : ((_zz_result_9 && io_a[22]) ? 6'h09 : ((_zz_result_8 && io_a[23]) ? 6'h08 : ((_zz_result_7 && io_a[24]) ? 6'h07 : ((_zz_result_6 && _zz_result_161) ? 6'h06 : (_zz_result_162 ? _zz_result_163 : _zz_result_164)))))));
  assign _zz_result_161 = io_a[25];
  assign _zz_result_162 = (_zz_result_5 && io_a[26]);
  assign _zz_result_163 = 6'h05;
  assign _zz_result_164 = ((_zz_result_4 && io_a[27]) ? 6'h04 : ((_zz_result_3 && io_a[28]) ? 6'h03 : ((_zz_result_2 && io_a[29]) ? 6'h02 : ((_zz_result_1 && io_a[30]) ? 6'h01 : ((_zz_result && io_a[31]) ? 6'h0 : 6'h20)))));
  assign _zz_result_167 = io_a[27];
  assign _zz_result_168 = (_zz_result_57 && io_a[26]);
  assign _zz_result_169 = 6'h1a;
  assign _zz_result_170 = ((_zz_result_56 && io_a[25]) ? 6'h19 : ((_zz_result_55 && io_a[24]) ? 6'h18 : ((_zz_result_54 && io_a[23]) ? 6'h17 : ((_zz_result_53 && io_a[22]) ? 6'h16 : ((_zz_result_52 && io_a[21]) ? 6'h15 : ((_zz_result_51 && _zz_result_171) ? 6'h14 : (_zz_result_172 ? _zz_result_173 : _zz_result_174)))))));
  assign _zz_result_171 = io_a[20];
  assign _zz_result_172 = (_zz_result_50 && io_a[19]);
  assign _zz_result_173 = 6'h13;
  assign _zz_result_174 = ((_zz_result_49 && io_a[18]) ? 6'h12 : ((_zz_result_48 && io_a[17]) ? 6'h11 : ((_zz_result_47 && io_a[16]) ? 6'h10 : ((_zz_result_46 && io_a[15]) ? 6'h0f : ((_zz_result_45 && io_a[14]) ? 6'h0e : ((_zz_result_44 && _zz_result_175) ? 6'h0d : (_zz_result_176 ? _zz_result_177 : _zz_result_178)))))));
  assign _zz_result_175 = io_a[13];
  assign _zz_result_176 = (_zz_result_43 && io_a[12]);
  assign _zz_result_177 = 6'h0c;
  assign _zz_result_178 = ((_zz_result_42 && io_a[11]) ? 6'h0b : ((_zz_result_41 && io_a[10]) ? 6'h0a : ((_zz_result_40 && io_a[9]) ? 6'h09 : ((_zz_result_39 && io_a[8]) ? 6'h08 : ((_zz_result_38 && io_a[7]) ? 6'h07 : ((_zz_result_37 && _zz_result_179) ? 6'h06 : (_zz_result_180 ? _zz_result_181 : _zz_result_182)))))));
  assign _zz_result_179 = io_a[6];
  assign _zz_result_180 = (_zz_result_36 && io_a[5]);
  assign _zz_result_181 = 6'h05;
  assign _zz_result_182 = ((_zz_result_35 && io_a[4]) ? 6'h04 : ((_zz_result_34 && io_a[3]) ? 6'h03 : ((_zz_result_33 && io_a[2]) ? 6'h02 : ((_zz_result_32 && io_a[1]) ? 6'h01 : ((_zz_result_31 && io_a[0]) ? 6'h0 : 6'h20)))));
  assign _zz_result_356 = _zz_result_64[4];
  assign _zz_result_357 = (_zz_result_91 && _zz_result_64[5]);
  assign _zz_result_358 = 6'h1a;
  assign _zz_result_359 = ((_zz_result_90 && _zz_result_64[6]) ? 6'h19 : ((_zz_result_89 && _zz_result_64[7]) ? 6'h18 : ((_zz_result_88 && _zz_result_64[8]) ? 6'h17 : ((_zz_result_87 && _zz_result_64[9]) ? 6'h16 : ((_zz_result_86 && _zz_result_64[10]) ? 6'h15 : ((_zz_result_85 && _zz_result_360) ? 6'h14 : (_zz_result_361 ? _zz_result_362 : _zz_result_363)))))));
  assign _zz_result_360 = _zz_result_64[11];
  assign _zz_result_361 = (_zz_result_84 && _zz_result_64[12]);
  assign _zz_result_362 = 6'h13;
  assign _zz_result_363 = ((_zz_result_83 && _zz_result_64[13]) ? 6'h12 : ((_zz_result_82 && _zz_result_64[14]) ? 6'h11 : ((_zz_result_81 && _zz_result_64[15]) ? 6'h10 : ((_zz_result_80 && _zz_result_64[16]) ? 6'h0f : ((_zz_result_79 && _zz_result_64[17]) ? 6'h0e : ((_zz_result_78 && _zz_result_364) ? 6'h0d : (_zz_result_365 ? _zz_result_366 : _zz_result_367)))))));
  assign _zz_result_364 = _zz_result_64[18];
  assign _zz_result_365 = (_zz_result_77 && _zz_result_64[19]);
  assign _zz_result_366 = 6'h0c;
  assign _zz_result_367 = ((_zz_result_76 && _zz_result_64[20]) ? 6'h0b : ((_zz_result_75 && _zz_result_64[21]) ? 6'h0a : ((_zz_result_74 && _zz_result_64[22]) ? 6'h09 : ((_zz_result_73 && _zz_result_64[23]) ? 6'h08 : ((_zz_result_72 && _zz_result_64[24]) ? 6'h07 : ((_zz_result_71 && _zz_result_368) ? 6'h06 : (_zz_result_369 ? _zz_result_370 : _zz_result_371)))))));
  assign _zz_result_368 = _zz_result_64[25];
  assign _zz_result_369 = (_zz_result_70 && _zz_result_64[26]);
  assign _zz_result_370 = 6'h05;
  assign _zz_result_371 = ((_zz_result_69 && _zz_result_64[27]) ? 6'h04 : ((_zz_result_68 && _zz_result_64[28]) ? 6'h03 : ((_zz_result_67 && _zz_result_64[29]) ? 6'h02 : ((_zz_result_66 && _zz_result_64[30]) ? 6'h01 : ((_zz_result_65 && _zz_result_64[31]) ? 6'h0 : 6'h20)))));
  assign _zz_result_374 = _zz_result_96[27];
  assign _zz_result_375 = (_zz_result_123 && _zz_result_96[26]);
  assign _zz_result_376 = 6'h1a;
  assign _zz_result_377 = ((_zz_result_122 && _zz_result_96[25]) ? 6'h19 : ((_zz_result_121 && _zz_result_96[24]) ? 6'h18 : ((_zz_result_120 && _zz_result_96[23]) ? 6'h17 : ((_zz_result_119 && _zz_result_96[22]) ? 6'h16 : ((_zz_result_118 && _zz_result_96[21]) ? 6'h15 : ((_zz_result_117 && _zz_result_378) ? 6'h14 : (_zz_result_379 ? _zz_result_380 : _zz_result_381)))))));
  assign _zz_result_378 = _zz_result_96[20];
  assign _zz_result_379 = (_zz_result_116 && _zz_result_96[19]);
  assign _zz_result_380 = 6'h13;
  assign _zz_result_381 = ((_zz_result_115 && _zz_result_96[18]) ? 6'h12 : ((_zz_result_114 && _zz_result_96[17]) ? 6'h11 : ((_zz_result_113 && _zz_result_96[16]) ? 6'h10 : ((_zz_result_112 && _zz_result_96[15]) ? 6'h0f : ((_zz_result_111 && _zz_result_96[14]) ? 6'h0e : ((_zz_result_110 && _zz_result_382) ? 6'h0d : (_zz_result_383 ? _zz_result_384 : _zz_result_385)))))));
  assign _zz_result_382 = _zz_result_96[13];
  assign _zz_result_383 = (_zz_result_109 && _zz_result_96[12]);
  assign _zz_result_384 = 6'h0c;
  assign _zz_result_385 = ((_zz_result_108 && _zz_result_96[11]) ? 6'h0b : ((_zz_result_107 && _zz_result_96[10]) ? 6'h0a : ((_zz_result_106 && _zz_result_96[9]) ? 6'h09 : ((_zz_result_105 && _zz_result_96[8]) ? 6'h08 : ((_zz_result_104 && _zz_result_96[7]) ? 6'h07 : ((_zz_result_103 && _zz_result_386) ? 6'h06 : (_zz_result_387 ? _zz_result_388 : _zz_result_389)))))));
  assign _zz_result_386 = _zz_result_96[6];
  assign _zz_result_387 = (_zz_result_102 && _zz_result_96[5]);
  assign _zz_result_388 = 6'h05;
  assign _zz_result_389 = ((_zz_result_101 && _zz_result_96[4]) ? 6'h04 : ((_zz_result_100 && _zz_result_96[3]) ? 6'h03 : ((_zz_result_99 && _zz_result_96[2]) ? 6'h02 : ((_zz_result_98 && _zz_result_96[1]) ? 6'h01 : ((_zz_result_97 && _zz_result_96[0]) ? 6'h0 : 6'h20)))));
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
  assign shamt = io_b[4 : 0];
  assign aW = aS[31 : 0];
  assign bW = bS[31 : 0];
  assign aWU = aU[31 : 0];
  assign shamtW = io_b[4 : 0];
  assign bitOneHot = _zz_bitOneHot[31:0];
  assign aZext = aU[31 : 0];
  assign clmulFull = (((((((_zz_clmulFull ^ _zz_clmulFull_62) ^ (_zz_clmulFull_65 ? _zz_clmulFull_66 : _zz_clmulFull_68)) ^ (bU[27] ? _zz_clmulFull_69 : 64'h0)) ^ (bU[28] ? _zz_clmulFull_71 : 64'h0)) ^ (bU[29] ? _zz_clmulFull_73 : 64'h0)) ^ (bU[30] ? _zz_clmulFull_75 : 64'h0)) ^ (bU[31] ? _zz_clmulFull_77 : 64'h0));
  assign mulUU = (aU * bU);
  assign mulSS = ($signed(aS) * $signed(bS));
  assign aSE = {{1{aS[31]}}, aS};
  assign bUE = _zz_bUE;
  assign mulSU = ($signed(aSE) * $signed(bUE));
  assign mulLow = _zz_mulLow[31 : 0];
  assign mulHighS = _zz_mulHighS[63 : 32];
  assign mulHighSu = _zz_mulHighSu[63 : 32];
  assign mulHighU = _zz_mulHighU[63 : 32];
  always @(*) begin
    case(io_op)
      AluOp_ADD : begin
        result = _zz_result_131;
      end
      AluOp_SUB : begin
        result = _zz_result_132;
      end
      AluOp_SLL_1 : begin
        result = _zz_result_133;
      end
      AluOp_SLT : begin
        result = (($signed(aS) < $signed(bS)) ? 32'h00000001 : 32'h0);
      end
      AluOp_SLTU : begin
        result = ((aU < bU) ? 32'h00000001 : 32'h0);
      end
      AluOp_XOR_1 : begin
        result = (io_a ^ io_b);
      end
      AluOp_SRL_1 : begin
        result = _zz_result_135;
      end
      AluOp_SRA_1 : begin
        result = _zz_result_136;
      end
      AluOp_OR_1 : begin
        result = (io_a | io_b);
      end
      AluOp_AND_1 : begin
        result = (io_a & io_b);
      end
      AluOp_ADDW : begin
        result = _zz_result_137;
      end
      AluOp_SUBW : begin
        result = _zz_result_138;
      end
      AluOp_SLLW : begin
        result = _zz_result_139;
      end
      AluOp_SRLW : begin
        result = _zz_result_142;
      end
      AluOp_SRAW : begin
        result = _zz_result_144;
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
        result = 32'h0;
      end
      AluOp_DIVU : begin
        result = 32'h0;
      end
      AluOp_REM_1 : begin
        result = 32'h0;
      end
      AluOp_REMU : begin
        result = 32'h0;
      end
      AluOp_MULW : begin
        result = _zz_result_145;
      end
      AluOp_DIVW : begin
        result = 32'h0;
      end
      AluOp_DIVUW : begin
        result = 32'h0;
      end
      AluOp_REMW : begin
        result = 32'h0;
      end
      AluOp_REMUW : begin
        result = 32'h0;
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
        result = _zz_result_147;
      end
      AluOp_CTZ : begin
        result = _zz_result_165;
      end
      AluOp_CPOP : begin
        result = _zz_result_183;
      end
      AluOp_SEXTB : begin
        result = _zz_result_312;
      end
      AluOp_SEXTH : begin
        result = _zz_result_314;
      end
      AluOp_ZEXTH : begin
        result = _zz_result_316;
      end
      AluOp_ORCB : begin
        result = {((|io_a[31 : 24]) ? 8'hff : 8'h0),{((|io_a[23 : 16]) ? 8'hff : 8'h0),{((|io_a[15 : 8]) ? 8'hff : 8'h0),((|io_a[7 : 0]) ? 8'hff : 8'h0)}}};
      end
      AluOp_REV8 : begin
        result = {io_a[7 : 0],{io_a[15 : 8],{io_a[23 : 16],io_a[31 : 24]}}};
      end
      AluOp_ROL_1 : begin
        result = ((shamt == 5'h0) ? aU : (_zz_result_318 | _zz_result_321));
      end
      AluOp_ROR_1 : begin
        result = ((shamt == 5'h0) ? aU : (_zz_result_323 | _zz_result_324));
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
        result = ((|(aU & bitOneHot)) ? 32'h00000001 : 32'h0);
      end
      AluOp_SH1ADD : begin
        result = _zz_result_327;
      end
      AluOp_SH2ADD : begin
        result = _zz_result_331;
      end
      AluOp_SH3ADD : begin
        result = _zz_result_335;
      end
      AluOp_ADDUW : begin
        result = _zz_result_339;
      end
      AluOp_SH1ADDUW : begin
        result = _zz_result_340;
      end
      AluOp_SH2ADDUW : begin
        result = _zz_result_344;
      end
      AluOp_SH3ADDUW : begin
        result = _zz_result_348;
      end
      AluOp_SLLIUW : begin
        result = _zz_result_352;
      end
      AluOp_CLMUL : begin
        result = clmulFull[31 : 0];
      end
      AluOp_CLMULH : begin
        result = clmulFull[63 : 32];
      end
      AluOp_CLMULR : begin
        result = clmulFull[62 : 31];
      end
      AluOp_CLZW : begin
        result = _zz_result_354;
      end
      AluOp_CTZW : begin
        result = _zz_result_372;
      end
      AluOp_CPOPW : begin
        result = _zz_result_390;
      end
      AluOp_ROLW : begin
        result = _zz_result_519;
      end
      default : begin
        result = _zz_result_525;
      end
    endcase
  end

  assign _zz_result = 1'b1;
  assign _zz_result_1 = (_zz_result && (! io_a[31]));
  assign _zz_result_2 = (_zz_result_1 && (! io_a[30]));
  assign _zz_result_3 = (_zz_result_2 && (! io_a[29]));
  assign _zz_result_4 = (_zz_result_3 && (! io_a[28]));
  assign _zz_result_5 = (_zz_result_4 && (! io_a[27]));
  assign _zz_result_6 = (_zz_result_5 && (! io_a[26]));
  assign _zz_result_7 = (_zz_result_6 && (! io_a[25]));
  assign _zz_result_8 = (_zz_result_7 && (! io_a[24]));
  assign _zz_result_9 = (_zz_result_8 && (! io_a[23]));
  assign _zz_result_10 = (_zz_result_9 && (! io_a[22]));
  assign _zz_result_11 = (_zz_result_10 && (! io_a[21]));
  assign _zz_result_12 = (_zz_result_11 && (! io_a[20]));
  assign _zz_result_13 = (_zz_result_12 && (! io_a[19]));
  assign _zz_result_14 = (_zz_result_13 && (! io_a[18]));
  assign _zz_result_15 = (_zz_result_14 && (! io_a[17]));
  assign _zz_result_16 = (_zz_result_15 && (! io_a[16]));
  assign _zz_result_17 = (_zz_result_16 && (! io_a[15]));
  assign _zz_result_18 = (_zz_result_17 && (! io_a[14]));
  assign _zz_result_19 = (_zz_result_18 && (! io_a[13]));
  assign _zz_result_20 = (_zz_result_19 && (! io_a[12]));
  assign _zz_result_21 = (_zz_result_20 && (! io_a[11]));
  assign _zz_result_22 = (_zz_result_21 && (! io_a[10]));
  assign _zz_result_23 = (_zz_result_22 && (! io_a[9]));
  assign _zz_result_24 = (_zz_result_23 && (! io_a[8]));
  assign _zz_result_25 = (_zz_result_24 && (! io_a[7]));
  assign _zz_result_26 = (_zz_result_25 && (! io_a[6]));
  assign _zz_result_27 = (_zz_result_26 && (! io_a[5]));
  assign _zz_result_28 = (_zz_result_27 && (! io_a[4]));
  assign _zz_result_29 = (_zz_result_28 && (! io_a[3]));
  assign _zz_result_30 = (_zz_result_29 && (! io_a[2]));
  assign _zz_result_31 = 1'b1;
  assign _zz_result_32 = (_zz_result_31 && (! io_a[0]));
  assign _zz_result_33 = (_zz_result_32 && (! io_a[1]));
  assign _zz_result_34 = (_zz_result_33 && (! io_a[2]));
  assign _zz_result_35 = (_zz_result_34 && (! io_a[3]));
  assign _zz_result_36 = (_zz_result_35 && (! io_a[4]));
  assign _zz_result_37 = (_zz_result_36 && (! io_a[5]));
  assign _zz_result_38 = (_zz_result_37 && (! io_a[6]));
  assign _zz_result_39 = (_zz_result_38 && (! io_a[7]));
  assign _zz_result_40 = (_zz_result_39 && (! io_a[8]));
  assign _zz_result_41 = (_zz_result_40 && (! io_a[9]));
  assign _zz_result_42 = (_zz_result_41 && (! io_a[10]));
  assign _zz_result_43 = (_zz_result_42 && (! io_a[11]));
  assign _zz_result_44 = (_zz_result_43 && (! io_a[12]));
  assign _zz_result_45 = (_zz_result_44 && (! io_a[13]));
  assign _zz_result_46 = (_zz_result_45 && (! io_a[14]));
  assign _zz_result_47 = (_zz_result_46 && (! io_a[15]));
  assign _zz_result_48 = (_zz_result_47 && (! io_a[16]));
  assign _zz_result_49 = (_zz_result_48 && (! io_a[17]));
  assign _zz_result_50 = (_zz_result_49 && (! io_a[18]));
  assign _zz_result_51 = (_zz_result_50 && (! io_a[19]));
  assign _zz_result_52 = (_zz_result_51 && (! io_a[20]));
  assign _zz_result_53 = (_zz_result_52 && (! io_a[21]));
  assign _zz_result_54 = (_zz_result_53 && (! io_a[22]));
  assign _zz_result_55 = (_zz_result_54 && (! io_a[23]));
  assign _zz_result_56 = (_zz_result_55 && (! io_a[24]));
  assign _zz_result_57 = (_zz_result_56 && (! io_a[25]));
  assign _zz_result_58 = (_zz_result_57 && (! io_a[26]));
  assign _zz_result_59 = (_zz_result_58 && (! io_a[27]));
  assign _zz_result_60 = (_zz_result_59 && (! io_a[28]));
  assign _zz_result_61 = (_zz_result_60 && (! io_a[29]));
  assign _zz_result_62 = {1'd0, shamt};
  assign _zz_result_63 = {1'd0, shamt};
  assign _zz_result_64 = io_a[31 : 0];
  assign _zz_result_65 = 1'b1;
  assign _zz_result_66 = (_zz_result_65 && (! _zz_result_64[31]));
  assign _zz_result_67 = (_zz_result_66 && (! _zz_result_64[30]));
  assign _zz_result_68 = (_zz_result_67 && (! _zz_result_64[29]));
  assign _zz_result_69 = (_zz_result_68 && (! _zz_result_64[28]));
  assign _zz_result_70 = (_zz_result_69 && (! _zz_result_64[27]));
  assign _zz_result_71 = (_zz_result_70 && (! _zz_result_64[26]));
  assign _zz_result_72 = (_zz_result_71 && (! _zz_result_64[25]));
  assign _zz_result_73 = (_zz_result_72 && (! _zz_result_64[24]));
  assign _zz_result_74 = (_zz_result_73 && (! _zz_result_64[23]));
  assign _zz_result_75 = (_zz_result_74 && (! _zz_result_64[22]));
  assign _zz_result_76 = (_zz_result_75 && (! _zz_result_64[21]));
  assign _zz_result_77 = (_zz_result_76 && (! _zz_result_64[20]));
  assign _zz_result_78 = (_zz_result_77 && (! _zz_result_64[19]));
  assign _zz_result_79 = (_zz_result_78 && (! _zz_result_64[18]));
  assign _zz_result_80 = (_zz_result_79 && (! _zz_result_64[17]));
  assign _zz_result_81 = (_zz_result_80 && (! _zz_result_64[16]));
  assign _zz_result_82 = (_zz_result_81 && (! _zz_result_64[15]));
  assign _zz_result_83 = (_zz_result_82 && (! _zz_result_64[14]));
  assign _zz_result_84 = (_zz_result_83 && (! _zz_result_64[13]));
  assign _zz_result_85 = (_zz_result_84 && (! _zz_result_64[12]));
  assign _zz_result_86 = (_zz_result_85 && (! _zz_result_64[11]));
  assign _zz_result_87 = (_zz_result_86 && (! _zz_result_64[10]));
  assign _zz_result_88 = (_zz_result_87 && (! _zz_result_64[9]));
  assign _zz_result_89 = (_zz_result_88 && (! _zz_result_64[8]));
  assign _zz_result_90 = (_zz_result_89 && (! _zz_result_64[7]));
  assign _zz_result_91 = (_zz_result_90 && (! _zz_result_64[6]));
  assign _zz_result_92 = (_zz_result_91 && (! _zz_result_64[5]));
  assign _zz_result_93 = (_zz_result_92 && (! _zz_result_64[4]));
  assign _zz_result_94 = (_zz_result_93 && (! _zz_result_64[3]));
  assign _zz_result_95 = (_zz_result_94 && (! _zz_result_64[2]));
  assign _zz_result_96 = io_a[31 : 0];
  assign _zz_result_97 = 1'b1;
  assign _zz_result_98 = (_zz_result_97 && (! _zz_result_96[0]));
  assign _zz_result_99 = (_zz_result_98 && (! _zz_result_96[1]));
  assign _zz_result_100 = (_zz_result_99 && (! _zz_result_96[2]));
  assign _zz_result_101 = (_zz_result_100 && (! _zz_result_96[3]));
  assign _zz_result_102 = (_zz_result_101 && (! _zz_result_96[4]));
  assign _zz_result_103 = (_zz_result_102 && (! _zz_result_96[5]));
  assign _zz_result_104 = (_zz_result_103 && (! _zz_result_96[6]));
  assign _zz_result_105 = (_zz_result_104 && (! _zz_result_96[7]));
  assign _zz_result_106 = (_zz_result_105 && (! _zz_result_96[8]));
  assign _zz_result_107 = (_zz_result_106 && (! _zz_result_96[9]));
  assign _zz_result_108 = (_zz_result_107 && (! _zz_result_96[10]));
  assign _zz_result_109 = (_zz_result_108 && (! _zz_result_96[11]));
  assign _zz_result_110 = (_zz_result_109 && (! _zz_result_96[12]));
  assign _zz_result_111 = (_zz_result_110 && (! _zz_result_96[13]));
  assign _zz_result_112 = (_zz_result_111 && (! _zz_result_96[14]));
  assign _zz_result_113 = (_zz_result_112 && (! _zz_result_96[15]));
  assign _zz_result_114 = (_zz_result_113 && (! _zz_result_96[16]));
  assign _zz_result_115 = (_zz_result_114 && (! _zz_result_96[17]));
  assign _zz_result_116 = (_zz_result_115 && (! _zz_result_96[18]));
  assign _zz_result_117 = (_zz_result_116 && (! _zz_result_96[19]));
  assign _zz_result_118 = (_zz_result_117 && (! _zz_result_96[20]));
  assign _zz_result_119 = (_zz_result_118 && (! _zz_result_96[21]));
  assign _zz_result_120 = (_zz_result_119 && (! _zz_result_96[22]));
  assign _zz_result_121 = (_zz_result_120 && (! _zz_result_96[23]));
  assign _zz_result_122 = (_zz_result_121 && (! _zz_result_96[24]));
  assign _zz_result_123 = (_zz_result_122 && (! _zz_result_96[25]));
  assign _zz_result_124 = (_zz_result_123 && (! _zz_result_96[26]));
  assign _zz_result_125 = (_zz_result_124 && (! _zz_result_96[27]));
  assign _zz_result_126 = (_zz_result_125 && (! _zz_result_96[28]));
  assign _zz_result_127 = (_zz_result_126 && (! _zz_result_96[29]));
  assign _zz_result_128 = io_a[31 : 0];
  assign _zz_result_129 = {1'd0, shamtW};
  assign _zz_result_130 = {1'd0, shamtW};
  assign io_result = result;

endmodule

module CsrFile (
  input  wire          io_timerInterrupt,
  input  wire [11:0]   io_csrAddr,
  input  wire [1:0]    io_csrOp,
  input  wire          io_csrWe,
  input  wire [31:0]   io_csrWrData,
  output wire [31:0]   io_rdData,
  input  wire          io_trapEna,
  input  wire [31:0]   io_trapEpc,
  input  wire [31:0]   io_trapCause,
  input  wire [31:0]   io_trapTval,
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
  output wire [31:0]   io_mtvec,
  output wire [31:0]   io_mepc,
  output wire [31:0]   io_debugMepc,
  output wire [31:0]   io_debugMcause,
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
  reg        [31:0]   mstatusReg;
  reg        [31:0]   mieReg;
  reg        [31:0]   mtvecReg;
  reg        [31:0]   mscratchReg;
  reg        [31:0]   mepcReg;
  reg        [31:0]   mcauseReg;
  reg        [31:0]   mtvalReg;
  reg        [1:0]    curModeReg;
  reg        [4:0]    fflagsReg;
  reg        [2:0]    frmReg;
  reg        [31:0]   readData;
  wire       [31:0]   mipBits;
  wire                wbActive;
  reg        [31:0]   opNew;
  reg        [31:0]   mstatusPostWb;
  wire                when_CsrFile_l130;
  wire       [31:0]   _zz_mstatusPostWb;
  reg        [31:0]   mstatusNext;
  reg        [1:0]    curModeNext;
  reg        [31:0]   mepcNext;
  reg        [31:0]   _zz_mepcNext;
  wire                when_CsrFile_l168;
  reg        [31:0]   mcauseNext;
  wire                when_CsrFile_l176;
  reg        [31:0]   mtvalNext;
  wire                when_CsrFile_l180;
  reg        [31:0]   mieNext;
  wire                when_CsrFile_l185;
  wire       [31:0]   _zz_mieNext;
  reg        [31:0]   mtvecNext;
  wire                when_CsrFile_l188;
  wire       [31:0]   _zz_mtvecNext;
  reg        [31:0]   mscratchNext;
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
  assign mipBits = {{24'h0,io_timerInterrupt},7'h0};
  always @(*) begin
    case(io_csrAddr)
      12'h300 : begin
        readData = mstatusReg;
      end
      12'h301 : begin
        readData = 32'h40101100;
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
        readData = 32'h0;
      end
      default : begin
        readData = 32'h0;
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
  assign _zz_mstatusPostWb = 32'h00007888;
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
  assign _zz_mieNext = 32'h00000080;
  always @(*) begin
    if(when_CsrFile_l185) begin
      mieNext = ((mieReg & (~ _zz_mieNext)) | (opNew & _zz_mieNext));
    end else begin
      mieNext = mieReg;
    end
  end

  assign when_CsrFile_l188 = (wbActive && (io_csrAddr == 12'h305));
  assign _zz_mtvecNext = 32'hfffffffc;
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
      mstatusReg <= 32'h0;
      mieReg <= 32'h0;
      mtvecReg <= 32'h0;
      mscratchReg <= 32'h0;
      mepcReg <= 32'h0;
      mcauseReg <= 32'h0;
      mtvalReg <= 32'h0;
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
  input  wire [31:0]   io_writeData,
  input  wire          io_writeEnable,
  output wire [31:0]   io_rs1Data,
  output wire [31:0]   io_rs2Data,
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
  assign io_rs1Data = ((io_rs1 == 5'h0) ? 32'h0 : _zz_io_rs1Data);
  assign io_rs2Data = ((io_rs2 == 5'h0) ? 32'h0 : _zz_io_rs2Data);
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
  output reg  [31:0]   io_output_imm,
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
  wire       [32:0]   _zz_immB;
  wire       [31:0]   _zz_immB_1;
  wire       [11:0]   _zz_immB_2;
  wire       [31:0]   _zz_immU;
  wire       [32:0]   _zz_immJ;
  wire       [31:0]   _zz_immJ_1;
  wire       [19:0]   _zz_immJ_2;
  wire       [4:0]    _zz_crdp;
  wire       [2:0]    _zz_crdp_1;
  wire       [4:0]    _zz_crs1p;
  wire       [2:0]    _zz_crs1p_1;
  wire       [4:0]    _zz_crs2p;
  wire       [2:0]    _zz_crs2p_1;
  wire       [31:0]   _zz_cShamt;
  wire       [5:0]    _zz_cShamt_1;
  wire                _zz_cJImm;
  wire       [0:0]    _zz_cJImm_1;
  wire       [2:0]    _zz_cJImm_2;
  wire       [9:0]    _zz_cAddi16sp;
  wire       [7:0]    _zz_cLdImm;
  wire       [8:0]    _zz_cLdspImm;
  wire       [8:0]    _zz_cSdspImm;
  wire       [31:0]   _zz_io_output_imm;
  wire       [31:0]   _zz_io_output_imm_1;
  wire       [31:0]   _zz_io_output_imm_2;
  wire       [17:0]   _zz_io_output_imm_3;
  wire       [31:0]   _zz_io_output_imm_4;
  wire       [31:0]   _zz_io_output_imm_5;
  wire       [6:0]    opcode;
  wire       [2:0]    funct3;
  wire       [6:0]    funct7;
  wire       [4:0]    funct5;
  wire       [5:0]    funct6;
  wire       [1:0]    convSel;
  wire       [4:0]    rs1Num;
  wire       [4:0]    rdNum;
  wire       [31:0]   immI;
  wire       [31:0]   immS;
  wire       [31:0]   immB;
  wire       [31:0]   immU;
  wire       [31:0]   immJ;
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
  wire       [31:0]   cShamt;
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
  wire                when_Decoder_l259;
  wire                when_Decoder_l264;
  wire       [1:0]    switch_Decoder_l274;
  wire                when_Decoder_l280;
  wire                when_Decoder_l291;
  wire                when_Decoder_l302;
  wire       [6:0]    _zz_io_output_aluOp;
  wire       [6:0]    _zz_io_output_aluOp_1;
  wire       [6:0]    _zz_io_output_aluOp_2;
  wire                when_Decoder_l349;
  wire                when_Decoder_l356;
  wire                when_Decoder_l374;
  wire                when_Decoder_l375;
  wire                when_Decoder_l376;
  wire                when_Decoder_l387;
  wire                when_Decoder_l388;
  wire       [6:0]    _zz_io_output_aluOp_3;
  wire                when_Decoder_l882;
  wire       [6:0]    _zz_io_output_aluOp_4;
  wire       [6:0]    _zz_io_output_aluOp_5;
  wire                when_Decoder_l955;
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
  `endif


  assign _zz_immI = io_instruction[31 : 20];
  assign _zz_immS = {io_instruction[31 : 25],io_instruction[11 : 7]};
  assign _zz_immB = ({1'd0,_zz_immB_1} <<< 1'd1);
  assign _zz_immB_2 = {io_instruction[31],{io_instruction[7],{io_instruction[30 : 25],io_instruction[11 : 8]}}};
  assign _zz_immB_1 = {{20{_zz_immB_2[11]}}, _zz_immB_2};
  assign _zz_immU = ({12'd0,io_instruction[31 : 12]} <<< 4'd12);
  assign _zz_immJ = ({1'd0,_zz_immJ_1} <<< 1'd1);
  assign _zz_immJ_2 = {io_instruction[31],{io_instruction[19 : 12],{io_instruction[20],io_instruction[30 : 21]}}};
  assign _zz_immJ_1 = {{12{_zz_immJ_2[19]}}, _zz_immJ_2};
  assign _zz_crdp_1 = io_instruction[4 : 2];
  assign _zz_crdp = {2'd0, _zz_crdp_1};
  assign _zz_crs1p_1 = io_instruction[9 : 7];
  assign _zz_crs1p = {2'd0, _zz_crs1p_1};
  assign _zz_crs2p_1 = io_instruction[4 : 2];
  assign _zz_crs2p = {2'd0, _zz_crs2p_1};
  assign _zz_cShamt_1 = c6;
  assign _zz_cShamt = {26'd0, _zz_cShamt_1};
  assign _zz_cAddi16sp = ({4'd0,{io_instruction[12],{io_instruction[4],{io_instruction[3],{io_instruction[5],{io_instruction[2],io_instruction[6]}}}}}} <<< 3'd4);
  assign _zz_cLdImm = ({3'd0,{io_instruction[6 : 5],io_instruction[12 : 10]}} <<< 2'd3);
  assign _zz_cLdspImm = ({3'd0,{io_instruction[4 : 2],{io_instruction[12],io_instruction[6 : 5]}}} <<< 2'd3);
  assign _zz_cSdspImm = ({3'd0,{io_instruction[9 : 7],io_instruction[12 : 10]}} <<< 2'd3);
  assign _zz_io_output_imm = {22'd0, cAddi4spn};
  assign _zz_io_output_imm_1 = {25'd0, cLwImm};
  assign _zz_io_output_imm_2 = {25'd0, cLwImm};
  assign _zz_io_output_imm_3 = ({12'd0,c6S} <<< 4'd12);
  assign _zz_io_output_imm_4 = {24'd0, cLwspImm};
  assign _zz_io_output_imm_5 = {24'd0, cSwspImm};
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
  `endif

  assign opcode = io_instruction[6 : 0];
  assign funct3 = io_instruction[14 : 12];
  assign funct7 = io_instruction[31 : 25];
  assign funct5 = io_instruction[31 : 27];
  assign funct6 = io_instruction[31 : 26];
  assign convSel = io_instruction[21 : 20];
  assign rs1Num = io_instruction[19 : 15];
  assign rdNum = io_instruction[11 : 7];
  assign immI = {{20{_zz_immI[11]}}, _zz_immI};
  assign immS = {{20{_zz_immS[11]}}, _zz_immS};
  assign immB = _zz_immB[31:0];
  assign immU = _zz_immU;
  assign immJ = _zz_immJ[31:0];
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
              io_output_regWrite = 1'b1;
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
                  if(!when_Decoder_l280) begin
                    io_output_regWrite = 1'b1;
                  end
                end
                2'b01 : begin
                  if(!when_Decoder_l291) begin
                    io_output_regWrite = 1'b1;
                  end
                end
                2'b10 : begin
                  io_output_regWrite = 1'b1;
                end
                default : begin
                  if(!when_Decoder_l302) begin
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
              if(!when_Decoder_l349) begin
                io_output_regWrite = 1'b1;
              end
            end
            3'b010 : begin
              if(!when_Decoder_l356) begin
                io_output_regWrite = 1'b1;
              end
            end
            3'b011 : begin
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
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
          if(when_Decoder_l882) begin
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
            end
            3'b110 : begin
              io_output_aluSrc = 1'b1;
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
              io_output_aluSrc = 1'b1;
            end
            3'b001 : begin
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
                  if(!when_Decoder_l280) begin
                    io_output_aluSrc = 1'b1;
                  end
                end
                2'b01 : begin
                  if(!when_Decoder_l291) begin
                    io_output_aluSrc = 1'b1;
                  end
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
              if(!when_Decoder_l349) begin
                io_output_aluSrc = 1'b1;
              end
            end
            3'b010 : begin
              if(!when_Decoder_l356) begin
                io_output_aluSrc = 1'b1;
              end
            end
            3'b011 : begin
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
              io_output_wbSel = 3'b010;
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
              io_output_jump = 1'b1;
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
            end
            3'b110 : begin
              io_output_aluOp = AluOp_ADD;
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
              io_output_aluOp = AluOp_ADD;
            end
            3'b001 : begin
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
                  if(!when_Decoder_l280) begin
                    io_output_aluOp = AluOp_SRL_1;
                  end
                end
                2'b01 : begin
                  if(!when_Decoder_l291) begin
                    io_output_aluOp = AluOp_SRA_1;
                  end
                end
                2'b10 : begin
                  io_output_aluOp = AluOp_AND_1;
                end
                default : begin
                  if(!when_Decoder_l302) begin
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
              if(!when_Decoder_l349) begin
                io_output_aluOp = AluOp_SLL_1;
              end
            end
            3'b010 : begin
              if(!when_Decoder_l356) begin
                io_output_aluOp = AluOp_ADD;
              end
            end
            3'b011 : begin
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
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
          if(when_Decoder_l882) begin
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
                io_output_aluOp = _zz_io_output_aluOp_4;
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
                io_output_aluOp = _zz_io_output_aluOp_5;
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
          if(when_Decoder_l955) begin
            casez(funct3)
              3'b010 : begin
                io_output_aluOp = AluOp_SH1ADD;
              end
              3'b100 : begin
                io_output_aluOp = AluOp_SH2ADD;
              end
              3'b110 : begin
                io_output_aluOp = AluOp_SH3ADD;
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
      case(switch_Decoder_l192)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
            end
            3'b010 : begin
              io_output_memSize = 2'b10;
            end
            3'b011 : begin
            end
            3'b110 : begin
              io_output_memSize = 2'b10;
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
                io_output_memSize = 2'b10;
              end
            end
            3'b011 : begin
            end
            3'b100 : begin
            end
            3'b110 : begin
              io_output_memSize = 2'b10;
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
            end
            3'b110 : begin
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
            end
            3'b110 : begin
              io_output_rs1 = crs1p;
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
              io_output_rs1 = crd;
            end
            3'b001 : begin
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
                  if(!when_Decoder_l280) begin
                    io_output_rs1 = crs1p;
                  end
                end
                2'b01 : begin
                  if(!when_Decoder_l291) begin
                    io_output_rs1 = crs1p;
                  end
                end
                2'b10 : begin
                  io_output_rs1 = crs1p;
                end
                default : begin
                  if(!when_Decoder_l302) begin
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
              if(!when_Decoder_l349) begin
                io_output_rs1 = crd;
              end
            end
            3'b010 : begin
              if(!when_Decoder_l356) begin
                io_output_rs1 = 5'h02;
              end
            end
            3'b011 : begin
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
                  if(!when_Decoder_l302) begin
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
              io_output_rd = 5'h01;
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
                  if(!when_Decoder_l280) begin
                    io_output_rd = crs1p;
                  end
                end
                2'b01 : begin
                  if(!when_Decoder_l291) begin
                    io_output_rd = crs1p;
                  end
                end
                2'b10 : begin
                  io_output_rd = crs1p;
                end
                default : begin
                  if(!when_Decoder_l302) begin
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
              if(!when_Decoder_l349) begin
                io_output_rd = crd;
              end
            end
            3'b010 : begin
              if(!when_Decoder_l356) begin
                io_output_rd = crd;
              end
            end
            3'b011 : begin
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
            end
            3'b110 : begin
              io_output_imm = _zz_io_output_imm_2;
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
              io_output_imm = {{26{c6S[5]}}, c6S};
            end
            3'b001 : begin
              io_output_imm = {{20{cJImm[11]}}, cJImm};
            end
            3'b010 : begin
              io_output_imm = {{26{c6S[5]}}, c6S};
            end
            3'b011 : begin
              if(when_Decoder_l259) begin
                io_output_imm = {{22{cAddi16sp[9]}}, cAddi16sp};
              end else begin
                if(!when_Decoder_l264) begin
                  io_output_imm = {{14{_zz_io_output_imm_3[17]}}, _zz_io_output_imm_3};
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l274)
                2'b00 : begin
                  if(!when_Decoder_l280) begin
                    io_output_imm = cShamt;
                  end
                end
                2'b01 : begin
                  if(!when_Decoder_l291) begin
                    io_output_imm = cShamt;
                  end
                end
                2'b10 : begin
                  io_output_imm = {{26{c6S[5]}}, c6S};
                end
                default : begin
                end
              endcase
            end
            3'b101 : begin
              io_output_imm = {{20{cJImm[11]}}, cJImm};
            end
            3'b110 : begin
              io_output_imm = {{23{cBImm[8]}}, cBImm};
            end
            default : begin
              io_output_imm = {{23{cBImm[8]}}, cBImm};
            end
          endcase
        end
        2'b10 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l349) begin
                io_output_imm = cShamt;
              end
            end
            3'b010 : begin
              if(!when_Decoder_l356) begin
                io_output_imm = _zz_io_output_imm_4;
              end
            end
            3'b011 : begin
            end
            3'b100 : begin
              if(when_Decoder_l374) begin
                if(when_Decoder_l375) begin
                  if(!when_Decoder_l376) begin
                    io_output_imm = 32'h0;
                  end
                end
              end else begin
                if(when_Decoder_l387) begin
                  if(!when_Decoder_l388) begin
                    io_output_imm = 32'h0;
                  end
                end
              end
            end
            3'b110 : begin
              io_output_imm = _zz_io_output_imm_5;
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
              io_output_illegal = 1'b1;
            end
            3'b110 : begin
            end
            3'b111 : begin
              io_output_illegal = 1'b1;
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
                  if(when_Decoder_l280) begin
                    io_output_illegal = 1'b1;
                  end
                end
                2'b01 : begin
                  if(when_Decoder_l291) begin
                    io_output_illegal = 1'b1;
                  end
                end
                2'b10 : begin
                end
                default : begin
                  if(when_Decoder_l302) begin
                    io_output_illegal = 1'b1;
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
              if(when_Decoder_l349) begin
                io_output_illegal = 1'b1;
              end
            end
            3'b010 : begin
              if(when_Decoder_l356) begin
                io_output_illegal = 1'b1;
              end
            end
            3'b011 : begin
              io_output_illegal = 1'b1;
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
              io_output_illegal = 1'b1;
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
              io_output_illegal = 1'b1;
            end
            3'b110 : begin
              io_output_illegal = 1'b1;
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
              io_output_illegal = 1'b1;
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
          io_output_illegal = 1'b1;
        end
        7'b0111011 : begin
          io_output_illegal = 1'b1;
        end
        7'b0110011 : begin
          if(when_Decoder_l882) begin
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
              io_output_valid = 1'b0;
            end
            3'b110 : begin
            end
            3'b111 : begin
              io_output_valid = 1'b0;
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
                  if(when_Decoder_l280) begin
                    io_output_valid = 1'b0;
                  end
                end
                2'b01 : begin
                  if(when_Decoder_l291) begin
                    io_output_valid = 1'b0;
                  end
                end
                2'b10 : begin
                end
                default : begin
                  if(when_Decoder_l302) begin
                    io_output_valid = 1'b0;
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
              if(when_Decoder_l349) begin
                io_output_valid = 1'b0;
              end
            end
            3'b010 : begin
              if(when_Decoder_l356) begin
                io_output_valid = 1'b0;
              end
            end
            3'b011 : begin
              io_output_valid = 1'b0;
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
              io_output_valid = 1'b0;
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
              io_output_valid = 1'b0;
            end
            3'b110 : begin
              io_output_valid = 1'b0;
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
              io_output_valid = 1'b0;
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
          io_output_valid = 1'b0;
        end
        7'b0111011 : begin
          io_output_valid = 1'b0;
        end
        7'b0110011 : begin
          if(when_Decoder_l882) begin
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
  assign when_Decoder_l259 = (crd == 5'h02);
  assign when_Decoder_l264 = ((crd == 5'h0) || (c6 == 6'h0));
  assign switch_Decoder_l274 = io_instruction[11 : 10];
  assign when_Decoder_l280 = io_instruction[12];
  assign when_Decoder_l291 = io_instruction[12];
  assign when_Decoder_l302 = io_instruction[12];
  assign _zz_io_output_aluOp = (io_instruction[5] ? AluOp_AND_1 : AluOp_OR_1);
  assign _zz_io_output_aluOp_1 = (io_instruction[5] ? AluOp_XOR_1 : AluOp_SUB);
  assign _zz_io_output_aluOp_2 = (io_instruction[6] ? _zz_io_output_aluOp : _zz_io_output_aluOp_1);
  assign when_Decoder_l349 = io_instruction[12];
  assign when_Decoder_l356 = (crd == 5'h0);
  assign when_Decoder_l374 = (io_instruction[12] == 1'b0);
  assign when_Decoder_l375 = (crs2 == 5'h0);
  assign when_Decoder_l376 = (crd == 5'h0);
  assign when_Decoder_l387 = (crs2 == 5'h0);
  assign when_Decoder_l388 = (crd == 5'h0);
  assign _zz_io_output_aluOp_3 = (io_instruction[30] ? AluOp_SRA_1 : AluOp_SRL_1);
  assign when_Decoder_l882 = ((funct7 & 7'h7f) == 7'h01);
  assign _zz_io_output_aluOp_4 = (io_instruction[30] ? AluOp_SUB : AluOp_ADD);
  assign _zz_io_output_aluOp_5 = (io_instruction[30] ? AluOp_SRA_1 : AluOp_SRL_1);
  assign when_Decoder_l955 = ((funct7 & 7'h7f) == 7'h10);
  assign switch_Decoder_l1024 = io_instruction[31 : 20];

endmodule
