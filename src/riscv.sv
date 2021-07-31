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

logic [IADDR-1:0] imem_addr;
logic [WIDTH-1:0] imem_rdata;

logic [DADDR-1:0] dmem_addr;
logic [WIDTH-1:0] dmem_wdata;
logic dmem_wr_en;
logic [WIDTH-1:0] dmem_rdata;

logic sel_alu0;
logic sel_alu1;
logic [`OP_BIT:0] alu_op;
logic sel_ex;
logic sel_res;
logic sel_rf_wr;
logic sel_pc;

memory #(
    .WIDTH(WIDTH),
    .ADDR(IADDR)
) imem (
    .clk(clk),
    .wr_en(1'b0),
    .addr(imem_addr),
    .rdata(imem_rdata),
    .wdata()
);

memory #(
    .WIDTH(WIDTH),
    .ADDR(DADDR)
) dmem (
    .clk(clk),
    .wr_en(dmem_wr_en),
    .addr(imem_addr),
    .rdata(imem_rdata),
    .wdata(dmem_wdata)
);

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
    .imem_addr(imem_addr),
    .imem_rdata(imem_rdata),
    .dmem_addr(dmem_addr),
    .dmem_wdata(dmem_wdata),
    .dmem_rdata(dmem_rdata),
    .sel_alu0(),
    .sel_alu1(),
    .alu_op(),
    .sel_ex(),
    .sel_res(),
    .sel_rf_wr(),
    .sel_pc()
);

// add controller

endmodule