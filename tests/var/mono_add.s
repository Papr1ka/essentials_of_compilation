	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
start:
    movq $1, %rcx
    addq %rcx, %rcx
    movq %rcx, %rdx
    addq %rcx, %rdx
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


