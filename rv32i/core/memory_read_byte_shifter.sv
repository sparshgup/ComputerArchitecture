`default_nettype none
`timescale 1ns/100ps

`include "memory_access.sv"

module memory_read_byte_shifter(addr, d_in, access, unsign, d_out);
// TODO(avinash) rename this module to make more sense.
parameter L = 128; // Include this in the rename.
parameter  W=32;
localparam C=W/8;
initial begin
  if(W!=32) begin
    $display("ERROR: W=%3d but only W=32 is currently supported. ", W);
    $finish;
  end
end

input wire [$clog2(L)-1:0] addr;
input wire [W-1:0] d_in;
input mem_access_t access;
input wire unsign;
output logic [W-1:0] d_out;

logic extend;
always_comb begin : EXTEND_MUX
  if(unsign) begin
    extend = 1'b0;
  end else begin
    case(access)
      MEM_ACCESS_BYTE: begin
      case(addr[1:0])
        2'd0 : extend = d_in[ 7];
        2'd1 : extend = d_in[15];
        2'd2 : extend = d_in[23];
        2'd3 : extend = d_in[31];
      endcase
    end
    MEM_ACCESS_HALF: extend = addr[1] ? d_in[31] : d_in[15];
    MEM_ACCESS_WORD: extend = d_in[31];
    default: extend = 0;
    endcase
  end
end

always_comb begin
  case(access) 
    MEM_ACCESS_BYTE: begin
      d_out[31:8] = {24{extend}};
      case(addr[1:0])
        2'd0 : d_out[7:0] = d_in[ 7: 0];
        2'd1 : d_out[7:0] = d_in[15: 8];
        2'd2 : d_out[7:0] = d_in[23:16];
        2'd3 : d_out[7:0] = d_in[31:24];
      endcase
    end
    MEM_ACCESS_HALF: begin
      d_out[31:16] = {16{extend}};
      d_out[15:0] = addr[1] ? d_in[31:16] : d_in[15:0];
    end
    MEM_ACCESS_WORD: d_out = d_in[31:0];
    default: d_out = '0;
  endcase
end

endmodule
