//`define AND and #50
//`define OR or #50
//`define XOR xor #50
//`define NOT not #50


`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7


module ALU
(
output[31:0]  result,
output        carryout,
output        zero,
output        overflow,
input[31:0]   operandA,
input[31:0]   operandB,
input[2:0]    command
);

wire[31:0] resultAddSub;
wire[31:0] resultAndNand;
wire[31:0] resultSLT;
wire[31:0] resultOrNor;
wire[31:0] resultXor;

wire invert;
wire invertedb;
wire[4:0] muxI;
wire midoverflow;
wire midcarryout;
wire midzeroer;
	//pick your operation
	ALUcontrolLUT pickOperand(muxI, invertB, invert, command, operandA, operandB);
	
	//instantiate all the modules
	andnand andernander1(resultsAndNand, operandA, operandB, invert);
	ornor orernorer1(resultOrNor, operandA, operandB, invert);
	FullAdderSubtractor32 addersubber1(resultAddSub, midcarryout, overflow, operandA, operandB, invertedb);
	slt slter1(resultSLT, resultAddSub, midoverflow);
  xorer xorer1(resultXor, operandA, operandB);
  zeroer zeroer1(midzeroer, resultAddSub, resultAndNand, resultSLT, resultOrNor, resultXor);
	
  //pick your result
  ALUresultLUT pickOperand(result, carryout, zero, overflow, muxI, resultAddSub, resultAndNand, resultSLT, resultOrNor, resultXor, midoverflow, midcarryout, midzeroer);
endmodule

module zeroor
(
    output iszero,
    input resultAddSub,
    input resultAndNand,
    input resultSLT,
    input resultOrNor,
    input resultXor
);
    `NOR  norgate(iszero, resultAddSub, resultAndNand, resultSLT, resultOrNor, resultXor);
endmodule

