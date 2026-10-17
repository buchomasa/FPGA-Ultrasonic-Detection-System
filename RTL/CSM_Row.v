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
// Row of CSMs that will be repetitively used to compute a square root 
//////////////////////////////////////////////////////////////////////////////////


module csm_row(
    input  [31:0] a,
    input  [31:0] b,
    input         bi,
    input         os,
    output [31:0] d,
    output        bo
);
    wire [32:0] borrow;
    assign borrow[0] = bi;
    assign bo = borrow[32];
    genvar i;
    generate
        for(i = 0; i < 32; i = i + 1)
        begin : CSM_STAGE

            csm U (
                .a  (a[i]),
                .b  (b[i]),
                .bi (borrow[i]),
                .os (os),

                .d  (d[i]),
                .bo (borrow[i+1])
            );
        end
    endgenerate
endmodule
