`default_nettype none

// Generates a Pulse Width Modulated signal.
// If ena is low the output should be low.
// If duty is zero the output should be zero.
// If duty is the max value (2^N-1) the output does not need to be fully high 
//   (it's okay if it goes low for one cycle).
// Excel goal: find a way so that the output is steady high if duty = 2^N -1.

module pwm(clk, rst, ena, duty, out);

parameter N = 8;

input wire clk, rst;
input wire ena; // Enables the output.
input wire [N-1:0] duty; // The "duty cycle" input.
output logic out;

logic [N-1:0] counter, counter_out;
logic lt_duty;

// Increment the counter value
adder_n #(.N(N)) increment_count (
    .a(counter), 
    .b(1), 
    .c_in(1'b0), 
    .sum(counter_out)
);

// Register to store the counter value
register #(.N(N)) counter_reg (
    .clk(clk),           
    .ena(ena),           
    .rst(rst),           
    .d(counter_out),         
    .q(counter)
);

comparator_lt #(.N(N+1)) lt_output (
    .a(counter), 
    .b(duty), 
    .out(lt_duty)
);

assign out = ena & lt_duty;

endmodule
