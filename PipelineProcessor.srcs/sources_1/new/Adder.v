`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 11:01:28 AM
// Design Name: 
// Module Name: Adder
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


module Adder
#(
    parameter SizeA = 32
)
(
    input signed [SizeA -1 :0] a,
    input signed [SizeA -1 :0] b,
    output signed [SizeA-1 :0] sum
);
    assign sum = a + b;
endmodule

