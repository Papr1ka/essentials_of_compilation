	.align 16
block.719:
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.720:
    movq $42, %rdi
    jmp block.719

	.align 16
main_start:
    callq read_int
    movq %rax, %rcx
    cmpq $1, %rcx
    je block.720
    movq $0, %rdi
    jmp block.719

	.globl main
	.align 16
main:
    pushq %rbp
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
    popq %rbp
    retq 


