	.align 16
conclusion:
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.141:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.142:
    addq $2, %rcx
    jmp block.141

	.align 16
block.143:
    addq $10, %rcx
    jmp block.141

	.align 16
block.144:
    cmpq $0, %rbx
    je block.142
    jmp block.143

	.align 16
block.145:
    cmpq $2, %rbx
    je block.142
    jmp block.143

	.align 16
start:
    callq read_int
    movq %rax, %rbx
    callq read_int
    movq %rax, %rcx
    cmpq $1, %rbx
    jl block.144
    jmp block.145

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    movq %rsp, %rbp
    subq $8, %rsp
    jmp start


