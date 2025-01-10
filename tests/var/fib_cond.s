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
    movq %rdi, %rdx
    addq %rsi, %rdx
    movq %rsi, %rdi
    movq %rdx, %rsi
    subq $1, %rcx
    jmp block.60

	.align 16
block.63:
    movq %rdi, %rdx
    addq %rsi, %rdx
    movq %rsi, %rdi
    movq %rdx, %rsi
    subq $1, %rcx
    cmpq $0, %rcx
    jg block.61
    movq %rdx, %rdi
    callq print_int
    jmp block.60

	.align 16
block.65:
    movq %rdi, %rdx
    addq %rsi, %rdx
    movq %rsi, %rdi
    movq %rdx, %rsi
    subq $1, %rcx
    cmpq $0, %rcx
    jg block.63
    movq %rdx, %rdi
    callq print_int
    jmp block.60

	.align 16
start:
    callq read_int
    movq %rax, %rcx
    movq $2, %rdi
    movq $3, %rsi
    movq %rsi, %rdx
    cmpq $0, %rcx
    jg block.65
    movq %rdx, %rdi
    callq print_int
    jmp block.60

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    jmp start


