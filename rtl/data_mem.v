`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2026 08:31:29 PM
// Design Name: 
// Module Name: data_mem
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
module data_mem(
    input clk,
    input mem_write,
    input [31:0] address, data_in,
    output [31:0] data_out        // not reg anymore
);

reg [7:0] memory [1023:0];

initial begin
    memory[0] = 8'h00;
    memory[1] = 8'h00;
    memory[2] = 8'h00;
    memory[3] = 8'h00;
end

// WRITE - synchronous (on clock edge)
always @(posedge clk) begin 
    if (mem_write) begin 
        memory[address]     <= data_in[7:0];
        memory[address + 1] <= data_in[15:8];
        memory[address + 2] <= data_in[23:16];
        memory[address + 3] <= data_in[31:24];
    end 
end

// READ - combinational (no clock, always up to date)
assign data_out = {memory[address+3],
                   memory[address+2],
                   memory[address+1],
                   memory[address]};

endmodule