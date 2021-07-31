module alu #(parameter WIDTH=32)
(
    input logic [WIDTH-1:0] in0,
    input logic [WIDTH-1:0] in1,
    output logic [WIDTH-1:0] out
);

///TODO
assign out = in0 + in1;

endmodule