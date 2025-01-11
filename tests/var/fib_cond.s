	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
block.37:
    movq $0, %rax
    jmp conclusion

	.align 16
block.38:
    movq %rcx, %rsi
    addq %rdi, %rsi
    movq %rdi, %rcx
    movq %rsi, %rdi
    subq $1, %rdx
    jmp block.37

	.align 16
block.40:
    movq %rcx, %rsi
    addq %rdi, %rsi
    movq %rdi, %rcx
    movq %rsi, %rdi
    subq $1, %rdx
    cmpq $0, %rdx
    jg block.38
    movq %rsi, %rdi
    callq print_int
    jmp block.37

	.align 16
block.42:
    movq %rcx, %rsi
    addq %rdi, %rsi
    movq %rdi, %rcx
    movq %rsi, %rdi
    subq $1, %rdx
    cmpq $0, %rdx
    jg block.40
    movq %rsi, %rdi
    callq print_int
    jmp block.37

	.align 16
start:
    callq read_int
    movq %rax, %rdx
    movq $2, %rcx
    movq $3, %rdi
    movq %rdi, %rsi
    cmpq $0, %rdx
    jg block.42
    movq %rsi, %rdi
    callq print_int
    jmp block.37

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    jmp start


