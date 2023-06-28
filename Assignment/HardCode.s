.text
.globl main
main:
    # Printing General Instructions
    li $v0, 4
    la $a0, Instructions
    syscall
    li $t9, 0	#Number of turns played
    li $t4, 0  #Current state of program
    j print_grid

#Taking input
ask_input:
	li $v0, 4
	la $a0, Input_prompt
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	move $t2, $t0
	j verify_input
verify_input:
	slt $t1, $t0, 10
	beq $t1, 0, invalid_input
	slt $t1, $t0, 0
	beq $t1, 1, invalid_input
	mul $t0, $t0, 4
	addi $t0, $t0, -4
	lw $t1, grid($t0)
	bne $t1, 0, invalid_input
	j valid_input
invalid_input:
	li $v0, 4
	la $a0, invalid
	syscall
	j ask_input
valid_input:
	li $s0, 1
	sw $s0, grid($t0)
	li $t1, 10
	mul $t4, $t4, $t1
	add $t4, $t4, $t2
	j give_response
#Processing computer's move
give_response:
	

#Printing
print_grid:
	li $t0, 0
	j print_element
print_element:
	beq $t0, 36, end_print
	lw $t1, grid($t0)
	beq $t1, 0, print__
	beq $t1, 1, print_x
	beq $t1, 2, print_o
print_x:
	li $v0, 4
	la $a0, str_x
	syscall

	addi $t0, $t0, 4
	li $t1, 12
	div $t0, $t1
	mfhi $t1
	beq $t1, 0, print_newline
	bne $t1, 0, print_space
print_o:
	li $v0, 4
	la $a0, str_o
	syscall

	addi $t0, $t0, 4
	li $t1, 12
	div $t0, $t1
	mfhi $t1
	beq $t1, 0, print_newline
	bne $t1, 0, print_space
print__:
	li $v0, 4
	la $a0, str__
	syscall

	addi $t0, $t0, 4
	li $t1, 12
	div $t0, $t1
	mfhi $t1
	beq $t1, 0, print_newline
	bne $t1, 0, print_space
print_newline:
	li $v0, 4
	la $a0, newline
	syscall
	j print_element
print_space:
	li $v0, 4
	la $a0, space
	syscall
	j print_element
end_print:
	j ask_input
end:
    #Exiting
    li $v0, 4
    la $a0, Thanks
    syscall
    li $v0, 10
    syscall
.data
grid: .word 0:9
Instructions: .ascii "------Tic-Tac-Toe------\nInstructions:\n"
            .ascii "1. You play as X and Computer plays as O, first turn is yours\n"
            .ascii "2. The position on the grid are marked as :\n   1 2 3\n   4 5 6\n   7 8 9\n"
            .asciiz "3. On your turn, enter the position no. where you want to place 'X'\nGame starts\n"
space: .asciiz " "
newline: .asciiz "\n"
str_x: .asciiz "X"
str_o: .asciiz "O"
str__: .asciiz "_"
Input_prompt: .asciiz "Enter a position to put 'X': "
invalid: .asciiz "ERROR! That's an invalid position, try again!\n"
Thanks: .asciiz "Hope you enjoyed the game\n"
