`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 05:08:09 PM
// Design Name: 
// Module Name: execute
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


module execute(
    input        clk,
    input        rst, 
    input [31:0]ResultW,   //new added 
    input [1:0] ForwardAE,ForwardBE,    //new added
    input        RegWriteE,
    input [1:0]  ResultSrcE,
    input        MemWriteE,    
    input        JumpE,
    input        BranchE,
    input [2:0]  ALUControlE,
    input        ALUSrcE,
    input [31:0] RD1E,
    input [31:0] RD2E,
    input [31:0] PCE,
    input [31:0] ImmExtE,
    input [31:0] PCPlus4E,
    input [4:0]  RdE,

    output [31:0] PCTargetE,
    output        PCSrcE,
    output        RegWriteM,
    output [1:0]  ResultSrcM,
    output        MemWriteM,
    output [31:0] ALUResultM,
    output [31:0] WriteDataM,
    output [4:0]  RdM,
    output [31:0] PCPlus4M
);

    wire [31:0] SrcAE, SrcBE;
    wire [31:0] ALUResultE;
    wire        ZeroE;
    wire [31:0]SrcBE_mux;
  //  assign SrcAE = RD1E;
    
    mux_3x1  m_E1 (                                     //new
        .d0(RD1E), .d1(ResultW), .d2(ALUResultM),
        .s(ForwardAE), .out(SrcAE)
    );
    
    mux_3x1  m_E2 (                                      //new
        .d0(RD2E), .d1(ResultW), .d2(ALUResultM),
        .s(ForwardBE), .out(SrcBE_mux)
    );
    
    
    mux_2x1 E_2x1 (.a(SrcBE_mux), .b(ImmExtE), .y(SrcBE), .s(ALUSrcE));

    ALU ALU_1 (
        .in1(SrcAE), .in2(SrcBE),
        .alu_control(ALUControlE),
        .result(ALUResultE), .zero_flag(ZeroE)
    );

    assign PCSrcE = JumpE | (BranchE & ZeroE);

    adder AE (.A(PCE), .B(ImmExtE), .sum(PCTargetE));

    Buff_Reg Reg_RegWriteE  (.clk(clk), .rst(rst), .X(RegWriteE),  .Y(RegWriteM));
    Buff_Reg Reg_ResultSrcE (.clk(clk), .rst(rst), .X(ResultSrcE), .Y(ResultSrcM));
    Buff_Reg Reg_MemWriteE  (.clk(clk), .rst(rst), .X(MemWriteE),  .Y(MemWriteM));
    Buff_Reg Reg_ALUResultE (.clk(clk), .rst(rst), .X(ALUResultE), .Y(ALUResultM));
    Buff_Reg Reg_WriteDataE (.clk(clk), .rst(rst), .X(SrcBE_mux),       .Y(WriteDataM));
    Buff_Reg Reg_RdE        (.clk(clk), .rst(rst), .X(RdE),        .Y(RdM));
    Buff_Reg Reg_PCPlus4E   (.clk(clk), .rst(rst), .X(PCPlus4E),   .Y(PCPlus4M));

endmodule
