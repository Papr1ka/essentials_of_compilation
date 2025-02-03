	.align 16
main_start:
    callq read_int
    movq %rax, %r12
    leaq tail_sum(%rip), %rbx
    movq $3, %rdi
    movq $0, %rsi
    callq *%rbx
    movq %rax, %rdi
    addq %r12, %rdi
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
    movq %rdx, %rax
    jmp tail_sum_conclusion

	.align 16
tail_sum_start:
    movq %rdi, %r8
    movq %rsi, %rdx
    cmpq $0, %r8
    je block.804
    leaq tail_sum(%rip), %rcx
    movq %r8, %rdi
    subq $1, %rdi
    movq %r8, %rsi
    addq %rdx, %rsi
    movq %rcx, %rax
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


