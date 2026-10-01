// Generator : SpinalHDL v1.14.2    git head : 78f29dc66110fc099a777992b6daa2f803ab445e
// Component : RiscvCoreF
// Git hash  : 315e41b9a80e183597f34c6177fb1f2bc6859e2d

`timescale 1ns/1ps

module RiscvCoreF (
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
  localparam AluOp_ADD = 5'd0;
  localparam AluOp_SUB = 5'd1;
  localparam AluOp_SLL_1 = 5'd2;
  localparam AluOp_SLT = 5'd3;
  localparam AluOp_SLTU = 5'd4;
  localparam AluOp_XOR_1 = 5'd5;
  localparam AluOp_SRL_1 = 5'd6;
  localparam AluOp_SRA_1 = 5'd7;
  localparam AluOp_OR_1 = 5'd8;
  localparam AluOp_AND_1 = 5'd9;
  localparam AluOp_ADDW = 5'd10;
  localparam AluOp_SUBW = 5'd11;
  localparam AluOp_SLLW = 5'd12;
  localparam AluOp_SRLW = 5'd13;
  localparam AluOp_SRAW = 5'd14;
  localparam AluOp_MUL = 5'd15;
  localparam AluOp_MULH = 5'd16;
  localparam AluOp_MULHSU = 5'd17;
  localparam AluOp_MULHU = 5'd18;
  localparam AluOp_DIV = 5'd19;
  localparam AluOp_DIVU = 5'd20;
  localparam AluOp_REM_1 = 5'd21;
  localparam AluOp_REMU = 5'd22;
  localparam AluOp_MULW = 5'd23;
  localparam AluOp_DIVW = 5'd24;
  localparam AluOp_DIVUW = 5'd25;
  localparam AluOp_REMW = 5'd26;
  localparam AluOp_REMUW = 5'd27;
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
  wire                fpRegFile_io_writeEnable;
  wire       [63:0]   fpUnit_1_io_a;
  wire       [63:0]   fpUnit_1_io_b;
  wire       [63:0]   fpUnit_1_io_c;
  wire                csrFile_1_io_csrWe;
  wire       [31:0]   csrFile_1_io_trapEpc;
  wire       [31:0]   csrFile_1_io_trapCause;
  wire       [31:0]   csrFile_1_io_trapTval;
  wire                csrFile_1_io_fpDirty;
  wire                csrFile_1_io_fpFlagsWe;
  wire                decoder_1_io_output_regWrite;
  wire                decoder_1_io_output_aluSrc;
  wire       [2:0]    decoder_1_io_output_wbSel;
  wire                decoder_1_io_output_branch;
  wire                decoder_1_io_output_jump;
  wire                decoder_1_io_output_jalr;
  wire       [4:0]    decoder_1_io_output_aluOp;
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
  wire       [63:0]   fpUnit_1_io_result;
  wire       [4:0]    fpUnit_1_io_flags;
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
  wire       [31:0]   _zz_aluResult;
  wire       [31:0]   _zz_csrWrDataEx;
  wire       [31:0]   _zz_branchCond;
  wire       [31:0]   _zz_branchCond_1;
  wire       [31:0]   _zz_branchCond_2;
  wire       [31:0]   _zz_branchCond_3;
  wire       [31:0]   _zz_ctrlTarget;
  wire       [4:0]    _zz_divInEx;
  wire       [4:0]    _zz_divInEx_1;
  wire                _zz_csrImplemented;
  wire                _zz_csrImplemented_1;
  wire       [11:0]   _zz_csrImplemented_2;
  wire                _zz_csrPrivIllegal;
  wire                _zz_csrPrivIllegal_1;
  wire                _zz_csrPrivIllegal_2;
  wire       [1:0]    _zz_csrPrivIllegal_3;
  wire       [3:0]    _zz_exTrapCause;
  wire       [31:0]   _zz_exTrapTval;
  wire       [63:0]   _zz_io_a;
  wire       [63:0]   _zz_io_a_1;
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
  reg        [4:0]    idEx_aluOp;
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
  wire       [31:0]   fpRs1Data;
  wire       [31:0]   fpRs2Data;
  wire       [31:0]   fpRs3Data;
  wire       [31:0]   wbWriteData;
  reg        [31:0]   forwardRs1;
  wire                when_RiscvCore_l394;
  wire                when_RiscvCore_l396;
  reg        [31:0]   forwardRs2;
  wire                when_RiscvCore_l409;
  wire                when_RiscvCore_l411;
  wire       [31:0]   fpFwdRs1;
  wire       [31:0]   fpFwdRs2;
  wire       [31:0]   fpFwdRs3;
  wire                _zz_fpFwdRs1;
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
  wire                when_RiscvCore_l561;
  wire                when_RiscvCore_l565;
  wire                when_RiscvCore_l569;
  wire                when_RiscvCore_l578;
  wire                when_RiscvCore_l584;
  wire                when_RiscvCore_l587;
  wire                when_RiscvCore_l596;
  wire                when_RiscvCore_l601;
  wire                when_RiscvCore_l604;
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
  wire                isFpCompute;
  wire                isFpFromInt;
  wire                isFpMvW;
  wire                isFpMvX;
  wire       [2:0]    fpRmEx;
  wire       [63:0]   fpuResult;
  wire       [4:0]    fpuFlags;
  wire       [31:0]   fpToIntResult;
  wire       [31:0]   fpToFpResult;
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
  wire                when_RiscvCore_l896;
  wire                when_RiscvCore_l903;
  wire                when_RiscvCore_l911;
  wire                when_RiscvCore_l912;
  wire                when_RiscvCore_l925;
  wire                when_RiscvCore_l926;
  wire                when_RiscvCore_l972;
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
  wire       [31:0]   fpLoadData;
  wire                when_RiscvCore_l1083;
  `ifndef SYNTHESIS
  reg [47:0] idEx_aluOp_string;
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
  assign _zz_io_a = {32'd0, forwardRs1};
  assign _zz_io_a_1 = {32'd0, fpFwdRs1};
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
    .io_output_aluOp      (decoder_1_io_output_aluOp[4:0]     ), //o
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
  FpRegisterFile fpRegFile (
    .io_rs1          (idEx_rs1[4:0]                  ), //i
    .io_rs2          (idEx_rs2[4:0]                  ), //i
    .io_rs3          (idEx_rs3[4:0]                  ), //i
    .io_rd           (memWb_rd[4:0]                  ), //i
    .io_writeData    (memWb_wbData[31:0]             ), //i
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
  FpUnit fpUnit_1 (
    .io_op     (idEx_fpOp[5:0]          ), //i
    .io_rm     (fpRmEx[2:0]             ), //i
    .io_a      (fpUnit_1_io_a[63:0]     ), //i
    .io_b      (fpUnit_1_io_b[63:0]     ), //i
    .io_c      (fpUnit_1_io_c[63:0]     ), //i
    .io_result (fpUnit_1_io_result[63:0]), //o
    .io_flags  (fpUnit_1_io_flags[4:0]  )  //o
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
    .io_fpDirty        (csrFile_1_io_fpDirty          ), //i
    .io_fpFlagsWe      (csrFile_1_io_fpFlagsWe        ), //i
    .io_fpFlags        (memWb_fpFlags[4:0]            ), //i
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
    .io_op     (idEx_aluOp[4:0]      ), //i
    .io_result (alu_1_io_result[31:0])  //o
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(idEx_aluOp)
      AluOp_ADD : idEx_aluOp_string = "ADD   ";
      AluOp_SUB : idEx_aluOp_string = "SUB   ";
      AluOp_SLL_1 : idEx_aluOp_string = "SLL_1 ";
      AluOp_SLT : idEx_aluOp_string = "SLT   ";
      AluOp_SLTU : idEx_aluOp_string = "SLTU  ";
      AluOp_XOR_1 : idEx_aluOp_string = "XOR_1 ";
      AluOp_SRL_1 : idEx_aluOp_string = "SRL_1 ";
      AluOp_SRA_1 : idEx_aluOp_string = "SRA_1 ";
      AluOp_OR_1 : idEx_aluOp_string = "OR_1  ";
      AluOp_AND_1 : idEx_aluOp_string = "AND_1 ";
      AluOp_ADDW : idEx_aluOp_string = "ADDW  ";
      AluOp_SUBW : idEx_aluOp_string = "SUBW  ";
      AluOp_SLLW : idEx_aluOp_string = "SLLW  ";
      AluOp_SRLW : idEx_aluOp_string = "SRLW  ";
      AluOp_SRAW : idEx_aluOp_string = "SRAW  ";
      AluOp_MUL : idEx_aluOp_string = "MUL   ";
      AluOp_MULH : idEx_aluOp_string = "MULH  ";
      AluOp_MULHSU : idEx_aluOp_string = "MULHSU";
      AluOp_MULHU : idEx_aluOp_string = "MULHU ";
      AluOp_DIV : idEx_aluOp_string = "DIV   ";
      AluOp_DIVU : idEx_aluOp_string = "DIVU  ";
      AluOp_REM_1 : idEx_aluOp_string = "REM_1 ";
      AluOp_REMU : idEx_aluOp_string = "REMU  ";
      AluOp_MULW : idEx_aluOp_string = "MULW  ";
      AluOp_DIVW : idEx_aluOp_string = "DIVW  ";
      AluOp_DIVUW : idEx_aluOp_string = "DIVUW ";
      AluOp_REMW : idEx_aluOp_string = "REMW  ";
      AluOp_REMUW : idEx_aluOp_string = "REMUW ";
      default : idEx_aluOp_string = "??????";
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
  assign when_RiscvCore_l394 = ((((((exMem_valid && exMem_regWrite) && (exMem_rd != 5'h0)) && (! exMem_memRead)) && (! exMem_atomic)) && (exMem_wbSel != 3'b011)) && (exMem_rd == idEx_rs1));
  always @(*) begin
    if(when_RiscvCore_l394) begin
      forwardRs1 = exMem_aluResult;
    end else begin
      if(when_RiscvCore_l396) begin
        forwardRs1 = wbWriteData;
      end else begin
        forwardRs1 = regFile_io_rs1Data;
      end
    end
  end

  assign when_RiscvCore_l396 = (((memWb_valid && memWb_regWrite) && (memWb_rd != 5'h0)) && (memWb_rd == idEx_rs1));
  assign when_RiscvCore_l409 = ((((((exMem_valid && exMem_regWrite) && (exMem_rd != 5'h0)) && (! exMem_memRead)) && (! exMem_atomic)) && (exMem_wbSel != 3'b011)) && (exMem_rd == idEx_rs2));
  always @(*) begin
    if(when_RiscvCore_l409) begin
      forwardRs2 = exMem_aluResult;
    end else begin
      if(when_RiscvCore_l411) begin
        forwardRs2 = wbWriteData;
      end else begin
        forwardRs2 = regFile_io_rs2Data;
      end
    end
  end

  assign when_RiscvCore_l411 = (((memWb_valid && memWb_regWrite) && (memWb_rd != 5'h0)) && (memWb_rd == idEx_rs2));
  assign _zz_fpFwdRs1 = ((memWb_valid && memWb_fpWrite) && (memWb_rd != 5'h0));
  assign fpFwdRs1 = ((_zz_fpFwdRs1 && (memWb_rd == idEx_rs1)) ? memWb_wbData : fpRs1Data);
  assign fpFwdRs2 = ((_zz_fpFwdRs1 && (memWb_rd == idEx_rs2)) ? memWb_wbData : fpRs2Data);
  assign fpFwdRs3 = ((_zz_fpFwdRs1 && (memWb_rd == idEx_rs3)) ? memWb_wbData : fpRs3Data);
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
      if(when_RiscvCore_l561) begin
        exTrapEna = 1'b1;
      end
      if(when_RiscvCore_l565) begin
        exTrapEna = 1'b1;
      end
      if(when_RiscvCore_l569) begin
        exTrapEna = 1'b1;
      end
      if(csrIllegal) begin
        exTrapEna = 1'b1;
      end
      if(when_RiscvCore_l578) begin
        exTrapEna = 1'b1;
      end
      if(when_RiscvCore_l584) begin
        if(when_RiscvCore_l587) begin
          exTrapEna = 1'b1;
        end
      end
      if(when_RiscvCore_l596) begin
        exTrapEna = 1'b1;
      end
      if(when_RiscvCore_l601) begin
        if(when_RiscvCore_l604) begin
          exTrapEna = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    exTrapCause = 32'h0;
    if(idEx_valid) begin
      if(when_RiscvCore_l561) begin
        exTrapCause = {28'd0, _zz_exTrapCause};
      end
      if(when_RiscvCore_l565) begin
        exTrapCause = 32'h00000003;
      end
      if(when_RiscvCore_l569) begin
        exTrapCause = 32'h00000002;
      end
      if(csrIllegal) begin
        exTrapCause = 32'h00000002;
      end
      if(when_RiscvCore_l578) begin
        exTrapCause = 32'h00000002;
      end
      if(when_RiscvCore_l584) begin
        if(when_RiscvCore_l587) begin
          exTrapCause = (idEx_isLr ? 32'h00000004 : 32'h00000006);
        end
      end
      if(when_RiscvCore_l596) begin
        exTrapCause = 32'h00000002;
      end
      if(when_RiscvCore_l601) begin
        if(when_RiscvCore_l604) begin
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
      if(when_RiscvCore_l584) begin
        if(when_RiscvCore_l587) begin
          exTrapTval = aluResult;
        end
      end
      if(when_RiscvCore_l601) begin
        if(when_RiscvCore_l604) begin
          exTrapTval = aluResult;
        end
      end
    end
  end

  assign mppSupported = ((csrFile_1_io_mstatusMpp == 2'b00) || (csrFile_1_io_mstatusMpp == 2'b11));
  assign when_RiscvCore_l561 = (idEx_sysOp == SysOp_ECALL);
  assign when_RiscvCore_l565 = (idEx_sysOp == SysOp_EBREAK);
  assign when_RiscvCore_l569 = ((idEx_sysOp == SysOp_MRET) && ((csrFile_1_io_curMode != MODE_M) || (! mppSupported)));
  assign when_RiscvCore_l578 = (idEx_illegal || (idEx_sysOp == SysOp_ILLEGAL));
  assign when_RiscvCore_l584 = (idEx_atomic || idEx_isLr);
  assign when_RiscvCore_l587 = (! ((idEx_memSize == 2'b10) ? (aluResult[1 : 0] == 2'b00) : (aluResult[2 : 0] == 3'b000)));
  assign when_RiscvCore_l596 = (idEx_fp && (csrFile_1_io_mstatusFs == 2'b00));
  assign when_RiscvCore_l601 = (idEx_fpLoad || idEx_fpStore);
  assign when_RiscvCore_l604 = (! ((idEx_memSize == 2'b11) ? (aluResult[2 : 0] == 3'b000) : (aluResult[1 : 0] == 2'b00)));
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
  assign fpUnit_1_io_a = (isFpFromInt ? _zz_io_a : _zz_io_a_1);
  assign fpUnit_1_io_b = {32'd0, fpFwdRs2};
  assign fpUnit_1_io_c = {32'd0, fpFwdRs3};
  assign fpuResult = fpUnit_1_io_result;
  assign fpuFlags = fpUnit_1_io_flags;
  assign fpToIntResult = (isFpMvX ? _zz_fpToIntResult : _zz_fpToIntResult_1);
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
  assign csrFile_1_io_fpDirty = (memWb_valid && (memWb_fpWrite || (memWb_csrWe && (((memWb_csrAddr == 12'h001) || (memWb_csrAddr == 12'h002)) || (memWb_csrAddr == 12'h003)))));
  assign csrFile_1_io_fpFlagsWe = (memWb_valid && memWb_fpWrite);
  assign flushYounger = (((ctrlFlush || trapCommit) || exMret) || intrTake);
  assign bubbleEx = ((trapCommit || exMret) || csrMretStall);
  assign when_RiscvCore_l896 = (! freezeAll);
  assign when_RiscvCore_l903 = (stallData || csrMretStall);
  assign when_RiscvCore_l911 = (! freezeAll);
  assign when_RiscvCore_l912 = (stallData || csrMretStall);
  assign when_RiscvCore_l925 = ((! freezeAll) && (! csrMretStall));
  assign when_RiscvCore_l926 = (stallData || flushYounger);
  assign when_RiscvCore_l972 = (! freezeAll);
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
  assign fpLoadData = loadResult[31 : 0];
  assign when_RiscvCore_l1083 = (! freezeAll);
  assign regFile_io_writeEnable = (memWb_valid && memWb_regWrite);
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
      if(when_RiscvCore_l896) begin
        if(trapCommit) begin
          pcReg <= trapEntry;
        end else begin
          if(exMret) begin
            pcReg <= csrFile_1_io_mepc;
          end else begin
            if(ctrlFlush) begin
              pcReg <= ctrlTarget;
            end else begin
              if(when_RiscvCore_l903) begin
                pcReg <= pcReg;
              end else begin
                pcReg <= (pcReg + _zz_pcReg);
              end
            end
          end
        end
      end
      if(when_RiscvCore_l911) begin
        if(!when_RiscvCore_l912) begin
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
      if(when_RiscvCore_l925) begin
        if(when_RiscvCore_l926) begin
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
      if(when_RiscvCore_l972) begin
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
        exMem_fpRs2Data <= fpFwdRs2;
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
      if(when_RiscvCore_l1083) begin
        memWb_valid <= exMem_valid;
        memWb_regWrite <= exMem_regWrite;
        memWb_rd <= exMem_rd;
        memWb_wbSel <= exMem_wbSel;
        memWb_fp <= exMem_fp;
        memWb_fpWrite <= exMem_fpWrite;
        memWb_fpFlags <= exMem_fpFlags;
        if(exMem_fpLoad) begin
          memWb_wbData <= fpLoadData;
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

module Alu (
  input  wire [31:0]   io_a,
  input  wire [31:0]   io_b,
  input  wire [4:0]    io_op,
  output wire [31:0]   io_result
);
  localparam AluOp_ADD = 5'd0;
  localparam AluOp_SUB = 5'd1;
  localparam AluOp_SLL_1 = 5'd2;
  localparam AluOp_SLT = 5'd3;
  localparam AluOp_SLTU = 5'd4;
  localparam AluOp_XOR_1 = 5'd5;
  localparam AluOp_SRL_1 = 5'd6;
  localparam AluOp_SRA_1 = 5'd7;
  localparam AluOp_OR_1 = 5'd8;
  localparam AluOp_AND_1 = 5'd9;
  localparam AluOp_ADDW = 5'd10;
  localparam AluOp_SUBW = 5'd11;
  localparam AluOp_SLLW = 5'd12;
  localparam AluOp_SRLW = 5'd13;
  localparam AluOp_SRAW = 5'd14;
  localparam AluOp_MUL = 5'd15;
  localparam AluOp_MULH = 5'd16;
  localparam AluOp_MULHSU = 5'd17;
  localparam AluOp_MULHU = 5'd18;
  localparam AluOp_DIV = 5'd19;
  localparam AluOp_DIVU = 5'd20;
  localparam AluOp_REM_1 = 5'd21;
  localparam AluOp_REMU = 5'd22;
  localparam AluOp_MULW = 5'd23;
  localparam AluOp_DIVW = 5'd24;
  localparam AluOp_DIVUW = 5'd25;
  localparam AluOp_REMW = 5'd26;
  localparam AluOp_REMUW = 5'd27;

  wire       [32:0]   _zz_bUE;
  wire       [63:0]   _zz_mulLow;
  wire       [63:0]   _zz_mulHighS;
  wire       [65:0]   _zz_mulHighSu;
  wire       [63:0]   _zz_mulHighU;
  wire       [31:0]   _zz_result;
  wire       [31:0]   _zz_result_1;
  wire       [31:0]   _zz_result_2;
  wire       [62:0]   _zz_result_3;
  wire       [31:0]   _zz_result_4;
  wire       [31:0]   _zz_result_5;
  wire       [31:0]   _zz_result_6;
  wire       [31:0]   _zz_result_7;
  wire       [31:0]   _zz_result_8;
  wire       [31:0]   _zz_result_9;
  wire       [62:0]   _zz_result_10;
  wire       [31:0]   _zz_result_11;
  wire       [31:0]   _zz_result_12;
  wire       [31:0]   _zz_result_13;
  wire       [31:0]   _zz_result_14;
  wire       [63:0]   _zz_result_15;
  wire       [31:0]   aU;
  wire       [31:0]   bU;
  wire       [31:0]   aS;
  wire       [31:0]   bS;
  wire       [4:0]    shamt;
  wire       [31:0]   aW;
  wire       [31:0]   bW;
  wire       [31:0]   aWU;
  wire       [4:0]    shamtW;
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
  `ifndef SYNTHESIS
  reg [47:0] io_op_string;
  `endif


  assign _zz_bUE = {1'd0, bU};
  assign _zz_mulLow = mulUU;
  assign _zz_mulHighS = mulSS;
  assign _zz_mulHighSu = mulSU;
  assign _zz_mulHighU = mulUU;
  assign _zz_result = (aU + bU);
  assign _zz_result_1 = (aU - bU);
  assign _zz_result_3 = ({31'd0,aU} <<< shamt);
  assign _zz_result_2 = _zz_result_3[31:0];
  assign _zz_result_4 = (aU >>> shamt);
  assign _zz_result_5 = ($signed(aS) >>> shamt);
  assign _zz_result_6 = ($signed(aW) + $signed(bW));
  assign _zz_result_7 = ($signed(aW) - $signed(bW));
  assign _zz_result_8 = _zz_result_9;
  assign _zz_result_10 = ({31'd0,aWU} <<< shamtW);
  assign _zz_result_9 = _zz_result_10[31:0];
  assign _zz_result_11 = _zz_result_12;
  assign _zz_result_12 = (aWU >>> shamtW);
  assign _zz_result_13 = ($signed(aW) >>> shamtW);
  assign _zz_result_15 = ($signed(aW) * $signed(bW));
  assign _zz_result_14 = _zz_result_15[31:0];
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_op)
      AluOp_ADD : io_op_string = "ADD   ";
      AluOp_SUB : io_op_string = "SUB   ";
      AluOp_SLL_1 : io_op_string = "SLL_1 ";
      AluOp_SLT : io_op_string = "SLT   ";
      AluOp_SLTU : io_op_string = "SLTU  ";
      AluOp_XOR_1 : io_op_string = "XOR_1 ";
      AluOp_SRL_1 : io_op_string = "SRL_1 ";
      AluOp_SRA_1 : io_op_string = "SRA_1 ";
      AluOp_OR_1 : io_op_string = "OR_1  ";
      AluOp_AND_1 : io_op_string = "AND_1 ";
      AluOp_ADDW : io_op_string = "ADDW  ";
      AluOp_SUBW : io_op_string = "SUBW  ";
      AluOp_SLLW : io_op_string = "SLLW  ";
      AluOp_SRLW : io_op_string = "SRLW  ";
      AluOp_SRAW : io_op_string = "SRAW  ";
      AluOp_MUL : io_op_string = "MUL   ";
      AluOp_MULH : io_op_string = "MULH  ";
      AluOp_MULHSU : io_op_string = "MULHSU";
      AluOp_MULHU : io_op_string = "MULHU ";
      AluOp_DIV : io_op_string = "DIV   ";
      AluOp_DIVU : io_op_string = "DIVU  ";
      AluOp_REM_1 : io_op_string = "REM_1 ";
      AluOp_REMU : io_op_string = "REMU  ";
      AluOp_MULW : io_op_string = "MULW  ";
      AluOp_DIVW : io_op_string = "DIVW  ";
      AluOp_DIVUW : io_op_string = "DIVUW ";
      AluOp_REMW : io_op_string = "REMW  ";
      AluOp_REMUW : io_op_string = "REMUW ";
      default : io_op_string = "??????";
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
        result = _zz_result;
      end
      AluOp_SUB : begin
        result = _zz_result_1;
      end
      AluOp_SLL_1 : begin
        result = _zz_result_2;
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
        result = _zz_result_4;
      end
      AluOp_SRA_1 : begin
        result = _zz_result_5;
      end
      AluOp_OR_1 : begin
        result = (io_a | io_b);
      end
      AluOp_AND_1 : begin
        result = (io_a & io_b);
      end
      AluOp_ADDW : begin
        result = _zz_result_6;
      end
      AluOp_SUBW : begin
        result = _zz_result_7;
      end
      AluOp_SLLW : begin
        result = _zz_result_8;
      end
      AluOp_SRLW : begin
        result = _zz_result_11;
      end
      AluOp_SRAW : begin
        result = _zz_result_13;
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
        result = _zz_result_14;
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
      default : begin
        result = 32'h0;
      end
    endcase
  end

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

  wire       [7:0]    _zz_readData;
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
  wire                when_CsrFile_l102;
  wire                when_CsrFile_l103;
  wire                when_CsrFile_l104;
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
  assign mipBits = {{24'h0,io_timerInterrupt},7'h0};
  always @(*) begin
    case(io_csrAddr)
      12'h300 : begin
        readData = mstatusReg;
      end
      12'h301 : begin
        readData = 32'h40100120;
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
    if(when_CsrFile_l102) begin
      readData = {27'd0, fflagsReg};
    end
    if(when_CsrFile_l103) begin
      readData = {29'd0, frmReg};
    end
    if(when_CsrFile_l104) begin
      readData = {24'd0, _zz_readData};
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

module FpUnit (
  input  wire [5:0]    io_op,
  input  wire [2:0]    io_rm,
  input  wire [63:0]   io_a,
  input  wire [63:0]   io_b,
  input  wire [63:0]   io_c,
  output wire [63:0]   io_result,
  output wire [4:0]    io_flags
);

  wire       [9:0]    _zz__zz_when_FpUnit_l180;
  wire       [9:0]    _zz__zz_when_FpUnit_l180_1;
  wire       [9:0]    _zz__zz_when_FpUnit_l180_2;
  wire       [7:0]    _zz__zz_when_FpUnit_l180_3;
  wire       [23:0]   _zz__zz_flagNX;
  wire       [9:0]    _zz__zz_when_FpUnit_l180_1_1;
  wire       [9:0]    _zz__zz_when_FpUnit_l180_1_2;
  wire       [9:0]    _zz__zz_when_FpUnit_l180_1_3;
  wire       [7:0]    _zz__zz_when_FpUnit_l180_1_4;
  wire       [23:0]   _zz__zz_when_FpUnit_l84;
  wire       [9:0]    _zz__zz_when_FpUnit_l329_1;
  wire       [9:0]    _zz__zz_when_FpUnit_l329_1_1;
  wire       [9:0]    _zz__zz_when_FpUnit_l329_1_2;
  wire       [7:0]    _zz__zz_when_FpUnit_l329_1_3;
  wire       [23:0]   _zz__zz_when_FpUnit_l84_1;
  wire       [31:0]   _zz_res_90;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_4;
  wire       [27:0]   _zz__zz_when_FpUnit_l84_4_1;
  wire       [23:0]   _zz__zz_when_FpUnit_l84_4_2;
  wire       [9:0]    _zz__zz_when_FpUnit_l180_4;
  wire       [9:0]    _zz__zz_when_FpUnit_l180_4_1;
  wire       [27:0]   _zz__zz_when_FpUnit_l84_5;
  wire       [27:0]   _zz__zz_when_FpUnit_l84_5_1;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_5_2;
  wire       [27:0]   _zz__zz_when_FpUnit_l84_5_3;
  wire       [23:0]   _zz__zz_when_FpUnit_l84_5_4;
  wire       [27:0]   _zz__zz_when_FpUnit_l84_9;
  wire       [27:0]   _zz__zz_when_FpUnit_l84_9_1;
  wire       [27:0]   _zz__zz_when_FpUnit_l84_9_2;
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
  wire       [11:0]   _zz__zz_flagUF_4_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l116;
  wire       [26:0]   _zz__zz_flagUF_5_1;
  wire       [26:0]   _zz__zz_flagUF_6;
  wire       [26:0]   _zz__zz_flagUF_6_1;
  wire       [57:0]   _zz__zz_flagUF_6_2;
  wire       [4:0]    _zz__zz_flagUF_6_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_2;
  wire       [23:0]   _zz__zz_when_FpUnit_l150_2_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_2_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l150_2_3;
  wire                _zz__zz_when_FpUnit_l150_2_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l150_2_5;
  wire                _zz__zz_when_FpUnit_l150_2_6;
  wire                _zz__zz_when_FpUnit_l150_2_7;
  wire       [23:0]   _zz__zz_res_2;
  wire       [23:0]   _zz__zz_res_2_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_4;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_4_1;
  wire       [7:0]    _zz__zz_res_5;
  wire       [11:0]   _zz__zz_res_5_1;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_12;
  wire       [27:0]   _zz__zz_when_FpUnit_l84_12_1;
  wire       [23:0]   _zz__zz_when_FpUnit_l84_12_2;
  wire       [9:0]    _zz__zz_when_FpUnit_l180_7;
  wire       [9:0]    _zz__zz_when_FpUnit_l180_7_1;
  wire       [27:0]   _zz__zz_when_FpUnit_l84_13;
  wire       [27:0]   _zz__zz_when_FpUnit_l84_13_1;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_13_2;
  wire       [27:0]   _zz__zz_when_FpUnit_l84_13_3;
  wire       [23:0]   _zz__zz_when_FpUnit_l84_13_4;
  wire       [27:0]   _zz__zz_when_FpUnit_l84_17;
  wire       [27:0]   _zz__zz_when_FpUnit_l84_17_1;
  wire       [27:0]   _zz__zz_when_FpUnit_l84_17_2;
  wire       [11:0]   _zz__zz_flagUF_13;
  wire       [11:0]   _zz__zz_flagUF_13_1;
  wire       [11:0]   _zz__zz_flagUF_13_2;
  wire       [11:0]   _zz__zz_flagUF_13_3;
  wire       [26:0]   _zz__zz_flagUF_11;
  wire       [27:0]   _zz__zz_flagUF_11_1;
  wire       [27:0]   _zz__zz_flagUF_12;
  wire       [27:0]   _zz__zz_flagUF_12_1;
  wire       [58:0]   _zz__zz_flagUF_12_2;
  wire       [26:0]   _zz__zz_flagUF_11_2;
  wire       [58:0]   _zz__zz_flagUF_11_3;
  wire       [4:0]    _zz__zz_flagUF_11_4;
  wire       [11:0]   _zz__zz_flagUF_15;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_1;
  wire       [26:0]   _zz__zz_flagUF_16;
  wire       [26:0]   _zz__zz_flagUF_17;
  wire       [26:0]   _zz__zz_flagUF_17_1;
  wire       [57:0]   _zz__zz_flagUF_17_2;
  wire       [4:0]    _zz__zz_flagUF_17_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_7;
  wire       [23:0]   _zz__zz_when_FpUnit_l150_7_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_7_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l150_7_3;
  wire                _zz__zz_when_FpUnit_l150_7_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l150_7_5;
  wire                _zz__zz_when_FpUnit_l150_7_6;
  wire                _zz__zz_when_FpUnit_l150_7_7;
  wire       [23:0]   _zz__zz_res_8;
  wire       [23:0]   _zz__zz_res_8_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_9;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_9_1;
  wire       [7:0]    _zz__zz_res_11;
  wire       [11:0]   _zz__zz_res_11_1;
  wire       [11:0]   _zz__zz_flagUF_24;
  wire       [11:0]   _zz__zz_flagUF_24_1;
  wire       [11:0]   _zz__zz_flagUF_24_2;
  wire       [11:0]   _zz__zz_flagUF_24_3;
  wire       [9:0]    _zz__zz_flagUF_24_4;
  wire       [26:0]   _zz__zz_flagUF_22;
  wire       [47:0]   _zz__zz_flagUF_22_1;
  wire       [47:0]   _zz__zz_flagUF_23;
  wire       [47:0]   _zz__zz_flagUF_23_1;
  wire       [110:0]  _zz__zz_flagUF_23_2;
  wire       [26:0]   _zz__zz_flagUF_22_2;
  wire       [110:0]  _zz__zz_flagUF_22_3;
  wire       [5:0]    _zz__zz_flagUF_22_4;
  wire       [11:0]   _zz__zz_flagUF_26;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_2;
  wire       [26:0]   _zz__zz_flagUF_27;
  wire       [26:0]   _zz__zz_flagUF_28;
  wire       [26:0]   _zz__zz_flagUF_28_1;
  wire       [57:0]   _zz__zz_flagUF_28_2;
  wire       [4:0]    _zz__zz_flagUF_28_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_12;
  wire       [23:0]   _zz__zz_when_FpUnit_l150_12_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_12_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l150_12_3;
  wire                _zz__zz_when_FpUnit_l150_12_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l150_12_5;
  wire                _zz__zz_when_FpUnit_l150_12_6;
  wire                _zz__zz_when_FpUnit_l150_12_7;
  wire       [23:0]   _zz__zz_res_14;
  wire       [23:0]   _zz__zz_res_14_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_14;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_14_1;
  wire       [7:0]    _zz__zz_res_17;
  wire       [11:0]   _zz__zz_res_17_1;
  wire       [52:0]   _zz__zz_when_FpUnit_l84_19;
  wire       [79:0]   _zz__zz_when_FpUnit_l84_20;
  wire       [52:0]   _zz__zz_when_FpUnit_l84_20_1;
  wire       [11:0]   _zz__zz_flagUF_35;
  wire       [11:0]   _zz__zz_flagUF_35_1;
  wire       [11:0]   _zz__zz_flagUF_35_2;
  wire       [11:0]   _zz__zz_flagUF_35_3;
  wire       [9:0]    _zz__zz_flagUF_35_4;
  wire       [26:0]   _zz__zz_flagUF_33;
  wire       [28:0]   _zz__zz_flagUF_33_1;
  wire       [28:0]   _zz__zz_flagUF_34;
  wire       [28:0]   _zz__zz_flagUF_34_1;
  wire       [59:0]   _zz__zz_flagUF_34_2;
  wire       [26:0]   _zz__zz_flagUF_33_2;
  wire       [59:0]   _zz__zz_flagUF_33_3;
  wire       [4:0]    _zz__zz_flagUF_33_4;
  wire       [105:0]  _zz__zz_flagUF_37;
  wire       [105:0]  _zz__zz_flagUF_37_1;
  wire       [105:0]  _zz__zz_flagUF_37_2;
  wire       [52:0]   _zz__zz_flagUF_37_3;
  wire       [52:0]   _zz__zz_flagUF_37_4;
  wire       [11:0]   _zz__zz_flagUF_38;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_3;
  wire       [26:0]   _zz__zz_flagUF_39;
  wire       [26:0]   _zz__zz_flagUF_40;
  wire       [26:0]   _zz__zz_flagUF_40_1;
  wire       [57:0]   _zz__zz_flagUF_40_2;
  wire       [4:0]    _zz__zz_flagUF_40_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_17;
  wire       [23:0]   _zz__zz_when_FpUnit_l150_17_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_17_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l150_17_3;
  wire                _zz__zz_when_FpUnit_l150_17_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l150_17_5;
  wire                _zz__zz_when_FpUnit_l150_17_6;
  wire                _zz__zz_when_FpUnit_l150_17_7;
  wire       [23:0]   _zz__zz_res_20;
  wire       [23:0]   _zz__zz_res_20_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_19;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_19_1;
  wire       [7:0]    _zz__zz_res_23;
  wire       [11:0]   _zz__zz_res_23_1;
  wire       [84:0]   _zz__zz_when_FpUnit_l84_21;
  wire       [55:0]   _zz__zz_when_FpUnit_l84_21_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l84_21_2;
  wire       [24:0]   _zz__zz_when_FpUnit_l84_21_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l84_21_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_23;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_23_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_23_2;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_23_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_24;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_24_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_26;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_26_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_26_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_26_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_27;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_27_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_27_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_27_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_27_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_28;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_28_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_30;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_30_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_30_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_30_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_31;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_31_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_31_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_31_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_31_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_32;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_32_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_34;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_34_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_34_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_34_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_35;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_35_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_35_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_35_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_35_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_36;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_36_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_38;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_38_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_38_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_38_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_39;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_39_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_39_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_39_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_39_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_40;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_40_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_42;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_42_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_42_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_42_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_43;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_43_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_43_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_43_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_43_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_44;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_44_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_46;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_46_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_46_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_46_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_47;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_47_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_47_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_47_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_47_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_48;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_48_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_50;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_50_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_50_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_50_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_51;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_51_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_51_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_51_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_51_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_52;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_52_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_54;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_54_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_54_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_54_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_55;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_55_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_55_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_55_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_55_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_56;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_56_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_58;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_58_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_58_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_58_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_59;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_59_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_59_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_59_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_59_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_60;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_60_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_62;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_62_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_62_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_62_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_63;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_63_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_63_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_63_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_63_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_64;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_64_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_66;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_66_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_66_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_66_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_67;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_67_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_67_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_67_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_67_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_68;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_68_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_70;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_70_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_70_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_70_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_71;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_71_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_71_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_71_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_71_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_72;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_72_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_74;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_74_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_74_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_74_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_75;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_75_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_75_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_75_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_75_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_76;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_76_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_78;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_78_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_78_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_78_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_79;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_79_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_79_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_79_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_79_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_80;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_80_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_82;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_82_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_82_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_82_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_83;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_83_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_83_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_83_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_83_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_84;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_84_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_86;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_86_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_86_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_86_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_87;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_87_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_87_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_87_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_87_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_88;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_88_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_90;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_90_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_90_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_90_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_91;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_91_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_91_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_91_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_91_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_92;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_92_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_94;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_94_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_94_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_94_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_95;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_95_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_95_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_95_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_95_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_96;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_96_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_98;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_98_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_98_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_98_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_99;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_99_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_99_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_99_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_99_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_100;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_100_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_102;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_102_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_102_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_102_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_103;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_103_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_103_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_103_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_103_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_104;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_104_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_106;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_106_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_106_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_106_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_107;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_107_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_107_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_107_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_107_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_108;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_108_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_110;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_110_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_110_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_110_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_111;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_111_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_111_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_111_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_111_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_112;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_112_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_114;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_114_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_114_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_114_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_115;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_115_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_115_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_115_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_115_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_116;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_116_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_118;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_118_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_118_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_118_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_119;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_119_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_119_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_119_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_119_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_120;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_120_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_122;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_122_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_122_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_122_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_123;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_123_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_123_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_123_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_123_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_124;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_124_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_126;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_126_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_126_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_126_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_127;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_127_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_127_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_127_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_127_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_128;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_128_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_130;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_130_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_130_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_130_3;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_131;
  wire       [59:0]   _zz__zz_when_FpUnit_l84_131_1;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_131_2;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_131_3;
  wire       [1:0]    _zz__zz_when_FpUnit_l84_131_4;
  wire       [57:0]   _zz__zz_when_FpUnit_l84_132;
  wire       [31:0]   _zz__zz_when_FpUnit_l84_132_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_134;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_134_1;
  wire       [29:0]   _zz__zz_when_FpUnit_l84_134_2;
  wire       [30:0]   _zz__zz_when_FpUnit_l84_134_3;
  wire       [11:0]   _zz__zz_flagUF_48;
  wire       [11:0]   _zz__zz_flagUF_48_1;
  wire       [11:0]   _zz__zz_flagUF_48_2;
  wire       [11:0]   _zz__zz_flagUF_48_3;
  wire       [10:0]   _zz__zz_flagUF_48_4;
  wire       [11:0]   _zz__zz_flagUF_48_5;
  wire       [11:0]   _zz__zz_flagUF_48_6;
  wire       [11:0]   _zz__zz_flagUF_48_7;
  wire       [11:0]   _zz__zz_flagUF_48_8;
  wire       [26:0]   _zz__zz_flagUF_46;
  wire       [29:0]   _zz__zz_flagUF_46_1;
  wire       [29:0]   _zz__zz_flagUF_47;
  wire       [29:0]   _zz__zz_flagUF_47_1;
  wire       [60:0]   _zz__zz_flagUF_47_2;
  wire       [26:0]   _zz__zz_flagUF_46_2;
  wire       [60:0]   _zz__zz_flagUF_46_3;
  wire       [4:0]    _zz__zz_flagUF_46_4;
  wire       [57:0]   _zz__zz_flagUF_50;
  wire       [11:0]   _zz__zz_flagUF_51;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_4;
  wire       [26:0]   _zz__zz_flagUF_52;
  wire       [26:0]   _zz__zz_flagUF_53;
  wire       [26:0]   _zz__zz_flagUF_53_1;
  wire       [57:0]   _zz__zz_flagUF_53_2;
  wire       [4:0]    _zz__zz_flagUF_53_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_22;
  wire       [23:0]   _zz__zz_when_FpUnit_l150_22_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_22_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l150_22_3;
  wire                _zz__zz_when_FpUnit_l150_22_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l150_22_5;
  wire                _zz__zz_when_FpUnit_l150_22_6;
  wire                _zz__zz_when_FpUnit_l150_22_7;
  wire       [23:0]   _zz__zz_res_26;
  wire       [23:0]   _zz__zz_res_26_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_24;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_24_1;
  wire       [7:0]    _zz__zz_res_29;
  wire       [11:0]   _zz__zz_res_29_1;
  wire       [31:0]   _zz_res_91;
  wire       [11:0]   _zz__zz_when_FpUnit_l329_2;
  wire       [9:0]    _zz__zz_when_FpUnit_l329_2_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l329_3;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_136;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_136_1;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_136_2;
  wire       [53:0]   _zz__zz_flagUF_58;
  wire       [53:0]   _zz__zz_flagUF_58_1;
  wire       [53:0]   _zz__zz_flagUF_58_2;
  wire       [116:0]  _zz__zz_flagUF_58_3;
  wire       [5:0]    _zz__zz_flagUF_58_4;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_137;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_137_1;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_137_2;
  wire       [53:0]   _zz__zz_flagUF_59;
  wire       [53:0]   _zz__zz_flagUF_59_1;
  wire       [53:0]   _zz__zz_flagUF_59_2;
  wire       [116:0]  _zz__zz_flagUF_59_3;
  wire       [5:0]    _zz__zz_flagUF_59_4;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_138;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_138_1;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_139;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_139_1;
  wire       [55:0]   _zz__zz_when_FpUnit_l84_140;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_140_1;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_140_2;
  wire       [55:0]   _zz__zz_when_FpUnit_l84_140_3;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_140_4;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_140_5;
  wire       [55:0]   _zz__zz_when_FpUnit_l84_142;
  wire       [11:0]   _zz__zz_flagUF_62;
  wire       [11:0]   _zz__zz_flagUF_62_1;
  wire       [26:0]   _zz__zz_flagUF_60;
  wire       [55:0]   _zz__zz_flagUF_60_1;
  wire       [55:0]   _zz__zz_flagUF_61;
  wire       [55:0]   _zz__zz_flagUF_61_1;
  wire       [118:0]  _zz__zz_flagUF_61_2;
  wire       [26:0]   _zz__zz_flagUF_60_2;
  wire       [118:0]  _zz__zz_flagUF_60_3;
  wire       [5:0]    _zz__zz_flagUF_60_4;
  wire       [11:0]   _zz__zz_flagUF_65;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_5;
  wire       [26:0]   _zz__zz_flagUF_66;
  wire       [26:0]   _zz__zz_flagUF_67;
  wire       [26:0]   _zz__zz_flagUF_67_1;
  wire       [57:0]   _zz__zz_flagUF_67_2;
  wire       [4:0]    _zz__zz_flagUF_67_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_27;
  wire       [23:0]   _zz__zz_when_FpUnit_l150_27_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_27_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l150_27_3;
  wire                _zz__zz_when_FpUnit_l150_27_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l150_27_5;
  wire                _zz__zz_when_FpUnit_l150_27_6;
  wire                _zz__zz_when_FpUnit_l150_27_7;
  wire       [23:0]   _zz__zz_res_42;
  wire       [23:0]   _zz__zz_res_42_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_29;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_29_1;
  wire       [7:0]    _zz__zz_res_45;
  wire       [11:0]   _zz__zz_res_45_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l329_7;
  wire       [9:0]    _zz__zz_when_FpUnit_l329_7_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l329_8;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_144;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_144_1;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_144_2;
  wire       [53:0]   _zz__zz_flagUF_72;
  wire       [53:0]   _zz__zz_flagUF_72_1;
  wire       [53:0]   _zz__zz_flagUF_72_2;
  wire       [116:0]  _zz__zz_flagUF_72_3;
  wire       [5:0]    _zz__zz_flagUF_72_4;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_145;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_145_1;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_145_2;
  wire       [53:0]   _zz__zz_flagUF_73;
  wire       [53:0]   _zz__zz_flagUF_73_1;
  wire       [53:0]   _zz__zz_flagUF_73_2;
  wire       [116:0]  _zz__zz_flagUF_73_3;
  wire       [5:0]    _zz__zz_flagUF_73_4;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_146;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_146_1;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_147;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_147_1;
  wire       [55:0]   _zz__zz_when_FpUnit_l84_148;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_148_1;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_148_2;
  wire       [55:0]   _zz__zz_when_FpUnit_l84_148_3;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_148_4;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_148_5;
  wire       [55:0]   _zz__zz_when_FpUnit_l84_150;
  wire       [11:0]   _zz__zz_flagUF_76;
  wire       [11:0]   _zz__zz_flagUF_76_1;
  wire       [26:0]   _zz__zz_flagUF_74;
  wire       [55:0]   _zz__zz_flagUF_74_1;
  wire       [55:0]   _zz__zz_flagUF_75;
  wire       [55:0]   _zz__zz_flagUF_75_1;
  wire       [118:0]  _zz__zz_flagUF_75_2;
  wire       [26:0]   _zz__zz_flagUF_74_2;
  wire       [118:0]  _zz__zz_flagUF_74_3;
  wire       [5:0]    _zz__zz_flagUF_74_4;
  wire       [11:0]   _zz__zz_flagUF_79;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_6;
  wire       [26:0]   _zz__zz_flagUF_80;
  wire       [26:0]   _zz__zz_flagUF_81;
  wire       [26:0]   _zz__zz_flagUF_81_1;
  wire       [57:0]   _zz__zz_flagUF_81_2;
  wire       [4:0]    _zz__zz_flagUF_81_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_32;
  wire       [23:0]   _zz__zz_when_FpUnit_l150_32_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_32_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l150_32_3;
  wire                _zz__zz_when_FpUnit_l150_32_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l150_32_5;
  wire                _zz__zz_when_FpUnit_l150_32_6;
  wire                _zz__zz_when_FpUnit_l150_32_7;
  wire       [23:0]   _zz__zz_res_47;
  wire       [23:0]   _zz__zz_res_47_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_34;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_34_1;
  wire       [7:0]    _zz__zz_res_50;
  wire       [11:0]   _zz__zz_res_50_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l329_12;
  wire       [9:0]    _zz__zz_when_FpUnit_l329_12_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l329_13;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_152;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_152_1;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_152_2;
  wire       [53:0]   _zz__zz_flagUF_86;
  wire       [53:0]   _zz__zz_flagUF_86_1;
  wire       [53:0]   _zz__zz_flagUF_86_2;
  wire       [116:0]  _zz__zz_flagUF_86_3;
  wire       [5:0]    _zz__zz_flagUF_86_4;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_153;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_153_1;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_153_2;
  wire       [53:0]   _zz__zz_flagUF_87;
  wire       [53:0]   _zz__zz_flagUF_87_1;
  wire       [53:0]   _zz__zz_flagUF_87_2;
  wire       [116:0]  _zz__zz_flagUF_87_3;
  wire       [5:0]    _zz__zz_flagUF_87_4;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_154;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_154_1;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_155;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_155_1;
  wire       [55:0]   _zz__zz_when_FpUnit_l84_156;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_156_1;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_156_2;
  wire       [55:0]   _zz__zz_when_FpUnit_l84_156_3;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_156_4;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_156_5;
  wire       [55:0]   _zz__zz_when_FpUnit_l84_158;
  wire       [11:0]   _zz__zz_flagUF_90;
  wire       [11:0]   _zz__zz_flagUF_90_1;
  wire       [26:0]   _zz__zz_flagUF_88;
  wire       [55:0]   _zz__zz_flagUF_88_1;
  wire       [55:0]   _zz__zz_flagUF_89;
  wire       [55:0]   _zz__zz_flagUF_89_1;
  wire       [118:0]  _zz__zz_flagUF_89_2;
  wire       [26:0]   _zz__zz_flagUF_88_2;
  wire       [118:0]  _zz__zz_flagUF_88_3;
  wire       [5:0]    _zz__zz_flagUF_88_4;
  wire       [11:0]   _zz__zz_flagUF_93;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_7;
  wire       [26:0]   _zz__zz_flagUF_94;
  wire       [26:0]   _zz__zz_flagUF_95;
  wire       [26:0]   _zz__zz_flagUF_95_1;
  wire       [57:0]   _zz__zz_flagUF_95_2;
  wire       [4:0]    _zz__zz_flagUF_95_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_37;
  wire       [23:0]   _zz__zz_when_FpUnit_l150_37_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_37_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l150_37_3;
  wire                _zz__zz_when_FpUnit_l150_37_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l150_37_5;
  wire                _zz__zz_when_FpUnit_l150_37_6;
  wire                _zz__zz_when_FpUnit_l150_37_7;
  wire       [23:0]   _zz__zz_res_52;
  wire       [23:0]   _zz__zz_res_52_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_39;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_39_1;
  wire       [7:0]    _zz__zz_res_55;
  wire       [11:0]   _zz__zz_res_55_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l329_17;
  wire       [9:0]    _zz__zz_when_FpUnit_l329_17_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l329_18;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_160;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_160_1;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_160_2;
  wire       [53:0]   _zz__zz_flagUF_100;
  wire       [53:0]   _zz__zz_flagUF_100_1;
  wire       [53:0]   _zz__zz_flagUF_100_2;
  wire       [116:0]  _zz__zz_flagUF_100_3;
  wire       [5:0]    _zz__zz_flagUF_100_4;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_161;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_161_1;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_161_2;
  wire       [53:0]   _zz__zz_flagUF_101;
  wire       [53:0]   _zz__zz_flagUF_101_1;
  wire       [53:0]   _zz__zz_flagUF_101_2;
  wire       [116:0]  _zz__zz_flagUF_101_3;
  wire       [5:0]    _zz__zz_flagUF_101_4;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_162;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_162_1;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_163;
  wire       [53:0]   _zz__zz_when_FpUnit_l84_163_1;
  wire       [55:0]   _zz__zz_when_FpUnit_l84_164;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_164_1;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_164_2;
  wire       [55:0]   _zz__zz_when_FpUnit_l84_164_3;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_164_4;
  wire       [54:0]   _zz__zz_when_FpUnit_l84_164_5;
  wire       [55:0]   _zz__zz_when_FpUnit_l84_166;
  wire       [11:0]   _zz__zz_flagUF_104;
  wire       [11:0]   _zz__zz_flagUF_104_1;
  wire       [26:0]   _zz__zz_flagUF_102;
  wire       [55:0]   _zz__zz_flagUF_102_1;
  wire       [55:0]   _zz__zz_flagUF_103;
  wire       [55:0]   _zz__zz_flagUF_103_1;
  wire       [118:0]  _zz__zz_flagUF_103_2;
  wire       [26:0]   _zz__zz_flagUF_102_2;
  wire       [118:0]  _zz__zz_flagUF_102_3;
  wire       [5:0]    _zz__zz_flagUF_102_4;
  wire       [11:0]   _zz__zz_flagUF_107;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_8;
  wire       [26:0]   _zz__zz_flagUF_108;
  wire       [26:0]   _zz__zz_flagUF_109;
  wire       [26:0]   _zz__zz_flagUF_109_1;
  wire       [57:0]   _zz__zz_flagUF_109_2;
  wire       [4:0]    _zz__zz_flagUF_109_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_42;
  wire       [23:0]   _zz__zz_when_FpUnit_l150_42_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_42_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l150_42_3;
  wire                _zz__zz_when_FpUnit_l150_42_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l150_42_5;
  wire                _zz__zz_when_FpUnit_l150_42_6;
  wire                _zz__zz_when_FpUnit_l150_42_7;
  wire       [23:0]   _zz__zz_res_57;
  wire       [23:0]   _zz__zz_res_57_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_44;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_44_1;
  wire       [7:0]    _zz__zz_res_60;
  wire       [11:0]   _zz__zz_res_60_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l447;
  wire       [11:0]   _zz__zz_flagNX_2;
  wire       [23:0]   _zz__zz_when_FpUnit_l474;
  wire       [23:0]   _zz__zz_flagNX_1;
  wire       [23:0]   _zz__zz_flagNX_1_1;
  wire       [54:0]   _zz__zz_flagNX_1_2;
  wire       [4:0]    _zz__zz_flagNX_1_3;
  wire       [96:0]   _zz__zz_when_FpUnit_l474_1;
  wire       [33:0]   _zz__zz_when_FpUnit_l474_2;
  wire       [5:0]    _zz__zz_when_FpUnit_l474_3;
  wire       [11:0]   _zz__zz_when_FpUnit_l474_4;
  wire       [33:0]   _zz__zz_when_FpUnit_l474_1_1;
  wire       [0:0]    _zz__zz_when_FpUnit_l474_1_2;
  wire       [31:0]   _zz__zz_res_62;
  wire       [63:0]   _zz_res_92;
  wire       [31:0]   _zz_res_93;
  wire       [11:0]   _zz__zz_when_FpUnit_l447_1;
  wire       [11:0]   _zz__zz_flagNX_4;
  wire       [23:0]   _zz__zz_when_FpUnit_l474_2_1;
  wire       [23:0]   _zz__zz_flagNX_3;
  wire       [23:0]   _zz__zz_flagNX_3_1;
  wire       [54:0]   _zz__zz_flagNX_3_2;
  wire       [4:0]    _zz__zz_flagNX_3_3;
  wire       [96:0]   _zz__zz_when_FpUnit_l474_2_2;
  wire       [33:0]   _zz__zz_when_FpUnit_l474_2_3;
  wire       [5:0]    _zz__zz_when_FpUnit_l474_2_4;
  wire       [11:0]   _zz__zz_when_FpUnit_l474_2_5;
  wire       [33:0]   _zz__zz_when_FpUnit_l474_3_1;
  wire       [0:0]    _zz__zz_when_FpUnit_l474_3_2;
  wire       [31:0]   _zz__zz_res_63;
  wire       [63:0]   _zz_res_94;
  wire       [11:0]   _zz__zz_when_FpUnit_l447_2;
  wire       [11:0]   _zz__zz_flagNX_6;
  wire       [23:0]   _zz__zz_when_FpUnit_l474_4_1;
  wire       [23:0]   _zz__zz_flagNX_5;
  wire       [23:0]   _zz__zz_flagNX_5_1;
  wire       [54:0]   _zz__zz_flagNX_5_2;
  wire       [4:0]    _zz__zz_flagNX_5_3;
  wire       [192:0]  _zz__zz_when_FpUnit_l474_4_2;
  wire       [65:0]   _zz__zz_when_FpUnit_l474_4_3;
  wire       [6:0]    _zz__zz_when_FpUnit_l474_4_4;
  wire       [11:0]   _zz__zz_when_FpUnit_l474_4_5;
  wire       [65:0]   _zz__zz_when_FpUnit_l474_5;
  wire       [0:0]    _zz__zz_when_FpUnit_l474_5_1;
  wire       [63:0]   _zz__zz_res_64;
  wire       [63:0]   _zz_res_95;
  wire       [11:0]   _zz__zz_when_FpUnit_l447_3;
  wire       [11:0]   _zz__zz_flagNX_8;
  wire       [23:0]   _zz__zz_when_FpUnit_l474_6;
  wire       [23:0]   _zz__zz_flagNX_7;
  wire       [23:0]   _zz__zz_flagNX_7_1;
  wire       [54:0]   _zz__zz_flagNX_7_2;
  wire       [4:0]    _zz__zz_flagNX_7_3;
  wire       [192:0]  _zz__zz_when_FpUnit_l474_6_1;
  wire       [65:0]   _zz__zz_when_FpUnit_l474_6_2;
  wire       [6:0]    _zz__zz_when_FpUnit_l474_6_3;
  wire       [11:0]   _zz__zz_when_FpUnit_l474_6_4;
  wire       [65:0]   _zz__zz_when_FpUnit_l474_7;
  wire       [0:0]    _zz__zz_when_FpUnit_l474_7_1;
  wire       [63:0]   _zz__zz_res_65;
  wire       [55:0]   _zz__zz_when_FpUnit_l84_168;
  wire       [55:0]   _zz__zz_when_FpUnit_l84_168_1;
  wire       [55:0]   _zz__zz_when_FpUnit_l84_168_2;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_9;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_9_1;
  wire       [26:0]   _zz__zz_flagNX_9;
  wire       [55:0]   _zz__zz_flagNX_9_1;
  wire       [55:0]   _zz__zz_flagNX_10;
  wire       [55:0]   _zz__zz_flagNX_10_1;
  wire       [118:0]  _zz__zz_flagNX_10_2;
  wire       [26:0]   _zz__zz_flagNX_9_2;
  wire       [118:0]  _zz__zz_flagNX_9_3;
  wire       [5:0]    _zz__zz_flagNX_9_4;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_10;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_11;
  wire       [26:0]   _zz__zz_flagNX_12;
  wire       [26:0]   _zz__zz_flagNX_13;
  wire       [26:0]   _zz__zz_flagNX_13_1;
  wire       [57:0]   _zz__zz_flagNX_13_2;
  wire       [4:0]    _zz__zz_flagNX_13_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_47;
  wire       [23:0]   _zz__zz_when_FpUnit_l150_47_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_47_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l150_47_3;
  wire                _zz__zz_when_FpUnit_l150_47_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l150_47_5;
  wire                _zz__zz_when_FpUnit_l150_47_6;
  wire                _zz__zz_when_FpUnit_l150_47_7;
  wire       [23:0]   _zz__zz_res_67;
  wire       [23:0]   _zz__zz_res_67_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_49;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_49_1;
  wire       [7:0]    _zz__zz_res_70;
  wire       [11:0]   _zz__zz_res_70_1;
  wire       [55:0]   _zz__zz_when_FpUnit_l84_170;
  wire       [55:0]   _zz__zz_when_FpUnit_l84_170_1;
  wire       [55:0]   _zz__zz_when_FpUnit_l84_170_2;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_12;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_12_1;
  wire       [26:0]   _zz__zz_flagNX_17;
  wire       [55:0]   _zz__zz_flagNX_17_1;
  wire       [55:0]   _zz__zz_flagNX_18;
  wire       [55:0]   _zz__zz_flagNX_18_1;
  wire       [118:0]  _zz__zz_flagNX_18_2;
  wire       [26:0]   _zz__zz_flagNX_17_2;
  wire       [118:0]  _zz__zz_flagNX_17_3;
  wire       [5:0]    _zz__zz_flagNX_17_4;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_13;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_14;
  wire       [26:0]   _zz__zz_flagNX_20;
  wire       [26:0]   _zz__zz_flagNX_21;
  wire       [26:0]   _zz__zz_flagNX_21_1;
  wire       [57:0]   _zz__zz_flagNX_21_2;
  wire       [4:0]    _zz__zz_flagNX_21_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_52;
  wire       [23:0]   _zz__zz_when_FpUnit_l150_52_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_52_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l150_52_3;
  wire                _zz__zz_when_FpUnit_l150_52_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l150_52_5;
  wire                _zz__zz_when_FpUnit_l150_52_6;
  wire                _zz__zz_when_FpUnit_l150_52_7;
  wire       [23:0]   _zz__zz_res_73;
  wire       [23:0]   _zz__zz_res_73_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_54;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_54_1;
  wire       [7:0]    _zz__zz_res_76;
  wire       [11:0]   _zz__zz_res_76_1;
  wire       [87:0]   _zz__zz_when_FpUnit_l84_172;
  wire       [87:0]   _zz__zz_when_FpUnit_l84_172_1;
  wire       [87:0]   _zz__zz_when_FpUnit_l84_172_2;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_15;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_15_1;
  wire       [26:0]   _zz__zz_flagNX_25;
  wire       [87:0]   _zz__zz_flagNX_25_1;
  wire       [87:0]   _zz__zz_flagNX_26;
  wire       [87:0]   _zz__zz_flagNX_26_1;
  wire       [214:0]  _zz__zz_flagNX_26_2;
  wire       [26:0]   _zz__zz_flagNX_25_2;
  wire       [214:0]  _zz__zz_flagNX_25_3;
  wire       [6:0]    _zz__zz_flagNX_25_4;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_16;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_17;
  wire       [26:0]   _zz__zz_flagNX_28;
  wire       [26:0]   _zz__zz_flagNX_29;
  wire       [26:0]   _zz__zz_flagNX_29_1;
  wire       [57:0]   _zz__zz_flagNX_29_2;
  wire       [4:0]    _zz__zz_flagNX_29_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_57;
  wire       [23:0]   _zz__zz_when_FpUnit_l150_57_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_57_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l150_57_3;
  wire                _zz__zz_when_FpUnit_l150_57_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l150_57_5;
  wire                _zz__zz_when_FpUnit_l150_57_6;
  wire                _zz__zz_when_FpUnit_l150_57_7;
  wire       [23:0]   _zz__zz_res_79;
  wire       [23:0]   _zz__zz_res_79_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_59;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_59_1;
  wire       [7:0]    _zz__zz_res_82;
  wire       [11:0]   _zz__zz_res_82_1;
  wire       [87:0]   _zz__zz_when_FpUnit_l84_174;
  wire       [87:0]   _zz__zz_when_FpUnit_l84_174_1;
  wire       [87:0]   _zz__zz_when_FpUnit_l84_174_2;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_18;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_18_1;
  wire       [26:0]   _zz__zz_flagNX_33;
  wire       [87:0]   _zz__zz_flagNX_33_1;
  wire       [87:0]   _zz__zz_flagNX_34;
  wire       [87:0]   _zz__zz_flagNX_34_1;
  wire       [214:0]  _zz__zz_flagNX_34_2;
  wire       [26:0]   _zz__zz_flagNX_33_2;
  wire       [214:0]  _zz__zz_flagNX_33_3;
  wire       [6:0]    _zz__zz_flagNX_33_4;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_19;
  wire       [11:0]   _zz__zz_when_FpUnit_l116_20;
  wire       [26:0]   _zz__zz_flagNX_36;
  wire       [26:0]   _zz__zz_flagNX_37;
  wire       [26:0]   _zz__zz_flagNX_37_1;
  wire       [57:0]   _zz__zz_flagNX_37_2;
  wire       [4:0]    _zz__zz_flagNX_37_3;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_62;
  wire       [23:0]   _zz__zz_when_FpUnit_l150_62_1;
  wire       [24:0]   _zz__zz_when_FpUnit_l150_62_2;
  wire       [0:0]    _zz__zz_when_FpUnit_l150_62_3;
  wire                _zz__zz_when_FpUnit_l150_62_4;
  wire       [2:0]    _zz__zz_when_FpUnit_l150_62_5;
  wire                _zz__zz_when_FpUnit_l150_62_6;
  wire                _zz__zz_when_FpUnit_l150_62_7;
  wire       [23:0]   _zz__zz_res_85;
  wire       [23:0]   _zz__zz_res_85_1;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_64;
  wire       [11:0]   _zz__zz_when_FpUnit_l150_64_1;
  wire       [7:0]    _zz__zz_res_88;
  wire       [11:0]   _zz__zz_res_88_1;
  wire                when_FpUnit_l481;
  wire       [7:0]    _zz_when_FpUnit_l270;
  wire       [22:0]   _zz_when_FpUnit_l270_1;
  wire                _zz_when_FpUnit_l270_2;
  wire                _zz_when_FpUnit_l206;
  wire                _zz_when_FpUnit_l270_3;
  wire                when_FpUnit_l270;
  wire                when_FpUnit_l206;
  wire                when_FpUnit_l304;
  wire                _zz_flagNV;
  wire                _zz_res;
  wire       [9:0]    _zz_when_FpUnit_l180;
  wire       [23:0]   _zz_flagNX;
  wire                _zz_when_FpUnit_l205;
  wire       [7:0]    _zz_when_FpUnit_l267;
  wire       [22:0]   _zz_when_FpUnit_l267_1;
  wire                _zz_when_FpUnit_l267_2;
  wire                _zz_when_FpUnit_l207;
  wire                _zz_when_FpUnit_l267_3;
  wire                when_FpUnit_l267;
  wire                when_FpUnit_l207;
  wire                when_FpUnit_l393;
  wire                _zz_flagNV_1;
  wire       [9:0]    _zz_when_FpUnit_l180_1;
  wire       [23:0]   _zz_when_FpUnit_l84;
  wire                _zz_when_FpUnit_l359;
  wire       [7:0]    _zz_when_FpUnit_l361;
  wire       [22:0]   _zz_when_FpUnit_l361_1;
  wire                _zz_when_FpUnit_l329;
  wire                _zz_when_FpUnit_l361_2;
  wire                _zz_when_FpUnit_l361_3;
  wire                when_FpUnit_l361;
  wire                _zz_when_FpUnit_l357;
  wire                _zz_flagNV_2;
  wire       [9:0]    _zz_when_FpUnit_l329_1;
  wire       [23:0]   _zz_when_FpUnit_l84_1;
  reg        [63:0]   res;
  reg                 flagNV;
  reg                 flagDZ;
  reg                 flagOF;
  reg                 flagUF;
  reg                 flagNX;
  wire                _zz_when_FpUnit_l205_1;
  wire                _zz_when_FpUnit_l180_2;
  wire                _zz_when_FpUnit_l84_2;
  wire                _zz_when_FpUnit_l84_3;
  wire       [9:0]    _zz_when_FpUnit_l180_3;
  wire       [27:0]   _zz_when_FpUnit_l84_4;
  wire       [9:0]    _zz_when_FpUnit_l180_4;
  reg        [27:0]   _zz_when_FpUnit_l84_5;
  wire                when_FpUnit_l180;
  wire                _zz_when_FpUnit_l84_6;
  wire       [27:0]   _zz_when_FpUnit_l84_7;
  wire                _zz_when_FpUnit_l84_8;
  wire       [27:0]   _zz_when_FpUnit_l84_9;
  wire                _zz_res_1;
  reg        [4:0]    _zz_when_FpUnit_l91;
  wire                when_FpUnit_l84;
  wire                when_FpUnit_l84_1;
  wire                when_FpUnit_l84_2;
  wire                when_FpUnit_l84_3;
  wire                when_FpUnit_l84_4;
  wire                when_FpUnit_l84_5;
  wire                when_FpUnit_l84_6;
  wire                when_FpUnit_l84_7;
  wire                when_FpUnit_l84_8;
  wire                when_FpUnit_l84_9;
  wire                when_FpUnit_l84_10;
  wire                when_FpUnit_l84_11;
  wire                when_FpUnit_l84_12;
  wire                when_FpUnit_l84_13;
  wire                when_FpUnit_l84_14;
  wire                when_FpUnit_l84_15;
  wire                when_FpUnit_l84_16;
  wire                when_FpUnit_l84_17;
  wire                when_FpUnit_l84_18;
  wire                when_FpUnit_l84_19;
  wire                when_FpUnit_l84_20;
  wire                when_FpUnit_l84_21;
  wire                when_FpUnit_l84_22;
  wire                when_FpUnit_l84_23;
  wire                when_FpUnit_l84_24;
  wire                when_FpUnit_l84_25;
  wire                when_FpUnit_l84_26;
  wire                when_FpUnit_l84_27;
  reg        [26:0]   _zz_flagUF;
  reg                 _zz_flagUF_1;
  wire       [11:0]   _zz_flagUF_2;
  wire                when_FpUnit_l90;
  wire                when_FpUnit_l91;
  wire       [4:0]    _zz_flagUF_3;
  wire                when_FpUnit_l208;
  wire                _zz_flagUF_4;
  wire       [11:0]   _zz_when_FpUnit_l116;
  wire       [11:0]   _zz_when_FpUnit_l119;
  reg        [26:0]   _zz_flagUF_5;
  reg                 _zz_flagUF_6;
  wire                when_FpUnit_l116;
  wire                when_FpUnit_l119;
  wire       [11:0]   _zz_when_FpUnit_l150;
  wire                _zz_flagUF_7;
  wire                _zz_flagUF_8;
  wire                _zz_flagUF_9;
  wire       [23:0]   _zz_when_FpUnit_l150_1;
  wire       [24:0]   _zz_when_FpUnit_l150_2;
  wire                _zz_when_FpUnit_l150_3;
  wire       [23:0]   _zz_res_2;
  wire       [11:0]   _zz_when_FpUnit_l150_4;
  wire                _zz_flagUF_10;
  wire                when_FpUnit_l150;
  wire       [31:0]   _zz_res_3;
  wire       [31:0]   _zz_res_4;
  reg        [31:0]   _zz_res_5;
  wire                when_FpUnit_l154;
  reg        [31:0]   _zz_res_6;
  wire                when_FpUnit_l204;
  wire                when_FpUnit_l205;
  wire                _zz_when_FpUnit_l205_2;
  wire                _zz_when_FpUnit_l180_5;
  wire                _zz_when_FpUnit_l84_10;
  wire                _zz_when_FpUnit_l84_11;
  wire       [9:0]    _zz_when_FpUnit_l180_6;
  wire       [27:0]   _zz_when_FpUnit_l84_12;
  wire       [9:0]    _zz_when_FpUnit_l180_7;
  reg        [27:0]   _zz_when_FpUnit_l84_13;
  wire                when_FpUnit_l180_1;
  wire                _zz_when_FpUnit_l84_14;
  wire       [27:0]   _zz_when_FpUnit_l84_15;
  wire                _zz_when_FpUnit_l84_16;
  wire       [27:0]   _zz_when_FpUnit_l84_17;
  wire                _zz_res_7;
  reg        [4:0]    _zz_when_FpUnit_l91_1;
  wire                when_FpUnit_l84_28;
  wire                when_FpUnit_l84_29;
  wire                when_FpUnit_l84_30;
  wire                when_FpUnit_l84_31;
  wire                when_FpUnit_l84_32;
  wire                when_FpUnit_l84_33;
  wire                when_FpUnit_l84_34;
  wire                when_FpUnit_l84_35;
  wire                when_FpUnit_l84_36;
  wire                when_FpUnit_l84_37;
  wire                when_FpUnit_l84_38;
  wire                when_FpUnit_l84_39;
  wire                when_FpUnit_l84_40;
  wire                when_FpUnit_l84_41;
  wire                when_FpUnit_l84_42;
  wire                when_FpUnit_l84_43;
  wire                when_FpUnit_l84_44;
  wire                when_FpUnit_l84_45;
  wire                when_FpUnit_l84_46;
  wire                when_FpUnit_l84_47;
  wire                when_FpUnit_l84_48;
  wire                when_FpUnit_l84_49;
  wire                when_FpUnit_l84_50;
  wire                when_FpUnit_l84_51;
  wire                when_FpUnit_l84_52;
  wire                when_FpUnit_l84_53;
  wire                when_FpUnit_l84_54;
  wire                when_FpUnit_l84_55;
  reg        [26:0]   _zz_flagUF_11;
  reg                 _zz_flagUF_12;
  wire       [11:0]   _zz_flagUF_13;
  wire                when_FpUnit_l90_1;
  wire                when_FpUnit_l91_1;
  wire       [4:0]    _zz_flagUF_14;
  wire                when_FpUnit_l208_1;
  wire                _zz_flagUF_15;
  wire       [11:0]   _zz_when_FpUnit_l116_1;
  wire       [11:0]   _zz_when_FpUnit_l119_1;
  reg        [26:0]   _zz_flagUF_16;
  reg                 _zz_flagUF_17;
  wire                when_FpUnit_l116_1;
  wire                when_FpUnit_l119_1;
  wire       [11:0]   _zz_when_FpUnit_l150_5;
  wire                _zz_flagUF_18;
  wire                _zz_flagUF_19;
  wire                _zz_flagUF_20;
  wire       [23:0]   _zz_when_FpUnit_l150_6;
  wire       [24:0]   _zz_when_FpUnit_l150_7;
  wire                _zz_when_FpUnit_l150_8;
  wire       [23:0]   _zz_res_8;
  wire       [11:0]   _zz_when_FpUnit_l150_9;
  wire                _zz_flagUF_21;
  wire                when_FpUnit_l150_1;
  wire       [31:0]   _zz_res_9;
  wire       [31:0]   _zz_res_10;
  reg        [31:0]   _zz_res_11;
  wire                when_FpUnit_l154_1;
  reg        [31:0]   _zz_res_12;
  wire                when_FpUnit_l204_1;
  wire                when_FpUnit_l205_1;
  wire                _zz_res_13;
  wire       [47:0]   _zz_when_FpUnit_l84_18;
  reg        [5:0]    _zz_when_FpUnit_l91_2;
  wire                when_FpUnit_l84_56;
  wire                when_FpUnit_l84_57;
  wire                when_FpUnit_l84_58;
  wire                when_FpUnit_l84_59;
  wire                when_FpUnit_l84_60;
  wire                when_FpUnit_l84_61;
  wire                when_FpUnit_l84_62;
  wire                when_FpUnit_l84_63;
  wire                when_FpUnit_l84_64;
  wire                when_FpUnit_l84_65;
  wire                when_FpUnit_l84_66;
  wire                when_FpUnit_l84_67;
  wire                when_FpUnit_l84_68;
  wire                when_FpUnit_l84_69;
  wire                when_FpUnit_l84_70;
  wire                when_FpUnit_l84_71;
  wire                when_FpUnit_l84_72;
  wire                when_FpUnit_l84_73;
  wire                when_FpUnit_l84_74;
  wire                when_FpUnit_l84_75;
  wire                when_FpUnit_l84_76;
  wire                when_FpUnit_l84_77;
  wire                when_FpUnit_l84_78;
  wire                when_FpUnit_l84_79;
  wire                when_FpUnit_l84_80;
  wire                when_FpUnit_l84_81;
  wire                when_FpUnit_l84_82;
  wire                when_FpUnit_l84_83;
  wire                when_FpUnit_l84_84;
  wire                when_FpUnit_l84_85;
  wire                when_FpUnit_l84_86;
  wire                when_FpUnit_l84_87;
  wire                when_FpUnit_l84_88;
  wire                when_FpUnit_l84_89;
  wire                when_FpUnit_l84_90;
  wire                when_FpUnit_l84_91;
  wire                when_FpUnit_l84_92;
  wire                when_FpUnit_l84_93;
  wire                when_FpUnit_l84_94;
  wire                when_FpUnit_l84_95;
  wire                when_FpUnit_l84_96;
  wire                when_FpUnit_l84_97;
  wire                when_FpUnit_l84_98;
  wire                when_FpUnit_l84_99;
  wire                when_FpUnit_l84_100;
  wire                when_FpUnit_l84_101;
  wire                when_FpUnit_l84_102;
  wire                when_FpUnit_l84_103;
  reg        [26:0]   _zz_flagUF_22;
  reg                 _zz_flagUF_23;
  wire       [11:0]   _zz_flagUF_24;
  wire                when_FpUnit_l90_2;
  wire                when_FpUnit_l91_2;
  wire       [5:0]    _zz_flagUF_25;
  wire                _zz_flagUF_26;
  wire       [11:0]   _zz_when_FpUnit_l116_2;
  wire       [11:0]   _zz_when_FpUnit_l119_2;
  reg        [26:0]   _zz_flagUF_27;
  reg                 _zz_flagUF_28;
  wire                when_FpUnit_l116_2;
  wire                when_FpUnit_l119_2;
  wire       [11:0]   _zz_when_FpUnit_l150_10;
  wire                _zz_flagUF_29;
  wire                _zz_flagUF_30;
  wire                _zz_flagUF_31;
  wire       [23:0]   _zz_when_FpUnit_l150_11;
  wire       [24:0]   _zz_when_FpUnit_l150_12;
  wire                _zz_when_FpUnit_l150_13;
  wire       [23:0]   _zz_res_14;
  wire       [11:0]   _zz_when_FpUnit_l150_14;
  wire                _zz_flagUF_32;
  wire                when_FpUnit_l150_2;
  wire       [31:0]   _zz_res_15;
  wire       [31:0]   _zz_res_16;
  reg        [31:0]   _zz_res_17;
  wire                when_FpUnit_l154_2;
  reg        [31:0]   _zz_res_18;
  wire                when_FpUnit_l234;
  wire                when_FpUnit_l235;
  wire                when_FpUnit_l236;
  wire                when_FpUnit_l237;
  wire                _zz_res_19;
  wire       [79:0]   _zz_when_FpUnit_l84_19;
  wire       [28:0]   _zz_when_FpUnit_l84_20;
  reg        [4:0]    _zz_when_FpUnit_l91_3;
  wire                when_FpUnit_l84_104;
  wire                when_FpUnit_l84_105;
  wire                when_FpUnit_l84_106;
  wire                when_FpUnit_l84_107;
  wire                when_FpUnit_l84_108;
  wire                when_FpUnit_l84_109;
  wire                when_FpUnit_l84_110;
  wire                when_FpUnit_l84_111;
  wire                when_FpUnit_l84_112;
  wire                when_FpUnit_l84_113;
  wire                when_FpUnit_l84_114;
  wire                when_FpUnit_l84_115;
  wire                when_FpUnit_l84_116;
  wire                when_FpUnit_l84_117;
  wire                when_FpUnit_l84_118;
  wire                when_FpUnit_l84_119;
  wire                when_FpUnit_l84_120;
  wire                when_FpUnit_l84_121;
  wire                when_FpUnit_l84_122;
  wire                when_FpUnit_l84_123;
  wire                when_FpUnit_l84_124;
  wire                when_FpUnit_l84_125;
  wire                when_FpUnit_l84_126;
  wire                when_FpUnit_l84_127;
  wire                when_FpUnit_l84_128;
  wire                when_FpUnit_l84_129;
  wire                when_FpUnit_l84_130;
  wire                when_FpUnit_l84_131;
  wire                when_FpUnit_l84_132;
  reg        [26:0]   _zz_flagUF_33;
  reg                 _zz_flagUF_34;
  wire       [11:0]   _zz_flagUF_35;
  wire                when_FpUnit_l90_3;
  wire                when_FpUnit_l91_3;
  wire       [4:0]    _zz_flagUF_36;
  wire                _zz_flagUF_37;
  wire                _zz_flagUF_38;
  wire       [11:0]   _zz_when_FpUnit_l116_3;
  wire       [11:0]   _zz_when_FpUnit_l119_3;
  reg        [26:0]   _zz_flagUF_39;
  reg                 _zz_flagUF_40;
  wire                when_FpUnit_l116_3;
  wire                when_FpUnit_l119_3;
  wire       [11:0]   _zz_when_FpUnit_l150_15;
  wire                _zz_flagUF_41;
  wire                _zz_flagUF_42;
  wire                _zz_flagUF_43;
  wire       [23:0]   _zz_when_FpUnit_l150_16;
  wire       [24:0]   _zz_when_FpUnit_l150_17;
  wire                _zz_when_FpUnit_l150_18;
  wire       [23:0]   _zz_res_20;
  wire       [11:0]   _zz_when_FpUnit_l150_19;
  wire                _zz_flagUF_44;
  wire                when_FpUnit_l150_3;
  wire       [31:0]   _zz_res_21;
  wire       [31:0]   _zz_res_22;
  reg        [31:0]   _zz_res_23;
  wire                when_FpUnit_l154_3;
  reg        [31:0]   _zz_res_24;
  wire                when_FpUnit_l261;
  wire                when_FpUnit_l262;
  wire                _zz_flagUF_45;
  wire       [55:0]   _zz_when_FpUnit_l84_21;
  wire       [29:0]   _zz_when_FpUnit_l84_22;
  wire       [57:0]   _zz_when_FpUnit_l84_23;
  wire       [57:0]   _zz_when_FpUnit_l84_24;
  wire                _zz_when_FpUnit_l84_25;
  wire       [29:0]   _zz_when_FpUnit_l84_26;
  wire       [57:0]   _zz_when_FpUnit_l84_27;
  wire       [57:0]   _zz_when_FpUnit_l84_28;
  wire                _zz_when_FpUnit_l84_29;
  wire       [29:0]   _zz_when_FpUnit_l84_30;
  wire       [57:0]   _zz_when_FpUnit_l84_31;
  wire       [57:0]   _zz_when_FpUnit_l84_32;
  wire                _zz_when_FpUnit_l84_33;
  wire       [29:0]   _zz_when_FpUnit_l84_34;
  wire       [57:0]   _zz_when_FpUnit_l84_35;
  wire       [57:0]   _zz_when_FpUnit_l84_36;
  wire                _zz_when_FpUnit_l84_37;
  wire       [29:0]   _zz_when_FpUnit_l84_38;
  wire       [57:0]   _zz_when_FpUnit_l84_39;
  wire       [57:0]   _zz_when_FpUnit_l84_40;
  wire                _zz_when_FpUnit_l84_41;
  wire       [29:0]   _zz_when_FpUnit_l84_42;
  wire       [57:0]   _zz_when_FpUnit_l84_43;
  wire       [57:0]   _zz_when_FpUnit_l84_44;
  wire                _zz_when_FpUnit_l84_45;
  wire       [29:0]   _zz_when_FpUnit_l84_46;
  wire       [57:0]   _zz_when_FpUnit_l84_47;
  wire       [57:0]   _zz_when_FpUnit_l84_48;
  wire                _zz_when_FpUnit_l84_49;
  wire       [29:0]   _zz_when_FpUnit_l84_50;
  wire       [57:0]   _zz_when_FpUnit_l84_51;
  wire       [57:0]   _zz_when_FpUnit_l84_52;
  wire                _zz_when_FpUnit_l84_53;
  wire       [29:0]   _zz_when_FpUnit_l84_54;
  wire       [57:0]   _zz_when_FpUnit_l84_55;
  wire       [57:0]   _zz_when_FpUnit_l84_56;
  wire                _zz_when_FpUnit_l84_57;
  wire       [29:0]   _zz_when_FpUnit_l84_58;
  wire       [57:0]   _zz_when_FpUnit_l84_59;
  wire       [57:0]   _zz_when_FpUnit_l84_60;
  wire                _zz_when_FpUnit_l84_61;
  wire       [29:0]   _zz_when_FpUnit_l84_62;
  wire       [57:0]   _zz_when_FpUnit_l84_63;
  wire       [57:0]   _zz_when_FpUnit_l84_64;
  wire                _zz_when_FpUnit_l84_65;
  wire       [29:0]   _zz_when_FpUnit_l84_66;
  wire       [57:0]   _zz_when_FpUnit_l84_67;
  wire       [57:0]   _zz_when_FpUnit_l84_68;
  wire                _zz_when_FpUnit_l84_69;
  wire       [29:0]   _zz_when_FpUnit_l84_70;
  wire       [57:0]   _zz_when_FpUnit_l84_71;
  wire       [57:0]   _zz_when_FpUnit_l84_72;
  wire                _zz_when_FpUnit_l84_73;
  wire       [29:0]   _zz_when_FpUnit_l84_74;
  wire       [57:0]   _zz_when_FpUnit_l84_75;
  wire       [57:0]   _zz_when_FpUnit_l84_76;
  wire                _zz_when_FpUnit_l84_77;
  wire       [29:0]   _zz_when_FpUnit_l84_78;
  wire       [57:0]   _zz_when_FpUnit_l84_79;
  wire       [57:0]   _zz_when_FpUnit_l84_80;
  wire                _zz_when_FpUnit_l84_81;
  wire       [29:0]   _zz_when_FpUnit_l84_82;
  wire       [57:0]   _zz_when_FpUnit_l84_83;
  wire       [57:0]   _zz_when_FpUnit_l84_84;
  wire                _zz_when_FpUnit_l84_85;
  wire       [29:0]   _zz_when_FpUnit_l84_86;
  wire       [57:0]   _zz_when_FpUnit_l84_87;
  wire       [57:0]   _zz_when_FpUnit_l84_88;
  wire                _zz_when_FpUnit_l84_89;
  wire       [29:0]   _zz_when_FpUnit_l84_90;
  wire       [57:0]   _zz_when_FpUnit_l84_91;
  wire       [57:0]   _zz_when_FpUnit_l84_92;
  wire                _zz_when_FpUnit_l84_93;
  wire       [29:0]   _zz_when_FpUnit_l84_94;
  wire       [57:0]   _zz_when_FpUnit_l84_95;
  wire       [57:0]   _zz_when_FpUnit_l84_96;
  wire                _zz_when_FpUnit_l84_97;
  wire       [29:0]   _zz_when_FpUnit_l84_98;
  wire       [57:0]   _zz_when_FpUnit_l84_99;
  wire       [57:0]   _zz_when_FpUnit_l84_100;
  wire                _zz_when_FpUnit_l84_101;
  wire       [29:0]   _zz_when_FpUnit_l84_102;
  wire       [57:0]   _zz_when_FpUnit_l84_103;
  wire       [57:0]   _zz_when_FpUnit_l84_104;
  wire                _zz_when_FpUnit_l84_105;
  wire       [29:0]   _zz_when_FpUnit_l84_106;
  wire       [57:0]   _zz_when_FpUnit_l84_107;
  wire       [57:0]   _zz_when_FpUnit_l84_108;
  wire                _zz_when_FpUnit_l84_109;
  wire       [29:0]   _zz_when_FpUnit_l84_110;
  wire       [57:0]   _zz_when_FpUnit_l84_111;
  wire       [57:0]   _zz_when_FpUnit_l84_112;
  wire                _zz_when_FpUnit_l84_113;
  wire       [29:0]   _zz_when_FpUnit_l84_114;
  wire       [57:0]   _zz_when_FpUnit_l84_115;
  wire       [57:0]   _zz_when_FpUnit_l84_116;
  wire                _zz_when_FpUnit_l84_117;
  wire       [29:0]   _zz_when_FpUnit_l84_118;
  wire       [57:0]   _zz_when_FpUnit_l84_119;
  wire       [57:0]   _zz_when_FpUnit_l84_120;
  wire                _zz_when_FpUnit_l84_121;
  wire       [29:0]   _zz_when_FpUnit_l84_122;
  wire       [57:0]   _zz_when_FpUnit_l84_123;
  wire       [57:0]   _zz_when_FpUnit_l84_124;
  wire                _zz_when_FpUnit_l84_125;
  wire       [29:0]   _zz_when_FpUnit_l84_126;
  wire       [57:0]   _zz_when_FpUnit_l84_127;
  wire       [57:0]   _zz_when_FpUnit_l84_128;
  wire                _zz_when_FpUnit_l84_129;
  wire       [29:0]   _zz_when_FpUnit_l84_130;
  wire       [57:0]   _zz_when_FpUnit_l84_131;
  wire       [57:0]   _zz_when_FpUnit_l84_132;
  wire                _zz_when_FpUnit_l84_133;
  wire       [29:0]   _zz_when_FpUnit_l84_134;
  reg        [4:0]    _zz_when_FpUnit_l91_4;
  wire                when_FpUnit_l84_133;
  wire                when_FpUnit_l84_134;
  wire                when_FpUnit_l84_135;
  wire                when_FpUnit_l84_136;
  wire                when_FpUnit_l84_137;
  wire                when_FpUnit_l84_138;
  wire                when_FpUnit_l84_139;
  wire                when_FpUnit_l84_140;
  wire                when_FpUnit_l84_141;
  wire                when_FpUnit_l84_142;
  wire                when_FpUnit_l84_143;
  wire                when_FpUnit_l84_144;
  wire                when_FpUnit_l84_145;
  wire                when_FpUnit_l84_146;
  wire                when_FpUnit_l84_147;
  wire                when_FpUnit_l84_148;
  wire                when_FpUnit_l84_149;
  wire                when_FpUnit_l84_150;
  wire                when_FpUnit_l84_151;
  wire                when_FpUnit_l84_152;
  wire                when_FpUnit_l84_153;
  wire                when_FpUnit_l84_154;
  wire                when_FpUnit_l84_155;
  wire                when_FpUnit_l84_156;
  wire                when_FpUnit_l84_157;
  wire                when_FpUnit_l84_158;
  wire                when_FpUnit_l84_159;
  wire                when_FpUnit_l84_160;
  wire                when_FpUnit_l84_161;
  wire                when_FpUnit_l84_162;
  reg        [26:0]   _zz_flagUF_46;
  reg                 _zz_flagUF_47;
  wire       [11:0]   _zz_flagUF_48;
  wire                when_FpUnit_l90_4;
  wire                when_FpUnit_l91_4;
  wire       [4:0]    _zz_flagUF_49;
  wire                _zz_flagUF_50;
  wire                _zz_res_25;
  wire                _zz_flagUF_51;
  wire       [11:0]   _zz_when_FpUnit_l116_4;
  wire       [11:0]   _zz_when_FpUnit_l119_4;
  reg        [26:0]   _zz_flagUF_52;
  reg                 _zz_flagUF_53;
  wire                when_FpUnit_l116_4;
  wire                when_FpUnit_l119_4;
  wire       [11:0]   _zz_when_FpUnit_l150_20;
  wire                _zz_flagUF_54;
  wire                _zz_flagUF_55;
  wire                _zz_flagUF_56;
  wire       [23:0]   _zz_when_FpUnit_l150_21;
  wire       [24:0]   _zz_when_FpUnit_l150_22;
  wire                _zz_when_FpUnit_l150_23;
  wire       [23:0]   _zz_res_26;
  wire       [11:0]   _zz_when_FpUnit_l150_24;
  wire                _zz_flagUF_57;
  wire                when_FpUnit_l150_4;
  wire       [31:0]   _zz_res_27;
  wire       [31:0]   _zz_res_28;
  reg        [31:0]   _zz_res_29;
  wire                when_FpUnit_l154_4;
  reg        [31:0]   _zz_res_30;
  wire                when_FpUnit_l305;
  wire                when_FpUnit_l396;
  wire                when_FpUnit_l394;
  wire                _zz_res_31;
  wire                _zz_res_32;
  reg        [31:0]   _zz_res_33;
  wire                when_FpUnit_l391;
  wire                when_FpUnit_l396_1;
  wire                when_FpUnit_l394_1;
  wire                _zz_res_34;
  wire                _zz_res_35;
  reg        [31:0]   _zz_res_36;
  wire                when_FpUnit_l391_1;
  reg        [31:0]   _zz_res_37;
  wire                _zz_res_38;
  wire                _zz_res_39;
  reg        [31:0]   _zz_res_40;
  reg        [9:0]    _zz_res_41;
  wire                _zz_when_FpUnit_l359_1;
  wire                _zz_when_FpUnit_l359_2;
  wire       [47:0]   _zz_when_FpUnit_l84_135;
  wire       [11:0]   _zz_when_FpUnit_l329_2;
  wire       [11:0]   _zz_when_FpUnit_l329_3;
  wire       [11:0]   _zz_when_FpUnit_l329_4;
  wire       [11:0]   _zz_when_FpUnit_l329_5;
  wire       [11:0]   _zz_when_FpUnit_l330;
  reg        [53:0]   _zz_when_FpUnit_l84_136;
  reg                 _zz_flagUF_58;
  wire                when_FpUnit_l329;
  wire                when_FpUnit_l330;
  wire       [11:0]   _zz_when_FpUnit_l329_6;
  wire       [11:0]   _zz_when_FpUnit_l330_1;
  reg        [53:0]   _zz_when_FpUnit_l84_137;
  reg                 _zz_flagUF_59;
  wire                when_FpUnit_l329_1;
  wire                when_FpUnit_l330_1;
  wire       [54:0]   _zz_when_FpUnit_l84_138;
  wire       [54:0]   _zz_when_FpUnit_l84_139;
  wire       [55:0]   _zz_when_FpUnit_l84_140;
  wire                _zz_when_FpUnit_l84_141;
  wire       [55:0]   _zz_when_FpUnit_l84_142;
  reg        [5:0]    _zz_when_FpUnit_l91_5;
  wire                when_FpUnit_l84_163;
  wire                when_FpUnit_l84_164;
  wire                when_FpUnit_l84_165;
  wire                when_FpUnit_l84_166;
  wire                when_FpUnit_l84_167;
  wire                when_FpUnit_l84_168;
  wire                when_FpUnit_l84_169;
  wire                when_FpUnit_l84_170;
  wire                when_FpUnit_l84_171;
  wire                when_FpUnit_l84_172;
  wire                when_FpUnit_l84_173;
  wire                when_FpUnit_l84_174;
  wire                when_FpUnit_l84_175;
  wire                when_FpUnit_l84_176;
  wire                when_FpUnit_l84_177;
  wire                when_FpUnit_l84_178;
  wire                when_FpUnit_l84_179;
  wire                when_FpUnit_l84_180;
  wire                when_FpUnit_l84_181;
  wire                when_FpUnit_l84_182;
  wire                when_FpUnit_l84_183;
  wire                when_FpUnit_l84_184;
  wire                when_FpUnit_l84_185;
  wire                when_FpUnit_l84_186;
  wire                when_FpUnit_l84_187;
  wire                when_FpUnit_l84_188;
  wire                when_FpUnit_l84_189;
  wire                when_FpUnit_l84_190;
  wire                when_FpUnit_l84_191;
  wire                when_FpUnit_l84_192;
  wire                when_FpUnit_l84_193;
  wire                when_FpUnit_l84_194;
  wire                when_FpUnit_l84_195;
  wire                when_FpUnit_l84_196;
  wire                when_FpUnit_l84_197;
  wire                when_FpUnit_l84_198;
  wire                when_FpUnit_l84_199;
  wire                when_FpUnit_l84_200;
  wire                when_FpUnit_l84_201;
  wire                when_FpUnit_l84_202;
  wire                when_FpUnit_l84_203;
  wire                when_FpUnit_l84_204;
  wire                when_FpUnit_l84_205;
  wire                when_FpUnit_l84_206;
  wire                when_FpUnit_l84_207;
  wire                when_FpUnit_l84_208;
  wire                when_FpUnit_l84_209;
  wire                when_FpUnit_l84_210;
  wire                when_FpUnit_l84_211;
  wire                when_FpUnit_l84_212;
  wire                when_FpUnit_l84_213;
  wire                when_FpUnit_l84_214;
  wire                when_FpUnit_l84_215;
  wire                when_FpUnit_l84_216;
  wire                when_FpUnit_l84_217;
  wire                when_FpUnit_l84_218;
  reg        [26:0]   _zz_flagUF_60;
  reg                 _zz_flagUF_61;
  wire       [11:0]   _zz_flagUF_62;
  wire                when_FpUnit_l90_5;
  wire                when_FpUnit_l91_5;
  wire       [5:0]    _zz_flagUF_63;
  wire                _zz_flagUF_64;
  wire                _zz_flagUF_65;
  wire       [11:0]   _zz_when_FpUnit_l116_5;
  wire       [11:0]   _zz_when_FpUnit_l119_5;
  reg        [26:0]   _zz_flagUF_66;
  reg                 _zz_flagUF_67;
  wire                when_FpUnit_l116_5;
  wire                when_FpUnit_l119_5;
  wire       [11:0]   _zz_when_FpUnit_l150_25;
  wire                _zz_flagUF_68;
  wire                _zz_flagUF_69;
  wire                _zz_flagUF_70;
  wire       [23:0]   _zz_when_FpUnit_l150_26;
  wire       [24:0]   _zz_when_FpUnit_l150_27;
  wire                _zz_when_FpUnit_l150_28;
  wire       [23:0]   _zz_res_42;
  wire       [11:0]   _zz_when_FpUnit_l150_29;
  wire                _zz_flagUF_71;
  wire                when_FpUnit_l150_5;
  wire       [31:0]   _zz_res_43;
  wire       [31:0]   _zz_res_44;
  reg        [31:0]   _zz_res_45;
  wire                when_FpUnit_l154_5;
  reg        [31:0]   _zz_res_46;
  wire                when_FpUnit_l357;
  wire                when_FpUnit_l358;
  wire                when_FpUnit_l359;
  wire                when_FpUnit_l360;
  wire                _zz_when_FpUnit_l359_3;
  wire                _zz_when_FpUnit_l359_4;
  wire       [47:0]   _zz_when_FpUnit_l84_143;
  wire       [11:0]   _zz_when_FpUnit_l329_7;
  wire       [11:0]   _zz_when_FpUnit_l329_8;
  wire       [11:0]   _zz_when_FpUnit_l329_9;
  wire       [11:0]   _zz_when_FpUnit_l329_10;
  wire       [11:0]   _zz_when_FpUnit_l330_2;
  reg        [53:0]   _zz_when_FpUnit_l84_144;
  reg                 _zz_flagUF_72;
  wire                when_FpUnit_l329_2;
  wire                when_FpUnit_l330_2;
  wire       [11:0]   _zz_when_FpUnit_l329_11;
  wire       [11:0]   _zz_when_FpUnit_l330_3;
  reg        [53:0]   _zz_when_FpUnit_l84_145;
  reg                 _zz_flagUF_73;
  wire                when_FpUnit_l329_3;
  wire                when_FpUnit_l330_3;
  wire       [54:0]   _zz_when_FpUnit_l84_146;
  wire       [54:0]   _zz_when_FpUnit_l84_147;
  wire       [55:0]   _zz_when_FpUnit_l84_148;
  wire                _zz_when_FpUnit_l84_149;
  wire       [55:0]   _zz_when_FpUnit_l84_150;
  reg        [5:0]    _zz_when_FpUnit_l91_6;
  wire                when_FpUnit_l84_219;
  wire                when_FpUnit_l84_220;
  wire                when_FpUnit_l84_221;
  wire                when_FpUnit_l84_222;
  wire                when_FpUnit_l84_223;
  wire                when_FpUnit_l84_224;
  wire                when_FpUnit_l84_225;
  wire                when_FpUnit_l84_226;
  wire                when_FpUnit_l84_227;
  wire                when_FpUnit_l84_228;
  wire                when_FpUnit_l84_229;
  wire                when_FpUnit_l84_230;
  wire                when_FpUnit_l84_231;
  wire                when_FpUnit_l84_232;
  wire                when_FpUnit_l84_233;
  wire                when_FpUnit_l84_234;
  wire                when_FpUnit_l84_235;
  wire                when_FpUnit_l84_236;
  wire                when_FpUnit_l84_237;
  wire                when_FpUnit_l84_238;
  wire                when_FpUnit_l84_239;
  wire                when_FpUnit_l84_240;
  wire                when_FpUnit_l84_241;
  wire                when_FpUnit_l84_242;
  wire                when_FpUnit_l84_243;
  wire                when_FpUnit_l84_244;
  wire                when_FpUnit_l84_245;
  wire                when_FpUnit_l84_246;
  wire                when_FpUnit_l84_247;
  wire                when_FpUnit_l84_248;
  wire                when_FpUnit_l84_249;
  wire                when_FpUnit_l84_250;
  wire                when_FpUnit_l84_251;
  wire                when_FpUnit_l84_252;
  wire                when_FpUnit_l84_253;
  wire                when_FpUnit_l84_254;
  wire                when_FpUnit_l84_255;
  wire                when_FpUnit_l84_256;
  wire                when_FpUnit_l84_257;
  wire                when_FpUnit_l84_258;
  wire                when_FpUnit_l84_259;
  wire                when_FpUnit_l84_260;
  wire                when_FpUnit_l84_261;
  wire                when_FpUnit_l84_262;
  wire                when_FpUnit_l84_263;
  wire                when_FpUnit_l84_264;
  wire                when_FpUnit_l84_265;
  wire                when_FpUnit_l84_266;
  wire                when_FpUnit_l84_267;
  wire                when_FpUnit_l84_268;
  wire                when_FpUnit_l84_269;
  wire                when_FpUnit_l84_270;
  wire                when_FpUnit_l84_271;
  wire                when_FpUnit_l84_272;
  wire                when_FpUnit_l84_273;
  wire                when_FpUnit_l84_274;
  reg        [26:0]   _zz_flagUF_74;
  reg                 _zz_flagUF_75;
  wire       [11:0]   _zz_flagUF_76;
  wire                when_FpUnit_l90_6;
  wire                when_FpUnit_l91_6;
  wire       [5:0]    _zz_flagUF_77;
  wire                _zz_flagUF_78;
  wire                _zz_flagUF_79;
  wire       [11:0]   _zz_when_FpUnit_l116_6;
  wire       [11:0]   _zz_when_FpUnit_l119_6;
  reg        [26:0]   _zz_flagUF_80;
  reg                 _zz_flagUF_81;
  wire                when_FpUnit_l116_6;
  wire                when_FpUnit_l119_6;
  wire       [11:0]   _zz_when_FpUnit_l150_30;
  wire                _zz_flagUF_82;
  wire                _zz_flagUF_83;
  wire                _zz_flagUF_84;
  wire       [23:0]   _zz_when_FpUnit_l150_31;
  wire       [24:0]   _zz_when_FpUnit_l150_32;
  wire                _zz_when_FpUnit_l150_33;
  wire       [23:0]   _zz_res_47;
  wire       [11:0]   _zz_when_FpUnit_l150_34;
  wire                _zz_flagUF_85;
  wire                when_FpUnit_l150_6;
  wire       [31:0]   _zz_res_48;
  wire       [31:0]   _zz_res_49;
  reg        [31:0]   _zz_res_50;
  wire                when_FpUnit_l154_6;
  reg        [31:0]   _zz_res_51;
  wire                when_FpUnit_l357_1;
  wire                when_FpUnit_l358_1;
  wire                when_FpUnit_l359_1;
  wire                when_FpUnit_l360_1;
  wire                _zz_when_FpUnit_l359_5;
  wire                _zz_when_FpUnit_l359_6;
  wire       [47:0]   _zz_when_FpUnit_l84_151;
  wire       [11:0]   _zz_when_FpUnit_l329_12;
  wire       [11:0]   _zz_when_FpUnit_l329_13;
  wire       [11:0]   _zz_when_FpUnit_l329_14;
  wire       [11:0]   _zz_when_FpUnit_l329_15;
  wire       [11:0]   _zz_when_FpUnit_l330_4;
  reg        [53:0]   _zz_when_FpUnit_l84_152;
  reg                 _zz_flagUF_86;
  wire                when_FpUnit_l329_4;
  wire                when_FpUnit_l330_4;
  wire       [11:0]   _zz_when_FpUnit_l329_16;
  wire       [11:0]   _zz_when_FpUnit_l330_5;
  reg        [53:0]   _zz_when_FpUnit_l84_153;
  reg                 _zz_flagUF_87;
  wire                when_FpUnit_l329_5;
  wire                when_FpUnit_l330_5;
  wire       [54:0]   _zz_when_FpUnit_l84_154;
  wire       [54:0]   _zz_when_FpUnit_l84_155;
  wire       [55:0]   _zz_when_FpUnit_l84_156;
  wire                _zz_when_FpUnit_l84_157;
  wire       [55:0]   _zz_when_FpUnit_l84_158;
  reg        [5:0]    _zz_when_FpUnit_l91_7;
  wire                when_FpUnit_l84_275;
  wire                when_FpUnit_l84_276;
  wire                when_FpUnit_l84_277;
  wire                when_FpUnit_l84_278;
  wire                when_FpUnit_l84_279;
  wire                when_FpUnit_l84_280;
  wire                when_FpUnit_l84_281;
  wire                when_FpUnit_l84_282;
  wire                when_FpUnit_l84_283;
  wire                when_FpUnit_l84_284;
  wire                when_FpUnit_l84_285;
  wire                when_FpUnit_l84_286;
  wire                when_FpUnit_l84_287;
  wire                when_FpUnit_l84_288;
  wire                when_FpUnit_l84_289;
  wire                when_FpUnit_l84_290;
  wire                when_FpUnit_l84_291;
  wire                when_FpUnit_l84_292;
  wire                when_FpUnit_l84_293;
  wire                when_FpUnit_l84_294;
  wire                when_FpUnit_l84_295;
  wire                when_FpUnit_l84_296;
  wire                when_FpUnit_l84_297;
  wire                when_FpUnit_l84_298;
  wire                when_FpUnit_l84_299;
  wire                when_FpUnit_l84_300;
  wire                when_FpUnit_l84_301;
  wire                when_FpUnit_l84_302;
  wire                when_FpUnit_l84_303;
  wire                when_FpUnit_l84_304;
  wire                when_FpUnit_l84_305;
  wire                when_FpUnit_l84_306;
  wire                when_FpUnit_l84_307;
  wire                when_FpUnit_l84_308;
  wire                when_FpUnit_l84_309;
  wire                when_FpUnit_l84_310;
  wire                when_FpUnit_l84_311;
  wire                when_FpUnit_l84_312;
  wire                when_FpUnit_l84_313;
  wire                when_FpUnit_l84_314;
  wire                when_FpUnit_l84_315;
  wire                when_FpUnit_l84_316;
  wire                when_FpUnit_l84_317;
  wire                when_FpUnit_l84_318;
  wire                when_FpUnit_l84_319;
  wire                when_FpUnit_l84_320;
  wire                when_FpUnit_l84_321;
  wire                when_FpUnit_l84_322;
  wire                when_FpUnit_l84_323;
  wire                when_FpUnit_l84_324;
  wire                when_FpUnit_l84_325;
  wire                when_FpUnit_l84_326;
  wire                when_FpUnit_l84_327;
  wire                when_FpUnit_l84_328;
  wire                when_FpUnit_l84_329;
  wire                when_FpUnit_l84_330;
  reg        [26:0]   _zz_flagUF_88;
  reg                 _zz_flagUF_89;
  wire       [11:0]   _zz_flagUF_90;
  wire                when_FpUnit_l90_7;
  wire                when_FpUnit_l91_7;
  wire       [5:0]    _zz_flagUF_91;
  wire                _zz_flagUF_92;
  wire                _zz_flagUF_93;
  wire       [11:0]   _zz_when_FpUnit_l116_7;
  wire       [11:0]   _zz_when_FpUnit_l119_7;
  reg        [26:0]   _zz_flagUF_94;
  reg                 _zz_flagUF_95;
  wire                when_FpUnit_l116_7;
  wire                when_FpUnit_l119_7;
  wire       [11:0]   _zz_when_FpUnit_l150_35;
  wire                _zz_flagUF_96;
  wire                _zz_flagUF_97;
  wire                _zz_flagUF_98;
  wire       [23:0]   _zz_when_FpUnit_l150_36;
  wire       [24:0]   _zz_when_FpUnit_l150_37;
  wire                _zz_when_FpUnit_l150_38;
  wire       [23:0]   _zz_res_52;
  wire       [11:0]   _zz_when_FpUnit_l150_39;
  wire                _zz_flagUF_99;
  wire                when_FpUnit_l150_7;
  wire       [31:0]   _zz_res_53;
  wire       [31:0]   _zz_res_54;
  reg        [31:0]   _zz_res_55;
  wire                when_FpUnit_l154_7;
  reg        [31:0]   _zz_res_56;
  wire                when_FpUnit_l357_2;
  wire                when_FpUnit_l358_2;
  wire                when_FpUnit_l359_2;
  wire                when_FpUnit_l360_2;
  wire                _zz_when_FpUnit_l359_7;
  wire                _zz_when_FpUnit_l359_8;
  wire       [47:0]   _zz_when_FpUnit_l84_159;
  wire       [11:0]   _zz_when_FpUnit_l329_17;
  wire       [11:0]   _zz_when_FpUnit_l329_18;
  wire       [11:0]   _zz_when_FpUnit_l329_19;
  wire       [11:0]   _zz_when_FpUnit_l329_20;
  wire       [11:0]   _zz_when_FpUnit_l330_6;
  reg        [53:0]   _zz_when_FpUnit_l84_160;
  reg                 _zz_flagUF_100;
  wire                when_FpUnit_l329_6;
  wire                when_FpUnit_l330_6;
  wire       [11:0]   _zz_when_FpUnit_l329_21;
  wire       [11:0]   _zz_when_FpUnit_l330_7;
  reg        [53:0]   _zz_when_FpUnit_l84_161;
  reg                 _zz_flagUF_101;
  wire                when_FpUnit_l329_7;
  wire                when_FpUnit_l330_7;
  wire       [54:0]   _zz_when_FpUnit_l84_162;
  wire       [54:0]   _zz_when_FpUnit_l84_163;
  wire       [55:0]   _zz_when_FpUnit_l84_164;
  wire                _zz_when_FpUnit_l84_165;
  wire       [55:0]   _zz_when_FpUnit_l84_166;
  reg        [5:0]    _zz_when_FpUnit_l91_8;
  wire                when_FpUnit_l84_331;
  wire                when_FpUnit_l84_332;
  wire                when_FpUnit_l84_333;
  wire                when_FpUnit_l84_334;
  wire                when_FpUnit_l84_335;
  wire                when_FpUnit_l84_336;
  wire                when_FpUnit_l84_337;
  wire                when_FpUnit_l84_338;
  wire                when_FpUnit_l84_339;
  wire                when_FpUnit_l84_340;
  wire                when_FpUnit_l84_341;
  wire                when_FpUnit_l84_342;
  wire                when_FpUnit_l84_343;
  wire                when_FpUnit_l84_344;
  wire                when_FpUnit_l84_345;
  wire                when_FpUnit_l84_346;
  wire                when_FpUnit_l84_347;
  wire                when_FpUnit_l84_348;
  wire                when_FpUnit_l84_349;
  wire                when_FpUnit_l84_350;
  wire                when_FpUnit_l84_351;
  wire                when_FpUnit_l84_352;
  wire                when_FpUnit_l84_353;
  wire                when_FpUnit_l84_354;
  wire                when_FpUnit_l84_355;
  wire                when_FpUnit_l84_356;
  wire                when_FpUnit_l84_357;
  wire                when_FpUnit_l84_358;
  wire                when_FpUnit_l84_359;
  wire                when_FpUnit_l84_360;
  wire                when_FpUnit_l84_361;
  wire                when_FpUnit_l84_362;
  wire                when_FpUnit_l84_363;
  wire                when_FpUnit_l84_364;
  wire                when_FpUnit_l84_365;
  wire                when_FpUnit_l84_366;
  wire                when_FpUnit_l84_367;
  wire                when_FpUnit_l84_368;
  wire                when_FpUnit_l84_369;
  wire                when_FpUnit_l84_370;
  wire                when_FpUnit_l84_371;
  wire                when_FpUnit_l84_372;
  wire                when_FpUnit_l84_373;
  wire                when_FpUnit_l84_374;
  wire                when_FpUnit_l84_375;
  wire                when_FpUnit_l84_376;
  wire                when_FpUnit_l84_377;
  wire                when_FpUnit_l84_378;
  wire                when_FpUnit_l84_379;
  wire                when_FpUnit_l84_380;
  wire                when_FpUnit_l84_381;
  wire                when_FpUnit_l84_382;
  wire                when_FpUnit_l84_383;
  wire                when_FpUnit_l84_384;
  wire                when_FpUnit_l84_385;
  wire                when_FpUnit_l84_386;
  reg        [26:0]   _zz_flagUF_102;
  reg                 _zz_flagUF_103;
  wire       [11:0]   _zz_flagUF_104;
  wire                when_FpUnit_l90_8;
  wire                when_FpUnit_l91_8;
  wire       [5:0]    _zz_flagUF_105;
  wire                _zz_flagUF_106;
  wire                _zz_flagUF_107;
  wire       [11:0]   _zz_when_FpUnit_l116_8;
  wire       [11:0]   _zz_when_FpUnit_l119_8;
  reg        [26:0]   _zz_flagUF_108;
  reg                 _zz_flagUF_109;
  wire                when_FpUnit_l116_8;
  wire                when_FpUnit_l119_8;
  wire       [11:0]   _zz_when_FpUnit_l150_40;
  wire                _zz_flagUF_110;
  wire                _zz_flagUF_111;
  wire                _zz_flagUF_112;
  wire       [23:0]   _zz_when_FpUnit_l150_41;
  wire       [24:0]   _zz_when_FpUnit_l150_42;
  wire                _zz_when_FpUnit_l150_43;
  wire       [23:0]   _zz_res_57;
  wire       [11:0]   _zz_when_FpUnit_l150_44;
  wire                _zz_flagUF_113;
  wire                when_FpUnit_l150_8;
  wire       [31:0]   _zz_res_58;
  wire       [31:0]   _zz_res_59;
  reg        [31:0]   _zz_res_60;
  wire                when_FpUnit_l154_8;
  reg        [31:0]   _zz_res_61;
  wire                when_FpUnit_l357_3;
  wire                when_FpUnit_l358_3;
  wire                when_FpUnit_l359_3;
  wire                when_FpUnit_l360_3;
  wire       [11:0]   _zz_when_FpUnit_l447;
  reg        [33:0]   _zz_when_FpUnit_l474;
  reg                 _zz_flagNX_1;
  wire                when_FpUnit_l447;
  wire       [11:0]   _zz_flagNX_2;
  wire                when_FpUnit_l450;
  wire                when_FpUnit_l453;
  wire       [33:0]   _zz_when_FpUnit_l474_1;
  wire                when_FpUnit_l474;
  reg        [31:0]   _zz_res_62;
  wire                when_FpUnit_l479;
  wire       [11:0]   _zz_when_FpUnit_l447_1;
  reg        [33:0]   _zz_when_FpUnit_l474_2;
  reg                 _zz_flagNX_3;
  wire                when_FpUnit_l447_1;
  wire       [11:0]   _zz_flagNX_4;
  wire                when_FpUnit_l450_1;
  wire                when_FpUnit_l453_1;
  wire       [33:0]   _zz_when_FpUnit_l474_3;
  wire                when_FpUnit_l474_1;
  reg        [31:0]   _zz_res_63;
  wire                when_FpUnit_l479_1;
  wire       [11:0]   _zz_when_FpUnit_l447_2;
  reg        [65:0]   _zz_when_FpUnit_l474_4;
  reg                 _zz_flagNX_5;
  wire                when_FpUnit_l447_2;
  wire       [11:0]   _zz_flagNX_6;
  wire                when_FpUnit_l450_2;
  wire                when_FpUnit_l453_2;
  wire       [65:0]   _zz_when_FpUnit_l474_5;
  wire                when_FpUnit_l474_2;
  reg        [63:0]   _zz_res_64;
  wire                when_FpUnit_l479_2;
  wire       [11:0]   _zz_when_FpUnit_l447_3;
  reg        [65:0]   _zz_when_FpUnit_l474_6;
  reg                 _zz_flagNX_7;
  wire                when_FpUnit_l447_3;
  wire       [11:0]   _zz_flagNX_8;
  wire                when_FpUnit_l450_3;
  wire                when_FpUnit_l453_3;
  wire       [65:0]   _zz_when_FpUnit_l474_7;
  wire                when_FpUnit_l474_3;
  reg        [63:0]   _zz_res_65;
  wire                when_FpUnit_l479_3;
  wire                _zz_res_66;
  wire       [31:0]   _zz_when_FpUnit_l84_167;
  wire       [55:0]   _zz_when_FpUnit_l84_168;
  reg        [5:0]    _zz_when_FpUnit_l91_9;
  wire                when_FpUnit_l84_387;
  wire                when_FpUnit_l84_388;
  wire                when_FpUnit_l84_389;
  wire                when_FpUnit_l84_390;
  wire                when_FpUnit_l84_391;
  wire                when_FpUnit_l84_392;
  wire                when_FpUnit_l84_393;
  wire                when_FpUnit_l84_394;
  wire                when_FpUnit_l84_395;
  wire                when_FpUnit_l84_396;
  wire                when_FpUnit_l84_397;
  wire                when_FpUnit_l84_398;
  wire                when_FpUnit_l84_399;
  wire                when_FpUnit_l84_400;
  wire                when_FpUnit_l84_401;
  wire                when_FpUnit_l84_402;
  wire                when_FpUnit_l84_403;
  wire                when_FpUnit_l84_404;
  wire                when_FpUnit_l84_405;
  wire                when_FpUnit_l84_406;
  wire                when_FpUnit_l84_407;
  wire                when_FpUnit_l84_408;
  wire                when_FpUnit_l84_409;
  wire                when_FpUnit_l84_410;
  wire                when_FpUnit_l84_411;
  wire                when_FpUnit_l84_412;
  wire                when_FpUnit_l84_413;
  wire                when_FpUnit_l84_414;
  wire                when_FpUnit_l84_415;
  wire                when_FpUnit_l84_416;
  wire                when_FpUnit_l84_417;
  wire                when_FpUnit_l84_418;
  wire                when_FpUnit_l84_419;
  wire                when_FpUnit_l84_420;
  wire                when_FpUnit_l84_421;
  wire                when_FpUnit_l84_422;
  wire                when_FpUnit_l84_423;
  wire                when_FpUnit_l84_424;
  wire                when_FpUnit_l84_425;
  wire                when_FpUnit_l84_426;
  wire                when_FpUnit_l84_427;
  wire                when_FpUnit_l84_428;
  wire                when_FpUnit_l84_429;
  wire                when_FpUnit_l84_430;
  wire                when_FpUnit_l84_431;
  wire                when_FpUnit_l84_432;
  wire                when_FpUnit_l84_433;
  wire                when_FpUnit_l84_434;
  wire                when_FpUnit_l84_435;
  wire                when_FpUnit_l84_436;
  wire                when_FpUnit_l84_437;
  wire                when_FpUnit_l84_438;
  wire                when_FpUnit_l84_439;
  wire                when_FpUnit_l84_440;
  wire                when_FpUnit_l84_441;
  wire                when_FpUnit_l84_442;
  reg        [26:0]   _zz_flagNX_9;
  reg                 _zz_flagNX_10;
  wire       [11:0]   _zz_when_FpUnit_l116_9;
  wire                when_FpUnit_l90_9;
  wire                when_FpUnit_l91_9;
  wire       [5:0]    _zz_flagNX_11;
  wire                _zz_when_FpUnit_l116_10;
  wire       [11:0]   _zz_when_FpUnit_l116_11;
  wire       [11:0]   _zz_when_FpUnit_l119_9;
  reg        [26:0]   _zz_flagNX_12;
  reg                 _zz_flagNX_13;
  wire                when_FpUnit_l116_9;
  wire                when_FpUnit_l119_9;
  wire       [11:0]   _zz_when_FpUnit_l150_45;
  wire                _zz_flagNX_14;
  wire                _zz_flagNX_15;
  wire                _zz_flagNX_16;
  wire       [23:0]   _zz_when_FpUnit_l150_46;
  wire       [24:0]   _zz_when_FpUnit_l150_47;
  wire                _zz_when_FpUnit_l150_48;
  wire       [23:0]   _zz_res_67;
  wire       [11:0]   _zz_when_FpUnit_l150_49;
  wire                when_FpUnit_l150_9;
  wire       [31:0]   _zz_res_68;
  wire       [31:0]   _zz_res_69;
  reg        [31:0]   _zz_res_70;
  wire                when_FpUnit_l154_9;
  reg        [31:0]   _zz_res_71;
  wire                when_FpUnit_l498;
  wire                _zz_res_72;
  wire       [31:0]   _zz_when_FpUnit_l84_169;
  wire       [55:0]   _zz_when_FpUnit_l84_170;
  reg        [5:0]    _zz_when_FpUnit_l91_10;
  wire                when_FpUnit_l84_443;
  wire                when_FpUnit_l84_444;
  wire                when_FpUnit_l84_445;
  wire                when_FpUnit_l84_446;
  wire                when_FpUnit_l84_447;
  wire                when_FpUnit_l84_448;
  wire                when_FpUnit_l84_449;
  wire                when_FpUnit_l84_450;
  wire                when_FpUnit_l84_451;
  wire                when_FpUnit_l84_452;
  wire                when_FpUnit_l84_453;
  wire                when_FpUnit_l84_454;
  wire                when_FpUnit_l84_455;
  wire                when_FpUnit_l84_456;
  wire                when_FpUnit_l84_457;
  wire                when_FpUnit_l84_458;
  wire                when_FpUnit_l84_459;
  wire                when_FpUnit_l84_460;
  wire                when_FpUnit_l84_461;
  wire                when_FpUnit_l84_462;
  wire                when_FpUnit_l84_463;
  wire                when_FpUnit_l84_464;
  wire                when_FpUnit_l84_465;
  wire                when_FpUnit_l84_466;
  wire                when_FpUnit_l84_467;
  wire                when_FpUnit_l84_468;
  wire                when_FpUnit_l84_469;
  wire                when_FpUnit_l84_470;
  wire                when_FpUnit_l84_471;
  wire                when_FpUnit_l84_472;
  wire                when_FpUnit_l84_473;
  wire                when_FpUnit_l84_474;
  wire                when_FpUnit_l84_475;
  wire                when_FpUnit_l84_476;
  wire                when_FpUnit_l84_477;
  wire                when_FpUnit_l84_478;
  wire                when_FpUnit_l84_479;
  wire                when_FpUnit_l84_480;
  wire                when_FpUnit_l84_481;
  wire                when_FpUnit_l84_482;
  wire                when_FpUnit_l84_483;
  wire                when_FpUnit_l84_484;
  wire                when_FpUnit_l84_485;
  wire                when_FpUnit_l84_486;
  wire                when_FpUnit_l84_487;
  wire                when_FpUnit_l84_488;
  wire                when_FpUnit_l84_489;
  wire                when_FpUnit_l84_490;
  wire                when_FpUnit_l84_491;
  wire                when_FpUnit_l84_492;
  wire                when_FpUnit_l84_493;
  wire                when_FpUnit_l84_494;
  wire                when_FpUnit_l84_495;
  wire                when_FpUnit_l84_496;
  wire                when_FpUnit_l84_497;
  wire                when_FpUnit_l84_498;
  reg        [26:0]   _zz_flagNX_17;
  reg                 _zz_flagNX_18;
  wire       [11:0]   _zz_when_FpUnit_l116_12;
  wire                when_FpUnit_l90_10;
  wire                when_FpUnit_l91_10;
  wire       [5:0]    _zz_flagNX_19;
  wire                _zz_when_FpUnit_l116_13;
  wire       [11:0]   _zz_when_FpUnit_l116_14;
  wire       [11:0]   _zz_when_FpUnit_l119_10;
  reg        [26:0]   _zz_flagNX_20;
  reg                 _zz_flagNX_21;
  wire                when_FpUnit_l116_10;
  wire                when_FpUnit_l119_10;
  wire       [11:0]   _zz_when_FpUnit_l150_50;
  wire                _zz_flagNX_22;
  wire                _zz_flagNX_23;
  wire                _zz_flagNX_24;
  wire       [23:0]   _zz_when_FpUnit_l150_51;
  wire       [24:0]   _zz_when_FpUnit_l150_52;
  wire                _zz_when_FpUnit_l150_53;
  wire       [23:0]   _zz_res_73;
  wire       [11:0]   _zz_when_FpUnit_l150_54;
  wire                when_FpUnit_l150_10;
  wire       [31:0]   _zz_res_74;
  wire       [31:0]   _zz_res_75;
  reg        [31:0]   _zz_res_76;
  wire                when_FpUnit_l154_10;
  reg        [31:0]   _zz_res_77;
  wire                when_FpUnit_l498_1;
  wire                _zz_res_78;
  wire       [63:0]   _zz_when_FpUnit_l84_171;
  wire       [87:0]   _zz_when_FpUnit_l84_172;
  reg        [6:0]    _zz_when_FpUnit_l91_11;
  wire                when_FpUnit_l84_499;
  wire                when_FpUnit_l84_500;
  wire                when_FpUnit_l84_501;
  wire                when_FpUnit_l84_502;
  wire                when_FpUnit_l84_503;
  wire                when_FpUnit_l84_504;
  wire                when_FpUnit_l84_505;
  wire                when_FpUnit_l84_506;
  wire                when_FpUnit_l84_507;
  wire                when_FpUnit_l84_508;
  wire                when_FpUnit_l84_509;
  wire                when_FpUnit_l84_510;
  wire                when_FpUnit_l84_511;
  wire                when_FpUnit_l84_512;
  wire                when_FpUnit_l84_513;
  wire                when_FpUnit_l84_514;
  wire                when_FpUnit_l84_515;
  wire                when_FpUnit_l84_516;
  wire                when_FpUnit_l84_517;
  wire                when_FpUnit_l84_518;
  wire                when_FpUnit_l84_519;
  wire                when_FpUnit_l84_520;
  wire                when_FpUnit_l84_521;
  wire                when_FpUnit_l84_522;
  wire                when_FpUnit_l84_523;
  wire                when_FpUnit_l84_524;
  wire                when_FpUnit_l84_525;
  wire                when_FpUnit_l84_526;
  wire                when_FpUnit_l84_527;
  wire                when_FpUnit_l84_528;
  wire                when_FpUnit_l84_529;
  wire                when_FpUnit_l84_530;
  wire                when_FpUnit_l84_531;
  wire                when_FpUnit_l84_532;
  wire                when_FpUnit_l84_533;
  wire                when_FpUnit_l84_534;
  wire                when_FpUnit_l84_535;
  wire                when_FpUnit_l84_536;
  wire                when_FpUnit_l84_537;
  wire                when_FpUnit_l84_538;
  wire                when_FpUnit_l84_539;
  wire                when_FpUnit_l84_540;
  wire                when_FpUnit_l84_541;
  wire                when_FpUnit_l84_542;
  wire                when_FpUnit_l84_543;
  wire                when_FpUnit_l84_544;
  wire                when_FpUnit_l84_545;
  wire                when_FpUnit_l84_546;
  wire                when_FpUnit_l84_547;
  wire                when_FpUnit_l84_548;
  wire                when_FpUnit_l84_549;
  wire                when_FpUnit_l84_550;
  wire                when_FpUnit_l84_551;
  wire                when_FpUnit_l84_552;
  wire                when_FpUnit_l84_553;
  wire                when_FpUnit_l84_554;
  wire                when_FpUnit_l84_555;
  wire                when_FpUnit_l84_556;
  wire                when_FpUnit_l84_557;
  wire                when_FpUnit_l84_558;
  wire                when_FpUnit_l84_559;
  wire                when_FpUnit_l84_560;
  wire                when_FpUnit_l84_561;
  wire                when_FpUnit_l84_562;
  wire                when_FpUnit_l84_563;
  wire                when_FpUnit_l84_564;
  wire                when_FpUnit_l84_565;
  wire                when_FpUnit_l84_566;
  wire                when_FpUnit_l84_567;
  wire                when_FpUnit_l84_568;
  wire                when_FpUnit_l84_569;
  wire                when_FpUnit_l84_570;
  wire                when_FpUnit_l84_571;
  wire                when_FpUnit_l84_572;
  wire                when_FpUnit_l84_573;
  wire                when_FpUnit_l84_574;
  wire                when_FpUnit_l84_575;
  wire                when_FpUnit_l84_576;
  wire                when_FpUnit_l84_577;
  wire                when_FpUnit_l84_578;
  wire                when_FpUnit_l84_579;
  wire                when_FpUnit_l84_580;
  wire                when_FpUnit_l84_581;
  wire                when_FpUnit_l84_582;
  wire                when_FpUnit_l84_583;
  wire                when_FpUnit_l84_584;
  wire                when_FpUnit_l84_585;
  wire                when_FpUnit_l84_586;
  reg        [26:0]   _zz_flagNX_25;
  reg                 _zz_flagNX_26;
  wire       [11:0]   _zz_when_FpUnit_l116_15;
  wire                when_FpUnit_l90_11;
  wire                when_FpUnit_l91_11;
  wire       [6:0]    _zz_flagNX_27;
  wire                _zz_when_FpUnit_l116_16;
  wire       [11:0]   _zz_when_FpUnit_l116_17;
  wire       [11:0]   _zz_when_FpUnit_l119_11;
  reg        [26:0]   _zz_flagNX_28;
  reg                 _zz_flagNX_29;
  wire                when_FpUnit_l116_11;
  wire                when_FpUnit_l119_11;
  wire       [11:0]   _zz_when_FpUnit_l150_55;
  wire                _zz_flagNX_30;
  wire                _zz_flagNX_31;
  wire                _zz_flagNX_32;
  wire       [23:0]   _zz_when_FpUnit_l150_56;
  wire       [24:0]   _zz_when_FpUnit_l150_57;
  wire                _zz_when_FpUnit_l150_58;
  wire       [23:0]   _zz_res_79;
  wire       [11:0]   _zz_when_FpUnit_l150_59;
  wire                when_FpUnit_l150_11;
  wire       [31:0]   _zz_res_80;
  wire       [31:0]   _zz_res_81;
  reg        [31:0]   _zz_res_82;
  wire                when_FpUnit_l154_11;
  reg        [31:0]   _zz_res_83;
  wire                when_FpUnit_l498_2;
  wire                _zz_res_84;
  wire       [63:0]   _zz_when_FpUnit_l84_173;
  wire       [87:0]   _zz_when_FpUnit_l84_174;
  reg        [6:0]    _zz_when_FpUnit_l91_12;
  wire                when_FpUnit_l84_587;
  wire                when_FpUnit_l84_588;
  wire                when_FpUnit_l84_589;
  wire                when_FpUnit_l84_590;
  wire                when_FpUnit_l84_591;
  wire                when_FpUnit_l84_592;
  wire                when_FpUnit_l84_593;
  wire                when_FpUnit_l84_594;
  wire                when_FpUnit_l84_595;
  wire                when_FpUnit_l84_596;
  wire                when_FpUnit_l84_597;
  wire                when_FpUnit_l84_598;
  wire                when_FpUnit_l84_599;
  wire                when_FpUnit_l84_600;
  wire                when_FpUnit_l84_601;
  wire                when_FpUnit_l84_602;
  wire                when_FpUnit_l84_603;
  wire                when_FpUnit_l84_604;
  wire                when_FpUnit_l84_605;
  wire                when_FpUnit_l84_606;
  wire                when_FpUnit_l84_607;
  wire                when_FpUnit_l84_608;
  wire                when_FpUnit_l84_609;
  wire                when_FpUnit_l84_610;
  wire                when_FpUnit_l84_611;
  wire                when_FpUnit_l84_612;
  wire                when_FpUnit_l84_613;
  wire                when_FpUnit_l84_614;
  wire                when_FpUnit_l84_615;
  wire                when_FpUnit_l84_616;
  wire                when_FpUnit_l84_617;
  wire                when_FpUnit_l84_618;
  wire                when_FpUnit_l84_619;
  wire                when_FpUnit_l84_620;
  wire                when_FpUnit_l84_621;
  wire                when_FpUnit_l84_622;
  wire                when_FpUnit_l84_623;
  wire                when_FpUnit_l84_624;
  wire                when_FpUnit_l84_625;
  wire                when_FpUnit_l84_626;
  wire                when_FpUnit_l84_627;
  wire                when_FpUnit_l84_628;
  wire                when_FpUnit_l84_629;
  wire                when_FpUnit_l84_630;
  wire                when_FpUnit_l84_631;
  wire                when_FpUnit_l84_632;
  wire                when_FpUnit_l84_633;
  wire                when_FpUnit_l84_634;
  wire                when_FpUnit_l84_635;
  wire                when_FpUnit_l84_636;
  wire                when_FpUnit_l84_637;
  wire                when_FpUnit_l84_638;
  wire                when_FpUnit_l84_639;
  wire                when_FpUnit_l84_640;
  wire                when_FpUnit_l84_641;
  wire                when_FpUnit_l84_642;
  wire                when_FpUnit_l84_643;
  wire                when_FpUnit_l84_644;
  wire                when_FpUnit_l84_645;
  wire                when_FpUnit_l84_646;
  wire                when_FpUnit_l84_647;
  wire                when_FpUnit_l84_648;
  wire                when_FpUnit_l84_649;
  wire                when_FpUnit_l84_650;
  wire                when_FpUnit_l84_651;
  wire                when_FpUnit_l84_652;
  wire                when_FpUnit_l84_653;
  wire                when_FpUnit_l84_654;
  wire                when_FpUnit_l84_655;
  wire                when_FpUnit_l84_656;
  wire                when_FpUnit_l84_657;
  wire                when_FpUnit_l84_658;
  wire                when_FpUnit_l84_659;
  wire                when_FpUnit_l84_660;
  wire                when_FpUnit_l84_661;
  wire                when_FpUnit_l84_662;
  wire                when_FpUnit_l84_663;
  wire                when_FpUnit_l84_664;
  wire                when_FpUnit_l84_665;
  wire                when_FpUnit_l84_666;
  wire                when_FpUnit_l84_667;
  wire                when_FpUnit_l84_668;
  wire                when_FpUnit_l84_669;
  wire                when_FpUnit_l84_670;
  wire                when_FpUnit_l84_671;
  wire                when_FpUnit_l84_672;
  wire                when_FpUnit_l84_673;
  wire                when_FpUnit_l84_674;
  reg        [26:0]   _zz_flagNX_33;
  reg                 _zz_flagNX_34;
  wire       [11:0]   _zz_when_FpUnit_l116_18;
  wire                when_FpUnit_l90_12;
  wire                when_FpUnit_l91_12;
  wire       [6:0]    _zz_flagNX_35;
  wire                _zz_when_FpUnit_l116_19;
  wire       [11:0]   _zz_when_FpUnit_l116_20;
  wire       [11:0]   _zz_when_FpUnit_l119_12;
  reg        [26:0]   _zz_flagNX_36;
  reg                 _zz_flagNX_37;
  wire                when_FpUnit_l116_12;
  wire                when_FpUnit_l119_12;
  wire       [11:0]   _zz_when_FpUnit_l150_60;
  wire                _zz_flagNX_38;
  wire                _zz_flagNX_39;
  wire                _zz_flagNX_40;
  wire       [23:0]   _zz_when_FpUnit_l150_61;
  wire       [24:0]   _zz_when_FpUnit_l150_62;
  wire                _zz_when_FpUnit_l150_63;
  wire       [23:0]   _zz_res_85;
  wire       [11:0]   _zz_when_FpUnit_l150_64;
  wire                when_FpUnit_l150_12;
  wire       [31:0]   _zz_res_86;
  wire       [31:0]   _zz_res_87;
  reg        [31:0]   _zz_res_88;
  wire                when_FpUnit_l154_12;
  reg        [31:0]   _zz_res_89;
  wire                when_FpUnit_l498_3;

  assign _zz__zz_when_FpUnit_l180 = ($signed(_zz__zz_when_FpUnit_l180_1) - $signed(10'h07f));
  assign _zz__zz_when_FpUnit_l180_1 = _zz__zz_when_FpUnit_l180_2;
  assign _zz__zz_when_FpUnit_l180_3 = _zz_when_FpUnit_l270;
  assign _zz__zz_when_FpUnit_l180_2 = {2'd0, _zz__zz_when_FpUnit_l180_3};
  assign _zz__zz_flagNX = {1'd0, _zz_when_FpUnit_l270_1};
  assign _zz__zz_when_FpUnit_l180_1_1 = ($signed(_zz__zz_when_FpUnit_l180_1_2) - $signed(10'h07f));
  assign _zz__zz_when_FpUnit_l180_1_2 = _zz__zz_when_FpUnit_l180_1_3;
  assign _zz__zz_when_FpUnit_l180_1_4 = _zz_when_FpUnit_l267;
  assign _zz__zz_when_FpUnit_l180_1_3 = {2'd0, _zz__zz_when_FpUnit_l180_1_4};
  assign _zz__zz_when_FpUnit_l84 = {1'd0, _zz_when_FpUnit_l267_1};
  assign _zz__zz_when_FpUnit_l329_1 = ($signed(_zz__zz_when_FpUnit_l329_1_1) - $signed(10'h07f));
  assign _zz__zz_when_FpUnit_l329_1_1 = _zz__zz_when_FpUnit_l329_1_2;
  assign _zz__zz_when_FpUnit_l329_1_3 = _zz_when_FpUnit_l361;
  assign _zz__zz_when_FpUnit_l329_1_2 = {2'd0, _zz__zz_when_FpUnit_l329_1_3};
  assign _zz__zz_when_FpUnit_l84_1 = {1'd0, _zz_when_FpUnit_l361_1};
  assign _zz_res_90 = 32'h7fc00000;
  assign _zz__zz_when_FpUnit_l84_4 = ({3'd0,_zz__zz_when_FpUnit_l84_4_1} <<< 2'd3);
  assign _zz__zz_when_FpUnit_l84_4_2 = (_zz_when_FpUnit_l180_2 ? _zz_when_FpUnit_l84 : _zz_flagNX);
  assign _zz__zz_when_FpUnit_l84_4_1 = {4'd0, _zz__zz_when_FpUnit_l84_4_2};
  assign _zz__zz_when_FpUnit_l180_4 = ($signed(_zz_when_FpUnit_l180_3) - $signed(_zz__zz_when_FpUnit_l180_4_1));
  assign _zz__zz_when_FpUnit_l180_4_1 = (_zz_when_FpUnit_l180_2 ? _zz_when_FpUnit_l180 : _zz_when_FpUnit_l180_1);
  assign _zz__zz_when_FpUnit_l84_5 = (_zz__zz_when_FpUnit_l84_5_1 >>> _zz_when_FpUnit_l180_4);
  assign _zz__zz_when_FpUnit_l84_5_2 = ({3'd0,_zz__zz_when_FpUnit_l84_5_3} <<< 2'd3);
  assign _zz__zz_when_FpUnit_l84_5_1 = _zz__zz_when_FpUnit_l84_5_2[27:0];
  assign _zz__zz_when_FpUnit_l84_5_4 = (_zz_when_FpUnit_l180_2 ? _zz_flagNX : _zz_when_FpUnit_l84);
  assign _zz__zz_when_FpUnit_l84_5_3 = {4'd0, _zz__zz_when_FpUnit_l84_5_4};
  assign _zz__zz_when_FpUnit_l84_9 = (_zz_when_FpUnit_l84_7 - _zz_when_FpUnit_l84_4);
  assign _zz__zz_when_FpUnit_l84_9_1 = (_zz_when_FpUnit_l84_4 - _zz_when_FpUnit_l84_7);
  assign _zz__zz_when_FpUnit_l84_9_2 = (_zz_when_FpUnit_l84_4 + _zz_when_FpUnit_l84_7);
  assign _zz__zz_flagUF_2 = _zz__zz_flagUF_2_1;
  assign _zz__zz_flagUF_2_1 = {7'd0, _zz_when_FpUnit_l91};
  assign _zz__zz_flagUF_2_2 = ($signed(_zz__zz_flagUF_2_3) - $signed(12'h01a));
  assign _zz__zz_flagUF_2_3 = {{2{_zz_when_FpUnit_l180_3[9]}}, _zz_when_FpUnit_l180_3};
  assign _zz__zz_flagUF_1 = (_zz_when_FpUnit_l84_9 >>> _zz_flagUF_3);
  assign _zz__zz_flagUF = _zz__zz_flagUF_1[26:0];
  assign _zz__zz_flagUF_1_1 = (_zz__zz_flagUF_1_2 - 28'h0000001);
  assign _zz__zz_flagUF_1_3 = ({31'd0,28'h0000001} <<< _zz_flagUF_3);
  assign _zz__zz_flagUF_1_2 = _zz__zz_flagUF_1_3[27:0];
  assign _zz__zz_flagUF_4 = ({31'd0,_zz_when_FpUnit_l84_9} <<< _zz__zz_flagUF_5);
  assign _zz__zz_flagUF_3 = _zz__zz_flagUF_4[26:0];
  assign _zz__zz_flagUF_5 = (5'h1a - _zz_when_FpUnit_l91);
  assign _zz__zz_flagUF_4_1 = ($signed(_zz_flagUF_2) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l116 = ($signed(12'hf82) - $signed(_zz_flagUF_2));
  assign _zz__zz_flagUF_5_1 = (_zz_flagUF >>> _zz_when_FpUnit_l119);
  assign _zz__zz_flagUF_6 = (_zz__zz_flagUF_6_1 - 27'h0000001);
  assign _zz__zz_flagUF_6_2 = ({31'd0,27'h0000001} <<< _zz__zz_flagUF_6_3);
  assign _zz__zz_flagUF_6_1 = _zz__zz_flagUF_6_2[26:0];
  assign _zz__zz_flagUF_6_3 = _zz_when_FpUnit_l119[4:0];
  assign _zz__zz_when_FpUnit_l150_2_1 = _zz_when_FpUnit_l150_1;
  assign _zz__zz_when_FpUnit_l150_2 = {1'd0, _zz__zz_when_FpUnit_l150_2_1};
  assign _zz__zz_when_FpUnit_l150_2_3 = ((io_rm == 3'b000) ? (_zz_flagUF_7 && ((_zz_flagUF_8 || _zz_flagUF_9) || _zz_when_FpUnit_l150_1[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_res_1 && (_zz__zz_when_FpUnit_l150_2_4 || _zz_flagUF_9)) : ((io_rm == _zz__zz_when_FpUnit_l150_2_5) ? (_zz__zz_when_FpUnit_l150_2_6 && _zz__zz_when_FpUnit_l150_2_7) : _zz_flagUF_7))));
  assign _zz__zz_when_FpUnit_l150_2_2 = {24'd0, _zz__zz_when_FpUnit_l150_2_3};
  assign _zz__zz_res_2 = (_zz_when_FpUnit_l150_2 >>> 1'd1);
  assign _zz__zz_res_2_1 = _zz_when_FpUnit_l150_2[23:0];
  assign _zz__zz_when_FpUnit_l150_4 = (_zz_when_FpUnit_l150_3 ? _zz__zz_when_FpUnit_l150_4_1 : _zz_when_FpUnit_l150);
  assign _zz__zz_when_FpUnit_l150_4_1 = ($signed(_zz_when_FpUnit_l150) + $signed(12'h001));
  assign _zz__zz_res_5_1 = _zz_when_FpUnit_l150_4;
  assign _zz__zz_res_5 = _zz__zz_res_5_1[7:0];
  assign _zz__zz_when_FpUnit_l84_12 = ({3'd0,_zz__zz_when_FpUnit_l84_12_1} <<< 2'd3);
  assign _zz__zz_when_FpUnit_l84_12_2 = (_zz_when_FpUnit_l180_5 ? _zz_when_FpUnit_l84 : _zz_flagNX);
  assign _zz__zz_when_FpUnit_l84_12_1 = {4'd0, _zz__zz_when_FpUnit_l84_12_2};
  assign _zz__zz_when_FpUnit_l180_7 = ($signed(_zz_when_FpUnit_l180_6) - $signed(_zz__zz_when_FpUnit_l180_7_1));
  assign _zz__zz_when_FpUnit_l180_7_1 = (_zz_when_FpUnit_l180_5 ? _zz_when_FpUnit_l180 : _zz_when_FpUnit_l180_1);
  assign _zz__zz_when_FpUnit_l84_13 = (_zz__zz_when_FpUnit_l84_13_1 >>> _zz_when_FpUnit_l180_7);
  assign _zz__zz_when_FpUnit_l84_13_2 = ({3'd0,_zz__zz_when_FpUnit_l84_13_3} <<< 2'd3);
  assign _zz__zz_when_FpUnit_l84_13_1 = _zz__zz_when_FpUnit_l84_13_2[27:0];
  assign _zz__zz_when_FpUnit_l84_13_4 = (_zz_when_FpUnit_l180_5 ? _zz_flagNX : _zz_when_FpUnit_l84);
  assign _zz__zz_when_FpUnit_l84_13_3 = {4'd0, _zz__zz_when_FpUnit_l84_13_4};
  assign _zz__zz_when_FpUnit_l84_17 = (_zz_when_FpUnit_l84_15 - _zz_when_FpUnit_l84_12);
  assign _zz__zz_when_FpUnit_l84_17_1 = (_zz_when_FpUnit_l84_12 - _zz_when_FpUnit_l84_15);
  assign _zz__zz_when_FpUnit_l84_17_2 = (_zz_when_FpUnit_l84_12 + _zz_when_FpUnit_l84_15);
  assign _zz__zz_flagUF_13 = _zz__zz_flagUF_13_1;
  assign _zz__zz_flagUF_13_1 = {7'd0, _zz_when_FpUnit_l91_1};
  assign _zz__zz_flagUF_13_2 = ($signed(_zz__zz_flagUF_13_3) - $signed(12'h01a));
  assign _zz__zz_flagUF_13_3 = {{2{_zz_when_FpUnit_l180_6[9]}}, _zz_when_FpUnit_l180_6};
  assign _zz__zz_flagUF_11_1 = (_zz_when_FpUnit_l84_17 >>> _zz_flagUF_14);
  assign _zz__zz_flagUF_11 = _zz__zz_flagUF_11_1[26:0];
  assign _zz__zz_flagUF_12 = (_zz__zz_flagUF_12_1 - 28'h0000001);
  assign _zz__zz_flagUF_12_2 = ({31'd0,28'h0000001} <<< _zz_flagUF_14);
  assign _zz__zz_flagUF_12_1 = _zz__zz_flagUF_12_2[27:0];
  assign _zz__zz_flagUF_11_3 = ({31'd0,_zz_when_FpUnit_l84_17} <<< _zz__zz_flagUF_11_4);
  assign _zz__zz_flagUF_11_2 = _zz__zz_flagUF_11_3[26:0];
  assign _zz__zz_flagUF_11_4 = (5'h1a - _zz_when_FpUnit_l91_1);
  assign _zz__zz_flagUF_15 = ($signed(_zz_flagUF_13) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l116_1 = ($signed(12'hf82) - $signed(_zz_flagUF_13));
  assign _zz__zz_flagUF_16 = (_zz_flagUF_11 >>> _zz_when_FpUnit_l119_1);
  assign _zz__zz_flagUF_17 = (_zz__zz_flagUF_17_1 - 27'h0000001);
  assign _zz__zz_flagUF_17_2 = ({31'd0,27'h0000001} <<< _zz__zz_flagUF_17_3);
  assign _zz__zz_flagUF_17_1 = _zz__zz_flagUF_17_2[26:0];
  assign _zz__zz_flagUF_17_3 = _zz_when_FpUnit_l119_1[4:0];
  assign _zz__zz_when_FpUnit_l150_7_1 = _zz_when_FpUnit_l150_6;
  assign _zz__zz_when_FpUnit_l150_7 = {1'd0, _zz__zz_when_FpUnit_l150_7_1};
  assign _zz__zz_when_FpUnit_l150_7_3 = ((io_rm == 3'b000) ? (_zz_flagUF_18 && ((_zz_flagUF_19 || _zz_flagUF_20) || _zz_when_FpUnit_l150_6[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_res_7 && (_zz__zz_when_FpUnit_l150_7_4 || _zz_flagUF_20)) : ((io_rm == _zz__zz_when_FpUnit_l150_7_5) ? (_zz__zz_when_FpUnit_l150_7_6 && _zz__zz_when_FpUnit_l150_7_7) : _zz_flagUF_18))));
  assign _zz__zz_when_FpUnit_l150_7_2 = {24'd0, _zz__zz_when_FpUnit_l150_7_3};
  assign _zz__zz_res_8 = (_zz_when_FpUnit_l150_7 >>> 1'd1);
  assign _zz__zz_res_8_1 = _zz_when_FpUnit_l150_7[23:0];
  assign _zz__zz_when_FpUnit_l150_9 = (_zz_when_FpUnit_l150_8 ? _zz__zz_when_FpUnit_l150_9_1 : _zz_when_FpUnit_l150_5);
  assign _zz__zz_when_FpUnit_l150_9_1 = ($signed(_zz_when_FpUnit_l150_5) + $signed(12'h001));
  assign _zz__zz_res_11_1 = _zz_when_FpUnit_l150_9;
  assign _zz__zz_res_11 = _zz__zz_res_11_1[7:0];
  assign _zz__zz_flagUF_24 = _zz__zz_flagUF_24_1;
  assign _zz__zz_flagUF_24_1 = {6'd0, _zz_when_FpUnit_l91_2};
  assign _zz__zz_flagUF_24_2 = ($signed(_zz__zz_flagUF_24_3) - $signed(12'h02e));
  assign _zz__zz_flagUF_24_4 = ($signed(_zz_when_FpUnit_l180) + $signed(_zz_when_FpUnit_l180_1));
  assign _zz__zz_flagUF_24_3 = {{2{_zz__zz_flagUF_24_4[9]}}, _zz__zz_flagUF_24_4};
  assign _zz__zz_flagUF_22_1 = (_zz_when_FpUnit_l84_18 >>> _zz_flagUF_25);
  assign _zz__zz_flagUF_22 = _zz__zz_flagUF_22_1[26:0];
  assign _zz__zz_flagUF_23 = (_zz__zz_flagUF_23_1 - 48'h000000000001);
  assign _zz__zz_flagUF_23_2 = ({63'd0,48'h000000000001} <<< _zz_flagUF_25);
  assign _zz__zz_flagUF_23_1 = _zz__zz_flagUF_23_2[47:0];
  assign _zz__zz_flagUF_22_3 = ({63'd0,_zz_when_FpUnit_l84_18} <<< _zz__zz_flagUF_22_4);
  assign _zz__zz_flagUF_22_2 = _zz__zz_flagUF_22_3[26:0];
  assign _zz__zz_flagUF_22_4 = (6'h1a - _zz_when_FpUnit_l91_2);
  assign _zz__zz_flagUF_26 = ($signed(_zz_flagUF_24) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l116_2 = ($signed(12'hf82) - $signed(_zz_flagUF_24));
  assign _zz__zz_flagUF_27 = (_zz_flagUF_22 >>> _zz_when_FpUnit_l119_2);
  assign _zz__zz_flagUF_28 = (_zz__zz_flagUF_28_1 - 27'h0000001);
  assign _zz__zz_flagUF_28_2 = ({31'd0,27'h0000001} <<< _zz__zz_flagUF_28_3);
  assign _zz__zz_flagUF_28_1 = _zz__zz_flagUF_28_2[26:0];
  assign _zz__zz_flagUF_28_3 = _zz_when_FpUnit_l119_2[4:0];
  assign _zz__zz_when_FpUnit_l150_12_1 = _zz_when_FpUnit_l150_11;
  assign _zz__zz_when_FpUnit_l150_12 = {1'd0, _zz__zz_when_FpUnit_l150_12_1};
  assign _zz__zz_when_FpUnit_l150_12_3 = ((io_rm == 3'b000) ? (_zz_flagUF_29 && ((_zz_flagUF_30 || _zz_flagUF_31) || _zz_when_FpUnit_l150_11[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_res_13 && (_zz__zz_when_FpUnit_l150_12_4 || _zz_flagUF_31)) : ((io_rm == _zz__zz_when_FpUnit_l150_12_5) ? (_zz__zz_when_FpUnit_l150_12_6 && _zz__zz_when_FpUnit_l150_12_7) : _zz_flagUF_29))));
  assign _zz__zz_when_FpUnit_l150_12_2 = {24'd0, _zz__zz_when_FpUnit_l150_12_3};
  assign _zz__zz_res_14 = (_zz_when_FpUnit_l150_12 >>> 1'd1);
  assign _zz__zz_res_14_1 = _zz_when_FpUnit_l150_12[23:0];
  assign _zz__zz_when_FpUnit_l150_14 = (_zz_when_FpUnit_l150_13 ? _zz__zz_when_FpUnit_l150_14_1 : _zz_when_FpUnit_l150_10);
  assign _zz__zz_when_FpUnit_l150_14_1 = ($signed(_zz_when_FpUnit_l150_10) + $signed(12'h001));
  assign _zz__zz_res_17_1 = _zz_when_FpUnit_l150_14;
  assign _zz__zz_res_17 = _zz__zz_res_17_1[7:0];
  assign _zz__zz_when_FpUnit_l84_19 = {29'd0, _zz_flagNX};
  assign _zz__zz_when_FpUnit_l84_20 = (_zz_when_FpUnit_l84_19 / _zz__zz_when_FpUnit_l84_20_1);
  assign _zz__zz_when_FpUnit_l84_20_1 = {29'd0, _zz_when_FpUnit_l84};
  assign _zz__zz_flagUF_35 = _zz__zz_flagUF_35_1;
  assign _zz__zz_flagUF_35_1 = {7'd0, _zz_when_FpUnit_l91_3};
  assign _zz__zz_flagUF_35_2 = ($signed(_zz__zz_flagUF_35_3) - $signed(12'h01b));
  assign _zz__zz_flagUF_35_4 = ($signed(_zz_when_FpUnit_l180) - $signed(_zz_when_FpUnit_l180_1));
  assign _zz__zz_flagUF_35_3 = {{2{_zz__zz_flagUF_35_4[9]}}, _zz__zz_flagUF_35_4};
  assign _zz__zz_flagUF_33_1 = (_zz_when_FpUnit_l84_20 >>> _zz_flagUF_36);
  assign _zz__zz_flagUF_33 = _zz__zz_flagUF_33_1[26:0];
  assign _zz__zz_flagUF_34 = (_zz__zz_flagUF_34_1 - 29'h00000001);
  assign _zz__zz_flagUF_34_2 = ({31'd0,29'h00000001} <<< _zz_flagUF_36);
  assign _zz__zz_flagUF_34_1 = _zz__zz_flagUF_34_2[28:0];
  assign _zz__zz_flagUF_33_3 = ({31'd0,_zz_when_FpUnit_l84_20} <<< _zz__zz_flagUF_33_4);
  assign _zz__zz_flagUF_33_2 = _zz__zz_flagUF_33_3[26:0];
  assign _zz__zz_flagUF_33_4 = (5'h1a - _zz_when_FpUnit_l91_3);
  assign _zz__zz_flagUF_37 = (_zz__zz_flagUF_37_1 - _zz__zz_flagUF_37_2);
  assign _zz__zz_flagUF_37_1 = {26'd0, _zz_when_FpUnit_l84_19};
  assign _zz__zz_flagUF_37_2 = (_zz__zz_flagUF_37_3 * _zz__zz_flagUF_37_4);
  assign _zz__zz_flagUF_37_3 = {24'd0, _zz_when_FpUnit_l84_20};
  assign _zz__zz_flagUF_37_4 = {29'd0, _zz_when_FpUnit_l84};
  assign _zz__zz_flagUF_38 = ($signed(_zz_flagUF_35) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l116_3 = ($signed(12'hf82) - $signed(_zz_flagUF_35));
  assign _zz__zz_flagUF_39 = (_zz_flagUF_33 >>> _zz_when_FpUnit_l119_3);
  assign _zz__zz_flagUF_40 = (_zz__zz_flagUF_40_1 - 27'h0000001);
  assign _zz__zz_flagUF_40_2 = ({31'd0,27'h0000001} <<< _zz__zz_flagUF_40_3);
  assign _zz__zz_flagUF_40_1 = _zz__zz_flagUF_40_2[26:0];
  assign _zz__zz_flagUF_40_3 = _zz_when_FpUnit_l119_3[4:0];
  assign _zz__zz_when_FpUnit_l150_17_1 = _zz_when_FpUnit_l150_16;
  assign _zz__zz_when_FpUnit_l150_17 = {1'd0, _zz__zz_when_FpUnit_l150_17_1};
  assign _zz__zz_when_FpUnit_l150_17_3 = ((io_rm == 3'b000) ? (_zz_flagUF_41 && ((_zz_flagUF_42 || _zz_flagUF_43) || _zz_when_FpUnit_l150_16[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_res_19 && (_zz__zz_when_FpUnit_l150_17_4 || _zz_flagUF_43)) : ((io_rm == _zz__zz_when_FpUnit_l150_17_5) ? (_zz__zz_when_FpUnit_l150_17_6 && _zz__zz_when_FpUnit_l150_17_7) : _zz_flagUF_41))));
  assign _zz__zz_when_FpUnit_l150_17_2 = {24'd0, _zz__zz_when_FpUnit_l150_17_3};
  assign _zz__zz_res_20 = (_zz_when_FpUnit_l150_17 >>> 1'd1);
  assign _zz__zz_res_20_1 = _zz_when_FpUnit_l150_17[23:0];
  assign _zz__zz_when_FpUnit_l150_19 = (_zz_when_FpUnit_l150_18 ? _zz__zz_when_FpUnit_l150_19_1 : _zz_when_FpUnit_l150_15);
  assign _zz__zz_when_FpUnit_l150_19_1 = ($signed(_zz_when_FpUnit_l150_15) + $signed(12'h001));
  assign _zz__zz_res_23_1 = _zz_when_FpUnit_l150_19;
  assign _zz__zz_res_23 = _zz__zz_res_23_1[7:0];
  assign _zz__zz_when_FpUnit_l84_21 = ({29'd0,_zz__zz_when_FpUnit_l84_21_1} <<< 5'd29);
  assign _zz__zz_when_FpUnit_l84_21_2 = (_zz_flagUF_45 ? _zz__zz_when_FpUnit_l84_21_3 : _zz__zz_when_FpUnit_l84_21_4);
  assign _zz__zz_when_FpUnit_l84_21_1 = {31'd0, _zz__zz_when_FpUnit_l84_21_2};
  assign _zz__zz_when_FpUnit_l84_21_3 = ({1'd0,_zz_flagNX} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_21_4 = {1'd0, _zz_flagNX};
  assign _zz__zz_when_FpUnit_l84_23_1 = ({2'd0,58'h0} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_23 = _zz__zz_when_FpUnit_l84_23_1[57:0];
  assign _zz__zz_when_FpUnit_l84_23_3 = _zz_when_FpUnit_l84_21[55 : 54];
  assign _zz__zz_when_FpUnit_l84_23_2 = {56'd0, _zz__zz_when_FpUnit_l84_23_3};
  assign _zz__zz_when_FpUnit_l84_24_1 = ({2'd0,_zz_when_FpUnit_l84_22} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_24 = {26'd0, _zz__zz_when_FpUnit_l84_24_1};
  assign _zz__zz_when_FpUnit_l84_26_1 = ({1'd0,_zz_when_FpUnit_l84_22} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_26 = _zz__zz_when_FpUnit_l84_26_1[29:0];
  assign _zz__zz_when_FpUnit_l84_26_3 = ({1'd0,_zz_when_FpUnit_l84_22} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_26_2 = _zz__zz_when_FpUnit_l84_26_3[29:0];
  assign _zz__zz_when_FpUnit_l84_27_1 = ({2'd0,(_zz_when_FpUnit_l84_25 ? _zz__zz_when_FpUnit_l84_27_2 : _zz_when_FpUnit_l84_23)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_27 = _zz__zz_when_FpUnit_l84_27_1[57:0];
  assign _zz__zz_when_FpUnit_l84_27_2 = (_zz_when_FpUnit_l84_23 - _zz_when_FpUnit_l84_24);
  assign _zz__zz_when_FpUnit_l84_27_4 = _zz_when_FpUnit_l84_21[53 : 52];
  assign _zz__zz_when_FpUnit_l84_27_3 = {56'd0, _zz__zz_when_FpUnit_l84_27_4};
  assign _zz__zz_when_FpUnit_l84_28_1 = ({2'd0,_zz_when_FpUnit_l84_26} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_28 = {26'd0, _zz__zz_when_FpUnit_l84_28_1};
  assign _zz__zz_when_FpUnit_l84_30_1 = ({1'd0,_zz_when_FpUnit_l84_26} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_30 = _zz__zz_when_FpUnit_l84_30_1[29:0];
  assign _zz__zz_when_FpUnit_l84_30_3 = ({1'd0,_zz_when_FpUnit_l84_26} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_30_2 = _zz__zz_when_FpUnit_l84_30_3[29:0];
  assign _zz__zz_when_FpUnit_l84_31_1 = ({2'd0,(_zz_when_FpUnit_l84_29 ? _zz__zz_when_FpUnit_l84_31_2 : _zz_when_FpUnit_l84_27)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_31 = _zz__zz_when_FpUnit_l84_31_1[57:0];
  assign _zz__zz_when_FpUnit_l84_31_2 = (_zz_when_FpUnit_l84_27 - _zz_when_FpUnit_l84_28);
  assign _zz__zz_when_FpUnit_l84_31_4 = _zz_when_FpUnit_l84_21[51 : 50];
  assign _zz__zz_when_FpUnit_l84_31_3 = {56'd0, _zz__zz_when_FpUnit_l84_31_4};
  assign _zz__zz_when_FpUnit_l84_32_1 = ({2'd0,_zz_when_FpUnit_l84_30} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_32 = {26'd0, _zz__zz_when_FpUnit_l84_32_1};
  assign _zz__zz_when_FpUnit_l84_34_1 = ({1'd0,_zz_when_FpUnit_l84_30} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_34 = _zz__zz_when_FpUnit_l84_34_1[29:0];
  assign _zz__zz_when_FpUnit_l84_34_3 = ({1'd0,_zz_when_FpUnit_l84_30} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_34_2 = _zz__zz_when_FpUnit_l84_34_3[29:0];
  assign _zz__zz_when_FpUnit_l84_35_1 = ({2'd0,(_zz_when_FpUnit_l84_33 ? _zz__zz_when_FpUnit_l84_35_2 : _zz_when_FpUnit_l84_31)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_35 = _zz__zz_when_FpUnit_l84_35_1[57:0];
  assign _zz__zz_when_FpUnit_l84_35_2 = (_zz_when_FpUnit_l84_31 - _zz_when_FpUnit_l84_32);
  assign _zz__zz_when_FpUnit_l84_35_4 = _zz_when_FpUnit_l84_21[49 : 48];
  assign _zz__zz_when_FpUnit_l84_35_3 = {56'd0, _zz__zz_when_FpUnit_l84_35_4};
  assign _zz__zz_when_FpUnit_l84_36_1 = ({2'd0,_zz_when_FpUnit_l84_34} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_36 = {26'd0, _zz__zz_when_FpUnit_l84_36_1};
  assign _zz__zz_when_FpUnit_l84_38_1 = ({1'd0,_zz_when_FpUnit_l84_34} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_38 = _zz__zz_when_FpUnit_l84_38_1[29:0];
  assign _zz__zz_when_FpUnit_l84_38_3 = ({1'd0,_zz_when_FpUnit_l84_34} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_38_2 = _zz__zz_when_FpUnit_l84_38_3[29:0];
  assign _zz__zz_when_FpUnit_l84_39_1 = ({2'd0,(_zz_when_FpUnit_l84_37 ? _zz__zz_when_FpUnit_l84_39_2 : _zz_when_FpUnit_l84_35)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_39 = _zz__zz_when_FpUnit_l84_39_1[57:0];
  assign _zz__zz_when_FpUnit_l84_39_2 = (_zz_when_FpUnit_l84_35 - _zz_when_FpUnit_l84_36);
  assign _zz__zz_when_FpUnit_l84_39_4 = _zz_when_FpUnit_l84_21[47 : 46];
  assign _zz__zz_when_FpUnit_l84_39_3 = {56'd0, _zz__zz_when_FpUnit_l84_39_4};
  assign _zz__zz_when_FpUnit_l84_40_1 = ({2'd0,_zz_when_FpUnit_l84_38} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_40 = {26'd0, _zz__zz_when_FpUnit_l84_40_1};
  assign _zz__zz_when_FpUnit_l84_42_1 = ({1'd0,_zz_when_FpUnit_l84_38} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_42 = _zz__zz_when_FpUnit_l84_42_1[29:0];
  assign _zz__zz_when_FpUnit_l84_42_3 = ({1'd0,_zz_when_FpUnit_l84_38} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_42_2 = _zz__zz_when_FpUnit_l84_42_3[29:0];
  assign _zz__zz_when_FpUnit_l84_43_1 = ({2'd0,(_zz_when_FpUnit_l84_41 ? _zz__zz_when_FpUnit_l84_43_2 : _zz_when_FpUnit_l84_39)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_43 = _zz__zz_when_FpUnit_l84_43_1[57:0];
  assign _zz__zz_when_FpUnit_l84_43_2 = (_zz_when_FpUnit_l84_39 - _zz_when_FpUnit_l84_40);
  assign _zz__zz_when_FpUnit_l84_43_4 = _zz_when_FpUnit_l84_21[45 : 44];
  assign _zz__zz_when_FpUnit_l84_43_3 = {56'd0, _zz__zz_when_FpUnit_l84_43_4};
  assign _zz__zz_when_FpUnit_l84_44_1 = ({2'd0,_zz_when_FpUnit_l84_42} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_44 = {26'd0, _zz__zz_when_FpUnit_l84_44_1};
  assign _zz__zz_when_FpUnit_l84_46_1 = ({1'd0,_zz_when_FpUnit_l84_42} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_46 = _zz__zz_when_FpUnit_l84_46_1[29:0];
  assign _zz__zz_when_FpUnit_l84_46_3 = ({1'd0,_zz_when_FpUnit_l84_42} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_46_2 = _zz__zz_when_FpUnit_l84_46_3[29:0];
  assign _zz__zz_when_FpUnit_l84_47_1 = ({2'd0,(_zz_when_FpUnit_l84_45 ? _zz__zz_when_FpUnit_l84_47_2 : _zz_when_FpUnit_l84_43)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_47 = _zz__zz_when_FpUnit_l84_47_1[57:0];
  assign _zz__zz_when_FpUnit_l84_47_2 = (_zz_when_FpUnit_l84_43 - _zz_when_FpUnit_l84_44);
  assign _zz__zz_when_FpUnit_l84_47_4 = _zz_when_FpUnit_l84_21[43 : 42];
  assign _zz__zz_when_FpUnit_l84_47_3 = {56'd0, _zz__zz_when_FpUnit_l84_47_4};
  assign _zz__zz_when_FpUnit_l84_48_1 = ({2'd0,_zz_when_FpUnit_l84_46} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_48 = {26'd0, _zz__zz_when_FpUnit_l84_48_1};
  assign _zz__zz_when_FpUnit_l84_50_1 = ({1'd0,_zz_when_FpUnit_l84_46} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_50 = _zz__zz_when_FpUnit_l84_50_1[29:0];
  assign _zz__zz_when_FpUnit_l84_50_3 = ({1'd0,_zz_when_FpUnit_l84_46} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_50_2 = _zz__zz_when_FpUnit_l84_50_3[29:0];
  assign _zz__zz_when_FpUnit_l84_51_1 = ({2'd0,(_zz_when_FpUnit_l84_49 ? _zz__zz_when_FpUnit_l84_51_2 : _zz_when_FpUnit_l84_47)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_51 = _zz__zz_when_FpUnit_l84_51_1[57:0];
  assign _zz__zz_when_FpUnit_l84_51_2 = (_zz_when_FpUnit_l84_47 - _zz_when_FpUnit_l84_48);
  assign _zz__zz_when_FpUnit_l84_51_4 = _zz_when_FpUnit_l84_21[41 : 40];
  assign _zz__zz_when_FpUnit_l84_51_3 = {56'd0, _zz__zz_when_FpUnit_l84_51_4};
  assign _zz__zz_when_FpUnit_l84_52_1 = ({2'd0,_zz_when_FpUnit_l84_50} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_52 = {26'd0, _zz__zz_when_FpUnit_l84_52_1};
  assign _zz__zz_when_FpUnit_l84_54_1 = ({1'd0,_zz_when_FpUnit_l84_50} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_54 = _zz__zz_when_FpUnit_l84_54_1[29:0];
  assign _zz__zz_when_FpUnit_l84_54_3 = ({1'd0,_zz_when_FpUnit_l84_50} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_54_2 = _zz__zz_when_FpUnit_l84_54_3[29:0];
  assign _zz__zz_when_FpUnit_l84_55_1 = ({2'd0,(_zz_when_FpUnit_l84_53 ? _zz__zz_when_FpUnit_l84_55_2 : _zz_when_FpUnit_l84_51)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_55 = _zz__zz_when_FpUnit_l84_55_1[57:0];
  assign _zz__zz_when_FpUnit_l84_55_2 = (_zz_when_FpUnit_l84_51 - _zz_when_FpUnit_l84_52);
  assign _zz__zz_when_FpUnit_l84_55_4 = _zz_when_FpUnit_l84_21[39 : 38];
  assign _zz__zz_when_FpUnit_l84_55_3 = {56'd0, _zz__zz_when_FpUnit_l84_55_4};
  assign _zz__zz_when_FpUnit_l84_56_1 = ({2'd0,_zz_when_FpUnit_l84_54} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_56 = {26'd0, _zz__zz_when_FpUnit_l84_56_1};
  assign _zz__zz_when_FpUnit_l84_58_1 = ({1'd0,_zz_when_FpUnit_l84_54} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_58 = _zz__zz_when_FpUnit_l84_58_1[29:0];
  assign _zz__zz_when_FpUnit_l84_58_3 = ({1'd0,_zz_when_FpUnit_l84_54} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_58_2 = _zz__zz_when_FpUnit_l84_58_3[29:0];
  assign _zz__zz_when_FpUnit_l84_59_1 = ({2'd0,(_zz_when_FpUnit_l84_57 ? _zz__zz_when_FpUnit_l84_59_2 : _zz_when_FpUnit_l84_55)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_59 = _zz__zz_when_FpUnit_l84_59_1[57:0];
  assign _zz__zz_when_FpUnit_l84_59_2 = (_zz_when_FpUnit_l84_55 - _zz_when_FpUnit_l84_56);
  assign _zz__zz_when_FpUnit_l84_59_4 = _zz_when_FpUnit_l84_21[37 : 36];
  assign _zz__zz_when_FpUnit_l84_59_3 = {56'd0, _zz__zz_when_FpUnit_l84_59_4};
  assign _zz__zz_when_FpUnit_l84_60_1 = ({2'd0,_zz_when_FpUnit_l84_58} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_60 = {26'd0, _zz__zz_when_FpUnit_l84_60_1};
  assign _zz__zz_when_FpUnit_l84_62_1 = ({1'd0,_zz_when_FpUnit_l84_58} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_62 = _zz__zz_when_FpUnit_l84_62_1[29:0];
  assign _zz__zz_when_FpUnit_l84_62_3 = ({1'd0,_zz_when_FpUnit_l84_58} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_62_2 = _zz__zz_when_FpUnit_l84_62_3[29:0];
  assign _zz__zz_when_FpUnit_l84_63_1 = ({2'd0,(_zz_when_FpUnit_l84_61 ? _zz__zz_when_FpUnit_l84_63_2 : _zz_when_FpUnit_l84_59)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_63 = _zz__zz_when_FpUnit_l84_63_1[57:0];
  assign _zz__zz_when_FpUnit_l84_63_2 = (_zz_when_FpUnit_l84_59 - _zz_when_FpUnit_l84_60);
  assign _zz__zz_when_FpUnit_l84_63_4 = _zz_when_FpUnit_l84_21[35 : 34];
  assign _zz__zz_when_FpUnit_l84_63_3 = {56'd0, _zz__zz_when_FpUnit_l84_63_4};
  assign _zz__zz_when_FpUnit_l84_64_1 = ({2'd0,_zz_when_FpUnit_l84_62} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_64 = {26'd0, _zz__zz_when_FpUnit_l84_64_1};
  assign _zz__zz_when_FpUnit_l84_66_1 = ({1'd0,_zz_when_FpUnit_l84_62} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_66 = _zz__zz_when_FpUnit_l84_66_1[29:0];
  assign _zz__zz_when_FpUnit_l84_66_3 = ({1'd0,_zz_when_FpUnit_l84_62} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_66_2 = _zz__zz_when_FpUnit_l84_66_3[29:0];
  assign _zz__zz_when_FpUnit_l84_67_1 = ({2'd0,(_zz_when_FpUnit_l84_65 ? _zz__zz_when_FpUnit_l84_67_2 : _zz_when_FpUnit_l84_63)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_67 = _zz__zz_when_FpUnit_l84_67_1[57:0];
  assign _zz__zz_when_FpUnit_l84_67_2 = (_zz_when_FpUnit_l84_63 - _zz_when_FpUnit_l84_64);
  assign _zz__zz_when_FpUnit_l84_67_4 = _zz_when_FpUnit_l84_21[33 : 32];
  assign _zz__zz_when_FpUnit_l84_67_3 = {56'd0, _zz__zz_when_FpUnit_l84_67_4};
  assign _zz__zz_when_FpUnit_l84_68_1 = ({2'd0,_zz_when_FpUnit_l84_66} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_68 = {26'd0, _zz__zz_when_FpUnit_l84_68_1};
  assign _zz__zz_when_FpUnit_l84_70_1 = ({1'd0,_zz_when_FpUnit_l84_66} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_70 = _zz__zz_when_FpUnit_l84_70_1[29:0];
  assign _zz__zz_when_FpUnit_l84_70_3 = ({1'd0,_zz_when_FpUnit_l84_66} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_70_2 = _zz__zz_when_FpUnit_l84_70_3[29:0];
  assign _zz__zz_when_FpUnit_l84_71_1 = ({2'd0,(_zz_when_FpUnit_l84_69 ? _zz__zz_when_FpUnit_l84_71_2 : _zz_when_FpUnit_l84_67)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_71 = _zz__zz_when_FpUnit_l84_71_1[57:0];
  assign _zz__zz_when_FpUnit_l84_71_2 = (_zz_when_FpUnit_l84_67 - _zz_when_FpUnit_l84_68);
  assign _zz__zz_when_FpUnit_l84_71_4 = _zz_when_FpUnit_l84_21[31 : 30];
  assign _zz__zz_when_FpUnit_l84_71_3 = {56'd0, _zz__zz_when_FpUnit_l84_71_4};
  assign _zz__zz_when_FpUnit_l84_72_1 = ({2'd0,_zz_when_FpUnit_l84_70} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_72 = {26'd0, _zz__zz_when_FpUnit_l84_72_1};
  assign _zz__zz_when_FpUnit_l84_74_1 = ({1'd0,_zz_when_FpUnit_l84_70} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_74 = _zz__zz_when_FpUnit_l84_74_1[29:0];
  assign _zz__zz_when_FpUnit_l84_74_3 = ({1'd0,_zz_when_FpUnit_l84_70} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_74_2 = _zz__zz_when_FpUnit_l84_74_3[29:0];
  assign _zz__zz_when_FpUnit_l84_75_1 = ({2'd0,(_zz_when_FpUnit_l84_73 ? _zz__zz_when_FpUnit_l84_75_2 : _zz_when_FpUnit_l84_71)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_75 = _zz__zz_when_FpUnit_l84_75_1[57:0];
  assign _zz__zz_when_FpUnit_l84_75_2 = (_zz_when_FpUnit_l84_71 - _zz_when_FpUnit_l84_72);
  assign _zz__zz_when_FpUnit_l84_75_4 = _zz_when_FpUnit_l84_21[29 : 28];
  assign _zz__zz_when_FpUnit_l84_75_3 = {56'd0, _zz__zz_when_FpUnit_l84_75_4};
  assign _zz__zz_when_FpUnit_l84_76_1 = ({2'd0,_zz_when_FpUnit_l84_74} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_76 = {26'd0, _zz__zz_when_FpUnit_l84_76_1};
  assign _zz__zz_when_FpUnit_l84_78_1 = ({1'd0,_zz_when_FpUnit_l84_74} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_78 = _zz__zz_when_FpUnit_l84_78_1[29:0];
  assign _zz__zz_when_FpUnit_l84_78_3 = ({1'd0,_zz_when_FpUnit_l84_74} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_78_2 = _zz__zz_when_FpUnit_l84_78_3[29:0];
  assign _zz__zz_when_FpUnit_l84_79_1 = ({2'd0,(_zz_when_FpUnit_l84_77 ? _zz__zz_when_FpUnit_l84_79_2 : _zz_when_FpUnit_l84_75)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_79 = _zz__zz_when_FpUnit_l84_79_1[57:0];
  assign _zz__zz_when_FpUnit_l84_79_2 = (_zz_when_FpUnit_l84_75 - _zz_when_FpUnit_l84_76);
  assign _zz__zz_when_FpUnit_l84_79_4 = _zz_when_FpUnit_l84_21[27 : 26];
  assign _zz__zz_when_FpUnit_l84_79_3 = {56'd0, _zz__zz_when_FpUnit_l84_79_4};
  assign _zz__zz_when_FpUnit_l84_80_1 = ({2'd0,_zz_when_FpUnit_l84_78} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_80 = {26'd0, _zz__zz_when_FpUnit_l84_80_1};
  assign _zz__zz_when_FpUnit_l84_82_1 = ({1'd0,_zz_when_FpUnit_l84_78} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_82 = _zz__zz_when_FpUnit_l84_82_1[29:0];
  assign _zz__zz_when_FpUnit_l84_82_3 = ({1'd0,_zz_when_FpUnit_l84_78} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_82_2 = _zz__zz_when_FpUnit_l84_82_3[29:0];
  assign _zz__zz_when_FpUnit_l84_83_1 = ({2'd0,(_zz_when_FpUnit_l84_81 ? _zz__zz_when_FpUnit_l84_83_2 : _zz_when_FpUnit_l84_79)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_83 = _zz__zz_when_FpUnit_l84_83_1[57:0];
  assign _zz__zz_when_FpUnit_l84_83_2 = (_zz_when_FpUnit_l84_79 - _zz_when_FpUnit_l84_80);
  assign _zz__zz_when_FpUnit_l84_83_4 = _zz_when_FpUnit_l84_21[25 : 24];
  assign _zz__zz_when_FpUnit_l84_83_3 = {56'd0, _zz__zz_when_FpUnit_l84_83_4};
  assign _zz__zz_when_FpUnit_l84_84_1 = ({2'd0,_zz_when_FpUnit_l84_82} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_84 = {26'd0, _zz__zz_when_FpUnit_l84_84_1};
  assign _zz__zz_when_FpUnit_l84_86_1 = ({1'd0,_zz_when_FpUnit_l84_82} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_86 = _zz__zz_when_FpUnit_l84_86_1[29:0];
  assign _zz__zz_when_FpUnit_l84_86_3 = ({1'd0,_zz_when_FpUnit_l84_82} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_86_2 = _zz__zz_when_FpUnit_l84_86_3[29:0];
  assign _zz__zz_when_FpUnit_l84_87_1 = ({2'd0,(_zz_when_FpUnit_l84_85 ? _zz__zz_when_FpUnit_l84_87_2 : _zz_when_FpUnit_l84_83)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_87 = _zz__zz_when_FpUnit_l84_87_1[57:0];
  assign _zz__zz_when_FpUnit_l84_87_2 = (_zz_when_FpUnit_l84_83 - _zz_when_FpUnit_l84_84);
  assign _zz__zz_when_FpUnit_l84_87_4 = _zz_when_FpUnit_l84_21[23 : 22];
  assign _zz__zz_when_FpUnit_l84_87_3 = {56'd0, _zz__zz_when_FpUnit_l84_87_4};
  assign _zz__zz_when_FpUnit_l84_88_1 = ({2'd0,_zz_when_FpUnit_l84_86} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_88 = {26'd0, _zz__zz_when_FpUnit_l84_88_1};
  assign _zz__zz_when_FpUnit_l84_90_1 = ({1'd0,_zz_when_FpUnit_l84_86} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_90 = _zz__zz_when_FpUnit_l84_90_1[29:0];
  assign _zz__zz_when_FpUnit_l84_90_3 = ({1'd0,_zz_when_FpUnit_l84_86} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_90_2 = _zz__zz_when_FpUnit_l84_90_3[29:0];
  assign _zz__zz_when_FpUnit_l84_91_1 = ({2'd0,(_zz_when_FpUnit_l84_89 ? _zz__zz_when_FpUnit_l84_91_2 : _zz_when_FpUnit_l84_87)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_91 = _zz__zz_when_FpUnit_l84_91_1[57:0];
  assign _zz__zz_when_FpUnit_l84_91_2 = (_zz_when_FpUnit_l84_87 - _zz_when_FpUnit_l84_88);
  assign _zz__zz_when_FpUnit_l84_91_4 = _zz_when_FpUnit_l84_21[21 : 20];
  assign _zz__zz_when_FpUnit_l84_91_3 = {56'd0, _zz__zz_when_FpUnit_l84_91_4};
  assign _zz__zz_when_FpUnit_l84_92_1 = ({2'd0,_zz_when_FpUnit_l84_90} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_92 = {26'd0, _zz__zz_when_FpUnit_l84_92_1};
  assign _zz__zz_when_FpUnit_l84_94_1 = ({1'd0,_zz_when_FpUnit_l84_90} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_94 = _zz__zz_when_FpUnit_l84_94_1[29:0];
  assign _zz__zz_when_FpUnit_l84_94_3 = ({1'd0,_zz_when_FpUnit_l84_90} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_94_2 = _zz__zz_when_FpUnit_l84_94_3[29:0];
  assign _zz__zz_when_FpUnit_l84_95_1 = ({2'd0,(_zz_when_FpUnit_l84_93 ? _zz__zz_when_FpUnit_l84_95_2 : _zz_when_FpUnit_l84_91)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_95 = _zz__zz_when_FpUnit_l84_95_1[57:0];
  assign _zz__zz_when_FpUnit_l84_95_2 = (_zz_when_FpUnit_l84_91 - _zz_when_FpUnit_l84_92);
  assign _zz__zz_when_FpUnit_l84_95_4 = _zz_when_FpUnit_l84_21[19 : 18];
  assign _zz__zz_when_FpUnit_l84_95_3 = {56'd0, _zz__zz_when_FpUnit_l84_95_4};
  assign _zz__zz_when_FpUnit_l84_96_1 = ({2'd0,_zz_when_FpUnit_l84_94} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_96 = {26'd0, _zz__zz_when_FpUnit_l84_96_1};
  assign _zz__zz_when_FpUnit_l84_98_1 = ({1'd0,_zz_when_FpUnit_l84_94} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_98 = _zz__zz_when_FpUnit_l84_98_1[29:0];
  assign _zz__zz_when_FpUnit_l84_98_3 = ({1'd0,_zz_when_FpUnit_l84_94} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_98_2 = _zz__zz_when_FpUnit_l84_98_3[29:0];
  assign _zz__zz_when_FpUnit_l84_99_1 = ({2'd0,(_zz_when_FpUnit_l84_97 ? _zz__zz_when_FpUnit_l84_99_2 : _zz_when_FpUnit_l84_95)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_99 = _zz__zz_when_FpUnit_l84_99_1[57:0];
  assign _zz__zz_when_FpUnit_l84_99_2 = (_zz_when_FpUnit_l84_95 - _zz_when_FpUnit_l84_96);
  assign _zz__zz_when_FpUnit_l84_99_4 = _zz_when_FpUnit_l84_21[17 : 16];
  assign _zz__zz_when_FpUnit_l84_99_3 = {56'd0, _zz__zz_when_FpUnit_l84_99_4};
  assign _zz__zz_when_FpUnit_l84_100_1 = ({2'd0,_zz_when_FpUnit_l84_98} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_100 = {26'd0, _zz__zz_when_FpUnit_l84_100_1};
  assign _zz__zz_when_FpUnit_l84_102_1 = ({1'd0,_zz_when_FpUnit_l84_98} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_102 = _zz__zz_when_FpUnit_l84_102_1[29:0];
  assign _zz__zz_when_FpUnit_l84_102_3 = ({1'd0,_zz_when_FpUnit_l84_98} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_102_2 = _zz__zz_when_FpUnit_l84_102_3[29:0];
  assign _zz__zz_when_FpUnit_l84_103_1 = ({2'd0,(_zz_when_FpUnit_l84_101 ? _zz__zz_when_FpUnit_l84_103_2 : _zz_when_FpUnit_l84_99)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_103 = _zz__zz_when_FpUnit_l84_103_1[57:0];
  assign _zz__zz_when_FpUnit_l84_103_2 = (_zz_when_FpUnit_l84_99 - _zz_when_FpUnit_l84_100);
  assign _zz__zz_when_FpUnit_l84_103_4 = _zz_when_FpUnit_l84_21[15 : 14];
  assign _zz__zz_when_FpUnit_l84_103_3 = {56'd0, _zz__zz_when_FpUnit_l84_103_4};
  assign _zz__zz_when_FpUnit_l84_104_1 = ({2'd0,_zz_when_FpUnit_l84_102} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_104 = {26'd0, _zz__zz_when_FpUnit_l84_104_1};
  assign _zz__zz_when_FpUnit_l84_106_1 = ({1'd0,_zz_when_FpUnit_l84_102} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_106 = _zz__zz_when_FpUnit_l84_106_1[29:0];
  assign _zz__zz_when_FpUnit_l84_106_3 = ({1'd0,_zz_when_FpUnit_l84_102} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_106_2 = _zz__zz_when_FpUnit_l84_106_3[29:0];
  assign _zz__zz_when_FpUnit_l84_107_1 = ({2'd0,(_zz_when_FpUnit_l84_105 ? _zz__zz_when_FpUnit_l84_107_2 : _zz_when_FpUnit_l84_103)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_107 = _zz__zz_when_FpUnit_l84_107_1[57:0];
  assign _zz__zz_when_FpUnit_l84_107_2 = (_zz_when_FpUnit_l84_103 - _zz_when_FpUnit_l84_104);
  assign _zz__zz_when_FpUnit_l84_107_4 = _zz_when_FpUnit_l84_21[13 : 12];
  assign _zz__zz_when_FpUnit_l84_107_3 = {56'd0, _zz__zz_when_FpUnit_l84_107_4};
  assign _zz__zz_when_FpUnit_l84_108_1 = ({2'd0,_zz_when_FpUnit_l84_106} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_108 = {26'd0, _zz__zz_when_FpUnit_l84_108_1};
  assign _zz__zz_when_FpUnit_l84_110_1 = ({1'd0,_zz_when_FpUnit_l84_106} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_110 = _zz__zz_when_FpUnit_l84_110_1[29:0];
  assign _zz__zz_when_FpUnit_l84_110_3 = ({1'd0,_zz_when_FpUnit_l84_106} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_110_2 = _zz__zz_when_FpUnit_l84_110_3[29:0];
  assign _zz__zz_when_FpUnit_l84_111_1 = ({2'd0,(_zz_when_FpUnit_l84_109 ? _zz__zz_when_FpUnit_l84_111_2 : _zz_when_FpUnit_l84_107)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_111 = _zz__zz_when_FpUnit_l84_111_1[57:0];
  assign _zz__zz_when_FpUnit_l84_111_2 = (_zz_when_FpUnit_l84_107 - _zz_when_FpUnit_l84_108);
  assign _zz__zz_when_FpUnit_l84_111_4 = _zz_when_FpUnit_l84_21[11 : 10];
  assign _zz__zz_when_FpUnit_l84_111_3 = {56'd0, _zz__zz_when_FpUnit_l84_111_4};
  assign _zz__zz_when_FpUnit_l84_112_1 = ({2'd0,_zz_when_FpUnit_l84_110} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_112 = {26'd0, _zz__zz_when_FpUnit_l84_112_1};
  assign _zz__zz_when_FpUnit_l84_114_1 = ({1'd0,_zz_when_FpUnit_l84_110} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_114 = _zz__zz_when_FpUnit_l84_114_1[29:0];
  assign _zz__zz_when_FpUnit_l84_114_3 = ({1'd0,_zz_when_FpUnit_l84_110} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_114_2 = _zz__zz_when_FpUnit_l84_114_3[29:0];
  assign _zz__zz_when_FpUnit_l84_115_1 = ({2'd0,(_zz_when_FpUnit_l84_113 ? _zz__zz_when_FpUnit_l84_115_2 : _zz_when_FpUnit_l84_111)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_115 = _zz__zz_when_FpUnit_l84_115_1[57:0];
  assign _zz__zz_when_FpUnit_l84_115_2 = (_zz_when_FpUnit_l84_111 - _zz_when_FpUnit_l84_112);
  assign _zz__zz_when_FpUnit_l84_115_4 = _zz_when_FpUnit_l84_21[9 : 8];
  assign _zz__zz_when_FpUnit_l84_115_3 = {56'd0, _zz__zz_when_FpUnit_l84_115_4};
  assign _zz__zz_when_FpUnit_l84_116_1 = ({2'd0,_zz_when_FpUnit_l84_114} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_116 = {26'd0, _zz__zz_when_FpUnit_l84_116_1};
  assign _zz__zz_when_FpUnit_l84_118_1 = ({1'd0,_zz_when_FpUnit_l84_114} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_118 = _zz__zz_when_FpUnit_l84_118_1[29:0];
  assign _zz__zz_when_FpUnit_l84_118_3 = ({1'd0,_zz_when_FpUnit_l84_114} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_118_2 = _zz__zz_when_FpUnit_l84_118_3[29:0];
  assign _zz__zz_when_FpUnit_l84_119_1 = ({2'd0,(_zz_when_FpUnit_l84_117 ? _zz__zz_when_FpUnit_l84_119_2 : _zz_when_FpUnit_l84_115)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_119 = _zz__zz_when_FpUnit_l84_119_1[57:0];
  assign _zz__zz_when_FpUnit_l84_119_2 = (_zz_when_FpUnit_l84_115 - _zz_when_FpUnit_l84_116);
  assign _zz__zz_when_FpUnit_l84_119_4 = _zz_when_FpUnit_l84_21[7 : 6];
  assign _zz__zz_when_FpUnit_l84_119_3 = {56'd0, _zz__zz_when_FpUnit_l84_119_4};
  assign _zz__zz_when_FpUnit_l84_120_1 = ({2'd0,_zz_when_FpUnit_l84_118} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_120 = {26'd0, _zz__zz_when_FpUnit_l84_120_1};
  assign _zz__zz_when_FpUnit_l84_122_1 = ({1'd0,_zz_when_FpUnit_l84_118} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_122 = _zz__zz_when_FpUnit_l84_122_1[29:0];
  assign _zz__zz_when_FpUnit_l84_122_3 = ({1'd0,_zz_when_FpUnit_l84_118} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_122_2 = _zz__zz_when_FpUnit_l84_122_3[29:0];
  assign _zz__zz_when_FpUnit_l84_123_1 = ({2'd0,(_zz_when_FpUnit_l84_121 ? _zz__zz_when_FpUnit_l84_123_2 : _zz_when_FpUnit_l84_119)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_123 = _zz__zz_when_FpUnit_l84_123_1[57:0];
  assign _zz__zz_when_FpUnit_l84_123_2 = (_zz_when_FpUnit_l84_119 - _zz_when_FpUnit_l84_120);
  assign _zz__zz_when_FpUnit_l84_123_4 = _zz_when_FpUnit_l84_21[5 : 4];
  assign _zz__zz_when_FpUnit_l84_123_3 = {56'd0, _zz__zz_when_FpUnit_l84_123_4};
  assign _zz__zz_when_FpUnit_l84_124_1 = ({2'd0,_zz_when_FpUnit_l84_122} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_124 = {26'd0, _zz__zz_when_FpUnit_l84_124_1};
  assign _zz__zz_when_FpUnit_l84_126_1 = ({1'd0,_zz_when_FpUnit_l84_122} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_126 = _zz__zz_when_FpUnit_l84_126_1[29:0];
  assign _zz__zz_when_FpUnit_l84_126_3 = ({1'd0,_zz_when_FpUnit_l84_122} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_126_2 = _zz__zz_when_FpUnit_l84_126_3[29:0];
  assign _zz__zz_when_FpUnit_l84_127_1 = ({2'd0,(_zz_when_FpUnit_l84_125 ? _zz__zz_when_FpUnit_l84_127_2 : _zz_when_FpUnit_l84_123)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_127 = _zz__zz_when_FpUnit_l84_127_1[57:0];
  assign _zz__zz_when_FpUnit_l84_127_2 = (_zz_when_FpUnit_l84_123 - _zz_when_FpUnit_l84_124);
  assign _zz__zz_when_FpUnit_l84_127_4 = _zz_when_FpUnit_l84_21[3 : 2];
  assign _zz__zz_when_FpUnit_l84_127_3 = {56'd0, _zz__zz_when_FpUnit_l84_127_4};
  assign _zz__zz_when_FpUnit_l84_128_1 = ({2'd0,_zz_when_FpUnit_l84_126} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_128 = {26'd0, _zz__zz_when_FpUnit_l84_128_1};
  assign _zz__zz_when_FpUnit_l84_130_1 = ({1'd0,_zz_when_FpUnit_l84_126} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_130 = _zz__zz_when_FpUnit_l84_130_1[29:0];
  assign _zz__zz_when_FpUnit_l84_130_3 = ({1'd0,_zz_when_FpUnit_l84_126} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_130_2 = _zz__zz_when_FpUnit_l84_130_3[29:0];
  assign _zz__zz_when_FpUnit_l84_131_1 = ({2'd0,(_zz_when_FpUnit_l84_129 ? _zz__zz_when_FpUnit_l84_131_2 : _zz_when_FpUnit_l84_127)} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_131 = _zz__zz_when_FpUnit_l84_131_1[57:0];
  assign _zz__zz_when_FpUnit_l84_131_2 = (_zz_when_FpUnit_l84_127 - _zz_when_FpUnit_l84_128);
  assign _zz__zz_when_FpUnit_l84_131_4 = _zz_when_FpUnit_l84_21[1 : 0];
  assign _zz__zz_when_FpUnit_l84_131_3 = {56'd0, _zz__zz_when_FpUnit_l84_131_4};
  assign _zz__zz_when_FpUnit_l84_132_1 = ({2'd0,_zz_when_FpUnit_l84_130} <<< 2'd2);
  assign _zz__zz_when_FpUnit_l84_132 = {26'd0, _zz__zz_when_FpUnit_l84_132_1};
  assign _zz__zz_when_FpUnit_l84_134_1 = ({1'd0,_zz_when_FpUnit_l84_130} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_134 = _zz__zz_when_FpUnit_l84_134_1[29:0];
  assign _zz__zz_when_FpUnit_l84_134_3 = ({1'd0,_zz_when_FpUnit_l84_130} <<< 1'd1);
  assign _zz__zz_when_FpUnit_l84_134_2 = _zz__zz_when_FpUnit_l84_134_3[29:0];
  assign _zz__zz_flagUF_48 = _zz__zz_flagUF_48_1;
  assign _zz__zz_flagUF_48_1 = {7'd0, _zz_when_FpUnit_l91_4};
  assign _zz__zz_flagUF_48_2 = ($signed(_zz__zz_flagUF_48_3) - $signed(12'h01a));
  assign _zz__zz_flagUF_48_4 = (_zz__zz_flagUF_48_5 >>> 1'd1);
  assign _zz__zz_flagUF_48_3 = {{1{_zz__zz_flagUF_48_4[10]}}, _zz__zz_flagUF_48_4};
  assign _zz__zz_flagUF_48_5 = (_zz_flagUF_45 ? _zz__zz_flagUF_48_6 : _zz__zz_flagUF_48_8);
  assign _zz__zz_flagUF_48_6 = ($signed(_zz__zz_flagUF_48_7) - $signed(12'h001));
  assign _zz__zz_flagUF_48_7 = {{2{_zz_when_FpUnit_l180[9]}}, _zz_when_FpUnit_l180};
  assign _zz__zz_flagUF_48_8 = {{2{_zz_when_FpUnit_l180[9]}}, _zz_when_FpUnit_l180};
  assign _zz__zz_flagUF_46_1 = (_zz_when_FpUnit_l84_134 >>> _zz_flagUF_49);
  assign _zz__zz_flagUF_46 = _zz__zz_flagUF_46_1[26:0];
  assign _zz__zz_flagUF_47 = (_zz__zz_flagUF_47_1 - 30'h00000001);
  assign _zz__zz_flagUF_47_2 = ({31'd0,30'h00000001} <<< _zz_flagUF_49);
  assign _zz__zz_flagUF_47_1 = _zz__zz_flagUF_47_2[29:0];
  assign _zz__zz_flagUF_46_3 = ({31'd0,_zz_when_FpUnit_l84_134} <<< _zz__zz_flagUF_46_4);
  assign _zz__zz_flagUF_46_2 = _zz__zz_flagUF_46_3[26:0];
  assign _zz__zz_flagUF_46_4 = (5'h1a - _zz_when_FpUnit_l91_4);
  assign _zz__zz_flagUF_50 = (_zz_when_FpUnit_l84_131 - _zz_when_FpUnit_l84_132);
  assign _zz__zz_flagUF_51 = ($signed(_zz_flagUF_48) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l116_4 = ($signed(12'hf82) - $signed(_zz_flagUF_48));
  assign _zz__zz_flagUF_52 = (_zz_flagUF_46 >>> _zz_when_FpUnit_l119_4);
  assign _zz__zz_flagUF_53 = (_zz__zz_flagUF_53_1 - 27'h0000001);
  assign _zz__zz_flagUF_53_2 = ({31'd0,27'h0000001} <<< _zz__zz_flagUF_53_3);
  assign _zz__zz_flagUF_53_1 = _zz__zz_flagUF_53_2[26:0];
  assign _zz__zz_flagUF_53_3 = _zz_when_FpUnit_l119_4[4:0];
  assign _zz__zz_when_FpUnit_l150_22_1 = _zz_when_FpUnit_l150_21;
  assign _zz__zz_when_FpUnit_l150_22 = {1'd0, _zz__zz_when_FpUnit_l150_22_1};
  assign _zz__zz_when_FpUnit_l150_22_3 = ((io_rm == 3'b000) ? (_zz_flagUF_54 && ((_zz_flagUF_55 || _zz_flagUF_56) || _zz_when_FpUnit_l150_21[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_res_25 && (_zz__zz_when_FpUnit_l150_22_4 || _zz_flagUF_56)) : ((io_rm == _zz__zz_when_FpUnit_l150_22_5) ? (_zz__zz_when_FpUnit_l150_22_6 && _zz__zz_when_FpUnit_l150_22_7) : _zz_flagUF_54))));
  assign _zz__zz_when_FpUnit_l150_22_2 = {24'd0, _zz__zz_when_FpUnit_l150_22_3};
  assign _zz__zz_res_26 = (_zz_when_FpUnit_l150_22 >>> 1'd1);
  assign _zz__zz_res_26_1 = _zz_when_FpUnit_l150_22[23:0];
  assign _zz__zz_when_FpUnit_l150_24 = (_zz_when_FpUnit_l150_23 ? _zz__zz_when_FpUnit_l150_24_1 : _zz_when_FpUnit_l150_20);
  assign _zz__zz_when_FpUnit_l150_24_1 = ($signed(_zz_when_FpUnit_l150_20) + $signed(12'h001));
  assign _zz__zz_res_29_1 = _zz_when_FpUnit_l150_24;
  assign _zz__zz_res_29 = _zz__zz_res_29_1[7:0];
  assign _zz_res_91 = {22'd0, _zz_res_41};
  assign _zz__zz_when_FpUnit_l329_2_1 = ($signed(_zz_when_FpUnit_l180) + $signed(_zz_when_FpUnit_l180_1));
  assign _zz__zz_when_FpUnit_l329_2 = {{2{_zz__zz_when_FpUnit_l329_2_1[9]}}, _zz__zz_when_FpUnit_l329_2_1};
  assign _zz__zz_when_FpUnit_l329_3 = {{2{_zz_when_FpUnit_l329_1[9]}}, _zz_when_FpUnit_l329_1};
  assign _zz__zz_when_FpUnit_l84_136 = {6'd0, _zz_when_FpUnit_l84_135};
  assign _zz__zz_when_FpUnit_l84_136_1 = (_zz__zz_when_FpUnit_l84_136_2 >>> _zz_when_FpUnit_l330);
  assign _zz__zz_when_FpUnit_l84_136_2 = {6'd0, _zz_when_FpUnit_l84_135};
  assign _zz__zz_flagUF_58 = {6'd0, _zz_when_FpUnit_l84_135};
  assign _zz__zz_flagUF_58_1 = (_zz__zz_flagUF_58_2 - 54'h00000000000001);
  assign _zz__zz_flagUF_58_3 = ({63'd0,54'h00000000000001} <<< _zz__zz_flagUF_58_4);
  assign _zz__zz_flagUF_58_2 = _zz__zz_flagUF_58_3[53:0];
  assign _zz__zz_flagUF_58_4 = _zz_when_FpUnit_l330[5:0];
  assign _zz__zz_when_FpUnit_l84_137 = {30'd0, _zz_when_FpUnit_l84_1};
  assign _zz__zz_when_FpUnit_l84_137_1 = (_zz__zz_when_FpUnit_l84_137_2 >>> _zz_when_FpUnit_l330_1);
  assign _zz__zz_when_FpUnit_l84_137_2 = {30'd0, _zz_when_FpUnit_l84_1};
  assign _zz__zz_flagUF_59 = {30'd0, _zz_when_FpUnit_l84_1};
  assign _zz__zz_flagUF_59_1 = (_zz__zz_flagUF_59_2 - 54'h00000000000001);
  assign _zz__zz_flagUF_59_3 = ({63'd0,54'h00000000000001} <<< _zz__zz_flagUF_59_4);
  assign _zz__zz_flagUF_59_2 = _zz__zz_flagUF_59_3[53:0];
  assign _zz__zz_flagUF_59_4 = _zz_when_FpUnit_l330_1[5:0];
  assign _zz__zz_when_FpUnit_l84_138_1 = _zz_when_FpUnit_l84_136;
  assign _zz__zz_when_FpUnit_l84_138 = {1'd0, _zz__zz_when_FpUnit_l84_138_1};
  assign _zz__zz_when_FpUnit_l84_139_1 = _zz_when_FpUnit_l84_137;
  assign _zz__zz_when_FpUnit_l84_139 = {1'd0, _zz__zz_when_FpUnit_l84_139_1};
  assign _zz__zz_when_FpUnit_l84_140_1 = (_zz_when_FpUnit_l359_1 ? _zz__zz_when_FpUnit_l84_140_2 : _zz_when_FpUnit_l84_138);
  assign _zz__zz_when_FpUnit_l84_140 = {{1{_zz__zz_when_FpUnit_l84_140_1[54]}}, _zz__zz_when_FpUnit_l84_140_1};
  assign _zz__zz_when_FpUnit_l84_140_2 = (- _zz_when_FpUnit_l84_138);
  assign _zz__zz_when_FpUnit_l84_140_4 = (_zz_when_FpUnit_l359_2 ? _zz__zz_when_FpUnit_l84_140_5 : _zz_when_FpUnit_l84_139);
  assign _zz__zz_when_FpUnit_l84_140_3 = {{1{_zz__zz_when_FpUnit_l84_140_4[54]}}, _zz__zz_when_FpUnit_l84_140_4};
  assign _zz__zz_when_FpUnit_l84_140_5 = (- _zz_when_FpUnit_l84_139);
  assign _zz__zz_when_FpUnit_l84_142 = (- _zz_when_FpUnit_l84_140);
  assign _zz__zz_flagUF_62 = _zz__zz_flagUF_62_1;
  assign _zz__zz_flagUF_62_1 = {6'd0, _zz_when_FpUnit_l91_5};
  assign _zz__zz_flagUF_60_1 = (_zz_when_FpUnit_l84_142 >>> _zz_flagUF_63);
  assign _zz__zz_flagUF_60 = _zz__zz_flagUF_60_1[26:0];
  assign _zz__zz_flagUF_61 = (_zz__zz_flagUF_61_1 - 56'h00000000000001);
  assign _zz__zz_flagUF_61_2 = ({63'd0,56'h00000000000001} <<< _zz_flagUF_63);
  assign _zz__zz_flagUF_61_1 = _zz__zz_flagUF_61_2[55:0];
  assign _zz__zz_flagUF_60_3 = ({63'd0,_zz_when_FpUnit_l84_142} <<< _zz__zz_flagUF_60_4);
  assign _zz__zz_flagUF_60_2 = _zz__zz_flagUF_60_3[26:0];
  assign _zz__zz_flagUF_60_4 = (6'h1a - _zz_when_FpUnit_l91_5);
  assign _zz__zz_flagUF_65 = ($signed(_zz_flagUF_62) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l116_5 = ($signed(12'hf82) - $signed(_zz_flagUF_62));
  assign _zz__zz_flagUF_66 = (_zz_flagUF_60 >>> _zz_when_FpUnit_l119_5);
  assign _zz__zz_flagUF_67 = (_zz__zz_flagUF_67_1 - 27'h0000001);
  assign _zz__zz_flagUF_67_2 = ({31'd0,27'h0000001} <<< _zz__zz_flagUF_67_3);
  assign _zz__zz_flagUF_67_1 = _zz__zz_flagUF_67_2[26:0];
  assign _zz__zz_flagUF_67_3 = _zz_when_FpUnit_l119_5[4:0];
  assign _zz__zz_when_FpUnit_l150_27_1 = _zz_when_FpUnit_l150_26;
  assign _zz__zz_when_FpUnit_l150_27 = {1'd0, _zz__zz_when_FpUnit_l150_27_1};
  assign _zz__zz_when_FpUnit_l150_27_3 = ((io_rm == 3'b000) ? (_zz_flagUF_68 && ((_zz_flagUF_69 || _zz_flagUF_70) || _zz_when_FpUnit_l150_26[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_when_FpUnit_l84_141 && (_zz__zz_when_FpUnit_l150_27_4 || _zz_flagUF_70)) : ((io_rm == _zz__zz_when_FpUnit_l150_27_5) ? (_zz__zz_when_FpUnit_l150_27_6 && _zz__zz_when_FpUnit_l150_27_7) : _zz_flagUF_68))));
  assign _zz__zz_when_FpUnit_l150_27_2 = {24'd0, _zz__zz_when_FpUnit_l150_27_3};
  assign _zz__zz_res_42 = (_zz_when_FpUnit_l150_27 >>> 1'd1);
  assign _zz__zz_res_42_1 = _zz_when_FpUnit_l150_27[23:0];
  assign _zz__zz_when_FpUnit_l150_29 = (_zz_when_FpUnit_l150_28 ? _zz__zz_when_FpUnit_l150_29_1 : _zz_when_FpUnit_l150_25);
  assign _zz__zz_when_FpUnit_l150_29_1 = ($signed(_zz_when_FpUnit_l150_25) + $signed(12'h001));
  assign _zz__zz_res_45_1 = _zz_when_FpUnit_l150_29;
  assign _zz__zz_res_45 = _zz__zz_res_45_1[7:0];
  assign _zz__zz_when_FpUnit_l329_7_1 = ($signed(_zz_when_FpUnit_l180) + $signed(_zz_when_FpUnit_l180_1));
  assign _zz__zz_when_FpUnit_l329_7 = {{2{_zz__zz_when_FpUnit_l329_7_1[9]}}, _zz__zz_when_FpUnit_l329_7_1};
  assign _zz__zz_when_FpUnit_l329_8 = {{2{_zz_when_FpUnit_l329_1[9]}}, _zz_when_FpUnit_l329_1};
  assign _zz__zz_when_FpUnit_l84_144 = {6'd0, _zz_when_FpUnit_l84_143};
  assign _zz__zz_when_FpUnit_l84_144_1 = (_zz__zz_when_FpUnit_l84_144_2 >>> _zz_when_FpUnit_l330_2);
  assign _zz__zz_when_FpUnit_l84_144_2 = {6'd0, _zz_when_FpUnit_l84_143};
  assign _zz__zz_flagUF_72 = {6'd0, _zz_when_FpUnit_l84_143};
  assign _zz__zz_flagUF_72_1 = (_zz__zz_flagUF_72_2 - 54'h00000000000001);
  assign _zz__zz_flagUF_72_3 = ({63'd0,54'h00000000000001} <<< _zz__zz_flagUF_72_4);
  assign _zz__zz_flagUF_72_2 = _zz__zz_flagUF_72_3[53:0];
  assign _zz__zz_flagUF_72_4 = _zz_when_FpUnit_l330_2[5:0];
  assign _zz__zz_when_FpUnit_l84_145 = {30'd0, _zz_when_FpUnit_l84_1};
  assign _zz__zz_when_FpUnit_l84_145_1 = (_zz__zz_when_FpUnit_l84_145_2 >>> _zz_when_FpUnit_l330_3);
  assign _zz__zz_when_FpUnit_l84_145_2 = {30'd0, _zz_when_FpUnit_l84_1};
  assign _zz__zz_flagUF_73 = {30'd0, _zz_when_FpUnit_l84_1};
  assign _zz__zz_flagUF_73_1 = (_zz__zz_flagUF_73_2 - 54'h00000000000001);
  assign _zz__zz_flagUF_73_3 = ({63'd0,54'h00000000000001} <<< _zz__zz_flagUF_73_4);
  assign _zz__zz_flagUF_73_2 = _zz__zz_flagUF_73_3[53:0];
  assign _zz__zz_flagUF_73_4 = _zz_when_FpUnit_l330_3[5:0];
  assign _zz__zz_when_FpUnit_l84_146_1 = _zz_when_FpUnit_l84_144;
  assign _zz__zz_when_FpUnit_l84_146 = {1'd0, _zz__zz_when_FpUnit_l84_146_1};
  assign _zz__zz_when_FpUnit_l84_147_1 = _zz_when_FpUnit_l84_145;
  assign _zz__zz_when_FpUnit_l84_147 = {1'd0, _zz__zz_when_FpUnit_l84_147_1};
  assign _zz__zz_when_FpUnit_l84_148_1 = (_zz_when_FpUnit_l359_3 ? _zz__zz_when_FpUnit_l84_148_2 : _zz_when_FpUnit_l84_146);
  assign _zz__zz_when_FpUnit_l84_148 = {{1{_zz__zz_when_FpUnit_l84_148_1[54]}}, _zz__zz_when_FpUnit_l84_148_1};
  assign _zz__zz_when_FpUnit_l84_148_2 = (- _zz_when_FpUnit_l84_146);
  assign _zz__zz_when_FpUnit_l84_148_4 = (_zz_when_FpUnit_l359_4 ? _zz__zz_when_FpUnit_l84_148_5 : _zz_when_FpUnit_l84_147);
  assign _zz__zz_when_FpUnit_l84_148_3 = {{1{_zz__zz_when_FpUnit_l84_148_4[54]}}, _zz__zz_when_FpUnit_l84_148_4};
  assign _zz__zz_when_FpUnit_l84_148_5 = (- _zz_when_FpUnit_l84_147);
  assign _zz__zz_when_FpUnit_l84_150 = (- _zz_when_FpUnit_l84_148);
  assign _zz__zz_flagUF_76 = _zz__zz_flagUF_76_1;
  assign _zz__zz_flagUF_76_1 = {6'd0, _zz_when_FpUnit_l91_6};
  assign _zz__zz_flagUF_74_1 = (_zz_when_FpUnit_l84_150 >>> _zz_flagUF_77);
  assign _zz__zz_flagUF_74 = _zz__zz_flagUF_74_1[26:0];
  assign _zz__zz_flagUF_75 = (_zz__zz_flagUF_75_1 - 56'h00000000000001);
  assign _zz__zz_flagUF_75_2 = ({63'd0,56'h00000000000001} <<< _zz_flagUF_77);
  assign _zz__zz_flagUF_75_1 = _zz__zz_flagUF_75_2[55:0];
  assign _zz__zz_flagUF_74_3 = ({63'd0,_zz_when_FpUnit_l84_150} <<< _zz__zz_flagUF_74_4);
  assign _zz__zz_flagUF_74_2 = _zz__zz_flagUF_74_3[26:0];
  assign _zz__zz_flagUF_74_4 = (6'h1a - _zz_when_FpUnit_l91_6);
  assign _zz__zz_flagUF_79 = ($signed(_zz_flagUF_76) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l116_6 = ($signed(12'hf82) - $signed(_zz_flagUF_76));
  assign _zz__zz_flagUF_80 = (_zz_flagUF_74 >>> _zz_when_FpUnit_l119_6);
  assign _zz__zz_flagUF_81 = (_zz__zz_flagUF_81_1 - 27'h0000001);
  assign _zz__zz_flagUF_81_2 = ({31'd0,27'h0000001} <<< _zz__zz_flagUF_81_3);
  assign _zz__zz_flagUF_81_1 = _zz__zz_flagUF_81_2[26:0];
  assign _zz__zz_flagUF_81_3 = _zz_when_FpUnit_l119_6[4:0];
  assign _zz__zz_when_FpUnit_l150_32_1 = _zz_when_FpUnit_l150_31;
  assign _zz__zz_when_FpUnit_l150_32 = {1'd0, _zz__zz_when_FpUnit_l150_32_1};
  assign _zz__zz_when_FpUnit_l150_32_3 = ((io_rm == 3'b000) ? (_zz_flagUF_82 && ((_zz_flagUF_83 || _zz_flagUF_84) || _zz_when_FpUnit_l150_31[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_when_FpUnit_l84_149 && (_zz__zz_when_FpUnit_l150_32_4 || _zz_flagUF_84)) : ((io_rm == _zz__zz_when_FpUnit_l150_32_5) ? (_zz__zz_when_FpUnit_l150_32_6 && _zz__zz_when_FpUnit_l150_32_7) : _zz_flagUF_82))));
  assign _zz__zz_when_FpUnit_l150_32_2 = {24'd0, _zz__zz_when_FpUnit_l150_32_3};
  assign _zz__zz_res_47 = (_zz_when_FpUnit_l150_32 >>> 1'd1);
  assign _zz__zz_res_47_1 = _zz_when_FpUnit_l150_32[23:0];
  assign _zz__zz_when_FpUnit_l150_34 = (_zz_when_FpUnit_l150_33 ? _zz__zz_when_FpUnit_l150_34_1 : _zz_when_FpUnit_l150_30);
  assign _zz__zz_when_FpUnit_l150_34_1 = ($signed(_zz_when_FpUnit_l150_30) + $signed(12'h001));
  assign _zz__zz_res_50_1 = _zz_when_FpUnit_l150_34;
  assign _zz__zz_res_50 = _zz__zz_res_50_1[7:0];
  assign _zz__zz_when_FpUnit_l329_12_1 = ($signed(_zz_when_FpUnit_l180) + $signed(_zz_when_FpUnit_l180_1));
  assign _zz__zz_when_FpUnit_l329_12 = {{2{_zz__zz_when_FpUnit_l329_12_1[9]}}, _zz__zz_when_FpUnit_l329_12_1};
  assign _zz__zz_when_FpUnit_l329_13 = {{2{_zz_when_FpUnit_l329_1[9]}}, _zz_when_FpUnit_l329_1};
  assign _zz__zz_when_FpUnit_l84_152 = {6'd0, _zz_when_FpUnit_l84_151};
  assign _zz__zz_when_FpUnit_l84_152_1 = (_zz__zz_when_FpUnit_l84_152_2 >>> _zz_when_FpUnit_l330_4);
  assign _zz__zz_when_FpUnit_l84_152_2 = {6'd0, _zz_when_FpUnit_l84_151};
  assign _zz__zz_flagUF_86 = {6'd0, _zz_when_FpUnit_l84_151};
  assign _zz__zz_flagUF_86_1 = (_zz__zz_flagUF_86_2 - 54'h00000000000001);
  assign _zz__zz_flagUF_86_3 = ({63'd0,54'h00000000000001} <<< _zz__zz_flagUF_86_4);
  assign _zz__zz_flagUF_86_2 = _zz__zz_flagUF_86_3[53:0];
  assign _zz__zz_flagUF_86_4 = _zz_when_FpUnit_l330_4[5:0];
  assign _zz__zz_when_FpUnit_l84_153 = {30'd0, _zz_when_FpUnit_l84_1};
  assign _zz__zz_when_FpUnit_l84_153_1 = (_zz__zz_when_FpUnit_l84_153_2 >>> _zz_when_FpUnit_l330_5);
  assign _zz__zz_when_FpUnit_l84_153_2 = {30'd0, _zz_when_FpUnit_l84_1};
  assign _zz__zz_flagUF_87 = {30'd0, _zz_when_FpUnit_l84_1};
  assign _zz__zz_flagUF_87_1 = (_zz__zz_flagUF_87_2 - 54'h00000000000001);
  assign _zz__zz_flagUF_87_3 = ({63'd0,54'h00000000000001} <<< _zz__zz_flagUF_87_4);
  assign _zz__zz_flagUF_87_2 = _zz__zz_flagUF_87_3[53:0];
  assign _zz__zz_flagUF_87_4 = _zz_when_FpUnit_l330_5[5:0];
  assign _zz__zz_when_FpUnit_l84_154_1 = _zz_when_FpUnit_l84_152;
  assign _zz__zz_when_FpUnit_l84_154 = {1'd0, _zz__zz_when_FpUnit_l84_154_1};
  assign _zz__zz_when_FpUnit_l84_155_1 = _zz_when_FpUnit_l84_153;
  assign _zz__zz_when_FpUnit_l84_155 = {1'd0, _zz__zz_when_FpUnit_l84_155_1};
  assign _zz__zz_when_FpUnit_l84_156_1 = (_zz_when_FpUnit_l359_5 ? _zz__zz_when_FpUnit_l84_156_2 : _zz_when_FpUnit_l84_154);
  assign _zz__zz_when_FpUnit_l84_156 = {{1{_zz__zz_when_FpUnit_l84_156_1[54]}}, _zz__zz_when_FpUnit_l84_156_1};
  assign _zz__zz_when_FpUnit_l84_156_2 = (- _zz_when_FpUnit_l84_154);
  assign _zz__zz_when_FpUnit_l84_156_4 = (_zz_when_FpUnit_l359_6 ? _zz__zz_when_FpUnit_l84_156_5 : _zz_when_FpUnit_l84_155);
  assign _zz__zz_when_FpUnit_l84_156_3 = {{1{_zz__zz_when_FpUnit_l84_156_4[54]}}, _zz__zz_when_FpUnit_l84_156_4};
  assign _zz__zz_when_FpUnit_l84_156_5 = (- _zz_when_FpUnit_l84_155);
  assign _zz__zz_when_FpUnit_l84_158 = (- _zz_when_FpUnit_l84_156);
  assign _zz__zz_flagUF_90 = _zz__zz_flagUF_90_1;
  assign _zz__zz_flagUF_90_1 = {6'd0, _zz_when_FpUnit_l91_7};
  assign _zz__zz_flagUF_88_1 = (_zz_when_FpUnit_l84_158 >>> _zz_flagUF_91);
  assign _zz__zz_flagUF_88 = _zz__zz_flagUF_88_1[26:0];
  assign _zz__zz_flagUF_89 = (_zz__zz_flagUF_89_1 - 56'h00000000000001);
  assign _zz__zz_flagUF_89_2 = ({63'd0,56'h00000000000001} <<< _zz_flagUF_91);
  assign _zz__zz_flagUF_89_1 = _zz__zz_flagUF_89_2[55:0];
  assign _zz__zz_flagUF_88_3 = ({63'd0,_zz_when_FpUnit_l84_158} <<< _zz__zz_flagUF_88_4);
  assign _zz__zz_flagUF_88_2 = _zz__zz_flagUF_88_3[26:0];
  assign _zz__zz_flagUF_88_4 = (6'h1a - _zz_when_FpUnit_l91_7);
  assign _zz__zz_flagUF_93 = ($signed(_zz_flagUF_90) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l116_7 = ($signed(12'hf82) - $signed(_zz_flagUF_90));
  assign _zz__zz_flagUF_94 = (_zz_flagUF_88 >>> _zz_when_FpUnit_l119_7);
  assign _zz__zz_flagUF_95 = (_zz__zz_flagUF_95_1 - 27'h0000001);
  assign _zz__zz_flagUF_95_2 = ({31'd0,27'h0000001} <<< _zz__zz_flagUF_95_3);
  assign _zz__zz_flagUF_95_1 = _zz__zz_flagUF_95_2[26:0];
  assign _zz__zz_flagUF_95_3 = _zz_when_FpUnit_l119_7[4:0];
  assign _zz__zz_when_FpUnit_l150_37_1 = _zz_when_FpUnit_l150_36;
  assign _zz__zz_when_FpUnit_l150_37 = {1'd0, _zz__zz_when_FpUnit_l150_37_1};
  assign _zz__zz_when_FpUnit_l150_37_3 = ((io_rm == 3'b000) ? (_zz_flagUF_96 && ((_zz_flagUF_97 || _zz_flagUF_98) || _zz_when_FpUnit_l150_36[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_when_FpUnit_l84_157 && (_zz__zz_when_FpUnit_l150_37_4 || _zz_flagUF_98)) : ((io_rm == _zz__zz_when_FpUnit_l150_37_5) ? (_zz__zz_when_FpUnit_l150_37_6 && _zz__zz_when_FpUnit_l150_37_7) : _zz_flagUF_96))));
  assign _zz__zz_when_FpUnit_l150_37_2 = {24'd0, _zz__zz_when_FpUnit_l150_37_3};
  assign _zz__zz_res_52 = (_zz_when_FpUnit_l150_37 >>> 1'd1);
  assign _zz__zz_res_52_1 = _zz_when_FpUnit_l150_37[23:0];
  assign _zz__zz_when_FpUnit_l150_39 = (_zz_when_FpUnit_l150_38 ? _zz__zz_when_FpUnit_l150_39_1 : _zz_when_FpUnit_l150_35);
  assign _zz__zz_when_FpUnit_l150_39_1 = ($signed(_zz_when_FpUnit_l150_35) + $signed(12'h001));
  assign _zz__zz_res_55_1 = _zz_when_FpUnit_l150_39;
  assign _zz__zz_res_55 = _zz__zz_res_55_1[7:0];
  assign _zz__zz_when_FpUnit_l329_17_1 = ($signed(_zz_when_FpUnit_l180) + $signed(_zz_when_FpUnit_l180_1));
  assign _zz__zz_when_FpUnit_l329_17 = {{2{_zz__zz_when_FpUnit_l329_17_1[9]}}, _zz__zz_when_FpUnit_l329_17_1};
  assign _zz__zz_when_FpUnit_l329_18 = {{2{_zz_when_FpUnit_l329_1[9]}}, _zz_when_FpUnit_l329_1};
  assign _zz__zz_when_FpUnit_l84_160 = {6'd0, _zz_when_FpUnit_l84_159};
  assign _zz__zz_when_FpUnit_l84_160_1 = (_zz__zz_when_FpUnit_l84_160_2 >>> _zz_when_FpUnit_l330_6);
  assign _zz__zz_when_FpUnit_l84_160_2 = {6'd0, _zz_when_FpUnit_l84_159};
  assign _zz__zz_flagUF_100 = {6'd0, _zz_when_FpUnit_l84_159};
  assign _zz__zz_flagUF_100_1 = (_zz__zz_flagUF_100_2 - 54'h00000000000001);
  assign _zz__zz_flagUF_100_3 = ({63'd0,54'h00000000000001} <<< _zz__zz_flagUF_100_4);
  assign _zz__zz_flagUF_100_2 = _zz__zz_flagUF_100_3[53:0];
  assign _zz__zz_flagUF_100_4 = _zz_when_FpUnit_l330_6[5:0];
  assign _zz__zz_when_FpUnit_l84_161 = {30'd0, _zz_when_FpUnit_l84_1};
  assign _zz__zz_when_FpUnit_l84_161_1 = (_zz__zz_when_FpUnit_l84_161_2 >>> _zz_when_FpUnit_l330_7);
  assign _zz__zz_when_FpUnit_l84_161_2 = {30'd0, _zz_when_FpUnit_l84_1};
  assign _zz__zz_flagUF_101 = {30'd0, _zz_when_FpUnit_l84_1};
  assign _zz__zz_flagUF_101_1 = (_zz__zz_flagUF_101_2 - 54'h00000000000001);
  assign _zz__zz_flagUF_101_3 = ({63'd0,54'h00000000000001} <<< _zz__zz_flagUF_101_4);
  assign _zz__zz_flagUF_101_2 = _zz__zz_flagUF_101_3[53:0];
  assign _zz__zz_flagUF_101_4 = _zz_when_FpUnit_l330_7[5:0];
  assign _zz__zz_when_FpUnit_l84_162_1 = _zz_when_FpUnit_l84_160;
  assign _zz__zz_when_FpUnit_l84_162 = {1'd0, _zz__zz_when_FpUnit_l84_162_1};
  assign _zz__zz_when_FpUnit_l84_163_1 = _zz_when_FpUnit_l84_161;
  assign _zz__zz_when_FpUnit_l84_163 = {1'd0, _zz__zz_when_FpUnit_l84_163_1};
  assign _zz__zz_when_FpUnit_l84_164_1 = (_zz_when_FpUnit_l359_7 ? _zz__zz_when_FpUnit_l84_164_2 : _zz_when_FpUnit_l84_162);
  assign _zz__zz_when_FpUnit_l84_164 = {{1{_zz__zz_when_FpUnit_l84_164_1[54]}}, _zz__zz_when_FpUnit_l84_164_1};
  assign _zz__zz_when_FpUnit_l84_164_2 = (- _zz_when_FpUnit_l84_162);
  assign _zz__zz_when_FpUnit_l84_164_4 = (_zz_when_FpUnit_l359_8 ? _zz__zz_when_FpUnit_l84_164_5 : _zz_when_FpUnit_l84_163);
  assign _zz__zz_when_FpUnit_l84_164_3 = {{1{_zz__zz_when_FpUnit_l84_164_4[54]}}, _zz__zz_when_FpUnit_l84_164_4};
  assign _zz__zz_when_FpUnit_l84_164_5 = (- _zz_when_FpUnit_l84_163);
  assign _zz__zz_when_FpUnit_l84_166 = (- _zz_when_FpUnit_l84_164);
  assign _zz__zz_flagUF_104 = _zz__zz_flagUF_104_1;
  assign _zz__zz_flagUF_104_1 = {6'd0, _zz_when_FpUnit_l91_8};
  assign _zz__zz_flagUF_102_1 = (_zz_when_FpUnit_l84_166 >>> _zz_flagUF_105);
  assign _zz__zz_flagUF_102 = _zz__zz_flagUF_102_1[26:0];
  assign _zz__zz_flagUF_103 = (_zz__zz_flagUF_103_1 - 56'h00000000000001);
  assign _zz__zz_flagUF_103_2 = ({63'd0,56'h00000000000001} <<< _zz_flagUF_105);
  assign _zz__zz_flagUF_103_1 = _zz__zz_flagUF_103_2[55:0];
  assign _zz__zz_flagUF_102_3 = ({63'd0,_zz_when_FpUnit_l84_166} <<< _zz__zz_flagUF_102_4);
  assign _zz__zz_flagUF_102_2 = _zz__zz_flagUF_102_3[26:0];
  assign _zz__zz_flagUF_102_4 = (6'h1a - _zz_when_FpUnit_l91_8);
  assign _zz__zz_flagUF_107 = ($signed(_zz_flagUF_104) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l116_8 = ($signed(12'hf82) - $signed(_zz_flagUF_104));
  assign _zz__zz_flagUF_108 = (_zz_flagUF_102 >>> _zz_when_FpUnit_l119_8);
  assign _zz__zz_flagUF_109 = (_zz__zz_flagUF_109_1 - 27'h0000001);
  assign _zz__zz_flagUF_109_2 = ({31'd0,27'h0000001} <<< _zz__zz_flagUF_109_3);
  assign _zz__zz_flagUF_109_1 = _zz__zz_flagUF_109_2[26:0];
  assign _zz__zz_flagUF_109_3 = _zz_when_FpUnit_l119_8[4:0];
  assign _zz__zz_when_FpUnit_l150_42_1 = _zz_when_FpUnit_l150_41;
  assign _zz__zz_when_FpUnit_l150_42 = {1'd0, _zz__zz_when_FpUnit_l150_42_1};
  assign _zz__zz_when_FpUnit_l150_42_3 = ((io_rm == 3'b000) ? (_zz_flagUF_110 && ((_zz_flagUF_111 || _zz_flagUF_112) || _zz_when_FpUnit_l150_41[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_when_FpUnit_l84_165 && (_zz__zz_when_FpUnit_l150_42_4 || _zz_flagUF_112)) : ((io_rm == _zz__zz_when_FpUnit_l150_42_5) ? (_zz__zz_when_FpUnit_l150_42_6 && _zz__zz_when_FpUnit_l150_42_7) : _zz_flagUF_110))));
  assign _zz__zz_when_FpUnit_l150_42_2 = {24'd0, _zz__zz_when_FpUnit_l150_42_3};
  assign _zz__zz_res_57 = (_zz_when_FpUnit_l150_42 >>> 1'd1);
  assign _zz__zz_res_57_1 = _zz_when_FpUnit_l150_42[23:0];
  assign _zz__zz_when_FpUnit_l150_44 = (_zz_when_FpUnit_l150_43 ? _zz__zz_when_FpUnit_l150_44_1 : _zz_when_FpUnit_l150_40);
  assign _zz__zz_when_FpUnit_l150_44_1 = ($signed(_zz_when_FpUnit_l150_40) + $signed(12'h001));
  assign _zz__zz_res_60_1 = _zz_when_FpUnit_l150_44;
  assign _zz__zz_res_60 = _zz__zz_res_60_1[7:0];
  assign _zz__zz_when_FpUnit_l447 = {{2{_zz_when_FpUnit_l180[9]}}, _zz_when_FpUnit_l180};
  assign _zz__zz_flagNX_2 = (- _zz_when_FpUnit_l447);
  assign _zz__zz_when_FpUnit_l474 = (_zz_flagNX >>> _zz_flagNX_2);
  assign _zz__zz_flagNX_1 = (_zz__zz_flagNX_1_1 - 24'h000001);
  assign _zz__zz_flagNX_1_2 = ({31'd0,24'h000001} <<< _zz__zz_flagNX_1_3);
  assign _zz__zz_flagNX_1_1 = _zz__zz_flagNX_1_2[23:0];
  assign _zz__zz_flagNX_1_3 = _zz_flagNX_2[4:0];
  assign _zz__zz_when_FpUnit_l474_1 = ({63'd0,_zz__zz_when_FpUnit_l474_2} <<< _zz__zz_when_FpUnit_l474_3);
  assign _zz__zz_when_FpUnit_l474_2 = {10'd0, _zz_flagNX};
  assign _zz__zz_when_FpUnit_l474_4 = _zz_when_FpUnit_l447;
  assign _zz__zz_when_FpUnit_l474_3 = _zz__zz_when_FpUnit_l474_4[5:0];
  assign _zz__zz_when_FpUnit_l474_1_2 = ((io_rm == 3'b000) ? (_zz_flagNX_1 && _zz_when_FpUnit_l474[0]) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (when_FpUnit_l481 && _zz_flagNX_1) : ((io_rm == 3'b011) ? ((! when_FpUnit_l481) && _zz_flagNX_1) : _zz_flagNX_1))));
  assign _zz__zz_when_FpUnit_l474_1_1 = {33'd0, _zz__zz_when_FpUnit_l474_1_2};
  assign _zz__zz_res_62 = _zz_when_FpUnit_l474_1[31:0];
  assign _zz_res_93 = _zz_res_62;
  assign _zz_res_92 = {{32{_zz_res_93[31]}}, _zz_res_93};
  assign _zz__zz_when_FpUnit_l447_1 = {{2{_zz_when_FpUnit_l180[9]}}, _zz_when_FpUnit_l180};
  assign _zz__zz_flagNX_4 = (- _zz_when_FpUnit_l447_1);
  assign _zz__zz_when_FpUnit_l474_2_1 = (_zz_flagNX >>> _zz_flagNX_4);
  assign _zz__zz_flagNX_3 = (_zz__zz_flagNX_3_1 - 24'h000001);
  assign _zz__zz_flagNX_3_2 = ({31'd0,24'h000001} <<< _zz__zz_flagNX_3_3);
  assign _zz__zz_flagNX_3_1 = _zz__zz_flagNX_3_2[23:0];
  assign _zz__zz_flagNX_3_3 = _zz_flagNX_4[4:0];
  assign _zz__zz_when_FpUnit_l474_2_2 = ({63'd0,_zz__zz_when_FpUnit_l474_2_3} <<< _zz__zz_when_FpUnit_l474_2_4);
  assign _zz__zz_when_FpUnit_l474_2_3 = {10'd0, _zz_flagNX};
  assign _zz__zz_when_FpUnit_l474_2_5 = _zz_when_FpUnit_l447_1;
  assign _zz__zz_when_FpUnit_l474_2_4 = _zz__zz_when_FpUnit_l474_2_5[5:0];
  assign _zz__zz_when_FpUnit_l474_3_2 = ((io_rm == 3'b000) ? (_zz_flagNX_3 && _zz_when_FpUnit_l474_2[0]) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (when_FpUnit_l481 && _zz_flagNX_3) : ((io_rm == 3'b011) ? ((! when_FpUnit_l481) && _zz_flagNX_3) : _zz_flagNX_3))));
  assign _zz__zz_when_FpUnit_l474_3_1 = {33'd0, _zz__zz_when_FpUnit_l474_3_2};
  assign _zz__zz_res_63 = _zz_when_FpUnit_l474_3[31:0];
  assign _zz_res_94 = {32'd0, _zz_res_63};
  assign _zz__zz_when_FpUnit_l447_2 = {{2{_zz_when_FpUnit_l180[9]}}, _zz_when_FpUnit_l180};
  assign _zz__zz_flagNX_6 = (- _zz_when_FpUnit_l447_2);
  assign _zz__zz_when_FpUnit_l474_4_1 = (_zz_flagNX >>> _zz_flagNX_6);
  assign _zz__zz_flagNX_5 = (_zz__zz_flagNX_5_1 - 24'h000001);
  assign _zz__zz_flagNX_5_2 = ({31'd0,24'h000001} <<< _zz__zz_flagNX_5_3);
  assign _zz__zz_flagNX_5_1 = _zz__zz_flagNX_5_2[23:0];
  assign _zz__zz_flagNX_5_3 = _zz_flagNX_6[4:0];
  assign _zz__zz_when_FpUnit_l474_4_2 = ({127'd0,_zz__zz_when_FpUnit_l474_4_3} <<< _zz__zz_when_FpUnit_l474_4_4);
  assign _zz__zz_when_FpUnit_l474_4_3 = {42'd0, _zz_flagNX};
  assign _zz__zz_when_FpUnit_l474_4_5 = _zz_when_FpUnit_l447_2;
  assign _zz__zz_when_FpUnit_l474_4_4 = _zz__zz_when_FpUnit_l474_4_5[6:0];
  assign _zz__zz_when_FpUnit_l474_5_1 = ((io_rm == 3'b000) ? (_zz_flagNX_5 && _zz_when_FpUnit_l474_4[0]) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (when_FpUnit_l481 && _zz_flagNX_5) : ((io_rm == 3'b011) ? ((! when_FpUnit_l481) && _zz_flagNX_5) : _zz_flagNX_5))));
  assign _zz__zz_when_FpUnit_l474_5 = {65'd0, _zz__zz_when_FpUnit_l474_5_1};
  assign _zz__zz_res_64 = _zz_when_FpUnit_l474_5[63:0];
  assign _zz_res_95 = _zz_res_64;
  assign _zz__zz_when_FpUnit_l447_3 = {{2{_zz_when_FpUnit_l180[9]}}, _zz_when_FpUnit_l180};
  assign _zz__zz_flagNX_8 = (- _zz_when_FpUnit_l447_3);
  assign _zz__zz_when_FpUnit_l474_6 = (_zz_flagNX >>> _zz_flagNX_8);
  assign _zz__zz_flagNX_7 = (_zz__zz_flagNX_7_1 - 24'h000001);
  assign _zz__zz_flagNX_7_2 = ({31'd0,24'h000001} <<< _zz__zz_flagNX_7_3);
  assign _zz__zz_flagNX_7_1 = _zz__zz_flagNX_7_2[23:0];
  assign _zz__zz_flagNX_7_3 = _zz_flagNX_8[4:0];
  assign _zz__zz_when_FpUnit_l474_6_1 = ({127'd0,_zz__zz_when_FpUnit_l474_6_2} <<< _zz__zz_when_FpUnit_l474_6_3);
  assign _zz__zz_when_FpUnit_l474_6_2 = {42'd0, _zz_flagNX};
  assign _zz__zz_when_FpUnit_l474_6_4 = _zz_when_FpUnit_l447_3;
  assign _zz__zz_when_FpUnit_l474_6_3 = _zz__zz_when_FpUnit_l474_6_4[6:0];
  assign _zz__zz_when_FpUnit_l474_7_1 = ((io_rm == 3'b000) ? (_zz_flagNX_7 && _zz_when_FpUnit_l474_6[0]) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (when_FpUnit_l481 && _zz_flagNX_7) : ((io_rm == 3'b011) ? ((! when_FpUnit_l481) && _zz_flagNX_7) : _zz_flagNX_7))));
  assign _zz__zz_when_FpUnit_l474_7 = {65'd0, _zz__zz_when_FpUnit_l474_7_1};
  assign _zz__zz_res_65 = _zz_when_FpUnit_l474_7[63:0];
  assign _zz__zz_when_FpUnit_l84_168 = (56'h0 - _zz__zz_when_FpUnit_l84_168_1);
  assign _zz__zz_when_FpUnit_l84_168_1 = {24'd0, _zz_when_FpUnit_l84_167};
  assign _zz__zz_when_FpUnit_l84_168_2 = {24'd0, _zz_when_FpUnit_l84_167};
  assign _zz__zz_when_FpUnit_l116_9 = _zz__zz_when_FpUnit_l116_9_1;
  assign _zz__zz_when_FpUnit_l116_9_1 = {6'd0, _zz_when_FpUnit_l91_9};
  assign _zz__zz_flagNX_9_1 = (_zz_when_FpUnit_l84_168 >>> _zz_flagNX_11);
  assign _zz__zz_flagNX_9 = _zz__zz_flagNX_9_1[26:0];
  assign _zz__zz_flagNX_10 = (_zz__zz_flagNX_10_1 - 56'h00000000000001);
  assign _zz__zz_flagNX_10_2 = ({63'd0,56'h00000000000001} <<< _zz_flagNX_11);
  assign _zz__zz_flagNX_10_1 = _zz__zz_flagNX_10_2[55:0];
  assign _zz__zz_flagNX_9_3 = ({63'd0,_zz_when_FpUnit_l84_168} <<< _zz__zz_flagNX_9_4);
  assign _zz__zz_flagNX_9_2 = _zz__zz_flagNX_9_3[26:0];
  assign _zz__zz_flagNX_9_4 = (6'h1a - _zz_when_FpUnit_l91_9);
  assign _zz__zz_when_FpUnit_l116_10 = ($signed(_zz_when_FpUnit_l116_9) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l116_11 = ($signed(12'hf82) - $signed(_zz_when_FpUnit_l116_9));
  assign _zz__zz_flagNX_12 = (_zz_flagNX_9 >>> _zz_when_FpUnit_l119_9);
  assign _zz__zz_flagNX_13 = (_zz__zz_flagNX_13_1 - 27'h0000001);
  assign _zz__zz_flagNX_13_2 = ({31'd0,27'h0000001} <<< _zz__zz_flagNX_13_3);
  assign _zz__zz_flagNX_13_1 = _zz__zz_flagNX_13_2[26:0];
  assign _zz__zz_flagNX_13_3 = _zz_when_FpUnit_l119_9[4:0];
  assign _zz__zz_when_FpUnit_l150_47_1 = _zz_when_FpUnit_l150_46;
  assign _zz__zz_when_FpUnit_l150_47 = {1'd0, _zz__zz_when_FpUnit_l150_47_1};
  assign _zz__zz_when_FpUnit_l150_47_3 = ((io_rm == 3'b000) ? (_zz_flagNX_14 && ((_zz_flagNX_15 || _zz_flagNX_16) || _zz_when_FpUnit_l150_46[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_res_66 && (_zz__zz_when_FpUnit_l150_47_4 || _zz_flagNX_16)) : ((io_rm == _zz__zz_when_FpUnit_l150_47_5) ? (_zz__zz_when_FpUnit_l150_47_6 && _zz__zz_when_FpUnit_l150_47_7) : _zz_flagNX_14))));
  assign _zz__zz_when_FpUnit_l150_47_2 = {24'd0, _zz__zz_when_FpUnit_l150_47_3};
  assign _zz__zz_res_67 = (_zz_when_FpUnit_l150_47 >>> 1'd1);
  assign _zz__zz_res_67_1 = _zz_when_FpUnit_l150_47[23:0];
  assign _zz__zz_when_FpUnit_l150_49 = (_zz_when_FpUnit_l150_48 ? _zz__zz_when_FpUnit_l150_49_1 : _zz_when_FpUnit_l150_45);
  assign _zz__zz_when_FpUnit_l150_49_1 = ($signed(_zz_when_FpUnit_l150_45) + $signed(12'h001));
  assign _zz__zz_res_70_1 = _zz_when_FpUnit_l150_49;
  assign _zz__zz_res_70 = _zz__zz_res_70_1[7:0];
  assign _zz__zz_when_FpUnit_l84_170 = (56'h0 - _zz__zz_when_FpUnit_l84_170_1);
  assign _zz__zz_when_FpUnit_l84_170_1 = {24'd0, _zz_when_FpUnit_l84_169};
  assign _zz__zz_when_FpUnit_l84_170_2 = {24'd0, _zz_when_FpUnit_l84_169};
  assign _zz__zz_when_FpUnit_l116_12 = _zz__zz_when_FpUnit_l116_12_1;
  assign _zz__zz_when_FpUnit_l116_12_1 = {6'd0, _zz_when_FpUnit_l91_10};
  assign _zz__zz_flagNX_17_1 = (_zz_when_FpUnit_l84_170 >>> _zz_flagNX_19);
  assign _zz__zz_flagNX_17 = _zz__zz_flagNX_17_1[26:0];
  assign _zz__zz_flagNX_18 = (_zz__zz_flagNX_18_1 - 56'h00000000000001);
  assign _zz__zz_flagNX_18_2 = ({63'd0,56'h00000000000001} <<< _zz_flagNX_19);
  assign _zz__zz_flagNX_18_1 = _zz__zz_flagNX_18_2[55:0];
  assign _zz__zz_flagNX_17_3 = ({63'd0,_zz_when_FpUnit_l84_170} <<< _zz__zz_flagNX_17_4);
  assign _zz__zz_flagNX_17_2 = _zz__zz_flagNX_17_3[26:0];
  assign _zz__zz_flagNX_17_4 = (6'h1a - _zz_when_FpUnit_l91_10);
  assign _zz__zz_when_FpUnit_l116_13 = ($signed(_zz_when_FpUnit_l116_12) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l116_14 = ($signed(12'hf82) - $signed(_zz_when_FpUnit_l116_12));
  assign _zz__zz_flagNX_20 = (_zz_flagNX_17 >>> _zz_when_FpUnit_l119_10);
  assign _zz__zz_flagNX_21 = (_zz__zz_flagNX_21_1 - 27'h0000001);
  assign _zz__zz_flagNX_21_2 = ({31'd0,27'h0000001} <<< _zz__zz_flagNX_21_3);
  assign _zz__zz_flagNX_21_1 = _zz__zz_flagNX_21_2[26:0];
  assign _zz__zz_flagNX_21_3 = _zz_when_FpUnit_l119_10[4:0];
  assign _zz__zz_when_FpUnit_l150_52_1 = _zz_when_FpUnit_l150_51;
  assign _zz__zz_when_FpUnit_l150_52 = {1'd0, _zz__zz_when_FpUnit_l150_52_1};
  assign _zz__zz_when_FpUnit_l150_52_3 = ((io_rm == 3'b000) ? (_zz_flagNX_22 && ((_zz_flagNX_23 || _zz_flagNX_24) || _zz_when_FpUnit_l150_51[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_res_72 && (_zz__zz_when_FpUnit_l150_52_4 || _zz_flagNX_24)) : ((io_rm == _zz__zz_when_FpUnit_l150_52_5) ? (_zz__zz_when_FpUnit_l150_52_6 && _zz__zz_when_FpUnit_l150_52_7) : _zz_flagNX_22))));
  assign _zz__zz_when_FpUnit_l150_52_2 = {24'd0, _zz__zz_when_FpUnit_l150_52_3};
  assign _zz__zz_res_73 = (_zz_when_FpUnit_l150_52 >>> 1'd1);
  assign _zz__zz_res_73_1 = _zz_when_FpUnit_l150_52[23:0];
  assign _zz__zz_when_FpUnit_l150_54 = (_zz_when_FpUnit_l150_53 ? _zz__zz_when_FpUnit_l150_54_1 : _zz_when_FpUnit_l150_50);
  assign _zz__zz_when_FpUnit_l150_54_1 = ($signed(_zz_when_FpUnit_l150_50) + $signed(12'h001));
  assign _zz__zz_res_76_1 = _zz_when_FpUnit_l150_54;
  assign _zz__zz_res_76 = _zz__zz_res_76_1[7:0];
  assign _zz__zz_when_FpUnit_l84_172 = (88'h0 - _zz__zz_when_FpUnit_l84_172_1);
  assign _zz__zz_when_FpUnit_l84_172_1 = {24'd0, _zz_when_FpUnit_l84_171};
  assign _zz__zz_when_FpUnit_l84_172_2 = {24'd0, _zz_when_FpUnit_l84_171};
  assign _zz__zz_when_FpUnit_l116_15 = _zz__zz_when_FpUnit_l116_15_1;
  assign _zz__zz_when_FpUnit_l116_15_1 = {5'd0, _zz_when_FpUnit_l91_11};
  assign _zz__zz_flagNX_25_1 = (_zz_when_FpUnit_l84_172 >>> _zz_flagNX_27);
  assign _zz__zz_flagNX_25 = _zz__zz_flagNX_25_1[26:0];
  assign _zz__zz_flagNX_26 = (_zz__zz_flagNX_26_1 - 88'h0000000000000000000001);
  assign _zz__zz_flagNX_26_2 = ({127'd0,88'h0000000000000000000001} <<< _zz_flagNX_27);
  assign _zz__zz_flagNX_26_1 = _zz__zz_flagNX_26_2[87:0];
  assign _zz__zz_flagNX_25_3 = ({127'd0,_zz_when_FpUnit_l84_172} <<< _zz__zz_flagNX_25_4);
  assign _zz__zz_flagNX_25_2 = _zz__zz_flagNX_25_3[26:0];
  assign _zz__zz_flagNX_25_4 = (7'h1a - _zz_when_FpUnit_l91_11);
  assign _zz__zz_when_FpUnit_l116_16 = ($signed(_zz_when_FpUnit_l116_15) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l116_17 = ($signed(12'hf82) - $signed(_zz_when_FpUnit_l116_15));
  assign _zz__zz_flagNX_28 = (_zz_flagNX_25 >>> _zz_when_FpUnit_l119_11);
  assign _zz__zz_flagNX_29 = (_zz__zz_flagNX_29_1 - 27'h0000001);
  assign _zz__zz_flagNX_29_2 = ({31'd0,27'h0000001} <<< _zz__zz_flagNX_29_3);
  assign _zz__zz_flagNX_29_1 = _zz__zz_flagNX_29_2[26:0];
  assign _zz__zz_flagNX_29_3 = _zz_when_FpUnit_l119_11[4:0];
  assign _zz__zz_when_FpUnit_l150_57_1 = _zz_when_FpUnit_l150_56;
  assign _zz__zz_when_FpUnit_l150_57 = {1'd0, _zz__zz_when_FpUnit_l150_57_1};
  assign _zz__zz_when_FpUnit_l150_57_3 = ((io_rm == 3'b000) ? (_zz_flagNX_30 && ((_zz_flagNX_31 || _zz_flagNX_32) || _zz_when_FpUnit_l150_56[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_res_78 && (_zz__zz_when_FpUnit_l150_57_4 || _zz_flagNX_32)) : ((io_rm == _zz__zz_when_FpUnit_l150_57_5) ? (_zz__zz_when_FpUnit_l150_57_6 && _zz__zz_when_FpUnit_l150_57_7) : _zz_flagNX_30))));
  assign _zz__zz_when_FpUnit_l150_57_2 = {24'd0, _zz__zz_when_FpUnit_l150_57_3};
  assign _zz__zz_res_79 = (_zz_when_FpUnit_l150_57 >>> 1'd1);
  assign _zz__zz_res_79_1 = _zz_when_FpUnit_l150_57[23:0];
  assign _zz__zz_when_FpUnit_l150_59 = (_zz_when_FpUnit_l150_58 ? _zz__zz_when_FpUnit_l150_59_1 : _zz_when_FpUnit_l150_55);
  assign _zz__zz_when_FpUnit_l150_59_1 = ($signed(_zz_when_FpUnit_l150_55) + $signed(12'h001));
  assign _zz__zz_res_82_1 = _zz_when_FpUnit_l150_59;
  assign _zz__zz_res_82 = _zz__zz_res_82_1[7:0];
  assign _zz__zz_when_FpUnit_l84_174 = (88'h0 - _zz__zz_when_FpUnit_l84_174_1);
  assign _zz__zz_when_FpUnit_l84_174_1 = {24'd0, _zz_when_FpUnit_l84_173};
  assign _zz__zz_when_FpUnit_l84_174_2 = {24'd0, _zz_when_FpUnit_l84_173};
  assign _zz__zz_when_FpUnit_l116_18 = _zz__zz_when_FpUnit_l116_18_1;
  assign _zz__zz_when_FpUnit_l116_18_1 = {5'd0, _zz_when_FpUnit_l91_12};
  assign _zz__zz_flagNX_33_1 = (_zz_when_FpUnit_l84_174 >>> _zz_flagNX_35);
  assign _zz__zz_flagNX_33 = _zz__zz_flagNX_33_1[26:0];
  assign _zz__zz_flagNX_34 = (_zz__zz_flagNX_34_1 - 88'h0000000000000000000001);
  assign _zz__zz_flagNX_34_2 = ({127'd0,88'h0000000000000000000001} <<< _zz_flagNX_35);
  assign _zz__zz_flagNX_34_1 = _zz__zz_flagNX_34_2[87:0];
  assign _zz__zz_flagNX_33_3 = ({127'd0,_zz_when_FpUnit_l84_174} <<< _zz__zz_flagNX_33_4);
  assign _zz__zz_flagNX_33_2 = _zz__zz_flagNX_33_3[26:0];
  assign _zz__zz_flagNX_33_4 = (7'h1a - _zz_when_FpUnit_l91_12);
  assign _zz__zz_when_FpUnit_l116_19 = ($signed(_zz_when_FpUnit_l116_18) + $signed(12'h07f));
  assign _zz__zz_when_FpUnit_l116_20 = ($signed(12'hf82) - $signed(_zz_when_FpUnit_l116_18));
  assign _zz__zz_flagNX_36 = (_zz_flagNX_33 >>> _zz_when_FpUnit_l119_12);
  assign _zz__zz_flagNX_37 = (_zz__zz_flagNX_37_1 - 27'h0000001);
  assign _zz__zz_flagNX_37_2 = ({31'd0,27'h0000001} <<< _zz__zz_flagNX_37_3);
  assign _zz__zz_flagNX_37_1 = _zz__zz_flagNX_37_2[26:0];
  assign _zz__zz_flagNX_37_3 = _zz_when_FpUnit_l119_12[4:0];
  assign _zz__zz_when_FpUnit_l150_62_1 = _zz_when_FpUnit_l150_61;
  assign _zz__zz_when_FpUnit_l150_62 = {1'd0, _zz__zz_when_FpUnit_l150_62_1};
  assign _zz__zz_when_FpUnit_l150_62_3 = ((io_rm == 3'b000) ? (_zz_flagNX_38 && ((_zz_flagNX_39 || _zz_flagNX_40) || _zz_when_FpUnit_l150_61[0])) : ((io_rm == 3'b001) ? 1'b0 : ((io_rm == 3'b010) ? (_zz_res_84 && (_zz__zz_when_FpUnit_l150_62_4 || _zz_flagNX_40)) : ((io_rm == _zz__zz_when_FpUnit_l150_62_5) ? (_zz__zz_when_FpUnit_l150_62_6 && _zz__zz_when_FpUnit_l150_62_7) : _zz_flagNX_38))));
  assign _zz__zz_when_FpUnit_l150_62_2 = {24'd0, _zz__zz_when_FpUnit_l150_62_3};
  assign _zz__zz_res_85 = (_zz_when_FpUnit_l150_62 >>> 1'd1);
  assign _zz__zz_res_85_1 = _zz_when_FpUnit_l150_62[23:0];
  assign _zz__zz_when_FpUnit_l150_64 = (_zz_when_FpUnit_l150_63 ? _zz__zz_when_FpUnit_l150_64_1 : _zz_when_FpUnit_l150_60);
  assign _zz__zz_when_FpUnit_l150_64_1 = ($signed(_zz_when_FpUnit_l150_60) + $signed(12'h001));
  assign _zz__zz_res_88_1 = _zz_when_FpUnit_l150_64;
  assign _zz__zz_res_88 = _zz__zz_res_88_1[7:0];
  assign _zz__zz_when_FpUnit_l150_2_4 = (_zz_flagUF_7 || _zz_flagUF_8);
  assign _zz__zz_when_FpUnit_l150_2_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l150_2_6 = (! _zz_res_1);
  assign _zz__zz_when_FpUnit_l150_2_7 = ((_zz_flagUF_7 || _zz_flagUF_8) || _zz_flagUF_9);
  assign _zz__zz_when_FpUnit_l150_7_4 = (_zz_flagUF_18 || _zz_flagUF_19);
  assign _zz__zz_when_FpUnit_l150_7_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l150_7_6 = (! _zz_res_7);
  assign _zz__zz_when_FpUnit_l150_7_7 = ((_zz_flagUF_18 || _zz_flagUF_19) || _zz_flagUF_20);
  assign _zz__zz_when_FpUnit_l150_12_4 = (_zz_flagUF_29 || _zz_flagUF_30);
  assign _zz__zz_when_FpUnit_l150_12_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l150_12_6 = (! _zz_res_13);
  assign _zz__zz_when_FpUnit_l150_12_7 = ((_zz_flagUF_29 || _zz_flagUF_30) || _zz_flagUF_31);
  assign _zz__zz_when_FpUnit_l150_17_4 = (_zz_flagUF_41 || _zz_flagUF_42);
  assign _zz__zz_when_FpUnit_l150_17_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l150_17_6 = (! _zz_res_19);
  assign _zz__zz_when_FpUnit_l150_17_7 = ((_zz_flagUF_41 || _zz_flagUF_42) || _zz_flagUF_43);
  assign _zz__zz_when_FpUnit_l150_22_4 = (_zz_flagUF_54 || _zz_flagUF_55);
  assign _zz__zz_when_FpUnit_l150_22_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l150_22_6 = (! _zz_res_25);
  assign _zz__zz_when_FpUnit_l150_22_7 = ((_zz_flagUF_54 || _zz_flagUF_55) || _zz_flagUF_56);
  assign _zz__zz_when_FpUnit_l150_27_4 = (_zz_flagUF_68 || _zz_flagUF_69);
  assign _zz__zz_when_FpUnit_l150_27_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l150_27_6 = (! _zz_when_FpUnit_l84_141);
  assign _zz__zz_when_FpUnit_l150_27_7 = ((_zz_flagUF_68 || _zz_flagUF_69) || _zz_flagUF_70);
  assign _zz__zz_when_FpUnit_l150_32_4 = (_zz_flagUF_82 || _zz_flagUF_83);
  assign _zz__zz_when_FpUnit_l150_32_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l150_32_6 = (! _zz_when_FpUnit_l84_149);
  assign _zz__zz_when_FpUnit_l150_32_7 = ((_zz_flagUF_82 || _zz_flagUF_83) || _zz_flagUF_84);
  assign _zz__zz_when_FpUnit_l150_37_4 = (_zz_flagUF_96 || _zz_flagUF_97);
  assign _zz__zz_when_FpUnit_l150_37_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l150_37_6 = (! _zz_when_FpUnit_l84_157);
  assign _zz__zz_when_FpUnit_l150_37_7 = ((_zz_flagUF_96 || _zz_flagUF_97) || _zz_flagUF_98);
  assign _zz__zz_when_FpUnit_l150_42_4 = (_zz_flagUF_110 || _zz_flagUF_111);
  assign _zz__zz_when_FpUnit_l150_42_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l150_42_6 = (! _zz_when_FpUnit_l84_165);
  assign _zz__zz_when_FpUnit_l150_42_7 = ((_zz_flagUF_110 || _zz_flagUF_111) || _zz_flagUF_112);
  assign _zz__zz_when_FpUnit_l150_47_4 = (_zz_flagNX_14 || _zz_flagNX_15);
  assign _zz__zz_when_FpUnit_l150_47_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l150_47_6 = (! _zz_res_66);
  assign _zz__zz_when_FpUnit_l150_47_7 = ((_zz_flagNX_14 || _zz_flagNX_15) || _zz_flagNX_16);
  assign _zz__zz_when_FpUnit_l150_52_4 = (_zz_flagNX_22 || _zz_flagNX_23);
  assign _zz__zz_when_FpUnit_l150_52_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l150_52_6 = (! _zz_res_72);
  assign _zz__zz_when_FpUnit_l150_52_7 = ((_zz_flagNX_22 || _zz_flagNX_23) || _zz_flagNX_24);
  assign _zz__zz_when_FpUnit_l150_57_4 = (_zz_flagNX_30 || _zz_flagNX_31);
  assign _zz__zz_when_FpUnit_l150_57_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l150_57_6 = (! _zz_res_78);
  assign _zz__zz_when_FpUnit_l150_57_7 = ((_zz_flagNX_30 || _zz_flagNX_31) || _zz_flagNX_32);
  assign _zz__zz_when_FpUnit_l150_62_4 = (_zz_flagNX_38 || _zz_flagNX_39);
  assign _zz__zz_when_FpUnit_l150_62_5 = 3'b011;
  assign _zz__zz_when_FpUnit_l150_62_6 = (! _zz_res_84);
  assign _zz__zz_when_FpUnit_l150_62_7 = ((_zz_flagNX_38 || _zz_flagNX_39) || _zz_flagNX_40);
  assign when_FpUnit_l481 = io_a[31];
  assign _zz_when_FpUnit_l270 = io_a[30 : 23];
  assign _zz_when_FpUnit_l270_1 = io_a[22 : 0];
  assign _zz_when_FpUnit_l270_2 = (_zz_when_FpUnit_l270 == 8'h0);
  assign _zz_when_FpUnit_l206 = (&_zz_when_FpUnit_l270);
  assign _zz_when_FpUnit_l270_3 = (_zz_when_FpUnit_l270_1 == 23'h0);
  assign when_FpUnit_l270 = (_zz_when_FpUnit_l270_2 && _zz_when_FpUnit_l270_3);
  assign when_FpUnit_l206 = (_zz_when_FpUnit_l206 && _zz_when_FpUnit_l270_3);
  assign when_FpUnit_l304 = (_zz_when_FpUnit_l206 && (! _zz_when_FpUnit_l270_3));
  assign _zz_flagNV = (when_FpUnit_l304 && (! _zz_when_FpUnit_l270_1[22]));
  assign _zz_res = (_zz_when_FpUnit_l270_2 && (! _zz_when_FpUnit_l270_3));
  assign _zz_when_FpUnit_l180 = (_zz_when_FpUnit_l270_2 ? 10'h382 : _zz__zz_when_FpUnit_l180);
  assign _zz_flagNX = (_zz_when_FpUnit_l270_2 ? _zz__zz_flagNX : {1'b1,_zz_when_FpUnit_l270_1});
  assign _zz_when_FpUnit_l205 = io_b[31];
  assign _zz_when_FpUnit_l267 = io_b[30 : 23];
  assign _zz_when_FpUnit_l267_1 = io_b[22 : 0];
  assign _zz_when_FpUnit_l267_2 = (_zz_when_FpUnit_l267 == 8'h0);
  assign _zz_when_FpUnit_l207 = (&_zz_when_FpUnit_l267);
  assign _zz_when_FpUnit_l267_3 = (_zz_when_FpUnit_l267_1 == 23'h0);
  assign when_FpUnit_l267 = (_zz_when_FpUnit_l267_2 && _zz_when_FpUnit_l267_3);
  assign when_FpUnit_l207 = (_zz_when_FpUnit_l207 && _zz_when_FpUnit_l267_3);
  assign when_FpUnit_l393 = (_zz_when_FpUnit_l207 && (! _zz_when_FpUnit_l267_3));
  assign _zz_flagNV_1 = (when_FpUnit_l393 && (! _zz_when_FpUnit_l267_1[22]));
  assign _zz_when_FpUnit_l180_1 = (_zz_when_FpUnit_l267_2 ? 10'h382 : _zz__zz_when_FpUnit_l180_1_1);
  assign _zz_when_FpUnit_l84 = (_zz_when_FpUnit_l267_2 ? _zz__zz_when_FpUnit_l84 : {1'b1,_zz_when_FpUnit_l267_1});
  assign _zz_when_FpUnit_l359 = io_c[31];
  assign _zz_when_FpUnit_l361 = io_c[30 : 23];
  assign _zz_when_FpUnit_l361_1 = io_c[22 : 0];
  assign _zz_when_FpUnit_l329 = (_zz_when_FpUnit_l361 == 8'h0);
  assign _zz_when_FpUnit_l361_2 = (&_zz_when_FpUnit_l361);
  assign _zz_when_FpUnit_l361_3 = (_zz_when_FpUnit_l361_1 == 23'h0);
  assign when_FpUnit_l361 = (_zz_when_FpUnit_l361_2 && _zz_when_FpUnit_l361_3);
  assign _zz_when_FpUnit_l357 = (_zz_when_FpUnit_l361_2 && (! _zz_when_FpUnit_l361_3));
  assign _zz_flagNV_2 = (_zz_when_FpUnit_l357 && (! _zz_when_FpUnit_l361_1[22]));
  assign _zz_when_FpUnit_l329_1 = (_zz_when_FpUnit_l329 ? 10'h382 : _zz__zz_when_FpUnit_l329_1);
  assign _zz_when_FpUnit_l84_1 = (_zz_when_FpUnit_l329 ? _zz__zz_when_FpUnit_l84_1 : {1'b1,_zz_when_FpUnit_l361_1});
  always @(*) begin
    res = {32'd0, _zz_res_90};
    case(io_op)
      6'h0 : begin
        res = {32'd0, _zz_res_6};
      end
      6'h01 : begin
        res = {32'd0, _zz_res_12};
      end
      6'h02 : begin
        res = {32'd0, _zz_res_18};
      end
      6'h03 : begin
        res = {32'd0, _zz_res_24};
      end
      6'h04 : begin
        res = {32'd0, _zz_res_30};
      end
      6'h05 : begin
        res = {32'd0, _zz_res_33};
      end
      6'h06 : begin
        res = {32'd0, _zz_res_36};
      end
      6'h07, 6'h08, 6'h09 : begin
        res = {32'd0, _zz_res_37};
      end
      6'h0a, 6'h0b, 6'h0c : begin
        res = {32'd0, _zz_res_40};
      end
      6'h0d : begin
        res = {32'd0, _zz_res_91};
      end
      6'h0e : begin
        res = io_a;
      end
      6'h0f : begin
        res = io_a;
      end
      6'h18 : begin
        res = {32'd0, _zz_res_46};
      end
      6'h19 : begin
        res = {32'd0, _zz_res_51};
      end
      6'h1a : begin
        res = {32'd0, _zz_res_56};
      end
      6'h1b : begin
        res = {32'd0, _zz_res_61};
      end
      6'h10 : begin
        res = _zz_res_92;
      end
      6'h11 : begin
        res = _zz_res_94;
      end
      6'h12 : begin
        res = _zz_res_95;
      end
      6'h13 : begin
        res = _zz_res_65;
      end
      6'h14 : begin
        res = {32'd0, _zz_res_71};
      end
      6'h15 : begin
        res = {32'd0, _zz_res_77};
      end
      6'h16 : begin
        res = {32'd0, _zz_res_83};
      end
      6'h17 : begin
        res = {32'd0, _zz_res_89};
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
        if(when_FpUnit_l204) begin
          flagNV = (_zz_flagNV || _zz_flagNV_1);
        end else begin
          if(when_FpUnit_l205) begin
            flagNV = 1'b1;
          end
        end
      end
      6'h01 : begin
        if(when_FpUnit_l204_1) begin
          flagNV = (_zz_flagNV || _zz_flagNV_1);
        end else begin
          if(when_FpUnit_l205_1) begin
            flagNV = 1'b1;
          end
        end
      end
      6'h02 : begin
        if(when_FpUnit_l234) begin
          flagNV = (_zz_flagNV || _zz_flagNV_1);
        end else begin
          if(when_FpUnit_l235) begin
            flagNV = 1'b1;
          end
        end
      end
      6'h03 : begin
        if(when_FpUnit_l261) begin
          flagNV = (_zz_flagNV || _zz_flagNV_1);
        end else begin
          if(when_FpUnit_l262) begin
            flagNV = 1'b1;
          end
        end
      end
      6'h04 : begin
        if(when_FpUnit_l304) begin
          flagNV = _zz_flagNV;
        end else begin
          if(when_FpUnit_l305) begin
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
            flagNV = (when_FpUnit_l304 || when_FpUnit_l393);
          end
          6'h0c : begin
            flagNV = (when_FpUnit_l304 || when_FpUnit_l393);
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
        if(when_FpUnit_l357) begin
          flagNV = ((_zz_flagNV || _zz_flagNV_1) || _zz_flagNV_2);
        end else begin
          if(when_FpUnit_l358) begin
            flagNV = 1'b1;
          end else begin
            if(when_FpUnit_l359) begin
              flagNV = 1'b1;
            end
          end
        end
      end
      6'h19 : begin
        if(when_FpUnit_l357_1) begin
          flagNV = ((_zz_flagNV || _zz_flagNV_1) || _zz_flagNV_2);
        end else begin
          if(when_FpUnit_l358_1) begin
            flagNV = 1'b1;
          end else begin
            if(when_FpUnit_l359_1) begin
              flagNV = 1'b1;
            end
          end
        end
      end
      6'h1a : begin
        if(when_FpUnit_l357_2) begin
          flagNV = ((_zz_flagNV || _zz_flagNV_1) || _zz_flagNV_2);
        end else begin
          if(when_FpUnit_l358_2) begin
            flagNV = 1'b1;
          end else begin
            if(when_FpUnit_l359_2) begin
              flagNV = 1'b1;
            end
          end
        end
      end
      6'h1b : begin
        if(when_FpUnit_l357_3) begin
          flagNV = ((_zz_flagNV || _zz_flagNV_1) || _zz_flagNV_2);
        end else begin
          if(when_FpUnit_l358_3) begin
            flagNV = 1'b1;
          end else begin
            if(when_FpUnit_l359_3) begin
              flagNV = 1'b1;
            end
          end
        end
      end
      6'h10 : begin
        if(when_FpUnit_l474) begin
          flagNV = 1'b1;
        end
      end
      6'h11 : begin
        if(when_FpUnit_l474_1) begin
          flagNV = 1'b1;
        end
      end
      6'h12 : begin
        if(when_FpUnit_l474_2) begin
          flagNV = 1'b1;
        end
      end
      6'h13 : begin
        if(when_FpUnit_l474_3) begin
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
        if(!when_FpUnit_l261) begin
          if(!when_FpUnit_l262) begin
            if(!when_FpUnit_l206) begin
              if(!when_FpUnit_l207) begin
                if(when_FpUnit_l267) begin
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
      default : begin
      end
    endcase
  end

  always @(*) begin
    flagOF = 1'b0;
    case(io_op)
      6'h0 : begin
        if(!when_FpUnit_l204) begin
          if(!when_FpUnit_l205) begin
            if(!when_FpUnit_l206) begin
              if(!when_FpUnit_l207) begin
                if(!when_FpUnit_l208) begin
                  flagOF = when_FpUnit_l150;
                end
              end
            end
          end
        end
      end
      6'h01 : begin
        if(!when_FpUnit_l204_1) begin
          if(!when_FpUnit_l205_1) begin
            if(!when_FpUnit_l206) begin
              if(!when_FpUnit_l207) begin
                if(!when_FpUnit_l208_1) begin
                  flagOF = when_FpUnit_l150_1;
                end
              end
            end
          end
        end
      end
      6'h02 : begin
        if(!when_FpUnit_l234) begin
          if(!when_FpUnit_l235) begin
            if(!when_FpUnit_l236) begin
              if(!when_FpUnit_l237) begin
                flagOF = when_FpUnit_l150_2;
              end
            end
          end
        end
      end
      6'h03 : begin
        if(!when_FpUnit_l261) begin
          if(!when_FpUnit_l262) begin
            if(!when_FpUnit_l206) begin
              if(!when_FpUnit_l207) begin
                if(!when_FpUnit_l267) begin
                  if(!when_FpUnit_l270) begin
                    flagOF = when_FpUnit_l150_3;
                  end
                end
              end
            end
          end
        end
      end
      6'h04 : begin
        if(!when_FpUnit_l304) begin
          if(!when_FpUnit_l305) begin
            if(!when_FpUnit_l206) begin
              if(!when_FpUnit_l270) begin
                flagOF = when_FpUnit_l150_4;
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
        if(!when_FpUnit_l357) begin
          if(!when_FpUnit_l358) begin
            if(!when_FpUnit_l359) begin
              if(!when_FpUnit_l360) begin
                if(!when_FpUnit_l361) begin
                  flagOF = when_FpUnit_l150_5;
                end
              end
            end
          end
        end
      end
      6'h19 : begin
        if(!when_FpUnit_l357_1) begin
          if(!when_FpUnit_l358_1) begin
            if(!when_FpUnit_l359_1) begin
              if(!when_FpUnit_l360_1) begin
                if(!when_FpUnit_l361) begin
                  flagOF = when_FpUnit_l150_6;
                end
              end
            end
          end
        end
      end
      6'h1a : begin
        if(!when_FpUnit_l357_2) begin
          if(!when_FpUnit_l358_2) begin
            if(!when_FpUnit_l359_2) begin
              if(!when_FpUnit_l360_2) begin
                if(!when_FpUnit_l361) begin
                  flagOF = when_FpUnit_l150_7;
                end
              end
            end
          end
        end
      end
      6'h1b : begin
        if(!when_FpUnit_l357_3) begin
          if(!when_FpUnit_l358_3) begin
            if(!when_FpUnit_l359_3) begin
              if(!when_FpUnit_l360_3) begin
                if(!when_FpUnit_l361) begin
                  flagOF = when_FpUnit_l150_8;
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
        if(!when_FpUnit_l498) begin
          flagOF = when_FpUnit_l150_9;
        end
      end
      6'h15 : begin
        if(!when_FpUnit_l498_1) begin
          flagOF = when_FpUnit_l150_10;
        end
      end
      6'h16 : begin
        if(!when_FpUnit_l498_2) begin
          flagOF = when_FpUnit_l150_11;
        end
      end
      6'h17 : begin
        if(!when_FpUnit_l498_3) begin
          flagOF = when_FpUnit_l150_12;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    flagUF = 1'b0;
    case(io_op)
      6'h0 : begin
        if(!when_FpUnit_l204) begin
          if(!when_FpUnit_l205) begin
            if(!when_FpUnit_l206) begin
              if(!when_FpUnit_l207) begin
                if(!when_FpUnit_l208) begin
                  flagUF = (_zz_flagUF_4 && _zz_flagUF_10);
                end
              end
            end
          end
        end
      end
      6'h01 : begin
        if(!when_FpUnit_l204_1) begin
          if(!when_FpUnit_l205_1) begin
            if(!when_FpUnit_l206) begin
              if(!when_FpUnit_l207) begin
                if(!when_FpUnit_l208_1) begin
                  flagUF = (_zz_flagUF_15 && _zz_flagUF_21);
                end
              end
            end
          end
        end
      end
      6'h02 : begin
        if(!when_FpUnit_l234) begin
          if(!when_FpUnit_l235) begin
            if(!when_FpUnit_l236) begin
              if(!when_FpUnit_l237) begin
                flagUF = (_zz_flagUF_26 && _zz_flagUF_32);
              end
            end
          end
        end
      end
      6'h03 : begin
        if(!when_FpUnit_l261) begin
          if(!when_FpUnit_l262) begin
            if(!when_FpUnit_l206) begin
              if(!when_FpUnit_l207) begin
                if(!when_FpUnit_l267) begin
                  if(!when_FpUnit_l270) begin
                    flagUF = (_zz_flagUF_38 && _zz_flagUF_44);
                  end
                end
              end
            end
          end
        end
      end
      6'h04 : begin
        if(!when_FpUnit_l304) begin
          if(!when_FpUnit_l305) begin
            if(!when_FpUnit_l206) begin
              if(!when_FpUnit_l270) begin
                flagUF = (_zz_flagUF_51 && _zz_flagUF_57);
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
        if(!when_FpUnit_l357) begin
          if(!when_FpUnit_l358) begin
            if(!when_FpUnit_l359) begin
              if(!when_FpUnit_l360) begin
                if(!when_FpUnit_l361) begin
                  flagUF = (_zz_flagUF_65 && _zz_flagUF_71);
                end
              end
            end
          end
        end
      end
      6'h19 : begin
        if(!when_FpUnit_l357_1) begin
          if(!when_FpUnit_l358_1) begin
            if(!when_FpUnit_l359_1) begin
              if(!when_FpUnit_l360_1) begin
                if(!when_FpUnit_l361) begin
                  flagUF = (_zz_flagUF_79 && _zz_flagUF_85);
                end
              end
            end
          end
        end
      end
      6'h1a : begin
        if(!when_FpUnit_l357_2) begin
          if(!when_FpUnit_l358_2) begin
            if(!when_FpUnit_l359_2) begin
              if(!when_FpUnit_l360_2) begin
                if(!when_FpUnit_l361) begin
                  flagUF = (_zz_flagUF_93 && _zz_flagUF_99);
                end
              end
            end
          end
        end
      end
      6'h1b : begin
        if(!when_FpUnit_l357_3) begin
          if(!when_FpUnit_l358_3) begin
            if(!when_FpUnit_l359_3) begin
              if(!when_FpUnit_l360_3) begin
                if(!when_FpUnit_l361) begin
                  flagUF = (_zz_flagUF_107 && _zz_flagUF_113);
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
      default : begin
      end
    endcase
  end

  always @(*) begin
    flagNX = 1'b0;
    case(io_op)
      6'h0 : begin
        if(!when_FpUnit_l204) begin
          if(!when_FpUnit_l205) begin
            if(!when_FpUnit_l206) begin
              if(!when_FpUnit_l207) begin
                if(!when_FpUnit_l208) begin
                  flagNX = _zz_flagUF_10;
                end
              end
            end
          end
        end
      end
      6'h01 : begin
        if(!when_FpUnit_l204_1) begin
          if(!when_FpUnit_l205_1) begin
            if(!when_FpUnit_l206) begin
              if(!when_FpUnit_l207) begin
                if(!when_FpUnit_l208_1) begin
                  flagNX = _zz_flagUF_21;
                end
              end
            end
          end
        end
      end
      6'h02 : begin
        if(!when_FpUnit_l234) begin
          if(!when_FpUnit_l235) begin
            if(!when_FpUnit_l236) begin
              if(!when_FpUnit_l237) begin
                flagNX = _zz_flagUF_32;
              end
            end
          end
        end
      end
      6'h03 : begin
        if(!when_FpUnit_l261) begin
          if(!when_FpUnit_l262) begin
            if(!when_FpUnit_l206) begin
              if(!when_FpUnit_l207) begin
                if(!when_FpUnit_l267) begin
                  if(!when_FpUnit_l270) begin
                    flagNX = _zz_flagUF_44;
                  end
                end
              end
            end
          end
        end
      end
      6'h04 : begin
        if(!when_FpUnit_l304) begin
          if(!when_FpUnit_l305) begin
            if(!when_FpUnit_l206) begin
              if(!when_FpUnit_l270) begin
                flagNX = _zz_flagUF_57;
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
        if(!when_FpUnit_l357) begin
          if(!when_FpUnit_l358) begin
            if(!when_FpUnit_l359) begin
              if(!when_FpUnit_l360) begin
                if(!when_FpUnit_l361) begin
                  flagNX = _zz_flagUF_71;
                end
              end
            end
          end
        end
      end
      6'h19 : begin
        if(!when_FpUnit_l357_1) begin
          if(!when_FpUnit_l358_1) begin
            if(!when_FpUnit_l359_1) begin
              if(!when_FpUnit_l360_1) begin
                if(!when_FpUnit_l361) begin
                  flagNX = _zz_flagUF_85;
                end
              end
            end
          end
        end
      end
      6'h1a : begin
        if(!when_FpUnit_l357_2) begin
          if(!when_FpUnit_l358_2) begin
            if(!when_FpUnit_l359_2) begin
              if(!when_FpUnit_l360_2) begin
                if(!when_FpUnit_l361) begin
                  flagNX = _zz_flagUF_99;
                end
              end
            end
          end
        end
      end
      6'h1b : begin
        if(!when_FpUnit_l357_3) begin
          if(!when_FpUnit_l358_3) begin
            if(!when_FpUnit_l359_3) begin
              if(!when_FpUnit_l360_3) begin
                if(!when_FpUnit_l361) begin
                  flagNX = _zz_flagUF_113;
                end
              end
            end
          end
        end
      end
      6'h10 : begin
        if(!when_FpUnit_l474) begin
          flagNX = _zz_flagNX_1;
        end
      end
      6'h11 : begin
        if(!when_FpUnit_l474_1) begin
          flagNX = _zz_flagNX_3;
        end
      end
      6'h12 : begin
        if(!when_FpUnit_l474_2) begin
          flagNX = _zz_flagNX_5;
        end
      end
      6'h13 : begin
        if(!when_FpUnit_l474_3) begin
          flagNX = _zz_flagNX_7;
        end
      end
      6'h14 : begin
        if(!when_FpUnit_l498) begin
          flagNX = ((_zz_flagNX_14 || _zz_flagNX_15) || _zz_flagNX_16);
        end
      end
      6'h15 : begin
        if(!when_FpUnit_l498_1) begin
          flagNX = ((_zz_flagNX_22 || _zz_flagNX_23) || _zz_flagNX_24);
        end
      end
      6'h16 : begin
        if(!when_FpUnit_l498_2) begin
          flagNX = ((_zz_flagNX_30 || _zz_flagNX_31) || _zz_flagNX_32);
        end
      end
      6'h17 : begin
        if(!when_FpUnit_l498_3) begin
          flagNX = ((_zz_flagNX_38 || _zz_flagNX_39) || _zz_flagNX_40);
        end
      end
      default : begin
      end
    endcase
  end

  assign _zz_when_FpUnit_l205_1 = (_zz_when_FpUnit_l205 ^ 1'b0);
  assign _zz_when_FpUnit_l180_2 = ($signed(_zz_when_FpUnit_l180) < $signed(_zz_when_FpUnit_l180_1));
  assign _zz_when_FpUnit_l84_2 = (_zz_when_FpUnit_l180_2 ? _zz_when_FpUnit_l205_1 : when_FpUnit_l481);
  assign _zz_when_FpUnit_l84_3 = (_zz_when_FpUnit_l180_2 ? when_FpUnit_l481 : _zz_when_FpUnit_l205_1);
  assign _zz_when_FpUnit_l180_3 = (_zz_when_FpUnit_l180_2 ? _zz_when_FpUnit_l180_1 : _zz_when_FpUnit_l180);
  assign _zz_when_FpUnit_l84_4 = _zz__zz_when_FpUnit_l84_4[27:0];
  assign _zz_when_FpUnit_l180_4 = _zz__zz_when_FpUnit_l180_4;
  assign when_FpUnit_l180 = (10'h01c <= _zz_when_FpUnit_l180_4);
  always @(*) begin
    if(when_FpUnit_l180) begin
      _zz_when_FpUnit_l84_5 = 28'h0;
    end else begin
      _zz_when_FpUnit_l84_5 = _zz__zz_when_FpUnit_l84_5;
    end
  end

  assign _zz_when_FpUnit_l84_6 = (! (_zz_when_FpUnit_l84_2 == _zz_when_FpUnit_l84_3));
  assign _zz_when_FpUnit_l84_7 = _zz_when_FpUnit_l84_5;
  assign _zz_when_FpUnit_l84_8 = (_zz_when_FpUnit_l84_6 && (_zz_when_FpUnit_l84_4 < _zz_when_FpUnit_l84_7));
  assign _zz_when_FpUnit_l84_9 = (_zz_when_FpUnit_l84_6 ? (_zz_when_FpUnit_l84_8 ? _zz__zz_when_FpUnit_l84_9 : _zz__zz_when_FpUnit_l84_9_1) : _zz__zz_when_FpUnit_l84_9_2);
  assign _zz_res_1 = (_zz_when_FpUnit_l84_8 ? _zz_when_FpUnit_l84_3 : _zz_when_FpUnit_l84_2);
  always @(*) begin
    _zz_when_FpUnit_l91 = 5'h0;
    if(when_FpUnit_l84) begin
      _zz_when_FpUnit_l91 = 5'h0;
    end
    if(when_FpUnit_l84_1) begin
      _zz_when_FpUnit_l91 = 5'h01;
    end
    if(when_FpUnit_l84_2) begin
      _zz_when_FpUnit_l91 = 5'h02;
    end
    if(when_FpUnit_l84_3) begin
      _zz_when_FpUnit_l91 = 5'h03;
    end
    if(when_FpUnit_l84_4) begin
      _zz_when_FpUnit_l91 = 5'h04;
    end
    if(when_FpUnit_l84_5) begin
      _zz_when_FpUnit_l91 = 5'h05;
    end
    if(when_FpUnit_l84_6) begin
      _zz_when_FpUnit_l91 = 5'h06;
    end
    if(when_FpUnit_l84_7) begin
      _zz_when_FpUnit_l91 = 5'h07;
    end
    if(when_FpUnit_l84_8) begin
      _zz_when_FpUnit_l91 = 5'h08;
    end
    if(when_FpUnit_l84_9) begin
      _zz_when_FpUnit_l91 = 5'h09;
    end
    if(when_FpUnit_l84_10) begin
      _zz_when_FpUnit_l91 = 5'h0a;
    end
    if(when_FpUnit_l84_11) begin
      _zz_when_FpUnit_l91 = 5'h0b;
    end
    if(when_FpUnit_l84_12) begin
      _zz_when_FpUnit_l91 = 5'h0c;
    end
    if(when_FpUnit_l84_13) begin
      _zz_when_FpUnit_l91 = 5'h0d;
    end
    if(when_FpUnit_l84_14) begin
      _zz_when_FpUnit_l91 = 5'h0e;
    end
    if(when_FpUnit_l84_15) begin
      _zz_when_FpUnit_l91 = 5'h0f;
    end
    if(when_FpUnit_l84_16) begin
      _zz_when_FpUnit_l91 = 5'h10;
    end
    if(when_FpUnit_l84_17) begin
      _zz_when_FpUnit_l91 = 5'h11;
    end
    if(when_FpUnit_l84_18) begin
      _zz_when_FpUnit_l91 = 5'h12;
    end
    if(when_FpUnit_l84_19) begin
      _zz_when_FpUnit_l91 = 5'h13;
    end
    if(when_FpUnit_l84_20) begin
      _zz_when_FpUnit_l91 = 5'h14;
    end
    if(when_FpUnit_l84_21) begin
      _zz_when_FpUnit_l91 = 5'h15;
    end
    if(when_FpUnit_l84_22) begin
      _zz_when_FpUnit_l91 = 5'h16;
    end
    if(when_FpUnit_l84_23) begin
      _zz_when_FpUnit_l91 = 5'h17;
    end
    if(when_FpUnit_l84_24) begin
      _zz_when_FpUnit_l91 = 5'h18;
    end
    if(when_FpUnit_l84_25) begin
      _zz_when_FpUnit_l91 = 5'h19;
    end
    if(when_FpUnit_l84_26) begin
      _zz_when_FpUnit_l91 = 5'h1a;
    end
    if(when_FpUnit_l84_27) begin
      _zz_when_FpUnit_l91 = 5'h1b;
    end
  end

  assign when_FpUnit_l84 = _zz_when_FpUnit_l84_9[0];
  assign when_FpUnit_l84_1 = _zz_when_FpUnit_l84_9[1];
  assign when_FpUnit_l84_2 = _zz_when_FpUnit_l84_9[2];
  assign when_FpUnit_l84_3 = _zz_when_FpUnit_l84_9[3];
  assign when_FpUnit_l84_4 = _zz_when_FpUnit_l84_9[4];
  assign when_FpUnit_l84_5 = _zz_when_FpUnit_l84_9[5];
  assign when_FpUnit_l84_6 = _zz_when_FpUnit_l84_9[6];
  assign when_FpUnit_l84_7 = _zz_when_FpUnit_l84_9[7];
  assign when_FpUnit_l84_8 = _zz_when_FpUnit_l84_9[8];
  assign when_FpUnit_l84_9 = _zz_when_FpUnit_l84_9[9];
  assign when_FpUnit_l84_10 = _zz_when_FpUnit_l84_9[10];
  assign when_FpUnit_l84_11 = _zz_when_FpUnit_l84_9[11];
  assign when_FpUnit_l84_12 = _zz_when_FpUnit_l84_9[12];
  assign when_FpUnit_l84_13 = _zz_when_FpUnit_l84_9[13];
  assign when_FpUnit_l84_14 = _zz_when_FpUnit_l84_9[14];
  assign when_FpUnit_l84_15 = _zz_when_FpUnit_l84_9[15];
  assign when_FpUnit_l84_16 = _zz_when_FpUnit_l84_9[16];
  assign when_FpUnit_l84_17 = _zz_when_FpUnit_l84_9[17];
  assign when_FpUnit_l84_18 = _zz_when_FpUnit_l84_9[18];
  assign when_FpUnit_l84_19 = _zz_when_FpUnit_l84_9[19];
  assign when_FpUnit_l84_20 = _zz_when_FpUnit_l84_9[20];
  assign when_FpUnit_l84_21 = _zz_when_FpUnit_l84_9[21];
  assign when_FpUnit_l84_22 = _zz_when_FpUnit_l84_9[22];
  assign when_FpUnit_l84_23 = _zz_when_FpUnit_l84_9[23];
  assign when_FpUnit_l84_24 = _zz_when_FpUnit_l84_9[24];
  assign when_FpUnit_l84_25 = _zz_when_FpUnit_l84_9[25];
  assign when_FpUnit_l84_26 = _zz_when_FpUnit_l84_9[26];
  assign when_FpUnit_l84_27 = _zz_when_FpUnit_l84_9[27];
  always @(*) begin
    _zz_flagUF = 27'h0;
    if(when_FpUnit_l90) begin
      if(when_FpUnit_l91) begin
        _zz_flagUF = _zz__zz_flagUF;
      end else begin
        _zz_flagUF = _zz__zz_flagUF_3;
      end
    end
  end

  always @(*) begin
    _zz_flagUF_1 = 1'b0;
    if(when_FpUnit_l90) begin
      if(when_FpUnit_l91) begin
        _zz_flagUF_1 = (|(_zz_when_FpUnit_l84_9 & _zz__zz_flagUF_1_1));
      end else begin
        _zz_flagUF_1 = 1'b0;
      end
    end
  end

  assign _zz_flagUF_2 = ($signed(_zz__zz_flagUF_2) + $signed(_zz__zz_flagUF_2_2));
  assign when_FpUnit_l90 = (_zz_when_FpUnit_l84_9 != 28'h0);
  assign when_FpUnit_l91 = (5'h1a < _zz_when_FpUnit_l91);
  assign _zz_flagUF_3 = (_zz_when_FpUnit_l91 - 5'h1a);
  assign when_FpUnit_l208 = (_zz_when_FpUnit_l84_9 == 28'h0);
  assign _zz_flagUF_4 = ($signed(_zz__zz_flagUF_4_1) < $signed(12'h001));
  assign _zz_when_FpUnit_l116 = (_zz_flagUF_4 ? _zz__zz_when_FpUnit_l116 : 12'h0);
  assign _zz_when_FpUnit_l119 = _zz_when_FpUnit_l116;
  assign when_FpUnit_l116 = ($signed(_zz_when_FpUnit_l116) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l116) begin
      _zz_flagUF_5 = _zz_flagUF;
    end else begin
      if(when_FpUnit_l119) begin
        _zz_flagUF_5 = 27'h0;
      end else begin
        _zz_flagUF_5 = _zz__zz_flagUF_5_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l116) begin
      _zz_flagUF_6 = _zz_flagUF_1;
    end else begin
      if(when_FpUnit_l119) begin
        _zz_flagUF_6 = ((|_zz_flagUF) || _zz_flagUF_1);
      end else begin
        _zz_flagUF_6 = ((|(_zz_flagUF & _zz__zz_flagUF_6)) || _zz_flagUF_1);
      end
    end
  end

  assign when_FpUnit_l119 = (12'h01b <= _zz_when_FpUnit_l119);
  assign _zz_when_FpUnit_l150 = (_zz_flagUF_4 ? 12'hf82 : _zz_flagUF_2);
  assign _zz_flagUF_7 = _zz_flagUF_5[2];
  assign _zz_flagUF_8 = _zz_flagUF_5[1];
  assign _zz_flagUF_9 = (_zz_flagUF_5[0] || _zz_flagUF_6);
  assign _zz_when_FpUnit_l150_1 = _zz_flagUF_5[26 : 3];
  assign _zz_when_FpUnit_l150_2 = (_zz__zz_when_FpUnit_l150_2 + _zz__zz_when_FpUnit_l150_2_2);
  assign _zz_when_FpUnit_l150_3 = _zz_when_FpUnit_l150_2[24];
  assign _zz_res_2 = (_zz_when_FpUnit_l150_3 ? _zz__zz_res_2 : _zz__zz_res_2_1);
  assign _zz_when_FpUnit_l150_4 = ($signed(_zz__zz_when_FpUnit_l150_4) + $signed(12'h07f));
  assign _zz_flagUF_10 = ((_zz_flagUF_7 || _zz_flagUF_8) || _zz_flagUF_9);
  assign when_FpUnit_l150 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l150_4));
  assign _zz_res_3 = {_zz_res_1,{8'hff,23'h0}};
  assign _zz_res_4 = {_zz_res_1,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_5 = 32'h0;
    if(when_FpUnit_l150) begin
      _zz_res_5 = ((io_rm == 3'b001) ? _zz_res_4 : ((io_rm == 3'b010) ? (_zz_res_1 ? _zz_res_3 : _zz_res_4) : ((io_rm == 3'b011) ? (_zz_res_1 ? _zz_res_4 : _zz_res_3) : _zz_res_3)));
    end else begin
      if(when_FpUnit_l154) begin
        _zz_res_5 = {_zz_res_1,{8'h0,_zz_res_2[22 : 0]}};
      end else begin
        _zz_res_5 = {_zz_res_1,{_zz__zz_res_5,_zz_res_2[22 : 0]}};
      end
    end
  end

  assign when_FpUnit_l154 = ($signed(_zz_when_FpUnit_l150_4) < $signed(12'h001));
  always @(*) begin
    _zz_res_6 = _zz_res_5;
    if(when_FpUnit_l204) begin
      _zz_res_6 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l205) begin
        _zz_res_6 = 32'h7fc00000;
      end else begin
        if(when_FpUnit_l206) begin
          _zz_res_6 = {when_FpUnit_l481,{8'hff,23'h0}};
        end else begin
          if(when_FpUnit_l207) begin
            _zz_res_6 = {_zz_when_FpUnit_l205_1,{8'hff,23'h0}};
          end else begin
            if(when_FpUnit_l208) begin
              _zz_res_6 = {((io_rm == 3'b010) ? 1'b1 : 1'b0),{8'h0,23'h0}};
            end
          end
        end
      end
    end
  end

  assign when_FpUnit_l204 = (when_FpUnit_l304 || when_FpUnit_l393);
  assign when_FpUnit_l205 = ((when_FpUnit_l206 && when_FpUnit_l207) && (when_FpUnit_l481 != _zz_when_FpUnit_l205_1));
  assign _zz_when_FpUnit_l205_2 = (_zz_when_FpUnit_l205 ^ 1'b1);
  assign _zz_when_FpUnit_l180_5 = ($signed(_zz_when_FpUnit_l180) < $signed(_zz_when_FpUnit_l180_1));
  assign _zz_when_FpUnit_l84_10 = (_zz_when_FpUnit_l180_5 ? _zz_when_FpUnit_l205_2 : when_FpUnit_l481);
  assign _zz_when_FpUnit_l84_11 = (_zz_when_FpUnit_l180_5 ? when_FpUnit_l481 : _zz_when_FpUnit_l205_2);
  assign _zz_when_FpUnit_l180_6 = (_zz_when_FpUnit_l180_5 ? _zz_when_FpUnit_l180_1 : _zz_when_FpUnit_l180);
  assign _zz_when_FpUnit_l84_12 = _zz__zz_when_FpUnit_l84_12[27:0];
  assign _zz_when_FpUnit_l180_7 = _zz__zz_when_FpUnit_l180_7;
  assign when_FpUnit_l180_1 = (10'h01c <= _zz_when_FpUnit_l180_7);
  always @(*) begin
    if(when_FpUnit_l180_1) begin
      _zz_when_FpUnit_l84_13 = 28'h0;
    end else begin
      _zz_when_FpUnit_l84_13 = _zz__zz_when_FpUnit_l84_13;
    end
  end

  assign _zz_when_FpUnit_l84_14 = (! (_zz_when_FpUnit_l84_10 == _zz_when_FpUnit_l84_11));
  assign _zz_when_FpUnit_l84_15 = _zz_when_FpUnit_l84_13;
  assign _zz_when_FpUnit_l84_16 = (_zz_when_FpUnit_l84_14 && (_zz_when_FpUnit_l84_12 < _zz_when_FpUnit_l84_15));
  assign _zz_when_FpUnit_l84_17 = (_zz_when_FpUnit_l84_14 ? (_zz_when_FpUnit_l84_16 ? _zz__zz_when_FpUnit_l84_17 : _zz__zz_when_FpUnit_l84_17_1) : _zz__zz_when_FpUnit_l84_17_2);
  assign _zz_res_7 = (_zz_when_FpUnit_l84_16 ? _zz_when_FpUnit_l84_11 : _zz_when_FpUnit_l84_10);
  always @(*) begin
    _zz_when_FpUnit_l91_1 = 5'h0;
    if(when_FpUnit_l84_28) begin
      _zz_when_FpUnit_l91_1 = 5'h0;
    end
    if(when_FpUnit_l84_29) begin
      _zz_when_FpUnit_l91_1 = 5'h01;
    end
    if(when_FpUnit_l84_30) begin
      _zz_when_FpUnit_l91_1 = 5'h02;
    end
    if(when_FpUnit_l84_31) begin
      _zz_when_FpUnit_l91_1 = 5'h03;
    end
    if(when_FpUnit_l84_32) begin
      _zz_when_FpUnit_l91_1 = 5'h04;
    end
    if(when_FpUnit_l84_33) begin
      _zz_when_FpUnit_l91_1 = 5'h05;
    end
    if(when_FpUnit_l84_34) begin
      _zz_when_FpUnit_l91_1 = 5'h06;
    end
    if(when_FpUnit_l84_35) begin
      _zz_when_FpUnit_l91_1 = 5'h07;
    end
    if(when_FpUnit_l84_36) begin
      _zz_when_FpUnit_l91_1 = 5'h08;
    end
    if(when_FpUnit_l84_37) begin
      _zz_when_FpUnit_l91_1 = 5'h09;
    end
    if(when_FpUnit_l84_38) begin
      _zz_when_FpUnit_l91_1 = 5'h0a;
    end
    if(when_FpUnit_l84_39) begin
      _zz_when_FpUnit_l91_1 = 5'h0b;
    end
    if(when_FpUnit_l84_40) begin
      _zz_when_FpUnit_l91_1 = 5'h0c;
    end
    if(when_FpUnit_l84_41) begin
      _zz_when_FpUnit_l91_1 = 5'h0d;
    end
    if(when_FpUnit_l84_42) begin
      _zz_when_FpUnit_l91_1 = 5'h0e;
    end
    if(when_FpUnit_l84_43) begin
      _zz_when_FpUnit_l91_1 = 5'h0f;
    end
    if(when_FpUnit_l84_44) begin
      _zz_when_FpUnit_l91_1 = 5'h10;
    end
    if(when_FpUnit_l84_45) begin
      _zz_when_FpUnit_l91_1 = 5'h11;
    end
    if(when_FpUnit_l84_46) begin
      _zz_when_FpUnit_l91_1 = 5'h12;
    end
    if(when_FpUnit_l84_47) begin
      _zz_when_FpUnit_l91_1 = 5'h13;
    end
    if(when_FpUnit_l84_48) begin
      _zz_when_FpUnit_l91_1 = 5'h14;
    end
    if(when_FpUnit_l84_49) begin
      _zz_when_FpUnit_l91_1 = 5'h15;
    end
    if(when_FpUnit_l84_50) begin
      _zz_when_FpUnit_l91_1 = 5'h16;
    end
    if(when_FpUnit_l84_51) begin
      _zz_when_FpUnit_l91_1 = 5'h17;
    end
    if(when_FpUnit_l84_52) begin
      _zz_when_FpUnit_l91_1 = 5'h18;
    end
    if(when_FpUnit_l84_53) begin
      _zz_when_FpUnit_l91_1 = 5'h19;
    end
    if(when_FpUnit_l84_54) begin
      _zz_when_FpUnit_l91_1 = 5'h1a;
    end
    if(when_FpUnit_l84_55) begin
      _zz_when_FpUnit_l91_1 = 5'h1b;
    end
  end

  assign when_FpUnit_l84_28 = _zz_when_FpUnit_l84_17[0];
  assign when_FpUnit_l84_29 = _zz_when_FpUnit_l84_17[1];
  assign when_FpUnit_l84_30 = _zz_when_FpUnit_l84_17[2];
  assign when_FpUnit_l84_31 = _zz_when_FpUnit_l84_17[3];
  assign when_FpUnit_l84_32 = _zz_when_FpUnit_l84_17[4];
  assign when_FpUnit_l84_33 = _zz_when_FpUnit_l84_17[5];
  assign when_FpUnit_l84_34 = _zz_when_FpUnit_l84_17[6];
  assign when_FpUnit_l84_35 = _zz_when_FpUnit_l84_17[7];
  assign when_FpUnit_l84_36 = _zz_when_FpUnit_l84_17[8];
  assign when_FpUnit_l84_37 = _zz_when_FpUnit_l84_17[9];
  assign when_FpUnit_l84_38 = _zz_when_FpUnit_l84_17[10];
  assign when_FpUnit_l84_39 = _zz_when_FpUnit_l84_17[11];
  assign when_FpUnit_l84_40 = _zz_when_FpUnit_l84_17[12];
  assign when_FpUnit_l84_41 = _zz_when_FpUnit_l84_17[13];
  assign when_FpUnit_l84_42 = _zz_when_FpUnit_l84_17[14];
  assign when_FpUnit_l84_43 = _zz_when_FpUnit_l84_17[15];
  assign when_FpUnit_l84_44 = _zz_when_FpUnit_l84_17[16];
  assign when_FpUnit_l84_45 = _zz_when_FpUnit_l84_17[17];
  assign when_FpUnit_l84_46 = _zz_when_FpUnit_l84_17[18];
  assign when_FpUnit_l84_47 = _zz_when_FpUnit_l84_17[19];
  assign when_FpUnit_l84_48 = _zz_when_FpUnit_l84_17[20];
  assign when_FpUnit_l84_49 = _zz_when_FpUnit_l84_17[21];
  assign when_FpUnit_l84_50 = _zz_when_FpUnit_l84_17[22];
  assign when_FpUnit_l84_51 = _zz_when_FpUnit_l84_17[23];
  assign when_FpUnit_l84_52 = _zz_when_FpUnit_l84_17[24];
  assign when_FpUnit_l84_53 = _zz_when_FpUnit_l84_17[25];
  assign when_FpUnit_l84_54 = _zz_when_FpUnit_l84_17[26];
  assign when_FpUnit_l84_55 = _zz_when_FpUnit_l84_17[27];
  always @(*) begin
    _zz_flagUF_11 = 27'h0;
    if(when_FpUnit_l90_1) begin
      if(when_FpUnit_l91_1) begin
        _zz_flagUF_11 = _zz__zz_flagUF_11;
      end else begin
        _zz_flagUF_11 = _zz__zz_flagUF_11_2;
      end
    end
  end

  always @(*) begin
    _zz_flagUF_12 = 1'b0;
    if(when_FpUnit_l90_1) begin
      if(when_FpUnit_l91_1) begin
        _zz_flagUF_12 = (|(_zz_when_FpUnit_l84_17 & _zz__zz_flagUF_12));
      end else begin
        _zz_flagUF_12 = 1'b0;
      end
    end
  end

  assign _zz_flagUF_13 = ($signed(_zz__zz_flagUF_13) + $signed(_zz__zz_flagUF_13_2));
  assign when_FpUnit_l90_1 = (_zz_when_FpUnit_l84_17 != 28'h0);
  assign when_FpUnit_l91_1 = (5'h1a < _zz_when_FpUnit_l91_1);
  assign _zz_flagUF_14 = (_zz_when_FpUnit_l91_1 - 5'h1a);
  assign when_FpUnit_l208_1 = (_zz_when_FpUnit_l84_17 == 28'h0);
  assign _zz_flagUF_15 = ($signed(_zz__zz_flagUF_15) < $signed(12'h001));
  assign _zz_when_FpUnit_l116_1 = (_zz_flagUF_15 ? _zz__zz_when_FpUnit_l116_1 : 12'h0);
  assign _zz_when_FpUnit_l119_1 = _zz_when_FpUnit_l116_1;
  assign when_FpUnit_l116_1 = ($signed(_zz_when_FpUnit_l116_1) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l116_1) begin
      _zz_flagUF_16 = _zz_flagUF_11;
    end else begin
      if(when_FpUnit_l119_1) begin
        _zz_flagUF_16 = 27'h0;
      end else begin
        _zz_flagUF_16 = _zz__zz_flagUF_16;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l116_1) begin
      _zz_flagUF_17 = _zz_flagUF_12;
    end else begin
      if(when_FpUnit_l119_1) begin
        _zz_flagUF_17 = ((|_zz_flagUF_11) || _zz_flagUF_12);
      end else begin
        _zz_flagUF_17 = ((|(_zz_flagUF_11 & _zz__zz_flagUF_17)) || _zz_flagUF_12);
      end
    end
  end

  assign when_FpUnit_l119_1 = (12'h01b <= _zz_when_FpUnit_l119_1);
  assign _zz_when_FpUnit_l150_5 = (_zz_flagUF_15 ? 12'hf82 : _zz_flagUF_13);
  assign _zz_flagUF_18 = _zz_flagUF_16[2];
  assign _zz_flagUF_19 = _zz_flagUF_16[1];
  assign _zz_flagUF_20 = (_zz_flagUF_16[0] || _zz_flagUF_17);
  assign _zz_when_FpUnit_l150_6 = _zz_flagUF_16[26 : 3];
  assign _zz_when_FpUnit_l150_7 = (_zz__zz_when_FpUnit_l150_7 + _zz__zz_when_FpUnit_l150_7_2);
  assign _zz_when_FpUnit_l150_8 = _zz_when_FpUnit_l150_7[24];
  assign _zz_res_8 = (_zz_when_FpUnit_l150_8 ? _zz__zz_res_8 : _zz__zz_res_8_1);
  assign _zz_when_FpUnit_l150_9 = ($signed(_zz__zz_when_FpUnit_l150_9) + $signed(12'h07f));
  assign _zz_flagUF_21 = ((_zz_flagUF_18 || _zz_flagUF_19) || _zz_flagUF_20);
  assign when_FpUnit_l150_1 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l150_9));
  assign _zz_res_9 = {_zz_res_7,{8'hff,23'h0}};
  assign _zz_res_10 = {_zz_res_7,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_11 = 32'h0;
    if(when_FpUnit_l150_1) begin
      _zz_res_11 = ((io_rm == 3'b001) ? _zz_res_10 : ((io_rm == 3'b010) ? (_zz_res_7 ? _zz_res_9 : _zz_res_10) : ((io_rm == 3'b011) ? (_zz_res_7 ? _zz_res_10 : _zz_res_9) : _zz_res_9)));
    end else begin
      if(when_FpUnit_l154_1) begin
        _zz_res_11 = {_zz_res_7,{8'h0,_zz_res_8[22 : 0]}};
      end else begin
        _zz_res_11 = {_zz_res_7,{_zz__zz_res_11,_zz_res_8[22 : 0]}};
      end
    end
  end

  assign when_FpUnit_l154_1 = ($signed(_zz_when_FpUnit_l150_9) < $signed(12'h001));
  always @(*) begin
    _zz_res_12 = _zz_res_11;
    if(when_FpUnit_l204_1) begin
      _zz_res_12 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l205_1) begin
        _zz_res_12 = 32'h7fc00000;
      end else begin
        if(when_FpUnit_l206) begin
          _zz_res_12 = {when_FpUnit_l481,{8'hff,23'h0}};
        end else begin
          if(when_FpUnit_l207) begin
            _zz_res_12 = {_zz_when_FpUnit_l205_2,{8'hff,23'h0}};
          end else begin
            if(when_FpUnit_l208_1) begin
              _zz_res_12 = {((io_rm == 3'b010) ? 1'b1 : 1'b0),{8'h0,23'h0}};
            end
          end
        end
      end
    end
  end

  assign when_FpUnit_l204_1 = (when_FpUnit_l304 || when_FpUnit_l393);
  assign when_FpUnit_l205_1 = ((when_FpUnit_l206 && when_FpUnit_l207) && (when_FpUnit_l481 != _zz_when_FpUnit_l205_2));
  assign _zz_res_13 = (when_FpUnit_l481 ^ _zz_when_FpUnit_l205);
  assign _zz_when_FpUnit_l84_18 = (_zz_flagNX * _zz_when_FpUnit_l84);
  always @(*) begin
    _zz_when_FpUnit_l91_2 = 6'h0;
    if(when_FpUnit_l84_56) begin
      _zz_when_FpUnit_l91_2 = 6'h0;
    end
    if(when_FpUnit_l84_57) begin
      _zz_when_FpUnit_l91_2 = 6'h01;
    end
    if(when_FpUnit_l84_58) begin
      _zz_when_FpUnit_l91_2 = 6'h02;
    end
    if(when_FpUnit_l84_59) begin
      _zz_when_FpUnit_l91_2 = 6'h03;
    end
    if(when_FpUnit_l84_60) begin
      _zz_when_FpUnit_l91_2 = 6'h04;
    end
    if(when_FpUnit_l84_61) begin
      _zz_when_FpUnit_l91_2 = 6'h05;
    end
    if(when_FpUnit_l84_62) begin
      _zz_when_FpUnit_l91_2 = 6'h06;
    end
    if(when_FpUnit_l84_63) begin
      _zz_when_FpUnit_l91_2 = 6'h07;
    end
    if(when_FpUnit_l84_64) begin
      _zz_when_FpUnit_l91_2 = 6'h08;
    end
    if(when_FpUnit_l84_65) begin
      _zz_when_FpUnit_l91_2 = 6'h09;
    end
    if(when_FpUnit_l84_66) begin
      _zz_when_FpUnit_l91_2 = 6'h0a;
    end
    if(when_FpUnit_l84_67) begin
      _zz_when_FpUnit_l91_2 = 6'h0b;
    end
    if(when_FpUnit_l84_68) begin
      _zz_when_FpUnit_l91_2 = 6'h0c;
    end
    if(when_FpUnit_l84_69) begin
      _zz_when_FpUnit_l91_2 = 6'h0d;
    end
    if(when_FpUnit_l84_70) begin
      _zz_when_FpUnit_l91_2 = 6'h0e;
    end
    if(when_FpUnit_l84_71) begin
      _zz_when_FpUnit_l91_2 = 6'h0f;
    end
    if(when_FpUnit_l84_72) begin
      _zz_when_FpUnit_l91_2 = 6'h10;
    end
    if(when_FpUnit_l84_73) begin
      _zz_when_FpUnit_l91_2 = 6'h11;
    end
    if(when_FpUnit_l84_74) begin
      _zz_when_FpUnit_l91_2 = 6'h12;
    end
    if(when_FpUnit_l84_75) begin
      _zz_when_FpUnit_l91_2 = 6'h13;
    end
    if(when_FpUnit_l84_76) begin
      _zz_when_FpUnit_l91_2 = 6'h14;
    end
    if(when_FpUnit_l84_77) begin
      _zz_when_FpUnit_l91_2 = 6'h15;
    end
    if(when_FpUnit_l84_78) begin
      _zz_when_FpUnit_l91_2 = 6'h16;
    end
    if(when_FpUnit_l84_79) begin
      _zz_when_FpUnit_l91_2 = 6'h17;
    end
    if(when_FpUnit_l84_80) begin
      _zz_when_FpUnit_l91_2 = 6'h18;
    end
    if(when_FpUnit_l84_81) begin
      _zz_when_FpUnit_l91_2 = 6'h19;
    end
    if(when_FpUnit_l84_82) begin
      _zz_when_FpUnit_l91_2 = 6'h1a;
    end
    if(when_FpUnit_l84_83) begin
      _zz_when_FpUnit_l91_2 = 6'h1b;
    end
    if(when_FpUnit_l84_84) begin
      _zz_when_FpUnit_l91_2 = 6'h1c;
    end
    if(when_FpUnit_l84_85) begin
      _zz_when_FpUnit_l91_2 = 6'h1d;
    end
    if(when_FpUnit_l84_86) begin
      _zz_when_FpUnit_l91_2 = 6'h1e;
    end
    if(when_FpUnit_l84_87) begin
      _zz_when_FpUnit_l91_2 = 6'h1f;
    end
    if(when_FpUnit_l84_88) begin
      _zz_when_FpUnit_l91_2 = 6'h20;
    end
    if(when_FpUnit_l84_89) begin
      _zz_when_FpUnit_l91_2 = 6'h21;
    end
    if(when_FpUnit_l84_90) begin
      _zz_when_FpUnit_l91_2 = 6'h22;
    end
    if(when_FpUnit_l84_91) begin
      _zz_when_FpUnit_l91_2 = 6'h23;
    end
    if(when_FpUnit_l84_92) begin
      _zz_when_FpUnit_l91_2 = 6'h24;
    end
    if(when_FpUnit_l84_93) begin
      _zz_when_FpUnit_l91_2 = 6'h25;
    end
    if(when_FpUnit_l84_94) begin
      _zz_when_FpUnit_l91_2 = 6'h26;
    end
    if(when_FpUnit_l84_95) begin
      _zz_when_FpUnit_l91_2 = 6'h27;
    end
    if(when_FpUnit_l84_96) begin
      _zz_when_FpUnit_l91_2 = 6'h28;
    end
    if(when_FpUnit_l84_97) begin
      _zz_when_FpUnit_l91_2 = 6'h29;
    end
    if(when_FpUnit_l84_98) begin
      _zz_when_FpUnit_l91_2 = 6'h2a;
    end
    if(when_FpUnit_l84_99) begin
      _zz_when_FpUnit_l91_2 = 6'h2b;
    end
    if(when_FpUnit_l84_100) begin
      _zz_when_FpUnit_l91_2 = 6'h2c;
    end
    if(when_FpUnit_l84_101) begin
      _zz_when_FpUnit_l91_2 = 6'h2d;
    end
    if(when_FpUnit_l84_102) begin
      _zz_when_FpUnit_l91_2 = 6'h2e;
    end
    if(when_FpUnit_l84_103) begin
      _zz_when_FpUnit_l91_2 = 6'h2f;
    end
  end

  assign when_FpUnit_l84_56 = _zz_when_FpUnit_l84_18[0];
  assign when_FpUnit_l84_57 = _zz_when_FpUnit_l84_18[1];
  assign when_FpUnit_l84_58 = _zz_when_FpUnit_l84_18[2];
  assign when_FpUnit_l84_59 = _zz_when_FpUnit_l84_18[3];
  assign when_FpUnit_l84_60 = _zz_when_FpUnit_l84_18[4];
  assign when_FpUnit_l84_61 = _zz_when_FpUnit_l84_18[5];
  assign when_FpUnit_l84_62 = _zz_when_FpUnit_l84_18[6];
  assign when_FpUnit_l84_63 = _zz_when_FpUnit_l84_18[7];
  assign when_FpUnit_l84_64 = _zz_when_FpUnit_l84_18[8];
  assign when_FpUnit_l84_65 = _zz_when_FpUnit_l84_18[9];
  assign when_FpUnit_l84_66 = _zz_when_FpUnit_l84_18[10];
  assign when_FpUnit_l84_67 = _zz_when_FpUnit_l84_18[11];
  assign when_FpUnit_l84_68 = _zz_when_FpUnit_l84_18[12];
  assign when_FpUnit_l84_69 = _zz_when_FpUnit_l84_18[13];
  assign when_FpUnit_l84_70 = _zz_when_FpUnit_l84_18[14];
  assign when_FpUnit_l84_71 = _zz_when_FpUnit_l84_18[15];
  assign when_FpUnit_l84_72 = _zz_when_FpUnit_l84_18[16];
  assign when_FpUnit_l84_73 = _zz_when_FpUnit_l84_18[17];
  assign when_FpUnit_l84_74 = _zz_when_FpUnit_l84_18[18];
  assign when_FpUnit_l84_75 = _zz_when_FpUnit_l84_18[19];
  assign when_FpUnit_l84_76 = _zz_when_FpUnit_l84_18[20];
  assign when_FpUnit_l84_77 = _zz_when_FpUnit_l84_18[21];
  assign when_FpUnit_l84_78 = _zz_when_FpUnit_l84_18[22];
  assign when_FpUnit_l84_79 = _zz_when_FpUnit_l84_18[23];
  assign when_FpUnit_l84_80 = _zz_when_FpUnit_l84_18[24];
  assign when_FpUnit_l84_81 = _zz_when_FpUnit_l84_18[25];
  assign when_FpUnit_l84_82 = _zz_when_FpUnit_l84_18[26];
  assign when_FpUnit_l84_83 = _zz_when_FpUnit_l84_18[27];
  assign when_FpUnit_l84_84 = _zz_when_FpUnit_l84_18[28];
  assign when_FpUnit_l84_85 = _zz_when_FpUnit_l84_18[29];
  assign when_FpUnit_l84_86 = _zz_when_FpUnit_l84_18[30];
  assign when_FpUnit_l84_87 = _zz_when_FpUnit_l84_18[31];
  assign when_FpUnit_l84_88 = _zz_when_FpUnit_l84_18[32];
  assign when_FpUnit_l84_89 = _zz_when_FpUnit_l84_18[33];
  assign when_FpUnit_l84_90 = _zz_when_FpUnit_l84_18[34];
  assign when_FpUnit_l84_91 = _zz_when_FpUnit_l84_18[35];
  assign when_FpUnit_l84_92 = _zz_when_FpUnit_l84_18[36];
  assign when_FpUnit_l84_93 = _zz_when_FpUnit_l84_18[37];
  assign when_FpUnit_l84_94 = _zz_when_FpUnit_l84_18[38];
  assign when_FpUnit_l84_95 = _zz_when_FpUnit_l84_18[39];
  assign when_FpUnit_l84_96 = _zz_when_FpUnit_l84_18[40];
  assign when_FpUnit_l84_97 = _zz_when_FpUnit_l84_18[41];
  assign when_FpUnit_l84_98 = _zz_when_FpUnit_l84_18[42];
  assign when_FpUnit_l84_99 = _zz_when_FpUnit_l84_18[43];
  assign when_FpUnit_l84_100 = _zz_when_FpUnit_l84_18[44];
  assign when_FpUnit_l84_101 = _zz_when_FpUnit_l84_18[45];
  assign when_FpUnit_l84_102 = _zz_when_FpUnit_l84_18[46];
  assign when_FpUnit_l84_103 = _zz_when_FpUnit_l84_18[47];
  always @(*) begin
    _zz_flagUF_22 = 27'h0;
    if(when_FpUnit_l90_2) begin
      if(when_FpUnit_l91_2) begin
        _zz_flagUF_22 = _zz__zz_flagUF_22;
      end else begin
        _zz_flagUF_22 = _zz__zz_flagUF_22_2;
      end
    end
  end

  always @(*) begin
    _zz_flagUF_23 = 1'b0;
    if(when_FpUnit_l90_2) begin
      if(when_FpUnit_l91_2) begin
        _zz_flagUF_23 = (|(_zz_when_FpUnit_l84_18 & _zz__zz_flagUF_23));
      end else begin
        _zz_flagUF_23 = 1'b0;
      end
    end
  end

  assign _zz_flagUF_24 = ($signed(_zz__zz_flagUF_24) + $signed(_zz__zz_flagUF_24_2));
  assign when_FpUnit_l90_2 = (_zz_when_FpUnit_l84_18 != 48'h0);
  assign when_FpUnit_l91_2 = (6'h1a < _zz_when_FpUnit_l91_2);
  assign _zz_flagUF_25 = (_zz_when_FpUnit_l91_2 - 6'h1a);
  assign _zz_flagUF_26 = ($signed(_zz__zz_flagUF_26) < $signed(12'h001));
  assign _zz_when_FpUnit_l116_2 = (_zz_flagUF_26 ? _zz__zz_when_FpUnit_l116_2 : 12'h0);
  assign _zz_when_FpUnit_l119_2 = _zz_when_FpUnit_l116_2;
  assign when_FpUnit_l116_2 = ($signed(_zz_when_FpUnit_l116_2) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l116_2) begin
      _zz_flagUF_27 = _zz_flagUF_22;
    end else begin
      if(when_FpUnit_l119_2) begin
        _zz_flagUF_27 = 27'h0;
      end else begin
        _zz_flagUF_27 = _zz__zz_flagUF_27;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l116_2) begin
      _zz_flagUF_28 = _zz_flagUF_23;
    end else begin
      if(when_FpUnit_l119_2) begin
        _zz_flagUF_28 = ((|_zz_flagUF_22) || _zz_flagUF_23);
      end else begin
        _zz_flagUF_28 = ((|(_zz_flagUF_22 & _zz__zz_flagUF_28)) || _zz_flagUF_23);
      end
    end
  end

  assign when_FpUnit_l119_2 = (12'h01b <= _zz_when_FpUnit_l119_2);
  assign _zz_when_FpUnit_l150_10 = (_zz_flagUF_26 ? 12'hf82 : _zz_flagUF_24);
  assign _zz_flagUF_29 = _zz_flagUF_27[2];
  assign _zz_flagUF_30 = _zz_flagUF_27[1];
  assign _zz_flagUF_31 = (_zz_flagUF_27[0] || _zz_flagUF_28);
  assign _zz_when_FpUnit_l150_11 = _zz_flagUF_27[26 : 3];
  assign _zz_when_FpUnit_l150_12 = (_zz__zz_when_FpUnit_l150_12 + _zz__zz_when_FpUnit_l150_12_2);
  assign _zz_when_FpUnit_l150_13 = _zz_when_FpUnit_l150_12[24];
  assign _zz_res_14 = (_zz_when_FpUnit_l150_13 ? _zz__zz_res_14 : _zz__zz_res_14_1);
  assign _zz_when_FpUnit_l150_14 = ($signed(_zz__zz_when_FpUnit_l150_14) + $signed(12'h07f));
  assign _zz_flagUF_32 = ((_zz_flagUF_29 || _zz_flagUF_30) || _zz_flagUF_31);
  assign when_FpUnit_l150_2 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l150_14));
  assign _zz_res_15 = {_zz_res_13,{8'hff,23'h0}};
  assign _zz_res_16 = {_zz_res_13,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_17 = 32'h0;
    if(when_FpUnit_l150_2) begin
      _zz_res_17 = ((io_rm == 3'b001) ? _zz_res_16 : ((io_rm == 3'b010) ? (_zz_res_13 ? _zz_res_15 : _zz_res_16) : ((io_rm == 3'b011) ? (_zz_res_13 ? _zz_res_16 : _zz_res_15) : _zz_res_15)));
    end else begin
      if(when_FpUnit_l154_2) begin
        _zz_res_17 = {_zz_res_13,{8'h0,_zz_res_14[22 : 0]}};
      end else begin
        _zz_res_17 = {_zz_res_13,{_zz__zz_res_17,_zz_res_14[22 : 0]}};
      end
    end
  end

  assign when_FpUnit_l154_2 = ($signed(_zz_when_FpUnit_l150_14) < $signed(12'h001));
  always @(*) begin
    _zz_res_18 = _zz_res_17;
    if(when_FpUnit_l234) begin
      _zz_res_18 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l235) begin
        _zz_res_18 = 32'h7fc00000;
      end else begin
        if(when_FpUnit_l236) begin
          _zz_res_18 = {_zz_res_13,{8'hff,23'h0}};
        end else begin
          if(when_FpUnit_l237) begin
            _zz_res_18 = {_zz_res_13,{8'h0,23'h0}};
          end
        end
      end
    end
  end

  assign when_FpUnit_l234 = (when_FpUnit_l304 || when_FpUnit_l393);
  assign when_FpUnit_l235 = ((when_FpUnit_l206 && when_FpUnit_l267) || (when_FpUnit_l270 && when_FpUnit_l207));
  assign when_FpUnit_l236 = (when_FpUnit_l206 || when_FpUnit_l207);
  assign when_FpUnit_l237 = (when_FpUnit_l270 || when_FpUnit_l267);
  assign _zz_res_19 = (when_FpUnit_l481 ^ _zz_when_FpUnit_l205);
  assign _zz_when_FpUnit_l84_19 = ({27'd0,_zz__zz_when_FpUnit_l84_19} <<< 5'd27);
  assign _zz_when_FpUnit_l84_20 = _zz__zz_when_FpUnit_l84_20[28:0];
  always @(*) begin
    _zz_when_FpUnit_l91_3 = 5'h0;
    if(when_FpUnit_l84_104) begin
      _zz_when_FpUnit_l91_3 = 5'h0;
    end
    if(when_FpUnit_l84_105) begin
      _zz_when_FpUnit_l91_3 = 5'h01;
    end
    if(when_FpUnit_l84_106) begin
      _zz_when_FpUnit_l91_3 = 5'h02;
    end
    if(when_FpUnit_l84_107) begin
      _zz_when_FpUnit_l91_3 = 5'h03;
    end
    if(when_FpUnit_l84_108) begin
      _zz_when_FpUnit_l91_3 = 5'h04;
    end
    if(when_FpUnit_l84_109) begin
      _zz_when_FpUnit_l91_3 = 5'h05;
    end
    if(when_FpUnit_l84_110) begin
      _zz_when_FpUnit_l91_3 = 5'h06;
    end
    if(when_FpUnit_l84_111) begin
      _zz_when_FpUnit_l91_3 = 5'h07;
    end
    if(when_FpUnit_l84_112) begin
      _zz_when_FpUnit_l91_3 = 5'h08;
    end
    if(when_FpUnit_l84_113) begin
      _zz_when_FpUnit_l91_3 = 5'h09;
    end
    if(when_FpUnit_l84_114) begin
      _zz_when_FpUnit_l91_3 = 5'h0a;
    end
    if(when_FpUnit_l84_115) begin
      _zz_when_FpUnit_l91_3 = 5'h0b;
    end
    if(when_FpUnit_l84_116) begin
      _zz_when_FpUnit_l91_3 = 5'h0c;
    end
    if(when_FpUnit_l84_117) begin
      _zz_when_FpUnit_l91_3 = 5'h0d;
    end
    if(when_FpUnit_l84_118) begin
      _zz_when_FpUnit_l91_3 = 5'h0e;
    end
    if(when_FpUnit_l84_119) begin
      _zz_when_FpUnit_l91_3 = 5'h0f;
    end
    if(when_FpUnit_l84_120) begin
      _zz_when_FpUnit_l91_3 = 5'h10;
    end
    if(when_FpUnit_l84_121) begin
      _zz_when_FpUnit_l91_3 = 5'h11;
    end
    if(when_FpUnit_l84_122) begin
      _zz_when_FpUnit_l91_3 = 5'h12;
    end
    if(when_FpUnit_l84_123) begin
      _zz_when_FpUnit_l91_3 = 5'h13;
    end
    if(when_FpUnit_l84_124) begin
      _zz_when_FpUnit_l91_3 = 5'h14;
    end
    if(when_FpUnit_l84_125) begin
      _zz_when_FpUnit_l91_3 = 5'h15;
    end
    if(when_FpUnit_l84_126) begin
      _zz_when_FpUnit_l91_3 = 5'h16;
    end
    if(when_FpUnit_l84_127) begin
      _zz_when_FpUnit_l91_3 = 5'h17;
    end
    if(when_FpUnit_l84_128) begin
      _zz_when_FpUnit_l91_3 = 5'h18;
    end
    if(when_FpUnit_l84_129) begin
      _zz_when_FpUnit_l91_3 = 5'h19;
    end
    if(when_FpUnit_l84_130) begin
      _zz_when_FpUnit_l91_3 = 5'h1a;
    end
    if(when_FpUnit_l84_131) begin
      _zz_when_FpUnit_l91_3 = 5'h1b;
    end
    if(when_FpUnit_l84_132) begin
      _zz_when_FpUnit_l91_3 = 5'h1c;
    end
  end

  assign when_FpUnit_l84_104 = _zz_when_FpUnit_l84_20[0];
  assign when_FpUnit_l84_105 = _zz_when_FpUnit_l84_20[1];
  assign when_FpUnit_l84_106 = _zz_when_FpUnit_l84_20[2];
  assign when_FpUnit_l84_107 = _zz_when_FpUnit_l84_20[3];
  assign when_FpUnit_l84_108 = _zz_when_FpUnit_l84_20[4];
  assign when_FpUnit_l84_109 = _zz_when_FpUnit_l84_20[5];
  assign when_FpUnit_l84_110 = _zz_when_FpUnit_l84_20[6];
  assign when_FpUnit_l84_111 = _zz_when_FpUnit_l84_20[7];
  assign when_FpUnit_l84_112 = _zz_when_FpUnit_l84_20[8];
  assign when_FpUnit_l84_113 = _zz_when_FpUnit_l84_20[9];
  assign when_FpUnit_l84_114 = _zz_when_FpUnit_l84_20[10];
  assign when_FpUnit_l84_115 = _zz_when_FpUnit_l84_20[11];
  assign when_FpUnit_l84_116 = _zz_when_FpUnit_l84_20[12];
  assign when_FpUnit_l84_117 = _zz_when_FpUnit_l84_20[13];
  assign when_FpUnit_l84_118 = _zz_when_FpUnit_l84_20[14];
  assign when_FpUnit_l84_119 = _zz_when_FpUnit_l84_20[15];
  assign when_FpUnit_l84_120 = _zz_when_FpUnit_l84_20[16];
  assign when_FpUnit_l84_121 = _zz_when_FpUnit_l84_20[17];
  assign when_FpUnit_l84_122 = _zz_when_FpUnit_l84_20[18];
  assign when_FpUnit_l84_123 = _zz_when_FpUnit_l84_20[19];
  assign when_FpUnit_l84_124 = _zz_when_FpUnit_l84_20[20];
  assign when_FpUnit_l84_125 = _zz_when_FpUnit_l84_20[21];
  assign when_FpUnit_l84_126 = _zz_when_FpUnit_l84_20[22];
  assign when_FpUnit_l84_127 = _zz_when_FpUnit_l84_20[23];
  assign when_FpUnit_l84_128 = _zz_when_FpUnit_l84_20[24];
  assign when_FpUnit_l84_129 = _zz_when_FpUnit_l84_20[25];
  assign when_FpUnit_l84_130 = _zz_when_FpUnit_l84_20[26];
  assign when_FpUnit_l84_131 = _zz_when_FpUnit_l84_20[27];
  assign when_FpUnit_l84_132 = _zz_when_FpUnit_l84_20[28];
  always @(*) begin
    _zz_flagUF_33 = 27'h0;
    if(when_FpUnit_l90_3) begin
      if(when_FpUnit_l91_3) begin
        _zz_flagUF_33 = _zz__zz_flagUF_33;
      end else begin
        _zz_flagUF_33 = _zz__zz_flagUF_33_2;
      end
    end
  end

  always @(*) begin
    _zz_flagUF_34 = 1'b0;
    if(when_FpUnit_l90_3) begin
      if(when_FpUnit_l91_3) begin
        _zz_flagUF_34 = (|(_zz_when_FpUnit_l84_20 & _zz__zz_flagUF_34));
      end else begin
        _zz_flagUF_34 = 1'b0;
      end
    end
  end

  assign _zz_flagUF_35 = ($signed(_zz__zz_flagUF_35) + $signed(_zz__zz_flagUF_35_2));
  assign when_FpUnit_l90_3 = (_zz_when_FpUnit_l84_20 != 29'h0);
  assign when_FpUnit_l91_3 = (5'h1a < _zz_when_FpUnit_l91_3);
  assign _zz_flagUF_36 = (_zz_when_FpUnit_l91_3 - 5'h1a);
  assign _zz_flagUF_37 = (_zz_flagUF_34 || (_zz__zz_flagUF_37 != 106'h0));
  assign _zz_flagUF_38 = ($signed(_zz__zz_flagUF_38) < $signed(12'h001));
  assign _zz_when_FpUnit_l116_3 = (_zz_flagUF_38 ? _zz__zz_when_FpUnit_l116_3 : 12'h0);
  assign _zz_when_FpUnit_l119_3 = _zz_when_FpUnit_l116_3;
  assign when_FpUnit_l116_3 = ($signed(_zz_when_FpUnit_l116_3) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l116_3) begin
      _zz_flagUF_39 = _zz_flagUF_33;
    end else begin
      if(when_FpUnit_l119_3) begin
        _zz_flagUF_39 = 27'h0;
      end else begin
        _zz_flagUF_39 = _zz__zz_flagUF_39;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l116_3) begin
      _zz_flagUF_40 = _zz_flagUF_37;
    end else begin
      if(when_FpUnit_l119_3) begin
        _zz_flagUF_40 = ((|_zz_flagUF_33) || _zz_flagUF_37);
      end else begin
        _zz_flagUF_40 = ((|(_zz_flagUF_33 & _zz__zz_flagUF_40)) || _zz_flagUF_37);
      end
    end
  end

  assign when_FpUnit_l119_3 = (12'h01b <= _zz_when_FpUnit_l119_3);
  assign _zz_when_FpUnit_l150_15 = (_zz_flagUF_38 ? 12'hf82 : _zz_flagUF_35);
  assign _zz_flagUF_41 = _zz_flagUF_39[2];
  assign _zz_flagUF_42 = _zz_flagUF_39[1];
  assign _zz_flagUF_43 = (_zz_flagUF_39[0] || _zz_flagUF_40);
  assign _zz_when_FpUnit_l150_16 = _zz_flagUF_39[26 : 3];
  assign _zz_when_FpUnit_l150_17 = (_zz__zz_when_FpUnit_l150_17 + _zz__zz_when_FpUnit_l150_17_2);
  assign _zz_when_FpUnit_l150_18 = _zz_when_FpUnit_l150_17[24];
  assign _zz_res_20 = (_zz_when_FpUnit_l150_18 ? _zz__zz_res_20 : _zz__zz_res_20_1);
  assign _zz_when_FpUnit_l150_19 = ($signed(_zz__zz_when_FpUnit_l150_19) + $signed(12'h07f));
  assign _zz_flagUF_44 = ((_zz_flagUF_41 || _zz_flagUF_42) || _zz_flagUF_43);
  assign when_FpUnit_l150_3 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l150_19));
  assign _zz_res_21 = {_zz_res_19,{8'hff,23'h0}};
  assign _zz_res_22 = {_zz_res_19,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_23 = 32'h0;
    if(when_FpUnit_l150_3) begin
      _zz_res_23 = ((io_rm == 3'b001) ? _zz_res_22 : ((io_rm == 3'b010) ? (_zz_res_19 ? _zz_res_21 : _zz_res_22) : ((io_rm == 3'b011) ? (_zz_res_19 ? _zz_res_22 : _zz_res_21) : _zz_res_21)));
    end else begin
      if(when_FpUnit_l154_3) begin
        _zz_res_23 = {_zz_res_19,{8'h0,_zz_res_20[22 : 0]}};
      end else begin
        _zz_res_23 = {_zz_res_19,{_zz__zz_res_23,_zz_res_20[22 : 0]}};
      end
    end
  end

  assign when_FpUnit_l154_3 = ($signed(_zz_when_FpUnit_l150_19) < $signed(12'h001));
  always @(*) begin
    _zz_res_24 = _zz_res_23;
    if(when_FpUnit_l261) begin
      _zz_res_24 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l262) begin
        _zz_res_24 = 32'h7fc00000;
      end else begin
        if(when_FpUnit_l206) begin
          _zz_res_24 = {_zz_res_19,{8'hff,23'h0}};
        end else begin
          if(when_FpUnit_l207) begin
            _zz_res_24 = {_zz_res_19,{8'h0,23'h0}};
          end else begin
            if(when_FpUnit_l267) begin
              _zz_res_24 = {_zz_res_19,{8'hff,23'h0}};
            end else begin
              if(when_FpUnit_l270) begin
                _zz_res_24 = {_zz_res_19,{8'h0,23'h0}};
              end
            end
          end
        end
      end
    end
  end

  assign when_FpUnit_l261 = (when_FpUnit_l304 || when_FpUnit_l393);
  assign when_FpUnit_l262 = ((when_FpUnit_l270 && when_FpUnit_l267) || (when_FpUnit_l206 && when_FpUnit_l207));
  assign _zz_flagUF_45 = _zz_when_FpUnit_l180[0];
  assign _zz_when_FpUnit_l84_21 = _zz__zz_when_FpUnit_l84_21[55:0];
  assign _zz_when_FpUnit_l84_22 = 30'h0;
  assign _zz_when_FpUnit_l84_23 = (_zz__zz_when_FpUnit_l84_23 | _zz__zz_when_FpUnit_l84_23_2);
  assign _zz_when_FpUnit_l84_24 = (_zz__zz_when_FpUnit_l84_24 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_25 = (_zz_when_FpUnit_l84_24 <= _zz_when_FpUnit_l84_23);
  assign _zz_when_FpUnit_l84_26 = (_zz_when_FpUnit_l84_25 ? (_zz__zz_when_FpUnit_l84_26 | 30'h00000001) : _zz__zz_when_FpUnit_l84_26_2);
  assign _zz_when_FpUnit_l84_27 = (_zz__zz_when_FpUnit_l84_27 | _zz__zz_when_FpUnit_l84_27_3);
  assign _zz_when_FpUnit_l84_28 = (_zz__zz_when_FpUnit_l84_28 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_29 = (_zz_when_FpUnit_l84_28 <= _zz_when_FpUnit_l84_27);
  assign _zz_when_FpUnit_l84_30 = (_zz_when_FpUnit_l84_29 ? (_zz__zz_when_FpUnit_l84_30 | 30'h00000001) : _zz__zz_when_FpUnit_l84_30_2);
  assign _zz_when_FpUnit_l84_31 = (_zz__zz_when_FpUnit_l84_31 | _zz__zz_when_FpUnit_l84_31_3);
  assign _zz_when_FpUnit_l84_32 = (_zz__zz_when_FpUnit_l84_32 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_33 = (_zz_when_FpUnit_l84_32 <= _zz_when_FpUnit_l84_31);
  assign _zz_when_FpUnit_l84_34 = (_zz_when_FpUnit_l84_33 ? (_zz__zz_when_FpUnit_l84_34 | 30'h00000001) : _zz__zz_when_FpUnit_l84_34_2);
  assign _zz_when_FpUnit_l84_35 = (_zz__zz_when_FpUnit_l84_35 | _zz__zz_when_FpUnit_l84_35_3);
  assign _zz_when_FpUnit_l84_36 = (_zz__zz_when_FpUnit_l84_36 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_37 = (_zz_when_FpUnit_l84_36 <= _zz_when_FpUnit_l84_35);
  assign _zz_when_FpUnit_l84_38 = (_zz_when_FpUnit_l84_37 ? (_zz__zz_when_FpUnit_l84_38 | 30'h00000001) : _zz__zz_when_FpUnit_l84_38_2);
  assign _zz_when_FpUnit_l84_39 = (_zz__zz_when_FpUnit_l84_39 | _zz__zz_when_FpUnit_l84_39_3);
  assign _zz_when_FpUnit_l84_40 = (_zz__zz_when_FpUnit_l84_40 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_41 = (_zz_when_FpUnit_l84_40 <= _zz_when_FpUnit_l84_39);
  assign _zz_when_FpUnit_l84_42 = (_zz_when_FpUnit_l84_41 ? (_zz__zz_when_FpUnit_l84_42 | 30'h00000001) : _zz__zz_when_FpUnit_l84_42_2);
  assign _zz_when_FpUnit_l84_43 = (_zz__zz_when_FpUnit_l84_43 | _zz__zz_when_FpUnit_l84_43_3);
  assign _zz_when_FpUnit_l84_44 = (_zz__zz_when_FpUnit_l84_44 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_45 = (_zz_when_FpUnit_l84_44 <= _zz_when_FpUnit_l84_43);
  assign _zz_when_FpUnit_l84_46 = (_zz_when_FpUnit_l84_45 ? (_zz__zz_when_FpUnit_l84_46 | 30'h00000001) : _zz__zz_when_FpUnit_l84_46_2);
  assign _zz_when_FpUnit_l84_47 = (_zz__zz_when_FpUnit_l84_47 | _zz__zz_when_FpUnit_l84_47_3);
  assign _zz_when_FpUnit_l84_48 = (_zz__zz_when_FpUnit_l84_48 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_49 = (_zz_when_FpUnit_l84_48 <= _zz_when_FpUnit_l84_47);
  assign _zz_when_FpUnit_l84_50 = (_zz_when_FpUnit_l84_49 ? (_zz__zz_when_FpUnit_l84_50 | 30'h00000001) : _zz__zz_when_FpUnit_l84_50_2);
  assign _zz_when_FpUnit_l84_51 = (_zz__zz_when_FpUnit_l84_51 | _zz__zz_when_FpUnit_l84_51_3);
  assign _zz_when_FpUnit_l84_52 = (_zz__zz_when_FpUnit_l84_52 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_53 = (_zz_when_FpUnit_l84_52 <= _zz_when_FpUnit_l84_51);
  assign _zz_when_FpUnit_l84_54 = (_zz_when_FpUnit_l84_53 ? (_zz__zz_when_FpUnit_l84_54 | 30'h00000001) : _zz__zz_when_FpUnit_l84_54_2);
  assign _zz_when_FpUnit_l84_55 = (_zz__zz_when_FpUnit_l84_55 | _zz__zz_when_FpUnit_l84_55_3);
  assign _zz_when_FpUnit_l84_56 = (_zz__zz_when_FpUnit_l84_56 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_57 = (_zz_when_FpUnit_l84_56 <= _zz_when_FpUnit_l84_55);
  assign _zz_when_FpUnit_l84_58 = (_zz_when_FpUnit_l84_57 ? (_zz__zz_when_FpUnit_l84_58 | 30'h00000001) : _zz__zz_when_FpUnit_l84_58_2);
  assign _zz_when_FpUnit_l84_59 = (_zz__zz_when_FpUnit_l84_59 | _zz__zz_when_FpUnit_l84_59_3);
  assign _zz_when_FpUnit_l84_60 = (_zz__zz_when_FpUnit_l84_60 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_61 = (_zz_when_FpUnit_l84_60 <= _zz_when_FpUnit_l84_59);
  assign _zz_when_FpUnit_l84_62 = (_zz_when_FpUnit_l84_61 ? (_zz__zz_when_FpUnit_l84_62 | 30'h00000001) : _zz__zz_when_FpUnit_l84_62_2);
  assign _zz_when_FpUnit_l84_63 = (_zz__zz_when_FpUnit_l84_63 | _zz__zz_when_FpUnit_l84_63_3);
  assign _zz_when_FpUnit_l84_64 = (_zz__zz_when_FpUnit_l84_64 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_65 = (_zz_when_FpUnit_l84_64 <= _zz_when_FpUnit_l84_63);
  assign _zz_when_FpUnit_l84_66 = (_zz_when_FpUnit_l84_65 ? (_zz__zz_when_FpUnit_l84_66 | 30'h00000001) : _zz__zz_when_FpUnit_l84_66_2);
  assign _zz_when_FpUnit_l84_67 = (_zz__zz_when_FpUnit_l84_67 | _zz__zz_when_FpUnit_l84_67_3);
  assign _zz_when_FpUnit_l84_68 = (_zz__zz_when_FpUnit_l84_68 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_69 = (_zz_when_FpUnit_l84_68 <= _zz_when_FpUnit_l84_67);
  assign _zz_when_FpUnit_l84_70 = (_zz_when_FpUnit_l84_69 ? (_zz__zz_when_FpUnit_l84_70 | 30'h00000001) : _zz__zz_when_FpUnit_l84_70_2);
  assign _zz_when_FpUnit_l84_71 = (_zz__zz_when_FpUnit_l84_71 | _zz__zz_when_FpUnit_l84_71_3);
  assign _zz_when_FpUnit_l84_72 = (_zz__zz_when_FpUnit_l84_72 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_73 = (_zz_when_FpUnit_l84_72 <= _zz_when_FpUnit_l84_71);
  assign _zz_when_FpUnit_l84_74 = (_zz_when_FpUnit_l84_73 ? (_zz__zz_when_FpUnit_l84_74 | 30'h00000001) : _zz__zz_when_FpUnit_l84_74_2);
  assign _zz_when_FpUnit_l84_75 = (_zz__zz_when_FpUnit_l84_75 | _zz__zz_when_FpUnit_l84_75_3);
  assign _zz_when_FpUnit_l84_76 = (_zz__zz_when_FpUnit_l84_76 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_77 = (_zz_when_FpUnit_l84_76 <= _zz_when_FpUnit_l84_75);
  assign _zz_when_FpUnit_l84_78 = (_zz_when_FpUnit_l84_77 ? (_zz__zz_when_FpUnit_l84_78 | 30'h00000001) : _zz__zz_when_FpUnit_l84_78_2);
  assign _zz_when_FpUnit_l84_79 = (_zz__zz_when_FpUnit_l84_79 | _zz__zz_when_FpUnit_l84_79_3);
  assign _zz_when_FpUnit_l84_80 = (_zz__zz_when_FpUnit_l84_80 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_81 = (_zz_when_FpUnit_l84_80 <= _zz_when_FpUnit_l84_79);
  assign _zz_when_FpUnit_l84_82 = (_zz_when_FpUnit_l84_81 ? (_zz__zz_when_FpUnit_l84_82 | 30'h00000001) : _zz__zz_when_FpUnit_l84_82_2);
  assign _zz_when_FpUnit_l84_83 = (_zz__zz_when_FpUnit_l84_83 | _zz__zz_when_FpUnit_l84_83_3);
  assign _zz_when_FpUnit_l84_84 = (_zz__zz_when_FpUnit_l84_84 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_85 = (_zz_when_FpUnit_l84_84 <= _zz_when_FpUnit_l84_83);
  assign _zz_when_FpUnit_l84_86 = (_zz_when_FpUnit_l84_85 ? (_zz__zz_when_FpUnit_l84_86 | 30'h00000001) : _zz__zz_when_FpUnit_l84_86_2);
  assign _zz_when_FpUnit_l84_87 = (_zz__zz_when_FpUnit_l84_87 | _zz__zz_when_FpUnit_l84_87_3);
  assign _zz_when_FpUnit_l84_88 = (_zz__zz_when_FpUnit_l84_88 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_89 = (_zz_when_FpUnit_l84_88 <= _zz_when_FpUnit_l84_87);
  assign _zz_when_FpUnit_l84_90 = (_zz_when_FpUnit_l84_89 ? (_zz__zz_when_FpUnit_l84_90 | 30'h00000001) : _zz__zz_when_FpUnit_l84_90_2);
  assign _zz_when_FpUnit_l84_91 = (_zz__zz_when_FpUnit_l84_91 | _zz__zz_when_FpUnit_l84_91_3);
  assign _zz_when_FpUnit_l84_92 = (_zz__zz_when_FpUnit_l84_92 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_93 = (_zz_when_FpUnit_l84_92 <= _zz_when_FpUnit_l84_91);
  assign _zz_when_FpUnit_l84_94 = (_zz_when_FpUnit_l84_93 ? (_zz__zz_when_FpUnit_l84_94 | 30'h00000001) : _zz__zz_when_FpUnit_l84_94_2);
  assign _zz_when_FpUnit_l84_95 = (_zz__zz_when_FpUnit_l84_95 | _zz__zz_when_FpUnit_l84_95_3);
  assign _zz_when_FpUnit_l84_96 = (_zz__zz_when_FpUnit_l84_96 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_97 = (_zz_when_FpUnit_l84_96 <= _zz_when_FpUnit_l84_95);
  assign _zz_when_FpUnit_l84_98 = (_zz_when_FpUnit_l84_97 ? (_zz__zz_when_FpUnit_l84_98 | 30'h00000001) : _zz__zz_when_FpUnit_l84_98_2);
  assign _zz_when_FpUnit_l84_99 = (_zz__zz_when_FpUnit_l84_99 | _zz__zz_when_FpUnit_l84_99_3);
  assign _zz_when_FpUnit_l84_100 = (_zz__zz_when_FpUnit_l84_100 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_101 = (_zz_when_FpUnit_l84_100 <= _zz_when_FpUnit_l84_99);
  assign _zz_when_FpUnit_l84_102 = (_zz_when_FpUnit_l84_101 ? (_zz__zz_when_FpUnit_l84_102 | 30'h00000001) : _zz__zz_when_FpUnit_l84_102_2);
  assign _zz_when_FpUnit_l84_103 = (_zz__zz_when_FpUnit_l84_103 | _zz__zz_when_FpUnit_l84_103_3);
  assign _zz_when_FpUnit_l84_104 = (_zz__zz_when_FpUnit_l84_104 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_105 = (_zz_when_FpUnit_l84_104 <= _zz_when_FpUnit_l84_103);
  assign _zz_when_FpUnit_l84_106 = (_zz_when_FpUnit_l84_105 ? (_zz__zz_when_FpUnit_l84_106 | 30'h00000001) : _zz__zz_when_FpUnit_l84_106_2);
  assign _zz_when_FpUnit_l84_107 = (_zz__zz_when_FpUnit_l84_107 | _zz__zz_when_FpUnit_l84_107_3);
  assign _zz_when_FpUnit_l84_108 = (_zz__zz_when_FpUnit_l84_108 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_109 = (_zz_when_FpUnit_l84_108 <= _zz_when_FpUnit_l84_107);
  assign _zz_when_FpUnit_l84_110 = (_zz_when_FpUnit_l84_109 ? (_zz__zz_when_FpUnit_l84_110 | 30'h00000001) : _zz__zz_when_FpUnit_l84_110_2);
  assign _zz_when_FpUnit_l84_111 = (_zz__zz_when_FpUnit_l84_111 | _zz__zz_when_FpUnit_l84_111_3);
  assign _zz_when_FpUnit_l84_112 = (_zz__zz_when_FpUnit_l84_112 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_113 = (_zz_when_FpUnit_l84_112 <= _zz_when_FpUnit_l84_111);
  assign _zz_when_FpUnit_l84_114 = (_zz_when_FpUnit_l84_113 ? (_zz__zz_when_FpUnit_l84_114 | 30'h00000001) : _zz__zz_when_FpUnit_l84_114_2);
  assign _zz_when_FpUnit_l84_115 = (_zz__zz_when_FpUnit_l84_115 | _zz__zz_when_FpUnit_l84_115_3);
  assign _zz_when_FpUnit_l84_116 = (_zz__zz_when_FpUnit_l84_116 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_117 = (_zz_when_FpUnit_l84_116 <= _zz_when_FpUnit_l84_115);
  assign _zz_when_FpUnit_l84_118 = (_zz_when_FpUnit_l84_117 ? (_zz__zz_when_FpUnit_l84_118 | 30'h00000001) : _zz__zz_when_FpUnit_l84_118_2);
  assign _zz_when_FpUnit_l84_119 = (_zz__zz_when_FpUnit_l84_119 | _zz__zz_when_FpUnit_l84_119_3);
  assign _zz_when_FpUnit_l84_120 = (_zz__zz_when_FpUnit_l84_120 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_121 = (_zz_when_FpUnit_l84_120 <= _zz_when_FpUnit_l84_119);
  assign _zz_when_FpUnit_l84_122 = (_zz_when_FpUnit_l84_121 ? (_zz__zz_when_FpUnit_l84_122 | 30'h00000001) : _zz__zz_when_FpUnit_l84_122_2);
  assign _zz_when_FpUnit_l84_123 = (_zz__zz_when_FpUnit_l84_123 | _zz__zz_when_FpUnit_l84_123_3);
  assign _zz_when_FpUnit_l84_124 = (_zz__zz_when_FpUnit_l84_124 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_125 = (_zz_when_FpUnit_l84_124 <= _zz_when_FpUnit_l84_123);
  assign _zz_when_FpUnit_l84_126 = (_zz_when_FpUnit_l84_125 ? (_zz__zz_when_FpUnit_l84_126 | 30'h00000001) : _zz__zz_when_FpUnit_l84_126_2);
  assign _zz_when_FpUnit_l84_127 = (_zz__zz_when_FpUnit_l84_127 | _zz__zz_when_FpUnit_l84_127_3);
  assign _zz_when_FpUnit_l84_128 = (_zz__zz_when_FpUnit_l84_128 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_129 = (_zz_when_FpUnit_l84_128 <= _zz_when_FpUnit_l84_127);
  assign _zz_when_FpUnit_l84_130 = (_zz_when_FpUnit_l84_129 ? (_zz__zz_when_FpUnit_l84_130 | 30'h00000001) : _zz__zz_when_FpUnit_l84_130_2);
  assign _zz_when_FpUnit_l84_131 = (_zz__zz_when_FpUnit_l84_131 | _zz__zz_when_FpUnit_l84_131_3);
  assign _zz_when_FpUnit_l84_132 = (_zz__zz_when_FpUnit_l84_132 | 58'h000000000000001);
  assign _zz_when_FpUnit_l84_133 = (_zz_when_FpUnit_l84_132 <= _zz_when_FpUnit_l84_131);
  assign _zz_when_FpUnit_l84_134 = (_zz_when_FpUnit_l84_133 ? (_zz__zz_when_FpUnit_l84_134 | 30'h00000001) : _zz__zz_when_FpUnit_l84_134_2);
  always @(*) begin
    _zz_when_FpUnit_l91_4 = 5'h0;
    if(when_FpUnit_l84_133) begin
      _zz_when_FpUnit_l91_4 = 5'h0;
    end
    if(when_FpUnit_l84_134) begin
      _zz_when_FpUnit_l91_4 = 5'h01;
    end
    if(when_FpUnit_l84_135) begin
      _zz_when_FpUnit_l91_4 = 5'h02;
    end
    if(when_FpUnit_l84_136) begin
      _zz_when_FpUnit_l91_4 = 5'h03;
    end
    if(when_FpUnit_l84_137) begin
      _zz_when_FpUnit_l91_4 = 5'h04;
    end
    if(when_FpUnit_l84_138) begin
      _zz_when_FpUnit_l91_4 = 5'h05;
    end
    if(when_FpUnit_l84_139) begin
      _zz_when_FpUnit_l91_4 = 5'h06;
    end
    if(when_FpUnit_l84_140) begin
      _zz_when_FpUnit_l91_4 = 5'h07;
    end
    if(when_FpUnit_l84_141) begin
      _zz_when_FpUnit_l91_4 = 5'h08;
    end
    if(when_FpUnit_l84_142) begin
      _zz_when_FpUnit_l91_4 = 5'h09;
    end
    if(when_FpUnit_l84_143) begin
      _zz_when_FpUnit_l91_4 = 5'h0a;
    end
    if(when_FpUnit_l84_144) begin
      _zz_when_FpUnit_l91_4 = 5'h0b;
    end
    if(when_FpUnit_l84_145) begin
      _zz_when_FpUnit_l91_4 = 5'h0c;
    end
    if(when_FpUnit_l84_146) begin
      _zz_when_FpUnit_l91_4 = 5'h0d;
    end
    if(when_FpUnit_l84_147) begin
      _zz_when_FpUnit_l91_4 = 5'h0e;
    end
    if(when_FpUnit_l84_148) begin
      _zz_when_FpUnit_l91_4 = 5'h0f;
    end
    if(when_FpUnit_l84_149) begin
      _zz_when_FpUnit_l91_4 = 5'h10;
    end
    if(when_FpUnit_l84_150) begin
      _zz_when_FpUnit_l91_4 = 5'h11;
    end
    if(when_FpUnit_l84_151) begin
      _zz_when_FpUnit_l91_4 = 5'h12;
    end
    if(when_FpUnit_l84_152) begin
      _zz_when_FpUnit_l91_4 = 5'h13;
    end
    if(when_FpUnit_l84_153) begin
      _zz_when_FpUnit_l91_4 = 5'h14;
    end
    if(when_FpUnit_l84_154) begin
      _zz_when_FpUnit_l91_4 = 5'h15;
    end
    if(when_FpUnit_l84_155) begin
      _zz_when_FpUnit_l91_4 = 5'h16;
    end
    if(when_FpUnit_l84_156) begin
      _zz_when_FpUnit_l91_4 = 5'h17;
    end
    if(when_FpUnit_l84_157) begin
      _zz_when_FpUnit_l91_4 = 5'h18;
    end
    if(when_FpUnit_l84_158) begin
      _zz_when_FpUnit_l91_4 = 5'h19;
    end
    if(when_FpUnit_l84_159) begin
      _zz_when_FpUnit_l91_4 = 5'h1a;
    end
    if(when_FpUnit_l84_160) begin
      _zz_when_FpUnit_l91_4 = 5'h1b;
    end
    if(when_FpUnit_l84_161) begin
      _zz_when_FpUnit_l91_4 = 5'h1c;
    end
    if(when_FpUnit_l84_162) begin
      _zz_when_FpUnit_l91_4 = 5'h1d;
    end
  end

  assign when_FpUnit_l84_133 = _zz_when_FpUnit_l84_134[0];
  assign when_FpUnit_l84_134 = _zz_when_FpUnit_l84_134[1];
  assign when_FpUnit_l84_135 = _zz_when_FpUnit_l84_134[2];
  assign when_FpUnit_l84_136 = _zz_when_FpUnit_l84_134[3];
  assign when_FpUnit_l84_137 = _zz_when_FpUnit_l84_134[4];
  assign when_FpUnit_l84_138 = _zz_when_FpUnit_l84_134[5];
  assign when_FpUnit_l84_139 = _zz_when_FpUnit_l84_134[6];
  assign when_FpUnit_l84_140 = _zz_when_FpUnit_l84_134[7];
  assign when_FpUnit_l84_141 = _zz_when_FpUnit_l84_134[8];
  assign when_FpUnit_l84_142 = _zz_when_FpUnit_l84_134[9];
  assign when_FpUnit_l84_143 = _zz_when_FpUnit_l84_134[10];
  assign when_FpUnit_l84_144 = _zz_when_FpUnit_l84_134[11];
  assign when_FpUnit_l84_145 = _zz_when_FpUnit_l84_134[12];
  assign when_FpUnit_l84_146 = _zz_when_FpUnit_l84_134[13];
  assign when_FpUnit_l84_147 = _zz_when_FpUnit_l84_134[14];
  assign when_FpUnit_l84_148 = _zz_when_FpUnit_l84_134[15];
  assign when_FpUnit_l84_149 = _zz_when_FpUnit_l84_134[16];
  assign when_FpUnit_l84_150 = _zz_when_FpUnit_l84_134[17];
  assign when_FpUnit_l84_151 = _zz_when_FpUnit_l84_134[18];
  assign when_FpUnit_l84_152 = _zz_when_FpUnit_l84_134[19];
  assign when_FpUnit_l84_153 = _zz_when_FpUnit_l84_134[20];
  assign when_FpUnit_l84_154 = _zz_when_FpUnit_l84_134[21];
  assign when_FpUnit_l84_155 = _zz_when_FpUnit_l84_134[22];
  assign when_FpUnit_l84_156 = _zz_when_FpUnit_l84_134[23];
  assign when_FpUnit_l84_157 = _zz_when_FpUnit_l84_134[24];
  assign when_FpUnit_l84_158 = _zz_when_FpUnit_l84_134[25];
  assign when_FpUnit_l84_159 = _zz_when_FpUnit_l84_134[26];
  assign when_FpUnit_l84_160 = _zz_when_FpUnit_l84_134[27];
  assign when_FpUnit_l84_161 = _zz_when_FpUnit_l84_134[28];
  assign when_FpUnit_l84_162 = _zz_when_FpUnit_l84_134[29];
  always @(*) begin
    _zz_flagUF_46 = 27'h0;
    if(when_FpUnit_l90_4) begin
      if(when_FpUnit_l91_4) begin
        _zz_flagUF_46 = _zz__zz_flagUF_46;
      end else begin
        _zz_flagUF_46 = _zz__zz_flagUF_46_2;
      end
    end
  end

  always @(*) begin
    _zz_flagUF_47 = 1'b0;
    if(when_FpUnit_l90_4) begin
      if(when_FpUnit_l91_4) begin
        _zz_flagUF_47 = (|(_zz_when_FpUnit_l84_134 & _zz__zz_flagUF_47));
      end else begin
        _zz_flagUF_47 = 1'b0;
      end
    end
  end

  assign _zz_flagUF_48 = ($signed(_zz__zz_flagUF_48) + $signed(_zz__zz_flagUF_48_2));
  assign when_FpUnit_l90_4 = (_zz_when_FpUnit_l84_134 != 30'h0);
  assign when_FpUnit_l91_4 = (5'h1a < _zz_when_FpUnit_l91_4);
  assign _zz_flagUF_49 = (_zz_when_FpUnit_l91_4 - 5'h1a);
  assign _zz_flagUF_50 = (_zz_flagUF_47 || ((_zz_when_FpUnit_l84_133 ? _zz__zz_flagUF_50 : _zz_when_FpUnit_l84_131) != 58'h0));
  assign _zz_res_25 = 1'b0;
  assign _zz_flagUF_51 = ($signed(_zz__zz_flagUF_51) < $signed(12'h001));
  assign _zz_when_FpUnit_l116_4 = (_zz_flagUF_51 ? _zz__zz_when_FpUnit_l116_4 : 12'h0);
  assign _zz_when_FpUnit_l119_4 = _zz_when_FpUnit_l116_4;
  assign when_FpUnit_l116_4 = ($signed(_zz_when_FpUnit_l116_4) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l116_4) begin
      _zz_flagUF_52 = _zz_flagUF_46;
    end else begin
      if(when_FpUnit_l119_4) begin
        _zz_flagUF_52 = 27'h0;
      end else begin
        _zz_flagUF_52 = _zz__zz_flagUF_52;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l116_4) begin
      _zz_flagUF_53 = _zz_flagUF_50;
    end else begin
      if(when_FpUnit_l119_4) begin
        _zz_flagUF_53 = ((|_zz_flagUF_46) || _zz_flagUF_50);
      end else begin
        _zz_flagUF_53 = ((|(_zz_flagUF_46 & _zz__zz_flagUF_53)) || _zz_flagUF_50);
      end
    end
  end

  assign when_FpUnit_l119_4 = (12'h01b <= _zz_when_FpUnit_l119_4);
  assign _zz_when_FpUnit_l150_20 = (_zz_flagUF_51 ? 12'hf82 : _zz_flagUF_48);
  assign _zz_flagUF_54 = _zz_flagUF_52[2];
  assign _zz_flagUF_55 = _zz_flagUF_52[1];
  assign _zz_flagUF_56 = (_zz_flagUF_52[0] || _zz_flagUF_53);
  assign _zz_when_FpUnit_l150_21 = _zz_flagUF_52[26 : 3];
  assign _zz_when_FpUnit_l150_22 = (_zz__zz_when_FpUnit_l150_22 + _zz__zz_when_FpUnit_l150_22_2);
  assign _zz_when_FpUnit_l150_23 = _zz_when_FpUnit_l150_22[24];
  assign _zz_res_26 = (_zz_when_FpUnit_l150_23 ? _zz__zz_res_26 : _zz__zz_res_26_1);
  assign _zz_when_FpUnit_l150_24 = ($signed(_zz__zz_when_FpUnit_l150_24) + $signed(12'h07f));
  assign _zz_flagUF_57 = ((_zz_flagUF_54 || _zz_flagUF_55) || _zz_flagUF_56);
  assign when_FpUnit_l150_4 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l150_24));
  assign _zz_res_27 = {_zz_res_25,{8'hff,23'h0}};
  assign _zz_res_28 = {_zz_res_25,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_29 = 32'h0;
    if(when_FpUnit_l150_4) begin
      _zz_res_29 = ((io_rm == 3'b001) ? _zz_res_28 : ((io_rm == 3'b010) ? (_zz_res_25 ? _zz_res_27 : _zz_res_28) : ((io_rm == 3'b011) ? (_zz_res_25 ? _zz_res_28 : _zz_res_27) : _zz_res_27)));
    end else begin
      if(when_FpUnit_l154_4) begin
        _zz_res_29 = {_zz_res_25,{8'h0,_zz_res_26[22 : 0]}};
      end else begin
        _zz_res_29 = {_zz_res_25,{_zz__zz_res_29,_zz_res_26[22 : 0]}};
      end
    end
  end

  assign when_FpUnit_l154_4 = ($signed(_zz_when_FpUnit_l150_24) < $signed(12'h001));
  always @(*) begin
    _zz_res_30 = _zz_res_29;
    if(when_FpUnit_l304) begin
      _zz_res_30 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l305) begin
        _zz_res_30 = 32'h7fc00000;
      end else begin
        if(when_FpUnit_l206) begin
          _zz_res_30 = {1'b0,{8'hff,23'h0}};
        end else begin
          if(when_FpUnit_l270) begin
            _zz_res_30 = {when_FpUnit_l481,{8'h0,23'h0}};
          end
        end
      end
    end
  end

  assign when_FpUnit_l305 = (when_FpUnit_l481 && (! when_FpUnit_l270));
  assign when_FpUnit_l396 = 1'b0;
  assign when_FpUnit_l394 = (when_FpUnit_l270 && when_FpUnit_l267);
  assign _zz_res_31 = (($signed(_zz_when_FpUnit_l180) < $signed(_zz_when_FpUnit_l180_1)) || (($signed(_zz_when_FpUnit_l180) == $signed(_zz_when_FpUnit_l180_1)) && (_zz_flagNX < _zz_when_FpUnit_l84)));
  assign _zz_res_32 = ((when_FpUnit_l481 == _zz_when_FpUnit_l205) ? (when_FpUnit_l481 ? ((! _zz_res_31) && (! (($signed(_zz_when_FpUnit_l180) == $signed(_zz_when_FpUnit_l180_1)) && (_zz_flagNX == _zz_when_FpUnit_l84)))) : _zz_res_31) : when_FpUnit_l481);
  always @(*) begin
    _zz_res_33 = io_a[31 : 0];
    if(when_FpUnit_l391) begin
      _zz_res_33 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l304) begin
        _zz_res_33 = io_b[31 : 0];
      end else begin
        if(when_FpUnit_l393) begin
          _zz_res_33 = io_a[31 : 0];
        end else begin
          if(when_FpUnit_l394) begin
            _zz_res_33 = {(when_FpUnit_l396 ? 1'b0 : 1'b1),{8'h0,23'h0}};
          end else begin
            if(when_FpUnit_l396) begin
              _zz_res_33 = (_zz_res_32 ? io_b[31 : 0] : io_a[31 : 0]);
            end else begin
              _zz_res_33 = (_zz_res_32 ? io_a[31 : 0] : io_b[31 : 0]);
            end
          end
        end
      end
    end
  end

  assign when_FpUnit_l391 = (when_FpUnit_l304 && when_FpUnit_l393);
  assign when_FpUnit_l396_1 = 1'b1;
  assign when_FpUnit_l394_1 = (when_FpUnit_l270 && when_FpUnit_l267);
  assign _zz_res_34 = (($signed(_zz_when_FpUnit_l180) < $signed(_zz_when_FpUnit_l180_1)) || (($signed(_zz_when_FpUnit_l180) == $signed(_zz_when_FpUnit_l180_1)) && (_zz_flagNX < _zz_when_FpUnit_l84)));
  assign _zz_res_35 = ((when_FpUnit_l481 == _zz_when_FpUnit_l205) ? (when_FpUnit_l481 ? ((! _zz_res_34) && (! (($signed(_zz_when_FpUnit_l180) == $signed(_zz_when_FpUnit_l180_1)) && (_zz_flagNX == _zz_when_FpUnit_l84)))) : _zz_res_34) : when_FpUnit_l481);
  always @(*) begin
    _zz_res_36 = io_a[31 : 0];
    if(when_FpUnit_l391_1) begin
      _zz_res_36 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l304) begin
        _zz_res_36 = io_b[31 : 0];
      end else begin
        if(when_FpUnit_l393) begin
          _zz_res_36 = io_a[31 : 0];
        end else begin
          if(when_FpUnit_l394_1) begin
            _zz_res_36 = {(when_FpUnit_l396_1 ? 1'b0 : 1'b1),{8'h0,23'h0}};
          end else begin
            if(when_FpUnit_l396_1) begin
              _zz_res_36 = (_zz_res_35 ? io_b[31 : 0] : io_a[31 : 0]);
            end else begin
              _zz_res_36 = (_zz_res_35 ? io_a[31 : 0] : io_b[31 : 0]);
            end
          end
        end
      end
    end
  end

  assign when_FpUnit_l391_1 = (when_FpUnit_l304 && when_FpUnit_l393);
  always @(*) begin
    _zz_res_37 = io_a[31 : 0];
    case(io_op)
      6'h07 : begin
        _zz_res_37[31] = io_b[31];
      end
      6'h08 : begin
        _zz_res_37[31] = (! io_b[31]);
      end
      6'h09 : begin
        _zz_res_37[31] = (io_a[31] ^ io_b[31]);
      end
      default : begin
      end
    endcase
  end

  assign _zz_res_38 = (((! when_FpUnit_l304) && (! when_FpUnit_l393)) && ((when_FpUnit_l270 && when_FpUnit_l267) || (((when_FpUnit_l481 == _zz_when_FpUnit_l205) && ($signed(_zz_when_FpUnit_l180) == $signed(_zz_when_FpUnit_l180_1))) && (_zz_flagNX == _zz_when_FpUnit_l84))));
  assign _zz_res_39 = ((((! when_FpUnit_l304) && (! when_FpUnit_l393)) && (! (when_FpUnit_l270 && when_FpUnit_l267))) && ((when_FpUnit_l481 != _zz_when_FpUnit_l205) ? when_FpUnit_l481 : (when_FpUnit_l481 ? ($signed(_zz_when_FpUnit_l180_1) < $signed(_zz_when_FpUnit_l180)) : ($signed(_zz_when_FpUnit_l180) < $signed(_zz_when_FpUnit_l180_1)))));
  always @(*) begin
    _zz_res_40 = 32'h0;
    case(io_op)
      6'h0a : begin
        _zz_res_40[0] = _zz_res_38;
      end
      6'h0b : begin
        _zz_res_40[0] = _zz_res_39;
      end
      6'h0c : begin
        _zz_res_40[0] = (_zz_res_38 || _zz_res_39);
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    _zz_res_41 = 10'h0;
    _zz_res_41[0] = (when_FpUnit_l481 && when_FpUnit_l206);
    _zz_res_41[1] = ((((when_FpUnit_l481 && (! when_FpUnit_l206)) && (! when_FpUnit_l304)) && (! when_FpUnit_l270)) && (! _zz_res));
    _zz_res_41[2] = (when_FpUnit_l481 && _zz_res);
    _zz_res_41[3] = (when_FpUnit_l481 && when_FpUnit_l270);
    _zz_res_41[4] = ((! when_FpUnit_l481) && when_FpUnit_l270);
    _zz_res_41[5] = ((! when_FpUnit_l481) && _zz_res);
    _zz_res_41[6] = (((((! when_FpUnit_l481) && (! when_FpUnit_l206)) && (! when_FpUnit_l304)) && (! when_FpUnit_l270)) && (! _zz_res));
    _zz_res_41[7] = ((! when_FpUnit_l481) && when_FpUnit_l206);
    _zz_res_41[8] = _zz_flagNV;
    _zz_res_41[9] = (when_FpUnit_l304 && (! _zz_flagNV));
  end

  assign _zz_when_FpUnit_l359_1 = ((when_FpUnit_l481 ^ _zz_when_FpUnit_l205) ^ 1'b0);
  assign _zz_when_FpUnit_l359_2 = (_zz_when_FpUnit_l359 ^ 1'b0);
  assign _zz_when_FpUnit_l84_135 = (_zz_flagNX * _zz_when_FpUnit_l84);
  assign _zz_when_FpUnit_l329_2 = ($signed(_zz__zz_when_FpUnit_l329_2) - $signed(12'h02e));
  assign _zz_when_FpUnit_l329_3 = ($signed(_zz__zz_when_FpUnit_l329_3) - $signed(12'h017));
  assign _zz_when_FpUnit_l329_4 = (($signed(_zz_when_FpUnit_l329_3) <= $signed(_zz_when_FpUnit_l329_2)) ? _zz_when_FpUnit_l329_2 : _zz_when_FpUnit_l329_3);
  assign _zz_when_FpUnit_l329_5 = ($signed(_zz_when_FpUnit_l329_4) - $signed(_zz_when_FpUnit_l329_2));
  assign _zz_when_FpUnit_l330 = _zz_when_FpUnit_l329_5;
  assign when_FpUnit_l329 = ($signed(_zz_when_FpUnit_l329_5) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l329) begin
      _zz_when_FpUnit_l84_136 = _zz__zz_when_FpUnit_l84_136;
    end else begin
      if(when_FpUnit_l330) begin
        _zz_when_FpUnit_l84_136 = 54'h0;
      end else begin
        _zz_when_FpUnit_l84_136 = _zz__zz_when_FpUnit_l84_136_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l329) begin
      _zz_flagUF_58 = 1'b0;
    end else begin
      if(when_FpUnit_l330) begin
        _zz_flagUF_58 = (|_zz_when_FpUnit_l84_135);
      end else begin
        _zz_flagUF_58 = (|(_zz__zz_flagUF_58 & _zz__zz_flagUF_58_1));
      end
    end
  end

  assign when_FpUnit_l330 = (12'h036 <= _zz_when_FpUnit_l330);
  assign _zz_when_FpUnit_l329_6 = ($signed(_zz_when_FpUnit_l329_4) - $signed(_zz_when_FpUnit_l329_3));
  assign _zz_when_FpUnit_l330_1 = _zz_when_FpUnit_l329_6;
  assign when_FpUnit_l329_1 = ($signed(_zz_when_FpUnit_l329_6) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l329_1) begin
      _zz_when_FpUnit_l84_137 = _zz__zz_when_FpUnit_l84_137;
    end else begin
      if(when_FpUnit_l330_1) begin
        _zz_when_FpUnit_l84_137 = 54'h0;
      end else begin
        _zz_when_FpUnit_l84_137 = _zz__zz_when_FpUnit_l84_137_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l329_1) begin
      _zz_flagUF_59 = 1'b0;
    end else begin
      if(when_FpUnit_l330_1) begin
        _zz_flagUF_59 = (|_zz_when_FpUnit_l84_1);
      end else begin
        _zz_flagUF_59 = (|(_zz__zz_flagUF_59 & _zz__zz_flagUF_59_1));
      end
    end
  end

  assign when_FpUnit_l330_1 = (12'h036 <= _zz_when_FpUnit_l330_1);
  assign _zz_when_FpUnit_l84_138 = _zz__zz_when_FpUnit_l84_138;
  assign _zz_when_FpUnit_l84_139 = _zz__zz_when_FpUnit_l84_139;
  assign _zz_when_FpUnit_l84_140 = ($signed(_zz__zz_when_FpUnit_l84_140) + $signed(_zz__zz_when_FpUnit_l84_140_3));
  assign _zz_when_FpUnit_l84_141 = _zz_when_FpUnit_l84_140[55];
  assign _zz_when_FpUnit_l84_142 = (_zz_when_FpUnit_l84_141 ? _zz__zz_when_FpUnit_l84_142 : _zz_when_FpUnit_l84_140);
  always @(*) begin
    _zz_when_FpUnit_l91_5 = 6'h0;
    if(when_FpUnit_l84_163) begin
      _zz_when_FpUnit_l91_5 = 6'h0;
    end
    if(when_FpUnit_l84_164) begin
      _zz_when_FpUnit_l91_5 = 6'h01;
    end
    if(when_FpUnit_l84_165) begin
      _zz_when_FpUnit_l91_5 = 6'h02;
    end
    if(when_FpUnit_l84_166) begin
      _zz_when_FpUnit_l91_5 = 6'h03;
    end
    if(when_FpUnit_l84_167) begin
      _zz_when_FpUnit_l91_5 = 6'h04;
    end
    if(when_FpUnit_l84_168) begin
      _zz_when_FpUnit_l91_5 = 6'h05;
    end
    if(when_FpUnit_l84_169) begin
      _zz_when_FpUnit_l91_5 = 6'h06;
    end
    if(when_FpUnit_l84_170) begin
      _zz_when_FpUnit_l91_5 = 6'h07;
    end
    if(when_FpUnit_l84_171) begin
      _zz_when_FpUnit_l91_5 = 6'h08;
    end
    if(when_FpUnit_l84_172) begin
      _zz_when_FpUnit_l91_5 = 6'h09;
    end
    if(when_FpUnit_l84_173) begin
      _zz_when_FpUnit_l91_5 = 6'h0a;
    end
    if(when_FpUnit_l84_174) begin
      _zz_when_FpUnit_l91_5 = 6'h0b;
    end
    if(when_FpUnit_l84_175) begin
      _zz_when_FpUnit_l91_5 = 6'h0c;
    end
    if(when_FpUnit_l84_176) begin
      _zz_when_FpUnit_l91_5 = 6'h0d;
    end
    if(when_FpUnit_l84_177) begin
      _zz_when_FpUnit_l91_5 = 6'h0e;
    end
    if(when_FpUnit_l84_178) begin
      _zz_when_FpUnit_l91_5 = 6'h0f;
    end
    if(when_FpUnit_l84_179) begin
      _zz_when_FpUnit_l91_5 = 6'h10;
    end
    if(when_FpUnit_l84_180) begin
      _zz_when_FpUnit_l91_5 = 6'h11;
    end
    if(when_FpUnit_l84_181) begin
      _zz_when_FpUnit_l91_5 = 6'h12;
    end
    if(when_FpUnit_l84_182) begin
      _zz_when_FpUnit_l91_5 = 6'h13;
    end
    if(when_FpUnit_l84_183) begin
      _zz_when_FpUnit_l91_5 = 6'h14;
    end
    if(when_FpUnit_l84_184) begin
      _zz_when_FpUnit_l91_5 = 6'h15;
    end
    if(when_FpUnit_l84_185) begin
      _zz_when_FpUnit_l91_5 = 6'h16;
    end
    if(when_FpUnit_l84_186) begin
      _zz_when_FpUnit_l91_5 = 6'h17;
    end
    if(when_FpUnit_l84_187) begin
      _zz_when_FpUnit_l91_5 = 6'h18;
    end
    if(when_FpUnit_l84_188) begin
      _zz_when_FpUnit_l91_5 = 6'h19;
    end
    if(when_FpUnit_l84_189) begin
      _zz_when_FpUnit_l91_5 = 6'h1a;
    end
    if(when_FpUnit_l84_190) begin
      _zz_when_FpUnit_l91_5 = 6'h1b;
    end
    if(when_FpUnit_l84_191) begin
      _zz_when_FpUnit_l91_5 = 6'h1c;
    end
    if(when_FpUnit_l84_192) begin
      _zz_when_FpUnit_l91_5 = 6'h1d;
    end
    if(when_FpUnit_l84_193) begin
      _zz_when_FpUnit_l91_5 = 6'h1e;
    end
    if(when_FpUnit_l84_194) begin
      _zz_when_FpUnit_l91_5 = 6'h1f;
    end
    if(when_FpUnit_l84_195) begin
      _zz_when_FpUnit_l91_5 = 6'h20;
    end
    if(when_FpUnit_l84_196) begin
      _zz_when_FpUnit_l91_5 = 6'h21;
    end
    if(when_FpUnit_l84_197) begin
      _zz_when_FpUnit_l91_5 = 6'h22;
    end
    if(when_FpUnit_l84_198) begin
      _zz_when_FpUnit_l91_5 = 6'h23;
    end
    if(when_FpUnit_l84_199) begin
      _zz_when_FpUnit_l91_5 = 6'h24;
    end
    if(when_FpUnit_l84_200) begin
      _zz_when_FpUnit_l91_5 = 6'h25;
    end
    if(when_FpUnit_l84_201) begin
      _zz_when_FpUnit_l91_5 = 6'h26;
    end
    if(when_FpUnit_l84_202) begin
      _zz_when_FpUnit_l91_5 = 6'h27;
    end
    if(when_FpUnit_l84_203) begin
      _zz_when_FpUnit_l91_5 = 6'h28;
    end
    if(when_FpUnit_l84_204) begin
      _zz_when_FpUnit_l91_5 = 6'h29;
    end
    if(when_FpUnit_l84_205) begin
      _zz_when_FpUnit_l91_5 = 6'h2a;
    end
    if(when_FpUnit_l84_206) begin
      _zz_when_FpUnit_l91_5 = 6'h2b;
    end
    if(when_FpUnit_l84_207) begin
      _zz_when_FpUnit_l91_5 = 6'h2c;
    end
    if(when_FpUnit_l84_208) begin
      _zz_when_FpUnit_l91_5 = 6'h2d;
    end
    if(when_FpUnit_l84_209) begin
      _zz_when_FpUnit_l91_5 = 6'h2e;
    end
    if(when_FpUnit_l84_210) begin
      _zz_when_FpUnit_l91_5 = 6'h2f;
    end
    if(when_FpUnit_l84_211) begin
      _zz_when_FpUnit_l91_5 = 6'h30;
    end
    if(when_FpUnit_l84_212) begin
      _zz_when_FpUnit_l91_5 = 6'h31;
    end
    if(when_FpUnit_l84_213) begin
      _zz_when_FpUnit_l91_5 = 6'h32;
    end
    if(when_FpUnit_l84_214) begin
      _zz_when_FpUnit_l91_5 = 6'h33;
    end
    if(when_FpUnit_l84_215) begin
      _zz_when_FpUnit_l91_5 = 6'h34;
    end
    if(when_FpUnit_l84_216) begin
      _zz_when_FpUnit_l91_5 = 6'h35;
    end
    if(when_FpUnit_l84_217) begin
      _zz_when_FpUnit_l91_5 = 6'h36;
    end
    if(when_FpUnit_l84_218) begin
      _zz_when_FpUnit_l91_5 = 6'h37;
    end
  end

  assign when_FpUnit_l84_163 = _zz_when_FpUnit_l84_142[0];
  assign when_FpUnit_l84_164 = _zz_when_FpUnit_l84_142[1];
  assign when_FpUnit_l84_165 = _zz_when_FpUnit_l84_142[2];
  assign when_FpUnit_l84_166 = _zz_when_FpUnit_l84_142[3];
  assign when_FpUnit_l84_167 = _zz_when_FpUnit_l84_142[4];
  assign when_FpUnit_l84_168 = _zz_when_FpUnit_l84_142[5];
  assign when_FpUnit_l84_169 = _zz_when_FpUnit_l84_142[6];
  assign when_FpUnit_l84_170 = _zz_when_FpUnit_l84_142[7];
  assign when_FpUnit_l84_171 = _zz_when_FpUnit_l84_142[8];
  assign when_FpUnit_l84_172 = _zz_when_FpUnit_l84_142[9];
  assign when_FpUnit_l84_173 = _zz_when_FpUnit_l84_142[10];
  assign when_FpUnit_l84_174 = _zz_when_FpUnit_l84_142[11];
  assign when_FpUnit_l84_175 = _zz_when_FpUnit_l84_142[12];
  assign when_FpUnit_l84_176 = _zz_when_FpUnit_l84_142[13];
  assign when_FpUnit_l84_177 = _zz_when_FpUnit_l84_142[14];
  assign when_FpUnit_l84_178 = _zz_when_FpUnit_l84_142[15];
  assign when_FpUnit_l84_179 = _zz_when_FpUnit_l84_142[16];
  assign when_FpUnit_l84_180 = _zz_when_FpUnit_l84_142[17];
  assign when_FpUnit_l84_181 = _zz_when_FpUnit_l84_142[18];
  assign when_FpUnit_l84_182 = _zz_when_FpUnit_l84_142[19];
  assign when_FpUnit_l84_183 = _zz_when_FpUnit_l84_142[20];
  assign when_FpUnit_l84_184 = _zz_when_FpUnit_l84_142[21];
  assign when_FpUnit_l84_185 = _zz_when_FpUnit_l84_142[22];
  assign when_FpUnit_l84_186 = _zz_when_FpUnit_l84_142[23];
  assign when_FpUnit_l84_187 = _zz_when_FpUnit_l84_142[24];
  assign when_FpUnit_l84_188 = _zz_when_FpUnit_l84_142[25];
  assign when_FpUnit_l84_189 = _zz_when_FpUnit_l84_142[26];
  assign when_FpUnit_l84_190 = _zz_when_FpUnit_l84_142[27];
  assign when_FpUnit_l84_191 = _zz_when_FpUnit_l84_142[28];
  assign when_FpUnit_l84_192 = _zz_when_FpUnit_l84_142[29];
  assign when_FpUnit_l84_193 = _zz_when_FpUnit_l84_142[30];
  assign when_FpUnit_l84_194 = _zz_when_FpUnit_l84_142[31];
  assign when_FpUnit_l84_195 = _zz_when_FpUnit_l84_142[32];
  assign when_FpUnit_l84_196 = _zz_when_FpUnit_l84_142[33];
  assign when_FpUnit_l84_197 = _zz_when_FpUnit_l84_142[34];
  assign when_FpUnit_l84_198 = _zz_when_FpUnit_l84_142[35];
  assign when_FpUnit_l84_199 = _zz_when_FpUnit_l84_142[36];
  assign when_FpUnit_l84_200 = _zz_when_FpUnit_l84_142[37];
  assign when_FpUnit_l84_201 = _zz_when_FpUnit_l84_142[38];
  assign when_FpUnit_l84_202 = _zz_when_FpUnit_l84_142[39];
  assign when_FpUnit_l84_203 = _zz_when_FpUnit_l84_142[40];
  assign when_FpUnit_l84_204 = _zz_when_FpUnit_l84_142[41];
  assign when_FpUnit_l84_205 = _zz_when_FpUnit_l84_142[42];
  assign when_FpUnit_l84_206 = _zz_when_FpUnit_l84_142[43];
  assign when_FpUnit_l84_207 = _zz_when_FpUnit_l84_142[44];
  assign when_FpUnit_l84_208 = _zz_when_FpUnit_l84_142[45];
  assign when_FpUnit_l84_209 = _zz_when_FpUnit_l84_142[46];
  assign when_FpUnit_l84_210 = _zz_when_FpUnit_l84_142[47];
  assign when_FpUnit_l84_211 = _zz_when_FpUnit_l84_142[48];
  assign when_FpUnit_l84_212 = _zz_when_FpUnit_l84_142[49];
  assign when_FpUnit_l84_213 = _zz_when_FpUnit_l84_142[50];
  assign when_FpUnit_l84_214 = _zz_when_FpUnit_l84_142[51];
  assign when_FpUnit_l84_215 = _zz_when_FpUnit_l84_142[52];
  assign when_FpUnit_l84_216 = _zz_when_FpUnit_l84_142[53];
  assign when_FpUnit_l84_217 = _zz_when_FpUnit_l84_142[54];
  assign when_FpUnit_l84_218 = _zz_when_FpUnit_l84_142[55];
  always @(*) begin
    _zz_flagUF_60 = 27'h0;
    if(when_FpUnit_l90_5) begin
      if(when_FpUnit_l91_5) begin
        _zz_flagUF_60 = _zz__zz_flagUF_60;
      end else begin
        _zz_flagUF_60 = _zz__zz_flagUF_60_2;
      end
    end
  end

  always @(*) begin
    _zz_flagUF_61 = 1'b0;
    if(when_FpUnit_l90_5) begin
      if(when_FpUnit_l91_5) begin
        _zz_flagUF_61 = (|(_zz_when_FpUnit_l84_142 & _zz__zz_flagUF_61));
      end else begin
        _zz_flagUF_61 = 1'b0;
      end
    end
  end

  assign _zz_flagUF_62 = ($signed(_zz__zz_flagUF_62) + $signed(_zz_when_FpUnit_l329_4));
  assign when_FpUnit_l90_5 = (_zz_when_FpUnit_l84_142 != 56'h0);
  assign when_FpUnit_l91_5 = (6'h1a < _zz_when_FpUnit_l91_5);
  assign _zz_flagUF_63 = (_zz_when_FpUnit_l91_5 - 6'h1a);
  assign _zz_flagUF_64 = ((_zz_flagUF_61 || _zz_flagUF_58) || _zz_flagUF_59);
  assign _zz_flagUF_65 = ($signed(_zz__zz_flagUF_65) < $signed(12'h001));
  assign _zz_when_FpUnit_l116_5 = (_zz_flagUF_65 ? _zz__zz_when_FpUnit_l116_5 : 12'h0);
  assign _zz_when_FpUnit_l119_5 = _zz_when_FpUnit_l116_5;
  assign when_FpUnit_l116_5 = ($signed(_zz_when_FpUnit_l116_5) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l116_5) begin
      _zz_flagUF_66 = _zz_flagUF_60;
    end else begin
      if(when_FpUnit_l119_5) begin
        _zz_flagUF_66 = 27'h0;
      end else begin
        _zz_flagUF_66 = _zz__zz_flagUF_66;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l116_5) begin
      _zz_flagUF_67 = _zz_flagUF_64;
    end else begin
      if(when_FpUnit_l119_5) begin
        _zz_flagUF_67 = ((|_zz_flagUF_60) || _zz_flagUF_64);
      end else begin
        _zz_flagUF_67 = ((|(_zz_flagUF_60 & _zz__zz_flagUF_67)) || _zz_flagUF_64);
      end
    end
  end

  assign when_FpUnit_l119_5 = (12'h01b <= _zz_when_FpUnit_l119_5);
  assign _zz_when_FpUnit_l150_25 = (_zz_flagUF_65 ? 12'hf82 : _zz_flagUF_62);
  assign _zz_flagUF_68 = _zz_flagUF_66[2];
  assign _zz_flagUF_69 = _zz_flagUF_66[1];
  assign _zz_flagUF_70 = (_zz_flagUF_66[0] || _zz_flagUF_67);
  assign _zz_when_FpUnit_l150_26 = _zz_flagUF_66[26 : 3];
  assign _zz_when_FpUnit_l150_27 = (_zz__zz_when_FpUnit_l150_27 + _zz__zz_when_FpUnit_l150_27_2);
  assign _zz_when_FpUnit_l150_28 = _zz_when_FpUnit_l150_27[24];
  assign _zz_res_42 = (_zz_when_FpUnit_l150_28 ? _zz__zz_res_42 : _zz__zz_res_42_1);
  assign _zz_when_FpUnit_l150_29 = ($signed(_zz__zz_when_FpUnit_l150_29) + $signed(12'h07f));
  assign _zz_flagUF_71 = ((_zz_flagUF_68 || _zz_flagUF_69) || _zz_flagUF_70);
  assign when_FpUnit_l150_5 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l150_29));
  assign _zz_res_43 = {_zz_when_FpUnit_l84_141,{8'hff,23'h0}};
  assign _zz_res_44 = {_zz_when_FpUnit_l84_141,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_45 = 32'h0;
    if(when_FpUnit_l150_5) begin
      _zz_res_45 = ((io_rm == 3'b001) ? _zz_res_44 : ((io_rm == 3'b010) ? (_zz_when_FpUnit_l84_141 ? _zz_res_43 : _zz_res_44) : ((io_rm == 3'b011) ? (_zz_when_FpUnit_l84_141 ? _zz_res_44 : _zz_res_43) : _zz_res_43)));
    end else begin
      if(when_FpUnit_l154_5) begin
        _zz_res_45 = {_zz_when_FpUnit_l84_141,{8'h0,_zz_res_42[22 : 0]}};
      end else begin
        _zz_res_45 = {_zz_when_FpUnit_l84_141,{_zz__zz_res_45,_zz_res_42[22 : 0]}};
      end
    end
  end

  assign when_FpUnit_l154_5 = ($signed(_zz_when_FpUnit_l150_29) < $signed(12'h001));
  always @(*) begin
    _zz_res_46 = _zz_res_45;
    if(when_FpUnit_l357) begin
      _zz_res_46 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l358) begin
        _zz_res_46 = 32'h7fc00000;
      end else begin
        if(when_FpUnit_l359) begin
          _zz_res_46 = 32'h7fc00000;
        end else begin
          if(when_FpUnit_l360) begin
            _zz_res_46 = {_zz_when_FpUnit_l359_1,{8'hff,23'h0}};
          end else begin
            if(when_FpUnit_l361) begin
              _zz_res_46 = {_zz_when_FpUnit_l359_2,{8'hff,23'h0}};
            end
          end
        end
      end
    end
  end

  assign when_FpUnit_l357 = ((when_FpUnit_l304 || when_FpUnit_l393) || _zz_when_FpUnit_l357);
  assign when_FpUnit_l358 = ((when_FpUnit_l206 && when_FpUnit_l267) || (when_FpUnit_l270 && when_FpUnit_l207));
  assign when_FpUnit_l359 = (((when_FpUnit_l206 || when_FpUnit_l207) && when_FpUnit_l361) && (_zz_when_FpUnit_l359_1 != _zz_when_FpUnit_l359_2));
  assign when_FpUnit_l360 = (when_FpUnit_l206 || when_FpUnit_l207);
  assign _zz_when_FpUnit_l359_3 = ((when_FpUnit_l481 ^ _zz_when_FpUnit_l205) ^ 1'b0);
  assign _zz_when_FpUnit_l359_4 = (_zz_when_FpUnit_l359 ^ 1'b1);
  assign _zz_when_FpUnit_l84_143 = (_zz_flagNX * _zz_when_FpUnit_l84);
  assign _zz_when_FpUnit_l329_7 = ($signed(_zz__zz_when_FpUnit_l329_7) - $signed(12'h02e));
  assign _zz_when_FpUnit_l329_8 = ($signed(_zz__zz_when_FpUnit_l329_8) - $signed(12'h017));
  assign _zz_when_FpUnit_l329_9 = (($signed(_zz_when_FpUnit_l329_8) <= $signed(_zz_when_FpUnit_l329_7)) ? _zz_when_FpUnit_l329_7 : _zz_when_FpUnit_l329_8);
  assign _zz_when_FpUnit_l329_10 = ($signed(_zz_when_FpUnit_l329_9) - $signed(_zz_when_FpUnit_l329_7));
  assign _zz_when_FpUnit_l330_2 = _zz_when_FpUnit_l329_10;
  assign when_FpUnit_l329_2 = ($signed(_zz_when_FpUnit_l329_10) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l329_2) begin
      _zz_when_FpUnit_l84_144 = _zz__zz_when_FpUnit_l84_144;
    end else begin
      if(when_FpUnit_l330_2) begin
        _zz_when_FpUnit_l84_144 = 54'h0;
      end else begin
        _zz_when_FpUnit_l84_144 = _zz__zz_when_FpUnit_l84_144_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l329_2) begin
      _zz_flagUF_72 = 1'b0;
    end else begin
      if(when_FpUnit_l330_2) begin
        _zz_flagUF_72 = (|_zz_when_FpUnit_l84_143);
      end else begin
        _zz_flagUF_72 = (|(_zz__zz_flagUF_72 & _zz__zz_flagUF_72_1));
      end
    end
  end

  assign when_FpUnit_l330_2 = (12'h036 <= _zz_when_FpUnit_l330_2);
  assign _zz_when_FpUnit_l329_11 = ($signed(_zz_when_FpUnit_l329_9) - $signed(_zz_when_FpUnit_l329_8));
  assign _zz_when_FpUnit_l330_3 = _zz_when_FpUnit_l329_11;
  assign when_FpUnit_l329_3 = ($signed(_zz_when_FpUnit_l329_11) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l329_3) begin
      _zz_when_FpUnit_l84_145 = _zz__zz_when_FpUnit_l84_145;
    end else begin
      if(when_FpUnit_l330_3) begin
        _zz_when_FpUnit_l84_145 = 54'h0;
      end else begin
        _zz_when_FpUnit_l84_145 = _zz__zz_when_FpUnit_l84_145_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l329_3) begin
      _zz_flagUF_73 = 1'b0;
    end else begin
      if(when_FpUnit_l330_3) begin
        _zz_flagUF_73 = (|_zz_when_FpUnit_l84_1);
      end else begin
        _zz_flagUF_73 = (|(_zz__zz_flagUF_73 & _zz__zz_flagUF_73_1));
      end
    end
  end

  assign when_FpUnit_l330_3 = (12'h036 <= _zz_when_FpUnit_l330_3);
  assign _zz_when_FpUnit_l84_146 = _zz__zz_when_FpUnit_l84_146;
  assign _zz_when_FpUnit_l84_147 = _zz__zz_when_FpUnit_l84_147;
  assign _zz_when_FpUnit_l84_148 = ($signed(_zz__zz_when_FpUnit_l84_148) + $signed(_zz__zz_when_FpUnit_l84_148_3));
  assign _zz_when_FpUnit_l84_149 = _zz_when_FpUnit_l84_148[55];
  assign _zz_when_FpUnit_l84_150 = (_zz_when_FpUnit_l84_149 ? _zz__zz_when_FpUnit_l84_150 : _zz_when_FpUnit_l84_148);
  always @(*) begin
    _zz_when_FpUnit_l91_6 = 6'h0;
    if(when_FpUnit_l84_219) begin
      _zz_when_FpUnit_l91_6 = 6'h0;
    end
    if(when_FpUnit_l84_220) begin
      _zz_when_FpUnit_l91_6 = 6'h01;
    end
    if(when_FpUnit_l84_221) begin
      _zz_when_FpUnit_l91_6 = 6'h02;
    end
    if(when_FpUnit_l84_222) begin
      _zz_when_FpUnit_l91_6 = 6'h03;
    end
    if(when_FpUnit_l84_223) begin
      _zz_when_FpUnit_l91_6 = 6'h04;
    end
    if(when_FpUnit_l84_224) begin
      _zz_when_FpUnit_l91_6 = 6'h05;
    end
    if(when_FpUnit_l84_225) begin
      _zz_when_FpUnit_l91_6 = 6'h06;
    end
    if(when_FpUnit_l84_226) begin
      _zz_when_FpUnit_l91_6 = 6'h07;
    end
    if(when_FpUnit_l84_227) begin
      _zz_when_FpUnit_l91_6 = 6'h08;
    end
    if(when_FpUnit_l84_228) begin
      _zz_when_FpUnit_l91_6 = 6'h09;
    end
    if(when_FpUnit_l84_229) begin
      _zz_when_FpUnit_l91_6 = 6'h0a;
    end
    if(when_FpUnit_l84_230) begin
      _zz_when_FpUnit_l91_6 = 6'h0b;
    end
    if(when_FpUnit_l84_231) begin
      _zz_when_FpUnit_l91_6 = 6'h0c;
    end
    if(when_FpUnit_l84_232) begin
      _zz_when_FpUnit_l91_6 = 6'h0d;
    end
    if(when_FpUnit_l84_233) begin
      _zz_when_FpUnit_l91_6 = 6'h0e;
    end
    if(when_FpUnit_l84_234) begin
      _zz_when_FpUnit_l91_6 = 6'h0f;
    end
    if(when_FpUnit_l84_235) begin
      _zz_when_FpUnit_l91_6 = 6'h10;
    end
    if(when_FpUnit_l84_236) begin
      _zz_when_FpUnit_l91_6 = 6'h11;
    end
    if(when_FpUnit_l84_237) begin
      _zz_when_FpUnit_l91_6 = 6'h12;
    end
    if(when_FpUnit_l84_238) begin
      _zz_when_FpUnit_l91_6 = 6'h13;
    end
    if(when_FpUnit_l84_239) begin
      _zz_when_FpUnit_l91_6 = 6'h14;
    end
    if(when_FpUnit_l84_240) begin
      _zz_when_FpUnit_l91_6 = 6'h15;
    end
    if(when_FpUnit_l84_241) begin
      _zz_when_FpUnit_l91_6 = 6'h16;
    end
    if(when_FpUnit_l84_242) begin
      _zz_when_FpUnit_l91_6 = 6'h17;
    end
    if(when_FpUnit_l84_243) begin
      _zz_when_FpUnit_l91_6 = 6'h18;
    end
    if(when_FpUnit_l84_244) begin
      _zz_when_FpUnit_l91_6 = 6'h19;
    end
    if(when_FpUnit_l84_245) begin
      _zz_when_FpUnit_l91_6 = 6'h1a;
    end
    if(when_FpUnit_l84_246) begin
      _zz_when_FpUnit_l91_6 = 6'h1b;
    end
    if(when_FpUnit_l84_247) begin
      _zz_when_FpUnit_l91_6 = 6'h1c;
    end
    if(when_FpUnit_l84_248) begin
      _zz_when_FpUnit_l91_6 = 6'h1d;
    end
    if(when_FpUnit_l84_249) begin
      _zz_when_FpUnit_l91_6 = 6'h1e;
    end
    if(when_FpUnit_l84_250) begin
      _zz_when_FpUnit_l91_6 = 6'h1f;
    end
    if(when_FpUnit_l84_251) begin
      _zz_when_FpUnit_l91_6 = 6'h20;
    end
    if(when_FpUnit_l84_252) begin
      _zz_when_FpUnit_l91_6 = 6'h21;
    end
    if(when_FpUnit_l84_253) begin
      _zz_when_FpUnit_l91_6 = 6'h22;
    end
    if(when_FpUnit_l84_254) begin
      _zz_when_FpUnit_l91_6 = 6'h23;
    end
    if(when_FpUnit_l84_255) begin
      _zz_when_FpUnit_l91_6 = 6'h24;
    end
    if(when_FpUnit_l84_256) begin
      _zz_when_FpUnit_l91_6 = 6'h25;
    end
    if(when_FpUnit_l84_257) begin
      _zz_when_FpUnit_l91_6 = 6'h26;
    end
    if(when_FpUnit_l84_258) begin
      _zz_when_FpUnit_l91_6 = 6'h27;
    end
    if(when_FpUnit_l84_259) begin
      _zz_when_FpUnit_l91_6 = 6'h28;
    end
    if(when_FpUnit_l84_260) begin
      _zz_when_FpUnit_l91_6 = 6'h29;
    end
    if(when_FpUnit_l84_261) begin
      _zz_when_FpUnit_l91_6 = 6'h2a;
    end
    if(when_FpUnit_l84_262) begin
      _zz_when_FpUnit_l91_6 = 6'h2b;
    end
    if(when_FpUnit_l84_263) begin
      _zz_when_FpUnit_l91_6 = 6'h2c;
    end
    if(when_FpUnit_l84_264) begin
      _zz_when_FpUnit_l91_6 = 6'h2d;
    end
    if(when_FpUnit_l84_265) begin
      _zz_when_FpUnit_l91_6 = 6'h2e;
    end
    if(when_FpUnit_l84_266) begin
      _zz_when_FpUnit_l91_6 = 6'h2f;
    end
    if(when_FpUnit_l84_267) begin
      _zz_when_FpUnit_l91_6 = 6'h30;
    end
    if(when_FpUnit_l84_268) begin
      _zz_when_FpUnit_l91_6 = 6'h31;
    end
    if(when_FpUnit_l84_269) begin
      _zz_when_FpUnit_l91_6 = 6'h32;
    end
    if(when_FpUnit_l84_270) begin
      _zz_when_FpUnit_l91_6 = 6'h33;
    end
    if(when_FpUnit_l84_271) begin
      _zz_when_FpUnit_l91_6 = 6'h34;
    end
    if(when_FpUnit_l84_272) begin
      _zz_when_FpUnit_l91_6 = 6'h35;
    end
    if(when_FpUnit_l84_273) begin
      _zz_when_FpUnit_l91_6 = 6'h36;
    end
    if(when_FpUnit_l84_274) begin
      _zz_when_FpUnit_l91_6 = 6'h37;
    end
  end

  assign when_FpUnit_l84_219 = _zz_when_FpUnit_l84_150[0];
  assign when_FpUnit_l84_220 = _zz_when_FpUnit_l84_150[1];
  assign when_FpUnit_l84_221 = _zz_when_FpUnit_l84_150[2];
  assign when_FpUnit_l84_222 = _zz_when_FpUnit_l84_150[3];
  assign when_FpUnit_l84_223 = _zz_when_FpUnit_l84_150[4];
  assign when_FpUnit_l84_224 = _zz_when_FpUnit_l84_150[5];
  assign when_FpUnit_l84_225 = _zz_when_FpUnit_l84_150[6];
  assign when_FpUnit_l84_226 = _zz_when_FpUnit_l84_150[7];
  assign when_FpUnit_l84_227 = _zz_when_FpUnit_l84_150[8];
  assign when_FpUnit_l84_228 = _zz_when_FpUnit_l84_150[9];
  assign when_FpUnit_l84_229 = _zz_when_FpUnit_l84_150[10];
  assign when_FpUnit_l84_230 = _zz_when_FpUnit_l84_150[11];
  assign when_FpUnit_l84_231 = _zz_when_FpUnit_l84_150[12];
  assign when_FpUnit_l84_232 = _zz_when_FpUnit_l84_150[13];
  assign when_FpUnit_l84_233 = _zz_when_FpUnit_l84_150[14];
  assign when_FpUnit_l84_234 = _zz_when_FpUnit_l84_150[15];
  assign when_FpUnit_l84_235 = _zz_when_FpUnit_l84_150[16];
  assign when_FpUnit_l84_236 = _zz_when_FpUnit_l84_150[17];
  assign when_FpUnit_l84_237 = _zz_when_FpUnit_l84_150[18];
  assign when_FpUnit_l84_238 = _zz_when_FpUnit_l84_150[19];
  assign when_FpUnit_l84_239 = _zz_when_FpUnit_l84_150[20];
  assign when_FpUnit_l84_240 = _zz_when_FpUnit_l84_150[21];
  assign when_FpUnit_l84_241 = _zz_when_FpUnit_l84_150[22];
  assign when_FpUnit_l84_242 = _zz_when_FpUnit_l84_150[23];
  assign when_FpUnit_l84_243 = _zz_when_FpUnit_l84_150[24];
  assign when_FpUnit_l84_244 = _zz_when_FpUnit_l84_150[25];
  assign when_FpUnit_l84_245 = _zz_when_FpUnit_l84_150[26];
  assign when_FpUnit_l84_246 = _zz_when_FpUnit_l84_150[27];
  assign when_FpUnit_l84_247 = _zz_when_FpUnit_l84_150[28];
  assign when_FpUnit_l84_248 = _zz_when_FpUnit_l84_150[29];
  assign when_FpUnit_l84_249 = _zz_when_FpUnit_l84_150[30];
  assign when_FpUnit_l84_250 = _zz_when_FpUnit_l84_150[31];
  assign when_FpUnit_l84_251 = _zz_when_FpUnit_l84_150[32];
  assign when_FpUnit_l84_252 = _zz_when_FpUnit_l84_150[33];
  assign when_FpUnit_l84_253 = _zz_when_FpUnit_l84_150[34];
  assign when_FpUnit_l84_254 = _zz_when_FpUnit_l84_150[35];
  assign when_FpUnit_l84_255 = _zz_when_FpUnit_l84_150[36];
  assign when_FpUnit_l84_256 = _zz_when_FpUnit_l84_150[37];
  assign when_FpUnit_l84_257 = _zz_when_FpUnit_l84_150[38];
  assign when_FpUnit_l84_258 = _zz_when_FpUnit_l84_150[39];
  assign when_FpUnit_l84_259 = _zz_when_FpUnit_l84_150[40];
  assign when_FpUnit_l84_260 = _zz_when_FpUnit_l84_150[41];
  assign when_FpUnit_l84_261 = _zz_when_FpUnit_l84_150[42];
  assign when_FpUnit_l84_262 = _zz_when_FpUnit_l84_150[43];
  assign when_FpUnit_l84_263 = _zz_when_FpUnit_l84_150[44];
  assign when_FpUnit_l84_264 = _zz_when_FpUnit_l84_150[45];
  assign when_FpUnit_l84_265 = _zz_when_FpUnit_l84_150[46];
  assign when_FpUnit_l84_266 = _zz_when_FpUnit_l84_150[47];
  assign when_FpUnit_l84_267 = _zz_when_FpUnit_l84_150[48];
  assign when_FpUnit_l84_268 = _zz_when_FpUnit_l84_150[49];
  assign when_FpUnit_l84_269 = _zz_when_FpUnit_l84_150[50];
  assign when_FpUnit_l84_270 = _zz_when_FpUnit_l84_150[51];
  assign when_FpUnit_l84_271 = _zz_when_FpUnit_l84_150[52];
  assign when_FpUnit_l84_272 = _zz_when_FpUnit_l84_150[53];
  assign when_FpUnit_l84_273 = _zz_when_FpUnit_l84_150[54];
  assign when_FpUnit_l84_274 = _zz_when_FpUnit_l84_150[55];
  always @(*) begin
    _zz_flagUF_74 = 27'h0;
    if(when_FpUnit_l90_6) begin
      if(when_FpUnit_l91_6) begin
        _zz_flagUF_74 = _zz__zz_flagUF_74;
      end else begin
        _zz_flagUF_74 = _zz__zz_flagUF_74_2;
      end
    end
  end

  always @(*) begin
    _zz_flagUF_75 = 1'b0;
    if(when_FpUnit_l90_6) begin
      if(when_FpUnit_l91_6) begin
        _zz_flagUF_75 = (|(_zz_when_FpUnit_l84_150 & _zz__zz_flagUF_75));
      end else begin
        _zz_flagUF_75 = 1'b0;
      end
    end
  end

  assign _zz_flagUF_76 = ($signed(_zz__zz_flagUF_76) + $signed(_zz_when_FpUnit_l329_9));
  assign when_FpUnit_l90_6 = (_zz_when_FpUnit_l84_150 != 56'h0);
  assign when_FpUnit_l91_6 = (6'h1a < _zz_when_FpUnit_l91_6);
  assign _zz_flagUF_77 = (_zz_when_FpUnit_l91_6 - 6'h1a);
  assign _zz_flagUF_78 = ((_zz_flagUF_75 || _zz_flagUF_72) || _zz_flagUF_73);
  assign _zz_flagUF_79 = ($signed(_zz__zz_flagUF_79) < $signed(12'h001));
  assign _zz_when_FpUnit_l116_6 = (_zz_flagUF_79 ? _zz__zz_when_FpUnit_l116_6 : 12'h0);
  assign _zz_when_FpUnit_l119_6 = _zz_when_FpUnit_l116_6;
  assign when_FpUnit_l116_6 = ($signed(_zz_when_FpUnit_l116_6) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l116_6) begin
      _zz_flagUF_80 = _zz_flagUF_74;
    end else begin
      if(when_FpUnit_l119_6) begin
        _zz_flagUF_80 = 27'h0;
      end else begin
        _zz_flagUF_80 = _zz__zz_flagUF_80;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l116_6) begin
      _zz_flagUF_81 = _zz_flagUF_78;
    end else begin
      if(when_FpUnit_l119_6) begin
        _zz_flagUF_81 = ((|_zz_flagUF_74) || _zz_flagUF_78);
      end else begin
        _zz_flagUF_81 = ((|(_zz_flagUF_74 & _zz__zz_flagUF_81)) || _zz_flagUF_78);
      end
    end
  end

  assign when_FpUnit_l119_6 = (12'h01b <= _zz_when_FpUnit_l119_6);
  assign _zz_when_FpUnit_l150_30 = (_zz_flagUF_79 ? 12'hf82 : _zz_flagUF_76);
  assign _zz_flagUF_82 = _zz_flagUF_80[2];
  assign _zz_flagUF_83 = _zz_flagUF_80[1];
  assign _zz_flagUF_84 = (_zz_flagUF_80[0] || _zz_flagUF_81);
  assign _zz_when_FpUnit_l150_31 = _zz_flagUF_80[26 : 3];
  assign _zz_when_FpUnit_l150_32 = (_zz__zz_when_FpUnit_l150_32 + _zz__zz_when_FpUnit_l150_32_2);
  assign _zz_when_FpUnit_l150_33 = _zz_when_FpUnit_l150_32[24];
  assign _zz_res_47 = (_zz_when_FpUnit_l150_33 ? _zz__zz_res_47 : _zz__zz_res_47_1);
  assign _zz_when_FpUnit_l150_34 = ($signed(_zz__zz_when_FpUnit_l150_34) + $signed(12'h07f));
  assign _zz_flagUF_85 = ((_zz_flagUF_82 || _zz_flagUF_83) || _zz_flagUF_84);
  assign when_FpUnit_l150_6 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l150_34));
  assign _zz_res_48 = {_zz_when_FpUnit_l84_149,{8'hff,23'h0}};
  assign _zz_res_49 = {_zz_when_FpUnit_l84_149,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_50 = 32'h0;
    if(when_FpUnit_l150_6) begin
      _zz_res_50 = ((io_rm == 3'b001) ? _zz_res_49 : ((io_rm == 3'b010) ? (_zz_when_FpUnit_l84_149 ? _zz_res_48 : _zz_res_49) : ((io_rm == 3'b011) ? (_zz_when_FpUnit_l84_149 ? _zz_res_49 : _zz_res_48) : _zz_res_48)));
    end else begin
      if(when_FpUnit_l154_6) begin
        _zz_res_50 = {_zz_when_FpUnit_l84_149,{8'h0,_zz_res_47[22 : 0]}};
      end else begin
        _zz_res_50 = {_zz_when_FpUnit_l84_149,{_zz__zz_res_50,_zz_res_47[22 : 0]}};
      end
    end
  end

  assign when_FpUnit_l154_6 = ($signed(_zz_when_FpUnit_l150_34) < $signed(12'h001));
  always @(*) begin
    _zz_res_51 = _zz_res_50;
    if(when_FpUnit_l357_1) begin
      _zz_res_51 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l358_1) begin
        _zz_res_51 = 32'h7fc00000;
      end else begin
        if(when_FpUnit_l359_1) begin
          _zz_res_51 = 32'h7fc00000;
        end else begin
          if(when_FpUnit_l360_1) begin
            _zz_res_51 = {_zz_when_FpUnit_l359_3,{8'hff,23'h0}};
          end else begin
            if(when_FpUnit_l361) begin
              _zz_res_51 = {_zz_when_FpUnit_l359_4,{8'hff,23'h0}};
            end
          end
        end
      end
    end
  end

  assign when_FpUnit_l357_1 = ((when_FpUnit_l304 || when_FpUnit_l393) || _zz_when_FpUnit_l357);
  assign when_FpUnit_l358_1 = ((when_FpUnit_l206 && when_FpUnit_l267) || (when_FpUnit_l270 && when_FpUnit_l207));
  assign when_FpUnit_l359_1 = (((when_FpUnit_l206 || when_FpUnit_l207) && when_FpUnit_l361) && (_zz_when_FpUnit_l359_3 != _zz_when_FpUnit_l359_4));
  assign when_FpUnit_l360_1 = (when_FpUnit_l206 || when_FpUnit_l207);
  assign _zz_when_FpUnit_l359_5 = ((when_FpUnit_l481 ^ _zz_when_FpUnit_l205) ^ 1'b1);
  assign _zz_when_FpUnit_l359_6 = (_zz_when_FpUnit_l359 ^ 1'b0);
  assign _zz_when_FpUnit_l84_151 = (_zz_flagNX * _zz_when_FpUnit_l84);
  assign _zz_when_FpUnit_l329_12 = ($signed(_zz__zz_when_FpUnit_l329_12) - $signed(12'h02e));
  assign _zz_when_FpUnit_l329_13 = ($signed(_zz__zz_when_FpUnit_l329_13) - $signed(12'h017));
  assign _zz_when_FpUnit_l329_14 = (($signed(_zz_when_FpUnit_l329_13) <= $signed(_zz_when_FpUnit_l329_12)) ? _zz_when_FpUnit_l329_12 : _zz_when_FpUnit_l329_13);
  assign _zz_when_FpUnit_l329_15 = ($signed(_zz_when_FpUnit_l329_14) - $signed(_zz_when_FpUnit_l329_12));
  assign _zz_when_FpUnit_l330_4 = _zz_when_FpUnit_l329_15;
  assign when_FpUnit_l329_4 = ($signed(_zz_when_FpUnit_l329_15) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l329_4) begin
      _zz_when_FpUnit_l84_152 = _zz__zz_when_FpUnit_l84_152;
    end else begin
      if(when_FpUnit_l330_4) begin
        _zz_when_FpUnit_l84_152 = 54'h0;
      end else begin
        _zz_when_FpUnit_l84_152 = _zz__zz_when_FpUnit_l84_152_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l329_4) begin
      _zz_flagUF_86 = 1'b0;
    end else begin
      if(when_FpUnit_l330_4) begin
        _zz_flagUF_86 = (|_zz_when_FpUnit_l84_151);
      end else begin
        _zz_flagUF_86 = (|(_zz__zz_flagUF_86 & _zz__zz_flagUF_86_1));
      end
    end
  end

  assign when_FpUnit_l330_4 = (12'h036 <= _zz_when_FpUnit_l330_4);
  assign _zz_when_FpUnit_l329_16 = ($signed(_zz_when_FpUnit_l329_14) - $signed(_zz_when_FpUnit_l329_13));
  assign _zz_when_FpUnit_l330_5 = _zz_when_FpUnit_l329_16;
  assign when_FpUnit_l329_5 = ($signed(_zz_when_FpUnit_l329_16) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l329_5) begin
      _zz_when_FpUnit_l84_153 = _zz__zz_when_FpUnit_l84_153;
    end else begin
      if(when_FpUnit_l330_5) begin
        _zz_when_FpUnit_l84_153 = 54'h0;
      end else begin
        _zz_when_FpUnit_l84_153 = _zz__zz_when_FpUnit_l84_153_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l329_5) begin
      _zz_flagUF_87 = 1'b0;
    end else begin
      if(when_FpUnit_l330_5) begin
        _zz_flagUF_87 = (|_zz_when_FpUnit_l84_1);
      end else begin
        _zz_flagUF_87 = (|(_zz__zz_flagUF_87 & _zz__zz_flagUF_87_1));
      end
    end
  end

  assign when_FpUnit_l330_5 = (12'h036 <= _zz_when_FpUnit_l330_5);
  assign _zz_when_FpUnit_l84_154 = _zz__zz_when_FpUnit_l84_154;
  assign _zz_when_FpUnit_l84_155 = _zz__zz_when_FpUnit_l84_155;
  assign _zz_when_FpUnit_l84_156 = ($signed(_zz__zz_when_FpUnit_l84_156) + $signed(_zz__zz_when_FpUnit_l84_156_3));
  assign _zz_when_FpUnit_l84_157 = _zz_when_FpUnit_l84_156[55];
  assign _zz_when_FpUnit_l84_158 = (_zz_when_FpUnit_l84_157 ? _zz__zz_when_FpUnit_l84_158 : _zz_when_FpUnit_l84_156);
  always @(*) begin
    _zz_when_FpUnit_l91_7 = 6'h0;
    if(when_FpUnit_l84_275) begin
      _zz_when_FpUnit_l91_7 = 6'h0;
    end
    if(when_FpUnit_l84_276) begin
      _zz_when_FpUnit_l91_7 = 6'h01;
    end
    if(when_FpUnit_l84_277) begin
      _zz_when_FpUnit_l91_7 = 6'h02;
    end
    if(when_FpUnit_l84_278) begin
      _zz_when_FpUnit_l91_7 = 6'h03;
    end
    if(when_FpUnit_l84_279) begin
      _zz_when_FpUnit_l91_7 = 6'h04;
    end
    if(when_FpUnit_l84_280) begin
      _zz_when_FpUnit_l91_7 = 6'h05;
    end
    if(when_FpUnit_l84_281) begin
      _zz_when_FpUnit_l91_7 = 6'h06;
    end
    if(when_FpUnit_l84_282) begin
      _zz_when_FpUnit_l91_7 = 6'h07;
    end
    if(when_FpUnit_l84_283) begin
      _zz_when_FpUnit_l91_7 = 6'h08;
    end
    if(when_FpUnit_l84_284) begin
      _zz_when_FpUnit_l91_7 = 6'h09;
    end
    if(when_FpUnit_l84_285) begin
      _zz_when_FpUnit_l91_7 = 6'h0a;
    end
    if(when_FpUnit_l84_286) begin
      _zz_when_FpUnit_l91_7 = 6'h0b;
    end
    if(when_FpUnit_l84_287) begin
      _zz_when_FpUnit_l91_7 = 6'h0c;
    end
    if(when_FpUnit_l84_288) begin
      _zz_when_FpUnit_l91_7 = 6'h0d;
    end
    if(when_FpUnit_l84_289) begin
      _zz_when_FpUnit_l91_7 = 6'h0e;
    end
    if(when_FpUnit_l84_290) begin
      _zz_when_FpUnit_l91_7 = 6'h0f;
    end
    if(when_FpUnit_l84_291) begin
      _zz_when_FpUnit_l91_7 = 6'h10;
    end
    if(when_FpUnit_l84_292) begin
      _zz_when_FpUnit_l91_7 = 6'h11;
    end
    if(when_FpUnit_l84_293) begin
      _zz_when_FpUnit_l91_7 = 6'h12;
    end
    if(when_FpUnit_l84_294) begin
      _zz_when_FpUnit_l91_7 = 6'h13;
    end
    if(when_FpUnit_l84_295) begin
      _zz_when_FpUnit_l91_7 = 6'h14;
    end
    if(when_FpUnit_l84_296) begin
      _zz_when_FpUnit_l91_7 = 6'h15;
    end
    if(when_FpUnit_l84_297) begin
      _zz_when_FpUnit_l91_7 = 6'h16;
    end
    if(when_FpUnit_l84_298) begin
      _zz_when_FpUnit_l91_7 = 6'h17;
    end
    if(when_FpUnit_l84_299) begin
      _zz_when_FpUnit_l91_7 = 6'h18;
    end
    if(when_FpUnit_l84_300) begin
      _zz_when_FpUnit_l91_7 = 6'h19;
    end
    if(when_FpUnit_l84_301) begin
      _zz_when_FpUnit_l91_7 = 6'h1a;
    end
    if(when_FpUnit_l84_302) begin
      _zz_when_FpUnit_l91_7 = 6'h1b;
    end
    if(when_FpUnit_l84_303) begin
      _zz_when_FpUnit_l91_7 = 6'h1c;
    end
    if(when_FpUnit_l84_304) begin
      _zz_when_FpUnit_l91_7 = 6'h1d;
    end
    if(when_FpUnit_l84_305) begin
      _zz_when_FpUnit_l91_7 = 6'h1e;
    end
    if(when_FpUnit_l84_306) begin
      _zz_when_FpUnit_l91_7 = 6'h1f;
    end
    if(when_FpUnit_l84_307) begin
      _zz_when_FpUnit_l91_7 = 6'h20;
    end
    if(when_FpUnit_l84_308) begin
      _zz_when_FpUnit_l91_7 = 6'h21;
    end
    if(when_FpUnit_l84_309) begin
      _zz_when_FpUnit_l91_7 = 6'h22;
    end
    if(when_FpUnit_l84_310) begin
      _zz_when_FpUnit_l91_7 = 6'h23;
    end
    if(when_FpUnit_l84_311) begin
      _zz_when_FpUnit_l91_7 = 6'h24;
    end
    if(when_FpUnit_l84_312) begin
      _zz_when_FpUnit_l91_7 = 6'h25;
    end
    if(when_FpUnit_l84_313) begin
      _zz_when_FpUnit_l91_7 = 6'h26;
    end
    if(when_FpUnit_l84_314) begin
      _zz_when_FpUnit_l91_7 = 6'h27;
    end
    if(when_FpUnit_l84_315) begin
      _zz_when_FpUnit_l91_7 = 6'h28;
    end
    if(when_FpUnit_l84_316) begin
      _zz_when_FpUnit_l91_7 = 6'h29;
    end
    if(when_FpUnit_l84_317) begin
      _zz_when_FpUnit_l91_7 = 6'h2a;
    end
    if(when_FpUnit_l84_318) begin
      _zz_when_FpUnit_l91_7 = 6'h2b;
    end
    if(when_FpUnit_l84_319) begin
      _zz_when_FpUnit_l91_7 = 6'h2c;
    end
    if(when_FpUnit_l84_320) begin
      _zz_when_FpUnit_l91_7 = 6'h2d;
    end
    if(when_FpUnit_l84_321) begin
      _zz_when_FpUnit_l91_7 = 6'h2e;
    end
    if(when_FpUnit_l84_322) begin
      _zz_when_FpUnit_l91_7 = 6'h2f;
    end
    if(when_FpUnit_l84_323) begin
      _zz_when_FpUnit_l91_7 = 6'h30;
    end
    if(when_FpUnit_l84_324) begin
      _zz_when_FpUnit_l91_7 = 6'h31;
    end
    if(when_FpUnit_l84_325) begin
      _zz_when_FpUnit_l91_7 = 6'h32;
    end
    if(when_FpUnit_l84_326) begin
      _zz_when_FpUnit_l91_7 = 6'h33;
    end
    if(when_FpUnit_l84_327) begin
      _zz_when_FpUnit_l91_7 = 6'h34;
    end
    if(when_FpUnit_l84_328) begin
      _zz_when_FpUnit_l91_7 = 6'h35;
    end
    if(when_FpUnit_l84_329) begin
      _zz_when_FpUnit_l91_7 = 6'h36;
    end
    if(when_FpUnit_l84_330) begin
      _zz_when_FpUnit_l91_7 = 6'h37;
    end
  end

  assign when_FpUnit_l84_275 = _zz_when_FpUnit_l84_158[0];
  assign when_FpUnit_l84_276 = _zz_when_FpUnit_l84_158[1];
  assign when_FpUnit_l84_277 = _zz_when_FpUnit_l84_158[2];
  assign when_FpUnit_l84_278 = _zz_when_FpUnit_l84_158[3];
  assign when_FpUnit_l84_279 = _zz_when_FpUnit_l84_158[4];
  assign when_FpUnit_l84_280 = _zz_when_FpUnit_l84_158[5];
  assign when_FpUnit_l84_281 = _zz_when_FpUnit_l84_158[6];
  assign when_FpUnit_l84_282 = _zz_when_FpUnit_l84_158[7];
  assign when_FpUnit_l84_283 = _zz_when_FpUnit_l84_158[8];
  assign when_FpUnit_l84_284 = _zz_when_FpUnit_l84_158[9];
  assign when_FpUnit_l84_285 = _zz_when_FpUnit_l84_158[10];
  assign when_FpUnit_l84_286 = _zz_when_FpUnit_l84_158[11];
  assign when_FpUnit_l84_287 = _zz_when_FpUnit_l84_158[12];
  assign when_FpUnit_l84_288 = _zz_when_FpUnit_l84_158[13];
  assign when_FpUnit_l84_289 = _zz_when_FpUnit_l84_158[14];
  assign when_FpUnit_l84_290 = _zz_when_FpUnit_l84_158[15];
  assign when_FpUnit_l84_291 = _zz_when_FpUnit_l84_158[16];
  assign when_FpUnit_l84_292 = _zz_when_FpUnit_l84_158[17];
  assign when_FpUnit_l84_293 = _zz_when_FpUnit_l84_158[18];
  assign when_FpUnit_l84_294 = _zz_when_FpUnit_l84_158[19];
  assign when_FpUnit_l84_295 = _zz_when_FpUnit_l84_158[20];
  assign when_FpUnit_l84_296 = _zz_when_FpUnit_l84_158[21];
  assign when_FpUnit_l84_297 = _zz_when_FpUnit_l84_158[22];
  assign when_FpUnit_l84_298 = _zz_when_FpUnit_l84_158[23];
  assign when_FpUnit_l84_299 = _zz_when_FpUnit_l84_158[24];
  assign when_FpUnit_l84_300 = _zz_when_FpUnit_l84_158[25];
  assign when_FpUnit_l84_301 = _zz_when_FpUnit_l84_158[26];
  assign when_FpUnit_l84_302 = _zz_when_FpUnit_l84_158[27];
  assign when_FpUnit_l84_303 = _zz_when_FpUnit_l84_158[28];
  assign when_FpUnit_l84_304 = _zz_when_FpUnit_l84_158[29];
  assign when_FpUnit_l84_305 = _zz_when_FpUnit_l84_158[30];
  assign when_FpUnit_l84_306 = _zz_when_FpUnit_l84_158[31];
  assign when_FpUnit_l84_307 = _zz_when_FpUnit_l84_158[32];
  assign when_FpUnit_l84_308 = _zz_when_FpUnit_l84_158[33];
  assign when_FpUnit_l84_309 = _zz_when_FpUnit_l84_158[34];
  assign when_FpUnit_l84_310 = _zz_when_FpUnit_l84_158[35];
  assign when_FpUnit_l84_311 = _zz_when_FpUnit_l84_158[36];
  assign when_FpUnit_l84_312 = _zz_when_FpUnit_l84_158[37];
  assign when_FpUnit_l84_313 = _zz_when_FpUnit_l84_158[38];
  assign when_FpUnit_l84_314 = _zz_when_FpUnit_l84_158[39];
  assign when_FpUnit_l84_315 = _zz_when_FpUnit_l84_158[40];
  assign when_FpUnit_l84_316 = _zz_when_FpUnit_l84_158[41];
  assign when_FpUnit_l84_317 = _zz_when_FpUnit_l84_158[42];
  assign when_FpUnit_l84_318 = _zz_when_FpUnit_l84_158[43];
  assign when_FpUnit_l84_319 = _zz_when_FpUnit_l84_158[44];
  assign when_FpUnit_l84_320 = _zz_when_FpUnit_l84_158[45];
  assign when_FpUnit_l84_321 = _zz_when_FpUnit_l84_158[46];
  assign when_FpUnit_l84_322 = _zz_when_FpUnit_l84_158[47];
  assign when_FpUnit_l84_323 = _zz_when_FpUnit_l84_158[48];
  assign when_FpUnit_l84_324 = _zz_when_FpUnit_l84_158[49];
  assign when_FpUnit_l84_325 = _zz_when_FpUnit_l84_158[50];
  assign when_FpUnit_l84_326 = _zz_when_FpUnit_l84_158[51];
  assign when_FpUnit_l84_327 = _zz_when_FpUnit_l84_158[52];
  assign when_FpUnit_l84_328 = _zz_when_FpUnit_l84_158[53];
  assign when_FpUnit_l84_329 = _zz_when_FpUnit_l84_158[54];
  assign when_FpUnit_l84_330 = _zz_when_FpUnit_l84_158[55];
  always @(*) begin
    _zz_flagUF_88 = 27'h0;
    if(when_FpUnit_l90_7) begin
      if(when_FpUnit_l91_7) begin
        _zz_flagUF_88 = _zz__zz_flagUF_88;
      end else begin
        _zz_flagUF_88 = _zz__zz_flagUF_88_2;
      end
    end
  end

  always @(*) begin
    _zz_flagUF_89 = 1'b0;
    if(when_FpUnit_l90_7) begin
      if(when_FpUnit_l91_7) begin
        _zz_flagUF_89 = (|(_zz_when_FpUnit_l84_158 & _zz__zz_flagUF_89));
      end else begin
        _zz_flagUF_89 = 1'b0;
      end
    end
  end

  assign _zz_flagUF_90 = ($signed(_zz__zz_flagUF_90) + $signed(_zz_when_FpUnit_l329_14));
  assign when_FpUnit_l90_7 = (_zz_when_FpUnit_l84_158 != 56'h0);
  assign when_FpUnit_l91_7 = (6'h1a < _zz_when_FpUnit_l91_7);
  assign _zz_flagUF_91 = (_zz_when_FpUnit_l91_7 - 6'h1a);
  assign _zz_flagUF_92 = ((_zz_flagUF_89 || _zz_flagUF_86) || _zz_flagUF_87);
  assign _zz_flagUF_93 = ($signed(_zz__zz_flagUF_93) < $signed(12'h001));
  assign _zz_when_FpUnit_l116_7 = (_zz_flagUF_93 ? _zz__zz_when_FpUnit_l116_7 : 12'h0);
  assign _zz_when_FpUnit_l119_7 = _zz_when_FpUnit_l116_7;
  assign when_FpUnit_l116_7 = ($signed(_zz_when_FpUnit_l116_7) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l116_7) begin
      _zz_flagUF_94 = _zz_flagUF_88;
    end else begin
      if(when_FpUnit_l119_7) begin
        _zz_flagUF_94 = 27'h0;
      end else begin
        _zz_flagUF_94 = _zz__zz_flagUF_94;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l116_7) begin
      _zz_flagUF_95 = _zz_flagUF_92;
    end else begin
      if(when_FpUnit_l119_7) begin
        _zz_flagUF_95 = ((|_zz_flagUF_88) || _zz_flagUF_92);
      end else begin
        _zz_flagUF_95 = ((|(_zz_flagUF_88 & _zz__zz_flagUF_95)) || _zz_flagUF_92);
      end
    end
  end

  assign when_FpUnit_l119_7 = (12'h01b <= _zz_when_FpUnit_l119_7);
  assign _zz_when_FpUnit_l150_35 = (_zz_flagUF_93 ? 12'hf82 : _zz_flagUF_90);
  assign _zz_flagUF_96 = _zz_flagUF_94[2];
  assign _zz_flagUF_97 = _zz_flagUF_94[1];
  assign _zz_flagUF_98 = (_zz_flagUF_94[0] || _zz_flagUF_95);
  assign _zz_when_FpUnit_l150_36 = _zz_flagUF_94[26 : 3];
  assign _zz_when_FpUnit_l150_37 = (_zz__zz_when_FpUnit_l150_37 + _zz__zz_when_FpUnit_l150_37_2);
  assign _zz_when_FpUnit_l150_38 = _zz_when_FpUnit_l150_37[24];
  assign _zz_res_52 = (_zz_when_FpUnit_l150_38 ? _zz__zz_res_52 : _zz__zz_res_52_1);
  assign _zz_when_FpUnit_l150_39 = ($signed(_zz__zz_when_FpUnit_l150_39) + $signed(12'h07f));
  assign _zz_flagUF_99 = ((_zz_flagUF_96 || _zz_flagUF_97) || _zz_flagUF_98);
  assign when_FpUnit_l150_7 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l150_39));
  assign _zz_res_53 = {_zz_when_FpUnit_l84_157,{8'hff,23'h0}};
  assign _zz_res_54 = {_zz_when_FpUnit_l84_157,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_55 = 32'h0;
    if(when_FpUnit_l150_7) begin
      _zz_res_55 = ((io_rm == 3'b001) ? _zz_res_54 : ((io_rm == 3'b010) ? (_zz_when_FpUnit_l84_157 ? _zz_res_53 : _zz_res_54) : ((io_rm == 3'b011) ? (_zz_when_FpUnit_l84_157 ? _zz_res_54 : _zz_res_53) : _zz_res_53)));
    end else begin
      if(when_FpUnit_l154_7) begin
        _zz_res_55 = {_zz_when_FpUnit_l84_157,{8'h0,_zz_res_52[22 : 0]}};
      end else begin
        _zz_res_55 = {_zz_when_FpUnit_l84_157,{_zz__zz_res_55,_zz_res_52[22 : 0]}};
      end
    end
  end

  assign when_FpUnit_l154_7 = ($signed(_zz_when_FpUnit_l150_39) < $signed(12'h001));
  always @(*) begin
    _zz_res_56 = _zz_res_55;
    if(when_FpUnit_l357_2) begin
      _zz_res_56 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l358_2) begin
        _zz_res_56 = 32'h7fc00000;
      end else begin
        if(when_FpUnit_l359_2) begin
          _zz_res_56 = 32'h7fc00000;
        end else begin
          if(when_FpUnit_l360_2) begin
            _zz_res_56 = {_zz_when_FpUnit_l359_5,{8'hff,23'h0}};
          end else begin
            if(when_FpUnit_l361) begin
              _zz_res_56 = {_zz_when_FpUnit_l359_6,{8'hff,23'h0}};
            end
          end
        end
      end
    end
  end

  assign when_FpUnit_l357_2 = ((when_FpUnit_l304 || when_FpUnit_l393) || _zz_when_FpUnit_l357);
  assign when_FpUnit_l358_2 = ((when_FpUnit_l206 && when_FpUnit_l267) || (when_FpUnit_l270 && when_FpUnit_l207));
  assign when_FpUnit_l359_2 = (((when_FpUnit_l206 || when_FpUnit_l207) && when_FpUnit_l361) && (_zz_when_FpUnit_l359_5 != _zz_when_FpUnit_l359_6));
  assign when_FpUnit_l360_2 = (when_FpUnit_l206 || when_FpUnit_l207);
  assign _zz_when_FpUnit_l359_7 = ((when_FpUnit_l481 ^ _zz_when_FpUnit_l205) ^ 1'b1);
  assign _zz_when_FpUnit_l359_8 = (_zz_when_FpUnit_l359 ^ 1'b1);
  assign _zz_when_FpUnit_l84_159 = (_zz_flagNX * _zz_when_FpUnit_l84);
  assign _zz_when_FpUnit_l329_17 = ($signed(_zz__zz_when_FpUnit_l329_17) - $signed(12'h02e));
  assign _zz_when_FpUnit_l329_18 = ($signed(_zz__zz_when_FpUnit_l329_18) - $signed(12'h017));
  assign _zz_when_FpUnit_l329_19 = (($signed(_zz_when_FpUnit_l329_18) <= $signed(_zz_when_FpUnit_l329_17)) ? _zz_when_FpUnit_l329_17 : _zz_when_FpUnit_l329_18);
  assign _zz_when_FpUnit_l329_20 = ($signed(_zz_when_FpUnit_l329_19) - $signed(_zz_when_FpUnit_l329_17));
  assign _zz_when_FpUnit_l330_6 = _zz_when_FpUnit_l329_20;
  assign when_FpUnit_l329_6 = ($signed(_zz_when_FpUnit_l329_20) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l329_6) begin
      _zz_when_FpUnit_l84_160 = _zz__zz_when_FpUnit_l84_160;
    end else begin
      if(when_FpUnit_l330_6) begin
        _zz_when_FpUnit_l84_160 = 54'h0;
      end else begin
        _zz_when_FpUnit_l84_160 = _zz__zz_when_FpUnit_l84_160_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l329_6) begin
      _zz_flagUF_100 = 1'b0;
    end else begin
      if(when_FpUnit_l330_6) begin
        _zz_flagUF_100 = (|_zz_when_FpUnit_l84_159);
      end else begin
        _zz_flagUF_100 = (|(_zz__zz_flagUF_100 & _zz__zz_flagUF_100_1));
      end
    end
  end

  assign when_FpUnit_l330_6 = (12'h036 <= _zz_when_FpUnit_l330_6);
  assign _zz_when_FpUnit_l329_21 = ($signed(_zz_when_FpUnit_l329_19) - $signed(_zz_when_FpUnit_l329_18));
  assign _zz_when_FpUnit_l330_7 = _zz_when_FpUnit_l329_21;
  assign when_FpUnit_l329_7 = ($signed(_zz_when_FpUnit_l329_21) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l329_7) begin
      _zz_when_FpUnit_l84_161 = _zz__zz_when_FpUnit_l84_161;
    end else begin
      if(when_FpUnit_l330_7) begin
        _zz_when_FpUnit_l84_161 = 54'h0;
      end else begin
        _zz_when_FpUnit_l84_161 = _zz__zz_when_FpUnit_l84_161_1;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l329_7) begin
      _zz_flagUF_101 = 1'b0;
    end else begin
      if(when_FpUnit_l330_7) begin
        _zz_flagUF_101 = (|_zz_when_FpUnit_l84_1);
      end else begin
        _zz_flagUF_101 = (|(_zz__zz_flagUF_101 & _zz__zz_flagUF_101_1));
      end
    end
  end

  assign when_FpUnit_l330_7 = (12'h036 <= _zz_when_FpUnit_l330_7);
  assign _zz_when_FpUnit_l84_162 = _zz__zz_when_FpUnit_l84_162;
  assign _zz_when_FpUnit_l84_163 = _zz__zz_when_FpUnit_l84_163;
  assign _zz_when_FpUnit_l84_164 = ($signed(_zz__zz_when_FpUnit_l84_164) + $signed(_zz__zz_when_FpUnit_l84_164_3));
  assign _zz_when_FpUnit_l84_165 = _zz_when_FpUnit_l84_164[55];
  assign _zz_when_FpUnit_l84_166 = (_zz_when_FpUnit_l84_165 ? _zz__zz_when_FpUnit_l84_166 : _zz_when_FpUnit_l84_164);
  always @(*) begin
    _zz_when_FpUnit_l91_8 = 6'h0;
    if(when_FpUnit_l84_331) begin
      _zz_when_FpUnit_l91_8 = 6'h0;
    end
    if(when_FpUnit_l84_332) begin
      _zz_when_FpUnit_l91_8 = 6'h01;
    end
    if(when_FpUnit_l84_333) begin
      _zz_when_FpUnit_l91_8 = 6'h02;
    end
    if(when_FpUnit_l84_334) begin
      _zz_when_FpUnit_l91_8 = 6'h03;
    end
    if(when_FpUnit_l84_335) begin
      _zz_when_FpUnit_l91_8 = 6'h04;
    end
    if(when_FpUnit_l84_336) begin
      _zz_when_FpUnit_l91_8 = 6'h05;
    end
    if(when_FpUnit_l84_337) begin
      _zz_when_FpUnit_l91_8 = 6'h06;
    end
    if(when_FpUnit_l84_338) begin
      _zz_when_FpUnit_l91_8 = 6'h07;
    end
    if(when_FpUnit_l84_339) begin
      _zz_when_FpUnit_l91_8 = 6'h08;
    end
    if(when_FpUnit_l84_340) begin
      _zz_when_FpUnit_l91_8 = 6'h09;
    end
    if(when_FpUnit_l84_341) begin
      _zz_when_FpUnit_l91_8 = 6'h0a;
    end
    if(when_FpUnit_l84_342) begin
      _zz_when_FpUnit_l91_8 = 6'h0b;
    end
    if(when_FpUnit_l84_343) begin
      _zz_when_FpUnit_l91_8 = 6'h0c;
    end
    if(when_FpUnit_l84_344) begin
      _zz_when_FpUnit_l91_8 = 6'h0d;
    end
    if(when_FpUnit_l84_345) begin
      _zz_when_FpUnit_l91_8 = 6'h0e;
    end
    if(when_FpUnit_l84_346) begin
      _zz_when_FpUnit_l91_8 = 6'h0f;
    end
    if(when_FpUnit_l84_347) begin
      _zz_when_FpUnit_l91_8 = 6'h10;
    end
    if(when_FpUnit_l84_348) begin
      _zz_when_FpUnit_l91_8 = 6'h11;
    end
    if(when_FpUnit_l84_349) begin
      _zz_when_FpUnit_l91_8 = 6'h12;
    end
    if(when_FpUnit_l84_350) begin
      _zz_when_FpUnit_l91_8 = 6'h13;
    end
    if(when_FpUnit_l84_351) begin
      _zz_when_FpUnit_l91_8 = 6'h14;
    end
    if(when_FpUnit_l84_352) begin
      _zz_when_FpUnit_l91_8 = 6'h15;
    end
    if(when_FpUnit_l84_353) begin
      _zz_when_FpUnit_l91_8 = 6'h16;
    end
    if(when_FpUnit_l84_354) begin
      _zz_when_FpUnit_l91_8 = 6'h17;
    end
    if(when_FpUnit_l84_355) begin
      _zz_when_FpUnit_l91_8 = 6'h18;
    end
    if(when_FpUnit_l84_356) begin
      _zz_when_FpUnit_l91_8 = 6'h19;
    end
    if(when_FpUnit_l84_357) begin
      _zz_when_FpUnit_l91_8 = 6'h1a;
    end
    if(when_FpUnit_l84_358) begin
      _zz_when_FpUnit_l91_8 = 6'h1b;
    end
    if(when_FpUnit_l84_359) begin
      _zz_when_FpUnit_l91_8 = 6'h1c;
    end
    if(when_FpUnit_l84_360) begin
      _zz_when_FpUnit_l91_8 = 6'h1d;
    end
    if(when_FpUnit_l84_361) begin
      _zz_when_FpUnit_l91_8 = 6'h1e;
    end
    if(when_FpUnit_l84_362) begin
      _zz_when_FpUnit_l91_8 = 6'h1f;
    end
    if(when_FpUnit_l84_363) begin
      _zz_when_FpUnit_l91_8 = 6'h20;
    end
    if(when_FpUnit_l84_364) begin
      _zz_when_FpUnit_l91_8 = 6'h21;
    end
    if(when_FpUnit_l84_365) begin
      _zz_when_FpUnit_l91_8 = 6'h22;
    end
    if(when_FpUnit_l84_366) begin
      _zz_when_FpUnit_l91_8 = 6'h23;
    end
    if(when_FpUnit_l84_367) begin
      _zz_when_FpUnit_l91_8 = 6'h24;
    end
    if(when_FpUnit_l84_368) begin
      _zz_when_FpUnit_l91_8 = 6'h25;
    end
    if(when_FpUnit_l84_369) begin
      _zz_when_FpUnit_l91_8 = 6'h26;
    end
    if(when_FpUnit_l84_370) begin
      _zz_when_FpUnit_l91_8 = 6'h27;
    end
    if(when_FpUnit_l84_371) begin
      _zz_when_FpUnit_l91_8 = 6'h28;
    end
    if(when_FpUnit_l84_372) begin
      _zz_when_FpUnit_l91_8 = 6'h29;
    end
    if(when_FpUnit_l84_373) begin
      _zz_when_FpUnit_l91_8 = 6'h2a;
    end
    if(when_FpUnit_l84_374) begin
      _zz_when_FpUnit_l91_8 = 6'h2b;
    end
    if(when_FpUnit_l84_375) begin
      _zz_when_FpUnit_l91_8 = 6'h2c;
    end
    if(when_FpUnit_l84_376) begin
      _zz_when_FpUnit_l91_8 = 6'h2d;
    end
    if(when_FpUnit_l84_377) begin
      _zz_when_FpUnit_l91_8 = 6'h2e;
    end
    if(when_FpUnit_l84_378) begin
      _zz_when_FpUnit_l91_8 = 6'h2f;
    end
    if(when_FpUnit_l84_379) begin
      _zz_when_FpUnit_l91_8 = 6'h30;
    end
    if(when_FpUnit_l84_380) begin
      _zz_when_FpUnit_l91_8 = 6'h31;
    end
    if(when_FpUnit_l84_381) begin
      _zz_when_FpUnit_l91_8 = 6'h32;
    end
    if(when_FpUnit_l84_382) begin
      _zz_when_FpUnit_l91_8 = 6'h33;
    end
    if(when_FpUnit_l84_383) begin
      _zz_when_FpUnit_l91_8 = 6'h34;
    end
    if(when_FpUnit_l84_384) begin
      _zz_when_FpUnit_l91_8 = 6'h35;
    end
    if(when_FpUnit_l84_385) begin
      _zz_when_FpUnit_l91_8 = 6'h36;
    end
    if(when_FpUnit_l84_386) begin
      _zz_when_FpUnit_l91_8 = 6'h37;
    end
  end

  assign when_FpUnit_l84_331 = _zz_when_FpUnit_l84_166[0];
  assign when_FpUnit_l84_332 = _zz_when_FpUnit_l84_166[1];
  assign when_FpUnit_l84_333 = _zz_when_FpUnit_l84_166[2];
  assign when_FpUnit_l84_334 = _zz_when_FpUnit_l84_166[3];
  assign when_FpUnit_l84_335 = _zz_when_FpUnit_l84_166[4];
  assign when_FpUnit_l84_336 = _zz_when_FpUnit_l84_166[5];
  assign when_FpUnit_l84_337 = _zz_when_FpUnit_l84_166[6];
  assign when_FpUnit_l84_338 = _zz_when_FpUnit_l84_166[7];
  assign when_FpUnit_l84_339 = _zz_when_FpUnit_l84_166[8];
  assign when_FpUnit_l84_340 = _zz_when_FpUnit_l84_166[9];
  assign when_FpUnit_l84_341 = _zz_when_FpUnit_l84_166[10];
  assign when_FpUnit_l84_342 = _zz_when_FpUnit_l84_166[11];
  assign when_FpUnit_l84_343 = _zz_when_FpUnit_l84_166[12];
  assign when_FpUnit_l84_344 = _zz_when_FpUnit_l84_166[13];
  assign when_FpUnit_l84_345 = _zz_when_FpUnit_l84_166[14];
  assign when_FpUnit_l84_346 = _zz_when_FpUnit_l84_166[15];
  assign when_FpUnit_l84_347 = _zz_when_FpUnit_l84_166[16];
  assign when_FpUnit_l84_348 = _zz_when_FpUnit_l84_166[17];
  assign when_FpUnit_l84_349 = _zz_when_FpUnit_l84_166[18];
  assign when_FpUnit_l84_350 = _zz_when_FpUnit_l84_166[19];
  assign when_FpUnit_l84_351 = _zz_when_FpUnit_l84_166[20];
  assign when_FpUnit_l84_352 = _zz_when_FpUnit_l84_166[21];
  assign when_FpUnit_l84_353 = _zz_when_FpUnit_l84_166[22];
  assign when_FpUnit_l84_354 = _zz_when_FpUnit_l84_166[23];
  assign when_FpUnit_l84_355 = _zz_when_FpUnit_l84_166[24];
  assign when_FpUnit_l84_356 = _zz_when_FpUnit_l84_166[25];
  assign when_FpUnit_l84_357 = _zz_when_FpUnit_l84_166[26];
  assign when_FpUnit_l84_358 = _zz_when_FpUnit_l84_166[27];
  assign when_FpUnit_l84_359 = _zz_when_FpUnit_l84_166[28];
  assign when_FpUnit_l84_360 = _zz_when_FpUnit_l84_166[29];
  assign when_FpUnit_l84_361 = _zz_when_FpUnit_l84_166[30];
  assign when_FpUnit_l84_362 = _zz_when_FpUnit_l84_166[31];
  assign when_FpUnit_l84_363 = _zz_when_FpUnit_l84_166[32];
  assign when_FpUnit_l84_364 = _zz_when_FpUnit_l84_166[33];
  assign when_FpUnit_l84_365 = _zz_when_FpUnit_l84_166[34];
  assign when_FpUnit_l84_366 = _zz_when_FpUnit_l84_166[35];
  assign when_FpUnit_l84_367 = _zz_when_FpUnit_l84_166[36];
  assign when_FpUnit_l84_368 = _zz_when_FpUnit_l84_166[37];
  assign when_FpUnit_l84_369 = _zz_when_FpUnit_l84_166[38];
  assign when_FpUnit_l84_370 = _zz_when_FpUnit_l84_166[39];
  assign when_FpUnit_l84_371 = _zz_when_FpUnit_l84_166[40];
  assign when_FpUnit_l84_372 = _zz_when_FpUnit_l84_166[41];
  assign when_FpUnit_l84_373 = _zz_when_FpUnit_l84_166[42];
  assign when_FpUnit_l84_374 = _zz_when_FpUnit_l84_166[43];
  assign when_FpUnit_l84_375 = _zz_when_FpUnit_l84_166[44];
  assign when_FpUnit_l84_376 = _zz_when_FpUnit_l84_166[45];
  assign when_FpUnit_l84_377 = _zz_when_FpUnit_l84_166[46];
  assign when_FpUnit_l84_378 = _zz_when_FpUnit_l84_166[47];
  assign when_FpUnit_l84_379 = _zz_when_FpUnit_l84_166[48];
  assign when_FpUnit_l84_380 = _zz_when_FpUnit_l84_166[49];
  assign when_FpUnit_l84_381 = _zz_when_FpUnit_l84_166[50];
  assign when_FpUnit_l84_382 = _zz_when_FpUnit_l84_166[51];
  assign when_FpUnit_l84_383 = _zz_when_FpUnit_l84_166[52];
  assign when_FpUnit_l84_384 = _zz_when_FpUnit_l84_166[53];
  assign when_FpUnit_l84_385 = _zz_when_FpUnit_l84_166[54];
  assign when_FpUnit_l84_386 = _zz_when_FpUnit_l84_166[55];
  always @(*) begin
    _zz_flagUF_102 = 27'h0;
    if(when_FpUnit_l90_8) begin
      if(when_FpUnit_l91_8) begin
        _zz_flagUF_102 = _zz__zz_flagUF_102;
      end else begin
        _zz_flagUF_102 = _zz__zz_flagUF_102_2;
      end
    end
  end

  always @(*) begin
    _zz_flagUF_103 = 1'b0;
    if(when_FpUnit_l90_8) begin
      if(when_FpUnit_l91_8) begin
        _zz_flagUF_103 = (|(_zz_when_FpUnit_l84_166 & _zz__zz_flagUF_103));
      end else begin
        _zz_flagUF_103 = 1'b0;
      end
    end
  end

  assign _zz_flagUF_104 = ($signed(_zz__zz_flagUF_104) + $signed(_zz_when_FpUnit_l329_19));
  assign when_FpUnit_l90_8 = (_zz_when_FpUnit_l84_166 != 56'h0);
  assign when_FpUnit_l91_8 = (6'h1a < _zz_when_FpUnit_l91_8);
  assign _zz_flagUF_105 = (_zz_when_FpUnit_l91_8 - 6'h1a);
  assign _zz_flagUF_106 = ((_zz_flagUF_103 || _zz_flagUF_100) || _zz_flagUF_101);
  assign _zz_flagUF_107 = ($signed(_zz__zz_flagUF_107) < $signed(12'h001));
  assign _zz_when_FpUnit_l116_8 = (_zz_flagUF_107 ? _zz__zz_when_FpUnit_l116_8 : 12'h0);
  assign _zz_when_FpUnit_l119_8 = _zz_when_FpUnit_l116_8;
  assign when_FpUnit_l116_8 = ($signed(_zz_when_FpUnit_l116_8) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l116_8) begin
      _zz_flagUF_108 = _zz_flagUF_102;
    end else begin
      if(when_FpUnit_l119_8) begin
        _zz_flagUF_108 = 27'h0;
      end else begin
        _zz_flagUF_108 = _zz__zz_flagUF_108;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l116_8) begin
      _zz_flagUF_109 = _zz_flagUF_106;
    end else begin
      if(when_FpUnit_l119_8) begin
        _zz_flagUF_109 = ((|_zz_flagUF_102) || _zz_flagUF_106);
      end else begin
        _zz_flagUF_109 = ((|(_zz_flagUF_102 & _zz__zz_flagUF_109)) || _zz_flagUF_106);
      end
    end
  end

  assign when_FpUnit_l119_8 = (12'h01b <= _zz_when_FpUnit_l119_8);
  assign _zz_when_FpUnit_l150_40 = (_zz_flagUF_107 ? 12'hf82 : _zz_flagUF_104);
  assign _zz_flagUF_110 = _zz_flagUF_108[2];
  assign _zz_flagUF_111 = _zz_flagUF_108[1];
  assign _zz_flagUF_112 = (_zz_flagUF_108[0] || _zz_flagUF_109);
  assign _zz_when_FpUnit_l150_41 = _zz_flagUF_108[26 : 3];
  assign _zz_when_FpUnit_l150_42 = (_zz__zz_when_FpUnit_l150_42 + _zz__zz_when_FpUnit_l150_42_2);
  assign _zz_when_FpUnit_l150_43 = _zz_when_FpUnit_l150_42[24];
  assign _zz_res_57 = (_zz_when_FpUnit_l150_43 ? _zz__zz_res_57 : _zz__zz_res_57_1);
  assign _zz_when_FpUnit_l150_44 = ($signed(_zz__zz_when_FpUnit_l150_44) + $signed(12'h07f));
  assign _zz_flagUF_113 = ((_zz_flagUF_110 || _zz_flagUF_111) || _zz_flagUF_112);
  assign when_FpUnit_l150_8 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l150_44));
  assign _zz_res_58 = {_zz_when_FpUnit_l84_165,{8'hff,23'h0}};
  assign _zz_res_59 = {_zz_when_FpUnit_l84_165,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_60 = 32'h0;
    if(when_FpUnit_l150_8) begin
      _zz_res_60 = ((io_rm == 3'b001) ? _zz_res_59 : ((io_rm == 3'b010) ? (_zz_when_FpUnit_l84_165 ? _zz_res_58 : _zz_res_59) : ((io_rm == 3'b011) ? (_zz_when_FpUnit_l84_165 ? _zz_res_59 : _zz_res_58) : _zz_res_58)));
    end else begin
      if(when_FpUnit_l154_8) begin
        _zz_res_60 = {_zz_when_FpUnit_l84_165,{8'h0,_zz_res_57[22 : 0]}};
      end else begin
        _zz_res_60 = {_zz_when_FpUnit_l84_165,{_zz__zz_res_60,_zz_res_57[22 : 0]}};
      end
    end
  end

  assign when_FpUnit_l154_8 = ($signed(_zz_when_FpUnit_l150_44) < $signed(12'h001));
  always @(*) begin
    _zz_res_61 = _zz_res_60;
    if(when_FpUnit_l357_3) begin
      _zz_res_61 = 32'h7fc00000;
    end else begin
      if(when_FpUnit_l358_3) begin
        _zz_res_61 = 32'h7fc00000;
      end else begin
        if(when_FpUnit_l359_3) begin
          _zz_res_61 = 32'h7fc00000;
        end else begin
          if(when_FpUnit_l360_3) begin
            _zz_res_61 = {_zz_when_FpUnit_l359_7,{8'hff,23'h0}};
          end else begin
            if(when_FpUnit_l361) begin
              _zz_res_61 = {_zz_when_FpUnit_l359_8,{8'hff,23'h0}};
            end
          end
        end
      end
    end
  end

  assign when_FpUnit_l357_3 = ((when_FpUnit_l304 || when_FpUnit_l393) || _zz_when_FpUnit_l357);
  assign when_FpUnit_l358_3 = ((when_FpUnit_l206 && when_FpUnit_l267) || (when_FpUnit_l270 && when_FpUnit_l207));
  assign when_FpUnit_l359_3 = (((when_FpUnit_l206 || when_FpUnit_l207) && when_FpUnit_l361) && (_zz_when_FpUnit_l359_7 != _zz_when_FpUnit_l359_8));
  assign when_FpUnit_l360_3 = (when_FpUnit_l206 || when_FpUnit_l207);
  assign _zz_when_FpUnit_l447 = ($signed(_zz__zz_when_FpUnit_l447) - $signed(12'h017));
  assign when_FpUnit_l447 = ($signed(12'h022) <= $signed(_zz_when_FpUnit_l447));
  always @(*) begin
    if(when_FpUnit_l447) begin
      _zz_when_FpUnit_l474 = 34'h1ffffffff;
    end else begin
      if(when_FpUnit_l450) begin
        _zz_when_FpUnit_l474 = 34'h0;
      end else begin
        if(when_FpUnit_l453) begin
          _zz_when_FpUnit_l474 = {10'd0, _zz__zz_when_FpUnit_l474};
        end else begin
          _zz_when_FpUnit_l474 = _zz__zz_when_FpUnit_l474_1[33:0];
        end
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l447) begin
      _zz_flagNX_1 = 1'b1;
    end else begin
      if(when_FpUnit_l450) begin
        _zz_flagNX_1 = (_zz_flagNX != 24'h0);
      end else begin
        if(when_FpUnit_l453) begin
          _zz_flagNX_1 = ((_zz_flagNX & _zz__zz_flagNX_1) != 24'h0);
        end else begin
          _zz_flagNX_1 = 1'b0;
        end
      end
    end
  end

  assign _zz_flagNX_2 = _zz__zz_flagNX_2;
  assign when_FpUnit_l450 = ($signed(_zz_when_FpUnit_l447) <= $signed(12'hfe8));
  assign when_FpUnit_l453 = ($signed(_zz_when_FpUnit_l447) < $signed(12'h0));
  assign _zz_when_FpUnit_l474_1 = (_zz_when_FpUnit_l474 + _zz__zz_when_FpUnit_l474_1_1);
  assign when_FpUnit_l474 = (((when_FpUnit_l304 || when_FpUnit_l206) || (((! when_FpUnit_l304) && (! when_FpUnit_l206)) && (34'h080000000 < _zz_when_FpUnit_l474_1))) || 1'b0);
  always @(*) begin
    if(when_FpUnit_l474) begin
      _zz_res_62 = 32'h7fffffff;
      if(when_FpUnit_l479) begin
        _zz_res_62 = 32'h80000000;
      end
    end else begin
      if(when_FpUnit_l481) begin
        _zz_res_62 = (32'h0 - _zz__zz_res_62);
      end else begin
        _zz_res_62 = _zz_when_FpUnit_l474_1[31:0];
      end
    end
  end

  assign when_FpUnit_l479 = (when_FpUnit_l481 && (! when_FpUnit_l304));
  assign _zz_when_FpUnit_l447_1 = ($signed(_zz__zz_when_FpUnit_l447_1) - $signed(12'h017));
  assign when_FpUnit_l447_1 = ($signed(12'h022) <= $signed(_zz_when_FpUnit_l447_1));
  always @(*) begin
    if(when_FpUnit_l447_1) begin
      _zz_when_FpUnit_l474_2 = 34'h1ffffffff;
    end else begin
      if(when_FpUnit_l450_1) begin
        _zz_when_FpUnit_l474_2 = 34'h0;
      end else begin
        if(when_FpUnit_l453_1) begin
          _zz_when_FpUnit_l474_2 = {10'd0, _zz__zz_when_FpUnit_l474_2_1};
        end else begin
          _zz_when_FpUnit_l474_2 = _zz__zz_when_FpUnit_l474_2_2[33:0];
        end
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l447_1) begin
      _zz_flagNX_3 = 1'b1;
    end else begin
      if(when_FpUnit_l450_1) begin
        _zz_flagNX_3 = (_zz_flagNX != 24'h0);
      end else begin
        if(when_FpUnit_l453_1) begin
          _zz_flagNX_3 = ((_zz_flagNX & _zz__zz_flagNX_3) != 24'h0);
        end else begin
          _zz_flagNX_3 = 1'b0;
        end
      end
    end
  end

  assign _zz_flagNX_4 = _zz__zz_flagNX_4;
  assign when_FpUnit_l450_1 = ($signed(_zz_when_FpUnit_l447_1) <= $signed(12'hfe8));
  assign when_FpUnit_l453_1 = ($signed(_zz_when_FpUnit_l447_1) < $signed(12'h0));
  assign _zz_when_FpUnit_l474_3 = (_zz_when_FpUnit_l474_2 + _zz__zz_when_FpUnit_l474_3_1);
  assign when_FpUnit_l474_1 = (((when_FpUnit_l304 || when_FpUnit_l206) || (((! when_FpUnit_l304) && (! when_FpUnit_l206)) && (34'h0ffffffff < _zz_when_FpUnit_l474_3))) || ((when_FpUnit_l481 && (! when_FpUnit_l270)) && (! when_FpUnit_l304)));
  always @(*) begin
    if(when_FpUnit_l474_1) begin
      _zz_res_63 = 32'hffffffff;
      if(when_FpUnit_l479_1) begin
        _zz_res_63 = 32'h0;
      end
    end else begin
      if(when_FpUnit_l481) begin
        _zz_res_63 = (32'h0 - _zz__zz_res_63);
      end else begin
        _zz_res_63 = _zz_when_FpUnit_l474_3[31:0];
      end
    end
  end

  assign when_FpUnit_l479_1 = (when_FpUnit_l481 && (! when_FpUnit_l304));
  assign _zz_when_FpUnit_l447_2 = ($signed(_zz__zz_when_FpUnit_l447_2) - $signed(12'h017));
  assign when_FpUnit_l447_2 = ($signed(12'h042) <= $signed(_zz_when_FpUnit_l447_2));
  always @(*) begin
    if(when_FpUnit_l447_2) begin
      _zz_when_FpUnit_l474_4 = 66'h1ffffffffffffffff;
    end else begin
      if(when_FpUnit_l450_2) begin
        _zz_when_FpUnit_l474_4 = 66'h0;
      end else begin
        if(when_FpUnit_l453_2) begin
          _zz_when_FpUnit_l474_4 = {42'd0, _zz__zz_when_FpUnit_l474_4_1};
        end else begin
          _zz_when_FpUnit_l474_4 = _zz__zz_when_FpUnit_l474_4_2[65:0];
        end
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l447_2) begin
      _zz_flagNX_5 = 1'b1;
    end else begin
      if(when_FpUnit_l450_2) begin
        _zz_flagNX_5 = (_zz_flagNX != 24'h0);
      end else begin
        if(when_FpUnit_l453_2) begin
          _zz_flagNX_5 = ((_zz_flagNX & _zz__zz_flagNX_5) != 24'h0);
        end else begin
          _zz_flagNX_5 = 1'b0;
        end
      end
    end
  end

  assign _zz_flagNX_6 = _zz__zz_flagNX_6;
  assign when_FpUnit_l450_2 = ($signed(_zz_when_FpUnit_l447_2) <= $signed(12'hfe8));
  assign when_FpUnit_l453_2 = ($signed(_zz_when_FpUnit_l447_2) < $signed(12'h0));
  assign _zz_when_FpUnit_l474_5 = (_zz_when_FpUnit_l474_4 + _zz__zz_when_FpUnit_l474_5);
  assign when_FpUnit_l474_2 = (((when_FpUnit_l304 || when_FpUnit_l206) || (((! when_FpUnit_l304) && (! when_FpUnit_l206)) && (66'h08000000000000000 < _zz_when_FpUnit_l474_5))) || 1'b0);
  always @(*) begin
    if(when_FpUnit_l474_2) begin
      _zz_res_64 = 64'h7fffffffffffffff;
      if(when_FpUnit_l479_2) begin
        _zz_res_64 = 64'h8000000000000000;
      end
    end else begin
      if(when_FpUnit_l481) begin
        _zz_res_64 = (64'h0 - _zz__zz_res_64);
      end else begin
        _zz_res_64 = _zz_when_FpUnit_l474_5[63:0];
      end
    end
  end

  assign when_FpUnit_l479_2 = (when_FpUnit_l481 && (! when_FpUnit_l304));
  assign _zz_when_FpUnit_l447_3 = ($signed(_zz__zz_when_FpUnit_l447_3) - $signed(12'h017));
  assign when_FpUnit_l447_3 = ($signed(12'h042) <= $signed(_zz_when_FpUnit_l447_3));
  always @(*) begin
    if(when_FpUnit_l447_3) begin
      _zz_when_FpUnit_l474_6 = 66'h1ffffffffffffffff;
    end else begin
      if(when_FpUnit_l450_3) begin
        _zz_when_FpUnit_l474_6 = 66'h0;
      end else begin
        if(when_FpUnit_l453_3) begin
          _zz_when_FpUnit_l474_6 = {42'd0, _zz__zz_when_FpUnit_l474_6};
        end else begin
          _zz_when_FpUnit_l474_6 = _zz__zz_when_FpUnit_l474_6_1[65:0];
        end
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l447_3) begin
      _zz_flagNX_7 = 1'b1;
    end else begin
      if(when_FpUnit_l450_3) begin
        _zz_flagNX_7 = (_zz_flagNX != 24'h0);
      end else begin
        if(when_FpUnit_l453_3) begin
          _zz_flagNX_7 = ((_zz_flagNX & _zz__zz_flagNX_7) != 24'h0);
        end else begin
          _zz_flagNX_7 = 1'b0;
        end
      end
    end
  end

  assign _zz_flagNX_8 = _zz__zz_flagNX_8;
  assign when_FpUnit_l450_3 = ($signed(_zz_when_FpUnit_l447_3) <= $signed(12'hfe8));
  assign when_FpUnit_l453_3 = ($signed(_zz_when_FpUnit_l447_3) < $signed(12'h0));
  assign _zz_when_FpUnit_l474_7 = (_zz_when_FpUnit_l474_6 + _zz__zz_when_FpUnit_l474_7);
  assign when_FpUnit_l474_3 = (((when_FpUnit_l304 || when_FpUnit_l206) || (((! when_FpUnit_l304) && (! when_FpUnit_l206)) && (66'h0ffffffffffffffff < _zz_when_FpUnit_l474_7))) || ((when_FpUnit_l481 && (! when_FpUnit_l270)) && (! when_FpUnit_l304)));
  always @(*) begin
    if(when_FpUnit_l474_3) begin
      _zz_res_65 = 64'hffffffffffffffff;
      if(when_FpUnit_l479_3) begin
        _zz_res_65 = 64'h0;
      end
    end else begin
      if(when_FpUnit_l481) begin
        _zz_res_65 = (64'h0 - _zz__zz_res_65);
      end else begin
        _zz_res_65 = _zz_when_FpUnit_l474_7[63:0];
      end
    end
  end

  assign when_FpUnit_l479_3 = (when_FpUnit_l481 && (! when_FpUnit_l304));
  assign _zz_res_66 = io_a[31];
  assign _zz_when_FpUnit_l84_167 = io_a[31 : 0];
  assign _zz_when_FpUnit_l84_168 = (_zz_res_66 ? _zz__zz_when_FpUnit_l84_168 : _zz__zz_when_FpUnit_l84_168_2);
  always @(*) begin
    _zz_when_FpUnit_l91_9 = 6'h0;
    if(when_FpUnit_l84_387) begin
      _zz_when_FpUnit_l91_9 = 6'h0;
    end
    if(when_FpUnit_l84_388) begin
      _zz_when_FpUnit_l91_9 = 6'h01;
    end
    if(when_FpUnit_l84_389) begin
      _zz_when_FpUnit_l91_9 = 6'h02;
    end
    if(when_FpUnit_l84_390) begin
      _zz_when_FpUnit_l91_9 = 6'h03;
    end
    if(when_FpUnit_l84_391) begin
      _zz_when_FpUnit_l91_9 = 6'h04;
    end
    if(when_FpUnit_l84_392) begin
      _zz_when_FpUnit_l91_9 = 6'h05;
    end
    if(when_FpUnit_l84_393) begin
      _zz_when_FpUnit_l91_9 = 6'h06;
    end
    if(when_FpUnit_l84_394) begin
      _zz_when_FpUnit_l91_9 = 6'h07;
    end
    if(when_FpUnit_l84_395) begin
      _zz_when_FpUnit_l91_9 = 6'h08;
    end
    if(when_FpUnit_l84_396) begin
      _zz_when_FpUnit_l91_9 = 6'h09;
    end
    if(when_FpUnit_l84_397) begin
      _zz_when_FpUnit_l91_9 = 6'h0a;
    end
    if(when_FpUnit_l84_398) begin
      _zz_when_FpUnit_l91_9 = 6'h0b;
    end
    if(when_FpUnit_l84_399) begin
      _zz_when_FpUnit_l91_9 = 6'h0c;
    end
    if(when_FpUnit_l84_400) begin
      _zz_when_FpUnit_l91_9 = 6'h0d;
    end
    if(when_FpUnit_l84_401) begin
      _zz_when_FpUnit_l91_9 = 6'h0e;
    end
    if(when_FpUnit_l84_402) begin
      _zz_when_FpUnit_l91_9 = 6'h0f;
    end
    if(when_FpUnit_l84_403) begin
      _zz_when_FpUnit_l91_9 = 6'h10;
    end
    if(when_FpUnit_l84_404) begin
      _zz_when_FpUnit_l91_9 = 6'h11;
    end
    if(when_FpUnit_l84_405) begin
      _zz_when_FpUnit_l91_9 = 6'h12;
    end
    if(when_FpUnit_l84_406) begin
      _zz_when_FpUnit_l91_9 = 6'h13;
    end
    if(when_FpUnit_l84_407) begin
      _zz_when_FpUnit_l91_9 = 6'h14;
    end
    if(when_FpUnit_l84_408) begin
      _zz_when_FpUnit_l91_9 = 6'h15;
    end
    if(when_FpUnit_l84_409) begin
      _zz_when_FpUnit_l91_9 = 6'h16;
    end
    if(when_FpUnit_l84_410) begin
      _zz_when_FpUnit_l91_9 = 6'h17;
    end
    if(when_FpUnit_l84_411) begin
      _zz_when_FpUnit_l91_9 = 6'h18;
    end
    if(when_FpUnit_l84_412) begin
      _zz_when_FpUnit_l91_9 = 6'h19;
    end
    if(when_FpUnit_l84_413) begin
      _zz_when_FpUnit_l91_9 = 6'h1a;
    end
    if(when_FpUnit_l84_414) begin
      _zz_when_FpUnit_l91_9 = 6'h1b;
    end
    if(when_FpUnit_l84_415) begin
      _zz_when_FpUnit_l91_9 = 6'h1c;
    end
    if(when_FpUnit_l84_416) begin
      _zz_when_FpUnit_l91_9 = 6'h1d;
    end
    if(when_FpUnit_l84_417) begin
      _zz_when_FpUnit_l91_9 = 6'h1e;
    end
    if(when_FpUnit_l84_418) begin
      _zz_when_FpUnit_l91_9 = 6'h1f;
    end
    if(when_FpUnit_l84_419) begin
      _zz_when_FpUnit_l91_9 = 6'h20;
    end
    if(when_FpUnit_l84_420) begin
      _zz_when_FpUnit_l91_9 = 6'h21;
    end
    if(when_FpUnit_l84_421) begin
      _zz_when_FpUnit_l91_9 = 6'h22;
    end
    if(when_FpUnit_l84_422) begin
      _zz_when_FpUnit_l91_9 = 6'h23;
    end
    if(when_FpUnit_l84_423) begin
      _zz_when_FpUnit_l91_9 = 6'h24;
    end
    if(when_FpUnit_l84_424) begin
      _zz_when_FpUnit_l91_9 = 6'h25;
    end
    if(when_FpUnit_l84_425) begin
      _zz_when_FpUnit_l91_9 = 6'h26;
    end
    if(when_FpUnit_l84_426) begin
      _zz_when_FpUnit_l91_9 = 6'h27;
    end
    if(when_FpUnit_l84_427) begin
      _zz_when_FpUnit_l91_9 = 6'h28;
    end
    if(when_FpUnit_l84_428) begin
      _zz_when_FpUnit_l91_9 = 6'h29;
    end
    if(when_FpUnit_l84_429) begin
      _zz_when_FpUnit_l91_9 = 6'h2a;
    end
    if(when_FpUnit_l84_430) begin
      _zz_when_FpUnit_l91_9 = 6'h2b;
    end
    if(when_FpUnit_l84_431) begin
      _zz_when_FpUnit_l91_9 = 6'h2c;
    end
    if(when_FpUnit_l84_432) begin
      _zz_when_FpUnit_l91_9 = 6'h2d;
    end
    if(when_FpUnit_l84_433) begin
      _zz_when_FpUnit_l91_9 = 6'h2e;
    end
    if(when_FpUnit_l84_434) begin
      _zz_when_FpUnit_l91_9 = 6'h2f;
    end
    if(when_FpUnit_l84_435) begin
      _zz_when_FpUnit_l91_9 = 6'h30;
    end
    if(when_FpUnit_l84_436) begin
      _zz_when_FpUnit_l91_9 = 6'h31;
    end
    if(when_FpUnit_l84_437) begin
      _zz_when_FpUnit_l91_9 = 6'h32;
    end
    if(when_FpUnit_l84_438) begin
      _zz_when_FpUnit_l91_9 = 6'h33;
    end
    if(when_FpUnit_l84_439) begin
      _zz_when_FpUnit_l91_9 = 6'h34;
    end
    if(when_FpUnit_l84_440) begin
      _zz_when_FpUnit_l91_9 = 6'h35;
    end
    if(when_FpUnit_l84_441) begin
      _zz_when_FpUnit_l91_9 = 6'h36;
    end
    if(when_FpUnit_l84_442) begin
      _zz_when_FpUnit_l91_9 = 6'h37;
    end
  end

  assign when_FpUnit_l84_387 = _zz_when_FpUnit_l84_168[0];
  assign when_FpUnit_l84_388 = _zz_when_FpUnit_l84_168[1];
  assign when_FpUnit_l84_389 = _zz_when_FpUnit_l84_168[2];
  assign when_FpUnit_l84_390 = _zz_when_FpUnit_l84_168[3];
  assign when_FpUnit_l84_391 = _zz_when_FpUnit_l84_168[4];
  assign when_FpUnit_l84_392 = _zz_when_FpUnit_l84_168[5];
  assign when_FpUnit_l84_393 = _zz_when_FpUnit_l84_168[6];
  assign when_FpUnit_l84_394 = _zz_when_FpUnit_l84_168[7];
  assign when_FpUnit_l84_395 = _zz_when_FpUnit_l84_168[8];
  assign when_FpUnit_l84_396 = _zz_when_FpUnit_l84_168[9];
  assign when_FpUnit_l84_397 = _zz_when_FpUnit_l84_168[10];
  assign when_FpUnit_l84_398 = _zz_when_FpUnit_l84_168[11];
  assign when_FpUnit_l84_399 = _zz_when_FpUnit_l84_168[12];
  assign when_FpUnit_l84_400 = _zz_when_FpUnit_l84_168[13];
  assign when_FpUnit_l84_401 = _zz_when_FpUnit_l84_168[14];
  assign when_FpUnit_l84_402 = _zz_when_FpUnit_l84_168[15];
  assign when_FpUnit_l84_403 = _zz_when_FpUnit_l84_168[16];
  assign when_FpUnit_l84_404 = _zz_when_FpUnit_l84_168[17];
  assign when_FpUnit_l84_405 = _zz_when_FpUnit_l84_168[18];
  assign when_FpUnit_l84_406 = _zz_when_FpUnit_l84_168[19];
  assign when_FpUnit_l84_407 = _zz_when_FpUnit_l84_168[20];
  assign when_FpUnit_l84_408 = _zz_when_FpUnit_l84_168[21];
  assign when_FpUnit_l84_409 = _zz_when_FpUnit_l84_168[22];
  assign when_FpUnit_l84_410 = _zz_when_FpUnit_l84_168[23];
  assign when_FpUnit_l84_411 = _zz_when_FpUnit_l84_168[24];
  assign when_FpUnit_l84_412 = _zz_when_FpUnit_l84_168[25];
  assign when_FpUnit_l84_413 = _zz_when_FpUnit_l84_168[26];
  assign when_FpUnit_l84_414 = _zz_when_FpUnit_l84_168[27];
  assign when_FpUnit_l84_415 = _zz_when_FpUnit_l84_168[28];
  assign when_FpUnit_l84_416 = _zz_when_FpUnit_l84_168[29];
  assign when_FpUnit_l84_417 = _zz_when_FpUnit_l84_168[30];
  assign when_FpUnit_l84_418 = _zz_when_FpUnit_l84_168[31];
  assign when_FpUnit_l84_419 = _zz_when_FpUnit_l84_168[32];
  assign when_FpUnit_l84_420 = _zz_when_FpUnit_l84_168[33];
  assign when_FpUnit_l84_421 = _zz_when_FpUnit_l84_168[34];
  assign when_FpUnit_l84_422 = _zz_when_FpUnit_l84_168[35];
  assign when_FpUnit_l84_423 = _zz_when_FpUnit_l84_168[36];
  assign when_FpUnit_l84_424 = _zz_when_FpUnit_l84_168[37];
  assign when_FpUnit_l84_425 = _zz_when_FpUnit_l84_168[38];
  assign when_FpUnit_l84_426 = _zz_when_FpUnit_l84_168[39];
  assign when_FpUnit_l84_427 = _zz_when_FpUnit_l84_168[40];
  assign when_FpUnit_l84_428 = _zz_when_FpUnit_l84_168[41];
  assign when_FpUnit_l84_429 = _zz_when_FpUnit_l84_168[42];
  assign when_FpUnit_l84_430 = _zz_when_FpUnit_l84_168[43];
  assign when_FpUnit_l84_431 = _zz_when_FpUnit_l84_168[44];
  assign when_FpUnit_l84_432 = _zz_when_FpUnit_l84_168[45];
  assign when_FpUnit_l84_433 = _zz_when_FpUnit_l84_168[46];
  assign when_FpUnit_l84_434 = _zz_when_FpUnit_l84_168[47];
  assign when_FpUnit_l84_435 = _zz_when_FpUnit_l84_168[48];
  assign when_FpUnit_l84_436 = _zz_when_FpUnit_l84_168[49];
  assign when_FpUnit_l84_437 = _zz_when_FpUnit_l84_168[50];
  assign when_FpUnit_l84_438 = _zz_when_FpUnit_l84_168[51];
  assign when_FpUnit_l84_439 = _zz_when_FpUnit_l84_168[52];
  assign when_FpUnit_l84_440 = _zz_when_FpUnit_l84_168[53];
  assign when_FpUnit_l84_441 = _zz_when_FpUnit_l84_168[54];
  assign when_FpUnit_l84_442 = _zz_when_FpUnit_l84_168[55];
  always @(*) begin
    _zz_flagNX_9 = 27'h0;
    if(when_FpUnit_l90_9) begin
      if(when_FpUnit_l91_9) begin
        _zz_flagNX_9 = _zz__zz_flagNX_9;
      end else begin
        _zz_flagNX_9 = _zz__zz_flagNX_9_2;
      end
    end
  end

  always @(*) begin
    _zz_flagNX_10 = 1'b0;
    if(when_FpUnit_l90_9) begin
      if(when_FpUnit_l91_9) begin
        _zz_flagNX_10 = (|(_zz_when_FpUnit_l84_168 & _zz__zz_flagNX_10));
      end else begin
        _zz_flagNX_10 = 1'b0;
      end
    end
  end

  assign _zz_when_FpUnit_l116_9 = ($signed(_zz__zz_when_FpUnit_l116_9) + $signed(12'h0));
  assign when_FpUnit_l90_9 = (_zz_when_FpUnit_l84_168 != 56'h0);
  assign when_FpUnit_l91_9 = (6'h1a < _zz_when_FpUnit_l91_9);
  assign _zz_flagNX_11 = (_zz_when_FpUnit_l91_9 - 6'h1a);
  assign _zz_when_FpUnit_l116_10 = ($signed(_zz__zz_when_FpUnit_l116_10) < $signed(12'h001));
  assign _zz_when_FpUnit_l116_11 = (_zz_when_FpUnit_l116_10 ? _zz__zz_when_FpUnit_l116_11 : 12'h0);
  assign _zz_when_FpUnit_l119_9 = _zz_when_FpUnit_l116_11;
  assign when_FpUnit_l116_9 = ($signed(_zz_when_FpUnit_l116_11) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l116_9) begin
      _zz_flagNX_12 = _zz_flagNX_9;
    end else begin
      if(when_FpUnit_l119_9) begin
        _zz_flagNX_12 = 27'h0;
      end else begin
        _zz_flagNX_12 = _zz__zz_flagNX_12;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l116_9) begin
      _zz_flagNX_13 = _zz_flagNX_10;
    end else begin
      if(when_FpUnit_l119_9) begin
        _zz_flagNX_13 = ((|_zz_flagNX_9) || _zz_flagNX_10);
      end else begin
        _zz_flagNX_13 = ((|(_zz_flagNX_9 & _zz__zz_flagNX_13)) || _zz_flagNX_10);
      end
    end
  end

  assign when_FpUnit_l119_9 = (12'h01b <= _zz_when_FpUnit_l119_9);
  assign _zz_when_FpUnit_l150_45 = (_zz_when_FpUnit_l116_10 ? 12'hf82 : _zz_when_FpUnit_l116_9);
  assign _zz_flagNX_14 = _zz_flagNX_12[2];
  assign _zz_flagNX_15 = _zz_flagNX_12[1];
  assign _zz_flagNX_16 = (_zz_flagNX_12[0] || _zz_flagNX_13);
  assign _zz_when_FpUnit_l150_46 = _zz_flagNX_12[26 : 3];
  assign _zz_when_FpUnit_l150_47 = (_zz__zz_when_FpUnit_l150_47 + _zz__zz_when_FpUnit_l150_47_2);
  assign _zz_when_FpUnit_l150_48 = _zz_when_FpUnit_l150_47[24];
  assign _zz_res_67 = (_zz_when_FpUnit_l150_48 ? _zz__zz_res_67 : _zz__zz_res_67_1);
  assign _zz_when_FpUnit_l150_49 = ($signed(_zz__zz_when_FpUnit_l150_49) + $signed(12'h07f));
  assign when_FpUnit_l150_9 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l150_49));
  assign _zz_res_68 = {_zz_res_66,{8'hff,23'h0}};
  assign _zz_res_69 = {_zz_res_66,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_70 = 32'h0;
    if(when_FpUnit_l150_9) begin
      _zz_res_70 = ((io_rm == 3'b001) ? _zz_res_69 : ((io_rm == 3'b010) ? (_zz_res_66 ? _zz_res_68 : _zz_res_69) : ((io_rm == 3'b011) ? (_zz_res_66 ? _zz_res_69 : _zz_res_68) : _zz_res_68)));
    end else begin
      if(when_FpUnit_l154_9) begin
        _zz_res_70 = {_zz_res_66,{8'h0,_zz_res_67[22 : 0]}};
      end else begin
        _zz_res_70 = {_zz_res_66,{_zz__zz_res_70,_zz_res_67[22 : 0]}};
      end
    end
  end

  assign when_FpUnit_l154_9 = ($signed(_zz_when_FpUnit_l150_49) < $signed(12'h001));
  always @(*) begin
    _zz_res_71 = _zz_res_70;
    if(when_FpUnit_l498) begin
      _zz_res_71 = {_zz_res_66,{8'h0,23'h0}};
    end
  end

  assign when_FpUnit_l498 = (_zz_when_FpUnit_l84_168 == 56'h0);
  assign _zz_res_72 = 1'b0;
  assign _zz_when_FpUnit_l84_169 = io_a[31 : 0];
  assign _zz_when_FpUnit_l84_170 = (_zz_res_72 ? _zz__zz_when_FpUnit_l84_170 : _zz__zz_when_FpUnit_l84_170_2);
  always @(*) begin
    _zz_when_FpUnit_l91_10 = 6'h0;
    if(when_FpUnit_l84_443) begin
      _zz_when_FpUnit_l91_10 = 6'h0;
    end
    if(when_FpUnit_l84_444) begin
      _zz_when_FpUnit_l91_10 = 6'h01;
    end
    if(when_FpUnit_l84_445) begin
      _zz_when_FpUnit_l91_10 = 6'h02;
    end
    if(when_FpUnit_l84_446) begin
      _zz_when_FpUnit_l91_10 = 6'h03;
    end
    if(when_FpUnit_l84_447) begin
      _zz_when_FpUnit_l91_10 = 6'h04;
    end
    if(when_FpUnit_l84_448) begin
      _zz_when_FpUnit_l91_10 = 6'h05;
    end
    if(when_FpUnit_l84_449) begin
      _zz_when_FpUnit_l91_10 = 6'h06;
    end
    if(when_FpUnit_l84_450) begin
      _zz_when_FpUnit_l91_10 = 6'h07;
    end
    if(when_FpUnit_l84_451) begin
      _zz_when_FpUnit_l91_10 = 6'h08;
    end
    if(when_FpUnit_l84_452) begin
      _zz_when_FpUnit_l91_10 = 6'h09;
    end
    if(when_FpUnit_l84_453) begin
      _zz_when_FpUnit_l91_10 = 6'h0a;
    end
    if(when_FpUnit_l84_454) begin
      _zz_when_FpUnit_l91_10 = 6'h0b;
    end
    if(when_FpUnit_l84_455) begin
      _zz_when_FpUnit_l91_10 = 6'h0c;
    end
    if(when_FpUnit_l84_456) begin
      _zz_when_FpUnit_l91_10 = 6'h0d;
    end
    if(when_FpUnit_l84_457) begin
      _zz_when_FpUnit_l91_10 = 6'h0e;
    end
    if(when_FpUnit_l84_458) begin
      _zz_when_FpUnit_l91_10 = 6'h0f;
    end
    if(when_FpUnit_l84_459) begin
      _zz_when_FpUnit_l91_10 = 6'h10;
    end
    if(when_FpUnit_l84_460) begin
      _zz_when_FpUnit_l91_10 = 6'h11;
    end
    if(when_FpUnit_l84_461) begin
      _zz_when_FpUnit_l91_10 = 6'h12;
    end
    if(when_FpUnit_l84_462) begin
      _zz_when_FpUnit_l91_10 = 6'h13;
    end
    if(when_FpUnit_l84_463) begin
      _zz_when_FpUnit_l91_10 = 6'h14;
    end
    if(when_FpUnit_l84_464) begin
      _zz_when_FpUnit_l91_10 = 6'h15;
    end
    if(when_FpUnit_l84_465) begin
      _zz_when_FpUnit_l91_10 = 6'h16;
    end
    if(when_FpUnit_l84_466) begin
      _zz_when_FpUnit_l91_10 = 6'h17;
    end
    if(when_FpUnit_l84_467) begin
      _zz_when_FpUnit_l91_10 = 6'h18;
    end
    if(when_FpUnit_l84_468) begin
      _zz_when_FpUnit_l91_10 = 6'h19;
    end
    if(when_FpUnit_l84_469) begin
      _zz_when_FpUnit_l91_10 = 6'h1a;
    end
    if(when_FpUnit_l84_470) begin
      _zz_when_FpUnit_l91_10 = 6'h1b;
    end
    if(when_FpUnit_l84_471) begin
      _zz_when_FpUnit_l91_10 = 6'h1c;
    end
    if(when_FpUnit_l84_472) begin
      _zz_when_FpUnit_l91_10 = 6'h1d;
    end
    if(when_FpUnit_l84_473) begin
      _zz_when_FpUnit_l91_10 = 6'h1e;
    end
    if(when_FpUnit_l84_474) begin
      _zz_when_FpUnit_l91_10 = 6'h1f;
    end
    if(when_FpUnit_l84_475) begin
      _zz_when_FpUnit_l91_10 = 6'h20;
    end
    if(when_FpUnit_l84_476) begin
      _zz_when_FpUnit_l91_10 = 6'h21;
    end
    if(when_FpUnit_l84_477) begin
      _zz_when_FpUnit_l91_10 = 6'h22;
    end
    if(when_FpUnit_l84_478) begin
      _zz_when_FpUnit_l91_10 = 6'h23;
    end
    if(when_FpUnit_l84_479) begin
      _zz_when_FpUnit_l91_10 = 6'h24;
    end
    if(when_FpUnit_l84_480) begin
      _zz_when_FpUnit_l91_10 = 6'h25;
    end
    if(when_FpUnit_l84_481) begin
      _zz_when_FpUnit_l91_10 = 6'h26;
    end
    if(when_FpUnit_l84_482) begin
      _zz_when_FpUnit_l91_10 = 6'h27;
    end
    if(when_FpUnit_l84_483) begin
      _zz_when_FpUnit_l91_10 = 6'h28;
    end
    if(when_FpUnit_l84_484) begin
      _zz_when_FpUnit_l91_10 = 6'h29;
    end
    if(when_FpUnit_l84_485) begin
      _zz_when_FpUnit_l91_10 = 6'h2a;
    end
    if(when_FpUnit_l84_486) begin
      _zz_when_FpUnit_l91_10 = 6'h2b;
    end
    if(when_FpUnit_l84_487) begin
      _zz_when_FpUnit_l91_10 = 6'h2c;
    end
    if(when_FpUnit_l84_488) begin
      _zz_when_FpUnit_l91_10 = 6'h2d;
    end
    if(when_FpUnit_l84_489) begin
      _zz_when_FpUnit_l91_10 = 6'h2e;
    end
    if(when_FpUnit_l84_490) begin
      _zz_when_FpUnit_l91_10 = 6'h2f;
    end
    if(when_FpUnit_l84_491) begin
      _zz_when_FpUnit_l91_10 = 6'h30;
    end
    if(when_FpUnit_l84_492) begin
      _zz_when_FpUnit_l91_10 = 6'h31;
    end
    if(when_FpUnit_l84_493) begin
      _zz_when_FpUnit_l91_10 = 6'h32;
    end
    if(when_FpUnit_l84_494) begin
      _zz_when_FpUnit_l91_10 = 6'h33;
    end
    if(when_FpUnit_l84_495) begin
      _zz_when_FpUnit_l91_10 = 6'h34;
    end
    if(when_FpUnit_l84_496) begin
      _zz_when_FpUnit_l91_10 = 6'h35;
    end
    if(when_FpUnit_l84_497) begin
      _zz_when_FpUnit_l91_10 = 6'h36;
    end
    if(when_FpUnit_l84_498) begin
      _zz_when_FpUnit_l91_10 = 6'h37;
    end
  end

  assign when_FpUnit_l84_443 = _zz_when_FpUnit_l84_170[0];
  assign when_FpUnit_l84_444 = _zz_when_FpUnit_l84_170[1];
  assign when_FpUnit_l84_445 = _zz_when_FpUnit_l84_170[2];
  assign when_FpUnit_l84_446 = _zz_when_FpUnit_l84_170[3];
  assign when_FpUnit_l84_447 = _zz_when_FpUnit_l84_170[4];
  assign when_FpUnit_l84_448 = _zz_when_FpUnit_l84_170[5];
  assign when_FpUnit_l84_449 = _zz_when_FpUnit_l84_170[6];
  assign when_FpUnit_l84_450 = _zz_when_FpUnit_l84_170[7];
  assign when_FpUnit_l84_451 = _zz_when_FpUnit_l84_170[8];
  assign when_FpUnit_l84_452 = _zz_when_FpUnit_l84_170[9];
  assign when_FpUnit_l84_453 = _zz_when_FpUnit_l84_170[10];
  assign when_FpUnit_l84_454 = _zz_when_FpUnit_l84_170[11];
  assign when_FpUnit_l84_455 = _zz_when_FpUnit_l84_170[12];
  assign when_FpUnit_l84_456 = _zz_when_FpUnit_l84_170[13];
  assign when_FpUnit_l84_457 = _zz_when_FpUnit_l84_170[14];
  assign when_FpUnit_l84_458 = _zz_when_FpUnit_l84_170[15];
  assign when_FpUnit_l84_459 = _zz_when_FpUnit_l84_170[16];
  assign when_FpUnit_l84_460 = _zz_when_FpUnit_l84_170[17];
  assign when_FpUnit_l84_461 = _zz_when_FpUnit_l84_170[18];
  assign when_FpUnit_l84_462 = _zz_when_FpUnit_l84_170[19];
  assign when_FpUnit_l84_463 = _zz_when_FpUnit_l84_170[20];
  assign when_FpUnit_l84_464 = _zz_when_FpUnit_l84_170[21];
  assign when_FpUnit_l84_465 = _zz_when_FpUnit_l84_170[22];
  assign when_FpUnit_l84_466 = _zz_when_FpUnit_l84_170[23];
  assign when_FpUnit_l84_467 = _zz_when_FpUnit_l84_170[24];
  assign when_FpUnit_l84_468 = _zz_when_FpUnit_l84_170[25];
  assign when_FpUnit_l84_469 = _zz_when_FpUnit_l84_170[26];
  assign when_FpUnit_l84_470 = _zz_when_FpUnit_l84_170[27];
  assign when_FpUnit_l84_471 = _zz_when_FpUnit_l84_170[28];
  assign when_FpUnit_l84_472 = _zz_when_FpUnit_l84_170[29];
  assign when_FpUnit_l84_473 = _zz_when_FpUnit_l84_170[30];
  assign when_FpUnit_l84_474 = _zz_when_FpUnit_l84_170[31];
  assign when_FpUnit_l84_475 = _zz_when_FpUnit_l84_170[32];
  assign when_FpUnit_l84_476 = _zz_when_FpUnit_l84_170[33];
  assign when_FpUnit_l84_477 = _zz_when_FpUnit_l84_170[34];
  assign when_FpUnit_l84_478 = _zz_when_FpUnit_l84_170[35];
  assign when_FpUnit_l84_479 = _zz_when_FpUnit_l84_170[36];
  assign when_FpUnit_l84_480 = _zz_when_FpUnit_l84_170[37];
  assign when_FpUnit_l84_481 = _zz_when_FpUnit_l84_170[38];
  assign when_FpUnit_l84_482 = _zz_when_FpUnit_l84_170[39];
  assign when_FpUnit_l84_483 = _zz_when_FpUnit_l84_170[40];
  assign when_FpUnit_l84_484 = _zz_when_FpUnit_l84_170[41];
  assign when_FpUnit_l84_485 = _zz_when_FpUnit_l84_170[42];
  assign when_FpUnit_l84_486 = _zz_when_FpUnit_l84_170[43];
  assign when_FpUnit_l84_487 = _zz_when_FpUnit_l84_170[44];
  assign when_FpUnit_l84_488 = _zz_when_FpUnit_l84_170[45];
  assign when_FpUnit_l84_489 = _zz_when_FpUnit_l84_170[46];
  assign when_FpUnit_l84_490 = _zz_when_FpUnit_l84_170[47];
  assign when_FpUnit_l84_491 = _zz_when_FpUnit_l84_170[48];
  assign when_FpUnit_l84_492 = _zz_when_FpUnit_l84_170[49];
  assign when_FpUnit_l84_493 = _zz_when_FpUnit_l84_170[50];
  assign when_FpUnit_l84_494 = _zz_when_FpUnit_l84_170[51];
  assign when_FpUnit_l84_495 = _zz_when_FpUnit_l84_170[52];
  assign when_FpUnit_l84_496 = _zz_when_FpUnit_l84_170[53];
  assign when_FpUnit_l84_497 = _zz_when_FpUnit_l84_170[54];
  assign when_FpUnit_l84_498 = _zz_when_FpUnit_l84_170[55];
  always @(*) begin
    _zz_flagNX_17 = 27'h0;
    if(when_FpUnit_l90_10) begin
      if(when_FpUnit_l91_10) begin
        _zz_flagNX_17 = _zz__zz_flagNX_17;
      end else begin
        _zz_flagNX_17 = _zz__zz_flagNX_17_2;
      end
    end
  end

  always @(*) begin
    _zz_flagNX_18 = 1'b0;
    if(when_FpUnit_l90_10) begin
      if(when_FpUnit_l91_10) begin
        _zz_flagNX_18 = (|(_zz_when_FpUnit_l84_170 & _zz__zz_flagNX_18));
      end else begin
        _zz_flagNX_18 = 1'b0;
      end
    end
  end

  assign _zz_when_FpUnit_l116_12 = ($signed(_zz__zz_when_FpUnit_l116_12) + $signed(12'h0));
  assign when_FpUnit_l90_10 = (_zz_when_FpUnit_l84_170 != 56'h0);
  assign when_FpUnit_l91_10 = (6'h1a < _zz_when_FpUnit_l91_10);
  assign _zz_flagNX_19 = (_zz_when_FpUnit_l91_10 - 6'h1a);
  assign _zz_when_FpUnit_l116_13 = ($signed(_zz__zz_when_FpUnit_l116_13) < $signed(12'h001));
  assign _zz_when_FpUnit_l116_14 = (_zz_when_FpUnit_l116_13 ? _zz__zz_when_FpUnit_l116_14 : 12'h0);
  assign _zz_when_FpUnit_l119_10 = _zz_when_FpUnit_l116_14;
  assign when_FpUnit_l116_10 = ($signed(_zz_when_FpUnit_l116_14) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l116_10) begin
      _zz_flagNX_20 = _zz_flagNX_17;
    end else begin
      if(when_FpUnit_l119_10) begin
        _zz_flagNX_20 = 27'h0;
      end else begin
        _zz_flagNX_20 = _zz__zz_flagNX_20;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l116_10) begin
      _zz_flagNX_21 = _zz_flagNX_18;
    end else begin
      if(when_FpUnit_l119_10) begin
        _zz_flagNX_21 = ((|_zz_flagNX_17) || _zz_flagNX_18);
      end else begin
        _zz_flagNX_21 = ((|(_zz_flagNX_17 & _zz__zz_flagNX_21)) || _zz_flagNX_18);
      end
    end
  end

  assign when_FpUnit_l119_10 = (12'h01b <= _zz_when_FpUnit_l119_10);
  assign _zz_when_FpUnit_l150_50 = (_zz_when_FpUnit_l116_13 ? 12'hf82 : _zz_when_FpUnit_l116_12);
  assign _zz_flagNX_22 = _zz_flagNX_20[2];
  assign _zz_flagNX_23 = _zz_flagNX_20[1];
  assign _zz_flagNX_24 = (_zz_flagNX_20[0] || _zz_flagNX_21);
  assign _zz_when_FpUnit_l150_51 = _zz_flagNX_20[26 : 3];
  assign _zz_when_FpUnit_l150_52 = (_zz__zz_when_FpUnit_l150_52 + _zz__zz_when_FpUnit_l150_52_2);
  assign _zz_when_FpUnit_l150_53 = _zz_when_FpUnit_l150_52[24];
  assign _zz_res_73 = (_zz_when_FpUnit_l150_53 ? _zz__zz_res_73 : _zz__zz_res_73_1);
  assign _zz_when_FpUnit_l150_54 = ($signed(_zz__zz_when_FpUnit_l150_54) + $signed(12'h07f));
  assign when_FpUnit_l150_10 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l150_54));
  assign _zz_res_74 = {_zz_res_72,{8'hff,23'h0}};
  assign _zz_res_75 = {_zz_res_72,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_76 = 32'h0;
    if(when_FpUnit_l150_10) begin
      _zz_res_76 = ((io_rm == 3'b001) ? _zz_res_75 : ((io_rm == 3'b010) ? (_zz_res_72 ? _zz_res_74 : _zz_res_75) : ((io_rm == 3'b011) ? (_zz_res_72 ? _zz_res_75 : _zz_res_74) : _zz_res_74)));
    end else begin
      if(when_FpUnit_l154_10) begin
        _zz_res_76 = {_zz_res_72,{8'h0,_zz_res_73[22 : 0]}};
      end else begin
        _zz_res_76 = {_zz_res_72,{_zz__zz_res_76,_zz_res_73[22 : 0]}};
      end
    end
  end

  assign when_FpUnit_l154_10 = ($signed(_zz_when_FpUnit_l150_54) < $signed(12'h001));
  always @(*) begin
    _zz_res_77 = _zz_res_76;
    if(when_FpUnit_l498_1) begin
      _zz_res_77 = {_zz_res_72,{8'h0,23'h0}};
    end
  end

  assign when_FpUnit_l498_1 = (_zz_when_FpUnit_l84_170 == 56'h0);
  assign _zz_res_78 = io_a[63];
  assign _zz_when_FpUnit_l84_171 = io_a[63 : 0];
  assign _zz_when_FpUnit_l84_172 = (_zz_res_78 ? _zz__zz_when_FpUnit_l84_172 : _zz__zz_when_FpUnit_l84_172_2);
  always @(*) begin
    _zz_when_FpUnit_l91_11 = 7'h0;
    if(when_FpUnit_l84_499) begin
      _zz_when_FpUnit_l91_11 = 7'h0;
    end
    if(when_FpUnit_l84_500) begin
      _zz_when_FpUnit_l91_11 = 7'h01;
    end
    if(when_FpUnit_l84_501) begin
      _zz_when_FpUnit_l91_11 = 7'h02;
    end
    if(when_FpUnit_l84_502) begin
      _zz_when_FpUnit_l91_11 = 7'h03;
    end
    if(when_FpUnit_l84_503) begin
      _zz_when_FpUnit_l91_11 = 7'h04;
    end
    if(when_FpUnit_l84_504) begin
      _zz_when_FpUnit_l91_11 = 7'h05;
    end
    if(when_FpUnit_l84_505) begin
      _zz_when_FpUnit_l91_11 = 7'h06;
    end
    if(when_FpUnit_l84_506) begin
      _zz_when_FpUnit_l91_11 = 7'h07;
    end
    if(when_FpUnit_l84_507) begin
      _zz_when_FpUnit_l91_11 = 7'h08;
    end
    if(when_FpUnit_l84_508) begin
      _zz_when_FpUnit_l91_11 = 7'h09;
    end
    if(when_FpUnit_l84_509) begin
      _zz_when_FpUnit_l91_11 = 7'h0a;
    end
    if(when_FpUnit_l84_510) begin
      _zz_when_FpUnit_l91_11 = 7'h0b;
    end
    if(when_FpUnit_l84_511) begin
      _zz_when_FpUnit_l91_11 = 7'h0c;
    end
    if(when_FpUnit_l84_512) begin
      _zz_when_FpUnit_l91_11 = 7'h0d;
    end
    if(when_FpUnit_l84_513) begin
      _zz_when_FpUnit_l91_11 = 7'h0e;
    end
    if(when_FpUnit_l84_514) begin
      _zz_when_FpUnit_l91_11 = 7'h0f;
    end
    if(when_FpUnit_l84_515) begin
      _zz_when_FpUnit_l91_11 = 7'h10;
    end
    if(when_FpUnit_l84_516) begin
      _zz_when_FpUnit_l91_11 = 7'h11;
    end
    if(when_FpUnit_l84_517) begin
      _zz_when_FpUnit_l91_11 = 7'h12;
    end
    if(when_FpUnit_l84_518) begin
      _zz_when_FpUnit_l91_11 = 7'h13;
    end
    if(when_FpUnit_l84_519) begin
      _zz_when_FpUnit_l91_11 = 7'h14;
    end
    if(when_FpUnit_l84_520) begin
      _zz_when_FpUnit_l91_11 = 7'h15;
    end
    if(when_FpUnit_l84_521) begin
      _zz_when_FpUnit_l91_11 = 7'h16;
    end
    if(when_FpUnit_l84_522) begin
      _zz_when_FpUnit_l91_11 = 7'h17;
    end
    if(when_FpUnit_l84_523) begin
      _zz_when_FpUnit_l91_11 = 7'h18;
    end
    if(when_FpUnit_l84_524) begin
      _zz_when_FpUnit_l91_11 = 7'h19;
    end
    if(when_FpUnit_l84_525) begin
      _zz_when_FpUnit_l91_11 = 7'h1a;
    end
    if(when_FpUnit_l84_526) begin
      _zz_when_FpUnit_l91_11 = 7'h1b;
    end
    if(when_FpUnit_l84_527) begin
      _zz_when_FpUnit_l91_11 = 7'h1c;
    end
    if(when_FpUnit_l84_528) begin
      _zz_when_FpUnit_l91_11 = 7'h1d;
    end
    if(when_FpUnit_l84_529) begin
      _zz_when_FpUnit_l91_11 = 7'h1e;
    end
    if(when_FpUnit_l84_530) begin
      _zz_when_FpUnit_l91_11 = 7'h1f;
    end
    if(when_FpUnit_l84_531) begin
      _zz_when_FpUnit_l91_11 = 7'h20;
    end
    if(when_FpUnit_l84_532) begin
      _zz_when_FpUnit_l91_11 = 7'h21;
    end
    if(when_FpUnit_l84_533) begin
      _zz_when_FpUnit_l91_11 = 7'h22;
    end
    if(when_FpUnit_l84_534) begin
      _zz_when_FpUnit_l91_11 = 7'h23;
    end
    if(when_FpUnit_l84_535) begin
      _zz_when_FpUnit_l91_11 = 7'h24;
    end
    if(when_FpUnit_l84_536) begin
      _zz_when_FpUnit_l91_11 = 7'h25;
    end
    if(when_FpUnit_l84_537) begin
      _zz_when_FpUnit_l91_11 = 7'h26;
    end
    if(when_FpUnit_l84_538) begin
      _zz_when_FpUnit_l91_11 = 7'h27;
    end
    if(when_FpUnit_l84_539) begin
      _zz_when_FpUnit_l91_11 = 7'h28;
    end
    if(when_FpUnit_l84_540) begin
      _zz_when_FpUnit_l91_11 = 7'h29;
    end
    if(when_FpUnit_l84_541) begin
      _zz_when_FpUnit_l91_11 = 7'h2a;
    end
    if(when_FpUnit_l84_542) begin
      _zz_when_FpUnit_l91_11 = 7'h2b;
    end
    if(when_FpUnit_l84_543) begin
      _zz_when_FpUnit_l91_11 = 7'h2c;
    end
    if(when_FpUnit_l84_544) begin
      _zz_when_FpUnit_l91_11 = 7'h2d;
    end
    if(when_FpUnit_l84_545) begin
      _zz_when_FpUnit_l91_11 = 7'h2e;
    end
    if(when_FpUnit_l84_546) begin
      _zz_when_FpUnit_l91_11 = 7'h2f;
    end
    if(when_FpUnit_l84_547) begin
      _zz_when_FpUnit_l91_11 = 7'h30;
    end
    if(when_FpUnit_l84_548) begin
      _zz_when_FpUnit_l91_11 = 7'h31;
    end
    if(when_FpUnit_l84_549) begin
      _zz_when_FpUnit_l91_11 = 7'h32;
    end
    if(when_FpUnit_l84_550) begin
      _zz_when_FpUnit_l91_11 = 7'h33;
    end
    if(when_FpUnit_l84_551) begin
      _zz_when_FpUnit_l91_11 = 7'h34;
    end
    if(when_FpUnit_l84_552) begin
      _zz_when_FpUnit_l91_11 = 7'h35;
    end
    if(when_FpUnit_l84_553) begin
      _zz_when_FpUnit_l91_11 = 7'h36;
    end
    if(when_FpUnit_l84_554) begin
      _zz_when_FpUnit_l91_11 = 7'h37;
    end
    if(when_FpUnit_l84_555) begin
      _zz_when_FpUnit_l91_11 = 7'h38;
    end
    if(when_FpUnit_l84_556) begin
      _zz_when_FpUnit_l91_11 = 7'h39;
    end
    if(when_FpUnit_l84_557) begin
      _zz_when_FpUnit_l91_11 = 7'h3a;
    end
    if(when_FpUnit_l84_558) begin
      _zz_when_FpUnit_l91_11 = 7'h3b;
    end
    if(when_FpUnit_l84_559) begin
      _zz_when_FpUnit_l91_11 = 7'h3c;
    end
    if(when_FpUnit_l84_560) begin
      _zz_when_FpUnit_l91_11 = 7'h3d;
    end
    if(when_FpUnit_l84_561) begin
      _zz_when_FpUnit_l91_11 = 7'h3e;
    end
    if(when_FpUnit_l84_562) begin
      _zz_when_FpUnit_l91_11 = 7'h3f;
    end
    if(when_FpUnit_l84_563) begin
      _zz_when_FpUnit_l91_11 = 7'h40;
    end
    if(when_FpUnit_l84_564) begin
      _zz_when_FpUnit_l91_11 = 7'h41;
    end
    if(when_FpUnit_l84_565) begin
      _zz_when_FpUnit_l91_11 = 7'h42;
    end
    if(when_FpUnit_l84_566) begin
      _zz_when_FpUnit_l91_11 = 7'h43;
    end
    if(when_FpUnit_l84_567) begin
      _zz_when_FpUnit_l91_11 = 7'h44;
    end
    if(when_FpUnit_l84_568) begin
      _zz_when_FpUnit_l91_11 = 7'h45;
    end
    if(when_FpUnit_l84_569) begin
      _zz_when_FpUnit_l91_11 = 7'h46;
    end
    if(when_FpUnit_l84_570) begin
      _zz_when_FpUnit_l91_11 = 7'h47;
    end
    if(when_FpUnit_l84_571) begin
      _zz_when_FpUnit_l91_11 = 7'h48;
    end
    if(when_FpUnit_l84_572) begin
      _zz_when_FpUnit_l91_11 = 7'h49;
    end
    if(when_FpUnit_l84_573) begin
      _zz_when_FpUnit_l91_11 = 7'h4a;
    end
    if(when_FpUnit_l84_574) begin
      _zz_when_FpUnit_l91_11 = 7'h4b;
    end
    if(when_FpUnit_l84_575) begin
      _zz_when_FpUnit_l91_11 = 7'h4c;
    end
    if(when_FpUnit_l84_576) begin
      _zz_when_FpUnit_l91_11 = 7'h4d;
    end
    if(when_FpUnit_l84_577) begin
      _zz_when_FpUnit_l91_11 = 7'h4e;
    end
    if(when_FpUnit_l84_578) begin
      _zz_when_FpUnit_l91_11 = 7'h4f;
    end
    if(when_FpUnit_l84_579) begin
      _zz_when_FpUnit_l91_11 = 7'h50;
    end
    if(when_FpUnit_l84_580) begin
      _zz_when_FpUnit_l91_11 = 7'h51;
    end
    if(when_FpUnit_l84_581) begin
      _zz_when_FpUnit_l91_11 = 7'h52;
    end
    if(when_FpUnit_l84_582) begin
      _zz_when_FpUnit_l91_11 = 7'h53;
    end
    if(when_FpUnit_l84_583) begin
      _zz_when_FpUnit_l91_11 = 7'h54;
    end
    if(when_FpUnit_l84_584) begin
      _zz_when_FpUnit_l91_11 = 7'h55;
    end
    if(when_FpUnit_l84_585) begin
      _zz_when_FpUnit_l91_11 = 7'h56;
    end
    if(when_FpUnit_l84_586) begin
      _zz_when_FpUnit_l91_11 = 7'h57;
    end
  end

  assign when_FpUnit_l84_499 = _zz_when_FpUnit_l84_172[0];
  assign when_FpUnit_l84_500 = _zz_when_FpUnit_l84_172[1];
  assign when_FpUnit_l84_501 = _zz_when_FpUnit_l84_172[2];
  assign when_FpUnit_l84_502 = _zz_when_FpUnit_l84_172[3];
  assign when_FpUnit_l84_503 = _zz_when_FpUnit_l84_172[4];
  assign when_FpUnit_l84_504 = _zz_when_FpUnit_l84_172[5];
  assign when_FpUnit_l84_505 = _zz_when_FpUnit_l84_172[6];
  assign when_FpUnit_l84_506 = _zz_when_FpUnit_l84_172[7];
  assign when_FpUnit_l84_507 = _zz_when_FpUnit_l84_172[8];
  assign when_FpUnit_l84_508 = _zz_when_FpUnit_l84_172[9];
  assign when_FpUnit_l84_509 = _zz_when_FpUnit_l84_172[10];
  assign when_FpUnit_l84_510 = _zz_when_FpUnit_l84_172[11];
  assign when_FpUnit_l84_511 = _zz_when_FpUnit_l84_172[12];
  assign when_FpUnit_l84_512 = _zz_when_FpUnit_l84_172[13];
  assign when_FpUnit_l84_513 = _zz_when_FpUnit_l84_172[14];
  assign when_FpUnit_l84_514 = _zz_when_FpUnit_l84_172[15];
  assign when_FpUnit_l84_515 = _zz_when_FpUnit_l84_172[16];
  assign when_FpUnit_l84_516 = _zz_when_FpUnit_l84_172[17];
  assign when_FpUnit_l84_517 = _zz_when_FpUnit_l84_172[18];
  assign when_FpUnit_l84_518 = _zz_when_FpUnit_l84_172[19];
  assign when_FpUnit_l84_519 = _zz_when_FpUnit_l84_172[20];
  assign when_FpUnit_l84_520 = _zz_when_FpUnit_l84_172[21];
  assign when_FpUnit_l84_521 = _zz_when_FpUnit_l84_172[22];
  assign when_FpUnit_l84_522 = _zz_when_FpUnit_l84_172[23];
  assign when_FpUnit_l84_523 = _zz_when_FpUnit_l84_172[24];
  assign when_FpUnit_l84_524 = _zz_when_FpUnit_l84_172[25];
  assign when_FpUnit_l84_525 = _zz_when_FpUnit_l84_172[26];
  assign when_FpUnit_l84_526 = _zz_when_FpUnit_l84_172[27];
  assign when_FpUnit_l84_527 = _zz_when_FpUnit_l84_172[28];
  assign when_FpUnit_l84_528 = _zz_when_FpUnit_l84_172[29];
  assign when_FpUnit_l84_529 = _zz_when_FpUnit_l84_172[30];
  assign when_FpUnit_l84_530 = _zz_when_FpUnit_l84_172[31];
  assign when_FpUnit_l84_531 = _zz_when_FpUnit_l84_172[32];
  assign when_FpUnit_l84_532 = _zz_when_FpUnit_l84_172[33];
  assign when_FpUnit_l84_533 = _zz_when_FpUnit_l84_172[34];
  assign when_FpUnit_l84_534 = _zz_when_FpUnit_l84_172[35];
  assign when_FpUnit_l84_535 = _zz_when_FpUnit_l84_172[36];
  assign when_FpUnit_l84_536 = _zz_when_FpUnit_l84_172[37];
  assign when_FpUnit_l84_537 = _zz_when_FpUnit_l84_172[38];
  assign when_FpUnit_l84_538 = _zz_when_FpUnit_l84_172[39];
  assign when_FpUnit_l84_539 = _zz_when_FpUnit_l84_172[40];
  assign when_FpUnit_l84_540 = _zz_when_FpUnit_l84_172[41];
  assign when_FpUnit_l84_541 = _zz_when_FpUnit_l84_172[42];
  assign when_FpUnit_l84_542 = _zz_when_FpUnit_l84_172[43];
  assign when_FpUnit_l84_543 = _zz_when_FpUnit_l84_172[44];
  assign when_FpUnit_l84_544 = _zz_when_FpUnit_l84_172[45];
  assign when_FpUnit_l84_545 = _zz_when_FpUnit_l84_172[46];
  assign when_FpUnit_l84_546 = _zz_when_FpUnit_l84_172[47];
  assign when_FpUnit_l84_547 = _zz_when_FpUnit_l84_172[48];
  assign when_FpUnit_l84_548 = _zz_when_FpUnit_l84_172[49];
  assign when_FpUnit_l84_549 = _zz_when_FpUnit_l84_172[50];
  assign when_FpUnit_l84_550 = _zz_when_FpUnit_l84_172[51];
  assign when_FpUnit_l84_551 = _zz_when_FpUnit_l84_172[52];
  assign when_FpUnit_l84_552 = _zz_when_FpUnit_l84_172[53];
  assign when_FpUnit_l84_553 = _zz_when_FpUnit_l84_172[54];
  assign when_FpUnit_l84_554 = _zz_when_FpUnit_l84_172[55];
  assign when_FpUnit_l84_555 = _zz_when_FpUnit_l84_172[56];
  assign when_FpUnit_l84_556 = _zz_when_FpUnit_l84_172[57];
  assign when_FpUnit_l84_557 = _zz_when_FpUnit_l84_172[58];
  assign when_FpUnit_l84_558 = _zz_when_FpUnit_l84_172[59];
  assign when_FpUnit_l84_559 = _zz_when_FpUnit_l84_172[60];
  assign when_FpUnit_l84_560 = _zz_when_FpUnit_l84_172[61];
  assign when_FpUnit_l84_561 = _zz_when_FpUnit_l84_172[62];
  assign when_FpUnit_l84_562 = _zz_when_FpUnit_l84_172[63];
  assign when_FpUnit_l84_563 = _zz_when_FpUnit_l84_172[64];
  assign when_FpUnit_l84_564 = _zz_when_FpUnit_l84_172[65];
  assign when_FpUnit_l84_565 = _zz_when_FpUnit_l84_172[66];
  assign when_FpUnit_l84_566 = _zz_when_FpUnit_l84_172[67];
  assign when_FpUnit_l84_567 = _zz_when_FpUnit_l84_172[68];
  assign when_FpUnit_l84_568 = _zz_when_FpUnit_l84_172[69];
  assign when_FpUnit_l84_569 = _zz_when_FpUnit_l84_172[70];
  assign when_FpUnit_l84_570 = _zz_when_FpUnit_l84_172[71];
  assign when_FpUnit_l84_571 = _zz_when_FpUnit_l84_172[72];
  assign when_FpUnit_l84_572 = _zz_when_FpUnit_l84_172[73];
  assign when_FpUnit_l84_573 = _zz_when_FpUnit_l84_172[74];
  assign when_FpUnit_l84_574 = _zz_when_FpUnit_l84_172[75];
  assign when_FpUnit_l84_575 = _zz_when_FpUnit_l84_172[76];
  assign when_FpUnit_l84_576 = _zz_when_FpUnit_l84_172[77];
  assign when_FpUnit_l84_577 = _zz_when_FpUnit_l84_172[78];
  assign when_FpUnit_l84_578 = _zz_when_FpUnit_l84_172[79];
  assign when_FpUnit_l84_579 = _zz_when_FpUnit_l84_172[80];
  assign when_FpUnit_l84_580 = _zz_when_FpUnit_l84_172[81];
  assign when_FpUnit_l84_581 = _zz_when_FpUnit_l84_172[82];
  assign when_FpUnit_l84_582 = _zz_when_FpUnit_l84_172[83];
  assign when_FpUnit_l84_583 = _zz_when_FpUnit_l84_172[84];
  assign when_FpUnit_l84_584 = _zz_when_FpUnit_l84_172[85];
  assign when_FpUnit_l84_585 = _zz_when_FpUnit_l84_172[86];
  assign when_FpUnit_l84_586 = _zz_when_FpUnit_l84_172[87];
  always @(*) begin
    _zz_flagNX_25 = 27'h0;
    if(when_FpUnit_l90_11) begin
      if(when_FpUnit_l91_11) begin
        _zz_flagNX_25 = _zz__zz_flagNX_25;
      end else begin
        _zz_flagNX_25 = _zz__zz_flagNX_25_2;
      end
    end
  end

  always @(*) begin
    _zz_flagNX_26 = 1'b0;
    if(when_FpUnit_l90_11) begin
      if(when_FpUnit_l91_11) begin
        _zz_flagNX_26 = (|(_zz_when_FpUnit_l84_172 & _zz__zz_flagNX_26));
      end else begin
        _zz_flagNX_26 = 1'b0;
      end
    end
  end

  assign _zz_when_FpUnit_l116_15 = ($signed(_zz__zz_when_FpUnit_l116_15) + $signed(12'h0));
  assign when_FpUnit_l90_11 = (_zz_when_FpUnit_l84_172 != 88'h0);
  assign when_FpUnit_l91_11 = (7'h1a < _zz_when_FpUnit_l91_11);
  assign _zz_flagNX_27 = (_zz_when_FpUnit_l91_11 - 7'h1a);
  assign _zz_when_FpUnit_l116_16 = ($signed(_zz__zz_when_FpUnit_l116_16) < $signed(12'h001));
  assign _zz_when_FpUnit_l116_17 = (_zz_when_FpUnit_l116_16 ? _zz__zz_when_FpUnit_l116_17 : 12'h0);
  assign _zz_when_FpUnit_l119_11 = _zz_when_FpUnit_l116_17;
  assign when_FpUnit_l116_11 = ($signed(_zz_when_FpUnit_l116_17) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l116_11) begin
      _zz_flagNX_28 = _zz_flagNX_25;
    end else begin
      if(when_FpUnit_l119_11) begin
        _zz_flagNX_28 = 27'h0;
      end else begin
        _zz_flagNX_28 = _zz__zz_flagNX_28;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l116_11) begin
      _zz_flagNX_29 = _zz_flagNX_26;
    end else begin
      if(when_FpUnit_l119_11) begin
        _zz_flagNX_29 = ((|_zz_flagNX_25) || _zz_flagNX_26);
      end else begin
        _zz_flagNX_29 = ((|(_zz_flagNX_25 & _zz__zz_flagNX_29)) || _zz_flagNX_26);
      end
    end
  end

  assign when_FpUnit_l119_11 = (12'h01b <= _zz_when_FpUnit_l119_11);
  assign _zz_when_FpUnit_l150_55 = (_zz_when_FpUnit_l116_16 ? 12'hf82 : _zz_when_FpUnit_l116_15);
  assign _zz_flagNX_30 = _zz_flagNX_28[2];
  assign _zz_flagNX_31 = _zz_flagNX_28[1];
  assign _zz_flagNX_32 = (_zz_flagNX_28[0] || _zz_flagNX_29);
  assign _zz_when_FpUnit_l150_56 = _zz_flagNX_28[26 : 3];
  assign _zz_when_FpUnit_l150_57 = (_zz__zz_when_FpUnit_l150_57 + _zz__zz_when_FpUnit_l150_57_2);
  assign _zz_when_FpUnit_l150_58 = _zz_when_FpUnit_l150_57[24];
  assign _zz_res_79 = (_zz_when_FpUnit_l150_58 ? _zz__zz_res_79 : _zz__zz_res_79_1);
  assign _zz_when_FpUnit_l150_59 = ($signed(_zz__zz_when_FpUnit_l150_59) + $signed(12'h07f));
  assign when_FpUnit_l150_11 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l150_59));
  assign _zz_res_80 = {_zz_res_78,{8'hff,23'h0}};
  assign _zz_res_81 = {_zz_res_78,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_82 = 32'h0;
    if(when_FpUnit_l150_11) begin
      _zz_res_82 = ((io_rm == 3'b001) ? _zz_res_81 : ((io_rm == 3'b010) ? (_zz_res_78 ? _zz_res_80 : _zz_res_81) : ((io_rm == 3'b011) ? (_zz_res_78 ? _zz_res_81 : _zz_res_80) : _zz_res_80)));
    end else begin
      if(when_FpUnit_l154_11) begin
        _zz_res_82 = {_zz_res_78,{8'h0,_zz_res_79[22 : 0]}};
      end else begin
        _zz_res_82 = {_zz_res_78,{_zz__zz_res_82,_zz_res_79[22 : 0]}};
      end
    end
  end

  assign when_FpUnit_l154_11 = ($signed(_zz_when_FpUnit_l150_59) < $signed(12'h001));
  always @(*) begin
    _zz_res_83 = _zz_res_82;
    if(when_FpUnit_l498_2) begin
      _zz_res_83 = {_zz_res_78,{8'h0,23'h0}};
    end
  end

  assign when_FpUnit_l498_2 = (_zz_when_FpUnit_l84_172 == 88'h0);
  assign _zz_res_84 = 1'b0;
  assign _zz_when_FpUnit_l84_173 = io_a[63 : 0];
  assign _zz_when_FpUnit_l84_174 = (_zz_res_84 ? _zz__zz_when_FpUnit_l84_174 : _zz__zz_when_FpUnit_l84_174_2);
  always @(*) begin
    _zz_when_FpUnit_l91_12 = 7'h0;
    if(when_FpUnit_l84_587) begin
      _zz_when_FpUnit_l91_12 = 7'h0;
    end
    if(when_FpUnit_l84_588) begin
      _zz_when_FpUnit_l91_12 = 7'h01;
    end
    if(when_FpUnit_l84_589) begin
      _zz_when_FpUnit_l91_12 = 7'h02;
    end
    if(when_FpUnit_l84_590) begin
      _zz_when_FpUnit_l91_12 = 7'h03;
    end
    if(when_FpUnit_l84_591) begin
      _zz_when_FpUnit_l91_12 = 7'h04;
    end
    if(when_FpUnit_l84_592) begin
      _zz_when_FpUnit_l91_12 = 7'h05;
    end
    if(when_FpUnit_l84_593) begin
      _zz_when_FpUnit_l91_12 = 7'h06;
    end
    if(when_FpUnit_l84_594) begin
      _zz_when_FpUnit_l91_12 = 7'h07;
    end
    if(when_FpUnit_l84_595) begin
      _zz_when_FpUnit_l91_12 = 7'h08;
    end
    if(when_FpUnit_l84_596) begin
      _zz_when_FpUnit_l91_12 = 7'h09;
    end
    if(when_FpUnit_l84_597) begin
      _zz_when_FpUnit_l91_12 = 7'h0a;
    end
    if(when_FpUnit_l84_598) begin
      _zz_when_FpUnit_l91_12 = 7'h0b;
    end
    if(when_FpUnit_l84_599) begin
      _zz_when_FpUnit_l91_12 = 7'h0c;
    end
    if(when_FpUnit_l84_600) begin
      _zz_when_FpUnit_l91_12 = 7'h0d;
    end
    if(when_FpUnit_l84_601) begin
      _zz_when_FpUnit_l91_12 = 7'h0e;
    end
    if(when_FpUnit_l84_602) begin
      _zz_when_FpUnit_l91_12 = 7'h0f;
    end
    if(when_FpUnit_l84_603) begin
      _zz_when_FpUnit_l91_12 = 7'h10;
    end
    if(when_FpUnit_l84_604) begin
      _zz_when_FpUnit_l91_12 = 7'h11;
    end
    if(when_FpUnit_l84_605) begin
      _zz_when_FpUnit_l91_12 = 7'h12;
    end
    if(when_FpUnit_l84_606) begin
      _zz_when_FpUnit_l91_12 = 7'h13;
    end
    if(when_FpUnit_l84_607) begin
      _zz_when_FpUnit_l91_12 = 7'h14;
    end
    if(when_FpUnit_l84_608) begin
      _zz_when_FpUnit_l91_12 = 7'h15;
    end
    if(when_FpUnit_l84_609) begin
      _zz_when_FpUnit_l91_12 = 7'h16;
    end
    if(when_FpUnit_l84_610) begin
      _zz_when_FpUnit_l91_12 = 7'h17;
    end
    if(when_FpUnit_l84_611) begin
      _zz_when_FpUnit_l91_12 = 7'h18;
    end
    if(when_FpUnit_l84_612) begin
      _zz_when_FpUnit_l91_12 = 7'h19;
    end
    if(when_FpUnit_l84_613) begin
      _zz_when_FpUnit_l91_12 = 7'h1a;
    end
    if(when_FpUnit_l84_614) begin
      _zz_when_FpUnit_l91_12 = 7'h1b;
    end
    if(when_FpUnit_l84_615) begin
      _zz_when_FpUnit_l91_12 = 7'h1c;
    end
    if(when_FpUnit_l84_616) begin
      _zz_when_FpUnit_l91_12 = 7'h1d;
    end
    if(when_FpUnit_l84_617) begin
      _zz_when_FpUnit_l91_12 = 7'h1e;
    end
    if(when_FpUnit_l84_618) begin
      _zz_when_FpUnit_l91_12 = 7'h1f;
    end
    if(when_FpUnit_l84_619) begin
      _zz_when_FpUnit_l91_12 = 7'h20;
    end
    if(when_FpUnit_l84_620) begin
      _zz_when_FpUnit_l91_12 = 7'h21;
    end
    if(when_FpUnit_l84_621) begin
      _zz_when_FpUnit_l91_12 = 7'h22;
    end
    if(when_FpUnit_l84_622) begin
      _zz_when_FpUnit_l91_12 = 7'h23;
    end
    if(when_FpUnit_l84_623) begin
      _zz_when_FpUnit_l91_12 = 7'h24;
    end
    if(when_FpUnit_l84_624) begin
      _zz_when_FpUnit_l91_12 = 7'h25;
    end
    if(when_FpUnit_l84_625) begin
      _zz_when_FpUnit_l91_12 = 7'h26;
    end
    if(when_FpUnit_l84_626) begin
      _zz_when_FpUnit_l91_12 = 7'h27;
    end
    if(when_FpUnit_l84_627) begin
      _zz_when_FpUnit_l91_12 = 7'h28;
    end
    if(when_FpUnit_l84_628) begin
      _zz_when_FpUnit_l91_12 = 7'h29;
    end
    if(when_FpUnit_l84_629) begin
      _zz_when_FpUnit_l91_12 = 7'h2a;
    end
    if(when_FpUnit_l84_630) begin
      _zz_when_FpUnit_l91_12 = 7'h2b;
    end
    if(when_FpUnit_l84_631) begin
      _zz_when_FpUnit_l91_12 = 7'h2c;
    end
    if(when_FpUnit_l84_632) begin
      _zz_when_FpUnit_l91_12 = 7'h2d;
    end
    if(when_FpUnit_l84_633) begin
      _zz_when_FpUnit_l91_12 = 7'h2e;
    end
    if(when_FpUnit_l84_634) begin
      _zz_when_FpUnit_l91_12 = 7'h2f;
    end
    if(when_FpUnit_l84_635) begin
      _zz_when_FpUnit_l91_12 = 7'h30;
    end
    if(when_FpUnit_l84_636) begin
      _zz_when_FpUnit_l91_12 = 7'h31;
    end
    if(when_FpUnit_l84_637) begin
      _zz_when_FpUnit_l91_12 = 7'h32;
    end
    if(when_FpUnit_l84_638) begin
      _zz_when_FpUnit_l91_12 = 7'h33;
    end
    if(when_FpUnit_l84_639) begin
      _zz_when_FpUnit_l91_12 = 7'h34;
    end
    if(when_FpUnit_l84_640) begin
      _zz_when_FpUnit_l91_12 = 7'h35;
    end
    if(when_FpUnit_l84_641) begin
      _zz_when_FpUnit_l91_12 = 7'h36;
    end
    if(when_FpUnit_l84_642) begin
      _zz_when_FpUnit_l91_12 = 7'h37;
    end
    if(when_FpUnit_l84_643) begin
      _zz_when_FpUnit_l91_12 = 7'h38;
    end
    if(when_FpUnit_l84_644) begin
      _zz_when_FpUnit_l91_12 = 7'h39;
    end
    if(when_FpUnit_l84_645) begin
      _zz_when_FpUnit_l91_12 = 7'h3a;
    end
    if(when_FpUnit_l84_646) begin
      _zz_when_FpUnit_l91_12 = 7'h3b;
    end
    if(when_FpUnit_l84_647) begin
      _zz_when_FpUnit_l91_12 = 7'h3c;
    end
    if(when_FpUnit_l84_648) begin
      _zz_when_FpUnit_l91_12 = 7'h3d;
    end
    if(when_FpUnit_l84_649) begin
      _zz_when_FpUnit_l91_12 = 7'h3e;
    end
    if(when_FpUnit_l84_650) begin
      _zz_when_FpUnit_l91_12 = 7'h3f;
    end
    if(when_FpUnit_l84_651) begin
      _zz_when_FpUnit_l91_12 = 7'h40;
    end
    if(when_FpUnit_l84_652) begin
      _zz_when_FpUnit_l91_12 = 7'h41;
    end
    if(when_FpUnit_l84_653) begin
      _zz_when_FpUnit_l91_12 = 7'h42;
    end
    if(when_FpUnit_l84_654) begin
      _zz_when_FpUnit_l91_12 = 7'h43;
    end
    if(when_FpUnit_l84_655) begin
      _zz_when_FpUnit_l91_12 = 7'h44;
    end
    if(when_FpUnit_l84_656) begin
      _zz_when_FpUnit_l91_12 = 7'h45;
    end
    if(when_FpUnit_l84_657) begin
      _zz_when_FpUnit_l91_12 = 7'h46;
    end
    if(when_FpUnit_l84_658) begin
      _zz_when_FpUnit_l91_12 = 7'h47;
    end
    if(when_FpUnit_l84_659) begin
      _zz_when_FpUnit_l91_12 = 7'h48;
    end
    if(when_FpUnit_l84_660) begin
      _zz_when_FpUnit_l91_12 = 7'h49;
    end
    if(when_FpUnit_l84_661) begin
      _zz_when_FpUnit_l91_12 = 7'h4a;
    end
    if(when_FpUnit_l84_662) begin
      _zz_when_FpUnit_l91_12 = 7'h4b;
    end
    if(when_FpUnit_l84_663) begin
      _zz_when_FpUnit_l91_12 = 7'h4c;
    end
    if(when_FpUnit_l84_664) begin
      _zz_when_FpUnit_l91_12 = 7'h4d;
    end
    if(when_FpUnit_l84_665) begin
      _zz_when_FpUnit_l91_12 = 7'h4e;
    end
    if(when_FpUnit_l84_666) begin
      _zz_when_FpUnit_l91_12 = 7'h4f;
    end
    if(when_FpUnit_l84_667) begin
      _zz_when_FpUnit_l91_12 = 7'h50;
    end
    if(when_FpUnit_l84_668) begin
      _zz_when_FpUnit_l91_12 = 7'h51;
    end
    if(when_FpUnit_l84_669) begin
      _zz_when_FpUnit_l91_12 = 7'h52;
    end
    if(when_FpUnit_l84_670) begin
      _zz_when_FpUnit_l91_12 = 7'h53;
    end
    if(when_FpUnit_l84_671) begin
      _zz_when_FpUnit_l91_12 = 7'h54;
    end
    if(when_FpUnit_l84_672) begin
      _zz_when_FpUnit_l91_12 = 7'h55;
    end
    if(when_FpUnit_l84_673) begin
      _zz_when_FpUnit_l91_12 = 7'h56;
    end
    if(when_FpUnit_l84_674) begin
      _zz_when_FpUnit_l91_12 = 7'h57;
    end
  end

  assign when_FpUnit_l84_587 = _zz_when_FpUnit_l84_174[0];
  assign when_FpUnit_l84_588 = _zz_when_FpUnit_l84_174[1];
  assign when_FpUnit_l84_589 = _zz_when_FpUnit_l84_174[2];
  assign when_FpUnit_l84_590 = _zz_when_FpUnit_l84_174[3];
  assign when_FpUnit_l84_591 = _zz_when_FpUnit_l84_174[4];
  assign when_FpUnit_l84_592 = _zz_when_FpUnit_l84_174[5];
  assign when_FpUnit_l84_593 = _zz_when_FpUnit_l84_174[6];
  assign when_FpUnit_l84_594 = _zz_when_FpUnit_l84_174[7];
  assign when_FpUnit_l84_595 = _zz_when_FpUnit_l84_174[8];
  assign when_FpUnit_l84_596 = _zz_when_FpUnit_l84_174[9];
  assign when_FpUnit_l84_597 = _zz_when_FpUnit_l84_174[10];
  assign when_FpUnit_l84_598 = _zz_when_FpUnit_l84_174[11];
  assign when_FpUnit_l84_599 = _zz_when_FpUnit_l84_174[12];
  assign when_FpUnit_l84_600 = _zz_when_FpUnit_l84_174[13];
  assign when_FpUnit_l84_601 = _zz_when_FpUnit_l84_174[14];
  assign when_FpUnit_l84_602 = _zz_when_FpUnit_l84_174[15];
  assign when_FpUnit_l84_603 = _zz_when_FpUnit_l84_174[16];
  assign when_FpUnit_l84_604 = _zz_when_FpUnit_l84_174[17];
  assign when_FpUnit_l84_605 = _zz_when_FpUnit_l84_174[18];
  assign when_FpUnit_l84_606 = _zz_when_FpUnit_l84_174[19];
  assign when_FpUnit_l84_607 = _zz_when_FpUnit_l84_174[20];
  assign when_FpUnit_l84_608 = _zz_when_FpUnit_l84_174[21];
  assign when_FpUnit_l84_609 = _zz_when_FpUnit_l84_174[22];
  assign when_FpUnit_l84_610 = _zz_when_FpUnit_l84_174[23];
  assign when_FpUnit_l84_611 = _zz_when_FpUnit_l84_174[24];
  assign when_FpUnit_l84_612 = _zz_when_FpUnit_l84_174[25];
  assign when_FpUnit_l84_613 = _zz_when_FpUnit_l84_174[26];
  assign when_FpUnit_l84_614 = _zz_when_FpUnit_l84_174[27];
  assign when_FpUnit_l84_615 = _zz_when_FpUnit_l84_174[28];
  assign when_FpUnit_l84_616 = _zz_when_FpUnit_l84_174[29];
  assign when_FpUnit_l84_617 = _zz_when_FpUnit_l84_174[30];
  assign when_FpUnit_l84_618 = _zz_when_FpUnit_l84_174[31];
  assign when_FpUnit_l84_619 = _zz_when_FpUnit_l84_174[32];
  assign when_FpUnit_l84_620 = _zz_when_FpUnit_l84_174[33];
  assign when_FpUnit_l84_621 = _zz_when_FpUnit_l84_174[34];
  assign when_FpUnit_l84_622 = _zz_when_FpUnit_l84_174[35];
  assign when_FpUnit_l84_623 = _zz_when_FpUnit_l84_174[36];
  assign when_FpUnit_l84_624 = _zz_when_FpUnit_l84_174[37];
  assign when_FpUnit_l84_625 = _zz_when_FpUnit_l84_174[38];
  assign when_FpUnit_l84_626 = _zz_when_FpUnit_l84_174[39];
  assign when_FpUnit_l84_627 = _zz_when_FpUnit_l84_174[40];
  assign when_FpUnit_l84_628 = _zz_when_FpUnit_l84_174[41];
  assign when_FpUnit_l84_629 = _zz_when_FpUnit_l84_174[42];
  assign when_FpUnit_l84_630 = _zz_when_FpUnit_l84_174[43];
  assign when_FpUnit_l84_631 = _zz_when_FpUnit_l84_174[44];
  assign when_FpUnit_l84_632 = _zz_when_FpUnit_l84_174[45];
  assign when_FpUnit_l84_633 = _zz_when_FpUnit_l84_174[46];
  assign when_FpUnit_l84_634 = _zz_when_FpUnit_l84_174[47];
  assign when_FpUnit_l84_635 = _zz_when_FpUnit_l84_174[48];
  assign when_FpUnit_l84_636 = _zz_when_FpUnit_l84_174[49];
  assign when_FpUnit_l84_637 = _zz_when_FpUnit_l84_174[50];
  assign when_FpUnit_l84_638 = _zz_when_FpUnit_l84_174[51];
  assign when_FpUnit_l84_639 = _zz_when_FpUnit_l84_174[52];
  assign when_FpUnit_l84_640 = _zz_when_FpUnit_l84_174[53];
  assign when_FpUnit_l84_641 = _zz_when_FpUnit_l84_174[54];
  assign when_FpUnit_l84_642 = _zz_when_FpUnit_l84_174[55];
  assign when_FpUnit_l84_643 = _zz_when_FpUnit_l84_174[56];
  assign when_FpUnit_l84_644 = _zz_when_FpUnit_l84_174[57];
  assign when_FpUnit_l84_645 = _zz_when_FpUnit_l84_174[58];
  assign when_FpUnit_l84_646 = _zz_when_FpUnit_l84_174[59];
  assign when_FpUnit_l84_647 = _zz_when_FpUnit_l84_174[60];
  assign when_FpUnit_l84_648 = _zz_when_FpUnit_l84_174[61];
  assign when_FpUnit_l84_649 = _zz_when_FpUnit_l84_174[62];
  assign when_FpUnit_l84_650 = _zz_when_FpUnit_l84_174[63];
  assign when_FpUnit_l84_651 = _zz_when_FpUnit_l84_174[64];
  assign when_FpUnit_l84_652 = _zz_when_FpUnit_l84_174[65];
  assign when_FpUnit_l84_653 = _zz_when_FpUnit_l84_174[66];
  assign when_FpUnit_l84_654 = _zz_when_FpUnit_l84_174[67];
  assign when_FpUnit_l84_655 = _zz_when_FpUnit_l84_174[68];
  assign when_FpUnit_l84_656 = _zz_when_FpUnit_l84_174[69];
  assign when_FpUnit_l84_657 = _zz_when_FpUnit_l84_174[70];
  assign when_FpUnit_l84_658 = _zz_when_FpUnit_l84_174[71];
  assign when_FpUnit_l84_659 = _zz_when_FpUnit_l84_174[72];
  assign when_FpUnit_l84_660 = _zz_when_FpUnit_l84_174[73];
  assign when_FpUnit_l84_661 = _zz_when_FpUnit_l84_174[74];
  assign when_FpUnit_l84_662 = _zz_when_FpUnit_l84_174[75];
  assign when_FpUnit_l84_663 = _zz_when_FpUnit_l84_174[76];
  assign when_FpUnit_l84_664 = _zz_when_FpUnit_l84_174[77];
  assign when_FpUnit_l84_665 = _zz_when_FpUnit_l84_174[78];
  assign when_FpUnit_l84_666 = _zz_when_FpUnit_l84_174[79];
  assign when_FpUnit_l84_667 = _zz_when_FpUnit_l84_174[80];
  assign when_FpUnit_l84_668 = _zz_when_FpUnit_l84_174[81];
  assign when_FpUnit_l84_669 = _zz_when_FpUnit_l84_174[82];
  assign when_FpUnit_l84_670 = _zz_when_FpUnit_l84_174[83];
  assign when_FpUnit_l84_671 = _zz_when_FpUnit_l84_174[84];
  assign when_FpUnit_l84_672 = _zz_when_FpUnit_l84_174[85];
  assign when_FpUnit_l84_673 = _zz_when_FpUnit_l84_174[86];
  assign when_FpUnit_l84_674 = _zz_when_FpUnit_l84_174[87];
  always @(*) begin
    _zz_flagNX_33 = 27'h0;
    if(when_FpUnit_l90_12) begin
      if(when_FpUnit_l91_12) begin
        _zz_flagNX_33 = _zz__zz_flagNX_33;
      end else begin
        _zz_flagNX_33 = _zz__zz_flagNX_33_2;
      end
    end
  end

  always @(*) begin
    _zz_flagNX_34 = 1'b0;
    if(when_FpUnit_l90_12) begin
      if(when_FpUnit_l91_12) begin
        _zz_flagNX_34 = (|(_zz_when_FpUnit_l84_174 & _zz__zz_flagNX_34));
      end else begin
        _zz_flagNX_34 = 1'b0;
      end
    end
  end

  assign _zz_when_FpUnit_l116_18 = ($signed(_zz__zz_when_FpUnit_l116_18) + $signed(12'h0));
  assign when_FpUnit_l90_12 = (_zz_when_FpUnit_l84_174 != 88'h0);
  assign when_FpUnit_l91_12 = (7'h1a < _zz_when_FpUnit_l91_12);
  assign _zz_flagNX_35 = (_zz_when_FpUnit_l91_12 - 7'h1a);
  assign _zz_when_FpUnit_l116_19 = ($signed(_zz__zz_when_FpUnit_l116_19) < $signed(12'h001));
  assign _zz_when_FpUnit_l116_20 = (_zz_when_FpUnit_l116_19 ? _zz__zz_when_FpUnit_l116_20 : 12'h0);
  assign _zz_when_FpUnit_l119_12 = _zz_when_FpUnit_l116_20;
  assign when_FpUnit_l116_12 = ($signed(_zz_when_FpUnit_l116_20) <= $signed(12'h0));
  always @(*) begin
    if(when_FpUnit_l116_12) begin
      _zz_flagNX_36 = _zz_flagNX_33;
    end else begin
      if(when_FpUnit_l119_12) begin
        _zz_flagNX_36 = 27'h0;
      end else begin
        _zz_flagNX_36 = _zz__zz_flagNX_36;
      end
    end
  end

  always @(*) begin
    if(when_FpUnit_l116_12) begin
      _zz_flagNX_37 = _zz_flagNX_34;
    end else begin
      if(when_FpUnit_l119_12) begin
        _zz_flagNX_37 = ((|_zz_flagNX_33) || _zz_flagNX_34);
      end else begin
        _zz_flagNX_37 = ((|(_zz_flagNX_33 & _zz__zz_flagNX_37)) || _zz_flagNX_34);
      end
    end
  end

  assign when_FpUnit_l119_12 = (12'h01b <= _zz_when_FpUnit_l119_12);
  assign _zz_when_FpUnit_l150_60 = (_zz_when_FpUnit_l116_19 ? 12'hf82 : _zz_when_FpUnit_l116_18);
  assign _zz_flagNX_38 = _zz_flagNX_36[2];
  assign _zz_flagNX_39 = _zz_flagNX_36[1];
  assign _zz_flagNX_40 = (_zz_flagNX_36[0] || _zz_flagNX_37);
  assign _zz_when_FpUnit_l150_61 = _zz_flagNX_36[26 : 3];
  assign _zz_when_FpUnit_l150_62 = (_zz__zz_when_FpUnit_l150_62 + _zz__zz_when_FpUnit_l150_62_2);
  assign _zz_when_FpUnit_l150_63 = _zz_when_FpUnit_l150_62[24];
  assign _zz_res_85 = (_zz_when_FpUnit_l150_63 ? _zz__zz_res_85 : _zz__zz_res_85_1);
  assign _zz_when_FpUnit_l150_64 = ($signed(_zz__zz_when_FpUnit_l150_64) + $signed(12'h07f));
  assign when_FpUnit_l150_12 = ($signed(12'h0ff) <= $signed(_zz_when_FpUnit_l150_64));
  assign _zz_res_86 = {_zz_res_84,{8'hff,23'h0}};
  assign _zz_res_87 = {_zz_res_84,{8'hfe,23'h7fffff}};
  always @(*) begin
    _zz_res_88 = 32'h0;
    if(when_FpUnit_l150_12) begin
      _zz_res_88 = ((io_rm == 3'b001) ? _zz_res_87 : ((io_rm == 3'b010) ? (_zz_res_84 ? _zz_res_86 : _zz_res_87) : ((io_rm == 3'b011) ? (_zz_res_84 ? _zz_res_87 : _zz_res_86) : _zz_res_86)));
    end else begin
      if(when_FpUnit_l154_12) begin
        _zz_res_88 = {_zz_res_84,{8'h0,_zz_res_85[22 : 0]}};
      end else begin
        _zz_res_88 = {_zz_res_84,{_zz__zz_res_88,_zz_res_85[22 : 0]}};
      end
    end
  end

  assign when_FpUnit_l154_12 = ($signed(_zz_when_FpUnit_l150_64) < $signed(12'h001));
  always @(*) begin
    _zz_res_89 = _zz_res_88;
    if(when_FpUnit_l498_3) begin
      _zz_res_89 = {_zz_res_84,{8'h0,23'h0}};
    end
  end

  assign when_FpUnit_l498_3 = (_zz_when_FpUnit_l84_174 == 88'h0);
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
  output reg  [4:0]    io_output_aluOp,
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
  output reg  [31:0]   io_output_imm,
  output reg           io_output_illegal,
  output reg  [1:0]    io_output_csrOp,
  output reg  [11:0]   io_output_csrAddr,
  output reg           io_output_csrImm,
  output reg           io_output_csrWe,
  output reg  [2:0]    io_output_sysOp,
  output reg           io_output_valid
);
  localparam AluOp_ADD = 5'd0;
  localparam AluOp_SUB = 5'd1;
  localparam AluOp_SLL_1 = 5'd2;
  localparam AluOp_SLT = 5'd3;
  localparam AluOp_SLTU = 5'd4;
  localparam AluOp_XOR_1 = 5'd5;
  localparam AluOp_SRL_1 = 5'd6;
  localparam AluOp_SRA_1 = 5'd7;
  localparam AluOp_OR_1 = 5'd8;
  localparam AluOp_AND_1 = 5'd9;
  localparam AluOp_ADDW = 5'd10;
  localparam AluOp_SUBW = 5'd11;
  localparam AluOp_SLLW = 5'd12;
  localparam AluOp_SRLW = 5'd13;
  localparam AluOp_SRAW = 5'd14;
  localparam AluOp_MUL = 5'd15;
  localparam AluOp_MULH = 5'd16;
  localparam AluOp_MULHSU = 5'd17;
  localparam AluOp_MULHU = 5'd18;
  localparam AluOp_DIV = 5'd19;
  localparam AluOp_DIVU = 5'd20;
  localparam AluOp_REM_1 = 5'd21;
  localparam AluOp_REMU = 5'd22;
  localparam AluOp_MULW = 5'd23;
  localparam AluOp_DIVW = 5'd24;
  localparam AluOp_DIVUW = 5'd25;
  localparam AluOp_REMW = 5'd26;
  localparam AluOp_REMUW = 5'd27;
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
  wire                when_Decoder_l151;
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
  wire       [1:0]    switch_Decoder_l188;
  wire                when_Decoder_l192;
  wire                when_Decoder_l255;
  wire                when_Decoder_l260;
  wire       [1:0]    switch_Decoder_l270;
  wire                when_Decoder_l276;
  wire                when_Decoder_l287;
  wire                when_Decoder_l298;
  wire       [4:0]    _zz_io_output_aluOp;
  wire       [4:0]    _zz_io_output_aluOp_1;
  wire       [4:0]    _zz_io_output_aluOp_2;
  wire                when_Decoder_l345;
  wire                when_Decoder_l352;
  wire                when_Decoder_l370;
  wire                when_Decoder_l371;
  wire                when_Decoder_l372;
  wire                when_Decoder_l383;
  wire                when_Decoder_l384;
  wire                when_Decoder_l540;
  wire                when_Decoder_l586;
  wire                when_Decoder_l632;
  wire                when_Decoder_l641;
  wire                when_Decoder_l650;
  wire                when_Decoder_l659;
  wire       [4:0]    _zz_io_output_aluOp_3;
  wire                when_Decoder_l770;
  wire       [4:0]    _zz_io_output_aluOp_4;
  wire       [4:0]    _zz_io_output_aluOp_5;
  wire       [11:0]   switch_Decoder_l852;
  `ifndef SYNTHESIS
  reg [47:0] io_output_aluOp_string;
  reg [31:0] io_output_branchType_string;
  reg [39:0] io_output_csrOp_string;
  reg [55:0] io_output_sysOp_string;
  reg [47:0] _zz_io_output_aluOp_string;
  reg [47:0] _zz_io_output_aluOp_1_string;
  reg [47:0] _zz_io_output_aluOp_2_string;
  reg [47:0] _zz_io_output_aluOp_3_string;
  reg [47:0] _zz_io_output_aluOp_4_string;
  reg [47:0] _zz_io_output_aluOp_5_string;
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
      AluOp_ADD : io_output_aluOp_string = "ADD   ";
      AluOp_SUB : io_output_aluOp_string = "SUB   ";
      AluOp_SLL_1 : io_output_aluOp_string = "SLL_1 ";
      AluOp_SLT : io_output_aluOp_string = "SLT   ";
      AluOp_SLTU : io_output_aluOp_string = "SLTU  ";
      AluOp_XOR_1 : io_output_aluOp_string = "XOR_1 ";
      AluOp_SRL_1 : io_output_aluOp_string = "SRL_1 ";
      AluOp_SRA_1 : io_output_aluOp_string = "SRA_1 ";
      AluOp_OR_1 : io_output_aluOp_string = "OR_1  ";
      AluOp_AND_1 : io_output_aluOp_string = "AND_1 ";
      AluOp_ADDW : io_output_aluOp_string = "ADDW  ";
      AluOp_SUBW : io_output_aluOp_string = "SUBW  ";
      AluOp_SLLW : io_output_aluOp_string = "SLLW  ";
      AluOp_SRLW : io_output_aluOp_string = "SRLW  ";
      AluOp_SRAW : io_output_aluOp_string = "SRAW  ";
      AluOp_MUL : io_output_aluOp_string = "MUL   ";
      AluOp_MULH : io_output_aluOp_string = "MULH  ";
      AluOp_MULHSU : io_output_aluOp_string = "MULHSU";
      AluOp_MULHU : io_output_aluOp_string = "MULHU ";
      AluOp_DIV : io_output_aluOp_string = "DIV   ";
      AluOp_DIVU : io_output_aluOp_string = "DIVU  ";
      AluOp_REM_1 : io_output_aluOp_string = "REM_1 ";
      AluOp_REMU : io_output_aluOp_string = "REMU  ";
      AluOp_MULW : io_output_aluOp_string = "MULW  ";
      AluOp_DIVW : io_output_aluOp_string = "DIVW  ";
      AluOp_DIVUW : io_output_aluOp_string = "DIVUW ";
      AluOp_REMW : io_output_aluOp_string = "REMW  ";
      AluOp_REMUW : io_output_aluOp_string = "REMUW ";
      default : io_output_aluOp_string = "??????";
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
      AluOp_ADD : _zz_io_output_aluOp_string = "ADD   ";
      AluOp_SUB : _zz_io_output_aluOp_string = "SUB   ";
      AluOp_SLL_1 : _zz_io_output_aluOp_string = "SLL_1 ";
      AluOp_SLT : _zz_io_output_aluOp_string = "SLT   ";
      AluOp_SLTU : _zz_io_output_aluOp_string = "SLTU  ";
      AluOp_XOR_1 : _zz_io_output_aluOp_string = "XOR_1 ";
      AluOp_SRL_1 : _zz_io_output_aluOp_string = "SRL_1 ";
      AluOp_SRA_1 : _zz_io_output_aluOp_string = "SRA_1 ";
      AluOp_OR_1 : _zz_io_output_aluOp_string = "OR_1  ";
      AluOp_AND_1 : _zz_io_output_aluOp_string = "AND_1 ";
      AluOp_ADDW : _zz_io_output_aluOp_string = "ADDW  ";
      AluOp_SUBW : _zz_io_output_aluOp_string = "SUBW  ";
      AluOp_SLLW : _zz_io_output_aluOp_string = "SLLW  ";
      AluOp_SRLW : _zz_io_output_aluOp_string = "SRLW  ";
      AluOp_SRAW : _zz_io_output_aluOp_string = "SRAW  ";
      AluOp_MUL : _zz_io_output_aluOp_string = "MUL   ";
      AluOp_MULH : _zz_io_output_aluOp_string = "MULH  ";
      AluOp_MULHSU : _zz_io_output_aluOp_string = "MULHSU";
      AluOp_MULHU : _zz_io_output_aluOp_string = "MULHU ";
      AluOp_DIV : _zz_io_output_aluOp_string = "DIV   ";
      AluOp_DIVU : _zz_io_output_aluOp_string = "DIVU  ";
      AluOp_REM_1 : _zz_io_output_aluOp_string = "REM_1 ";
      AluOp_REMU : _zz_io_output_aluOp_string = "REMU  ";
      AluOp_MULW : _zz_io_output_aluOp_string = "MULW  ";
      AluOp_DIVW : _zz_io_output_aluOp_string = "DIVW  ";
      AluOp_DIVUW : _zz_io_output_aluOp_string = "DIVUW ";
      AluOp_REMW : _zz_io_output_aluOp_string = "REMW  ";
      AluOp_REMUW : _zz_io_output_aluOp_string = "REMUW ";
      default : _zz_io_output_aluOp_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_aluOp_1)
      AluOp_ADD : _zz_io_output_aluOp_1_string = "ADD   ";
      AluOp_SUB : _zz_io_output_aluOp_1_string = "SUB   ";
      AluOp_SLL_1 : _zz_io_output_aluOp_1_string = "SLL_1 ";
      AluOp_SLT : _zz_io_output_aluOp_1_string = "SLT   ";
      AluOp_SLTU : _zz_io_output_aluOp_1_string = "SLTU  ";
      AluOp_XOR_1 : _zz_io_output_aluOp_1_string = "XOR_1 ";
      AluOp_SRL_1 : _zz_io_output_aluOp_1_string = "SRL_1 ";
      AluOp_SRA_1 : _zz_io_output_aluOp_1_string = "SRA_1 ";
      AluOp_OR_1 : _zz_io_output_aluOp_1_string = "OR_1  ";
      AluOp_AND_1 : _zz_io_output_aluOp_1_string = "AND_1 ";
      AluOp_ADDW : _zz_io_output_aluOp_1_string = "ADDW  ";
      AluOp_SUBW : _zz_io_output_aluOp_1_string = "SUBW  ";
      AluOp_SLLW : _zz_io_output_aluOp_1_string = "SLLW  ";
      AluOp_SRLW : _zz_io_output_aluOp_1_string = "SRLW  ";
      AluOp_SRAW : _zz_io_output_aluOp_1_string = "SRAW  ";
      AluOp_MUL : _zz_io_output_aluOp_1_string = "MUL   ";
      AluOp_MULH : _zz_io_output_aluOp_1_string = "MULH  ";
      AluOp_MULHSU : _zz_io_output_aluOp_1_string = "MULHSU";
      AluOp_MULHU : _zz_io_output_aluOp_1_string = "MULHU ";
      AluOp_DIV : _zz_io_output_aluOp_1_string = "DIV   ";
      AluOp_DIVU : _zz_io_output_aluOp_1_string = "DIVU  ";
      AluOp_REM_1 : _zz_io_output_aluOp_1_string = "REM_1 ";
      AluOp_REMU : _zz_io_output_aluOp_1_string = "REMU  ";
      AluOp_MULW : _zz_io_output_aluOp_1_string = "MULW  ";
      AluOp_DIVW : _zz_io_output_aluOp_1_string = "DIVW  ";
      AluOp_DIVUW : _zz_io_output_aluOp_1_string = "DIVUW ";
      AluOp_REMW : _zz_io_output_aluOp_1_string = "REMW  ";
      AluOp_REMUW : _zz_io_output_aluOp_1_string = "REMUW ";
      default : _zz_io_output_aluOp_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_aluOp_2)
      AluOp_ADD : _zz_io_output_aluOp_2_string = "ADD   ";
      AluOp_SUB : _zz_io_output_aluOp_2_string = "SUB   ";
      AluOp_SLL_1 : _zz_io_output_aluOp_2_string = "SLL_1 ";
      AluOp_SLT : _zz_io_output_aluOp_2_string = "SLT   ";
      AluOp_SLTU : _zz_io_output_aluOp_2_string = "SLTU  ";
      AluOp_XOR_1 : _zz_io_output_aluOp_2_string = "XOR_1 ";
      AluOp_SRL_1 : _zz_io_output_aluOp_2_string = "SRL_1 ";
      AluOp_SRA_1 : _zz_io_output_aluOp_2_string = "SRA_1 ";
      AluOp_OR_1 : _zz_io_output_aluOp_2_string = "OR_1  ";
      AluOp_AND_1 : _zz_io_output_aluOp_2_string = "AND_1 ";
      AluOp_ADDW : _zz_io_output_aluOp_2_string = "ADDW  ";
      AluOp_SUBW : _zz_io_output_aluOp_2_string = "SUBW  ";
      AluOp_SLLW : _zz_io_output_aluOp_2_string = "SLLW  ";
      AluOp_SRLW : _zz_io_output_aluOp_2_string = "SRLW  ";
      AluOp_SRAW : _zz_io_output_aluOp_2_string = "SRAW  ";
      AluOp_MUL : _zz_io_output_aluOp_2_string = "MUL   ";
      AluOp_MULH : _zz_io_output_aluOp_2_string = "MULH  ";
      AluOp_MULHSU : _zz_io_output_aluOp_2_string = "MULHSU";
      AluOp_MULHU : _zz_io_output_aluOp_2_string = "MULHU ";
      AluOp_DIV : _zz_io_output_aluOp_2_string = "DIV   ";
      AluOp_DIVU : _zz_io_output_aluOp_2_string = "DIVU  ";
      AluOp_REM_1 : _zz_io_output_aluOp_2_string = "REM_1 ";
      AluOp_REMU : _zz_io_output_aluOp_2_string = "REMU  ";
      AluOp_MULW : _zz_io_output_aluOp_2_string = "MULW  ";
      AluOp_DIVW : _zz_io_output_aluOp_2_string = "DIVW  ";
      AluOp_DIVUW : _zz_io_output_aluOp_2_string = "DIVUW ";
      AluOp_REMW : _zz_io_output_aluOp_2_string = "REMW  ";
      AluOp_REMUW : _zz_io_output_aluOp_2_string = "REMUW ";
      default : _zz_io_output_aluOp_2_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_aluOp_3)
      AluOp_ADD : _zz_io_output_aluOp_3_string = "ADD   ";
      AluOp_SUB : _zz_io_output_aluOp_3_string = "SUB   ";
      AluOp_SLL_1 : _zz_io_output_aluOp_3_string = "SLL_1 ";
      AluOp_SLT : _zz_io_output_aluOp_3_string = "SLT   ";
      AluOp_SLTU : _zz_io_output_aluOp_3_string = "SLTU  ";
      AluOp_XOR_1 : _zz_io_output_aluOp_3_string = "XOR_1 ";
      AluOp_SRL_1 : _zz_io_output_aluOp_3_string = "SRL_1 ";
      AluOp_SRA_1 : _zz_io_output_aluOp_3_string = "SRA_1 ";
      AluOp_OR_1 : _zz_io_output_aluOp_3_string = "OR_1  ";
      AluOp_AND_1 : _zz_io_output_aluOp_3_string = "AND_1 ";
      AluOp_ADDW : _zz_io_output_aluOp_3_string = "ADDW  ";
      AluOp_SUBW : _zz_io_output_aluOp_3_string = "SUBW  ";
      AluOp_SLLW : _zz_io_output_aluOp_3_string = "SLLW  ";
      AluOp_SRLW : _zz_io_output_aluOp_3_string = "SRLW  ";
      AluOp_SRAW : _zz_io_output_aluOp_3_string = "SRAW  ";
      AluOp_MUL : _zz_io_output_aluOp_3_string = "MUL   ";
      AluOp_MULH : _zz_io_output_aluOp_3_string = "MULH  ";
      AluOp_MULHSU : _zz_io_output_aluOp_3_string = "MULHSU";
      AluOp_MULHU : _zz_io_output_aluOp_3_string = "MULHU ";
      AluOp_DIV : _zz_io_output_aluOp_3_string = "DIV   ";
      AluOp_DIVU : _zz_io_output_aluOp_3_string = "DIVU  ";
      AluOp_REM_1 : _zz_io_output_aluOp_3_string = "REM_1 ";
      AluOp_REMU : _zz_io_output_aluOp_3_string = "REMU  ";
      AluOp_MULW : _zz_io_output_aluOp_3_string = "MULW  ";
      AluOp_DIVW : _zz_io_output_aluOp_3_string = "DIVW  ";
      AluOp_DIVUW : _zz_io_output_aluOp_3_string = "DIVUW ";
      AluOp_REMW : _zz_io_output_aluOp_3_string = "REMW  ";
      AluOp_REMUW : _zz_io_output_aluOp_3_string = "REMUW ";
      default : _zz_io_output_aluOp_3_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_aluOp_4)
      AluOp_ADD : _zz_io_output_aluOp_4_string = "ADD   ";
      AluOp_SUB : _zz_io_output_aluOp_4_string = "SUB   ";
      AluOp_SLL_1 : _zz_io_output_aluOp_4_string = "SLL_1 ";
      AluOp_SLT : _zz_io_output_aluOp_4_string = "SLT   ";
      AluOp_SLTU : _zz_io_output_aluOp_4_string = "SLTU  ";
      AluOp_XOR_1 : _zz_io_output_aluOp_4_string = "XOR_1 ";
      AluOp_SRL_1 : _zz_io_output_aluOp_4_string = "SRL_1 ";
      AluOp_SRA_1 : _zz_io_output_aluOp_4_string = "SRA_1 ";
      AluOp_OR_1 : _zz_io_output_aluOp_4_string = "OR_1  ";
      AluOp_AND_1 : _zz_io_output_aluOp_4_string = "AND_1 ";
      AluOp_ADDW : _zz_io_output_aluOp_4_string = "ADDW  ";
      AluOp_SUBW : _zz_io_output_aluOp_4_string = "SUBW  ";
      AluOp_SLLW : _zz_io_output_aluOp_4_string = "SLLW  ";
      AluOp_SRLW : _zz_io_output_aluOp_4_string = "SRLW  ";
      AluOp_SRAW : _zz_io_output_aluOp_4_string = "SRAW  ";
      AluOp_MUL : _zz_io_output_aluOp_4_string = "MUL   ";
      AluOp_MULH : _zz_io_output_aluOp_4_string = "MULH  ";
      AluOp_MULHSU : _zz_io_output_aluOp_4_string = "MULHSU";
      AluOp_MULHU : _zz_io_output_aluOp_4_string = "MULHU ";
      AluOp_DIV : _zz_io_output_aluOp_4_string = "DIV   ";
      AluOp_DIVU : _zz_io_output_aluOp_4_string = "DIVU  ";
      AluOp_REM_1 : _zz_io_output_aluOp_4_string = "REM_1 ";
      AluOp_REMU : _zz_io_output_aluOp_4_string = "REMU  ";
      AluOp_MULW : _zz_io_output_aluOp_4_string = "MULW  ";
      AluOp_DIVW : _zz_io_output_aluOp_4_string = "DIVW  ";
      AluOp_DIVUW : _zz_io_output_aluOp_4_string = "DIVUW ";
      AluOp_REMW : _zz_io_output_aluOp_4_string = "REMW  ";
      AluOp_REMUW : _zz_io_output_aluOp_4_string = "REMUW ";
      default : _zz_io_output_aluOp_4_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_io_output_aluOp_5)
      AluOp_ADD : _zz_io_output_aluOp_5_string = "ADD   ";
      AluOp_SUB : _zz_io_output_aluOp_5_string = "SUB   ";
      AluOp_SLL_1 : _zz_io_output_aluOp_5_string = "SLL_1 ";
      AluOp_SLT : _zz_io_output_aluOp_5_string = "SLT   ";
      AluOp_SLTU : _zz_io_output_aluOp_5_string = "SLTU  ";
      AluOp_XOR_1 : _zz_io_output_aluOp_5_string = "XOR_1 ";
      AluOp_SRL_1 : _zz_io_output_aluOp_5_string = "SRL_1 ";
      AluOp_SRA_1 : _zz_io_output_aluOp_5_string = "SRA_1 ";
      AluOp_OR_1 : _zz_io_output_aluOp_5_string = "OR_1  ";
      AluOp_AND_1 : _zz_io_output_aluOp_5_string = "AND_1 ";
      AluOp_ADDW : _zz_io_output_aluOp_5_string = "ADDW  ";
      AluOp_SUBW : _zz_io_output_aluOp_5_string = "SUBW  ";
      AluOp_SLLW : _zz_io_output_aluOp_5_string = "SLLW  ";
      AluOp_SRLW : _zz_io_output_aluOp_5_string = "SRLW  ";
      AluOp_SRAW : _zz_io_output_aluOp_5_string = "SRAW  ";
      AluOp_MUL : _zz_io_output_aluOp_5_string = "MUL   ";
      AluOp_MULH : _zz_io_output_aluOp_5_string = "MULH  ";
      AluOp_MULHSU : _zz_io_output_aluOp_5_string = "MULHSU";
      AluOp_MULHU : _zz_io_output_aluOp_5_string = "MULHU ";
      AluOp_DIV : _zz_io_output_aluOp_5_string = "DIV   ";
      AluOp_DIVU : _zz_io_output_aluOp_5_string = "DIVU  ";
      AluOp_REM_1 : _zz_io_output_aluOp_5_string = "REM_1 ";
      AluOp_REMU : _zz_io_output_aluOp_5_string = "REMU  ";
      AluOp_MULW : _zz_io_output_aluOp_5_string = "MULW  ";
      AluOp_DIVW : _zz_io_output_aluOp_5_string = "DIVW  ";
      AluOp_DIVUW : _zz_io_output_aluOp_5_string = "DIVUW ";
      AluOp_REMW : _zz_io_output_aluOp_5_string = "REMW  ";
      AluOp_REMUW : _zz_io_output_aluOp_5_string = "REMUW ";
      default : _zz_io_output_aluOp_5_string = "??????";
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
      case(switch_Decoder_l188)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l192) begin
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
              if(when_Decoder_l255) begin
                io_output_regWrite = 1'b1;
              end else begin
                if(!when_Decoder_l260) begin
                  io_output_regWrite = 1'b1;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l270)
                2'b00 : begin
                  if(!when_Decoder_l276) begin
                    io_output_regWrite = 1'b1;
                  end
                end
                2'b01 : begin
                  if(!when_Decoder_l287) begin
                    io_output_regWrite = 1'b1;
                  end
                end
                2'b10 : begin
                  io_output_regWrite = 1'b1;
                end
                default : begin
                  if(!when_Decoder_l298) begin
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
              if(!when_Decoder_l345) begin
                io_output_regWrite = 1'b1;
              end
            end
            3'b010 : begin
              if(!when_Decoder_l352) begin
                io_output_regWrite = 1'b1;
              end
            end
            3'b011 : begin
            end
            3'b100 : begin
              if(when_Decoder_l370) begin
                if(!when_Decoder_l371) begin
                  io_output_regWrite = 1'b1;
                end
              end else begin
                if(when_Decoder_l383) begin
                  if(!when_Decoder_l384) begin
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
        end
        7'b0111011 : begin
        end
        7'b0110011 : begin
          if(!when_Decoder_l770) begin
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
      case(switch_Decoder_l188)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l192) begin
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
              if(when_Decoder_l255) begin
                io_output_aluSrc = 1'b1;
              end else begin
                if(!when_Decoder_l260) begin
                  io_output_aluSrc = 1'b1;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l270)
                2'b00 : begin
                  if(!when_Decoder_l276) begin
                    io_output_aluSrc = 1'b1;
                  end
                end
                2'b01 : begin
                  if(!when_Decoder_l287) begin
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
              if(!when_Decoder_l345) begin
                io_output_aluSrc = 1'b1;
              end
            end
            3'b010 : begin
              if(!when_Decoder_l352) begin
                io_output_aluSrc = 1'b1;
              end
            end
            3'b011 : begin
            end
            3'b100 : begin
              if(when_Decoder_l370) begin
                if(when_Decoder_l371) begin
                  if(!when_Decoder_l372) begin
                    io_output_aluSrc = 1'b1;
                  end
                end
              end else begin
                if(when_Decoder_l383) begin
                  if(!when_Decoder_l384) begin
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
      case(switch_Decoder_l188)
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
              if(!when_Decoder_l352) begin
                io_output_wbSel = 3'b001;
              end
            end
            3'b011 : begin
            end
            3'b100 : begin
              if(when_Decoder_l370) begin
                if(when_Decoder_l371) begin
                  if(!when_Decoder_l372) begin
                    io_output_wbSel = 3'b010;
                  end
                end
              end else begin
                if(when_Decoder_l383) begin
                  if(!when_Decoder_l384) begin
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
      case(switch_Decoder_l188)
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
      case(switch_Decoder_l188)
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
              if(when_Decoder_l370) begin
                if(when_Decoder_l371) begin
                  if(!when_Decoder_l372) begin
                    io_output_jump = 1'b1;
                  end
                end
              end else begin
                if(when_Decoder_l383) begin
                  if(!when_Decoder_l384) begin
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
      case(switch_Decoder_l188)
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
              if(when_Decoder_l370) begin
                if(when_Decoder_l371) begin
                  if(!when_Decoder_l372) begin
                    io_output_jalr = 1'b1;
                  end
                end
              end else begin
                if(when_Decoder_l383) begin
                  if(!when_Decoder_l384) begin
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
      case(switch_Decoder_l188)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l192) begin
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
              if(when_Decoder_l255) begin
                io_output_aluOp = AluOp_ADD;
              end else begin
                if(!when_Decoder_l260) begin
                  io_output_aluOp = AluOp_ADD;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l270)
                2'b00 : begin
                  if(!when_Decoder_l276) begin
                    io_output_aluOp = AluOp_SRL_1;
                  end
                end
                2'b01 : begin
                  if(!when_Decoder_l287) begin
                    io_output_aluOp = AluOp_SRA_1;
                  end
                end
                2'b10 : begin
                  io_output_aluOp = AluOp_AND_1;
                end
                default : begin
                  if(!when_Decoder_l298) begin
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
              if(!when_Decoder_l345) begin
                io_output_aluOp = AluOp_SLL_1;
              end
            end
            3'b010 : begin
              if(!when_Decoder_l352) begin
                io_output_aluOp = AluOp_ADD;
              end
            end
            3'b011 : begin
            end
            3'b100 : begin
              if(when_Decoder_l370) begin
                if(!when_Decoder_l371) begin
                  io_output_aluOp = AluOp_ADD;
                end
              end else begin
                if(!when_Decoder_l383) begin
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
          if(!when_Decoder_l770) begin
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
      case(switch_Decoder_l188)
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
      case(switch_Decoder_l188)
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
              if(!when_Decoder_l255) begin
                if(!when_Decoder_l260) begin
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
              if(when_Decoder_l370) begin
                if(!when_Decoder_l371) begin
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
      case(switch_Decoder_l188)
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
              if(!when_Decoder_l352) begin
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
      case(switch_Decoder_l188)
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
      case(switch_Decoder_l188)
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
              if(!when_Decoder_l352) begin
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
                end
                default : begin
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
                end
                default : begin
                end
              endcase
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
      case(switch_Decoder_l188)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l192) begin
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
              if(when_Decoder_l255) begin
                io_output_rs1 = 5'h02;
              end
            end
            3'b100 : begin
              case(switch_Decoder_l270)
                2'b00 : begin
                  if(!when_Decoder_l276) begin
                    io_output_rs1 = crs1p;
                  end
                end
                2'b01 : begin
                  if(!when_Decoder_l287) begin
                    io_output_rs1 = crs1p;
                  end
                end
                2'b10 : begin
                  io_output_rs1 = crs1p;
                end
                default : begin
                  if(!when_Decoder_l298) begin
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
              if(!when_Decoder_l345) begin
                io_output_rs1 = crd;
              end
            end
            3'b010 : begin
              if(!when_Decoder_l352) begin
                io_output_rs1 = 5'h02;
              end
            end
            3'b011 : begin
            end
            3'b100 : begin
              if(when_Decoder_l370) begin
                if(when_Decoder_l371) begin
                  if(!when_Decoder_l372) begin
                    io_output_rs1 = crd;
                  end
                end
              end else begin
                if(when_Decoder_l383) begin
                  if(!when_Decoder_l384) begin
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
      case(switch_Decoder_l188)
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
              case(switch_Decoder_l270)
                2'b00 : begin
                end
                2'b01 : begin
                end
                2'b10 : begin
                end
                default : begin
                  if(!when_Decoder_l298) begin
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
              if(when_Decoder_l370) begin
                if(!when_Decoder_l371) begin
                  io_output_rs2 = crs2;
                end
              end else begin
                if(!when_Decoder_l383) begin
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
      case(switch_Decoder_l188)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l192) begin
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
              if(when_Decoder_l255) begin
                io_output_rd = 5'h02;
              end else begin
                if(!when_Decoder_l260) begin
                  io_output_rd = crd;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l270)
                2'b00 : begin
                  if(!when_Decoder_l276) begin
                    io_output_rd = crs1p;
                  end
                end
                2'b01 : begin
                  if(!when_Decoder_l287) begin
                    io_output_rd = crs1p;
                  end
                end
                2'b10 : begin
                  io_output_rd = crs1p;
                end
                default : begin
                  if(!when_Decoder_l298) begin
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
              if(!when_Decoder_l345) begin
                io_output_rd = crd;
              end
            end
            3'b010 : begin
              if(!when_Decoder_l352) begin
                io_output_rd = crd;
              end
            end
            3'b011 : begin
            end
            3'b100 : begin
              if(when_Decoder_l370) begin
                if(!when_Decoder_l371) begin
                  io_output_rd = crd;
                end
              end else begin
                if(when_Decoder_l383) begin
                  if(!when_Decoder_l384) begin
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
      case(switch_Decoder_l188)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l192) begin
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
              if(when_Decoder_l255) begin
                io_output_imm = {{22{cAddi16sp[9]}}, cAddi16sp};
              end else begin
                if(!when_Decoder_l260) begin
                  io_output_imm = {{14{_zz_io_output_imm_3[17]}}, _zz_io_output_imm_3};
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l270)
                2'b00 : begin
                  if(!when_Decoder_l276) begin
                    io_output_imm = cShamt;
                  end
                end
                2'b01 : begin
                  if(!when_Decoder_l287) begin
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
              if(!when_Decoder_l345) begin
                io_output_imm = cShamt;
              end
            end
            3'b010 : begin
              if(!when_Decoder_l352) begin
                io_output_imm = _zz_io_output_imm_4;
              end
            end
            3'b011 : begin
            end
            3'b100 : begin
              if(when_Decoder_l370) begin
                if(when_Decoder_l371) begin
                  if(!when_Decoder_l372) begin
                    io_output_imm = 32'h0;
                  end
                end
              end else begin
                if(when_Decoder_l383) begin
                  if(!when_Decoder_l384) begin
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
      case(switch_Decoder_l188)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(when_Decoder_l192) begin
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
              if(!when_Decoder_l255) begin
                if(when_Decoder_l260) begin
                  io_output_illegal = 1'b1;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l270)
                2'b00 : begin
                  if(when_Decoder_l276) begin
                    io_output_illegal = 1'b1;
                  end
                end
                2'b01 : begin
                  if(when_Decoder_l287) begin
                    io_output_illegal = 1'b1;
                  end
                end
                2'b10 : begin
                end
                default : begin
                  if(when_Decoder_l298) begin
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
              if(when_Decoder_l345) begin
                io_output_illegal = 1'b1;
              end
            end
            3'b010 : begin
              if(when_Decoder_l352) begin
                io_output_illegal = 1'b1;
              end
            end
            3'b011 : begin
              io_output_illegal = 1'b1;
            end
            3'b100 : begin
              if(when_Decoder_l370) begin
                if(when_Decoder_l371) begin
                  if(when_Decoder_l372) begin
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
          if(when_Decoder_l540) begin
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
              if(when_Decoder_l586) begin
                io_output_illegal = 1'b1;
              end
            end
            6'h30 : begin
              case(convSel)
                2'b00 : begin
                end
                2'b01 : begin
                end
                2'b10 : begin
                  io_output_illegal = 1'b1;
                end
                default : begin
                  io_output_illegal = 1'b1;
                end
              endcase
            end
            6'h34 : begin
              case(convSel)
                2'b00 : begin
                end
                2'b01 : begin
                end
                2'b10 : begin
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
        end
        7'b1000011 : begin
          if(when_Decoder_l632) begin
            io_output_illegal = 1'b1;
          end
        end
        7'b1000111 : begin
          if(when_Decoder_l641) begin
            io_output_illegal = 1'b1;
          end
        end
        7'b1001011 : begin
          if(when_Decoder_l650) begin
            io_output_illegal = 1'b1;
          end
        end
        7'b1001111 : begin
          if(when_Decoder_l659) begin
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
          io_output_illegal = 1'b1;
        end
        7'b0111011 : begin
          io_output_illegal = 1'b1;
        end
        7'b0110011 : begin
          if(when_Decoder_l770) begin
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
      case(switch_Decoder_l188)
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
              if(!when_Decoder_l370) begin
                if(when_Decoder_l383) begin
                  if(when_Decoder_l384) begin
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
              casez(switch_Decoder_l852)
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
      case(switch_Decoder_l188)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(when_Decoder_l192) begin
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
              if(!when_Decoder_l255) begin
                if(when_Decoder_l260) begin
                  io_output_valid = 1'b0;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l270)
                2'b00 : begin
                  if(when_Decoder_l276) begin
                    io_output_valid = 1'b0;
                  end
                end
                2'b01 : begin
                  if(when_Decoder_l287) begin
                    io_output_valid = 1'b0;
                  end
                end
                2'b10 : begin
                end
                default : begin
                  if(when_Decoder_l298) begin
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
              if(when_Decoder_l345) begin
                io_output_valid = 1'b0;
              end
            end
            3'b010 : begin
              if(when_Decoder_l352) begin
                io_output_valid = 1'b0;
              end
            end
            3'b011 : begin
              io_output_valid = 1'b0;
            end
            3'b100 : begin
              if(when_Decoder_l370) begin
                if(when_Decoder_l371) begin
                  if(when_Decoder_l372) begin
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
          if(when_Decoder_l540) begin
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
              if(when_Decoder_l586) begin
                io_output_valid = 1'b0;
              end
            end
            6'h30 : begin
              case(convSel)
                2'b00 : begin
                end
                2'b01 : begin
                end
                2'b10 : begin
                  io_output_valid = 1'b0;
                end
                default : begin
                  io_output_valid = 1'b0;
                end
              endcase
            end
            6'h34 : begin
              case(convSel)
                2'b00 : begin
                end
                2'b01 : begin
                end
                2'b10 : begin
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
        end
        7'b1000011 : begin
          if(when_Decoder_l632) begin
            io_output_valid = 1'b0;
          end
        end
        7'b1000111 : begin
          if(when_Decoder_l641) begin
            io_output_valid = 1'b0;
          end
        end
        7'b1001011 : begin
          if(when_Decoder_l650) begin
            io_output_valid = 1'b0;
          end
        end
        7'b1001111 : begin
          if(when_Decoder_l659) begin
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
          io_output_valid = 1'b0;
        end
        7'b0111011 : begin
          io_output_valid = 1'b0;
        end
        7'b0110011 : begin
          if(when_Decoder_l770) begin
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
              casez(switch_Decoder_l852)
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

  assign when_Decoder_l151 = (io_output_csrOp == CsrOp_WRITE);
  always @(*) begin
    if(when_Decoder_l151) begin
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
  assign switch_Decoder_l188 = io_instruction[1 : 0];
  assign when_Decoder_l192 = (cAddi4spn == 10'h0);
  assign when_Decoder_l255 = (crd == 5'h02);
  assign when_Decoder_l260 = ((crd == 5'h0) || (c6 == 6'h0));
  assign switch_Decoder_l270 = io_instruction[11 : 10];
  assign when_Decoder_l276 = io_instruction[12];
  assign when_Decoder_l287 = io_instruction[12];
  assign when_Decoder_l298 = io_instruction[12];
  assign _zz_io_output_aluOp = (io_instruction[5] ? AluOp_AND_1 : AluOp_OR_1);
  assign _zz_io_output_aluOp_1 = (io_instruction[5] ? AluOp_XOR_1 : AluOp_SUB);
  assign _zz_io_output_aluOp_2 = (io_instruction[6] ? _zz_io_output_aluOp : _zz_io_output_aluOp_1);
  assign when_Decoder_l345 = io_instruction[12];
  assign when_Decoder_l352 = (crd == 5'h0);
  assign when_Decoder_l370 = (io_instruction[12] == 1'b0);
  assign when_Decoder_l371 = (crs2 == 5'h0);
  assign when_Decoder_l372 = (crd == 5'h0);
  assign when_Decoder_l383 = (crs2 == 5'h0);
  assign when_Decoder_l384 = (crd == 5'h0);
  assign when_Decoder_l540 = io_instruction[25];
  assign when_Decoder_l586 = (funct3 != 3'b000);
  assign when_Decoder_l632 = io_instruction[25];
  assign when_Decoder_l641 = io_instruction[25];
  assign when_Decoder_l650 = io_instruction[25];
  assign when_Decoder_l659 = io_instruction[25];
  assign _zz_io_output_aluOp_3 = (io_instruction[30] ? AluOp_SRA_1 : AluOp_SRL_1);
  assign when_Decoder_l770 = ((funct7 & 7'h7f) == 7'h01);
  assign _zz_io_output_aluOp_4 = (io_instruction[30] ? AluOp_SUB : AluOp_ADD);
  assign _zz_io_output_aluOp_5 = (io_instruction[30] ? AluOp_SRA_1 : AluOp_SRL_1);
  assign switch_Decoder_l852 = io_instruction[31 : 20];

endmodule
