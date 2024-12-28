	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    movq $1, -8(%rbp)
    movq $1, -16(%rbp)
    movq -8(%rbp), %rax
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rax
    addq -16(%rbp), %rax
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rdi
    callq print_int
    movq -16(%rbp), %rax
    movq %rax, -8(%rbp)
    movq -24(%rbp), %rax
    movq %rax, -16(%rbp)
    movq -8(%rbp), %rax
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rax
    addq -16(%rbp), %rax
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rdi
    callq print_int
    movq -16(%rbp), %rax
    movq %rax, -8(%rbp)
    movq -24(%rbp), %rax
    movq %rax, -16(%rbp)
    movq -8(%rbp), %rax
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rax
    addq -16(%rbp), %rax
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rdi
    callq print_int
    movq -16(%rbp), %rax
    movq %rax, -8(%rbp)
    movq -24(%rbp), %rax
    movq %rax, -16(%rbp)
    movq -8(%rbp), %rax
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rax
    addq -16(%rbp), %rax
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rdi
    callq print_int
    movq -16(%rbp), %rax
    movq %rax, -8(%rbp)
    movq -24(%rbp), %rax
    movq %rax, -16(%rbp)
    movq -8(%rbp), %rax
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rax
    addq -16(%rbp), %rax
    movq %rax, -24(%rbp)
    movq -24(%rbp), %rdi
    callq print_int
    addq $32, %rsp
    popq %rbp
    retq 

