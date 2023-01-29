module AluAndTest;
    import cv32e40p_pkg::*;

    logic           [31:0]  result_o;
    alu_opcode_e            operator_i;
    logic           [31:0]  operand_a_i;
    logic           [31:0]  operand_b_i;

    // I/O não usados:
    logic                   clk;
    logic                   rst_n;
    logic                   enable_i;
    logic           [31:0]  operand_c_i;
    logic           [ 1:0]  vector_mode_i;
    logic           [ 4:0]  bmask_a_i;
    logic           [ 4:0]  bmask_b_i;
    logic           [ 1:0]  imm_vec_ext_i;
    logic                   is_clpx_i;
    logic                   is_subrot_i;
    logic           [ 1:0]  clpx_shift_i;
    logic                   comparison_result_o;
    logic                   ready_o;
    logic                   ex_ready_i;
    
    cv32e40p_alu dut(.*);

    initial begin
        $monitor($time," - sel = %b: a = %b | b = %b | res = %b", operator_i, operand_a_i, operand_b_i, result_o);

        // Valores iniciais
        operator_i = ALU_AND;
        operand_a_i = 32'd0;
        operand_b_i = 32'd0;

        // Após 10, 'b' muda para 1. 'a' continua 0 e 'operator_i' continua ALU_AND
        #10
        operand_b_i = 32'd1;
        
        // Após 10, 'a' muda para 1. 'b' continua 1 e 'operator_i' continua ALU_AND
        #10
        operand_a_i = 32'd1;
    end
endmodule: AluAndTest
