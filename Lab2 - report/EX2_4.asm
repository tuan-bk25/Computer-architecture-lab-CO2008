.data
neg: .asciiz "A factorial for your number can not be found."
big: .asciiz "Number is too big (max is 12)."
input: .asciiz "Please input a number: "

.text
main:
	la $a0, input
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s0, $v0

	bltz $s0, negative
	li $t0, 12
	bgt $s0, $t0, too_big           #13! is over 32 bits

	move $a0, $s0
	jal fact
	move $a0, $v0
	li $v0, 1
	syscall
	j end

negative:
	la $a0, neg
	li $v0, 4
	syscall
	j end

too_big:
	la $a0, big
	li $v0, 4
	syscall

end:
	li $v0, 10
	syscall

#$a0 = n, return $v0 = n!
fact:
	bgtz $a0, fact_rec
	li $v0, 1                       #0! = 1
	jr $ra
fact_rec:
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $a0, 0($sp)

	addi $a0, $a0, -1
	jal fact                        #v0 = (n-1)!

	lw $a0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8

	mult $a0, $v0
	mflo $v0                        #v0 = n * (n-1)!
	jr $ra
