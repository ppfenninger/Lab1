//ALU testbench
`timescale 1 ns / 1 ps
`include "alu.v"

module testALU();
	reg[31:0] operandA;
	reg[31:0] operandB;
	reg[2:0]  command;
	wire[31:0] result;
	wire overflow;
	wire carryout;
	wire zero;

	TestAlu ALU (operandA, operandB, command);

	initial begin
		$dumpfile("alu.vcd");
    	$dumpvars(0, ALU);

    	$display("TESTING BASIC GATES");

    	// OR Test
    	a=32'b1100;b=32'b1010;command=3'b111; #1000
    	if(result != 32'b1110) $display("OR Test Failed - result: %b%b%b%b", result[3], result[2], result[1], result[0]);

    	// NOR Test
    	command=3'b110; #1000
    	if(result != 32'b0001) $display("NOR Test Failed - result: %b%b%b%b", result[3], result[2], result[1], result[0]);

    	// XOR Test
    	command=3'b010; #1000
    	if(result != 32'b0110) $display("XOR Test Failed - result: %b%b%b%b", result[3], result[2], result[1], result[0]);

    	// AND Test
    	command=3'b100; #1000
    	if(result != 32'b1000) $display("AND Test Failed - result: %b%b%b%b", result[3], result[2], result[1], result[0]);

    	// NAND Test
    	command=3'b101; #1000
    	if(result != 32'b0001) $display("NAND Test Failed - result: %b%b%b%b", result[3], result[2], result[1], result[0]);

    	$display("TESTING ADD");
    	command=3'b000;
    	a=32'd7000;b=32'd14000; #1000
    	if(result != 32'd21000) $display("p + p = p TEST FAILED - result: %d", result);
    	if(overflow != 0) $display("p + p = p OVERFLOW FAILED");
    	if(carryout != 0) $display("p + p = p CARRYOUT FAILED");
    	a=32'd2147483647;b=32'd14000; #1000
    	if(result != 32'd2147497647) $display("p + p = n TEST FAILED - result: %d", result);
    	if(overflow != 1) $display("p + p = n OVERFLOW FAILED");
    	if(carryout != 0) $display("p + p = n CARRYOUT FAILED");
    	a=32'd0;b=32'd87000; #1000
    	if(result != 32'd87000) $display("0 + p = p TEST FAILED - result: %d", result);
    	if(overflow != 0) $display("0 + p = p OVERFLOW FAILED");
    	if(carryout != 0) $display("0 + p = p CARRYOUT FAILED");
    	a=32'd3657483652;b=32'd2997483652; #1000
    	if(result != 32'd2360000008) $display("n + n = n TEST FAILED - result: %d", result);
    	if(overflow != 0) $display("n + n = n OVERFLOW FAILED");
    	if(carryout != 1) $display("n + n = n CARRYOUT FAILED");
    	a=32'd2147483652;b=32'd2147483652; #1000
    	if(result != 32'd8) $display("n + n = p TEST FAILED - result: %d", result);
    	if(overflow != 1) $display("n + n = p OVERFLOW FAILED");
    	if(carryout != 1) $display("n + n = p CARRYOUT FAILED");
    	a=32'd3657483652;b=32'd637483644; #1000
    	if(result != 32'd0) $display("n + p = 0 TEST FAILED - result: %d", result);
    	if(overflow != 0) $display("n + p = 0 OVERFLOW FAILED");
    	if(carryout != 1) $display("n + p = 0 CARRYOUT FAILED");
    	a=32'd3657483652;b=32'd637483645; #1000
    	if(result != 32'd1) $display("n + p = p TEST FAILED - result: %d", result);
    	if(overflow != 0) $display("n + p = p OVERFLOW FAILED");
    	if(carryout != 1) $display("n + p = p CARRYOUT FAILED");
    	a=32'd3657483652;b=32'd637483643; #1000
    	if(result != 32'd4294967295) $display("n + p = n TEST FAILED - result: %d", result);
    	if(overflow != 0) $display("n + p = n OVERFLOW FAILED");
    	if(carryout != 0) $display("n + p = n CARRYOUT FAILED");


    	$display("TESTING SUBTRACT");
    	command=3'b001;
    	a=32'd;b=32'd637483644; #1000
    	if(result != 32'd3657483652) $display("0 - p = n TEST FAILED - result: %d", result); //the result is equivalent to -637483644
    	if(overflow != 0) $display("0 - p = n OVERFLOW FAILED");
    	if(carryout != 0) $display("0 - p = n CARRYOUT FAILED");
    	a=32'd;b=32'd3657483652; #1000 // b is equivalent to -637483644
    	if(result != 32'd637483644) $display("0 - n = p TEST FAILED - result: %d", result);
    	if(overflow != 0) $display("0 - n = p OVERFLOW FAILED");
    	if(carryout != 0) $display("0 - n = p CARRYOUT FAILED");
    	a=32'd3657483652;b=32'd3657483652; #1000 // a and b is equivalent to -637483644
    	if(result != 32'd0) $display("n - n = 0 TEST FAILED - result: %d", result);
    	if(overflow != 0) $display("n - n = 0 OVERFLOW FAILED");
    	if(carryout != 1) $display("n - n = 0 CARRYOUT FAILED");
    	a=32'd637483644;b=32'd637483644; #1000
    	if(result != 32'd) $display("p - p = 0 TEST FAILED - result: %d", result);
    	if(overflow != 0) $display("p - p = 0 OVERFLOW FAILED");
    	if(carryout != 1) $display("p - p = 0 CARRYOUT FAILED");
    	a=32'd436258181;b=32'd236258181; #1000
    	if(result != 32'd200000000) $display("p - p = p TEST FAILED - result: %d", result);
    	if(overflow != 0) $display("p - p = p OVERFLOW FAILED");
    	if(carryout != 1) $display("p - p = p CARRYOUT FAILED");
    	a=32'd436258181;b=32'd2013265920; #1000
    	if(result != 32'd2449524101) $display("p - p = n TEST FAILED - result: %d", result); //result is equivalent to -1845443195
    	if(overflow != 0) $display("p - p = n OVERFLOW FAILED");
    	if(carryout != 0) $display("p - p = n CARRYOUT FAILED");
    	a=32'd3657483652;b=32'd3657483653; #1000 //a and b both correspond to negative numbers
    	if(result != 32'd4294967295) $display("n - n = n TEST FAILED - result: %d", result); //the result is also a negative twos complement number
    	if(overflow != 0) $display("n - n = n OVERFLOW FAILED");
    	if(carryout != 0) $display("n - n = n CARRYOUT FAILED");
    	a=32'd3657483652;b=32'd3657483653; #1000
    	if(result != 32'd1) $display("n - n = p TEST FAILED - result: %d", result);
    	if(overflow != 0) $display("n - n = p OVERFLOW FAILED");
    	if(carryout != 1) $display("n - n = p CARRYOUT FAILED");
    	a=32'd7000;b=32'd4294953296 ; #1000 //b is the equivalent of -14000
    	if(result != 32'd21000) $display("p - n = p TEST FAILED - result: %d", result);
    	if(overflow != 0) $display("p - n = p OVERFLOW FAILED");
    	if(carryout != 0) $display("p - n = p CARRYOUT FAILED");
    	a=32'd2147483647;b=32'd4294953296; #1000
    	if(result != 32'd2147497647) $display("p - n = n TEST FAILED - result: %d", result);
    	if(overflow != 1) $display("p - n = n OVERFLOW FAILED");
    	if(carryout != 0) $display("p - n = n CARRYOUT FAILED");
    	a=32'd3657483652;b=32'd1297483644; #1000
    	if(result != 32'd2360000008) $display("n - p = n TEST FAILED - result: %d", result);
    	if(overflow != 0) $display("n - p = n OVERFLOW FAILED");
    	if(carryout != 1) $display("n - p = n CARRYOUT FAILED");
    	a=32'd2147483652;b=32'd2147483644; #1000
    	if(result != 32'd8) $display("n - p = p TEST FAILED - result: %d", result);
    	if(overflow != 1) $display("n - p = p OVERFLOW FAILED");
    	if(carryout != 1) $display("n - p = p CARRYOUT FAILED");

    	$display("TESTING SLT");
    	command=3'b011;
    	a=32'd0;b=32'd1000; #1000
    	if (result != 32'd1) $display("0 < p TEST FAILED");
    	a=32'd1000;b=32'd0; #1000
    	if (result != 32'd0) $display("p not < 0 TEST FAILED");
    	a=32'd0;b=32'd3657483652; #1000
    	if (result != 32'd0) $display("0 not < n TEST FAILED");
    	a=32'd3657483652;b=32'd0; #1000
    	if (result != 32'd1) $display("n < 0 TEST FAILED");
    	a=32'd1000;b=32'd2000; #1000
    	if (result != 32'd1) $display("p < p TEST FAILED");
    	a=32'd2000;b=32'd1000; #1000
    	if (result != 32'd0) $display("p not < p TEST FAILED");
    	a=32'd2360000008;b=32'd3657483652; #1000
    	if (result != 32'd1) $display("n < n TEST FAILED");
    	a=32'd3657483652;b=32'd2360000008; #1000
    	if (result != 32'd0) $display("n not < n TEST FAILED");
    	a=32'd3657483652;b=32'd1000; #1000
    	if (result != 32'd1) $display("n < p TEST FAILED");
    	a=32'd1000;b=32'd3657483652; #1000
    	if (result != 32'd0) $display("p not < n TEST FAILED");
	end
endmodule // testALU
