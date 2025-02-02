	.align 16
block.279:
    movq %rdx, %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.280:
    movq $2, %rdx
    addq %rcx, %rdx
    jmp block.279

	.align 16
block.281:
    movq $10, %rdx
    addq %rcx, %rdx
    jmp block.279

	.align 16
block.282:
    cmpq $0, %rbx
    je block.280
    jmp block.281

	.align 16
main_start:
    callq read_int
    movq %rax, %rbx
    callq read_int
    movq %rax, %rcx
    cmpq $1, %rbx
    jl block.282
    cmpq $2, %rbx
    je block.280
    jmp block.281

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


