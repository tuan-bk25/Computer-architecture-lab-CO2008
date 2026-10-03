.data
array: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
comma: .asciiz ", "
.text
	la $t1, array
	lw $a0, 36($t1)
	li $v0, 1
	syscall
	la $a0, comma
	li $v0, 4
	syscall
	lw $a0, 32($t1)
	li $v0, 1
	syscall
	la $a0, comma
	li $v0, 4
	syscall
	lw $a0, 28($t1)
	li $v0, 1
	syscall
	la $a0, comma
	li $v0, 4
	syscall
	lw $a0, 24($t1)
	li $v0, 1
	syscall
	la $a0, comma
	li $v0, 4
	syscall
	lw $a0, 20($t1)
	li $v0, 1
	syscall
	la $a0, comma
	li $v0, 4
	syscall
	lw $a0, 16($t1)
	li $v0, 1
	syscall
	la $a0, comma
	li $v0, 4
	syscall
	lw $a0, 12($t1)
	li $v0, 1
	syscall
	la $a0, comma
	li $v0, 4
	syscall
	lw $a0, 8($t1)
	li $v0, 1
	syscall
	la $a0, comma
	li $v0, 4
	syscall
	lw $a0, 4($t1)
	li $v0, 1
	syscall
	la $a0, comma
	li $v0, 4
	syscall
	lw $a0, 0($t1)
	li $v0, 1
	syscall

	li $v0, 10
	syscall
