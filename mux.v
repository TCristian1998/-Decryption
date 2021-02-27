`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:53:30 11/26/2020 
// Design Name: 
// Module Name:    mux 
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
module mux #(
		parameter D_WIDTH = 8
	)(
		// Clock and reset interface
		input clk,
		input rst_n,
		
		//Select interface
		input[1:0] select,
		
		// Output interface
		output reg[D_WIDTH - 1 : 0] data_o,
		output reg						 valid_o,
				
		//output interfaces
		input [D_WIDTH - 1 : 0] 	data0_i,
		input   							valid0_i,
		
		input [D_WIDTH - 1 : 0] 	data1_i,
		input   							valid1_i,
		
		input [D_WIDTH - 1 : 0] 	data2_i,
		input     						valid2_i
    );
always @(posedge clk) begin

	if (valid0_i == 1) begin 
									valid_o <= 1;
									data_o <= data0_i;
							end
							
 	if (valid1_i == 1) begin 
									valid_o <= 1;
									data_o <= data1_i ;
							end 
							
	if (valid2_i == 1) begin 
									valid_o <= 1;
									data_o <= data2_i ;
							end 
	if (valid2_i == 0 && valid1_i == 0 && valid0_i == 0)  begin
																valid_o <=0;
																data_o <= 0;
														  end

end
endmodule
