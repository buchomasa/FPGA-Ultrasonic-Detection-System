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
// Block for square root algorithm
//////////////////////////////////////////////////////////////////////////////////

module csm(
    input a,
    input b,
    input bi,
    input os,
    output d,
    output bo
    );
    wire d_prime;
    assign d_prime = a ^ b ^ bi;
    assign d = (os & a) | (~os & d_prime);
    assign bo = (~a & b) | (bi & ~(a ^ b));
endmodule
