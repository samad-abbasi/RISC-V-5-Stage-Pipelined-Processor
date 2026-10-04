`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2026 08:38:55 PM
// Design Name: 
// Module Name: tb_data_mem
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


module tb_data_mem();
reg clk, mem_read, mem_write;
reg [31:0] address, data_in;
wire [31:0] data_out;

data_mem uut (
    .clk(clk),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .address(address),
    .data_in(data_in),
    .data_out(data_out)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    mem_read = 0;
    mem_write = 0;
    address = 32'b0;
    data_in = 32'b0;

    #20;

    @(posedge clk);
    address   <= 32'd8;
    data_in   <= 32'hAABBCCDD;
    mem_write <= 1'b1;

    @(posedge clk);
    mem_write <= 1'b0;
    
    #20;

    @(posedge clk);
    address  <= 32'd8;
    mem_read <= 1'b1;

    @(posedge clk);
    mem_read <= 1'b0;

    #40;
    $stop;
end

endmodule