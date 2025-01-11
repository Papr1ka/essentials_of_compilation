	.align 16
conclusion:
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 

	.align 16
start:
    callq read_int
    movq %rax, %rbx
    callq read_int
    movq %rax, %rcx
    movq $8, %rdx
    addq %rbx, %rdx
    movq $-2, %rsi
    addq %rcx, %rsi
    subq %rsi, %rdx
    movq $-3, %rcx
    addq %rdx, %rcx
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    movq %rsp, %rbp
    subq $8, %rsp
    jmp start


