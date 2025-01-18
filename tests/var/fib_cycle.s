	.align 16
conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %rbp
    retq 

	.align 16
block.186:
    movq $0, %rax
    jmp conclusion

	.align 16
block.187:
    movq $1, %rdi
    callq print_int
    jmp block.186

	.align 16
block.190:
    movq %rdx, %rdi
    callq print_int
    jmp block.186

	.align 16
block.189:
    movq %rdi, %rdx
    subq %rsi, %rdx
    movq %rsi, %rdi
    movq %rdx, %rsi
    addq $1, %rcx
    jmp block.188

	.align 16
block.188:
    cmpq $0, %rcx
    jl block.189
    jmp block.190

	.align 16
block.192:
    movq %rsi, %rdx
    addq %rdi, %rdx
    movq %rdi, %rsi
    movq %rdx, %rdi
    subq $1, %rcx
    jmp block.191

	.align 16
block.191:
    cmpq $0, %rcx
    jg block.192
    jmp block.190

	.align 16
start:
    callq read_int
    movq %rax, %rcx
    movq $0, %rsi
    movq $1, %rdi
    movq $0, %rdx
    cmpq $1, %rcx
    je block.187
    cmpq $0, %rcx
    jl block.188
    subq $1, %rcx
    jmp block.191

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $0, %rsp
    movq $65536, %rdi
    movq $16, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    addq $0, %r15
    jmp start


