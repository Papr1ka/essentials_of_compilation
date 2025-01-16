	.align 16
conclusion:
    subq $0, %r15
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.149:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.150:
    movq $0, %rcx
    jmp block.149

	.align 16
block.152:
    xorq $1, %rcx
    xorq $1, %rcx
    cmpq $0, %rcx
    je block.150
    movq $1, %rcx
    jmp block.149

	.align 16
block.153:
    movq $1, %rcx
    jmp block.152

	.align 16
block.155:
    cmpq $0, %rbx
    je block.153
    movq %rdx, %rcx
    xorq $1, %rcx
    jmp block.152

	.align 16
block.156:
    movq %rdx, %rcx
    xorq $1, %rcx
    jmp block.155

	.align 16
start:
    callq read_int
    movq %rax, %rcx
    cmpq $0, %rcx
    sete %al
    movzbq %al, %rbx
    callq read_int
    movq %rax, %rcx
    cmpq $1, %rcx
    sete %al
    movzbq %al, %rdx
    xorq $1, %rbx
    movq %rbx, %rdx
    xorq $1, %rdx
    cmpq $0, %rbx
    je block.156
    movq $0, %rcx
    jmp block.155

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


