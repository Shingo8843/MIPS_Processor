`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2022 01:55:58 PM
// Design Name: 
// Module Name: RF
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


module RF#(parameter AWL = 5, DWL = 32)(
    input CLK,RFWE,
    input [AWL-1:0] RFRA1,//read
    input [AWL-1:0] RFRA2,//read
    input [AWL-1:0] RFWA,//write address
    input [DWL-1:0] RFWD, //Write data
    output [DWL-1:0] RFRD1,//Read Data
    output [DWL-1:0] RFRD2//Read Data
    );
    
    reg [DWL-1:0] ram [0:2**AWL-1];
    initial $readmemb("REGISTER.mem",ram);
    always @(posedge CLK)begin
        if(RFWE) ram[RFWA] <= RFWD;
        ram[0] <= 0;
    end
    assign RFRD1 = ram[RFRA1];
    assign RFRD2 = ram[RFRA2];
endmodule

