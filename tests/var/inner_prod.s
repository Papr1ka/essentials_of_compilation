	.align 16
block.360:
    movq %r14, %rcx
    imulq -8(%rbp), %rcx
    addq %rcx, %rbx
    addq $1, %r12
    jmp block.359

	.align 16
block.362:
    movq $255, %rdi
    callq exit
    jmp block.360

	.align 16
block.361:
    movq %r13, %r11
    movq %r12, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -8(%rbp)
    jmp block.360

	.align 16
block.363:
    movq %r13, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %r12
    jl block.361
    jmp block.362

	.align 16
block.364:
    cmpq $0, %r12
    jge block.363
    jmp block.362

	.align 16
block.365:
    movq -8(%r15), %r11
    movq %r12, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %r14
    jmp block.364

	.align 16
block.366:
    movq $255, %rdi
    callq exit
    jmp block.364

	.align 16
block.367:
    movq -8(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %r12
    jl block.365
    jmp block.366

	.align 16
block.368:
    cmpq $0, %r12
    jge block.367
    jmp block.366

	.align 16
block.359:
    movq -8(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %r12
    jl block.368
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.370:
    movq free_ptr(%rip), %r11
    addq $32, free_ptr(%rip)
    movq $4611686018427387917, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %rbx, 8(%r11)
    movq %rcx, %r11
    movq %r12, 16(%r11)
    movq %rcx, %r11
    movq %r13, 24(%r11)
    movq %rcx, %r13
    movq $0, %r12
    movq $0, %rbx
    jmp block.359

	.align 16
block.372:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $4611686018427387913, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r12, 8(%r11)
    movq %rcx, %r11
    movq %rbx, 16(%r11)
    movq %rcx, -8(%r15)
    movq $8, %rbx
    movq $9, %r12
    movq $11, %r13
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.370
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.370

	.align 16
main_start:
    movq $5, %r12
    movq $10, %rbx
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.372
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.372

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
    addq $8, %r15
    movq $0, 0(%r15)
    jmp main_start

	.align 16
main_conclusion:
    subq $8, %r15
    addq $16, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 


