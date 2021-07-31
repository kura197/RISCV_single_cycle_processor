module flopenr #(parameter WIDTH=32)
(
    input logic clk,
    input logic reset_n,
    input logic wr_en,
    input logic [WIDTH-1:0] in,
    output logic [WIDTH-1:0] out
);

always_ff @(posedge clk)
    if(!reset_n)
        out <= 0;
    else if(wr_en)
        out <= in;

endmodule
