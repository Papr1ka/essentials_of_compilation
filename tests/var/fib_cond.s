	.align 16
block.305:
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.306:
    movq %r13, %rcx
    addq %rbx, %rcx
    movq %rbx, %r13
    movq %rcx, %rbx
    subq $1, %r12
    jmp block.305

	.align 16
block.308:
    movq %r13, %rcx
    addq %rbx, %rcx
    movq %rbx, %r13
    movq %rcx, %rbx
    subq $1, %r12
    cmpq $0, %r12
    jg block.306
    movq %rcx, %rdi
    callq print_int
    jmp block.305

	.align 16
block.310:
    movq %r13, %rcx
    addq %rbx, %rcx
    movq %rbx, %r13
    movq %rcx, %rbx
    subq $1, %r12
    cmpq $0, %r12
    jg block.308
    movq %rcx, %rdi
    callq print_int
    jmp block.305

	.align 16
main_start:
    callq read_int
    movq %rax, %r12
    movq $2, %r13
    movq $3, %rbx
    movq %rbx, %rcx
    cmpq $0, %r12
    jg block.310
    movq %rcx, %rdi
    callq print_int
    jmp block.305

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


