	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
start:
    movq $1, %rdx
    movq $42, %rcx
    movq $7, %rsi
    addq %rdx, %rsi
    movq %rsi, %rdx
    addq %rcx, %rsi
    negq %rdx
    addq %rdx, %rsi
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


