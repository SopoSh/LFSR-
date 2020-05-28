.global _lfsr32
_ lfsr32:
       pushl %ebp              #save old %ebp
movl %esp,%ebp          #set %ebp as frame pointer

movl 16(%ebp),%edx      #edx=seed
movl %edx, %eax	     #eax=lfsr=seed
jmp SHIFT:
  SHIFT:
	movl %eax, %ebx         #copies eax into ebx
	shrl $2, %eax           #shift a left by 2
	xorl %eax, %ebx		  #xor of ebx and eax, stored in ebx
	shrl $4, %eax		  #shift a left by 4 (6-2=4)
     xorl %eax, %ebx		  #xor of ebx and eax, stored in ebx
     shrl $1, %eax		  #shift a left by 1 (7-6=1) , eax=lfsr>>7
     xorl %eax, %ebx		  #xor of ebx and eax, stored in ebx
	andl $1, %ebx		  #bit in ebx

	shll $6, %eax		  #eax=lfsr>>1 (7-6=1)
	shll $31, %ebx		  #ebx = lfsr<<31
	or %ebx, %eax		  #eax=final lfsr
END:
  movl %ebp, %esp
  popl %ebp			   #restore ebp
  ret




