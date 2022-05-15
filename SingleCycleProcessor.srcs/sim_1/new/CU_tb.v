`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2022 10:49:58 AM
// Design Name: 
// Module Name: CU_tb
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


module CU_tb(
    
    );
    parameter ClockPeriod = 10;
    reg [5:0] opcode,func;
    wire MtoRFSel;
    wire DMWE;
    wire Branch;
    wire ALUInSel;
    wire RFDSel;
    wire RFWE;
    wire [1:0] ALUOp;
    wire [3:0] ALUSel;
    Main_Decoder MD00(
        .opcode(opcode),
        .MtoRFSel(MtoRFSel),
        .DMWE(DMWE),
        .Branch(Branch),
        .ALUInSel(ALUInSel),
        .RFDSel(RFDSel),
        .RFWE(RFWE),
        .ALUOp(ALUOp)
    );  
    ALU_Decoder AD00(
        .ALUOp(ALUOp),
        .func(func),
        .ALUSel(ALUSel)
    );
    initial begin
        opcode <= 6'b000000;
        func <= 6'b100000;
        #10;func <= 6'b100010;
        #10;func <= 6'b100100;
        #10;func <= 6'b100101;
        #10;func <= 6'b101010;
        #200;$finish;
    end
endmodule
