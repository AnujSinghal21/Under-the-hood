`include "task3.v"
module tb;
    reg [4:0] T;
    wire [1:0] fsm;
    heating_system heat0 (T,fsm);
    initial begin
        #2;
        T = 5'b00000;
        $monitor("Temperature =%d, state = %b",T,fsm);
        repeat(15) begin
            T = $random;
            #15;
        end
    end
endmodule