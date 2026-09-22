// Generator : SpinalHDL v1.14.2    git head : 78f29dc66110fc099a777992b6daa2f803ab445e
// Component : RiscvCore64C
// Git hash  : 8b7bb915c2ab280bcdb17d1fff269033fdde593d

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
  wire       [63:0]   csrFile_1_io_rdData;
  wire       [1:0]    csrFile_1_io_curMode;
  wire                csrFile_1_io_mstatusMie;
  wire       [1:0]    csrFile_1_io_mstatusMpp;
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
  wire       [63:0]   _zz_exTrapTval;
  wire       [63:0]   _zz_io_a_2;
  wire       [31:0]   _zz_io_a_3;
  wire       [63:0]   _zz_io_a_4;
  wire       [63:0]   _zz_io_b_2;
  wire       [31:0]   _zz_io_b_3;
  wire       [63:0]   _zz_io_b_4;
  wire       [63:0]   _zz_exAluResult_1;
  wire       [31:0]   _zz_exAluResult_2;
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
  wire                when_RiscvCore_l255;
  wire                when_RiscvCore_l259;
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
  reg        [4:0]    idEx_rs1;
  reg        [4:0]    idEx_rs2;
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
  reg        [1:0]    memWb_csrOp;
  reg                 memWb_csrWe;
  reg        [11:0]   memWb_csrAddr;
  reg        [63:0]   memWb_csrWrData;
  wire       [63:0]   wbWriteData;
  reg        [63:0]   forwardRs1;
  wire                when_RiscvCore_l322;
  wire                when_RiscvCore_l324;
  reg        [63:0]   forwardRs2;
  wire                when_RiscvCore_l337;
  wire                when_RiscvCore_l339;
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
  wire                csrPrivIllegal;
  wire                mtvecModeBad;
  wire                csrIllegal;
  reg                 exTrapEna;
  reg        [63:0]   exTrapCause;
  reg        [63:0]   exTrapTval;
  wire                mppSupported;
  wire                when_RiscvCore_l467;
  wire                when_RiscvCore_l471;
  wire                when_RiscvCore_l475;
  wire                when_RiscvCore_l484;
  wire                when_RiscvCore_l490;
  wire                when_RiscvCore_l493;
  wire                mretLegal;
  wire                csrAffectsMret;
  wire                csrMretStall;
  wire                exMretRaw;
  wire                intrReq;
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
  wire                when_RiscvCore_l715;
  wire                when_RiscvCore_l722;
  wire                when_RiscvCore_l730;
  wire                when_RiscvCore_l731;
  wire                when_RiscvCore_l744;
  wire                when_RiscvCore_l745;
  wire                when_RiscvCore_l782;
  wire                effMemWrite;
  wire                normalRead;
  wire                normalWrite;
  wire       [2:0]    storeOffset;
  wire       [63:0]   storeValue;
  reg        [63:0]   loadResult;
  wire       [7:0]    _zz_loadResult;
  wire       [15:0]   _zz_loadResult_1;
  wire       [31:0]   _zz_loadResult_2;
  wire                when_RiscvCore_l871;
  `ifndef SYNTHESIS
  reg [47:0] idEx_aluOp_string;
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
    .io_curMode        (csrFile_1_io_curMode[1:0]     ), //o
    .io_mstatusMie     (csrFile_1_io_mstatusMie       ), //o
    .io_mstatusMpp     (csrFile_1_io_mstatusMpp[1:0]  ), //o
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
    .io_op     (idEx_aluOp[4:0]      ), //i
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
      if(when_RiscvCore_l255) begin
        fetchInstr = {16'h0,_zz_hiReg};
      end else begin
        if(when_RiscvCore_l259) begin
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
      if(when_RiscvCore_l255) begin
        fetchLen = 3'b010;
      end else begin
        if(when_RiscvCore_l259) begin
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
      if(when_RiscvCore_l255) begin
        fetchCompressed = 1'b1;
      end else begin
        if(when_RiscvCore_l259) begin
          fetchCompressed = 1'b0;
        end else begin
          fetchCompressed = 1'b1;
        end
      end
    end
  end

  assign when_RiscvCore_l255 = pcReg[1];
  assign when_RiscvCore_l259 = (_zz_fetchInstr[1 : 0] == 2'b11);
  assign wbWriteData = ((memWb_wbSel == 3'b011) ? csrFile_1_io_rdData : memWb_wbData);
  assign when_RiscvCore_l322 = ((((((exMem_valid && exMem_regWrite) && (exMem_rd != 5'h0)) && (! exMem_memRead)) && (! exMem_atomic)) && (exMem_wbSel != 3'b011)) && (exMem_rd == idEx_rs1));
  always @(*) begin
    if(when_RiscvCore_l322) begin
      forwardRs1 = exMem_aluResult;
    end else begin
      if(when_RiscvCore_l324) begin
        forwardRs1 = wbWriteData;
      end else begin
        forwardRs1 = regFile_io_rs1Data;
      end
    end
  end

  assign when_RiscvCore_l324 = (((memWb_valid && memWb_regWrite) && (memWb_rd != 5'h0)) && (memWb_rd == idEx_rs1));
  assign when_RiscvCore_l337 = ((((((exMem_valid && exMem_regWrite) && (exMem_rd != 5'h0)) && (! exMem_memRead)) && (! exMem_atomic)) && (exMem_wbSel != 3'b011)) && (exMem_rd == idEx_rs2));
  always @(*) begin
    if(when_RiscvCore_l337) begin
      forwardRs2 = exMem_aluResult;
    end else begin
      if(when_RiscvCore_l339) begin
        forwardRs2 = wbWriteData;
      end else begin
        forwardRs2 = regFile_io_rs2Data;
      end
    end
  end

  assign when_RiscvCore_l339 = (((memWb_valid && memWb_regWrite) && (memWb_rd != 5'h0)) && (memWb_rd == idEx_rs2));
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
  assign csrPrivIllegal = (isCsrInst && (((((((_zz_csrPrivIllegal || _zz_csrPrivIllegal_1) || (! _zz_csrPrivIllegal_2)) || (! (_zz_csrPrivIllegal_3 <= csrFile_1_io_curMode))) || (! (2'b11 <= csrFile_1_io_curMode))) || (! (2'b11 <= csrFile_1_io_curMode))) || (! (2'b11 <= csrFile_1_io_curMode))) || (! (2'b11 <= csrFile_1_io_curMode))));
  assign mtvecModeBad = ((((isCsrInst && idEx_csrWe) && (idEx_csrAddr == 12'h305)) && ((idEx_csrOp == CsrOp_WRITE) || (idEx_csrOp == CsrOp_SET))) && (csrWrDataEx[1 : 0] != 2'b00));
  assign csrIllegal = ((((csrRoWrite || csrUnimpl) || csrPrivIllegal) || mtvecModeBad) && idEx_valid);
  always @(*) begin
    exTrapEna = 1'b0;
    if(idEx_valid) begin
      if(when_RiscvCore_l467) begin
        exTrapEna = 1'b1;
      end
      if(when_RiscvCore_l471) begin
        exTrapEna = 1'b1;
      end
      if(when_RiscvCore_l475) begin
        exTrapEna = 1'b1;
      end
      if(csrIllegal) begin
        exTrapEna = 1'b1;
      end
      if(when_RiscvCore_l484) begin
        exTrapEna = 1'b1;
      end
      if(when_RiscvCore_l490) begin
        if(when_RiscvCore_l493) begin
          exTrapEna = 1'b1;
        end
      end
    end
  end

  always @(*) begin
    exTrapCause = 64'h0;
    if(idEx_valid) begin
      if(when_RiscvCore_l467) begin
        exTrapCause = {60'd0, _zz_exTrapCause};
      end
      if(when_RiscvCore_l471) begin
        exTrapCause = 64'h0000000000000003;
      end
      if(when_RiscvCore_l475) begin
        exTrapCause = 64'h0000000000000002;
      end
      if(csrIllegal) begin
        exTrapCause = 64'h0000000000000002;
      end
      if(when_RiscvCore_l484) begin
        exTrapCause = 64'h0000000000000002;
      end
      if(when_RiscvCore_l490) begin
        if(when_RiscvCore_l493) begin
          exTrapCause = (idEx_isLr ? 64'h0000000000000004 : 64'h0000000000000006);
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
      if(when_RiscvCore_l490) begin
        if(when_RiscvCore_l493) begin
          exTrapTval = aluResult;
        end
      end
    end
  end

  assign mppSupported = ((csrFile_1_io_mstatusMpp == 2'b00) || (csrFile_1_io_mstatusMpp == 2'b11));
  assign when_RiscvCore_l467 = (idEx_sysOp == SysOp_ECALL);
  assign when_RiscvCore_l471 = (idEx_sysOp == SysOp_EBREAK);
  assign when_RiscvCore_l475 = ((idEx_sysOp == SysOp_MRET) && ((csrFile_1_io_curMode != MODE_M) || (! mppSupported)));
  assign when_RiscvCore_l484 = (idEx_illegal || (idEx_sysOp == SysOp_ILLEGAL));
  assign when_RiscvCore_l490 = (idEx_atomic || idEx_isLr);
  assign when_RiscvCore_l493 = (! ((idEx_memSize == 2'b10) ? (aluResult[1 : 0] == 2'b00) : (aluResult[2 : 0] == 3'b000)));
  assign mretLegal = (((idEx_valid && (idEx_sysOp == SysOp_MRET)) && (csrFile_1_io_curMode == MODE_M)) && mppSupported);
  assign csrAffectsMret = (((memWb_valid && memWb_csrWe) && ((memWb_csrAddr == 12'h300) || (memWb_csrAddr == 12'h341))) || ((exMem_valid && exMem_csrWe) && ((exMem_csrAddr == 12'h300) || (exMem_csrAddr == 12'h341))));
  assign csrMretStall = (mretLegal && csrAffectsMret);
  assign exMretRaw = (mretLegal && (! csrMretStall));
  assign intrReq = (((io_timerInterrupt && csrFile_1_io_mieMtie) && csrFile_1_io_mstatusMie) && (csrFile_1_io_curMode == MODE_M));
  assign stallData = (((idEx_valid && (idEx_rd != 5'h0)) && ((idEx_memRead || idEx_atomic) || ((idEx_wbSel == 3'b011) && idEx_regWrite))) && ((idEx_rd == decoder_1_io_output_rs1) || (idEx_rd == decoder_1_io_output_rs2)));
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
  assign when_RiscvCore_l715 = (! freezeAll);
  assign when_RiscvCore_l722 = (stallData || csrMretStall);
  assign when_RiscvCore_l730 = (! freezeAll);
  assign when_RiscvCore_l731 = (stallData || csrMretStall);
  assign when_RiscvCore_l744 = ((! freezeAll) && (! csrMretStall));
  assign when_RiscvCore_l745 = (stallData || flushYounger);
  assign when_RiscvCore_l782 = (! freezeAll);
  assign effMemWrite = (exMem_memWrite && (exMem_isSc ? scSuccess : 1'b1));
  assign normalRead = ((exMem_valid && exMem_memRead) && (! exMem_atomic));
  assign normalWrite = (exMem_valid && effMemWrite);
  assign io_dBus_valid = (((normalRead || normalWrite) || amoDriveRead) || amoDriveWrite);
  assign io_dBus_write = (normalWrite || amoDriveWrite);
  assign io_dBus_size = exMem_memSize;
  assign io_dBus_address = exMem_aluResult;
  assign storeOffset = exMem_aluResult[2 : 0];
  assign storeValue = (amoDriveWrite ? amoNewValue : exMem_rs2Data);
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
  assign when_RiscvCore_l871 = (! freezeAll);
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
      idEx_rs1 <= 5'h0;
      idEx_rs2 <= 5'h0;
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
      if(when_RiscvCore_l715) begin
        if(trapCommit) begin
          pcReg <= trapEntry;
        end else begin
          if(exMret) begin
            pcReg <= csrFile_1_io_mepc;
          end else begin
            if(ctrlFlush) begin
              pcReg <= ctrlTarget;
            end else begin
              if(when_RiscvCore_l722) begin
                pcReg <= pcReg;
              end else begin
                pcReg <= (pcReg + _zz_pcReg);
              end
            end
          end
        end
      end
      if(when_RiscvCore_l730) begin
        if(!when_RiscvCore_l731) begin
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
      if(when_RiscvCore_l744) begin
        if(when_RiscvCore_l745) begin
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
        idEx_rs1 <= decoder_1_io_output_rs1;
        idEx_rs2 <= decoder_1_io_output_rs2;
        idEx_rd <= decoder_1_io_output_rd;
        idEx_imm <= decoder_1_io_output_imm;
        idEx_illegal <= decoder_1_io_output_illegal;
        idEx_csrOp <= decoder_1_io_output_csrOp;
        idEx_csrImm <= decoder_1_io_output_csrImm;
        idEx_csrAddr <= decoder_1_io_output_csrAddr;
        idEx_csrWe <= decoder_1_io_output_csrWe;
        idEx_sysOp <= decoder_1_io_output_sysOp;
      end
      if(when_RiscvCore_l782) begin
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
        exMem_regWrite <= idEx_regWrite;
        exMem_rd <= idEx_rd;
        exMem_wbSel <= idEx_wbSel;
        exMem_aluResult <= exAluResult;
        exMem_rs2Data <= forwardRs2;
        exMem_csrOp <= idEx_csrOp;
        exMem_csrWe <= idEx_csrWe;
        exMem_csrAddr <= idEx_csrAddr;
        exMem_csrWrData <= csrWrDataEx;
      end
      if(when_RiscvCore_l871) begin
        memWb_valid <= exMem_valid;
        memWb_regWrite <= exMem_regWrite;
        memWb_rd <= exMem_rd;
        memWb_wbSel <= exMem_wbSel;
        if(exMem_atomic) begin
          memWb_wbData <= (exMem_isSc ? (scSuccess ? 64'h0 : 64'h0000000000000001) : amoOldValue);
        end else begin
          if(exMem_memRead) begin
            memWb_wbData <= loadResult;
          end else begin
            memWb_wbData <= exMem_aluResult;
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
  input  wire [4:0]    io_op,
  output wire [63:0]   io_result
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

  wire       [64:0]   _zz_bUE;
  wire       [127:0]  _zz_mulLow;
  wire       [127:0]  _zz_mulHighS;
  wire       [129:0]  _zz_mulHighSu;
  wire       [127:0]  _zz_mulHighU;
  wire       [63:0]   _zz_result;
  wire       [63:0]   _zz_result_1;
  wire       [63:0]   _zz_result_2;
  wire       [126:0]  _zz_result_3;
  wire       [63:0]   _zz_result_4;
  wire       [63:0]   _zz_result_5;
  wire       [63:0]   _zz_result_6;
  wire       [31:0]   _zz_result_7;
  wire       [63:0]   _zz_result_8;
  wire       [31:0]   _zz_result_9;
  wire       [63:0]   _zz_result_10;
  wire       [31:0]   _zz_result_11;
  wire       [31:0]   _zz_result_12;
  wire       [62:0]   _zz_result_13;
  wire       [63:0]   _zz_result_14;
  wire       [31:0]   _zz_result_15;
  wire       [31:0]   _zz_result_16;
  wire       [63:0]   _zz_result_17;
  wire       [31:0]   _zz_result_18;
  wire       [63:0]   _zz_result_19;
  wire       [31:0]   _zz_result_20;
  wire       [63:0]   _zz_result_21;
  wire       [63:0]   aU;
  wire       [63:0]   bU;
  wire       [63:0]   aS;
  wire       [63:0]   bS;
  wire       [5:0]    shamt;
  wire       [31:0]   aW;
  wire       [31:0]   bW;
  wire       [31:0]   aWU;
  wire       [4:0]    shamtW;
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
  assign _zz_result_3 = ({63'd0,aU} <<< shamt);
  assign _zz_result_2 = _zz_result_3[63:0];
  assign _zz_result_4 = (aU >>> shamt);
  assign _zz_result_5 = ($signed(aS) >>> shamt);
  assign _zz_result_7 = ($signed(aW) + $signed(bW));
  assign _zz_result_6 = {{32{_zz_result_7[31]}}, _zz_result_7};
  assign _zz_result_9 = ($signed(aW) - $signed(bW));
  assign _zz_result_8 = {{32{_zz_result_9[31]}}, _zz_result_9};
  assign _zz_result_11 = _zz_result_12;
  assign _zz_result_10 = {{32{_zz_result_11[31]}}, _zz_result_11};
  assign _zz_result_13 = ({31'd0,aWU} <<< shamtW);
  assign _zz_result_12 = _zz_result_13[31:0];
  assign _zz_result_15 = _zz_result_16;
  assign _zz_result_14 = {{32{_zz_result_15[31]}}, _zz_result_15};
  assign _zz_result_16 = (aWU >>> shamtW);
  assign _zz_result_18 = ($signed(aW) >>> shamtW);
  assign _zz_result_17 = {{32{_zz_result_18[31]}}, _zz_result_18};
  assign _zz_result_20 = _zz_result_21[31:0];
  assign _zz_result_19 = {{32{_zz_result_20[31]}}, _zz_result_20};
  assign _zz_result_21 = ($signed(aW) * $signed(bW));
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
  assign shamt = io_b[5 : 0];
  assign aW = aS[31 : 0];
  assign bW = bS[31 : 0];
  assign aWU = aU[31 : 0];
  assign shamtW = io_b[4 : 0];
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
        result = _zz_result;
      end
      AluOp_SUB : begin
        result = _zz_result_1;
      end
      AluOp_SLL_1 : begin
        result = _zz_result_2;
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
        result = _zz_result_8;
      end
      AluOp_SLLW : begin
        result = _zz_result_10;
      end
      AluOp_SRLW : begin
        result = _zz_result_14;
      end
      AluOp_SRAW : begin
        result = _zz_result_17;
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
        result = _zz_result_19;
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
      default : begin
        result = 64'h0;
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
  input  wire [63:0]   io_csrWrData,
  output wire [63:0]   io_rdData,
  input  wire          io_trapEna,
  input  wire [63:0]   io_trapEpc,
  input  wire [63:0]   io_trapCause,
  input  wire [63:0]   io_trapTval,
  input  wire          io_mretEna,
  output wire [1:0]    io_curMode,
  output wire          io_mstatusMie,
  output wire [1:0]    io_mstatusMpp,
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
  reg        [63:0]   readData;
  wire       [63:0]   mipBits;
  wire                wbActive;
  reg        [63:0]   opNew;
  reg        [63:0]   mstatusPostWb;
  wire                when_CsrFile_l114;
  wire       [63:0]   _zz_mstatusPostWb;
  reg        [63:0]   mstatusNext;
  reg        [1:0]    curModeNext;
  reg        [63:0]   mepcNext;
  reg        [63:0]   _zz_mepcNext;
  wire                when_CsrFile_l148;
  reg        [63:0]   mcauseNext;
  wire                when_CsrFile_l156;
  reg        [63:0]   mtvalNext;
  wire                when_CsrFile_l160;
  reg        [63:0]   mieNext;
  wire                when_CsrFile_l165;
  wire       [63:0]   _zz_mieNext;
  reg        [63:0]   mtvecNext;
  wire                when_CsrFile_l168;
  wire       [63:0]   _zz_mtvecNext;
  reg        [63:0]   mscratchNext;
  wire                when_CsrFile_l177;
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

  assign when_CsrFile_l114 = (wbActive && (io_csrAddr == 12'h300));
  assign _zz_mstatusPostWb = 64'h0000000000001888;
  always @(*) begin
    if(when_CsrFile_l114) begin
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

  assign when_CsrFile_l148 = (wbActive && (io_csrAddr == 12'h341));
  always @(*) begin
    if(when_CsrFile_l148) begin
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

  assign when_CsrFile_l156 = (wbActive && (io_csrAddr == 12'h342));
  always @(*) begin
    if(when_CsrFile_l156) begin
      mcauseNext = opNew;
    end else begin
      mcauseNext = mcauseReg;
    end
    if(io_trapEna) begin
      mcauseNext = io_trapCause;
    end
  end

  assign when_CsrFile_l160 = (wbActive && (io_csrAddr == 12'h343));
  always @(*) begin
    if(when_CsrFile_l160) begin
      mtvalNext = opNew;
    end else begin
      mtvalNext = mtvalReg;
    end
    if(io_trapEna) begin
      mtvalNext = io_trapTval;
    end
  end

  assign when_CsrFile_l165 = (wbActive && (io_csrAddr == 12'h304));
  assign _zz_mieNext = 64'h0000000000000080;
  always @(*) begin
    if(when_CsrFile_l165) begin
      mieNext = ((mieReg & (~ _zz_mieNext)) | (opNew & _zz_mieNext));
    end else begin
      mieNext = mieReg;
    end
  end

  assign when_CsrFile_l168 = (wbActive && (io_csrAddr == 12'h305));
  assign _zz_mtvecNext = 64'hfffffffffffffffc;
  always @(*) begin
    if(when_CsrFile_l168) begin
      mtvecNext = ((mtvecReg & (~ _zz_mtvecNext)) | (opNew & _zz_mtvecNext));
    end else begin
      mtvecNext = mtvecReg;
    end
  end

  assign when_CsrFile_l177 = (wbActive && (io_csrAddr == 12'h340));
  always @(*) begin
    if(when_CsrFile_l177) begin
      mscratchNext = opNew;
    end else begin
      mscratchNext = mscratchReg;
    end
  end

  assign io_curMode = curModeReg;
  assign io_mstatusMie = mstatusReg[3];
  assign io_mstatusMpp = mstatusReg[12 : 11];
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
    end else begin
      mstatusReg <= mstatusNext;
      mieReg <= mieNext;
      mtvecReg <= mtvecNext;
      mscratchReg <= mscratchNext;
      mepcReg <= mepcNext;
      mcauseReg <= mcauseNext;
      mtvalReg <= mtvalNext;
      curModeReg <= curModeNext;
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
  wire       [4:0]    rs1Num;
  wire       [4:0]    rdNum;
  wire       [63:0]   immI;
  wire       [63:0]   immS;
  wire       [63:0]   immB;
  wire       [63:0]   immU;
  wire       [63:0]   immJ;
  reg                 csrWrite;
  wire                when_Decoder_l128;
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
  wire       [1:0]    switch_Decoder_l165;
  wire                when_Decoder_l169;
  wire                when_Decoder_l216;
  wire                when_Decoder_l232;
  wire                when_Decoder_l237;
  wire       [1:0]    switch_Decoder_l247;
  wire                when_Decoder_l275;
  wire       [1:0]    switch_Decoder_l277;
  wire       [4:0]    _zz_io_output_aluOp;
  wire       [4:0]    _zz_io_output_aluOp_1;
  wire       [4:0]    _zz_io_output_aluOp_2;
  wire                when_Decoder_l329;
  wire                when_Decoder_l337;
  wire                when_Decoder_l347;
  wire                when_Decoder_l348;
  wire                when_Decoder_l349;
  wire                when_Decoder_l360;
  wire                when_Decoder_l361;
  wire       [4:0]    _zz_io_output_aluOp_3;
  wire       [4:0]    _zz_io_output_aluOp_4;
  wire                when_Decoder_l578;
  wire       [4:0]    _zz_io_output_aluOp_5;
  wire       [4:0]    _zz_io_output_aluOp_6;
  wire       [11:0]   switch_Decoder_l660;
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
  reg [47:0] _zz_io_output_aluOp_6_string;
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
  always @(*) begin
    case(_zz_io_output_aluOp_6)
      AluOp_ADD : _zz_io_output_aluOp_6_string = "ADD   ";
      AluOp_SUB : _zz_io_output_aluOp_6_string = "SUB   ";
      AluOp_SLL_1 : _zz_io_output_aluOp_6_string = "SLL_1 ";
      AluOp_SLT : _zz_io_output_aluOp_6_string = "SLT   ";
      AluOp_SLTU : _zz_io_output_aluOp_6_string = "SLTU  ";
      AluOp_XOR_1 : _zz_io_output_aluOp_6_string = "XOR_1 ";
      AluOp_SRL_1 : _zz_io_output_aluOp_6_string = "SRL_1 ";
      AluOp_SRA_1 : _zz_io_output_aluOp_6_string = "SRA_1 ";
      AluOp_OR_1 : _zz_io_output_aluOp_6_string = "OR_1  ";
      AluOp_AND_1 : _zz_io_output_aluOp_6_string = "AND_1 ";
      AluOp_ADDW : _zz_io_output_aluOp_6_string = "ADDW  ";
      AluOp_SUBW : _zz_io_output_aluOp_6_string = "SUBW  ";
      AluOp_SLLW : _zz_io_output_aluOp_6_string = "SLLW  ";
      AluOp_SRLW : _zz_io_output_aluOp_6_string = "SRLW  ";
      AluOp_SRAW : _zz_io_output_aluOp_6_string = "SRAW  ";
      AluOp_MUL : _zz_io_output_aluOp_6_string = "MUL   ";
      AluOp_MULH : _zz_io_output_aluOp_6_string = "MULH  ";
      AluOp_MULHSU : _zz_io_output_aluOp_6_string = "MULHSU";
      AluOp_MULHU : _zz_io_output_aluOp_6_string = "MULHU ";
      AluOp_DIV : _zz_io_output_aluOp_6_string = "DIV   ";
      AluOp_DIVU : _zz_io_output_aluOp_6_string = "DIVU  ";
      AluOp_REM_1 : _zz_io_output_aluOp_6_string = "REM_1 ";
      AluOp_REMU : _zz_io_output_aluOp_6_string = "REMU  ";
      AluOp_MULW : _zz_io_output_aluOp_6_string = "MULW  ";
      AluOp_DIVW : _zz_io_output_aluOp_6_string = "DIVW  ";
      AluOp_DIVUW : _zz_io_output_aluOp_6_string = "DIVUW ";
      AluOp_REMW : _zz_io_output_aluOp_6_string = "REMW  ";
      AluOp_REMUW : _zz_io_output_aluOp_6_string = "REMUW ";
      default : _zz_io_output_aluOp_6_string = "??????";
    endcase
  end
  `endif

  assign opcode = io_instruction[6 : 0];
  assign funct3 = io_instruction[14 : 12];
  assign funct7 = io_instruction[31 : 25];
  assign funct5 = io_instruction[31 : 27];
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
      case(switch_Decoder_l165)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l169) begin
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
              if(!when_Decoder_l216) begin
                io_output_regWrite = 1'b1;
              end
            end
            3'b010 : begin
              io_output_regWrite = 1'b1;
            end
            3'b011 : begin
              if(when_Decoder_l232) begin
                io_output_regWrite = 1'b1;
              end else begin
                if(!when_Decoder_l237) begin
                  io_output_regWrite = 1'b1;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l247)
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
                  if(when_Decoder_l275) begin
                    case(switch_Decoder_l277)
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
              if(!when_Decoder_l329) begin
                io_output_regWrite = 1'b1;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l337) begin
                io_output_regWrite = 1'b1;
              end
            end
            3'b100 : begin
              if(when_Decoder_l347) begin
                if(!when_Decoder_l348) begin
                  io_output_regWrite = 1'b1;
                end
              end else begin
                if(when_Decoder_l360) begin
                  if(!when_Decoder_l361) begin
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
          if(when_Decoder_l578) begin
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
      case(switch_Decoder_l165)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l169) begin
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
              if(!when_Decoder_l216) begin
                io_output_aluSrc = 1'b1;
              end
            end
            3'b010 : begin
              io_output_aluSrc = 1'b1;
            end
            3'b011 : begin
              if(when_Decoder_l232) begin
                io_output_aluSrc = 1'b1;
              end else begin
                if(!when_Decoder_l237) begin
                  io_output_aluSrc = 1'b1;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l247)
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
              if(!when_Decoder_l329) begin
                io_output_aluSrc = 1'b1;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l337) begin
                io_output_aluSrc = 1'b1;
              end
            end
            3'b100 : begin
              if(when_Decoder_l347) begin
                if(when_Decoder_l348) begin
                  if(!when_Decoder_l349) begin
                    io_output_aluSrc = 1'b1;
                  end
                end
              end else begin
                if(when_Decoder_l360) begin
                  if(!when_Decoder_l361) begin
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
      case(switch_Decoder_l165)
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
              if(!when_Decoder_l329) begin
                io_output_wbSel = 3'b001;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l337) begin
                io_output_wbSel = 3'b001;
              end
            end
            3'b100 : begin
              if(when_Decoder_l347) begin
                if(when_Decoder_l348) begin
                  if(!when_Decoder_l349) begin
                    io_output_wbSel = 3'b010;
                  end
                end
              end else begin
                if(when_Decoder_l360) begin
                  if(!when_Decoder_l361) begin
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
      case(switch_Decoder_l165)
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
      case(switch_Decoder_l165)
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
              if(when_Decoder_l347) begin
                if(when_Decoder_l348) begin
                  if(!when_Decoder_l349) begin
                    io_output_jump = 1'b1;
                  end
                end
              end else begin
                if(when_Decoder_l360) begin
                  if(!when_Decoder_l361) begin
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
      case(switch_Decoder_l165)
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
              if(when_Decoder_l347) begin
                if(when_Decoder_l348) begin
                  if(!when_Decoder_l349) begin
                    io_output_jalr = 1'b1;
                  end
                end
              end else begin
                if(when_Decoder_l360) begin
                  if(!when_Decoder_l361) begin
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
      case(switch_Decoder_l165)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l169) begin
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
              if(!when_Decoder_l216) begin
                io_output_aluOp = AluOp_ADDW;
              end
            end
            3'b010 : begin
              io_output_aluOp = AluOp_ADD;
            end
            3'b011 : begin
              if(when_Decoder_l232) begin
                io_output_aluOp = AluOp_ADD;
              end else begin
                if(!when_Decoder_l237) begin
                  io_output_aluOp = AluOp_ADD;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l247)
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
                  if(when_Decoder_l275) begin
                    case(switch_Decoder_l277)
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
              if(!when_Decoder_l329) begin
                io_output_aluOp = AluOp_ADD;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l337) begin
                io_output_aluOp = AluOp_ADD;
              end
            end
            3'b100 : begin
              if(when_Decoder_l347) begin
                if(!when_Decoder_l348) begin
                  io_output_aluOp = AluOp_ADD;
                end
              end else begin
                if(!when_Decoder_l360) begin
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
          if(when_Decoder_l578) begin
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
      case(switch_Decoder_l165)
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
      case(switch_Decoder_l165)
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
              if(!when_Decoder_l232) begin
                if(!when_Decoder_l237) begin
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
              if(when_Decoder_l347) begin
                if(!when_Decoder_l348) begin
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
      case(switch_Decoder_l165)
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
              if(!when_Decoder_l329) begin
                io_output_memRead = 1'b1;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l337) begin
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
      case(switch_Decoder_l165)
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
      case(switch_Decoder_l165)
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
              if(!when_Decoder_l329) begin
                io_output_memSize = 2'b10;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l337) begin
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
    io_output_rs1 = rs1Num;
    if(isComp) begin
      case(switch_Decoder_l165)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l169) begin
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
              if(!when_Decoder_l216) begin
                io_output_rs1 = crd;
              end
            end
            3'b010 : begin
              io_output_rs1 = 5'h0;
            end
            3'b011 : begin
              if(when_Decoder_l232) begin
                io_output_rs1 = 5'h02;
              end
            end
            3'b100 : begin
              case(switch_Decoder_l247)
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
                  if(when_Decoder_l275) begin
                    case(switch_Decoder_l277)
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
              if(!when_Decoder_l329) begin
                io_output_rs1 = 5'h02;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l337) begin
                io_output_rs1 = 5'h02;
              end
            end
            3'b100 : begin
              if(when_Decoder_l347) begin
                if(when_Decoder_l348) begin
                  if(!when_Decoder_l349) begin
                    io_output_rs1 = crd;
                  end
                end
              end else begin
                if(when_Decoder_l360) begin
                  if(!when_Decoder_l361) begin
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
      case(switch_Decoder_l165)
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
              case(switch_Decoder_l247)
                2'b00 : begin
                end
                2'b01 : begin
                end
                2'b10 : begin
                end
                default : begin
                  if(when_Decoder_l275) begin
                    case(switch_Decoder_l277)
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
              if(when_Decoder_l347) begin
                if(!when_Decoder_l348) begin
                  io_output_rs2 = crs2;
                end
              end else begin
                if(!when_Decoder_l360) begin
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
      case(switch_Decoder_l165)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l169) begin
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
              if(!when_Decoder_l216) begin
                io_output_rd = crd;
              end
            end
            3'b010 : begin
              io_output_rd = crd;
            end
            3'b011 : begin
              if(when_Decoder_l232) begin
                io_output_rd = 5'h02;
              end else begin
                if(!when_Decoder_l237) begin
                  io_output_rd = crd;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l247)
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
                  if(when_Decoder_l275) begin
                    case(switch_Decoder_l277)
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
              if(!when_Decoder_l329) begin
                io_output_rd = crd;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l337) begin
                io_output_rd = crd;
              end
            end
            3'b100 : begin
              if(when_Decoder_l347) begin
                if(!when_Decoder_l348) begin
                  io_output_rd = crd;
                end
              end else begin
                if(when_Decoder_l360) begin
                  if(!when_Decoder_l361) begin
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
      case(switch_Decoder_l165)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(!when_Decoder_l169) begin
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
              if(!when_Decoder_l216) begin
                io_output_imm = {{58{c6S[5]}}, c6S};
              end
            end
            3'b010 : begin
              io_output_imm = {{58{c6S[5]}}, c6S};
            end
            3'b011 : begin
              if(when_Decoder_l232) begin
                io_output_imm = {{54{cAddi16sp[9]}}, cAddi16sp};
              end else begin
                if(!when_Decoder_l237) begin
                  io_output_imm = {{46{_zz_io_output_imm_3[17]}}, _zz_io_output_imm_3};
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l247)
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
              if(!when_Decoder_l329) begin
                io_output_imm = _zz_io_output_imm_4;
              end
            end
            3'b011 : begin
              if(!when_Decoder_l337) begin
                io_output_imm = {{55{cLdspImm[8]}}, cLdspImm};
              end
            end
            3'b100 : begin
              if(when_Decoder_l347) begin
                if(when_Decoder_l348) begin
                  if(!when_Decoder_l349) begin
                    io_output_imm = 64'h0;
                  end
                end
              end else begin
                if(when_Decoder_l360) begin
                  if(!when_Decoder_l361) begin
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
      case(switch_Decoder_l165)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(when_Decoder_l169) begin
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
              if(when_Decoder_l216) begin
                io_output_illegal = 1'b1;
              end
            end
            3'b010 : begin
            end
            3'b011 : begin
              if(!when_Decoder_l232) begin
                if(when_Decoder_l237) begin
                  io_output_illegal = 1'b1;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l247)
                2'b00 : begin
                end
                2'b01 : begin
                end
                2'b10 : begin
                end
                default : begin
                  if(when_Decoder_l275) begin
                    case(switch_Decoder_l277)
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
              if(when_Decoder_l329) begin
                io_output_illegal = 1'b1;
              end
            end
            3'b011 : begin
              if(when_Decoder_l337) begin
                io_output_illegal = 1'b1;
              end
            end
            3'b100 : begin
              if(when_Decoder_l347) begin
                if(when_Decoder_l348) begin
                  if(when_Decoder_l349) begin
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
          if(when_Decoder_l578) begin
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
      case(switch_Decoder_l165)
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
              if(!when_Decoder_l347) begin
                if(when_Decoder_l360) begin
                  if(when_Decoder_l361) begin
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
              casez(switch_Decoder_l660)
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
      case(switch_Decoder_l165)
        2'b00 : begin
          case(cfunct3)
            3'b000 : begin
              if(when_Decoder_l169) begin
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
              if(when_Decoder_l216) begin
                io_output_valid = 1'b0;
              end
            end
            3'b010 : begin
            end
            3'b011 : begin
              if(!when_Decoder_l232) begin
                if(when_Decoder_l237) begin
                  io_output_valid = 1'b0;
                end
              end
            end
            3'b100 : begin
              case(switch_Decoder_l247)
                2'b00 : begin
                end
                2'b01 : begin
                end
                2'b10 : begin
                end
                default : begin
                  if(when_Decoder_l275) begin
                    case(switch_Decoder_l277)
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
              if(when_Decoder_l329) begin
                io_output_valid = 1'b0;
              end
            end
            3'b011 : begin
              if(when_Decoder_l337) begin
                io_output_valid = 1'b0;
              end
            end
            3'b100 : begin
              if(when_Decoder_l347) begin
                if(when_Decoder_l348) begin
                  if(when_Decoder_l349) begin
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
          if(when_Decoder_l578) begin
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
              casez(switch_Decoder_l660)
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

  assign when_Decoder_l128 = (io_output_csrOp == CsrOp_WRITE);
  always @(*) begin
    if(when_Decoder_l128) begin
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
  assign switch_Decoder_l165 = io_instruction[1 : 0];
  assign when_Decoder_l169 = (cAddi4spn == 10'h0);
  assign when_Decoder_l216 = (crd == 5'h0);
  assign when_Decoder_l232 = (crd == 5'h02);
  assign when_Decoder_l237 = ((crd == 5'h0) || (c6 == 6'h0));
  assign switch_Decoder_l247 = io_instruction[11 : 10];
  assign when_Decoder_l275 = io_instruction[12];
  assign switch_Decoder_l277 = io_instruction[6 : 5];
  assign _zz_io_output_aluOp = (io_instruction[5] ? AluOp_AND_1 : AluOp_OR_1);
  assign _zz_io_output_aluOp_1 = (io_instruction[5] ? AluOp_XOR_1 : AluOp_SUB);
  assign _zz_io_output_aluOp_2 = (io_instruction[6] ? _zz_io_output_aluOp : _zz_io_output_aluOp_1);
  assign when_Decoder_l329 = (crd == 5'h0);
  assign when_Decoder_l337 = (crd == 5'h0);
  assign when_Decoder_l347 = (io_instruction[12] == 1'b0);
  assign when_Decoder_l348 = (crs2 == 5'h0);
  assign when_Decoder_l349 = (crd == 5'h0);
  assign when_Decoder_l360 = (crs2 == 5'h0);
  assign when_Decoder_l361 = (crd == 5'h0);
  assign _zz_io_output_aluOp_3 = (io_instruction[30] ? AluOp_SRA_1 : AluOp_SRL_1);
  assign _zz_io_output_aluOp_4 = (io_instruction[30] ? AluOp_SRAW : AluOp_SRLW);
  assign when_Decoder_l578 = ((funct7 & 7'h7f) == 7'h01);
  assign _zz_io_output_aluOp_5 = (io_instruction[30] ? AluOp_SUB : AluOp_ADD);
  assign _zz_io_output_aluOp_6 = (io_instruction[30] ? AluOp_SRA_1 : AluOp_SRL_1);
  assign switch_Decoder_l660 = io_instruction[31 : 20];

endmodule
