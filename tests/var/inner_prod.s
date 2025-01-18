	.align 16
conclusion:
    subq $8, %r15
    addq $16, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.288:
    movq %r14, %rcx
    imulq -8(%rbp), %rcx
    addq %rcx, %rbx
    addq $1, %r12
    jmp block.287

	.align 16
block.290:
    movq $255, %rdi
    callq exit
    jmp block.288

	.align 16
block.289:
    movq %r13, %r11
    movq %r12, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -8(%rbp)
    jmp block.288

	.align 16
block.291:
    movq %r13, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %r12
    jl block.289
    jmp block.290

	.align 16
block.292:
    cmpq $0, %r12
    jge block.291
    jmp block.290

	.align 16
block.294:
    movq $255, %rdi
    callq exit
    jmp block.292

	.align 16
block.293:
    movq -8(%r15), %r11
    movq %r12, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %r14
    jmp block.292

	.align 16
block.295:
    movq -8(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %r12
    jl block.293
    jmp block.294

	.align 16
block.296:
    cmpq $0, %r12
    jge block.295
    jmp block.294

	.align 16
block.287:
    movq -8(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %r12
    jl block.296
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.298:
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
    jmp block.287

	.align 16
block.300:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $4611686018427387913, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %rbx, 8(%r11)
    movq %rcx, %r11
    movq %r12, 16(%r11)
    movq %rcx, -8(%r15)
    movq $8, %rbx
    movq $9, %r12
    movq $11, %r13
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.298
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.298

	.align 16
start:
    movq $5, %rbx
    movq $10, %r12
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.300
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.300

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
    movq $0, 0(%r15)
    addq $8, %r15
    jmp start


