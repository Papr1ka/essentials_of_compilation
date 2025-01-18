	.align 16
conclusion:
    subq $112, %r15
    addq $64, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 

	.align 16
block.390:
    movq -8(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    movq %rdx, %rdi
    callq print_int
    movq %r13, %rdi
    callq print_int
    movq %r12, %rdi
    callq print_int
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp conclusion

	.align 16
block.391:
    movq -16(%r15), %r11
    movq $0, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -8(%r15)
    jmp block.390

	.align 16
block.392:
    movq $255, %rdi
    callq exit
    jmp block.390

	.align 16
block.393:
    movq -16(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    movq $0, %rax
    cmpq %rcx, %rax
    jl block.391
    jmp block.392

	.align 16
block.396:
    movq %r14, %rdi
    callq print_int
    addq $1, -8(%rbp)
    jmp block.395

	.align 16
block.402:
    movq $255, %rdi
    callq exit
    jmp block.396

	.align 16
block.397:
    movq -24(%r15), %r11
    movq -8(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %r14
    jmp block.396

	.align 16
block.399:
    movq $255, %rdi
    callq exit
    jmp block.397

	.align 16
block.398:
    movq -16(%r15), %r11
    movq -16(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -24(%r15)
    jmp block.397

	.align 16
block.400:
    movq -16(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, -16(%rbp)
    jl block.398
    jmp block.399

	.align 16
block.401:
    cmpq $0, -16(%rbp)
    jge block.400
    jmp block.399

	.align 16
block.403:
    movq -32(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, -8(%rbp)
    jl block.401
    jmp block.402

	.align 16
block.404:
    movq -16(%r15), %r11
    movq -16(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -32(%r15)
    jmp block.403

	.align 16
block.405:
    movq $255, %rdi
    callq exit
    jmp block.403

	.align 16
block.406:
    movq -16(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, -16(%rbp)
    jl block.404
    jmp block.405

	.align 16
block.407:
    cmpq $0, -16(%rbp)
    jge block.406
    jmp block.405

	.align 16
block.408:
    cmpq $0, -8(%rbp)
    jge block.407
    jmp block.402

	.align 16
block.395:
    cmpq %rbx, -8(%rbp)
    jl block.408
    addq $1, -16(%rbp)
    jmp block.394

	.align 16
block.410:
    movq $0, -8(%rbp)
    jmp block.395

	.align 16
block.394:
    cmpq %r13, -16(%rbp)
    jl block.410
    movq -16(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    movq %rcx, %rdi
    callq print_int
    movq $0, %rax
    cmpq $0, %rax
    jge block.393
    jmp block.392

	.align 16
block.415:
    movq -24(%rbp), %rcx
    imulq -32(%rbp), %rcx
    addq %rcx, -40(%rbp)
    addq $1, -48(%rbp)
    jmp block.414

	.align 16
block.421:
    movq $255, %rdi
    callq exit
    jmp block.415

	.align 16
block.416:
    movq -40(%r15), %r11
    movq -8(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -32(%rbp)
    jmp block.415

	.align 16
block.418:
    movq $255, %rdi
    callq exit
    jmp block.416

	.align 16
block.417:
    movq -48(%r15), %r11
    movq -48(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -40(%r15)
    jmp block.416

	.align 16
block.419:
    movq -48(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, -48(%rbp)
    jl block.417
    jmp block.418

	.align 16
block.420:
    cmpq $0, -48(%rbp)
    jge block.419
    jmp block.418

	.align 16
block.422:
    movq -56(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, -8(%rbp)
    jl block.420
    jmp block.421

	.align 16
block.423:
    movq -48(%r15), %r11
    movq -48(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -56(%r15)
    jmp block.422

	.align 16
block.424:
    movq $255, %rdi
    callq exit
    jmp block.422

	.align 16
block.425:
    movq -48(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, -48(%rbp)
    jl block.423
    jmp block.424

	.align 16
block.426:
    cmpq $0, -48(%rbp)
    jge block.425
    jmp block.424

	.align 16
block.427:
    cmpq $0, -8(%rbp)
    jge block.426
    jmp block.421

	.align 16
block.428:
    movq -64(%r15), %r11
    movq -48(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -24(%rbp)
    jmp block.427

	.align 16
block.433:
    movq $255, %rdi
    callq exit
    jmp block.427

	.align 16
block.429:
    movq -72(%r15), %r11
    movq -16(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -64(%r15)
    jmp block.428

	.align 16
block.430:
    movq $255, %rdi
    callq exit
    jmp block.428

	.align 16
block.431:
    movq -72(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, -16(%rbp)
    jl block.429
    jmp block.430

	.align 16
block.432:
    cmpq $0, -16(%rbp)
    jge block.431
    jmp block.430

	.align 16
block.434:
    movq -80(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, -48(%rbp)
    jl block.432
    jmp block.433

	.align 16
block.436:
    movq $255, %rdi
    callq exit
    jmp block.434

	.align 16
block.435:
    movq -72(%r15), %r11
    movq -16(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -80(%r15)
    jmp block.434

	.align 16
block.437:
    movq -72(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, -16(%rbp)
    jl block.435
    jmp block.436

	.align 16
block.438:
    cmpq $0, -16(%rbp)
    jge block.437
    jmp block.436

	.align 16
block.439:
    cmpq $0, -48(%rbp)
    jge block.438
    jmp block.433

	.align 16
block.440:
    addq $1, -8(%rbp)
    jmp block.413

	.align 16
block.441:
    movq -88(%r15), %r11
    movq -8(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq -40(%rbp), %rax
    movq %rax, 8(%r11)
    jmp block.440

	.align 16
block.442:
    movq -16(%r15), %r11
    movq -16(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -88(%r15)
    jmp block.441

	.align 16
block.443:
    movq $255, %rdi
    callq exit
    jmp block.441

	.align 16
block.444:
    movq -16(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, -16(%rbp)
    jl block.442
    jmp block.443

	.align 16
block.445:
    cmpq $0, -16(%rbp)
    jge block.444
    jmp block.443

	.align 16
block.446:
    movq -96(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, -8(%rbp)
    jl block.445
    jmp block.440

	.align 16
block.448:
    movq $255, %rdi
    callq exit
    jmp block.446

	.align 16
block.447:
    movq -16(%r15), %r11
    movq -16(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -96(%r15)
    jmp block.446

	.align 16
block.449:
    movq -16(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, -16(%rbp)
    jl block.447
    jmp block.448

	.align 16
block.450:
    cmpq $0, -16(%rbp)
    jge block.449
    jmp block.448

	.align 16
block.414:
    cmpq %r12, -48(%rbp)
    jl block.439
    cmpq $0, -8(%rbp)
    jge block.450
    jmp block.440

	.align 16
block.452:
    movq $0, -48(%rbp)
    movq $0, -40(%rbp)
    jmp block.414

	.align 16
block.413:
    cmpq %rbx, -8(%rbp)
    jl block.452
    addq $1, -16(%rbp)
    jmp block.412

	.align 16
block.454:
    movq $0, -8(%rbp)
    jmp block.413

	.align 16
block.412:
    cmpq %r13, -16(%rbp)
    jl block.454
    movq $0, -16(%rbp)
    jmp block.394

	.align 16
block.456:
    movq free_ptr(%rip), %r11
    addq $32, free_ptr(%rip)
    movq $4611686018427387919, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq -104(%r15), %rax
    movq %rax, 8(%r11)
    movq %rcx, %r11
    movq -112(%r15), %rax
    movq %rax, 16(%r11)
    movq %rcx, %r11
    movq -16(%r15), %rax
    movq %rax, 24(%r11)
    movq %rcx, -16(%r15)
    movq $0, -16(%rbp)
    jmp block.412

	.align 16
block.458:
    movq free_ptr(%rip), %r11
    addq $32, free_ptr(%rip)
    movq $4611686018427387917, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq -56(%rbp), %rax
    movq %rax, 8(%r11)
    movq %rcx, %r11
    movq -40(%rbp), %rax
    movq %rax, 16(%r11)
    movq %rcx, %r11
    movq -48(%rbp), %rax
    movq %rax, 24(%r11)
    movq %rcx, -16(%r15)
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.456
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.456

	.align 16
block.460:
    movq free_ptr(%rip), %r11
    addq $32, free_ptr(%rip)
    movq $4611686018427387917, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq -8(%rbp), %rax
    movq %rax, 8(%r11)
    movq %rcx, %r11
    movq -56(%rbp), %rax
    movq %rax, 16(%r11)
    movq %rcx, %r11
    movq -40(%rbp), %rax
    movq %rax, 24(%r11)
    movq %rcx, -112(%r15)
    movq $0, -56(%rbp)
    movq $0, -40(%rbp)
    movq $0, -48(%rbp)
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.458
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.458

	.align 16
block.462:
    movq free_ptr(%rip), %r11
    addq $32, free_ptr(%rip)
    movq $4611686018427387917, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq -56(%rbp), %rax
    movq %rax, 8(%r11)
    movq %rcx, %r11
    movq -8(%rbp), %rax
    movq %rax, 16(%r11)
    movq %rcx, %r11
    movq -16(%rbp), %rax
    movq %rax, 24(%r11)
    movq %rcx, -104(%r15)
    movq $0, -8(%rbp)
    movq $0, -56(%rbp)
    movq $0, -40(%rbp)
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.460
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.460

	.align 16
block.464:
    movq -112(%r15), %r11
    movq 0(%r11), %rbx
    movq $4611686018427387900, %rcx
    andq %rcx, %rbx
    sarq $2, %rbx
    movq %r13, %rdi
    callq print_int
    movq %r12, %rdi
    callq print_int
    movq %rbx, %rdi
    callq print_int
    movq $0, -56(%rbp)
    movq $0, -8(%rbp)
    movq $0, -16(%rbp)
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.462
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.462

	.align 16
block.466:
    movq $255, %rdi
    callq exit
    jmp block.464

	.align 16
block.465:
    movq -48(%r15), %r11
    movq $0, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -112(%r15)
    jmp block.464

	.align 16
block.467:
    movq -48(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    movq $0, %rax
    cmpq %rdx, %rax
    jl block.465
    jmp block.466

	.align 16
block.468:
    movq -16(%r15), %r11
    movq 0(%r11), %r12
    movq $4611686018427387900, %rcx
    andq %rcx, %r12
    sarq $2, %r12
    movq $0, %rax
    cmpq $0, %rax
    jge block.467
    jmp block.466

	.align 16
block.469:
    movq -72(%r15), %r11
    movq $0, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -16(%r15)
    jmp block.468

	.align 16
block.470:
    movq $255, %rdi
    callq exit
    jmp block.468

	.align 16
block.471:
    movq -72(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    movq $0, %rax
    cmpq %rdx, %rax
    jl block.469
    jmp block.470

	.align 16
block.472:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $4611686018427387915, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq -104(%r15), %rax
    movq %rax, 8(%r11)
    movq %rcx, %r11
    movq -48(%r15), %rax
    movq %rax, 16(%r11)
    movq %rcx, -48(%r15)
    movq -72(%r15), %r11
    movq 0(%r11), %r13
    movq $4611686018427387900, %rcx
    andq %rcx, %r13
    sarq $2, %r13
    movq $0, %rax
    cmpq $0, %rax
    jge block.471
    jmp block.470

	.align 16
block.474:
    movq free_ptr(%rip), %r11
    addq $32, free_ptr(%rip)
    movq $4611686018427387917, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %rbx, 8(%r11)
    movq %rcx, %r11
    movq %r12, 16(%r11)
    movq %rcx, %r11
    movq %r13, 24(%r11)
    movq %rcx, -48(%r15)
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.472
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.472

	.align 16
block.476:
    movq free_ptr(%rip), %r11
    addq $32, free_ptr(%rip)
    movq $4611686018427387917, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r12, 8(%r11)
    movq %rcx, %r11
    movq %rbx, 16(%r11)
    movq %rcx, %r11
    movq %r13, 24(%r11)
    movq %rcx, -104(%r15)
    movq $7, %rbx
    movq $8, %r12
    movq $12, %r13
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.474
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.474

	.align 16
block.478:
    movq free_ptr(%rip), %r11
    addq $32, free_ptr(%rip)
    movq $4611686018427387919, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq -48(%r15), %rax
    movq %rax, 8(%r11)
    movq %rcx, %r11
    movq -104(%r15), %rax
    movq %rax, 16(%r11)
    movq %rcx, %r11
    movq -72(%r15), %rax
    movq %rax, 24(%r11)
    movq %rcx, -72(%r15)
    movq $5, %r12
    movq $6, %rbx
    movq $6, %r13
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.476
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.476

	.align 16
block.480:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $4611686018427387913, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r12, 8(%r11)
    movq %rcx, %r11
    movq %rbx, 16(%r11)
    movq %rcx, -72(%r15)
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.478
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.478

	.align 16
block.482:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $4611686018427387913, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r12, 8(%r11)
    movq %rcx, %r11
    movq %rbx, 16(%r11)
    movq %rcx, -104(%r15)
    movq $9, %r12
    movq $11, %rbx
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.480
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.480

	.align 16
block.484:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $4611686018427387913, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %rbx, 8(%r11)
    movq %rcx, %r11
    movq %r12, 16(%r11)
    movq %rcx, -48(%r15)
    movq $3, %r12
    movq $4, %rbx
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.482
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.482

	.align 16
start:
    movq $1, %rbx
    movq $2, %r12
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.484
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.484

	.globl main
	.align 16
main:
    pushq %rbp
    pushq %rbx
    pushq %r12
    pushq %r13
    pushq %r14
    movq %rsp, %rbp
    subq $64, %rsp
    movq $65536, %rdi
    movq $16, %rsi
    callq initialize
    movq rootstack_begin(%rip), %r15
    movq $0, 0(%r15)
    movq $0, 8(%r15)
    movq $0, 16(%r15)
    movq $0, 24(%r15)
    movq $0, 32(%r15)
    movq $0, 40(%r15)
    movq $0, 48(%r15)
    movq $0, 56(%r15)
    movq $0, 64(%r15)
    movq $0, 72(%r15)
    movq $0, 80(%r15)
    movq $0, 88(%r15)
    movq $0, 96(%r15)
    movq $0, 104(%r15)
    addq $112, %r15
    jmp start


