	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
start:
    movq $100, %rdx
    addq $4, %rdx
    movq $48, %rcx
    subq %rdx, %rcx
    movq $6, %rdx
    addq $7, %rdx
    movq $5, %rsi
    subq %rdx, %rsi
    movq $2, %rdx
    addq %rsi, %rdx
    subq $4, %rdx
    addq %rcx, %rdx
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


