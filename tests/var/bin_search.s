	.align 16
conclusion:
    subq $8, %r15
    addq $192, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.553:
    movq $0, %rax
    jmp conclusion

	.align 16
block.554:
    movq $-1, %rdi
    callq print_int
    jmp block.553

	.align 16
block.567:
    cmpq %r14, %r12
    jg block.554
    movq %rbx, %rdi
    callq print_int
    jmp block.553

	.align 16
block.558:
    subq $2, %rcx
    addq $1, %rbx
    jmp block.557

	.align 16
block.559:
    movq %r12, %rcx
    addq %r14, %rcx
    movq $0, %rbx
    jmp block.557

	.align 16
block.560:
    movq $1, %r12
    addq %rbx, %r12
    jmp block.559

	.align 16
block.562:
    cmpq -8(%rbp), %r13
    jg block.560
    movq %rbx, %r14
    subq $1, %r14
    jmp block.559

	.align 16
block.564:
    movq $255, %rdi
    callq exit
    jmp block.562

	.align 16
block.563:
    movq -8(%r15), %r11
    movq %rbx, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -8(%rbp)
    jmp block.562

	.align 16
block.565:
    movq -8(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %rbx
    jl block.563
    jmp block.564

	.align 16
block.566:
    cmpq $0, %rbx
    jge block.565
    jmp block.564

	.align 16
block.568:
    cmpq %r14, %r12
    jle block.566
    jmp block.567

	.align 16
block.569:
    cmpq %r13, -16(%rbp)
    jne block.568
    jmp block.567

	.align 16
block.570:
    movq -8(%r15), %r11
    movq %rbx, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -16(%rbp)
    jmp block.569

	.align 16
block.571:
    movq $255, %rdi
    callq exit
    jmp block.569

	.align 16
block.572:
    movq -8(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %rbx
    jl block.570
    jmp block.571

	.align 16
block.556:
    cmpq $0, %rbx
    jge block.572
    jmp block.571

	.align 16
block.573:
    movq free_ptr(%rip), %r11
    addq $208, free_ptr(%rip)
    movq $4611686018427388005, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r13, 8(%r11)
    movq %rcx, %r11
    movq %r14, 16(%r11)
    movq %rcx, %r11
    movq -24(%rbp), %rax
    movq %rax, 24(%r11)
    movq %rcx, %r11
    movq -32(%rbp), %rax
    movq %rax, 32(%r11)
    movq %rcx, %r11
    movq -40(%rbp), %rax
    movq %rax, 40(%r11)
    movq %rcx, %r11
    movq -48(%rbp), %rax
    movq %rax, 48(%r11)
    movq %rcx, %r11
    movq -56(%rbp), %rax
    movq %rax, 56(%r11)
    movq %rcx, %r11
    movq -64(%rbp), %rax
    movq %rax, 64(%r11)
    movq %rcx, %r11
    movq -72(%rbp), %rax
    movq %rax, 72(%r11)
    movq %rcx, %r11
    movq %r12, 80(%r11)
    movq %rcx, %r11
    movq -80(%rbp), %rax
    movq %rax, 88(%r11)
    movq %rcx, %r11
    movq -88(%rbp), %rax
    movq %rax, 96(%r11)
    movq %rcx, %r11
    movq -96(%rbp), %rax
    movq %rax, 104(%r11)
    movq %rcx, %r11
    movq -104(%rbp), %rax
    movq %rax, 112(%r11)
    movq %rcx, %r11
    movq -112(%rbp), %rax
    movq %rax, 120(%r11)
    movq %rcx, %r11
    movq -120(%rbp), %rax
    movq %rax, 128(%r11)
    movq %rcx, %r11
    movq %rbx, 136(%r11)
    movq %rcx, %r11
    movq -128(%rbp), %rax
    movq %rax, 144(%r11)
    movq %rcx, %r11
    movq -136(%rbp), %rax
    movq %rax, 152(%r11)
    movq %rcx, %r11
    movq -144(%rbp), %rax
    movq %rax, 160(%r11)
    movq %rcx, %r11
    movq -152(%rbp), %rax
    movq %rax, 168(%r11)
    movq %rcx, %r11
    movq -160(%rbp), %rax
    movq %rax, 176(%r11)
    movq %rcx, %r11
    movq -168(%rbp), %rax
    movq %rax, 184(%r11)
    movq %rcx, %r11
    movq -176(%rbp), %rax
    movq %rax, 192(%r11)
    movq %rcx, %r11
    movq -184(%rbp), %rax
    movq %rax, 200(%r11)
    movq %rcx, -8(%r15)
    callq read_int
    movq %rax, %r13
    movq $0, %r12
    movq -8(%r15), %r11
    movq 0(%r11), %r14
    movq $4611686018427387900, %rcx
    andq %rcx, %r14
    sarq $2, %r14
    subq $1, %r14
    movq $12, %rbx
    jmp block.556

	.align 16
block.557:
    cmpq $2, %rcx
    jge block.558
    jmp block.556

	.align 16
start:
    movq $30, %r13
    negq %r13
    movq $26, %r14
    negq %r14
    movq $26, -24(%rbp)
    negq -24(%rbp)
    movq $22, -32(%rbp)
    negq -32(%rbp)
    movq $19, -40(%rbp)
    negq -40(%rbp)
    movq $15, -48(%rbp)
    negq -48(%rbp)
    movq $12, -56(%rbp)
    negq -56(%rbp)
    movq $10, -64(%rbp)
    negq -64(%rbp)
    movq $9, -72(%rbp)
    negq -72(%rbp)
    movq $8, %r12
    negq %r12
    movq $0, -80(%rbp)
    movq $0, -88(%rbp)
    movq $2, -96(%rbp)
    movq $7, -104(%rbp)
    movq $20, -112(%rbp)
    movq $29, -120(%rbp)
    movq $30, %rbx
    movq $31, -128(%rbp)
    movq $32, -136(%rbp)
    movq $32, -144(%rbp)
    movq $38, -152(%rbp)
    movq $38, -160(%rbp)
    movq $43, -168(%rbp)
    movq $46, -176(%rbp)
    movq $48, -184(%rbp)
    movq free_ptr(%rip), %rcx
    addq $208, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.573
    movq %r15, %rdi
    movq $208, %rsi
    callq collect
    jmp block.573

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    movq %rsp, %rbp
    subq $192, %rsp
    movq $65536, %rdi
    movq $16, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    movq $0, 0(%r15)
    addq $8, %r15
    jmp start


