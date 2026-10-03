.data
array: .space 20
input0: .asciiz "Please input element 0: "
input1: .asciiz "Please input element 1: "
input2: .asciiz "Please input element 2: "
input3: .asciiz "Please input element 3: "
input4: .asciiz "Please input element 4: "
output: .asciiz "Please enter index: "

.text
main:
	la $t1, array

	li $v0, 4
	la $a0, input0
	syscall
	li $v0, 5
	syscall
	sw $v0, 0($t1)

	li $v0, 4
	la $a0, input1
	syscall
	li $v0, 5
	syscall
	sw $v0, 4($t1)

	li $v0, 4
	la $a0, input2
	syscall
	li $v0, 5
	syscall
	sw $v0, 8($t1)

	li $v0, 4
	la $a0, input3
	syscall
	li $v0, 5
	syscall
	sw $v0, 12($t1)

	li $v0, 4
	la $a0, input4
	syscall
	li $v0, 5
	syscall
	sw $v0, 16($t1)

	#get index
	li $v0, 4
	la $a0, output
	syscall
	li $v0, 5
	syscall
	sll $t0, $v0, 2
	add $t1, $t1, $t0
	lw $a0, 0($t1)
	li $v0, 1
	syscall

	li $v0, 10
	syscall
