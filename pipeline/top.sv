module top();
    //our testbench
    // Declare signals
    logic clk;
    bit reset;

    // Instantiate clock and CPU
    clock cl(clk);
    cpu_top cpu(clk, reset);

    // Stimulus process
    initial begin
        reset = 0;
        clk <= 0;
        #5;
        reset = 1'b1;
        #5;
        reset = 1'b0;
        #1000;
        $finish;
    end

endmodule