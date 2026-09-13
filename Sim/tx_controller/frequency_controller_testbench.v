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

module frequency_generator_testbench();
reg clk, reset, enable;
wire tx;

frequency_generator uut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .tx(tx)
);

always #5 clk = ~clk;
initial begin
    clk = 1'b0;
    reset = 1'b1;
    enable = 1'b0;
    
    #20;
    reset = 1'b0;
    enable = 1'b1;
    
    #200000;
    enable = 1'b0;
    #100;
    
    $finish;
end
endmodule
