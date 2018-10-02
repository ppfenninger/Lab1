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

module ander
(
    output AandB,
    input a, 
    input b
);
    `AND  andgate(AandB, a, b);   // AND gate produces AandB from A and B
endmodule

module nander
(
    output AnandB,
    input a, 
    input b
);
    `NAND nandgate(AandB, a, b); // NAND gate produces AnadB from A and B
endmodule

module norer
(
    output AnorB,
    input a, 
    input b
);
    `NOR  norgate(AnorB, a, b);  // NOR gate produces AonrB from A and B
endmodule

module orer
(
    output AorB,
    input a, 
    input b 
);
    `OR  orgate(AorB, a, b);   // OR gate produces AorB from A and B
endmodule

module xorer
(
	output xorer,
	input a,
	input b
);
	`XOR  xorgate(xorer, a, b);
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
