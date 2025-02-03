	.align 16
block.18:
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.19:
    movq $12, %rdi
    callq print_int
    jmp block.18

	.align 16
block.22:
    cmpq $0, %r12
    je block.19
    cmpq $0, %r13
    je block.19
    movq $11, %rdi
    callq print_int
    jmp block.18

	.align 16
block.24:
    callq read_int
    movq %rax, %rbx
    callq read_int
    movq %rax, %rcx
    cmpq %rcx, %rbx
    jl block.22
    movq $13, %rdi
    callq print_int
    jmp block.18

	.align 16
block.25:
    movq $9, %rdi
    callq print_int
    jmp block.24

	.align 16
block.30:
    callq read_int
    movq %rax, %rcx
    cmpq $4, %rcx
    je block.25
    callq read_int
    movq %rax, %rcx
    subq $4, %rcx
    cmpq $0, %rcx
    je block.25
    callq read_int
    movq %rax, %rcx
    cmpq $8, %rcx
    je block.25
    callq read_int
    movq %rax, %rcx
    cmpq $9, %rcx
    je block.25
    movq $10, %rdi
    callq print_int
    jmp block.24

	.align 16
block.32:
    movq $8, %rdi
    callq print_int
    jmp block.30

	.align 16
block.31:
    movq $7, %rdi
    callq print_int
    jmp block.30

	.align 16
block.33:
    callq read_int
    movq %rax, %rcx
    cmpq $8, %rcx
    je block.31
    jmp block.32

	.align 16
block.34:
    callq read_int
    movq %rax, %rcx
    subq $4, %rcx
    cmpq $0, %rcx
    je block.33
    jmp block.32

	.align 16
block.35:
    callq read_int
    movq %rax, %rcx
    cmpq $4, %rcx
    je block.34
    jmp block.32

	.align 16
block.36:
    movq $6, %rdi
    callq print_int
    jmp block.35

	.align 16
block.39:
    cmpq $0, %r14
    je block.36
    cmpq $0, %rbx
    je block.36
    movq $5, %rdi
    callq print_int
    jmp block.35

	.align 16
block.40:
    movq $3, %rdi
    callq print_int
    jmp block.39

	.align 16
block.41:
    movq $2, %rdi
    callq print_int
    jmp block.39

	.align 16
block.42:
    callq read_int
    movq %rax, %rcx
    cmpq $4, %rcx
    je block.41
    jmp block.40

	.align 16
block.44:
    cmpq $0, %rbx
    je block.40
    cmpq $0, %r12
    je block.42
    jmp block.41

	.align 16
block.46:
    movq $0, %rdi
    callq print_int
    jmp block.44

	.align 16
block.45:
    movq $1, %rdi
    callq print_int
    jmp block.44

	.align 16
block.47:
    cmpq $0, %r12
    je block.45
    jmp block.46

	.align 16
block.48:
    cmpq $0, %rbx
    je block.47
    jmp block.46

	.align 16
main_start:
    movq $1, %r12
    movq $0, %r13
    movq $0, %rcx
    movq $1, %rbx
    movq $0, %r14
    cmpq $0, %rcx
    je block.48
    jmp block.46

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
    jmp main_start

	.align 16
main_conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 


