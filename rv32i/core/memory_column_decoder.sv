`default_nettype none
`timescale 1ns/100ps

`include "memory_access.sv"

module memory_column_decoder(addr, access, col_ena);
parameter L = 128;
parameter  W=32;
localparam C=W/8;
initial begin
  if(W != 32) begin
    $display("ERROR: W=%d but only W=32 supported. ", W);
    $finish;
  end
end

input wire [$clog2(L)-1:0] addr;
input mem_access_t access;
output logic [C-1:0] col_ena;

always_comb begin
  case(access) 
    MEM_ACCESS_BYTE: col_ena = 1'b1 << addr[1:0];
    MEM_ACCESS_HALF: col_ena = addr[1] ? 4'b1100 : 4'b0011;
    MEM_ACCESS_WORD: col_ena = 4'b1111;
    default: col_ena = 4'b0;
  endcase
end

endmodule
