	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    callq read_int
    movq %rax, %rcx
    movq $2, %rdx
    addq %rcx, %rdx
    movq %rdx, %rdi
    callq print_int
    callq read_int
    movq %rax, %rcx
    movq $3, %rdx
    subq %rcx, %rdx
    movq %rdx, %rdi
    callq print_int
    callq read_int
    movq %rax, %rcx
    movq $3, %rdx
    addq %rcx, %rdx
    movq %rdx, %rdi
    callq print_int
    callq read_int
    movq %rax, %rcx
    subq $6, %rcx
    movq $3, %rdx
    addq %rcx, %rdx
    movq %rdx, %rdi
    callq print_int
    popq %rbp
    retq 

