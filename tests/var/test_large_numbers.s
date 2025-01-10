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
    movq %rax, %r12
    movq $71854, %r13
    callq read_int
    movq %rax, %rbx
    movq %r12, %rcx
    addq %r13, %rcx
    addq %rbx, %rcx
    movq %rcx, %rdi
    callq print_int
    movq %r12, %r14
    movq %r13, %r12
    addq %rbx, %r12
    movq %r12, %rdi
    callq print_int
    subq %r14, %rbx
    movq %rbx, %rdi
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


