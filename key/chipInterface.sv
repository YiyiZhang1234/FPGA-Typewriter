module chipInterface(

	input bit PS2_KBCLK,
	input bit PS2_KBDAT,
	input bit CLOCK_50,
	input bit KEY[0],
	output bit [17:0] LEDR);

	bit[7:0] led_d,led_q;
	bit parity_error_d,parity_error_q;
	bit rdy_d,rdy_q;
	bit rst_l;

	assign rst_l = KEY[0];
	assign LEDR[7:0] = led_q[7:0];
	assign LEDR[16] = parity_error_q;
	assign LEDR[17] = rdy_q;

	keyboard(.clk_k(PS2_KBCLK), .data(PS2_KBDAT), .led(led_d), 
			.parity_error(parity_error_d), .rdy(rdy_d));

	always_ff @(posedge CLOCK_50, negedge rst_l) begin
		if (~rst_l) begin
			led_q <= 8'b0;
			parity_error_q <= 0;
			rdy_q <= 0;
		end
		else begin
			led_q[7:0] <= led_d[7:0];
			parity_error_q <= parity_error_d;
	      rdy_q <= rdy_d;
		end
	end


endmodule