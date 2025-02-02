	.align 16
block.715:
    addq %r12, %rbx
    subq $1, %r12
    jmp block.714

	.align 16
block.714:
    cmpq $0, %r12
    jg block.715
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
main_start:
    movq $0, %rbx
    callq read_int
    movq %rax, %r12
    jmp block.714

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
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
    popq %r12
    popq %rbx
    popq %rbp
    retq 


