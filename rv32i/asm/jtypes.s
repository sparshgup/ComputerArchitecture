# for (int i = 9; i >= 0; i--)

addi x4, zero, 9   # x04 = 9

LOOP_START: addi x1, zero, 1
            addi x2, zero, 2
            add  x3, zero, x1

NOT_TAKEN:  beq x1, x2, INVALID 
            addi x4, x4, -1      # i--
            beq  x4, zero, END   # i==0

            # for testing jal, use: jal zero, LOOP_START (also j LOOP_START)
            # for testing jalr, use: jalr x10, zero, 4

            jal zero, LOOP_START # go back to LOOP_START. 

END:        beq x1, x3, END

INVALID:    nop

|--------------------|
| Register File State|
|--------------------|
|    x00, zero = (0) |
|      x01, ra = (1) |
|      x02, sp = (2) |
|      x03, gp = (1) |
|      x04, tp = (0) |
|      x10     = (x) | # if testing jal
|      x10     = (32)| # if testing jalr
|--------------------|