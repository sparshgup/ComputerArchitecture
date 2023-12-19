`timescale 1ns/1ps
`default_nettype none

`include "alu_types.sv"
`include "memory_access.sv"
`include "memory_exceptions.sv"
`include "rv32_common.sv"
`include "memory_map.sv" 


module rv32i_multicycle_core(
  clk, rst, ena,
  mem_addr, mem_rd_data, mem_wr_data, mem_wr_ena,
  mem_access, mem_exception,
  PC, instructions_completed, instruction_done
);

parameter PC_START_ADDRESS = {MMU_BANK_INST, 28'h0};

// Standard control signals.
input  wire clk, rst, ena; // <- worry about implementing the ena signal last.
output logic instruction_done; // Should be high for one clock cycle when finishing an instruction (e.g. during the writeback state).

// Memory interface.
output logic [31:0] mem_addr, mem_wr_data;
input   wire [31:0] mem_rd_data;
output mem_access_t mem_access;
input mem_exception_mask_t mem_exception;
output logic mem_wr_ena;

// Program Counter
output wire [31:0] PC;
output logic [31:0] instructions_completed;
wire [31:0] PC_old;
logic PC_ena, PC_old_ena;
logic [31:0] PC_next;

// Control Signals
// Decoder
logic [6:0] op;
logic [2:0] funct3;
logic [6:0] funct7;
logic [4:0] uimm;
logic rtype, itype, ltype, stype, btype, jtype, utype;
enum logic [2:0] {IMM_SRC_ITYPE, IMM_SRC_STYPE, IMM_SRC_BTYPE, IMM_SRC_JTYPE, IMM_SRC_UTYPE} immediate_src;
logic [31:0] extended_immediate;

// R-file Control Signals
logic [4:0] rd, rs1, rs2;
wire [31:0] reg_data1, reg_data2;
logic reg_write;
logic [31:0] rfile_wr_data;
wire [31:0] reg_A, reg_B;

// ALU Control Signals
enum logic [2:0] {ALU_SRC_A_PC, ALU_SRC_A_RF, ALU_SRC_A_OLD_PC, ALU_SRC_A_ZERO, ALU_SRC_B_RF_BGE} 
  alu_src_a;
enum logic [2:0] {ALU_SRC_B_RF, ALU_SRC_B_IMM, ALU_SRC_B_4, ALU_SRC_B_ZERO, ALU_SRC_A_RF_BGE, ALU_SRC_B_UIMM}
  alu_src_b;
logic [31:0] src_a, src_b;
wire [31:0] alu_result;
alu_control_t alu_control, ri_alu_control;
wire overflow;
wire zero;
wire equal;

// Non-architectural Register Signals
logic IR_write;
wire [31:0] IR; // Instruction Register (current instruction)
logic ALU_ena;
wire [31:0] alu_last; // Not a descriptive name, but this is what it's called in the text.
logic mem_data_ena;
wire [31:0] mem_data;
enum logic {MEM_SRC_PC, MEM_SRC_RESULT} mem_src;
enum logic [1:0] {RESULT_SRC_ALU, RESULT_SRC_MEM_DATA, RESULT_SRC_ALU_LAST} result_src; 
logic [31:0] result;

// Program Counter Register
register #(.N(32), .RESET_VALUE(PC_START_ADDRESS)) PC_REGISTER (
  .clk(clk), .rst(rst), .ena(PC_ena), .d(PC_next), .q(PC)
);

// Register file
register_file REGISTER_FILE(
  .clk(clk), .rst(rst),
  .wr_ena(reg_write), .wr_addr(rd), .wr_data(rfile_wr_data),
  .rd_addr0(rs1), .rd_addr1(rs2),
  .rd_data0(reg_data1), .rd_data1(reg_data2)
);

task print_rfile();
  REGISTER_FILE.print_state();
endtask

// Non-architecture register: save register read data for future cycles.
register #(.N(32)) REGISTER_A (.clk(clk), .rst(rst), .ena(1'b1), .d(reg_data1), .q(reg_A));
register #(.N(32)) REGISTER_B (.clk(clk), .rst(rst), .ena(1'b1), .d(reg_data2), .q(reg_B));
// always_comb mem_wr_data = reg_B; // RISC-V always stores data from this location.

// ALU and related control signals - use the behavioral one if you need to.
alu ALU (
  .a(src_a), .b(src_b), .result(alu_result),
  .control(alu_control),
  .overflow(overflow), .zero(zero), .equal(equal)
);


// Non-architecture register: for old program counter
register #(.N(32)) REGISTER_PC_OLD (.clk(clk), .rst(rst), .ena(PC_old_ena), .d(PC), .q(PC_old));

// Non-architecture register: to store the current instruction
register #(.N(32)) REGISTER_IR (.clk(clk), .rst(rst), .ena(IR_write), .d(mem_rd_data), .q(IR));

// Non-architecture register: Data register
register #(.N(32)) REGISTER_DATA (.clk(clk), .rst(rst), .ena(mem_data_ena), .d(mem_rd_data), .q(mem_data));

// Non-architecture register: to store output of ALU
register #(.N(32)) REGISTER_ALU (.clk(clk), .rst(rst), .ena(ALU_ena), .d(alu_result), .q(alu_last));


// ALU src_a and arc_b muxes
always_comb begin : ALU_SRC_A_MUX
  case (alu_src_a)
    ALU_SRC_A_PC    : src_a = PC;
    ALU_SRC_A_RF    : src_a = reg_A;
    ALU_SRC_A_OLD_PC: src_a = PC_old;
    ALU_SRC_A_ZERO  : src_a = 0;
    ALU_SRC_B_RF_BGE: src_a = reg_B;
    default: src_a = 0;
  endcase  
end

always_comb begin : ALU_SRC_B_MUX
  case (alu_src_b)
    ALU_SRC_B_RF    : src_b = reg_B;
    ALU_SRC_B_IMM   : src_b = extended_immediate;
    ALU_SRC_B_4     : src_b = 32'd4;
    ALU_SRC_B_ZERO  : src_b = 0;
    ALU_SRC_A_RF_BGE: src_b = reg_A;
    ALU_SRC_B_UIMM  : src_b = uimm;
    default: src_b = 0;
  endcase
end

// Result mux
always_comb begin : RESULT_MUX
  case (result_src)
    RESULT_SRC_ALU     : result = alu_result;
    RESULT_SRC_ALU_LAST: result = alu_last;
    RESULT_SRC_MEM_DATA: result = mem_data;
    default: result = alu_result;
  endcase
end

// instruction logic
always_comb begin : IR_decoder
  op = IR[6:0];
  rd = IR[11:7];
  funct3 = IR[14:12];
  rs1 = IR[19:15];
  rs2 = IR[24:20];
  funct7 = IR[31:25];
  uimm = extended_immediate[4:0];
end

// to track instructions
always_comb begin : IR_types
  itype = (op == OP_ITYPE);
  rtype = (op == OP_RTYPE);
  stype = (op == OP_STYPE);
  ltype = (op == OP_LTYPE);
  btype = (op == OP_BTYPE);
  jtype = (op == OP_JAL) | (op == OP_JALR);
  utype = (op == OP_LUI) | (op == OP_AUIPC);
end

// Extend (sign extension)
always_comb begin : extend_logic

  case (op)
    OP_ITYPE: immediate_src = IMM_SRC_ITYPE;
    OP_LTYPE: immediate_src = IMM_SRC_ITYPE;
    OP_STYPE: immediate_src = IMM_SRC_STYPE;
    OP_BTYPE: immediate_src = IMM_SRC_BTYPE;
    OP_JAL  : immediate_src = IMM_SRC_JTYPE;
    OP_JALR : immediate_src = IMM_SRC_ITYPE;
    OP_LUI  : immediate_src = IMM_SRC_UTYPE;
    OP_AUIPC: immediate_src = IMM_SRC_UTYPE;
    default : immediate_src = IMM_SRC_ITYPE; // Does not matter
  endcase

  case (immediate_src)
    IMM_SRC_ITYPE: extended_immediate = {{20{IR[31]}}, IR[31:20]};
    IMM_SRC_STYPE: extended_immediate = {{20{IR[31]}}, IR[31:25], IR[11:7]};
    IMM_SRC_BTYPE: extended_immediate = {{20{IR[31]}}, IR[7], IR[30:25], IR[11:8], 1'b0};
    IMM_SRC_JTYPE: extended_immediate = {{12{IR[31]}}, IR[19:12], IR[20], IR[30:21], 1'b0};
    IMM_SRC_UTYPE: extended_immediate = {IR[31:12], {12{1'b0}}};
    default: extended_immediate = 0; // Does not matter
  endcase

end


// Multicycle control Finite States
enum logic [3:0] {
  S_FETCH, S_DECODE, 
  S_MEM_ADR, S_MEM_READ, S_MEM_WB, S_MEM_WRITE, 
  S_EXECUTE_R, S_EXECUTE_I, S_EXECUTE_U,
  S_JAL, S_JALR, 
  S_BRANCH, 
  S_ALU_WB, 
  S_J_WB,
  S_ERROR
} state;


// Multicycle control FSM logic
always_ff @(posedge clk) begin : multicycle_FSM
  if (rst) begin
    state <= S_FETCH;
  end 
  else if (ena) begin

    case (state)

      // Fetch
      S_FETCH: begin
        state <= S_DECODE;
      end

      // Decode based on op
      S_DECODE: begin
        case (op)
          OP_LTYPE: state <= S_MEM_ADR;
          OP_STYPE: state <= S_MEM_ADR;
          OP_RTYPE: state <= S_EXECUTE_R;
          OP_ITYPE: state <= S_EXECUTE_I;
          OP_LUI  : state <= S_EXECUTE_U;
          OP_AUIPC: state <= S_EXECUTE_U;
          OP_JAL  : state <= S_JAL;
          OP_JALR : state <= S_JALR;
          OP_BTYPE: state <= S_BRANCH;
        endcase
      end

      // op = lw/sw
      S_MEM_ADR: begin
        case (op)
          OP_LTYPE: state <= S_MEM_READ;
          OP_STYPE: state <= S_MEM_WRITE;
        endcase
      end

      // op = lw
      S_MEM_READ: state <= S_MEM_WB;
      S_MEM_WB: state <= S_FETCH;

      // op = sw
      S_MEM_WRITE: state <= S_FETCH;
      
      // op = R-type
      S_EXECUTE_R: state <= S_ALU_WB;

      // op = I-type ALU
      S_EXECUTE_I: state <= S_ALU_WB;

      // op = lw/auipc
      S_EXECUTE_U: state <= S_ALU_WB;

      // op = jal
      S_JAL: state <= S_ALU_WB;
      
      // op = jalr
      S_JALR: state <= S_J_WB;
      S_J_WB: state <= S_FETCH;

      // ALU_WB state
      S_ALU_WB: state <= S_FETCH;

      // op = B-type
      S_BRANCH: state <= S_FETCH; 

      default: state <= S_ERROR;

    endcase
  end
end


// memory access logic
always_comb begin : mem_access_logic

  case (op)
    OP_LTYPE: begin
      case (funct3)
        FUNCT3_LOAD_LB : mem_access = MEM_ACCESS_BYTE;
        FUNCT3_LOAD_LH : mem_access = MEM_ACCESS_HALF;
        FUNCT3_LOAD_LW : mem_access = MEM_ACCESS_WORD;
        FUNCT3_LOAD_LBU: mem_access = MEM_ACCESS_BYTE;
        FUNCT3_LOAD_LHU: mem_access = MEM_ACCESS_HALF;
        default: mem_access = MEM_ACCESS_WORD;
      endcase
    end
    OP_STYPE: begin
      case (funct3)
        FUNCT3_STORE_SB: mem_access = MEM_ACCESS_BYTE;
        FUNCT3_STORE_SH: mem_access = MEM_ACCESS_HALF;
        FUNCT3_STORE_SW: mem_access = MEM_ACCESS_WORD;
        default: mem_access = MEM_ACCESS_WORD;
      endcase
    end
    default: mem_access = MEM_ACCESS_WORD;
  endcase

  case (mem_access)
    MEM_ACCESS_BYTE: mem_wr_data = reg_B[7:0];
    MEM_ACCESS_HALF: mem_wr_data = reg_B[15:0];
    MEM_ACCESS_WORD: mem_wr_data = reg_B;
    default: mem_wr_data = reg_B;
  endcase

end


// memory logic
always_comb begin : memory_logic
  mem_wr_data  = 0;
  mem_wr_ena   = (state == S_MEM_WRITE);
  mem_data_ena = (state == S_MEM_READ);
end

// Memory address mux
always_comb begin : mem_addr_mux
  case (state)
    S_FETCH    : mem_addr = PC;
    S_MEM_READ : mem_addr = result;
    S_MEM_WRITE: mem_addr = result;
    default: mem_addr = 0;
  endcase
end

// PC enable (old and current) logic
always_comb PC_old_ena = (state == S_FETCH) | (state == S_JAL) | (state == S_JALR);

always_comb begin : PC_ena_logic
  case (state)
    S_FETCH: begin
      PC_ena = 1;
      PC_next = result;
    end
    S_JAL: begin
      PC_ena = 1;
      PC_next = result; 
    end
    S_JALR: begin
      PC_ena = 1;
      PC_next = result;
    end
    S_BRANCH: begin
      // set PC_ena based on B-type op
      case (funct3)
        FUNCT3_BEQ : PC_ena = equal;
        FUNCT3_BNE : PC_ena = ~equal;
        FUNCT3_BLT : PC_ena = alu_result[0];
        FUNCT3_BLTU: PC_ena = alu_result[0];
        FUNCT3_BGE : PC_ena = alu_result[0] | equal;
        FUNCT3_BGEU: PC_ena = alu_result[0] | equal;
      endcase
      PC_next = result;
    end
    default: begin
      PC_ena = 0;
      PC_next = PC;
    end
  endcase
end


// IR enable logic
always_comb begin : IR_write_logic
  case (state)
    S_FETCH: IR_write = 1;
    default: IR_write = 0;
  endcase
end


// writeback logic
always_comb begin : writeback_logic
  case (state)
    S_ALU_WB: begin
      reg_write = 1;
      rfile_wr_data = result;
    end

    S_MEM_WB: begin
      reg_write = 1;
      // load in state mem_wb based on type
      case (funct3)
        FUNCT3_LOAD_LB : rfile_wr_data = {{24{mem_data[7]}}, mem_data[7:0]};
        FUNCT3_LOAD_LH : rfile_wr_data = {{16{mem_data[15]}}, mem_data[15:0]};
        FUNCT3_LOAD_LW : rfile_wr_data = mem_data;
        FUNCT3_LOAD_LBU: rfile_wr_data = {{24{1'b0}}, mem_data[7:0]};
        FUNCT3_LOAD_LHU: rfile_wr_data = {{15{1'b0}}, mem_data[15:0]};
        default: rfile_wr_data = mem_data;
      endcase
    end

    S_J_WB: begin
      reg_write = 1;
      rfile_wr_data = PC_old;
    end
  
    default: begin
      reg_write = 0;
      rfile_wr_data = 0;
    end
  endcase
end

// result_src logic
always_comb begin : result_src_logic
  case (state)
    S_FETCH    : result_src = RESULT_SRC_ALU;
    S_DECODE   : result_src = RESULT_SRC_ALU;
    S_MEM_ADR  : result_src = RESULT_SRC_ALU;
    S_MEM_READ : result_src = RESULT_SRC_ALU_LAST;
    S_MEM_WB   : result_src = RESULT_SRC_MEM_DATA;
    S_MEM_WRITE: result_src = RESULT_SRC_ALU_LAST;
    S_EXECUTE_R: result_src = RESULT_SRC_ALU;
    S_EXECUTE_I: result_src = RESULT_SRC_ALU;
    S_EXECUTE_U: result_src = RESULT_SRC_ALU;
    S_JAL      : result_src = RESULT_SRC_ALU_LAST;
    S_JALR     : result_src = RESULT_SRC_ALU;
    S_ALU_WB   : result_src = RESULT_SRC_ALU_LAST;
    S_J_WB     : result_src = RESULT_SRC_ALU_LAST;
    S_BRANCH   : result_src = RESULT_SRC_ALU_LAST;
    default: result_src = RESULT_SRC_ALU;
  endcase
end


// ALU decoder
always_comb begin : ALU_decoder
  case(state)

    S_FETCH: begin
      alu_control = ALU_ADD;
      ALU_ena = 1;
    end

    S_DECODE: begin
      alu_control = ALU_ADD;
      ALU_ena = 1;
    end

    S_MEM_ADR: begin
      alu_control = ALU_ADD;
      ALU_ena = 1;
    end

    // I-type
    S_EXECUTE_I: begin
      case (funct3)
        FUNCT3_ADD: alu_control = ALU_ADD;
        FUNCT3_XOR: alu_control = ALU_XOR;
        FUNCT3_OR : alu_control = ALU_OR;
        FUNCT3_AND: alu_control = ALU_AND;
        FUNCT3_SLL: alu_control = ALU_SLL;
        // SRL or SRA based on funct7[5]
        FUNCT3_SHIFT_RIGHT: begin
          case (funct7[5])
            0: alu_control = ALU_SRL;
            1: alu_control = ALU_SRA;
          endcase
        end
        FUNCT3_SLT : alu_control = ALU_SLT;
        FUNCT3_SLTU: alu_control = ALU_SLTU;
      endcase

      ALU_ena = 1;
    end

    // R-type
    S_EXECUTE_R: begin
      case (funct3)
        FUNCT3_ADD: begin
          // ADD or SUB based on funct7[5]
          case (funct7[5])
            0: alu_control = ALU_ADD;
            1: alu_control = ALU_SUB;
          endcase
        end
        FUNCT3_XOR: alu_control = ALU_XOR;
        FUNCT3_OR : alu_control = ALU_OR;
        FUNCT3_AND: alu_control = ALU_AND;
        FUNCT3_SLL: alu_control = ALU_SLL;
        FUNCT3_SHIFT_RIGHT: begin
          // SRL or SRA based on funct7[5]
          case (funct7[5])
            0: alu_control = ALU_SRL;
            1: alu_control = ALU_SRA;
          endcase
        end
        FUNCT3_SLT : alu_control = ALU_SLT;
        FUNCT3_SLTU: alu_control = ALU_SLTU;
      endcase

      ALU_ena = 1;
    end

    S_EXECUTE_U: begin
      alu_control = ALU_ADD;
      ALU_ena = 1;
    end

    S_JAL: begin
      alu_control = ALU_ADD;
      ALU_ena = 1;
    end

    S_JALR: begin
      alu_control = ALU_ADD;
      ALU_ena = 1;
    end

    S_BRANCH: begin
      case (funct3)
        // Branch instructions
        FUNCT3_BEQ, FUNCT3_BNE: begin
          alu_control = ALU_SUB;
          ALU_ena = 1;
        end
        FUNCT3_BLT: begin
          alu_control = ALU_SLT;
          ALU_ena = 1;
        end
        FUNCT3_BLTU: begin
          alu_control = ALU_SLTU;
          ALU_ena = 1;
        end
        FUNCT3_BGE: begin
          alu_control = ALU_SLT;
          ALU_ena = 1;
        end
        FUNCT3_BGEU: begin
          alu_control = ALU_SLTU;
          ALU_ena = 1;
        end
      endcase
    end

    default: begin
      alu_control = ALU_ADD;
      ALU_ena = 1;
    end

  endcase
end


// ALU src logic
always_comb begin : ALU_src_logic

  case (state)

    S_FETCH: begin
      alu_src_a = ALU_SRC_A_PC;
      alu_src_b = ALU_SRC_B_4;
    end

    S_DECODE: begin
      alu_src_a = ALU_SRC_A_OLD_PC;
      alu_src_b = ALU_SRC_B_IMM;
    end

    S_MEM_ADR: begin
      alu_src_a = ALU_SRC_A_RF;
      alu_src_b = ALU_SRC_B_IMM;
    end

    S_EXECUTE_R: begin
      alu_src_a = ALU_SRC_A_RF;
      alu_src_b = ALU_SRC_B_RF;
    end

    S_EXECUTE_I: begin
      alu_src_a = ALU_SRC_A_RF;
      case (funct3)
        FUNCT3_SLL        : alu_src_b = ALU_SRC_B_UIMM;
        FUNCT3_SHIFT_RIGHT: alu_src_b = ALU_SRC_B_UIMM;
        default           : alu_src_b = ALU_SRC_B_IMM;
      endcase
    end

    S_EXECUTE_U: begin
      case (op)
        OP_LUI  : alu_src_a = ALU_SRC_A_ZERO;
        OP_AUIPC: alu_src_a = ALU_SRC_A_PC;
      endcase
      alu_src_b = ALU_SRC_B_IMM;
    end

    S_JAL: begin
      alu_src_a = ALU_SRC_A_PC;
      alu_src_b = ALU_SRC_B_4;
    end

    S_JALR: begin
      alu_src_a = ALU_SRC_A_RF;
      alu_src_b = ALU_SRC_B_IMM;
    end

    S_BRANCH: begin
      case (funct3)
        // Branch instructions
        FUNCT3_BEQ, FUNCT3_BNE: begin
          alu_src_a = ALU_SRC_A_RF;
          alu_src_b = ALU_SRC_B_RF;
        end
        FUNCT3_BLT: begin
          alu_src_a = ALU_SRC_A_RF;
          alu_src_b = ALU_SRC_B_RF;
        end
        FUNCT3_BLTU: begin
          alu_src_a = ALU_SRC_A_RF;
          alu_src_b = ALU_SRC_B_RF;
        end
        FUNCT3_BGE: begin
          alu_src_a = ALU_SRC_B_RF_BGE;
          alu_src_b = ALU_SRC_A_RF_BGE;
        end
        FUNCT3_BGEU: begin
          alu_src_a = ALU_SRC_B_RF_BGE;
          alu_src_b = ALU_SRC_A_RF_BGE;
        end
      endcase
    end

    default: begin
      alu_src_a = ALU_SRC_A_PC;
      alu_src_b = ALU_SRC_B_ZERO;
    end

  endcase
end

endmodule