module andnand
(
    output res[31:0],
    input a[31:0], 
    input b[31:0],
    input invert //used for nand   if invert=1 then not AandB
);  // AND gate produces AandB from A and B
    wire AandB[31:0];
    `AND  andgate(AandB[0], a[0], b[0]);
    `AND  andgate(AandB[1], a[1], b[1]);
    `AND  andgate(AandB[2], a[2], b[2]);
    `AND  andgate(AandB[3], a[3], b[3]);
    `AND  andgate(AandB[4], a[4], b[4]);
    `AND  andgate(AandB[5], a[5], b[5]);
    `AND  andgate(AandB[6], a[6], b[6]);
    `AND  andgate(AandB[7], a[7], b[7]);
    `AND  andgate(AandB[8], a[8], b[8]);
    `AND  andgate(AandB[9], a[9], b[9]);
    `AND  andgate(AandB[10], a[10], b[10]);
    `AND  andgate(AandB[11], a[11], b[11]);
    `AND  andgate(AandB[12], a[12], b[12]);
    `AND  andgate(AandB[13], a[13], b[13]);
    `AND  andgate(AandB[14], a[14], b[14]);
    `AND  andgate(AandB[15], a[15], b[15]);
    `AND  andgate(AandB[16], a[16], b[16]);
    `AND  andgate(AandB[17], a[17], b[17]);
    `AND  andgate(AandB[18], a[18], b[18]);
    `AND  andgate(AandB[19], a[19], b[19]);
    `AND  andgate(AandB[20], a[20], b[20]);
    `AND  andgate(AandB[21], a[21], b[21]);
    `AND  andgate(AandB[22], a[22], b[22]);
    `AND  andgate(AandB[23], a[23], b[23]);
    `AND  andgate(AandB[24], a[24], b[24]);
    `AND  andgate(AandB[25], a[25], b[25]);
    `AND  andgate(AandB[26], a[26], b[26]);
    `AND  andgate(AandB[27], a[27], b[27]);
    `AND  andgate(AandB[28], a[28], b[28]);
    `AND  andgate(AandB[29], a[29], b[29]);
    `AND  andgate(AandB[30], a[30], b[30]);
    `AND  andgate(AandB[31], a[31], b[31]);
    `XOR  xorgate(res[0], AandB[0], invert);
    `XOR  xorgate(res[1], AandB[1], invert);
    `XOR  xorgate(res[2], AandB[2], invert);
    `XOR  xorgate(res[3], AandB[3], invert);
    `XOR  xorgate(res[4], AandB[4], invert);
    `XOR  xorgate(res[5], AandB[5], invert);
    `XOR  xorgate(res[6], AandB[6], invert);
    `XOR  xorgate(res[7], AandB[7], invert);
    `XOR  xorgate(res[8], AandB[8], invert);
    `XOR  xorgate(res[9], AandB[9], invert);
    `XOR  xorgate(res[10], AandB[10], invert);
    `XOR  xorgate(res[11], AandB[11], invert);
    `XOR  xorgate(res[12], AandB[12], invert);
    `XOR  xorgate(res[13], AandB[13], invert);
    `XOR  xorgate(res[14], AandB[14], invert);
    `XOR  xorgate(res[15], AandB[15], invert);
    `XOR  xorgate(res[16], AandB[16], invert);
    `XOR  xorgate(res[17], AandB[17], invert);
    `XOR  xorgate(res[18], AandB[18], invert);
    `XOR  xorgate(res[19], AandB[19], invert);
    `XOR  xorgate(res[20], AandB[20], invert);
    `XOR  xorgate(res[21], AandB[21], invert);
    `XOR  xorgate(res[22], AandB[22], invert);
    `XOR  xorgate(res[23], AandB[23], invert);
    `XOR  xorgate(res[24], AandB[24], invert);
    `XOR  xorgate(res[25], AandB[25], invert);
    `XOR  xorgate(res[26], AandB[26], invert);
    `XOR  xorgate(res[27], AandB[27], invert);
    `XOR  xorgate(res[28], AandB[28], invert);
    `XOR  xorgate(res[29], AandB[29], invert);
    `XOR  xorgate(res[30], AandB[30], invert);
endmodule

module orNor
(
    output res[31:0],
    input a[31:0], 
    input b[31:0],
    input invert 
);  // OR gate produces AorB from A and B
    wire AorB[31:0];
    `OR  orgate(AorB[0], a[0], b[0]);
    `OR  orgate(AorB[1], a[1], b[1]);
    `OR  orgate(AorB[2], a[2], b[2]);
    `OR  orgate(AorB[3], a[3], b[3]);
    `OR  orgate(AorB[4], a[4], b[4]);
    `OR  orgate(AorB[5], a[5], b[5]);
    `OR  orgate(AorB[6], a[6], b[6]);
    `OR  orgate(AorB[7], a[7], b[7]);
    `OR  orgate(AorB[8], a[8], b[8]);
    `OR  orgate(AorB[9], a[9], b[9]);
    `OR  orgate(AorB[10], a[10], b[10]);
    `OR  orgate(AorB[11], a[11], b[11]);
    `OR  orgate(AorB[12], a[12], b[12]);
    `OR  orgate(AorB[13], a[13], b[13]);
    `OR  orgate(AorB[14], a[14], b[14]);
    `OR  orgate(AorB[15], a[15], b[15]);
    `OR  orgate(AorB[16], a[16], b[16]);
    `OR  orgate(AorB[17], a[17], b[17]);
    `OR  orgate(AorB[18], a[18], b[18]);
    `OR  orgate(AorB[19], a[19], b[19]);
    `OR  orgate(AorB[20], a[20], b[20]);
    `OR  orgate(AorB[21], a[21], b[21]);
    `OR  orgate(AorB[22], a[22], b[22]);
    `OR  orgate(AorB[23], a[23], b[23]);
    `OR  orgate(AorB[24], a[24], b[24]);
    `OR  orgate(AorB[25], a[25], b[25]);
    `OR  orgate(AorB[26], a[26], b[26]);
    `OR  orgate(AorB[27], a[27], b[27]);
    `OR  orgate(AorB[28], a[28], b[28]);
    `OR  orgate(AorB[29], a[29], b[29]);
    `OR  orgate(AorB[30], a[30], b[30]);
    `OR  orgate(AorB[31], a[31], b[31]);
    `XOR  xorgate(res[0], AorB[0], invert);
    `XOR  xorgate(res[1], AorB[1], invert);
    `XOR  xorgate(res[2], AorB[2], invert);
    `XOR  xorgate(res[3], AorB[3], invert);
    `XOR  xorgate(res[4], AorB[4], invert);
    `XOR  xorgate(res[5], AorB[5], invert);
    `XOR  xorgate(res[6], AorB[6], invert);
    `XOR  xorgate(res[7], AorB[7], invert);
    `XOR  xorgate(res[8], AorB[8], invert);
    `XOR  xorgate(res[9], AorB[9], invert);
    `XOR  xorgate(res[10], AorB[10], invert);
    `XOR  xorgate(res[11], AorB[11], invert);
    `XOR  xorgate(res[12], AorB[12], invert);
    `XOR  xorgate(res[13], AorB[13], invert);
    `XOR  xorgate(res[14], AorB[14], invert);
    `XOR  xorgate(res[15], AorB[15], invert);
    `XOR  xorgate(res[16], AorB[16], invert);
    `XOR  xorgate(res[17], AorB[17], invert);
    `XOR  xorgate(res[18], AorB[18], invert);
    `XOR  xorgate(res[19], AorB[19], invert);
    `XOR  xorgate(res[20], AorB[20], invert);
    `XOR  xorgate(res[21], AorB[21], invert);
    `XOR  xorgate(res[22], AorB[22], invert);
    `XOR  xorgate(res[23], AorB[23], invert);
    `XOR  xorgate(res[24], AorB[24], invert);
    `XOR  xorgate(res[25], AorB[25], invert);
    `XOR  xorgate(res[26], AorB[26], invert);
    `XOR  xorgate(res[27], AorB[27], invert);
    `XOR  xorgate(res[28], AorB[28], invert);
    `XOR  xorgate(res[29], AorB[29], invert);
    `XOR  xorgate(res[30], AorB[30], invert);
