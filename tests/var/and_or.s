	.align 16
conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.84:
    movq $0, %rax
    jmp conclusion

	.align 16
block.85:
    movq $12, %rdi
    callq print_int
    jmp block.84

	.align 16
block.88:
    cmpq $0, %r12
    je block.85
    cmpq $0, %r13
    je block.85
    movq $11, %rdi
    callq print_int
    jmp block.84

	.align 16
block.90:
    callq read_int
    movq %rax, %rbx
    callq read_int
    movq %rax, %rcx
    cmpq %rcx, %rbx
    jl block.88
    movq $13, %rdi
    callq print_int
    jmp block.84

	.align 16
block.91:
    movq $9, %rdi
    callq print_int
    jmp block.90

	.align 16
block.96:
    callq read_int
    movq %rax, %rcx
    cmpq $4, %rcx
    je block.91
    callq read_int
    movq %rax, %rcx
    subq $4, %rcx
    cmpq $0, %rcx
    je block.91
    callq read_int
    movq %rax, %rcx
    cmpq $8, %rcx
    je block.91
    callq read_int
    movq %rax, %rcx
    cmpq $9, %rcx
    je block.91
    movq $10, %rdi
    callq print_int
    jmp block.90

	.align 16
block.98:
    movq $8, %rdi
    callq print_int
    jmp block.96

	.align 16
block.97:
    movq $7, %rdi
    callq print_int
    jmp block.96

	.align 16
block.99:
    callq read_int
    movq %rax, %rcx
    cmpq $8, %rcx
    je block.97
    jmp block.98

	.align 16
block.100:
    callq read_int
    movq %rax, %rcx
    subq $4, %rcx
    cmpq $0, %rcx
    je block.99
    jmp block.98

	.align 16
block.101:
    callq read_int
    movq %rax, %rcx
    cmpq $4, %rcx
    je block.100
    jmp block.98

	.align 16
block.102:
    movq $6, %rdi
    callq print_int
    jmp block.101

	.align 16
block.105:
    cmpq $0, %r14
    je block.102
    cmpq $0, %rbx
    je block.102
    movq $5, %rdi
    callq print_int
    jmp block.101

	.align 16
block.106:
    movq $3, %rdi
    callq print_int
    jmp block.105

	.align 16
block.107:
    movq $2, %rdi
    callq print_int
    jmp block.105

	.align 16
block.108:
    callq read_int
    movq %rax, %rcx
    cmpq $4, %rcx
    je block.107
    jmp block.106

	.align 16
block.110:
    cmpq $0, %rbx
    je block.106
    cmpq $0, %r12
    je block.108
    jmp block.107

	.align 16
block.111:
    movq $1, %rdi
    callq print_int
    jmp block.110

	.align 16
block.112:
    movq $0, %rdi
    callq print_int
    jmp block.110

	.align 16
block.113:
    cmpq $0, %r12
    je block.111
    jmp block.112

	.align 16
block.114:
    cmpq $0, %rbx
    je block.113
    jmp block.112

	.align 16
start:
    movq $1, %r12
    movq $0, %r13
    movq $0, %rcx
    movq $1, %rbx
    movq $0, %r14
    cmpq $0, %rcx
    je block.114
    jmp block.112

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    movq %rsp, %rbp
    subq $0, %rsp
    movq $65536, %rdi
    movq $16, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    addq $0, %r15
    jmp start


