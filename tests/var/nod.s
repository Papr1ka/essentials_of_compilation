	.align 16
conclusion:
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.56:
    movq $0, %rax
    jmp conclusion

	.align 16
block.57:
    movq %rbx, %rdi
    callq print_int
    jmp block.56

	.align 16
block.58:
    movq %rbx, %rdi
    callq print_int
    jmp block.56

	.align 16
block.60:
    movq %rbx, %rdi
    callq print_int
    jmp block.56

	.align 16
block.59:
    movq %rbx, %rdi
    callq print_int
    jmp block.56

	.align 16
block.61:
    subq %rcx, %rbx
    jmp block.60

	.align 16
block.64:
    cmpq %rcx, %rbx
    je block.59
    cmpq %rcx, %rbx
    jg block.61
    subq %rbx, %rcx
    jmp block.60

	.align 16
block.65:
    subq %rcx, %rbx
    jmp block.64

	.align 16
block.68:
    cmpq %rcx, %rbx
    je block.58
    cmpq %rcx, %rbx
    jg block.65
    subq %rbx, %rcx
    jmp block.64

	.align 16
block.69:
    subq %rcx, %rbx
    jmp block.68

	.align 16
start:
    callq read_int
    movq %rax, %rbx
    callq read_int
    movq %rax, %rcx
    cmpq %rcx, %rbx
    je block.57
    cmpq %rcx, %rbx
    jg block.69
    subq %rbx, %rcx
    jmp block.68

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    movq %rsp, %rbp
    subq $8, %rsp
    jmp start


