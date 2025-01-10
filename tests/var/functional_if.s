	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
block.57:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.58:
    jmp block.57

	.align 16
start:
    callq read_int
    movq %rax, %rcx
    cmpq $5, %rcx
    jle block.58
    callq read_int
    movq %rax, %rcx
    jmp block.57

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    jmp start


