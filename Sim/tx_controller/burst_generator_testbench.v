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
module burst_generator_testbench();

    reg clk;
    reg reset;
    reg start;

    wire enable;
    wire done;

    burst_generator uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .enable(enable),
        .done(done)
    );
  
    always #5 clk = ~clk;

    initial begin

        clk   = 1'b0;
        reset = 1'b1;
        start = 1'b0;
        #20;

        reset = 1'b0;
        start = 1'b1;
        #10;
      
        start = 1'b0;
        #200000;
        $finish;

    end

endmodule
