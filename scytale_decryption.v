`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:24:12 11/27/2020 
// Design Name: 
// Module Name:    scytale_decryption 
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
module scytale_decryption#(
			parameter D_WIDTH = 8, 
			parameter KEY_WIDTH = 8, 
			parameter MAX_NOF_CHARS = 50,
			parameter START_DECRYPTION_TOKEN = 8'hFA
		)(
			// Clock and reset interface
			input clk,
			input rst_n,
			
			// Input interface
			input[D_WIDTH - 1:0] data_i,
			input valid_i,
			
			// Decryption Key
			input[KEY_WIDTH - 1 : 0] key_N,
			input[KEY_WIDTH - 1 : 0] key_M,
			
			// Output interface
			output reg[D_WIDTH - 1:0] data_o,
			output reg valid_o,
			
			output reg busy
    );

// TODO: Implement Scytale Decryption here

reg[D_WIDTH - 1:0] a [50:0]; // vectorul in care o sa stocam valorile lui data_i
reg [6:0] i;
reg [6:0] f;
reg [6:0] j;
reg [6:0] q;
always @(posedge clk) begin
	if(rst_n == 0) begin
						data_o <= 0;
						busy <= 0;
						valid_o <= 0;
						i <= 0; // i este numarul de elemente din a si de asemenea ne ajuta sa ne dam seama cand 
						// toate elementele din vector au fost scrise in data_o 
						q <= 0; // cu ajutorul lui q ne plimbam pe coloane cand decriptam
						j <= 0; // contorul vectorului a (de fiecare data cand adaugam un element j se incrementeaza)
						f <= 0; // cu ajutorul lui f ne plimbam pe linii atunci cand decriptam
						a[i] <= 0;
				   end
				   
				   
		else 	begin
					if(busy == 1)   begin 
										valid_o <= 1;
										data_o <= a[f * key_N + q];
										if(f+1 == key_M) begin
															f <= 0;
															q <= q+1;
													   	 end 	
														 
											else f<=f+1;
										
										if(q == key_N) q <= 0;
										
										i <= i-1;
										
										if(i==0) begin  //daca i=0 inseamna cas-a ajuns la finalul decripatrii si o sa facem toate acele valori 0
													busy <=0;
													valid_o <= 0;
													data_o <= 0;
													j <= 0;
												end
								    end 
					
					
					
					if (valid_i == 1 && data_i != 8'hFA ) begin // daca valid_i este activ si semnalul nostru este diferit de valoaea nula atunci putem 
																//adauga in vectorul creat de noi valoarea lui data_i
													a[j] <= data_i;
													j <= j+1;
													i <= j+1;
													
									  end	
					if (data_i == 8'hFA) begin 
										busy <= 1;
										f <= 0;
										q <= 0;
									    end			
				end
end
endmodule