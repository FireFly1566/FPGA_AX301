
`timescale 1ns/1ps

module pll_test(
		input clk,
		input rst_n,
		output clkout1,
		output clkout2,
		output clkout3,
		output clkout4
);

wire locked;

pll pll_inst(
			.inclk0(clk),
			.c0(clkout1),
			.c1(clkout2),
			.c2(clkout3),
			.c3(clkout4),
			
			//status and control signals
			.areset(~rst_n),
			.locked(locked)
		);


endmodule