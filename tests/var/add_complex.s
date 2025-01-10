	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
start:
    callq read_int
    movq %rax, %rdx
    movq $1, %rsi
    negq %rsi
    addq $3, %rsi
    addq $400, %rsi
    movq $5, %rcx
    addq %rsi, %rcx
    negq %rcx
    addq %rcx, %rdx
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


