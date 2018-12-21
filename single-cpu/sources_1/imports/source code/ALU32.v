`timescale 1ns / 1ps
module ALU32(
  input [2:0] ALUopcode,
  input [31:0] rega,
  input [31:0] regb, 
  output reg [31:0] result, 
  output wire zero
);
  assign zero = (result==0)?1:0;
  always @( ALUopcode or rega or regb ) begin
    case (ALUopcode)
      3'b000 : result = rega + regb;
      3'b001 : result = rega - regb;
      3'b010 : result = regb << rega;     
      3'b011 : result = rega | regb;
      3'b100 : result = rega & regb;
      3'b101 : result = (rega < regb)?1:0; // 不带符号比较
      3'b110 : begin // 带符号比较b
                if(rega < regb && (rega[31] == regb[31]))result = 1;
                else if (rega[31] == 1 && regb[31] == 0) result = 1;
                else result = 0;
              end
    default : begin
                result = 32'h00000000;
                $display ("no match");
              end
    endcase
  end
endmodule
