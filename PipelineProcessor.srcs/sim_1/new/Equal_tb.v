`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2022 10:32:59 AM
// Design Name: 
// Module Name: Equal_tb
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


module Equal_tb;
    reg [31:0] Ein1 = 32'd0;
    reg [31:0] Ein2 = 32'd1;
    wire EqualD;
    Equal E00(
        .Ein1(Ein1),
        .Ein2(Ein2),
        .EqualD(EqualD)
    );
    initial begin
        Ein1 = 32'd0;Ein2 = 32'd1;
        #10;Ein1 = 32'd1;Ein2 = 32'd1;
        #10;Ein1 = 32'hFFFFFFFF;Ein2 = 32'hFFFFFFF0;
        #10;Ein1 = 32'hFFFFFFFF;Ein2 = 32'hFFFFFFFF;
        #10;$finish;
    end
endmodule
