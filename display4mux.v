`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:21:21 01/14/2016 
// Design Name: 
// Module Name:    display4mux 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//		reloj de 50 Mhz de la basys2
//		load señal de cargar datos a unos de los 4 buffers de 8 bits 
//		datai dato de 8 bits a cargar en el buffer 7 seg a-g+dp
//		bufdestino buffer destino para cargar
//	
// 	con load=0 multiplexa
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module display4mux(
    input reset,
	 input reloj, load,
	 input [7:0] datai,
	 input [1:0] bufdestino,
	 
    output reg [7:0] disp_7seg_a_g_dp,
	 output reg [3:0] anodos
    );

	wire [7:0] buff[3:0];
	// bufdestino (when load=1)
	//		00 multiplexing displaying
	//		00 datai -> buf[0]
	//		01 datai -> buf[1]
	//		10 datai -> buf[2]
	//		11 datai -> buf[3]

	wire [1:0] anodosctrl;
	reg [3:0] e;	//enable de ff_d's
	
	reg[20:0] divisor;	// para el div de frec del despliegue multiplexado

	FF_D	buff0(reloj, reset, e[0], datai, buff[0]),
			buff1(reloj, reset, e[1], datai, buff[1]),
			buff2(reloj, reset, e[2], datai, buff[2]),
			buff3(reloj, reset, e[3], datai, buff[3]);
			
	always @(*) begin
		if(load)
		  case(bufdestino)
			2'b00:	e=4'b1;
			2'b01:	e=4'd2;
			2'b10:	e=4'd4;
			2'b11:	e=4'd8;
		  endcase
		 else
			e=4'b0;
	end
			
	always @(posedge reloj) begin
		divisor<=divisor+1;
	end

	// despliegue
	assign anodosctrl={divisor[15],divisor[14]};	 
	always @(anodosctrl, buff[0], buff[1], buff[2], buff[3])
		case(anodosctrl)
			2'd0: begin disp_7seg_a_g_dp=buff[0]; anodos=4'b1110; end
			2'd1: begin disp_7seg_a_g_dp=buff[1]; anodos=4'b1101; end
			2'd2: begin disp_7seg_a_g_dp=buff[2]; anodos=4'b1011; end
			2'd3: begin disp_7seg_a_g_dp=buff[3]; anodos=4'b0111; end
			default: anodos=4'b1111;
		endcase

endmodule

module FF_D(input clk, input reset, e, input [7:0] d, output reg [7:0] q);
	always@(posedge clk) begin
		if(reset)
			q<=8'b0;
		if(e) q<=d;
	end
endmodule

