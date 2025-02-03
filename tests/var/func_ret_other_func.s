	.align 16
block.881:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $5, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r14, 8(%r11)
    movq %rcx, %r11
    movq %rbx, 16(%r11)
    movq %r13, %rdi
    movq %rcx, %rsi
    callq *%r12
    movq %rax, %rcx
    movq %rcx, %r11
    movq 16(%r11), %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
main_start:
    leaq test(%rip), %rcx
    callq *%rcx
    movq %rax, %r13
    leaq map(%rip), %r12
    movq $0, %r14
    movq $41, %rbx
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.881
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.881

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
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
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
test_start:
    leaq inc(%rip), %rax
    jmp test_conclusion

	.align 16
test:
    pushq %rbp
    movq %rsp, %rbp
    subq $0, %rsp
    addq $0, %r15
    jmp test_start

	.align 16
test_conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %rbp
    retq 

	.align 16
inc_start:
    movq $1, %rax
    addq %rdi, %rax
    jmp inc_conclusion

	.align 16
inc:
    pushq %rbp
    movq %rsp, %rbp
    subq $0, %rsp
    addq $0, %r15
    jmp inc_start

	.align 16
inc_conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %rbp
    retq 

	.align 16
block.883:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $5, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r12, 8(%r11)
    movq %rcx, %r11
    movq %rbx, 16(%r11)
    movq %rcx, %rax
    jmp map_conclusion

	.align 16
map_start:
    movq %rdi, %rbx
    movq %rsi, -8(%r15)
    movq -8(%r15), %r11
    movq 8(%r11), %rdi
    callq *%rbx
    movq %rax, %r12
    movq -8(%r15), %r11
    movq 16(%r11), %rdi
    callq *%rbx
    movq %rax, %rbx
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.883
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.883

	.align 16
map:
    pushq %rbp
    pushq %rbx
    pushq %r12
    movq %rsp, %rbp
    subq $0, %rsp
    addq $8, %r15
    movq $0, 0(%r15)
    jmp map_start

	.align 16
map_conclusion:
    subq $8, %r15
    addq $0, %rsp
    popq %r12
    popq %rbx
    popq %rbp
    retq 


