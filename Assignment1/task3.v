module heating_system(
    input [4:0] temp, output reg [1:0] C
);
    initial begin
        C = 2'b00;
    end
    always @(temp) begin
        if (C == 2'b10) begin
            if (temp > 5'b11010) begin
                C = 2'b01;
            end else begin
                if (temp > 5'b10100) begin
                    C = 2'b00;
                end
            end
        end else begin
            if (C == 2'b01) begin
                if (temp < 5'b01000) begin
                    C = 2'b10;
                end else begin
                    if (temp < 5'b01110) begin
                        C = 2'b00;
                    end
                end
            end else begin
                if (C == 2'b00) begin
                    if (temp < 5'b01100) begin
                        C = 2'b10;
                    end else begin
                        if (temp > 5'b10010) begin
                            C = 2'b01;
                        end
                    end
                end
            end
        end
    end
endmodule
