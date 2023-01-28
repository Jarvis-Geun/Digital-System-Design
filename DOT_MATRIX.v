// DOT_MATRIX good

module dot_matrix(
	input clk, reset,
	input [3:0] wrong, fail, correct, 
	output reg [13:0] dot_row,
	output reg [9:0] dot_col
);
	
	reg [3:0] c_crt;
	reg [3:0] c_wrg;
	reg [3:0] sel_count;
	reg [3:0] count;
	reg [13:0] dot_data_0, dot_data_1, dot_data_2, dot_data_3,dot_data_4,dot_data_5,
			dot_data_6, dot_data_7, dot_data_8, dot_data_9;

always @(posedge clk or negedge reset) begin 		// clk_1kHz is declared in top_test module
	if(reset == 1'b0) begin			// negedge reset
		dot_col <= 0;
		sel_count <= 0;
	end

	else begin 				// posedge clk 
		if( sel_count >= 9)
			sel_count <= 0;
		else 
			sel_count <= sel_count + 1;
	
		case (sel_count) 
			4'd0 : dot_col <= 10'b10_0000_0000;
			4'd1 : dot_col <= 10'b01_0000_0000;
			4'd2 : dot_col <= 10'b00_1000_0000;
			4'd3 : dot_col <= 10'b00_0100_0000;
			4'd4 : dot_col <= 10'b00_0010_0000;
			4'd5 : dot_col <= 10'b00_0001_0000;
			4'd6 : dot_col <= 10'b00_0000_1000;
			4'd7 : dot_col <= 10'b00_0000_0100;
			4'd8 : dot_col <= 10'b00_0000_0010;
			4'd9 : dot_col <= 10'b00_0000_0001;
			default : dot_col <= 0;
		endcase 
	end
end

always @(posedge correct or negedge reset) begin
		if(~reset) begin
			c_crt <= 0; 
		end

		else if(correct >= 1) begin
			c_crt <= 4'd1;
			
		end
end

always@(posedge wrong or negedge reset) begin
		if(~reset) begin
			c_wrg <= 0; 
		end

		else begin
			c_wrg <= c_wrg + 4'd1;
		end
end

always@(posedge clk) begin 	
	if(c_crt == 4'd1) begin 
				dot_data_9 <= 14'b00_0000_0000_0000;
				dot_data_8 <= 14'b11_1111_0011_1100;
				dot_data_7 <= 14'b10_0100_0100_0010;
				dot_data_6 <= 14'b10_0100_1001_0101;
				dot_data_5 <= 14'b01_1000_1010_0001;
	
				dot_data_4 <= 14'b01_1000_1010_0001;
				dot_data_3 <= 14'b10_0100_1001_0101;
				dot_data_2 <= 14'b10_0100_0100_0010;
				dot_data_1 <= 14'b11_1111_0011_1100;
				dot_data_0 <= 14'b00_0000_0000_0000;
	end

	else if(c_wrg == 4'd1 ) begin 
				dot_data_9 <= 14'b11_1111_1111_0000;
				dot_data_8 <= 14'b01_0000_0000_1100;
				dot_data_7 <= 14'b01_0000_1001_0010;
				dot_data_6 <= 14'b10_0000_1011_0001;
				dot_data_5 <= 14'b01_0011_1001_0001;

				dot_data_4 <= 14'b01_0011_1000_0001;
				dot_data_3 <= 14'b10_0011_1000_0001;
				dot_data_2 <= 14'b01_0000_1011_0010;
				dot_data_1 <= 14'b10_0000_0000_1100;
				dot_data_0 <= 14'b11_1111_1111_0000;
	end

	else if(c_wrg == 4'd2) begin 	
				dot_data_9 <= 14'b11_1111_1111_0000;
				dot_data_8 <= 14'b01_0000_0000_1100;
				dot_data_7 <= 14'b01_0000_1001_0010;
				dot_data_6 <= 14'b10_0000_1011_0001;
				dot_data_5 <= 14'b01_0011_1001_0001;

				dot_data_4 <= 14'b01_0011_1000_0001;
				dot_data_3 <= 14'b10_0011_1000_0001;
				dot_data_2 <= 14'b01_0000_1011_0010;
				dot_data_1 <= 14'b10_0000_0000_1100;
				dot_data_0 <= 14'b11_1111_1111_0000;
	end

	else if(c_wrg == 4'd3) begin 
				dot_data_9 <= 14'b00_0000_0111_1111;
				dot_data_8 <= 14'b10_0001_0000_1001;
				dot_data_7 <= 14'b11_1111_0000_1001;
				dot_data_6 <= 14'b10_0001_0000_1001;
				dot_data_5 <= 14'b00_0000_0000_0001;

				dot_data_4 <= 14'b00_0000_0111_1110;
				dot_data_3 <= 14'b11_1111_0000_1001;
				dot_data_2 <= 14'b10_0000_0000_1001;
				dot_data_1 <= 14'b10_0000_0000_1001;
				dot_data_0 <= 14'b10_0000_0111_1110;	
	end

 	else begin 
				dot_data_9 <= 14'b00_0000_0001_1000;
				dot_data_8 <= 14'b00_0000_0000_1100;
				dot_data_7 <= 14'b00_0000_0000_0110;
				dot_data_6 <= 14'b00_0110_1111_1111;
				dot_data_5 <= 14'b00_1100_0000_0110;

				dot_data_4 <= 14'b01_1000_0000_1100;
				dot_data_3 <= 14'b11_1111_1101_1000;
				dot_data_2 <= 14'b01_1000_0000_0000;
				dot_data_1 <= 14'b00_1100_0000_0000;
				dot_data_0 <= 14'b00_0110_0000_0000;
	end
end

always @ (posedge clk or negedge reset) begin  // clk = 1kHz
	if(reset == 1'b0) begin 
			dot_row<=0;
	end
	else begin 
		case (sel_count) 		
			4'd0 : dot_row <= dot_data_0;
			4'd1 : dot_row <= dot_data_1;
			4'd2 : dot_row <= dot_data_2;
			4'd3 : dot_row <= dot_data_3;
			4'd4 : dot_row <= dot_data_4;
			4'd5 : dot_row <= dot_data_5;
			4'd6 : dot_row <= dot_data_6;
			4'd7 : dot_row <= dot_data_7;
			4'd8 : dot_row <= dot_data_8;
			4'd9 : dot_row <= dot_data_9;
			default : dot_row <= 0;
		endcase 
	end
end

endmodule





