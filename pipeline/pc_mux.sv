module pc_mux(
    input logic reset,
    input logic [31:0] pc_addr,
    input logic [31:0] jmp_addr,
    input logic pc_sel,
    output logic [31:0] pc
);

    always_comb begin
        if (reset == 1'b0) begin
            if (pc_sel) begin
                pc = jmp_addr;
            end else begin
                pc = pc_addr;
            end
        end
    end

endmodule
