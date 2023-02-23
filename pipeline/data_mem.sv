module data_mem(reset, clk, result, mem_wr, mem_rd, rdb, read_data);

  parameter CPU_BITS = 32;

  input reset, clk, mem_wr, mem_rd;
  input [31:0] result, rdb;
  output reg [31:0] read_data;

  reg [31:0] data_ram [0:127];
  integer i;
  initial begin
    $readmemh("data.mif", data_ram);
  end

  always @(posedge clk) begin
    if (reset == 1'b0) begin
      if (mem_wr) begin
        data_ram[result] <= rdb;
      end
      else if (mem_rd) begin
        read_data <= data_ram[result];
      end
    end
  end

endmodule
