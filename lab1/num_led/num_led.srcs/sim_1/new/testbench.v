`timescale 1ns / 1ps

module testbench();
    reg         clk, rst;
    reg [7:0]   switch;
    reg         center_btn_key;
    wire[6:0]   digital_num0, digital_num1;
    wire[7:0]   digital_cs;
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        rst = 0;
        # 100 rst = 1;
    end
    
    num_led #(
        .COUNTER_WIDTH(5)
    ) num_led0(
        .rst(rst),
        .clk(clk),
        
        .digital_num0(digital_num0),
        .digital_num1(digital_num1),
        .digital_cs(digital_cs),
        
        .switch(switch),
        .center_btn_key(center_btn_key)
    );

endmodule
