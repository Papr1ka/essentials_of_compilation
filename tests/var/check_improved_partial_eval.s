	.align 16
main_start:
    callq read_int
    movq %rax, %rcx
    movq $2, %rdi
    addq %rcx, %rdi
    callq print_int
    callq read_int
    movq %rax, %rcx
    movq $3, %rdi
    subq %rcx, %rdi
    callq print_int
    callq read_int
    movq %rax, %rcx
    movq $3, %rdi
    addq %rcx, %rdi
    callq print_int
    callq read_int
    movq %rax, %rcx
    subq $6, %rcx
    movq $3, %rdi
    addq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $0, %rsp
    movq $65536, %rdi
    movq $16, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    addq $0, %r15
    jmp main_start

	.align 16
main_conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %rbp
    retq 


