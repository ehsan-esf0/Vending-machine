`include "./Logical_modules/DFF.v"
`include "./Logical_modules/FMS.v"
`include "./Logical_modules/Remaining.v"
`include "./Logical_modules/Register.v"
`include "./Logical_modules/decoder_3to8.v"

module MainModule (
    input [2:0] product_id,
    input [7:0] price0, price1, price2, price3, price4, price5, price6, price7,
    input clk,
    input reset,
    input [7:0] amount_paid,
    output [7:0] decoder_out,
    output [1:0] state,
    output [7:0] price,
    output [7:0] change
);

    wire [7:0] decoder_out;
    wire [7:0] price_out [0:7];


    decoder_3to8 decoder (
        .in(product_id),
        .out(decoder_out)
    );


    FSM fsm (
        .product_id(product_id),
        .decoder_out(decoder_out),
        .clk(clk),
        .reset(reset),
        .state(state)
    );


    Register price_reg0 (.data_in(price0), .clk(clk), .reset(reset), .data_out(price_out[0]));
    Register price_reg1 (.data_in(price1), .clk(clk), .reset(reset), .data_out(price_out[1]));
    Register price_reg2 (.data_in(price2), .clk(clk), .reset(reset), .data_out(price_out[2]));
    Register price_reg3 (.data_in(price3), .clk(clk), .reset(reset), .data_out(price_out[3]));
    Register price_reg4 (.data_in(price4), .clk(clk), .reset(reset), .data_out(price_out[4]));
    Register price_reg5 (.data_in(price5), .clk(clk), .reset(reset), .data_out(price_out[5]));
    Register price_reg6 (.data_in(price6), .clk(clk), .reset(reset), .data_out(price_out[6]));
    Register price_reg7 (.data_in(price7), .clk(clk), .reset(reset), .data_out(price_out[7]));


    Remaining change_calculator (
        .price(price),
        .amount_paid(amount_paid),
        .change(change)
    );


    assign price = price_out[product_id];

endmodule

module testbench;
    reg [2:0] product_id;
    reg [7:0] price0, price1, price2, price3, price4, price5, price6, price7;
    reg clk, reset;
    reg [7:0] amount_paid;
    wire [7:0] decoder_out;
    wire [1:0] state;
    wire [7:0] price;
    wire [7:0] change;

    MainModule main (
        .product_id(product_id),
        .price0(price0), .price1(price1), .price2(price2), .price3(price3),
        .price4(price4), .price5(price5), .price6(price6), .price7(price7),
        .clk(clk),
        .reset(reset),
        .amount_paid(amount_paid),
        .decoder_out(decoder_out),
        .state(state),
        .price(price),
        .change(change)
    );

    initial begin

        price0 = 8'd10;
        price1 = 8'd20;
        price2 = 8'd30;
        price3 = 8'd40;
        price4 = 8'd50;
        price5 = 8'd60;
        price6 = 8'd70;
        price7 = 8'd80;


        product_id = 3'b000; clk = 0; reset = 0; amount_paid = 8'd0;


        #5 reset = 1;
        #5 reset = 0;

        #10 product_id = 3'b001; amount_paid = 8'd25;
        #10 product_id = 3'b010; amount_paid = 8'd35;
        #10 product_id = 3'b011; amount_paid = 8'd45;
        #10 product_id = 3'b100; amount_paid = 8'd55;
        #10 product_id = 3'b101; amount_paid = 8'd65;
        #10 product_id = 3'b110; amount_paid = 8'd75;
        #10 product_id = 3'b111; amount_paid = 8'd85;

     
        #20 $finish;
    end

    always #5 clk = ~clk; 

    initial begin
        $monitor("At time %t, Product ID = %b, Decoder Out = %b, State = %b, Price = %d, Amount Paid = %d, Change = %d", $time, product_id, decoder_out, state, price, amount_paid, change);
    end
endmodule
