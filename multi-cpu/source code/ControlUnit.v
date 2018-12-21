`timescale 1ns / 1ps
module ControlUnit(
  input[5:0] op, 
  input zero,
  input sign,
  input rst,
  input clk,
  input [31:0]pc,
  output wire RegWre, 
  output wire ALUSrcA,  // choose data1 or sa
  output wire ALUSrcB, //choose data2 or sign|zero
  output wire InsMemRw, //write instruction or read 
  output wire [1:0] PcSrc,
  output wire ExtSel, //zero-extend or sign-extend
  output wire [1:0]RegDst, //register to write,choose from rt or rs
  output wire PCWre,
  output wire WrRegDSrc,
  output wire mRD,
  output wire mWR,
  output wire DBDataSrc,
  output wire [2:0] ALUOp,
  output wire IRWre
  );
reg[2:0] o_state;
    reg addi,add,sub,ori,andx,orx,sll,slti,sw,lw,beq,bne,j,slt,subi,halt,sltiu,bltz,jal,jr;
    initial begin
      addi=0;
      add=0;
      sub=0;
      ori=0;
      andx=0;
      orx=0;
      sll=0;
      slti=0;
      sltiu = 0;
      sw=0;
      lw=0;
      beq=0;
      bne=0;
      j=0;
      subi = 0;
      bltz = 0;
      slt = 0;
      halt = 0;
      jr = 0;
      jal = 0;
      o_state = 3'b000;
    end
    //D触发?
    always @(negedge clk or negedge rst) begin
      if (rst==0) begin
        o_state = 3'b000;
      end
      else begin
        case(o_state)
          3'b000:begin
            jal = 0;
            o_state=3'b001;
          end
          3'b001:begin
            case(op[5:3])
              3'b111:o_state=3'b000;// 指令 j jal jar halt
              default:o_state=3'b010;
            endcase
          end
          3'b010:begin
            case(op[5:2])
              4'b1100:o_state=3'b100;//lw sw
              4'b1101:o_state=3'b000; //beq bltz
              default:o_state=3'b011;
            endcase
          end
          3'b011:
            o_state = 3'b000;
          3'b100:begin
            if(op[0]) //lw
              o_state = 3'b011;  
            else //sw
              o_state = 3'b000;
            end
          endcase
        end
    end
 

    assign  PCWre = !halt && (o_state==3'b000);
    assign  ALUSrcA = sll;
    assign  ALUSrcB = addi || ori||sltiu||slti||sw||lw||subi;
    assign  DBDataSrc = lw;
    assign  RegWre = (add||addi||sub||ori||orx||andx||slti||sll||slt||sltiu||lw||subi)&&o_state==3||jal;
    assign  InsMemRw = 1;
    assign  mRD = lw&&(o_state==3'b100||o_state==3'b000);
    assign  mWR = sw&&(o_state==3'b100||o_state==3'b000);
    assign  RegDst[1] = add||sub||andx||orx||sll||slt;
    assign  RegDst[0] = addi||ori||sltiu||lw||subi;
    assign  ExtSel = addi||slti||sw||lw||beq||bne||subi||bltz;
    assign PcSrc[0] =(beq&&zero)||(bne&&!zero)||j||jal||(bltz&&sign&&!zero);
    assign PcSrc[1] = j ||jal||jr;
    assign ALUOp[0] = sub||orx||ori||beq||slt||bne||slti||subi||bltz;
    assign ALUOp[1] =bltz||andx||slt||sltiu;
    assign ALUOp[2] = sll||orx||ori||andx||slti;
    assign IRWre= o_state==1;
    assign WrRegDSrc = !jal;
    always @(op or zero or sign or pc) begin
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
      sltiu = 0;
      j=0;
      subi = 0;
      slt = 0;
      // halt = 0;
      jr = 0;
      bltz = 0;
      jal = 0;
      case(op)
        6'b000000:   
          add = 1;    
        6'b000001: 
          sub = 1;
        6'b000010:
          addi= 1;
        6'b000011://subi
          subi = 1;
        6'b010000://or
          orx = 1;
        6'b010001://andx
          andx = 1;
        6'b010010://or
          ori = 1;
        6'b011000://sll
          sll = 1;
        6'b100110:
          slt = 1;
        6'b100110: //slti
         slti = 1;
        6'b100111:
          sltiu = 1;
        6'b110000://sw
          sw =1;
        6'b110001://lw
          lw = 1;
        6'b110100://beq
          beq = 1;
        6'b110001://bne
          bne = 1;
        6'b110110:
          bltz = 1;
        6'b111000: //j
          j = 1;
        6'b111001: //jr
          jr = 1;
        6'b111010://jal
          jal = 1;
        6'b111111://halt
          halt = 1;
      endcase    
    end
endmodule
