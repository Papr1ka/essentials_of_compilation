	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
start:
    callq read_int
    movq %rax, %rdx
    movq $1, %rcx
    negq %rcx
    addq $3, %rcx
    addq $400, %rcx
    movq $5, %rsi
    addq %rcx, %rsi
    negq %rsi
    addq %rsi, %rdx
    movq %rdx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    jmp start


