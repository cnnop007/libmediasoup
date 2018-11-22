.file	"poly1305-x86.s"
.text
.align	6,0x90
.globl	_poly1305_init
.align	4
_poly1305_init:
L_poly1305_init_begin:
	pushl	%ebp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	movl	20(%esp),%edi
	movl	24(%esp),%esi
	movl	28(%esp),%ebp
	xorl	%eax,%eax
	movl	%eax,(%edi)
	movl	%eax,4(%edi)
	movl	%eax,8(%edi)
	movl	%eax,12(%edi)
	movl	%eax,16(%edi)
	movl	%eax,20(%edi)
	cmpl	$0,%esi
	je	L000nokey
	call	L001pic_point
L001pic_point:
	popl	%ebx
	leal	_poly1305_blocks-L001pic_point(%ebx),%eax
	leal	_poly1305_emit-L001pic_point(%ebx),%edx
	movl	L_OPENSSL_ia32cap_P$non_lazy_ptr-L001pic_point(%ebx),%edi
	movl	(%edi),%ecx
	andl	$83886080,%ecx
	cmpl	$83886080,%ecx
	jne	L002no_sse2
	leal	__poly1305_blocks_sse2-L001pic_point(%ebx),%eax
	leal	__poly1305_emit_sse2-L001pic_point(%ebx),%edx
	movl	8(%edi),%ecx
	testl	$32,%ecx
	jz	L002no_sse2
	leal	__poly1305_blocks_avx2-L001pic_point(%ebx),%eax
L002no_sse2:
	movl	20(%esp),%edi
	movl	%eax,(%ebp)
	movl	%edx,4(%ebp)
	movl	(%esi),%eax
	movl	4(%esi),%ebx
	movl	8(%esi),%ecx
	movl	12(%esi),%edx
	andl	$268435455,%eax
	andl	$268435452,%ebx
	andl	$268435452,%ecx
	andl	$268435452,%edx
	movl	%eax,24(%edi)
	movl	%ebx,28(%edi)
	movl	%ecx,32(%edi)
	movl	%edx,36(%edi)
	movl	$1,%eax
L000nokey:
	popl	%edi
	popl	%esi
	popl	%ebx
	popl	%ebp
	ret
.globl	_poly1305_blocks
.align	4
_poly1305_blocks:
L_poly1305_blocks_begin:
	pushl	%ebp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	movl	20(%esp),%edi
	movl	24(%esp),%esi
	movl	28(%esp),%ecx
Lenter_blocks:
	andl	$-15,%ecx
	jz	L003nodata
	subl	$64,%esp
	movl	24(%edi),%eax
	movl	28(%edi),%ebx
	leal	(%esi,%ecx,1),%ebp
	movl	32(%edi),%ecx
	movl	36(%edi),%edx
	movl	%ebp,92(%esp)
	movl	%esi,%ebp
	movl	%eax,36(%esp)
	movl	%ebx,%eax
	shrl	$2,%eax
	movl	%ebx,40(%esp)
	addl	%ebx,%eax
	movl	%ecx,%ebx
	shrl	$2,%ebx
	movl	%ecx,44(%esp)
	addl	%ecx,%ebx
	movl	%edx,%ecx
	shrl	$2,%ecx
	movl	%edx,48(%esp)
	addl	%edx,%ecx
	movl	%eax,52(%esp)
	movl	%ebx,56(%esp)
	movl	%ecx,60(%esp)
	movl	(%edi),%eax
	movl	4(%edi),%ebx
	movl	8(%edi),%ecx
	movl	12(%edi),%esi
	movl	16(%edi),%edi
	jmp	L004loop
.align	5,0x90
L004loop:
	addl	(%ebp),%eax
	adcl	4(%ebp),%ebx
	adcl	8(%ebp),%ecx
	adcl	12(%ebp),%esi
	leal	16(%ebp),%ebp
	adcl	96(%esp),%edi
	movl	%eax,(%esp)
	movl	%esi,12(%esp)
	mull	36(%esp)
	movl	%edi,16(%esp)
	movl	%eax,%edi
	movl	%ebx,%eax
	movl	%edx,%esi
	mull	60(%esp)
	addl	%eax,%edi
	movl	%ecx,%eax
	adcl	%edx,%esi
	mull	56(%esp)
	addl	%eax,%edi
	movl	12(%esp),%eax
	adcl	%edx,%esi
	mull	52(%esp)
	addl	%eax,%edi
	movl	(%esp),%eax
	adcl	%edx,%esi
	mull	40(%esp)
	movl	%edi,20(%esp)
	xorl	%edi,%edi
	addl	%eax,%esi
	movl	%ebx,%eax
	adcl	%edx,%edi
	mull	36(%esp)
	addl	%eax,%esi
	movl	%ecx,%eax
	adcl	%edx,%edi
	mull	60(%esp)
	addl	%eax,%esi
	movl	12(%esp),%eax
	adcl	%edx,%edi
	mull	56(%esp)
	addl	%eax,%esi
	movl	16(%esp),%eax
	adcl	%edx,%edi
	imull	52(%esp),%eax
	addl	%eax,%esi
	movl	(%esp),%eax
	adcl	$0,%edi
	mull	44(%esp)
	movl	%esi,24(%esp)
	xorl	%esi,%esi
	addl	%eax,%edi
	movl	%ebx,%eax
	adcl	%edx,%esi
	mull	40(%esp)
	addl	%eax,%edi
	movl	%ecx,%eax
	adcl	%edx,%esi
	mull	36(%esp)
	addl	%eax,%edi
	movl	12(%esp),%eax
	adcl	%edx,%esi
	mull	60(%esp)
	addl	%eax,%edi
	movl	16(%esp),%eax
	adcl	%edx,%esi
	imull	56(%esp),%eax
	addl	%eax,%edi
	movl	(%esp),%eax
	adcl	$0,%esi
	mull	48(%esp)
	movl	%edi,28(%esp)
	xorl	%edi,%edi
	addl	%eax,%esi
	movl	%ebx,%eax
	adcl	%edx,%edi
	mull	44(%esp)
	addl	%eax,%esi
	movl	%ecx,%eax
	adcl	%edx,%edi
	mull	40(%esp)
	addl	%eax,%esi
	movl	12(%esp),%eax
	adcl	%edx,%edi
	mull	36(%esp)
	addl	%eax,%esi
	movl	16(%esp),%ecx
	adcl	%edx,%edi
	movl	%ecx,%edx
	imull	60(%esp),%ecx
	addl	%ecx,%esi
	movl	20(%esp),%eax
	adcl	$0,%edi
	imull	36(%esp),%edx
	addl	%edi,%edx
	movl	24(%esp),%ebx
	movl	28(%esp),%ecx
	movl	%edx,%edi
	shrl	$2,%edx
	andl	$3,%edi
	leal	(%edx,%edx,4),%edx
	addl	%edx,%eax
	adcl	$0,%ebx
	adcl	$0,%ecx
	adcl	$0,%esi
	adcl	$0,%edi
	cmpl	92(%esp),%ebp
	jne	L004loop
	movl	84(%esp),%edx
	addl	$64,%esp
	movl	%eax,(%edx)
	movl	%ebx,4(%edx)
	movl	%ecx,8(%edx)
	movl	%esi,12(%edx)
	movl	%edi,16(%edx)
L003nodata:
	popl	%edi
	popl	%esi
	popl	%ebx
	popl	%ebp
	ret
.globl	_poly1305_emit
.align	4
_poly1305_emit:
L_poly1305_emit_begin:
	pushl	%ebp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	movl	20(%esp),%ebp
Lenter_emit:
	movl	24(%esp),%edi
	movl	(%ebp),%eax
	movl	4(%ebp),%ebx
	movl	8(%ebp),%ecx
	movl	12(%ebp),%edx
	movl	16(%ebp),%esi
	addl	$5,%eax
	adcl	$0,%ebx
	adcl	$0,%ecx
	adcl	$0,%edx
	adcl	$0,%esi
	shrl	$2,%esi
	negl	%esi
	andl	%esi,%eax
	andl	%esi,%ebx
	andl	%esi,%ecx
	andl	%esi,%edx
	movl	%eax,(%edi)
	movl	%ebx,4(%edi)
	movl	%ecx,8(%edi)
	movl	%edx,12(%edi)
	notl	%esi
	movl	(%ebp),%eax
	movl	4(%ebp),%ebx
	movl	8(%ebp),%ecx
	movl	12(%ebp),%edx
	movl	28(%esp),%ebp
	andl	%esi,%eax
	andl	%esi,%ebx
	andl	%esi,%ecx
	andl	%esi,%edx
	orl	(%edi),%eax
	orl	4(%edi),%ebx
	orl	8(%edi),%ecx
	orl	12(%edi),%edx
	addl	(%ebp),%eax
	adcl	4(%ebp),%ebx
	adcl	8(%ebp),%ecx
	adcl	12(%ebp),%edx
	movl	%eax,(%edi)
	movl	%ebx,4(%edi)
	movl	%ecx,8(%edi)
	movl	%edx,12(%edi)
	popl	%edi
	popl	%esi
	popl	%ebx
	popl	%ebp
	ret
.align	5,0x90
.align	4
__poly1305_init_sse2:
	movdqu	24(%edi),%xmm4
	leal	48(%edi),%edi
	movl	%esp,%ebp
	subl	$224,%esp
	andl	$-16,%esp
	movq	64(%ebx),%xmm7
	movdqa	%xmm4,%xmm0
	movdqa	%xmm4,%xmm1
	movdqa	%xmm4,%xmm2
	pand	%xmm7,%xmm0
	psrlq	$26,%xmm1
	psrldq	$6,%xmm2
	pand	%xmm7,%xmm1
	movdqa	%xmm2,%xmm3
	psrlq	$4,%xmm2
	psrlq	$30,%xmm3
	pand	%xmm7,%xmm2
	pand	%xmm7,%xmm3
	psrldq	$13,%xmm4
	leal	144(%esp),%edx
	movl	$2,%ecx
