	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
start:
    callq read_int
    movq %rax, %rcx
    movq $100, %rdx
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


