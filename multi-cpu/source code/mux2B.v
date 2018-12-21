`timescale 1ns / 1ps
module MuxALUa(
  input [31:0]ReadData1,
  input [4:0]sa,
  input ALUSrcA,
  output [31:0]ALUinputA
  );
//第二个需要拓�?
assign ALUinputA = ALUSrcA==0?ReadData1:{0,sa};

endmodule
