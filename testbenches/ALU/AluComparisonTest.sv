module AluComparisonTest;
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
        
        operator_i = ALU_LTS; //a < b, ALU_LTS, ALU_SLTS, ALU_LTU, ALU_SLTU usam a mesma lógica
        operand_a_i = 32'd9;
        operand_b_i = 32'd10;

        #5
        operand_a_i = 32'd10;
        operand_b_i = 32'd9;
        
        #5
        operand_a_i = 32'd10;
        operand_b_i = 32'd10;

        #5
        operator_i = ALU_EQ; //a = b
        operand_a_i = 32'd9;
        operand_b_i = 32'd10;
        
        #5
        operand_a_i = 32'd10;
        operand_b_i = 32'd10;

        #5
        operator_i = ALU_NE; //a != b
        operand_a_i = 32'd10;
        operand_b_i = 32'd9;
        
        #5
        operand_a_i = 32'd10;
        operand_b_i = 32'd10;

        #5
        operator_i = ALU_GTS; //a > b, ALU_GTS, ALU_GTU, mesma lógica
        operand_a_i = 32'd10;
        operand_b_i = 32'd9;
        
        #5
        operand_a_i = 32'd10;
        operand_b_i = 32'd10;

        #5
        operator_i = ALU_GES;//a >= b, ALU_GES, ALU_GEU
        operand_a_i = 32'd10;
        operand_b_i = 32'd10;

        #5
        operand_a_i = 32'd10;
        operand_b_i = 32'd8;

        //a <= b, ALU_SLETS, ALU_SLETU, ALU_LES, ALU_LEU
        #5
        operator_i = ALU_LES;//a <= b, ALU_GES, ALU_GEU
        operand_a_i = 32'd8;
        operand_b_i = 32'd10;

        #5
        operand_a_i = 32'd10;
        operand_b_i = 32'd10;
    end
endmodule: AluComparisonTest
