module pattern (
    input clk,
    input wire [9:0] sx, sy,
    output reg [7:0] red, green, blue,
    input frame,
    input btn1,
    input btn2
);
localparam H_RES = 640;  // horizontal screen resolution
localparam V_RES = 480;  // vertical screen resolution

localparam FRAME_NUM = 1;  // slow-mo: animate every N frames
reg [$clog2(FRAME_NUM):0] cnt_frame;  // frame counter

always @(posedge clk) begin
    if (frame) cnt_frame <= (cnt_frame == FRAME_NUM-1) ? 0 : cnt_frame + 1;
end

localparam CORDW = 10;
localparam V_SIZE_PADDLE = 15;   // size in pixels
localparam H_SIZE_PADDLE = 100;
localparam V_SIZE_BALL = 15;   // size in pixels
localparam H_SIZE_BALL = 15;

localparam BRICK_WIDTH = 75;  // Adjusted for space between bricks
localparam BRICK_HEIGHT = 30; // Adjusted for space between bricks
localparam BRICK_SPACING = 20; // Space between bricks
localparam MARGIN_TOP = 30; // Space from the top of the screen
localparam MARGIN_SIDE = 40; // Space from the sides of the screen

// State of bricks (1 = active, 0 = destroyed)
reg brick1_active, brick2_active, brick3_active, brick4_active, brick5_active, brick6_active;
reg brick7_active, brick8_active, brick9_active, brick10_active, brick11_active, brick12_active;
reg brick13_active, brick14_active, brick15_active, brick16_active, brick17_active, brick18_active;

// Brick positions
localparam brick1_x_min = MARGIN_SIDE;
localparam brick1_x_max = MARGIN_SIDE + BRICK_WIDTH;
localparam brick1_y_min = MARGIN_TOP;
localparam brick1_y_max = MARGIN_TOP + BRICK_HEIGHT;

localparam brick2_x_min = MARGIN_SIDE + (BRICK_WIDTH + BRICK_SPACING);
localparam brick2_x_max = brick2_x_min + BRICK_WIDTH;
localparam brick2_y_min = MARGIN_TOP;
localparam brick2_y_max = MARGIN_TOP + BRICK_HEIGHT;

localparam brick3_x_min = MARGIN_SIDE + 2 * (BRICK_WIDTH + BRICK_SPACING);
localparam brick3_x_max = brick3_x_min + BRICK_WIDTH;
localparam brick3_y_min = MARGIN_TOP;
localparam brick3_y_max = MARGIN_TOP + BRICK_HEIGHT;

localparam brick4_x_min = MARGIN_SIDE + 3 * (BRICK_WIDTH + BRICK_SPACING);
localparam brick4_x_max = brick4_x_min + BRICK_WIDTH;
localparam brick4_y_min = MARGIN_TOP;
localparam brick4_y_max = MARGIN_TOP + BRICK_HEIGHT;

localparam brick5_x_min = MARGIN_SIDE + 4 * (BRICK_WIDTH + BRICK_SPACING);
localparam brick5_x_max = brick5_x_min + BRICK_WIDTH;
localparam brick5_y_min = MARGIN_TOP;
localparam brick5_y_max = MARGIN_TOP + BRICK_HEIGHT;

localparam brick6_x_min = MARGIN_SIDE + 5 * (BRICK_WIDTH + BRICK_SPACING);
localparam brick6_x_max = brick6_x_min + BRICK_WIDTH;
localparam brick6_y_min = MARGIN_TOP;
localparam brick6_y_max = MARGIN_TOP + BRICK_HEIGHT;

localparam brick7_x_min = MARGIN_SIDE;
localparam brick7_x_max = MARGIN_SIDE + BRICK_WIDTH;
localparam brick7_y_min = MARGIN_TOP + (BRICK_HEIGHT + BRICK_SPACING);
localparam brick7_y_max = brick7_y_min + BRICK_HEIGHT;

localparam brick8_x_min = MARGIN_SIDE + (BRICK_WIDTH + BRICK_SPACING);
localparam brick8_x_max = brick8_x_min + BRICK_WIDTH;
localparam brick8_y_min = MARGIN_TOP + (BRICK_HEIGHT + BRICK_SPACING);
localparam brick8_y_max = brick8_y_min + BRICK_HEIGHT;