L005square:
	movdqa	%xmm0,(%esp)
	movdqa	%xmm1,16(%esp)
	movdqa	%xmm2,32(%esp)
	movdqa	%xmm3,48(%esp)
	movdqa	%xmm4,64(%esp)
	movdqa	%xmm1,%xmm6
	movdqa	%xmm2,%xmm5
	pslld	$2,%xmm6
	pslld	$2,%xmm5
	paddd	%xmm1,%xmm6
	paddd	%xmm2,%xmm5
	movdqa	%xmm6,80(%esp)
	movdqa	%xmm5,96(%esp)
	movdqa	%xmm3,%xmm6
	movdqa	%xmm4,%xmm5
	pslld	$2,%xmm6
	pslld	$2,%xmm5
	paddd	%xmm3,%xmm6
	paddd	%xmm4,%xmm5
	movdqa	%xmm6,112(%esp)
	movdqa	%xmm5,128(%esp)
	pshufd	$68,%xmm0,%xmm6
	movdqa	%xmm1,%xmm5
	pshufd	$68,%xmm1,%xmm1
	pshufd	$68,%xmm2,%xmm2
	pshufd	$68,%xmm3,%xmm3
	pshufd	$68,%xmm4,%xmm4
	movdqa	%xmm6,(%edx)
	movdqa	%xmm1,16(%edx)
	movdqa	%xmm2,32(%edx)
	movdqa	%xmm3,48(%edx)
	movdqa	%xmm4,64(%edx)
	pmuludq	%xmm0,%xmm4
	pmuludq	%xmm0,%xmm3
	pmuludq	%xmm0,%xmm2
	pmuludq	%xmm0,%xmm1
	pmuludq	%xmm6,%xmm0
	movdqa	%xmm5,%xmm6
	pmuludq	48(%edx),%xmm5
	movdqa	%xmm6,%xmm7
	pmuludq	32(%edx),%xmm6
	paddq	%xmm5,%xmm4
	movdqa	%xmm7,%xmm5
	pmuludq	16(%edx),%xmm7
	paddq	%xmm6,%xmm3
	movdqa	80(%esp),%xmm6
	pmuludq	(%edx),%xmm5
	paddq	%xmm7,%xmm2
	pmuludq	64(%edx),%xmm6
	movdqa	32(%esp),%xmm7
	paddq	%xmm5,%xmm1
	movdqa	%xmm7,%xmm5
	pmuludq	32(%edx),%xmm7
	paddq	%xmm6,%xmm0
	movdqa	%xmm5,%xmm6
	pmuludq	16(%edx),%xmm5
	paddq	%xmm7,%xmm4
	movdqa	96(%esp),%xmm7
	pmuludq	(%edx),%xmm6
	paddq	%xmm5,%xmm3
	movdqa	%xmm7,%xmm5
	pmuludq	64(%edx),%xmm7
	paddq	%xmm6,%xmm2
	pmuludq	48(%edx),%xmm5
	movdqa	48(%esp),%xmm6
	paddq	%xmm7,%xmm1
	movdqa	%xmm6,%xmm7
	pmuludq	16(%edx),%xmm6
	paddq	%xmm5,%xmm0
	movdqa	112(%esp),%xmm5
	pmuludq	(%edx),%xmm7
	paddq	%xmm6,%xmm4
	movdqa	%xmm5,%xmm6
	pmuludq	64(%edx),%xmm5
	paddq	%xmm7,%xmm3
	movdqa	%xmm6,%xmm7
	pmuludq	48(%edx),%xmm6
	paddq	%xmm5,%xmm2
	pmuludq	32(%edx),%xmm7
	movdqa	64(%esp),%xmm5
	paddq	%xmm6,%xmm1
	movdqa	128(%esp),%xmm6
	pmuludq	(%edx),%xmm5
	paddq	%xmm7,%xmm0
	movdqa	%xmm6,%xmm7
	pmuludq	64(%edx),%xmm6
	paddq	%xmm5,%xmm4
	movdqa	%xmm7,%xmm5
	pmuludq	16(%edx),%xmm7
	paddq	%xmm6,%xmm3
	movdqa	%xmm5,%xmm6
	pmuludq	32(%edx),%xmm5
	paddq	%xmm7,%xmm0
	pmuludq	48(%edx),%xmm6
	movdqa	64(%ebx),%xmm7
	paddq	%xmm5,%xmm1
	paddq	%xmm6,%xmm2
	movdqa	%xmm3,%xmm5
	pand	%xmm7,%xmm3
	psrlq	$26,%xmm5
	paddq	%xmm4,%xmm5
	movdqa	%xmm0,%xmm6
	pand	%xmm7,%xmm0
	psrlq	$26,%xmm6
	movdqa	%xmm5,%xmm4
	paddq	%xmm1,%xmm6
	psrlq	$26,%xmm5
	pand	%xmm7,%xmm4
	movdqa	%xmm6,%xmm1
	psrlq	$26,%xmm6
	paddd	%xmm5,%xmm0
	psllq	$2,%xmm5
	paddq	%xmm2,%xmm6
	paddq	%xmm0,%xmm5
	pand	%xmm7,%xmm1
	movdqa	%xmm6,%xmm2
	psrlq	$26,%xmm6
	pand	%xmm7,%xmm2
	paddd	%xmm3,%xmm6
	movdqa	%xmm5,%xmm0
	psrlq	$26,%xmm5
	movdqa	%xmm6,%xmm3
	psrlq	$26,%xmm6
	pand	%xmm7,%xmm0
	paddd	%xmm5,%xmm1
	pand	%xmm7,%xmm3
	paddd	%xmm6,%xmm4
	decl	%ecx
	jz	L006square_break
	punpcklqdq	(%esp),%xmm0
	punpcklqdq	16(%esp),%xmm1
	punpcklqdq	32(%esp),%xmm2
	punpcklqdq	48(%esp),%xmm3
	punpcklqdq	64(%esp),%xmm4
	jmp	L005square
L006square_break:
	psllq	$32,%xmm0
	psllq	$32,%xmm1
	psllq	$32,%xmm2
	psllq	$32,%xmm3
	psllq	$32,%xmm4
	por	(%esp),%xmm0
	por	16(%esp),%xmm1
	por	32(%esp),%xmm2
	por	48(%esp),%xmm3
	por	64(%esp),%xmm4
	pshufd	$141,%xmm0,%xmm0
	pshufd	$141,%xmm1,%xmm1
	pshufd	$141,%xmm2,%xmm2
	pshufd	$141,%xmm3,%xmm3
	pshufd	$141,%xmm4,%xmm4
	movdqu	%xmm0,(%edi)
	movdqu	%xmm1,16(%edi)
	movdqu	%xmm2,32(%edi)
	movdqu	%xmm3,48(%edi)
	movdqu	%xmm4,64(%edi)
	movdqa	%xmm1,%xmm6
	movdqa	%xmm2,%xmm5
	pslld	$2,%xmm6
	pslld	$2,%xmm5
	paddd	%xmm1,%xmm6
	paddd	%xmm2,%xmm5
	movdqu	%xmm6,80(%edi)
	movdqu	%xmm5,96(%edi)
	movdqa	%xmm3,%xmm6
	movdqa	%xmm4,%xmm5
	pslld	$2,%xmm6
	pslld	$2,%xmm5
	paddd	%xmm3,%xmm6
	paddd	%xmm4,%xmm5
	movdqu	%xmm6,112(%edi)
	movdqu	%xmm5,128(%edi)
	movl	%ebp,%esp
	leal	-48(%edi),%edi
	ret
.align	5,0x90
.align	4
__poly1305_blocks_sse2:
	pushl	%ebp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	movl	20(%esp),%edi
	movl	24(%esp),%esi
	movl	28(%esp),%ecx
	movl	20(%edi),%eax
	andl	$-16,%ecx
	jz	L007nodata
	cmpl	$64,%ecx
	jae	L008enter_sse2
	testl	%eax,%eax
	jz	Lenter_blocks
.align	4,0x90
L008enter_sse2:
	call	L009pic_point
L009pic_point:
	popl	%ebx
	leal	Lconst_sse2-L009pic_point(%ebx),%ebx
	testl	%eax,%eax
	jnz	L010base2_26
	call	__poly1305_init_sse2
	movl	(%edi),%eax
	movl	3(%edi),%ecx
	movl	6(%edi),%edx
	movl	9(%edi),%esi
	movl	13(%edi),%ebp
	movl	$1,20(%edi)
	shrl	$2,%ecx
	andl	$67108863,%eax
	shrl	$4,%edx
	andl	$67108863,%ecx
	shrl	$6,%esi
	andl	$67108863,%edx
	movd	%eax,%xmm0
	movd	%ecx,%xmm1
	movd	%edx,%xmm2
	movd	%esi,%xmm3
	movd	%ebp,%xmm4
	movl	24(%esp),%esi
	movl	28(%esp),%ecx
	jmp	L011base2_32
.align	4,0x90
L010base2_26:
	movd	(%edi),%xmm0
	movd	4(%edi),%xmm1
	movd	8(%edi),%xmm2
	movd	12(%edi),%xmm3
	movd	16(%edi),%xmm4
	movdqa	64(%ebx),%xmm7
