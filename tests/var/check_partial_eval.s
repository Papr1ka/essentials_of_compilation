	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
start:
    movq $100, %rcx
    addq $4, %rcx
    movq $48, %rdx
    subq %rcx, %rdx
    movq $6, %rsi
    addq $7, %rsi
    movq $5, %rcx
    subq %rsi, %rcx
    movq $2, %rsi
    addq %rcx, %rsi
    subq $4, %rsi
    movq %rsi, %rcx
    addq %rdx, %rcx
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


