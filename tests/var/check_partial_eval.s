	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
start:
    movq $-56, %rdx
    movq $-10, %rcx
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


