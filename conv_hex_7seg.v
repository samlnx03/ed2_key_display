`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:43:05 01/14/2016 
// Design Name: 
// Module Name:    conv_hex_7seg
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module conv_hex_7seg(
    input [3:0] hex,
    output reg [7:0] sieteseg_a2g_dp
    );
	 
	 always @(*) begin
		 case (hex)
					4'b0000: sieteseg_a2g_dp=8'b0000_0011;
					4'd1: sieteseg_a2g_dp=8'b1001_1111;
					4'd2: sieteseg_a2g_dp=8'b0010_0101;
					4'd3: sieteseg_a2g_dp=8'b0000_1101;
					4'd4: sieteseg_a2g_dp=8'b1001_1001;
					4'd5: sieteseg_a2g_dp=8'b0100_1001;
					4'd6: sieteseg_a2g_dp=8'b1100_0001;
					4'd7: sieteseg_a2g_dp=8'b0001_1111;
					4'd8: sieteseg_a2g_dp=8'b0000_0001;
					4'd9: sieteseg_a2g_dp=8'b0001_1001;
					
					4'ha: sieteseg_a2g_dp=8'b0001_0001;
					4'hb: sieteseg_a2g_dp=8'b1100_0001;
					4'hc: sieteseg_a2g_dp=8'b0110_0011;
					4'hd: sieteseg_a2g_dp=8'b1000_0101;
					4'he: sieteseg_a2g_dp=8'b0110_0001;
					4'hf: sieteseg_a2g_dp=8'b0111_0001;
					default: sieteseg_a2g_dp=8'hff;
		 endcase
    end
 
endmodule
