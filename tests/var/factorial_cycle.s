	.align 16
conclusion:
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.197:
    addq %rdx, %rbx
    subq $1, %rcx
    jmp block.196

	.align 16
block.196:
    cmpq $0, %rcx
    jg block.197
    subq $1, %r12
    jmp block.195

	.align 16
block.199:
    movq %rbx, %rdx
    movq %r12, %rcx
    movq $0, %rbx
    jmp block.196

	.align 16
block.195:
    cmpq $0, %r12
    jg block.199
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
start:
    callq read_int
    movq %rax, %r12
    movq $1, %rbx
    jmp block.195

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    movq %rsp, %rbp
    jmp start


