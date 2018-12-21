`timescale 1ns / 1ps
module MUX4(
  input [31:0] PC4,
  input [25:0] jumpAddress,
  input [31:0] extendResult,
  input [31:0] regSrc,
  input [1:0] PCSrc,
  output wire [31:0] result
  );

wire [31:0]extendAddr;
assign extendAddr[27:2]= jumpAddress;
assign extendAddr[31:28] =PC4[31:28] ;
assign extendAddr[1:0] = 2'b00;
assign result = PCSrc==0?PC4:(PCSrc==1?(extendResult<<2)+PC4: (PCSrc==2?regSrc:extendAddr));
endmodule
