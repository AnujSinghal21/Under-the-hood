.text
main:
	li $v0, 4	#Print string
	la $a0, msg1	#Load address of msg1 
	syscall	#syscall (Asking for entering the value of n)
	li $v0, 5	#Read Int
	syscall	#syscall (Reads integer entered by user) 
	move $t0, $v0	#store $v0 (given n) in register $t0, $t0 will contain the given n
	li $t1, 2	#$t1 will be used as an iterator for loop
	li $t2, 0	#will store Fibonacci no. corresponding to $t1 - 2
	li $t3, 1	#will store Fibonacci no. corresponding to $t1 - 1
	li $t4, 1	#will store Fibonacci no. corresponding to $t1
	j loop		#calling the loop
loop:	
	beq $t1 , $t0, end	#if $t0 == $t1, we have got the answer, go to end to print the result
	addi $t1, $t1, 1	#increment the iterator (i++)
	move $t2, $t3		#$t3 will become new $t2
	move $t3, $t4		#$t4 will become new $t3 
	add $t4, $t2, $t3	#new $t4 (the next Fibonacci no.) = $t2 + $t3
	jal loop		#loop back
end:
	#Give Output
	li $v0, 4	#Print string
	la $a0, msg2	#Load address of msg2
	syscall	#syscall	
	li $v0, 1	#Print int
	move $a0, $t0	#Save n in $a0
	syscall	#syscall prints a0
	li $v0, 4	#Print string
	la $a0, msg3	#Load address of msg3
	syscall	#syscall	
	li $v0, 1	#Print int
	move $a0, $t4	#Save the answer ($t4) in $a0
	syscall	#syscall prints a0
	li $v0, 4	#Print String
	la $a0, msg4	#Load address of msg4
	syscall	#syscall
	li $v0, 10	#Exit
	syscall	#syscall to exit
.data
msg1:	.asciiz	"---Fibonacci Number Calculator---\n   Enter the value of n: "
msg2:	.asciiz	"Fibonacci number for n="
msg3:	.asciiz	" is: "
msg4:	.asciiz	"\n-----------Thank you-------------\n"
