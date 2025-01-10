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
    movq $6, %rcx
    addq $7, %rcx
    movq $5, %rsi
    subq %rcx, %rsi
    movq $2, %rcx
    addq %rsi, %rcx
    subq $4, %rcx
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


