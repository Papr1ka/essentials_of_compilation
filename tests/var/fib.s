	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    movq $1, %rcx
    movq $1, %rbx
    movq %rcx, %r12
    addq %rbx, %r12
    movq %r12, %rdi
    callq print_int
    movq %rbx, %rcx
    movq %r12, %rbx
    movq %rcx, %r12
    addq %rbx, %r12
    movq %r12, %rdi
    callq print_int
    movq %rbx, %rcx
    movq %r12, %rbx
    movq %rcx, %r12
    addq %rbx, %r12
    movq %r12, %rdi
    callq print_int
    movq %rbx, %rcx
    movq %r12, %rbx
    movq %rcx, %r12
    addq %rbx, %r12
    movq %r12, %rdi
    callq print_int
    movq %rbx, %rcx
    movq %r12, %rbx
    movq %rcx, %r12
    addq %rbx, %r12
    movq %r12, %rdi
    callq print_int
    popq %rbp
    retq 

