`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Texas Tech University Department of Electrical and Computer Engineering
// Zachary Gottschalk
//
// Create Date: 09/27/2026
// Design Name: Localization Engine
// Module Name: square_root
// Project Name: Ultrasonic_Object_Tracking System
//
// Description:
// Square root calculator using digit-by-digit algorithm
// Will be utilized to compute object coordinates.
//////////////////////////////////////////////////////////////////////////////////

module square_root(
    input             clk,
    input             rst,
    input             start,
    input      [31:0] radicand,

    output reg [15:0] root,
    output reg        done
);

    reg  [31:0] remainder;
    reg  [31:0] rad_shift;
    reg  [4:0]  count;

    // Bring down next two bits
    wire [31:0] rem_next;

    // Trial divisor
    wire [31:0] trial_divisor;

    // Subtractor outputs
    wire [31:0] trial_result;
    wire        trial_borrow;

    assign rem_next      = {remainder[29:0], rad_shift[31:30]};
    assign trial_divisor = {14'd0, root, 2'b01};

    csm_row subtractor (
        .a  (rem_next),
        .b  (trial_divisor),
        .bi (1'b0),
        .os (1'b0),
        .d  (trial_result),
        .bo (trial_borrow)
    );

    always @(posedge clk or posedge rst)
    begin

        if (rst)
        begin
            root      <= 16'd0;
            remainder <= 32'd0;
            rad_shift <= 32'd0;
            count     <= 5'd0;
            done      <= 1'b0;
        end

        else if (start)
        begin
            root      <= 16'd0;
            remainder <= 32'd0;
            rad_shift <= radicand;
            count     <= 5'd16;
            done      <= 1'b0;
        end

        else if (count != 0)
        begin

            // Consume next two bits
            rad_shift <= {rad_shift[29:0], 2'b00};

            if (!trial_borrow) // If the trial subtraction succeeds, keep the result and append a 1 to the root
            begin
                remainder <= trial_result;
                root      <= {root[14:0], 1'b1};
            end
            else
            begin // If the trial subtraction fails, restore the remainder and append a 0 to the root
                remainder <= rem_next;
                root      <= {root[14:0], 1'b0};
            end

            count <= count - 1;

            if (count == 1)
                done <= 1'b1;
        end
    end
endmodule
