module DFF (Q, D, clk, rst);
    output Q;
    input D, clk, rst;
    wire Qm, S, R;

    nand (S, D, clk, rst);
    nand (R, ~D, clk, rst);
    nand (Qm, R, Q);
    nand (Q, S, Qm);

endmodule


