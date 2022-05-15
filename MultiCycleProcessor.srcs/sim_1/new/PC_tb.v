`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 02:59:58 PM
// Design Name: 
// Module Name: PC_tb
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


module PC_tb();
    parameter ClockPeriod = 10;
    reg CLK = 0;
    wire [31:0] PCIn;
    wire [31:0] PCOut;
    reg PCWE = 0;
    wire Zero;
    Register PC00(
        .CLK(CLK),
        .RegEN(PCWE),
        .PCIn(PCIn),
        .PCOut(PCOut)
    );
    ALU ALU00(
        .ALU_select(4'b0000),
        .A(PCOut),
        .B(1),
        .shamt(0),
        .OUT(PCIn),
        .CO(Zero)
    );
    
    always CLK = #(ClockPeriod / 2) ~CLK;
    initial begin
        #10;PCWE = 1;
        #100;PCWE = 0;
        #100;$finish;
        
    end
endmodule
