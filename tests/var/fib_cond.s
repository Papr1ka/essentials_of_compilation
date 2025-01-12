	.align 16
conclusion:
    addq $8, %rsp
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.37:
    movq $0, %rax
    jmp conclusion

	.align 16
block.38:
    movq %r13, %rcx
    addq %rbx, %rcx
    movq %rbx, %r13
    movq %rcx, %rbx
    subq $1, %r12
    jmp block.37

	.align 16
block.40:
    movq %r13, %rcx
    addq %rbx, %rcx
    movq %rbx, %r13
    movq %rcx, %rbx
    subq $1, %r12
    cmpq $0, %r12
    jg block.38
    movq %rcx, %rdi
    callq print_int
    jmp block.37

	.align 16
block.42:
    movq %r13, %rcx
    addq %rbx, %rcx
    movq %rbx, %r13
    movq %rcx, %rbx
    subq $1, %r12
    cmpq $0, %r12
    jg block.40
    movq %rcx, %rdi
    callq print_int
    jmp block.37

	.align 16
start:
    callq read_int
    movq %rax, %r12
    movq $2, %r13
    movq $3, %rbx
    movq %rbx, %rcx
    cmpq $0, %r12
    jg block.42
    movq %rcx, %rdi
    callq print_int
    jmp block.37

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    movq %rsp, %rbp
    subq $8, %rsp
    jmp start


