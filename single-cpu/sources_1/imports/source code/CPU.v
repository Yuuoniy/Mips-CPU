`timescale 1ns / 1ps

module CPU(
  input clk,
  input reset,
  //pc
  output wire [31:0] pcIn,pcOut,PC4,
  //ins memory
  output wire [31:0] IDataOut,
  //register file
  output wire [4:0]WriteReg,
  output wire [31:0]readData1,readData2, writeData,
  //control unit
  output wire [1:0] PcSrc,
  output wire RegWre, ALUSrcB,InsMemRw, ExtSel, RegDst, PCWre,mRD, mWR, DBDataSrc,
  output wire [2:0] ALUOp,
//extend
   output wire [31:0] extendResult,
  //dataMemory
  output wire [31:0] DataOut,
  //ALU
  output wire zero,
  output wire [31:0]rega,regb,ALUreslut
  );
  PC pc(clk,reset,pcIn,PCWre,pcOut,PC4);
  //choose pc
  MUX3 mux3(PC4,IDataOut[25:0],extendResult,PcSrc,pcIn);
//SelectRtRd 
  SelectRtRd selectRtRd(IDataOut[20:16],IDataOut[15:11],RegDst,WriteReg);
  InsMemory insMemory(pcOut,InsMemRw,IDataOut);
  RegFile regFile(clk,reset,RegWre,IDataOut[25:21],IDataOut[20:16],WriteReg,writeData,readData1,readData2);
  //control unit 
  ControlUnit controlUnit(IDataOut[31:26],zero,RegWre,ALUSrcA,ALUSrcB,InsMemRw,PcSrc,ExtSel,RegDst,PCWre,mRD,mWR,DBDataSrc,ALUOp
    );

  SignZeroExtend extend(IDataOut[15:0],ExtSel,extendResult);
  DataMemory dataMemory(clk,ALUreslut,readData2,mRD,mWR,DataOut);
  MuxALUa muxalua(readData1,IDataOut[10:6],ALUSrcA,rega
    );
  MuxFor32Bits mux32_1(readData2,extendResult,ALUSrcB,regb);

  MuxFor32Bits selectDB(ALUreslut,DataOut,DBDataSrc,writeData);

  ALU32 alu(ALUOp,rega,regb,ALUreslut,zero);
endmodule