L011base2_32:
	movl	32(%esp),%eax
	movl	%esp,%ebp
	subl	$528,%esp
	andl	$-16,%esp
	leal	48(%edi),%edi
	shll	$24,%eax
	testl	$31,%ecx
	jz	L012even
	movdqu	(%esi),%xmm6
	leal	16(%esi),%esi
	movdqa	%xmm6,%xmm5
	pand	%xmm7,%xmm6
	paddd	%xmm6,%xmm0
	movdqa	%xmm5,%xmm6
	psrlq	$26,%xmm5
	psrldq	$6,%xmm6
	pand	%xmm7,%xmm5
	paddd	%xmm5,%xmm1
	movdqa	%xmm6,%xmm5
	psrlq	$4,%xmm6
	pand	%xmm7,%xmm6
	paddd	%xmm6,%xmm2
	movdqa	%xmm5,%xmm6
	psrlq	$30,%xmm5
	pand	%xmm7,%xmm5
	psrldq	$7,%xmm6
	paddd	%xmm5,%xmm3
	movd	%eax,%xmm5
	paddd	%xmm6,%xmm4
	movd	12(%edi),%xmm6
	paddd	%xmm5,%xmm4
	movdqa	%xmm0,(%esp)
	movdqa	%xmm1,16(%esp)
	movdqa	%xmm2,32(%esp)
	movdqa	%xmm3,48(%esp)
	movdqa	%xmm4,64(%esp)
	pmuludq	%xmm6,%xmm0
	pmuludq	%xmm6,%xmm1
	pmuludq	%xmm6,%xmm2
	movd	28(%edi),%xmm5
	pmuludq	%xmm6,%xmm3
	pmuludq	%xmm6,%xmm4
	movdqa	%xmm5,%xmm6
	pmuludq	48(%esp),%xmm5
	movdqa	%xmm6,%xmm7
	pmuludq	32(%esp),%xmm6
	paddq	%xmm5,%xmm4
	movdqa	%xmm7,%xmm5
	pmuludq	16(%esp),%xmm7
	paddq	%xmm6,%xmm3
	movd	92(%edi),%xmm6
	pmuludq	(%esp),%xmm5
	paddq	%xmm7,%xmm2
	pmuludq	64(%esp),%xmm6
	movd	44(%edi),%xmm7
	paddq	%xmm5,%xmm1
	movdqa	%xmm7,%xmm5
	pmuludq	32(%esp),%xmm7
	paddq	%xmm6,%xmm0
	movdqa	%xmm5,%xmm6
	pmuludq	16(%esp),%xmm5
	paddq	%xmm7,%xmm4
	movd	108(%edi),%xmm7
	pmuludq	(%esp),%xmm6
	paddq	%xmm5,%xmm3
	movdqa	%xmm7,%xmm5
	pmuludq	64(%esp),%xmm7
	paddq	%xmm6,%xmm2
	pmuludq	48(%esp),%xmm5
	movd	60(%edi),%xmm6
	paddq	%xmm7,%xmm1
	movdqa	%xmm6,%xmm7
	pmuludq	16(%esp),%xmm6
	paddq	%xmm5,%xmm0
	movd	124(%edi),%xmm5
	pmuludq	(%esp),%xmm7
	paddq	%xmm6,%xmm4
	movdqa	%xmm5,%xmm6
	pmuludq	64(%esp),%xmm5
	paddq	%xmm7,%xmm3
	movdqa	%xmm6,%xmm7
	pmuludq	48(%esp),%xmm6
	paddq	%xmm5,%xmm2
	pmuludq	32(%esp),%xmm7
	movd	76(%edi),%xmm5
	paddq	%xmm6,%xmm1
	movd	140(%edi),%xmm6
	pmuludq	(%esp),%xmm5
	paddq	%xmm7,%xmm0
	movdqa	%xmm6,%xmm7
	pmuludq	64(%esp),%xmm6
	paddq	%xmm5,%xmm4
	movdqa	%xmm7,%xmm5
	pmuludq	16(%esp),%xmm7
	paddq	%xmm6,%xmm3
	movdqa	%xmm5,%xmm6
	pmuludq	32(%esp),%xmm5
	paddq	%xmm7,%xmm0
	pmuludq	48(%esp),%xmm6
	movdqa	64(%ebx),%xmm7
	paddq	%xmm5,%xmm1
	paddq	%xmm6,%xmm2
	movdqa	%xmm3,%xmm5
	pand	%xmm7,%xmm3
	psrlq	$26,%xmm5
	paddq	%xmm4,%xmm5
	movdqa	%xmm0,%xmm6
	pand	%xmm7,%xmm0
	psrlq	$26,%xmm6
	movdqa	%xmm5,%xmm4
	paddq	%xmm1,%xmm6
	psrlq	$26,%xmm5
	pand	%xmm7,%xmm4
	movdqa	%xmm6,%xmm1
	psrlq	$26,%xmm6
	paddd	%xmm5,%xmm0
	psllq	$2,%xmm5
	paddq	%xmm2,%xmm6
	paddq	%xmm0,%xmm5
	pand	%xmm7,%xmm1
	movdqa	%xmm6,%xmm2
	psrlq	$26,%xmm6
	pand	%xmm7,%xmm2
	paddd	%xmm3,%xmm6
	movdqa	%xmm5,%xmm0
	psrlq	$26,%xmm5
	movdqa	%xmm6,%xmm3
	psrlq	$26,%xmm6
	pand	%xmm7,%xmm0
	paddd	%xmm5,%xmm1
	pand	%xmm7,%xmm3
	paddd	%xmm6,%xmm4
	subl	$16,%ecx
	jz	L013done
L012even:
	leal	384(%esp),%edx
	leal	-32(%esi),%eax
	subl	$64,%ecx
	movdqu	(%edi),%xmm5
	pshufd	$68,%xmm5,%xmm6
	cmovbl	%eax,%esi
	pshufd	$238,%xmm5,%xmm5
	movdqa	%xmm6,(%edx)
	leal	160(%esp),%eax
	movdqu	16(%edi),%xmm6
	movdqa	%xmm5,-144(%edx)
	pshufd	$68,%xmm6,%xmm5
	pshufd	$238,%xmm6,%xmm6
	movdqa	%xmm5,16(%edx)
	movdqu	32(%edi),%xmm5
	movdqa	%xmm6,-128(%edx)
	pshufd	$68,%xmm5,%xmm6
	pshufd	$238,%xmm5,%xmm5
	movdqa	%xmm6,32(%edx)
	movdqu	48(%edi),%xmm6
	movdqa	%xmm5,-112(%edx)
	pshufd	$68,%xmm6,%xmm5
	pshufd	$238,%xmm6,%xmm6
	movdqa	%xmm5,48(%edx)
	movdqu	64(%edi),%xmm5
	movdqa	%xmm6,-96(%edx)
	pshufd	$68,%xmm5,%xmm6
	pshufd	$238,%xmm5,%xmm5
	movdqa	%xmm6,64(%edx)
	movdqu	80(%edi),%xmm6
	movdqa	%xmm5,-80(%edx)
	pshufd	$68,%xmm6,%xmm5
	pshufd	$238,%xmm6,%xmm6
	movdqa	%xmm5,80(%edx)
	movdqu	96(%edi),%xmm5
	movdqa	%xmm6,-64(%edx)
	pshufd	$68,%xmm5,%xmm6
	pshufd	$238,%xmm5,%xmm5
	movdqa	%xmm6,96(%edx)
	movdqu	112(%edi),%xmm6
	movdqa	%xmm5,-48(%edx)
	pshufd	$68,%xmm6,%xmm5
	pshufd	$238,%xmm6,%xmm6
	movdqa	%xmm5,112(%edx)
	movdqu	128(%edi),%xmm5
	movdqa	%xmm6,-32(%edx)
	pshufd	$68,%xmm5,%xmm6
	pshufd	$238,%xmm5,%xmm5
	movdqa	%xmm6,128(%edx)
	movdqa	%xmm5,-16(%edx)
	movdqu	32(%esi),%xmm5
	movdqu	48(%esi),%xmm6
	leal	32(%esi),%esi
	movdqa	%xmm2,112(%esp)
	movdqa	%xmm3,128(%esp)
	movdqa	%xmm4,144(%esp)
	movdqa	%xmm5,%xmm2
	movdqa	%xmm6,%xmm3
	psrldq	$6,%xmm2
	psrldq	$6,%xmm3
	movdqa	%xmm5,%xmm4
	punpcklqdq	%xmm3,%xmm2
	punpckhqdq	%xmm6,%xmm4
	punpcklqdq	%xmm6,%xmm5
	movdqa	%xmm2,%xmm3
	psrlq	$4,%xmm2
	psrlq	$30,%xmm3
	movdqa	%xmm5,%xmm6
	psrlq	$40,%xmm4
	psrlq	$26,%xmm6
	pand	%xmm7,%xmm5
	pand	%xmm7,%xmm6
	pand	%xmm7,%xmm2
	pand	%xmm7,%xmm3
	por	(%ebx),%xmm4
	movdqa	%xmm0,80(%esp)
	movdqa	%xmm1,96(%esp)
	jbe	L014skip_loop
	jmp	L015loop
