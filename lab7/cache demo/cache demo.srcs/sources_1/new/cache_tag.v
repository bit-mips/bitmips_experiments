`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/28 13:34:17
// Design Name: 
// Module Name: cache_tag
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


module cache_tag(
    input   wire        clk,
    input   wire        en,
    input   wire        wen,
    input   wire[6:0]   addr,
    input   wire[20:0]  wdata, // bit 20 is valid field, bit 19-0 is tag field
    output  wire[20:0]  rdata  // bit 20 is valid field, bit 19-0 is tag field
    );
    
    wire[2:0] zeros;
    
    cache_tag_0 cache_tag_0_0 (
      .clka(clk),               // input wire clka
      .ena(en),                 // input wire ena
      .wea({3{wen}}),           // input wire [2 : 0] wea
      .addra(addr),             // input wire [6 : 0] addra
      .dina({3'b000, wdata}),   // input wire [23 : 0] dina
      .douta({zeros, rdata})    // output wire [23 : 0] douta
    );
    
endmodule
