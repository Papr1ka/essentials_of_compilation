	.align 16
conclusion:
    subq $32, %r15
    addq $8, %rsp
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.232:
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.234:
    movq $0, %rcx
    jmp block.232

	.align 16
block.233:
    movq $42, %rcx
    jmp block.232

	.align 16
block.235:
    movq -8(%r15), %r11
    movq 0(%r11), %rcx
    andq $126, %rcx
    sarq $1, %rcx
    movq %rbx, %r11
    movq 0(%r11), %rdx
    andq $126, %rdx
    sarq $1, %rdx
    cmpq %rdx, %rcx
    je block.233
    jmp block.234

	.align 16
block.236:
    movq -16(%r15), %r11
    movq 0(%r11), %rcx
    andq $126, %rcx
    sarq $1, %rcx
    movq -24(%r15), %r11
    movq 0(%r11), %rdx
    andq $126, %rdx
    sarq $1, %rdx
    cmpq %rdx, %rcx
    je block.235
    jmp block.234

	.align 16
block.237:
    movq -32(%r15), %r11
    movq 0(%r11), %rcx
    andq $126, %rcx
    sarq $1, %rcx
    cmpq $3, %rcx
    je block.236
    jmp block.234

	.align 16
block.238:
    movq free_ptr(%rip), %r11
    addq $16, free_ptr(%rip)
    movq $131, 0(%r11)
    movq %r11, %rbx
    movq %rbx, %r11
    movq -8(%r15), %rax
    movq %rax, 8(%r11)
    movq %rbx, %r11
    movq 8(%r11), %rcx
    movq %rcx, %r11
    movq 8(%r11), %rcx
    movq %rcx, %rdi
    callq print_int
    movq -16(%r15), %r11
    movq 0(%r11), %rcx
    andq $126, %rcx
    sarq $1, %rcx
    cmpq $2, %rcx
    je block.237
    jmp block.234

	.align 16
block.240:
    movq free_ptr(%rip), %r11
    addq $16, free_ptr(%rip)
    movq $3, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %rbx, 8(%r11)
    movq %rcx, -8(%r15)
    movq free_ptr(%rip), %rcx
    addq $16, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.238
    movq %r15, %rdi
    movq $16, %rsi
    callq collect
    jmp block.238

	.align 16
block.242:
    movq %rcx, %rdi
    callq print_int
    movq $42, %rbx
    movq free_ptr(%rip), %rcx
    addq $16, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.240
    movq %r15, %rdi
    movq $16, %rsi
    callq collect
    jmp block.240

	.align 16
block.244:
    movq $0, %rcx
    jmp block.242

	.align 16
block.243:
    movq $42, %rcx
    jmp block.242

	.align 16
block.245:
    movq -16(%r15), %rax
    cmpq -24(%r15), %rax
    sete %al
    movzbq %al, %rcx
    cmpq $0, %rcx
    je block.243
    jmp block.244

	.align 16
block.246:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $5, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r12, 8(%r11)
    movq %rcx, %r11
    movq %rbx, 16(%r11)
    movq %rcx, -24(%r15)
    movq -16(%r15), %rax
    cmpq -16(%r15), %rax
    je block.245
    jmp block.244

	.align 16
block.248:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $5, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %rbx, 8(%r11)
    movq %rcx, %r11
    movq %r12, 16(%r11)
    movq %rcx, -16(%r15)
    movq $3, %r12
    movq $7, %rbx
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.246
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.246

	.align 16
block.250:
    movq free_ptr(%rip), %r11
    addq $32, free_ptr(%rip)
    movq $7, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r12, 8(%r11)
    movq %rcx, %r11
    movq %rbx, 16(%r11)
    movq %rcx, %r11
    movq %r13, 24(%r11)
    movq %rcx, -32(%r15)
    movq -32(%r15), %r11
    movq 8(%r11), %rcx
    movq %rcx, %rdi
    callq print_int
    movq $3, %rbx
    movq $7, %r12
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.248
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.248

	.align 16
start:
    movq $42, %r12
    movq $1, %rbx
    movq $2, %r13
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.250
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.250

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
    movq $0, 0(%r15)
    movq $0, 1(%r15)
    movq $0, 2(%r15)
    movq $0, 3(%r15)
    addq $32, %r15
    jmp start


