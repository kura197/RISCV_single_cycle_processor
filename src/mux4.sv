module mux4 #(parameter WIDTH=32)
(
    input logic [1:0] sel,
    input logic [WIDTH-1:0] in0,
    input logic [WIDTH-1:0] in1,
    input logic [WIDTH-1:0] in2,
    input logic [WIDTH-1:0] in3,
    output logic [WIDTH-1:0] out
);

logic [WIDTH-1:0] d0, d1;

mux2 #(32) mux2_0(sel[0], in0, in1, d0);
mux2 #(32) mux2_1(sel[0], in2, in3, d1);
assign out = sel[1] ? d1 : d0;

endmodule