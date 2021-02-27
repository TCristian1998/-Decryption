`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:12:00 11/23/2020 
// Design Name: 
// Module Name:    demux 
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

module demux #(
		parameter MST_DWIDTH = 32,
		parameter SYS_DWIDTH = 8
	)(
		// Clock and reset interface
		input clk_sys,
		input clk_mst,
		input rst_n,
		
		//Select interface
		input[1:0] select,
		
		// Input interface
		input [MST_DWIDTH -1  : 0]	 data_i,
		input 						 	 valid_i,
		
		//output interfaces
		output reg [SYS_DWIDTH - 1 : 0] 	data0_o,
		output reg     						valid0_o,
		
		output reg [SYS_DWIDTH - 1 : 0] 	data1_o,
		output reg     						valid1_o,
		
		output reg [SYS_DWIDTH - 1 : 0] 	data2_o,
		output reg     						valid2_o
    );

reg [31:0] a;
reg [6:0] h;
reg [6:0] b;
reg [1:0] c;
	
always @(posedge clk_mst) begin



	if(rst_n == 0) begin
							valid0_o <= 0;
							valid1_o <= 0;
							valid2_o <= 0;
						end
	 else begin 

				if(valid_i == 1) begin
											a <= data_i;
											
											if(select == 2'b00)  begin
																	   valid0_o <= 1;
																 end
																 
											if(select == 2'b01)  begin
																	   valid1_o <= 1;
																 end
																 
											if(select == 2'b10)  begin
																	   valid2_o <= 1;
																 end																	 
								end
					else 	begin
								 valid0_o <= 0;
								 valid1_o <= 0;
								 valid2_o <= 0;
							end

 			end
end

	
always @(posedge clk_sys) begin

	if(rst_n == 0) begin
							data0_o <= 0;
							data1_o <= 0;
							data2_o <= 0;
							h<=31;
							b<=0;
							c<= 0;
						end


	else begin
				if (valid_i == 1) begin	
										b<=b+1;
									end
				if (valid0_o == 1)  begin
													data0_o <=  a[ h -: 8 ];
													if(h==7) h<= 31;
														else h <= h-8;
												end
				
				if (valid1_o == 1)  begin
													data1_o <=  a[ h -: 8 ];
													if(h==7) h<= 31;
														else h <= h-8;
												end
			
				if ( valid2_o == 1)  begin
													data2_o <=  a[ h -: 8 ];
													if(h==7) h<= 31;
														else h <= h-8;
												end


		end

end
endmodule