localparam brick9_x_min = MARGIN_SIDE + 2 * (BRICK_WIDTH + BRICK_SPACING);
localparam brick9_x_max = brick9_x_min + BRICK_WIDTH;
localparam brick9_y_min = MARGIN_TOP + (BRICK_HEIGHT + BRICK_SPACING);
localparam brick9_y_max = brick9_y_min + BRICK_HEIGHT;

localparam brick10_x_min = MARGIN_SIDE + 3 * (BRICK_WIDTH + BRICK_SPACING);
localparam brick10_x_max = brick10_x_min + BRICK_WIDTH;
localparam brick10_y_min = MARGIN_TOP + (BRICK_HEIGHT + BRICK_SPACING);
localparam brick10_y_max = brick10_y_min + BRICK_HEIGHT;

localparam brick11_x_min = MARGIN_SIDE + 4 * (BRICK_WIDTH + BRICK_SPACING);
localparam brick11_x_max = brick11_x_min + BRICK_WIDTH;
localparam brick11_y_min = MARGIN_TOP + (BRICK_HEIGHT + BRICK_SPACING);
localparam brick11_y_max = brick11_y_min + BRICK_HEIGHT;

localparam brick12_x_min = MARGIN_SIDE + 5 * (BRICK_WIDTH + BRICK_SPACING);
localparam brick12_x_max = brick12_x_min + BRICK_WIDTH;
localparam brick12_y_min = MARGIN_TOP + (BRICK_HEIGHT + BRICK_SPACING);
localparam brick12_y_max = brick12_y_min + BRICK_HEIGHT;

localparam brick13_x_min = MARGIN_SIDE;
localparam brick13_x_max = MARGIN_SIDE + BRICK_WIDTH;
localparam brick13_y_min = MARGIN_TOP + 2 * (BRICK_HEIGHT + BRICK_SPACING);
localparam brick13_y_max = brick13_y_min + BRICK_HEIGHT;

localparam brick14_x_min = MARGIN_SIDE + (BRICK_WIDTH + BRICK_SPACING);
localparam brick14_x_max = brick14_x_min + BRICK_WIDTH;
localparam brick14_y_min = MARGIN_TOP + 2 * (BRICK_HEIGHT + BRICK_SPACING);
localparam brick14_y_max = brick14_y_min + BRICK_HEIGHT;

localparam brick15_x_min = MARGIN_SIDE + 2 * (BRICK_WIDTH + BRICK_SPACING);
localparam brick15_x_max = brick15_x_min + BRICK_WIDTH;
localparam brick15_y_min = MARGIN_TOP + 2 * (BRICK_HEIGHT + BRICK_SPACING);
localparam brick15_y_max = brick15_y_min + BRICK_HEIGHT;

localparam brick16_x_min = MARGIN_SIDE + 3 * (BRICK_WIDTH + BRICK_SPACING);
localparam brick16_x_max = brick16_x_min + BRICK_WIDTH;
localparam brick16_y_min = MARGIN_TOP + 2 * (BRICK_HEIGHT + BRICK_SPACING);
localparam brick16_y_max = brick16_y_min + BRICK_HEIGHT;

localparam brick17_x_min = MARGIN_SIDE + 4 * (BRICK_WIDTH + BRICK_SPACING);
localparam brick17_x_max = brick17_x_min + BRICK_WIDTH;
localparam brick17_y_min = MARGIN_TOP + 2 * (BRICK_HEIGHT + BRICK_SPACING);
localparam brick17_y_max = brick17_y_min + BRICK_HEIGHT;

localparam brick18_x_min = MARGIN_SIDE + 5 * (BRICK_WIDTH + BRICK_SPACING);
localparam brick18_x_max = brick18_x_min + BRICK_WIDTH;
localparam brick18_y_min = MARGIN_TOP + 2 * (BRICK_HEIGHT + BRICK_SPACING);
localparam brick18_y_max = brick18_y_min + BRICK_HEIGHT;

reg [CORDW-1:0] qx, qy;  // paddle position
reg [CORDW-1:0] qxb, qyb;  // ball position
reg qdx, qdy;  // ball direction: 0 is right/down
reg [CORDW-1:0] qs = 5;   // ball speed in pixels/frame

