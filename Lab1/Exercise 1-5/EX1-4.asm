.data
input: .asciiz  "Please enter a positive integer less than 16: "
output: .asciiz "Its binary form is: "

.text
main:
	li $v0, 4
	la $a0, input
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	li $v0, 4
	la $a0, output
	syscall

	#bit 3
	srl $a0, $t0, 3
	andi $a0, $a0, 1
	li $v0, 1
	syscall
	#bit 2
	srl $a0, $t0, 2
	andi $a0, $a0, 1
	li $v0, 1
	syscall
	#bit 1
	srl $a0, $t0, 1
	andi $a0, $a0, 1
	li $v0, 1
	syscall
	#bit 0
	andi $a0, $t0, 1
	li $v0, 1
	syscall

	li $v0, 10
	syscall
