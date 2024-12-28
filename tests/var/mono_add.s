	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq $1, -8(%rbp)
    movq -8(%rbp), %rax
    addq -8(%rbp), %rax
    movq %rax, -8(%rbp)
    movq -8(%rbp), %rax
    movq %rax, -16(%rbp)
    movq -16(%rbp), %rax
    addq -8(%rbp), %rax
    movq %rax, -16(%rbp)
    movq -8(%rbp), %rax
    addq -16(%rbp), %rax
    movq %rax, -8(%rbp)
    movq -8(%rbp), %rdi
    callq print_int
    addq $16, %rsp
    popq %rbp
    retq 