initial begin
    qx = (H_RES - H_SIZE_PADDLE) / 2;  // center paddle horizontally
    qy = V_RES - V_SIZE_PADDLE - 50;   // 50 pixels above bottom edge
    qxb = (H_RES - H_SIZE_BALL) / 2;  // center ball horizontally
    qyb = V_RES - V_SIZE_BALL - 65;   // 65 pixels above bottom edge
    // Initialize bricks
    brick1_active = 1;
    brick2_active = 1;
    brick3_active = 1;
    brick4_active = 1;
    brick5_active = 1;
    brick6_active = 1;
    brick7_active = 1;
    brick8_active = 1;
    brick9_active = 1;
    brick10_active = 1;
    brick11_active = 1;
    brick12_active = 1;
    brick13_active = 1;
    brick14_active = 1;
    brick15_active = 1;
    brick16_active = 1;
    brick17_active = 1;
    brick18_active = 1;
end

// Paddle movement
always @(posedge clk) begin
    if (frame && cnt_frame == 0) begin
        // horizontal position
        if (btn2 && !(qx + H_SIZE_PADDLE + qs >= H_RES-1) ) begin  // moving right
            qx <= qx + qs;  // continue moving right
        end else if (btn1 && !(qx < qs)) begin
            qx <= qx - qs;  // continue moving left
        end
    end
end

