`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 11:53:08 AM
// Design Name: 
// Module Name: Control_Unit
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


module Control_Unit(
    input [5:0] opcode,
    input [5:0] func,
    output MtoRFSel,
    output DMWE,
    output Branch,
    output ALUInSel,
    output RFDSel,
    output RFWE,
    output ALUSel
);
    reg ALUOp;
    
endmodule
