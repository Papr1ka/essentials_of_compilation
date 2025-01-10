	.align 16
conclusion:
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.67:
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.68:
    jmp block.67

	.align 16
block.70:
    cmpq %r12, %rbx
    jg block.68
    movq %r12, %rbx
    jmp block.67

	.align 16
block.71:
    movq %rbx, %rdi
    callq print_int
    jmp block.70

	.align 16
start:
    callq read_int
    movq %rax, %r12
    callq read_int
    movq %rax, %rcx
    movq %r12, %rbx
    addq %rcx, %rbx
    subq %rcx, %r12
    cmpq %r12, %rbx
    jg block.71
    movq %r12, %rdi
    callq print_int
    jmp block.70

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    movq %rsp, %rbp
    jmp start


