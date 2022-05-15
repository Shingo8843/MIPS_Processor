`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 01:37:19 PM
// Design Name: 
// Module Name: Main_Decoder
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


module Main_Decoder(
    input [5:0] opcode,
    output reg MtoRFSel,
    output reg DMWE,
    output reg Branch,
    output reg ALUInSel,
    output reg RFDSel,
    output reg RFWE,
    output reg [1:0] ALUOp,
    output reg JUMPSel
    
);  
    parameter Rtype = 6'b000000;
    parameter lw = 6'b100011;
    parameter sw = 6'b101011;
    parameter beq = 6'b000100;
    parameter addi = 6'b001000;
    parameter lui = 6'b001111;
    parameter slti = 6'b001010;
    parameter jump = 6'b000010;
    always @(*) begin
        case (opcode)//1'bX
            Rtype:begin//change to combinational logic
                RFWE = 1;
                RFDSel = 1;
                ALUInSel = 0;
                Branch = 0;
                DMWE = 0;
                MtoRFSel = 0;
                ALUOp = 2'b10;
                JUMPSel = 0;
            end
            lw:begin
                RFWE = 1;
                RFDSel = 0;
                ALUInSel = 1;
                Branch = 0;
                DMWE = 0;
                MtoRFSel = 1;
                ALUOp = 2'b00;
                JUMPSel = 0;
            end
            sw:begin
                RFWE = 0;
                RFDSel = 1'bX;
                ALUInSel = 1;
                Branch = 0;
                DMWE = 1;
                MtoRFSel = 1'bX;
                ALUOp = 2'b00;
                JUMPSel = 0;
            end
            beq:begin
                RFWE = 0;
                RFDSel = 1'bX;
                ALUInSel = 0;
                Branch = 1;
                DMWE = 0;
                MtoRFSel = 1'bX;
                ALUOp = 2'b01;
                JUMPSel = 0;
            end
            addi:begin
                RFWE = 1;
                RFDSel = 0;
                ALUInSel = 1;
                Branch = 0;
                DMWE = 0;
                MtoRFSel = 0;
                ALUOp = 2'b00;
                JUMPSel = 0;
            end      
            jump:begin
                RFWE = 0;
                RFDSel = 1'bX;
                ALUInSel = 1'bX;
                Branch = 1'bX;
                DMWE = 0;
                MtoRFSel = 1'bX;
                ALUOp = 2'bXX;
                JUMPSel = 1;
            end
//            lui:begin
//                RFWE <= 1;
//                RFDSel <= 0;
//                ALUInSel <= 1'bX;
//                Branch <= 0;
//                DMWE <= 0;
//                MtoRFSel <= 2;
//                ALUOp <= 2'bXX;
//            end
//            slti:begin
//                RFWE <= 1;
//                RFDSel <= 0;
//                ALUInSel <= 1;
//                Branch <= 0;
//                DMWE <= 0;
//                MtoRFSel <= 0;
//                ALUOp <= 2'b11;
//            end       
        endcase
    end
endmodule
