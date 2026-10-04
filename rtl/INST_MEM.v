`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2026 03:01:44 PM
// Design Name: 
// Module Name: INST_MEM
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

module INST_MEM(
 input [31:0] PC,
 output [31:0] Instruction_Code
    );
    reg [7:0] Memory [62:0]; //Byte -addressable
    
    initial begin
// addi x1,x0,5
    Memory[0]  = 8'h93;
    Memory[1]  = 8'h00;
    Memory[2]  = 8'h50;
    Memory[3]  = 8'h00;
    
    // addi x2,x0,10
    Memory[4]  = 8'h13;
    Memory[5]  = 8'h01;
    Memory[6]  = 8'hA0;
    Memory[7]  = 8'h00;
    
    // add x3,x1,x2
    Memory[8]  = 8'hB3;
    Memory[9]  = 8'h81;
    Memory[10] = 8'h20;
    Memory[11] = 8'h00;
    
    // add x4,x3,x2
    Memory[12] = 8'h33;
    Memory[13] = 8'h82;
    Memory[14] = 8'h21;
    Memory[15] = 8'h00;
    
    // sw x4,0(x0)
    Memory[16] = 8'h23;
    Memory[17] = 8'h20;
    Memory[18] = 8'h40;
    Memory[19] = 8'h00;
    
    // lw x5,0(x0)
    Memory[20] = 8'h83;
    Memory[21] = 8'h22;
    Memory[22] = 8'h00;
    Memory[23] = 8'h00;
    
    // add x6,x5,x1
    Memory[24] = 8'h33;
    Memory[25] = 8'h83;
    Memory[26] = 8'h12;
    Memory[27] = 8'h00;
    
    // beq x1,x2,+8
    Memory[28] = 8'h63;
    Memory[29] = 8'h84;
    Memory[30] = 8'h20;
    Memory[31] = 8'h00;
    
    // addi x7,x0,11
    Memory[32] = 8'h93;
    Memory[33] = 8'h03;
    Memory[34] = 8'hB0;
    Memory[35] = 8'h00;
    
    // beq x1,x1,+8
    Memory[36] = 8'h63;
    Memory[37] = 8'h84;
    Memory[38] = 8'h10;
    Memory[39] = 8'h00;
    
    // addi x7,x0,99
    Memory[40] = 8'h93;
    Memory[41] = 8'h03;
    Memory[42] = 8'h30;
    Memory[43] = 8'h06;
    
    // jal x8,+8
    Memory[44] = 8'h6F;
    Memory[45] = 8'h04;
    Memory[46] = 8'h80;
    Memory[47] = 8'h00;
    
    // addi x9,x0,55
    Memory[48] = 8'h93;
    Memory[49] = 8'h04;
    Memory[50] = 8'h70;
    Memory[51] = 8'h03;
    
    // addi x10,x0,77
    Memory[52] = 8'h13;
    Memory[53] = 8'h05;
    Memory[54] = 8'hD0;
    Memory[55] = 8'h04;
    end
    assign Instruction_Code = {Memory[PC+3],Memory[PC+2],Memory[PC+1],Memory[PC]};
  
endmodule

