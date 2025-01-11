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
    movq %rdi, %rdx
    addq %rsi, %rdx
    movq %rsi, %rdi
    movq %rdx, %rsi
    subq $1, %rcx
    jmp block.37

	.align 16
block.40:
    movq %rdi, %rdx
    addq %rsi, %rdx
    movq %rsi, %rdi
    movq %rdx, %rsi
    subq $1, %rcx
    cmpq $0, %rcx
    jg block.38
    movq %rdx, %rdi
    callq print_int
    jmp block.37

	.align 16
block.42:
    movq %rdi, %rdx
    addq %rsi, %rdx
    movq %rsi, %rdi
    movq %rdx, %rsi
    subq $1, %rcx
    cmpq $0, %rcx
    jg block.40
    movq %rdx, %rdi
    callq print_int
    jmp block.37

	.align 16
start:
    callq read_int
    movq %rax, %rcx
    movq $2, %rdi
    movq $3, %rsi
    movq %rsi, %rdx
    cmpq $0, %rcx
    jg block.42
    movq %rdx, %rdi
    callq print_int
    jmp block.37

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    jmp start


