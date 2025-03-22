.globl main

.data
source:
    .word   3
    .word   1
    .word   4
    .word   1
    .word   5
    .word   9
    .word   0
dest:
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0

.text
# a0, pass and return; t1 t0 as temp
fun:
    addi t0, a0, 1 # a0 stores x, t0 = x + 1
    sub t1, x0, a0 # t1 = -x
    mul a0, t0, t1 # a0 as return
    jr ra

main:
    # BEGIN PROLOGUE
    # s0 sum
    # s1 pointer of source first int 
    # s2 pointer of dest first int
    # s3 offset of int in source
    # ra 
    # t0 k
    # t1 the pointer of source element and temp in fun
    # t2 the element in source -> t1
    # t3 the pointer of dest element
    # a0 parameter of fun source[k] and return of func
    
    addi sp, sp, -20
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw ra, 16(sp)
    # END PROLOGUE
    addi t0, x0, 0 # t0 = 0
    addi s0, x0, 0 # s0 = 0
    la s1, source # pointer of source 1st num
    la s2, dest # pointer of dest
loop:
    slli s3, t0, 2 # s3 = 4k as sizeof int
    add t1, s1, s3 # t1 is the pointer of source reset every loop
    lw t2, 0(t1) # t2 store source[k]
    beq t2, x0, exit # != 0
    add a0, x0, t2 # pass by value. a0 stores source[k]
    addi sp, sp, -8 # fun take a0 and t0
    sw t0, 0(sp)
    sw t2, 4(sp)
    jal fun
    lw t0, 0(sp)
    lw t2, 4(sp)
    addi sp, sp, 8 # reset stack
    add t2, x0, a0 # t2 = fun(source[k])
    add t3, s2, s3 # t3 = pointer of dest kth element
    sw t2, 0(t3) # dest[k] = fun(source[k])
    add s0, s0, t2 # s0 = sum sum += dest[k]
    addi t0, t0, 1 # k++
    jal x0, loop
exit:
    add a0, x0, s0 # a0 as return a0 = sum
    # BEGIN EPILOGUE
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20
    # END EPILOGUE
    jr ra
