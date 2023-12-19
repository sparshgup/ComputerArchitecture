addi x1, x0, 17
addi x10, zero, -16
slli x2, x1, 4
slti x3, x2, 1000
sltiu x4, x2, 1000
xori x5, x2, 479
srli x6, x10, 4
srai x7, x10, 4
ori x8, x2, 2044
andi x9, x8, 100

# |---------------------------------------|
# | Register File State                   |
# |---------------------------------------|
# |    x00, zero = 0x00000000 (         0)|
# |      x01, ra = 0x00000011 (        17)|
# |      x02, sp = 0x00000110 (       272)|
# |      x03, gp = 0x00000001 (         1)|
# |      x04, tp = 0x00000001 (         1)|
# |      x05, t0 = 0x000000cf (       207)|
# |      x06, t1 = 0x0fffffff ( 268435455)|
# |      x07, t2 = 0xffffffff (        -1)|
# |      x08, s0 = 0x000007fc (      2044)|
# |      x09, s1 = 0x00000064 (       100)|
# |      x10, a0 = 0xfffffff0 (       -16)|
# |      x11, a1 = 0xxxxxxxxx (         x)|
# |      x12, a2 = 0xxxxxxxxx (         x)|
# |      x13, a3 = 0xxxxxxxxx (         x)|
# |      x14, a4 = 0xxxxxxxxx (         x)|
# |      x15, a5 = 0xxxxxxxxx (         x)|
# |      x16, a6 = 0xxxxxxxxx (         x)|
# |      x17, a7 = 0xxxxxxxxx (         x)|
# |      x18, s2 = 0xxxxxxxxx (         x)|
# |      x19, s3 = 0xxxxxxxxx (         x)|
# |      x20, s4 = 0xxxxxxxxx (         x)|
# |      x21, s5 = 0xxxxxxxxx (         x)|
# |      x22, s6 = 0xxxxxxxxx (         x)|
# |      x23, s7 = 0xxxxxxxxx (         x)|
# |      x24, s8 = 0xxxxxxxxx (         x)|
# |      x25, s9 = 0xxxxxxxxx (         x)|
# |     x26, s10 = 0xxxxxxxxx (         x)|
# |     x27, s11 = 0xxxxxxxxx (         x)|
# |      x28, t3 = 0xxxxxxxxx (         x)|
# |      x29, t4 = 0xxxxxxxxx (         x)|
# |      x30, t5 = 0xxxxxxxxx (         x)|
# |      x31, t6 = 0xxxxxxxxx (         x)|
# |---------------------------------------|