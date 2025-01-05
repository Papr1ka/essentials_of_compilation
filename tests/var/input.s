	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    callq read_int
    movq %rax, %rcx
    movq %rcx, %rdi
    callq print_int
    popq %rbp
    retq 

