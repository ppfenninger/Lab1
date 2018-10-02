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
    input a, 
    input b,
    input invert //used for nand   if invert=1 then not AandB
);  // AND gate produces AandB from A and B
    wire AandB;
    wire nAandB;
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





















endmodule

module orer
(
    output AorB[31:0],
    input a, 
    input b 
);  // OR gate produces AorB from A and B
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
endmodule

module norer
(
    output AnorB,
    input a, 
    input b
);  // NOR gate produces AonrB from A and B
    `NOR  norgate(AnorB[0], a[0], b[0]);
    `NOR  norgate(AnorB[1], a[1], b[1]);
    `NOR  norgate(AnorB[2], a[2], b[2]);
    `NOR  norgate(AnorB[3], a[3], b[3]);
    `NOR  norgate(AnorB[4], a[4], b[4]);
    `NOR  norgate(AnorB[5], a[5], b[5]);
    `NOR  norgate(AnorB[6], a[6], b[6]);
    `NOR  norgate(AnorB[7], a[7], b[7]);
    `NOR  norgate(AnorB[8], a[8], b[8]);
    `NOR  norgate(AnorB[9], a[9], b[9]);
    `NOR  norgate(AnorB[10], a[10], b[10]);
    `NOR  norgate(AnorB[11], a[11], b[11]);
    `NOR  norgate(AnorB[12], a[12], b[12]);
    `NOR  norgate(AnorB[13], a[13], b[13]);
    `NOR  norgate(AnorB[14], a[14], b[14]);
    `NOR  norgate(AnorB[15], a[15], b[15]);
    `NOR  norgate(AnorB[16], a[16], b[16]);
    `NOR  norgate(AnorB[17], a[17], b[17]);
    `NOR  norgate(AnorB[18], a[18], b[18]);
    `NOR  norgate(AnorB[19], a[19], b[19]);
    `NOR  norgate(AnorB[20], a[20], b[20]);
    `NOR  norgate(AnorB[21], a[21], b[21]);
    `NOR  norgate(AnorB[22], a[22], b[22]);
    `NOR  norgate(AnorB[23], a[23], b[23]);
    `NOR  norgate(AnorB[24], a[24], b[24]);
    `NOR  norgate(AnorB[25], a[25], b[25]);
    `NOR  norgate(AnorB[26], a[26], b[26]);
    `NOR  norgate(AnorB[27], a[27], b[27]);
    `NOR  norgate(AnorB[28], a[28], b[28]);
    `NOR  norgate(AnorB[29], a[29], b[29]);
    `NOR  norgate(AnorB[30], a[30], b[30]);
    `NOR  norgate(AnorB[31], a[31], b[31]);
endmodule

module xorer
(
	output xorer[31:0],
	input a,
	input b
);
	`XOR  xorgate(xorer[0], a[0], b[0]);
  `XOR  xorgate(xorer[0], a[0], b[0]);
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

module slt
(
    output slter,
    input subResBit1,
    input overflow 
);
    wire invOverflow;
    `NOT  invgate(invOverflow, overflow); // inverts overflow
    `AND  andgate(slter, invOverflow, subResBit1) // if invover and bit1 are high. then slt result is high
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
