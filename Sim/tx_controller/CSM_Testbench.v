`timescale 1ns/1ps

module csm_testbench;

    reg a;
    reg b;
    reg bi;
    reg os;

    wire d;
    wire bo;

    csm DUT(
        .a(a),
        .b(b),
        .bi(bi),
        .os(os),
        .d(d),
        .bo(bo)
    );

    initial begin

        $display("a b bi os | d bo");
        $display("----------------");

        // Test 1
        a  = 0;
        b  = 0;
        bi = 0;
        os = 0;
        #10;
        $display("%b %b %b %b | %b %b",a,b,bi,os,d,bo);

        // Test 2
        a  = 1;
        b  = 0;
        bi = 0;
        os = 0;
        #10;
        $display("%b %b %b %b | %b %b",a,b,bi,os,d,bo);

        // Test 3
        a  = 1;
        b  = 1;
        bi = 0;
        os = 0;
        #10;
        $display("%b %b %b %b | %b %b",a,b,bi,os,d,bo);

        // Test 4
        a  = 0;
        b  = 1;
        bi = 0;
        os = 0;
        #10;
        $display("%b %b %b %b | %b %b",a,b,bi,os,d,bo);

        // Test 5
        a  = 0;
        b  = 1;
        bi = 1;
        os = 0;
        #10;
        $display("%b %b %b %b | %b %b",a,b,bi,os,d,bo);

        // Test OS = 1
        a  = 1;
        b  = 0;
        bi = 0;
        os = 1;
        #10;
        $display("%b %b %b %b | %b %b",a,b,bi,os,d,bo);

        $finish;
