	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $64, %rsp
    callq read_int
    movq %rax, -8(%rbp)
    movq $71854, %rax
    movq %rax, -16(%rbp)
    callq read_int
    movq %rax, -24(%rbp)
    movq -8(%rbp), %rax
    movq %rax, -32(%rbp)
    movq -32(%rbp), %rax
    addq -16(%rbp), %rax
    movq %rax, -32(%rbp)
    movq -32(%rbp), %rax
    movq %rax, -40(%rbp)
    movq -40(%rbp), %rax
    addq -24(%rbp), %rax
    movq %rax, -40(%rbp)
    movq -40(%rbp), %rdi
    callq print_int
    movq -8(%rbp), %rax
    movq %rax, -48(%rbp)
    movq -16(%rbp), %rax
    movq %rax, -8(%rbp)
    movq -8(%rbp), %rax
    addq -24(%rbp), %rax
    movq %rax, -8(%rbp)
    movq -8(%rbp), %rdi
    callq print_int
    movq -24(%rbp), %rax
    movq %rax, -56(%rbp)
    movq -56(%rbp), %rax
    subq -48(%rbp), %rax
    movq %rax, -56(%rbp)
    movq -56(%rbp), %rdi
    callq print_int
    addq $64, %rsp
    popq %rbp
    retq 

