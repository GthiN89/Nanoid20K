// (c) fpga4fun.com & KNJN LLC 2013-2023

////////////////////////////////////////////////////////////////////////
module HDMI_top #(
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

simple480p s480p(
    .clk(clk),
    .sx(sx),
    .sy(sy),
    .hsync(hsync),
    .vsync(vsync),
    .de(de),
    .frame(frame)
); 


//display_480p #(.CORDW(CORDW)) s480p (
//    .clk_pix(clk),
//    .rst_pix(rst_pix),
//    .sx(sx),
//    .sy(sy),
//    .hsync(hsync),
//    .vsync(vsync),
//    .de(de),
//    .frame(frame),
//    .line(line)
//);

// Color patterns
localparam WHITE  = 24'hFFFFFF;  // {B,G,R}
localparam YELLOW = 24'h00FFFF;
localparam CYAN   = 24'hFFFF00;
localparam GREEN  = 24'h00FF00;
localparam MAGENTA= 24'hFF00FF;
localparam RED    = 24'h0000FF;
localparam BLUE   = 24'hFF0000;
localparam BLACK  = 24'h000000;

pattern animation (
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

////////////////////////////////////////////////////////////////////////
wire [9:0] TMDS_red, TMDS_green, TMDS_blue;

TMDS_encoder encode_R(.clk(clk), .VD(red  ), .CD(2'b00), .VDE(de), .TMDS(TMDS_red));
TMDS_encoder encode_G(.clk(clk), .VD(green), .CD(2'b00), .VDE(de), .TMDS(TMDS_green));
TMDS_encoder encode_B(.clk(clk), .VD(blue ), .CD({vsync,hsync}), .VDE(de), .TMDS(TMDS_blue));

////////////////////////////////////////////////////////////////////////
wire clk_TMDS; 
wire PLL_CLKFX;  // 25MHz x 10 = 250MHz

Gowin_rPLL rPLL(
    .clkout(PLL_CLKFX), // output clkout
    .clkin(clk) // input clkin
);

BUFG uut(
    .O(clk_TMDS),
    .I(PLL_CLKFX)
);

////////////////////////////////////////////////////////////////////////
reg [3:0] TMDS_mod10 = 0;  // modulus 10 counter
reg [9:0] TMDS_shift_red = 0, TMDS_shift_green = 0, TMDS_shift_blue = 0;
reg TMDS_shift_load = 0;

always_ff @(posedge clk_TMDS) begin
    TMDS_shift_load <= (TMDS_mod10 == 4'd9);
    if (TMDS_shift_load) begin
        TMDS_shift_red <= TMDS_red;
        TMDS_shift_green <= TMDS_green;
        TMDS_shift_blue <= TMDS_blue;
    end else begin
        TMDS_shift_red <= TMDS_shift_red[9:1];
        TMDS_shift_green <= TMDS_shift_green[9:1];
        TMDS_shift_blue <= TMDS_shift_blue[9:1];
    end
    TMDS_mod10 <= (TMDS_mod10 == 4'd9) ? 4'd0 : TMDS_mod10 + 4'd1;
end

TLVDS_OBUF OBUFDS_red (
    .O(TMDSp[2]),
    .OB(TMDSn[2]),
    .I(TMDS_shift_red[0])
);

TLVDS_OBUF OBUFDS_green (
    .O(TMDSp[1]),
    .OB(TMDSn[1]),
    .I(TMDS_shift_green[0])
);

TLVDS_OBUF OBUFDS_blue (
    .O(TMDSp[0]),
    .OB(TMDSn[0]),
    .I(TMDS_shift_blue[0])
);

TLVDS_OBUF OBUFDS_clock (
    .O(TMDSp_clock),
    .OB(TMDSn_clock),
    .I(clk)
);

endmodule


