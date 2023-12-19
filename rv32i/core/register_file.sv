`default_nettype none
`timescale 1ns/1ps

module register_file(
  rst, clk,
  wr_ena, wr_addr, wr_data,
  rd_addr0, rd_data0,
  rd_addr1, rd_data1
);
// Not parametrizing, these widths are defined by the RISC-V Spec.

input wire clk, rst;

// Write channel:
input wire wr_ena;
input wire [4:0] wr_addr;
input wire [31:0] wr_data;

// Two read channels:
input wire [4:0] rd_addr0, rd_addr1;
output logic [31:0] rd_data0, rd_data1;

logic [31:0] x00; 
always_comb x00 = 32'd0; // ties x00 to ground

// DON'T DO THIS:
// logic [31:0] register_file_registers [31:0];
// CAN'T: because that's a RAM. Works in simulation, not synthesis. Technically if you implement it as a distribute ram it sort of works out, but the following more structural representation captures how much hardware/area the register file really takes.


// Python cmd to generate: print(", ".join([f"x{i:02d}" for i in range(1, 32)]))
wire signed [31:0] x01, x02, x03, x04, x05, x06, x07;
wire signed [31:0] x08, x09, x10, x11, x12, x13, x14, x15;
wire signed [31:0] x16, x17, x18, x19, x20, x21, x22, x23;
wire signed [31:0] x24, x25, x26, x27, x28, x29, x30, x31;

logic [31:0] enables; // enable for each register

// Python cmd to generate: print(", ".join([f".in{i}(x{i:02d})" for i in range(0, 32)]))
// mux for rd_data0
mux32 #(.N(32)) mux_rd_data0 (
  .in0(x00), .in1(x01), .in2(x02), .in3(x03), .in4(x04), .in5(x05), .in6(x06), .in7(x07), 
  .in8(x08), .in9(x09), .in10(x10), .in11(x11), .in12(x12), .in13(x13), .in14(x14), .in15(x15), 
  .in16(x16), .in17(x17), .in18(x18), .in19(x19), .in20(x20), .in21(x21), .in22(x22), .in23(x23), 
  .in24(x24), .in25(x25), .in26(x26), .in27(x27), .in28(x28), .in29(x29), .in30(x30), .in31(x31),
  .s(rd_addr0), .out(rd_data0)
);
// mux for rd_data1
mux32 #(.N(32)) mux_rd_data1 (
  .in0(x00), .in1(x01), .in2(x02), .in3(x03), .in4(x04), .in5(x05), .in6(x06), .in7(x07), 
  .in8(x08), .in9(x09), .in10(x10), .in11(x11), .in12(x12), .in13(x13), .in14(x14), .in15(x15), 
  .in16(x16), .in17(x17), .in18(x18), .in19(x19), .in20(x20), .in21(x21), .in22(x22), .in23(x23), 
  .in24(x24), .in25(x25), .in26(x26), .in27(x27), .in28(x28), .in29(x29), .in30(x30), .in31(x31),
  .s(rd_addr1), .out(rd_data1)
);

// decoder for write enables
decoder_5_to_32 decoder_wr (.ena(wr_ena), .in(wr_addr), .out(enables));

