	.file	"intmm.c"
	.comm	ima,643204,32
	.comm	imb,643204,32
	.comm	imr,643204,32
	.comm	seed,4,4
	.text
	.globl	Initrand
	.type	Initrand, @function
Initrand:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$74755, seed(%rip)
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	Initrand, .-Initrand
	.globl	Rand
	.type	Rand, @function
Rand:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	seed(%rip), %eax
	imull	$1309, %eax, %eax
	addl	$13849, %eax
	movzwl	%ax, %eax
	movl	%eax, seed(%rip)
	movl	seed(%rip), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	Rand, .-Rand
	.globl	Initmatrix
	.type	Initmatrix, @function
Initmatrix:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$24, %rsp
	movq	%rdi, -24(%rbp)
	movl	$1, -12(%rbp)
	jmp	.L5
.L8:
	movl	$1, -8(%rbp)
	jmp	.L6
.L7:
	movl	$0, %eax
	call	Rand
	movl	%eax, -4(%rbp)
	movl	-12(%rbp), %eax
	cltq
	imulq	$1604, %rax, %rdx
	movq	-24(%rbp), %rax
	leaq	(%rdx,%rax), %rsi
	movl	-4(%rbp), %ecx
	movl	$-2004318071, %edx
	movl	%ecx, %eax
	imull	%edx
	leal	(%rdx,%rcx), %eax
	sarl	$6, %eax
	movl	%eax, %edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	sall	$3, %eax
	movl	%eax, %edx
	sall	$4, %edx
	subl	%eax, %edx
	movl	%ecx, %eax
	subl	%edx, %eax
	leal	-60(%rax), %edx
	movl	-8(%rbp), %eax
	cltq
	movl	%edx, (%rsi,%rax,4)
	addl	$1, -8(%rbp)
.L6:
	cmpl	$400, -8(%rbp)
	jle	.L7
	addl	$1, -12(%rbp)
.L5:
	cmpl	$400, -12(%rbp)
	jle	.L8
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	Initmatrix, .-Initmatrix
	.globl	Innerproduct
	.type	Innerproduct, @function
Innerproduct:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movl	%ecx, -44(%rbp)
	movl	%r8d, -48(%rbp)
	movq	-24(%rbp), %rax
	movl	$0, (%rax)
	movl	$1, -4(%rbp)
	jmp	.L10
.L11:
	movq	-24(%rbp), %rax
	movl	(%rax), %edx
	movl	-44(%rbp), %eax
	cltq
	imulq	$1604, %rax, %rcx
	movq	-32(%rbp), %rax
	addq	%rax, %rcx
	movl	-4(%rbp), %eax
	cltq
	movl	(%rcx,%rax,4), %ecx
	movl	-4(%rbp), %eax
	cltq
	imulq	$1604, %rax, %rsi
	movq	-40(%rbp), %rax
	addq	%rax, %rsi
	movl	-48(%rbp), %eax
	cltq
	movl	(%rsi,%rax,4), %eax
	imull	%ecx, %eax
	addl	%eax, %edx
	movq	-24(%rbp), %rax
	movl	%edx, (%rax)
	addl	$1, -4(%rbp)
.L10:
	cmpl	$400, -4(%rbp)
	jle	.L11
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	Innerproduct, .-Innerproduct
	.globl	InnerproductPASM
	.type	InnerproductPASM, @function
