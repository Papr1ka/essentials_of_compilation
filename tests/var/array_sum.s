	.align 16
conclusion:
    subq $0, %r15
    addq $16, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.591:
    addq -8(%rbp), %rbx
    addq $1, %r13
    jmp block.590

	.align 16
block.593:
    movq $255, %rdi
    callq exit
    jmp block.591

	.align 16
block.592:
    movq %r12, %r11
    movq %r13, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -8(%rbp)
    jmp block.591

	.align 16
block.594:
    movq %r12, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %r13
    jl block.592
    jmp block.593

	.align 16
block.595:
    cmpq $0, %r13
    jge block.594
    jmp block.593

	.align 16
block.590:
    movq %r12, %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %r13
    jl block.595
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.597:
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
    movq -16(%rbp), %rax
    movq %rax, 40(%r11)
    movq %rcx, %r12
    movq $0, %rbx
    movq $0, %r13
    jmp block.590

	.align 16
start:
    movq $1, %rbx
    movq $2, %r12
    movq $3, %r13
    movq $4, %r14
    movq $5, -16(%rbp)
    movq free_ptr(%rip), %rcx
    addq $48, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.597
    movq %r15, %rdi
    movq $48, %rsi
    callq collect
    jmp block.597

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
    jmp start


