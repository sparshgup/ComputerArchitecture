addi x1, x0, 1    # x01 = 1
addi x2, x0, 28   # x02 = 28  

# Test lui instruction
lui x3, 0x5678     # Load upimm 0x5678 to x3

# Test auipc instruction
auipc x4, 0x5678   # Add upimm 0x5678 to PC and store the result in x4

|---------------------------|
| Register File State       |
|---------------------------|
| x00, zero = 0x00000000 (0)|
| x01, ra = 0x00000001 (1)  |
| x02, sp = 0x0000001c (28) |
| x03, gp = 0x05678000      |
| x04, t0 = 0x05678010      |
|---------------------------|
