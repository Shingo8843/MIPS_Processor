`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2022 01:54:59 PM
// Design Name: 
// Module Name: IM
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


module IM #(parameter AWL = 32, DWL = 32)(
    input [AWL-1:0] MA,
    output [DWL-1:0] MRD
    );
    reg [DWL-1:0] rom [0:256-1];
    initial $readmemb("init.mem",rom);
    assign MRD = rom[MA];
endmodule

