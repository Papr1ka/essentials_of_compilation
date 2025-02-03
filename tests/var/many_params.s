	.align 16
block.862:
    movq free_ptr(%rip), %r11
    addq $48, free_ptr(%rip)
    movq $11, 0(%r11)
    movq %r11, %r9
    movq %r9, %r11
    movq %rbx, 8(%r11)
    movq %r9, %r11
    movq %r13, 16(%r11)
    movq %r9, %r11
    movq %r14, 24(%r11)
    movq %r9, %r11
    movq -8(%rbp), %rax
    movq %rax, 32(%r11)
    movq %r9, %r11
    movq -16(%rbp), %rax
    movq %rax, 40(%r11)
    movq $1, %rdi
    movq $2, %rsi
    movq $3, %rdx
    movq $4, %rcx
    movq $5, %r8
    callq *%r12
    movq %rax, %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.864:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $5, 0(%r11)
    movq %r11, %r9
    movq %r9, %r11
    movq %rbx, 8(%r11)
    movq %r9, %r11
    movq %r14, 16(%r11)
    movq $1, %rdi
    movq $2, %rsi
    movq $3, %rdx
    movq $4, %rcx
    movq $5, %r8
    callq *%r13
    movq %rax, %rdi
    callq print_int
    leaq sum10(%rip), %r12
    movq $6, %rbx
    movq $7, %r13
    movq $8, %r14
    movq $9, -8(%rbp)
    movq $10, -16(%rbp)
    movq free_ptr(%rip), %rcx
    addq $48, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.862
    movq %r15, %rdi
    movq $48, %rsi
    callq collect
    jmp block.862

	.align 16
main_start:
    leaq sum5(%rip), %r9
    movq $1, %rdi
    movq $2, %rsi
    movq $3, %rdx
    movq $4, %rcx
    movq $5, %r8
    callq *%r9
    movq %rax, %rdi
    callq print_int
    leaq sum6(%rip), %rbx
    movq $1, %rdi
    movq $2, %rsi
    movq $3, %rdx
    movq $4, %rcx
    movq $5, %r8
    movq $6, %r9
    callq *%rbx
    movq %rax, %rdi
    callq print_int
    leaq sum7(%rip), %r13
    movq $6, %rbx
    movq $7, %r14
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.864
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.864

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    movq %rsp, %rbp
    subq $16, %rsp
    movq $65536, %rdi
    movq $16, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    addq $0, %r15
    jmp main_start

	.align 16
main_conclusion:
    subq $0, %r15
    addq $16, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
sum5_start:
    addq %rsi, %rdi
    addq %rdx, %rdi
    addq %rcx, %rdi
    movq %rdi, %rax
    addq %r8, %rax
    jmp sum5_conclusion

	.align 16
sum5:
    pushq %rbp
    movq %rsp, %rbp
    subq $0, %rsp
    addq $0, %r15
    jmp sum5_start

	.align 16
sum5_conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %rbp
    retq 

	.align 16
sum6_start:
    addq %rsi, %rdi
    addq %rdx, %rdi
    addq %rcx, %rdi
    addq %r8, %rdi
    movq %rdi, %rax
    addq %r9, %rax
    jmp sum6_conclusion

	.align 16
sum6:
    pushq %rbp
    movq %rsp, %rbp
    subq $0, %rsp
    addq $0, %r15
    jmp sum6_start

	.align 16
sum6_conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %rbp
    retq 

	.align 16
sum7_start:
    addq %rsi, %rdi
    addq %rdx, %rdi
    addq %rcx, %rdi
    movq %rdi, %rcx
    addq %r8, %rcx
    movq %r9, %r11
    movq 8(%r11), %rdx
    addq %rdx, %rcx
    movq %r9, %r11
    movq 16(%r11), %rdx
    movq %rcx, %rax
    addq %rdx, %rax
    jmp sum7_conclusion

	.align 16
sum7:
    pushq %rbp
    movq %rsp, %rbp
    subq $0, %rsp
    addq $0, %r15
    jmp sum7_start

	.align 16
sum7_conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %rbp
    retq 

	.align 16
sum10_start:
    addq %rsi, %rdi
    addq %rdx, %rdi
    addq %rcx, %rdi
    addq %r8, %rdi
    movq %r9, %r11
    movq 8(%r11), %rcx
    addq %rcx, %rdi
    movq %r9, %r11
    movq 16(%r11), %rdx
    movq %rdi, %rcx
    addq %rdx, %rcx
    movq %r9, %r11
    movq 24(%r11), %rdx
    addq %rdx, %rcx
    movq %r9, %r11
    movq 32(%r11), %rdx
    addq %rdx, %rcx
    movq %r9, %r11
    movq 40(%r11), %rdx
    movq %rcx, %rax
    addq %rdx, %rax
    jmp sum10_conclusion

	.align 16
sum10:
    pushq %rbp
    movq %rsp, %rbp
    subq $0, %rsp
    addq $0, %r15
    jmp sum10_start

	.align 16
sum10_conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %rbp
    retq 


