// Prefix Adder 

// Source: https://shareok.org/bitstream/handle/11244/25747/Gundi_okstate_0664M_13905.pdf?sequence=1&isAllowed=y 
//         (Page 12: Fig 1.9)

module adder_n_prefix(a, b, c_in, sum, c_out);

parameter N = 32; // parameter for N-bits

input wire [N-1:0] a, b;
input wire c_in;
output logic [N-1:0] sum;
output logic c_out;

logic [N-1:0] g, p;
logic [N:0] carry;

always_comb begin
    g = a & b;
    p = a ^ b;
    carry[0] = c_in;
    c_out = carry[N];
end

genvar i; 
generate
    for (i = 0; i < N; i = i + 1) begin
        always_comb begin : prefix_adder
            sum[i] = g[i] ^ carry[i];
            carry[i + 1] = g[i] | (p[i] & carry[i]);
        end
    end
endgenerate 

endmodule
