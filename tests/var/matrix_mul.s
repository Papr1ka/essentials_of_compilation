	.align 16
block.506:
    movq -8(%r15), %r11
    movq 0(%r11), %rdi
    movq $4611686018427387900, %rcx
    andq %rcx, %rdi
    sarq $2, %rdi
    callq print_int
    movq %r13, %rdi
    callq print_int
    movq %r12, %rdi
    callq print_int
    movq %rbx, %rdi
    callq print_int
    movq $0, %rax
    jmp main_conclusion

	.align 16
block.508:
    movq $255, %rdi
    callq exit
    jmp block.506

	.align 16
block.507:
    movq -16(%r15), %r11
    movq $0, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -8(%r15)
    jmp block.506

	.align 16
block.509:
    movq -16(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    movq $0, %rax
    cmpq %rcx, %rax
    jl block.507
    jmp block.508

	.align 16
block.512:
    movq %r14, %rdi
    callq print_int
    addq $1, -8(%rbp)
    jmp block.511

	.align 16
block.513:
    movq -24(%r15), %r11
    movq -8(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %r14
    jmp block.512

	.align 16
block.518:
    movq $255, %rdi
    callq exit
    jmp block.512

	.align 16
block.515:
    movq $255, %rdi
    callq exit
    jmp block.513

	.align 16
block.514:
    movq -16(%r15), %r11
    movq -16(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -24(%r15)
    jmp block.513

	.align 16
block.516:
    movq -16(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, -16(%rbp)
    jl block.514
    jmp block.515

	.align 16
block.517:
    cmpq $0, -16(%rbp)
    jge block.516
    jmp block.515

	.align 16
block.519:
    movq -32(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, -8(%rbp)
    jl block.517
    jmp block.518

	.align 16
block.520:
    movq -16(%r15), %r11
    movq -16(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -32(%r15)
    jmp block.519

	.align 16
block.521:
    movq $255, %rdi
    callq exit
    jmp block.519

	.align 16
block.522:
    movq -16(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, -16(%rbp)
    jl block.520
    jmp block.521

	.align 16
block.523:
    cmpq $0, -16(%rbp)
    jge block.522
    jmp block.521

	.align 16
block.524:
    cmpq $0, -8(%rbp)
    jge block.523
    jmp block.518

	.align 16
block.511:
    cmpq %rbx, -8(%rbp)
    jl block.524
    addq $1, -16(%rbp)
    jmp block.510

	.align 16
block.526:
    movq $0, -8(%rbp)
    jmp block.511

	.align 16
block.510:
    cmpq %r13, -16(%rbp)
    jl block.526
    movq -16(%r15), %r11
    movq 0(%r11), %rdi
    movq $4611686018427387900, %rcx
    andq %rcx, %rdi
    sarq $2, %rdi
    callq print_int
    movq $0, %rax
    cmpq $0, %rax
    jge block.509
    jmp block.508

	.align 16
block.531:
    movq -24(%rbp), %rcx
    imulq -32(%rbp), %rcx
    addq %rcx, -40(%rbp)
    addq $1, -48(%rbp)
    jmp block.530

	.align 16
block.532:
    movq -40(%r15), %r11
    movq -8(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -32(%rbp)
    jmp block.531

	.align 16
block.537:
    movq $255, %rdi
    callq exit
    jmp block.531

	.align 16
block.533:
    movq -48(%r15), %r11
    movq -48(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -40(%r15)
    jmp block.532

	.align 16
block.534:
    movq $255, %rdi
    callq exit
    jmp block.532

	.align 16
block.535:
    movq -48(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, -48(%rbp)
    jl block.533
    jmp block.534

	.align 16
block.536:
    cmpq $0, -48(%rbp)
    jge block.535
    jmp block.534

	.align 16
block.538:
    movq -56(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, -8(%rbp)
    jl block.536
    jmp block.537

	.align 16
block.540:
    movq $255, %rdi
    callq exit
    jmp block.538

	.align 16
block.539:
    movq -48(%r15), %r11
    movq -48(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -56(%r15)
    jmp block.538

	.align 16
block.541:
    movq -48(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, -48(%rbp)
    jl block.539
    jmp block.540

	.align 16
block.542:
    cmpq $0, -48(%rbp)
    jge block.541
    jmp block.540

	.align 16
block.543:
    cmpq $0, -8(%rbp)
    jge block.542
    jmp block.537

	.align 16
block.549:
    movq $255, %rdi
    callq exit
    jmp block.543

	.align 16
block.544:
    movq -64(%r15), %r11
    movq -48(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -24(%rbp)
    jmp block.543

	.align 16
block.546:
    movq $255, %rdi
    callq exit
    jmp block.544

	.align 16
block.545:
    movq -72(%r15), %r11
    movq -16(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -64(%r15)
    jmp block.544

	.align 16
block.547:
    movq -72(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, -16(%rbp)
    jl block.545
    jmp block.546

	.align 16
block.548:
    cmpq $0, -16(%rbp)
    jge block.547
    jmp block.546

	.align 16
block.550:
    movq -80(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, -48(%rbp)
    jl block.548
    jmp block.549

	.align 16
block.552:
    movq $255, %rdi
    callq exit
    jmp block.550

	.align 16
block.551:
    movq -72(%r15), %r11
    movq -16(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -80(%r15)
    jmp block.550

	.align 16
block.553:
    movq -72(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, -16(%rbp)
    jl block.551
    jmp block.552

	.align 16
block.554:
    cmpq $0, -16(%rbp)
    jge block.553
    jmp block.552

	.align 16
block.555:
    cmpq $0, -48(%rbp)
    jge block.554
    jmp block.549

	.align 16
block.556:
    addq $1, -8(%rbp)
    jmp block.529

	.align 16
block.562:
    jmp block.556

	.align 16
block.557:
    movq -88(%r15), %r11
    movq -8(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq -40(%rbp), %rax
    movq %rax, 8(%r11)
    jmp block.556

	.align 16
block.558:
    movq -16(%r15), %r11
    movq -16(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -88(%r15)
    jmp block.557

	.align 16
block.559:
    movq $255, %rdi
    callq exit
    jmp block.557

	.align 16
block.560:
    movq -16(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, -16(%rbp)
    jl block.558
    jmp block.559

	.align 16
block.561:
    cmpq $0, -16(%rbp)
    jge block.560
    jmp block.559

	.align 16
block.563:
    movq -96(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    cmpq %rcx, -8(%rbp)
    jl block.561
    jmp block.562

	.align 16
block.565:
    movq $255, %rdi
    callq exit
    jmp block.563

	.align 16
block.564:
    movq -16(%r15), %r11
    movq -16(%rbp), %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -96(%r15)
    jmp block.563

	.align 16
block.566:
    movq -16(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    cmpq %rdx, -16(%rbp)
    jl block.564
    jmp block.565

	.align 16
block.567:
    cmpq $0, -16(%rbp)
    jge block.566
    jmp block.565

	.align 16
block.530:
    cmpq %r12, -48(%rbp)
    jl block.555
    cmpq $0, -8(%rbp)
    jge block.567
    jmp block.562

	.align 16
block.569:
    movq $0, -48(%rbp)
    movq $0, -40(%rbp)
    jmp block.530

	.align 16
block.529:
    cmpq %rbx, -8(%rbp)
    jl block.569
    addq $1, -16(%rbp)
    jmp block.528

	.align 16
block.571:
    movq $0, -8(%rbp)
    jmp block.529

	.align 16
block.528:
    cmpq %r13, -16(%rbp)
    jl block.571
    movq $0, -16(%rbp)
    jmp block.510

	.align 16
block.573:
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
    jmp block.528

	.align 16
block.575:
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
    jl block.573
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.573

	.align 16
block.577:
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
    movq -40(%rbp), %rax
    movq %rax, 24(%r11)
    movq %rcx, -112(%r15)
    movq $0, -56(%rbp)
    movq $0, -40(%rbp)
    movq $0, -48(%rbp)
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.575
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.575

	.align 16
block.579:
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
    movq $0, -56(%rbp)
    movq $0, -8(%rbp)
    movq $0, -40(%rbp)
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.577
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.577

	.align 16
block.581:
    movq -16(%r15), %r11
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
    jl block.579
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.579

	.align 16
block.583:
    movq $255, %rdi
    callq exit
    jmp block.581

	.align 16
block.582:
    movq -48(%r15), %r11
    movq $0, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -16(%r15)
    jmp block.581

	.align 16
block.584:
    movq -48(%r15), %r11
    movq 0(%r11), %rcx
    movq $4611686018427387900, %rdx
    andq %rdx, %rcx
    sarq $2, %rcx
    movq $0, %rax
    cmpq %rcx, %rax
    jl block.582
    jmp block.583

	.align 16
block.585:
    movq -112(%r15), %r11
    movq 0(%r11), %r12
    movq $4611686018427387900, %rcx
    andq %rcx, %r12
    sarq $2, %r12
    movq $0, %rax
    cmpq $0, %rax
    jge block.584
    jmp block.583

	.align 16
block.586:
    movq -72(%r15), %r11
    movq $0, %rcx
    imulq $8, %rcx
    addq %rcx, %r11
    movq 8(%r11), %rax
    movq %rax, -112(%r15)
    jmp block.585

	.align 16
block.587:
    movq $255, %rdi
    callq exit
    jmp block.585

	.align 16
block.588:
    movq -72(%r15), %r11
    movq 0(%r11), %rdx
    movq $4611686018427387900, %rcx
    andq %rcx, %rdx
    sarq $2, %rdx
    movq $0, %rax
    cmpq %rdx, %rax
    jl block.586
    jmp block.587

	.align 16
block.589:
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
    jge block.588
    jmp block.587

	.align 16
block.591:
    movq free_ptr(%rip), %r11
    addq $32, free_ptr(%rip)
    movq $4611686018427387917, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r12, 8(%r11)
    movq %rcx, %r11
    movq %r13, 16(%r11)
    movq %rcx, %r11
    movq %rbx, 24(%r11)
    movq %rcx, -48(%r15)
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.589
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.589

	.align 16
block.593:
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
    movq %rcx, -104(%r15)
    movq $7, %r12
    movq $8, %r13
    movq $12, %rbx
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.591
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.591

	.align 16
block.595:
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
    movq $5, %rbx
    movq $6, %r12
    movq $6, %r13
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.593
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.593

	.align 16
block.597:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $4611686018427387913, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %rbx, 8(%r11)
    movq %rcx, %r11
    movq %r12, 16(%r11)
    movq %rcx, -72(%r15)
    movq free_ptr(%rip), %rcx
    addq $32, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.595
    movq %r15, %rdi
    movq $32, %rsi
    callq collect
    jmp block.595

	.align 16
block.599:
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
    movq $9, %rbx
    movq $11, %r12
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.597
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.597

	.align 16
block.601:
    movq free_ptr(%rip), %r11
    addq $24, free_ptr(%rip)
    movq $4611686018427387913, %rax
    movq %rax, 0(%r11)
    movq %r11, %rcx
    movq %rcx, %r11
    movq %r12, 8(%r11)
    movq %rcx, %r11
    movq %rbx, 16(%r11)
    movq %rcx, -48(%r15)
    movq $3, %r12
    movq $4, %rbx
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.599
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.599

	.align 16
main_start:
    movq $1, %r12
    movq $2, %rbx
    movq free_ptr(%rip), %rcx
    addq $24, %rcx
    cmpq fromspace_end(%rip), %rcx
    jl block.601
    movq %r15, %rdi
    movq $24, %rsi
    callq collect
    jmp block.601

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
    addq $112, %r15
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
    jmp main_start

	.align 16
main_conclusion:
    subq $112, %r15
    addq $64, %rsp
    popq %r14
    popq %r13
    popq %r12
    popq %rbx
    popq %rbp
    retq 


