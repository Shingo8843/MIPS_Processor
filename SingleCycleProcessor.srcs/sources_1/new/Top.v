`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 02:51:58 PM
// Design Name: 
// Module Name: Top
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


module Top(
    input CLK
    );
    wire [31:0] PCIn,PCJumpOut,PCJumpIn,PCBranchOut,PCBranchIn,PCOut;
    parameter ClockPeriod = 10;
    wire [5:0] opcode,func;
    wire [4:0] rs,rt,rd,shamt,rtd;
    wire [15:0] imm;
    wire [25:0] jump;
    wire [31:0] MRD;
    wire [31:0] Simm;
    wire JUMPSel,PCSel,MtoRFSel,DMWE,Branch,ALUInSel,RFDSel,RFWE,CO;
    wire [1:0] ALUOp;
    wire [3:0] ALUSel;
    wire [31:0] DMOut,ALUDM,ALUOut,RFRD1,RFRD2,ALUIn2;
    //wire [31:0] SE
    Program_Counter 
    #(.Size(32))
    PC00(
        .CLK(CLK),
        .PCIn(PCJumpOut),
        .PCOut(PCOut)
    );
    
    Adder
    #(.SizeA(32))
    ADDERPC(
        .a(PCOut),
        .b(1),
        .sum(PCIn)
    );
    
    Adder
    #(.SizeA(32))
    ADDERBranch(
    .a(PCIn),
    .b(Simm),
    .sum(PCBranchIn)
    );
    
    ANDGate
    ANDBranch(
    .a(CO&&1),
    .b(Branch&&1),
    .ANDResult(PCSel)
    );
    
    MUX #(.Size(32)) 
    MUXBeq(
        .INSelect(PCSel),
        .MUXIN0(PCIn),
        .MUXIN1(PCBranchIn),
        .MUXOut(PCBranchOut)
    );
    MUX #(.Size(32)) 
    MUXJUMP(
        .INSelect(JUMPSel),
        .MUXIN0(PCBranchOut),
        .MUXIN1({PCIn[31:26],jump}),
        .MUXOut(PCJumpOut)
    );
    IM IM00(
        .MA(PCOut[4:0]),
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
        .ALUOp(ALUOp),
        .JUMPSel(JUMPSel)
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
        .RFWA(rtd),//write address
        .RFWD(ALUDM), //Write data
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
        .B(ALUIn2),
        .shamt(shamt),
        .OUT(ALUOut),
        .CO(CO)
        );
    MUX #(.Size(32)) MUXALU(
        .INSelect(ALUInSel),
        .MUXIN0(RFRD2),
        .MUXIN1(Simm),
        .MUXOut(ALUIn2)
    );
    MUX #(.Size(5)) MUXRFD(
        .INSelect(RFDSel),
        .MUXIN0(rt),
        .MUXIN1(rd),
        .MUXOut(rtd)
    );
    MUX #(.Size(32)) MUXDM(
        .INSelect(MtoRFSel),
        .MUXIN0(ALUOut),
        .MUXIN1(DMOut),
        .MUXOut(ALUDM)
    );
endmodule
