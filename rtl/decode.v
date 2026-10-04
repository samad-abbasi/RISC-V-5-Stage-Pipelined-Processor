`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 03:40:57 PM
// Design Name: 
// Module Name: decode
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module decode(
    input        clk,
    input        FlushE,rst,
    input        RegWriteW,
    input [31:0] ResultW,
    input [4:0]  RdW,    
    input [31:0] InstrD,
    input [31:0] PCD,
    input [31:0] PCPlus4D,

    output        RegWriteE,
    output [1:0]  ResultSrcE,
    output        MemWriteE,
    output        JumpE,
    output        BranchE,
    output [2:0]  ALUControlE,
    output        ALUSrcE,
    output [31:0] RD1E,
    output [31:0] RD2E,
    output [31:0] PCE,
    output [31:0] ImmExtE,
    output [31:0] PCPlus4E,
    output [4:0]  RdE ,Rs1E,Rs2E
);

    wire        RegWriteD;
    wire [1:0]  ResultSrcD;
    wire        MemWriteD;
    wire        JumpD;
    wire        BranchD;
    wire [2:0]  ALUControlD;
    wire        ALUSrcD;
    wire [1:0]  ImmSrcD;

    wire [31:0] RD1_Dwire;
    wire [31:0] RD2_Dwire;
    wire [4:0]  Rs1D,Rs2D,RdD;     //rs1,Rs2 added newly
    wire [31:0] ImmExtD;

    assign RdD = InstrD[11:7];
    assign Rs1D = InstrD[19:15];     //new
    assign Rs2D = InstrD[24:20];      //new
    REG_FILE RF_1 (
        .clock(clk), .reset(rst),
        .A1(InstrD[19:15]), .A2(InstrD[24:20]), .A3(RdW),
        .WD3(ResultW), .WE3(RegWriteW),
        .RD1(RD1_Dwire), .RD2(RD2_Dwire)
    );

    Imm_Gen IG_1 (
        .instruction(InstrD),
        .immediate_output(ImmExtD),
        .ImmSrc(ImmSrcD)
    );

    control_unit CU1 (
        .op(InstrD[6:0]), .funct3(InstrD[14:12]), .funct7_5(InstrD[30]),
        .RegWrite(RegWriteD), .ResultSrc(ResultSrcD), .MemWrite(MemWriteD),
        .Jump(JumpD), .Branch(BranchD), .ALUControl(ALUControlD),
        .ALUSrc(ALUSrcD), .ImmSrc(ImmSrcD)
    );

    // Control pipeline registers
    Buff_RegD Reg_RegWriteD  (.clk(clk), .rst(rst), .CLR(FlushE),.X(RegWriteD),  .Y(RegWriteE));
    Buff_RegD Reg_ResultSrcD (.clk(clk), .rst(rst), .CLR(FlushE), .X(ResultSrcD), .Y(ResultSrcE));
    Buff_RegD Reg_MemWriteD  (.clk(clk), .rst(rst), .CLR(FlushE), .X(MemWriteD),  .Y(MemWriteE));
    Buff_RegD Reg_JumpD      (.clk(clk), .rst(rst), .CLR(FlushE), .X(JumpD),      .Y(JumpE));
    Buff_RegD Reg_BranchD    (.clk(clk), .rst(rst),.CLR(FlushE), .X(BranchD),    .Y(BranchE));
    Buff_RegD Reg_ALUControlD(.clk(clk), .rst(rst),.CLR(FlushE), .X(ALUControlD),.Y(ALUControlE));
    Buff_RegD Reg_ALUSrcD    (.clk(clk), .rst(rst), .CLR(FlushE),.X(ALUSrcD),    .Y(ALUSrcE));

    // Data pipeline registers
    Buff_RegD Reg_RD1_D  (.clk(clk), .rst(rst), .CLR(FlushE),.X(RD1_Dwire), .Y(RD1E));
    Buff_RegD Reg_RD2_D  (.clk(clk), .rst(rst), .CLR(FlushE),.X(RD2_Dwire), .Y(RD2E));
    Buff_RegD Reg_RdD    (.clk(clk), .rst(rst), .CLR(FlushE),.X(RdD),       .Y(RdE));
    Buff_RegD Reg_PCD    (.clk(clk), .rst(rst),.CLR(FlushE), .X(PCD),       .Y(PCE));
    Buff_RegD Reg_Rs1D    (.clk(clk), .rst(rst),.CLR(FlushE), .X(Rs1D),       .Y(Rs1E));  //new
    Buff_RegD Reg_Rs2D    (.clk(clk), .rst(rst),.CLR(FlushE), .X(Rs2D),       .Y(Rs2E));  //new
    Buff_RegD Reg_PCPlus4D(.clk(clk),.rst(rst), .CLR(FlushE),.X(PCPlus4D),  .Y(PCPlus4E));
    Buff_RegD Reg_ImmExtD(.clk(clk), .rst(rst), .CLR(FlushE),.X(ImmExtD),   .Y(ImmExtE));

endmodule