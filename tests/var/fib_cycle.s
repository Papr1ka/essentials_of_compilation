	.align 16
block.312:
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.316:
    callq print_int
    jmp block.312

	.align 16
block.313:
    movq $1, %rdi
    callq print_int
    jmp block.312

	.align 16
block.315:
    movq %rdx, %rdi
    subq %rsi, %rdi
    movq %rsi, %rdx
    movq %rdi, %rsi
    addq $1, %rcx
    jmp block.314

	.align 16
block.314:
    cmpq $0, %rcx
    jl block.315
    jmp block.316

	.align 16
block.318:
    movq %rsi, %rdi
    addq %rdx, %rdi
    movq %rdx, %rsi
    movq %rdi, %rdx
    subq $1, %rcx
    jmp block.317

	.align 16
block.317:
    cmpq $0, %rcx
    jg block.318
    jmp block.316

	.align 16
main_start:
    callq read_int
    movq %rax, %rcx
    movq $0, %rsi
    movq $1, %rdx
    movq $0, %rdi
    cmpq $1, %rcx
    je block.313
    cmpq $0, %rcx
    jl block.314
    subq $1, %rcx
    jmp block.317

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


