	.align 16
block.708:
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.709:
    movq %rbx, %rdi
    callq print_int
    jmp block.708

	.align 16
main_start:
    movq $2, %rbx
    callq read_int
    movq %rax, %rcx
    cmpq %rcx, %rbx
    je block.709
    movq %rcx, %rdi
    callq print_int
    jmp block.708

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    movq %rsp, %rbp
    subq $8, %rsp
    movq $65536, %rdi
    movq $16, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    addq $0, %r15
    jmp main_start

	.align 16
main_conclusion:
    subq $0, %r15
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 


