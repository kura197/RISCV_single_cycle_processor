`include "def.h";

module datapath #(parameter WIDTH=32, IADDR=10, DADDR=10)
(
    input logic clk,
    input logic reset_n,
    output logic [`INSTR_BIT-1:0] kind,
    output logic [2:0] funct3,
    output logic [6:0] funct7,
    output logic [IADDR-1:0] imem_addr,
    input logic [WIDTH-1:0] imem_rdata,
    output logic [DADDR-1:0] dmem_addr,
    output logic [WIDTH-1:0] dmem_wdata,
    input logic [WIDTH-1:0] dmem_rdata
);

localparam RFADDR = 5;

logic [WIDTH-1:0] pc, next_pc, inc_pc;
logic [WIDTH-1:0] instr;
logic [WIDTH-1:0] imm;
logic rf_wr_en;
logic [RFADDR-1:0] rs1, rs2, rd;
logic [WIDTH-1:0] rf_rdata1, rf_rdata2, rf_wdata;
logic [WIDTH-1:0] alu_in0, alu_in1, alu_out;
logic [WIDTH-1:0] ex_out;
logic [WIDTH-1:0] result;

assign inc_pc = pc + 4;
assign imem_addr = pc[IADDR-1:0];
assign instr = imem_rdata;
assign dmem_addr = ex_out[DADDR-1:0];
assign dmem_wdata = rf_rdata2;

flopenr #(
    .WIDTH(WIDTH)
) reg_pc (
    .clk(clk),
    .reset_n(reset_n),
    .wr_en(1'b1),
    .in(next_pc),
    .out(pc)
);

//TODO: add decoder
//TODO: add cmp

decoder #(
    .WIDTH(WIDTH)
) decoder (
    .instr(instr),
    .kind(kind),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .funct3(funct3),
    .funct7(funct7),
    .imm(imm)
);

regfile #(
    .WIDTH(WIDTH),
    .ADDR(RFADDR)
) regfile (
    .clk(clk),
    .reset_n(reset_n),
    .wr_en(rf_wr_en),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .rdata1(rf_rdata1),
    .rdata2(rf_rdata2),
    .wdata(rf_wdata)
);

mux2 #(
    .WIDTH(WIDTH)
) mux2_alu0 (
    .sel(),
    .in0(rf_rdata1),
    .in1(pc),
    .out(alu_in0)
);

mux2 #(
    .WIDTH(WIDTH)
) mux2_alu1 (
    .sel(),
    .in0(rf_rdata2),
    .in1(imm),
    .out(alu_in1)
);

alu #(
    .WIDTH(WIDTH)
) alu (
    .in0(alu_in0),
    .in1(alu_in1),
    .out(alu_out)
);

mux2 #(
    .WIDTH(WIDTH)
) mux2_ex (
    .sel(),
    .in0(alu_out),
    .in1(imm),
    .out(ex_out)
);

mux2 #(
    .WIDTH(WIDTH)
) mux2_res (
    .sel(),
    .in0(dmem_rdata),
    .in1(ex_out),
    .out(result)
);

mux2 #(
    .WIDTH(WIDTH)
) mux2_rf_wr (
    .sel(),
    .in0(result),
    .in1(inc_pc),
    .out(rf_wdata)
);

mux2 #(
    .WIDTH(WIDTH)
) mux2_pc (
    .sel(),
    .in0(inc_pc),
    .in1(result),
    .out(next_pc)
);

endmodule