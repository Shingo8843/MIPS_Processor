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
    wire Stall;
    wire ForwardAD;
    wire ForwardBD;
    wire [1:0] ForwardAE;
    wire [1:0] ForwardBE;
    wire EqualD;
    wire [31:0] ALUIn1E,ALUIn2E;
    wire [31:0] Ein1,Ein2;
    MUX #(.Size(32)) MUXAD(//MEMORY[68:37],MEMORY[36:5]
        .INSelect(ForwardAD),
        .MUXIN0(RFRD1),
        .MUXIN1(EXECUTE[100:69]),
        .MUXOut(Ein1)
    );
    MUX #(.Size(32)) MUXBD (//MEMORY[68:37],MEMORY[36:5]
        .INSelect(ForwardBD),
        .MUXIN0(RFRD2),
        .MUXIN1(EXECUTE[100:69]),
        .MUXOut(Ein2)
    );
    MUX4 MUXAE(
        .INSelect(ForwardAE),
        .MUXIN00(DECODE[105:74]),
        .MUXIN01(ALUDM),
        .MUXIN10(EXECUTE[100:69]),
        .MUXIN11(0),
        .MUXOut(ALUIn1E)
    );
    MUX4 MUXBE(
        .INSelect(ForwardBE),
        .MUXIN00(DECODE[73:42]),
        .MUXIN01(ALUDM),
        .MUXIN10(EXECUTE[100:69]),
        .MUXIN11(0),
        .MUXOut(ALUIn2E)
    );
    ALU#(.Size(32))
    ALU00(
        .ALU_select(DECODE[111:108]),//ALUSel
        .A(ALUIn1E),//RFRD1
        .B(ALUIn2),//ALUIn2
        .shamt(DECODE[152:148]),//shamt
        .OUT(ALUOut),
        .CO(CO)
        );
    Equal #(.Size(32)) 
    E00(
        .Ein1(Ein1),
        .Ein2(Ein2),
        .EqualD(EqualD)
    );
    
    Register #(.Size(32))
    PC00(
        .CLK(CLK),
        .CLR(1'b0),
        .RegEN(!Stall),
        .PCIn(PCJumpOut),
        .PCOut(PCOut)
    );
    HazardUnit HZ00(
        .CLK(CLK),
        .rtD(rt),
        .rtE(DECODE[41:37]),
        .rsD(rs),
        .rsE(DECODE[157:153]),
        .rtdE(rtd),
        .rtdM(EXECUTE[36:32]),
        .rtdW(MEMORY[4:0]),
        .BranchD(Branch),
        .MtoRFSelE(DECODE[114]),
        .MtoRFSelM(EXECUTE[104]),
        .RFWEE(DECODE[115]),
        .RFWEM(EXECUTE[105]),
        .RFWEW(MEMORY[70]),
        .Stall(Stall),
        .ForwardAD(ForwardAD),
        .ForwardBD(ForwardBD),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE)
    );
    //Pipelines
    wire [63:0] FETCH;
    Register #(.Size(64))//Top32 = Instruction //Lower32 = Clock
    FETCH00(
        .CLK(!CLK),
        .CLR(1'b0),
        .RegEN(!Stall),
        .PCIn({MRD,PCIn}),
        .PCOut(FETCH)
    );
    //(RFWE-1 MtoRFSel-1 DMWE-1 Branch-1 ALUSel-4 ALUInSel-1 RFDSel-1)-9
    wire [157:0] DECODE;
    Register #(.Size(158))//9-Control Signal 32-RFRD1 32-RFRD2 5-rt 5-rd 32-Simm
    DECODE00(
        .CLK(!CLK),
        .CLR(Stall),
        .RegEN(1'b1),
        .PCIn({rs,shamt,FETCH[31:0],RFWE,MtoRFSel,DMWE,Branch,ALUSel,ALUInSel,RFDSel,RFRD1,RFRD2,rt,rd,Simm}),
        .PCOut(DECODE)//DECODE[157:153] DECODE[152:148],DECODE[147:116],DECODE[115:112],DECODE[111:108],DECODE[107],DECODE[106],DECODE[105:74],DECODE[73:42],DECODE[41:37],DECODE[36:32],DECODE[31:0]
    );
    //(RFWE-1 MtoRFSel-1 DMWE-1 Branch-1 )-4
    wire [105:0] EXECUTE;
    Register #(.Size(106))//4-Control Signal 1-Zero 32-ALUOut 32-DMIn 5-rtd 32-PCBranch
    EXECUTE00(
        .CLK(!CLK),
        .CLR(1'b0),
        .RegEN(1'b1),
        .PCIn({DECODE[115:112],CO,ALUOut,ALUIn2E,rtd,PCBranchIn}),
        .PCOut(EXECUTE)//EXECUTE[105:104],EXECUTE[103],EXECUTE[102],EXECUTE[101],EXECUTE[100:69],DECODE[68:37],EXECUTE[36:32],EXECUTE[31:0]
    );
    //(RFWE-1 MtoRFSel-1)-2
    wire [70:0] MEMORY;
    Register #(.Size(71))//2-Control Signal 32-ALUOut 32-DMOut rtd-5
    MEMORY00(
        .CLK(!CLK),
        .CLR(1'b0),
        .RegEN(1'b1),
        .PCIn({EXECUTE[105:104],EXECUTE[100:69],DMOut,EXECUTE[36:32]}),
        .PCOut(MEMORY)//MEMORY[70],MEMORY[69],MEMORY[68:37],MEMORY[36:5],MEMORY[4:0]
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
        .a(Branch),
        .b(EqualD),
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
        .MA(PCOut),
        .MRD(MRD)
    );
    Instruction_Decoder ID00(
        .Instruction(FETCH[63:32]),//InstrD
        .opcode(opcode),
        .func(func),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .shamt(shamt),
        .imm(imm),
        .jump(jump)
        );
    RF RF00(
        .CLK(CLK),
        .RFWE(MEMORY[70]),//RFWE
        .RFRA1(rs) ,//read
        .RFRA2(rt),//read
        .RFWA(MEMORY[4:0]),//write address//rtd
        .RFWD(ALUDM), //Write data
        .RFRD1(RFRD1),//Read Data
        .RFRD2(RFRD2)//Read Data
        );
    DM DM00(
        .CLK(CLK),
        .DMWE(EXECUTE[103]),//DEWE
        .DMA(EXECUTE[100:69]),//ALUOut
        .DMWD(EXECUTE[68:37]),//RFRD2
        .DMRD(DMOut)
        );    
    
    MUX #(.Size(32)) MUXALU(
        .INSelect(DECODE[107]),//ALUInSel
        .MUXIN0(ALUIn2E),//RFRD2
        .MUXIN1(DECODE[31:0]),//SImm
        .MUXOut(ALUIn2)
    );
    MUX #(.Size(5)) MUXRFD(
        .INSelect(DECODE[106]),//RFDSel
        .MUXIN0(DECODE[41:37]),//rt
        .MUXIN1(DECODE[36:32]),//rd
        .MUXOut(rtd)
    );//DECODE[41:37],DECODE[36:32]
    MUX #(.Size(32)) MUXDM(//MEMORY[68:37],MEMORY[36:5]
        .INSelect(MEMORY[69]),
        .MUXIN0(MEMORY[68:37]),//ALUOut
        .MUXIN1(MEMORY[36:5]),//DMOut
        .MUXOut(ALUDM)
    );
    
endmodule
