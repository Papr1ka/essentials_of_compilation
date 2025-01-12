	.align 16
conclusion:
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.179:
    addq %r12, %rbx
    subq $1, %r12
    jmp block.178

	.align 16
block.178:
    cmpq $0, %r12
    jg block.179
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
start:
    movq $0, %rbx
    callq read_int
    movq %rax, %r12
    jmp block.178

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    movq %rsp, %rbp
    jmp start