// Ball movement and collision detection
always @(posedge clk) begin
    if (frame && cnt_frame == 0) begin
        // horizontal position
        if (qdx == 0) begin  // moving right
            if (qxb + H_SIZE_BALL + qs >= H_RES-1) begin  // hitting right of screen?
                qxb <= H_RES - H_SIZE_BALL -1;  // move right as far as we can
                qdx <= 1;  // move left next frame
            end else qxb <= qxb + qs;  // continue moving right
        end else begin  // moving left
            if (qxb < qs) begin  // hitting left of screen?
                qxb <= 0;  // move left as far as we can
                qdx <= 0;  // move right next frame
            end else begin
                qxb <= qxb - qs;  // continue moving left
            end
        end

        // vertical position
        if (qdy == 0) begin  // moving down
            if (qyb + V_SIZE_BALL >= V_RES-1) begin  // hitting bottom of screen?
                qyb <= V_RES - V_SIZE_BALL - 1;  // move down as far as we can
                qdy <= 1;  // move up next frame
            end else begin
                if ((qyb + V_SIZE_BALL >= qy) && (qyb <= qy + V_SIZE_PADDLE) && (qxb + H_SIZE_BALL >= qx) && (qxb <= qx + H_SIZE_PADDLE)) begin
                    // Ball hits paddle
                    qdy <= 1;  // move up next frame
                end else if (qyb + V_SIZE_BALL > qy + V_SIZE_PADDLE) begin
                    // Ball is below paddle, stop the game
                    qyb <= qyb;  // keep current position
                    qdy <= qdy;  // stop vertical movement
                    qxb <= qxb;
                end else begin
                    qyb <= qyb + qs;  // continue moving down
                end
            end
        end else begin  // moving up
            if (qyb < qs) begin  // hitting top of screen?
                qyb <= 0;  // move up as far as we can
                qdy <= 0;  // move down next frame
            end else begin
                qyb <= qyb - qs;  // continue moving up
            end
        end

        // Collision with bricks
        if (brick1_active && (qxb + H_SIZE_BALL > brick1_x_min) && (qxb < brick1_x_max) &&
            (qyb + V_SIZE_BALL > brick1_y_min) && (qyb < brick1_y_max)) begin
            brick1_active = 0;
            qdy <= ~qdy;
        end
        if (brick2_active && (qxb + H_SIZE_BALL > brick2_x_min) && (qxb < brick2_x_max) &&
            (qyb + V_SIZE_BALL > brick2_y_min) && (qyb < brick2_y_max)) begin
            brick2_active = 0;
            qdy <= ~qdy;
        end
        if (brick3_active && (qxb + H_SIZE_BALL > brick3_x_min) && (qxb < brick3_x_max) &&
            (qyb + V_SIZE_BALL > brick3_y_min) && (qyb < brick3_y_max)) begin
            brick3_active = 0;
            qdy <= ~qdy;
        end
        if (brick4_active && (qxb + H_SIZE_BALL > brick4_x_min) && (qxb < brick4_x_max) &&
            (qyb + V_SIZE_BALL > brick4_y_min) && (qyb < brick4_y_max)) begin
            brick4_active = 0;
            qdy <= ~qdy;
        end
        if (brick5_active && (qxb + H_SIZE_BALL > brick5_x_min) && (qxb < brick5_x_max) &&
            (qyb + V_SIZE_BALL > brick5_y_min) && (qyb < brick5_y_max)) begin
            brick5_active = 0;
            qdy <= ~qdy;
        end
        if (brick6_active && (qxb + H_SIZE_BALL > brick6_x_min) && (qxb < brick6_x_max) &&
            (qyb + V_SIZE_BALL > brick6_y_min) && (qyb < brick6_y_max)) begin
            brick6_active = 0;
            qdy <= ~qdy;
        end
        if (brick7_active && (qxb + H_SIZE_BALL > brick7_x_min) && (qxb < brick7_x_max) &&
            (qyb + V_SIZE_BALL > brick7_y_min) && (qyb < brick7_y_max)) begin
            brick7_active = 0;
            qdy <= ~qdy;
        end
        if (brick8_active && (qxb + H_SIZE_BALL > brick8_x_min) && (qxb < brick8_x_max) &&
            (qyb + V_SIZE_BALL > brick8_y_min) && (qyb < brick8_y_max)) begin
            brick8_active = 0;
            qdy <= ~qdy;
        end
        if (brick9_active && (qxb + H_SIZE_BALL > brick9_x_min) && (qxb < brick9_x_max) &&
            (qyb + V_SIZE_BALL > brick9_y_min) && (qyb < brick9_y_max)) begin
            brick9_active = 0;
            qdy <= ~qdy;
        end
        if (brick10_active && (qxb + H_SIZE_BALL > brick10_x_min) && (qxb < brick10_x_max) &&
            (qyb + V_SIZE_BALL > brick10_y_min) && (qyb < brick10_y_max)) begin
            brick10_active = 0;
            qdy <= ~qdy;
        end
        if (brick11_active && (qxb + H_SIZE_BALL > brick11_x_min) && (qxb < brick11_x_max) &&
            (qyb + V_SIZE_BALL > brick11_y_min) && (qyb < brick11_y_max)) begin
            brick11_active = 0;
            qdy <= ~qdy;
        end
        if (brick12_active && (qxb + H_SIZE_BALL > brick12_x_min) && (qxb < brick12_x_max) &&
            (qyb + V_SIZE_BALL > brick12_y_min) && (qyb < brick12_y_max)) begin
            brick12_active = 0;
            qdy <= ~qdy;
        end
        if (brick13_active && (qxb + H_SIZE_BALL > brick13_x_min) && (qxb < brick13_x_max) &&
            (qyb + V_SIZE_BALL > brick13_y_min) && (qyb < brick13_y_max)) begin
            brick13_active = 0;
            qdy <= ~qdy;
        end
        if (brick14_active && (qxb + H_SIZE_BALL > brick14_x_min) && (qxb < brick14_x_max) &&
            (qyb + V_SIZE_BALL > brick14_y_min) && (qyb < brick14_y_max)) begin
            brick14_active = 0;
            qdy <= ~qdy;
        end
        if (brick15_active && (qxb + H_SIZE_BALL > brick15_x_min) && (qxb < brick15_x_max) &&
            (qyb + V_SIZE_BALL > brick15_y_min) && (qyb < brick15_y_max)) begin
            brick15_active = 0;
            qdy <= ~qdy;
        end
        if (brick16_active && (qxb + H_SIZE_BALL > brick16_x_min) && (qxb < brick16_x_max) &&
            (qyb + V_SIZE_BALL > brick16_y_min) && (qyb < brick16_y_max)) begin
            brick16_active = 0;
            qdy <= ~qdy;
        end
        if (brick17_active && (qxb + H_SIZE_BALL > brick17_x_min) && (qxb < brick17_x_max) &&
            (qyb + V_SIZE_BALL > brick17_y_min) && (qyb < brick17_y_max)) begin
            brick17_active = 0;
            qdy <= ~qdy;
        end
        if (brick18_active && (qxb + H_SIZE_BALL > brick18_x_min) && (qxb < brick18_x_max) &&
            (qyb + V_SIZE_BALL > brick18_y_min) && (qyb < brick18_y_max)) begin
            brick18_active = 0;
            qdy <= ~qdy;
        end
    end
