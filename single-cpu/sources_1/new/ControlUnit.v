
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

    wire addi,addi,sub,ori,andx,orx,sll,slti,sw,lw,beq,bne,j,halt;
    always @(op) begin
      case(op)
      6'b000000: //add  
        add = 1;    
      6'b000001: //addi
        addi = 1;
      6'b000010://sub
        sub= 1;
      6'b010000://ori
        ori = 1;
      6'b010001://andx
        andx = 1;
      6'b010010://or
        orx = 1;
      6'b011000://sll
        sll = 1;
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
        PCWre = halt;
        ALUSrcA = sll;
        ALUSrcB = addi || ori||slti||sw||lw;
        DBDataSrc = lw;
        RegWre = add||addi||sub||ori||orx||andx||slti||sll||lw;
        InsMemRw = lw?1:0;
        mRD = lw;
        mWR = sw;
        RegDst = add||sub||andx||orx||sll;
        ExtSel = addi||slti||sw||lw||beq||bne;
        if(add||addi||sub||orx||ori||andx||slti||sll||sw||lw||(bne&&zero)||(beq&&!zero))
          PcSrc = 2'b00;
        else if((beq&&zero)||bne&&!zero)
          PcSrc = 2'b01;
        else if(j)
          PcSrc = 2'b10;
    end
endmodule
