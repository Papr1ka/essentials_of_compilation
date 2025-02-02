	.align 16
block.168:
    addq $1, %r12
    jmp block.167

	.align 16
block.169:
    movq $0, %rbx
    jmp block.168

	.align 16
block.170:
    movq -16(%rbp), %rax
    cmpq -8(%rbp), %rax
    je block.169
    jmp block.168

	.align 16
block.171:
    movq %r14, %r11
    movq %r12, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -8(%rbp)
    jmp block.170

	.align 16
block.172:
    movq $255, %rdi
    callq exit
    jmp block.170

	.align 16
block.173:
    movq %r14, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %r12
    jl block.171
    jmp block.172

	.align 16
block.174:
    cmpq $0, %r12
    jge block.173
    jmp block.172

	.align 16
block.175:
    movq %r14, %r11
    movq %r13, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -16(%rbp)
    jmp block.174

	.align 16
block.176:
    movq $255, %rdi
    callq exit
    jmp block.174

	.align 16
block.177:
    movq %r14, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %r13
    jl block.175
    jmp block.176

	.align 16
block.178:
    cmpq $0, %r13
    jge block.177
    jmp block.176

	.align 16
block.179:
    addq $1, %r13
    jmp block.166

	.align 16
block.167:
    cmpq %r13, %r12
    jl block.178
    cmpq $0, %rbx
    je block.179
    addq $1, -24(%rbp)
    jmp block.179

	.align 16
block.182:
    movq $1, %rbx
    movq $0, %r12
    jmp block.167

	.align 16
block.166:
    movq %r14, %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %r13
    jl block.182
    movq -24(%rbp), %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.184:
    movq free_ptr(%rip), %r11
    addq $208, free_ptr(%rip)
    movq $4611686018427388005, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r14, 8(%r11)
    movq %rcx, %r11
    movq %r13, 16(%r11)
    movq %rcx, %r11
    movq -24(%rbp), %rax
    movq %rax, 24(%r11)
    movq %rcx, %r11
    movq -32(%rbp), %rax
    movq %rax, 32(%r11)
    movq %rcx, %r11
    movq -40(%rbp), %rax
    movq %rax, 40(%r11)
    movq %rcx, %r11
    movq -48(%rbp), %rax
    movq %rax, 48(%r11)
    movq %rcx, %r11
    movq -56(%rbp), %rax
    movq %rax, 56(%r11)
    movq %rcx, %r11
    movq -64(%rbp), %rax
    movq %rax, 64(%r11)
    movq %rcx, %r11
    movq %r12, 72(%r11)
    movq %rcx, %r11
    movq -72(%rbp), %rax
    movq %rax, 80(%r11)
    movq %rcx, %r11
    movq -80(%rbp), %rax
    movq %rax, 88(%r11)
    movq %rcx, %r11
    movq -88(%rbp), %rax
    movq %rax, 96(%r11)
    movq %rcx, %r11
    movq -96(%rbp), %rax
    movq %rax, 104(%r11)
    movq %rcx, %r11
    movq -104(%rbp), %rax
    movq %rax, 112(%r11)
    movq %rcx, %r11
    movq -112(%rbp), %rax
    movq %rax, 120(%r11)
    movq %rcx, %r11
    movq -120(%rbp), %rax
    movq %rax, 128(%r11)
    movq %rcx, %r11
    movq -128(%rbp), %rax
    movq %rax, 136(%r11)
    movq %rcx, %r11
    movq %rbx, 144(%r11)
    movq %rcx, %r11
    movq -136(%rbp), %rax
    movq %rax, 152(%r11)
    movq %rcx, %r11
    movq -144(%rbp), %rax
    movq %rax, 160(%r11)
    movq %rcx, %r11
    movq -152(%rbp), %rax
    movq %rax, 168(%r11)
    movq %rcx, %r11
    movq -160(%rbp), %rax
    movq %rax, 176(%r11)
    movq %rcx, %r11
    movq -168(%rbp), %rax
    movq %rax, 184(%r11)
    movq %rcx, %r11
    movq -176(%rbp), %rax
    movq %rax, 192(%r11)
    movq %rcx, %r11
    movq -184(%rbp), %rax
    movq %rax, 200(%r11)
    movq %rcx, %r14
    movq $0, -24(%rbp)
    movq $0, %r13
    jmp block.166

	.align 16
main_start:
    movq $6, %r14
    movq $4, %r13
    movq $7, -24(%rbp)
    movq $10, -32(%rbp)
    movq $6, -40(%rbp)
    movq $1, -48(%rbp)
    movq $8, -56(%rbp)
    negq -56(%rbp)
    movq $7, -64(%rbp)
    movq $2, %r12
    negq %r12
    movq $4, -72(%rbp)
    movq $7, -80(%rbp)
    movq $7, -88(%rbp)
    movq $5, -96(%rbp)
    movq $7, -104(%rbp)
    movq $0, -112(%rbp)
    movq $10, -120(%rbp)
    negq -120(%rbp)
    movq $4, -128(%rbp)
    movq $7, %rbx
    movq $10, -136(%rbp)
    negq -136(%rbp)
    movq $1, -144(%rbp)
    movq $2, -152(%rbp)
    negq -152(%rbp)
    movq $0, -160(%rbp)
    movq $4, -168(%rbp)
    negq -168(%rbp)
    movq $5, -176(%rbp)
    movq $1, -184(%rbp)
    movq free_ptr(%rip), %rcx
    addq $208, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.184
    movq %r15, %rdi
    movq $208, %rsi
    callq collect
    jmp block.184

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    movq %rsp, %rbp
    subq $192, %rsp
    movq $65536, %rdi
    movq $16, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    addq $0, %r15
    jmp main_start

	.align 16
main_conclusion:
    subq $0, %r15
    addq $192, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 


