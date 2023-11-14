`default_nettype none

// Comparator for equality
// Source: Harris & Harris - Digital Design and Computer Architecture - RISC V Edition (Pg. 245)

module comparator_eq(a, b, out);

parameter N = 32;
input wire signed [N-1:0] a, b;
output logic out;

logic [N-1:0] result;
always_comb begin
    result = ~ (a ^ b);
    out = (&result);
end

endmodule
