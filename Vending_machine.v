`include "./Logical_modules/DFF.v"
`include "./Logical_modules/FMS.v"
`include "./Logical_modules/Remaining.v"
`include "./Logical_modules/Register.v"
`include "./Logical_modules/decoder_3to8.v"
`include "./Logical_modules/Comparator.v"
`include "./Logical_modules/DiscountCalculator.v"
`include "./Logical_modules/ProductCounter.v"

module MainModule (
    input [2:0] product_id,
    input [7:0] price0, price1, price2, price3, price4, price5, price6, price7,
    input [3:0] quantity, 
    input [15:0] amount_paid, 
    input clk,
    input reset,
    output [7:0] price,
    output [15:0] total_price, 
    output [15:0] discounted_price, 
    output [15:0] remaining_amount 
);

    wire [7:0] prices [0:7]; 
    wire discount;


    assign prices[0] = price0;
    assign prices[1] = price1;
    assign prices[2] = price2;
    assign prices[3] = price3;
    assign prices[4] = price4;
    assign prices[5] = price5;
    assign prices[6] = price6;
    assign prices[7] = price7;


    assign price = prices[product_id];

 
    assign total_price = price * quantity;


    Comparator comparator (
        .count(quantity),
        .discount(discount)
    );


    DiscountCalculator discount_calculator (
        .total_amount(total_price),
        .discount(discount),
        .discounted_amount(discounted_price)
    );


    Remaining change_calculator (
        .price(discounted_price),
        .amount_paid(amount_paid),
        .remaining(remaining_amount)
    );

endmodule

module testbench;
    reg [2:0] product_id;
    reg [7:0] price0, price1, price2, price3, price4, price5, price6, price7;
    reg [3:0] quantity; 
    reg [15:0] amount_paid; 
    reg clk, reset;
    wire [7:0] price;
    wire [15:0] total_price; 
    wire [15:0] discounted_price; 
    wire [15:0] remaining_amount; 

    MainModule main (
        .product_id(product_id),
        .price0(price0), .price1(price1), .price2(price2), .price3(price3),
        .price4(price4), .price5(price5), .price6(price6), .price7(price7),
        .quantity(quantity),
        .amount_paid(amount_paid),
        .clk(clk),
        .reset(reset),
        .price(price),
        .total_price(total_price),
        .discounted_price(discounted_price),
        .remaining_amount(remaining_amount)
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

    
        product_id = 3'b000; clk = 0; reset = 0; amount_paid = 16'd0; quantity = 4'd0;

      
        #5 reset = 1;
        #5 reset = 0;

     
        #10 product_id = 3'b001; amount_paid = 16'd250; quantity = 4'd5;
        #10 product_id = 3'b010; amount_paid = 16'd350; quantity = 4'd10;
        #10 product_id = 3'b011; amount_paid = 16'd450; quantity = 4'd12;
        #10 product_id = 3'b100; amount_paid = 16'd550; quantity = 4'd15;


        #20 $finish;
    end

    always #5 clk = ~clk; 

    initial begin
        $monitor("At time %t, Product ID = %b, Price = %d, Total Price = %d, Discounted Price = %d, Amount Paid = %d, Remaining Amount = %d, Quantity = %d", $time, product_id, price, total_price, discounted_price, amount_paid, remaining_amount, quantity);
    end
endmodule
