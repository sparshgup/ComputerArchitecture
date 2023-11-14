// Ripple carry adder 

// Source: https://www.researchgate.net/figure/Structure-of-Full-Adder-and-4-bits-Ripple-carry-adder_fig4_303692204

// To instantiate:
// adder_n #(.N(32)) AN_ADDER_THAT_IS_32_BITS_WIDE ( port list );

`default_nettype none

module adder_n(a, b, c_in, sum, c_out);

parameter N = 32; // parameter for N-bits

input wire [N-1:0] a, b;
input wire c_in;
output logic [N-1:0] sum;
output logic c_out;

logic [N:0] carry;

always_comb begin
    carry[0] = c_in;
    c_out = carry[N];
end

genvar i;
generate
    for (i = 0; i < N; i = i + 1) begin: ripple_carry
        adder_1 ADDER (
            .a(a[i]), 
            .b(b[i]), 
            .c_in(carry[i]), 
            .sum(sum[i]), 
            .c_out(carry[i+1])
        );
    end
endgenerate

endmodule
