module AluSubTest;
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
        $monitor($time," - sel = %b: a = %d | b = %d | res = (%d) %b", operator_i, operand_a_i, operand_b_i, result_o, result_o);

        // Valores iniciais
        enable_i = 1;
        operand_c_i = 32'd0;
        vector_mode_i = 2'd0;
        bmask_a_i = 5'd0;
        bmask_b_i = 5'd0;
        imm_vec_ext_i = 2'd0;
        is_clpx_i = 1;
        is_subrot_i = 0;
        clpx_shift_i= 2'd0;
        ex_ready_i = 1;
        // Quais dessas inputs influenciam no resultado ??
        // teste com resultado negativo dando pau

        operator_i = ALU_SUB;
        operand_a_i = 32'd0;
        operand_b_i = 32'd0;

        // Após 10, 'b' muda para 10. 'a' muda para 1
        #10
        operand_b_i = 32'd10;
        operand_a_i = 32'd1;

        // Após 10, 'b' muda para 5. 'a' muda para 25
        #10
        operand_b_i = 32'd5;
        operand_a_i = 32'd25;
    end
endmodule: AluSubTest
