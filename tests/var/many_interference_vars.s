	.align 16
main_start:
    movq $1, %rdi
    movq $2, -8(%rbp)
    movq $3, -16(%rbp)
    movq $4, -24(%rbp)
    movq $5, -32(%rbp)
    movq $6, -40(%rbp)
    movq $7, -48(%rbp)
    movq $8, -56(%rbp)
    movq $9, %r14
    movq $10, -64(%rbp)
    movq $11, -72(%rbp)
    movq $12, %r13
    movq $13, %r12
    movq $14, -80(%rbp)
    movq $15, -88(%rbp)
    movq $16, %rbx
    callq print_int
    movq -8(%rbp), %rdi
    callq print_int
    movq -16(%rbp), %rdi
    callq print_int
    movq -24(%rbp), %rdi
    callq print_int
    movq -32(%rbp), %rdi
    callq print_int
    movq -40(%rbp), %rdi
    callq print_int
    movq -48(%rbp), %rdi
    callq print_int
    movq -56(%rbp), %rdi
    callq print_int
    movq %r14, %rdi
    callq print_int
    movq -64(%rbp), %rdi
    callq print_int
    movq -72(%rbp), %rdi
    callq print_int
    movq %r13, %rdi
    callq print_int
    movq %r12, %rdi
    callq print_int
    movq -80(%rbp), %rdi
    callq print_int
    movq -88(%rbp), %rdi
    callq print_int
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    movq %rsp, %rbp
    subq $96, %rsp
    movq $65536, %rdi
    movq $16, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    addq $0, %r15
    jmp main_start

	.align 16
main_conclusion:
    subq $0, %r15
    addq $96, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 