// Instantiate registers
// Python cmd to generate: 
// print("\n".join([f"register #(.N(32), .RESET_VALUE(0)) reg_x{i:02d} (.clk(clk), .ena(enables[{i:02d}]), .rst(1'b0), .d(wr_data), .q(x{i:02d}));" for i in range(1, 32)]))
register #(.N(32), .RESET_VALUE(0)) reg_x01 (.clk(clk), .ena(enables[01]), .rst(1'b0), .d(wr_data), .q(x01));
register #(.N(32), .RESET_VALUE(0)) reg_x02 (.clk(clk), .ena(enables[02]), .rst(1'b0), .d(wr_data), .q(x02));
register #(.N(32), .RESET_VALUE(0)) reg_x03 (.clk(clk), .ena(enables[03]), .rst(1'b0), .d(wr_data), .q(x03));
register #(.N(32), .RESET_VALUE(0)) reg_x04 (.clk(clk), .ena(enables[04]), .rst(1'b0), .d(wr_data), .q(x04));
register #(.N(32), .RESET_VALUE(0)) reg_x05 (.clk(clk), .ena(enables[05]), .rst(1'b0), .d(wr_data), .q(x05));
register #(.N(32), .RESET_VALUE(0)) reg_x06 (.clk(clk), .ena(enables[06]), .rst(1'b0), .d(wr_data), .q(x06));
register #(.N(32), .RESET_VALUE(0)) reg_x07 (.clk(clk), .ena(enables[07]), .rst(1'b0), .d(wr_data), .q(x07));
register #(.N(32), .RESET_VALUE(0)) reg_x08 (.clk(clk), .ena(enables[08]), .rst(1'b0), .d(wr_data), .q(x08));
register #(.N(32), .RESET_VALUE(0)) reg_x09 (.clk(clk), .ena(enables[09]), .rst(1'b0), .d(wr_data), .q(x09));
register #(.N(32), .RESET_VALUE(0)) reg_x10 (.clk(clk), .ena(enables[10]), .rst(1'b0), .d(wr_data), .q(x10));
register #(.N(32), .RESET_VALUE(0)) reg_x11 (.clk(clk), .ena(enables[11]), .rst(1'b0), .d(wr_data), .q(x11));
register #(.N(32), .RESET_VALUE(0)) reg_x12 (.clk(clk), .ena(enables[12]), .rst(1'b0), .d(wr_data), .q(x12));
register #(.N(32), .RESET_VALUE(0)) reg_x13 (.clk(clk), .ena(enables[13]), .rst(1'b0), .d(wr_data), .q(x13));
register #(.N(32), .RESET_VALUE(0)) reg_x14 (.clk(clk), .ena(enables[14]), .rst(1'b0), .d(wr_data), .q(x14));
register #(.N(32), .RESET_VALUE(0)) reg_x15 (.clk(clk), .ena(enables[15]), .rst(1'b0), .d(wr_data), .q(x15));
register #(.N(32), .RESET_VALUE(0)) reg_x16 (.clk(clk), .ena(enables[16]), .rst(1'b0), .d(wr_data), .q(x16));
register #(.N(32), .RESET_VALUE(0)) reg_x17 (.clk(clk), .ena(enables[17]), .rst(1'b0), .d(wr_data), .q(x17));
register #(.N(32), .RESET_VALUE(0)) reg_x18 (.clk(clk), .ena(enables[18]), .rst(1'b0), .d(wr_data), .q(x18));
register #(.N(32), .RESET_VALUE(0)) reg_x19 (.clk(clk), .ena(enables[19]), .rst(1'b0), .d(wr_data), .q(x19));
register #(.N(32), .RESET_VALUE(0)) reg_x20 (.clk(clk), .ena(enables[20]), .rst(1'b0), .d(wr_data), .q(x20));
register #(.N(32), .RESET_VALUE(0)) reg_x21 (.clk(clk), .ena(enables[21]), .rst(1'b0), .d(wr_data), .q(x21));
register #(.N(32), .RESET_VALUE(0)) reg_x22 (.clk(clk), .ena(enables[22]), .rst(1'b0), .d(wr_data), .q(x22));
register #(.N(32), .RESET_VALUE(0)) reg_x23 (.clk(clk), .ena(enables[23]), .rst(1'b0), .d(wr_data), .q(x23));
register #(.N(32), .RESET_VALUE(0)) reg_x24 (.clk(clk), .ena(enables[24]), .rst(1'b0), .d(wr_data), .q(x24));
register #(.N(32), .RESET_VALUE(0)) reg_x25 (.clk(clk), .ena(enables[25]), .rst(1'b0), .d(wr_data), .q(x25));
register #(.N(32), .RESET_VALUE(0)) reg_x26 (.clk(clk), .ena(enables[26]), .rst(1'b0), .d(wr_data), .q(x26));
register #(.N(32), .RESET_VALUE(0)) reg_x27 (.clk(clk), .ena(enables[27]), .rst(1'b0), .d(wr_data), .q(x27));
register #(.N(32), .RESET_VALUE(0)) reg_x28 (.clk(clk), .ena(enables[28]), .rst(1'b0), .d(wr_data), .q(x28));
register #(.N(32), .RESET_VALUE(0)) reg_x29 (.clk(clk), .ena(enables[29]), .rst(1'b0), .d(wr_data), .q(x29));
register #(.N(32), .RESET_VALUE(0)) reg_x30 (.clk(clk), .ena(enables[30]), .rst(1'b0), .d(wr_data), .q(x30));
register #(.N(32), .RESET_VALUE(0)) reg_x31 (.clk(clk), .ena(enables[31]), .rst(1'b0), .d(wr_data), .q(x31));


