addi x1, x0, 1    # x01 = 1
addi x2, x0, 28   # x02 = 28  

# Test lw instruction
lw x4, 0(x0)      # Load word from address 0 into x4

# Test lh instruction
lh x5, 16(x0)     # Load halfword from address 16 into x5

# Test lb instruction
lb x6, 8(x0)      # Load signed byte from address 8 into x6

# Test lhu instruction
lhu x7, 20(x0)    # Load unsigned halfword from address 20 into x8

# Test lbu instruction
lbu x8, 12(x0)    # Load unsigned byte from address 12 into x7



|---------------------------|
| Register File State       |
|---------------------------|
| x00, zero = 0x00000000 (0)|
| x01, ra = 0x00000001 (1)  |
| x02, sp = 0x0000001c (28) |
| x03, gp = 0xxxxxxxxx      |
| x04, t0 = 0x00100093      |
| x05, t1 = 0x00000303      |
| x06, t2 = 0x00000003      |
| x07, t3 = 0x00005383      |
| x08, t4 = 0x00000083      |
|---------------------------|