endmodule

module xorer
(
	output xorer[31:0],
	input a[31:0],
	input b[31:0]
);
	`XOR  xorgate(xorer[0], a[0], b[0]);
  `XOR  xorgate(xorer[1], a[1], b[1]);
  `XOR  xorgate(xorer[2], a[2], b[2]);
  `XOR  xorgate(xorer[3], a[3], b[3]);
  `XOR  xorgate(xorer[4], a[4], b[4]);
  `XOR  xorgate(xorer[5], a[5], b[5]);
  `XOR  xorgate(xorer[6], a[6], b[6]);
  `XOR  xorgate(xorer[7], a[7], b[7]);
  `XOR  xorgate(xorer[8], a[8], b[8]);
  `XOR  xorgate(xorer[9], a[9], b[9]);
  `XOR  xorgate(xorer[10], a[10], b[10]);
  `XOR  xorgate(xorer[11], a[11], b[11]);
  `XOR  xorgate(xorer[12], a[12], b[12]);
  `XOR  xorgate(xorer[13], a[13], b[13]);
  `XOR  xorgate(xorer[14], a[14], b[14]);
  `XOR  xorgate(xorer[15], a[15], b[15]);
  `XOR  xorgate(xorer[16], a[16], b[16]);
  `XOR  xorgate(xorer[17], a[17], b[17]);
  `XOR  xorgate(xorer[18], a[18], b[18]);
  `XOR  xorgate(xorer[19], a[19], b[19]);
  `XOR  xorgate(xorer[20], a[20], b[20]);
  `XOR  xorgate(xorer[21], a[21], b[21]);
  `XOR  xorgate(xorer[22], a[22], b[22]);
  `XOR  xorgate(xorer[23], a[23], b[23]);
  `XOR  xorgate(xorer[24], a[24], b[24]);
  `XOR  xorgate(xorer[25], a[25], b[25]);
  `XOR  xorgate(xorer[26], a[26], b[26]);
  `XOR  xorgate(xorer[27], a[27], b[27]);
  `XOR  xorgate(xorer[28], a[28], b[28]);
  `XOR  xorgate(xorer[29], a[29], b[29]);
  `XOR  xorgate(xorer[30], a[30], b[30]);
  `XOR  xorgate(xorer[31], a[31], b[31]);
