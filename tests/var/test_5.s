	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
block.160:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.161:
    movq $42, %rcx
    jmp block.160

	.align 16
start:
    callq read_int
    movq %rax, %rcx
    cmpq $1, %rcx
    je block.161
    movq $0, %rcx
    jmp block.160

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    jmp start