.align	5,0x90
L015loop:
	movdqa	-144(%edx),%xmm7
	movdqa	%xmm6,16(%eax)
	movdqa	%xmm2,32(%eax)
	movdqa	%xmm3,48(%eax)
	movdqa	%xmm4,64(%eax)
	movdqa	%xmm5,%xmm1
	pmuludq	%xmm7,%xmm5
	movdqa	%xmm6,%xmm0
	pmuludq	%xmm7,%xmm6
	pmuludq	%xmm7,%xmm2
	pmuludq	%xmm7,%xmm3
	pmuludq	%xmm7,%xmm4
	pmuludq	-16(%edx),%xmm0
	movdqa	%xmm1,%xmm7
	pmuludq	-128(%edx),%xmm1
	paddq	%xmm5,%xmm0
	movdqa	%xmm7,%xmm5
	pmuludq	-112(%edx),%xmm7
	paddq	%xmm6,%xmm1
	movdqa	%xmm5,%xmm6
	pmuludq	-96(%edx),%xmm5
	paddq	%xmm7,%xmm2
	movdqa	16(%eax),%xmm7
	pmuludq	-80(%edx),%xmm6
	paddq	%xmm5,%xmm3
	movdqa	%xmm7,%xmm5
	pmuludq	-128(%edx),%xmm7
	paddq	%xmm6,%xmm4
	movdqa	%xmm5,%xmm6
	pmuludq	-112(%edx),%xmm5
	paddq	%xmm7,%xmm2
	movdqa	32(%eax),%xmm7
	pmuludq	-96(%edx),%xmm6
	paddq	%xmm5,%xmm3
	movdqa	%xmm7,%xmm5
	pmuludq	-32(%edx),%xmm7
	paddq	%xmm6,%xmm4
	movdqa	%xmm5,%xmm6
	pmuludq	-16(%edx),%xmm5
	paddq	%xmm7,%xmm0
	movdqa	%xmm6,%xmm7
	pmuludq	-128(%edx),%xmm6
	paddq	%xmm5,%xmm1
	movdqa	48(%eax),%xmm5
	pmuludq	-112(%edx),%xmm7
	paddq	%xmm6,%xmm3
	movdqa	%xmm5,%xmm6
	pmuludq	-48(%edx),%xmm5
	paddq	%xmm7,%xmm4
	movdqa	%xmm6,%xmm7
	pmuludq	-32(%edx),%xmm6
	paddq	%xmm5,%xmm0
	movdqa	%xmm7,%xmm5
	pmuludq	-16(%edx),%xmm7
	paddq	%xmm6,%xmm1
	movdqa	64(%eax),%xmm6
	pmuludq	-128(%edx),%xmm5
	paddq	%xmm7,%xmm2
	movdqa	%xmm6,%xmm7
	pmuludq	-16(%edx),%xmm6
	paddq	%xmm5,%xmm4
	movdqa	%xmm7,%xmm5
	pmuludq	-64(%edx),%xmm7
	paddq	%xmm6,%xmm3
	movdqa	%xmm5,%xmm6
	pmuludq	-48(%edx),%xmm5
	paddq	%xmm7,%xmm0
	movdqa	64(%ebx),%xmm7
	pmuludq	-32(%edx),%xmm6
	paddq	%xmm5,%xmm1
	paddq	%xmm6,%xmm2
	movdqu	-32(%esi),%xmm5
	movdqu	-16(%esi),%xmm6
	leal	32(%esi),%esi
	movdqa	%xmm2,32(%esp)
	movdqa	%xmm3,48(%esp)
	movdqa	%xmm4,64(%esp)
	movdqa	%xmm5,%xmm2
	movdqa	%xmm6,%xmm3
	psrldq	$6,%xmm2
	psrldq	$6,%xmm3
	movdqa	%xmm5,%xmm4
	punpcklqdq	%xmm3,%xmm2
	punpckhqdq	%xmm6,%xmm4
	punpcklqdq	%xmm6,%xmm5
	movdqa	%xmm2,%xmm3
	psrlq	$4,%xmm2
	psrlq	$30,%xmm3
	movdqa	%xmm5,%xmm6
	psrlq	$40,%xmm4
	psrlq	$26,%xmm6
	pand	%xmm7,%xmm5
	pand	%xmm7,%xmm6
	pand	%xmm7,%xmm2
	pand	%xmm7,%xmm3
	por	(%ebx),%xmm4
	leal	-32(%esi),%eax
	subl	$64,%ecx
	paddd	80(%esp),%xmm5
	paddd	96(%esp),%xmm6
	paddd	112(%esp),%xmm2
	paddd	128(%esp),%xmm3
	paddd	144(%esp),%xmm4
	cmovbl	%eax,%esi
	leal	160(%esp),%eax
	movdqa	(%edx),%xmm7
	movdqa	%xmm1,16(%esp)
	movdqa	%xmm6,16(%eax)
	movdqa	%xmm2,32(%eax)
	movdqa	%xmm3,48(%eax)
	movdqa	%xmm4,64(%eax)
	movdqa	%xmm5,%xmm1
	pmuludq	%xmm7,%xmm5
	paddq	%xmm0,%xmm5
	movdqa	%xmm6,%xmm0
	pmuludq	%xmm7,%xmm6
	pmuludq	%xmm7,%xmm2
	pmuludq	%xmm7,%xmm3
	pmuludq	%xmm7,%xmm4
	paddq	16(%esp),%xmm6
	paddq	32(%esp),%xmm2
	paddq	48(%esp),%xmm3
	paddq	64(%esp),%xmm4
	pmuludq	128(%edx),%xmm0
	movdqa	%xmm1,%xmm7
	pmuludq	16(%edx),%xmm1
	paddq	%xmm5,%xmm0
	movdqa	%xmm7,%xmm5
	pmuludq	32(%edx),%xmm7
	paddq	%xmm6,%xmm1
	movdqa	%xmm5,%xmm6
	pmuludq	48(%edx),%xmm5
	paddq	%xmm7,%xmm2
	movdqa	16(%eax),%xmm7
	pmuludq	64(%edx),%xmm6
	paddq	%xmm5,%xmm3
	movdqa	%xmm7,%xmm5
	pmuludq	16(%edx),%xmm7
	paddq	%xmm6,%xmm4
	movdqa	%xmm5,%xmm6
	pmuludq	32(%edx),%xmm5
	paddq	%xmm7,%xmm2
	movdqa	32(%eax),%xmm7
	pmuludq	48(%edx),%xmm6
	paddq	%xmm5,%xmm3
	movdqa	%xmm7,%xmm5
	pmuludq	112(%edx),%xmm7
	paddq	%xmm6,%xmm4
	movdqa	%xmm5,%xmm6
	pmuludq	128(%edx),%xmm5
	paddq	%xmm7,%xmm0
	movdqa	%xmm6,%xmm7
	pmuludq	16(%edx),%xmm6
	paddq	%xmm5,%xmm1
	movdqa	48(%eax),%xmm5
	pmuludq	32(%edx),%xmm7
	paddq	%xmm6,%xmm3
	movdqa	%xmm5,%xmm6
	pmuludq	96(%edx),%xmm5
	paddq	%xmm7,%xmm4
	movdqa	%xmm6,%xmm7
	pmuludq	112(%edx),%xmm6
	paddq	%xmm5,%xmm0
	movdqa	%xmm7,%xmm5
	pmuludq	128(%edx),%xmm7
	paddq	%xmm6,%xmm1
	movdqa	64(%eax),%xmm6
	pmuludq	16(%edx),%xmm5
	paddq	%xmm7,%xmm2
	movdqa	%xmm6,%xmm7
	pmuludq	128(%edx),%xmm6
	paddq	%xmm5,%xmm4
	movdqa	%xmm7,%xmm5
	pmuludq	80(%edx),%xmm7
	paddq	%xmm6,%xmm3
	movdqa	%xmm5,%xmm6
	pmuludq	96(%edx),%xmm5
	paddq	%xmm7,%xmm0
	movdqa	64(%ebx),%xmm7
	pmuludq	112(%edx),%xmm6
	paddq	%xmm5,%xmm1
	paddq	%xmm6,%xmm2
	movdqa	%xmm3,%xmm5
	pand	%xmm7,%xmm3
	psrlq	$26,%xmm5
	paddq	%xmm4,%xmm5
	movdqa	%xmm0,%xmm6
	pand	%xmm7,%xmm0
	psrlq	$26,%xmm6
	movdqa	%xmm5,%xmm4
	paddq	%xmm1,%xmm6
	psrlq	$26,%xmm5
	pand	%xmm7,%xmm4
	movdqa	%xmm6,%xmm1
	psrlq	$26,%xmm6
	paddd	%xmm5,%xmm0
	psllq	$2,%xmm5
	paddq	%xmm2,%xmm6
	paddq	%xmm0,%xmm5
	pand	%xmm7,%xmm1
	movdqa	%xmm6,%xmm2
	psrlq	$26,%xmm6
	pand	%xmm7,%xmm2
	paddd	%xmm3,%xmm6
	movdqa	%xmm5,%xmm0
	psrlq	$26,%xmm5
	movdqa	%xmm6,%xmm3
	psrlq	$26,%xmm6
	pand	%xmm7,%xmm0
	paddd	%xmm5,%xmm1
	pand	%xmm7,%xmm3
	paddd	%xmm6,%xmm4
	movdqu	32(%esi),%xmm5
	movdqu	48(%esi),%xmm6
	leal	32(%esi),%esi
	movdqa	%xmm2,112(%esp)
	movdqa	%xmm3,128(%esp)
	movdqa	%xmm4,144(%esp)
	movdqa	%xmm5,%xmm2
	movdqa	%xmm6,%xmm3
	psrldq	$6,%xmm2
	psrldq	$6,%xmm3
	movdqa	%xmm5,%xmm4
	punpcklqdq	%xmm3,%xmm2
	punpckhqdq	%xmm6,%xmm4
	punpcklqdq	%xmm6,%xmm5
	movdqa	%xmm2,%xmm3
	psrlq	$4,%xmm2
	psrlq	$30,%xmm3
	movdqa	%xmm5,%xmm6
	psrlq	$40,%xmm4
	psrlq	$26,%xmm6
	pand	%xmm7,%xmm5
	pand	%xmm7,%xmm6
	pand	%xmm7,%xmm2
	pand	%xmm7,%xmm3
	por	(%ebx),%xmm4
	movdqa	%xmm0,80(%esp)
	movdqa	%xmm1,96(%esp)
	ja	L015loop
L014skip_loop:
	pshufd	$16,-144(%edx),%xmm7
	addl	$32,%ecx
	jnz	L016long_tail
	paddd	%xmm0,%xmm5
	paddd	%xmm1,%xmm6
	paddd	112(%esp),%xmm2
	paddd	128(%esp),%xmm3
	paddd	144(%esp),%xmm4
