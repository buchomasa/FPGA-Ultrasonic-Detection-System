`timescale 1ns/1ps

module square_root_testbench;

    reg         clk;
    reg         rst;
    reg         start;
    reg  [31:0] radicand;

    wire [15:0] root;
    wire        done;

    square_root DUT (
        .clk(clk),
        .rst(rst),
        .start(start),
        .radicand(radicand),
        .root(root),
        .done(done)
    );

    // 100 MHz clock
    always #5 clk = ~clk;

    initial
    begin
        clk      = 0;
        rst      = 1;
        start    = 0;
        radicand = 0;

        #20;
        rst = 0;

        //----------------------------------------
        // Test 1 : sqrt(25)=5
        //----------------------------------------
        radicand = 32'd25;

        #10;
        start = 1;

        #10;
        start = 0;

        wait(done);

        $display("Input=%d Root=%d",radicand,root);

        if(root == 16'd5)
            $display("PASS");
        else
            $display("FAIL");

        //----------------------------------------
        // Test 2 : sqrt(625)=25
        //----------------------------------------
        #20;

        rst = 1;
        #10;
        rst = 0;

        radicand = 32'd625;

        #10;
        start = 1;

        #10;
        start = 0;

        wait(done);

        $display("Input=%d Root=%d",radicand,root);

        if(root == 16'd25)
            $display("PASS");
        else
            $display("FAIL");

        //----------------------------------------
        // Test 3 : sqrt(1000000)=1000
        //----------------------------------------
        #20;

        rst = 1;
        #10;
        rst = 0;

        radicand = 32'd1000000;

        #10;
        start = 1;

        #10;
        start = 0;

        wait(done);

        $display("Input=%d Root=%d",radicand,root);

        if(root == 16'd1000)
            $display("PASS");
        else
            $display("FAIL");

        //----------------------------------------
        // Test 4 : max perfect square
        //----------------------------------------
        #20;

        rst = 1;
        #10;
        rst = 0;

        radicand = 32'd4294836225; // 65535^2

        #10;
        start = 1;

        #10;
        start = 0;

        wait(done);

        $display("Input=%d Root=%d",radicand,root);

        if(root == 16'd65535)
            $display("PASS");
        else
            $display("FAIL");

        $finish;

    end

endmodule
