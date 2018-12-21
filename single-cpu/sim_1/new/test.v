`timescale 1ns / 1ps
module test(
 );
  reg clk;
  reg reset;
  wire [31:0] pcIn,pcOut,PC4;
//choose pc
  //ins memory
  wire [31:0]IDataOut;
  //register file
  wire [4:0]WriteReg;
  wire [31:0]readData1,readData2, writeData;
  //control unit
  // wire [5:0]op;
  wire [1:0] PcSrc;
  wire RegWre, ALUSrcB,InsMemRw, ExtSel, RegDst, PCWre,mRD, mWR, DBDataSrc;
  wire [2:0] ALUOp;
//extend
  wire [31:0] extendResult;
  //dataMemory
  wire [31:0] DataOut;
  //ALU
  wire zero;
  wire [31:0]rega,regb,ALUreslut;

CPU cpu(clk,reset,pcIn,pcOut,PC4,IDataOut,WriteReg,readData1,readData2,writeData,PcSrc,RegWre,ALUSrcB,InsMemRw,ExtSel,RegDst,PCWre,mRD,mWR,DBDataSrc,ALUOp,extendResult,DataOut,zero,rega,regb,ALUreslut);
always begin
   #5  clk =~ clk;
end

initial begin
  clk = 0;
  reset = 0;
   #6;
   reset = 1;
//   forever #5 clk = ~clk;
end
endmodule
