	.align 16
main_start:
    callq read_int
    movq %rax, %r13
    movq $71854, %r12
    callq read_int
    movq %rax, %rbx
    movq %r13, %rdi
    addq %r12, %rdi
    addq %rbx, %rdi
    callq print_int
    movq %r13, %r14
    movq %r12, %r13
    addq %rbx, %r13
    movq %r13, %rdi
    callq print_int
    subq %r14, %rbx
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    movq %rsp, %rbp
    subq $0, %rsp
    movq $65536, %rdi
    movq $16, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    addq $0, %r15
    jmp main_start

	.align 16
main_conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 


