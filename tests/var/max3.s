	.align 16
conclusion:
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.73:
    movq %r12, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.74:
    jmp block.73

	.align 16
block.76:
    cmpq %rcx, %r12
    jg block.74
    movq %rcx, %r12
    jmp block.73

	.align 16
block.77:
    jmp block.76

	.align 16
start:
    callq read_int
    movq %rax, %r12
    callq read_int
    movq %rax, %rbx
    callq read_int
    movq %rax, %rcx
    cmpq %rbx, %r12
    jg block.77
    movq %rbx, %r12
    jmp block.76

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    movq %rsp, %rbp
    jmp start


