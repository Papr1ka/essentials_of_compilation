	.align 16
block.416:
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.409:
    movq %r13, %rdi
    callq print_int
    movq $1, %rbx
    jmp block.408

	.align 16
block.411:
    cmpq %r12, -8(%rbp)
    je block.409
    addq $1, %r13
    jmp block.408

	.align 16
block.413:
    movq $255, %rdi
    callq exit
    jmp block.411

	.align 16
block.412:
    movq %r14, %r11
    movq %r13, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -8(%rbp)
    jmp block.411

	.align 16
block.414:
    movq %r14, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %r13
    jl block.412
    jmp block.413

	.align 16
block.415:
    cmpq $0, %r13
    jge block.414
    jmp block.413

	.align 16
block.417:
    cmpq $0, %rbx
    je block.415
    jmp block.416

	.align 16
block.408:
    movq %r14, %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %r13
    jl block.417
    jmp block.416

	.align 16
block.418:
    movq free_ptr(%rip), %r11
    addq $144, free_ptr(%rip)
    movq $4611686018427387973, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r13, 8(%r11)
    movq %rcx, %r11
    movq %r14, 16(%r11)
    movq %rcx, %r11
    movq -16(%rbp), %rax
    movq %rax, 24(%r11)
    movq %rcx, %r11
    movq -24(%rbp), %rax
    movq %rax, 32(%r11)
    movq %rcx, %r11
    movq %r12, 40(%r11)
    movq %rcx, %r11
    movq %rbx, 48(%r11)
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
    movq %rcx, %r14
    callq read_int
    movq %rax, %r12
    movq $0, %r13
    movq $0, %rbx
    jmp block.408

	.align 16
main_start:
    movq $1, %r13
    movq $2, %r14
    movq $5, -16(%rbp)
    movq $10, -24(%rbp)
    movq $4, %r12
    negq %r12
    movq $15, %rbx
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
    jl block.418
    movq %r15, %rdi
    movq $144, %rsi
    callq collect
    jmp block.418

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
    jmp main_start

	.align 16
main_conclusion:
    subq $0, %r15
    addq $112, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 


