	.align 16
conclusion:
    subq $0, %r15
    addq $8, %rsp
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.37:
    movq $0, %rax
    jmp conclusion

	.align 16
block.38:
    movq %r12, %rcx
    addq %r13, %rcx
    movq %r13, %r12
    movq %rcx, %r13
    subq $1, %rbx
    jmp block.37

	.align 16
block.40:
    movq %r12, %rcx
    addq %r13, %rcx
    movq %r13, %r12
    movq %rcx, %r13
    subq $1, %rbx
    cmpq $0, %rbx
    jg block.38
    movq %rcx, %rdi
    callq print_int
    jmp block.37

	.align 16
block.42:
    movq %r12, %rcx
    addq %r13, %rcx
    movq %r13, %r12
    movq %rcx, %r13
    subq $1, %rbx
    cmpq $0, %rbx
    jg block.40
    movq %rcx, %rdi
    callq print_int
    jmp block.37

	.align 16
start:
    callq read_int
    movq %rax, %rbx
    movq $2, %r12
    movq $3, %r13
    movq %r13, %rcx
    cmpq $0, %rbx
    jg block.42
    movq %rcx, %rdi
    callq print_int
    jmp block.37

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    movq %rsp, %rbp
    subq $8, %rsp
    movq $65536, %rdi
    movq $16, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    addq $0, %r15
    jmp start


