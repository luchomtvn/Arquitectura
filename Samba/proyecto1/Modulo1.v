`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:07:36 08/10/2015 
// Design Name: 
// Module Name:    Modulo1 
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
module Modulo1 ( input A, B, C, D, output E, F);
	//wire F, E;
	wire AB, O, W, CD;
	
	assign AB = A & B;
	assign O = AB | C;
	assign W = ~O;
	assign CD = C & D;
	assign F = W | CD;
	assign E = C & D & CD;
	
endmodule