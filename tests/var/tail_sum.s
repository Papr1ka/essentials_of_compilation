	.align 16
main_start:
    callq read_int
    movq %rax, %r12
    leaq tail_sum(%rip), %rbx
    movq $3, %rdi
    movq $0, %rsi
    callq *%rbx
    movq %rax, %rcx
    addq %r12, %rcx
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

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

	.align 16
block.804:
    movq %rcx, %rax
    jmp tail_sum_conclusion

	.align 16
tail_sum_start:
    movq %rsi, %rcx
    cmpq $0, %rdi
    je block.804
    leaq tail_sum(%rip), %rdx
    movq %rdi, %r8
    subq $1, %r8
    movq %rdi, %rsi
    addq %rcx, %rsi
    movq %r8, %rdi
    movq %rdx, %rax
    subq $0, %r15
    addq $0, %rsp
    popq %rbp
    jmp *%rax

	.align 16
tail_sum:
    pushq %rbp
    movq %rsp, %rbp
    subq $0, %rsp
    addq $0, %r15
    jmp tail_sum_start

	.align 16
tail_sum_conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %rbp
    retq 


