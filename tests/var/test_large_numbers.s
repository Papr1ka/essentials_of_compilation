	.align 16
conclusion:
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
start:
    callq read_int
    movq %rax, %r13
    movq $71854, %r12
    callq read_int
    movq %rax, %r14
    movq %r13, %rcx
    addq %r12, %rcx
    addq %r14, %rcx
    movq %rcx, %rdi
    callq print_int
    movq %r13, %rbx
    movq %r12, %r13
    addq %r14, %r13
    movq %r13, %rdi
    callq print_int
    subq %rbx, %r14
    movq %r14, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    movq %rsp, %rbp
    jmp start


