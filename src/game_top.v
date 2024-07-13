
module game_top #(
    parameter CORDW=16,   // signed coordinate width (bits)
    parameter H_RES=640,  // horizontal screen resolution (pixels)
    parameter SX_OFFS=2   // horizontal screen offset (pixels)
    ) (
    input clk,  // 25MHz
    input btn1,
    input btn2,
//    input reg rst_pix,
    output [2:0] TMDSp, TMDSn,
    output TMDSp_clock, TMDSn_clock
);
////////////////////////////////////////////////////////////////////////
wire [9:0] sx, sy;
wire hsync, vsync, de, line, frame;
wire [7:0] red, green, blue;

reg rst_pix;
initial begin
    rst_pix = 1'b0;
end

display_480p #(.CORDW(CORDW)) s480p (
    .clk_pix(clk),
    .rst_pix(rst_pix),
    .sx(sx),
    .sy(sy),
    .hsync(hsync),
    .vsync(vsync),
    .de(de),
    .frame(frame),
    .line(line)
);

// Color patterns
localparam WHITE  = 24'hFFFFFF;  // {B,G,R}
localparam YELLOW = 24'h00FFFF;
localparam CYAN   = 24'hFFFF00;
localparam GREEN  = 24'h00FF00;
localparam MAGENTA= 24'hFF00FF;
localparam RED    = 24'h0000FF;
localparam BLUE   = 24'hFF0000;
localparam BLACK  = 24'h000000;

game_loop arkanoid (
    .clk(clk),
    .sx(sx),
    .sy(sy),
    .red(red),
    .green(green),
    .blue(blue),
    .frame(frame),
    .btn1(btn1),
    .btn2(btn2)
);



DVI_TX_Top DVI_TX_Top_inst
(
    .I_rst_n       (~rst_pix   ),  //asynchronous reset, low active
    .I_serial_clk  (PLL_CLKFX    ),
    .I_rgb_clk     (clk       ),  //pixel clock
    .I_rgb_vs      (vsync     ), 
    .I_rgb_hs      (hsync     ),    
    .I_rgb_de      (de     ), 
    .I_rgb_r       (red ),  //tp0_data_r
    .I_rgb_g       (green  ),  
    .I_rgb_b       (blue  ),  
    .O_tmds_clk_p  (TMDSp_clock  ),
    .O_tmds_clk_n  (TMDSn_clock  ),
    .O_tmds_data_p (TMDSp ),  //{r,g,b}TMDSp
    .O_tmds_data_n (TMDSn )
);




Gowin_rPLL rPLL(
    .clkout(PLL_CLKFX), // output clkout
    .clkin(clk) // input clkin
);


endmodule


