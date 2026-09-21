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


`timescale 1ns / 1ps

module burst_generator(
    input clk,
    input reset,
    input start,
    output reg enable,
    output reg done
    );

    reg [14:0] count;
    reg busy;

    always @(posedge clk) begin

        if (reset) begin
            count  <= 15'd0;
            enable <= 1'b0;
            done   <= 1'b0;
            busy   <= 1'b0;
        end

        else begin
            done <= 1'b0;

            if (start && !busy) begin
                count  <= 15'd0;
                enable <= 1'b1;
                busy   <= 1'b1;
            end
            else if (busy) begin

                if (count == 15'd19999) begin
                    count  <= 15'd0;
                    enable <= 1'b0;
                    done   <= 1'b1;
                    busy   <= 1'b0;
                end

                else begin
                    count <= count + 1'b1;
                end
            end
            else begin
                enable <= 1'b0;
            end
        end
    end

endmodule
