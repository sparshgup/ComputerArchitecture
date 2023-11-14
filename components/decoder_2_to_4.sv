`timescale 1ns/1ps
`default_nettype none

module decoder_2_to_4(ena, in, out);

input wire ena;
input wire [1:0] in;
output logic [3:0] out;

always_comb begin
    out[0] = ena & ~in[1] & ~in[0];
    out[1] = ena & ~in[1] &  in[0];
    out[2] = ena &  in[1] & ~in[0];
    out[3] = ena &  in[1] &  in[0];
end

endmodule