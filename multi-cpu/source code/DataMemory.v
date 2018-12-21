`timescale 1ns / 1ps
module DataMemory(
  input clk,
  input [31:0]DAddr,
  input [31:0] DataIn,
  input mRD,
  input mWR,
  output wire [31:0]DataOut
  );
    reg [7:0] memory[120:0];
    reg [31:0] tempData;
initial begin
    // $readmemb("dataMemory.txt", memory, 0, 400);
    tempData = 32'h00000000;
end

assign DataOut = mRD==0?32'bz:tempData;
always @(posedge clk ) begin
  if(mWR==1) begin
    memory[DAddr] = DataIn[31:24];
    memory[DAddr + 1] = DataIn[23:16];
    memory[DAddr + 2] = DataIn[15:8];
    memory[DAddr + 3] = DataIn[7:0];
  end
end

always @(DAddr or mRD) begin
 if(mRD==1) begin
    tempData={memory[DAddr],memory[DAddr+1],memory[DAddr+2],memory[DAddr+3]};
  end
end
endmodule
