	.align 16
block.223:
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.224:
    movq $-1, %rdi
    callq print_int
    jmp block.223

	.align 16
block.237:
    cmpq %rbx, %r13
    jg block.224
    movq %r12, %rdi
    callq print_int
    jmp block.223

	.align 16
block.228:
    subq $2, %rcx
    addq $1, %r12
    jmp block.227

	.align 16
block.229:
    movq %r13, %rcx
    addq %rbx, %rcx
    movq $0, %r12
    jmp block.227

	.align 16
block.230:
    movq $1, %r13
    addq %r12, %r13
    jmp block.229

	.align 16
block.232:
    cmpq -8(%rbp), %r14
    jg block.230
    movq %r12, %rbx
    subq $1, %rbx
    jmp block.229

	.align 16
block.234:
    movq $255, %rdi
    callq exit
    jmp block.232

	.align 16
block.233:
    movq -8(%r15), %r11
    movq %r12, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -8(%rbp)
    jmp block.232

	.align 16
block.235:
    movq -8(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %r12
    jl block.233
    jmp block.234

	.align 16
block.236:
    cmpq $0, %r12
    jge block.235
    jmp block.234

	.align 16
block.238:
    cmpq %rbx, %r13
    jle block.236
    jmp block.237

	.align 16
block.239:
    cmpq %r14, -16(%rbp)
    jne block.238
    jmp block.237

	.align 16
block.241:
    movq $255, %rdi
    callq exit
    jmp block.239

	.align 16
block.240:
    movq -8(%r15), %r11
    movq %r12, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -16(%rbp)
    jmp block.239

	.align 16
block.242:
    movq -8(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %r12
    jl block.240
    jmp block.241

	.align 16
block.226:
    cmpq $0, %r12
    jge block.242
    jmp block.241

	.align 16
block.243:
    movq free_ptr(%rip), %r11
    addq $208, free_ptr(%rip)
    movq $4611686018427388005, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r13, 8(%r11)
    movq %rcx, %r11
    movq %r14, 16(%r11)
    movq %rcx, %r11
    movq %r12, 24(%r11)
    movq %rcx, %r11
    movq %rbx, 32(%r11)
    movq %rcx, %r11
    movq -24(%rbp), %rax
    movq %rax, 40(%r11)
    movq %rcx, %r11
    movq -32(%rbp), %rax
    movq %rax, 48(%r11)
    movq %rcx, %r11
    movq -40(%rbp), %rax
    movq %rax, 56(%r11)
    movq %rcx, %r11
    movq -48(%rbp), %rax
    movq %rax, 64(%r11)
    movq %rcx, %r11
    movq -56(%rbp), %rax
    movq %rax, 72(%r11)
    movq %rcx, %r11
    movq -64(%rbp), %rax
    movq %rax, 80(%r11)
    movq %rcx, %r11
    movq -72(%rbp), %rax
    movq %rax, 88(%r11)
    movq %rcx, %r11
    movq -80(%rbp), %rax
    movq %rax, 96(%r11)
    movq %rcx, %r11
    movq -88(%rbp), %rax
    movq %rax, 104(%r11)
    movq %rcx, %r11
    movq -96(%rbp), %rax
    movq %rax, 112(%r11)
    movq %rcx, %r11
    movq -104(%rbp), %rax
    movq %rax, 120(%r11)
    movq %rcx, %r11
    movq -112(%rbp), %rax
    movq %rax, 128(%r11)
    movq %rcx, %r11
    movq -120(%rbp), %rax
    movq %rax, 136(%r11)
    movq %rcx, %r11
    movq -128(%rbp), %rax
    movq %rax, 144(%r11)
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
    movq %rcx, -8(%r15)
    callq read_int
    movq %rax, %r14
    movq $0, %r13
    movq -8(%r15), %r11
    movq 0(%r11), %rbx
    movq $4611686018427387900, %rcx
    andq %rcx, %rbx
    sarq $2, %rbx
    subq $1, %rbx
    movq $12, %r12
    jmp block.226

	.align 16
block.227:
    cmpq $2, %rcx
    jge block.228
    jmp block.226

	.align 16
main_start:
    movq $30, %r13
    negq %r13
    movq $26, %r14
    negq %r14
    movq $26, %r12
    negq %r12
    movq $22, %rbx
    negq %rbx
    movq $19, -24(%rbp)
    negq -24(%rbp)
    movq $15, -32(%rbp)
    negq -32(%rbp)
    movq $12, -40(%rbp)
    negq -40(%rbp)
    movq $10, -48(%rbp)
    negq -48(%rbp)
    movq $9, -56(%rbp)
    negq -56(%rbp)
    movq $8, -64(%rbp)
    negq -64(%rbp)
    movq $0, -72(%rbp)
    movq $0, -80(%rbp)
    movq $2, -88(%rbp)
    movq $7, -96(%rbp)
    movq $20, -104(%rbp)
    movq $29, -112(%rbp)
    movq $30, -120(%rbp)
    movq $31, -128(%rbp)
    movq $32, -136(%rbp)
    movq $32, -144(%rbp)
    movq $38, -152(%rbp)
    movq $38, -160(%rbp)
    movq $43, -168(%rbp)
    movq $46, -176(%rbp)
    movq $48, -184(%rbp)
    movq free_ptr(%rip), %rcx
    addq $208, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.243
    movq %r15, %rdi
    movq $208, %rsi
    callq collect
    jmp block.243

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
    addq $8, %r15
    movq $0, 0(%r15)
    jmp main_start

	.align 16
main_conclusion:
    subq $8, %r15
    addq $192, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 


