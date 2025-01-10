	.align 16
conclusion:
    popq %rbp
    retq 

	.align 16
block.165:
    movq $0, %rax
    jmp conclusion

	.align 16
block.166:
    movq $14, %rdi
    callq print_int
    jmp block.165

	.align 16
block.167:
    movq $2, %rdi
    callq print_int
    jmp block.165

	.align 16
block.168:
    movq $1, %rdi
    callq print_int
    jmp block.165

	.align 16
block.169:
    movq $6, %rcx
    subq $118, %rcx
    negq %rcx
    subq $200, %rcx
    movq $5, %rax
    cmpq %rcx, %rax
    jge block.168
    jmp block.167

	.align 16
block.170:
    movq $5, %rax
    cmpq $10, %rax
    je block.167
    jmp block.169

	.align 16
block.171:
    movq $5, %rax
    cmpq $6, %rax
    jg block.166
    jmp block.170

	.align 16
block.172:
    movq $10, %rcx
    addq $100, %rcx
    movq $110, %rax
    cmpq %rcx, %rax
    je block.166
    jmp block.170

	.align 16
block.173:
    movq $6, %rax
    cmpq $110, %rax
    jl block.171
    jmp block.172

	.align 16
block.174:
    movq %rcx, %rdi
    callq print_int
    jmp block.173

	.align 16
block.175:
    movq $1, %rcx
    jmp block.174

	.align 16
block.176:
    movq $3, %rcx
    jmp block.174

	.align 16
block.177:
    movq $2, %rax
    cmpq $2, %rax
    je block.175
    jmp block.176

	.align 16
start:
    movq $5, %rax
    cmpq $10, %rax
    jg block.177
    jmp block.173

	.globl main
	.align 16
main:
    pushq %rbp
    movq %rsp, %rbp
    jmp start


