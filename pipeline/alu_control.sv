module alu_control(
    input logic reset,
    input logic [31:0] instruction,
    input logic [2:0] alu_op,
    output logic [3:0] alu_decode
);

    // Define constants for the ALU operations
    localparam ADD = 4'b0000;
    localparam SUB = 4'b1000;
    localparam SLL = 4'b0001;
    localparam SRL = 4'b0010;
    localparam SRA = 4'b1010;
    localparam AND = 4'b0011;
    localparam OR = 4'b0100;
    localparam XOR = 4'b0101;
    localparam SLT = 4'b0110;
    localparam SLTU = 4'b0111;

    always_comb begin
        if (~reset == 1'b1) begin
            case (alu_op)
                3'b010: begin
                    case (instruction[31:25])
                        7'b0000000: begin
                            case (instruction[14:12])
                                4'b0000: alu_decode = ADD;
                                4'b0001: alu_decode = SLL;
                                4'b0010: alu_decode = SLT;
                                4'b0011: alu_decode = SLTU;
                                4'b0100: alu_decode = XOR;
                                4'b0101: alu_decode = SRL;
                                4'b0110: alu_decode = OR;
                                4'b0111: alu_decode = AND;
                                default: alu_decode = 4'b0000;
                            endcase
                        end
                        7'b1000000: begin
                            case (instruction[14:12])
                                4'b0000: alu_decode = SUB;
                                4'b0101: alu_decode = SRA;
                                default: alu_decode = 4'b0000;
                            endcase
                        end
                        default: alu_decode = 4'b0000;
                    endcase
                end
                3'b000: alu_decode = ADD;
                3'b111: begin
                    if (instruction[14:12] == 4'b0000)
                        alu_decode = XOR;
                    else
                        alu_decode = 4'b0000;
                end
                default: alu_decode = 4'b0000;
            endcase
        end
    end

endmodule
