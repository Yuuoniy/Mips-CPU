

module CPUTest(
 );
  input clk;
  input reset;
  wire [31:0] pcIn,pcOut,PC4;
//choose pc
  wire [31:0]jumpAddress,immeExtend,pcReslut;
  //ins memory
  wire [31:0] IAddr,IDataOut;
  //register file
  wire [4:0]rs, rt, rd,sa;
  wire [31:0]readData1,readData2, writeData,WriteReg;
  //control unit
  wire [5:0]op;
  wire [1:0] PcSrc;
  wire RegWre, ALUSrcB,InsMemRw, ExtSel, RegDst, PCWre,mRD, mWR, DBDataSrc;
  wire [2:0] ALUOp;
//extend
  wire [15:0] immediate;
  wire [31:0] extendResult;
  //dataMemory
  wire [31:0] DataOut;
  //ALU
  wire zero,ALUreslut;
  wire [31:0]rega,regb;

CPU cpu(clk,reset,pcIn,pcOut,PC4,jumpAddress,immeExtend,pcReslut,IAddr,IDataOut,rs,rt,rd,sa,readData1,readData2,writeData,WriteReg,op,PcSrc,RegWre,ALUSrcB,InsMemRw,ExtSel,RegDst,PCWre,mRD,mWR,DBDataSrc,ALUOp,immediate,extendResult,DataOut,zero,ALUreslut,rega,regb);
always begin
   #5  clk =~ clk;
end

initial begin
  clk = 0;
  reset = 0;
end
endmodule
