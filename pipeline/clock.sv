module clock (
  output logic clk
);

  always #10 clk = ~clk;

endmodule