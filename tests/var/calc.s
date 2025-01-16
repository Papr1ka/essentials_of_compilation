	.align 16
conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.44:
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.45:
    movq %r12, %rbx
    jmp block.44

	.align 16
block.47:
    cmpq %rbx, %r12
    jg block.45
    jmp block.44

	.align 16
block.48:
    movq %r12, %rdi
    callq print_int
    jmp block.47

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
    jg block.48
    movq %rbx, %rdi
    callq print_int
    jmp block.47

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    movq %rsp, %rbp
    subq $0, %rsp
    movq $65536, %rdi
    movq $16, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    addq $0, %r15
    jmp start


