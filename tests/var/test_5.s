	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
block.208:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.209:
    movq $42, %rcx
    jmp block.208

	.align 16
block.210:
    movq $0, %rcx
    jmp block.208

	.align 16
start:
    callq read_int
    movq %rax, %rcx
    cmpq $1, %rcx
    je block.209
    jmp block.210

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    jmp start


