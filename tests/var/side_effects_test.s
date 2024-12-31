	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    callq read_int
    movq %rax, -8(%rbp)
    callq read_int
    movq %rax, -16(%rbp)
    callq read_int
    movq %rax, -24(%rbp)
    movq -8(%rbp), %rax
    movq %rax, -32(%rbp)
    movq -32(%rbp), %rax
    addq -24(%rbp), %rax
    movq %rax, -32(%rbp)
    movq -32(%rbp), %rdi
    callq print_int
    addq $32, %rsp
    popq %rbp
    retq 

