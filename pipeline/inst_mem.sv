module inst_mem(reset, read_addr, instruction, ra, rb, wa, opcode);
    parameter CPU_BITS = 32;
    input reset;
    input [6:0] read_addr;
    output reg [31:0] instruction;
    output reg [4:0] ra, rb, wa;
    output reg [7:0] opcode;
    reg [31:0] inst_ram [0:127];

    localparam RTYPE = 8'b00110011;
    localparam ITYPE = 8'b00000011;
    localparam STYPE = 8'b00100011;
    localparam JTYPE = 8'b01100011;

    initial begin
        $readmemh("instruction.mif", inst_ram);
    end

    always_comb begin
        if (reset == 1'b0) begin
            instruction = inst_ram[read_addr];

            case (inst_ram[read_addr][7:0])
                RTYPE: begin
                    ra = inst_ram[read_addr][20:16];
                    rb = inst_ram[read_addr][25:21];
                    opcode = inst_ram[read_addr][7:0];
                    wa = inst_ram[read_addr][12:8];
                end
                ITYPE: begin
                    ra = inst_ram[read_addr][20:16];
                    opcode = inst_ram[read_addr][7:0];
                    wa = inst_ram[read_addr][12:8];
                end
                STYPE: begin
                    ra = inst_ram[read_addr][20:16];
                    rb = inst_ram[read_addr][25:21];
                    opcode = inst_ram[read_addr][7:0];
                    wa = inst_ram[read_addr][25:21];
                end
                JTYPE: begin
                    ra = inst_ram[read_addr][20:16];
                    rb = inst_ram[read_addr][25:21];
                    opcode = inst_ram[read_addr][7:0];
                end
                default: begin
                    ra = 5'b0;
                    rb = 5'b0;
                    opcode = 8'b0;
                    wa = 5'b0;
                end
            endcase
        end
    end

endmodule
