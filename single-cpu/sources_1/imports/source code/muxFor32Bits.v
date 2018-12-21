`timescale 1ns / 1ps
module MuxFor32Bits(
  input [31:0] v0,
  input [31:0] v1,
  input control,
  output  [31:0] res

  );
assign res = control==0?v0:v1;

endmodule
