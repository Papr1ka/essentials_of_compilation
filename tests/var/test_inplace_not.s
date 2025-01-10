	.align 16
conclusion:
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.197:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.198:
    movq $1, %rcx
    jmp block.197

	.align 16
block.199:
    movq $0, %rcx
    jmp block.197

	.align 16
block.200:
    xorq $1, %rcx
    xorq $1, %rcx
    cmpq $1, %rcx
    je block.198
    jmp block.199

	.align 16
block.201:
    movq $1, %rcx
    jmp block.200

	.align 16
block.202:
    movq %rdx, %rcx
    xorq $1, %rcx
    jmp block.200

	.align 16
block.203:
    cmpq $0, %rbx
    je block.201
    jmp block.202

	.align 16
block.204:
    movq %rdx, %rcx
    xorq $1, %rcx
    jmp block.203

	.align 16
block.205:
    movq $0, %rcx
    jmp block.203

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
    je block.204
    jmp block.205

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    movq %rsp, %rbp
    subq $8, %rsp
    jmp start


