`define AND2 and #40
`define AND3 and #60
`define AND4 and #80
`define OR2 or #40
`define OR8 or #160
`define XOR2 xor #40
`define NOT1 not #10
`define NAND2 nand #20
`define NOR2 nor #20
`define NOR32 nor #320

module didOverflow
(
    output overflow,
    input a, 
    input b, 
    input s, // most sig bit
    input sub
);
    wire BxorSub;
    wire notA;
    wire notB;
    wire notS;
    wire aAndB;
    wire notaAndNotb;
    wire negToPos;
    wire posToNeg;
    `XOR2 xorgate(BxorSub, b, sub);
    `NOT1 aNot(notA, a);
    `NOT1 bNot(notB, BxorSub);
    `NOT1 sNot(notS, s);
    `AND2 andab(aAndB, a, BxorSub);
    `AND2 andabNot(notaAndNotb, notA, notB);
    `AND2 andSwitch1(negToPos, aAndB, notS);
    `AND2 andSwitch2(posToNeg, notaAndNotb, s);
    `OR2 orGate(overflow, negToPos, posToNeg);
endmodule

module AdderAndSubtractor
(
    output res, 
    output carryout,
    input a, 
    input b, 
    input isSubtract,
    input carryin
);
    wire BxorSub;
    wire xAorB;
    wire AandB;
    wire xAorBandCin;
    `XOR2  xorgate(BxorSub, b, isSubtract);
    `XOR2  xorgate(xAorB, a, BxorSub);   // OR gate produces AorB from A and B
    `XOR2  xorgate(res, xAorB, carryin);
    `AND2  andgate(AandB, a, BxorSub);
    `AND2  andgate(xAorBandCin, xAorB, carryin);
    `OR2   orgate(carryout, AandB, xAorBandCin);
endmodule

module aluBitSlice
(
    output carryOut,
    output initialResult,
    input a,
    input b,
    input carryIn,
    input isSubtract,
    input s0,
    input s1,
    input s2
);

    wire addSub;
    wire orRes;
    wire norRes;
    wire xorRes;
    wire andRes;
    wire nandRes;

    wire s0inv;
    wire s1inv;
    wire s2inv;

    wire isAdd;
    wire isSub;
    wire isOr;
    wire isNor;
    wire isXor;
    wire isAnd;
    wire isNand;
    wire isSLT;

    `AND2(andRes, a, b);
    `NAND2(nandRes, a, b);
    `OR2(orRes, a, b);
    `NOR2(norRes, a, b);
    `XOR2(xorRes, a, b);

    AdderAndSubtractor adder (
        .res (addSub),
        .carryout (carryOut),
        .a (a),
        .b (b),
        .isSubtract (isSubtract),
        .carryin (carryIn)
    );

    `NOT1(s0inv, s0);
    `NOT1(s1inv, s1);
    `NOT1(s2inv, s2);

    `AND4(isAdd, addSub, s0inv, s1inv, s2inv);
    `AND4(isSub, addSub, s0, s1inv, s2inv);
    `AND4(isXor, xorRes, s0inv, s1, s2inv);
    `AND4(isSLT, addSub, s0, s1, s2inv);
    `AND4(isAnd, andRes, s0inv, s1inv, s2);
    `AND4(isNand, nandRes, s0, s1inv, s2);
    `AND4(isNor, norRes, s0inv, s1, s2);
    `AND4(isOr, orRes, s0, s1, s2);

    `OR8(initialResult, isAdd, isSub, isXor, isAnd, isNand, isNor, isOr, isSLT);

endmodule

module isZero (
    input[31:0] a,
    output out
);

`NOR32(out, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14], 
    a[15], a[16], a[17], a[18], a[19], a[20], a[21], a[22], a[23], a[24], a[25], a[26], a[27], a[28], a[29], a[30], a[31]);

endmodule // isZero

module alu (
    output carryout,
    output zero,
    output overflow,
    output[31:0] result,
    input[31:0] operandA,
    input[31:0] operandB,
    input[2:0] command
);

    wire[31:0] initialResult;
    wire[32:0] carryOut;
    wire isSubtract;

    `OR2(isSubtract, command[0], command[0]);
    `OR2(carryOut[0], isSubtract, isSubtract); 


    generate
        genvar i;
        for (i=0; i<32; i=i+1)
        begin
            aluBitSlice aluBitSlice (
                .carryOut (carryOut[i+1]),
                .initialResult (initialResult[i]),
                .a (operandA[i]),
                .b (operandB[i]),
                .carryIn (carryOut[i]),
                .isSubtract (isSubtract),
                .s0 (command[0]),
                .s1 (command[1]),
                .s2 (command[2])
            );
        end
    endgenerate

    `OR2(carryout, carryOut[32], carryOut[32]);

    didOverflow overflowCalc(
        .overflow (overflow),
        .a (operandA[31]),
        .b (operandB[31]),
        .s (initialResult[31]),
        .sub (isSubtract)
    );

    wire s2inv;
    wire overflowInv;
    wire isSLTinv;
    wire isSLT;
    wire SLTval;

    `NOT1(s2inv, command[2]);
    `NOT1(overflowInv, overflow);
    `AND3(isSLT, s2inv, command[0], command[1]);
    `NOT1(isSLTinv, isSLT);
    `AND3(SLTval, initialResult[31], overflowInv, isSLT);

    generate
        genvar j;
        for (j=1; j<32; j=j+1)
        begin
            `AND2(result[j], initialResult[j], isSLTinv);
        end
    endgenerate

    `OR2(result[0], initialResult[0], SLTval);

    isZero zeroCalc(
        .a (result),
        .out (zero)
    );
endmodule