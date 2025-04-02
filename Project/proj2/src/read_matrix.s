.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
# Exceptions:
# - If malloc returns an error,
#   this function terminates the program with error code 88.
# - If you receive an fopen error or eof, 
#   this function terminates the program with error code 90.
# - If you receive an fread error or eof,
#   this function terminates the program with error code 91.
# - If you receive an fclose error or eof,
#   this function terminates the program with error code 92.
# ==============================================================================
read_matrix:

    # Prologue
    addi sp, sp, -24
    sw, s0, 0(sp)
    sw, s1, 4(sp)
    sw, s2, 8(sp)
    sw, s3, 12(sp)
    sw, s4, 16(sp)
    sw, s5, 20(sp)
	
    mv s0, a0 # the pointer of filename  
    mv s1, a1 # the pointer to rows num
    mv s2, a2 # the pointer to cols num 

    li a2, 0
    jal fopen
    blt a0, x0, error_90
    mv s3, a0 # the file descriptor

    li a0, 2
    jal malloc
    beq a0, x0, error_88
    mv a2, a0
    mv s4, a2 # the address of buffer
    mv a1, s3 
    li a3, 2
    jal fread
    bne a0, a3, error_91
    lw t0, 0(s4) # num of rows 
    lw t1, 4(s4) # num of cols
    mul s5, t0, t1 # total number of int

    li a0, s5 
    jal malloc
    beq a0, x0, error_90
    mv a2, a0
    mv s4, a2
    mv a1, s3 
    mv a3, s5
    jal fread 
    bne a0, a3, error_91

    mv a1, s3
    jal fclose 
    bne a0, x0, error_92

    mv a0, s4
    mv a1, s1
    mv a2, s2

 
    # Epilogue
    lw, s0, 0(sp)
    lw, s1, 4(sp)
    lw, s2, 8(sp)
    lw, s3, 12(sp)
    lw, s4, 16(sp)
    lw, s5, 20(sp)
    addi sp, sp, 24

    ret
error_88:
	li a1, 88
    jal exit2

error_90:
	li a1, 90
    jal exit2

error_91:
	li a1, 91
    jal exit2
    
error_92:
	li a1, 92
    jal exit2