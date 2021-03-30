	.file	"game.c"
	.text
.Ltext0:
	.comm	accy,4,4
	.globl	quit_game
	.bss
	.align 4
	.type	quit_game, @object
	.size	quit_game, 4
quit_game:
	.zero	4
	.comm	climber,8,8
	.comm	rand_sem,8,8
	.text
	.globl	myrand
	.type	myrand, @function
myrand:
.LFB6:
	.file 1 "game.c"
	.loc 1 18 1
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	.loc 1 20 3
	movq	rand_sem(%rip), %rax
	movq	%rax, %rdi
	call	nWaitSem@PLT
	.loc 1 21 8
	call	rand@PLT
	movl	%eax, -4(%rbp)
	.loc 1 22 3
	movq	rand_sem(%rip), %rax
	movq	%rax, %rdi
	call	nSignalSem@PLT
	.loc 1 23 10
	movl	-4(%rbp), %eax
	.loc 1 24 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	myrand, .-myrand
	.section	.rodata
.LC2:
	.string	"ladder-screen.txt"
	.text
	.globl	nMain
	.type	nMain, @function
nMain:
.LFB7:
	.loc 1 29 1
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	%edi, -36(%rbp)
	movq	%rsi, -48(%rbp)
	.loc 1 34 3
	movl	$2, %edi
	call	nSetTimeSlice@PLT
	.loc 1 35 13
	movl	$1, %edi
	call	nMakeSem@PLT
	.loc 1 35 11
	movq	%rax, rand_sem(%rip)
	.loc 1 37 34
	cmpl	$1, -36(%rbp)
	jle	.L4
	.loc 1 37 29 discriminator 1
	movq	-48(%rbp), %rax
	addq	$8, %rax
	.loc 1 37 20 discriminator 1
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	jmp	.L5
.L4:
	.loc 1 37 34 discriminator 2
	movl	$3, %eax
.L5:
	.loc 1 37 8 discriminator 4
	movl	%eax, -4(%rbp)
	.loc 1 38 34 discriminator 4
	cmpl	$2, -36(%rbp)
	jle	.L6
	.loc 1 38 29 discriminator 1
	movq	-48(%rbp), %rax
	addq	$16, %rax
	.loc 1 38 20 discriminator 1
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atof@PLT
	.loc 1 38 34 discriminator 1
	cvtsd2ss	%xmm0, %xmm0
	jmp	.L7
.L6:
	.loc 1 38 34 is_stmt 0 discriminator 2
	movss	.LC0(%rip), %xmm0
.L7:
	.loc 1 38 8 is_stmt 1 discriminator 4
	movss	%xmm0, -20(%rbp)
	.loc 1 39 33 discriminator 4
	cmpl	$3, -36(%rbp)
	jle	.L8
	.loc 1 39 28 discriminator 1
	movq	-48(%rbp), %rax
	addq	$24, %rax
	.loc 1 39 19 discriminator 1
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atof@PLT
	.loc 1 39 33 discriminator 1
	cvtsd2ss	%xmm0, %xmm0
	jmp	.L9
.L8:
	.loc 1 39 33 is_stmt 0 discriminator 2
	movss	.LC1(%rip), %xmm0
.L9:
	.loc 1 39 7 is_stmt 1 discriminator 4
	movss	%xmm0, accy(%rip)
	.loc 1 41 3 discriminator 4
	leaq	.LC2(%rip), %rdi
	call	InitLadder@PLT
	.loc 1 43 13 discriminator 4
	movss	-20(%rbp), %xmm0
	movl	-4(%rbp), %eax
	movl	%eax, %esi
	leaq	BallGen(%rip), %rdi
	movl	$1, %eax
	call	nEmitTask@PLT
	movq	%rax, -16(%rbp)
	.loc 1 45 12 discriminator 4
	movss	-20(%rbp), %xmm0
	movl	$24, %edx
	movl	$1, %esi
	leaq	Climber(%rip), %rdi
	movl	$1, %eax
	call	nEmitTask@PLT
	.loc 1 45 10 discriminator 4
	movq	%rax, climber(%rip)
	.loc 1 46 3 discriminator 4
	movq	climber(%rip), %rax
	movq	%rax, %rdi
	call	nWaitTask@PLT
	.loc 1 48 12 discriminator 4
	movl	$1, quit_game(%rip)
	.loc 1 49 3 discriminator 4
	movq	-16(%rbp), %rax
	movl	$-1, %esi
	movq	%rax, %rdi
	call	CallServer@PLT
	.loc 1 50 3 discriminator 4
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	nWaitTask@PLT
	.loc 1 52 3 discriminator 4
	movl	$0, %eax
	call	EndLadder@PLT
	.loc 1 54 10 discriminator 4
	movl	$0, %eax
	.loc 1 55 1 discriminator 4
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	nMain, .-nMain
	.comm	balls,160,32
	.globl	curr_ball
	.bss
	.align 4
	.type	curr_ball, @object
	.size	curr_ball, 4
curr_ball:
	.zero	4
	.section	.rodata
.LC3:
	.string	"Generador de rocas"
	.text
	.globl	BallGen
	.type	BallGen, @function
BallGen:
.LFB8:
	.loc 1 67 1
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$56, %rsp
	.cfi_offset 3, -24
	movl	%edi, -52(%rbp)
	movss	%xmm0, -56(%rbp)
	.loc 1 68 7
	movl	$0, -20(%rbp)
	.loc 1 71 9
	movss	-56(%rbp), %xmm0
	movss	%xmm0, -24(%rbp)
	.loc 1 73 3
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	nSetTaskName@PLT
	.loc 1 75 9
	jmp	.L12
