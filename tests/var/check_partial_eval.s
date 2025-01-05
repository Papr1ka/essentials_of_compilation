	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    movq $-56, %rcx
    movq $-10, %rdx
    addq %rcx, %rdx
    addq %rcx, %rdx
    movq %rdx, %rdi
    callq print_int
    popq %rbp
    retq 

