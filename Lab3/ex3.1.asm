.data
zero: .float 0.0
two: .float 2.0
four: .float 4.0

a: .asciiz "Please insert a: "
b: .asciiz "Please insert b: "
c: .asciiz "Please insert c: "
x1: .asciiz "x1 = "
x2: .asciiz "x2 = "
x: .asciiz "There is one solution, x = "
no_real: .asciiz "There is no real solution"
downline: .asciiz "\n"
.text
main:
	la $a0, a
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	mov.s $f20, $f0
	
	la $a0, b
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	mov.s $f21, $f0
	
	la $a0, c
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	mov.s $f22, $f0
	
	l.s $f9, zero
	neg.s $f2, $f21			#-b
	
	#a = 0 -> bx + c = 0
	c.eq.s $f20, $f9
	bc1f quadratic
	c.eq.s $f21, $f9
	bc1t print_no_real		#a = 0 and b = 0
	neg.s $f12, $f22
	div.s $f12, $f12, $f21		#x = -c/b
	j print_only
	
quadratic:
	#delta = b*b - 4ac
	mul.s $f0, $f21, $f21
	mul.s $f1, $f20, $f22
	l.s $f3, four
	mul.s $f1, $f1, $f3
	sub.s $f23, $f0, $f1
	
	#Check for answers
	c.lt.s $f23, $f9
	bc1t print_no_real
	l.s $f4, two
	mul.s $f4, $f4, $f20		#2*a
	c.eq.s $f23, $f9
	bc1f print_two
	div.s $f12, $f2, $f4		#x = -b/2a
	
print_only:
	la $a0, x
	li $v0, 4
	syscall
	add.s $f12, $f12, $f9		#+0.0 avoids printing -0.0
	li $v0, 2
	syscall
	j end

print_two:
	sqrt.s $f1, $f23			#sqrt(delta)
	
	la $a0, x1
	li $v0, 4
	syscall
	sub.s $f12, $f2, $f1		#-b - sqrt(delta)
	div.s $f12, $f12, $f4		#x1
	add.s $f12, $f12, $f9
	li $v0, 2
	syscall
	
	la $a0, downline
	li $v0, 4
	syscall
	
	la $a0, x2
	li $v0, 4
	syscall
	add.s $f12, $f2, $f1		#-b + sqrt(delta)
	div.s $f12, $f12, $f4		#x2
	add.s $f12, $f12, $f9
	li $v0, 2
	syscall
	j end

print_no_real:
	la $a0, no_real
	li $v0, 4
	syscall

end:
	li $v0, 10
	syscall