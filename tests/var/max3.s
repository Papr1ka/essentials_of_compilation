	.align 16
conclusion:
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.50:
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.51:
    jmp block.50

	.align 16
block.53:
    cmpq %rcx, %rbx
    jg block.51
    movq %rcx, %rbx
    jmp block.50

	.align 16
block.54:
    jmp block.53

	.align 16
start:
    callq read_int
    movq %rax, %rbx
    callq read_int
    movq %rax, %r12
    callq read_int
    movq %rax, %rcx
    cmpq %r12, %rbx
    jg block.54
    movq %r12, %rbx
    jmp block.53

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    movq %rsp, %rbp
    jmp start


