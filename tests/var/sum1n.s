	.align 16
block.715:
    addq %rbx, %r12
    subq $1, %rbx
    jmp block.714

	.align 16
block.714:
    cmpq $0, %rbx
    jg block.715
    movq %r12, %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
main_start:
    movq $0, %r12
    callq read_int
    movq %rax, %rbx
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


