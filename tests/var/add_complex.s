	.align 16
conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %rbp
    retq 

	.align 16
start:
    callq read_int
    movq %rax, %rdx
    movq $-407, %rcx
    addq %rdx, %rcx
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

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
    jmp start


