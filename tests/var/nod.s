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
    subq %rcx, %rbx
    jmp block.80

	.align 16
block.82:
    subq %rbx, %rcx
    jmp block.80

	.align 16
block.83:
    movq %rbx, %rdi
    callq print_int
    jmp block.79

	.align 16
block.84:
    cmpq %rcx, %rbx
    jg block.81
    jmp block.82

	.align 16
block.85:
    cmpq %rcx, %rbx
    je block.83
    jmp block.84

	.align 16
block.86:
    subq %rcx, %rbx
    jmp block.85

	.align 16
block.87:
    subq %rbx, %rcx
    jmp block.85

	.align 16
block.88:
    movq %rbx, %rdi
    callq print_int
    jmp block.79

	.align 16
block.89:
    cmpq %rcx, %rbx
    jg block.86
    jmp block.87

	.align 16
block.90:
    cmpq %rcx, %rbx
    je block.88
    jmp block.89

	.align 16
block.91:
    subq %rcx, %rbx
    jmp block.90

	.align 16
block.92:
    subq %rbx, %rcx
    jmp block.90

	.align 16
block.93:
    movq %rbx, %rdi
    callq print_int
    jmp block.79

	.align 16
block.94:
    cmpq %rcx, %rbx
    jg block.91
    jmp block.92

	.align 16
start:
    callq read_int
    movq %rax, %rbx
    callq read_int
    movq %rax, %rcx
    cmpq %rcx, %rbx
    je block.93
    jmp block.94

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    movq %rsp, %rbp
    subq $8, %rsp
    jmp start


