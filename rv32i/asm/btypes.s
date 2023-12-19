addi x1, x0, 10     # x01 = 10
addi x2, x0, -10    # x02 = -10
addi x3, x0, 5      # x03 = 5

# debugging register is x31

beq x0, x0, equal                   # testing equal
    addi x31, x31, 1                
equal: 
    addi x5, x0, 1
    
bne x1, x0, not_equal               # testing not equal
    addi x31, x31, 1
not_equal: 
    addi x6, x0, 2

blt x1, x2, less_than               # testing less than
    addi x31, x31, 1
less_than: 
    addi x7, x0, 3

bge x1, x3, greater_than            # testing greater than
    addi x31, x31, 1
greater_than: 
    addi x8, x0, 4

bltu x3, x1, less_than_unsigned     # testing less than less_than_unsigned
    addi x31, x31, 1
less_than_unsigned: 
    addi x9, x0, 5

bgeu x1, x3, greater_than_unsigned  # testing greater than unsigned
    addi x31, x31, 1
greater_than_unsigned: 
    addi x10, x0, 6

infinite_loop: beq x0, x0, infinite_loop

|--------------------|
| Register File State|
|--------------------|
|    x00, zero = 0   |
|      x01, ra = 10  |
|      x02, sp = -10 |
|      x03, gp = 5   |
|      x04, tp = x   |
|      x05, t0 = 1   |
|      x06, t1 = 2   |
|      x07, t2 = 3   |
|      x08, s0 = 4   |
|      x09, s1 = 5   |
|      x10, a0 = 6   |
|       x11-31 = x   |
|--------------------|
