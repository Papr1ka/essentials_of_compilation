	.align 16
conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.182:
    subq %rbx, %r12
    jmp block.181

	.align 16
block.184:
    cmpq %rbx, %r12
    jg block.182
    subq %r12, %rbx
    jmp block.181

	.align 16
block.181:
    cmpq %rbx, %r12
    jne block.184
    movq %r12, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
start:
    movq $2184, %r12
    movq $140, %rbx
    jmp block.181

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    movq %rsp, %rbp
    subq $0, %rsp
    movq $65536, %rdi
    movq $16, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    addq $0, %r15
    jmp start


