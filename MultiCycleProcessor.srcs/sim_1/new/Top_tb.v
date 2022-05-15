`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 04:05:22 PM
// Design Name: 
// Module Name: Top_tb
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


module Top_tb;
    parameter ClockPeriod = 10;
    reg CLK = 0;
    Top Top00(
    .CLK(CLK)
    );
    always CLK = #(ClockPeriod / 2) ~CLK;
    initial begin
        #2000;$finish;
    end
endmodule
