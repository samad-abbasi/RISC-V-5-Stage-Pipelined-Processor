`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2026 02:30:16 PM
// Design Name: 
// Module Name: pc_32bit
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


module pc_32bit( clk,rst,prev_value,count,en

   );
    input clk;
    input rst,en;
    input [31:0]prev_value;
    output reg [31:0]count;
   
    always@(posedge clk or posedge rst)
    begin 
   
    if(rst)
    count<=32'd0;
   
   else if(en)
    count <=count;
   
    
    else
    count <=prev_value;
   
    end 
    endmodule
    
    
    
    

