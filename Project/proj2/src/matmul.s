.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 72.
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 73.
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 74.
# =======================================================
matmul:

    # Error checks
    ble a1, zero, exit_72
    ble a2, zero, exit_72
    ble a4, zero, exit_73
    ble a5, zero, exit_73
	bne a2, a4, exit_74


    # Prologue
    addi sp, sp, -32
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    sw s5, 20(sp)
    sw s6, 24(sp)
    sw ra, 28(sp)

mv s0, a0 # s0 the pointer of m0
mv s1, a1 # s1 the row of m0 
mv s2, a2 # s2 the colums of m0 
mv s3, a3 # s3 the pointer of m1 
mv s4, a4 # s4 the row of m1 
mv s5, a5 # s5 the columns of m1
mv s6, a6 # s6 the pointer of d


li t0, 0 # the counter of outer loop

outer_loop_start:
    beq t0, s1 outer_loop_end
    mul t1, t0, s2 
    slli t1, t1, 2 # the offset of start pointer of m0 
    li t2, 0 # the counter of inner loop


inner_loop_start:
    beq t2, s5, inner_loop_end
    slli t3, t2, 2 # the offset of start pointer of m1
    add a1, t3, s3

    addi sp, sp, -16
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)
    sw t3, 12(sp)

    add a0, t1, s0 
    mv a2, s2 
    addi a3, x0, 1
    mv a4, s5

    jal ra, dot
    sw a0, 0(s6)
    addi s6, s6, 4

    lw t0, 0(sp)
    lw t1, 4(sp)
    lw t2, 8(sp)
    lw t3, 12(sp)
    addi sp, sp, 16
    
    addi t2, t2, 1
    jal x0, inner_loop_start

inner_loop_end:
    addi t0, t0, 1
    jal x0, outer_loop_start

outer_loop_end:

    # Epilogue
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw s4, 16(sp)
    lw s5, 20(sp)
    lw s6, 24(sp)
    lw ra, 28(sp)
    addi sp, sp, 32
    
    ret

exit_72:
    li a1, 72
    j exit2
exit_73:
	li a1, 73
    j exit2
exit_74:
	li a1, 74
    j exit2