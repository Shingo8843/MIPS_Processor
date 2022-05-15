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
    output reg [5:0] opcode,
    output reg [5:0] func,
    output reg [4:0] rs,
    output reg [4:0] rt,
    output reg [4:0] rd,
    output reg [4:0] shamt,
    output reg [15:0] imm,
    output reg [25:0] jump
    );
    parameter lw = 6'b100011;
    
    always @(*) begin
        opcode = Instruction[31:26];
        func = Instruction[5:0];
        rs = Instruction[25:21];
        rt = Instruction[20:16];
        rd = Instruction[15:11];
        shamt = Instruction[11:6];
        imm = Instruction[15:0];
        jump = Instruction[25:0];
    end
endmodule
