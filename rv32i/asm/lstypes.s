# Testing a few load/store instructions

# some standard i/r instructions
addi x1, x0, 1
addi x2, x1, 27
sll x3, x1, x2

# testing load/store by calculating addresses using x0 and imm offsets
lw x4, 0(x0)
lw x5, 4(x0)
sw x5, 28(x0)
lh x6, 24(x0)

|-------------------------------|
| Register File State           |
|-------------------------------|
|    x00, zero = 0x00000000 (0) |
|      x01, ra = 0x00000001 (1) |
|      x02, sp = 0x0000001c (28)|
|      x03, gp = 0x10000000     |
|      x04, tp = 0x00100093     |
|      x05, t0 = 0x01b08113     |
|      x06, t1 = 0x00001303     |
|-------------------------------|