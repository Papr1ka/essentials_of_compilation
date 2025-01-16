	.align 16
conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
start:
    movq $1, %rcx
    movq $1, %rbx
    movq %rcx, %r12
    addq %rbx, %r12
    movq %r12, %rdi
    callq print_int
    movq %rbx, %rcx
    movq %r12, %rbx
    movq %rcx, %r12
    addq %rbx, %r12
    movq %r12, %rdi
    callq print_int
    movq %rbx, %rcx
    movq %r12, %rbx
    movq %rcx, %r12
    addq %rbx, %r12
    movq %r12, %rdi
    callq print_int
    movq %rbx, %rcx
    movq %r12, %rbx
    movq %rcx, %r12
    addq %rbx, %r12
    movq %r12, %rdi
    callq print_int
    movq %rbx, %rcx
    movq %r12, %rbx
    movq %rcx, %r12
    addq %rbx, %r12
    movq %r12, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

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


