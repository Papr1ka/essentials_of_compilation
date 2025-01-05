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
    movq %rdx, %rcx
    subq %rsi, %rcx
    movq $-3, %rdx
    addq %rcx, %rdx
    movq %rdx, %rdi
    callq print_int
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 

