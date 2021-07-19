module counter
(
    input logic reset_n,
    input logic clk,
    input logic en,
    output logic [3:0] cnt
);

always_ff @(posedge clk)
    if(~reset_n)
        cnt <= 0;
    else if(en)
        cnt <= cnt + 1'b1;

endmodule
