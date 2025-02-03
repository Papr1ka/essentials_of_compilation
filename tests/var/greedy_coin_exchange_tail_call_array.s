	.align 16
block.1184:
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
    movq -16(%rbp), %rax
    movq %rax, 24(%r11)
    movq %rcx, -8(%r15)
    leaq exchange(%rip), %r12
    movq %rbx, %rdi
    movq -8(%r15), %rsi
    callq *%r12
    leaq print_array(%rip), %r13
    movq -8(%r15), %rdi
    callq *%r13
    movq $0, %rax
    jmp main_conclusion

	.align 16
main_start:
    callq read_int
    movq %rax, %rbx
    movq $0, %r14
    movq $0, -8(%rbp)
    movq $0, -16(%rbp)
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.1184
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.1184

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
    addq $8, %r15
    movq $0, 0(%r15)
    jmp main_start

	.align 16
main_conclusion:
    subq $8, %r15
    addq $16, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.1187:
    movq %r12, %rdi
    callq print_int
    addq $1, %rbx
    jmp block.1186

	.align 16
block.1188:
    movq %r13, %r11
    movq %rbx, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %r12
    jmp block.1187

	.align 16
block.1189:
    movq $255, %rdi
    callq exit
    jmp block.1187

	.align 16
block.1190:
    movq %r13, %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %rbx
    jl block.1188
    jmp block.1189

	.align 16
block.1191:
    cmpq $0, %rbx
    jge block.1190
    jmp block.1189

	.align 16
block.1186:
    movq %r13, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %rbx
    jl block.1191
    jmp print_array_conclusion

	.align 16
print_array_start:
    movq %rdi, %r13
    movq $0, %rbx
    jmp block.1186

	.align 16
print_array:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    movq %rsp, %rbp
    subq $8, %rsp
    addq $0, %r15
    jmp print_array_start

	.align 16
print_array_conclusion:
    subq $0, %r15
    addq $8, %rsp
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.1192:
    leaq exchange(%rip), %r12
    subq $5, %rbx
    movq %rbx, %rdi
    movq %r13, %rsi
    movq %r12, %rax
    subq $0, %r15
    addq $0, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    jmp *%rax

	.align 16
block.1201:
    leaq exchange(%rip), %r14
    subq $2, %rbx
    movq %rbx, %rdi
    movq %r13, %rsi
    movq %r14, %rax
    subq $0, %r15
    addq $0, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    jmp *%rax

	.align 16
block.1210:
    leaq exchange(%rip), %r14
    subq $1, %rbx
    movq %rbx, %rdi
    movq %r13, %rsi
    movq %r14, %rax
    subq $0, %r15
    addq $0, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    jmp *%rax

	.align 16
block.1198:
    movq $255, %rdi
    callq exit
    jmp block.1192

	.align 16
block.1193:
    movq $1, %rcx
    addq %r14, %rcx
    movq %r13, %r11
    movq $2, %rdx
    imulq $8, %rdx
    addq %rdx, %r11
    movq %rcx, 8(%r11)
    jmp block.1192

	.align 16
block.1202:
    movq $1, %rcx
    addq %r12, %rcx
    movq %r13, %r11
    movq $1, %rdx
    imulq $8, %rdx
    addq %rdx, %r11
    movq %rcx, 8(%r11)
    jmp block.1201

	.align 16
block.1207:
    movq $255, %rdi
    callq exit
    jmp block.1201

	.align 16
block.1216:
    movq $255, %rdi
    callq exit
    jmp block.1210

	.align 16
block.1211:
    movq $1, %rcx
    addq %r12, %rcx
    movq %r13, %r11
    movq $0, %rdx
    imulq $8, %rdx
    addq %rdx, %r11
    movq %rcx, 8(%r11)
    jmp block.1210

	.align 16
block.1195:
    movq $255, %rdi
    callq exit
    jmp block.1193

	.align 16
block.1194:
    movq %r13, %r11
    movq $2, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %r14
    jmp block.1193

	.align 16
block.1203:
    movq %r13, %r11
    movq $1, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %r12
    jmp block.1202

	.align 16
block.1204:
    movq $255, %rdi
    callq exit
    jmp block.1202

	.align 16
block.1213:
    movq $255, %rdi
    callq exit
    jmp block.1211

	.align 16
block.1212:
    movq %r13, %r11
    movq $0, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %r12
    jmp block.1211

	.align 16
block.1196:
    movq %r13, %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    movq $2, %rax
    cmpq %rcx, %rax
    jl block.1194
    jmp block.1195

	.align 16
block.1205:
    movq %r13, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    movq $1, %rax
    cmpq %rdx, %rax
    jl block.1203
    jmp block.1204

	.align 16
block.1214:
    movq %r13, %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    movq $0, %rax
    cmpq %rcx, %rax
    jl block.1212
    jmp block.1213

	.align 16
block.1197:
    movq $2, %rax
    cmpq $0, %rax
    jge block.1196
    jmp block.1195

	.align 16
block.1206:
    movq $1, %rax
    cmpq $0, %rax
    jge block.1205
    jmp block.1204

	.align 16
block.1215:
    movq $0, %rax
    cmpq $0, %rax
    jge block.1214
    jmp block.1213

	.align 16
block.1199:
    movq %r13, %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    movq $2, %rax
    cmpq %rcx, %rax
    jl block.1197
    jmp block.1198

	.align 16
block.1208:
    movq %r13, %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    movq $1, %rax
    cmpq %rcx, %rax
    jl block.1206
    jmp block.1207

	.align 16
block.1217:
    movq %r13, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    movq $0, %rax
    cmpq %rdx, %rax
    jl block.1215
    jmp block.1216

	.align 16
block.1200:
    movq $2, %rax
    cmpq $0, %rax
    jge block.1199
    jmp block.1198

	.align 16
block.1209:
    movq $1, %rax
    cmpq $0, %rax
    jge block.1208
    jmp block.1207

	.align 16
block.1218:
    movq $0, %rax
    cmpq $0, %rax
    jge block.1217
    jmp block.1216

	.align 16
exchange_start:
    movq %rdi, %rbx
    movq %rsi, %r13
    cmpq $5, %rbx
    jge block.1200
    cmpq $2, %rbx
    jge block.1209
    cmpq $1, %rbx
    jge block.1218
    jmp exchange_conclusion

	.align 16
exchange:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    movq %rsp, %rbp
    subq $0, %rsp
    addq $0, %r15
    jmp exchange_start

	.align 16
exchange_conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 


