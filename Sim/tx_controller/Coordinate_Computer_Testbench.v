`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2026 10:08:27 AM
// Design Name: 
// Module Name: coordinate_computer_testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module coordinate_computer_testbench;

    reg         clk;
    reg         rst;
    reg         start;

    reg  [31:0] D1;
    reg  [31:0] D2;
    reg  [31:0] D3;

    wire [15:0] X_Coordinate;
    wire [15:0] Y_Coordinate;

    coordinate_computer DUT(
        .D1(D1),
        .D2(D2),
        .D3(D3),

        .clk(clk),
        .rst(rst),
        .start(start),

        .X_Coordinate(X_Coordinate),
        .Y_Coordinate(Y_Coordinate)
    );

    //--------------------------------------------------
    // 100 MHz Clock
    //--------------------------------------------------
    always #5 clk = ~clk;

    //--------------------------------------------------
    // Simulation
    //--------------------------------------------------
    initial
    begin

        clk   = 0;
        rst   = 1;
        start = 0;

        D1 = 0;
        D2 = 0;
        D3 = 0;

        //--------------------------------------------------
        // Reset
        //--------------------------------------------------
        #20;
        rst = 0;

        //--------------------------------------------------
        // Test Point:
        // (1500,1000)
        //
        // D1 = sqrt(1500^2 + 1000^2) ≈ 1803
        // D2 = 1000
        // D3 = sqrt(1500^2 + 1000^2) ≈ 1803
        //--------------------------------------------------
        D1 = 32'd1803;
        D2 = 32'd1000;
        D3 = 32'd1803;

        #20;
        start = 1;

        #10;
        start = 0;

        //--------------------------------------------------
        // Wait for square-root engine
        //--------------------------------------------------
        #500;

        $display("--------------------------------");
        $display("D1 = %d", D1);
        $display("D2 = %d", D2);
        $display("D3 = %d", D3);
        $display("--------------------------------");
        $display("Computed X = %d", X_Coordinate);
        $display("Computed Y = %d", Y_Coordinate);
        $display("--------------------------------");

        if ((X_Coordinate > 1490) &&
            (X_Coordinate < 1510) &&
            (Y_Coordinate > 990)  &&
            (Y_Coordinate < 1010))
        begin
            $display("PASS");
        end
        else
        begin
            $display("FAIL");
        end

        #50;
        $finish;

    end

    //--------------------------------------------------
    // Useful Debug Output
    //--------------------------------------------------
    always @(posedge clk)
    begin
        $display(
            "t=%0t  X=%0d  Y=%0d",
            $time,
            X_Coordinate,
            Y_Coordinate
        );
    end
endmodule
