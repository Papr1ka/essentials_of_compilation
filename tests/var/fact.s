	.align 16
main_start:
    movq $1, %rdi
    addq %rdi, %rdi
    movq %rdi, %rcx
    addq %rdi, %rcx
    addq %rcx, %rdi
    movq %rdi, %rcx
    addq %rdi, %rcx
    movq %rcx, %rdi
    addq %rcx, %rdi
    movq %rdi, %rcx
    addq %rdi, %rcx
    addq %rcx, %rcx
    addq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

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


