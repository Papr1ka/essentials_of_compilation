	.align 16
conclusion:
    subq $0, %r15
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.116:
    movq %rdx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.117:
    movq $2, %rdx
    addq %rcx, %rdx
    jmp block.116

	.align 16
block.118:
    movq $10, %rdx
    addq %rcx, %rdx
    jmp block.116

	.align 16
block.119:
    cmpq $0, %rbx
    je block.117
    jmp block.118

	.align 16
start:
    callq read_int
    movq %rax, %rbx
    callq read_int
    movq %rax, %rcx
    cmpq $1, %rbx
    jl block.119
    cmpq $2, %rbx
    je block.117
    jmp block.118

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    movq %rsp, %rbp
    subq $8, %rsp
    movq $65536, %rdi
    movq $16, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    addq $0, %r15
    jmp start


