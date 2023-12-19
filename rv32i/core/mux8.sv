`default_nettype none

module mux8(in0, in1, in2, in3, in4, in5, in6, in7, s, out);

    parameter N = 1;

    input wire [N-1:0] in0, in1, in2, in3, in4, in5, in6, in7; 
    input wire [2:0] s;
    output logic [N-1:0] out;

    wire [N-1:0] mux0_out, mux1_out;

    mux4 #(.N(N)) MUX_0 (.in0(in0), .in1(in1), .in2(in2), .in3(in3), .s(s[1:0]), .out(mux0_out));
    mux4 #(.N(N)) MUX_1 (.in0(in4), .in1(in5), .in2(in6), .in3(in7), .s(s[1:0]), .out(mux1_out));
    mux2 #(.N(N)) MUX_2 (.in0(mux0_out), .in1(mux1_out), .s(s[2]), .out(out));

endmodule