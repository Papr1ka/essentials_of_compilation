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
    subq %r12, %rbx
    jmp block.181

	.align 16
block.184:
    cmpq %r12, %rbx
    jg block.182
    subq %rbx, %r12
    jmp block.181

	.align 16
block.181:
    cmpq %r12, %rbx
    jne block.184
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
start:
    movq $2184, %rbx
    movq $140, %r12
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


