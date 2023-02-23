module cpu_top (
  input logic clk,
  input logic reset
);

  parameter CPU_REGS = 32;
  parameter CPU_BITS = 32;
  parameter CPU_ALUW = 10;
  logic [2:0] i;
  logic [2:0] idle;
  logic [63:0] infinity;

  logic [CPU_BITS-1:0] ra, rb, wa;
  logic [CPU_BITS-1:0] wda, rda, rdb, rdx;
  logic [CPU_ALUW-1:0] alu_op;
  logic brnch, mem_rd, mem_to_rgs, mem_wr, alu_src, reg_wr;
  logic [6:0] opcode;
  logic [CPU_BITS-1:0] result, read_data, pc, shl;
  logic pc_sel;
  logic [CPU_BITS-1:0] im_gen;
  logic [3:0] alu_decode;

  logic [0:0] step;

  logic [CPU_BITS-1:0] read_addr, instruction, pc_addr, jmp_addr;

  control cont(reset, opcode, brnch, mem_rd, mem_to_rgs, alu_op, mem_wr, alu_src, reg_wr);
  data_mem dmem(reset, clk, result, mem_wr, mem_rd, rdb, read_data);
  inst_mem imem(reset, read_addr, instruction, ra, rb, wa, opcode);
  alu alux(reset, alu_decode, rda, rdx, result);
  reg_file regf(reset, clk, ra, rb, wa, wda, reg_wr, rda, rdb);
  pc_adder padr(reset, step, pc, pc_addr);
  jmp_adder jadr(reset, read_addr, shl, jmp_addr);
  pc_mux pcmx(reset, pc, pc_addr, jmp_addr, pc_sel);
  alu_mux almx(reset, im_gen, rdb, rdx, alu_src);
  wda_mux wdmx(reset, wda, mem_to_rgs, result, read_data);
  alu_control aluc(reset, instruction, alu_op, alu_decode);
  imm_gen imgn(reset, instruction, im_gen);
  pc_assign nxpc(reset, read_addr, pc);
  taken tken(result, brnch, pc_sel);

  always_ff @(posedge step) begin
    if (pc == 0) begin
      pc <= pc + 1;
    end
  end

  always @(posedge clk) begin
    idle = 7;
    repeat (infinity) begin
      for (i = 0; i < idle; i = i + 1) begin
        @(posedge clk);
      end
      if (reset == 1'b0) begin
        step <= ~step;
        idle = 3;
      end
    end
  end

endmodule
