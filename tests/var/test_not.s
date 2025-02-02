	.align 16
block.742:
    addq %rcx, %rbx
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.743:
    subq $1, %rbx
    jmp block.742

	.align 16
block.745:
    cmpq $0, %rdx
    je block.743
    addq $1, %rcx
    jmp block.742

	.align 16
block.746:
    movq $1, %rdx
    jmp block.745

	.align 16
main_start:
    callq read_int
    movq %rax, %rcx
    movq $15, %rbx
    addq %rcx, %rbx
    callq read_int
    movq %rax, %rdx
    movq $4, %rcx
    subq %rdx, %rcx
    negq %rcx
    cmpq %rcx, %rbx
    je block.746
    cmpq %rcx, %rbx
    setg %al
    movzbq %al, %rdx
    xorq $1, %rdx
    jmp block.745

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