InnerproductPASM:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -56(%rbp)
	movq	%rsi, -64(%rbp)
	movq	%rdx, -72(%rbp)
	movl	%ecx, -76(%rbp)
	movl	%r8d, -80(%rbp)
	movq	-56(%rbp), %rax
	movl	$0, (%rax)
	movq	-64(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, -16(%rbp)
	movl	-76(%rbp), %eax
	imull	$1604, %eax, %eax
	cltq
	addq	%rax, -24(%rbp)
	movl	-80(%rbp), %eax
	sall	$2, %eax
	cltq
	addq	%rax, -16(%rbp)
	movq	-24(%rbp), %rax
	addq	$1600, %rax
	movq	%rax, -8(%rbp)
.L13:
	addq	$4, -24(%rbp)
	addq	$1604, -16(%rbp)
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movl	%eax, -32(%rbp)
	movl	-36(%rbp), %eax
	imull	-32(%rbp), %eax
	movl	%eax, -28(%rbp)
	movq	-56(%rbp), %rax
	movl	(%rax), %edx
	movl	-28(%rbp), %eax
	addl	%eax, %edx
	movq	-56(%rbp), %rax
	movl	%edx, (%rax)
	movq	-24(%rbp), %rax
	cmpq	-8(%rbp), %rax
	jb	.L13
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	InnerproductPASM, .-InnerproductPASM
	.globl	InnerproductASM
	.type	InnerproductASM, @function
InnerproductASM:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	.cfi_offset 3, -24
	movq	%rdi, -48(%rbp)
	movq	%rsi, -56(%rbp)
	movq	%rdx, -64(%rbp)
	movl	%ecx, -68(%rbp)
	movl	%r8d, -72(%rbp)
	movq	-48(%rbp), %rax
	movl	$0, (%rax)
	movq	-56(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	-64(%rbp), %rax
	movq	%rax, -24(%rbp)
	movl	-68(%rbp), %eax
	imull	$1604, %eax, %eax
	cltq
	addq	%rax, -32(%rbp)
	movl	-72(%rbp), %eax
	sall	$2, %eax
	cltq
	addq	%rax, -24(%rbp)
	movl	$4, -40(%rbp)
	movl	$1604, -36(%rbp)
	movq	-32(%rbp), %rax
	addq	$1600, %rax
	movq	%rax, -16(%rbp)
	movq	-32(%rbp), %rax
	movq	-24(%rbp), %rdx
	movl	-36(%rbp), %edi
	movq	-16(%rbp), %rsi
	movq	%rax, %rbx
	movq	%rdx, %rcx
#APP
# 62 "intmm.c" 1
	inner:add %rbx, 4
	add %rcx,%rdi
	mov %rax, (%rbx)
	mov %r9, (%rcx)
	mul %r9
	add %rdx, %rax
	cmp %rax, %rsi
	jl inner
	
# 0 "" 2
#NO_APP
	movq	-48(%rbp), %rax
	movl	%edx, (%rax)
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	InnerproductASM, .-InnerproductASM
	.section	.rodata
.LC0:
	.string	"%d\n"
	.text
	.globl	Intmm
	.type	Intmm, @function
Intmm:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movl	$0, %eax
	call	Initrand
	movl	$ima, %edi
	call	Initmatrix
	movl	$imb, %edi
	call	Initmatrix
	movl	$1, -8(%rbp)
	jmp	.L16
.L19:
	movl	$1, -4(%rbp)
	jmp	.L17
.L18:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movl	-8(%rbp), %eax
	cltq
	imulq	$401, %rax, %rax
	addq	%rdx, %rax
	salq	$2, %rax
	leaq	imr(%rax), %rdi
	movl	-4(%rbp), %edx
	movl	-8(%rbp), %eax
	movl	%edx, %r8d
	movl	%eax, %ecx
	movl	$imb, %edx
	movl	$ima, %esi
	call	InnerproductASM
	addl	$1, -4(%rbp)
.L17:
	cmpl	$400, -4(%rbp)
	jle	.L18
	addl	$1, -8(%rbp)
.L16:
	cmpl	$400, -8(%rbp)
	jle	.L19
	movl	-20(%rbp), %eax
	leal	1(%rax), %edx
	movl	-20(%rbp), %eax
	addl	$1, %eax
	cltq
	movslq	%edx, %rdx
	imulq	$401, %rdx, %rdx
	addq	%rdx, %rax
	movl	imr(,%rax,4), %eax
	movl	%eax, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	Intmm, .-Intmm
	.globl	main
	.type	main, @function
main:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	jmp	.L21
.L22:
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	Intmm
	addl	$1, -4(%rbp)
.L21:
	cmpl	$9, -4(%rbp)
	jle	.L22
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.8.2-19ubuntu1) 4.8.2"
	.section	.note.GNU-stack,"",@progbits
