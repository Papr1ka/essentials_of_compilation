	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
start:
    callq read_int
    movq %rax, %rdx
    movq $2, %rcx
    addq %rdx, %rcx
    movq %rcx, %rdi
    callq print_int
    callq read_int
    movq %rax, %rdx
    movq $3, %rcx
    subq %rdx, %rcx
    movq %rcx, %rdi
    callq print_int
    callq read_int
    movq %rax, %rdx
    movq $3, %rcx
    addq %rdx, %rcx
    movq %rcx, %rdi
    callq print_int
    callq read_int
    movq %rax, %rdx
    subq $6, %rdx
    movq $3, %rcx
    addq %rdx, %rcx
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    jmp start


