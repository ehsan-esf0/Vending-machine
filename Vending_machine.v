`include "./Sequential_module/DFF.v"

module Vending_machine (
    input [3:0] D,
    input CLK,
    input RESET,
    output [3:0] Q
);

    DFF dff0 (.D(D[0]), .clk(CLK), .rst(RESET), .Q(Q[0]));
    DFF dff1 (.D(D[1]), .clk(CLK), .rst(RESET), .Q(Q[1]));
    DFF dff2 (.D(D[2]), .clk(CLK), .rst(RESET), .Q(Q[2]));
    DFF dff3 (.D(D[3]), .clk(CLK), .rst(RESET), .Q(Q[3]));

endmodule


module testbench;
    reg [3:0] D;
    reg CLK, RESET;
    wire [3:0] Q;

    Vending_machine register (.D(D), .CLK(CLK), .RESET(RESET), .Q(Q));

    initial begin

        D = 4'b0000; CLK = 0; RESET = 0;


        #5 RESET = 1;

        #10 D = 4'b1010;
        #10 D = 4'b0101;
        #10 D = 4'b1111;
        #10 D = 4'b0000;
        #10 D = 4'b1001;
        #10 D = 4'b0110;

 
        #20 $finish;
    end

    always #10 CLK = ~CLK; 

    initial begin
        $monitor("At time %t, Q = %b, D = %b, CLK = %d, RESET = %d", $time, Q, D, CLK, RESET);
    end
endmodule
