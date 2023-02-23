module jmp_adder(
    input reset,
    input [31:0] read_addr,
    input [31:0] shl,
    output reg [31:0] jmp_addr
);

    always_comb begin
        if (reset == 1'b0) begin
            jmp_addr = read_addr + shl;
        end
    end

endmodule
