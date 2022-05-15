`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 11:05:42 AM
// Design Name: 
// Module Name: SignExtend
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


module SignExtend #(SizeIn = 16,SizeOut = 32)(
    input [SizeIn-1:0] SEin,
    output [SizeOut-1:0] SEout
    );
    assign SEout = { {(SizeOut-SizeIn){SEin[SizeIn-1]}}, SEin[SizeIn-1:0] };
endmodule
