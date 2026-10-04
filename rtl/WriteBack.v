`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 06:16:19 PM
// Design Name: 
// Module Name: WriteBack
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


module WriteBack(
    input        RegWriteW,
    input [1:0]  ResultSrcW,
    input [31:0] ALUResultW,  
    input [31:0] ReadDataW,
    input [4:0]  RdW,
    input [31:0] PCPlus4W,

    output [31:0] ResultW
);

    mux_3x1 m_WB (
        .d0(ALUResultW), .d1(ReadDataW), .d2(PCPlus4W),
        .s(ResultSrcW), .out(ResultW)
    );

endmodule
