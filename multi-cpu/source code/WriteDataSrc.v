`timescale 1ns / 1ps


module WriteDataSrc(
    input [31:0] PC4,
    input [31:0] DataOut,
    input WrRegDSrc,
    output wire [31:0] WriteData
    );

    assign WriteData = (WrRegDSrc==1)?DataOut:PC4;

endmodule
