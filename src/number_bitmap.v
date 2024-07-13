module number_bitmap (
 input clk,
 input reg [7:0] number,
 output reg [7:0] score [7:0]
);


always @ (posedge clk) begin
    case (number)
        4'b0000: begin
            score[0] = 8'b00111100;
            score[1] = 8'b01100110;
            score[2] = 8'b01100110;
            score[3] = 8'b01100110;
            score[4] = 8'b01100110;
            score[5] = 8'b01100110;
            score[6] = 8'b00111100;
            score[7] = 8'b00000000;
        end
        4'b0001: begin
            score[0] = 8'b00011000;
            score[1] = 8'b00111000;
            score[2] = 8'b00011000;
            score[3] = 8'b00011000;
            score[4] = 8'b00011000;
            score[5] = 8'b00011000;
            score[6] = 8'b01111110;
            score[7] = 8'b00000000;
        end
        4'b0010: begin
            score[0] = 8'b00111100;
            score[1] = 8'b01100110;
            score[2] = 8'b00000110;
            score[3] = 8'b00001100;
            score[4] = 8'b00110000;
            score[5] = 8'b01100000;
            score[6] = 8'b01111110;
            score[7] = 8'b00000000;
        end
        4'b0011: begin
            score[0] = 8'b00111100;
            score[1] = 8'b01100110;
            score[2] = 8'b00000110;
            score[3] = 8'b00011100;
            score[4] = 8'b00000110;
            score[5] = 8'b01100110;
            score[6] = 8'b00111100;
            score[7] = 8'b00000000;
        end
        4'b0100: begin
            score[0] = 8'b00001100;
            score[1] = 8'b00011100;
            score[2] = 8'b00111100;
            score[3] = 8'b01101100;
            score[4] = 8'b01111110;
            score[5] = 8'b00001100;
            score[6] = 8'b00011110;
            score[7] = 8'b00000000;
        end
        4'b0101: begin
            score[0] = 8'b01111110;
            score[1] = 8'b01100000;
            score[2] = 8'b01111100;
            score[3] = 8'b00000110;
            score[4] = 8'b00000110;
            score[5] = 8'b01100110;
            score[6] = 8'b00111100;
            score[7] = 8'b00000000;
        end
        4'b0110: begin
            score[0] = 8'b00111100;
            score[1] = 8'b01100110;
            score[2] = 8'b01100000;
            score[3] = 8'b01111100;
            score[4] = 8'b01100110;
            score[5] = 8'b01100110;
            score[6] = 8'b00111100;
            score[7] = 8'b00000000;
        end
        4'b0111: begin
            score[0] = 8'b01111110;
            score[1] = 8'b01100110;
            score[2] = 8'b00000110;
            score[3] = 8'b00001100;
            score[4] = 8'b00011000;
            score[5] = 8'b00011000;
            score[6] = 8'b00011000;
            score[7] = 8'b00000000;
        end
        4'b1000: begin
            score[0] = 8'b00111100;
            score[1] = 8'b01100110;
            score[2] = 8'b01100110;
            score[3] = 8'b00111100;
            score[4] = 8'b01100110;
            score[5] = 8'b01100110;
            score[6] = 8'b00111100;
            score[7] = 8'b00000000;
        end
        4'b1001: begin
            score[0] = 8'b00111100;
            score[1] = 8'b01100110;
            score[2] = 8'b01100110;
            score[3] = 8'b00111110;
            score[4] = 8'b00000110;
            score[5] = 8'b01100110;
            score[6] = 8'b00111100;
            score[7] = 8'b00000000;
        end
        default: begin
            score[0] = 8'b00000000;
            score[1] = 8'b00000000;
            score[2] = 8'b00000000;
            score[3] = 8'b00000000;
            score[4] = 8'b00000000;
            score[5] = 8'b00000000;
            score[6] = 8'b00000000;
            score[7] = 8'b00000000;
        end
    endcase
end

endmodule