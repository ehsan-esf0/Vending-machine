module Register (
    input [7:0] data_in,
    input clk,
    input reset,
    output [7:0] data_out
);

    DFF dff0 (.D(data_in[0]), .clk(clk), .rst(reset), .Q(data_out[0]));
    DFF dff1 (.D(data_in[1]), .clk(clk), .rst(reset), .Q(data_out[1]));
    DFF dff2 (.D(data_in[2]), .clk(clk), .rst(reset), .Q(data_out[2]));
    DFF dff3 (.D(data_in[3]), .clk(clk), .rst(reset), .Q(data_out[3]));
    DFF dff4 (.D(data_in[4]), .clk(clk), .rst(reset), .Q(data_out[4]));
    DFF dff5 (.D(data_in[5]), .clk(clk), .rst(reset), .Q(data_out[5]));
    DFF dff6 (.D(data_in[6]), .clk(clk), .rst(reset), .Q(data_out[6]));
    DFF dff7 (.D(data_in[7]), .clk(clk), .rst(reset), .Q(data_out[7]));

endmodule
