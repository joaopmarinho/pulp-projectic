module coreTest;
    import cv32e40p_pkg::*;
    import cv32e40p_apu_core_pkg::*;

        // Clock and Reset
        logic       clk_i;
        logic       rst_ni;
        logic       enable_i;
        logic       pulp_clock_en_i;    // PULP clock enable (only used if PULP_CLUSTER = 1)
        logic       scan_cg_en_i;       // Enable all clock gates for testing
        
        // Core ID, Cluster ID, debug mode halt address and boot address are considered more or less static
        logic [31:0] boot_addr_i;
        logic [31:0] mtvec_addr_i;
        logic [31:0] dm_halt_addr_i;
        logic [31:0] hart_id_i;
        logic [31:0] dm_exception_addr_i;
        
        // Instruction memory interface
        logic        instr_req_o;
        logic        instr_gnt_i;
        logic        instr_rvalid_i;
        logic [31:0] instr_addr_o;
        logic [31:0] instr_rdata_i;
        

        // Data memory interface
        logic        data_req_o;
        logic        data_gnt_i;
        logic        data_rvalid_i;
        logic        data_we_o;
        logic [ 3:0] data_be_o;
        logic [31:0] data_addr_o;
        logic [31:0] data_wdata_o;
        logic [31:0] data_rdata_i;

            // apu-interconnect
        // handshake signals
        logic                              apu_req_o;
        logic                              apu_gnt_i;
        // request channel
        logic [   APU_NARGS_CPU-1:0][31:0] apu_operands_o;
        logic [     APU_WOP_CPU-1:0]       apu_op_o;
        logic [APU_NDSFLAGS_CPU-1:0]       apu_flags_o;
        // response channel
        logic                              apu_rvalid_i;
        logic [                31:0]       apu_result_i;
        logic [APU_NUSFLAGS_CPU-1:0]       apu_flags_i;

        // Interrupt inputs
        logic [31:0] irq_i;  // CLINT interrupts + CLINT extension interrupts
        logic        irq_ack_o;
        logic [ 4:0] irq_id_o;

        // Debug Interface
        logic debug_req_i;
        logic debug_havereset_o;
        logic debug_running_o;
        logic debug_halted_o;

        // CPU Control Signals
        logic fetch_enable_i;
        logic core_sleep_o;

    cv32e40p_core dut(.*);

    initial begin
        //output logic [31:0] data_wdata_o,
        $monitor($time," - instr_addr_o = %b | data_addr_o = %b | data_wdata_o = %b", instr_addr_o, data_addr_o, data_wdata_o);

        // Instrução: addi x10, x10, 1
        instr_rdata_i = 32'b00000000_00010101_00000101_00010011;
        data_rdata_i = 32'b0;

        //output logic [31:0] instr_addr_o,
        //output logic [31:0] data_addr_o,
        //output logic [31:0] data_wdata_o,

    end
endmodule: coreTest

//Little endian

//00 15 05 13 00 00 00 00 00 00 00 00 00 00 00 00
//00000000 00010101 00000101 00010011 instrução
//00000000 00000000 00000000 00000000 dados?

//00000000 00000000 00000000 00000000 memória
//00000000 00000000 00000000 00000000
//addi x10, x10, 1