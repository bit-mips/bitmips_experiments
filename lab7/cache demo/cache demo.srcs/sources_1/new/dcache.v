`timescale 1ns / 1ps

module dcache(
    // global signals
    wire rst,
    wire clk//,
    
    // cpu interface bus
    
    // memeory interface bus
     
    );
    
    reg[31:0] data_addr_r; // the address that cpu want to access
    wire[31:0] cache_access_addr;
    
    // -----------------------------------------------
    // cache tag control
    wire[20:0] tag_way_wdata;
    
    wire tag_way0_wen;
    wire tag_way1_wen;
    wire[19:0] tag_way0_rtag;
    wire[19:0] tag_way1_rtag;
    wire tag_way0_hit;
    wire tag_way1_hit;
    wire tag_way0_valid;
    wire tag_way1_valid;
    wire tag_way0_work;
    wire tag_way1_work;
    dcache_tag dcache_tag_way0(rst, clk, tag_way0_wen, tag_way_wdata, cache_access_addr, tag_way0_rtag, tag_way0_hit, tag_way0_valid, tag_way0_work);
    dcache_tag dcache_tag_way1(rst, clk, tag_way1_wen, tag_way_wdata, cache_access_addr, tag_way1_rtag, tag_way1_hit, tag_way1_valid, tag_way1_work);
    
    // pseudo code
    /*
        tag_way0_wen = £¨miss reload && lru[data_addr_r[11£º5]] == 1'b0£© ? 1'b1 : 1'b0;
        tag_way1_wen is as same as tag_way0_wen.
    */
    /*
        tag_way_wdata = (miss reload) ? {1'b1, data_addr_r[31:12]} : 21'b0;
    */
    
    // -----------------------------------------------
    // cache data control
    wire[3:0] way0_data0_wen;
    wire[3:0] way0_data1_wen;
    wire[3:0] way0_data2_wen;
    wire[3:0] way0_data3_wen;
    wire[3:0] way0_data4_wen;
    wire[3:0] way0_data5_wen;
    wire[3:0] way0_data6_wen;
    wire[3:0] way0_data7_wen;
    wire[3:0] way1_data0_wen;
    wire[3:0] way1_data1_wen;
    wire[3:0] way1_data2_wen;
    wire[3:0] way1_data3_wen;
    wire[3:0] way1_data4_wen;
    wire[3:0] way1_data5_wen;
    wire[3:0] way1_data6_wen;
    wire[3:0] way1_data7_wen;
    
    wire[3:0] way0_rdata0;
    wire[3:0] way0_rdata1;
    wire[3:0] way0_rdata2;
    wire[3:0] way0_rdata3;
    wire[3:0] way0_rdata4;
    wire[3:0] way0_rdata5;
    wire[3:0] way0_rdata6;
    wire[3:0] way0_rdata7;
    wire[3:0] way1_rdata0;
    wire[3:0] way1_rdata1;
    wire[3:0] way1_rdata2;
    wire[3:0] way1_rdata3;
    wire[3:0] way1_rdata4;
    wire[3:0] way1_rdata5;
    wire[3:0] way1_rdata6;
    wire[3:0] way1_rdata7;
    
    wire[31:0] cache_wdata;
    
    dcache_data dcache_data_way0_word0(rst, clk, 1'b1, way0_data0_wen, cache_wdata, cache_access_addr, way0_rdata0);
    dcache_data dcache_data_way0_word1(rst, clk, 1'b1, way0_data1_wen, cache_wdata, cache_access_addr, way0_rdata1);
    dcache_data dcache_data_way0_word2(rst, clk, 1'b1, way0_data2_wen, cache_wdata, cache_access_addr, way0_rdata2);
    dcache_data dcache_data_way0_word3(rst, clk, 1'b1, way0_data3_wen, cache_wdata, cache_access_addr, way0_rdata3);
    dcache_data dcache_data_way0_word4(rst, clk, 1'b1, way0_data4_wen, cache_wdata, cache_access_addr, way0_rdata4);
    dcache_data dcache_data_way0_word5(rst, clk, 1'b1, way0_data5_wen, cache_wdata, cache_access_addr, way0_rdata5);
    dcache_data dcache_data_way0_word6(rst, clk, 1'b1, way0_data6_wen, cache_wdata, cache_access_addr, way0_rdata6);
    dcache_data dcache_data_way0_word7(rst, clk, 1'b1, way0_data7_wen, cache_wdata, cache_access_addr, way0_rdata7);
    dcache_data dcache_data_way1_word0(rst, clk, 1'b1, way1_data0_wen, cache_wdata, cache_access_addr, way1_rdata0);
    dcache_data dcache_data_way1_word1(rst, clk, 1'b1, way1_data1_wen, cache_wdata, cache_access_addr, way1_rdata1);
    dcache_data dcache_data_way1_word2(rst, clk, 1'b1, way1_data2_wen, cache_wdata, cache_access_addr, way1_rdata2);
    dcache_data dcache_data_way1_word3(rst, clk, 1'b1, way1_data3_wen, cache_wdata, cache_access_addr, way1_rdata3);
    dcache_data dcache_data_way1_word4(rst, clk, 1'b1, way1_data4_wen, cache_wdata, cache_access_addr, way1_rdata4);
    dcache_data dcache_data_way1_word5(rst, clk, 1'b1, way1_data5_wen, cache_wdata, cache_access_addr, way1_rdata5);
    dcache_data dcache_data_way1_word6(rst, clk, 1'b1, way1_data6_wen, cache_wdata, cache_access_addr, way1_rdata6);
    dcache_data dcache_data_way1_word7(rst, clk, 1'b1, way1_data7_wen, cache_wdata, cache_access_addr, way1_rdata7);
    
    // write
    // pseudo code
    /*
        if  1. sw instrs && hit0 && valid0 && waddr_r[4:2] == 3'b000 || 
            2. read from mem && select way0 to store && read_counter == 3'b000 begin
            way0_data0_wen = 1'b1£»
        end else 
            way0_data0_wen = 1'b0;
        
        ..
        other is same
    */
    
    /*
        if (read from mem) begin
            cache_wdata = rdata_from_mem;
        end else if (sw instrs) begin
            cache_wdata = wdata_from_cpu;
        end
    */
    
    // read
    wire[31:0] word_selection0, word_selection1;
    wire[31:0] hit_word;
    assign word_selection0 = (data_addr_r[4:2] == 3'b000) ? way0_rdata0 :
                             (data_addr_r[4:2] == 3'b001) ? way0_rdata1 :
                             (data_addr_r[4:2] == 3'b010) ? way0_rdata2 :
                             (data_addr_r[4:2] == 3'b011) ? way0_rdata3 :
                             (data_addr_r[4:2] == 3'b100) ? way0_rdata4 :
                             (data_addr_r[4:2] == 3'b101) ? way0_rdata5 :
                             (data_addr_r[4:2] == 3'b110) ? way0_rdata6 :
                             (data_addr_r[4:2] == 3'b111) ? way0_rdata7 : 32'b0;
    assign word_selection1 = (data_addr_r[4:2] == 3'b000) ? way1_rdata0 :
                             (data_addr_r[4:2] == 3'b001) ? way1_rdata1 :
                             (data_addr_r[4:2] == 3'b010) ? way1_rdata2 :
                             (data_addr_r[4:2] == 3'b011) ? way1_rdata3 :
                             (data_addr_r[4:2] == 3'b100) ? way1_rdata4 :
                             (data_addr_r[4:2] == 3'b101) ? way1_rdata5 :
                             (data_addr_r[4:2] == 3'b110) ? way1_rdata6 :
                             (data_addr_r[4:2] == 3'b111) ? way1_rdata7 : 32'b0;
    assign hit_word = (tag_way0_hit && tag_way0_valid) ? word_selection0 :
                      (tag_way1_hit && tag_way1_valid) ? word_selection1 : 32'b0;
    
    // -----------------------------------------------
    // dirty field
    reg[127:0] dirty_way0, dirty_way1;
    always @ (posedge clk) begin
        if (rst) begin
            dirty_way0 <= 128'b0;
        end else begin
            // pseudo code
            /*
                if (cpu write && hit0 && valid0) || (miss reload && write && lru[data_addr_r[11:5]] == 1'b0) begin
                    dirty_way0[data_addr_r[11:5]] = 1'b1;
                end else if (miss reload && read && lru[data_addr_r[11:5]] == 1'b0) begin
                    dirty_way0[data_addr_r[11:5]] = 1'b0;
                end
            */
        end
    end
    
    // dirty_way1 is as same as dirty_way0
    
    
    // -----------------------------------------------
    // lru replacement algorithm
    reg[127:0] lru;
    
    always @ (posedge clk) begin
        if (rst) begin
            lru <= 128'b0;
        end else begin
            // pseudo code
            /*
                if ( cpu write || cpu read ) begin
                    if hit0 && valid0 begin lru[data_addr_r[11:5]] = 1'b1; end // way 0 is used this time, replace way1 next time
                    if hit1 && valid1 begin lru[data_addr_r[11:5]] = 1'b0; end // way 1 is used this time, replace way0 next time
                if ( unhit && replace way-i(i = lru[data_addr_r[11:5]])) begin
                    lru[data_addr_r[11:5]] = ~lru[data_addr_r[11:5]];
                end
            */
        end
    end
    
    // how about 4 way lru, more complex
    
endmodule
