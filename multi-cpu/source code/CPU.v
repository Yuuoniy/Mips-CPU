`timescale 1ns / 1ps

module CPU(
  input clk,reset,
  //pc
  output wire [31:0] pcIn,pcOut,PC4,
  //ins memory
  output wire [31:0] IDataOut,
  //register file
  output wire [4:0]WriteReg,
  output wire [31:0]readData1,readData2, DBDRin,ADRout,BDRout,ALUoutDRout,DBDRout,IROut,WriteData,
  
  //control unit
  output wire [1:0] PcSrc,RegDst,
  output wire RegWre, ALUSrcB,InsMemRw, ExtSel , PCWre,WrRegDSrc,mRD, mWR, DBDataSrc,IRWre,
  output wire [2:0] ALUOp,
//extend
   output wire [31:0] extendResult,
  //dataMemory
  output wire [31:0] DataOut,
  //ALU
  output wire zero,sign,
  output wire [31:0]rega,regb,ALUreslut
  );
  PC pc(clk,reset,pcIn,PCWre,pcOut,PC4);
  //choose pc
  MUX4 PCSelector(PC4,IDataOut[25:0],extendResult,readData1,PcSrc,pcIn);

  //IR
  IR ir(IDataOut, clk, IRWre, IROut); 
//SelectRtRd 
  // SelectRtRd selectRtRd(IDataOut[20:16],IDataOut[15:11],RegDst,WriteReg);
  WriteRegSrc wRegSrc(IROut[20:16],IROut[15:11],RegDst,WriteReg);

  InsMemory insMemory(pcOut,InsMemRw,IDataOut);

  RegFile regFile(clk,reset,RegWre,IROut[25:21],IROut[20:16],WriteReg,WriteData,readData1,readData2);
//DataReg
  DataReg ADR(clk,readData1,ADRout);
  DataReg BDR(clk,readData2,BDRout);
  DataReg ALUoutDR(clk,ALUreslut,ALUoutDRout);
  DBDReg DBDR(clk,DBDRin,DBDRout);

//
//write data mux2 pc4/writedata
WriteDataSrc WriteDataSelector(PC4,DBDRout,WrRegDSrc,WriteData);
  //control unit 
  ControlUnit controlUnit(IROut[31:26],zero,sign,reset,clk,pcOut, RegWre,ALUSrcA,ALUSrcB,InsMemRw,PcSrc,ExtSel,RegDst,PCWre,WrRegDSrc,mRD,mWR,DBDataSrc,ALUOp,IRWre
    );

  SignZeroExtend extend(IROut[15:0],ExtSel,extendResult);
  DataMemory dataMemory(clk,ALUoutDRout,readData2,mRD,mWR,DataOut);
  MuxALUa ALUASelector(readData1,IROut[10:6],ALUSrcA,rega
    );
  MuxFor32Bits ALUBSelector(BDRout,extendResult,ALUSrcB,regb);

  MuxFor32Bits selectDB(ALUreslut,DataOut,DBDataSrc,DBDRin);

  ALU32 alu(ALUOp,rega,regb,ALUreslut,zero,sign);
endmodule
