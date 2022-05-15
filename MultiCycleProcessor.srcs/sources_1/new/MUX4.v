`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2022 06:02:30 PM
// Design Name: 
// Module Name: MUX4
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


module MUX4#(parameter Size = 32)(
    input [1:0] INSelect,
    input [Size-1:0] MUXIN00,
    input [Size-1:0] MUXIN01,
    input [Size-1:0] MUXIN10,
    input [Size-1:0] MUXIN11,
    output [Size-1:0] MUXOut
    );
    assign MUXOut = INSelect[1] ? (INSelect[0] ? MUXIN11 : MUXIN10) : (INSelect[0] ? MUXIN01 : MUXIN00);
endmodule
