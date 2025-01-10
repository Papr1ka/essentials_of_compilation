	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
block.211:
    movq $0, %rax
    jmp conclusion

	.align 16
start:
    movq $0, %rdi
    callq print_int
    jmp block.211

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    jmp start


