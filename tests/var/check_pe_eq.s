	.align 16
block.266:
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.267:
    movq $1, %rdi
    callq print_int
    jmp block.266

	.align 16
block.269:
    cmpq $-6, %rbx
    jg block.267
    movq $0, %rdi
    callq print_int
    jmp block.266

	.align 16
block.270:
    movq $1, %rdi
    callq print_int
    jmp block.269

	.align 16
block.272:
    cmpq $10, %rbx
    jle block.270
    movq $0, %rdi
    callq print_int
    jmp block.269

	.align 16
block.273:
    movq $1, %rdi
    callq print_int
    jmp block.272

	.align 16
main_start:
    movq $10, %rbx
    movq $1, %rax
    cmpq %rbx, %rax
    je block.273
    movq $0, %rdi
    callq print_int
    jmp block.272

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


