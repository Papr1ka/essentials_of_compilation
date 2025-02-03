	.align 16
block.380:
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.381:
    movq $0, %rdi
    callq print_int
    jmp block.380

	.align 16
block.384:
    xorq $1, %rbx
    addq $1, %r12
    jmp block.383

	.align 16
block.383:
    cmpq %r13, %r12
    jl block.384
    cmpq $0, %rbx
    je block.381
    movq $1, %rdi
    callq print_int
    jmp block.380

	.align 16
main_start:
    callq read_int
    movq %rax, %r13
    movq $1, %rbx
    movq $0, %r12
    jmp block.383

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
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
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 


