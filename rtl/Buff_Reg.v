`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 03:36:35 PM
// Design Name: 
// Module Name: Buff_Reg
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


module Buff_Reg(

 input clk,CLR,
 input rst,
 input [31:0]X,
 output reg [31:0]Y
    );
    always@(posedge clk)
    begin 
   
    if(rst || CLR)
    Y<=32'b0;
   
    else 
    Y <=X;
    end
endmodule