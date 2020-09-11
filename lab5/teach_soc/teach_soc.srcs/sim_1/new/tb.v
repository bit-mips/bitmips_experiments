`timescale 1ns / 1ps

module tb();

    reg clk;
    reg rstn;
    
    initial begin
        clk = 0;
        rstn = 0;
        
        # 1000 rstn = 1;
    end
    
    always # 5 clk = ~clk;
    
    teach_soc_top teach_soc_top_u(
        .clk(clk),
        .resetn(rstn),
    
        // ----- GPIO -----
        .mid_btn_key(1'b0),
        .left_btn_key(1'b0), 
        .right_btn_key(1'b0),
        .up_btn_key(1'b0),
        .down_btn_key(1'b0),
        .switch(8'hff),
        .digital_num0(),
        .digital_num1(),
        .digital_cs(),
        .led()
    );

endmodule
