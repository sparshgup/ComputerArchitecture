`default_nettype none

module mux4(in0, in1, in2, in3, s, out);

    parameter N = 1;

    input wire [N-1:0] in0, in1, in2, in3; 
    input wire [1:0] s;
    output logic [N-1:0] out;

    wire [N-1:0] mux0_out, mux1_out;

    mux2 #(.N(N)) MUX_0 (.in0(in0), .in1(in1), .s(s[0]), .out(mux0_out));
    mux2 #(.N(N)) MUX_1 (.in0(in2), .in1(in3), .s(s[0]), .out(mux1_out));
    mux2 #(.N(N)) MUX_2 (.in0(mux0_out), .in1(mux1_out), .s(s[1]), .out(out));

endmodule
