	.align 16
main_start:
    leaq test(%rip), %rcx
    movq $-4, %rdi
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
block.809:
    movq %rcx, %rax
    jmp test_conclusion

	.align 16
block.810:
    movq $2, %rcx
    jmp block.809

	.align 16
test_start:
    movq %rdi, %rcx
    cmpq $0, %rcx
    jg block.810
    movq $3, %rcx
    jmp block.809

	.align 16
test:
    pushq %rbp
    movq %rsp, %rbp
    subq $0, %rsp
    addq $0, %r15
    jmp test_start

	.align 16
test_conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %rbp
    retq 


