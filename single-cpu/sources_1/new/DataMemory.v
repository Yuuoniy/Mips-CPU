module DataMemory(
  input clk,
  input [31:0]DAddr,
  input [31:0] DataIn,
  input mRD,
  input mWR,
  output [31:0]DataOut,
  reg [31:0] memory[0:200]
  );
always @(posedge clk ) begin
  if(mRD==0)//read
    DataOut = memory[DAddr];
  else 
    memory[DAddr] = DataIn;
end

endmodule
