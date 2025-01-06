	.globl main
main:
    pushq %rbp
    pushq %rbx
    movq %rsp, %rbp
    subq $8, %rsp
    callq read_int
    movq %rax, %rbx
    callq read_int
    movq %rax, %rcx
    movq $8, %rdx
    addq %rbx, %rdx
    movq $-2, %rsi
    addq %rcx, %rsi
    subq %rsi, %rdx
    movq $-3, %rcx
    addq %rdx, %rcx
    movq %rcx, %rdi
    callq print_int
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 

