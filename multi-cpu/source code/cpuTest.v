`timescale 1ns / 1ps
module test(
 );
  reg clk;
  reg reset;
  wire [31:0] pcIn,pcOut,PC4;
  //ins memory
  wire [31:0]IDataOut;
  //register file
  wire [4:0]WriteReg;
  wire [31:0]readData1,readData2, DBDRin,ADRout,BDRout,ALUoutDRout,DBDRout,IROut,WriteData;
  //control unit
  // wire [5:0]op;
  wire [1:0] PcSrc,RegDst;
  wire RegWre, ALUSrcB,InsMemRw, ExtSel,  PCWre,WrRegDSrc,mRD, mWR, DBDataSrc,IRWre;
  wire [2:0] ALUOp;
//extend
  wire [31:0] extendResult;
  //dataMemory
  wire [31:0] DataOut;
  //ALU
  wire zero;
  wire [31:0]rega,regb,ALUreslut;

CPU cpu(clk,reset,pcIn,pcOut,PC4,IDataOut,WriteReg,readData1,readData2,DBDRin,ADRout,BDRout,ALUoutDRout,DBDRout,IROut,WriteData,PcSrc,RegDst,RegWre,ALUSrcB,InsMemRw,ExtSel,PCWre,WrRegDSrc,mRD,mWR,DBDataSrc,IRWre,ALUOp,extendResult,DataOut,zero,sign,rega,regb,ALUreslut);
always begin
   #5  clk =~ clk;
end

initial begin
  clk = 1;
  reset = 0;

  #23 reset = 1;
end
endmodule
