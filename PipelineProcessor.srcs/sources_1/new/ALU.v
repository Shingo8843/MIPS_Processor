`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2022 01:53:55 PM
// Design Name: 
// Module Name: ALU
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


module ALU#(Size = 8)(
    input [3:0] ALU_select,
    input [Size-1: 0] A,B,
    input [4:0] shamt,
    output reg [Size-1: 0] OUT,
    output reg CO
    );
    always@(*) begin
        case(ALU_select) 
            4'b0000:begin OUT <= A + B;CO = 0;end//Addition
            4'b0001:begin OUT <= A - B; if((A - B) == 0)CO = 1; end//Subtraction
            4'b0010:begin OUT <= B <<shamt;CO = 0;end//Logical Left
            4'b0011:begin OUT <= B >>shamt;CO = 0;end//Logical Right
            4'b0100:begin OUT <= B <<A;CO = 0;end//Logical Variable Left
            4'b0101:begin OUT <= B >>A;CO = 0;end//Logical Variable Right
            4'b0110:begin OUT <= B>>>shamt;CO = 0;end//Arithmetic Right
            4'b0111:begin OUT <= A & B;CO = 0;end//AND
            4'b1000:begin OUT <= A | B;CO = 0;end//OR
            4'b1001:begin OUT <= A ^ B;CO = 0;end//XOR
            4'b1010:begin OUT <=~(A^B);CO = 0;end//XNOR
            4'b1011:begin OUT <= B>>>A;CO = 0;end
            4'b1100:OUT <= 0;
            4'b1101:OUT <= 0;
            4'b1110:OUT <= 0;
            4'b1111:OUT <= 0;
        endcase 
    end
endmodule

