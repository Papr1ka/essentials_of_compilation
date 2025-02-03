	.align 16
block.301:
    addq %rcx, %r12
    subq $1, %rdx
    jmp block.300

	.align 16
block.300:
    cmpq $0, %rdx
    jg block.301
    subq $1, %rbx
    jmp block.299

	.align 16
block.303:
    movq %r12, %rcx
    movq %rbx, %rdx
    movq $0, %r12
    jmp block.300

	.align 16
block.299:
    cmpq $0, %rbx
    jg block.303
    movq %r12, %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
main_start:
    callq read_int
    movq %rax, %rbx
    movq $1, %r12
    jmp block.299

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


