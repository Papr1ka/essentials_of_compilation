	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
start:
    callq read_int
    movq %rax, %rcx
    addq $100, %rcx
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


