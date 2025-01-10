	.align 16
conclusion:
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.198:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.199:
    movq $1, %rcx
    jmp block.198

	.align 16
block.200:
    movq $0, %rcx
    jmp block.198

	.align 16
block.201:
    xorq $1, %rcx
    xorq $1, %rcx
    cmpq $1, %rcx
    je block.199
    jmp block.200

	.align 16
block.202:
    movq $1, %rcx
    jmp block.201

	.align 16
block.203:
    movq %rdx, %rcx
    xorq $1, %rcx
    jmp block.201

	.align 16
block.204:
    cmpq $0, %rbx
    je block.202
    jmp block.203

	.align 16
block.205:
    movq %rdx, %rcx
    xorq $1, %rcx
    jmp block.204

	.align 16
block.206:
    movq $0, %rcx
    jmp block.204

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
    je block.205
    jmp block.206

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    movq %rsp, %rbp
    subq $8, %rsp
    jmp start


