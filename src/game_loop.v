module game_loop (
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
reg [7:0] score_counter; // score counter, 

reg [3:0] tens_digit;
reg [3:0] units_digit;

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

localparam NUM_BRICKS_X = 6;
localparam NUM_BRICKS_Y = 4;
localparam NUM_BRICKS = NUM_BRICKS_X * NUM_BRICKS_Y;

// State of bricks (1 = active, 0 = destroyed)
reg [NUM_BRICKS-1:0] bricks_active;

reg [CORDW-1:0] qx, qy;  // paddle position
reg [CORDW-1:0] qxb, qyb;  // ball position
reg qdx, qdy;  // ball direction: 0 is right/down
reg [CORDW-1:0] qs = 5;   // ball speed in pixels/frame
reg [CORDW-1:0] ps = 10;   // paddle speed in pixels/frame

integer i, j;

initial begin
    qx = (H_RES - H_SIZE_PADDLE) / 2;  // center paddle horizontally
    qy = V_RES - V_SIZE_PADDLE - 50;   // 50 pixels above bottom edge
    qxb = (H_RES - H_SIZE_BALL) / 2;  // center ball horizontally
    qyb = V_RES - V_SIZE_BALL - 65;   // 65 pixels above bottom edge
    score_counter = 0;
    tens_digit = 4'b0000;
    units_digit = 4'b0000;

    // Initialize bricks
    for (i = 0; i < NUM_BRICKS; i = i + 1) begin
        bricks_active[i] = 1;
    end
end

// Paddle movement
always @(posedge clk) begin
    if (frame && cnt_frame == 0) begin
        // horizontal position
        if (btn2 && !(qx + H_SIZE_PADDLE + ps >= H_RES-1) ) begin  // moving right
            qx <= qx + ps;  // continue moving right
        end else if (btn1 && !(qx < ps)) begin
            qx <= qx - ps;  // continue moving left
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
        for (i = 0; i < NUM_BRICKS; i = i + 1) begin
            if (bricks_active[i]) begin
                // Calculate brick position
                integer bx_min = MARGIN_SIDE + (i % NUM_BRICKS_X) * (BRICK_WIDTH + BRICK_SPACING);
                integer bx_max = bx_min + BRICK_WIDTH;
                integer by_min = MARGIN_TOP + (i / NUM_BRICKS_X) * (BRICK_HEIGHT + BRICK_SPACING);
                integer by_max = by_min + BRICK_HEIGHT;

                if ((qxb + H_SIZE_BALL > bx_min) && (qxb < bx_max) &&
                    (qyb + V_SIZE_BALL > by_min) && (qyb < by_max)) begin
                    score_counter = score_counter + 1;  // increase score on collision
                    tens_digit = (score_counter - 1)  / 10;
                    units_digit = score_counter  % 10;
                    bricks_active[i] = 0;
                    qdy <= ~qdy;
                end
            end
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
    for (i = 0; i < NUM_BRICKS; i = i + 1) begin
        if (bricks_active[i]) begin
            // Calculate brick position
            integer bx_min = MARGIN_SIDE + (i % NUM_BRICKS_X) * (BRICK_WIDTH + BRICK_SPACING);
            integer bx_max = bx_min + BRICK_WIDTH;
            integer by_min = MARGIN_TOP + (i / NUM_BRICKS_X) * (BRICK_HEIGHT + BRICK_SPACING);
            integer by_max = by_min + BRICK_HEIGHT;

            if ((sx >= bx_min) && (sx < bx_max) && (sy >= by_min) && (sy < by_max)) begin
                brick = 1;
            end
        end
    end
end

// Score display in top left corner
reg [7:0] score [7:0]; // 8x8 bitmaps for digits '0' to '9'
reg [7:0] score_1 [7:0]; // 8x8 bitmaps for digits '0' to '9'


number_bitmap score1 ( //tens
    .clk(clk),
    .number(tens_digit),
    .score(score_1)
);

number_bitmap score2 ( //units
    .clk(clk),
    .number((units_digit - 1) < 9 ? (units_digit - 1) : 9 ),
    .score(score)
);

reg score_area_1;
always @(posedge clk) begin
    integer scaled_sx = sx / 2;
    integer scaled_sy = sy / 2;
    score_area_1 = (sx < 16) && (sy < 16) && score_1[scaled_sy][7 - scaled_sx];
end

reg score_area_2;
always @(posedge clk) begin
    integer scaled_sx = (sx - 16) / 2;
    integer scaled_sy = sy / 2;
    score_area_2 = (sx >= 16) && (sx < 32) && (sy < 16) && score[scaled_sy][7 - scaled_sx];
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
    end else if (score_area_1) begin
        red <= 8'd255;
        green <= 8'd255;
        blue <= 8'd255;
    end else if (score_area_2) begin
        red <= 8'd255;
        green <= 8'd255;
        blue <= 8'd255;
    end else begin
        red <= 8'd0;
        green <= 8'd0;
        blue <= 8'd0;
    end
end

endmodule
