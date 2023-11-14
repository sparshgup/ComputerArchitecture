`default_nettype none

module mux16(in0, in1, in2, in3, in4, in5, in6, in7, in8,
             in9, in10, in11, in12, in13, in14, in15,
             s, out);

    parameter N = 1;

    input wire [N-1:0] in0, in1, in2, in3, in4, in5, in6, in7, in8;
    input wire [N-1:0] in9, in10, in11, in12, in13, in14, in15;
    input wire [3:0] s;
    output logic [N-1:0] out;

    wire [N-1:0] mux0_out, mux1_out;

    mux8 #(.N(N)) MUX_0 (.in0(in0), .in1(in1), .in2(in2), .in3(in3), 
                         .in4(in4), .in5(in5), .in6(in6), .in7(in7),
                         .s(s[2:0]), .out(mux0_out));
    mux8 #(.N(N)) MUX_1 (.in0(in8), .in1(in9), .in2(in10), .in3(in11), 
                         .in4(in12), .in5(in13), .in6(in14), .in7(in15),
                         .s(s[2:0]), .out(mux1_out));
    mux2 #(.N(N)) MUX_2 (.in0(mux0_out), .in1(mux1_out), .s(s[3]), .out(out));

endmodule
