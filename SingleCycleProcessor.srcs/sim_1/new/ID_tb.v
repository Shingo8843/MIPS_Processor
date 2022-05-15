`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 10:05:35 AM
// Design Name: 
// Module Name: ID_tb
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


module ID_tb;
reg [31:0] Instruction;
wire [5:0] opcode,func;
wire [4:0] rs,rt,rd,shamt;
wire [15:0] imm;
wire [25:0] jump;
Instruction_Decoder ID00(
    .Instruction(Instruction),
    .opcode(opcode),
    .func(func),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .shamt(shamt),
    .imm(imm),
    .jump(jump)
    );
initial begin
        Instruction <= 32'b00001100000000000000000000000000;
    #10;Instruction <= 32'b00001100000000000000000000000001;
    #10;$finish;
end 
    
    
endmodule
