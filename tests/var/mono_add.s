	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    movq $1, %rcx
    addq %rcx, %rcx
    movq %rcx, %rdx
    addq %rcx, %rdx
    addq %rdx, %rcx
    movq %rcx, %rdi
    callq print_int
    popq %rbp
    retq 

