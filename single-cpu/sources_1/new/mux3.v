module MUX3(
  input [31:0] PC4,
  input [31:0] jumpAddress,
  input [31:0] immeExtend,
  input [1:0] PCSrc,
  output wire [31:0] result
  );

assign result = PCSrc==0?PC4:(PCSrc==1?(immeExtend<<2)+PC4:jumpAddress);
endmodule
