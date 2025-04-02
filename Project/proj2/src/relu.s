.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 78.
# ==============================================================================
relu:
    # Prologue
    addi sp, sp, -16
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw ra, 12(sp)

    # Exception handling: If a1 < 1, exit with error code 78
    li t0, 1
    blt a1, t0, error_exit

add s0, x0, a0 # s0 store pointer of array 
add s1, x0, x0 # s1 store the counter

loop_start:
    beq s1, a1, loop_end
    add t0, s1, x0
    addi s1, s1, 1
    slli t0, t0, 2
    add t0, s0, t0
    lw s2, 0(t0) # t0 store the value of ith 
    blt s2, x0, loop_continue
    jal x0, loop_start


loop_continue:
    sw x0, 0(t0)
    jal x0, loop_start


loop_end:
    # Epilogue
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw ra, 12(sp)
    addi sp, sp, 16 
	ret

error_exit:
    li a1, 78
    j exit2
        
