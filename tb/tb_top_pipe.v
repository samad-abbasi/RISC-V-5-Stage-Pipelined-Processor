`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 07:27:34 PM
// Design Name: 
// Module Name: tb_top_pipe
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

module tb_top_pipe;

    reg clk;
    reg rst;

    top_pipe uut (
        .clk(clk),
        .rst(rst)
    );

    // Clock
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;

        #20;
        rst = 0;

        #300;

        $finish;
    end

initial begin

$monitor(
"Time=%0t | clk=%b | rst=%b | PCF=%h | RD_F=%h | PCD=%h | INSND=%h | Rs1E=%0d Rs2E=%0d RdE=%0d RdM=%0d RdW=%0d | FAE=%b FBE=%b | PCSrcE=%b BranchE=%b JumpE=%b | StallF=%b StallD=%b FlushD=%b FlushE=%b | PCTargetE=%h | ResultW=%h | x1=%h x2=%h x3=%h x4=%h x5=%h x6=%h x7=%h x8=%h x9=%h x10=%h",

    $time,
    uut.clk,
    uut.rst,

    // Fetch
    uut.FETCH_STAGE.PCF,
    uut.FETCH_STAGE.RD_F,

    // Decode
    uut.PCD,
    uut.InstrD,

    // Hazard tracking
    uut.Rs1E,
    uut.Rs2E,
    uut.RdE,
    uut.RdM,
    uut.RdW,

    uut.ForwardAE,
    uut.ForwardBE,

    // Branch / Jump
    uut.PCSrcE,
    uut.BranchE,
    uut.JumpE,

    // Stall / Flush
    uut.StallF,
    uut.StallD,
    uut.FlushD,
    uut.FlushE,

    // Target PC
    uut.PCTargetE,

    // Writeback
    uut.ResultW,

    // Register file
    uut.DECODE_STAGE.RF_1.reg_memory[1],
    uut.DECODE_STAGE.RF_1.reg_memory[2],
    uut.DECODE_STAGE.RF_1.reg_memory[3],
    uut.DECODE_STAGE.RF_1.reg_memory[4],
    uut.DECODE_STAGE.RF_1.reg_memory[5],
    uut.DECODE_STAGE.RF_1.reg_memory[6],
    uut.DECODE_STAGE.RF_1.reg_memory[7],
    uut.DECODE_STAGE.RF_1.reg_memory[8],
    uut.DECODE_STAGE.RF_1.reg_memory[9],
    uut.DECODE_STAGE.RF_1.reg_memory[10]

);

end
endmodule