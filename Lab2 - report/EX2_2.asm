.data
a: .asciiz "a = "
b: .asciiz "b = "
warning: .asciiz "Invalid input! Please try again.\n"
gcd_str: .asciiz "GCD="
lcm_str: .asciiz ", LCM="

.text
main:
	la $a0, a
	jal get_input
	move $s0, $v0                   #s0 = a

	la $a0, b
	jal get_input
	move $s1, $v0                   #s1 = b

	move $a0, $s0
	move $a1, $s1
	jal gcd
	move $s2, $v0                   #s2 = gcd

	div $s0, $s2
	mflo $t0
	mult $t0, $s1
	mflo $s3                        #s3 = lcm = a / gcd * b

	la $a0, gcd_str
	li $v0, 4
	syscall
	move $a0, $s2
	li $v0, 1
	syscall

	la $a0, lcm_str
	li $v0, 4
	syscall
	move $a0, $s3
	li $v0, 1
	syscall

	li $v0, 10
	syscall

#$a0 = prompt, return $v0 (must be positive)
get_input:
	move $t0, $a0
input_loop:
	move $a0, $t0
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	bgtz $v0, input_done
	la $a0, warning
	li $v0, 4
	syscall
	j input_loop
input_done:
	jr $ra

#$a0 = a, $a1 = b, return $v0 = gcd
gcd:
	bne $a1, $0, gcd_rec
	move $v0, $a0                   #b == 0 -> gcd = a
	jr $ra
gcd_rec:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	div $a0, $a1
	move $a0, $a1                   #a = b
	mfhi $a1                        #b = a % b
	jal gcd

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
