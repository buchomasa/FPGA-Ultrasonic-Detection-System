`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Texas Tech University Department of Electrical and Computer Engineering
// Zachary Gottschalk
//
// Create Date: 09/27/2026
// Design Name: Localization Engine
// Module Name: Coordinate Computer
// Project Name: Ultrasonic_Object_Tracking System
//
// Description:
// Computes object coordinates from three measured distances.
//
// Sensor locations (mm):
// S1 = (0,    0)
// S2 = (1500, 0)
// S3 = (3000, 0)
//
// All distances are assumed to be in millimeters.
//////////////////////////////////////////////////////////////////////////////////

module coordinate_computer(
    input  [31:0] D1,
    input  [31:0] D2,
    input  [31:0] D3,

    input         clk,
    input         rst,
    input         start,

    output [15:0] X_Coordinate,
    output [15:0] Y_Coordinate
);

    wire signed [63:0] D12;
    wire signed [63:0] D22;
    wire signed [63:0] D32;

    assign D12 = D1 * D1;
    assign D22 = D2 * D2;
    assign D32 = D3 * D3;

    wire signed [31:0] x1;
    wire signed [31:0] x2;
    wire signed [31:0] x3;
    wire signed [31:0] x_avg;

    assign x1 = (D12 - D22 + 64'sd2250000) / 3000;
    assign x2 = (D22 - D32 + 64'sd6750000) / 3000;
    assign x3 = (D12 - D32 + 64'sd9000000) / 6000;
    assign x_avg = (x1 + x2 + x3) / 3;
    assign X_Coordinate = x_avg[15:0];
    
    wire signed [63:0] X_Coordinate2;
    assign X_Coordinate2 =
        $signed(x_avg) * $signed(x_avg);

    wire signed [63:0] y1;
    wire signed [63:0] y2;
    wire signed [63:0] y3;

    assign y1 =
        D12 - X_Coordinate2;
    assign y2 =
        D22 -
        (($signed(x_avg) - 1500) *
         ($signed(x_avg) - 1500));
    assign y3 =
        D32 -
        (($signed(x_avg) - 3000) *
         ($signed(x_avg) - 3000));

    wire signed [63:0] y_sum;
    assign y_sum = y1 + y2 + y3;
    wire [31:0] y_radicand;
    assign y_radicand =
        (y_sum > 0) ?
        (y_sum / 3) :
        32'd0;

    wire [15:0] y_root;
    wire        y_done;
    
    square_root SQRT_Y(
        .clk      (clk),
        .rst      (rst),
        .start    (start),
        .radicand (y_radicand),
