`include "def.h";

module alu #(parameter WIDTH=32)
(
    input logic [`OP_BIT-1:0] op,
    input logic [WIDTH-1:0] in0,
    input logic [WIDTH-1:0] in1,
    output logic [WIDTH-1:0] out
);

always_comb
    case(op)
        ADD: out = in0 + in1;
        default: out = 32'dx;
    endcase

endmodule