end

reg square;
always @(posedge clk) begin
    square = (sx >= qx) && (sx < qx + H_SIZE_PADDLE) && (sy >= qy) && (sy < qy + V_SIZE_PADDLE);
end

reg ball;
always @(posedge clk) begin
    ball = (sx >= qxb) && (sx < qxb + H_SIZE_BALL) && (sy >= qyb) && (sy < qyb + V_SIZE_BALL);
end

reg brick;
always @(posedge clk) begin
    brick = 0;
    if (brick1_active && (sx >= brick1_x_min) && (sx < brick1_x_max) && (sy >= brick1_y_min) && (sy < brick1_y_max)) brick = 1;
    if (brick2_active && (sx >= brick2_x_min) && (sx < brick2_x_max) && (sy >= brick2_y_min) && (sy < brick2_y_max)) brick = 1;
    if (brick3_active && (sx >= brick3_x_min) && (sx < brick3_x_max) && (sy >= brick3_y_min) && (sy < brick3_y_max)) brick = 1;
    if (brick4_active && (sx >= brick4_x_min) && (sx < brick4_x_max) && (sy >= brick4_y_min) && (sy < brick4_y_max)) brick = 1;
    if (brick5_active && (sx >= brick5_x_min) && (sx < brick5_x_max) && (sy >= brick5_y_min) && (sy < brick5_y_max)) brick = 1;
    if (brick6_active && (sx >= brick6_x_min) && (sx < brick6_x_max) && (sy >= brick6_y_min) && (sy < brick6_y_max)) brick = 1;
    if (brick7_active && (sx >= brick7_x_min) && (sx < brick7_x_max) && (sy >= brick7_y_min) && (sy < brick7_y_max)) brick = 1;
    if (brick8_active && (sx >= brick8_x_min) && (sx < brick8_x_max) && (sy >= brick8_y_min) && (sy < brick8_y_max)) brick = 1;
    if (brick9_active && (sx >= brick9_x_min) && (sx < brick9_x_max) && (sy >= brick9_y_min) && (sy < brick9_y_max)) brick = 1;
    if (brick10_active && (sx >= brick10_x_min) && (sx < brick10_x_max) && (sy >= brick10_y_min) && (sy < brick10_y_max)) brick = 1;
    if (brick11_active && (sx >= brick11_x_min) && (sx < brick11_x_max) && (sy >= brick11_y_min) && (sy < brick11_y_max)) brick = 1;
    if (brick12_active && (sx >= brick12_x_min) && (sx < brick12_x_max) && (sy >= brick12_y_min) && (sy < brick12_y_max)) brick = 1;
    if (brick13_active && (sx >= brick13_x_min) && (sx < brick13_x_max) && (sy >= brick13_y_min) && (sy < brick13_y_max)) brick = 1;
    if (brick14_active && (sx >= brick14_x_min) && (sx < brick14_x_max) && (sy >= brick14_y_min) && (sy < brick14_y_max)) brick = 1;
    if (brick15_active && (sx >= brick15_x_min) && (sx < brick15_x_max) && (sy >= brick15_y_min) && (sy < brick15_y_max)) brick = 1;
    if (brick16_active && (sx >= brick16_x_min) && (sx < brick16_x_max) && (sy >= brick16_y_min) && (sy < brick16_y_max)) brick = 1;
    if (brick17_active && (sx >= brick17_x_min) && (sx < brick17_x_max) && (sy >= brick17_y_min) && (sy < brick17_y_max)) brick = 1;
    if (brick18_active && (sx >= brick18_x_min) && (sx < brick18_x_max) && (sy >= brick18_y_min) && (sy < brick18_y_max)) brick = 1;
end

always @(posedge clk) begin
    if (square) begin
        red <= 8'd0;
        green <= 8'd0;
        blue <= 8'd255;
    end else if (ball) begin
        red <= 8'd255;
        green <= 8'd0;
        blue <= 8'd0;
    end else if (brick) begin
        red <= 8'd0;
        green <= 8'd255;
        blue <= 8'd0;
    end else begin
        red <= 8'd0;
        green <= 8'd0;
        blue <= 8'd0;
    end
end

endmodule