L016long_tail:
	movdqa	%xmm5,(%eax)
	movdqa	%xmm6,16(%eax)
	movdqa	%xmm2,32(%eax)
	movdqa	%xmm3,48(%eax)
	movdqa	%xmm4,64(%eax)
	pmuludq	%xmm7,%xmm5
	pmuludq	%xmm7,%xmm6
	pmuludq	%xmm7,%xmm2
	movdqa	%xmm5,%xmm0
	pshufd	$16,-128(%edx),%xmm5
	pmuludq	%xmm7,%xmm3
	movdqa	%xmm6,%xmm1
	pmuludq	%xmm7,%xmm4
	movdqa	%xmm5,%xmm6
	pmuludq	48(%eax),%xmm5
	movdqa	%xmm6,%xmm7
	pmuludq	32(%eax),%xmm6
	paddq	%xmm5,%xmm4
	movdqa	%xmm7,%xmm5
	pmuludq	16(%eax),%xmm7
	paddq	%xmm6,%xmm3
	pshufd	$16,-64(%edx),%xmm6
	pmuludq	(%eax),%xmm5
	paddq	%xmm7,%xmm2
	pmuludq	64(%eax),%xmm6
	pshufd	$16,-112(%edx),%xmm7
	paddq	%xmm5,%xmm1
	movdqa	%xmm7,%xmm5
	pmuludq	32(%eax),%xmm7
	paddq	%xmm6,%xmm0
	movdqa	%xmm5,%xmm6
	pmuludq	16(%eax),%xmm5
	paddq	%xmm7,%xmm4
	pshufd	$16,-48(%edx),%xmm7
	pmuludq	(%eax),%xmm6
	paddq	%xmm5,%xmm3
	movdqa	%xmm7,%xmm5
	pmuludq	64(%eax),%xmm7
	paddq	%xmm6,%xmm2
	pmuludq	48(%eax),%xmm5
	pshufd	$16,-96(%edx),%xmm6
	paddq	%xmm7,%xmm1
	movdqa	%xmm6,%xmm7
	pmuludq	16(%eax),%xmm6
	paddq	%xmm5,%xmm0
	pshufd	$16,-32(%edx),%xmm5
	pmuludq	(%eax),%xmm7
	paddq	%xmm6,%xmm4
	movdqa	%xmm5,%xmm6
	pmuludq	64(%eax),%xmm5
	paddq	%xmm7,%xmm3
	movdqa	%xmm6,%xmm7
	pmuludq	48(%eax),%xmm6
	paddq	%xmm5,%xmm2
	pmuludq	32(%eax),%xmm7
	pshufd	$16,-80(%edx),%xmm5
	paddq	%xmm6,%xmm1
	pshufd	$16,-16(%edx),%xmm6
	pmuludq	(%eax),%xmm5
	paddq	%xmm7,%xmm0
	movdqa	%xmm6,%xmm7
	pmuludq	64(%eax),%xmm6
	paddq	%xmm5,%xmm4
	movdqa	%xmm7,%xmm5
	pmuludq	16(%eax),%xmm7
	paddq	%xmm6,%xmm3
	movdqa	%xmm5,%xmm6
	pmuludq	32(%eax),%xmm5
	paddq	%xmm7,%xmm0
	pmuludq	48(%eax),%xmm6
	movdqa	64(%ebx),%xmm7
	paddq	%xmm5,%xmm1
	paddq	%xmm6,%xmm2
	jz	L017short_tail
	movdqu	-32(%esi),%xmm5
	movdqu	-16(%esi),%xmm6
	leal	32(%esi),%esi
	movdqa	%xmm2,32(%esp)
	movdqa	%xmm3,48(%esp)
	movdqa	%xmm4,64(%esp)
	movdqa	%xmm5,%xmm2
	movdqa	%xmm6,%xmm3
	psrldq	$6,%xmm2
	psrldq	$6,%xmm3
	movdqa	%xmm5,%xmm4
	punpcklqdq	%xmm3,%xmm2
	punpckhqdq	%xmm6,%xmm4
	punpcklqdq	%xmm6,%xmm5
	movdqa	%xmm2,%xmm3
	psrlq	$4,%xmm2
	psrlq	$30,%xmm3
	movdqa	%xmm5,%xmm6
	psrlq	$40,%xmm4
	psrlq	$26,%xmm6
	pand	%xmm7,%xmm5
	pand	%xmm7,%xmm6
	pand	%xmm7,%xmm2
	pand	%xmm7,%xmm3
	por	(%ebx),%xmm4
	pshufd	$16,(%edx),%xmm7
	paddd	80(%esp),%xmm5
	paddd	96(%esp),%xmm6
	paddd	112(%esp),%xmm2
	paddd	128(%esp),%xmm3
	paddd	144(%esp),%xmm4
	movdqa	%xmm5,(%esp)
	pmuludq	%xmm7,%xmm5
	movdqa	%xmm6,16(%esp)
	pmuludq	%xmm7,%xmm6
	paddq	%xmm5,%xmm0
	movdqa	%xmm2,%xmm5
	pmuludq	%xmm7,%xmm2
	paddq	%xmm6,%xmm1
	movdqa	%xmm3,%xmm6
	pmuludq	%xmm7,%xmm3
	paddq	32(%esp),%xmm2
	movdqa	%xmm5,32(%esp)
	pshufd	$16,16(%edx),%xmm5
	paddq	48(%esp),%xmm3
	movdqa	%xmm6,48(%esp)
	movdqa	%xmm4,%xmm6
	pmuludq	%xmm7,%xmm4
	paddq	64(%esp),%xmm4
	movdqa	%xmm6,64(%esp)
	movdqa	%xmm5,%xmm6
	pmuludq	48(%esp),%xmm5
	movdqa	%xmm6,%xmm7
	pmuludq	32(%esp),%xmm6
	paddq	%xmm5,%xmm4
	movdqa	%xmm7,%xmm5
	pmuludq	16(%esp),%xmm7
	paddq	%xmm6,%xmm3
	pshufd	$16,80(%edx),%xmm6
	pmuludq	(%esp),%xmm5
	paddq	%xmm7,%xmm2
	pmuludq	64(%esp),%xmm6
	pshufd	$16,32(%edx),%xmm7
	paddq	%xmm5,%xmm1
	movdqa	%xmm7,%xmm5
	pmuludq	32(%esp),%xmm7
	paddq	%xmm6,%xmm0
	movdqa	%xmm5,%xmm6
	pmuludq	16(%esp),%xmm5
	paddq	%xmm7,%xmm4
	pshufd	$16,96(%edx),%xmm7
	pmuludq	(%esp),%xmm6
	paddq	%xmm5,%xmm3
	movdqa	%xmm7,%xmm5
	pmuludq	64(%esp),%xmm7
	paddq	%xmm6,%xmm2
	pmuludq	48(%esp),%xmm5
	pshufd	$16,48(%edx),%xmm6
	paddq	%xmm7,%xmm1
	movdqa	%xmm6,%xmm7
	pmuludq	16(%esp),%xmm6
	paddq	%xmm5,%xmm0
	pshufd	$16,112(%edx),%xmm5
	pmuludq	(%esp),%xmm7
	paddq	%xmm6,%xmm4
	movdqa	%xmm5,%xmm6
	pmuludq	64(%esp),%xmm5
	paddq	%xmm7,%xmm3
	movdqa	%xmm6,%xmm7
	pmuludq	48(%esp),%xmm6
	paddq	%xmm5,%xmm2
	pmuludq	32(%esp),%xmm7
	pshufd	$16,64(%edx),%xmm5
	paddq	%xmm6,%xmm1
	pshufd	$16,128(%edx),%xmm6
	pmuludq	(%esp),%xmm5
	paddq	%xmm7,%xmm0
	movdqa	%xmm6,%xmm7
	pmuludq	64(%esp),%xmm6
	paddq	%xmm5,%xmm4
	movdqa	%xmm7,%xmm5
	pmuludq	16(%esp),%xmm7
	paddq	%xmm6,%xmm3
	movdqa	%xmm5,%xmm6
	pmuludq	32(%esp),%xmm5
	paddq	%xmm7,%xmm0
	pmuludq	48(%esp),%xmm6
	movdqa	64(%ebx),%xmm7
	paddq	%xmm5,%xmm1
	paddq	%xmm6,%xmm2
L017short_tail:
	pshufd	$78,%xmm4,%xmm6
	pshufd	$78,%xmm3,%xmm5
	paddq	%xmm6,%xmm4
	paddq	%xmm5,%xmm3
	pshufd	$78,%xmm0,%xmm6
	pshufd	$78,%xmm1,%xmm5
	paddq	%xmm6,%xmm0
	paddq	%xmm5,%xmm1
	pshufd	$78,%xmm2,%xmm6
	movdqa	%xmm3,%xmm5
	pand	%xmm7,%xmm3
	psrlq	$26,%xmm5
	paddq	%xmm6,%xmm2
	paddq	%xmm4,%xmm5
	movdqa	%xmm0,%xmm6
	pand	%xmm7,%xmm0
	psrlq	$26,%xmm6
	movdqa	%xmm5,%xmm4
	paddq	%xmm1,%xmm6
	psrlq	$26,%xmm5
	pand	%xmm7,%xmm4
	movdqa	%xmm6,%xmm1
	psrlq	$26,%xmm6
	paddd	%xmm5,%xmm0
	psllq	$2,%xmm5
	paddq	%xmm2,%xmm6
	paddq	%xmm0,%xmm5
	pand	%xmm7,%xmm1
	movdqa	%xmm6,%xmm2
	psrlq	$26,%xmm6
	pand	%xmm7,%xmm2
	paddd	%xmm3,%xmm6
	movdqa	%xmm5,%xmm0
	psrlq	$26,%xmm5
	movdqa	%xmm6,%xmm3
	psrlq	$26,%xmm6
	pand	%xmm7,%xmm0
	paddd	%xmm5,%xmm1
	pand	%xmm7,%xmm3
	paddd	%xmm6,%xmm4
L013done:
	movd	%xmm0,-48(%edi)
	movd	%xmm1,-44(%edi)
	movd	%xmm2,-40(%edi)
	movd	%xmm3,-36(%edi)
	movd	%xmm4,-32(%edi)
	movl	%ebp,%esp
L007nodata:
	popl	%edi
	popl	%esi
	popl	%ebx
	popl	%ebp
	ret
.align	5,0x90
.align	4
__poly1305_emit_sse2:
	pushl	%ebp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	movl	20(%esp),%ebp
	cmpl	$0,20(%ebp)
	je	Lenter_emit
	movl	(%ebp),%eax
	movl	4(%ebp),%edi
	movl	8(%ebp),%ecx
	movl	12(%ebp),%edx
	movl	16(%ebp),%esi
	movl	%edi,%ebx
	shll	$26,%edi
	shrl	$6,%ebx
	addl	%edi,%eax
	movl	%ecx,%edi
	adcl	$0,%ebx
	shll	$20,%edi
	shrl	$12,%ecx
	addl	%edi,%ebx
	movl	%edx,%edi
	adcl	$0,%ecx
	shll	$14,%edi
	shrl	$18,%edx
	addl	%edi,%ecx
	movl	%esi,%edi
	adcl	$0,%edx
	shll	$8,%edi
	shrl	$24,%esi
	addl	%edi,%edx
	adcl	$0,%esi
	movl	%esi,%edi
	andl	$3,%esi
	shrl	$2,%edi
	leal	(%edi,%edi,4),%ebp
	movl	24(%esp),%edi
	addl	%ebp,%eax
	movl	28(%esp),%ebp
	adcl	$0,%ebx
	adcl	$0,%ecx
	adcl	$0,%edx
	adcl	$0,%esi
	movd	%eax,%xmm0
	addl	$5,%eax
	movd	%ebx,%xmm1
	adcl	$0,%ebx
	movd	%ecx,%xmm2
	adcl	$0,%ecx
	movd	%edx,%xmm3
	adcl	$0,%edx
	adcl	$0,%esi
	shrl	$2,%esi
	negl	%esi
	andl	%esi,%eax
	andl	%esi,%ebx
	andl	%esi,%ecx
	andl	%esi,%edx
	movl	%eax,(%edi)
	movd	%xmm0,%eax
	movl	%ebx,4(%edi)
	movd	%xmm1,%ebx
	movl	%ecx,8(%edi)
	movd	%xmm2,%ecx
	movl	%edx,12(%edi)
	movd	%xmm3,%edx
	notl	%esi
	andl	%esi,%eax
	andl	%esi,%ebx
	orl	(%edi),%eax
	andl	%esi,%ecx
	orl	4(%edi),%ebx
	andl	%esi,%edx
	orl	8(%edi),%ecx
	orl	12(%edi),%edx
	addl	(%ebp),%eax
	adcl	4(%ebp),%ebx
	movl	%eax,(%edi)
	adcl	8(%ebp),%ecx
	movl	%ebx,4(%edi)
	adcl	12(%ebp),%edx
	movl	%ecx,8(%edi)
	movl	%edx,12(%edi)
	popl	%edi
	popl	%esi
	popl	%ebx
	popl	%ebp
	ret
