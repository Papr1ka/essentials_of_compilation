	.align 16
block.335:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $5, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r13, 8(%r11)
    movq %rcx, %r11
    movq %r12, 16(%r11)
    movq %rcx, %r12
    addq $1, %rbx
    jmp block.334

	.align 16
block.337:
    movq %r12, %r11
    movq 16(%r11), %r13
    movq %r12, %r11
    movq 8(%r11), %rcx
    movq %r12, %r11
    movq 16(%r11), %rdx
    movq %rcx, %r12
    addq %rdx, %r12
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.335
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.335

	.align 16
block.334:
    cmpq $8, %rbx
    jl block.337
    movq %r12, %r11
    movq 8(%r11), %rcx
    movq %r12, %r11
    movq 16(%r11), %rdx
    addq %rdx, %rcx
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.339:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $5, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r12, 8(%r11)
    movq %rcx, %r11
    movq %rbx, 16(%r11)
    movq %rcx, %r12
    movq $0, %rbx
    jmp block.334

	.align 16
main_start:
    movq $0, %r12
    movq $1, %rbx
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.339
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.339

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
    addq $0, %r15
    jmp main_start

	.align 16
main_conclusion:
    subq $0, %r15
    addq $8, %rsp
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 


