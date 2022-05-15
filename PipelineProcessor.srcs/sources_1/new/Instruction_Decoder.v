`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 09:52:43 AM
// Design Name: 
// Module Name: Instruction_Decoder
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


module Instruction_Decoder(
    input [31:0] Instruction,
    output  [5:0] opcode,
    output  [5:0] func,
    output  [4:0] rs,
    output  [4:0] rt,
    output  [4:0] rd,
    output  [4:0] shamt,
    output  [15:0] imm,
    output  [25:0] jump
    );
    parameter lw = 6'b100011;
    
    
    assign opcode = Instruction[31:26];
    assign func = Instruction[5:0];
    assign rs = Instruction[25:21];
    assign rt = Instruction[20:16];
    assign rd = Instruction[15:11];
    assign shamt = Instruction[11:6];
    assign imm = Instruction[15:0];
    assign jump = Instruction[25:0];
    
endmodule
