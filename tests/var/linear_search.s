	.align 16
conclusion:
    subq $0, %r15
    addq $112, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.669:
    movq $0, %rax
    jmp conclusion

	.align 16
block.662:
    movq %rbx, %rdi
    callq print_int
    movq $1, %r12
    jmp block.661

	.align 16
block.664:
    cmpq %r14, -8(%rbp)
    je block.662
    addq $1, %rbx
    jmp block.661

	.align 16
block.665:
    movq %r13, %r11
    movq %rbx, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -8(%rbp)
    jmp block.664

	.align 16
block.666:
    movq $255, %rdi
    callq exit
    jmp block.664

	.align 16
block.667:
    movq %r13, %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %rbx
    jl block.665
    jmp block.666

	.align 16
block.668:
    cmpq $0, %rbx
    jge block.667
    jmp block.666

	.align 16
block.670:
    cmpq $0, %r12
    je block.668
    jmp block.669

	.align 16
block.661:
    movq %r13, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %rbx
    jl block.670
    jmp block.669

	.align 16
block.671:
    movq free_ptr(%rip), %r11
    addq $144, free_ptr(%rip)
    movq $4611686018427387973, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r13, 8(%r11)
    movq %rcx, %r11
    movq %r12, 16(%r11)
    movq %rcx, %r11
    movq %r14, 24(%r11)
    movq %rcx, %r11
    movq -16(%rbp), %rax
    movq %rax, 32(%r11)
    movq %rcx, %r11
    movq %rbx, 40(%r11)
    movq %rcx, %r11
    movq -24(%rbp), %rax
    movq %rax, 48(%r11)
    movq %rcx, %r11
    movq -32(%rbp), %rax
    movq %rax, 56(%r11)
    movq %rcx, %r11
    movq -40(%rbp), %rax
    movq %rax, 64(%r11)
    movq %rcx, %r11
    movq -48(%rbp), %rax
    movq %rax, 72(%r11)
    movq %rcx, %r11
    movq -56(%rbp), %rax
    movq %rax, 80(%r11)
    movq %rcx, %r11
    movq -64(%rbp), %rax
    movq %rax, 88(%r11)
    movq %rcx, %r11
    movq -72(%rbp), %rax
    movq %rax, 96(%r11)
    movq %rcx, %r11
    movq -80(%rbp), %rax
    movq %rax, 104(%r11)
    movq %rcx, %r11
    movq -88(%rbp), %rax
    movq %rax, 112(%r11)
    movq %rcx, %r11
    movq -96(%rbp), %rax
    movq %rax, 120(%r11)
    movq %rcx, %r11
    movq -104(%rbp), %rax
    movq %rax, 128(%r11)
    movq %rcx, %r11
    movq -112(%rbp), %rax
    movq %rax, 136(%r11)
    movq %rcx, %r13
    callq read_int
    movq %rax, %r14
    movq $0, %rbx
    movq $0, %r12
    jmp block.661

	.align 16
start:
    movq $1, %r13
    movq $2, %r12
    movq $5, %r14
    movq $10, -16(%rbp)
    movq $4, %rbx
    negq %rbx
    movq $15, -24(%rbp)
    movq $2, -32(%rbp)
    movq $9, -40(%rbp)
    movq $42, -48(%rbp)
    movq $89, -56(%rbp)
    movq $90, -64(%rbp)
    movq $6, -72(%rbp)
    movq $3, -80(%rbp)
    movq $2, -88(%rbp)
    movq $0, -96(%rbp)
    movq $15, -104(%rbp)
    movq $104, -112(%rbp)
    movq free_ptr(%rip), %rcx
    addq $144, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.671
    movq %r15, %rdi
    movq $144, %rsi
    callq collect
    jmp block.671

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    movq %rsp, %rbp
    subq $112, %rsp
    movq $65536, %rdi
    movq $16, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    addq $0, %r15
    jmp start


