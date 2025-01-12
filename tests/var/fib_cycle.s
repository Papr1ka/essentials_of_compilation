	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
block.186:
    movq $0, %rax
    jmp conclusion

	.align 16
block.190:
    movq %rdx, %rdi
    callq print_int
    jmp block.186

	.align 16
block.187:
    movq $1, %rdi
    callq print_int
    jmp block.186

	.align 16
block.189:
    movq %rcx, %rdx
    subq %rdi, %rdx
    movq %rdi, %rcx
    movq %rdx, %rdi
    addq $1, %rsi
    jmp block.188

	.align 16
block.188:
    cmpq $0, %rsi
    jl block.189
    jmp block.190

	.align 16
block.192:
    movq %rdi, %rdx
    addq %rcx, %rdx
    movq %rcx, %rdi
    movq %rdx, %rcx
    subq $1, %rsi
    jmp block.191

	.align 16
block.191:
    cmpq $0, %rsi
    jg block.192
    jmp block.190

	.align 16
start:
    callq read_int
    movq %rax, %rsi
    movq $0, %rdi
    movq $1, %rcx
    movq $0, %rdx
    cmpq $1, %rsi
    je block.187
    cmpq $0, %rsi
    jl block.188
    subq $1, %rsi
    jmp block.191

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    jmp start


