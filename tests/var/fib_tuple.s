	.align 16
conclusion:
    subq $0, %r15
    addq $8, %rsp
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.266:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $5, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %rbx, 8(%r11)
    movq %rcx, %r11
    movq %r12, 16(%r11)
    movq %rcx, %r12
    addq $1, %r13
    jmp block.265

	.align 16
block.268:
    movq %r12, %r11
    movq 16(%r11), %rbx
    movq %r12, %r11
    movq 8(%r11), %rcx
    movq %r12, %r11
    movq 16(%r11), %rdx
    movq %rcx, %r12
    addq %rdx, %r12
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.266
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.266

	.align 16
block.265:
    cmpq $8, %r13
    jl block.268
    movq %r12, %r11
    movq 8(%r11), %rcx
    movq %r12, %r11
    movq 16(%r11), %rdx
    addq %rdx, %rcx
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.270:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $5, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %rbx, 8(%r11)
    movq %rcx, %r11
    movq %r12, 16(%r11)
    movq %rcx, %r12
    movq $0, %r13
    jmp block.265

	.align 16
start:
    movq $0, %rbx
    movq $1, %r12
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.270
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.270

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
    jmp start


