.data
array: .space 20
input: .asciiz "array "
mark: .asciiz " : "
space: .asciiz " "
result: .asciiz "Result: "

.text
main:
	la $a0, array
	li $a1, 5
	jal read_array

	la $a0, array
	li $a1, 5
	jal round_array

	la $a0, result
	li $v0, 4
	syscall
	la $a0, array
	li $a1, 5
	jal print_array

	li $v0, 10
	syscall

#$a0 = address of array, $a1 = size
read_array:
	move $t0, $a0
	li $t1, 0                       #index
read_loop:
	beq $t1, $a1, read_done

	la $a0, input
	li $v0, 4
	syscall
	move $a0, $t1
	li $v0, 1
	syscall
	la $a0, mark
	li $v0, 4
	syscall

	li $v0, 5
	syscall
	sw $v0, 0($t0)

	addi $t0, $t0, 4
	addi $t1, $t1, 1
	j read_loop
read_done:
	jr $ra

#$a0 = address of array, $a1 = size
round_array:
	li $t0, 0                       #index
	li $t5, 3
round_loop:
	beq $t0, $a1, round_done
	lw $t1, 0($a0)
	andi $t2, $t1, 3                #t2 = number % 4
	beq $t2, $0, store              #divisible by 4
	beq $t2, $t5, up                #remainder 3 -> +1
	sub $t1, $t1, $t2               #remainder 1 or 2 -> round down
	j store
up:
	addi $t1, $t1, 1
store:
	sw $t1, 0($a0)
	addi $a0, $a0, 4
	addi $t0, $t0, 1
	j round_loop
round_done:
	jr $ra

#$a0 = address of array, $a1 = size
print_array:
	move $t0, $a0
	li $t1, 0
print_loop:
	beq $t1, $a1, print_done
	lw $a0, 0($t0)
	li $v0, 1
	syscall
	la $a0, space
	li $v0, 4
	syscall
	addi $t0, $t0, 4
	addi $t1, $t1, 1
	j print_loop
print_done:
	jr $ra
