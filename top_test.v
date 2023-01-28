// This module is the main module(top module). All inputs, outputs from each modules are declared in this module.

module top_test(
	input rst, clk, push_0, push_1,
	input [3:0] key_pad_row,
	output [2:0] key_pad_col,
	output [7:0] seg_data, seg_com, lcd_data,
	output [9:0] dot_col,
	output [13:0] dot_row,
	output [15:0] led, 
	output lcd_rs, lcd_rw, lcd_en,
	output W1_piezo,
    	output reg [3:0] step_motor
);
	wire reset;
	assign reset = rst;

	wire [11:0] key;
	wire [11:0] key_save;
	
	wire clk_12_5M, clk_100k, clk_10k, clk_1k, clk_1s, clk_h, clk_step, clk_led;
	wire [3:0] wrong, correct, fail, success, up_down;
	wire [11:0] key_num_toss;
	

	// clk
	clk_div u1(.clk_25M(clk), .reset(reset), .clk_12_5M(clk_12_5M), .clk_100k(clk_100k),
                    .clk_10k(clk_10k), .clk_1k(clk_1k), .clk_1s(clk_1s), .clk_h(clk_h),
                    .clk_step(clk_step), .clk_led(clk_led));
	

	// key pad
	key_pad u2(.clk(clk_1k), .reset(reset), .key_pad_row(key_pad_row), .toss_end(toss_end), .key_pad_col(key_pad_col), .key(key), .key_save(key_save));


	//Correct Or Not
	CorrectOrNot u0(.clk(clk_1k), .push_0(push_0), .push_1(push_1), .reset(reset), .key(key), .wrong(wrong), .key_num_toss(key_num_toss), .correct(correct), .fail(fail), 
	.success(success), .up_down(up_down), .key_save(key_save));	
	

	// led
	led_dir u4(.clk(clk_10k), .reset(reset), .led(led), .wrong(wrong), .fail(fail));


	// 7-segment
	sev_seg u5(.clk_1k(clk_10k), .correct(correct), .wrong(wrong), .fail(fail), .success(success), .reset(reset), .seg_data(seg_data), .seg_com(seg_com));


	// Dot Matrix
	 dot_matrix u6(.clk(clk_1k), .reset(reset), .wrong(wrong), .fail(fail), .correct(correct), .dot_row(dot_row), .dot_col(dot_col));
	

	// text lcd		 
 	text_lcd u7(.clk(clk_1k), .reset(reset), .wrong(wrong), .correct(correct),  .up_down(up_down),  .lcd_en(lcd_en), .lcd_rs(lcd_rs), .lcd_rw(lcd_rw), .lcd_data(lcd_data));


	// piezo
     	piezo u8(.clk(clk_100k), .reset(reset), .sw2(key), .W1_piezo(W1_piezo));


    	// step_motor
	step_motor u9(.clk(clk_step), .reset(reset), .sw(push_0), .correct(correct), .step_motor(step_motor));

endmodule
