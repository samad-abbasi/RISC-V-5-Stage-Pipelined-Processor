`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 03:33:21 PM
// Design Name: 
// Module Name: Fetch
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

module fetch(
    input        clk,
    input        PCSrcE,
    input StallF, StallD ,FlushD,rst,   //FlusD is rst                  //from hazard unit
    input [31:0] PCTargetE,
    output [31:0] InstrD,
    output [31:0] PCD,
    output [31:0] PCPlus4D
);

    wire [31:0] PCPlus4F, PC_F, PCF, RD_F;

    mux_2x1   m1  (.a(PCPlus4F), .b(PCTargetE), .y(PC_F),    .s(PCSrcE));
    pc_32bit  p1  (.clk(clk),    .rst(rst),  .en(StallF),    .prev_value(PC_F), .count(PCF));
    INST_MEM  IM1 (.PC(PCF),     .Instruction_Code(RD_F));
    adder     a1  (.A(PCF),      .B(32'd4),      .sum(PCPlus4F));

    Buff_RegF2 Reg_InstrF   (.clk(clk), .rst(rst), .CLR(FlushD),.en(StallD), .X(RD_F),     .Y(InstrD));
    Buff_RegF2 Reg_PCF      (.clk(clk), .rst(rst), .CLR(FlushD),.en(StallD), .X(PCF),      .Y(PCD));
    Buff_RegF2 Reg_PCPlus4F (.clk(clk), .rst(rst), .CLR(FlushD),.en(StallD),.X(PCPlus4F), .Y(PCPlus4D));

endmodule