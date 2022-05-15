`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2022 04:22:20 PM
// Design Name: 
// Module Name: HazardUnit
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


module HazardUnit(
    input CLK,
    input [4:0] rtD,
    input [4:0] rtE,
    input [4:0] rsD,
    input [4:0] rsE,
    input [4:0] rtdE,
    input [4:0] rtdM,
    input [4:0] rtdW,
    input BranchD,
    input MtoRFSelE,
    input MtoRFSelM,
    input RFWEE,
    input RFWEM,
    input RFWEW,
    output Stall,
    output reg ForwardAD,
    output reg ForwardBD,
    output reg [1:0] ForwardAE,
    output reg [1:0] ForwardBE
    );
    reg  LWStall = 0;
    reg  BRStall = 0;
    always@(*) begin
        if ((rsE!=5'b00000)&&(rsE==rtdW)&&RFWEW)
            ForwardAE <= 2'b01;
        else if((rsE!=5'b00000)&&(rsE==rtdM)&&RFWEM)
            ForwardAE <= 2'b10;
        
        else
            ForwardAE <= 2'b00;
    end
    
    always@(*) begin
        if ((rtE!=5'b00000)&&(rtE==rtdW)&&RFWEW)
            ForwardBE <= 2'b01;
        else if((rtE!=5'b00000)&&(rtE==rtdM)&&RFWEM)
            ForwardBE <= 2'b10;
        
        else
            ForwardBE <= 2'b00;
    end
    always@(*) begin
        if(((rsD == rtdE || rtD == rtdE) && BranchD && RFWEE) || ((rsD == rtdM || rtD == rtdM) && BranchD && MtoRFSelM))
            BRStall <= 1'b1;
        else
            BRStall <= 1'b0;
    end
    always@(*) begin
        if(MtoRFSelE && ((rtE == rsD) || (rtE == rtD)))
            LWStall <= 1'b1;
        else
            LWStall <= 1'b0;
    end
    always@(*) begin
        if((rsD != 0) && (rsD == rtdM) && RFWEM)
            ForwardAD <= 1'b1;
        else
            ForwardAD <= 1'b0;
    end
    always@(*) begin
        if((rtD != 0) && (rtD == rtdM) && RFWEM)
            ForwardBD <= 1'b1;
        else
            ForwardBD <= 1'b0;
    end
    assign Stall = LWStall || BRStall;
endmodule
