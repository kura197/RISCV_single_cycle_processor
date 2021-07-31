`define INSTR_BIT 4
enum [`INSTR_BIT-1:0] {LUI, AUIPC, JAL, JALR, BRANCH, LOAD, STORE, OPIMM, OP, MISCMEM, SYSTEM} instr_kind;

`define OP_BIT 1
enum [`OP_BIT-1:0] {ADD} op_kind;