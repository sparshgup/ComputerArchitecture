`timescale 1ns/1ps
`default_nettype none

module decoder_5_to_32(ena, in, out);

input wire ena;
input wire [4:0] in;
output logic [31:0] out;

logic [3:0] decoder0_out;
logic [7:0] decoder1_out, decoder2_out, decoder3_out, decoder4_out;

decoder_2_to_4 decoder0 (.ena(ena), .in(in[4:3]), .out(decoder0_out));
decoder_3_to_8 decoder1 (.ena(decoder0_out[0]), .in(in[2:0]), .out(decoder1_out));
decoder_3_to_8 decoder2 (.ena(decoder0_out[1]), .in(in[2:0]), .out(decoder2_out));
decoder_3_to_8 decoder3 (.ena(decoder0_out[2]), .in(in[2:0]), .out(decoder3_out));
decoder_3_to_8 decoder4 (.ena(decoder0_out[3]), .in(in[2:0]), .out(decoder4_out));

always_comb begin
    out = {decoder4_out, decoder3_out, decoder2_out, decoder1_out};
end

endmodule
