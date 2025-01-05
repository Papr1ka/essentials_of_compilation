	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    movq $1, %rcx
    movq $42, %rdx
    movq $7, %rsi
    addq %rcx, %rsi
    movq %rsi, %rcx
    addq %rdx, %rcx
    movq %rsi, %rdx
    negq %rdx
    addq %rdx, %rcx
    movq %rcx, %rdi
    callq print_int
    popq %rbp
    retq 

