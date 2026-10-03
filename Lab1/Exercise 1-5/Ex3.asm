# a = t0, b = t1, c = t2, d = t3
.data
a: .asciiz "Insert a: "
b: .asciiz "Insert b: "
c: .asciiz "Insert c: "
d: .asciiz "Insert d: "
f: .asciiz "F = "
remainder: .asciiz ", remainder "
.text
main:
	li $v0, 4
	la $a0, a
	syscall
	li $v0, 5
	syscall
	move $t0, $v0 # A

	li $v0, 4
	la $a0, b
	syscall
	li $v0, 5
	syscall
	move $t1, $v0 # B

	li $v0, 4
	la $a0, c
	syscall
	li $v0, 5
	syscall
	move $t2, $v0 # C

	li $v0, 4
	la $a0, d
	syscall
	li $v0, 5
	syscall
	move $t3, $v0 # D

	addi $t4, $t0, 10
	sub $t5, $t1, $t3
	sll $t6, $t0, 1 #times 2
	sub $t6, $t2, $t6
	mult $t4, $t5
	mflo $t7
	mult $t7, $t6
	mflo $t7

	add $t8, $t0, $t1
	add $t8, $t8, $t2

	div $t7, $t8

	mflo $t7
	mfhi $t8

	li $v0, 4
	la $a0, f
	syscall
	li $v0, 1
	move $a0, $t7
	syscall
	li $v0, 4
	la $a0, remainder
	syscall
	li $v0, 1
	move $a0, $t8
	syscall

	li $v0, 10
	syscall
