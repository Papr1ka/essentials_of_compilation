	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
block.34:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.35:
    jmp block.34

	.align 16
start:
    callq read_int
    movq %rax, %rcx
    cmpq $5, %rcx
    jle block.35
    callq read_int
    movq %rax, %rcx
    jmp block.34

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    jmp start


