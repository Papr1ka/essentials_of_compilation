	.align 16
conclusion:
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 

	.align 16
start:
    callq read_int
    movq %rax, %rdx
    addq $1, %rdx
    movq $1, %rcx
    addq %rdx, %rcx
    movq %rcx, %rdi
    callq print_int
    callq read_int
    movq %rax, %rcx
    addq $2, %rcx
    movq $5, %rdx
    subq %rcx, %rdx
    movq %rdx, %rdi
    callq print_int
    callq read_int
    movq %rax, %rcx
    movq $1, %rdx
    addq %rcx, %rdx
    movq $1, %rcx
    addq %rdx, %rcx
    addq $1, %rcx
    movq %rcx, %rdi
    callq print_int
    movq $5, %rbx
    subq $2, %rbx
    callq read_int
    movq %rax, %rcx
    subq $6, %rcx
    addq %rcx, %rbx
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    movq %rsp, %rbp
    subq $8, %rsp
    jmp start