endmodule

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

module AdderAndSubtractorBitSlice
(
    output res, 
    output carryout,
    input a, 
    input b, 
    input carryinSub,
);
    wire BxorSub;
    wire xAorB;
    wire AandB;
    wire xAorBandCin;
    `XOR  xorgate(BxorSub, b, carryinSub);
    `XOR  xorgate(xAorB, a, BxorSub);   // OR gate produces AorB from A and B
    `XOR  xorgate(res, xAorB, carryinSub);
    `AND  andgate(AandB, a, BxorSub);
    `AND  andgate(xAorBandCin, xAorB, carryin);
    `OR   orgate(carryout, AandB, xAorBandCin);
endmodule

module FullAdderSubtractor32bit
(
  output[31:0] res,  // 2's complement sum of a and b
  output carryout,  // Carry out of the summation of a and b
  output overflow,  // True if the calculation resulted in an overflow
  input[31:0] a,     // First operand in 2's complement format
  input[31:0] b      // Second operand in 2's complement format
  input subtract
);
  wire carryout[30:0];

  AdderAndSubtractorBitSlice addsub0 (
    .res (res[0]),
    .carryout (carryout[0]),
    .a (a[0]),
    .b (b[0]),
    .carryinSub (subtract)
  );
  AdderAndSubtractorBitSlice addsub1 (
    .res (res[1]),
    .carryout (carryout[1]),
    .a (a[1]),
    .b (b[1]),
    .carryinSub (carryout[0])
  );
  AdderAndSubtractorBitSlice addsub2 (
    .res (res[2]),
    .carryout (carryout[2]),
    .a (a[2]),
    .b (b[2]),
    .carryinSub (carryout[1])
  );
  AdderAndSubtractorBitSlice addsub3 (
    .res (res[3]),
    .carryout (carryout[3]),
    .a (a[3]),
    .b (b[3]),
    .carryinSub (carryout[2])
  );
  AdderAndSubtractorBitSlice addsub4 (
    .res (res[4]),
    .carryout (carryout[4]),
    .a (a[4]),
    .b (b[4]),
    .carryinSub (carryout[3])
  );
  AdderAndSubtractorBitSlice addsub5 (
    .res (res[5]),
    .carryout (carryout[5]),
    .a (a[5]),
    .b (b[5]),
    .carryinSub (carryout[4])
  );
  AdderAndSubtractorBitSlice addsub6 (
    .res (res[6]),
    .carryout (carryout[6]),
    .a (a[6]),
    .b (b[6]),
    .carryinSub (carryout[5])
  );
  AdderAndSubtractorBitSlice addsub7 (
    .res (res[7]),
    .carryout (carryout[7]),
    .a (a[7]),
    .b (b[7]),
    .carryinSub (carryout[6])
  );
  AdderAndSubtractorBitSlice addsub8 (
    .res (res[8]),
    .carryout (carryout[8]),
    .a (a[8]),
    .b (b[8]),
    .carryinSub (carryout[7])
  );
  AdderAndSubtractorBitSlice addsub9 (
    .res (res[9]),
    .carryout (carryout[9]),
    .a (a[9]),
    .b (b[9]),
    .carryinSub (carryout[8])
  );
  AdderAndSubtractorBitSlice addsub10 (
    .res (res[10]),
    .carryout (carryout[10]),
    .a (a[10]),
    .b (b[10]),
    .carryinSub (carryout[9])
  );
  AdderAndSubtractorBitSlice addsub11 (
    .res (res[11]),
    .carryout (carryout[11]),
    .a (a[11]),
    .b (b[11]),
    .carryinSub (carryout[10])
  );
  AdderAndSubtractorBitSlice addsub12 (
    .res (res[12]),
    .carryout (carryout[12]),
    .a (a[12]),
    .b (b[12]),
    .carryinSub (carryout[11])
  );
  AdderAndSubtractorBitSlice addsub13 (
    .res (res[13]),
    .carryout (carryout[13]),
    .a (a[13]),
    .b (b[13]),
    .carryinSub (carryout[12])
  );
  AdderAndSubtractorBitSlice addsub14 (
    .res (res[14]),
    .carryout (carryout[14]),
    .a (a[14]),
    .b (b[14]),
    .carryinSub (carryout[13])
  );
  AdderAndSubtractorBitSlice addsub15 (
    .res (res[15]),
    .carryout (carryout[15]),
    .a (a[15]),
    .b (b[15]),
    .carryinSub (carryout[14])
  );
  AdderAndSubtractorBitSlice addsub16 (
    .res (res[16]),
    .carryout (carryout[16]),
    .a (a[16]),
    .b (b[16]),
    .carryinSub (carryout[15])
  );
  AdderAndSubtractorBitSlice addsub17 (
    .res (res[17]),
    .carryout (carryout[17]),
    .a (a[17]),
    .b (b[17]),
    .carryinSub (carryout[16])
  );
  AdderAndSubtractorBitSlice addsub18 (
    .res (res[18]),
    .carryout (carryout[18]),
    .a (a[18]),
    .b (b[18]),
    .carryinSub (carryout[17])
  );
  AdderAndSubtractorBitSlice addsub19 (
    .res (res[19]),
    .carryout (carryout[19]),
    .a (a[19]),
    .b (b[19]),
    .carryinSub (carryout[18])
  );
  AdderAndSubtractorBitSlice addsub20 (
    .res (res[20]),
    .carryout (carryout[20]),
    .a (a[20]),
    .b (b[20]),
    .carryinSub (carryout[19])
  );
  AdderAndSubtractorBitSlice addsub21 (
    .res (res[21]),
    .carryout (carryout[21]),
    .a (a[21]),
    .b (b[21]),
    .carryinSub (carryout[20])
  );
  AdderAndSubtractorBitSlice addsub22 (
    .res (res[22]),
    .carryout (carryout[22]),
    .a (a[22]),
    .b (b[22]),
    .carryinSub (carryout[21])
  );
  AdderAndSubtractorBitSlice addsub23 (
    .res (res[23]),
    .carryout (carryout[23]),
    .a (a[23]),
    .b (b[23]),
    .carryinSub (carryout[22])
  );
  AdderAndSubtractorBitSlice addsub24 (
    .res (res[24]),
    .carryout (carryout[24]),
    .a (a[24]),
    .b (b[24]),
    .carryinSub (carryout[23])
  );
  AdderAndSubtractorBitSlice addsub25 (
    .res (res[25]),
    .carryout (carryout[25]),
    .a (a[25]),
    .b (b[25]),
    .carryinSub (carryout[24])
  );
  AdderAndSubtractorBitSlice addsub26 (
    .res (res[26]),
    .carryout (carryout[26]),
    .a (a[26]),
    .b (b[26]),
    .carryinSub (carryout[25])
  );
  AdderAndSubtractorBitSlice addsub27 (
    .res (res[27]),
    .carryout (carryout[27]),
    .a (a[27]),
    .b (b[27]),
    .carryinSub (carryout[26])
  );
  AdderAndSubtractorBitSlice addsub28 (
    .res (res[28]),
    .carryout (carryout[28]),
    .a (a[28]),
    .b (b[28]),
    .carryinSub (carryout[27])
  );
  AdderAndSubtractorBitSlice addsub29 (
    .res (res[29]),
    .carryout (carryout[29]),
    .a (a[29]),
    .b (b[29]),
    .carryinSub (carryout[28])
  );
  AdderAndSubtractorBitSlice addsub30 (
    .res (res[30]),
    .carryout (carryout[30]),
    .a (a[30]),
    .b (b[30]),
    .carryinSub (carryout[29])
  );
  AdderAndSubtractorBitSlice addsub31 (
    .res (res[31]),
    .carryout (carryout[31]),
    .a (a[31]),
    .b (b[31]),
    .carryinSub (carryout[30])
  );


  didOverflow over1 (
    .overflow (overflow),
    .a (a[3]),
    .b (b[3]),
    .s (sum[3])
  );
