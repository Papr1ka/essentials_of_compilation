	.align 16
block.1285:
    movq free_ptr(%rip), %r11
    addq $56, free_ptr(%rip)
    movq $4611686018427387929, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r13, 8(%r11)
    movq %rcx, %r11
    movq %r12, 16(%r11)
    movq %rcx, %r11
    movq -8(%rbp), %rax
    movq %rax, 24(%r11)
    movq %rcx, %r11
    movq %rbx, 32(%r11)
    movq %rcx, %r11
    movq -16(%rbp), %rax
    movq %rax, 40(%r11)
    movq %rcx, %r11
    movq -24(%rbp), %rax
    movq %rax, 48(%r11)
    leaq getMinDiff(%rip), %rax
    movq %rax, -32(%rbp)
    movq %rcx, %rdi
    movq %r14, %rsi
    callq *-32(%rbp)
    movq %rax, %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
main_start:
    movq $6, %r14
    movq $12, %r13
    movq $6, %r12
    movq $4, -8(%rbp)
    movq $15, %rbx
    movq $17, -16(%rbp)
    movq $10, -24(%rbp)
    movq free_ptr(%rip), %rcx
    addq $56, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.1285
    movq %r15, %rdi
    movq $56, %rsi
    callq collect
    jmp block.1285

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    movq %rsp, %rbp
    subq $32, %rsp
    movq $65536, %rdi
    movq $16, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    addq $0, %r15
    jmp main_start

	.align 16
main_conclusion:
    subq $0, %r15
    addq $32, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.1288:
    addq $1, %rbx
    jmp block.1287

	.align 16
block.1289:
    movq %r12, %rsi
    subq -8(%rbp), %rsi
    movq -16(%rbp), %rdi
    callq *-24(%rbp)
    movq %rax, %rsi
    leaq min(%rip), %r13
    subq -32(%rbp), %rsi
    movq -40(%rbp), %rdi
    callq *%r13
    movq %rax, -40(%rbp)
    jmp block.1288

	.align 16
block.1291:
    movq $255, %rdi
    callq exit
    jmp block.1289

	.align 16
block.1290:
    movq -48(%rbp), %rcx
    subq $1, %rcx
    movq -8(%r15), %r11
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %r12
    jmp block.1289

	.align 16
