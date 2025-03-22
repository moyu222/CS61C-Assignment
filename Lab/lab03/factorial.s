.globl factorial

.data
n: .word 8

.text
main:
    la t0, n # *t0 = &n
    lw a0, 0(t0) # a0 = *t0
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
    # YOUR CODE HERE
    li t0, 1           # t0 = 1 (循环终止条件)
    li t2, 1           # t2 = 1 (存储最终结果)

loop:
    ble a0, t0, done   # if (n <= 1) 结束循环
    mul t2, t2, a0     # t2 = t2 * n
    addi a0, a0, -1    # n = n - 1
    j loop             # 继续循环

done:
    mv a0, t2          # 把结果存入 a0
    jr ra              # 返回


factorial1:
    
    # 函数入口，保存返回地址 ra
    addi sp, sp, -8    # 预留栈空间
    sw ra, 4(sp)       # 保存返回地址
    sw a0, 0(sp)       # 保存 n

    # 递归终止条件: if (n == 1) return 1
    li t0, 1           # t0 = 1
    beq a0, t0, base_case

    # 递归调用 factorial(n-1)
    addi a0, a0, -1    # a0 = n - 1
    jal ra, factorial  # 递归调用 factorial(n-1)

    # 计算 n * factorial(n-1)
    lw t1, 0(sp)       # 取回 n
    mul a0, a0, t1     # a0 = n * factorial(n-1)

    # 函数返回，恢复栈
    lw ra, 4(sp)       # 取回 ra
    addi sp, sp, 8     # 恢复栈
    jr ra              # 返回

base_case:
    li a0, 1           # 返回 1
    lw ra, 4(sp)       # 取回 ra
    addi sp, sp, 8     # 恢复栈
    jr ra              # 返回
    