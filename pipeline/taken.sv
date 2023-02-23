module taken(
    input logic [31:0] result,
    input logic brnch,
    output logic pc_sel
);

    always_comb begin
        if (!result && brnch) begin
            pc_sel = 1'b1;
        end else begin
            pc_sel = 1'b0;
        end
    end

endmodule
