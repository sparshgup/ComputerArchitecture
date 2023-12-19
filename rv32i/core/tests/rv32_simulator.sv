`timescale 1ns/1ps
`default_nettype none

`include "memory_access.sv"
`include "memory_exceptions.sv"

module rv32_simulator;

// Simulator Arguments.
int max_cycles = 100;
string wave_fn = "rv32_simulator.fst";
string initial_memory = "";
string final_memory = "";

logic clk, rst, ena;
wire done;

mem_access_t mem_access;
wire [31:0] mem_addr, mem_wr_data, mem_rd_data, PC;
wire mem_wr_ena, instruction_done;
mem_exception_mask_t mem_exception = mem_exception_mask_t'(0);
wire [31:0] instructions_completed;

rv32i_multicycle_core CORE (
  .clk(clk),
  .rst(rst),
  .ena(ena),
  .mem_addr(mem_addr),
  .mem_wr_data(mem_wr_data),
  .mem_rd_data(mem_rd_data),
  .mem_wr_ena(mem_wr_ena),
  .mem_access(mem_access),
  .mem_exception(mem_exception),
  .PC(PC),
  .instruction_done(instruction_done),
  .instructions_completed(instructions_completed)
);

bytewise_distributed_ram #(.W(32), .L_BYTES(4096))
MEMORY (
  .clk(clk),
  .access(mem_access), .addr(mem_addr), .rd_data(mem_rd_data),
  .wr_ena(mem_wr_ena), .wr_data(mem_wr_data), .active()
);

task finish_simulation;
  if(final_memory != "") begin
    $display("Writing final memory state to file '%s'.", final_memory);
    MEMORY.dump_memory(final_memory);
  end

  // TODO(avinash) - have this optionally write register_file out as well.
  CORE.REGISTER_FILE.print_state();
  $finish;
endtask

initial begin
  int cli_error = 0;
  cli_error = $value$plusargs("max_cycles=%d", max_cycles);
  cli_error |= $value$plusargs("wave_fn=%s", wave_fn);
  if(!$value$plusargs("initial_memory=%s", initial_memory)) begin
    // TODO(avinash) - put file exists check here!
    $display("ERROR: Must provide initial memory file in the form: +initial_memory=\"path_to_memh_file\"");
    $finish;
  end
  cli_error |= $value$plusargs("final_memory=%s", final_memory);
  if(cli_error) begin
    $display("Usage:\n ./rv32_simulator +initial_memory=path/to/memh/file");
    $display("  Additional arguments:");
    $display("    +initial_memory=path/to/memh/file");
    $display("        Required: path to a memh file that containes the assembled binary to run.");
    $display("    +max_cycles=NUMBER_OF_CYCLES_TO_RUN");
    $display("    +wave_fn=path/to/wave/file");
    $display("        default is rv32_simulator.fst");
    $display("    +final_memory=path/to/memh/file");
    $display("        If provided, the final memory contents will be saved here. Use this to debug your store instructions.");
  end

  
  MEMORY.load_memory(initial_memory);
    
  $display("Running simulation of memory %s for up to %d cycles. Waves will be stored to %s.", initial_memory, max_cycles, wave_fn);
  
  $dumpfile(wave_fn);
  $dumpvars(0, CORE);
  
  clk = 0;
  ena = 1;
  rst = 1;
  repeat (2) @(negedge clk);
  rst = 0;
  repeat (max_cycles) @(posedge clk);
  @(negedge clk);
  
  $display("Ran %d cycles, finishing.", max_cycles);
  finish_simulation();
end

always #5 clk = ~clk;

// Force end the solution if an infinite loop lasts too long.
parameter INFINITE_LOOP_LENGTH=4;
logic [31:0] PC_buffer [$:INFINITE_LOOP_LENGTH];
logic all_equal = 1'b1;
always @(posedge clk) begin
  if(~CORE.rst) begin
    if(CORE.state == CORE.S_FETCH) begin
        PC_buffer.push_back(CORE.PC_REGISTER.q);
        if(PC_buffer.size() == INFINITE_LOOP_LENGTH) begin
          all_equal = 1'b1;
          for(int i = 0; i < INFINITE_LOOP_LENGTH; i++) begin
            all_equal = all_equal & (PC_buffer[0] == PC_buffer[i]);
          end
          if(all_equal) begin
            $display("!!! Infinite loop detected (over %3d iterations) - ending sim !!!", INFINITE_LOOP_LENGTH);
            finish_simulation;
          end
          PC_buffer.delete(0);
        end
    end

  end
end
endmodule
