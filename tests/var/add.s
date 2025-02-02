	.align 16
main_start:
    leaq add(%rip), %rcx
    movq $40, %rdi
    movq $2, %rsi
    callq *%rcx
    movq %rax, %rcx
    movq %rcx, %rdi
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

	.align 16
add_start:
    movq %rdi, %rdx
    movq %rsi, %rcx
    movq %rdx, %rax
    addq %rcx, %rax
    jmp add_conclusion

	.align 16
add:
    pushq %rbp
    movq %rsp, %rbp
    subq $0, %rsp
    addq $0, %r15
    jmp add_start

	.align 16
add_conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %rbp
    retq 


