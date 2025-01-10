	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
block.60:
    movq $0, %rax
    jmp conclusion

	.align 16
block.61:
    movq %rdi, %rcx
    addq %rdx, %rcx
    movq %rdx, %rdi
    movq %rcx, %rdx
    subq $1, %rsi
    jmp block.60

	.align 16
block.62:
    movq %rcx, %rdi
    callq print_int
    jmp block.60

	.align 16
block.63:
    movq %rdi, %rcx
    addq %rdx, %rcx
    movq %rdx, %rdi
    movq %rcx, %rdx
    subq $1, %rsi
    cmpq $0, %rsi
    jg block.61
    jmp block.62

	.align 16
block.64:
    movq %rcx, %rdi
    callq print_int
    jmp block.60

	.align 16
block.65:
    movq %rdi, %rcx
    addq %rdx, %rcx
    movq %rdx, %rdi
    movq %rcx, %rdx
    subq $1, %rsi
    cmpq $0, %rsi
    jg block.63
    jmp block.64

	.align 16
block.66:
    movq %rcx, %rdi
    callq print_int
    jmp block.60

	.align 16
start:
    callq read_int
    movq %rax, %rsi
    movq $2, %rdi
    movq $3, %rdx
    movq %rdx, %rcx
    cmpq $0, %rsi
    jg block.65
    jmp block.66

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    jmp start


