`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2020/09/08 08:47:20
//////////////////////////////////////////////////////////////////////////////////


module teach_soc_top(
    input           clk,
    input           resetn,
    
    // ----- GPIO -----
    input           mid_btn_key,
    input           left_btn_key, 
    input           right_btn_key,
    input           up_btn_key,
    input           down_btn_key,
    input   [7:0]   switch,
    output  [6:0]   digital_num0,
    output  [6:0]   digital_num1,
    output  [7:0]   digital_cs,
    output  [7:0]   led
);

wire[31:0] debug_wb_pc; 
wire[3:0] debug_wb_rf_wen;
wire[4:0] debug_wb_rf_wnum;
wire[31:0] debug_wb_rf_wdata;


// clk pll
wire soc_clk;
clk_pll clk_pll(
    // Clock out ports
    .soc_clk(soc_clk),     // output soc_clk
   // Clock in ports
    .clk_in1(clk)          // input clk_in1
);

//cpu inst sram
wire        cpu_inst_en;
wire [3 :0] cpu_inst_wen;
wire [31:0] cpu_inst_addr;
wire [31:0] cpu_inst_wdata;
wire [31:0] cpu_inst_rdata;
//cpu data sram
wire        cpu_data_en;
wire [3 :0] cpu_data_wen;
wire [31:0] cpu_data_addr;
wire [31:0] cpu_data_wdata;
wire [31:0] cpu_data_rdata;


wire        data_sram_en;
wire [3 :0] data_sram_wen;
wire [31:0] data_sram_addr;
wire [31:0] data_sram_wdata;
wire [31:0] data_sram_rdata;

wire        confreg_en;
wire [3 :0] confreg_wen;
wire [31:0] confreg_addr;
wire [31:0] confreg_wdata;
wire [31:0] confreg_rdata;
    
// cpu    
ls132r_top cpu (
    .clk              (soc_clk   ),
    .resetn           (resetn    ),  //low active
    .int_n_i              (6'b111111      ),  //interrupt,high active

    .inst_sram_en     (cpu_inst_en   ),
    .inst_sram_wen    (cpu_inst_wen  ),
    .inst_sram_addr   (cpu_inst_addr ),
    .inst_sram_wdata  (cpu_inst_wdata),
    .inst_sram_rdata  (cpu_inst_rdata),
    
    .data_sram_en     (cpu_data_en   ),
    .data_sram_wen    (cpu_data_wen  ),
    .data_sram_addr   (cpu_data_addr ),
    .data_sram_wdata  (cpu_data_wdata),
    .data_sram_rdata  (cpu_data_rdata),

    //debug
    .debug_wb_pc      (debug_wb_pc      ),
    .debug_wb_rf_wen  (debug_wb_rf_wen  ),
    .debug_wb_rf_wnum (debug_wb_rf_wnum ),
    .debug_wb_rf_wdata(debug_wb_rf_wdata)
);

// inst ram
inst_ram inst_ram (
  .clka (soc_clk            ),  // input wire clka
  .ena  (cpu_inst_en        ),  // input wire ena
  .wea  (cpu_inst_wen       ),  // input wire [3 : 0] wea
  .addra(cpu_inst_addr[17:2]),  // input wire [15 : 0] addra
  .dina (cpu_inst_wdata     ),  // input wire [31 : 0] dina
  .douta(cpu_inst_rdata     )   // output wire [31 : 0] douta
);

// bridge 1x2
bridge_1x2 bridge_1x2 (
    .clk            (soc_clk        ),
    .reset          (~resetn        ),
    
    .cpu_data_en    (cpu_data_en    ),
    .cpu_data_wen   (cpu_data_wen   ),
    .cpu_data_addr  (cpu_data_addr  ),
    .cpu_data_wdata (cpu_data_wdata ),
    .cpu_data_rdata (cpu_data_rdata ),
    
    .data_sram_en   (data_sram_en   ),
    .data_sram_wen  (data_sram_wen  ),
    .data_sram_addr (data_sram_addr ),
    .data_sram_wdata(data_sram_wdata),
    .data_sram_rdata(data_sram_rdata),
    
    .confreg_en     (confreg_en     ),
    .confreg_wen    (confreg_wen    ),
    .confreg_addr   (confreg_addr   ),
    .confreg_wdata  (confreg_wdata  ),
    .confreg_rdata  (confreg_rdata  )
);

// data ram
data_ram data_ram (
  .clka (soc_clk             ),  // input wire clka
  .ena  (data_sram_en        ),  // input wire ena
  .wea  (data_sram_wen       ),  // input wire [3 : 0] wea
  .addra(data_sram_addr[13:2]),  // input wire [11 : 0] addra
  .dina (data_sram_wdata     ),  // input wire [31 : 0] dina
  .douta(data_sram_rdata     )   // output wire [31 : 0] douta
);

// confreg
confreg confreg (
    .clk          (soc_clk       ),
    .rst          (~resetn       ),
    
    .confreg_en   (confreg_en    ),
    .confreg_wen  (confreg_wen   ),
    .confreg_addr (confreg_addr  ),
    .confreg_wdata(confreg_wdata ),
    .confreg_rdata(confreg_rdata ),
    
    .digital_num0 (digital_num0  ),
    .digital_num1 (digital_num1  ),
    .digital_cs   (digital_cs    ),
    .led          (led           ),
    .switch       (switch        ),
    .mid_btn_key  (mid_btn_key   ),
    .left_btn_key (left_btn_key  ),
    .right_btn_key(right_btn_key ),
    .up_btn_key   (up_btn_key    ),
    .down_btn_key (down_btn_key  )
);
    
endmodule
