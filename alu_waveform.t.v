//ALU testbench
`timescale 1 ns / 1 ps
`include "alu_paige.v"

module testALU();
	reg[31:0] operandA;
	reg[31:0] operandB;
	reg[2:0]  command;
	wire[31:0] result;
	wire overflow;
	wire carryout;
	wire zero;

	alu alu (carryout, zero, overflow, result, operandA, operandB, command);

	initial begin
		$dumpfile("alu_wave.vcd");
    	$dumpvars(0, alu);

        $display("TESTING SLT");
        command=3'b011;
        operandA=32'd0;operandB=32'd1; #4000
        if (result != 32'd1) $display("0 < p TEST FAILED - result: %b", result);
        operandA=32'd1;operandB=32'd0; #4000
        if (result != 32'd0) $display("p not < 0 TEST FAILED - result %b", result);
	end
endmodule // testALU
