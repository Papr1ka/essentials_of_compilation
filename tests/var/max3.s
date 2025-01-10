	.align 16
conclusion:
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.73:
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.74:
    jmp block.73

	.align 16
block.75:
    movq %rcx, %rbx
    jmp block.73

	.align 16
block.76:
    cmpq %rcx, %rbx
    jg block.74
    jmp block.75

	.align 16
block.77:
    jmp block.76

	.align 16
block.78:
    movq %r12, %rbx
    jmp block.76

	.align 16
start:
    callq read_int
    movq %rax, %rbx
    callq read_int
    movq %rax, %r12
    callq read_int
    movq %rax, %rcx
    cmpq %r12, %rbx
    jg block.77
    jmp block.78

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    movq %rsp, %rbp
    jmp start


