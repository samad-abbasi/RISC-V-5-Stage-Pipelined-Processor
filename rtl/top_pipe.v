`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 07:26:12 PM
// Design Name: 
// Module Name: top_pipe
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


module top_pipe(
    input clk,
    input rst
);


wire        PCSrcE;   //hazard connect
wire [31:0] PCTargetE;

wire        RegWriteW;
wire [4:0]  RdW;
wire [31:0] ResultW;


//  STAGE 1 : FETCH

wire [31:0] InstrD;
wire [31:0] PCD;
wire [31:0] PCPlus4D;
wire StallF,StallD,FlushD;    //from hazard

fetch FETCH_STAGE (
    .clk       (clk),
    .rst       (rst),
    .StallF (StallF),   ////////////////////////////////////////wire StallF
    .StallD (StallD),
    .FlushD(FlushD),
   
    .PCSrcE    (PCSrcE),
    .PCTargetE (PCTargetE),
    .InstrD    (InstrD),
    .PCD       (PCD),
    .PCPlus4D  (PCPlus4D)
);


//  STAGE 2 : DECODE
wire FlushE;          //From control hazard 
wire        RegWriteE;
wire [1:0]  ResultSrcE;
wire        MemWriteE;
wire        JumpE;
wire        BranchE;
wire [2:0]  ALUControlE;
wire        ALUSrcE;
wire [31:0] RD1E;
wire [31:0] RD2E;
wire [31:0] PCE;
wire [31:0] ImmExtE;
wire [31:0] PCPlus4E;
wire [4:0]  RdE;
wire [4:0] Rs1E,Rs2E;    //new added

decode DECODE_STAGE (
    .clk         (clk),
    .rst         (rst),
    .FlushE (FlushE),
    .InstrD      (InstrD),
    .PCD         (PCD),
    .PCPlus4D    (PCPlus4D),
    .RegWriteW   (RegWriteW),
    .RdW         (RdW),
     .ResultW     (ResultW),
    .RegWriteE   (RegWriteE),
    .ResultSrcE  (ResultSrcE),
    .MemWriteE   (MemWriteE),
    .JumpE       (JumpE),
    .BranchE     (BranchE),
    .ALUControlE (ALUControlE),
    .ALUSrcE     (ALUSrcE),
    .RD1E        (RD1E),
    .RD2E        (RD2E),
    .PCE         (PCE),
    .ImmExtE     (ImmExtE),
    .PCPlus4E    (PCPlus4E),
    .Rs1E        (Rs1E),    //new
    .Rs2E        (Rs2E),
    .RdE         (RdE)
);


//  STAGE 3 : EXECUTE

wire        RegWriteM;
wire [1:0]  ResultSrcM;
wire        MemWriteM;
wire [31:0] ALUResultM;
wire [31:0] WriteDataM;
wire [4:0]  RdM;
wire [31:0] PCPlus4M;
wire [1:0]ForwardAE ,ForwardBE;

execute EXECUTE_STAGE (
    .clk         (clk),
    .rst         (rst),
    .ResultW(ResultW), .ForwardAE(ForwardAE), .ForwardBE(ForwardBE),
    .RegWriteE   (RegWriteE),
    .ResultSrcE  (ResultSrcE),
    .MemWriteE   (MemWriteE),
    .JumpE       (JumpE),
    .BranchE     (BranchE),
    .ALUControlE (ALUControlE),
    .ALUSrcE     (ALUSrcE),
    .RD1E        (RD1E),
    .RD2E        (RD2E),
    .PCE         (PCE),
    .ImmExtE     (ImmExtE),
    .PCPlus4E    (PCPlus4E),
    .RdE         (RdE),
    .PCSrcE      (PCSrcE),
    .PCTargetE   (PCTargetE),
    .RegWriteM   (RegWriteM),
    .ResultSrcM  (ResultSrcM),       //hazard mei jana last bit 0 bit 
    .MemWriteM   (MemWriteM),
    .ALUResultM  (ALUResultM),
    .WriteDataM  (WriteDataM),
    .RdM         (RdM),
    .PCPlus4M    (PCPlus4M)
);


//  STAGE 4 : MEMORY


wire [1:0]  ResultSrcW;
wire [31:0] ALUResultW;          
wire [31:0] ReadDataW;
wire [31:0] PCPlus4W;




Memory MEMORY_STAGE (
    .clk         (clk),        
    .rst         (rst),          
    .RegWriteM   (RegWriteM),
    .ResultSrcM  (ResultSrcM),
    .MemWriteM   (MemWriteM),
    .ALUResultM  (ALUResultM),
    .WriteDataM  (WriteDataM),
    .RdM         (RdM),
    .PCPlus4M    (PCPlus4M),
    .RegWriteW   (RegWriteW),
    .ResultSrcW  (ResultSrcW),
    .ALUResultW  (ALUResultW),   
    .ReadDataW   (ReadDataW),
    .RdW         (RdW),
    .PCPlus4W    (PCPlus4W)
);


//  STAGE 5 : WRITEBACK

WriteBack WRITEBACK_STAGE (
    .RegWriteW   (RegWriteW),
    .ResultSrcW  (ResultSrcW),
    .ALUResultW  (ALUResultW),   
    .ReadDataW   (ReadDataW),
    .RdW         (RdW),
    .PCPlus4W    (PCPlus4W),
    .ResultW     (ResultW)
);



hazard_unit H1(
            .Rs1D(InstrD[19:15]), .Rs2D(InstrD[24:20]), 
            .Rs1E(Rs1E), .Rs2E(Rs2E),
            .RdE(RdE), .RdM(RdM),.RdW(RdW),
           .PCSrcE(PCSrcE), .RegWriteM(RegWriteM),.RegWriteW(RegWriteW), 
            .ResultSrcE(ResultSrcE[0]),
            
            .StallF(StallF), .StallD(StallD),.FlushD(FlushD),.FlushE(FlushE),
            .ForwardAE(ForwardAE),.ForwardBE(ForwardBE)
                        
            );


endmodule
