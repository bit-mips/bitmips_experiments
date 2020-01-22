`timescale 1ns / 1ps

module mycpu(
    input   wire        rst,
    input   wire        clk,
    
    output  wire[31:0]  inst_rom_addr,
    input   wire[31:0]  inst_rom_rdata,
    
    output  wire[31:0]  data_ram_addr,
    output  wire[31:0]  data_ram_wdata,
    output  wire        data_ram_wen,
    input   wire[31:0]  data_ram_rdata
    );
    
    
endmodule
