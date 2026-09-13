`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Texas Tech University Department of Electrical and Computer Engineering 
// Zachary Gottschalk 
// 
// Create Date: 09/13/2026 12:16:33 PM
// Design Name: Frequency Generator
// Module Name: frequency_generator
// Project Name: Tx_Controller
//////////////////////////////////////////////////////////////////////////////////


module frequency_generator(
    input clk,
    input reset,
    input enable,
    output reg tx
    );

    reg [10:0] counter;

    always @(posedge clk) begin
        if (reset) begin
            counter <= 11'd0;
            tx      <= 1'b0;
        end
        else if (enable) begin
            if (counter == 11'd1249) begin
                counter <= 11'd0;
                tx      <= ~tx;
            end
            else begin
                counter <= counter + 1'b1;
            end
        end
        else begin
            counter <= 11'd0;
            tx      <= 1'b0;
        end
    end

endmodule
