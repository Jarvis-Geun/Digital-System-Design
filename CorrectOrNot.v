// Before using this module, initiate wrong and correct in top module

module CorrectOrNot (
	input clk, reset, push_1, push_0,				// import rand_num from "top_test" module
	input [11:0] key,
	input reg [11:0] key_save, key_num_toss,		// import key from "key_pad" module
	output reg [3:0] wrong, correct, fail, success, up_down

);

	reg [11:0] key_num, key_num_t;
	reg [11:0] rand_num;
	reg [50:0] a, d;



always@(negedge push_0 or negedge reset)begin
	if(~reset) begin
		key_num <= 12'b0000_0000_0000;
	end
	
	else begin
		if       (key_save == 12'b010_000_000_000) begin
			key_num <= 0;
		end

		else if (key_save == 12'b000_000_000_001) begin
			key_num <= 1;
		end

		else if (key_save == 12'b000_000_000_010) begin
			key_num <= 2;
		end

		else if (key_save == 12'b000_000_000_100) begin
			key_num <= 3;
		end

		else if (key_save == 12'b000_000_001_000) begin
			key_num <= 4;
		end

		else if (key_save == 12'b000_000_010_000) begin
			key_num <= 5;
		end

		else if (key_save == 12'b000_000_100_000) begin
			key_num <= 6;
		end

		else if (key_save == 12'b000_001_000_000) begin
			key_num <= 7;
		end

		else if (key_save == 12'b000_010_000_000) begin
			key_num <= 8;
		end

		else if (key_save == 12'b000_100_000_000) begin
			key_num <= 9;
		end

		// I don't know why, but random number has to be declared in this section.
		// I declared other sections but It was not worked.
		// Actually It's not a real random number - it's just a constant - but It might be possible to use real random number
		// if I make a new random_num module. However, I didn't make the module because I didn't have enough time to make it.
		rand_num <= 12'b0000_0000_0111;

		if (d<100) begin
			d <= d+1;
		end

		else if(d == 100) begin
			d <= 0 ;
		end
	end
end

always@(posedge d or negedge reset) begin
	if(reset == 1'b0) begin
		wrong <= 0; correct <= 0; fail <= 0; success <= 0; up_down <= 0;
	end

	else if (correct >= 3) begin
		success <= 1;
	end

	else if (wrong >= 9) begin
		fail <= 1;
		wrong <=0;
	end

	else if ((rand_num - key_num) == 0 ) begin
		up_down <= 3;			// assign up_down "100" if (rand_num - key_num) is 0
		correct <= correct + 1;
	end

	else if (rand_num > key_num) begin
		up_down <= 1;			// up
		wrong <= wrong + 1;
	end

	else begin
		wrong <= wrong + 1;
		up_down <= 2;			// down

	end
	
end

endmodule