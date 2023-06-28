.text
.globl main
main:
    # Printing General Instructions
    li $v0, 4
    la $a0, Instructions
    syscall
    li $t9, 0	#Number of turns played
    j print_grid

#Taking input
ask_input:
	li $v0, 4
	la $a0, Input_prompt
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
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
	j give_response
#Processing computer's move
give_response:
	addi $t9, $t9, 1
	beq $t9, 9, draw
	j find_best
find_best:
	li $s1, 0
	li $s2, -1000
	li $t0, 0
	j test_position
test_position:
	beq $t0, 36, apply_best_move
	lw $t1, grid($t0)
	bne $t1, 0, call_next_test
	li $s0, 2
	sw $s0, grid($t0)
	li $t7, 0
	li $t8, 0
	j evaluate_move
test_position_2:
	li $s0, 0
	sw $s0, grid($t0)	
	slt $t1, $s2, $t6
	beq $t1, 1, set_as_best
	j call_next_test
set_as_best:
	move $s1, $t0
	move $s2, $t6	
	j call_next_test
evaluate_move:
#stores the result in $t6, uses $t7, $t8 as inputs
	li $t5, 0
	j evaluate_board
evaluate_move_2:
	
	j test_position_2
evaluate_board:
#gives result in $t5
	j e_row_1
e_row_1:
	li $t1, 0
	lw $t2, grid($t1)
	li $t1, 4
	lw $t3, grid($t1)
	beq $t2, $t3, e_row_1_c
	j e_row_2
e_row_1_c:
	li $t1, 8
	lw $t3, grid($t1)
	beq $t2, $t3, e_row_1_e
	j e_row_2
e_row_1_e:
	li $t3, 1
	beq $t2, $t3, board_evaluated_x
	li $t3, 2
	beq $t2, $t3, board_evaluated_o
	j e_row_2
e_row_2:
	li $t1, 12
	lw $t2, grid($t1)
	li $t1, 16
	lw $t3, grid($t1)
	beq $t2, $t3, e_row_2_c
	j e_row_3
e_row_2_c:
	li $t1, 20
	lw $t3, grid($t1)
	beq $t2, $t3, e_row_2_e
	j e_row_3
e_row_2_e:
	li $t3, 1
	beq $t2, $t3, board_evaluated_x
	li $t3, 2
	beq $t2, $t3, board_evaluated_o
	j e_row_3
e_row_3:
	li $t1, 24
	lw $t2, grid($t1)
	li $t1, 28
	lw $t3, grid($t1)
	beq $t2, $t3, e_row_3_c
	j e_col_1
e_row_3_c:
	li $t1, 32
	lw $t3, grid($t1)
	beq $t2, $t3, e_row_3_e
	j e_col_1
e_row_3_e:
	li $t3, 1
	beq $t2, $t3, board_evaluated_x
	li $t3, 2
	beq $t2, $t3, board_evaluated_o
	j e_col_1
e_col_1:
	li $t1, 0
	lw $t2, grid($t1)
	li $t1, 12
	lw $t3, grid($t1)
	beq $t2, $t3, e_col_1_c
	j e_col_2
e_col_1_c:
	li $t1, 24
	lw $t3, grid($t1)
	beq $t2, $t3, e_col_1_e
	j e_col_2
e_col_1_e:
	li $t3, 1
	beq $t2, $t3, board_evaluated_x
	li $t3, 2
	beq $t2, $t3, board_evaluated_o
	j e_col_2
e_col_2:
	li $t1, 4
	lw $t2, grid($t1)
	li $t1, 16
	lw $t3, grid($t1)
	beq $t2, $t3, e_col_2_c
	j e_col_3
e_col_2_c:
	li $t1, 28
	lw $t3, grid($t1)
	beq $t2, $t3, e_col_2_e
	j e_col_3
e_col_2_e:
	li $t3, 1
	beq $t2, $t3, board_evaluated_x
	li $t3, 2
	beq $t2, $t3, board_evaluated_o
	j e_col_3
e_col_3:
	li $t1, 8
	lw $t2, grid($t1)
	li $t1, 20
	lw $t3, grid($t1)
	beq $t2, $t3, e_col_3_c
	j e_dia_1
e_col_3_c:
	li $t1, 32
	lw $t3, grid($t1)
	beq $t2, $t3, e_col_3_e
	j e_dia_1
e_col_3_e:
	li $t3, 1
	beq $t2, $t3, board_evaluated_x
	li $t3, 2
	beq $t2, $t3, board_evaluated_o
	j e_dia_1
e_dia_1:
	li $t1, 0
	lw $t2, grid($t1)
	li $t1, 16
	lw $t3, grid($t1)
	beq $t2, $t3, e_dia_1_c
	j e_dia_2
e_dia_1_c:
	li $t1, 32
	lw $t3, grid($t1)
	beq $t2, $t3, e_dia_1_e
	j e_dia_2
e_dia_1_e:
	li $t3, 1
	beq $t2, $t3, board_evaluated_x
	li $t3, 2
	beq $t2, $t3, board_evaluated_o
	j e_dia_2
e_dia_2:
	li $t1, 8
	lw $t2, grid($t1)
	li $t1, 16
	lw $t3, grid($t1)
	beq $t2, $t3, e_dia_2_c
	j eval_board_exit
e_dia_2_c:
	li $t1, 24
	lw $t3, grid($t1)
	beq $t2, $t3, e_dia_2_e
	j eval_board_exit
e_dia_2_e:
	li $t3, 1
	beq $t2, $t3, board_evaluated_x
	li $t3, 2
	beq $t2, $t3, board_evaluated_o
	j eval_board_exit
eval_board_exit:
	j evaluate_move_2
board_evaluated_x:
	li $t5, -10	
	j evaluate_move_2
board_evaluate_o:
	li $t5, 10
	j evaluate_move_2





call_next_test:
	addi $t0, $t0, 4
	j test_position
apply_best_move:
	move $t0, $s1
	li $t1, 2
	sw $t1, grid($t0)
	j print_grid

	addi $t9, $t9, 1

draw:
	j end

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
