`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/17/2026 03:48:43 PM
// Design Name: 
// Module Name: main_decoder
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

module main_decoder(
    input  [6:0] Op,
    output reg       RegWrite,
    output reg [1:0] ImmSrc,
    output reg       ALUSrc,
    output reg       MemWrite,
    output reg   [1:0] ResultSrc,
    output reg       Branch,
    output reg [1:0] ALUOp,
     output reg       Jump  
    
);

always @(*) begin
    case(Op)

        // lw instruction
        7'b0000011: begin
            RegWrite  = 1'b1;
            ImmSrc    = 2'b00;
            ALUSrc    = 1'b1;
            MemWrite  = 1'b0;
            ResultSrc = 1'b1;
            Branch    = 1'b0;
            ALUOp     = 2'b00;
             Jump      = 1'b0; 
        end

        // sw instruction
        7'b0100011: begin
            RegWrite  = 1'b0;
            ImmSrc    = 2'b01;
            ALUSrc    = 1'b1;
            MemWrite  = 1'b1;
            ResultSrc = 1'bx;
            Branch    = 1'b0;
            ALUOp     = 2'b00;
             Jump      = 1'b0; 
        end

        // R-type instruction
        7'b0110011: begin
            RegWrite  = 1'b1;
            ImmSrc    = 2'bxx;
            ALUSrc    = 1'b0;
            MemWrite  = 1'b0;
            ResultSrc = 1'b0;
            Branch    = 1'b0;
            ALUOp     = 2'b10;
             Jump      = 1'b0; 
        end

        // beq instruction
        7'b1100011: begin
            RegWrite  = 1'b0;
            ImmSrc    = 2'b10;
            ALUSrc    = 1'b0;
            MemWrite  = 1'b0;
            ResultSrc = 1'bx;
            Branch    = 1'b1;
            ALUOp     = 2'b01;
             Jump      = 1'b0; 
        end
        
    //  jal instruction 
            7'b1101111: begin
                RegWrite  = 1'b1;     
                ImmSrc    = 2'b11;    
                ALUSrc    = 1'bx;     
                MemWrite  = 1'b0;     
                ResultSrc = 2'b10;    
                Branch    = 1'b0;
                ALUOp     = 2'bxx;
                Jump      = 1'b1;     // Unconditional jump
            end
        // default case
        default: begin
            RegWrite  = 1'b0;
            ImmSrc    = 2'b00;
            ALUSrc    = 1'b0;
            MemWrite  = 1'b0;
            ResultSrc = 1'b0;
            Branch    = 1'b0;
            ALUOp     = 2'b00;
            Jump      = 1'b0; 
        end

    endcase
end

endmodule