.L15:
.LBB2:
	.loc 1 77 30
	movl	$0, %eax
	call	myrand
	.loc 1 77 39
	andl	$1023, %eax
	.loc 1 77 22
	cvtsi2ss	%eax, %xmm0
	cvtss2sd	%xmm0, %xmm0
	.loc 1 77 46
	movsd	.LC4(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movapd	%xmm0, %xmm1
	.loc 1 77 54
	movsd	.LC5(%rip), %xmm0
	addsd	%xmm0, %xmm1
	.loc 1 77 60
	cvtss2sd	-24(%rbp), %xmm0
	mulsd	%xmm1, %xmm0
	.loc 1 77 11
	cvtsd2ss	%xmm0, %xmm2
	movss	%xmm2, -36(%rbp)
	.loc 1 79 18
	movl	curr_ball(%rip), %eax
	.loc 1 79 8
	cmpl	%eax, -52(%rbp)
	jg	.L13
	.loc 1 79 37 discriminator 1
	movl	$0, curr_ball(%rip)
.L13:
	.loc 1 80 14
	movl	curr_ball(%rip), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	balls(%rip), %rax
	movq	(%rdx,%rax), %rax
	.loc 1 80 8
	testq	%rax, %rax
	je	.L14
	.loc 1 80 33 discriminator 1
	movl	curr_ball(%rip), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	balls(%rip), %rax
	movq	(%rdx,%rax), %rax
	movq	%rax, %rdi
	call	nWaitTask@PLT
.L14:
	.loc 1 82 23
	cvtss2sd	-36(%rbp), %xmm0
	.loc 1 82 10
	movl	curr_ball(%rip), %ebx
	.loc 1 82 23
	movl	$1, %edx
	movl	$1, %esi
	leaq	Ball(%rip), %rdi
	movl	$1, %eax
	call	nEmitTask@PLT
	movq	%rax, %rcx
	.loc 1 82 21
	movslq	%ebx, %rax
	leaq	0(,%rax,8), %rdx
	leaq	balls(%rip), %rax
	movq	%rcx, (%rdx,%rax)
	.loc 1 84 14
	movl	curr_ball(%rip), %eax
	addl	$1, %eax
	movl	%eax, curr_ball(%rip)
	.loc 1 85 13
	movl	$0, %eax
	call	myrand
	.loc 1 85 11
	andl	$4095, %eax
	movl	%eax, -20(%rbp)
.L12:
.LBE2:
	.loc 1 75 28
	movl	-20(%rbp), %edx
	leaq	-48(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	nReceive@PLT
	movq	%rax, -32(%rbp)
	.loc 1 75 9
	cmpq	$0, -32(%rbp)
	je	.L15
	.loc 1 88 3
	movq	-48(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	nReply@PLT
	.loc 1 90 12
	movl	$0, curr_ball(%rip)
	.loc 1 91 9
	jmp	.L16
.L18:
	.loc 1 94 5
	movl	curr_ball(%rip), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	balls(%rip), %rax
	movq	(%rdx,%rax), %rax
	movq	%rax, %rdi
	call	nWaitTask@PLT
	.loc 1 95 14
	movl	curr_ball(%rip), %eax
	addl	$1, %eax
	movl	%eax, curr_ball(%rip)
.L16:
	.loc 1 91 19
	movl	curr_ball(%rip), %eax
	.loc 1 91 9
	cmpl	%eax, -52(%rbp)
	jle	.L17
	.loc 1 91 35 discriminator 1
	movl	curr_ball(%rip), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	balls(%rip), %rax
	movq	(%rdx,%rax), %rax
	.loc 1 91 27 discriminator 1
	testq	%rax, %rax
	jne	.L18
.L17:
	.loc 1 98 10
	movl	$0, %eax
	.loc 1 99 1
	addq	$56, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	BallGen, .-BallGen
	.section	.rodata
.LC7:
	.string	"Roca"
.LC12:
	.string	"Malo\n"
.LC13:
	.string	"Ball"
	.text
	.globl	Ball
	.type	Ball, @function
Ball:
.LFB9:
	.loc 1 104 1
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movl	%edi, -52(%rbp)
	movl	%esi, -56(%rbp)
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -64(%rbp)
	.loc 1 105 9
	cvtsi2ss	-52(%rbp), %xmm0
	movss	%xmm0, -4(%rbp)
	.loc 1 106 9
	cvtsi2ss	-56(%rbp), %xmm0
	movss	%xmm0, -8(%rbp)
	.loc 1 107 9
	movss	-64(%rbp), %xmm0
	movss	%xmm0, -12(%rbp)
	.loc 1 108 9
	pxor	%xmm0, %xmm0
	movss	%xmm0, -16(%rbp)
	.loc 1 110 3
	leaq	.LC7(%rip), %rdi
	movl	$0, %eax
	call	nSetTaskName@PLT
	.loc 1 112 9
	jmp	.L21
.L52:
.LBB3:
	.loc 1 116 9
	movl	-56(%rbp), %eax
	leal	1(%rax), %edx
	movl	-52(%rbp), %eax
	movl	%eax, %esi
	movl	%edx, %edi
	call	Get@PLT
	.loc 1 116 8
	cmpl	$84, %eax
	jne	.L22
	.loc 1 118 9
	pxor	%xmm0, %xmm0
	movss	%xmm0, -16(%rbp)
	.loc 1 119 10
	pxor	%xmm0, %xmm0
	ucomiss	-12(%rbp), %xmm0
	jp	.L27
	pxor	%xmm0, %xmm0
	ucomiss	-12(%rbp), %xmm0
	jne	.L27
	.loc 1 119 25 discriminator 1
	movl	$0, %eax
	call	myrand
	.loc 1 119 33 discriminator 1
	andl	$1, %eax
	.loc 1 119 46 discriminator 1
	cmpl	$1, %eax
	je	.L25
	.loc 1 119 46 is_stmt 0 discriminator 2
	movss	-64(%rbp), %xmm0
	movss	.LC8(%rip), %xmm1
	xorps	%xmm1, %xmm0
	jmp	.L26
.L25:
	.loc 1 119 46 discriminator 3
	movss	-64(%rbp), %xmm0
.L26:
	.loc 1 119 22 is_stmt 1 discriminator 5
	movss	%xmm0, -12(%rbp)
	jmp	.L27
.L22:
	.loc 1 121 14
	movl	-56(%rbp), %eax
	leal	1(%rax), %edx
	movl	-52(%rbp), %eax
	movl	%eax, %esi
	movl	%edx, %edi
	call	Get@PLT
	.loc 1 121 13
	cmpl	$72, %eax
	jne	.L27
	.loc 1 123 12
	movl	$0, %eax
	call	myrand
	.loc 1 123 20
	andl	$1, %eax
	.loc 1 123 10
	cmpl	$1, %eax
	jne	.L28
	.loc 1 125 11
	movss	-64(%rbp), %xmm0
	movss	.LC9(%rip), %xmm1
	divss	%xmm1, %xmm0
	movss	%xmm0, -16(%rbp)
	.loc 1 126 11
	pxor	%xmm0, %xmm0
	movss	%xmm0, -12(%rbp)
	jmp	.L27
.L28:
	.loc 1 128 14
	pxor	%xmm0, %xmm0
	movss	%xmm0, -16(%rbp)
.L27:
	.loc 1 131 8
	movss	-12(%rbp), %xmm0
	pxor	%xmm1, %xmm1
	comiss	%xmm1, %xmm0
	jbe	.L29
	.loc 1 131 20 discriminator 1
	movl	-52(%rbp), %eax
	leal	1(%rax), %edx
	movl	-56(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	Get@PLT
	.loc 1 131 17 discriminator 1
	cmpl	$84, %eax
	je	.L31
.L29:
	.loc 1 131 38 discriminator 3
	pxor	%xmm0, %xmm0
	comiss	-16(%rbp), %xmm0
	jbe	.L32
	.loc 1 131 52 discriminator 4
	movl	-52(%rbp), %eax
	leal	-1(%rax), %edx
	movl	-56(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	Get@PLT
	.loc 1 131 49 discriminator 4
	cmpl	$84, %eax
	jne	.L32
.L31:
	.loc 1 132 10
	movss	-12(%rbp), %xmm0
	movss	.LC8(%rip), %xmm1
	xorps	%xmm1, %xmm0
	movss	%xmm0, -12(%rbp)
.L32:
.LBB4:
	.loc 1 134 13
	movss	.LC10(%rip), %xmm0
	movss	%xmm0, -20(%rbp)
	.loc 1 135 13
	movss	.LC10(%rip), %xmm0
	movss	%xmm0, -24(%rbp)
	.loc 1 137 10
	movss	-12(%rbp), %xmm0
	pxor	%xmm1, %xmm1
	comiss	%xmm1, %xmm0
	jbe	.L62
	.loc 1 138 18
	cvtss2sd	-4(%rbp), %xmm1
	movsd	.LC11(%rip), %xmm0
	addsd	%xmm1, %xmm0
	call	floor@PLT
	movapd	%xmm0, %xmm1
	.loc 1 138 31
	cvtss2sd	-4(%rbp), %xmm0
	subsd	%xmm0, %xmm1
	movapd	%xmm1, %xmm0
	.loc 1 138 35
	cvtss2sd	-12(%rbp), %xmm1
	divsd	%xmm1, %xmm0
	.loc 1 138 15
	cvtsd2ss	%xmm0, %xmm4
	movss	%xmm4, -20(%rbp)
	jmp	.L36
.L62:
	.loc 1 139 15
	pxor	%xmm0, %xmm0
	comiss	-12(%rbp), %xmm0
	jbe	.L36
	.loc 1 140 20
	cvtss2sd	-4(%rbp), %xmm3
	movsd	%xmm3, -72(%rbp)
	.loc 1 140 21
	cvtss2sd	-4(%rbp), %xmm0
	movsd	.LC11(%rip), %xmm1
	subsd	%xmm1, %xmm0
	call	ceil@PLT
	.loc 1 140 20
	movsd	-72(%rbp), %xmm3
	subsd	%xmm0, %xmm3
	movapd	%xmm3, %xmm0
	.loc 1 140 35
	movss	-12(%rbp), %xmm1
	movss	.LC8(%rip), %xmm2
	xorps	%xmm2, %xmm1
	cvtss2sd	%xmm1, %xmm1
	.loc 1 140 34
	divsd	%xmm1, %xmm0
	.loc 1 140 15
	cvtsd2ss	%xmm0, %xmm5
	movss	%xmm5, -20(%rbp)
.L36:
	.loc 1 142 10
	movss	-16(%rbp), %xmm0
	pxor	%xmm1, %xmm1
	comiss	%xmm1, %xmm0
	jbe	.L38
	.loc 1 142 28 discriminator 1
	cvtss2sd	-8(%rbp), %xmm1
	movsd	.LC11(%rip), %xmm0
	addsd	%xmm1, %xmm0
	call	floor@PLT
	movapd	%xmm0, %xmm1
	.loc 1 142 41 discriminator 1
	cvtss2sd	-8(%rbp), %xmm0
	subsd	%xmm0, %xmm1
	movapd	%xmm1, %xmm0
	.loc 1 142 45 discriminator 1
	cvtss2sd	-16(%rbp), %xmm1
	divsd	%xmm1, %xmm0
	.loc 1 142 25 discriminator 1
	cvtsd2ss	%xmm0, %xmm6
	movss	%xmm6, -24(%rbp)
.L38:
	.loc 1 144 37
	movss	-24(%rbp), %xmm0
	comiss	-20(%rbp), %xmm0
	jbe	.L63
	.loc 1 144 37 is_stmt 0 discriminator 1
	movss	-20(%rbp), %xmm0
	jmp	.L42
.L63:
	.loc 1 144 37 discriminator 2
	movss	-24(%rbp), %xmm0
.L42:
	.loc 1 144 12 is_stmt 1 discriminator 4
	movss	%xmm0, -28(%rbp)
.LBE4:
	.loc 1 147 14 discriminator 4
	movss	-12(%rbp), %xmm0
	mulss	-28(%rbp), %xmm0
	.loc 1 147 8 discriminator 4
	movss	-4(%rbp), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -4(%rbp)
	.loc 1 148 14 discriminator 4
	movss	-16(%rbp), %xmm0
	mulss	-28(%rbp), %xmm0
	.loc 1 148 8 discriminator 4
	movss	-8(%rbp), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -8(%rbp)
	.loc 1 150 6 discriminator 4
	movss	-4(%rbp), %xmm0
	cvttss2si	%xmm0, %eax
	movl	%eax, -52(%rbp)
	.loc 1 150 18 discriminator 4
	movss	-8(%rbp), %xmm0
	cvttss2si	%xmm0, %eax
	movl	%eax, -56(%rbp)
	.loc 1 152 9 discriminator 4
	movl	-52(%rbp), %edx
	movl	-56(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	Get@PLT
	.loc 1 152 8 discriminator 4
	cmpl	$84, %eax
	jne	.L43
	.loc 1 154 9
	movss	-12(%rbp), %xmm0
	movss	.LC8(%rip), %xmm1
	xorps	%xmm1, %xmm0
	movss	%xmm0, -12(%rbp)
	.loc 1 155 16
	movss	-12(%rbp), %xmm0
	mulss	-28(%rbp), %xmm0
	.loc 1 155 10
	movss	-4(%rbp), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -4(%rbp)
	.loc 1 156 8
	movss	-4(%rbp), %xmm0
	cvttss2si	%xmm0, %eax
	movl	%eax, -52(%rbp)
.L43:
	.loc 1 159 16
	movss	accy(%rip), %xmm0
	mulss	-28(%rbp), %xmm0
	.loc 1 159 8
	movss	-16(%rbp), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -16(%rbp)
	.loc 1 161 8
	pxor	%xmm0, %xmm0
	ucomiss	-12(%rbp), %xmm0
	jp	.L44
	pxor	%xmm0, %xmm0
	ucomiss	-12(%rbp), %xmm0
	jne	.L44
	.loc 1 161 19 discriminator 1
	pxor	%xmm0, %xmm0
	ucomiss	-16(%rbp), %xmm0
	jp	.L44
	pxor	%xmm0, %xmm0
	ucomiss	-16(%rbp), %xmm0
	je	.L46
.L44:
	.loc 1 161 31 discriminator 3
	pxor	%xmm0, %xmm0
	comiss	-28(%rbp), %xmm0
	ja	.L46
	.loc 1 161 44 discriminator 4
	movss	-28(%rbp), %xmm0
	comiss	.LC10(%rip), %xmm0
	jbe	.L48
.L46:
	.loc 1 162 7
	leaq	.LC12(%rip), %rsi
	leaq	.LC13(%rip), %rdi
	movl	$0, %eax
	call	nFatalError@PLT
.L48:
.LBB5:
	.loc 1 166 11
	movl	$120, -44(%rbp)
	.loc 1 168 11
	movl	-52(%rbp), %edx
	movl	-56(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	Get@PLT
	.loc 1 168 10
	cmpl	$64, %eax
	jne	.L50
	.loc 1 168 27 discriminator 1
	movl	$0, %edi
	call	nExitTask@PLT
.L50:
	.loc 1 170 17
	movl	-52(%rbp), %edx
	movl	-56(%rbp), %eax
	movl	%eax, %esi
	movl	$111, %edi
	call	Put@PLT
	movl	%eax, -32(%rbp)
	.loc 1 172 10
	cmpl	$80, -32(%rbp)
	jne	.L51
	.loc 1 173 9
	movq	climber(%rip), %rax
	leaq	-44(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	nSend@PLT
.L51:
	.loc 1 175 13
	movss	-28(%rbp), %xmm0
	cvttss2si	%xmm0, %edx
	leaq	-40(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	nReceive@PLT
	.loc 1 176 7
	movl	-52(%rbp), %edx
	movl	-56(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	Restore@PLT
.L21:
.LBE5:
.LBE3:
	.loc 1 112 11
	movl	quit_game(%rip), %eax
	.loc 1 112 9
	testl	%eax, %eax
	je	.L52
	.loc 1 179 10
	movl	$0, %eax
	.loc 1 180 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	Ball, .-Ball
	.section	.rodata
.LC14:
	.string	"lector"
	.text
	.globl	Kbd
	.type	Kbd, @function
Kbd:
.LFB10:
	.loc 1 183 1
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	.loc 1 186 3
	leaq	.LC14(%rip), %rdi
	movl	$0, %eax
	call	nSetTaskName@PLT
.L65:
	.loc 1 190 8 discriminator 1
	movl	$0, %eax
	call	GetchTty@PLT
	.loc 1 190 7 discriminator 1
	movl	%eax, -4(%rbp)
	.loc 1 191 5 discriminator 1
	leaq	-4(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	nSend@PLT
	.loc 1 193 14 discriminator 1
	movl	-4(%rbp), %eax
	.loc 1 193 5 discriminator 1
	cmpl	$113, %eax
	jne	.L65
	.loc 1 195 10
	movl	$0, %eax
	.loc 1 196 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	Kbd, .-Kbd
	.section	.rodata
.LC15:
	.string	"*** Perdiste ***"
.LC16:
	.string	"Escalador"
.LC18:
	.string	"*** Ganaste ***"
	.text
	.globl	Climber
	.type	Climber, @function
Climber:
.LFB11:
	.loc 1 201 1
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$160, %rsp
	movl	%edi, -132(%rbp)
	movl	%esi, -136(%rbp)
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -144(%rbp)
	.loc 1 202 19
	call	nCurrentTask@PLT
	movq	%rax, %rsi
	leaq	Kbd(%rip), %rdi
	movl	$0, %eax
	call	nEmitTask@PLT
	movq	%rax, -64(%rbp)
	.loc 1 204 7
	movl	$0, -8(%rbp)
	.loc 1 205 9
	cvtsi2ss	-132(%rbp), %xmm0
	movss	%xmm0, -12(%rbp)
	.loc 1 205 24
	cvtsi2ss	-136(%rbp), %xmm0
	movss	%xmm0, -16(%rbp)
	.loc 1 206 9
	pxor	%xmm0, %xmm0
	movss	%xmm0, -20(%rbp)
	.loc 1 206 18
	pxor	%xmm0, %xmm0
	movss	%xmm0, -24(%rbp)
	.loc 1 207 9
	pxor	%xmm0, %xmm0
	movss	%xmm0, -28(%rbp)
	.loc 1 208 9
	leaq	.LC15(%rip), %rax
	movq	%rax, -40(%rbp)
	.loc 1 212 3
	leaq	.LC16(%rip), %rdi
	movl	$0, %eax
	call	nSetTaskName@PLT
	.loc 1 214 20
	call	nGetTime@PLT
	.loc 1 214 11
	cvtsi2ss	%eax, %xmm0
	movss	%xmm0, -4(%rbp)
.L126:
.LBB6:
	.loc 1 221 19
	movss	-28(%rbp), %xmm0
	cvttss2si	%xmm0, %edx
	leaq	-120(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	nReceive@PLT
	movq	%rax, -72(%rbp)
	.loc 1 223 22
	call	nGetTime@PLT
	.loc 1 223 13
	cvtsi2ss	%eax, %xmm0
	movss	%xmm0, -76(%rbp)
	.loc 1 224 17
	movss	-76(%rbp), %xmm0
	movaps	%xmm0, %xmm1
	subss	-4(%rbp), %xmm1
	.loc 1 224 8
	movss	-28(%rbp), %xmm0
	comiss	%xmm1, %xmm0
	jbe	.L68
	.loc 1 224 39 discriminator 1
	movss	-76(%rbp), %xmm0
	subss	-4(%rbp), %xmm0
	movss	%xmm0, -28(%rbp)
.L68:
	.loc 1 226 13
	movss	-76(%rbp), %xmm0
	movss	%xmm0, -4(%rbp)
	.loc 1 228 14
	movss	-20(%rbp), %xmm0
	mulss	-28(%rbp), %xmm0
	.loc 1 228 8
	movss	-12(%rbp), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -12(%rbp)
	.loc 1 229 14
	movss	-24(%rbp), %xmm0
	mulss	-28(%rbp), %xmm0
	.loc 1 229 8
	movss	-16(%rbp), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -16(%rbp)
	.loc 1 231 5
	movl	-132(%rbp), %edx
	movl	-136(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	Restore@PLT
	.loc 1 232 7
	movss	-12(%rbp), %xmm0
	cvttss2si	%xmm0, %eax
	movl	%eax, -132(%rbp)
	.loc 1 232 20
	movss	-16(%rbp), %xmm0
	cvttss2si	%xmm0, %eax
	movl	%eax, -136(%rbp)
	.loc 1 233 15
	movl	-132(%rbp), %edx
	movl	-136(%rbp), %eax
	movl	%eax, %esi
	movl	$80, %edi
	call	Put@PLT
	movl	%eax, -80(%rbp)
	.loc 1 236 8
	cmpq	$0, -72(%rbp)
	je	.L70
.LBB7:
	.loc 1 238 11
	movq	-72(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -84(%rbp)
	.loc 1 240 7
	movq	-120(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	nReply@PLT
	.loc 1 242 10
	cmpl	$120, -84(%rbp)
	je	.L154
	.loc 1 243 15
	cmpl	$113, -84(%rbp)
	jne	.L73
	.loc 1 245 9
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	nWaitTask@PLT
	.loc 1 246 9
	movl	$0, %edi
	call	nExitTask@PLT
	jmp	.L74
.L73:
	.loc 1 248 15
	cmpl	$105, -84(%rbp)
	jne	.L75
	.loc 1 250 12
	cmpl	$72, -80(%rbp)
	jne	.L76
	.loc 1 251 34
	pxor	%xmm0, %xmm0
	comiss	-24(%rbp), %xmm0
	jb	.L145
	.loc 1 251 25 discriminator 1
	movss	-144(%rbp), %xmm0
	movss	.LC8(%rip), %xmm1
	xorps	%xmm1, %xmm0
	cvtss2sd	%xmm0, %xmm0
	.loc 1 251 29 discriminator 1
	movsd	.LC17(%rip), %xmm1
	divsd	%xmm1, %xmm0
	.loc 1 251 34 discriminator 1
	cvtsd2ss	%xmm0, %xmm0
	jmp	.L79
.L145:
	.loc 1 251 34 is_stmt 0 discriminator 2
	pxor	%xmm0, %xmm0
.L79:
	.loc 1 251 13 is_stmt 1 discriminator 4
	movss	%xmm0, -24(%rbp)
	.loc 1 251 43 discriminator 4
	pxor	%xmm0, %xmm0
	movss	%xmm0, -20(%rbp)
	jmp	.L74
.L76:
	.loc 1 252 18
	movl	$-1, -8(%rbp)
	jmp	.L74
.L75:
	.loc 1 254 15
	cmpl	$107, -84(%rbp)
	jne	.L81
	.loc 1 256 12
	cmpl	$72, -80(%rbp)
	jne	.L82
	.loc 1 256 52 discriminator 1
	movss	-24(%rbp), %xmm0
	pxor	%xmm1, %xmm1
	comiss	%xmm1, %xmm0
	jb	.L146
	.loc 1 256 47 discriminator 2
	cvtss2sd	-144(%rbp), %xmm0
	movsd	.LC17(%rip), %xmm1
	divsd	%xmm1, %xmm0
	.loc 1 256 52 discriminator 2
	cvtsd2ss	%xmm0, %xmm0
	jmp	.L85
.L146:
	.loc 1 256 52 is_stmt 0 discriminator 3
	pxor	%xmm0, %xmm0
.L85:
	.loc 1 256 32 is_stmt 1 discriminator 5
	movss	%xmm0, -24(%rbp)
	.loc 1 256 61 discriminator 5
	pxor	%xmm0, %xmm0
	movss	%xmm0, -20(%rbp)
	jmp	.L74
.L82:
	.loc 1 257 18
	movl	$1, -8(%rbp)
	jmp	.L74
.L81:
	.loc 1 259 16
	movl	-136(%rbp), %eax
	leal	1(%rax), %edx
	movl	-132(%rbp), %eax
	movl	%eax, %esi
	movl	%edx, %edi
	call	Get@PLT
	.loc 1 259 15
	cmpl	$84, %eax
	je	.L87
	.loc 1 259 38 discriminator 1
	movl	-136(%rbp), %eax
	leal	1(%rax), %edx
	movl	-132(%rbp), %eax
	movl	%eax, %esi
	movl	%edx, %edi
	call	Get@PLT
	.loc 1 259 35 discriminator 1
	cmpl	$72, %eax
	jne	.L74
.L87:
	.loc 1 261 13
	movl	$0, -8(%rbp)
	.loc 1 262 12
	cmpl	$106, -84(%rbp)
	jne	.L88
	.loc 1 262 42 discriminator 1
	pxor	%xmm0, %xmm0
	comiss	-20(%rbp), %xmm0
	jb	.L147
	.loc 1 262 42 is_stmt 0 discriminator 2
	movss	-144(%rbp), %xmm0
	movss	.LC8(%rip), %xmm1
	xorps	%xmm1, %xmm0
	jmp	.L91
.L147:
	.loc 1 262 42 discriminator 3
	pxor	%xmm0, %xmm0
.L91:
	.loc 1 262 25 is_stmt 1 discriminator 5
	movss	%xmm0, -20(%rbp)
.L88:
	.loc 1 263 12
	cmpl	$108, -84(%rbp)
	jne	.L92
	.loc 1 263 41 discriminator 1
	movss	-20(%rbp), %xmm0
	pxor	%xmm1, %xmm1
	comiss	%xmm1, %xmm0
	jb	.L148
	.loc 1 263 41 is_stmt 0 discriminator 2
	movss	-144(%rbp), %xmm0
	jmp	.L95
.L148:
	.loc 1 263 41 discriminator 3
	pxor	%xmm0, %xmm0
.L95:
	.loc 1 263 25 is_stmt 1 discriminator 5
	movss	%xmm0, -20(%rbp)
.L92:
	.loc 1 264 12
	cmpl	$32, -84(%rbp)
	jne	.L74
	.loc 1 264 25 discriminator 1
	movss	-144(%rbp), %xmm0
	movss	.LC8(%rip), %xmm1
	xorps	%xmm1, %xmm0
	movss	%xmm0, -24(%rbp)
.L74:
	.loc 1 266 15
	movss	-4(%rbp), %xmm0
	movss	%xmm0, -76(%rbp)
.L70:
.LBE7:
	.loc 1 269 8
	cmpl	$35, -80(%rbp)
	jne	.L96
	.loc 1 271 13
	leaq	.LC18(%rip), %rax
	movq	%rax, -40(%rbp)
	.loc 1 272 7
	jmp	.L72
.L96:
	.loc 1 274 13
	cmpl	$111, -80(%rbp)
	je	.L155
	.loc 1 278 8
	cmpl	$0, -8(%rbp)
	je	.L98
	.loc 1 280 10
	cmpl	$0, -8(%rbp)
	jle	.L99
	.loc 1 280 21 discriminator 1
	movl	-136(%rbp), %eax
	leal	1(%rax), %edx
	movl	-132(%rbp), %eax
	movl	%eax, %esi
	movl	%edx, %edi
	call	Get@PLT
	.loc 1 280 18 discriminator 1
	cmpl	$72, %eax
	jne	.L99
	.loc 1 280 45 discriminator 2
	movss	-144(%rbp), %xmm0
	movss	.LC9(%rip), %xmm1
	divss	%xmm1, %xmm0
	movss	%xmm0, -24(%rbp)
	.loc 1 280 56 discriminator 2
	pxor	%xmm0, %xmm0
	movss	%xmm0, -20(%rbp)
	.loc 1 280 67 discriminator 2
	movl	$0, -8(%rbp)
	jmp	.L98
.L99:
	.loc 1 281 15
	cmpl	$0, -8(%rbp)
	jns	.L98
	.loc 1 281 23 discriminator 1
	cmpl	$72, -80(%rbp)
	jne	.L98
	.loc 1 281 47 discriminator 2
	movss	-144(%rbp), %xmm0
	movss	.LC8(%rip), %xmm1
	xorps	%xmm1, %xmm0
	.loc 1 281 45 discriminator 2
	movss	.LC9(%rip), %xmm1
	divss	%xmm1, %xmm0
	movss	%xmm0, -24(%rbp)
	.loc 1 281 57 discriminator 2
	pxor	%xmm0, %xmm0
	movss	%xmm0, -20(%rbp)
	.loc 1 281 68 discriminator 2
	movl	$0, -8(%rbp)
.L98:
.LBB8:
	.loc 1 284 40
	movss	-24(%rbp), %xmm0
	pxor	%xmm1, %xmm1
	comiss	%xmm1, %xmm0
	jb	.L149
	.loc 1 284 40 is_stmt 0 discriminator 1
	movl	$1, %edx
	jmp	.L102
.L149:
	.loc 1 284 40 discriminator 2
	movl	$-1, %edx
.L102:
	.loc 1 284 18 is_stmt 1 discriminator 4
	movl	-136(%rbp), %eax
	addl	%eax, %edx
	movl	-132(%rbp), %eax
	movl	%eax, %esi
	movl	%edx, %edi
	call	Get@PLT
	movl	%eax, -88(%rbp)
	.loc 1 285 10 discriminator 4
	cmpl	$84, -88(%rbp)
	jne	.L103
	.loc 1 285 25 discriminator 1
	pxor	%xmm0, %xmm0
	movss	%xmm0, -24(%rbp)
.L103:
.LBE8:
.LBB9:
	.loc 1 288 44
	movss	-20(%rbp), %xmm0
	pxor	%xmm1, %xmm1
	comiss	%xmm1, %xmm0
	jb	.L150
	.loc 1 288 44 is_stmt 0 discriminator 1
	movl	$1, %edx
	jmp	.L106
.L150:
	.loc 1 288 44 discriminator 2
	movl	$-1, %edx
.L106:
	.loc 1 288 18 is_stmt 1 discriminator 4
	movl	-132(%rbp), %eax
	addl	%eax, %edx
	movl	-136(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	Get@PLT
	movl	%eax, -92(%rbp)
	.loc 1 289 10 discriminator 4
	cmpl	$84, -92(%rbp)
	jne	.L107
	.loc 1 289 25 discriminator 1
	pxor	%xmm0, %xmm0
	movss	%xmm0, -20(%rbp)
.L107:
.LBE9:
	.loc 1 292 8
	cmpl	$72, -80(%rbp)
	je	.L108
	.loc 1 292 26 discriminator 1
	movl	-136(%rbp), %eax
	leal	1(%rax), %edx
	movl	-132(%rbp), %eax
	movl	%eax, %esi
	movl	%edx, %edi
	call	Get@PLT
	.loc 1 292 23 discriminator 1
	cmpl	$32, %eax
	jne	.L108
	.loc 1 292 55 discriminator 2
	movss	accy(%rip), %xmm0
	mulss	-28(%rbp), %xmm0
	.loc 1 292 48 discriminator 2
	movss	-24(%rbp), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, -24(%rbp)
.L108:
	.loc 1 293 8
	pxor	%xmm0, %xmm0
	comiss	-24(%rbp), %xmm0
	jbe	.L109
	.loc 1 293 16 discriminator 1
	pxor	%xmm0, %xmm0
	ucomiss	-20(%rbp), %xmm0
	jp	.L109
	pxor	%xmm0, %xmm0
	ucomiss	-20(%rbp), %xmm0
	jne	.L109
	.loc 1 293 27 discriminator 2
	cmpl	$32, -80(%rbp)
	jne	.L109
	.loc 1 293 47 discriminator 3
	movl	-136(%rbp), %eax
	leal	1(%rax), %edx
	movl	-132(%rbp), %eax
	movl	%eax, %esi
	movl	%edx, %edi
	call	Get@PLT
	.loc 1 293 44 discriminator 3
	cmpl	$72, %eax
	jne	.L109
	.loc 1 293 69 discriminator 4
	pxor	%xmm0, %xmm0
	movss	%xmm0, -24(%rbp)
.L109:
.LBB10:
	.loc 1 295 13
	movss	.LC10(%rip), %xmm0
	movss	%xmm0, -44(%rbp)
	.loc 1 296 13
	movss	.LC10(%rip), %xmm0
	movss	%xmm0, -48(%rbp)
	.loc 1 298 10
	pxor	%xmm0, %xmm0
	ucomiss	-20(%rbp), %xmm0
	jp	.L140
	pxor	%xmm0, %xmm0
	ucomiss	-20(%rbp), %xmm0
	je	.L112
.L140:
	.loc 1 299 48
	movss	-20(%rbp), %xmm0
	pxor	%xmm1, %xmm1
	comiss	%xmm1, %xmm0
	jbe	.L151
	.loc 1 299 27 discriminator 1
	cvtss2sd	-12(%rbp), %xmm1
	movsd	.LC11(%rip), %xmm0
	addsd	%xmm1, %xmm0
	call	floor@PLT
	movapd	%xmm0, %xmm1
	.loc 1 299 40 discriminator 1
	cvtss2sd	-12(%rbp), %xmm0
	subsd	%xmm0, %xmm1
	movapd	%xmm1, %xmm0
	.loc 1 299 44 discriminator 1
	cvtss2sd	-20(%rbp), %xmm1
	.loc 1 299 48 discriminator 1
	divsd	%xmm1, %xmm0
	jmp	.L116
.L151:
	.loc 1 299 53 discriminator 2
	cvtss2sd	-12(%rbp), %xmm3
	movsd	%xmm3, -152(%rbp)
	.loc 1 299 54 discriminator 2
	cvtss2sd	-12(%rbp), %xmm0
	movsd	.LC11(%rip), %xmm1
	subsd	%xmm1, %xmm0
	call	ceil@PLT
	.loc 1 299 53 discriminator 2
	movsd	-152(%rbp), %xmm3
	subsd	%xmm0, %xmm3
	movapd	%xmm3, %xmm0
	.loc 1 299 68 discriminator 2
	movss	-20(%rbp), %xmm1
	movss	.LC8(%rip), %xmm2
	xorps	%xmm2, %xmm1
	cvtss2sd	%xmm1, %xmm1
	.loc 1 299 48 discriminator 2
	divsd	%xmm1, %xmm0
.L116:
	.loc 1 299 15 discriminator 4
	cvtsd2ss	%xmm0, %xmm5
	movss	%xmm5, -44(%rbp)
.L112:
	.loc 1 301 10
	pxor	%xmm0, %xmm0
	ucomiss	-24(%rbp), %xmm0
	jp	.L142
	pxor	%xmm0, %xmm0
	ucomiss	-24(%rbp), %xmm0
	je	.L117
.L142:
	.loc 1 302 48
	movss	-24(%rbp), %xmm0
	pxor	%xmm1, %xmm1
	comiss	%xmm1, %xmm0
	jbe	.L152
	.loc 1 302 27 discriminator 1
	cvtss2sd	-16(%rbp), %xmm1
	movsd	.LC11(%rip), %xmm0
	addsd	%xmm1, %xmm0
	call	floor@PLT
	movapd	%xmm0, %xmm1
	.loc 1 302 40 discriminator 1
	cvtss2sd	-16(%rbp), %xmm0
	subsd	%xmm0, %xmm1
	movapd	%xmm1, %xmm0
	.loc 1 302 44 discriminator 1
	cvtss2sd	-24(%rbp), %xmm1
	.loc 1 302 48 discriminator 1
	divsd	%xmm1, %xmm0
	jmp	.L121
.L152:
	.loc 1 302 53 discriminator 2
	cvtss2sd	-16(%rbp), %xmm4
	movsd	%xmm4, -152(%rbp)
	.loc 1 302 54 discriminator 2
	cvtss2sd	-16(%rbp), %xmm0
	movsd	.LC11(%rip), %xmm1
	subsd	%xmm1, %xmm0
	call	ceil@PLT
	.loc 1 302 53 discriminator 2
	movsd	-152(%rbp), %xmm4
	subsd	%xmm0, %xmm4
	movapd	%xmm4, %xmm0
	.loc 1 302 68 discriminator 2
	movss	-24(%rbp), %xmm1
	movss	.LC8(%rip), %xmm2
	xorps	%xmm2, %xmm1
	cvtss2sd	%xmm1, %xmm1
	.loc 1 302 48 discriminator 2
	divsd	%xmm1, %xmm0
.L121:
	.loc 1 302 15 discriminator 4
	cvtsd2ss	%xmm0, %xmm6
	movss	%xmm6, -48(%rbp)
.L117:
	.loc 1 304 37
	movss	-48(%rbp), %xmm0
	comiss	-44(%rbp), %xmm0
	jbe	.L153
	.loc 1 304 37 is_stmt 0 discriminator 1
	movss	-44(%rbp), %xmm0
	jmp	.L124
.L153:
	.loc 1 304 37 discriminator 2
	movss	-48(%rbp), %xmm0
.L124:
	.loc 1 304 12 is_stmt 1 discriminator 4
	movss	%xmm0, -28(%rbp)
.LBE10:
.LBB11:
	.loc 1 307 26 discriminator 4
	movss	-20(%rbp), %xmm0
	mulss	-28(%rbp), %xmm0
	.loc 1 307 23 discriminator 4
	addss	-12(%rbp), %xmm0
	.loc 1 307 11 discriminator 4
	cvttss2si	%xmm0, %eax
	movl	%eax, -96(%rbp)
	.loc 1 308 26 discriminator 4
	movss	-24(%rbp), %xmm0
	mulss	-28(%rbp), %xmm0
	.loc 1 308 23 discriminator 4
	addss	-16(%rbp), %xmm0
	.loc 1 308 11 discriminator 4
	cvttss2si	%xmm0, %eax
	movl	%eax, -100(%rbp)
	.loc 1 309 11 discriminator 4
	movl	-96(%rbp), %edx
	movl	-100(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	Get@PLT
	.loc 1 309 10 discriminator 4
	cmpl	$84, %eax
	jne	.L126
	.loc 1 309 35 discriminator 1
	pxor	%xmm0, %xmm0
	movss	%xmm0, -24(%rbp)
	.loc 1 309 31 discriminator 1
	movss	-24(%rbp), %xmm0
	movss	%xmm0, -20(%rbp)
.LBE11:
.LBE6:
	.loc 1 217 3 discriminator 1
	jmp	.L126
.L154:
.LBB13:
.LBB12:
	.loc 1 242 7
	nop
	jmp	.L72
.L155:
.LBE12:
	.loc 1 274 5
	nop
.L72:
.LBE13:
.LBB14:
	.loc 1 313 9
	movl	$1, -52(%rbp)
	.loc 1 315 9
	movl	$32, -56(%rbp)
	.loc 1 317 11
	jmp	.L127
.L129:
	.loc 1 319 7
	movl	$38, %esi
	movl	$3, %edi
	call	ClearToEOL@PLT
	.loc 1 320 16
	movl	-52(%rbp), %eax
	leal	1(%rax), %edx
	movl	%edx, -52(%rbp)
	.loc 1 320 18
	andl	$1, %eax
	.loc 1 320 10
	testl	%eax, %eax
	je	.L128
	.loc 1 320 22 discriminator 1
	movq	-40(%rbp), %rax
	movq	%rax, %rdx
	movl	$48, %esi
	movl	$3, %edi
	movl	$0, %eax
	call	PrintTty@PLT
.L128:
	.loc 1 321 7
	movl	$0, %eax
	call	RefreshTty@PLT
	.loc 1 323 20
	leaq	-120(%rbp), %rax
	movl	$1000, %esi
	movq	%rax, %rdi
	call	nReceive@PLT
	movq	%rax, -112(%rbp)
	.loc 1 324 10
	cmpq	$0, -112(%rbp)
	je	.L127
	.loc 1 326 12
	movq	-112(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -56(%rbp)
	.loc 1 327 9
	movq	-120(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	nReply@PLT
.L127:
	.loc 1 317 11
	cmpl	$113, -56(%rbp)
	jne	.L129
.LBE14:
	.loc 1 330 3
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	nWaitTask@PLT
	.loc 1 332 10
	movl	$0, %eax
	.loc 1 333 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	Climber, .-Climber
	.section	.rodata
	.align 4
.LC0:
	.long	1017370378
	.align 4
.LC1:
	.long	953267991
	.align 8
.LC4:
	.long	0
	.long	1083179008
	.align 8
.LC5:
	.long	858993459
	.long	1070805811
	.align 16
.LC8:
	.long	2147483648
	.long	0
	.long	0
	.long	0
	.align 4
.LC9:
	.long	1073741824
	.align 4
.LC10:
	.long	1148846080
	.align 8
.LC11:
	.long	0
	.long	1072693248
	.align 8
.LC17:
	.long	0
	.long	1073741824
	.text
.Letext0:
	.file 2 "<built-in>"
	.file 3 "/usr/lib/gcc/x86_64-linux-gnu/8/include/stdarg.h"
	.file 4 "/usr/include/x86_64-linux-gnu/bits/types.h"
	.file 5 "/usr/include/curses.h"
	.file 6 "/usr/lib/gcc/x86_64-linux-gnu/8/include/stddef.h"
	.file 7 "/usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h"
	.file 8 "/usr/include/x86_64-linux-gnu/bits/types/FILE.h"
	.file 9 "/usr/include/stdio.h"
	.file 10 "/usr/include/x86_64-linux-gnu/bits/sys_errlist.h"
	.file 11 "/home/pss/CC41B/nsystem64-beta3/include/nSystem.h"
	.file 12 "tty.h"
	.file 13 "/usr/include/math.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0xc56
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.long	.LASF149
	.byte	0xc
	.long	.LASF150
	.long	.LASF151
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF6
	.byte	0x3
	.byte	0x28
	.byte	0x1b
	.long	0x39
	.uleb128 0x3
	.long	.LASF152
	.long	0x42
	.uleb128 0x4
	.long	0x59
	.long	0x52
	.uleb128 0x5
	.long	0x52
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.byte	0x7
	.long	.LASF4
	.uleb128 0x7
	.long	.LASF153
	.byte	0x18
	.byte	0x2
	.byte	0
	.long	0x96
	.uleb128 0x8
	.long	.LASF0
	.byte	0x2
	.byte	0
	.long	0x96
	.byte	0
	.uleb128 0x8
	.long	.LASF1
	.byte	0x2
	.byte	0
	.long	0x96
	.byte	0x4
	.uleb128 0x8
	.long	.LASF2
	.byte	0x2
	.byte	0
	.long	0x9d
	.byte	0x8
	.uleb128 0x8
	.long	.LASF3
	.byte	0x2
	.byte	0
	.long	0x9d
	.byte	0x10
	.byte	0
	.uleb128 0x6
	.byte	0x4
	.byte	0x7
	.long	.LASF5
	.uleb128 0x9
	.byte	0x8
	.uleb128 0x2
	.long	.LASF7
	.byte	0x3
	.byte	0x63
	.byte	0x18
	.long	0x2d
	.uleb128 0x6
	.byte	0x1
	.byte	0x8
	.long	.LASF8
	.uleb128 0x6
	.byte	0x2
	.byte	0x7
	.long	.LASF9
	.uleb128 0x6
	.byte	0x1
	.byte	0x6
	.long	.LASF10
	.uleb128 0x6
	.byte	0x2
	.byte	0x5
	.long	.LASF11
	.uleb128 0xa
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x6
	.byte	0x8
	.byte	0x5
	.long	.LASF12
	.uleb128 0x2
	.long	.LASF13
	.byte	0x4
	.byte	0x96
	.byte	0x19
	.long	0xce
	.uleb128 0x2
	.long	.LASF14
	.byte	0x4
	.byte	0x97
	.byte	0x1b
	.long	0xce
	.uleb128 0xb
	.byte	0x8
	.long	0xf3
	.uleb128 0x6
	.byte	0x1
	.byte	0x6
	.long	.LASF15
	.uleb128 0xc
	.long	0xf3
	.uleb128 0x2
	.long	.LASF16
	.byte	0x5
	.byte	0xad
	.byte	0x12
	.long	0x96
	.uleb128 0x2
	.long	.LASF17
	.byte	0x6
	.byte	0xd8
	.byte	0x17
	.long	0x52
	.uleb128 0xd
	.long	.LASF58
	.byte	0xd8
	.byte	0x7
	.byte	0x31
	.byte	0x8
	.long	0x29e
	.uleb128 0xe
	.long	.LASF18
	.byte	0x7
	.byte	0x33
	.byte	0x7
	.long	0xc7
	.byte	0
	.uleb128 0xe
	.long	.LASF19
	.byte	0x7
	.byte	0x36
	.byte	0x9
	.long	0xed
	.byte	0x8
	.uleb128 0xe
	.long	.LASF20
	.byte	0x7
	.byte	0x37
	.byte	0x9
	.long	0xed
	.byte	0x10
	.uleb128 0xe
	.long	.LASF21
	.byte	0x7
	.byte	0x38
	.byte	0x9
	.long	0xed
	.byte	0x18
	.uleb128 0xe
	.long	.LASF22
	.byte	0x7
	.byte	0x39
	.byte	0x9
	.long	0xed
	.byte	0x20
	.uleb128 0xe
	.long	.LASF23
	.byte	0x7
	.byte	0x3a
	.byte	0x9
	.long	0xed
	.byte	0x28
	.uleb128 0xe
	.long	.LASF24
	.byte	0x7
	.byte	0x3b
	.byte	0x9
	.long	0xed
	.byte	0x30
	.uleb128 0xe
	.long	.LASF25
	.byte	0x7
	.byte	0x3c
	.byte	0x9
	.long	0xed
	.byte	0x38
	.uleb128 0xe
	.long	.LASF26
	.byte	0x7
	.byte	0x3d
	.byte	0x9
	.long	0xed
	.byte	0x40
	.uleb128 0xe
	.long	.LASF27
	.byte	0x7
	.byte	0x40
	.byte	0x9
	.long	0xed
	.byte	0x48
	.uleb128 0xe
	.long	.LASF28
	.byte	0x7
	.byte	0x41
	.byte	0x9
	.long	0xed
	.byte	0x50
	.uleb128 0xe
	.long	.LASF29
	.byte	0x7
	.byte	0x42
	.byte	0x9
	.long	0xed
	.byte	0x58
	.uleb128 0xe
	.long	.LASF30
	.byte	0x7
	.byte	0x44
	.byte	0x16
	.long	0x2b7
	.byte	0x60
	.uleb128 0xe
	.long	.LASF31
	.byte	0x7
	.byte	0x46
	.byte	0x14
	.long	0x2bd
	.byte	0x68
	.uleb128 0xe
	.long	.LASF32
	.byte	0x7
	.byte	0x48
	.byte	0x7
	.long	0xc7
	.byte	0x70
	.uleb128 0xe
	.long	.LASF33
	.byte	0x7
	.byte	0x49
	.byte	0x7
	.long	0xc7
	.byte	0x74
	.uleb128 0xe
	.long	.LASF34
	.byte	0x7
	.byte	0x4a
	.byte	0xb
	.long	0xd5
	.byte	0x78
	.uleb128 0xe
	.long	.LASF35
	.byte	0x7
	.byte	0x4d
	.byte	0x12
	.long	0xb2
	.byte	0x80
	.uleb128 0xe
	.long	.LASF36
	.byte	0x7
	.byte	0x4e
	.byte	0xf
	.long	0xb9
	.byte	0x82
	.uleb128 0xe
	.long	.LASF37
	.byte	0x7
	.byte	0x4f
	.byte	0x8
	.long	0x2c3
	.byte	0x83
	.uleb128 0xe
	.long	.LASF38
	.byte	0x7
	.byte	0x51
	.byte	0xf
	.long	0x2d3
	.byte	0x88
	.uleb128 0xe
	.long	.LASF39
	.byte	0x7
	.byte	0x59
	.byte	0xd
	.long	0xe1
	.byte	0x90
	.uleb128 0xe
	.long	.LASF40
	.byte	0x7
	.byte	0x5b
	.byte	0x17
	.long	0x2de
	.byte	0x98
	.uleb128 0xe
	.long	.LASF41
	.byte	0x7
	.byte	0x5c
	.byte	0x19
	.long	0x2e9
	.byte	0xa0
	.uleb128 0xe
	.long	.LASF42
	.byte	0x7
	.byte	0x5d
	.byte	0x14
	.long	0x2bd
	.byte	0xa8
	.uleb128 0xe
	.long	.LASF43
	.byte	0x7
	.byte	0x5e
	.byte	0x9
	.long	0x9d
	.byte	0xb0
	.uleb128 0xe
	.long	.LASF44
	.byte	0x7
	.byte	0x5f
	.byte	0xa
	.long	0x10b
	.byte	0xb8
	.uleb128 0xe
	.long	.LASF45
	.byte	0x7
	.byte	0x60
	.byte	0x7
	.long	0xc7
	.byte	0xc0
	.uleb128 0xe
	.long	.LASF46
	.byte	0x7
	.byte	0x62
	.byte	0x8
	.long	0x2ef
	.byte	0xc4
	.byte	0
	.uleb128 0x2
	.long	.LASF47
	.byte	0x8
	.byte	0x7
	.byte	0x19
	.long	0x117
	.uleb128 0xf
	.long	.LASF154
	.byte	0x7
	.byte	0x2b
	.byte	0xe
	.uleb128 0x10
	.long	.LASF48
	.uleb128 0xb
	.byte	0x8
	.long	0x2b2
	.uleb128 0xb
	.byte	0x8
	.long	0x117
	.uleb128 0x4
	.long	0xf3
	.long	0x2d3
	.uleb128 0x5
	.long	0x52
	.byte	0
	.byte	0
	.uleb128 0xb
	.byte	0x8
	.long	0x2aa
	.uleb128 0x10
	.long	.LASF49
	.uleb128 0xb
	.byte	0x8
	.long	0x2d9
	.uleb128 0x10
	.long	.LASF50
	.uleb128 0xb
	.byte	0x8
	.long	0x2e4
	.uleb128 0x4
	.long	0xf3
	.long	0x2ff
	.uleb128 0x5
	.long	0x52
	.byte	0x13
	.byte	0
	.uleb128 0x11
	.long	.LASF51
	.byte	0x9
	.byte	0x89
	.byte	0xe
	.long	0x30b
	.uleb128 0xb
	.byte	0x8
	.long	0x29e
	.uleb128 0x11
	.long	.LASF52
	.byte	0x9
	.byte	0x8a
	.byte	0xe
	.long	0x30b
	.uleb128 0x11
	.long	.LASF53
	.byte	0x9
	.byte	0x8b
	.byte	0xe
	.long	0x30b
	.uleb128 0x11
	.long	.LASF54
	.byte	0xa
	.byte	0x1a
	.byte	0xc
	.long	0xc7
	.uleb128 0x4
	.long	0x34b
	.long	0x340
	.uleb128 0x12
	.byte	0
	.uleb128 0xc
	.long	0x335
	.uleb128 0xb
	.byte	0x8
	.long	0xfa
	.uleb128 0xc
	.long	0x345
	.uleb128 0x11
	.long	.LASF55
	.byte	0xa
	.byte	0x1b
	.byte	0x1a
	.long	0x340
	.uleb128 0x4
	.long	0xff
	.long	0x367
	.uleb128 0x12
	.byte	0
	.uleb128 0x13
	.long	.LASF56
	.byte	0x5
	.value	0x127
	.byte	0x23
	.long	0x35c
	.uleb128 0x14
	.long	.LASF57
	.byte	0x5
	.value	0x182
	.byte	0x18
	.long	0x381
	.uleb128 0x15
	.long	.LASF59
	.byte	0x58
	.byte	0x5
	.value	0x1b3
	.byte	0x8
	.long	0x50a
	.uleb128 0x16
	.long	.LASF60
	.byte	0x5
	.value	0x1b5
	.byte	0x11
	.long	0xc0
	.byte	0
	.uleb128 0x16
	.long	.LASF61
	.byte	0x5
	.value	0x1b5
	.byte	0x18
	.long	0xc0
	.byte	0x2
	.uleb128 0x16
	.long	.LASF62
	.byte	0x5
	.value	0x1b8
	.byte	0x11
	.long	0xc0
	.byte	0x4
	.uleb128 0x16
	.long	.LASF63
	.byte	0x5
	.value	0x1b8
	.byte	0x18
	.long	0xc0
	.byte	0x6
	.uleb128 0x16
	.long	.LASF64
	.byte	0x5
	.value	0x1b9
	.byte	0x11
	.long	0xc0
	.byte	0x8
	.uleb128 0x16
	.long	.LASF65
	.byte	0x5
	.value	0x1b9
	.byte	0x18
	.long	0xc0
	.byte	0xa
	.uleb128 0x16
	.long	.LASF18
	.byte	0x5
	.value	0x1bb
	.byte	0xa
	.long	0xc0
	.byte	0xc
	.uleb128 0x16
	.long	.LASF66
	.byte	0x5
	.value	0x1be
	.byte	0xa
	.long	0x50a
	.byte	0x10
	.uleb128 0x16
	.long	.LASF67
	.byte	0x5
	.value	0x1bf
	.byte	0xa
	.long	0xff
	.byte	0x14
	.uleb128 0x16
	.long	.LASF68
	.byte	0x5
	.value	0x1c2
	.byte	0x7
	.long	0x57a
	.byte	0x18
	.uleb128 0x16
	.long	.LASF69
	.byte	0x5
	.value	0x1c3
	.byte	0x7
	.long	0x57a
	.byte	0x19
	.uleb128 0x16
	.long	.LASF70
	.byte	0x5
	.value	0x1c4
	.byte	0x7
	.long	0x57a
	.byte	0x1a
	.uleb128 0x16
	.long	.LASF71
	.byte	0x5
	.value	0x1c5
	.byte	0x7
	.long	0x57a
	.byte	0x1b
	.uleb128 0x16
	.long	.LASF72
	.byte	0x5
	.value	0x1c6
	.byte	0x7
	.long	0x57a
	.byte	0x1c
	.uleb128 0x16
	.long	.LASF73
	.byte	0x5
	.value	0x1c7
	.byte	0x7
	.long	0x57a
	.byte	0x1d
	.uleb128 0x16
	.long	.LASF74
	.byte	0x5
	.value	0x1c8
	.byte	0x7
	.long	0x57a
	.byte	0x1e
	.uleb128 0x16
	.long	.LASF75
	.byte	0x5
	.value	0x1c9
	.byte	0x7
	.long	0x57a
	.byte	0x1f
	.uleb128 0x16
	.long	.LASF76
	.byte	0x5
	.value	0x1ca
	.byte	0x7
	.long	0x57a
	.byte	0x20
	.uleb128 0x16
	.long	.LASF77
	.byte	0x5
	.value	0x1cb
	.byte	0x6
	.long	0xc7
	.byte	0x24
	.uleb128 0x16
	.long	.LASF78
	.byte	0x5
	.value	0x1cd
	.byte	0xf
	.long	0x586
	.byte	0x28
	.uleb128 0x16
	.long	.LASF79
	.byte	0x5
	.value	0x1d0
	.byte	0x11
	.long	0xc0
	.byte	0x30
	.uleb128 0x16
	.long	.LASF80
	.byte	0x5
	.value	0x1d1
	.byte	0x11
	.long	0xc0
	.byte	0x32
	.uleb128 0x16
	.long	.LASF81
	.byte	0x5
	.value	0x1d4
	.byte	0x6
	.long	0xc7
	.byte	0x34
	.uleb128 0x16
	.long	.LASF82
	.byte	0x5
	.value	0x1d5
	.byte	0x6
	.long	0xc7
	.byte	0x38
	.uleb128 0x16
	.long	.LASF83
	.byte	0x5
	.value	0x1d6
	.byte	0xa
	.long	0x58c
	.byte	0x40
	.uleb128 0x16
	.long	.LASF84
	.byte	0x5
	.value	0x1de
	.byte	0x4
	.long	0x517
	.byte	0x48
	.uleb128 0x16
	.long	.LASF85
	.byte	0x5
	.value	0x1e0
	.byte	0x11
	.long	0xc0
	.byte	0x54
	.byte	0
	.uleb128 0x14
	.long	.LASF86
	.byte	0x5
	.value	0x184
	.byte	0x10
	.long	0xff
	.uleb128 0x15
	.long	.LASF87
	.byte	0xc
	.byte	0x5
	.value	0x1d9
	.byte	0x9
	.long	0x57a
	.uleb128 0x16
	.long	.LASF88
	.byte	0x5
	.value	0x1db
	.byte	0x15
	.long	0xc0
	.byte	0
	.uleb128 0x16
	.long	.LASF89
	.byte	0x5
	.value	0x1db
	.byte	0x22
	.long	0xc0
	.byte	0x2
	.uleb128 0x16
	.long	.LASF90
	.byte	0x5
	.value	0x1dc
	.byte	0x15
	.long	0xc0
	.byte	0x4
	.uleb128 0x16
	.long	.LASF91
	.byte	0x5
	.value	0x1dc
	.byte	0x22
	.long	0xc0
	.byte	0x6
	.uleb128 0x16
	.long	.LASF92
	.byte	0x5
	.value	0x1dd
	.byte	0x15
	.long	0xc0
	.byte	0x8
	.uleb128 0x16
	.long	.LASF93
	.byte	0x5
	.value	0x1dd
	.byte	0x22
	.long	0xc0
	.byte	0xa
	.byte	0
	.uleb128 0x6
	.byte	0x1
	.byte	0x2
	.long	.LASF94
	.uleb128 0x10
	.long	.LASF95
	.uleb128 0xb
	.byte	0x8
	.long	0x581
	.uleb128 0xb
	.byte	0x8
	.long	0x374
	.uleb128 0x13
	.long	.LASF96
	.byte	0x5
	.value	0x5bf
	.byte	0x25
	.long	0x58c
	.uleb128 0x13
	.long	.LASF97
	.byte	0x5
	.value	0x5c0
	.byte	0x25
	.long	0x58c
	.uleb128 0x13
	.long	.LASF98
	.byte	0x5
	.value	0x5c1
	.byte	0x25
	.long	0x58c
	.uleb128 0x4
	.long	0xf3
	.long	0x5c4
	.uleb128 0x12
	.byte	0
	.uleb128 0x13
	.long	.LASF99
	.byte	0x5
	.value	0x5c2
	.byte	0x21
	.long	0x5b9
	.uleb128 0x13
	.long	.LASF100
	.byte	0x5
	.value	0x5c3
	.byte	0x20
	.long	0xc7
	.uleb128 0x13
	.long	.LASF101
	.byte	0x5
	.value	0x5c4
	.byte	0x20
	.long	0xc7
	.uleb128 0x13
	.long	.LASF102
	.byte	0x5
	.value	0x5c5
	.byte	0x20
	.long	0xc7
	.uleb128 0x13
	.long	.LASF103
	.byte	0x5
	.value	0x5c6
	.byte	0x20
	.long	0xc7
	.uleb128 0x13
	.long	.LASF104
	.byte	0x5
	.value	0x5c7
	.byte	0x20
	.long	0xc7
	.uleb128 0x13
	.long	.LASF105
	.byte	0x5
	.value	0x5c8
	.byte	0x20
	.long	0xc7
	.uleb128 0x6
	.byte	0x8
	.byte	0x7
	.long	.LASF106
	.uleb128 0x6
	.byte	0x8
	.byte	0x5
	.long	.LASF107
	.uleb128 0x2
	.long	.LASF108
	.byte	0xb
	.byte	0x16
	.byte	0x18
	.long	0x639
	.uleb128 0xb
	.byte	0x8
	.long	0x63f
	.uleb128 0x10
	.long	.LASF109
	.uleb128 0x2
	.long	.LASF110
	.byte	0xb
	.byte	0x17
	.byte	0x18
	.long	0x650
	.uleb128 0xb
	.byte	0x8
	.long	0x656
	.uleb128 0x10
	.long	.LASF110
	.uleb128 0x17
	.byte	0x30
	.byte	0xc
	.byte	0x3e
	.byte	0x9
	.long	0x6a0
	.uleb128 0x18
	.string	"op"
	.byte	0xc
	.byte	0x40
	.byte	0x7
	.long	0xc7
	.byte	0
	.uleb128 0x18
	.string	"y"
	.byte	0xc
	.byte	0x41
	.byte	0x7
	.long	0xc7
	.byte	0x4
	.uleb128 0x18
	.string	"x"
	.byte	0xc
	.byte	0x41
	.byte	0xa
	.long	0xc7
	.byte	0x8
	.uleb128 0xe
	.long	.LASF111
	.byte	0xc
	.byte	0x42
	.byte	0x9
	.long	0xed
	.byte	0x10
	.uleb128 0x18
	.string	"ap"
	.byte	0xc
	.byte	0x43
	.byte	0xb
	.long	0x9f
	.byte	0x18
	.byte	0
	.uleb128 0x2
	.long	.LASF112
	.byte	0xc
	.byte	0x45
	.byte	0x3
	.long	0x65b
	.uleb128 0x6
	.byte	0x4
	.byte	0x4
	.long	.LASF113
	.uleb128 0x6
	.byte	0x8
	.byte	0x4
	.long	.LASF114
	.uleb128 0x13
	.long	.LASF115
	.byte	0xd
	.value	0x305
	.byte	0xc
	.long	0xc7
	.uleb128 0x19
	.long	.LASF116
	.byte	0x1
	.byte	0xb
	.byte	0x7
	.long	0x6ac
	.uleb128 0x9
	.byte	0x3
	.quad	accy
	.uleb128 0x19
	.long	.LASF117
	.byte	0x1
	.byte	0xc
	.byte	0x5
	.long	0xc7
	.uleb128 0x9
	.byte	0x3
	.quad	quit_game
	.uleb128 0x19
	.long	.LASF118
	.byte	0x1
	.byte	0xd
	.byte	0x7
	.long	0x62d
	.uleb128 0x9
	.byte	0x3
	.quad	climber
	.uleb128 0x19
	.long	.LASF119
	.byte	0x1
	.byte	0xf
	.byte	0x6
	.long	0x644
	.uleb128 0x9
	.byte	0x3
	.quad	rand_sem
	.uleb128 0x17
	.byte	0x4
	.byte	0x1
	.byte	0x1a
	.byte	0x9
	.long	0x734
	.uleb128 0x18
	.string	"r"
	.byte	0x1
	.byte	0x1a
	.byte	0x18
	.long	0x6ac
	.byte	0
	.byte	0
	.uleb128 0x2
	.long	.LASF120
	.byte	0x1
	.byte	0x1a
	.byte	0x1d
	.long	0x71f
	.uleb128 0x4
	.long	0x62d
	.long	0x750
	.uleb128 0x5
	.long	0x52
	.byte	0x13
	.byte	0
	.uleb128 0x19
	.long	.LASF121
	.byte	0x1
	.byte	0x3d
	.byte	0x7
	.long	0x740
	.uleb128 0x9
	.byte	0x3
	.quad	balls
	.uleb128 0x19
	.long	.LASF122
	.byte	0x1
	.byte	0x3e
	.byte	0x5
	.long	0xc7
	.uleb128 0x9
	.byte	0x3
	.quad	curr_ball
	.uleb128 0x1a
	.long	.LASF138
	.byte	0x1
	.byte	0xc6
	.byte	0x5
	.long	0xc7
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0x9b0
	.uleb128 0x1b
	.string	"ix"
	.byte	0x1
	.byte	0xc8
	.byte	0x5
	.long	0xc7
	.uleb128 0x3
	.byte	0x91
	.sleb128 -148
	.uleb128 0x1b
	.string	"iy"
	.byte	0x1
	.byte	0xc8
	.byte	0x9
	.long	0xc7
	.uleb128 0x3
	.byte	0x91
	.sleb128 -152
	.uleb128 0x1b
	.string	"vel"
	.byte	0x1
	.byte	0xc7
	.byte	0x7
	.long	0x6ac
	.uleb128 0x3
	.byte	0x91
	.sleb128 -160
	.uleb128 0x1c
	.long	.LASF123
	.byte	0x1
	.byte	0xca
	.byte	0x9
	.long	0x62d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x1c
	.long	.LASF124
	.byte	0x1
	.byte	0xcb
	.byte	0x9
	.long	0x6ac
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1c
	.long	.LASF125
	.byte	0x1
	.byte	0xcc
	.byte	0x7
	.long	0xc7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1d
	.string	"rx"
	.byte	0x1
	.byte	0xcd
	.byte	0x9
	.long	0x6ac
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x1d
	.string	"ry"
	.byte	0x1
	.byte	0xcd
	.byte	0x18
	.long	0x6ac
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1d
	.string	"vx"
	.byte	0x1
	.byte	0xce
	.byte	0x9
	.long	0x6ac
	.uleb128 0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x1d
	.string	"vy"
	.byte	0x1
	.byte	0xce
	.byte	0x12
	.long	0x6ac
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x1c
	.long	.LASF126
	.byte	0x1
	.byte	0xcf
	.byte	0x9
	.long	0x6ac
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x1c
	.long	.LASF127
	.byte	0x1
	.byte	0xd0
	.byte	0x9
	.long	0xed
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x1c
	.long	.LASF128
	.byte	0x1
	.byte	0xd1
	.byte	0x8
	.long	0x9b0
	.uleb128 0x3
	.byte	0x91
	.sleb128 -88
	.uleb128 0x1c
	.long	.LASF129
	.byte	0x1
	.byte	0xd2
	.byte	0x9
	.long	0x62d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -136
	.uleb128 0x1e
	.long	.Ldebug_ranges0+0
	.long	0x96a
	.uleb128 0x1c
	.long	.LASF130
	.byte	0x1
	.byte	0xda
	.byte	0xb
	.long	0x6ac
	.uleb128 0x3
	.byte	0x91
	.sleb128 -92
	.uleb128 0x1c
	.long	.LASF131
	.byte	0x1
	.byte	0xdb
	.byte	0x9
	.long	0xc7
	.uleb128 0x3
	.byte	0x91
	.sleb128 -96
	.uleb128 0x1e
	.long	.Ldebug_ranges0+0x30
	.long	0x8b3
	.uleb128 0x1d
	.string	"cmd"
	.byte	0x1
	.byte	0xee
	.byte	0xb
	.long	0xc7
	.uleb128 0x3
	.byte	0x91
	.sleb128 -100
	.byte	0
	.uleb128 0x1f
	.quad	.LBB8
	.quad	.LBE8-.LBB8
	.long	0x8da
	.uleb128 0x20
	.long	.LASF132
	.byte	0x1
	.value	0x11c
	.byte	0xb
	.long	0xc7
	.uleb128 0x3
	.byte	0x91
	.sleb128 -104
	.byte	0
	.uleb128 0x1f
	.quad	.LBB9
	.quad	.LBE9-.LBB9
	.long	0x901
	.uleb128 0x20
	.long	.LASF133
	.byte	0x1
	.value	0x120
	.byte	0xb
	.long	0xc7
	.uleb128 0x3
	.byte	0x91
	.sleb128 -108
	.byte	0
	.uleb128 0x1f
	.quad	.LBB10
	.quad	.LBE10-.LBB10
	.long	0x937
	.uleb128 0x20
	.long	.LASF134
	.byte	0x1
	.value	0x127
	.byte	0xd
	.long	0x6ac
	.uleb128 0x2
	.byte	0x91
	.sleb128 -60
	.uleb128 0x20
	.long	.LASF135
	.byte	0x1
	.value	0x128
	.byte	0xd
	.long	0x6ac
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.byte	0
	.uleb128 0x21
	.quad	.LBB11
	.quad	.LBE11-.LBB11
	.uleb128 0x22
	.string	"ix"
	.byte	0x1
	.value	0x133
	.byte	0xb
	.long	0xc7
	.uleb128 0x3
	.byte	0x91
	.sleb128 -112
	.uleb128 0x22
	.string	"iy"
	.byte	0x1
	.value	0x134
	.byte	0xb
	.long	0xc7
	.uleb128 0x3
	.byte	0x91
	.sleb128 -116
	.byte	0
	.byte	0
	.uleb128 0x21
	.quad	.LBB14
	.quad	.LBE14-.LBB14
	.uleb128 0x20
	.long	.LASF136
	.byte	0x1
	.value	0x139
	.byte	0x9
	.long	0xc7
	.uleb128 0x3
	.byte	0x91
	.sleb128 -68
	.uleb128 0x20
	.long	.LASF128
	.byte	0x1
	.value	0x13a
	.byte	0xa
	.long	0x9b0
	.uleb128 0x3
	.byte	0x91
	.sleb128 -128
	.uleb128 0x22
	.string	"cmd"
	.byte	0x1
	.value	0x13b
	.byte	0x9
	.long	0xc7
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.byte	0
	.byte	0
	.uleb128 0xb
	.byte	0x8
	.long	0xc7
	.uleb128 0x23
	.string	"Kbd"
	.byte	0x1
	.byte	0xb6
	.byte	0x5
	.long	0xc7
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0x9f6
	.uleb128 0x24
	.long	.LASF137
	.byte	0x1
	.byte	0xb6
	.byte	0xf
	.long	0x62d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x1d
	.string	"ch"
	.byte	0x1
	.byte	0xb8
	.byte	0x7
	.long	0xc7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.uleb128 0x1a
	.long	.LASF139
	.byte	0x1
	.byte	0x65
	.byte	0x5
	.long	0xc7
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0xb11
	.uleb128 0x1b
	.string	"x"
	.byte	0x1
	.byte	0x66
	.byte	0x5
	.long	0xc7
	.uleb128 0x3
	.byte	0x91
	.sleb128 -68
	.uleb128 0x1b
	.string	"y"
	.byte	0x1
	.byte	0x66
	.byte	0x8
	.long	0xc7
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x1b
	.string	"vel"
	.byte	0x1
	.byte	0x67
	.byte	0x7
	.long	0x6ac
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x1d
	.string	"rx"
	.byte	0x1
	.byte	0x69
	.byte	0x9
	.long	0x6ac
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1d
	.string	"ry"
	.byte	0x1
	.byte	0x6a
	.byte	0x9
	.long	0x6ac
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1d
	.string	"vx"
	.byte	0x1
	.byte	0x6b
	.byte	0x9
	.long	0x6ac
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x1d
	.string	"vy"
	.byte	0x1
	.byte	0x6c
	.byte	0x9
	.long	0x6ac
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x21
	.quad	.LBB3
	.quad	.LBE3-.LBB3
	.uleb128 0x1c
	.long	.LASF126
	.byte	0x1
	.byte	0x72
	.byte	0xb
	.long	0x6ac
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x1f
	.quad	.LBB4
	.quad	.LBE4-.LBB4
	.long	0xad0
	.uleb128 0x1c
	.long	.LASF134
	.byte	0x1
	.byte	0x86
	.byte	0xd
	.long	0x6ac
	.uleb128 0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x1c
	.long	.LASF135
	.byte	0x1
	.byte	0x87
	.byte	0xd
	.long	0x6ac
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.byte	0
	.uleb128 0x21
	.quad	.LBB5
	.quad	.LBE5-.LBB5
	.uleb128 0x1c
	.long	.LASF129
	.byte	0x1
	.byte	0xa4
	.byte	0xd
	.long	0x62d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x1c
	.long	.LASF131
	.byte	0x1
	.byte	0xa5
	.byte	0xb
	.long	0xc7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x1c
	.long	.LASF140
	.byte	0x1
	.byte	0xa6
	.byte	0xb
	.long	0xc7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -60
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	.LASF141
	.byte	0x1
	.byte	0x40
	.byte	0x6
	.long	0xc7
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0xbb1
	.uleb128 0x24
	.long	.LASF142
	.byte	0x1
	.byte	0x41
	.byte	0x5
	.long	0xc7
	.uleb128 0x3
	.byte	0x91
	.sleb128 -68
	.uleb128 0x1b
	.string	"Vel"
	.byte	0x1
	.byte	0x42
	.byte	0x7
	.long	0x734
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x1c
	.long	.LASF143
	.byte	0x1
	.byte	0x44
	.byte	0x7
	.long	0xc7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x1d
	.string	"req"
	.byte	0x1
	.byte	0x45
	.byte	0xc
	.long	0xbb1
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x1c
	.long	.LASF129
	.byte	0x1
	.byte	0x46
	.byte	0x9
	.long	0x62d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x1d
	.string	"vel"
	.byte	0x1
	.byte	0x47
	.byte	0x9
	.long	0x6ac
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x21
	.quad	.LBB2
	.quad	.LBE2-.LBB2
	.uleb128 0x1c
	.long	.LASF144
	.byte	0x1
	.byte	0x4d
	.byte	0xb
	.long	0x6ac
	.uleb128 0x2
	.byte	0x91
	.sleb128 -52
	.byte	0
	.byte	0
	.uleb128 0xb
	.byte	0x8
	.long	0x6a0
	.uleb128 0x25
	.long	.LASF145
	.byte	0x1
	.byte	0x1c
	.byte	0x5
	.long	0xc7
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0xc25
	.uleb128 0x24
	.long	.LASF146
	.byte	0x1
	.byte	0x1c
	.byte	0xf
	.long	0xc7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x24
	.long	.LASF147
	.byte	0x1
	.byte	0x1c
	.byte	0x1c
	.long	0xc25
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x1c
	.long	.LASF148
	.byte	0x1
	.byte	0x1e
	.byte	0x9
	.long	0x62d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1c
	.long	.LASF121
	.byte	0x1
	.byte	0x1f
	.byte	0x7
	.long	0xc7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x1d
	.string	"vel"
	.byte	0x1
	.byte	0x20
	.byte	0x9
	.long	0x734
	.uleb128 0x2
	.byte	0x91
	.sleb128 -36
	.byte	0
	.uleb128 0xb
	.byte	0x8
	.long	0xed
	.uleb128 0x26
	.long	.LASF155
	.byte	0x1
	.byte	0x11
	.byte	0x5
	.long	0xc7
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x1d
	.string	"ret"
	.byte	0x1
	.byte	0x13
	.byte	0x7
	.long	0xc7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x21
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.long	0x2c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.quad	.LBB6-.Ltext0
	.quad	.LBE6-.Ltext0
	.quad	.LBB13-.Ltext0
	.quad	.LBE13-.Ltext0
	.quad	0
	.quad	0
	.quad	.LBB7-.Ltext0
	.quad	.LBE7-.Ltext0
	.quad	.LBB12-.Ltext0
	.quad	.LBE12-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF151:
	.string	"/home/pss/CC41B/nsystem64-beta3/games"
.LASF95:
	.string	"ldat"
.LASF37:
	.string	"_shortbuf"
.LASF154:
	.string	"_IO_lock_t"
.LASF0:
	.string	"gp_offset"
.LASF76:
	.string	"_use_keypad"
.LASF53:
	.string	"stderr"
.LASF111:
	.string	"format"
.LASF26:
	.string	"_IO_buf_end"
.LASF79:
	.string	"_regtop"
.LASF70:
	.string	"_leaveok"
.LASF115:
	.string	"signgam"
.LASF24:
	.string	"_IO_write_end"
.LASF5:
	.string	"unsigned int"
.LASF42:
	.string	"_freeres_list"
.LASF18:
	.string	"_flags"
.LASF78:
	.string	"_line"
.LASF30:
	.string	"_markers"
.LASF140:
	.string	"kill"
.LASF138:
	.string	"Climber"
.LASF104:
	.string	"LINES"
.LASF150:
	.string	"game.c"
.LASF124:
	.string	"currtime"
.LASF131:
	.string	"curr_obj"
.LASF109:
	.string	"Task"
.LASF112:
	.string	"Request"
.LASF100:
	.string	"COLORS"
.LASF130:
	.string	"waketime"
.LASF142:
	.string	"nballs"
.LASF63:
	.string	"_maxx"
.LASF62:
	.string	"_maxy"
.LASF71:
	.string	"_scroll"
.LASF108:
	.string	"nTask"
.LASF52:
	.string	"stdout"
.LASF29:
	.string	"_IO_save_end"
.LASF133:
	.string	"nextx"
.LASF132:
	.string	"nexty"
.LASF113:
	.string	"float"
.LASF49:
	.string	"_IO_codecvt"
.LASF136:
	.string	"count"
.LASF74:
	.string	"_immed"
.LASF2:
	.string	"overflow_arg_area"
.LASF106:
	.string	"long long unsigned int"
.LASF93:
	.string	"_pad_right"
.LASF84:
	.string	"_pad"
.LASF137:
	.string	"climber_task"
.LASF55:
	.string	"sys_errlist"
.LASF28:
	.string	"_IO_backup_base"
.LASF105:
	.string	"TABSIZE"
.LASF39:
	.string	"_offset"
.LASF148:
	.string	"ball_gen"
.LASF54:
	.string	"sys_nerr"
.LASF32:
	.string	"_fileno"
.LASF85:
	.string	"_yoffset"
.LASF72:
	.string	"_idlok"
.LASF6:
	.string	"__gnuc_va_list"
.LASF139:
	.string	"Ball"
.LASF65:
	.string	"_begx"
.LASF17:
	.string	"size_t"
.LASF87:
	.string	"pdat"
.LASF69:
	.string	"_clear"
.LASF21:
	.string	"_IO_read_base"
.LASF94:
	.string	"_Bool"
.LASF143:
	.string	"wakeup"
.LASF146:
	.string	"argc"
.LASF51:
	.string	"stdin"
.LASF120:
	.string	"Float"
.LASF134:
	.string	"xpause"
.LASF123:
	.string	"kbd_task"
.LASF15:
	.string	"char"
.LASF116:
	.string	"accy"
.LASF45:
	.string	"_mode"
.LASF48:
	.string	"_IO_marker"
.LASF19:
	.string	"_IO_read_ptr"
.LASF7:
	.string	"va_list"
.LASF22:
	.string	"_IO_write_base"
.LASF107:
	.string	"long long int"
.LASF75:
	.string	"_sync"
.LASF27:
	.string	"_IO_save_base"
.LASF145:
	.string	"nMain"
.LASF90:
	.string	"_pad_top"
.LASF141:
	.string	"BallGen"
.LASF86:
	.string	"attr_t"
.LASF81:
	.string	"_parx"
.LASF82:
	.string	"_pary"
.LASF99:
	.string	"ttytype"
.LASF16:
	.string	"chtype"
.LASF43:
	.string	"_freeres_buf"
.LASF44:
	.string	"__pad5"
.LASF80:
	.string	"_regbottom"
.LASF36:
	.string	"_vtable_offset"
.LASF98:
	.string	"stdscr"
.LASF83:
	.string	"_parent"
.LASF147:
	.string	"argv"
.LASF102:
	.string	"COLS"
.LASF122:
	.string	"curr_ball"
.LASF96:
	.string	"curscr"
.LASF20:
	.string	"_IO_read_end"
.LASF11:
	.string	"short int"
.LASF129:
	.string	"sender"
.LASF91:
	.string	"_pad_left"
.LASF67:
	.string	"_bkgd"
.LASF12:
	.string	"long int"
.LASF128:
	.string	"pcmd"
.LASF66:
	.string	"_attrs"
.LASF97:
	.string	"newscr"
.LASF50:
	.string	"_IO_wide_data"
.LASF135:
	.string	"ypause"
.LASF77:
	.string	"_delay"
.LASF153:
	.string	"__va_list_tag"
.LASF59:
	.string	"_win_st"
.LASF73:
	.string	"_idcok"
.LASF1:
	.string	"fp_offset"
.LASF110:
	.string	"nSem"
.LASF101:
	.string	"COLOR_PAIRS"
.LASF41:
	.string	"_wide_data"
.LASF38:
	.string	"_lock"
.LASF4:
	.string	"long unsigned int"
.LASF117:
	.string	"quit_game"
.LASF34:
	.string	"_old_offset"
.LASF58:
	.string	"_IO_FILE"
.LASF119:
	.string	"rand_sem"
.LASF121:
	.string	"balls"
.LASF3:
	.string	"reg_save_area"
.LASF8:
	.string	"unsigned char"
.LASF127:
	.string	"endmsg"
.LASF23:
	.string	"_IO_write_ptr"
.LASF149:
	.string	"GNU C17 8.3.0 -mtune=generic -march=x86-64 -g"
.LASF40:
	.string	"_codecvt"
.LASF155:
	.string	"myrand"
.LASF13:
	.string	"__off_t"
.LASF10:
	.string	"signed char"
.LASF9:
	.string	"short unsigned int"
.LASF152:
	.string	"__builtin_va_list"
.LASF89:
	.string	"_pad_x"
.LASF88:
	.string	"_pad_y"
.LASF126:
	.string	"pause"
.LASF125:
	.string	"ydir"
.LASF114:
	.string	"double"
.LASF56:
	.string	"acs_map"
.LASF31:
	.string	"_chain"
.LASF47:
	.string	"FILE"
.LASF61:
	.string	"_curx"
.LASF33:
	.string	"_flags2"
.LASF92:
	.string	"_pad_bottom"
.LASF118:
	.string	"climber"
.LASF64:
	.string	"_begy"
.LASF35:
	.string	"_cur_column"
.LASF103:
	.string	"ESCDELAY"
.LASF68:
	.string	"_notimeout"
.LASF144:
	.string	"rand_vel"
.LASF60:
	.string	"_cury"
.LASF14:
	.string	"__off64_t"
.LASF46:
	.string	"_unused2"
.LASF25:
	.string	"_IO_buf_base"
.LASF57:
	.string	"WINDOW"
	.ident	"GCC: (Debian 8.3.0-6) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
