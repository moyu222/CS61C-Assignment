.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 77.
# =================================================================
argmax:

    # Prologue
    addi sp, sp, -20
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw ra, 16(sp)

 # Exception handling: If a1 < 1, exit with error code 78
    li t0, 1
    blt a1, t0, error_exit

add s0, a0, x0 # s0 the pointer of first item
add s1, x0, x0 # s1 the counter 
lw s2, 0(s0) # arr[0] as smallest
li s3, 0 # index of smallest

loop_start:
    beq s1, a1, loop_end
    add t0, s1, x0 
    slli t0, t0, 2
    add t0, t0, s0 
    addi s1, s1, 1
    lw t1, 0(t0)
    blt t1, s2, loop_continue # arr[i] < prev smallest
    jal x0, loop_start



loop_continue:
    mv s2, t1
    mv s3, s1 # update the index
    jal x0, loop_start


loop_end:
    mv a0, s3
    # Epilogue
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20

    ret

error_exit:
    li a1, 77
    j exit2    
