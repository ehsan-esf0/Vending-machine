module FSM (
    input [2:0] product_id,
    input [7:0] decoder_out,
    input clk,
    input reset,
    output reg [1:0] state
);


    parameter IDLE = 2'b00,
              PRODUCT_SELECTED = 2'b01,
              PAYMENT = 2'b10,
              DISPENSE = 2'b11;
              
    always @ (posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE; 
        else begin
            case (state)
                IDLE: if (decoder_out != 8'b00000000) state <= PRODUCT_SELECTED;
                PRODUCT_SELECTED: state <= PAYMENT;
                PAYMENT: state <= DISPENSE;
                DISPENSE: state <= IDLE;
                default: state <= IDLE;
            endcase
        end
    end
endmodule
