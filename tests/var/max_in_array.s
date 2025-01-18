	.align 16
conclusion:
    subq $0, %r15
    addq $32, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.615:
    addq $1, %rbx
    jmp block.614

	.align 16
block.617:
    movq $255, %rdi
    callq exit
    jmp block.615

	.align 16
block.616:
    movq %r12, %r11
    movq %rbx, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -8(%rbp)
    jmp block.615

	.align 16
block.618:
    movq %r12, %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %rbx
    jl block.616
    jmp block.617

	.align 16
block.619:
    cmpq $0, %rbx
    jge block.618
    jmp block.617

	.align 16
block.620:
    movq -16(%rbp), %rax
    cmpq -8(%rbp), %rax
    jg block.619
    jmp block.615

	.align 16
block.622:
    movq $255, %rdi
    callq exit
    jmp block.620

	.align 16
block.621:
    movq %r12, %r11
    movq %rbx, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -16(%rbp)
    jmp block.620

	.align 16
block.623:
    movq %r12, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %rbx
    jl block.621
    jmp block.622

	.align 16
block.624:
    cmpq $0, %rbx
    jge block.623
    jmp block.622

	.align 16
block.614:
    movq %r12, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %rbx
    jl block.624
    movq -8(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.626:
    movq $1, %rbx
    jmp block.614

	.align 16
block.628:
    movq $255, %rdi
    callq exit
    jmp block.626

	.align 16
block.627:
    movq %r12, %r11
    movq $0, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -8(%rbp)
    jmp block.626

	.align 16
block.629:
    movq %r12, %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    movq $0, %rax
    cmpq %rcx, %rax
    jl block.627
    jmp block.628

	.align 16
block.630:
    movq free_ptr(%rip), %r11
    addq $48, free_ptr(%rip)
    movq $4611686018427387925, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r13, 8(%r11)
    movq %rcx, %r11
    movq %r14, 16(%r11)
    movq %rcx, %r11
    movq %r12, 24(%r11)
    movq %rcx, %r11
    movq %rbx, 32(%r11)
    movq %rcx, %r11
    movq -24(%rbp), %rax
    movq %rax, 40(%r11)
    movq %rcx, %r12
    movq $0, %rax
    cmpq $0, %rax
    jge block.629
    jmp block.628

	.align 16
start:
    movq $10, %r13
    movq $20, %r14
    movq $5, %r12
    movq $30, %rbx
    movq $15, -24(%rbp)
    movq free_ptr(%rip), %rcx
    addq $48, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.630
    movq %r15, %rdi
    movq $48, %rsi
    callq collect
    jmp block.630

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
    addq $0, %r15
    jmp start


