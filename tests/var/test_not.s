	.align 16
conclusion:
    subq $0, %r15
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.140:
    addq %rcx, %rbx
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.141:
    subq $1, %rbx
    jmp block.140

	.align 16
block.143:
    cmpq $0, %rdx
    je block.141
    addq $1, %rcx
    jmp block.140

	.align 16
block.144:
    movq $1, %rdx
    jmp block.143

	.align 16
start:
    callq read_int
    movq %rax, %rcx
    movq $15, %rbx
    addq %rcx, %rbx
    callq read_int
    movq %rax, %rdx
    movq $4, %rcx
    subq %rdx, %rcx
    negq %rcx
    cmpq %rcx, %rbx
    je block.144
    cmpq %rcx, %rbx
    setg %al
    movzbq %al, %rdx
    xorq $1, %rdx
    jmp block.143

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


