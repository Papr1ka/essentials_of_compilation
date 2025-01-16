	.align 16
conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.50:
    movq %r12, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.51:
    jmp block.50

	.align 16
block.53:
    cmpq %rcx, %r12
    jg block.51
    movq %rcx, %r12
    jmp block.50

	.align 16
block.54:
    movq %rbx, %r12
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
    jmp block.53

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


