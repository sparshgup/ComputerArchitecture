`ifndef MEMORY_ACCESS_H
`define MEMORY_ACCESS_H

// Based on risc-v funct3[1:0] - do not change!
typedef enum logic [1:0] {
  MEM_ACCESS_WORD=2'b10, // 32 bits
  MEM_ACCESS_HALF=2'b01, // 16 bits
  MEM_ACCESS_BYTE=2'b00, //  8 bits
  MEM_ACCESS_INVALID=2'b11
} mem_access_t;


`ifdef SIMULATION
function string mem_access_to_string(mem_access_t access);
  case(access)
    MEM_ACCESS_WORD: mem_access_to_string = "word";
    MEM_ACCESS_HALF: mem_access_to_string = "half";
    MEM_ACCESS_BYTE: mem_access_to_string = "byte";
    default        : mem_access_to_string = "invalid";
  endcase
endfunction

`endif

`endif // MEMORY_ACCESS_H