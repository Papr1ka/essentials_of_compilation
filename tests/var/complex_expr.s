	.align 16
conclusion:
    addq $8, %rsp
    popq %rbx
    popq %rbp
    retq 

	.align 16
start:
    callq read_int
    movq %rax, %rbx
    callq read_int
    movq %rax, %rcx
    addq $4, %rbx
    subq $2, %rbx
    addq $6, %rbx
    addq $4, %rcx
    subq $1, %rcx
    subq $2, %rcx
    subq $3, %rcx
    subq %rcx, %rbx
    movq $4, %rcx
    negq %rcx
    addq %rcx, %rbx
    addq $1, %rbx
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


