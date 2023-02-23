module alu_mux(
    input logic reset,
    input logic alu_src,
    input logic [31:0] im_gen,
    input logic [31:0] rdb,
    output logic [31:0] rdx
);

    always_comb begin
        if (reset == 1'b0) begin
            if (alu_src) begin
                rdx = im_gen;
            end else begin
                rdx = rdb;
            end
        end
    end

endmodule
