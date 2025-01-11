	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
start:
    movq $1, %rsi
    movq $42, %rdx
    movq $7, %rcx
    addq %rsi, %rcx
    movq %rcx, %rsi
    addq %rdx, %rsi
    negq %rcx
    addq %rcx, %rsi
    movq %rsi, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    jmp start


