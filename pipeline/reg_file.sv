module reg_file(
    input logic reset,
    input logic clk,
    input logic [4:0] ra,
    input logic [4:0] rb,
    input logic [4:0] wa,
    input logic [31:0] wda,
    input logic reg_wr,
    output logic [31:0] rda,
    output logic [31:0] rdb
);

    logic [31:0] registers [0:31];

    always_comb begin
        if (reset == 1'b0) begin
            if (ra != 0) begin
                rda = registers[ra];
            end else begin
                rda = 32'd0;
            end
            if (rb != 0) begin
                rdb = registers[rb];
            end else begin
                rdb = 32'd0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (reset == 1'b0) begin
            if (reg_wr && (wa != 0)) begin
                registers[wa] <= wda;
            end
        end
    end

endmodule
//In SystemVerilog, we declare the module inputs and outputs in the module header. Inside the module, we can declare an array of registers using the logic [31:0] registers [0:31] syntax. We can initialize the register values using an initial block. We use the always_comb block to describe combinational logic that depends on the inputs. We can use the != operator to compare the input values to zero, as zero is a valid index in Python but not in SystemVerilog. We


