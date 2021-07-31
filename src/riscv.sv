`include "def.h";

module riscv #(parameter WIDTH=32)
(
    input logic clk,
    input logic reset_n
);

localparam IADDR = 5;
localparam DADDR = 5;

logic [`INSTR_BIT-1:0] kind;
logic [2:0] funct3;
logic [6:0] funct7;

datapath #(
    .WIDTH(WIDTH),
    .IADDR(IADDR),
    .DADDR(DADDR)
) datapath (
    .clk(clk),
    .reset_n(reset_n),
    .kind(kind),
    .funct3(funct3),
    .funct7(funct7),
    .imem_addr(),
    .imem_rdata(),
    .dmem_addr(),
    .dmem_wdata(),
    .dmem_rdata()
);

endmodule