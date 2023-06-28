.text
main:
	li $v0, 4	#Print string
	la $a0, msg1	#Load address of msg1 
	syscall	#syscall (Asking for entering the first number)
	li $v0, 5	#Read Int
	syscall	#syscall (Reads integer entered by user) 
	move $t0, $v0	#store $v0 (given a) in register $t0, $t0 will contain a
	li $v0, 4	#Print string
	la $a0, msg2	#Load address of msg2 
	syscall	#syscall (Asking for entering the second number)
	li $v0, 5	#Read Int
	syscall	#syscall (Reads integer entered by user) 
	move $t1, $v0	#store $v0 (given b) in register $t1, $t1 will contain the given b		
	slt $t2, $t0, $t1	#check if a<b
	beq $t2, 1, swap	#if a<b swap a,b
	beq $t2, 0, calc	#else execute the algorithm
swap:
	move $t2, $t1		#some temp = b
	move $t1, $t0		# b = a
	move $t0, $t2		# a = temp
	j calc			#now execute the GCD algorithm
calc:	
	#Using Euclidean GCD Algorithm
	beq $t1 , 0, end	#if b==0, we have got the answer (in a), go to end to print the result
	div $t2, $t0, $t1	#divide a/b, remainder is stored in HI
	mfhi $t2		#mfhi stores the remainder in t2
	move $t0, $t1		#a = b
	move $t1, $t2		#b = remainder
	jal calc		#loop
end:
	#Give Output
	li $v0, 4	#Print string
	la $a0, msg3	#Load address of msg3
	syscall	#syscall	
	li $v0, 1	#Print int
	move $a0, $t0	#Save a(which is now GCD) in $a0
	syscall	#syscall prints a0
	li $v0, 4	#Print string
	la $a0, msg4	#Load address of msg4
	syscall	#syscall
	li $v0, 10	#Exit
	syscall	#syscall to exit
.data
msg1:	.asciiz	"-------GCD Calculator-------\n   Enter First Number: "
msg2:	.asciiz	"   Enter Second Number: "
msg3:	.asciiz	"GCD of given numbers is : "
msg4:	.asciiz	"\n---------Thank you-----------\n"
