	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    callq read_int
    movq %rax, %rcx
    movq $100, %rdx
    addq %rcx, %rdx
    movq %rdx, %rdi
    callq print_int
    popq %rbp
    retq 

