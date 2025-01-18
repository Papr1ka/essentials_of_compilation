	.align 16
conclusion:
    subq $8, %r15
    addq $32, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.764:
    movq -8(%rbp), %rdi
    callq print_int
    addq $1, %rbx
    jmp block.763

	.align 16
block.766:
    movq $255, %rdi
    callq exit
    jmp block.764

	.align 16
block.765:
    movq %r12, %r11
    movq %rbx, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -8(%rbp)
    jmp block.764

	.align 16
block.767:
    movq %r12, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %rbx
    jl block.765
    jmp block.766

	.align 16
block.768:
    cmpq $0, %rbx
    jge block.767
    jmp block.766

	.align 16
block.763:
    movq %r12, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %rbx
    jl block.768
    movq $0, %rax
    jmp conclusion

	.align 16
block.771:
    addq $1, %rbx
    jmp block.770

	.align 16
block.772:
    movq %r12, %r11
    imulq $8, %r13
    addq %r13, %r11
    movq -16(%rbp), %rax
    movq %rax, 8(%r11)
    jmp block.771

	.align 16
block.773:
    movq -8(%r15), %r11
    movq %rbx, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -16(%rbp)
    jmp block.772

	.align 16
block.774:
    movq $255, %rdi
    callq exit
    jmp block.772

	.align 16
block.775:
    movq -8(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %rbx
    jl block.773
    jmp block.774

	.align 16
block.776:
    movq %r12, %r11
    movq 0(%r11), %r13
    movq $4611686018427387900, %rcx
    andq %rcx, %r13
    sarq $2, %r13
    subq %rbx, %r13
    subq $1, %r13
    cmpq $0, %rbx
    jge block.775
    jmp block.774

	.align 16
block.777:
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
    jl block.776
    jmp block.771

	.align 16
block.778:
    movq %r12, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    movq %rdx, %rcx
    subq %rbx, %rcx
    subq $1, %rcx
    cmpq $0, %rcx
    jge block.777
    jmp block.771

	.align 16
block.770:
    movq -8(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %rbx
    jl block.778
    movq $0, %rbx
    jmp block.763

	.align 16
block.780:
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
    jmp block.770

	.align 16
block.782:
    movq free_ptr(%rip), %r11
    addq $48, free_ptr(%rip)
    movq $4611686018427387925, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r12, 8(%r11)
    movq %rcx, %r11
    movq %rbx, 16(%r11)
    movq %rcx, %r11
    movq %r13, 24(%r11)
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
    jl block.780
    movq %r15, %rdi
    movq $48, %rsi
    callq collect
    jmp block.780

	.align 16
start:
    callq read_int
    movq %rax, %r12
    callq read_int
    movq %rax, %rbx
    callq read_int
    movq %rax, %r13
    callq read_int
    movq %rax, %r14
    callq read_int
    movq %rax, -32(%rbp)
    movq free_ptr(%rip), %rcx
    addq $48, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.782
    movq %r15, %rdi
    movq $48, %rsi
    callq collect
    jmp block.782

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
    movq $0, 0(%r15)
    addq $8, %r15
    jmp start


