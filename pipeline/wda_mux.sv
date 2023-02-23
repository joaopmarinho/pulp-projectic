module wda_mux(
    input logic reset,
    input logic mem_to_rgs,
    input logic [31:0] result,
    input logic [31:0] read_data,
    output logic [31:0] wda
);

    always_comb begin
        if (reset == 1'b0) begin
            if (mem_to_rgs) begin
                wda = read_data;
            end else begin
                wda = result;
            end
        end
    end

endmodule
