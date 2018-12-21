/*
* @Author: Yuuoniy
* @Date:   2018-05-19 20:28:56
* @Last Modified by:   Yuuoniy
* @Last Modified time: 2018-05-19 20:29:40
*/
module InsMemory(
input [31:0]IAddr,
input InsMemRW,
output [31:0]IDataOut,
reg [31:0] Memory[0:255]


);
initial
  $readmemb("instructions.txt",Memory);
  always @(IAddr) begin
    if(InsMemRW)
    IDataOut = Memory[IAddr];
  end

endmodule
