`include "Register.v"

module testbench;
    reg [7:0] data_in;
    reg clk, reset;
    wire [7:0] data_out;

    Register register (
        .data_in(data_in),
        .clk(clk),
        .reset(reset),
        .data_out(data_out)
    );

    initial begin
        
        data_in = 8'b0; clk = 0; reset = 0;


        #5 reset = 1;

    
        #10 data_in = 8'b10101010;
        #10 data_in = 8'b01010101;
        #10 data_in = 8'b11110000;
        #10 data_in = 8'b00001111;
        
   
        #20 $finish;
    end

    always #5 clk = ~clk; 

    initial begin
        $monitor("At time %t, data_in = %b, data_out = %b, clk = %d, reset = %d", $time, data_in, data_out, clk, reset);
    end
endmodule
