`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/28 12:08:05
// Design Name: 
// Module Name: dcache_tag
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


module dcache_tag(
    input   wire        rst,
    input   wire        clk,
    input   wire        wen,
    input   wire[20:0]  wdata, // bit 20 is valid field, bit 19-0 is tag field
    input   wire[31:0]  addr,
    output  wire[19:0]  rdata, // read tag
    output  wire        hit,
    output  wire        valid,
    output  wire        work   // indicate cache is able to work
    );
    wire       tag_wen;
    wire[6:0]  tag_addr;
    wire[20:0] tag_wdata; // bit 20 is valid field, bit 19-0 is tag field
    wire[20:0] tag_rdata; // bit 20 is valid field, bit 19-0 is tag field
    
    cache_tag cache_tag0(clk, 1'b1, tag_wen, tag_addr, tag_wdata, tag_rdata);
    
    // reset 
    reg[6:0] reset_counter;
    always @ (posedge clk) begin
        if (rst) reset_counter <= 7'b0;
        else if (reset_counter != 7'b111_1111) reset_counter <= reset_counter + 1'b1;
    end
    wire reset_done = reset_counter == 7'b111_1111 ? 1'b1 : 1'b0; // counter == 128, then reset is down
    
    reg work_t;
    always @ (posedge clk) begin
        if (rst) work_t <= 1'b0;
        else work_t <= reset_done;
    end
    assign work = work_t;
    assign reseting = ~work;
    
    
    assign tag_wen = (reseting == 1'b1) ? 1'b1 : // reset
                     (wen == 1'b1) ? 1'b1 : // write tag
                     1'b0; // do nothing
    assign tag_addr = (reseting == 1'b1) ? reset_counter : // reset time, counter as index
                       addr[11:5]; // work time, addr[11:5] as index
    assign tag_wdata = (reseting == 1'b1) ? 21'b0 : // reset data
                        wdata; // write tag
    
    // store address to compare tag in next clock
    reg[31:0] addr_t;
    always @ (posedge clk) begin
        if (rst) begin
            addr_t <= 32'b0;
        end else begin
            addr_t <= addr;
        end
    end
    
    // read
    assign hit = (addr_t[31:12] == tag_rdata[19:0]) ? 1'b1 : 1'b0;
    assign valid = tag_rdata[20];
    assign rdata = tag_rdata[19:0];
endmodule