endmodule

module slt
(
    output res,
    input subRes[31:0],
    input overflow 
);
    wire invOverflow;
    `NOT  invgate(invOverflow, overflow); // inverts overflow
    `AND  andgate(res, invOverflow, subRes[31]) // if invover and bit1 are high. then slt result is high
endmodule

module ALUcontrolLUT
//behavioral unit
(
output reg[2:0] 	muxindex,
output reg		invertB,
output reg		inverted,
...
input[2:0]	ALUcommand,
input a,
input b,
)

  always @(ALUcommand) begin
    case (ALUcommand)
      `ADD:  begin muxindex = 0; invertB=0; inverted = 0; end    
      `SUB:  begin muxindex = 0; invertB=1; inverted = 0; end	
      `XOR:  begin muxindex = 1; invertB=0; inverted = 0; end    
      `SLT:  begin muxindex = 2; invertB=0; inverted = 0; end
      `AND:  begin muxindex = 3; invertB=0; inverted = 0; end    
      `NAND: begin muxindex = 3; invertB=1; inverted = 1; end
      `NOR:  begin muxindex = 4; invertB=1; inverted = 1; end    
      `OR:   begin muxindex = 4; invertB=0; inverted = 0; end
    endcase
  end
endmodule

module ALUresultLUT
//behavioral unit
(
output reg[31:0] 	finalResult,
output reg		carryout,
output reg		zero,
output reg		overflow,
...
input[4:0]  muxIndex,
input[31:0] resultAddSub,
input[31:0] resultAndNand,
input[31:0] resultSLT,
input[31:0] resultOrNor,
input[31:0] resultXor,
input midcarryout,
input midoverflow,
input midzeroer,
//zero need to add
//overflow need to add

)
  always @(ALUcommand) begin
    case (ALUcommand)
      0:  begin finalResult = resultAddSub; carryout=midcarryout; zero = midzeroer; overflow = midoverflow; end    
      1:  begin finalResult = resultXor; carryout=0; zero = 0; overflow = 0; end	
      2:  begin finalResult = resultSLT; carryout=0; zero = 0; overflow = 0; end    
      3:  begin finalResult = resultAndNand; carryout=0; zero = 0; overflow = 0; end
      4:  begin finalResult = resultOrNor; carryout=0; zero = 0; overflow = 0; end    
    endcase
  end
endmodule



module AllBits
#(parameter WIDTH=32)
(
	output [WIDTH-1:0] out,
	input  [WIDTH-1:0] a, b,
	input command
);
	
	genvari;
	generate
		for (i=0; i<WIDTH; i=i+1)
		begin:genblock
			ALUcontrolLUT aluTable(command, a[i], b[i], .out (out[i])
			);
		end
	endgenerate
endmodule
