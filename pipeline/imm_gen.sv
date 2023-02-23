module imm_gen(
  input reset,
  input [31:0] instruction,
  output reg [31:0] im_gen
);
  reg [19:0] pad;
  reg [19:0] temp;
  localparam RTYPE = 8'b00110011;
  localparam ITYPE = 8'b00000011;
  localparam STYPE = 8'b00100011;
  localparam JTYPE = 8'b01100011;

  always_comb begin
    if (reset == 1'b0) begin
      if (instruction[7:0] == ITYPE) begin
        im_gen[12+:20] = instruction[32+:20];
      end
      else if (instruction[7:0] == STYPE) begin
        im_gen[12+:7] = instruction[32+:25];
        im_gen[5+:7] = instruction[12+:7];
      end
      else if (instruction[7:0] == JTYPE) begin
        im_gen[12] = instruction[31];
        im_gen[11+:7] = instruction[31+:25];
        im_gen[11] = instruction[7];
        im_gen[5+:4] = instruction[12+:9];
        im_gen[0] = 0;
      end

      if (instruction[31] == 0) begin
        pad = 20'b0;
        im_gen[31 -: 20] = pad;
      end
      else begin
        temp = (2**20) - 1;
        pad = temp;
        im_gen[31 -: 20] = pad;
      end
    end
  end
  
endmodule
