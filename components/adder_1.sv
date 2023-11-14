/*
  a 1 bit addder that we can daisy chain for 
  ripple carry adders
*/

// Source: Harris & Harris - Digital Design and Computer Architecture - RISC V Edition (Pg. 238)

module adder_1(a, b, c_in, sum, c_out);

input wire a, b, c_in;
output logic sum, c_out;

always_comb begin : adder_gates
  sum = a ^ b ^ c_in;
  c_out = (a & b) | (a & c_in) | (b & c_in);
end

endmodule
