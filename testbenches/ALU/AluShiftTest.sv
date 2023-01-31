module AluShiftTest;
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
        
        operator_i = ALU_SRA;   //shift right aritmético
        operand_a_i = 32'd4;    //valor inicial em binário: 100
        operand_b_i = 32'd1;    //bit offset: 1 bit 
        //resultado = 10
        #10
        
        operator_i = ALU_SRL;   //shift right lógico
        operand_a_i = 32'd4;    //valor inicial em binário: 100
        operand_b_i = 32'd1;    //bit offset: 1 bit 
        //resultado = 10
        #10
        operator_i = ALU_ROR;  //rotate right, os bits no final são transferidos para o começo a depender do offset 
        operand_a_i = 32'd5;    
        operand_b_i = 32'd1;    

        #10
        operator_i = ALU_SLL;   // shift left lógico
        operand_a_i = 32'd5;    // valor inicial: 101
        operand_b_i = 32'd2;   //bit offset: 10

    end
endmodule: AluShiftTest
