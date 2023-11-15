`timescale 1ns/1ps
`default_nettype none

`include "alu_types.sv"

module alu(a, b, control, result, overflow, zero, equal);
parameter N = 32; // Don't need to support other numbers, just using this as a constant.

input wire [N-1:0] a, b; // Inputs to the ALU.
input alu_control_t control; // Sets the current operation.
output logic [N-1:0] result; // Result of the selected operation.

output logic overflow; // Is high if the result of an ADD or SUB wraps around the 32 bit boundary.
output logic zero;  // Is high if the result is ever all zeros.
output logic equal; // is high if a == b.


logic [N-1:0] sll_result, srl_result, sra_result, adder_result;
logic c_out, slt_result, sltu_result;


// Shifters
logic [N-1:0] temp_sll_out, temp_srl_out, temp_sra_out;

sll #(.N(N)) alu_sll (.in(a), .shamt(b[4:0]), .out(temp_sll_out));
srl #(.N(N)) alu_srl (.in(a), .shamt(b[4:0]), .out(temp_srl_out));
sra #(.N(N)) alu_sra (.in(a), .shamt(b[4:0]), .out(temp_sra_out));

mux2 #(.N(N)) sll_temp (.in0(temp_sll_out), .in1(0), .s(|b[N-1:5]), .out(sll_result));
mux2 #(.N(N)) srl_temp (.in0(temp_srl_out), .in1(0), .s(|b[N-1:5]), .out(srl_result));
mux2 #(.N(N)) sra_temp (.in0(temp_sra_out), .in1(0), .s(|b[N-1:5]), .out(sra_result));


// Adder and Subtracter
logic [N-1:0] b_add_sub;
mux2 #(.N(N)) add_sub (.in0(b), .in1(~b), .s(control[2]), .out(b_add_sub));
adder_n #(.N(N)) alu_add_sub (.a(a), .b(b_add_sub), .c_in(control[2]), .sum(adder_result));


// SLT
logic [N-1:0] temp_slt_out;
comparator_lt #(.N(N)) alu_slt (.a(a), .b(b), .out(temp_slt_out));
mux4 #(.N(N)) slt_temp (
  .in0(temp_slt_out),
  .in1(1'b0),
  .in2(1'b1),
  .in3(temp_slt_out),
  .s({a[N-1], b[N-1]}),
  .out(slt_result)
);


//SLTU
logic [N-1:0] temp_sltu_out;
mux2 #(.N(N)) sltu_temp (
  .in0(5'b11111), 
  .in1(a), 
  .s(control[3]), 
  .out(temp_sltu_out)
);
comparator_lt #(.N(N+1)) alu_sltu (.a(temp_sltu_out), .b(b), .out(sltu_result));


// ALU MUX
mux16 #(.N(N)) alu_mux (
  .in0(32'b0),
  .in1(a & b),
  .in2(a | b),
  .in3(a ^ b),
  .in4(32'b0),
  .in5(sll_result),
  .in6(srl_result),
  .in7(sra_result),
  .in8(adder_result),
  .in9(32'b0),
  .in10(32'b0),
  .in11(32'b0),
  .in12(adder_result),
  .in13({31'b0, slt_result}),
  .in14(32'b0),
  .in15({31'b0, sltu_result}),
  .s(control),
  .out(result)
);


// Overflow, Zero, and Equal flags
always_comb begin
  overflow = (control[3]) & ~(control[2] ^ a[N-1] ^ b[N-1]) & (a[N-1] ^ adder_result[N-1]); 
end
comparator_eq #(.N(N)) alu_zero (.a(result), .b(32'b0), .out(zero));
comparator_eq #(.N(N)) alu_equal (.a(a), .b(b), .out(equal));

endmodule