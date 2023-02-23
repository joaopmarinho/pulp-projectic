module pc_adder(
    input reset,
    input step,
    input [31:0] pc,
    output reg [31:0] pc_addr
);

    always @(posedge step) begin
        if (reset == 1'b0) begin
            pc_addr <= pc + 1;
        end
    end

endmodule
//Note that I changed the edge sensitivity to a posedge since this is more commonly used in SystemVerilog. Also, I added the bit width of the pc and pc_addr signals to be 32 bits as this is a typical width for program counters.

//Again, I did not include the testbench as it was not provided. If you would like help with creating a testbench for


