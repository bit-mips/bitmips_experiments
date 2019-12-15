`timescale 1ns / 1ps

`define RST_ENABLE 1'b0

module num_led #(
    parameter COUNTER_WIDTH = 20
)(
    input   wire        rst,
    input   wire        clk,
    
    output  wire[6:0]   digital_num0,
    output  wire[6:0]   digital_num1,
    output  wire[7:0]   digital_cs,
    
    input   wire[7:0]   switch,
    input   wire        center_btn_key
    );
    
    /*
    * use center button and dial switch on the board as input
    * for example:
    * set the dial switch at down,down,down,up,up,down,up,down(up is high level, down is low level), 
    * then press the center button on  board, the dial switch value which is 00011010(0x1a) will be 
    * write to num_led_value according to write_byte_index. If num_led_value equals 0 then switch value 
    * will be write to num_led_value[7:0], if num_led_value equals 0 then switch value will be write to 
    * num_led_value[15:8] and so on.
    * write_byte_index initial value is 0, it will add 1 when you press center button. 
    * If write_byte_index = 3, write_byte_index will equal 0 after it add 1.
    */
    reg         center_btn_key_r;
    reg         center_btn_key_r2;
    always @ (posedge clk) begin
        center_btn_key_r2 <= center_btn_key_r;
    end
    
    reg[31:0]   num_led_value;
    reg[1:0]    write_byte_index;
    always @ (posedge clk) begin
        if (rst == `RST_ENABLE) begin
            num_led_value <= 32'b0;
            write_byte_index <= 2'b0;
        end else if (center_btn_key_r && !center_btn_key_r2) begin
            case(write_byte_index)
                2'b00: num_led_value[7:0]   <= switch;
                2'b01: num_led_value[15:8]  <= switch;
                2'b10: num_led_value[23:16] <= switch;
                2'b11: num_led_value[31:24] <= switch;
                default: num_led_value <= 32'b0;
            endcase
            
            write_byte_index <= write_byte_index + 1'b1;
        end
    end
    
    /*
    * digital num led
    * you need to code
    * make digital num led show the value of num_led_value(data width is 32) with Hexadecimal
    */
    reg [COUNTER_WIDTH - 1:0]  count;
    reg [3:0]   scan_data1, scan_data2;
    reg [7:0]   scan_enable;
    reg [6:0]   num_a_g1, num_a_g2;
    
    assign digital_cs = scan_enable;
    assign digital_num0 = num_a_g1;
    assign digital_num1 = num_a_g2;
    
    always @ (posedge clk) begin
        if (rst == `RST_ENABLE) begin
            count <= 0;
        end else begin
            count <= count + 1;
        end
    end
    
    always @ (posedge clk) begin
        if (rst == `RST_ENABLE) begin
            scan_data1 <= 4'b0;
            scan_data2 <= 4'b0;
            scan_enable <= 8'b0;
        end else begin
            case(count[COUNTER_WIDTH - 1:COUNTER_WIDTH - 2])
            2'b00: begin
                scan_data1 <= num_led_value[3:0];
                scan_data2 <= num_led_value[19:16];
                scan_enable <= 8'b0001_0001;
            end
            /****** your code ******/
            
            default: ;
            endcase
        end
    end
    
    always @ (posedge clk) begin
        if (rst == `RST_ENABLE) begin
            num_a_g1 <= 7'b0;
            num_a_g2 <= 7'b0;
        end else begin
            case(scan_data1)
            4'd0: num_a_g1 <= 7'b111_1110; // 0
            /****** your code ******/
            
            default: ;
            endcase
            
            case(scan_data2)
            4'd0: num_a_g2 <= 7'b111_1110; // 0
            /****** your code ******/
            
            default: ;
            endcase
        end
    end
    
    // center btn key
    // eliminate jitter
    reg         center_btn_key_flag;
    reg [COUNTER_WIDTH - 1:0]  center_btn_key_count;
    wire center_btn_key_start = !center_btn_key_r && center_btn_key;
    wire center_btn_key_end   = center_btn_key_r && center_btn_key;
    wire center_btn_key_sample= center_btn_key_count[COUNTER_WIDTH - 1];
    
    always @ (posedge clk) begin
        if (rst == `RST_ENABLE) begin
            center_btn_key_flag <= 1'b0;
        end else if (center_btn_key_sample) begin
            center_btn_key_flag <= 1'b0;
        end else if (center_btn_key_start || center_btn_key_end) begin
            center_btn_key_flag <= 1'b1;
        end
        
        if (rst == `RST_ENABLE || !center_btn_key_flag) begin
            center_btn_key_count <= 0;
        end else begin
            center_btn_key_count <= center_btn_key_count + 1'b1;
        end
        
        if (rst == `RST_ENABLE) begin
            center_btn_key_r <= 1'b0;
        end else if (center_btn_key_sample) begin
            center_btn_key_r <= center_btn_key;
        end
    end
endmodule
