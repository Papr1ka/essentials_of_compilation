	.align 16
conclusion:
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.188:
    addq %rcx, %rbx
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.189:
    subq $1, %rbx
    jmp block.188

	.align 16
block.190:
    addq $1, %rcx
    jmp block.188

	.align 16
block.191:
    cmpq $0, %rdx
    je block.189
    jmp block.190

	.align 16
block.192:
    movq $1, %rdx
    jmp block.191

	.align 16
block.193:
    movq $5, %rdx
    subq $4, %rdx
    cmpq $6, %rdx
    setg %al
    movzbq %al, %rdx
    xorq $1, %rdx
    xorq $1, %rdx
    jmp block.191

	.align 16
block.194:
    cmpq %rcx, %rbx
    setg %al
    movzbq %al, %rdx
    cmpq $0, %rdx
    je block.192
    jmp block.193

	.align 16
start:
    callq read_int
    movq %rax, %rbx
    addq $15, %rbx
    callq read_int
    movq %rax, %rdx
    movq $4, %rcx
    subq %rdx, %rcx
    negq %rcx
    cmpq %rcx, %rbx
    je block.192
    jmp block.194

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    movq %rsp, %rbp
    subq $8, %rsp
    jmp start


