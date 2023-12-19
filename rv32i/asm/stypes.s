# Simulating Store Instructions: sw, sb, sh

# Initialize registers
addi x1, x0, 1    # x01 = 1
addi x2, x0, 10   # x02 = 10
addi x3, x0, 20   # x03 = 20

# Store word value in x1 to memory address 0 using sw
sw x1, 0(x0)

# Store halfword value in x3 to memory address 16 using sh
sh x2, 16(x0)

# Store byte value in x2 to memory address 8 using sb
sb x3, 8(x0)


|--------------------------------------|
| Register File State                  |
|--------------------------------------|
| x00, zero = 0x00000000 (0)           |
| x01, ra = 0x00000001 (1)             |
| x02, sp = 0x0000000a (10)            |
| x03, gp = 0x00000014 (20)            |
|--------------------------------------|
