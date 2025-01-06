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
    subq %rcx, %rbx
    movq %rbx, %rdi
    callq print_int
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 

