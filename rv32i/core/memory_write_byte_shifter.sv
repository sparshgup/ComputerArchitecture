`default_nettype none
`timescale 1ns/100ps
`include "memory_access.sv"

module memory_write_byte_shifter(addr, d_in, access, d_out);
parameter L = 128;
parameter  W=32;
localparam C=W/8;
initial begin
  if(W!=32) begin
    $display("ERROR: W=%3d but only W=32 is currently supported. ", W);
    $finish;
  end
end

input wire [W-1:0] d_in;
input wire [$clog2(L)-1:0] addr;
input mem_access_t access;
output logic [W-1:0] d_out;

logic b1_select;
logic [1:0] b2_select, b3_select;


always_comb begin
  case(access)
    MEM_ACCESS_BYTE: begin
      b1_select = 1'b0;
      b2_select = 2'b0;
      b3_select = 2'b0;
    end
    MEM_ACCESS_HALF: begin
      b1_select = 1'b1;
      b2_select = 0;
      b3_select = 1;
    end
    MEM_ACCESS_WORD: begin
      b1_select = 1'b1;
      b2_select = 2'd2;
      b3_select = 2'd3;
    end
    default: begin
      b1_select = '0;
      b2_select = '0;
      b3_select = '0;
    end
  endcase

  d_out[7:0] = d_in[7:0];
  d_out[15:8] = b1_select ? d_in[15:8] : d_in[7:0];
  case(b2_select)
    2'd0 : d_out[23:16] = d_in[7:0];
    2'd1 : d_out[23:16] = d_in[15:8];
    2'd2 : d_out[23:16] = d_in[23:16];
    default : d_out[23:16] = d_in[7:0];
  endcase
  case(b3_select)
    2'd0 : d_out[31:24] = d_in[7:0];
    2'd1 : d_out[31:24] = d_in[15:8];
    2'd2 : d_out[31:24] = d_in[23:16];
    2'd3 : d_out[31:24] = d_in[31:24];
  endcase
    
end

endmodule
