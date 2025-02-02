	.align 16
block.301:
    addq %rdx, %rbx
    subq $1, %rcx
    jmp block.300

	.align 16
block.300:
    cmpq $0, %rcx
    jg block.301
    subq $1, %r12
    jmp block.299

	.align 16
block.303:
    movq %rbx, %rdx
    movq %r12, %rcx
    movq $0, %rbx
    jmp block.300

	.align 16
block.299:
    cmpq $0, %r12
    jg block.303
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
main_start:
    callq read_int
    movq %rax, %r12
    movq $1, %rbx
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


