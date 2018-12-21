/*
* @Author: Yuuoniy
* @Date:   2018-05-19 20:28:56
* @Last Modified by:   Yuuoniy
* @Last Modified time: 2018-05-19 20:29:40
*/
`timescale 1ns / 1ps
module InsMemory(
input [31:0]IAddr,
input InsMemRW,
output reg [31:0]IDataOut

);
reg [7:0] Memory[90:0];
initial begin
  // $readmemb("instructions.txt",Memory);
    Memory[0] = 8'b00000100;
    Memory[1] = 8'b00000001;
    Memory[2] = 8'b00000000;
    Memory[3] = 8'b00001000;

    Memory[4] = 8'b01000000;
    Memory[5] = 8'b00000010;
    Memory[6] = 8'b00000000;
    Memory[7] = 8'b00000010;

    Memory[8] = 8'b00000000;
    Memory[9] = 8'b01000001;
    Memory[10] = 8'b00011000;
    Memory[11] = 8'b00000000;

    Memory[12] = 8'b00001000;
    Memory[13] = 8'b01100010;
    Memory[14] = 8'b00101000;
    Memory[15] = 8'b00000000;

    Memory[16] = 8'b01000100;
    Memory[17] = 8'b10100010;
    Memory[18] = 8'b00100000;
    Memory[19] = 8'b00000000;

    Memory[20] = 8'b01001000;
    Memory[21] = 8'b10000010;
    Memory[22] = 8'b01000000;
    Memory[23] = 8'b00000000;

    Memory[24] = 8'b01100000;
    Memory[25] = 8'b00001000;
    Memory[26] = 8'b01000000;
    Memory[27] = 8'b01000000;

    Memory[28] = 8'b11000101;
    Memory[29] = 8'b00000001;
    Memory[30] = 8'b11111111;
    Memory[31] = 8'b11111110;

    Memory[32] = 8'b01101100;
    Memory[33] = 8'b01000110;
    Memory[34] = 8'b00000000;
    Memory[35] = 8'b00001000;

    Memory[36] = 8'b01101100;
    Memory[37] = 8'b11000111;
    Memory[38] = 8'b00000000;
    Memory[39] = 8'b00000000;

    Memory[40] = 8'b00000100;
    Memory[41] = 8'b11100111;
    Memory[42] = 8'b00000000;
    Memory[43] = 8'b00001000;

    Memory[44] = 8'b11000000;
    Memory[45] = 8'b11100001;
    Memory[46] = 8'b11111111;
    Memory[47] = 8'b11111110;

    Memory[48] = 8'b10011000;
    Memory[49] = 8'b00100010;
    Memory[50] = 8'b00000000;
    Memory[51] = 8'b00000100;

    Memory[52] = 8'b10011100;
    Memory[53] = 8'b00101001;
    Memory[54] = 8'b00000000;
    Memory[55] = 8'b00000100;

    Memory[56] = 8'b11100000;
    Memory[57] = 8'b00000000;
    Memory[58] = 8'b00000000;
    Memory[59] = 8'b00010000;

    Memory[60] = 8'b00000100;
    Memory[61] = 8'b00001010;
    Memory[62] = 8'b00000000;
    Memory[63] = 8'b00001010;
    
    Memory[64] = 8'b00001100;
    Memory[65] = 8'b01000001;
    Memory[66] = 8'b00000000;
    Memory[67] = 8'b00000001;


    Memory[68] = 8'b11111100;
    Memory[69] = 8'b00000000;
    Memory[70] = 8'b00000000;
    Memory[71] = 8'b00000000;



end
  always @(IAddr) begin
    if(InsMemRW)
    IDataOut = {Memory[IAddr],Memory[IAddr+1],Memory[IAddr+2],Memory[IAddr+3]};
  end

endmodule