.align	5,0x90
.align	4
__poly1305_init_avx2:
	vmovdqu	24(%edi),%xmm4
	leal	48(%edi),%edi
	movl	%esp,%ebp
	subl	$224,%esp
	andl	$-16,%esp
	vmovdqa	64(%ebx),%xmm7
	vpand	%xmm7,%xmm4,%xmm0
	vpsrlq	$26,%xmm4,%xmm1
	vpsrldq	$6,%xmm4,%xmm3
	vpand	%xmm7,%xmm1,%xmm1
	vpsrlq	$4,%xmm3,%xmm2
	vpsrlq	$30,%xmm3,%xmm3
	vpand	%xmm7,%xmm2,%xmm2
	vpand	%xmm7,%xmm3,%xmm3
	vpsrldq	$13,%xmm4,%xmm4
	leal	144(%esp),%edx
	movl	$2,%ecx
L018square:
	vmovdqa	%xmm0,(%esp)
	vmovdqa	%xmm1,16(%esp)
	vmovdqa	%xmm2,32(%esp)
	vmovdqa	%xmm3,48(%esp)
	vmovdqa	%xmm4,64(%esp)
	vpslld	$2,%xmm1,%xmm6
	vpslld	$2,%xmm2,%xmm5
	vpaddd	%xmm1,%xmm6,%xmm6
	vpaddd	%xmm2,%xmm5,%xmm5
	vmovdqa	%xmm6,80(%esp)
	vmovdqa	%xmm5,96(%esp)
	vpslld	$2,%xmm3,%xmm6
	vpslld	$2,%xmm4,%xmm5
	vpaddd	%xmm3,%xmm6,%xmm6
	vpaddd	%xmm4,%xmm5,%xmm5
	vmovdqa	%xmm6,112(%esp)
	vmovdqa	%xmm5,128(%esp)
	vpshufd	$68,%xmm0,%xmm5
	vmovdqa	%xmm1,%xmm6
	vpshufd	$68,%xmm1,%xmm1
	vpshufd	$68,%xmm2,%xmm2
	vpshufd	$68,%xmm3,%xmm3
	vpshufd	$68,%xmm4,%xmm4
	vmovdqa	%xmm5,(%edx)
	vmovdqa	%xmm1,16(%edx)
	vmovdqa	%xmm2,32(%edx)
	vmovdqa	%xmm3,48(%edx)
	vmovdqa	%xmm4,64(%edx)
	vpmuludq	%xmm0,%xmm4,%xmm4
	vpmuludq	%xmm0,%xmm3,%xmm3
	vpmuludq	%xmm0,%xmm2,%xmm2
	vpmuludq	%xmm0,%xmm1,%xmm1
	vpmuludq	%xmm0,%xmm5,%xmm0
	vpmuludq	48(%edx),%xmm6,%xmm5
	vpaddq	%xmm5,%xmm4,%xmm4
	vpmuludq	32(%edx),%xmm6,%xmm7
	vpaddq	%xmm7,%xmm3,%xmm3
	vpmuludq	16(%edx),%xmm6,%xmm5
	vpaddq	%xmm5,%xmm2,%xmm2
	vmovdqa	80(%esp),%xmm7
	vpmuludq	(%edx),%xmm6,%xmm6
	vpaddq	%xmm6,%xmm1,%xmm1
	vmovdqa	32(%esp),%xmm5
	vpmuludq	64(%edx),%xmm7,%xmm7
	vpaddq	%xmm7,%xmm0,%xmm0
	vpmuludq	32(%edx),%xmm5,%xmm6
	vpaddq	%xmm6,%xmm4,%xmm4
	vpmuludq	16(%edx),%xmm5,%xmm7
	vpaddq	%xmm7,%xmm3,%xmm3
	vmovdqa	96(%esp),%xmm6
	vpmuludq	(%edx),%xmm5,%xmm5
	vpaddq	%xmm5,%xmm2,%xmm2
	vpmuludq	64(%edx),%xmm6,%xmm7
	vpaddq	%xmm7,%xmm1,%xmm1
	vmovdqa	48(%esp),%xmm5
	vpmuludq	48(%edx),%xmm6,%xmm6
	vpaddq	%xmm6,%xmm0,%xmm0
	vpmuludq	16(%edx),%xmm5,%xmm7
	vpaddq	%xmm7,%xmm4,%xmm4
	vmovdqa	112(%esp),%xmm6
	vpmuludq	(%edx),%xmm5,%xmm5
	vpaddq	%xmm5,%xmm3,%xmm3
	vpmuludq	64(%edx),%xmm6,%xmm7
	vpaddq	%xmm7,%xmm2,%xmm2
	vpmuludq	48(%edx),%xmm6,%xmm5
	vpaddq	%xmm5,%xmm1,%xmm1
	vmovdqa	64(%esp),%xmm7
	vpmuludq	32(%edx),%xmm6,%xmm6
	vpaddq	%xmm6,%xmm0,%xmm0
	vmovdqa	128(%esp),%xmm5
	vpmuludq	(%edx),%xmm7,%xmm7
	vpaddq	%xmm7,%xmm4,%xmm4
	vpmuludq	64(%edx),%xmm5,%xmm6
	vpaddq	%xmm6,%xmm3,%xmm3
	vpmuludq	16(%edx),%xmm5,%xmm7
	vpaddq	%xmm7,%xmm0,%xmm0
	vpmuludq	32(%edx),%xmm5,%xmm6
	vpaddq	%xmm6,%xmm1,%xmm1
	vmovdqa	64(%ebx),%xmm7
	vpmuludq	48(%edx),%xmm5,%xmm5
	vpaddq	%xmm5,%xmm2,%xmm2
	vpsrlq	$26,%xmm3,%xmm5
	vpand	%xmm7,%xmm3,%xmm3
	vpsrlq	$26,%xmm0,%xmm6
	vpand	%xmm7,%xmm0,%xmm0
	vpaddq	%xmm5,%xmm4,%xmm4
	vpaddq	%xmm6,%xmm1,%xmm1
	vpsrlq	$26,%xmm4,%xmm5
	vpand	%xmm7,%xmm4,%xmm4
	vpsrlq	$26,%xmm1,%xmm6
	vpand	%xmm7,%xmm1,%xmm1
	vpaddq	%xmm6,%xmm2,%xmm2
	vpaddd	%xmm5,%xmm0,%xmm0
	vpsllq	$2,%xmm5,%xmm5
	vpsrlq	$26,%xmm2,%xmm6
	vpand	%xmm7,%xmm2,%xmm2
	vpaddd	%xmm5,%xmm0,%xmm0
	vpaddd	%xmm6,%xmm3,%xmm3
	vpsrlq	$26,%xmm3,%xmm6
	vpsrlq	$26,%xmm0,%xmm5
	vpand	%xmm7,%xmm0,%xmm0
	vpand	%xmm7,%xmm3,%xmm3
	vpaddd	%xmm5,%xmm1,%xmm1
	vpaddd	%xmm6,%xmm4,%xmm4
	decl	%ecx
	jz	L019square_break
	vpunpcklqdq	(%esp),%xmm0,%xmm0
	vpunpcklqdq	16(%esp),%xmm1,%xmm1
	vpunpcklqdq	32(%esp),%xmm2,%xmm2
	vpunpcklqdq	48(%esp),%xmm3,%xmm3
	vpunpcklqdq	64(%esp),%xmm4,%xmm4
	jmp	L018square
L019square_break:
	vpsllq	$32,%xmm0,%xmm0
	vpsllq	$32,%xmm1,%xmm1
	vpsllq	$32,%xmm2,%xmm2
	vpsllq	$32,%xmm3,%xmm3
	vpsllq	$32,%xmm4,%xmm4
	vpor	(%esp),%xmm0,%xmm0
	vpor	16(%esp),%xmm1,%xmm1
	vpor	32(%esp),%xmm2,%xmm2
	vpor	48(%esp),%xmm3,%xmm3
	vpor	64(%esp),%xmm4,%xmm4
	vpshufd	$141,%xmm0,%xmm0
	vpshufd	$141,%xmm1,%xmm1
	vpshufd	$141,%xmm2,%xmm2
	vpshufd	$141,%xmm3,%xmm3
	vpshufd	$141,%xmm4,%xmm4
	vmovdqu	%xmm0,(%edi)
	vmovdqu	%xmm1,16(%edi)
	vmovdqu	%xmm2,32(%edi)
	vmovdqu	%xmm3,48(%edi)
	vmovdqu	%xmm4,64(%edi)
	vpslld	$2,%xmm1,%xmm6
	vpslld	$2,%xmm2,%xmm5
	vpaddd	%xmm1,%xmm6,%xmm6
	vpaddd	%xmm2,%xmm5,%xmm5
	vmovdqu	%xmm6,80(%edi)
	vmovdqu	%xmm5,96(%edi)
	vpslld	$2,%xmm3,%xmm6
	vpslld	$2,%xmm4,%xmm5
	vpaddd	%xmm3,%xmm6,%xmm6
	vpaddd	%xmm4,%xmm5,%xmm5
	vmovdqu	%xmm6,112(%edi)
	vmovdqu	%xmm5,128(%edi)
	movl	%ebp,%esp
	leal	-48(%edi),%edi
	ret
