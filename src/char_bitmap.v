module game_over_bitmap (
    input clk,
    input reg [3:0] letter,
    output reg [7:0] bitmap [7:0]
);

always @(posedge clk) begin
    case (letter)
        4'b0000: begin // G
            bitmap[0] = 8'b00111100;
            bitmap[1] = 8'b01000010;
            bitmap[2] = 8'b01000000;
            bitmap[3] = 8'b01001110;
            bitmap[4] = 8'b01000010;
            bitmap[5] = 8'b01000010;
            bitmap[6] = 8'b00111100;
            bitmap[7] = 8'b00000000;
        end
        4'b0001: begin // A
            bitmap[0] = 8'b00011000;
            bitmap[1] = 8'b00100100;
            bitmap[2] = 8'b01000010;
            bitmap[3] = 8'b01111110;
            bitmap[4] = 8'b01000010;
            bitmap[5] = 8'b01000010;
            bitmap[6] = 8'b01000010;
            bitmap[7] = 8'b00000000;
        end
        4'b0010: begin // M
            bitmap[0] = 8'b01000010;
            bitmap[1] = 8'b01100110;
            bitmap[2] = 8'b01011010;
            bitmap[3] = 8'b01000010;
            bitmap[4] = 8'b01000010;
            bitmap[5] = 8'b01000010;
            bitmap[6] = 8'b01000010;
            bitmap[7] = 8'b00000000;
        end
        4'b0011: begin // E
            bitmap[0] = 8'b01111110;
            bitmap[1] = 8'b01000000;
            bitmap[2] = 8'b01000000;
            bitmap[3] = 8'b01111100;
            bitmap[4] = 8'b01000000;
            bitmap[5] = 8'b01000000;
            bitmap[6] = 8'b01111110;
            bitmap[7] = 8'b00000000;
        end
        4'b0100: begin // O
            bitmap[0] = 8'b00111100;
            bitmap[1] = 8'b01000010;
            bitmap[2] = 8'b01000010;
            bitmap[3] = 8'b01000010;
            bitmap[4] = 8'b01000010;
            bitmap[5] = 8'b01000010;
            bitmap[6] = 8'b00111100;
            bitmap[7] = 8'b00000000;
        end
        4'b0101: begin // V
            bitmap[0] = 8'b01000010;
            bitmap[1] = 8'b01000010;
            bitmap[2] = 8'b01000010;
            bitmap[3] = 8'b01000010;
            bitmap[4] = 8'b01000010;
            bitmap[5] = 8'b00100100;
            bitmap[6] = 8'b00011000;
            bitmap[7] = 8'b00000000;
        end
        4'b0110: begin // R
            bitmap[0] = 8'b01111100;
            bitmap[1] = 8'b01000010;
            bitmap[2] = 8'b01000010;
            bitmap[3] = 8'b01111100;
            bitmap[4] = 8'b01001000;
            bitmap[5] = 8'b01000100;
            bitmap[6] = 8'b01000010;
            bitmap[7] = 8'b00000000;
        end
        4'b1111: begin // space
            bitmap[0] = 8'b00000000;
            bitmap[1] = 8'b00000000;
            bitmap[2] = 8'b00000000;
            bitmap[3] = 8'b00000000;
            bitmap[4] = 8'b00000000;
            bitmap[5] = 8'b00000000;
            bitmap[6] = 8'b00000000;
            bitmap[7] = 8'b00000000;
        end
        default: begin
            bitmap[0] = 8'b00000000;
            bitmap[1] = 8'b00000000;
            bitmap[2] = 8'b00000000;
            bitmap[3] = 8'b00000000;
            bitmap[4] = 8'b00000000;
            bitmap[5] = 8'b00000000;
            bitmap[6] = 8'b00000000;
            bitmap[7] = 8'b00000000;
        end
    endcase
end

endmodule