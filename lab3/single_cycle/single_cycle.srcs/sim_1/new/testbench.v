`timescale 1ns / 1ps

module testbench();
    reg rst, clk;
    initial begin
        rst = 1'b1;
        clk = 1'b0;
        #100 rst = 1'b0;
    end
    
    always #5 clk = ~clk;
    
    single_cycle single_cycle0(
        .rst(rst),
        .clk(clk)
    );
endmodule