.align	5,0x90
.align	4
__poly1305_blocks_avx2:
	pushl	%ebp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	movl	20(%esp),%edi
	movl	24(%esp),%esi
	movl	28(%esp),%ecx
	movl	20(%edi),%eax
	andl	$-16,%ecx
	jz	L020nodata
	cmpl	$64,%ecx
	jae	L021enter_avx2
	testl	%eax,%eax
	jz	Lenter_blocks
L021enter_avx2:
	vzeroupper
	call	L022pic_point
L022pic_point:
	popl	%ebx
	leal	Lconst_sse2-L022pic_point(%ebx),%ebx
	testl	%eax,%eax
	jnz	L023base2_26
	call	__poly1305_init_avx2
	movl	(%edi),%eax
	movl	3(%edi),%ecx
	movl	6(%edi),%edx
	movl	9(%edi),%esi
	movl	13(%edi),%ebp
	shrl	$2,%ecx
	andl	$67108863,%eax
	shrl	$4,%edx
	andl	$67108863,%ecx
	shrl	$6,%esi
	andl	$67108863,%edx
	movl	%eax,(%edi)
	movl	%ecx,4(%edi)
	movl	%edx,8(%edi)
	movl	%esi,12(%edi)
	movl	%ebp,16(%edi)
	movl	$1,20(%edi)
	movl	24(%esp),%esi
	movl	28(%esp),%ecx
L023base2_26:
	movl	32(%esp),%eax
	movl	%esp,%ebp
	subl	$448,%esp
	andl	$-512,%esp
	vmovdqu	48(%edi),%xmm0
	leal	288(%esp),%edx
	vmovdqu	64(%edi),%xmm1
	vmovdqu	80(%edi),%xmm2
	vmovdqu	96(%edi),%xmm3
	vmovdqu	112(%edi),%xmm4
	leal	48(%edi),%edi
	vpermq	$64,%ymm0,%ymm0
	vpermq	$64,%ymm1,%ymm1
	vpermq	$64,%ymm2,%ymm2
	vpermq	$64,%ymm3,%ymm3
	vpermq	$64,%ymm4,%ymm4
	vpshufd	$200,%ymm0,%ymm0
	vpshufd	$200,%ymm1,%ymm1
	vpshufd	$200,%ymm2,%ymm2
	vpshufd	$200,%ymm3,%ymm3
	vpshufd	$200,%ymm4,%ymm4
	vmovdqa	%ymm0,-128(%edx)
	vmovdqu	80(%edi),%xmm0
	vmovdqa	%ymm1,-96(%edx)
	vmovdqu	96(%edi),%xmm1
	vmovdqa	%ymm2,-64(%edx)
	vmovdqu	112(%edi),%xmm2
	vmovdqa	%ymm3,-32(%edx)
	vmovdqu	128(%edi),%xmm3
	vmovdqa	%ymm4,(%edx)
	vpermq	$64,%ymm0,%ymm0
	vpermq	$64,%ymm1,%ymm1
	vpermq	$64,%ymm2,%ymm2
	vpermq	$64,%ymm3,%ymm3
	vpshufd	$200,%ymm0,%ymm0
	vpshufd	$200,%ymm1,%ymm1
	vpshufd	$200,%ymm2,%ymm2
	vpshufd	$200,%ymm3,%ymm3
	vmovdqa	%ymm0,32(%edx)
	vmovd	-48(%edi),%xmm0
	vmovdqa	%ymm1,64(%edx)
	vmovd	-44(%edi),%xmm1
	vmovdqa	%ymm2,96(%edx)
	vmovd	-40(%edi),%xmm2
	vmovdqa	%ymm3,128(%edx)
	vmovd	-36(%edi),%xmm3
	vmovd	-32(%edi),%xmm4
	vmovdqa	64(%ebx),%ymm7
	negl	%eax
	testl	$63,%ecx
	jz	L024even
	movl	%ecx,%edx
	andl	$-64,%ecx
	andl	$63,%edx
	vmovdqu	(%esi),%xmm5
	cmpl	$32,%edx
	jb	L025one
	vmovdqu	16(%esi),%xmm6
	je	L026two
	vinserti128	$1,32(%esi),%ymm5,%ymm5
	leal	48(%esi),%esi
	leal	8(%ebx),%ebx
	leal	296(%esp),%edx
	jmp	L027tail
L026two:
	leal	32(%esi),%esi
	leal	16(%ebx),%ebx
	leal	304(%esp),%edx
	jmp	L027tail
L025one:
	leal	16(%esi),%esi
	vpxor	%ymm6,%ymm6,%ymm6
	leal	32(%ebx,%eax,8),%ebx
	leal	312(%esp),%edx
	jmp	L027tail
.align	5,0x90
L024even:
	vmovdqu	(%esi),%xmm5
	vmovdqu	16(%esi),%xmm6
	vinserti128	$1,32(%esi),%ymm5,%ymm5
	vinserti128	$1,48(%esi),%ymm6,%ymm6
	leal	64(%esi),%esi
	subl	$64,%ecx
	jz	L027tail
L028loop:
	vmovdqa	%ymm2,64(%esp)
	vpsrldq	$6,%ymm5,%ymm2
	vmovdqa	%ymm0,(%esp)
	vpsrldq	$6,%ymm6,%ymm0
	vmovdqa	%ymm1,32(%esp)
	vpunpckhqdq	%ymm6,%ymm5,%ymm1
	vpunpcklqdq	%ymm6,%ymm5,%ymm5
	vpunpcklqdq	%ymm0,%ymm2,%ymm2
	vpsrlq	$30,%ymm2,%ymm0
	vpsrlq	$4,%ymm2,%ymm2
	vpsrlq	$26,%ymm5,%ymm6
	vpsrlq	$40,%ymm1,%ymm1
	vpand	%ymm7,%ymm2,%ymm2
	vpand	%ymm7,%ymm5,%ymm5
	vpand	%ymm7,%ymm6,%ymm6
	vpand	%ymm7,%ymm0,%ymm0
	vpor	(%ebx),%ymm1,%ymm1
	vpaddq	64(%esp),%ymm2,%ymm2
	vpaddq	(%esp),%ymm5,%ymm5
	vpaddq	32(%esp),%ymm6,%ymm6
	vpaddq	%ymm3,%ymm0,%ymm0
	vpaddq	%ymm4,%ymm1,%ymm1
	vpmuludq	-96(%edx),%ymm2,%ymm3
	vmovdqa	%ymm6,32(%esp)
	vpmuludq	-64(%edx),%ymm2,%ymm4
	vmovdqa	%ymm0,96(%esp)
	vpmuludq	96(%edx),%ymm2,%ymm0
	vmovdqa	%ymm1,128(%esp)
	vpmuludq	128(%edx),%ymm2,%ymm1
	vpmuludq	-128(%edx),%ymm2,%ymm2
	vpmuludq	-32(%edx),%ymm5,%ymm7
	vpaddq	%ymm7,%ymm3,%ymm3
	vpmuludq	(%edx),%ymm5,%ymm6
	vpaddq	%ymm6,%ymm4,%ymm4
	vpmuludq	-128(%edx),%ymm5,%ymm7
	vpaddq	%ymm7,%ymm0,%ymm0
	vmovdqa	32(%esp),%ymm7
	vpmuludq	-96(%edx),%ymm5,%ymm6
	vpaddq	%ymm6,%ymm1,%ymm1
	vpmuludq	-64(%edx),%ymm5,%ymm5
	vpaddq	%ymm5,%ymm2,%ymm2
	vpmuludq	-64(%edx),%ymm7,%ymm6
	vpaddq	%ymm6,%ymm3,%ymm3
	vpmuludq	-32(%edx),%ymm7,%ymm5
	vpaddq	%ymm5,%ymm4,%ymm4
	vpmuludq	128(%edx),%ymm7,%ymm6
	vpaddq	%ymm6,%ymm0,%ymm0
	vmovdqa	96(%esp),%ymm6
	vpmuludq	-128(%edx),%ymm7,%ymm5
	vpaddq	%ymm5,%ymm1,%ymm1
	vpmuludq	-96(%edx),%ymm7,%ymm7
	vpaddq	%ymm7,%ymm2,%ymm2
	vpmuludq	-128(%edx),%ymm6,%ymm5
	vpaddq	%ymm5,%ymm3,%ymm3
	vpmuludq	-96(%edx),%ymm6,%ymm7
	vpaddq	%ymm7,%ymm4,%ymm4
	vpmuludq	64(%edx),%ymm6,%ymm5
	vpaddq	%ymm5,%ymm0,%ymm0
	vmovdqa	128(%esp),%ymm5
	vpmuludq	96(%edx),%ymm6,%ymm7
	vpaddq	%ymm7,%ymm1,%ymm1
	vpmuludq	128(%edx),%ymm6,%ymm6
	vpaddq	%ymm6,%ymm2,%ymm2
	vpmuludq	128(%edx),%ymm5,%ymm7
	vpaddq	%ymm7,%ymm3,%ymm3
	vpmuludq	32(%edx),%ymm5,%ymm6
	vpaddq	%ymm6,%ymm0,%ymm0
	vpmuludq	-128(%edx),%ymm5,%ymm7
	vpaddq	%ymm7,%ymm4,%ymm4
	vmovdqa	64(%ebx),%ymm7
	vpmuludq	64(%edx),%ymm5,%ymm6
	vpaddq	%ymm6,%ymm1,%ymm1
	vpmuludq	96(%edx),%ymm5,%ymm5
	vpaddq	%ymm5,%ymm2,%ymm2
	vpsrlq	$26,%ymm3,%ymm5
	vpand	%ymm7,%ymm3,%ymm3
	vpsrlq	$26,%ymm0,%ymm6
	vpand	%ymm7,%ymm0,%ymm0
	vpaddq	%ymm5,%ymm4,%ymm4
	vpaddq	%ymm6,%ymm1,%ymm1
	vpsrlq	$26,%ymm4,%ymm5
	vpand	%ymm7,%ymm4,%ymm4
	vpsrlq	$26,%ymm1,%ymm6
	vpand	%ymm7,%ymm1,%ymm1
	vpaddq	%ymm6,%ymm2,%ymm2
	vpaddq	%ymm5,%ymm0,%ymm0
	vpsllq	$2,%ymm5,%ymm5
	vpsrlq	$26,%ymm2,%ymm6
	vpand	%ymm7,%ymm2,%ymm2
	vpaddq	%ymm5,%ymm0,%ymm0
	vpaddq	%ymm6,%ymm3,%ymm3
	vpsrlq	$26,%ymm3,%ymm6
	vpsrlq	$26,%ymm0,%ymm5
	vpand	%ymm7,%ymm0,%ymm0
	vpand	%ymm7,%ymm3,%ymm3
	vpaddq	%ymm5,%ymm1,%ymm1
	vpaddq	%ymm6,%ymm4,%ymm4
	vmovdqu	(%esi),%xmm5
	vmovdqu	16(%esi),%xmm6
	vinserti128	$1,32(%esi),%ymm5,%ymm5
	vinserti128	$1,48(%esi),%ymm6,%ymm6
	leal	64(%esi),%esi
	subl	$64,%ecx
	jnz	L028loop
