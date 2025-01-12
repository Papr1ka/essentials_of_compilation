	.align 16
conclusion:
    addq $8, %rsp
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.172:
    movq $0, %rax
    jmp conclusion

	.align 16
block.173:
    movq $0, %rdi
    callq print_int
    jmp block.172

	.align 16
block.176:
    xorq $1, %r12
    addq $1, %r13
    jmp block.175

	.align 16
block.175:
    cmpq %rbx, %r13
    jl block.176
    cmpq $0, %r12
    je block.173
    movq $1, %rdi
    callq print_int
    jmp block.172

	.align 16
start:
    callq read_int
    movq %rax, %rbx
    movq $1, %r12
    movq $0, %r13
    jmp block.175

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    movq %rsp, %rbp
    subq $8, %rsp
    jmp start


