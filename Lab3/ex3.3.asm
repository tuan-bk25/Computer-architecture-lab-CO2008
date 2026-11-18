.data
fin: .asciiz "raw_input.txt"
fout: .asciiz "formatted_result.txt"
buffer: .space 256

header: .asciiz "-----Student personal information-----\n"
l_name: .asciiz "Name: "
l_id: .asciiz "ID: "
l_address: .asciiz "Address: "
l_age: .asciiz "Age: "
l_religion: .asciiz "Religion: "
labels: .word l_name, l_id, l_address, l_age, l_religion
error: .asciiz "Cannot open raw_input.txt"

.text
main:
	#Open raw_input.txt for reading
	li $v0, 13
	la $a0, fin
	li $a1, 0
	li $a2, 0
	syscall
	bltz $v0, open_error
	move $s0, $v0			#file descriptor
	
	#Read the text into buffer
	li $v0, 14
	move $a0, $s0
	la $a1, buffer
	li $a2, 255
	syscall
	move $s1, $v0			#number of bytes read
	
	#Close the file
	li $v0, 16
	move $a0, $s0
	syscall
	
	la $t0, buffer
	add $t0, $t0, $s1
	sb $zero, 0($t0)			#end of text
	
	#Allocate the string in the heap: bytes read + 1
	li $v0, 9
	addi $a0, $s1, 1
	syscall
	move $s2, $v0			#$s2 = string in heap
	
	#Copy the line from buffer to the string (stop at \n, \r or \0)
	la $t0, buffer
	move $t1, $s2
copy:
	lb $t2, 0($t0)
	beqz $t2, copy_done
	beq $t2, 10, copy_done
	beq $t2, 13, copy_done
	sb $t2, 0($t1)
	addi $t0, $t0, 1
	addi $t1, $t1, 1
	j copy
copy_done:
	sb $zero, 0($t1)
	
	#Allocate the output string in the heap
	li $v0, 9
	addi $a0, $s1, 128
	syscall
	move $s3, $v0			#$s3 = output string
	move $t1, $s3			#$t1 = write pointer
	
	la $a0, header
	jal append
	
	#For each field: label, then text up to ',' and a newline
	la $s4, labels
	li $s5, 5
	move $t0, $s2			#$t0 = read pointer in the string
field:
	lw $a0, 0($s4)
	jal append
copy_field:
	lb $t2, 0($t0)
	beqz $t2, field_end
	addi $t0, $t0, 1
	beq $t2, 44, field_end		#44 = ','
	sb $t2, 0($t1)
	addi $t1, $t1, 1
	j copy_field
field_end:
	li $t2, 10
	sb $t2, 0($t1)
	addi $t1, $t1, 1
	addi $s4, $s4, 4
	addi $s5, $s5, -1
	bnez $s5, field
	sb $zero, 0($t1)
	sub $s6, $t1, $s3			#length of the output
	
	#Print to the terminal
	li $v0, 4
	move $a0, $s3
	syscall
	
	#Write to formatted_result.txt
	li $v0, 13
	la $a0, fout
	li $a1, 1
	li $a2, 0
	syscall
	move $s0, $v0
	
	li $v0, 15
	move $a0, $s0
	move $a1, $s3
	move $a2, $s6
	syscall
	
	li $v0, 16
	move $a0, $s0
	syscall

end:
	li $v0, 10
	syscall

open_error:
	li $v0, 4
	la $a0, error
	syscall
	j end

#Append the string at $a0 to the output at $t1
append:
	lb $t3, 0($a0)
	beqz $t3, append_done
	sb $t3, 0($t1)
	addi $a0, $a0, 1
	addi $t1, $t1, 1
	j append
append_done:
	jr $ra