#Exercise 01

.data
hello: .asciiz "Hello, "
input: .space 50
colon: .asciiz "!"
.text
main:
	#Get name
	li $v0, 8
	la $a0, input
	li $a1, 50
	syscall

	#print
	li $v0, 4
	la $a0, hello
	syscall
	li $v0, 4
	la $a0, input
	syscall
	li $v0, 4
	la $a0, colon
	syscall

	#End
	li $v0, 10
	syscall
