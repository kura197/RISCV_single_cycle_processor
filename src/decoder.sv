module decoder #(parameter WIDTH=32)
(
    input [WIDTH-1:0] instr,
    output [3:0] kind,
    output [4:0] rs1,
    output [4:0] rs2,
    output [4:0] rd,
    output [2:0] funct3,
    output [6:0] funct7,
    output [31:0] imm
);

`include "def.h";

logic [6:0] opcode;
assign opcode = instr[6:0];
assign rd = instr[11:7];
assign funct3 = instr[14:12];
assign rs1 = instr[19:15];
assign rs2 = instr[24:20];
assign funct7 = instr[31:25];

logic test;
always_comb
    case(opcode)
        7'b0110111: begin
            kind = LUI;
            imm = {instr[31:12], 12'b0};
        end
        7'b0010111: begin
            kind = AUIPC;
            imm = {instr[31:12], 12'b0};
        end
        7'b1101111: begin
            kind = JAL;
            imm = {instr[20], instr[10:1], instr[11], instr[19:12], 12'b0};
        end
        7'b1100111: begin
            kind = JALR;
            imm = {{20{instr[31]}}, instr[31:20]};
        end
        7'b1100011: begin
            kind = BRANCH;
            imm = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
        end
        7'b0000011: begin
            kind = LOAD;
            imm = {{20{instr[31]}}, instr[31:20]};
        end
        7'b0100011: begin
            kind = STORE;
            imm = {{20{instr[31]}}, instr[31:25], instr[11:7]};
        end
        7'b0010011: begin
            kind = OPIMM;
            imm = {{20{instr[31]}}, instr[31:20]};
        end
        7'b0110011: begin
            kind = OP;
            imm = 32'dx;
        end
        7'b0001111: begin
            kind = MISCMEM;
            imm = 32'dx;
        end
        7'b1110011: begin
            kind = SYSTEM;
            imm = 32'dx;
        end
        default: begin
            kind = 4'dx;
            imm = 32'dx;
        end
    endcase

endmodule