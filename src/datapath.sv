module datapath #(parameter WIDTH=32, IADDR=10, DADDR=10)
(
    input clk,
    input reset_n,
    output [IADDR-1:0] imem_addr,
    input [WIDTH-1:0] imem_rdata,
    output [DADDR-1:0] dmem_addr,
    output [DADDR-1:0] dmem_wdata,
    input [WIDTH-1:0] dmem_rdata
);

localparam RFADDR = 5;

logic [IADDR-1:0] pc, next_pc;
logic [WIDTH-1:0] instr;
logic rf_wr_en;
logic [RFADDR-1:0] rs1, rs2, rd;
logic [WIDTH-1:0] rf_rdata1, rf_rdata2, rf_wdata;
logic [WIDTH-1:0] alu_in0, alu_in1, alu_out;

assign imem_addr = pc;
assign instr = imem_rdata;

assign dmem_addr = alu_out[DADDR-1:0];

flopenr #(
    .WIDTH(IADDR)
) reg_pc (
    .clk(clk),
    .reset_n(reset_n),
    .wr_en(1'b1),
    .in(next_pc),
    .out(pc)
);

//TODO: add decoder

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

alu #(
    .WIDTH(WIDTH)
) alu (
    .in0(alu_in0),
    .in1(alu_in1),
    .out(alu_out)
);

endmodule