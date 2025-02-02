	.align 16
block.312:
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.316:
    movq %rdx, %rdi
    callq print_int
    jmp block.312

	.align 16
block.313:
    movq $1, %rdi
    callq print_int
    jmp block.312

	.align 16
block.315:
    movq %rcx, %rdx
    subq %rsi, %rdx
    movq %rsi, %rcx
    movq %rdx, %rsi
    addq $1, %rdi
    jmp block.314

	.align 16
block.314:
    cmpq $0, %rdi
    jl block.315
    jmp block.316

	.align 16
block.318:
    movq %rsi, %rdx
    addq %rcx, %rdx
    movq %rcx, %rsi
    movq %rdx, %rcx
    subq $1, %rdi
    jmp block.317

	.align 16
block.317:
    cmpq $0, %rdi
    jg block.318
    jmp block.316

	.align 16
main_start:
    callq read_int
    movq %rax, %rdi
    movq $0, %rsi
    movq $1, %rcx
    movq $0, %rdx
    cmpq $1, %rdi
    je block.313
    cmpq $0, %rdi
    jl block.314
    subq $1, %rdi
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


