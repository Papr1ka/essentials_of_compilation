	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $80, %rsp
    callq read_int
    movq %rax, -8(%rbp)
    movq $2, -16(%rbp)
    movq -16(%rbp), %rax
    addq -8(%rbp), %rax
    movq %rax, -16(%rbp)
    movq -16(%rbp), %rdi
    callq print_int
    callq read_int
    movq %rax, -24(%rbp)
    movq $3, -32(%rbp)
    movq -32(%rbp), %rax
    subq -24(%rbp), %rax
    movq %rax, -32(%rbp)
    movq -32(%rbp), %rdi
    callq print_int
    callq read_int
    movq %rax, -40(%rbp)
    movq $3, -48(%rbp)
    movq -48(%rbp), %rax
    addq -40(%rbp), %rax
    movq %rax, -48(%rbp)
    movq -48(%rbp), %rdi
    callq print_int
    callq read_int
    movq %rax, -56(%rbp)
    movq -56(%rbp), %rax
    movq %rax, -64(%rbp)
    subq $6, -64(%rbp)
    movq $3, -72(%rbp)
    movq -72(%rbp), %rax
    addq -64(%rbp), %rax
    movq %rax, -72(%rbp)
    movq -72(%rbp), %rdi
    callq print_int
    addq $80, %rsp
    popq %rbp
    retq 

