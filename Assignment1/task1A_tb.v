`include "task1A.v"
module tb;
    reg [7:0] A, B,C;
    wire [7:0] R;
    wire C_out;
    three_number_add addthree0(A, B, C, R, C_out);
    initial begin
        $display(" A   B   C   Sum");
        $monitor("%d %d %d  %d", A, B, C, R);

        repeat(10) begin
            A = $random;
            B = $random;
            C = $random;
            #25;
        end
    end
endmodule