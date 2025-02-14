.text
    li t0, 5
    li t1, 1
    li t2, 1
    li t3, 1
    li t4, 0
loop:
    sw t1, 0(t4)
    addi t4, t4, 4
    add t5, t1, t2
    addi t1, t2, 0
    addi t2, t5, 0
    addi t3, t3, 1
    bge t0, t3, loop
exit:
