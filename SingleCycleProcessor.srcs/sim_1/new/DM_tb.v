`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2022 12:35:10 PM
// Design Name: 
// Module Name: DM_tb
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


module DM_tb(

    );
    reg CLK = 0;
    reg DMWE = 0;
    reg [31:0] ALUOut,RFRD2;
    wire [31:0] DMOut;
    
DM DM00(
    .CLK(CLK),
    .DMWE(DMWE),
    .DMA(ALUOut),
    .DMWD(RFRD2),
    .DMRD(DMOut)
    ); 
endmodule
