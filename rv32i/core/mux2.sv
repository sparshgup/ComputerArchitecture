`default_nettype none

module mux2(in0, in1, s, out);

    parameter N = 1;

    input wire [N-1:0] in0, in1; 
    input wire s;
    output logic [N-1:0] out;

    always_comb out = s ? in1 : in0;

endmodule
