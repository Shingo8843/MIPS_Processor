`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2022 03:34:50 PM
// Design Name: 
// Module Name: Register
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


module Register#(parameter Size = 32) (
    input CLK,
    input RegEN,
    input [Size-1:0] PCIn,
    output [Size-1:0] PCOut
    );
    reg [Size-1:0] REGISTER = 0;
    always @(posedge CLK) if(RegEN) REGISTER <= PCIn;
    assign PCOut = REGISTER;
endmodule
