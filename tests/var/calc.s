	.align 16
block.250:
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.251:
    movq %r12, %rdi
    jmp block.250

	.align 16
block.253:
    cmpq %rbx, %r12
    jg block.251
    movq %rbx, %rdi
    jmp block.250

	.align 16
block.254:
    movq %r12, %rdi
    callq print_int
    jmp block.253

	.align 16
main_start:
    callq read_int
    movq %rax, %rbx
    callq read_int
    movq %rax, %rcx
    movq %rbx, %r12
    addq %rcx, %r12
    subq %rcx, %rbx
    cmpq %rbx, %r12
    jg block.254
    movq %rbx, %rdi
    callq print_int
    jmp block.253

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
    jmp main_start

	.align 16
main_conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %r12
    popq %rbx
    popq %rbp
    retq 


