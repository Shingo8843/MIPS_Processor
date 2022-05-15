`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2022 08:58:42 AM
// Design Name: 
// Module Name: HU_tb
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


module HU_tb;
    reg [4:0] rtD = 0;
    reg [4:0] rtE = 0;
    reg [4:0] rsD = 0;
    reg [4:0] rsE = 0;
    reg [4:0] tdD = 0;
    reg [4:0] rtdE = 0;
    reg [4:0] rtdM = 0;
    reg [4:0] rtdW = 0;
    reg BranchD = 0;
    reg MtoRFSelE = 0;
    reg MtoRFSelM = 0;
    reg RFWEE = 0;
    reg RFWEM = 0;
    reg RFWEW = 0;
    wire Stall;
    wire ForwardAD;
    wire ForwardBD;
    wire [1:0] ForwardAE;
    wire [1:0] ForwardBE;
    HazardUnit HZ00(
        .rtD(rtD),
        .rtE(rtE),
        .rsD(rsD),
        .rsE(rsE),
        .tdD(tdD),
        .rtdE(rtdE),
        .rtdM(rtdM),
        .rtdW(rtdW),
        .BranchD(BranchD),
        .MtoRFSelE(MtoRFSelE),
        .MtoRFSelM(MtoRFSelM),
        .RFWEE(RFWEE),
        .RFWEM(RFWEM),
        .RFWEW(RFWEW),
        .Stall(Stall),
        .ForwardAD(ForwardAD),
        .ForwardBD(ForwardBD),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE)
    );
    initial begin
        rsD = 4'b0010; rtdM = 4'b0010; RFWEM = 1'b1;//ForwardAD = 1
        #10;rsD = 4'b0000;rtD = 4'b0010;//ForwardBD = 1
        #10;rtdE = 4'b0010;BranchD = 1'b1;RFWEE = 1'b1;RFWEM = 1'b0; //StallBR = 1
        #10;rsD = 4'b0010;rtD = 4'b0000;//stallBR
        #10;MtoRFSelE = 1'b1;RFWEE = 1'b0;//stallLW
        #10;MtoRFSelM = 1'b0;rtE = 4'b0010; rsE = 4'b0010;RFWEM = 1'b1;rtdM = 4'b0010;rtdW = 4'b0000; //AE/BE=10
        #10;rtdM = 4'b0000;rtdW = 4'b0010; RFWEW = 1'b1;RFWEM = 1'b0; //AE/BE=10
        #10;$finish;
    end
    
endmodule
