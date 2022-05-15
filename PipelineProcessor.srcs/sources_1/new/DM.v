`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2022 01:52:42 PM
// Design Name: 
// Module Name: DM
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


module DM #(parameter AWL = 32, DWL = 32)(
    input CLK,DMWE,
    input [AWL-1:0] DMA,
    input [DWL-1:0] DMWD,
    output [DWL-1:0] DMRD
    );
    parameter unsigned S = 2**AWL - 1;
    reg [DWL-1:0] ram [0:511];
    initial $readmemb("DataMemory.mem",ram);
    always@(posedge CLK) begin
        if(DMWE) ram[DMA] <= DMWD;
    end
    assign DMRD = ram[DMA];
endmodule

