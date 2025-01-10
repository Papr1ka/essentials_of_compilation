	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
start:
    movq $1, %rdx
    movq $42, %rsi
    addq $7, %rdx
    movq %rdx, %rcx
    addq %rsi, %rcx
    negq %rdx
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
    jmp start


