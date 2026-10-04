`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 05:38:22 PM
// Design Name: 
// Module Name: Memory
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


module Memory(
    input        clk,          
    input        rst,        
    input        RegWriteM,
    input [1:0]  ResultSrcM,
    input        MemWriteM,
    input [31:0] ALUResultM,
    input [31:0] WriteDataM,
    input [4:0]  RdM,
    input [31:0] PCPlus4M,

    output        RegWriteW,
    output [1:0]  ResultSrcW,
    output [31:0] ALUResultW,  
    output [31:0] ReadDataW,
    output [4:0]  RdW,
    output [31:0] PCPlus4W
);

    wire [31:0] RD_Mout;

    data_mem DM_1 (
        .clk(clk), .mem_write(MemWriteM),
        .address(ALUResultM), .data_in(WriteDataM), .data_out(RD_Mout)
    );

    Buff_Reg Reg_RegWriteM  (.clk(clk), .rst(rst), .X(RegWriteM),  .Y(RegWriteW));
    Buff_Reg Reg_ResultSrcM (.clk(clk), .rst(rst), .X(ResultSrcM), .Y(ResultSrcW));
    Buff_Reg Reg_ALUResultM (.clk(clk), .rst(rst), .X(ALUResultM), .Y(ALUResultW));
    Buff_Reg Reg_RD_Mout    (.clk(clk), .rst(rst), .X(RD_Mout),    .Y(ReadDataW));
    Buff_Reg Reg_RdM        (.clk(clk), .rst(rst), .X(RdM),        .Y(RdW));
    Buff_Reg Reg_PCPlus4M   (.clk(clk), .rst(rst), .X(PCPlus4M),   .Y(PCPlus4W)); 

endmodule