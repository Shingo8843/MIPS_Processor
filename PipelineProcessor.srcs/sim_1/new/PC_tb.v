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
    wire [4:0] PCIn;
    wire [4:0] PCOut;
    Program_Counter PC00(
        .CLK(CLK),
        .PCIn(PCIn),
        .PCOut(PCOut)
    );
    Adder
    #(.SizeA(5))
    ADDER00(
    .a(PCOut),
    .b(1),
    .sum(PCIn)
    );
    always CLK = #(ClockPeriod / 2) ~CLK;
    initial begin
        #100;$finish;
    end
endmodule
