.text
.globl main


main:

	li $v0, 4
	la $a0, prmpt1
	syscall

	li $v0, 5
	syscall
	move	$t0, $v0

    jal   iBase
    move 	$t2, $v0

    li $v0, 4
	la $a0, prmpt2
	syscall

    li $v0, 1 
	move $a0, $t2
	syscall

    li $v0, 4
	la $a0, linebreak
	syscall

	li $v0, 10
	syscall

iBase:
    bgt		$t0, 1, Fib	
    move 	$v0, $t0	
    jr		$ra 
    
Fib:
    addi	$sp, $sp, -12
    sw		$ra, 0($sp)
    sw		$t0, 4($sp) 
    addi	$t0, $t0, -1
    jal		iBase				
    lw		$t0, 4($sp)		 
    sw		$v0, 8($sp)		
    addi	$t0, $t0, -2
    jal		iBase
    lw		$t1, 8($sp)
    add		$v0, $t1, $v0		
    lw		$ra, 0($sp)
    addi	$sp, $sp, 12 			
    jr		$ra					
        

.data

prmpt1:		.asciiz "n = "
prmpt2:		.asciiz "\nFib(n) = "
linebreak:	.asciiz "\n"	
#This way only able to calculate upto n = .