	.align 16
block.1122:
    movq free_ptr(%rip), %r11
    addq $32, free_ptr(%rip)
    movq $7, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r14, 8(%r11)
    movq %rcx, %r11
    movq -8(%rbp), %rax
    movq %rax, 16(%r11)
    movq %rcx, %r11
    movq -16(%rbp), %rax
    movq %rax, 24(%r11)
    movq %rbx, %rdi
    movq %rcx, %rsi
    callq *%r13
    movq %rax, %rdi
    callq *%r12
    movq $0, %rax
    jmp main_conclusion

	.align 16
main_start:
    callq read_int
    movq %rax, %rbx
    leaq print_coins(%rip), %r12
    leaq exchange(%rip), %r13
    movq $0, %r14
    movq $0, -8(%rbp)
    movq $0, -16(%rbp)
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.1122
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.1122

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
print_coins_start:
    movq %rdi, %rbx
    movq %rbx, %r11
    movq 8(%r11), %rdi
    callq print_int
    movq %rbx, %r11
    movq 16(%r11), %rdi
    callq print_int
    movq %rbx, %r11
    movq 24(%r11), %rdi
    callq print_int
    jmp print_coins_conclusion

	.align 16
print_coins:
    pushq %rbp
    pushq %rbx
    movq %rsp, %rbp
    subq $8, %rsp
    addq $0, %r15
    jmp print_coins_start

	.align 16
print_coins_conclusion:
    subq $0, %r15
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.1124:
    movq %rsi, %r11
    movq 24(%r11), %r8
    movq $1, %rdi
    addq %r8, %rdi
    movq %rsi, %r11
    movq %rdi, 24(%r11)
    leaq exchange(%rip), %rcx
    subq $5, %rdx
    movq %rdx, %rdi
    movq %rcx, %rax
    subq $0, %r15
    addq $0, %rsp
    popq %rbp
    jmp *%rax

	.align 16
block.1125:
    movq %rsi, %r11
    movq 16(%r11), %r8
    movq $1, %rdi
    addq %r8, %rdi
    movq %rsi, %r11
    movq %rdi, 16(%r11)
    leaq exchange(%rip), %rcx
    subq $2, %rdx
    movq %rdx, %rdi
    movq %rcx, %rax
    subq $0, %r15
    addq $0, %rsp
    popq %rbp
    jmp *%rax

	.align 16
block.1128:
    movq %rsi, %rax
    jmp exchange_conclusion

	.align 16
exchange_start:
    movq %rdi, %rdx
    cmpq $0, %rdx
    je block.1128
    cmpq $5, %rdx
    jge block.1124
    cmpq $2, %rdx
    jge block.1125
    movq %rsi, %r11
    movq 8(%r11), %r9
    movq $1, %rdi
    addq %r9, %rdi
    movq %rsi, %r11
    movq %rdi, 8(%r11)
    leaq exchange(%rip), %r8
    movq %rdx, %rdi
    subq $1, %rdi
    movq %r8, %rax
    subq $0, %r15
    addq $0, %rsp
    popq %rbp
    jmp *%rax

	.align 16
exchange:
    pushq %rbp
    movq %rsp, %rbp
    subq $0, %rsp
    addq $0, %r15
    jmp exchange_start

	.align 16
exchange_conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %rbp
    retq 


