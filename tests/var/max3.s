	.align 16
block.638:
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.639:
    jmp block.638

	.align 16
block.641:
    cmpq %rcx, %rdi
    jg block.639
    movq %rcx, %rdi
    jmp block.638

	.align 16
block.642:
    movq %r12, %rdi
    jmp block.641

	.align 16
main_start:
    callq read_int
    movq %rax, %r12
    callq read_int
    movq %rax, %rbx
    callq read_int
    movq %rax, %rcx
    cmpq %rbx, %r12
    jg block.642
    movq %rbx, %rdi
    jmp block.641

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


