`define AND and #50
`define OR or #50
`define XOR xor #50
`define NOT not #50

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
	// Your code here
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

module ander
(
    input a, 
    input b, 
);

    wire AandB;

    `AND  andgate(AandB, a, b);   // AND gate produces AandB from A and B
endmodule

module nander
(
    input a, 
    input b, 
);
    wire AnandB;

    `NAND nandgate(AandB, a, b); // NAND gate produces AnadB from A and B
  
endmodule

module norer
(
    input a, 
    input b, 
);

    wire AnorB;

    `NOR  norgate(AnorB, a, b);  // NOR gate produces AonrB from A and B
endmodule

module orer
(
    input a, 
    input b, 
);

    wire AorB;
    `OR  orgate(AorB, a, b);   // OR gate produces AorB from A and B

endmodule

module structuralFullAdder
(
    output sum, 
    output carryout,
    input a, 
    input b, 
    input carryin
);

    wire xAorB;
    wire AandB;
    wire xAorBandCin;

    `XOR  xorgate(xAorB, a, b);   // OR gate produces AorB from A and B
    `XOR  xorgate(sum, xAorB, carryin);
    `AND  andgate(AandB, a, b);
    `AND  andgate(xAorBandCin, xAorB, carryin);
    `OR   orgate(carryout, AandB, xAorBandCin);
    
endmodule

module xorers
(
	output xorers,
	input a,
	input b, 
);
	'XOR   xorgate(xorers, a, b);
endmodule

module structuralFullSubtractor
(
    output sub, 
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
    `XOR  xorgate(sum, xAorB, carryin);
    `AND  andgate(AandB, a, BxorSub);
    `AND  andgate(xAorBandCin, xAorB, carryin);
    `OR   orgate(carryout, AandB, xAorBandCin);
    
endmodule



module FullAdder4bit
(
  output[3:0] sum,  // 2's complement sum of a and b
  output carryout,  // Carry out of the summation of a and b
  output overflow,  // True if the calculation resulted in an overflow
  input[3:0] a,     // First operand in 2's complement format
  input[3:0] b      // Second operand in 2's complement format
);
	wire carry01;
	wire carry12;
	wire carry23;

	structuralFullAdder add0 (
	  .sum (sum[0]),
	  .carryout (carry01),
	  .a (a[0]),
	  .b (b[0]),
	  .carryin (1'b0)
	);
	structuralFullAdder add1 (
	  .sum (sum[1]),
	  .carryout (carry12),
	  .a (a[1]),
	  .b (b[1]),
	  .carryin (carry01)
	);
	structuralFullAdder add2 (
	  .sum (sum[2]),
	  .carryout (carry23),
	  .a (a[2]),
	  .b (b[2]),
	  .carryin (carry12)
	);
	structuralFullAdder add3 (
	  .sum (sum[3]),
	  .carryout (carryout),
	  .a (a[3]),
	  .b (b[3]),
	  .carryin (carry23)
	);
	didOverflow over1 (
	  .overflow (overflow),
	  .a (a[3]),
	  .b (b[3]),
	  .s (sum[3])
	);
endmodule

// look up table needs editing 
module ALUcontrolLUT
//behavioral unit
(
output reg[2:0] 	muxindex,
output reg		invertB,
output reg		othercontrolsignal,
...
input[2:0]	ALUcommand
)

  always @(ALUcommand) begin
    case (ALUcommand)
      `ADD:  begin muxindex = 0; invertB=0; othercontrolsignal = ?; end    
      `SUB:  begin muxindex = 0; invertB=1; othercontrolsignal = ?; end
      `XOR:  begin muxindex = 1; invertB=?; othercontrolsignal = ?; end    
      `SLT:  begin muxindex = 2; invertB=?; othercontrolsignal = ?; end
      `AND:  begin muxindex = 3; invertB=?; othercontrolsignal = ?; end    
      `NAND: begin muxindex = 3; invertB=?; othercontrolsignal = ?; end
      `NOR:  begin muxindex = 4; invertB=?; othercontrolsignal = ?; end    
      `OR:   begin muxindex = 4; invertB=?; othercontrolsignal = ?; end
    endcase
  end
endmodule

module AllBits
#(parameter WIDTH=32)
(
	output [WIDTH-1:0] out,
	input  [WIDTH-1:0] a, b
);
	genvari;
	generate
		for (i=0; i<WIDTH; i=i+1)
		begin:genblock
			wire _out;
			ALUcontrolLUT(_out, a[i], b[i]);
		end
	endgenerate
endmodule
