	.align 16
block.699:
    subq %rbx, %r12
    jmp block.698

	.align 16
block.701:
    cmpq %rbx, %r12
    jg block.699
    subq %r12, %rbx
    jmp block.698

	.align 16
block.698:
    cmpq %rbx, %r12
    jne block.701
    movq %r12, %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
main_start:
    movq $2184, %r12
    movq $140, %rbx
    jmp block.698

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


