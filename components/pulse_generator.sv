`default_nettype none
// Outputs a pulse on out with a period of "ticks".
// i.e. out should go high for one cycle every "ticks" clocks.

module pulse_generator(clk, rst, ena, ticks, out);

parameter N = 8;
input wire clk, rst, ena;
input wire [N-1:0] ticks;
output logic out;

logic [N-1:0] counter, counter_out;
logic c_eq;

adder_n #(.N(N)) increment_count (
    .a(counter),
    .b(1),
    .c_in(1'b0),
    .sum(counter_out)
);

comparator_eq #(.N(N)) eq (
    .a(ticks),
    .b(counter_out),
    .out(c_eq)
);

logic local_rst;
always_comb local_rst = rst | c_eq;

register #(.N(N)) counter_reg (
    .clk(clk),
    .ena(ena),
    .rst(local_rst),
    .d(counter_out),
    .q(counter)
);

always_comb out = c_eq & ena;

endmodule
