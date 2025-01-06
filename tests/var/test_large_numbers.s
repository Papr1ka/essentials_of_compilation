	.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    callq read_int
    movq %rax, %rbx
    movq $71854, %r12
    callq read_int
    movq %rax, %r13
    movq %rbx, %rcx
    addq %r12, %rcx
    addq %r13, %rcx
    movq %rcx, %rdi
    callq print_int
    movq %rbx, %r14
    movq %r12, %rbx
    addq %r13, %rbx
    movq %rbx, %rdi
    callq print_int
    subq %r14, %r13
    movq %r13, %rdi
    callq print_int
    popq %rbp
    retq 

