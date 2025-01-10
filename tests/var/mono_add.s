	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
start:
    movq $1, %rdx
    addq %rdx, %rdx
    movq %rdx, %rcx
    addq %rdx, %rcx
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


