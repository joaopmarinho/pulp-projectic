module pc_assign (
    input logic reset,
    output logic [31:0] read_addr,
    input logic [31:0] pc
);

    assign read_addr = reset ? read_addr : pc;

endmodule