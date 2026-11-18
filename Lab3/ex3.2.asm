.data
two: .float 2.0
siz: .float 6.0
seven: .float 7.0
u: .asciiz "Please insert u: "
v: .asciiz "Please insert v: "
a: .asciiz "Please insert a: "
b: .asciiz "Please insert b: "
c: .asciiz "Please insert c: "
d: .asciiz "Please insert d: "
e: .asciiz "Please insert e: "
error: .asciiz "Cannot calculate: d^4 + e^3 = 0"

# u  ax^6 + bx^5 + cx	 		1		     a(u^7-v^7)    b(u^6-v^6)    c(u^2-v^2)       
# ( ------------------ = ---------- * ( ----------- + ----------- + ----------- )   
# v     d^4 + e^3			 d^4 + e^3	         7             6              2

.text
input:
	la $a0, u
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	mov.s $f6, $f0
	
	la $a0, v
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	mov.s $f7, $f0
	
	la $a0, a
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	mov.s $f1, $f0
	
	la $a0, b
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	mov.s $f2, $f0
	
	la $a0, c
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	mov.s $f3, $f0
	
	la $a0, d
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	mov.s $f4, $f0
	
	la $a0, e
	li $v0, 4
	syscall
	li $v0, 6
	syscall
	mov.s $f5, $f0

calculate:
	mul.s $f8, $f4, $f4
	mul.s $f8, $f8, $f8			#d^4
	mul.s $f9, $f5, $f5
	mul.s $f9, $f9, $f5			#e^3
	add.s $f10, $f8, $f9			#$f10 = d^4 + e^3
	
	mtc1 $zero, $f28			#$f28 = 0.0
	c.eq.s $f10, $f28
	bc1t print_error			#d^4 + e^3 = 0
	
	mul.s $f11, $f6, $f6			#u^2
	mul.s $f12, $f7, $f7			#v^2
	sub.s $f13, $f11, $f12
	mul.s $f14, $f3, $f13
	l.s $f0, two
	div.s $f15, $f14, $f0		#$f15 = c(u^2-v^2)/2
	
	mul.s $f16, $f11, $f11
	mul.s $f16, $f16, $f11		#u^6
	mul.s $f17, $f12, $f12
	mul.s $f17, $f17, $f12		#v^6
	sub.s $f18, $f16, $f17
	mul.s $f19, $f2, $f18
	l.s $f0, siz
	div.s $f20, $f19, $f0		#$f20 = b(u^6-v^6)/6
	
	mul.s $f21, $f16, $f6		#u^7
	mul.s $f22, $f17, $f7		#v^7
	sub.s $f23, $f21, $f22
	mul.s $f24, $f1, $f23
	l.s $f0, seven
	div.s $f25, $f24, $f0		#$f25 = a(u^7-v^7)/7
	
	add.s $f26, $f20, $f15
	add.s $f26, $f26, $f25
	div.s $f27, $f26, $f10
	
	add.s $f12, $f27, $f28		#+0.0 avoids printing -0.0
	li $v0, 2
	syscall
	j end

print_error:
	la $a0, error
	li $v0, 4
	syscall

end:
	li $v0, 10
	syscall