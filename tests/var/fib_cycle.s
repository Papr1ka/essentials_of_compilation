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
block.190:
    movq %rcx, %rdi
    callq print_int
    jmp block.186

	.align 16
block.187:
    movq $1, %rdi
    callq print_int
    jmp block.186

	.align 16
block.189:
    movq %rsi, %rcx
    subq %rdi, %rcx
    movq %rdi, %rsi
    movq %rcx, %rdi
    addq $1, %rdx
    jmp block.188

	.align 16
block.188:
    cmpq $0, %rdx
    jl block.189
    jmp block.190

	.align 16
block.192:
    movq %rdi, %rcx
    addq %rsi, %rcx
    movq %rsi, %rdi
    movq %rcx, %rsi
    subq $1, %rdx
    jmp block.191

	.align 16
block.191:
    cmpq $0, %rdx
    jg block.192
    jmp block.190

	.align 16
start:
    callq read_int
    movq %rax, %rdx
    movq $0, %rdi
    movq $1, %rsi
    movq $0, %rcx
    cmpq $1, %rdx
    je block.187
    cmpq $0, %rdx
    jl block.188
    subq $1, %rdx
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


