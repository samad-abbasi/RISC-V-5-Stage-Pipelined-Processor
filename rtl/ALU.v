`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2026 06:10:58 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
input [31:0] in1, in2,
input [2:0] alu_control,
output reg [31:0] result,
output zero_flag
);

always @(*) begin
    case(alu_control)

        3'b000: result = in1 + in2;
        3'b001: result = in1 - in2;
        3'b010: result = in1 & in2;
        3'b110: result = in1 | in2;

        default: result = 32'b0;

    endcase
end

assign zero_flag = (result == 32'b0);

endmodule
