`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:33:04 11/23/2020 
// Design Name: 
// Module Name:    zigzag_decryption 
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
module zigzag_decryption #(
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
			input[KEY_WIDTH - 1 : 0] key,
			
			// Output interface
            output reg busy,
			output reg[D_WIDTH - 1:0] data_o,
			output reg valid_o
    );

// TODO: Implement ZigZag Decryption here

reg[D_WIDTH - 1:0] a [50:0]; // vectorul in care o sa stocam valorile lui data_i
reg [6:0] i;
reg [6:0] f;
reg [6:0] j;
reg [6:0] q;
reg [6:0] Q;
reg [6:0] m;
reg [6:0] m1;
always @(posedge clk) begin
	if(rst_n == 0) begin
						data_o <= 0;
						busy <= 0;
						valid_o <= 0;
						i <= 0; // i este numarul de elemente din a si de asemenea ne ajuta sa ne dam seama cand 
						// toate elementele din vector au fost scrise in data_o 
						q <= 0; // q este jumatatea sirului nostru
						j <= 0; // contorul vectorului a (de fiecare data cand adaugam un element j se incrementeaza)
						f <= 0; // cu ajutorul lui f ne plimbam pe linii atunci cand decriptam
						a[i] <= 0;
						m<=0;
				   end
				   
				   
		else 	begin
					if(busy == 1)   begin 
										valid_o <= 1;
										q <= j>>1;
										if (key == 2) if (f[0] == 0 ) data_o <= a[f>>1]; //daca cheia este 2 si indicele este par punem valoarea pe pozitia f/2 
																						else  begin 
																									data_o <= a[q+m ];
																									m <= m+1;
																								end
																		//daca indicele este impar scriem valoarea de la jumatatea numarului incolo
										f <= f + 1;
										i <= i - 1;
										
										
										if(i==0) begin //daca i=0 inseamna cas-a ajuns la finalul decripatrii si o sa facem toate acele valori 0
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
										if(key == 2)	if (j[0] == 0) m <= 0;
															else m<=1;
										m1<=0;
									    end			
				end
end
endmodule