block.1292:
    movq -48(%rbp), %rcx
    subq $1, %rcx
    movq -8(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rsi
    andq %rsi, %rdx
    sarq $2, %rdx
    cmpq %rdx, %rcx
    jl block.1290
    jmp block.1291

	.align 16
block.1293:
    movq -56(%rbp), %rax
    movq %rax, -16(%rbp)
    movq -16(%rbp), %rax
    addq -8(%rbp), %rax
    movq %rax, -16(%rbp)
    movq -48(%rbp), %rcx
    subq $1, %rcx
    cmpq $0, %rcx
    jge block.1292
    jmp block.1291

	.align 16
block.1295:
    movq $255, %rdi
    callq exit
    jmp block.1293

	.align 16
block.1294:
    movq %rbx, %rcx
    subq $1, %rcx
    movq -8(%r15), %r11
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -56(%rbp)
    jmp block.1293

	.align 16
block.1296:
    movq %rbx, %rcx
    subq $1, %rcx
    movq -8(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rsi
    andq %rsi, %rdx
    sarq $2, %rdx
    cmpq %rdx, %rcx
    jl block.1294
    jmp block.1295

	.align 16
block.1297:
    movq -64(%rbp), %rsi
    subq -8(%rbp), %rsi
    movq -16(%rbp), %rdi
    callq *-72(%rbp)
    movq %rax, -32(%rbp)
    leaq max(%rip), %rax
    movq %rax, -24(%rbp)
    movq %rbx, %rcx
    subq $1, %rcx
    cmpq $0, %rcx
    jge block.1296
    jmp block.1295

	.align 16
block.1298:
    movq -8(%r15), %r11
    movq %rbx, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -64(%rbp)
    jmp block.1297

	.align 16
block.1299:
    movq $255, %rdi
    callq exit
    jmp block.1297

	.align 16
block.1300:
    movq -8(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %rbx
    jl block.1298
    jmp block.1299

	.align 16
block.1301:
    movq %r14, -16(%rbp)
    movq -16(%rbp), %rax
    addq -8(%rbp), %rax
    movq %rax, -16(%rbp)
    cmpq $0, %rbx
    jge block.1300
    jmp block.1299

	.align 16
block.1302:
    movq -8(%r15), %r11
    movq $0, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %r14
    jmp block.1301

	.align 16
block.1303:
    movq $255, %rdi
    callq exit
    jmp block.1301

	.align 16
block.1304:
    movq -8(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    movq $0, %rax
    cmpq %rdx, %rax
    jl block.1302
    jmp block.1303

	.align 16
block.1305:
    leaq min(%rip), %rax
    movq %rax, -72(%rbp)
    movq $0, %rax
    cmpq $0, %rax
    jge block.1304
    jmp block.1303

	.align 16
block.1306:
    movq -80(%rbp), %rcx
    subq -8(%rbp), %rcx
    cmpq $0, %rcx
    jge block.1305
    jmp block.1288

	.align 16
block.1307:
    movq -8(%r15), %r11
    movq %rbx, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -80(%rbp)
    jmp block.1306

	.align 16
block.1308:
    movq $255, %rdi
    callq exit
    jmp block.1306

	.align 16
block.1309:
    movq -8(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %rbx
    jl block.1307
    jmp block.1308

	.align 16
block.1310:
    cmpq $0, %rbx
    jge block.1309
    jmp block.1308

	.align 16
block.1287:
    movq -8(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %rbx
    jl block.1310
    movq -40(%rbp), %rax
    jmp getMinDiff_conclusion

	.align 16
block.1312:
    subq %rbx, -40(%rbp)
    movq $1, %rbx
    jmp block.1287

	.align 16
block.1314:
    movq $255, %rdi
    callq exit
    jmp block.1312

	.align 16
block.1313:
    movq -8(%r15), %r11
    movq $0, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rbx
    jmp block.1312

	.align 16
block.1315:
    movq -8(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    movq $0, %rax
    cmpq %rcx, %rax
    jl block.1313
    jmp block.1314

	.align 16
block.1316:
    movq $0, %rax
    cmpq $0, %rax
    jge block.1315
    jmp block.1314

	.align 16
block.1318:
    movq $255, %rdi
    callq exit
    jmp block.1316

	.align 16
block.1317:
    movq -48(%rbp), %rcx
    subq $1, %rcx
    movq -8(%r15), %r11
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -40(%rbp)
    jmp block.1316

	.align 16
block.1319:
    movq -48(%rbp), %rcx
    subq $1, %rcx
    movq -8(%r15), %r11
    movq 0(%r11), %rsi
    movq $4611686018427387900, %rdx
    andq %rdx, %rsi
    sarq $2, %rsi
    cmpq %rsi, %rcx
    jl block.1317
    jmp block.1318

	.align 16
getMinDiff_start:
    movq %rdi, -8(%r15)
    movq %rsi, -8(%rbp)
    movq -8(%r15), %r11
    movq 0(%r11), %rax
    movq %rax, -48(%rbp)
    movq $4611686018427387900, %rdx
    andq %rdx, -48(%rbp)
    sarq $2, -48(%rbp)
    leaq bubble_sort_inplace(%rip), %rcx
    movq -8(%r15), %rdi
    callq *%rcx
    movq -48(%rbp), %rcx
    subq $1, %rcx
    cmpq $0, %rcx
    jge block.1319
    jmp block.1318

	.align 16
getMinDiff:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    movq %rsp, %rbp
    subq $80, %rsp
    addq $8, %r15
    movq $0, 0(%r15)
    jmp getMinDiff_start

	.align 16
getMinDiff_conclusion:
    subq $8, %r15
    addq $80, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.1321:
    movq %rsi, %rax
    jmp max_conclusion

	.align 16
block.1322:
    movq %rdi, %rsi
    jmp block.1321

	.align 16
max_start:
    cmpq %rsi, %rdi
    jg block.1322
    jmp block.1321

	.align 16
max:
    pushq %rbp
    movq %rsp, %rbp
    subq $0, %rsp
    addq $0, %r15
    jmp max_start

	.align 16
max_conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %rbp
    retq 

	.align 16
block.1325:
    movq %rsi, %rax
    jmp min_conclusion

	.align 16
block.1326:
    movq %rdi, %rsi
    jmp block.1325

	.align 16
min_start:
    cmpq %rsi, %rdi
    jl block.1326
    jmp block.1325

	.align 16
min:
    pushq %rbp
    movq %rsp, %rbp
    subq $0, %rsp
    addq $0, %r15
    jmp min_start

	.align 16
min_conclusion:
    subq $0, %r15
    addq $0, %rsp
    popq %rbp
    retq 

	.align 16
block.1330:
    addq $1, %r12
    jmp block.1329

	.align 16
block.1332:
    movq $255, %rdi
    callq exit
    jmp block.1330

	.align 16
block.1331:
    movq %r13, %r11
    movq %r12, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq %r14, 8(%r11)
    jmp block.1330

	.align 16
block.1333:
    movq %r13, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %r12
    jl block.1331
    jmp block.1332

	.align 16
block.1334:
    cmpq $0, %r12
    jge block.1333
    jmp block.1332

	.align 16
block.1335:
    movq %r13, %r11
    movq -8(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq %rbx, 8(%r11)
    jmp block.1334

	.align 16
block.1336:
    movq $255, %rdi
    callq exit
    jmp block.1334

	.align 16
block.1337:
    movq %r13, %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, -8(%rbp)
    jl block.1335
    jmp block.1336

	.align 16
block.1338:
    cmpq $0, -8(%rbp)
    jge block.1337
    jmp block.1336

	.align 16
block.1339:
    cmpq %r14, %rbx
    jl block.1338
    jmp block.1330

	.align 16
block.1341:
    movq $255, %rdi
    callq exit
    jmp block.1339

	.align 16
block.1340:
    movq %r13, %r11
    movq %r12, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rbx
    jmp block.1339

	.align 16
block.1342:
    movq %r13, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, %r12
    jl block.1340
    jmp block.1341

	.align 16
block.1343:
    cmpq $0, %r12
    jge block.1342
    jmp block.1341

	.align 16
block.1344:
    movq %r13, %r11
    movq -8(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %r14
    jmp block.1343

	.align 16
block.1345:
    movq $255, %rdi
    callq exit
    jmp block.1343

	.align 16
block.1346:
    movq %r13, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, -8(%rbp)
    jl block.1344
    jmp block.1345

	.align 16
block.1347:
    cmpq $0, -8(%rbp)
    jge block.1346
    jmp block.1345

	.align 16
block.1329:
    movq %r13, %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, %r12
    jl block.1347
    addq $1, -8(%rbp)
    jmp block.1328

	.align 16
block.1349:
    movq $1, %r12
    addq -8(%rbp), %r12
    jmp block.1329

	.align 16
block.1328:
    movq %r13, %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, -8(%rbp)
    jl block.1349
    jmp bubble_sort_inplace_conclusion

	.align 16
bubble_sort_inplace_start:
    movq %rdi, %r13
    movq $0, -8(%rbp)
    jmp block.1328

	.align 16
bubble_sort_inplace:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    movq %rsp, %rbp
    subq $16, %rsp
    addq $0, %r15
    jmp bubble_sort_inplace_start

	.align 16
bubble_sort_inplace_conclusion:
    subq $0, %r15
    addq $16, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 