// Aliases (helpful for debugging assembly);
`ifdef SIMULATION
logic [31:0] ra, sp, gp, tp, t0, t1, t2, s0, fp, s1, a0, a1, a2, a3, a4, a5, 
  a6, a7, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, t3, t4, t5, t6;
always_comb begin : REGISTER_ALIASES
  ra = x01; // Return Address
  sp = x02; // Stack Pointer
  gp = x03; // Global Pointer
  tp = x04; // Thread Pointer
  fp = x08; // Frame Pointer
  s0 = x08; // Saved Registers - must be preserved by called functions.
  s1 = x09; 
  s2 = x18;
  s3 = x19;
  s4 = x20;
  s5 = x21;
  s6 = x22;
  s7 = x23;
  s8 = x24;
  s9 = x25;
  s10 = x26;
  s11 = x27;
  t0 = x05; // Temporary values (can be changed by called functions).
  t1 = x06;
  t2 = x07;
  t3 = x28;
  t4 = x29;
  t5 = x30;
  t6 = x31;
  a0 = x10;
  a1 = x11;
  a2 = x12;
  a3 = x13;
  a4 = x14;
  a5 = x15;
  a6 = x16;
  a7 = x17;
end

function void print_state();
  $display("|---------------------------------------|");
  $display("| Register File State                   |");
  $display("|---------------------------------------|");
  $display("| %12s = 0x%8h (%10d)|", "x00, zero", x00, x00);
  $display("| %12s = 0x%8h (%10d)|", "x01, ra", x01, x01);
  $display("| %12s = 0x%8h (%10d)|", "x02, sp", x02, x02);
  $display("| %12s = 0x%8h (%10d)|", "x03, gp", x03, x03);
  $display("| %12s = 0x%8h (%10d)|", "x04, tp", x04, x04);
  $display("| %12s = 0x%8h (%10d)|", "x05, t0", x05, x05);
  $display("| %12s = 0x%8h (%10d)|", "x06, t1", x06, x06);
  $display("| %12s = 0x%8h (%10d)|", "x07, t2", x07, x07);
  $display("| %12s = 0x%8h (%10d)|", "x08, s0", x08, x08);
  $display("| %12s = 0x%8h (%10d)|", "x09, s1", x09, x09);
  $display("| %12s = 0x%8h (%10d)|", "x10, a0", x10, x10);
  $display("| %12s = 0x%8h (%10d)|", "x11, a1", x11, x11);
  $display("| %12s = 0x%8h (%10d)|", "x12, a2", x12, x12);
  $display("| %12s = 0x%8h (%10d)|", "x13, a3", x13, x13);
  $display("| %12s = 0x%8h (%10d)|", "x14, a4", x14, x14);
  $display("| %12s = 0x%8h (%10d)|", "x15, a5", x15, x15);
  $display("| %12s = 0x%8h (%10d)|", "x16, a6", x16, x16);
  $display("| %12s = 0x%8h (%10d)|", "x17, a7", x17, x17);
  $display("| %12s = 0x%8h (%10d)|", "x18, s2", x18, x18); 
  $display("| %12s = 0x%8h (%10d)|", "x19, s3", x19, x19); 
  $display("| %12s = 0x%8h (%10d)|", "x20, s4", x20, x20); 
  $display("| %12s = 0x%8h (%10d)|", "x21, s5", x21, x21); 
  $display("| %12s = 0x%8h (%10d)|", "x22, s6", x22, x22); 
  $display("| %12s = 0x%8h (%10d)|", "x23, s7", x23, x23); 
  $display("| %12s = 0x%8h (%10d)|", "x24, s8", x24, x24); 
  $display("| %12s = 0x%8h (%10d)|", "x25, s9", x25, x25); 
  $display("| %12s = 0x%8h (%10d)|", "x26, s10", x26, x26); 
  $display("| %12s = 0x%8h (%10d)|", "x27, s11", x27, x27); 
  $display("| %12s = 0x%8h (%10d)|", "x28, t3", x28, x28); 
  $display("| %12s = 0x%8h (%10d)|", "x29, t4", x29, x29); 
  $display("| %12s = 0x%8h (%10d)|", "x30, t5", x30, x30); 
  $display("| %12s = 0x%8h (%10d)|", "x31, t6", x31, x31); 
  $display("|---------------------------------------|");
endfunction // print_state

/*
// TODO(avinash) - finish this task for more automated testing.
task dump_state(string file);
  int fd = $fopen("./register_file.txt", "w");
  $fdisplay(fd, "|---------------------------------------|");
  $fdisplay(fd, "| Register File State                   |");
  $fdisplay(fd, "|---------------------------------------|");
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x00, zero", x00, x00);
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x01, ra", x01, x01);
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x02, sp", x02, x02);
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x03, gp", x03, x03);
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x04, tp", x04, x04);
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x05, t0", x05, x05);
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x06, t1", x06, x06);
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x07, t2", x07, x07);
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x08, s0", x08, x08);
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x09, s1", x09, x09);
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x10, a0", x10, x10);
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x11, a1", x11, x11);
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x12, a2", x12, x12);
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x13, a3", x13, x13);
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x14, a4", x14, x14);
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x15, a5", x15, x15);
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x16, a6", x16, x16);
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x17, a7", x17, x17);
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x18, s2", x18, x18); 
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x19, s3", x19, x19); 
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x20, s4", x20, x20); 
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x21, s5", x21, x21); 
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x22, s6", x22, x22); 
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x23, s7", x23, x23); 
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x24, s8", x24, x24); 
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x25, s9", x25, x25); 
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x26, s10", x26, x26); 
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x27, s11", x27, x27); 
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x28, t3", x28, x28); 
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x29, t4", x29, x29); 
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x30, t5", x30, x30); 
  $fdisplay(fd, "| %12s = 0x%8h (%10d)|", "x31, t6", x31, x31); 
  $fdisplay(fd, "|---------------------------------------|");
  $fclose(fd);
endtask
*/ 

`endif // SIMULATION
endmodule