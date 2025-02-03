	.align 16
block.341:
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.342:
    movq %rbx, %rdi
    jmp block.341

	.align 16
main_start:
    callq read_int
    movq %rax, %rbx
    cmpq $5, %rbx
    jle block.342
    callq read_int
    movq %rax, %rdi
    jmp block.341

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


