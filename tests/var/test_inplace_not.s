	.align 16
block.725:
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.726:
    movq $0, %rdi
    jmp block.725

	.align 16
block.728:
    xorq $1, %rcx
    xorq $1, %rcx
    cmpq $0, %rcx
    je block.726
    movq $1, %rdi
    jmp block.725

	.align 16
block.729:
    movq $1, %rcx
    jmp block.728

	.align 16
block.731:
    cmpq $0, %rbx
    je block.729
    movq %rdx, %rcx
    xorq $1, %rcx
    jmp block.728

	.align 16
block.732:
    movq %rdx, %rcx
    xorq $1, %rcx
    jmp block.731

	.align 16
main_start:
    callq read_int
    movq %rax, %rcx
    cmpq $0, %rcx
    sete %al
    movzbq %al, %rbx
    callq read_int
    movq %rax, %rcx
    cmpq $1, %rcx
    sete %al
    movzbq %al, %rdx
    xorq $1, %rbx
    movq %rbx, %rdx
    xorq $1, %rdx
    cmpq $0, %rbx
    je block.732
    movq $0, %rcx
    jmp block.731

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    movq %rsp, %rbp
    subq $8, %rsp
    movq $65536, %rdi
    movq $16, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    addq $0, %r15
    jmp main_start

	.align 16
main_conclusion:
    subq $0, %r15
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 


