	.align 16
block.123:
    addq -8(%rbp), %rbx
    addq $1, %r12
    jmp block.122

	.align 16
block.125:
    movq $255, %rdi
    callq exit
    jmp block.123

	.align 16
block.124:
    movq %r13, %r11
    movq %r12, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -8(%rbp)
    jmp block.123

	.align 16
block.126:
    movq %r13, %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %r12
    jl block.124
    jmp block.125

	.align 16
block.127:
    cmpq $0, %r12
    jge block.126
    jmp block.125

	.align 16
block.122:
    movq %r13, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %r12
    jl block.127
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.129:
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
    movq %r14, 24(%r11)
    movq %rcx, %r11
    movq -16(%rbp), %rax
    movq %rax, 32(%r11)
    movq %rcx, %r11
    movq %rbx, 40(%r11)
    movq %rcx, %r13
    movq $0, %rbx
    movq $0, %r12
    jmp block.122

	.align 16
main_start:
    movq $1, %r12
    movq $2, %r13
    movq $3, %r14
    movq $4, -16(%rbp)
    movq $5, %rbx
    movq free_ptr(%rip), %rcx
    addq $48, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.129
    movq %r15, %rdi
    movq $48, %rsi
    callq collect
    jmp block.129

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    movq %rsp, %rbp
    subq $16, %rsp
    movq $65536, %rdi
    movq $16, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    addq $0, %r15
    jmp main_start

	.align 16
main_conclusion:
    subq $0, %r15
    addq $16, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 


