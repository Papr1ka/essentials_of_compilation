	.align 16
conclusion:
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.54:
    movq $0, %rax
    jmp conclusion

	.align 16
block.55:
    movq %rbx, %rdi
    callq print_int
    jmp block.54

	.align 16
block.56:
    movq %rcx, %rdi
    callq print_int
    jmp block.54

	.align 16
start:
    movq $2, %rbx
    callq read_int
    movq %rax, %rcx
    cmpq %rcx, %rbx
    je block.55
    jmp block.56

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    movq %rsp, %rbp
    subq $8, %rsp
    jmp start


