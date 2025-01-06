module DFF (Q, D, clk, rst);
    output Q;
    input D, clk, rst;
    wire Qm, S, R;

    nand (S, D, clk, rst);
    nand (R, ~D, clk, rst);
    nand (Qm, R, Q);
    nand (Q, S, Qm);

endmodule


module testbench;
    reg D, clk, rst;
    wire Q;

    DFF dff (Q, D, clk, rst);

    initial begin

        D = 0; clk = 0; rst = 0;

     
        #5 rst = 1;

        #5 D = 0;
        #5 D = 1; 
        #5 D = 0; 
        #5 D = 1; 
        #5 D = 0; 
        #5 D = 1; 
        #5 D = 0;
        #5 D = 1;
        #5 D = 0; 



        #20 $finish;
    end

    always #5 clk = ~clk; 

    initial begin
        $monitor("At time %t, Q = %d, D = %d, clk = %d, rst = %d", $time, Q, D, clk, rst);
    end
endmodule
