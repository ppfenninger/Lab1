`define AND and #5
`define OR or #5
`define XOR xor #5
`define NOT not #5
`define NAND nand #5
`define NOR nor #5

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
    `XOR xorgate(BxorSub, b, sub);
    `NOT aNot(notA, a);
    `NOT bNot(notB, BxorSub);
    `NOT sNot(notS, s);
    `AND andab(aAndB, a, BxorSub);
    `AND andabNot(notaAndNotb, notA, notB);
    `AND andSwitch1(negToPos, aAndB, notS);
    `AND andSwitch2(posToNeg, notaAndNotb, s);
    `OR orGate(overflow, negToPos, posToNeg);
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
    `XOR  xorgate(BxorSub, b, isSubtract);
    `XOR  xorgate(xAorB, a, BxorSub);   // OR gate produces AorB from A and B
    `XOR  xorgate(res, xAorB, isSubtract);
    `AND  andgate(AandB, a, BxorSub);
    `AND  andgate(xAorBandCin, xAorB, carryin);
    `OR   orgate(carryout, AandB, xAorBandCin);
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

    `AND(andRes, a, b);
    `NAND(nandRes, a, b);
    `OR(orRes, a, b);
    `NOR(norRes, a, b);
    `XOR(xorRes, a, b);

    AdderAndSubtractor adder (
        .res (addSub),
        .carryout (carryOut),
        .a (a),
        .b (b),
        .isSubtract (isSubtract),
        .carryin (carryIn)
    );

    `NOT(s0inv, s0);
    `NOT(s1inv, s1);
    `NOT(s2inv, s2);

    `AND(isAdd, addSub, s0inv, s1inv, s2inv);
    `AND(isSub, addSub, s0, s1inv, s2inv);
    `AND(isXor, xorRes, s0inv, s1, s2inv);
    `AND(isAnd, andRes, s0inv, s1inv, s2);
    `AND(isNand, nandRes, s0, s1inv, s2);
    `AND(isNor, norRes, s0inv, s1, s2);
    `AND(isOr, orRes, s0, s1, s2);

    `OR(initialResult, isAdd, isSub, isXor, isAnd, isNand, isNor, isOr);

endmodule

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

    `OR(isSubtract, command[0], command[0]);
    `OR(carryOut[0], isSubtract, isSubtract);


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

    `OR(carryout, carryOut[32], carryOut[32]);

    didOverflow overflowCalc(
        .overflow (overflow),
        .a (operandA[31]),
        .b (operandB[31]),
        .s (initialResult[31]),
        .sub (isSubtract)
    );

    wire s3inv;
    wire overflowInv;
    wire isSLTinv;
    wire isSLT;

    `NOT(s3inv, command[2]);
    `NOT(overflowInv, overflow);
    `AND(isSLT, initialResult[31], overflowInv, s3inv, command[0], command[1]);
    `NOT(isSLTinv, isSLT);

    generate
        genvar j;
        for (j=0; j<31; j=j+1)
        begin
            `AND(result[j], initialResult[j], isSLTinv);
        end
    endgenerate

    `OR(result[31], initialResult[31], isSLT);
    `NOR(zero, result[1]);

endmodule