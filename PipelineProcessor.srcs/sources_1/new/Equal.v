`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2022 10:28:02 AM
// Design Name: 
// Module Name: Equal
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


module Equal #(parameter Size = 32)(
    input [Size-1:0] Ein1,
    input [Size-1:0] Ein2,
    output EqualD
    );
    assign EqualD = (Ein1 == Ein2)?1'b1:1'b0;
endmodule
