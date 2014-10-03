.extern cur_ctx
.globl my_yeild 


#ifdef __x86_64__

my_yeild:
	movq    cur_ctx, %rsi
        movq    %rsp, 0(%rsi)
        /* Save the callee saved registers */
	movq    %r12, 8(%rsi)
        movq    %r13, 16(%rsi)
        movq    %r14, 24(%rsi)
        movq    %r15, 32(%rsi)

my_set:
        movq    %rdi, cur_ctx /*argument will be in rdi */
        /* reload the registers */
        movq    0(%rdi), %rsp
        movq    8(%rdi), %r12
        movq    16(%rdi), %r13
        movq    24(%rdi), %r14
        movq    32(%rdi), %r15
        ret

#endif

#ifdef __i386__

my_yeild:
	movl cur_ctx, %eax
	movl 	%esp, 0(%eax)
        /* Save the callee saved registers */
	movl 	%ebx, 4(%eax)
	movl 	%esi, 8(%eax)
	movl 	%edi, 12(%eax)

my_set:
	movl 	4(%esp), %eax /* agrument will be on stack*/
	movl	%eax, cur_ctx
	/* reload the registers */
	movl    0(%eax), %esp
	movl    4(%eax), %ebx
	movl    8(%eax), %esi
	movl    12(%eax), %edi
	ret
#endif
