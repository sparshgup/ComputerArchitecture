`timescale 1ns/1ps
`default_nettype none
`include "memory_access.sv"

// Based on UG901 - Vivado Synthesis Guide  Single-Port RAM with Asynchronous Read (Distributed RAM)

/*
This module assumes byte-wise addressing.

*/

module bytewise_distributed_ram(clk, wr_ena, access, addr, active, wr_data, rd_data);

parameter W = 32;
parameter L_BYTES = 128; // Must be a power of two!
parameter [31:0] BASE_ADDRESS = 32'h0000_0000;
localparam L_WORDS = L_BYTES/4;
localparam C = W/8;
parameter INIT = "";
input wire clk;
input wire wr_ena;
input mem_access_t access;
wire [C-1:0] col_ena;
input wire [31:0] addr;
logic [$clog2(L_BYTES)-1:0] addr_internal;
input wire [W-1:0] wr_data;
inout wire [W-1:0] rd_data;
wire [W-1:0] rd_data_internal;
output logic active;

tristate #(.N(W)) DATA_BUS_TRISTATE(.in(rd_data_internal), .oe(active), .io(rd_data));

// Decoding by address:
always_comb begin
  // Instead of doing a >= and < comparators you can just chck the 
  active = (BASE_ADDRESS[31:$clog2(L_BYTES)] == addr[31:$clog2(L_BYTES)]);
  addr_internal = addr[$clog2(L_BYTES)-1:0];
end


// TODO(avinash) - make a version with the decoder/shifter outside this module once I implement separate d/i cache.
memory_column_decoder #(.W(W),.L(L_BYTES)) COLUMN_DECODER(
  .addr(addr_internal), .access(access), .col_ena(col_ena)
);

wire [W-1:0] wr_data_shifted;
memory_write_byte_shifter #(.W(W), .L(L_BYTES)) WR_SHIFTER
(
  .addr(addr_internal), .d_in(wr_data), .access(access), .d_out(wr_data_shifted)
);


logic [W-1:0] ram [0:L_WORDS-1];
logic [$clog2(L_WORDS)-1:0] word_address;
always_comb word_address = addr_internal[$clog2(L_BYTES)-1:2];

task load_memory(string file);
  $readmemh(file, ram);
endtask

task dump_memory(string file);
  $writememh(file, ram);
endtask

// Create one write port per column in memory.
genvar i;
generate for(i = 0; i < C; i++) begin
  always_ff @(posedge clk) begin : distributed_ram_write_ports
    if(active & wr_ena & col_ena[i]) begin
      ram[word_address][i*8 +: 8] <= wr_data_shifted[i*8 +: 8];
    end
  end
end endgenerate

// TODO(avinash) make unsign a parameter or input to this module.
memory_read_byte_shifter #(.W(W),.L(L_BYTES))
READ_BYTE_SHIFTER(
  .addr(addr_internal), .d_in(ram[word_address]), .access(access), .unsign(1'b1), .d_out(rd_data_internal)
);

initial begin
  if(W % 8 != 0) begin
    $display("ERROR: bytewise blockram must have a width divisible by 8");
    $finish;
  end
  if (L_BYTES !== 2**$clog2(L_BYTES)) begin
    $display("ERROR: bytewise blockram must have L_bytes be a power of two.");
    $display("       %d != %d", L_BYTES, $clog2(L_BYTES)*$clog2(L_BYTES));
    $finish;
  end
  if(INIT != "") begin
    $display("###########################################");
    $display("Initializing distributed ram from file %s.", INIT);
    $display("###########################################");
    load_memory(INIT);
  end
end




endmodule