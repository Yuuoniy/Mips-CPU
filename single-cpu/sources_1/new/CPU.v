module CPU(
  input clk,
  input reset,
  //pc
  wire [31:0] pcIn,pcOut,PC4,

//RW

//choose pc
  wire [31:0]jumpAddress,immeExtend,pcReslut,
  //ins memory
  wire [31:0] IAddr,IDataOut,
  //register file
  wire [4:0]rs, rt, rd,sa,
  wire [31:0]readData1,readData2, writeData,WriteReg,

  //control unit
  wire [5:0]op,
  wire [1:0] PcSrc,
  wire RegWre, ALUSrcB,InsMemRw, ExtSel, RegDst, PCWre,mRD, mWR, DBDataSrc,
  wire [2:0] ALUOp,
//extend
wire [15:0] immediate,
wire [31:0] extendResult,
  //dataMemory
wire [31:0] DataOut,
  //ALU
  wire zero,ALUreslut,
  wire [31:0]rega,regb
  );

  PC pc(clk,reset,pcIn,PCWre,pcOut,PC4);
  //choose pc
  MUX3 mux3(PC4,jumpAddress,immeExtend,PcSrc,pcReslut);
//SelectRtRd 
  SelectRtRd selectRtRd(rt,rd,RegDst,WriteReg);


  InsMemory insMemory(IAddr,InsMemRw,IDataOut);
  RegFile regFile(clk,reset,RegWre,rs,rt,WriteReg,writeData,readData1,readData2);

  //control unit 
  ControlUnit controlUnit(op,zero,RegWre,ALUSrcA,ALUSrcB,InsMemRw,PcSrc,ExtSel,RegDst,mRD,mWR,DBDataSrc,ALUOp
    );

  SignZeroExtend extend(immediate,ExtSel,extendResult);
  DataMemory dataMemory(clk,ALUreslut,readData2,mRD,mWR,DataOut);
  MuxALUa muxalua(readData1,sa,ALUSrcA,rega
    );
  MuxFor32Bits mux32_1(readData2,extendResult,ALUSrcB,regb);

  MuxFor32Bits selectDB(ALUreslut,DataOut,DBDataSrc,writeData);

  ALU32 alu(ALUOp,rega,regb,ALUreslut,zero);
endmodule
