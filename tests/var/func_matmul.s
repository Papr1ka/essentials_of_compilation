	.align 16
block.968:
    movq free_ptr(%rip), %r11
    addq $32, free_ptr(%rip)
    movq $4611686018427387919, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq -8(%r15), %rax
    movq %rax, 8(%r11)
    movq %rcx, %r11
    movq -16(%r15), %rax
    movq %rax, 16(%r11)
    movq %rcx, %r11
    movq -24(%r15), %rax
    movq %rax, 24(%r11)
    movq %rcx, -8(%r15)
    leaq matmul(%rip), %rbx
    movq -32(%r15), %rdi
    movq -40(%r15), %rsi
    movq -8(%r15), %rdx
    callq *%rbx
    leaq print_matrix(%rip), %r12
    movq -8(%r15), %rdi
    callq *%r12
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.970:
    movq free_ptr(%rip), %r11
    addq $32, free_ptr(%rip)
    movq $4611686018427387917, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r13, 8(%r11)
    movq %rcx, %r11
    movq %r14, 16(%r11)
    movq %rcx, %r11
    movq -8(%rbp), %rax
    movq %rax, 24(%r11)
    movq %rcx, -24(%r15)
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.968
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.968

	.align 16
block.972:
    movq free_ptr(%rip), %r11
    addq $32, free_ptr(%rip)
    movq $4611686018427387917, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r14, 8(%r11)
    movq %rcx, %r11
    movq -8(%rbp), %rax
    movq %rax, 16(%r11)
    movq %rcx, %r11
    movq %r13, 24(%r11)
    movq %rcx, -16(%r15)
    movq $0, %r13
    movq $0, %r14
    movq $0, -8(%rbp)
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.970
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.970

	.align 16
block.974:
    movq free_ptr(%rip), %r11
    addq $32, free_ptr(%rip)
    movq $4611686018427387917, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r13, 8(%r11)
    movq %rcx, %r11
    movq %r14, 16(%r11)
    movq %rcx, %r11
    movq -16(%rbp), %rax
    movq %rax, 24(%r11)
    movq %rcx, -8(%r15)
    movq $0, %r14
    movq $0, -8(%rbp)
    movq $0, %r13
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.972
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.972

	.align 16
block.976:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $4611686018427387915, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq -8(%r15), %rax
    movq %rax, 8(%r11)
    movq %rcx, %r11
    movq -24(%r15), %rax
    movq %rax, 16(%r11)
    movq %rcx, -40(%r15)
    movq $0, %r13
    movq $0, %r14
    movq $0, -16(%rbp)
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.974
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.974

	.align 16
block.978:
    movq free_ptr(%rip), %r11
    addq $32, free_ptr(%rip)
    movq $4611686018427387917, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq -8(%rbp), %rax
    movq %rax, 8(%r11)
    movq %rcx, %r11
    movq %r14, 16(%r11)
    movq %rcx, %r11
    movq %r13, 24(%r11)
    movq %rcx, -24(%r15)
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.976
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.976

	.align 16
block.980:
    movq free_ptr(%rip), %r11
    addq $32, free_ptr(%rip)
    movq $4611686018427387917, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r14, 8(%r11)
    movq %rcx, %r11
    movq %r13, 16(%r11)
    movq %rcx, %r11
    movq -16(%rbp), %rax
    movq %rax, 24(%r11)
    movq %rcx, -8(%r15)
    movq $7, -8(%rbp)
    movq $8, %r14
    movq $12, %r13
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.978
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.978

	.align 16
block.982:
    movq free_ptr(%rip), %r11
    addq $32, free_ptr(%rip)
    movq $4611686018427387919, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq -32(%r15), %rax
    movq %rax, 8(%r11)
    movq %rcx, %r11
    movq -8(%r15), %rax
    movq %rax, 16(%r11)
    movq %rcx, %r11
    movq -24(%r15), %rax
    movq %rax, 24(%r11)
    movq %rcx, -32(%r15)
    movq $5, %r14
    movq $6, %r13
    movq $6, -16(%rbp)
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.980
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.980

	.align 16
block.984:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $4611686018427387913, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r14, 8(%r11)
    movq %rcx, %r11
    movq %r13, 16(%r11)
    movq %rcx, -24(%r15)
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.982
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.982

	.align 16
block.986:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $4611686018427387913, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r14, 8(%r11)
    movq %rcx, %r11
    movq %r13, 16(%r11)
    movq %rcx, -8(%r15)
    movq $9, %r14
    movq $11, %r13
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.984
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.984

	.align 16
block.988:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $4611686018427387913, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r14, 8(%r11)
    movq %rcx, %r11
    movq %r13, 16(%r11)
    movq %rcx, -32(%r15)
    movq $3, %r14
    movq $4, %r13
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.986
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.986

	.align 16
main_start:
    movq $1, %r14
    movq $2, %r13
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.988
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.988

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    movq %rsp, %rbp
    subq $16, %rsp
    movq $65536, %rdi
    movq $16, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    addq $40, %r15
    movq $0, 0(%r15)
    movq $0, 8(%r15)
    movq $0, 16(%r15)
    movq $0, 24(%r15)
    movq $0, 32(%r15)
    jmp main_start

	.align 16
