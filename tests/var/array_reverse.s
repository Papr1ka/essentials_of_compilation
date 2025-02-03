	.align 16
block.80:
    movq -8(%rbp), %rdi
    callq print_int
    addq $1, %rbx
    jmp block.79

	.align 16
block.81:
    movq %r12, %r11
    movq %rbx, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -8(%rbp)
    jmp block.80

	.align 16
block.82:
    movq $255, %rdi
    callq exit
    jmp block.80

	.align 16
block.83:
    movq %r12, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %rbx
    jl block.81
    jmp block.82

	.align 16
block.84:
    cmpq $0, %rbx
    jge block.83
    jmp block.82

	.align 16
block.79:
    movq %r12, %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %rbx
    jl block.84
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.87:
    addq $1, %rbx
    jmp block.86

	.align 16
block.93:
    movq $255, %rdi
    callq exit
    jmp block.87

	.align 16
block.88:
    movq %r12, %r11
    imulq $8, %r13
    addq %r13, %r11
    movq -16(%rbp), %rax
    movq %rax, 8(%r11)
    jmp block.87

	.align 16
block.89:
    movq -8(%r15), %r11
    movq %rbx, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -16(%rbp)
    jmp block.88

	.align 16
block.90:
    movq $255, %rdi
    callq exit
    jmp block.88

	.align 16
block.91:
    movq -8(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %rbx
    jl block.89
    jmp block.90

	.align 16
block.92:
    movq %r12, %r11
    movq 0(%r11), %r13
    movq $4611686018427387900, %rcx
    andq %rcx, %r13
    sarq $2, %r13
    subq %rbx, %r13
    subq $1, %r13
    cmpq $0, %rbx
    jge block.91
    jmp block.90

	.align 16
block.94:
    movq %r12, %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    subq %rbx, %rcx
    subq $1, %rcx
    movq %r12, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rsi
    andq %rsi, %rdx
    sarq $2, %rdx
    cmpq %rdx, %rcx
    jl block.92
    jmp block.93

	.align 16
block.95:
    movq %r12, %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    subq %rbx, %rcx
    subq $1, %rcx
    cmpq $0, %rcx
    jge block.94
    jmp block.93

	.align 16
block.86:
    movq -8(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %rbx
    jl block.95
    movq $0, %rbx
    jmp block.79

	.align 16
block.97:
    movq free_ptr(%rip), %r11
    addq $48, free_ptr(%rip)
    movq $4611686018427387925, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %rbx, 8(%r11)
    movq %rcx, %r11
    movq %r12, 16(%r11)
    movq %rcx, %r11
    movq %r13, 24(%r11)
    movq %rcx, %r11
    movq %r14, 32(%r11)
    movq %rcx, %r11
    movq -24(%rbp), %rax
    movq %rax, 40(%r11)
    movq %rcx, %r12
    movq $0, %rbx
    jmp block.86

	.align 16
block.99:
    movq free_ptr(%rip), %r11
    addq $48, free_ptr(%rip)
    movq $4611686018427387925, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r12, 8(%r11)
    movq %rcx, %r11
    movq %r13, 16(%r11)
    movq %rcx, %r11
    movq %rbx, 24(%r11)
    movq %rcx, %r11
    movq %r14, 32(%r11)
    movq %rcx, %r11
    movq -32(%rbp), %rax
    movq %rax, 40(%r11)
    movq %rcx, -8(%r15)
    movq $0, %rbx
    movq $0, %r12
    movq $0, %r13
    movq $0, %r14
    movq $0, -24(%rbp)
    movq free_ptr(%rip), %rcx
    addq $48, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.97
    movq %r15, %rdi
    movq $48, %rsi
    callq collect
    jmp block.97

	.align 16
main_start:
    callq read_int
    movq %rax, %r12
    callq read_int
    movq %rax, %r13
    callq read_int
    movq %rax, %rbx
    callq read_int
    movq %rax, %r14
    callq read_int
    movq %rax, -32(%rbp)
    movq free_ptr(%rip), %rcx
    addq $48, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.99
    movq %r15, %rdi
    movq $48, %rsi
    callq collect
    jmp block.99

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    movq %rsp, %rbp
    subq $32, %rsp
    movq $65536, %rdi
    movq $16, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    addq $8, %r15
    movq $0, 0(%r15)
    jmp main_start

	.align 16
main_conclusion:
    subq $8, %r15
    addq $32, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 


