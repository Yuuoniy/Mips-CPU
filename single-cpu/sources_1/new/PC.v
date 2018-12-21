module PC(
  input clk,
  input Reset,
  input [31:0]pcIn,
  input PCWre,
  output [31:0]pcOut,
  output [31:0]PC4
  );
 // reg [31:0] pc; //暂时保存
initial begin
    PCOut = 0;
    PC4 = 4;
   end

always @(posedge clk or posedge reset) begin
  if (reset==1) begin
    pcOut = 0;
  end
  else if (PCWre) begin
    pcOut = pcIn+4; 
    PC4 = pcIn+4;
  end
end
endmodule
