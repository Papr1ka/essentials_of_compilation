	.align 16
conclusion:
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.67:
    movq %r12, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.68:
    jmp block.67

	.align 16
block.69:
    movq %rbx, %r12
    jmp block.67

	.align 16
block.70:
    cmpq %rbx, %r12
    jg block.68
    jmp block.69

	.align 16
block.71:
    movq %r12, %rdi
    callq print_int
    jmp block.70

	.align 16
block.72:
    movq %rbx, %rdi
    callq print_int
    jmp block.70

	.align 16
start:
    callq read_int
    movq %rax, %rbx
    callq read_int
    movq %rax, %rcx
    movq %rbx, %r12
    addq %rcx, %r12
    subq %rcx, %rbx
    cmpq %rbx, %r12
    jg block.71
    jmp block.72

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    movq %rsp, %rbp
    jmp start


