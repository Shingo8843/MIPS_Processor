`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2022 01:56:42 PM
// Design Name: 
// Module Name: Assignment0_tb
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


module Main_tb;
    reg CLK = 1;
    parameter ClockPeriod = 10;
    ////////////////////////RF
    reg RFWE = 0;
    reg [4:0] RFR1,RFR2,RFWA;
    reg [31:0] RFWD;
    wire [31:0] RFRD1,RFRD2;
    ///////////////////////IM
    reg [4:0] MA;
    wire [31:0] MRD;
    ///////////////////////DM
    reg WE = 0;
    reg [4:0] DMA;
    reg [31:0] DMWD;
    wire [31:0] DMRD;
    //////////////////////ALU
    reg [3:0] ALU_select;
    reg [7:0] A,B;
    wire [7:0] OUT;
    wire CO;
    /////////////
    ALU ALU00(
        .ALU_select(ALU_select),
        .A(A),
        .B(B),
        .OUT(OUT),
        .CO(CO)
    );
    DM DM00(
    .CLK(CLK),
    .WE(WE),
    .DMA(DMA),
    .DMWD(DMWD),
    .DMRD(DMRD)
    );
    
    IM IM00(
        .MA(MA),
        .MRD(MRD)
    );
    RF RF00(
        .CLK(CLK),
        .RFWE(RFWE),
        .RFRA1(RFR1),//read
        .RFRA2(RFR2),//read
        .RFWA(RFWA),//write address
        .RFWD(RFWD), //Write data
        .RFRD1(RFRD1),//Read Data
        .RFRD2(RFRD2)//Read Data
    );
    ////////////////////////////////////////////
    
    always CLK = #(ClockPeriod / 2) ~CLK;
    ////////////////////RF
    initial begin
        RFWE = 0;
        RFR1 = 5'b00000;
        RFR2 = 5'b00001;
        RFWA = 5'b00000;
        RFWD = 32'hFFFFFFFF;
        #20;RFWE = 1;
        #20;RFWA = 5'b00001;RFWD = 32'h0000FFFF;
        #210; $finish;
    end
    /////////////////////DM
    initial begin
        DMA = 5'b00000;
        DMWD = 32'hFFFFFFFF;
        #20;
        WE = 1;
        #10;WE = 0;
        #10;DMWD = 32'h0000FFFF;WE = 1;
        #210; $finish;
    end
    /////////////IM
    initial begin
        MA = 3'b000;
        #250; $finish;
    end
    ////////ALU
    initial begin
        A = 8;B = 4;
        ALU_select = 4'b0000;
        #20;ALU_select = 4'b0001;
        #20;ALU_select = 4'b0010;
        #20;ALU_select = 4'b0011;
        #20;ALU_select = 4'b0100;
        #20;ALU_select = 4'b0101;
        #20;ALU_select = 4'b0110;
        #20;ALU_select = 4'b0111;
        #20;ALU_select = 4'b1000;
        #20;ALU_select = 4'b1001;
        #20;ALU_select = 4'b1010;
        #20;ALU_select = 4'b1011;
        #30; $finish;
    end
endmodule

