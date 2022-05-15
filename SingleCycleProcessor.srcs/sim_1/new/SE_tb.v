`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 11:10:38 AM
// Design Name: 
// Module Name: SE_tb
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

module SE_t;
    reg [15:0] SEin;
    wire [31:0] SEout;
    
    SignExtend #(
    .SizeIn(16),
    .SizeOut(32)
    )
    SE00(
    .SEin(SEin),
    .SEout(SEout)
    );
    initial begin
        SEin <= 16'hFFFF;
        #10;    SEin <= 16'h0FFF;
        #10;    SEin <= 16'hF000;    
        #10;    SEin <= 16'h0000;
        #10;$finish;
    end 

endmodule
