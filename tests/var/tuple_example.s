	.align 16
conclusion:
    subq $8, %r15
    addq $8, %rsp
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.225:
    movq free_ptr(%rip), %r11
    addq $16, free_ptr(%rip)
    movq $131, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq -8(%r15), %rax
    movq %rax, 8(%r11)
    movq %rcx, %r11
    movq 8(%r11), %rcx
    movq %rcx, %r11
    movq 8(%r11), %rcx
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.227:
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
    jl block.225
    movq %r15, %rdi
    movq $16, %rsi
    callq collect
    jmp block.225

	.align 16
block.229:
    movq %rcx, %rdi
    callq print_int
    movq $42, %rbx
    movq free_ptr(%rip), %rcx
    addq $16, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.227
    movq %r15, %rdi
    movq $16, %rsi
    callq collect
    jmp block.227

	.align 16
block.231:
    movq $0, %rcx
    jmp block.229

	.align 16
block.230:
    movq $42, %rcx
    jmp block.229

	.align 16
block.232:
    cmpq %rcx, -8(%r15)
    sete %al
    movzbq %al, %rcx
    cmpq $0, %rcx
    je block.230
    jmp block.231

	.align 16
block.233:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $5, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r12, 8(%r11)
    movq %rcx, %r11
    movq %rbx, 16(%r11)
    movq -8(%r15), %rax
    cmpq -8(%r15), %rax
    je block.232
    jmp block.231

	.align 16
block.235:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $5, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r12, 8(%r11)
    movq %rcx, %r11
    movq %rbx, 16(%r11)
    movq %rcx, -8(%r15)
    movq $3, %r12
    movq $7, %rbx
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.233
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.233

	.align 16
block.237:
    movq free_ptr(%rip), %r11
    addq $32, free_ptr(%rip)
    movq $7, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %rbx, 8(%r11)
    movq %rcx, %r11
    movq %r12, 16(%r11)
    movq %rcx, %r11
    movq %r13, 24(%r11)
    movq %rcx, %r11
    movq 8(%r11), %rcx
    movq %rcx, %rdi
    callq print_int
    movq $3, %r12
    movq $7, %rbx
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.235
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.235

	.align 16
start:
    movq $42, %rbx
    movq $1, %r12
    movq $2, %r13
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.237
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.237

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
    addq $8, %r15
    jmp start


