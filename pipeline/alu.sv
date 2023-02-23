module alu(reset, alu_decode, rda, rdx, result);
    input reset, alu_decode;
    input logic [31:0] rda, rdx;
    output logic [31:0] result;
    logic [31:0] temp;
    logic [31:0] pad;
    
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
        if (reset == 1'b0) begin
            case (alu_decode)
                AND: result = rda & rdx;
                OR: result = rda | rdx;
                ADD: result = rda + rdx;
                SUB: result = rda - rdx;
                XOR: result = rda ^ rdx;
                SLL: result = rda << rdx;
                SRL: result = $signed(rda) >>> rdx;
                SLT: result = $signed(rda) < $signed(rdx);
                SLTU: result = rda < rdx;
                SRA: begin
                    if (rda[31] == 0) begin
                        result = $signed(rda) >>> rdx;
                    end
                    else if (rda[31] == 1) begin
                        temp = (2**rdx) - 1;
                        pad = {1'b1{temp}};
                        result = $signed(rda) >>> rdx;
                        result[(31 - rdx + 1)+:31] = pad;
                    end
                end
            endcase
        end
    end
endmodule