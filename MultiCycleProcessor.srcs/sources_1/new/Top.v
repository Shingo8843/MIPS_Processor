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
    //Enable Signal
    wire IRWE;
    wire DMWE;
    wire PCWE;
    wire Branch;
    wire RFWE;
    wire [1:0] ALUOp;
    //Select Signal
    wire MtoRFSel;
    wire RFDSel;
    wire IDSel;
    wire [1:0] PCSel;
    wire [1:0] ALUIn2Sel;
    wire ALUIn1Sel;
    wire [3:0] ALUSel;
    //PC
    wire [31:0] PCIn;
    wire [31:0] PCOut;
    
    //Register Output
    wire [31:0] IR;
    wire [31:0] ALUOutR;
    wire [4:0] rtd;
    //MuxOut
    wire [31:0] MRA;
    
    //MEM 
    wire [31:0] MWD;
    wire [31:0] MRD;
    
    //INST DECODER
    wire [5:0] opcode,func;
    wire [4:0] rs,rt,rd,shamt;
    wire [15:0] imm;
    wire [25:0] jump;
    //Sign Extend
    wire [31:0] Simm;
    
    wire [31:0] RFRD1,RFRD2;
    wire [31:0] A,B;
    wire [31:0] ALUOut;
    wire [31:0] DR;
    wire [31:0] ALUIn1,ALUIn2;
    wire [31:0] RFWD;
    wire Zero;
    wire PC01,PC02;
    //Modules    
    Instruction_Decoder ID00(
        .Instruction(IR),
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
    
    ALU_Decoder AD00(
        .ALUOp(ALUOp),
        .func(func),
        .ALUSel(ALUSel)
    );
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
    Register PC00(
        .CLK(CLK),
        .RegEN(PC02),
        .PCIn(PCIn ),
        .PCOut(PCOut)
    );
    MUX #(.Size(32)) 
    MUXRFWD00(
        .INSelect(MtoRFSel),
        .MUXIN0(ALUOutR),
        .MUXIN1(DR),
        .MUXOut(RFWD)  
    );
    MUX #(.Size(32)) 
    MUXMEM00(
        .INSelect(IDSel),
        .MUXIN0(PCOut),
        .MUXIN1(ALUOutR),
        .MUXOut(MRA)  
    );
    DM MEM00(//Reads DataMemory.mem
        .CLK(CLK),
        .DMWE(DMWE),
        .DMA(MRA),
        .DMWD(B),
        .DMRD(MRD)
    );
    Register IR00(//instruction register
        .CLK(CLK),
        .RegEN(IRWE),
        .PCIn(MRD),
        .PCOut(IR)
    );
    MUX #(.Size(5)) MUXRFD(
        .INSelect(RFDSel),
        .MUXIN0(rt),
        .MUXIN1(rd),
        .MUXOut(rtd)
    );
    RF RF00(
        .CLK(CLK),
        .RFWE(RFWE),
        .RFRA1(rs) ,//read
        .RFRA2(rt),//read
        .RFWA(rtd),//write address
        .RFWD(RFWD), //Write data
        .RFRD1(RFRD1),//Read Data
        .RFRD2(RFRD2)//Read Data
    );
    Register A00(//instruction register
        .CLK(CLK),
        .RegEN(1),
        .PCIn(RFRD1),
        .PCOut(A)
    );
    Register B00(//instruction register
        .CLK(CLK),
        .RegEN(1),
        .PCIn(RFRD2),
        .PCOut(B)
    );
    MUX #(.Size(32)) MUXALU1(
        .INSelect(ALUIn1Sel),
        .MUXIN0(PCOut),
        .MUXIN1(A),
        .MUXOut(ALUIn1)
    );
    ALU ALU00(
        .ALU_select(ALUSel),
        .A(ALUIn1),
        .B(ALUIn2),
        .shamt(shamt),
        .OUT(ALUOut),
        .CO(Zero)
    );
    MUX4 MUXALU2(
        .INSelect(ALUIn2Sel),
        .MUXIN00(B),
        .MUXIN01(1),
        .MUXIN10(Simm),
        .MUXIN11(0),
        .MUXOut(ALUIn2)
    );
    Register ALUOutR00(//instruction register
        .CLK(CLK),
        .RegEN(1),
        .PCIn(ALUOut),
        .PCOut(ALUOutR)
    );
    Register DR00(//instruction register
        .CLK(CLK),
        .RegEN(1),
        .PCIn(MRD),
        .PCOut(DR)
    );
    ANDGate
    ANDBranch(
        .a(Zero&1),
        .b(Branch&1),
        .ANDResult(PC01)
    );
    ORGate
    PCENOR(
        .a(PC01),
        .b(PCWE),
        .ORResult(PC02)
    );
    MUX4 MUXPC4(
        .INSelect(PCSel),
        .MUXIN00(ALUOut),
        .MUXIN01(ALUOutR),
        .MUXIN10({ALUOutR[31:26],jump}),
        .MUXIN11(0),
        .MUXOut(PCIn)
    );
endmodule


//Time lag in loading instruction
//MUX #(.Size(32)) 
//    MUXMEM(
//        .INSelect(),
//        .MUXIN0(),
//        .MUXIN1(),
//        .MUXOut()
//    );