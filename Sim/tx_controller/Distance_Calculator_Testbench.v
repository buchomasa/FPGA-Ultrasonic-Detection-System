`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Texas Tech University Department of Electrical and Computer Engineering
// Zachary Gottschalk
//
// Create Date: 09/27/2026
// Design Name: Localization Engine
// Module Name: distance_calculator_tb
// Project Name: Ultrasonic_Object_Tracking_System
//
// Description:
// Testbench for the distance calculator.
// T1, T2, and T3 represent echo times measured in
// 100 MHz clock cycles.
//
// Expected outputs are distances in meters.
//////////////////////////////////////////////////////////////////////////////////

module distance_calculator_tb;

    reg  [31:0] T1;
    reg  [31:0] T2;
    reg  [31:0] T3;

    wire [31:0] D1;
    wire [31:0] D2;
    wire [31:0] D3;

    distance_calculator uut (
        .T1(T1),
        .T2(T2),
        .T3(T3),
        .D1(D1),
        .D2(D2),
        .D3(D3)
    );

    initial begin

        //--------------------------------------------------
        // Test Case 1
        // Object distances:
        // D1 ≈ 1 m
        // D2 ≈ 2 m
        // D3 ≈ 3 m
        //--------------------------------------------------
        T1 = 32'd583090;
        T2 = 32'd1166180;
        T3 = 32'd1749271;

        #10;

        $display("---------------------------------------");
        $display("Test Case 1");
        $display("Expected: D1=1, D2=2, D3=3");
        $display("Measured: D1=%d, D2=%d, D3=%d",
                  D1, D2, D3);

        //--------------------------------------------------
        // Test Case 2
        // Object distances:
        // D1 ≈ 4 m
        // D2 ≈ 5 m
        // D3 ≈ 6 m
        //--------------------------------------------------
        T1 = 32'd2332361;
        T2 = 32'd2915452;
        T3 = 32'd3498542;

        #10;

        $display("---------------------------------------");
        $display("Test Case 2");
        $display("Expected: D1=4, D2=5, D3=6");
        $display("Measured: D1=%d, D2=%d, D3=%d",
                  D1, D2, D3);

        //--------------------------------------------------
        // Test Case 3
        // Object distances:
        // D1 ≈ 7 m
        // D2 ≈ 8 m
        // D3 ≈ 9 m
        //--------------------------------------------------
        T1 = 32'd4081633;
        T2 = 32'd4664723;
        T3 = 32'd5247813;

        #10;

        $display("---------------------------------------");
        $display("Test Case 3");
        $display("Expected: D1=7, D2=8, D3=9");
        $display("Measured: D1=%d, D2=%d, D3=%d",
                  D1, D2, D3);

        $display("---------------------------------------");

        $finish;
    end

endmodule
