`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:48:24 11/07/2015 
// Design Name: 
// Module Name:    modulo_test 
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
module modulo_test
(
	input wire [7:0]r_data,
	input wire clk,
	input wire rx_empty,
	input wire tx_full,
	output reg [7:0]w_data,
	output reg rd,
	output reg wr
);

	
//Estados
localparam [2:0] START = 4'b0000,
					  IDLE = 4'b0001,
					  RECIBO = 4'b0010,
					  PASO	= 4'b0011,
					  CONTINUO = 4'b0100,
					  ENVIAR = 4'b0101,
					  ESPERO = 4'b0110;
					  
					  
					  
//Variables internas
reg [7:0] buffer = 1;
reg [3:0] current_state = 4'b0000;
reg [3:0] next_state = 4'b0000;

//Variables para el pipe.
reg inicio = 0; //variable que reinicia todo el pipe a 0.
reg activo = 0; //Variable que habilita los clk del pipe.
reg [2:0]s = 0;
integer indice = 0; //variable utilizada para enviar el buffer
reg [11:0]i_sup = 0;
reg [11:0]i_bajo = 0;
reg [7:0]bytes = 148; //cantidad de bytes a enviar en buffer envio

//Cables para el pipe
// PC
wire [8:0]PCF;
//Instruccion
wire [31:0]InstrD;

// se�ales de control
wire [1:0]MemReadD;
wire RegWriteD;
wire MemtoRegD;
wire [3:0]MemWriteD;
wire [3:0]ALUControlID;
wire [1:0]ALUSrcD;
wire RegDstD;
wire BranchD; 

//banco de registros
wire [31:0]out0;
wire [31:0]out1;
wire [31:0]out2;
wire [31:0]out3;
wire [31:0]out4;
wire [31:0]out5;
wire [31:0]out6;
wire [31:0]out7;
wire [31:0]out8;
wire [31:0]out9;
wire [31:0]out10;
wire [31:0]out11;
wire [31:0]out12;
wire [31:0]out13;
wire [31:0]out14;
wire [31:0]out15;
wire [31:0]out16;
wire [31:0]out17;
wire [31:0]out18;
wire [31:0]out19;
wire [31:0]out20;
wire [31:0]out21;
wire [31:0]out22;
wire [31:0]out23;
wire [31:0]out24;
wire [31:0]out25;
wire [31:0]out26;
wire [31:0]out27;
wire [31:0]out28;
wire [31:0]out29;
wire [31:0]out30;
wire [31:0]out31;

// se�ales de salida de la unidad de riesgos
wire StallF;
wire StallD;
wire [1:0]ForwardAD;
wire [1:0]ForwardBD;
wire FlushE;
wire [1:0]ForwardAE;
wire [1:0]ForwardBE;

wire finalW;

Pipe pipeline
(
	.clk(clk),
	.inicio(inicio),
	.activo(activo),
	.PCF_o(PCF),
	.InstrD_o(InstrD),
	.MemReadD_o(MemReadD),
	.RegWriteD_o(RegWriteD),
	.MemtoRegD_o(MemtoRegD),
	.MemWriteD_o(MemWriteD),
	.ALUControlID_o(ALUControlID),
	.ALUSrcD_o(ALUSrcD),
	.RegDstD_o(RegDstD),
	.BranchD_o(BranchD), 
	.out0_o(out0),
	.out1_o(out1),
	.out2_o(out2),
	.out3_o(out3),
	.out4_o(out4),
	.out5_o(out5),
	.out6_o(out6),
	.out7_o(out7),
	.out8_o(out8),
	.out9_o(out9),
	.out10_o(out10),
	.out11_o(out11),
	.out12_o(out12),
	.out13_o(out13),
	.out14_o(out14),
	.out15_o(out15),
	.out16_o(out16),
	.out17_o(out17),
	.out18_o(out18),
	.out19_o(out19),
	.out20_o(out20),
	.out21_o(out21),
	.out22_o(out22),
	.out23_o(out23),
	.out24_o(out24),
	.out25_o(out25),
	.out26_o(out26),
	.out27_o(out27),
	.out28_o(out28),
	.out29_o(out29),
	.out30_o(out30),
	.out31_o(out31),
	.StallF_o(StallF),
	.StallD_o(StallD),
	.ForwardAD_o(ForwardAD),
	.ForwardBD_o(ForwardBD),
	.FlushE_o(FlushE),
	.ForwardAE_o(ForwardAE),
	.ForwardBE_o(ForwardBE),
	.finalW_o(finalW)
);

wire [1183:0]buffer_envio = 0;

Buffer_out #(1184) superbuffer
(
	.PCF(PCF),
	.InstrD(InstrD),
	.MemReadD(MemReadD),
	.RegWriteD(RegWriteD),
	.MemtoRegD(MemtoRegD),
	.MemWriteD(MemWriteD),
	.ALUControlID(ALUControlID),
	.ALUSrcD(ALUSrcD),
	.RegDstD(RegDstD),
	.BranchD(BranchD), 
	.out0(out0),
	.out1(out1),
	.out2(out2),
	.out3(out3),
	.out4(out4),
	.out5(out5),
	.out6(out6),
	.out7(out7),
	.out8(out8),
	.out9(out9),
	.out10(out10),
	.out11(out11),
	.out12(out12),
	.out13(out13),
	.out14(out14),
	.out15(out15),
	.out16(out16),
	.out17(out17),
	.out18(out18),
	.out19(out19),
	.out20(out20),
	.out21(out21),
	.out22(out22),
	.out23(out23),
	.out24(out24),
	.out25(out25),
	.out26(out26),
	.out27(out27),
	.out28(out28),
	.out29(out29),
	.out30(out30),
	.out31(out31),
	.StallF(StallF),
	.StallD(StallD),
	.ForwardAD(ForwardAD),
	.ForwardBD(ForwardBD),
	.FlushE(FlushE),
	.ForwardAE(ForwardAE),
	.ForwardBE(ForwardBE),
	.buffer_envio(buffer_envio)
);


reg [1183:0]buffer_e = 0;

wire [7:0] buffer_envio_aux [147:0];	

always @(*)
begin
	buffer_e <= buffer_envio;
end

generate
	genvar i;
		for(i=0;i<148;i=i+1)begin:nombre
			assign buffer_envio_aux[i]=buffer_e[(i+1)*8-1 : i*8];
		end
endgenerate
/*
	//Fracciona los registros
	generate
	genvar i;
		for(i=0;i<148;i=i+1)begin:nombre
			assign buffer_envio_aux[i]=buffer_envio[(i+1)*8-1 : i*8];
		end
	endgenerate
	*/
always @(posedge clk)
begin
		current_state <= next_state;
end

		
always @(posedge clk) // always de logica de salida
begin
	case(current_state)
		START:
			begin
				w_data=buffer;
				rd = 0;
				wr = 0;
				//Inicializo el pipe
				inicio = 1;
				activo = 1;
				if(s == 3)
				begin
					s = 0;
					next_state = IDLE;
				end
				else
				begin
					s = s+1;
					next_state = START;
				end
			end
		IDLE: // estado inicial. Idle
				begin
					activo = 0;
					inicio = 0;
					if(rx_empty == 0)
					begin
						rd=1;
						next_state = RECIBO;
					end
					else
					begin
						rd=0;
						next_state = IDLE;
					end
				end
		RECIBO: 
				begin
					//Espero que rx empty vuelva a 1
					if(rx_empty == 1)
					begin
						buffer = r_data;
						rd = 0;
						/*
							si buffer es p voy a paso
							si buffer es c voy a cont
						*/
						next_state = CONTINUO;
					end
					else
					begin
						next_state = RECIBO;
					end
				end
		CONTINUO:
				begin
					activo = 1;
					indice = 0;
					if(finalW == 1)
					begin
						next_state = ENVIAR;
					end
					else
					begin
						next_state = CONTINUO;
					end
				end
		ENVIAR:
				begin
					indice = indice+1;
					//w_data = buffer_envio[(indice*8)-1:(indice*8)-8];
					w_data = buffer_envio_aux[indice-1];
					wr = 1;
					next_state = ESPERO;
				end
		ESPERO: 
				begin
					if(tx_full == 1)
					begin
						wr = 0;
						if(indice == bytes)
						begin
							next_state = IDLE;
						end
						else
						begin
							next_state = ENVIAR;
						end
					end
					else
					begin
						next_state = ESPERO;
					end
				end
	endcase
end//always de logica de salida
	


endmodule



