.data
array: .space 40
input: .asciiz "Please insert a element: "
s_res: .asciiz "Second largest value is "
i_res: .asciiz ", found in index "
none: .asciiz "No second largest value."
comma: .asciiz ", "
dot: .asciiz "."

.text
main:
	li $s0, 10                      #size
	la $s1, array
	li $t0, 0
in_loop:
	beq $t0, $s0, find_max
	la $a0, input
	li $v0, 4
	syscall
	li $v0, 5
	syscall

	sll $t1, $t0, 2
	add $t1, $s1, $t1
	sw $v0, 0($t1)
	addi $t0, $t0, 1
	j in_loop

#s2 = max
find_max:
	lw $s2, 0($s1)
	li $t0, 1
max_loop:
	beq $t0, $s0, find_sec
	sll $t1, $t0, 2
	add $t1, $s1, $t1
	lw $t2, 0($t1)
	ble $t2, $s2, max_next
	move $s2, $t2
max_next:
	addi $t0, $t0, 1
	j max_loop

#s3 = second max, s4 = 1 if found
find_sec:
	li $s4, 0
	li $t0, 0
sec_loop:
	beq $t0, $s0, check
	sll $t1, $t0, 2
	add $t1, $s1, $t1
	lw $t2, 0($t1)
	bge $t2, $s2, sec_next          #skip if equal to max
	beq $s4, $0, sec_set            #first candidate
	ble $t2, $s3, sec_next
sec_set:
	move $s3, $t2
	li $s4, 1
sec_next:
	addi $t0, $t0, 1
	j sec_loop

check:
	bne $s4, $0, print
	la $a0, none
	li $v0, 4
	syscall
	j end

print:
	la $a0, s_res
	li $v0, 4
	syscall
	move $a0, $s3
	li $v0, 1
	syscall
	la $a0, i_res
	li $v0, 4
	syscall

	li $t0, 0
	li $t3, 0                       #flag: printed an idx or not
print_idx:
	beq $t0, $s0, end
	sll $t1, $t0, 2
	add $t1, $s1, $t1
	lw $t2, 0($t1)

	bne $t2, $s3, next_idx
	beq $t3, $0, pw_idx             #first idx -> no comma
	la $a0, comma
	li $v0, 4
	syscall
pw_idx:
	move $a0, $t0
	li $v0, 1
	syscall
	li $t3, 1
next_idx:
	addi $t0, $t0, 1
	j print_idx
end:
	la $a0, dot
	li $v0, 4
	syscall
	li $v0, 10
	syscall
