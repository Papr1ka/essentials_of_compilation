	.align 16
conclusion:
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.109:
    movq $0, %rax
    jmp conclusion

	.align 16
block.110:
    movq $12, %rdi
    callq print_int
    jmp block.109

	.align 16
block.113:
    cmpq $0, %r13
    je block.110
    cmpq $0, %r12
    je block.110
    movq $11, %rdi
    callq print_int
    jmp block.109

	.align 16
block.115:
    callq read_int
    movq %rax, %rbx
    callq read_int
    movq %rax, %rcx
    cmpq %rcx, %rbx
    jl block.113
    movq $13, %rdi
    callq print_int
    jmp block.109

	.align 16
block.116:
    movq $9, %rdi
    callq print_int
    jmp block.115

	.align 16
block.121:
    callq read_int
    movq %rax, %rcx
    addq $1, %rcx
    cmpq $5, %rcx
    je block.116
    callq read_int
    movq %rax, %rcx
    subq $4, %rcx
    cmpq $0, %rcx
    je block.116
    callq read_int
    movq %rax, %rcx
    cmpq $8, %rcx
    je block.116
    callq read_int
    movq %rax, %rcx
    cmpq $9, %rcx
    je block.116
    movq $10, %rdi
    callq print_int
    jmp block.115

	.align 16
block.123:
    movq $8, %rdi
    callq print_int
    jmp block.121

	.align 16
block.122:
    movq $7, %rdi
    callq print_int
    jmp block.121

	.align 16
block.124:
    callq read_int
    movq %rax, %rcx
    cmpq $8, %rcx
    je block.122
    jmp block.123

	.align 16
block.125:
    callq read_int
    movq %rax, %rcx
    subq $4, %rcx
    cmpq $0, %rcx
    je block.124
    jmp block.123

	.align 16
block.126:
    callq read_int
    movq %rax, %rcx
    addq $1, %rcx
    cmpq $5, %rcx
    je block.125
    jmp block.123

	.align 16
block.127:
    movq $6, %rdi
    callq print_int
    jmp block.126

	.align 16
block.130:
    cmpq $0, %r14
    je block.127
    cmpq $0, %rbx
    je block.127
    movq $5, %rdi
    callq print_int
    jmp block.126

	.align 16
block.132:
    movq $2, %rdi
    callq print_int
    jmp block.130

	.align 16
block.131:
    movq $3, %rdi
    callq print_int
    jmp block.130

	.align 16
block.133:
    callq read_int
    movq %rax, %rcx
    cmpq $4, %rcx
    je block.132
    jmp block.131

	.align 16
block.135:
    cmpq $0, %rbx
    je block.131
    cmpq $0, %r13
    je block.133
    jmp block.132

	.align 16
block.136:
    movq $1, %rdi
    callq print_int
    jmp block.135

	.align 16
block.137:
    movq $0, %rdi
    callq print_int
    jmp block.135

	.align 16
block.138:
    cmpq $0, %r13
    je block.136
    jmp block.137

	.align 16
block.139:
    cmpq $0, %rbx
    je block.138
    jmp block.137

	.align 16
start:
    movq $1, %r13
    movq $0, %r12
    movq $0, %rcx
    movq $1, %rbx
    movq $0, %r14
    cmpq $0, %rcx
    je block.139
    jmp block.137

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    movq %rsp, %rbp
    jmp start


