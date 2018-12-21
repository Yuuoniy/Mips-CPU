`timescale 1ns / 1ps
module ControlUnit(
  input[5:0] op, 
  input zero,
  output wire RegWre, 
  output wire ALUSrcA,  // choose data1 or sa
  output wire ALUSrcB, //choose data2 or sign|zero
  output wire InsMemRw, //write instruction or read 
  output wire [1:0] PcSrc,
  output wire ExtSel, //zero-extend or sign-extend
  output wire RegDst, //register to write,choose from rt or rs
  output wire PCWre,
  output wire mRD,
  output wire mWR,
  output wire DBDataSrc,
  output wire [2:0] ALUOp
  );

    reg addi,add,sub,ori,andx,orx,sll,slti,sw,lw,beq,bne,j,slt,subi,halt;
    initial begin
      addi=0;
      add=0;
      sub=0;
      ori=0;
      andx=0;
      orx=0;
      sll=0;
      slti=0;
      sw=0;
      lw=0;
      beq=0;
      bne=0;
      j=0;
      subi = 0;
      slt = 0;
      halt = 0;
    end
    assign   PCWre = !halt;
    assign  ALUSrcA = sll;
    assign  ALUSrcB = addi || ori||slti||sw||lw||subi;
    assign  DBDataSrc = lw;
    assign  RegWre = add||addi||sub||ori||orx||andx||slti||sll||lw||subi;
    assign  InsMemRw = 1;
    assign  mRD = lw;
    assign  mWR = sw;
    assign  RegDst = add||sub||andx||orx||sll;
    assign  ExtSel = addi||slti||sw||lw||beq||bne||subi;
      // if(add||addi||sub||orx||ori||andx||slti||sll||sw||lw||(bne&&zero)||(beq&&!zero))
      //   PcSrc = 2'b00;
      // else if((beq&&zero)||bne&&!zero)
      //   PcSrc = 2'b01;
      // else if(j)
      //   PcSrc = 2'b10;

    assign PcSrc[0] =(beq&&zero)||bne&&!zero;
    assign PcSrc[1] =j ;
    assign ALUOp[0] = sub||orx||ori||beq||bne||slti||subi;
    assign ALUOp[1] = sll ||orx||ori;
    assign ALUOp[2] = andx||slti;

    always @(op) begin
      addi=0;
      add=0;
      sub=0;
      ori=0;
      andx=0;
      orx=0;
      sll=0;
      slti=0;
      sw=0;
      lw=0;
      beq=0;
      bne=0;
      j=0;
      subi = 0;
      slt = 0;
      halt = 0;

      case(op)
        6'b000000: //add  
          add = 1;    
        6'b000001: //addi
          addi = 1;
        6'b000010://sub
          sub= 1;
        6'b000011://subi
          subi = 1;
        6'b010000://ori
          ori = 1;
        6'b010001://andx
          andx = 1;
        6'b010010://or
          orx = 1;
        6'b011000://sll
          sll = 1;
        6'b011001:
          slt = 1;
        6'b011011: //slti
         slti = 1;
        6'b100110://sw
          sw =1;
        6'b100111://lw
          lw = 1;
        6'b110000://beq
          beq = 1;
        6'b110001://bne
          bne = 1;
        6'b111000: //j
          j = 1;
        6'b111111://halt
          halt = 1;
      endcase    
    end
endmodule
