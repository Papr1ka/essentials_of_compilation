	.align 16
block.779:
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.781:
    movq $0, %rdi
    jmp block.779

	.align 16
block.780:
    movq $42, %rdi
    jmp block.779

	.align 16
block.782:
    movq -8(%r15), %r11
    movq 0(%r11), %rcx
    andq $126, %rcx
    sarq $1, %rcx
    movq %rbx, %r11
    movq 0(%r11), %rdx
    andq $126, %rdx
    sarq $1, %rdx
    cmpq %rdx, %rcx
    je block.780
    jmp block.781

	.align 16
block.783:
    movq -16(%r15), %r11
    movq 0(%r11), %rcx
    andq $126, %rcx
    sarq $1, %rcx
    movq -24(%r15), %r11
    movq 0(%r11), %rdx
    andq $126, %rdx
    sarq $1, %rdx
    cmpq %rdx, %rcx
    je block.782
    jmp block.781

	.align 16
block.784:
    movq -32(%r15), %r11
    movq 0(%r11), %rcx
    andq $126, %rcx
    sarq $1, %rcx
    cmpq $3, %rcx
    je block.783
    jmp block.781

	.align 16
block.785:
    movq free_ptr(%rip), %r11
    addq $16, free_ptr(%rip)
    movq $131, 0(%r11)
    movq %r11, %rbx
    movq %rbx, %r11
    movq -8(%r15), %rax
    movq %rax, 8(%r11)
    movq %rbx, %r11
    movq 8(%r11), %rcx
    movq %rcx, %r11
    movq 8(%r11), %rdi
    callq print_int
    movq -16(%r15), %r11
    movq 0(%r11), %rcx
    andq $126, %rcx
    sarq $1, %rcx
    cmpq $2, %rcx
    je block.784
    jmp block.781

	.align 16
block.787:
    movq free_ptr(%rip), %r11
    addq $16, free_ptr(%rip)
    movq $3, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %rbx, 8(%r11)
    movq %rcx, -8(%r15)
    movq free_ptr(%rip), %rcx
    addq $16, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.785
    movq %r15, %rdi
    movq $16, %rsi
    callq collect
    jmp block.785

	.align 16
block.789:
    callq print_int
    movq $42, %rbx
    movq free_ptr(%rip), %rcx
    addq $16, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.787
    movq %r15, %rdi
    movq $16, %rsi
    callq collect
    jmp block.787

	.align 16
block.790:
    movq $42, %rdi
    jmp block.789

	.align 16
block.791:
    movq $0, %rdi
    jmp block.789

	.align 16
block.792:
    movq -16(%r15), %rax
    cmpq -24(%r15), %rax
    sete %al
    movzbq %al, %rcx
    cmpq $0, %rcx
    je block.790
    jmp block.791

	.align 16
block.793:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $5, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %rbx, 8(%r11)
    movq %rcx, %r11
    movq %r12, 16(%r11)
    movq %rcx, -24(%r15)
    movq -16(%r15), %rax
    cmpq -16(%r15), %rax
    je block.792
    jmp block.791

	.align 16
block.795:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $5, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r12, 8(%r11)
    movq %rcx, %r11
    movq %rbx, 16(%r11)
    movq %rcx, -16(%r15)
    movq $3, %rbx
    movq $7, %r12
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.793
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.793

	.align 16
block.797:
    movq free_ptr(%rip), %r11
    addq $32, free_ptr(%rip)
    movq $7, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r12, 8(%r11)
    movq %rcx, %r11
    movq %rbx, 16(%r11)
    movq %rcx, %r11
    movq %r13, 24(%r11)
    movq %rcx, -32(%r15)
    movq -32(%r15), %r11
    movq 8(%r11), %rdi
    callq print_int
    movq $3, %r12
    movq $7, %rbx
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.795
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.795

	.align 16
main_start:
    movq $42, %r12
    movq $1, %rbx
    movq $2, %r13
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.797
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.797

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    movq %rsp, %rbp
    subq $8, %rsp
    movq $65536, %rdi
    movq $16, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    addq $32, %r15
    movq $0, 0(%r15)
    movq $0, 8(%r15)
    movq $0, 16(%r15)
    movq $0, 24(%r15)
    jmp main_start

	.align 16
main_conclusion:
    subq $32, %r15
    addq $8, %rsp
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 