main_conclusion:
    subq $40, %r15
    addq $16, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.992:
    movq %r14, %rdi
    callq print_int
    addq $1, %r12
    jmp block.991

	.align 16
block.998:
    movq $255, %rdi
    callq exit
    jmp block.992

	.align 16
block.993:
    movq -8(%r15), %r11
    movq %r12, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %r14
    jmp block.992

	.align 16
block.994:
    movq -16(%r15), %r11
    movq %rbx, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -8(%r15)
    jmp block.993

	.align 16
block.995:
    movq $255, %rdi
    callq exit
    jmp block.993

	.align 16
block.996:
    movq -16(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %rbx
    jl block.994
    jmp block.995

	.align 16
block.997:
    cmpq $0, %rbx
    jge block.996
    jmp block.995

	.align 16
block.999:
    movq -24(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %r12
    jl block.997
    jmp block.998

	.align 16
block.1001:
    movq $255, %rdi
    callq exit
    jmp block.999

	.align 16
block.1000:
    movq -16(%r15), %r11
    movq %rbx, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -24(%r15)
    jmp block.999

	.align 16
block.1002:
    movq -16(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %rbx
    jl block.1000
    jmp block.1001

	.align 16
block.1003:
    cmpq $0, %rbx
    jge block.1002
    jmp block.1001

	.align 16
block.1004:
    cmpq $0, %r12
    jge block.1003
    jmp block.998

	.align 16
block.991:
    cmpq -8(%rbp), %r12
    jl block.1004
    addq $1, %rbx
    jmp block.990

	.align 16
block.1006:
    movq $0, %r12
    jmp block.991

	.align 16
block.990:
    cmpq %r13, %rbx
    jl block.1006
    jmp print_matrix_conclusion

	.align 16
block.1007:
    movq %rbx, %r11
    movq 0(%r11), %rax
    movq %rax, -8(%rbp)
    movq $4611686018427387900, %rcx
    andq %rcx, -8(%rbp)
    sarq $2, -8(%rbp)
    movq $0, %rbx
    jmp block.990

	.align 16
block.1008:
    movq -16(%r15), %r11
    movq $0, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rbx
    jmp block.1007

	.align 16
block.1009:
    movq $255, %rdi
    callq exit
    jmp block.1007

	.align 16
block.1010:
    movq -16(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    movq $0, %rax
    cmpq %rdx, %rax
    jl block.1008
    jmp block.1009

	.align 16
print_matrix_start:
    movq %rdi, -16(%r15)
    movq -16(%r15), %r11
    movq 0(%r11), %r13
    movq $4611686018427387900, %rcx
    andq %rcx, %r13
    sarq $2, %r13
    movq $0, %rax
    cmpq $0, %rax
    jge block.1010
    jmp block.1009

	.align 16
print_matrix:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    movq %rsp, %rbp
    subq $16, %rsp
    addq $24, %r15
    movq $0, 0(%r15)
    movq $0, 8(%r15)
    movq $0, 16(%r15)
    jmp print_matrix_start

	.align 16
print_matrix_conclusion:
    subq $24, %r15
    addq $16, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.1014:
    movq -8(%rbp), %rcx
    imulq -16(%rbp), %rcx
    addq %rcx, %r12
    addq $1, %r14
    jmp block.1013

	.align 16
block.1015:
    movq %rbx, %r11
    movq -24(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -16(%rbp)
    jmp block.1014

	.align 16
block.1020:
    movq $255, %rdi
    callq exit
    jmp block.1014

	.align 16
block.1017:
    movq $255, %rdi
    callq exit
    jmp block.1015

	.align 16
block.1016:
    movq -8(%r15), %r11
    movq %r14, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rbx
    jmp block.1015

	.align 16
block.1018:
    movq -8(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %r14
    jl block.1016
    jmp block.1017

	.align 16
block.1019:
    cmpq $0, %r14
    jge block.1018
    jmp block.1017

	.align 16
block.1021:
    movq -16(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, -24(%rbp)
    jl block.1019
    jmp block.1020

	.align 16
block.1022:
    movq -8(%r15), %r11
    movq %r14, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -16(%r15)
    jmp block.1021

	.align 16
block.1023:
    movq $255, %rdi
    callq exit
    jmp block.1021

	.align 16
block.1024:
    movq -8(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %r14
    jl block.1022
    jmp block.1023

	.align 16
block.1025:
    cmpq $0, %r14
    jge block.1024
    jmp block.1023

	.align 16
block.1026:
    cmpq $0, -24(%rbp)
    jge block.1025
    jmp block.1020

	.align 16
block.1027:
    movq -24(%r15), %r11
    movq %r14, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -8(%rbp)
    jmp block.1026

	.align 16
block.1032:
    movq $255, %rdi
    callq exit
    jmp block.1026

	.align 16
block.1028:
    movq -32(%r15), %r11
    movq %r13, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -24(%r15)
    jmp block.1027

	.align 16
block.1029:
    movq $255, %rdi
    callq exit
    jmp block.1027

	.align 16
block.1030:
    movq -32(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %r13
    jl block.1028
    jmp block.1029

	.align 16
block.1031:
    cmpq $0, %r13
    jge block.1030
    jmp block.1029

	.align 16
block.1033:
    movq -40(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %r14
    jl block.1031
    jmp block.1032

	.align 16
block.1034:
    movq -32(%r15), %r11
    movq %r13, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -40(%r15)
    jmp block.1033

	.align 16
block.1035:
    movq $255, %rdi
    callq exit
    jmp block.1033

	.align 16
block.1036:
    movq -32(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %r13
    jl block.1034
    jmp block.1035

	.align 16
block.1037:
    cmpq $0, %r13
    jge block.1036
    jmp block.1035

	.align 16
block.1038:
    cmpq $0, %r14
    jge block.1037
    jmp block.1032

	.align 16
block.1039:
    addq $1, -24(%rbp)
    jmp block.1012

	.align 16
block.1040:
    movq -48(%r15), %r11
    movq -24(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq %r12, 8(%r11)
    jmp block.1039

	.align 16
block.1045:
    movq $255, %rdi
    callq exit
    jmp block.1039

	.align 16
block.1042:
    movq $255, %rdi
    callq exit
    jmp block.1040

	.align 16
block.1041:
    movq -56(%r15), %r11
    movq %r13, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -48(%r15)
    jmp block.1040

	.align 16
block.1043:
    movq -56(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %r13
    jl block.1041
    jmp block.1042

	.align 16
block.1044:
    cmpq $0, %r13
    jge block.1043
    jmp block.1042

	.align 16
block.1046:
    movq -64(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, -24(%rbp)
    jl block.1044
    jmp block.1045

	.align 16
block.1047:
    movq -56(%r15), %r11
    movq %r13, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -64(%r15)
    jmp block.1046

	.align 16
block.1048:
    movq $255, %rdi
    callq exit
    jmp block.1046

	.align 16
block.1049:
    movq -56(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %r13
    jl block.1047
    jmp block.1048

	.align 16
block.1050:
    cmpq $0, %r13
    jge block.1049
    jmp block.1048

	.align 16
block.1013:
    cmpq -32(%rbp), %r14
    jl block.1038
    cmpq $0, -24(%rbp)
    jge block.1050
    jmp block.1045

	.align 16
block.1052:
    movq $0, %r14
    movq $0, %r12
    jmp block.1013

	.align 16
block.1012:
    movq -24(%rbp), %rax
    cmpq -40(%rbp), %rax
    jl block.1052
    addq $1, %r13
    jmp block.1011

	.align 16
block.1054:
    movq $0, -24(%rbp)
    jmp block.1012

	.align 16
block.1011:
    cmpq -48(%rbp), %r13
    jl block.1054
    jmp matmul_conclusion

	.align 16
block.1055:
    movq %r12, %r11
    movq 0(%r11), %rax
    movq %rax, -40(%rbp)
    movq $4611686018427387900, %rcx
    andq %rcx, -40(%rbp)
    sarq $2, -40(%rbp)
    movq $0, %r13
    jmp block.1011

	.align 16
block.1057:
    movq $255, %rdi
    callq exit
    jmp block.1055

	.align 16
block.1056:
    movq -8(%r15), %r11
    movq $0, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %r12
    jmp block.1055

	.align 16
block.1058:
    movq -8(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    movq $0, %rax
    cmpq %rcx, %rax
    jl block.1056
    jmp block.1057

	.align 16
block.1059:
    movq %r13, %r11
    movq 0(%r11), %rax
    movq %rax, -32(%rbp)
    movq $4611686018427387900, %rcx
    andq %rcx, -32(%rbp)
    sarq $2, -32(%rbp)
    movq $0, %rax
    cmpq $0, %rax
    jge block.1058
    jmp block.1057

	.align 16
block.1061:
    movq $255, %rdi
    callq exit
    jmp block.1059

	.align 16
block.1060:
    movq -32(%r15), %r11
    movq $0, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %r13
    jmp block.1059

	.align 16
block.1062:
    movq -32(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    movq $0, %rax
    cmpq %rcx, %rax
    jl block.1060
    jmp block.1061

	.align 16
matmul_start:
    movq %rdi, -32(%r15)
    movq %rsi, -8(%r15)
    movq %rdx, -56(%r15)
    movq -32(%r15), %r11
    movq 0(%r11), %rax
    movq %rax, -48(%rbp)
    movq $4611686018427387900, %rcx
    andq %rcx, -48(%rbp)
    sarq $2, -48(%rbp)
    movq $0, %rax
    cmpq $0, %rax
    jge block.1062
    jmp block.1061

	.align 16
matmul:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    movq %rsp, %rbp
    subq $48, %rsp
    addq $64, %r15
    movq $0, 0(%r15)
    movq $0, 8(%r15)
    movq $0, 16(%r15)
    movq $0, 24(%r15)
    movq $0, 32(%r15)
    movq $0, 40(%r15)
    movq $0, 48(%r15)
    movq $0, 56(%r15)
    jmp matmul_start

	.align 16
matmul_conclusion:
    subq $64, %r15
    addq $48, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 