L027tail:
	vmovdqa	%ymm2,64(%esp)
	vpsrldq	$6,%ymm5,%ymm2
	vmovdqa	%ymm0,(%esp)
	vpsrldq	$6,%ymm6,%ymm0
	vmovdqa	%ymm1,32(%esp)
	vpunpckhqdq	%ymm6,%ymm5,%ymm1
	vpunpcklqdq	%ymm6,%ymm5,%ymm5
	vpunpcklqdq	%ymm0,%ymm2,%ymm2
	vpsrlq	$30,%ymm2,%ymm0
	vpsrlq	$4,%ymm2,%ymm2
	vpsrlq	$26,%ymm5,%ymm6
	vpsrlq	$40,%ymm1,%ymm1
	vpand	%ymm7,%ymm2,%ymm2
	vpand	%ymm7,%ymm5,%ymm5
	vpand	%ymm7,%ymm6,%ymm6
	vpand	%ymm7,%ymm0,%ymm0
	vpor	(%ebx),%ymm1,%ymm1
	andl	$-64,%ebx
	vpaddq	64(%esp),%ymm2,%ymm2
	vpaddq	(%esp),%ymm5,%ymm5
	vpaddq	32(%esp),%ymm6,%ymm6
	vpaddq	%ymm3,%ymm0,%ymm0
	vpaddq	%ymm4,%ymm1,%ymm1
	vpmuludq	-92(%edx),%ymm2,%ymm3
	vmovdqa	%ymm6,32(%esp)
	vpmuludq	-60(%edx),%ymm2,%ymm4
	vmovdqa	%ymm0,96(%esp)
	vpmuludq	100(%edx),%ymm2,%ymm0
	vmovdqa	%ymm1,128(%esp)
	vpmuludq	132(%edx),%ymm2,%ymm1
	vpmuludq	-124(%edx),%ymm2,%ymm2
	vpmuludq	-28(%edx),%ymm5,%ymm7
	vpaddq	%ymm7,%ymm3,%ymm3
	vpmuludq	4(%edx),%ymm5,%ymm6
	vpaddq	%ymm6,%ymm4,%ymm4
	vpmuludq	-124(%edx),%ymm5,%ymm7
	vpaddq	%ymm7,%ymm0,%ymm0
	vmovdqa	32(%esp),%ymm7
	vpmuludq	-92(%edx),%ymm5,%ymm6
	vpaddq	%ymm6,%ymm1,%ymm1
	vpmuludq	-60(%edx),%ymm5,%ymm5
	vpaddq	%ymm5,%ymm2,%ymm2
	vpmuludq	-60(%edx),%ymm7,%ymm6
	vpaddq	%ymm6,%ymm3,%ymm3
	vpmuludq	-28(%edx),%ymm7,%ymm5
	vpaddq	%ymm5,%ymm4,%ymm4
	vpmuludq	132(%edx),%ymm7,%ymm6
	vpaddq	%ymm6,%ymm0,%ymm0
	vmovdqa	96(%esp),%ymm6
	vpmuludq	-124(%edx),%ymm7,%ymm5
	vpaddq	%ymm5,%ymm1,%ymm1
	vpmuludq	-92(%edx),%ymm7,%ymm7
	vpaddq	%ymm7,%ymm2,%ymm2
	vpmuludq	-124(%edx),%ymm6,%ymm5
	vpaddq	%ymm5,%ymm3,%ymm3
	vpmuludq	-92(%edx),%ymm6,%ymm7
	vpaddq	%ymm7,%ymm4,%ymm4
	vpmuludq	68(%edx),%ymm6,%ymm5
	vpaddq	%ymm5,%ymm0,%ymm0
	vmovdqa	128(%esp),%ymm5
	vpmuludq	100(%edx),%ymm6,%ymm7
	vpaddq	%ymm7,%ymm1,%ymm1
	vpmuludq	132(%edx),%ymm6,%ymm6
	vpaddq	%ymm6,%ymm2,%ymm2
	vpmuludq	132(%edx),%ymm5,%ymm7
	vpaddq	%ymm7,%ymm3,%ymm3
	vpmuludq	36(%edx),%ymm5,%ymm6
	vpaddq	%ymm6,%ymm0,%ymm0
	vpmuludq	-124(%edx),%ymm5,%ymm7
	vpaddq	%ymm7,%ymm4,%ymm4
	vmovdqa	64(%ebx),%ymm7
	vpmuludq	68(%edx),%ymm5,%ymm6
	vpaddq	%ymm6,%ymm1,%ymm1
	vpmuludq	100(%edx),%ymm5,%ymm5
	vpaddq	%ymm5,%ymm2,%ymm2
	vpsrldq	$8,%ymm4,%ymm5
	vpsrldq	$8,%ymm3,%ymm6
	vpaddq	%ymm5,%ymm4,%ymm4
	vpsrldq	$8,%ymm0,%ymm5
	vpaddq	%ymm6,%ymm3,%ymm3
	vpsrldq	$8,%ymm1,%ymm6
	vpaddq	%ymm5,%ymm0,%ymm0
	vpsrldq	$8,%ymm2,%ymm5
	vpaddq	%ymm6,%ymm1,%ymm1
	vpermq	$2,%ymm4,%ymm6
	vpaddq	%ymm5,%ymm2,%ymm2
	vpermq	$2,%ymm3,%ymm5
	vpaddq	%ymm6,%ymm4,%ymm4
	vpermq	$2,%ymm0,%ymm6
	vpaddq	%ymm5,%ymm3,%ymm3
	vpermq	$2,%ymm1,%ymm5
	vpaddq	%ymm6,%ymm0,%ymm0
	vpermq	$2,%ymm2,%ymm6
	vpaddq	%ymm5,%ymm1,%ymm1
	vpaddq	%ymm6,%ymm2,%ymm2
	vpsrlq	$26,%ymm3,%ymm5
	vpand	%ymm7,%ymm3,%ymm3
	vpsrlq	$26,%ymm0,%ymm6
	vpand	%ymm7,%ymm0,%ymm0
	vpaddq	%ymm5,%ymm4,%ymm4
	vpaddq	%ymm6,%ymm1,%ymm1
	vpsrlq	$26,%ymm4,%ymm5
	vpand	%ymm7,%ymm4,%ymm4
	vpsrlq	$26,%ymm1,%ymm6
	vpand	%ymm7,%ymm1,%ymm1
	vpaddq	%ymm6,%ymm2,%ymm2
	vpaddq	%ymm5,%ymm0,%ymm0
	vpsllq	$2,%ymm5,%ymm5
	vpsrlq	$26,%ymm2,%ymm6
	vpand	%ymm7,%ymm2,%ymm2
	vpaddq	%ymm5,%ymm0,%ymm0
	vpaddq	%ymm6,%ymm3,%ymm3
	vpsrlq	$26,%ymm3,%ymm6
	vpsrlq	$26,%ymm0,%ymm5
	vpand	%ymm7,%ymm0,%ymm0
	vpand	%ymm7,%ymm3,%ymm3
	vpaddq	%ymm5,%ymm1,%ymm1
	vpaddq	%ymm6,%ymm4,%ymm4
	cmpl	$0,%ecx
	je	L029done
	vpshufd	$252,%xmm0,%xmm0
	leal	288(%esp),%edx
	vpshufd	$252,%xmm1,%xmm1
	vpshufd	$252,%xmm2,%xmm2
	vpshufd	$252,%xmm3,%xmm3
	vpshufd	$252,%xmm4,%xmm4
	jmp	L024even
.align	4,0x90
L029done:
	vmovd	%xmm0,-48(%edi)
	vmovd	%xmm1,-44(%edi)
	vmovd	%xmm2,-40(%edi)
	vmovd	%xmm3,-36(%edi)
	vmovd	%xmm4,-32(%edi)
	vzeroupper
	movl	%ebp,%esp
L020nodata:
	popl	%edi
	popl	%esi
	popl	%ebx
	popl	%ebp
	ret
.align	6,0x90
Lconst_sse2:
.long	16777216,0,16777216,0,16777216,0,16777216,0
.long	0,0,0,0,0,0,0,0
.long	67108863,0,67108863,0,67108863,0,67108863,0
.long	268435455,268435452,268435452,268435452
.byte	80,111,108,121,49,51,48,53,32,102,111,114,32,120,56,54
.byte	44,32,67,82,89,80,84,79,71,65,77,83,32,98,121,32
.byte	60,97,112,112,114,111,64,111,112,101,110,115,115,108,46,111
.byte	114,103,62,0
.align	2,0x90
.section __IMPORT,__pointers,non_lazy_symbol_pointers
L_OPENSSL_ia32cap_P$non_lazy_ptr:
.indirect_symbol	_OPENSSL_ia32cap_P
.long	0
.comm	_OPENSSL_ia32cap_P,16,2
