`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2022 09:17:44 AM
// Design Name: 
// Module Name: MUX_tb
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


module MUX_tb;
reg INSelect;
reg [4:0] MUXIN0,MUXIN1;
wire [4:0] MUXOut;
MUX MUX00(
    .INSelect(INSelect),
    .MUXIN0(MUXIN0),
    .MUXIN1(MUXIN1),
    .MUXOut(MUXOut)
    );
    initial begin
        MUXIN0 <= 5'b00000;
        MUXIN1 <= 5'b11111;
        INSelect <= 1'b1;
        #20;
        INSelect <=1'b0;
        
        #20;
        MUXIN0 <= 5'b01010;
        
        #200;$finish;
    end
endmodule
