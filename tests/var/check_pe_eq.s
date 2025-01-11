	.align 16
conclusion:
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.163:
    movq $0, %rax
    jmp conclusion

	.align 16
block.164:
    movq $1, %rdi
    callq print_int
    jmp block.163

	.align 16
block.166:
    cmpq $-6, %rbx
    jg block.164
    movq $0, %rdi
    callq print_int
    jmp block.163

	.align 16
block.167:
    movq $1, %rdi
    callq print_int
    jmp block.166

	.align 16
block.169:
    cmpq $10, %rbx
    jle block.167
    movq $0, %rdi
    callq print_int
    jmp block.166

	.align 16
block.170:
    movq $1, %rdi
    callq print_int
    jmp block.169

	.align 16
start:
    movq $10, %rbx
    movq $1, %rax
    cmpq %rbx, %rax
    je block.170
    movq $0, %rdi
    callq print_int
    jmp block.169

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    movq %rsp, %rbp
    subq $8, %rsp
    jmp start


