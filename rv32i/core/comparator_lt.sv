`default_nettype none

// Less than comparator

module comparator_lt(a, b, out);

parameter N = 32;
input wire signed [N-1:0] a, b;
output logic out;

logic [N-1:0] result;
logic c_out;

adder_n #(.N(N)) subtractor (.a(a), .b(~b), .c_in(1'b1), .sum(result), .c_out(c_out));

always_comb out = result[N-1] | (a[N-1] & ~b[N-1] & c_out) | (~a[N-1] & b[N-1] & result[N-1]);

endmodule
