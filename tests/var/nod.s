	.align 16
conclusion:
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.79:
    movq $0, %rax
    jmp conclusion

	.align 16
block.80:
    movq %rbx, %rdi
    callq print_int
    jmp block.79

	.align 16
block.81:
    movq %rbx, %rdi
    callq print_int
    jmp block.79

	.align 16
block.82:
    movq %rbx, %rdi
    callq print_int
    jmp block.79

	.align 16
block.83:
    movq %rbx, %rdi
    callq print_int
    jmp block.79

	.align 16
block.84:
    subq %rcx, %rbx
    jmp block.83

	.align 16
block.85:
    subq %rbx, %rcx
    jmp block.83

	.align 16
block.86:
    cmpq %rcx, %rbx
    jg block.84
    jmp block.85

	.align 16
block.87:
    cmpq %rcx, %rbx
    je block.82
    jmp block.86

	.align 16
block.88:
    subq %rcx, %rbx
    jmp block.87

	.align 16
block.89:
    subq %rbx, %rcx
    jmp block.87

	.align 16
block.90:
    cmpq %rcx, %rbx
    jg block.88
    jmp block.89

	.align 16
block.91:
    cmpq %rcx, %rbx
    je block.81
    jmp block.90

	.align 16
block.92:
    subq %rcx, %rbx
    jmp block.91

	.align 16
block.93:
    subq %rbx, %rcx
    jmp block.91

	.align 16
block.94:
    cmpq %rcx, %rbx
    jg block.92
    jmp block.93

	.align 16
start:
    callq read_int
    movq %rax, %rbx
    callq read_int
    movq %rax, %rcx
    cmpq %rcx, %rbx
    je block.80
    jmp block.94

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    movq %rsp, %rbp
    subq $8, %rsp
    jmp start


