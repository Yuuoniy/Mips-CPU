`timescale 1ns / 1ps
module PC(
  input clk,
  input reset,
  input [31:0]pcIn,
  input PCWre,
  output reg [31:0]pcOut,
  output reg [31:0]PC4
  );
  reg [31:0] tmpPC;
  // reg[31:0] help;
  initial begin
     tmpPC =0;
     pcOut = 0;
     PC4 = pcOut+4;
  end

always @(posedge clk ) begin
   if (reset == 0) begin
     pcOut = 0;
     PC4 = 4;
   end
   else if (PCWre==1) begin
     pcOut = pcIn;
     PC4 = pcOut+4;
   end
end

endmodule
