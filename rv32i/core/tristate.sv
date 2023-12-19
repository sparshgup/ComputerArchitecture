`timescale 1ns / 100ps
`default_nettype none

module tristate(in, oe, io);
parameter N = 1;
input wire [N-1:0] in;
input wire oe;
// Note, using wire and assign because xilinx doesn't support always_comb for tristates.
inout wire [N-1:0] io;

assign io = oe ? in : {{N}{1'bZ}};

endmodule