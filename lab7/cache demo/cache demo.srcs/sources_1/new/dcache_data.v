`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/28 12:01:54
// Design Name: 
// Module Name: dcache_data
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dcache_data(
    input   wire        rst,
    input   wire        clk,
    input   wire        en,
    input   wire[3:0]   wen,
    input   wire[31:0]  wdata,
    input   wire[31:0]  addr,
    output  wire[31:0]  rdata
    );
    
    dcache_data_ram dcache_data_ram_0 (
      .clka(clk),           // input wire clka
      .ena(en),             // input wire ena
      .wea(wen),            // input wire [3 : 0] wea
      .addra(addr[11:5]),   // input wire [6 : 0] addra
      .dina(wdata),         // input wire [31 : 0] dina
      .douta(rdata)         // output wire [31 : 0] douta
    );
endmodule
