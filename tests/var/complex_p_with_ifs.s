	.align 16
conclusion:
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.126:
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.127:
    negq %rbx
    jmp block.126

	.align 16
block.128:
    movq $4, %rbx
    jmp block.127

	.align 16
block.130:
    cmpq $2, %rbx
    je block.128
    subq $2, %rbx
    jmp block.127

	.align 16
block.132:
    callq read_int
    movq %rax, %rcx
    cmpq $4, %rcx
    je block.130
    movq $1, %rbx
    jmp block.126

	.align 16
block.133:
    callq read_int
    movq %rax, %rcx
    cmpq $127, %rcx
    jl block.130
    jmp block.132

	.align 16
start:
    movq $8, %rbx
    callq read_int
    movq %rax, %rcx
    cmpq $6, %rcx
    setg %al
    movzbq %al, %rcx
    cmpq $0, %rcx
    je block.133
    jmp block.132

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    movq %rsp, %rbp
    subq $8, %rsp
    jmp start


