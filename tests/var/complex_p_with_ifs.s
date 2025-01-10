	.align 16
conclusion:
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.151:
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.152:
    negq %rbx
    jmp block.151

	.align 16
block.153:
    movq $4, %rbx
    jmp block.152

	.align 16
block.154:
    subq $2, %rbx
    jmp block.152

	.align 16
block.155:
    movq $1, %rbx
    jmp block.151

	.align 16
block.156:
    movq $2, %rbx
    jmp block.151

	.align 16
block.157:
    cmpq $2, %rbx
    je block.153
    jmp block.154

	.align 16
block.158:
    movq $2, %rax
    cmpq $4, %rax
    jl block.155
    jmp block.155

	.align 16
block.159:
    callq read_int
    movq %rax, %rcx
    cmpq $4, %rcx
    je block.157
    jmp block.158

	.align 16
block.160:
    callq read_int
    movq %rax, %rcx
    cmpq $127, %rcx
    jl block.157
    jmp block.159

	.align 16
start:
    movq $8, %rbx
    callq read_int
    movq %rax, %rcx
    cmpq $6, %rcx
    setg %al
    movzbq %al, %rcx
    cmpq $0, %rcx
    je block.160
    jmp block.159

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    movq %rsp, %rbp
    subq $8, %rsp
    jmp start


