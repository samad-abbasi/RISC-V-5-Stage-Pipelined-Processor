`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/17/2026 03:30:19 PM
// Design Name: 
// Module Name: tb_adder
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

module tb_adder;

reg  [31:0] A, B;
wire [31:0] sum;


adder uut (
    .A(A),
    .B(B),
    .sum(sum)
);

initial begin
    $monitor("Time=%0t | A=%h | B=%h | Sum=%h",
              $time, A, B, sum);

    // Test 1
    A = 32'b0;
    B = 32'b0;
    #20;

    // Test 2
    A = 32'hDEAFBEEF;
    B = 32'hFEFAFEFE;
    #20;

    // Test 3
    A = 32'hFFFFFFFF;
    B = 32'hFFFFFFFF;
    #20;

    $finish;
end

endmodule