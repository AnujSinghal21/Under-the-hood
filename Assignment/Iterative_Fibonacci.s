.text
.globl main


main:

	li $v0, 4
	la $a0, prmpt1
	syscall

	li $v0, 5
	syscall
	move	$t0,$v0

    li $t3, 0  
    li $t1, 0
    li $t2, 1
    beq		$t0, $zero, Fib0
    beq		$t0, 1, Fib1
    addi	$t0, $t0, -1
    j math

Fib0:

    li $t2, 0
    j printans

Fib1:

    li $t2, 1
    j printans

math:

    beq		$t3, $t0, printans
    move 	$t4, $t2
    add		$t2, $t1, $t2
    move 	$t1, $t4
    addi	$t3, $t3, 1
	j math		
	
printans:

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


.data

prmpt1:		.asciiz "n = "
prmpt2:		.asciiz "\nFib(n) = "
linebreak:	.asciiz "\n"	