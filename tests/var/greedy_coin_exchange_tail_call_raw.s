	.align 16
main_start:
    callq read_int
    movq %rax, %rdi
    leaq exchange(%rip), %rbx
    movq $0, %rsi
    movq $0, %rdx
    movq $0, %rcx
    callq *%rbx
    movq %rax, %rbx
    movq %rbx, %r11
    movq 8(%r11), %rdi
    callq print_int
    movq %rbx, %r11
    movq 16(%r11), %rdi
    callq print_int
    movq %rbx, %r11
    movq 24(%r11), %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

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

	.align 16
block.1148:
    leaq exchange(%rip), %r10
    subq $5, %r9
    movq $1, %r8
    addq %rcx, %r8
    movq %r9, %rdi
    movq %r12, %rsi
    movq %r8, %rcx
    movq %r10, %rax
    subq $0, %r15
    addq $8, %rsp
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    jmp *%rax

	.align 16
block.1149:
    leaq exchange(%rip), %r10
    subq $2, %r9
    movq $1, %r8
    addq %rdx, %r8
    movq %r9, %rdi
    movq %r12, %rsi
    movq %r8, %rdx
    movq %r10, %rax
    subq $0, %r15
    addq $8, %rsp
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    jmp *%rax

	.align 16
block.1152:
    movq free_ptr(%rip), %r11
    addq $32, free_ptr(%rip)
    movq $7, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r12, 8(%r11)
    movq %rcx, %r11
    movq %r13, 16(%r11)
    movq %rcx, %r11
    movq %rbx, 24(%r11)
    movq %rcx, %rax
    jmp exchange_conclusion

	.align 16
block.1154:
    movq %rdx, %r13
    movq %rcx, %rbx
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.1152
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.1152

	.align 16
exchange_start:
    movq %rdi, %r9
    movq %rsi, %r12
    cmpq $0, %r9
    je block.1154
    cmpq $5, %r9
    jge block.1148
    cmpq $2, %r9
    jge block.1149
    leaq exchange(%rip), %r8
    movq %r9, %rdi
    subq $1, %rdi
    movq $1, %rsi
    addq %r12, %rsi
    movq %r8, %rax
    subq $0, %r15
    addq $8, %rsp
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    jmp *%rax

	.align 16
exchange:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    movq %rsp, %rbp
    subq $8, %rsp
    addq $0, %r15
    jmp exchange_start

	.align 16
exchange_conclusion:
    subq $0, %r15
    addq $8, %rsp
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 


