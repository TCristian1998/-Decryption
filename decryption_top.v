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

module decryption_top#(
			parameter addr_witdth = 8,
			parameter reg_width 	 = 16,
			parameter MST_DWIDTH = 32,
			parameter SYS_DWIDTH = 8
		)(
		// Clock and reset interface
		input clk_sys,
		input clk_mst,
		input rst_n,
		
		// Input interface
		input [MST_DWIDTH -1 : 0] data_i,
		input 						  valid_i,
		output busy,
		
		//output interface
		output [SYS_DWIDTH - 1 : 0] data_o,
		output      					 valid_o,
		
		// Register access interface
		input[addr_witdth - 1:0] addr,
		input read,
		input write,
		input [reg_width - 1 : 0] wdata,
		output[reg_width - 1 : 0] rdata,
		output done,
		output error
		
    );
	
	
	// TODO: Add and connect all Decryption blocks
wire [15 : 0] select;
    wire [reg_width - 1 : 0] caesar_key;
    wire [reg_width - 1 : 0] scytale_key;
    wire [reg_width - 1 : 0] zigzag_key;

    wire [SYS_DWIDTH - 1 : 0]     data0_o; 
    wire                         valid0_o;
    wire [SYS_DWIDTH - 1 : 0]     data1_o;
    wire                         valid1_o;
    wire [SYS_DWIDTH - 1 : 0]     data2_o;
    wire                         valid2_o;
    wire busy0_o,busy1_o,busy2_o;
    wire valid_zigzag_o;
    wire valid_caesar_o;
    wire valid_scytale_o;

    wire [SYS_DWIDTH - 1 : 0] data_caesar_o;
    wire [SYS_DWIDTH - 1 : 0] data_scytale_o;
    wire [SYS_DWIDTH - 1 : 0] data_zigzag_o;

    decryption_regfile ana(clk_sys, rst_n, addr,read,write, wdata,rdata,done,error,select,caesar_key,scytale_key,zigzag_key);

    demux are(clk_sys, clk_mst,rst_n,select[1:0],data_i, valid_i,data0_o,valid0_o,data1_o,valid1_o,data2_o,valid2_o );

    caesar_decryption caesar1(clk_sys,rst_n,data0_o,valid0_o,caesar_key,busy0_o,data_caesar_o,valid_caesar_o);

    scytale_decryption scytale2(clk_sys,rst_n,data1_o,valid1_o,scytale_key[15:8],scytale_key[7:0],data_scytale_o,valid_scytale_o,busy1_o);

    zigzag_decryption zigzag3(clk_sys,rst_n,data2_o,valid2_o,zigzag_key[7:0],busy2_o,data_zigzag_o, valid_zigzag_o);

    mux multiplexor(clk_sys,rst_n,select[1:0], data_o,  valid_o,data_caesar_o, valid_caesar_o,  data_scytale_o,valid_scytale_o, data_zigzag_o, valid_zigzag_o);

    or(busy,busy0_o,busy1_o,busy2_o);