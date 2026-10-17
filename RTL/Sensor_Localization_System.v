`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Texas Tech University Department of Electrical and Computer Engineering
// Zachary Gottschalk
//
// Create Date: 09/27/2026
// Design Name: Localization Engine
// Module Name: Sensor_Localization_System
// Project Name: Ultrasonic_Object_Tracking System
//
// Description:
// Temporary top-level used to test the localization engine.
// T1, T2, and T3 are currently hard-coded test distances.
//////////////////////////////////////////////////////////////////////////////////

module Sensor_Localization_System(
    input clk,
    output [15:0] led
);

    wire [31:0] T1;
    wire [31:0] T2;
    wire [31:0] T3;

    wire [31:0] D1;
    wire [31:0] D2;
    wire [31:0] D3;

    // Temporary test distances in meters
    assign T1 = 32'd10;
    assign T2 = 32'd20;
    assign T3 = 32'd30;

    distance_calculator distance_calc (
        .T1(T1),
        .T2(T2),
        .T3(T3),
        .D1(D1),
        .D2(D2),
        .D3(D3)
    );

    // Temporary output so Vivado has something to implement.
    assign led = D1[15:0];

endmodule
