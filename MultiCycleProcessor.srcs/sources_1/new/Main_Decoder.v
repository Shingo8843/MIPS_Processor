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
    input CLK,
    input [5:0] opcode,
    output reg MtoRFSel,
    output reg RFDSel,
    output reg IDSel,
    output reg [1:0] PCSel,
    output reg [1:0] ALUIn2Sel,
    output reg ALUIn1Sel,
    output reg IRWE,
    output reg DMWE,
    output reg PCWE,
    output reg Branch,
    output reg RFWE,
    output reg [1:0] ALUOp
    
);  
    //Inst Type
    parameter Rtype = 6'b000000;
    parameter lw = 6'b100011;
    parameter sw = 6'b101011;
    parameter beq = 6'b000100;
    parameter addi = 6'b001000;
    parameter jump = 6'b000010;
    ///State
    parameter FETCH = 4'b0000;
    parameter DECODE = 4'b0001;
    parameter MEMADR = 4'b0010;
    parameter MEMREAD = 4'b0011;
    parameter MEMWRITEBACK = 4'b0100;
    parameter DMWESTATE = 4'b0101;
    parameter EXECUTE = 4'b0110;
    parameter ALUWRITEBACK = 4'b0111;
    parameter BRANCH = 4'b1000;
    parameter JUMP = 4'b1001;
    parameter ADDI1 = 4'b1010;
    parameter ADDI2 = 4'b1011;
    parameter START = 4'b1111;
    reg [3:0] Current_State = START;
    
    always @(negedge CLK) begin//non-blocking 
        case(Current_State)
            START: begin
                MtoRFSel = 1'b0;
                RFDSel = 1'b0;
                IDSel = 1'b0;
                PCSel = 2'b00;
                ALUIn2Sel = 2'b00;
                ALUIn1Sel = 1'b0;
                IRWE = 0;
                DMWE = 0;
                PCWE = 0;
                Branch = 0;
                RFWE = 0;
                ALUOp = 2'b00;
                Current_State = FETCH;
                end
            FETCH:begin
                MtoRFSel = 1'b0;
                RFDSel = 1'b0;
                IDSel = 0;
                PCSel = 2'b00;
                ALUIn2Sel = 2'b01;
                ALUIn1Sel = 0;
                IRWE = 1;
                DMWE = 0;
                PCWE = 1;
                Branch = 0;
                RFWE = 0;
                ALUOp = 2'b00;
                
                Current_State = DECODE;
                end
            DECODE: begin
                MtoRFSel = 1'b0;
                RFDSel = 1'b0;
                IDSel = 1'b0;
                PCSel = 2'b00;
                ALUIn2Sel = 2'b10;
                ALUIn1Sel = 1'b0;
                IRWE = 0;
                DMWE = 0;
                PCWE = 0;
                Branch = 0;
                RFWE = 0;
                ALUOp = 2'b00;                
                case (opcode)//1'bX
                    Rtype:begin//change to combinational logic
                        Current_State = EXECUTE;
                        end
                    lw:begin
                        Current_State = MEMADR;
                        end
                    sw:begin
                        Current_State = MEMADR;
                        end
                    beq:begin
                        Current_State =  BRANCH;
                        end
                    addi:begin
                        Current_State =  ADDI1;
                        end      
                    jump:begin
                        Current_State =  JUMP;
                        end
                    endcase
                end
            MEMADR: begin
                MtoRFSel = 1'b0;
                RFDSel = 1'b0;
                IDSel = 1'b0;
                PCSel = 2'b0;
                ALUIn2Sel = 2'b10;
                ALUIn1Sel = 1'b1;
                IRWE = 0;
                DMWE = 0;
                PCWE = 0;
                Branch = 0;
                RFWE = 0;
                ALUOp = 2'b00;
                if(opcode == lw) begin
                    Current_State = MEMREAD;
                    end
                else begin//(opcode == sw) 
                    Current_State = DMWESTATE;
                    end
                end
            MEMREAD: begin
                MtoRFSel = 1'b0;
                RFDSel = 1'b0;
                IDSel = 1'b1;
                PCSel = 2'b00;
                ALUIn2Sel = 2'b00;
                ALUIn1Sel = 1'b0;
                IRWE = 0;
                DMWE = 0;
                PCWE = 0;
                Branch = 0;
                RFWE = 0;
                ALUOp = 2'b00;
                
                Current_State = MEMWRITEBACK;
                end
            MEMWRITEBACK: begin
                MtoRFSel = 1'b1;
                RFDSel = 1'b0;
                IDSel = 1'b1;
                PCSel = 2'b00;
                ALUIn2Sel = 2'b00;
                ALUIn1Sel = 1'b0;
                IRWE = 0;
                DMWE = 0;
                PCWE = 0;
                Branch = 0;
                RFWE = 1;
                ALUOp = 2'b00;
                
                Current_State = FETCH;
                end
            DMWESTATE: begin
                MtoRFSel = 1'b0;
                RFDSel = 1'b0;
                IDSel = 1'b1;
                PCSel = 2'b00;
                ALUIn2Sel = 2'b00;
                ALUIn1Sel = 1'b0;
                IRWE = 0;
                DMWE = 1;
                PCWE = 0;
                Branch = 0;
                RFWE = 0;
                ALUOp = 2'b00;
                
                Current_State = FETCH;
                end
            EXECUTE: begin
                MtoRFSel = 1'b0;
                RFDSel = 1'b0;
                IDSel = 1'b0;
                PCSel = 2'b00;
                ALUIn2Sel = 2'b00;
                ALUIn1Sel = 1'b1;
                IRWE = 0;
                DMWE = 0;
                PCWE = 0;
                Branch = 0;
                RFWE = 0;
                ALUOp = 2'b10;
                
                Current_State = ALUWRITEBACK;
                end
            ALUWRITEBACK: begin
                MtoRFSel = 1'b0;
                RFDSel = 1'b1;
                IDSel = 1'b0;
                PCSel = 2'b00;
                ALUIn2Sel = 2'b00;
                ALUIn1Sel = 1'b0;
                IRWE = 0;
                DMWE = 0;
                PCWE = 0;
                Branch = 0;
                RFWE = 1;
                ALUOp = 2'b00;
                
                Current_State = FETCH;
                end
            BRANCH: begin
                MtoRFSel = 1'b0;
                RFDSel = 1'b0;
                IDSel = 1'b0;
                PCSel = 2'b01;
                ALUIn2Sel = 2'b00;
                ALUIn1Sel = 1'b1;
                IRWE = 0;
                DMWE = 0;
                PCWE = 0;
                Branch = 1;
                RFWE = 0;
                ALUOp = 2'b01;
                
                Current_State = FETCH;
                end
            JUMP: begin
                MtoRFSel = 1'b0;
                RFDSel = 1'b0;
                IDSel = 1'b0;
                PCSel = 2'b10;
                ALUIn2Sel = 2'b00;
                ALUIn1Sel = 1'b0;
                IRWE = 0;
                DMWE = 0;
                PCWE = 1;
                Branch = 0;
                RFWE = 0;
                ALUOp = 2'b00;
                
                Current_State = FETCH;
                end
            ADDI1: begin
                MtoRFSel = 1'b0;
                RFDSel = 1'b0;
                IDSel = 1'b0;
                PCSel = 2'b00;
                ALUIn2Sel = 2'b10;
                ALUIn1Sel = 1'b1;
                IRWE = 0;
                DMWE = 0;
                PCWE = 0;
                Branch = 0;
                RFWE = 0;
                ALUOp = 2'b00;
                
                Current_State = ADDI2;
                end
            ADDI2: begin
                MtoRFSel = 1'b0;
                RFDSel = 1'b0;
                IDSel = 1'b0;
                PCSel = 2'b00;
                ALUIn2Sel = 2'b00;
                ALUIn1Sel = 1'b0;
                IRWE = 0;
                DMWE = 0;
                PCWE = 0;
                Branch = 0;
                RFWE = 1;
                ALUOp = 2'b00;
                
                Current_State = FETCH;
                end
       endcase
    end
endmodule




//        case (opcode)//1'bX
//            Rtype:begin//change to combinational logic
                
//            end
//            lw:begin

//            end
//            sw:begin

//            end
//            beq:begin

//            end
//            addi:begin

//            end      
//            jump:begin

//            end
//         endcase