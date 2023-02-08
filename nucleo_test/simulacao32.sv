`timescale 1ps/1ps

module simulacao32;
    logic clk;
    logic rst;
    reg [31:0] rdaddress;
    reg [31:0] wdaddress;
    reg [31:0] data;
    reg Wr;
    wire [31:0] q; //fio - não tem estado

    Memoria32 meminst (.raddress(rdaddress), .waddress(wdaddress), .Clk(clk), .Datain(data), .Dataout(q), .Wr(Wr));

    //gerador de clock e reset
    localparam CLKPERIOD = 10000;
    localparam CLKDELAY = CLKPERIOD / 2;
    initial begin
        clk = 1'b1;
        rst = 1'b1;
        #(CLKPERIOD)
        #(CLKPERIOD)
        #(CLKPERIOD)
        rst = 1'b0;
    end
    always #(CLKDELAY) clk = ~clk;

    //realiza a leitura
    always_ff @(posedge clk or posedge rst)
    begin
        if(rst) begin
			rdaddress <= 0;
			wdaddress <= 0; //não bloqueante (atribuição simultânea)
		end
		else begin
            if(rdaddress < 64) rdaddress <= rdaddress + 4;
            else begin
                rdaddress <= 0;
                $stop;
            end
        end
    end
endmodule