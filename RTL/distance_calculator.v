`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Texas Tech University Department of Electrical and Computer Engineering
// Zachary Gottschalk
//
// Create Date: 09/27/2026
// Design Name: Localization Engine
// Module Name: distance_calculator
// Project Name: Ultrasonic_Object_Tracking System
//
// Description:
// Temporary distance input module for the localization engine.
//
// T1, T2, and T3 currently represent known distances in meters.
// These values will eventually be replaced by time-of-flight measurements
// from the three ultrasonic receivers.
//
// D1, D2, and D3 are passed to the localization/triangulation engine.
//////////////////////////////////////////////////////////////////////////////////

module distance_calculator(
    input  [31:0] T1,
    input  [31:0] T2,
    input  [31:0] T3,
    output [31:0] D1,
    output [31:0] D2,
    output [31:0] D3
    );

    // Temporary pass-through
    assign D1 = (32'd343 * T1) / (2 * 32'd100000000);
    assign D2 = (32'd343 * T2) / (2 * 32'd100000000);
    assign D3 = (32'd343 * T3) / (2 * 32'd100000000);

endmodule
