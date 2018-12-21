module SignZeroExtend(
input [15:0] immediate,
input ExtSel,
output wire [31:0] extendResult
  );

assign extendResult = ExtSel?(immediate[15]==0?{16'h0000,immediate}:{16'hffff,immediate}):32'h00000000;


endmodule
