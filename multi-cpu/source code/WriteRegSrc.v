`timescale 1ns / 1ps


module WriteRegSrc(
    input [4:0] rt,
    input [4:0] rd,
    input [1:0] RegDst,
    output wire [4:0] WriteReg
    );

    assign WriteReg = RegDst==0?5'b11111:(RegDst==2?rd:rt);

endmodule
