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
	AllBits allbit1(
  		.a(operandA),             // input
  		.b(operandB),             // input
  		.command(command), 	  // input
  		.out(result)  		  // output
		)
);
endmodule

module didOverflow
(
    output overflow,
    input a, 
    input b, 
    input s
);
	wire notA;
	wire notB;
	wire notS;
    wire aAndB;
    wire notaAndNotb;
    wire negToPos;
    wire posToNeg;

    `NOT aNot(notA, a);
    `NOT bNot(notB, b);
    `NOT sNot(notS, s);

    `AND andab(aAndB, a, b);
    `AND andabNot(notaAndNotb, notA, notB);

    `AND andSwitch1(negToPos, aAndB, notS);
    `AND andSwitch2(posToNeg, notaAndNotb, s);

    `OR orGate(overflow, negToPos, posToNeg);

endmodule

module anderAndnander
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

module orer
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

module AdderAndSubtractor
(
    output res, 
    output carryout,
    input a, 
    input b, 
    input carryin,
    input subtract
);
    wire BxorSub;
    wire xAorB;
    wire AandB;
    wire xAorBandCin;

    `XOR  xorgate(BxorSub, b, subtract);
    `XOR  xorgate(xAorB, a, BxorSub);   // OR gate produces AorB from A and B
    `XOR  xorgate(res, xAorB, carryin);
    `AND  andgate(AandB, a, BxorSub);
    `AND  andgate(xAorBandCin, xAorB, carryin);
    `OR   orgate(carryout, AandB, xAorBandCin);
endmodule

module behavioral4bitMultiplexer
(
    output out,
    input address0, address1, address2,
    input in0, in1, in2, in3, in4, in5, in6, in7 
);
    // Join single-bit inputs into a bus, use address as index
    wire[7:0] inputs = {in7, in6, in5, in4, in3, in2, in1, in0};
    wire[2:0] address = {address2, address1, address0};
    assign out = inputs[address];
endmodule

// look up table needs editing 
module ALUcontrolLUT
//behavioral unit
(
output reg[2:0] 	muxindex,
output reg		invertB,
//output reg		othercontrolsignal,
...
input[2:0]	ALUcommand,
input a,
input b,
)

  always @(ALUcommand) begin
    case (ALUcommand)
      `ADD:  begin muxindex = 0; invertB=0; end    //othercontrolsignal = ?;
      `SUB:  begin muxindex = 0; invertB=1; end	
      `XOR:  begin muxindex = 1; invertB=0; end    
      `SLT:  begin muxindex = 2; invertB=0; end
      `AND:  begin muxindex = 3; invertB=0; end    
      `NAND: begin muxindex = 3; invertB=1; end
      `NOR:  begin muxindex = 4; invertB=1; end    
      `OR:   begin muxindex = 4; invertB=0; end
    endcase
	behavioral4bitMultiplexer mux() //sam work on this. 
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
