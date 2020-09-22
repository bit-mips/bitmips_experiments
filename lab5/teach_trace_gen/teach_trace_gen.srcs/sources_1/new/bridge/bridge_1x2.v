`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2020/09/08 09:57:13
//////////////////////////////////////////////////////////////////////////////////

`define CONF_ADDR_BASE 32'h1faf_0000
`define CONF_ADDR_MASK 32'hffff_0000

module bridge_1x2(
    input           clk,
    input           reset,
    
    input           cpu_data_en,
    input   [3 :0]  cpu_data_wen,
    input   [31:0]  cpu_data_addr,
    input   [31:0]  cpu_data_wdata,
    output  [31:0]  cpu_data_rdata,
    
    
    output          data_sram_en,
    output  [3 :0]  data_sram_wen,
    output  [31:0]  data_sram_addr,
    output  [31:0]  data_sram_wdata,
    input   [31:0]  data_sram_rdata,
    
    output          confreg_en,
    output  [3 :0]  confreg_wen,
    output  [31:0]  confreg_addr,
    output  [31:0]  confreg_wdata,
    input   [31:0]  confreg_rdata
    );
    
    wire sel_sram;
    wire sel_conf;
    
    reg sel_sram_r;
    reg sel_conf_r;
    
    assign sel_conf = (cpu_data_addr & `CONF_ADDR_MASK) == `CONF_ADDR_BASE;
    assign sel_sram = !sel_conf;
    
    assign data_sram_en    = cpu_data_en & sel_sram;
    assign data_sram_wen   = cpu_data_wen;
    assign data_sram_addr  = cpu_data_addr;
    assign data_sram_wdata = cpu_data_wdata;
    
    assign confreg_en    = cpu_data_en & sel_conf;
    assign confreg_wen   = cpu_data_wen;
    assign confreg_addr  = cpu_data_addr;
    assign confreg_wdata = cpu_data_wdata;
    
    always @ (posedge clk) begin
        if (reset) begin
            sel_sram_r <= 1'b0;
            sel_conf_r <= 1'b0;
        end else begin
            sel_sram_r <= sel_sram;
            sel_conf_r <= sel_conf;
        end
    end
    
    assign cpu_data_rdata = {32{sel_sram_r}} & data_sram_rdata
                          | {32{sel_conf_r}} & confreg_rdata;
endmodule
