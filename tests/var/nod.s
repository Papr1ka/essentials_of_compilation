	.align 16
block.682:
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.686:
    movq %rbx, %rdi
    callq print_int
    jmp block.682

	.align 16
block.685:
    movq %rbx, %rdi
    callq print_int
    jmp block.682

	.align 16
block.684:
    movq %rbx, %rdi
    callq print_int
    jmp block.682

	.align 16
block.683:
    movq %rbx, %rdi
    callq print_int
    jmp block.682

	.align 16
block.687:
    subq %rcx, %rbx
    jmp block.686

	.align 16
block.690:
    cmpq %rcx, %rbx
    je block.685
    cmpq %rcx, %rbx
    jg block.687
    subq %rbx, %rcx
    jmp block.686

	.align 16
block.691:
    subq %rcx, %rbx
    jmp block.690

	.align 16
block.694:
    cmpq %rcx, %rbx
    je block.684
    cmpq %rcx, %rbx
    jg block.691
    subq %rbx, %rcx
    jmp block.690

	.align 16
block.695:
    subq %rcx, %rbx
    jmp block.694

	.align 16
main_start:
    callq read_int
    movq %rax, %rbx
    callq read_int
    movq %rax, %rcx
    cmpq %rcx, %rbx
    je block.683
    cmpq %rcx, %rbx
    jg block.695
    subq %rbx, %rcx
    jmp block.694

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


