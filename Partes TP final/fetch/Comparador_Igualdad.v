`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:51:38 11/17/2015 
// Design Name: 
// Module Name:    Comparador_Igualdad 
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
module Comparador_Igualdad(
	input wire [31:0] input1,
	input wire [31:0] input2,
	output reg EqualD
);

always@(*)
begin
	if(input1 == input2)
	begin
		EqualD <= 1;
	end
	else
	begin
		EqualD <= 0;
	end
end


endmodule