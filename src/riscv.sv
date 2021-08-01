`include "lib_pkg.sv";

module riscv #(parameter WIDTH=32)
(
    input logic clk,
    input logic reset_n
);

import lib_pkg::*;

localparam IADDR = 5;
localparam DADDR = 5;

op_type_t op_type;
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
alu_type_t alu_type;
logic sel_ex;
logic sel_res;
logic sel_rf_wr;
logic rf_wr_en;
logic sel_pc;
cmp_type_t cmp_type;
logic cmp_res;

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
    .op_type(op_type),
    .funct3(funct3),
    .funct7(funct7),
    .imem_addr(imem_addr),
    .imem_rdata(imem_rdata),
    .dmem_addr(dmem_addr),
    .dmem_wdata(dmem_wdata),
    .dmem_rdata(dmem_rdata),
    .sel_alu0(sel_alu0),
    .sel_alu1(sel_alu1),
    .alu_type(alu_type),
    .sel_ex(sel_ex),
    .sel_res(sel_res),
    .sel_rf_wr(sel_rf_wr),
    .rf_wr_en(rf_wr_en),
    .sel_pc(sel_pc),
    .cmp_type(cmp_type),
    .cmp_out(cmp_res)
);

controller #(
) controller (
    .op_type(op_type),
    .funct3(funct3),
    .funct7(funct7),
    .cmp_res(cmp_res),
    .sel_alu0(sel_alu0),
    .sel_alu1(sel_alu1),
    .alu_type(alu_type),
    .sel_ex(sel_ex),
    .dmem_wr_en(dmem_wr_en),
    .sel_res(sel_res),
    .sel_rf_wr(sel_rf_wr),
    .rf_wr_en(rf_wr_en),
    .sel_pc(sel_pc),
    .cmp_type(cmp_type)
);

// add controller

endmodule