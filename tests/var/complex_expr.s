	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $48, %rsp
    callq read_int
    movq %rax, -8(%rbp)
    callq read_int
    movq %rax, -16(%rbp)
    movq $8, -24(%rbp)
    movq -24(%rbp), %rax
    addq -8(%rbp), %rax
    movq %rax, -24(%rbp)
    movq $-2, -32(%rbp)
    movq -32(%rbp), %rax
    addq -16(%rbp), %rax
    movq %rax, -32(%rbp)
    movq -24(%rbp), %rax
    movq %rax, -40(%rbp)
    movq -40(%rbp), %rax
    subq -32(%rbp), %rax
    movq %rax, -40(%rbp)
    movq $-3, -48(%rbp)
    movq -48(%rbp), %rax
    addq -40(%rbp), %rax
    movq %rax, -48(%rbp)
    movq -48(%rbp), %rdi
    callq print_int
    addq $48, %rsp
    popq %rbp
    retq 

