`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 10:31:47 AM
// Design Name: 
// Module Name: lw_tb
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


module lw_tb;
reg CLK = 1;
parameter ClockPeriod = 10;
wire [5:0] opcode,func;
wire [4:0] rs,rt,rd,shamt;
wire [15:0] imm;
wire [25:0] jump;

reg [4:0] MA;
wire [31:0] MRD;

wire [31:0] Simm;

wire MtoRFSel;
wire DMWE;
wire Branch;
wire ALUInSel;
wire RFDSel;
wire RFWE;
wire [1:0] ALUOp;

wire [3:0] ALUSel;
wire CO;

wire [31:0] DMOut;
wire [31:0] ALUOut;
wire [31:0] RFRD1,RFRD2;
//wire [31:0] SE
IM IM00(
    .MA(MA),
    .MRD(MRD)
);
Instruction_Decoder ID00(
    .Instruction(MRD),
    .opcode(opcode),
    .func(func),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .shamt(shamt),
    .imm(imm),
    .jump(jump)
    );
SignExtend #(
    .SizeIn(16),
    .SizeOut(32)
    )
    SEIMM(
    .SEin(imm),
    .SEout(Simm)
);
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
RF RF00(
    .CLK(CLK),
    .RFWE(RFWE),
    .RFRA1(rs) ,//read
    .RFRA2(rt),//read
    .RFWA(rt),//write address
    .RFWD(DMOut), //Write data
    .RFRD1(RFRD1),//Read Data
    .RFRD2(RFRD2)//Read Data
    );
DM DM00(
    .CLK(CLK),
    .DMWE(DMWE),
    .DMA(ALUOut),
    .DMWD(RFRD2),
    .DMRD(DMOut)
    );    
ALU#(.Size(32))
ALU00(
    .ALU_select(ALUSel),
    .A(RFRD1),
    .B(Simm),
    .OUT(ALUOut),
    .CO(CO)
    );
always CLK = #(ClockPeriod / 2) ~CLK;
initial begin
    MA <= 5'b00000;
    #10;    MA <= 5'b00001;
    #10;    MA <= 5'b00010;    
    #10;    MA <= 5'b00011;
    #10;    MA <= 5'b00100;
    
    #10;    MA <= 5'b00101;
    #10;    MA <= 5'b00110;
    #10;    MA <= 5'b00111;
    #10;    MA <= 5'b01000;
    #10;    MA <= 5'b01001;
    
//    #10;    MA <= 5'b01010;
//    #10;    MA <= 5'b01011;
//    #10;    MA <= 5'b01100;
//    #10;    MA <= 5'b01101;
//    #10;    MA <= 5'b01110;
    
    
    #100;$finish;
end 
    
    
endmodule