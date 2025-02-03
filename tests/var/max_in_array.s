	.align 16
block.657:
    addq $1, %rbx
    jmp block.656

	.align 16
block.658:
    movq %r12, %r11
    movq %rbx, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -8(%rbp)
    jmp block.657

	.align 16
block.659:
    movq $255, %rdi
    callq exit
    jmp block.657

	.align 16
block.660:
    movq %r12, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %rbx
    jl block.658
    jmp block.659

	.align 16
block.661:
    cmpq $0, %rbx
    jge block.660
    jmp block.659

	.align 16
block.662:
    movq -16(%rbp), %rax
    cmpq -8(%rbp), %rax
    jg block.661
    jmp block.657

	.align 16
block.663:
    movq %r12, %r11
    movq %rbx, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -16(%rbp)
    jmp block.662

	.align 16
block.664:
    movq $255, %rdi
    callq exit
    jmp block.662

	.align 16
block.665:
    movq %r12, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %rbx
    jl block.663
    jmp block.664

	.align 16
block.666:
    cmpq $0, %rbx
    jge block.665
    jmp block.664

	.align 16
block.656:
    movq %r12, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %rbx
    jl block.666
    movq -8(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.668:
    movq $1, %rbx
    jmp block.656

	.align 16
block.670:
    movq $255, %rdi
    callq exit
    jmp block.668

	.align 16
block.669:
    movq %r12, %r11
    movq $0, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -8(%rbp)
    jmp block.668

	.align 16
block.671:
    movq %r12, %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    movq $0, %rax
    cmpq %rcx, %rax
    jl block.669
    jmp block.670

	.align 16
block.672:
    movq free_ptr(%rip), %r11
    addq $48, free_ptr(%rip)
    movq $4611686018427387925, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r14, 8(%r11)
    movq %rcx, %r11
    movq %r13, 16(%r11)
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
    jge block.671
    jmp block.670

	.align 16
main_start:
    movq $10, %r14
    movq $20, %r13
    movq $5, %r12
    movq $30, %rbx
    movq $15, -24(%rbp)
    movq free_ptr(%rip), %rcx
    addq $48, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.672
    movq %r15, %rdi
    movq $48, %rsi
    callq collect
    jmp block.672

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
    jmp main_start

	.align 16
main_conclusion:
    subq $0, %r15
    addq $32, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 


