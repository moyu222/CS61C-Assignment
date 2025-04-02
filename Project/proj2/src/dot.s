.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 75.
# - If the stride of either vector is less than 1,
#   this function terminates the program with error code 76.
# =======================================================
dot:

    # Prologue
    addi sp, sp, -16
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw ra, 12(sp)

 # Exception handling: If a2 < 1, exit with error code 75 if a3,a4 < 1, error with code 76
    li t0, 1
    blt a2, t0, length_error
    blt a3, t0, stride_error
    blt a4, t0, stride_error

li s0, 0 # s0 is the counter
mv s1, a0 # s1 is the pointer of v0 
mv s2, a1 # s2 is the pointer of v1
li a0, 0

loop_start:
    beq s0, a2, loop_end
    mv t0, s0
    mv t1, s0 # t0 for v0, t1 for v1 
    addi s0, s0, 1
    mul t0, t0, a3
    mul t1, t1, a4
    slli t0, t0, 2
    slli t1, t1, 2
    add t0, t0, s1 
    add t1, t1, s2
    lw t2, 0(t0) # t2 = v0[i]
    lw t3, 0(t1) # t3 = v1[i]
    mul t4, t2, t3 
    add a0, a0 ,t4
    jal x0, loop_start

loop_end:
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw ra, 12(sp)
    addi sp, sp, 16
    # Epilogue

    
    ret
length_error:
    li a1, 75
    j exit2

stride_error:
    li a1, 76
    j exit2

