	.align 16
block.289:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.290:
    negq %rcx
    jmp block.289

	.align 16
block.291:
    movq $4, %rcx
    jmp block.290

	.align 16
block.293:
    cmpq $2, %rbx
    je block.291
    movq %rbx, %rcx
    subq $2, %rcx
    jmp block.290

	.align 16
block.295:
    callq read_int
    movq %rax, %rcx
    cmpq $4, %rcx
    je block.293
    movq $1, %rcx
    jmp block.289

	.align 16
block.296:
    callq read_int
    movq %rax, %rcx
    cmpq $127, %rcx
    jl block.293
    jmp block.295

	.align 16
main_start:
    movq $8, %rbx
    callq read_int
    movq %rax, %rcx
    cmpq $6, %rcx
    setg %al
    movzbq %al, %rcx
    cmpq $0, %rcx
    je block.296
    jmp block.295

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


