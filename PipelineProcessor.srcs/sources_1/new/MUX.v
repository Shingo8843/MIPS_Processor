`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 04:51:48 PM
// Design Name: 
// Module Name: MUX
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


module MUX#(parameter Size = 5)(
    input INSelect,
    input [Size-1:0] MUXIN0,
    input [Size-1:0] MUXIN1,
    output [Size-1:0] MUXOut
    );
    assign MUXOut = INSelect?MUXIN1:MUXIN0;
endmodule
