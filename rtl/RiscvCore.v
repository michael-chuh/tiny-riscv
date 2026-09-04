// Generator : SpinalHDL v1.14.2    git head : 78f29dc66110fc099a777992b6daa2f803ab445e
// Component : RiscvCore

`timescale 1ns/1ps

module RiscvCore (
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
  localparam AluOp_MUL = 5'd10;
  localparam AluOp_MULH = 5'd11;
  localparam AluOp_MULHSU = 5'd12;
  localparam AluOp_MULHU = 5'd13;
  localparam AluOp_DIV = 5'd14;
  localparam AluOp_DIVU = 5'd15;
  localparam AluOp_REM_1 = 5'd16;
  localparam AluOp_REMU = 5'd17;
  localparam BranchOp_NONE = 3'd0;
  localparam BranchOp_BEQ = 3'd1;
  localparam BranchOp_BNE = 3'd2;
  localparam BranchOp_BLT = 3'd3;
  localparam BranchOp_BGE = 3'd4;
  localparam BranchOp_BLTU = 3'd5;
  localparam BranchOp_BGEU = 3'd6;

  wire                regFile_io_writeEnable;
  wire                divider_1_io_start;
  wire       [31:0]   divider_1_io_a;
  wire       [31:0]   divider_1_io_b;
  wire                divider_1_io_ack;
  wire                decoder_1_io_output_regWrite;
  wire                decoder_1_io_output_aluSrc;
  wire       [1:0]    decoder_1_io_output_wbSel;
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
  wire       [4:0]    decoder_1_io_output_rs1;
  wire       [4:0]    decoder_1_io_output_rs2;
  wire       [4:0]    decoder_1_io_output_rd;
  wire       [31:0]   decoder_1_io_output_imm;
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
  wire       [31:0]   alu_1_io_result;
  wire                divider_1_io_busy;
  wire                divider_1_io_done;
  wire       [31:0]   divider_1_io_quotient;
  wire       [31:0]   divider_1_io_remainder;
  wire       [31:0]   _zz_aluResult;
  wire       [31:0]   _zz_branchCond;
  wire       [31:0]   _zz_branchCond_1;
  wire       [31:0]   _zz_branchCond_2;
  wire       [31:0]   _zz_branchCond_3;
  wire       [31:0]   _zz_ctrlTarget;
  wire       [94:0]   _zz_io_dBus_writeData;
  wire       [5:0]    _zz_io_dBus_writeData_1;
  wire       [3:0]    _zz_io_dBus_writeMask;
  wire       [6:0]    _zz_io_dBus_writeMask_1;
  wire       [62:0]   _zz_io_dBus_writeData_2;
  wire       [4:0]    _zz_io_dBus_writeData_3;
  wire       [31:0]   _zz__zz_loadResult;
  wire       [5:0]    _zz__zz_loadResult_1;
  wire       [31:0]   _zz_loadResult_2;
  wire       [7:0]    _zz_loadResult_3;
  wire       [31:0]   _zz_loadResult_4;
  wire       [31:0]   _zz__zz_loadResult_1_1;
  wire       [4:0]    _zz__zz_loadResult_1_2;
  wire       [31:0]   _zz_loadResult_5;
  wire       [15:0]   _zz_loadResult_6;
  wire       [31:0]   _zz_loadResult_7;
  reg        [31:0]   pcReg;
  reg                 ifId_valid;
  reg        [31:0]   ifId_pc;
  reg        [31:0]   ifId_instruction;
  wire       [4:0]    ifIdRs1;
  wire       [4:0]    ifIdRs2;
  reg                 idEx_valid;
  reg        [31:0]   idEx_pc;
  reg                 idEx_regWrite;
  reg                 idEx_aluSrc;
  reg        [1:0]    idEx_wbSel;
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
  reg        [4:0]    idEx_rs1;
  reg        [4:0]    idEx_rs2;
  reg        [4:0]    idEx_rd;
  reg        [31:0]   idEx_imm;
  reg        [31:0]   idEx_rs1Data;
  reg        [31:0]   idEx_rs2Data;
  reg                 exMem_valid;
  reg                 exMem_memRead;
  reg                 exMem_memWrite;
  reg        [1:0]    exMem_memSize;
  reg                 exMem_memSign;
  reg                 exMem_regWrite;
  reg        [4:0]    exMem_rd;
  reg        [31:0]   exMem_aluResult;
  reg        [31:0]   exMem_rs2Data;
  reg                 memWb_valid;
  reg                 memWb_regWrite;
  reg        [4:0]    memWb_rd;
  reg        [31:0]   memWb_wbData;
  reg        [31:0]   forwardRs1;
  wire                when_RiscvCore_l156;
  wire                when_RiscvCore_l158;
  reg        [31:0]   forwardRs2;
  wire                when_RiscvCore_l165;
  wire                when_RiscvCore_l167;
  reg        [31:0]   aluA;
  wire       [31:0]   aluB;
  reg        [31:0]   aluResult;
  reg                 branchCond;
  wire                branchTaken;
  wire                jumpTaken;
  wire                ctrlFlush;
  reg        [31:0]   ctrlTarget;
  wire                stallLoad;
  wire                fetchStall;
  wire                memStall;
  wire                divIsDiv;
  wire                divIsRem;
  wire                divInEx;
  wire                divSigned;
  wire                divStall;
  wire       [31:0]   exAluResult;
  wire                freezeAll;
  wire                when_RiscvCore_l277;
  wire                when_RiscvCore_l278;
  wire                when_RiscvCore_l288;
  wire                when_RiscvCore_l289;
  wire                when_RiscvCore_l301;
  wire                when_RiscvCore_l302;
  wire                when_RiscvCore_l330;
  wire       [1:0]    storeOffset;
  reg        [31:0]   loadResult;
  wire       [7:0]    _zz_loadResult;
  wire       [15:0]   _zz_loadResult_1;
  wire                when_RiscvCore_l383;
  `ifndef SYNTHESIS
  reg [47:0] idEx_aluOp_string;
  reg [31:0] idEx_branchType_string;
  `endif


  assign _zz_aluResult = (idEx_pc + 32'h00000004);
  assign _zz_branchCond = forwardRs1;
  assign _zz_branchCond_1 = forwardRs2;
  assign _zz_branchCond_2 = forwardRs2;
  assign _zz_branchCond_3 = forwardRs1;
  assign _zz_ctrlTarget = (forwardRs1 + idEx_imm);
  assign _zz_io_dBus_writeData = ({63'd0,exMem_rs2Data} <<< _zz_io_dBus_writeData_1);
  assign _zz_io_dBus_writeData_1 = (storeOffset * 4'b1000);
  assign _zz_io_dBus_writeMask_1 = ({3'd0,4'b0001} <<< storeOffset);
  assign _zz_io_dBus_writeMask = _zz_io_dBus_writeMask_1[3:0];
  assign _zz_io_dBus_writeData_2 = ({31'd0,exMem_rs2Data} <<< _zz_io_dBus_writeData_3);
  assign _zz_io_dBus_writeData_3 = (exMem_aluResult[1] * 4'b1000);
  assign _zz__zz_loadResult = (io_dBus_readData >>> _zz__zz_loadResult_1);
  assign _zz__zz_loadResult_1 = (storeOffset * 4'b1000);
  assign _zz_loadResult_3 = _zz_loadResult;
  assign _zz_loadResult_2 = {{24{_zz_loadResult_3[7]}}, _zz_loadResult_3};
  assign _zz_loadResult_4 = {24'd0, _zz_loadResult};
  assign _zz__zz_loadResult_1_1 = (io_dBus_readData >>> _zz__zz_loadResult_1_2);
  assign _zz__zz_loadResult_1_2 = (exMem_aluResult[1] * 4'b1000);
  assign _zz_loadResult_6 = _zz_loadResult_1;
  assign _zz_loadResult_5 = {{16{_zz_loadResult_6[15]}}, _zz_loadResult_6};
  assign _zz_loadResult_7 = {16'd0, _zz_loadResult_1};
  Decoder decoder_1 (
    .io_instruction       (ifId_instruction[31:0]             ), //i
    .io_output_regWrite   (decoder_1_io_output_regWrite       ), //o
    .io_output_aluSrc     (decoder_1_io_output_aluSrc         ), //o
    .io_output_wbSel      (decoder_1_io_output_wbSel[1:0]     ), //o
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
    .io_output_rs1        (decoder_1_io_output_rs1[4:0]       ), //o
    .io_output_rs2        (decoder_1_io_output_rs2[4:0]       ), //o
    .io_output_rd         (decoder_1_io_output_rd[4:0]        ), //o
    .io_output_imm        (decoder_1_io_output_imm[31:0]      ), //o
    .io_output_valid      (decoder_1_io_output_valid          )  //o
  );
  RegisterFile regFile (
    .io_rs1          (ifIdRs1[4:0]                 ), //i
    .io_rs2          (ifIdRs2[4:0]                 ), //i
    .io_rd           (memWb_rd[4:0]                ), //i
    .io_writeData    (memWb_wbData[31:0]           ), //i
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
  Alu alu_1 (
    .io_a      (aluA[31:0]           ), //i
    .io_b      (aluB[31:0]           ), //i
    .io_op     (idEx_aluOp[4:0]      ), //i
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
      AluOp_MUL : idEx_aluOp_string = "MUL   ";
      AluOp_MULH : idEx_aluOp_string = "MULH  ";
      AluOp_MULHSU : idEx_aluOp_string = "MULHSU";
      AluOp_MULHU : idEx_aluOp_string = "MULHU ";
      AluOp_DIV : idEx_aluOp_string = "DIV   ";
      AluOp_DIVU : idEx_aluOp_string = "DIVU  ";
      AluOp_REM_1 : idEx_aluOp_string = "REM_1 ";
      AluOp_REMU : idEx_aluOp_string = "REMU  ";
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
  `endif

  assign io_iBus_valid = 1'b1;
  assign io_iBus_pc = pcReg;
  assign ifIdRs1 = ifId_instruction[19 : 15];
  assign ifIdRs2 = ifId_instruction[24 : 20];
  assign when_RiscvCore_l156 = ((((exMem_valid && exMem_regWrite) && (exMem_rd != 5'h0)) && (! exMem_memRead)) && (exMem_rd == idEx_rs1));
  always @(*) begin
    if(when_RiscvCore_l156) begin
      forwardRs1 = exMem_aluResult;
    end else begin
      if(when_RiscvCore_l158) begin
        forwardRs1 = memWb_wbData;
      end else begin
        forwardRs1 = idEx_rs1Data;
      end
    end
  end

  assign when_RiscvCore_l158 = (((memWb_valid && memWb_regWrite) && (memWb_rd != 5'h0)) && (memWb_rd == idEx_rs1));
  assign when_RiscvCore_l165 = ((((exMem_valid && exMem_regWrite) && (exMem_rd != 5'h0)) && (! exMem_memRead)) && (exMem_rd == idEx_rs2));
  always @(*) begin
    if(when_RiscvCore_l165) begin
      forwardRs2 = exMem_aluResult;
    end else begin
      if(when_RiscvCore_l167) begin
        forwardRs2 = memWb_wbData;
      end else begin
        forwardRs2 = idEx_rs2Data;
      end
    end
  end

  assign when_RiscvCore_l167 = (((memWb_valid && memWb_regWrite) && (memWb_rd != 5'h0)) && (memWb_rd == idEx_rs2));
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
  always @(*) begin
    if(idEx_jump) begin
      aluResult = _zz_aluResult;
    end else begin
      aluResult = alu_1_io_result;
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

  assign stallLoad = (((idEx_valid && idEx_memRead) && (idEx_rd != 5'h0)) && ((idEx_rd == ifIdRs1) || (idEx_rd == ifIdRs2)));
  assign fetchStall = (! io_iBus_ready);
  assign memStall = ((exMem_valid && (exMem_memRead || exMem_memWrite)) && (! io_dBus_ready));
  assign divIsDiv = ((idEx_aluOp == AluOp_DIV) || (idEx_aluOp == AluOp_DIVU));
  assign divIsRem = ((idEx_aluOp == AluOp_REM_1) || (idEx_aluOp == AluOp_REMU));
  assign divInEx = (idEx_valid && (divIsDiv || divIsRem));
  assign divSigned = ((idEx_aluOp == AluOp_DIV) || (idEx_aluOp == AluOp_REM_1));
  assign divider_1_io_a = aluA;
  assign divider_1_io_b = aluB;
  assign divider_1_io_start = (((divInEx && (! divider_1_io_busy)) && (! divider_1_io_done)) && (! (memStall || fetchStall)));
  assign divider_1_io_ack = ((divInEx && divider_1_io_done) && (! (memStall || fetchStall)));
  assign divStall = ((divInEx && (! divider_1_io_done)) && (! (memStall || fetchStall)));
  assign exAluResult = ((divInEx && divider_1_io_done) ? (divIsRem ? divider_1_io_remainder : divider_1_io_quotient) : aluResult);
  assign freezeAll = ((memStall || fetchStall) || divStall);
  assign when_RiscvCore_l277 = (! freezeAll);
  assign when_RiscvCore_l278 = (! stallLoad);
  assign when_RiscvCore_l288 = (! freezeAll);
  assign when_RiscvCore_l289 = (! stallLoad);
  assign when_RiscvCore_l301 = (! freezeAll);
  assign when_RiscvCore_l302 = (stallLoad || ctrlFlush);
  assign when_RiscvCore_l330 = (! freezeAll);
  assign io_dBus_valid = (exMem_valid && (exMem_memRead || exMem_memWrite));
  assign io_dBus_write = exMem_memWrite;
  assign io_dBus_size = exMem_memSize;
  assign io_dBus_address = exMem_aluResult;
  assign storeOffset = exMem_aluResult[1 : 0];
  always @(*) begin
    io_dBus_writeData = 32'h0;
    case(exMem_memSize)
      2'b00 : begin
        io_dBus_writeData = _zz_io_dBus_writeData[31:0];
      end
      2'b01 : begin
        io_dBus_writeData = _zz_io_dBus_writeData_2[31:0];
      end
      default : begin
        io_dBus_writeData = exMem_rs2Data;
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
        io_dBus_writeMask = (exMem_aluResult[1] ? 4'b1110 : 4'b0011);
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
        loadResult = (exMem_memSign ? _zz_loadResult_2 : _zz_loadResult_4);
      end
      2'b01 : begin
        loadResult = (exMem_memSign ? _zz_loadResult_5 : _zz_loadResult_7);
      end
      default : begin
        loadResult = io_dBus_readData;
      end
    endcase
  end

  assign _zz_loadResult_1 = _zz__zz_loadResult_1_1[15 : 0];
  assign when_RiscvCore_l383 = (! freezeAll);
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
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      pcReg <= 32'h0;
      ifId_valid <= 1'b0;
      ifId_pc <= 32'h0;
      ifId_instruction <= 32'h0;
      idEx_valid <= 1'b0;
      idEx_pc <= 32'h0;
      idEx_regWrite <= 1'b0;
      idEx_aluSrc <= 1'b0;
      idEx_wbSel <= 2'b00;
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
      idEx_rs1 <= 5'h0;
      idEx_rs2 <= 5'h0;
      idEx_rd <= 5'h0;
      idEx_imm <= 32'h0;
      idEx_rs1Data <= 32'h0;
      idEx_rs2Data <= 32'h0;
      exMem_valid <= 1'b0;
      exMem_memRead <= 1'b0;
      exMem_memWrite <= 1'b0;
      exMem_memSize <= 2'b00;
      exMem_memSign <= 1'b0;
      exMem_regWrite <= 1'b0;
      exMem_rd <= 5'h0;
      exMem_aluResult <= 32'h0;
      exMem_rs2Data <= 32'h0;
      memWb_valid <= 1'b0;
      memWb_regWrite <= 1'b0;
      memWb_rd <= 5'h0;
      memWb_wbData <= 32'h0;
    end else begin
      if(when_RiscvCore_l277) begin
        if(when_RiscvCore_l278) begin
          if(ctrlFlush) begin
            pcReg <= ctrlTarget;
          end else begin
            pcReg <= (pcReg + 32'h00000004);
          end
        end
      end
      if(when_RiscvCore_l288) begin
        if(when_RiscvCore_l289) begin
          if(ctrlFlush) begin
            ifId_valid <= 1'b0;
          end else begin
            ifId_pc <= pcReg;
            ifId_instruction <= io_iBus_instruction;
            ifId_valid <= 1'b1;
          end
        end
      end
      if(when_RiscvCore_l301) begin
        if(when_RiscvCore_l302) begin
          idEx_valid <= 1'b0;
        end else begin
          idEx_valid <= ifId_valid;
        end
        idEx_pc <= ifId_pc;
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
        idEx_rs1 <= decoder_1_io_output_rs1;
        idEx_rs2 <= decoder_1_io_output_rs2;
        idEx_rd <= decoder_1_io_output_rd;
        idEx_imm <= decoder_1_io_output_imm;
        idEx_rs1Data <= regFile_io_rs1Data;
        idEx_rs2Data <= regFile_io_rs2Data;
      end
      if(when_RiscvCore_l330) begin
        exMem_valid <= idEx_valid;
        exMem_memRead <= idEx_memRead;
        exMem_memWrite <= idEx_memWrite;
        exMem_memSize <= idEx_memSize;
        exMem_memSign <= idEx_memSign;
        exMem_regWrite <= idEx_regWrite;
        exMem_rd <= idEx_rd;
        exMem_aluResult <= exAluResult;
        exMem_rs2Data <= forwardRs2;
      end
      if(when_RiscvCore_l383) begin
        memWb_valid <= exMem_valid;
        memWb_regWrite <= exMem_regWrite;
        memWb_rd <= exMem_rd;
        if(exMem_memRead) begin
          memWb_wbData <= loadResult;
        end else begin
          memWb_wbData <= exMem_aluResult;
        end
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
  localparam AluOp_MUL = 5'd10;
  localparam AluOp_MULH = 5'd11;
  localparam AluOp_MULHSU = 5'd12;
  localparam AluOp_MULHU = 5'd13;
  localparam AluOp_DIV = 5'd14;
  localparam AluOp_DIVU = 5'd15;
  localparam AluOp_REM_1 = 5'd16;
  localparam AluOp_REMU = 5'd17;

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
  wire       [31:0]   aU;
  wire       [31:0]   bU;
  wire       [31:0]   aS;
  wire       [31:0]   bS;
  wire       [4:0]    shamt;
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
      AluOp_MUL : io_op_string = "MUL   ";
      AluOp_MULH : io_op_string = "MULH  ";
      AluOp_MULHSU : io_op_string = "MULHSU";
      AluOp_MULHU : io_op_string = "MULHU ";
      AluOp_DIV : io_op_string = "DIV   ";
      AluOp_DIVU : io_op_string = "DIVU  ";
      AluOp_REM_1 : io_op_string = "REM_1 ";
      AluOp_REMU : io_op_string = "REMU  ";
      default : io_op_string = "??????";
    endcase
  end
  `endif

  assign aU = io_a;
  assign bU = io_b;
  assign aS = io_a;
  assign bS = io_b;
  assign shamt = io_b[4 : 0];
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
      default : begin
        result = 32'h0;
      end
    endcase
  end

  assign io_result = result;

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
  output reg  [1:0]    io_output_wbSel,
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
  output wire [4:0]    io_output_rs1,
  output wire [4:0]    io_output_rs2,
  output wire [4:0]    io_output_rd,
  output reg  [31:0]   io_output_imm,
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
  localparam AluOp_MUL = 5'd10;
  localparam AluOp_MULH = 5'd11;
  localparam AluOp_MULHSU = 5'd12;
  localparam AluOp_MULHU = 5'd13;
  localparam AluOp_DIV = 5'd14;
  localparam AluOp_DIVU = 5'd15;
  localparam AluOp_REM_1 = 5'd16;
  localparam AluOp_REMU = 5'd17;
  localparam BranchOp_NONE = 3'd0;
  localparam BranchOp_BEQ = 3'd1;
  localparam BranchOp_BNE = 3'd2;
  localparam BranchOp_BLT = 3'd3;
  localparam BranchOp_BGE = 3'd4;
  localparam BranchOp_BLTU = 3'd5;
  localparam BranchOp_BGEU = 3'd6;

  wire       [11:0]   _zz_immI;
  wire       [11:0]   _zz_immS;
  wire       [32:0]   _zz_immB;
  wire       [31:0]   _zz_immB_1;
  wire       [11:0]   _zz_immB_2;
  wire       [31:0]   _zz_immU;
  wire       [32:0]   _zz_immJ;
  wire       [31:0]   _zz_immJ_1;
  wire       [19:0]   _zz_immJ_2;
  wire       [6:0]    opcode;
  wire       [2:0]    funct3;
  wire       [6:0]    funct7;
  wire       [31:0]   immI;
  wire       [31:0]   immS;
  wire       [31:0]   immB;
  wire       [31:0]   immU;
  wire       [31:0]   immJ;
  wire       [4:0]    _zz_io_output_aluOp;
  wire                when_Decoder_l157;
  wire       [4:0]    _zz_io_output_aluOp_1;
  wire       [4:0]    _zz_io_output_aluOp_2;
  `ifndef SYNTHESIS
  reg [47:0] io_output_aluOp_string;
  reg [31:0] io_output_branchType_string;
  reg [47:0] _zz_io_output_aluOp_string;
  reg [47:0] _zz_io_output_aluOp_1_string;
  reg [47:0] _zz_io_output_aluOp_2_string;
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
      AluOp_MUL : io_output_aluOp_string = "MUL   ";
      AluOp_MULH : io_output_aluOp_string = "MULH  ";
      AluOp_MULHSU : io_output_aluOp_string = "MULHSU";
      AluOp_MULHU : io_output_aluOp_string = "MULHU ";
      AluOp_DIV : io_output_aluOp_string = "DIV   ";
      AluOp_DIVU : io_output_aluOp_string = "DIVU  ";
      AluOp_REM_1 : io_output_aluOp_string = "REM_1 ";
      AluOp_REMU : io_output_aluOp_string = "REMU  ";
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
      AluOp_MUL : _zz_io_output_aluOp_string = "MUL   ";
      AluOp_MULH : _zz_io_output_aluOp_string = "MULH  ";
      AluOp_MULHSU : _zz_io_output_aluOp_string = "MULHSU";
      AluOp_MULHU : _zz_io_output_aluOp_string = "MULHU ";
      AluOp_DIV : _zz_io_output_aluOp_string = "DIV   ";
      AluOp_DIVU : _zz_io_output_aluOp_string = "DIVU  ";
      AluOp_REM_1 : _zz_io_output_aluOp_string = "REM_1 ";
      AluOp_REMU : _zz_io_output_aluOp_string = "REMU  ";
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
      AluOp_MUL : _zz_io_output_aluOp_1_string = "MUL   ";
      AluOp_MULH : _zz_io_output_aluOp_1_string = "MULH  ";
      AluOp_MULHSU : _zz_io_output_aluOp_1_string = "MULHSU";
      AluOp_MULHU : _zz_io_output_aluOp_1_string = "MULHU ";
      AluOp_DIV : _zz_io_output_aluOp_1_string = "DIV   ";
      AluOp_DIVU : _zz_io_output_aluOp_1_string = "DIVU  ";
      AluOp_REM_1 : _zz_io_output_aluOp_1_string = "REM_1 ";
      AluOp_REMU : _zz_io_output_aluOp_1_string = "REMU  ";
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
      AluOp_MUL : _zz_io_output_aluOp_2_string = "MUL   ";
      AluOp_MULH : _zz_io_output_aluOp_2_string = "MULH  ";
      AluOp_MULHSU : _zz_io_output_aluOp_2_string = "MULHSU";
      AluOp_MULHU : _zz_io_output_aluOp_2_string = "MULHU ";
      AluOp_DIV : _zz_io_output_aluOp_2_string = "DIV   ";
      AluOp_DIVU : _zz_io_output_aluOp_2_string = "DIVU  ";
      AluOp_REM_1 : _zz_io_output_aluOp_2_string = "REM_1 ";
      AluOp_REMU : _zz_io_output_aluOp_2_string = "REMU  ";
      default : _zz_io_output_aluOp_2_string = "??????";
    endcase
  end
  `endif

  assign opcode = io_instruction[6 : 0];
  assign funct3 = io_instruction[14 : 12];
  assign funct7 = io_instruction[31 : 25];
  assign immI = {{20{_zz_immI[11]}}, _zz_immI};
  assign immS = {{20{_zz_immS[11]}}, _zz_immS};
  assign immB = _zz_immB[31:0];
  assign immU = _zz_immU;
  assign immJ = _zz_immJ[31:0];
  always @(*) begin
    io_output_regWrite = 1'b0;
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
      7'b0010011 : begin
        io_output_regWrite = 1'b1;
      end
      7'b0110011 : begin
        if(when_Decoder_l157) begin
          io_output_regWrite = 1'b1;
        end else begin
          io_output_regWrite = 1'b1;
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

  always @(*) begin
    io_output_aluSrc = 1'b0;
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
      7'b0010011 : begin
        io_output_aluSrc = 1'b1;
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

  always @(*) begin
    io_output_wbSel = 2'b00;
    casez(opcode)
      7'b0110111 : begin
      end
      7'b0010111 : begin
      end
      7'b1101111 : begin
        io_output_wbSel = 2'b10;
      end
      7'b1100111 : begin
        io_output_wbSel = 2'b10;
      end
      7'b1100011 : begin
      end
      7'b0000011 : begin
        io_output_wbSel = 2'b01;
      end
      7'b0100011 : begin
      end
      7'b0010011 : begin
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

  always @(*) begin
    io_output_branch = 1'b0;
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
      7'b0010011 : begin
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

  always @(*) begin
    io_output_jump = 1'b0;
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
      7'b0010011 : begin
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

  always @(*) begin
    io_output_jalr = 1'b0;
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
      7'b0010011 : begin
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

  always @(*) begin
    io_output_aluOp = AluOp_ADD;
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
            io_output_aluOp = _zz_io_output_aluOp;
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
      7'b0110011 : begin
        if(when_Decoder_l157) begin
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
              io_output_aluOp = _zz_io_output_aluOp_1;
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
              io_output_aluOp = _zz_io_output_aluOp_2;
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

  always @(*) begin
    io_output_branchType = BranchOp_NONE;
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
      7'b0010011 : begin
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

  always @(*) begin
    io_output_aluASrc = 2'b00;
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
      7'b0010011 : begin
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

  always @(*) begin
    io_output_memRead = 1'b0;
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
      7'b0010011 : begin
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

  always @(*) begin
    io_output_memWrite = 1'b0;
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
      7'b0010011 : begin
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

  always @(*) begin
    io_output_memSize = 2'b10;
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
          default : begin
          end
        endcase
      end
      7'b0010011 : begin
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

  always @(*) begin
    io_output_memSign = 1'b0;
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
          end
          3'b100 : begin
          end
          3'b101 : begin
          end
          default : begin
          end
        endcase
      end
      7'b0100011 : begin
      end
      7'b0010011 : begin
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

  assign io_output_rs1 = io_instruction[19 : 15];
  assign io_output_rs2 = io_instruction[24 : 20];
  assign io_output_rd = io_instruction[11 : 7];
  always @(*) begin
    io_output_imm = immI;
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
      7'b0010011 : begin
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

  always @(*) begin
    io_output_valid = 1'b1;
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
          default : begin
            io_output_valid = 1'b0;
          end
        endcase
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
      7'b0110011 : begin
        if(when_Decoder_l157) begin
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
        io_output_valid = 1'b0;
      end
      7'b1110011 : begin
        io_output_valid = 1'b0;
      end
      default : begin
        io_output_valid = 1'b0;
      end
    endcase
  end

  assign _zz_io_output_aluOp = (io_instruction[30] ? AluOp_SRA_1 : AluOp_SRL_1);
  assign when_Decoder_l157 = ((funct7 & 7'h7f) == 7'h01);
  assign _zz_io_output_aluOp_1 = (io_instruction[30] ? AluOp_SUB : AluOp_ADD);
  assign _zz_io_output_aluOp_2 = (io_instruction[30] ? AluOp_SRA_1 : AluOp_SRL_1);

endmodule
