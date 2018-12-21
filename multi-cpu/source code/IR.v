//指令寄存�?
`timescale 1ns / 1ps
// IR指令寄存器，目的是使指令代码保持稳定
module IR(inIns, clk, IRWre, outIns);
  input clk, IRWre;
  input [31:0] inIns;
  output reg[31:0] outIns;
  always @(posedge clk) begin 
    if (IRWre) begin
        outIns = inIns;
     end
  end
endmodule
