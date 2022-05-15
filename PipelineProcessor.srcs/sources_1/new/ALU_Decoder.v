module ALU_Decoder(
    input [1:0] ALUOp,
    input [5:0] func,
    output reg [3:0] ALUSel
);
    parameter RType=2'b10;
    parameter lsw=2'b00;
    parameter beq=2'b01;
    parameter ADD=6'b100000;
    parameter SUB=6'b100010;
    parameter AND=6'b100100;
    parameter OR =6'b100101;
    parameter SLT=6'b101010;
    parameter SLL=6'b000000;
    parameter SRA=6'b000011;
    parameter SRL=6'b000010;
    parameter SLLV=6'b000100;
    parameter SRLV=6'b000110;
    parameter SRAV=6'b000111;
    parameter MULT=6'b101010;
    parameter MULTU=6'b101010;
    always @(*) begin 
        case(ALUOp)
            lsw:ALUSel = 4'b0000; 
            beq:ALUSel = 4'b0001; 
            RType:begin
                case(func)
                    ADD:    ALUSel = 4'b0000;
                    SUB:    ALUSel = 4'b0001;
                    AND:    ALUSel = 4'b0111;
                    OR:     ALUSel = 4'b1000;
                    
                    //SLT:    ALUSel <= 4'b0010;
                    SLL:    ALUSel = 4'b0010;
                    SRA:    ALUSel = 4'b0110;
                    SLLV:   ALUSel = 4'b0100;
                    SRLV:   ALUSel = 4'b0101;
                    SRAV:   ALUSel = 4'b1011;
//                    MULT:   ALUSel <= 4'b0010;
//                    MULTU:  ALUSel <= 4'b0010;
                endcase
            end
        endcase
    end
endmodule

//            4'b0000:begin Result = A + B; CO = Result[Size]; OUT = Result[Size-1:0];end//Addition
//            4'b0001:begin Result = A - B; CO = Result[Size]; OUT = Result[Size-1:0];end//Subtraction
//            4'b0010:OUT = A <<1;//Logical Left
//            4'b0011:OUT = A >>1;//Logical Right
//            4'b0100:OUT = A <<B;//Logical Variable Left
//            4'b0101:OUT = A >>B;//Logical Variable Right
//            4'b0110:OUT = A>>>1;//Arithmetic Right
//            4'b0111:OUT = A & B;//AND
//            4'b1000:OUT = A | B;//OR
//            4'b1001:OUT = A ^ B;//XOR
//            4'b1010:OUT =~(A^B);//XNOR