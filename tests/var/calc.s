	.align 16
conclusion:
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.44:
    movq %r12, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.45:
    movq %rbx, %r12
    jmp block.44

	.align 16
block.47:
    cmpq %r12, %rbx
    jg block.45
    jmp block.44

	.align 16
block.48:
    movq %rbx, %rdi
    callq print_int
    jmp block.47

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
    jg block.48
    movq %r12, %rdi
    callq print_int
    jmp block.47

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    movq %rsp, %rbp
    jmp start


