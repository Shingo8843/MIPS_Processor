`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2022 08:35:18 PM
// Design Name: 
// Module Name: Control_Unit_tb
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


module Control_Unit_tb;
    reg CLK = 1;
    reg [5:0] opcode;
    wire MtoRFSel;
    wire RFDSel;
    wire IDSel;
    wire [1:0] PCSel;
    wire [1:0] ALUIn2Sel;
    wire ALUIn1Sel;
    wire IRWE;
    wire DMWE;
    wire PCWE;
    wire Branch;
    wire RFWE;
    wire [1:0] ALUOp;
    Main_Decoder MD00(
        .CLK(CLK),
        .opcode(opcode),
        .MtoRFSel(MtoRFSel),
        .RFDSel(RFDSel),
        .IDSel(IDSel),
        .PCSel(PCSel),
        .ALUIn2Sel(ALUIn2Sel),
        .ALUIn1Sel(ALUIn1Sel),
        .IRWE(IRWE),
        .DMWE(DMWE),
        .PCWE(PCWE),
        .Branch(Branch),
        .RFWE(RFWE),
        .ALUOp(ALUOp)
    );
    parameter Rtype = 6'b000000;
    parameter lw = 6'b100011;
    parameter sw = 6'b101011;
    parameter beq = 6'b000100;
    parameter addi = 6'b001000;
    parameter jump = 6'b000010;
    parameter ClockPeriod = 10;
    always CLK = #(ClockPeriod / 2) ~CLK;
    initial begin
        opcode = Rtype;#40;
        opcode = lw;#50;
        opcode = sw;#40;
        opcode = beq;#30;
        opcode = addi;#40;
        opcode = jump;#30;
        
        #10;$finish;
    end
endmodule
