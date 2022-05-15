`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 02:55:53 PM
// Design Name: 
// Module Name: Program_Counter
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


module Program_Counter#(parameter Size = 32) (
    input CLK,
    input [Size-1:0] PCIn,
    output [Size-1:0] PCOut
    );
    reg [Size-1:0] COUNTER = 0;
    always @(posedge CLK) COUNTER <= PCIn;
    assign PCOut = COUNTER;
endmodule
