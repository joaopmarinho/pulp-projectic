module control(
    input logic reset,
    input logic [5:0] opcode,
    output logic brnch,
    output logic mem_rd,
    output logic mem_to_rgs,
    output logic [2:0] alu_op,
    output logic mem_wr,
    output logic alu_src,
    output logic reg_wr
);


// RTYPE: Arithmetic and logic operations on registers

// ADD, SUB, AND, OR, XOR, NOR, SLT, SLL, SRL, SRA, JR
// ITYPE: Arithmetic and memory load operations based on data from instruction and register

// ADDI, ANDI, ORI, XORI, SLTI, LW, SW, BEQ, BNE
// STYPE: Store data operation based on data from instruction and register

// SB, SH, SW
// JTYPE: Increment PC based on Jump or branch instruction

// J, JAL, JR, JALR, BEQ, BNE, BGTZ, BLEZ, BGEZ, BLTZ

    localparam RTYPE = 8'b00110011;
    localparam ITYPE = 8'b00000011;
    localparam STYPE = 8'b00100011;
    localparam JTYPE = 8'b01100011;

    always_comb begin
        if (reset == 1'b0) begin
            case (opcode)
                RTYPE: begin
                    alu_src = 1'b0;
                    mem_to_rgs = 1'b0;
                    reg_wr = 1'b1;
                    mem_rd = 1'b0;
                    mem_wr = 1'b0;
                    brnch = 1'b0;
                    alu_op = 3'b010;
                end
                ITYPE: begin
                    alu_src = 1'b1;
                    mem_to_rgs = 1'b1;
                    reg_wr = 1'b1;
                    mem_rd = 1'b1;
                    mem_wr = 1'b0;
                    brnch = 1'b0;
                    alu_op = 3'b000;
                end
                STYPE: begin
                    alu_src = 1'b1;
                    mem_to_rgs = 1'b0;
                    reg_wr = 1'b0;
                    mem_rd = 1'b0;
                    mem_wr = 1'b1;
                    brnch = 1'b0;
                    alu_op = 3'b000;
                end
                JTYPE: begin
                    alu_src = 1'b0;
                    mem_to_rgs = 1'b0;
                    reg_wr = 1'b0;
                    mem_rd = 1'b0;
                    mem_wr = 1'b0;
                    brnch = 1'b1;
                    alu_op = 3'b111;
                end
                default: begin
                    alu_src = 1'b0;
                    mem_to_rgs = 1'b0;
                    reg_wr = 1'b0;
                    mem_rd = 1'b0;
                    mem_wr = 1'b0;
                    brnch = 1'b0;
                    alu_op = 3'b000;
                end
            endcase
        end
    end

endmodule
