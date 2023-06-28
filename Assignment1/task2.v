module flip_flop(
    input A, B, clk, output reg C
);
    initial begin
        C = 1'b0;
    end
    always @(posedge clk) begin
        C = (A & B) | C;
    end
endmodule
