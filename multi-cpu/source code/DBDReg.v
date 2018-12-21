`timescale 1ns / 1ps
// 切分数据通路模块
module DBDReg(clk, inData, outData);
  input clk;
  input [31:0] inData;
  output reg[31:0] outData;
  always @(negedge clk) begin
    outData = inData;
  end
endmodule
