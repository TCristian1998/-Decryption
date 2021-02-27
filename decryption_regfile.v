`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:13:49 11/23/2020 
// Design Name: 
// Module Name:    decryption_regfile 
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
module decryption_regfile #(
			parameter addr_witdth = 8,
			parameter reg_width 	 = 16
		)(
			// Clock and reset interface
			input clk, 
			input rst_n,
			
			// Register access interface
			input[addr_witdth - 1:0] addr,
			input read,
			input write,
			input [reg_width -1 : 0] wdata,
			output reg [reg_width -1 : 0] rdata,
			output reg done,
			output reg error,
			
			// Output wires
			output [reg_width - 1 : 0] select,
			output [reg_width - 1 : 0] caesar_key,
			output [reg_width - 1 : 0] scytale_key,
			output [reg_width - 1 : 0] zigzag_key
    );
	 
reg a;
reg b; 	 
//pentru a putea sa afisam semnalul done si error dupa un ciclu de ceas ne vom folosi de aceaste doua variabile.
reg [reg_width - 1 : 0] select1;
reg [reg_width - 1 : 0] caesar_key1;
reg [reg_width - 1 : 0] scytale_key1;
reg [reg_width - 1 : 0] zigzag_key1;

always @(posedge clk) begin

if( a == 1) done <=1;
		else done <= 0;
//in a se afla valoarea 1 daca la bataia anterioara de ceas s-au efectuat scrieri sau citiri.		
if( b == 1) error <=1;
		else error <= 0;
//in b se afla valoarea 1 daca la bataia anterioara nu s-au facut scrieri si citire la adresa corecta.		
if(write == 1 || read == 1) a <=1;
		else a <=0;

		
if(addr != 8'h00 && addr != 8'h10  && addr != 8'h12  &&  addr!= 8'h14) b <= 1;
		else b <= 0;
//adaugamin fiecare variabila reg valoarea sa de reset
   if(rst_n == 0)   begin
						select1 <= 16'h0;
						caesar_key1 <= 16'h0;
						scytale_key1 <= 16'hFFFF;
						zigzag_key1 <= 16'h2;
					end
					
	else   begin
					case ({read,write}) 
						 2'b00:  begin // daca nici scrierea nici citirea nu sunt active atunci nu se va intampla nimic
						
								end
	                2'b01:  begin //daca scrierea este activa atunci variabilele de tip reg vor primi
					//informatia aflata in wdata.
										case (addr)
												8'h00: begin 
												          select1[1:0] <= wdata;
														end
												
												8'h10: begin
															caesar_key1 <= wdata;
														end		
														
												8'h12: begin 
												          scytale_key1 <= wdata;
														end
												
												8'h14: begin
															zigzag_key1 <= wdata;
														end		
										endcase
							end		
											
							2'b10:  begin //daca scrierea este activa atunci o sa se puna in rdata valoarea
							//unuia dintre registri
										case (addr)
												8'h00: begin 
												         rdata <= select1;
														end
												
												8'h10: begin
															rdata <= caesar_key1;
														end		
												
												8'h12: begin 
												         rdata <= scytale_key1;
														end
												
												8'h14: begin
															rdata <= zigzag_key1;
														end		
										endcase
									end 
					endcase 
			end

end
assign select = select1;
assign caesar_key = caesar_key1;
assign scytale_key = scytale_key1;
assign zigzag_key = zigzag_key1; 
	
endmodule
