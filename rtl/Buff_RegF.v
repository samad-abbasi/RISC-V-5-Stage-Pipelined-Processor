`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2026 03:20:11 PM
// Design Name: 
// Module Name: Buff_RegF
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

 input clk,
 input rst,
 input [31:0]X,
 output reg [31:0]Y
    );
    always@(posedge clk)
    begin 
   
    if(rst)
    Y<=32'b0;
   
    else 
    Y<=X;
    end
endmodule



module Buff_RegF2(

 input clk,en,
 input rst,CLR,
 input [31:0]X,
 output reg [31:0]Y
    );
    always@(posedge clk)
    begin 
   
    if(rst || CLR)
    Y<=32'b0;
   
    else if (en)
    Y <=Y;
    
    else 
    Y<=X;
    end
endmodule




module Buff_RegD(
 input clk,
 input rst,CLR,
 input [31:0]X,
 output reg [31:0]Y
    );
    always@(posedge clk)
    begin 
   
    if(rst || CLR)
    Y<=32'b0;
     
    else 
    Y<=X;
    end
endmodule
