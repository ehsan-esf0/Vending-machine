
module ProductCounter (
    input [3:0] count_in,
    input clk,
    input reset,
    output [3:0] count_out
);

    wire [3:0] next_count;


    DFF dff0 (.D(next_count[0]), .clk(clk), .rst(reset), .Q(count_out[0]));
    DFF dff1 (.D(next_count[1]), .clk(clk), .rst(reset), .Q(count_out[1]));
    DFF dff2 (.D(next_count[2]), .clk(clk), .rst(reset), .Q(count_out[2]));
    DFF dff3 (.D(next_count[3]), .clk(clk), .rst(reset), .Q(count_out[3]));


    assign next_count = count_in;

endmodule
