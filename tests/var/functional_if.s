	.align 16
conclusion:
    subq $0, %r15
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.34:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.35:
    movq %rbx, %rcx
    jmp block.34

	.align 16
start:
    callq read_int
    movq %rax, %rbx
    cmpq $5, %rbx
    jle block.35
    callq read_int
    movq %rax, %rcx
    jmp block.34

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
    jmp start


