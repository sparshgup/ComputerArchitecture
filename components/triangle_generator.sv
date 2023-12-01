`default_nettype none

// Generates "triangle" waves (counts from 0 to 2^N-1, then back down again)
// The triangle should increment/decrement only if the ena signal is high, and
// hold its value otherwise.
module triangle_generator(clk, rst, ena, out);

parameter N = 8;
input wire clk, rst, ena;
output logic [N-1:0] out;

typedef enum logic {COUNTING_UP = 1'b1, COUNTING_DOWN = 1'b0} state_t;
state_t state, next_state;


// Behavioral counter adder
logic [N-1:0] adder, counter_out;

always_comb begin : count_adder
  case (state)
    COUNTING_DOWN : adder = -1;
    COUNTING_UP   : adder = 1;
    default:        adder = 0;
  endcase

  counter_out = out + adder;
end

// Counter register
always_ff @(posedge clk) begin : counter_reg
  if(rst) out <= 0;
  else if(ena) out <= counter_out;
  else out <= out;
end

// FSM
always_ff @(posedge clk) begin : fsm
  if(rst) state <= COUNTING_UP;
  else state <= next_state;
end

// Comparators
logic low_out, high_out;

comparator_eq #(.N(N)) eq_low (.a(counter_out),.b(0),.out(low_out));
comparator_eq #(.N(N)) eq_high (.a(counter_out),.b(2**N - 1),.out(high_out));

// Triangle generation
always_comb begin : triangle_gen
  
  case(state)
    COUNTING_DOWN: begin
      if (low_out) next_state = COUNTING_UP;
    end
    COUNTING_UP: begin
      if (high_out) next_state = COUNTING_DOWN;
    end
    default: next_state = COUNTING_UP;
  endcase
  
end

endmodule
