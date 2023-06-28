.text
.globl main
main:
    # Printing General Instructions
    li $v0, 4
    la $a0, Instructions
    syscall

	#initializing few variables
    li $t9, 0	#Number of turns played
    li $t8, 0  #Current state of grid
	li $s0, 0
	li $t1, 0
	sw $s0, grid($t1)
	li $t1, 4
	sw $s0, grid($t1)
	li $t1, 8
	sw $s0, grid($t1)
	li $t1, 12
	sw $s0, grid($t1)
	li $t1, 16
	sw $s0, grid($t1)
	li $t1, 20
	sw $s0, grid($t1)
	li $t1, 24
	sw $s0, grid($t1)
	li $t1, 28
	sw $s0, grid($t1)
	li $t1, 32
	sw $s0, grid($t1)
	
	j print_grid	#Prints the current grid
	

#Taking input
ask_input:
	#asks user for choosing a position, storing result in $t0
	li $v0, 4
	la $a0, Input_prompt
	syscall

	li $v0, 5
	syscall
	move $t0, $v0

	j verify_input	#verify that the position chosen is valid
verify_input:
	slt $t1, $t0, 10	#if the position is greater than 9
	beq $t1, 0, invalid_input

	slt $t1, $t0, 0		#if the position is less than 0
	beq $t1, 1, invalid_input

	move $t2, $t0	#if the position is already occupied
	mul $t2, $t2, 4
	addi $t2, $t2, -4
	lw $t1, grid($t2)
	bne $t1, 0, invalid_input

	j valid_input	#the input is valid, proceeding to find the computer's response
invalid_input:
	# tells user that given position is invalid, and asks to enter a new position
	li $v0, 4
	la $a0, invalid
	syscall

	j ask_input
valid_input:
	#at this moment we have the user choice stored in $t0

	li $s0, 1			#updating the grid
	sw $s0, grid($t2)

	addi $t9, $t9, 1	#increment no. of turns played count
	beq $t9, 5, print_grid	#if 5 turns played by user, then its a draw (code ensured user doesn't win)

	li $t1, 10			#Updating the current state
	mul $t8, $t8, $t1
	add $t8, $t8, $t0

	j find_response		#Finding the computer's response for the current state
find_response:
	#This program knows all the possible states the game can reach and the optimal response to each state
	beq $t8, 1, response_5
	beq $t8, 2, response_1
	beq $t8, 3, response_5
	beq $t8, 4, response_1
	beq $t8, 5, response_1
	beq $t8, 6, response_3
	beq $t8, 7, response_5
	beq $t8, 8, response_2
	beq $t8, 9, response_5
	beq $t8, 12, response_3
	beq $t8, 13, response_2
	beq $t8, 14, response_7
	beq $t8, 16, response_2
	beq $t8, 17, response_4
	beq $t8, 18, response_4
	beq $t8, 19, response_2
	beq $t8, 23, response_4
	beq $t8, 24, response_5
	beq $t8, 25, response_8
	beq $t8, 26, response_7
	beq $t8, 27, response_5
	beq $t8, 28, response_5
	beq $t8, 29, response_5
	beq $t8, 31, response_2
	beq $t8, 32, response_1
	beq $t8, 34, response_1
	beq $t8, 36, response_9
	beq $t8, 37, response_2
	beq $t8, 38, response_4
	beq $t8, 39, response_6
	beq $t8, 42, response_5
	beq $t8, 43, response_5
	beq $t8, 45, response_6
	beq $t8, 46, response_5
	beq $t8, 47, response_2
	beq $t8, 48, response_3
	beq $t8, 49, response_3
	beq $t8, 52, response_8
	beq $t8, 53, response_7
	beq $t8, 54, response_6
	beq $t8, 56, response_4
	beq $t8, 57, response_3
	beq $t8, 58, response_2
	beq $t8, 59, response_3
	beq $t8, 61, response_4
	beq $t8, 62, response_4
	beq $t8, 64, response_5
	beq $t8, 65, response_4
	beq $t8, 67, response_1
	beq $t8, 68, response_1
	beq $t8, 69, response_1
	beq $t8, 71, response_4
	beq $t8, 72, response_1
	beq $t8, 73, response_2
	beq $t8, 74, response_1
	beq $t8, 76, response_2
	beq $t8, 78, response_9
	beq $t8, 79, response_8
	beq $t8, 81, response_7
	beq $t8, 83, response_7
	beq $t8, 84, response_7
	beq $t8, 85, response_1
	beq $t8, 86, response_7
	beq $t8, 87, response_9
	beq $t8, 89, response_7
	beq $t8, 91, response_2
	beq $t8, 92, response_1
	beq $t8, 93, response_6
	beq $t8, 94, response_1
	beq $t8, 96, response_3
	beq $t8, 97, response_8
	beq $t8, 98, response_7
	beq $t8, 124, response_7
	beq $t8, 126, response_7
	beq $t8, 127, response_4
	beq $t8, 128, response_4
	beq $t8, 129, response_4
	beq $t8, 134, response_8
	beq $t8, 136, response_8
	beq $t8, 137, response_4
	beq $t8, 138, response_4
	beq $t8, 139, response_6
	beq $t8, 142, response_3
	beq $t8, 143, response_2
	beq $t8, 146, response_2
	beq $t8, 148, response_3
	beq $t8, 149, response_2
	beq $t8, 163, response_8
	beq $t8, 164, response_7
	beq $t8, 167, response_8
	beq $t8, 168, response_7
	beq $t8, 169, response_3
	beq $t8, 172, response_6
	beq $t8, 173, response_2
	beq $t8, 176, response_2
	beq $t8, 178, response_6
	beq $t8, 179, response_6
	beq $t8, 182, response_3
	beq $t8, 183, response_6
	beq $t8, 186, response_3
	beq $t8, 187, response_6
	beq $t8, 189, response_6
	beq $t8, 193, response_6
	beq $t8, 194, response_7
	beq $t8, 196, response_3
	beq $t8, 197, response_8
	beq $t8, 198, response_7
	beq $t8, 235, response_7
	beq $t8, 236, response_7
	beq $t8, 237, response_5
	beq $t8, 238, response_5
	beq $t8, 239, response_6
	beq $t8, 243, response_9
	beq $t8, 246, response_3
	beq $t8, 247, response_9
	beq $t8, 248, response_3
	beq $t8, 249, response_3
	beq $t8, 253, response_7
	beq $t8, 254, response_6
	beq $t8, 256, response_4
	beq $t8, 257, response_3
	beq $t8, 259, response_3
	beq $t8, 263, response_4
	beq $t8, 264, response_5
	beq $t8, 265, response_4
	beq $t8, 268, response_4
	beq $t8, 269, response_3
	beq $t8, 273, response_4
	beq $t8, 274, response_9
	beq $t8, 276, response_9
	beq $t8, 278, response_9
	beq $t8, 279, response_8
	beq $t8, 283, response_4
	beq $t8, 284, response_3
	beq $t8, 286, response_3
	beq $t8, 287, response_9
	beq $t8, 289, response_7
	beq $t8, 293, response_6
	beq $t8, 294, response_3
	beq $t8, 296, response_3
	beq $t8, 297, response_8
	beq $t8, 298, response_7
	beq $t8, 314, response_8
	beq $t8, 316, response_8
	beq $t8, 317, response_4
	beq $t8, 318, response_4
	beq $t8, 319, response_6
	beq $t8, 324, response_9
	beq $t8, 326, response_9
	beq $t8, 327, response_4
	beq $t8, 328, response_4
	beq $t8, 329, response_6
	beq $t8, 342, response_9
	beq $t8, 346, response_9
	beq $t8, 347, response_2
	beq $t8, 348, response_9
	beq $t8, 349, response_6
	beq $t8, 361, response_2
	beq $t8, 362, response_1
	beq $t8, 364, response_1
	beq $t8, 367, response_1
	beq $t8, 368, response_1
	beq $t8, 371, response_4
	beq $t8, 374, response_1
	beq $t8, 376, response_8
	beq $t8, 378, response_9
	beq $t8, 379, response_8
	beq $t8, 381, response_6
	beq $t8, 382, response_1
	beq $t8, 386, response_9
	beq $t8, 387, response_6
	beq $t8, 389, response_6
	beq $t8, 391, response_2
	beq $t8, 392, response_4
	beq $t8, 394, response_1
	beq $t8, 397, response_4
	beq $t8, 398, response_4
	beq $t8, 423, response_9
	beq $t8, 426, response_3
	beq $t8, 427, response_9
	beq $t8, 428, response_3
	beq $t8, 429, response_3
	beq $t8, 432, response_9
	beq $t8, 436, response_9
	beq $t8, 437, response_2
	beq $t8, 438, response_9
	beq $t8, 439, response_6
	beq $t8, 452, response_8
	beq $t8, 453, response_7
	beq $t8, 457, response_3
	beq $t8, 458, response_2
	beq $t8, 459, response_2
	beq $t8, 462, response_3
	beq $t8, 463, response_9
	beq $t8, 467, response_2
	beq $t8, 468, response_2
	beq $t8, 469, response_3
	beq $t8, 473, response_5
	beq $t8, 475, response_3
	beq $t8, 476, response_3
	beq $t8, 478, response_3
	beq $t8, 479, response_3
	beq $t8, 482, response_5
	beq $t8, 485, response_2
	beq $t8, 486, response_2
	beq $t8, 487, response_2
	beq $t8, 489, response_2
	beq $t8, 492, response_5
	beq $t8, 495, response_2
	beq $t8, 496, response_2
	beq $t8, 497, response_2
	beq $t8, 498, response_2
	beq $t8, 523, response_7
	beq $t8, 524, response_6
	beq $t8, 526, response_4
	beq $t8, 527, response_3
	beq $t8, 529, response_3
	beq $t8, 532, response_4
	beq $t8, 534, response_6
	beq $t8, 536, response_4
	beq $t8, 538, response_4
	beq $t8, 539, response_4
	beq $t8, 542, response_8
	beq $t8, 543, response_7
	beq $t8, 547, response_3
	beq $t8, 548, response_2
	beq $t8, 549, response_2
	beq $t8, 562, response_7
	beq $t8, 563, response_7
	beq $t8, 567, response_3
	beq $t8, 568, response_2
	beq $t8, 569, response_3
	beq $t8, 572, response_8
	beq $t8, 574, response_2
	beq $t8, 576, response_2
	beq $t8, 578, response_2
	beq $t8, 579, response_2
	beq $t8, 583, response_7
	beq $t8, 584, response_3
	beq $t8, 586, response_3
	beq $t8, 587, response_3
	beq $t8, 589, response_3
	beq $t8, 592, response_8
	beq $t8, 594, response_2
	beq $t8, 596, response_2
	beq $t8, 597, response_2
	beq $t8, 598, response_2
	beq $t8, 612, response_5
	beq $t8, 615, response_9
	beq $t8, 617, response_5
	beq $t8, 618, response_5
	beq $t8, 619, response_5
	beq $t8, 621, response_5
	beq $t8, 625, response_8
	beq $t8, 627, response_5
	beq $t8, 628, response_5
	beq $t8, 629, response_7
	beq $t8, 641, response_7
	beq $t8, 642, response_1
	beq $t8, 647, response_1
	beq $t8, 648, response_1
	beq $t8, 649, response_1
	beq $t8, 651, response_9
	beq $t8, 652, response_8
	beq $t8, 657, response_1
	beq $t8, 658, response_2
	beq $t8, 659, response_1
	beq $t8, 672, response_5
	beq $t8, 674, response_2
	beq $t8, 675, response_2
	beq $t8, 678, response_2
	beq $t8, 679, response_2
	beq $t8, 682, response_5
	beq $t8, 684, response_2
	beq $t8, 685, response_2
	beq $t8, 687, response_2
	beq $t8, 689, response_2
	beq $t8, 692, response_7
	beq $t8, 694, response_2
	beq $t8, 695, response_2
	beq $t8, 697, response_2
	beq $t8, 698, response_2
	beq $t8, 712, response_6
	beq $t8, 713, response_2
	beq $t8, 716, response_2
	beq $t8, 718, response_6
	beq $t8, 719, response_6
	beq $t8, 723, response_4
	beq $t8, 724, response_9
	beq $t8, 726, response_9
	beq $t8, 728, response_9
	beq $t8, 729, response_8
	beq $t8, 731, response_4
	beq $t8, 734, response_1
	beq $t8, 736, response_8
	beq $t8, 738, response_9
	beq $t8, 739, response_8
	beq $t8, 742, response_9
	beq $t8, 743, response_2
	beq $t8, 746, response_2
	beq $t8, 748, response_9
	beq $t8, 749, response_8
	beq $t8, 761, response_8
	beq $t8, 763, response_8
	beq $t8, 764, response_1
	beq $t8, 768, response_9
	beq $t8, 769, response_8
	beq $t8, 781, response_4
	beq $t8, 782, response_1
	beq $t8, 783, response_1
	beq $t8, 784, response_1
	beq $t8, 786, response_1
	beq $t8, 791, response_2
	beq $t8, 792, response_1
	beq $t8, 793, response_2
	beq $t8, 794, response_2
	beq $t8, 796, response_2
	beq $t8, 813, response_5
	beq $t8, 814, response_5
	beq $t8, 815, response_9
	beq $t8, 816, response_5
	beq $t8, 819, response_5
	beq $t8, 831, response_5
	beq $t8, 834, response_5
	beq $t8, 835, response_1
	beq $t8, 836, response_9
	beq $t8, 839, response_6
	beq $t8, 841, response_5
	beq $t8, 843, response_5
	beq $t8, 845, response_6
	beq $t8, 846, response_5
	beq $t8, 849, response_3
	beq $t8, 853, response_7
	beq $t8, 854, response_3
	beq $t8, 856, response_3
	beq $t8, 857, response_3
	beq $t8, 859, response_3
	beq $t8, 861, response_5
	beq $t8, 863, response_9
	beq $t8, 864, response_5
	beq $t8, 865, response_4
	beq $t8, 869, response_3
	beq $t8, 871, response_4
	beq $t8, 873, response_5
	beq $t8, 874, response_1
	beq $t8, 875, response_3
	beq $t8, 876, response_1
	beq $t8, 891, response_5
	beq $t8, 893, response_6
	beq $t8, 894, response_3
	beq $t8, 895, response_1
	beq $t8, 896, response_3
	beq $t8, 913, response_6
	beq $t8, 914, response_7
	beq $t8, 916, response_3
	beq $t8, 917, response_8
	beq $t8, 918, response_7
	beq $t8, 923, response_6
	beq $t8, 924, response_3
	beq $t8, 926, response_3
	beq $t8, 927, response_8
	beq $t8, 928, response_7
	beq $t8, 931, response_2
	beq $t8, 932, response_4
	beq $t8, 934, response_1
	beq $t8, 937, response_4
	beq $t8, 938, response_4
	beq $t8, 942, response_3
	beq $t8, 943, response_6
	beq $t8, 946, response_3
	beq $t8, 947, response_8
	beq $t8, 948, response_7
	beq $t8, 961, response_2
	beq $t8, 962, response_7
	beq $t8, 964, response_1
	beq $t8, 967, response_8
	beq $t8, 968, response_7
	beq $t8, 971, response_2
	beq $t8, 972, response_1
	beq $t8, 973, response_2
	beq $t8, 974, response_2
	beq $t8, 976, response_2
	beq $t8, 981, response_3
	beq $t8, 982, response_1
	beq $t8, 983, response_6
	beq $t8, 984, response_3
	beq $t8, 986, response_3
	beq $t8, 1246, response_8
	beq $t8, 1248, response_6
	beq $t8, 1249, response_6
	beq $t8, 1264, response_8
	beq $t8, 1268, response_4
	beq $t8, 1269, response_4
	beq $t8, 1276, response_8
	beq $t8, 1278, response_6
	beq $t8, 1279, response_6
	beq $t8, 1286, response_7
	beq $t8, 1287, response_6
	beq $t8, 1289, response_6
	beq $t8, 1296, response_7
	beq $t8, 1297, response_6
	beq $t8, 1298, response_6
	beq $t8, 1346, response_7
	beq $t8, 1347, response_6
	beq $t8, 1349, response_6
	beq $t8, 1364, response_7
	beq $t8, 1367, response_4
	beq $t8, 1369, response_4
	beq $t8, 1376, response_8
	beq $t8, 1378, response_6
	beq $t8, 1379, response_6
	beq $t8, 1386, response_9
	beq $t8, 1387, response_6
	beq $t8, 1389, response_6
	beq $t8, 1394, response_8
	beq $t8, 1397, response_4
	beq $t8, 1398, response_4
	beq $t8, 1426, response_8
	beq $t8, 1428, response_6
	beq $t8, 1429, response_6
	beq $t8, 1436, response_8
	beq $t8, 1438, response_6
	beq $t8, 1439, response_8
	beq $t8, 1463, response_8
	beq $t8, 1468, response_3
	beq $t8, 1469, response_3
	beq $t8, 1482, response_6
	beq $t8, 1486, response_2
	beq $t8, 1489, response_2
	beq $t8, 1493, response_8
	beq $t8, 1496, response_3
	beq $t8, 1498, response_3
	beq $t8, 1634, response_7
	beq $t8, 1637, response_4
	beq $t8, 1639, response_4
	beq $t8, 1643, response_8
	beq $t8, 1648, response_3
	beq $t8, 1649, response_3
	beq $t8, 1673, response_4
	beq $t8, 1674, response_3
	beq $t8, 1679, response_3
	beq $t8, 1683, response_9
	beq $t8, 1684, response_3
	beq $t8, 1689, response_3
	beq $t8, 1694, response_7
	beq $t8, 1697, response_8
	beq $t8, 1698, response_7
	beq $t8, 1723, response_8
	beq $t8, 1728, response_3
	beq $t8, 1729, response_3
	beq $t8, 1736, response_8
	beq $t8, 1738, response_6
	beq $t8, 1739, response_6
	beq $t8, 1763, response_8
	beq $t8, 1768, response_9
	beq $t8, 1769, response_8
	beq $t8, 1782, response_3
	beq $t8, 1783, response_2
	beq $t8, 1789, response_2
	beq $t8, 1792, response_3
	beq $t8, 1793, response_2
	beq $t8, 1798, response_2
	beq $t8, 1826, response_7
	beq $t8, 1827, response_6
	beq $t8, 1829, response_6
	beq $t8, 1832, response_7
	beq $t8, 1837, response_2
	beq $t8, 1839, response_2
	beq $t8, 1862, response_7
	beq $t8, 1867, response_9
	beq $t8, 1869, response_7
	beq $t8, 1872, response_3
	beq $t8, 1873, response_2
	beq $t8, 1879, response_2
	beq $t8, 1892, response_3
	beq $t8, 1893, response_2
	beq $t8, 1897, response_2
	beq $t8, 1934, response_8
	beq $t8, 1937, response_4
	beq $t8, 1938, response_4
	beq $t8, 1943, response_8
	beq $t8, 1946, response_3
	beq $t8, 1948, response_3
	beq $t8, 1964, response_7
	beq $t8, 1967, response_8
	beq $t8, 1968, response_7
	beq $t8, 1973, response_4
	beq $t8, 1974, response_3
	beq $t8, 1976, response_3
	beq $t8, 1983, response_6
	beq $t8, 1984, response_3
	beq $t8, 1986, response_3
	beq $t8, 2356, response_8
	beq $t8, 2358, response_6
	beq $t8, 2359, response_6
	beq $t8, 2365, response_8
	beq $t8, 2368, response_5
	beq $t8, 2369, response_5
	beq $t8, 2376, response_9
	beq $t8, 2378, response_6
	beq $t8, 2379, response_6
	beq $t8, 2386, response_7
	beq $t8, 2387, response_6
	beq $t8, 2389, response_6
	beq $t8, 2395, response_7
	beq $t8, 2397, response_5
	beq $t8, 2398, response_5
	beq $t8, 2436, response_7
	beq $t8, 2437, response_6
	beq $t8, 2438, response_6
	beq $t8, 2467, response_9
	beq $t8, 2468, response_7
	beq $t8, 2469, response_7
	beq $t8, 2473, response_6
	beq $t8, 2476, response_3
	beq $t8, 2478, response_3
	beq $t8, 2486, response_7
	beq $t8, 2487, response_9
	beq $t8, 2489, response_7
	beq $t8, 2496, response_7
	beq $t8, 2497, response_8
	beq $t8, 2498, response_7
	beq $t8, 2534, response_9
	beq $t8, 2536, response_4
	beq $t8, 2539, response_4
	beq $t8, 2543, response_7
	beq $t8, 2547, response_3
	beq $t8, 2549, response_3
	beq $t8, 2563, response_7
	beq $t8, 2567, response_3
	beq $t8, 2569, response_7
	beq $t8, 2574, response_6
	beq $t8, 2576, response_4
	beq $t8, 2579, response_4
	beq $t8, 2594, response_6
	beq $t8, 2596, response_4
	beq $t8, 2597, response_4
	beq $t8, 2635, response_8
	beq $t8, 2638, response_5
	beq $t8, 2639, response_5
	beq $t8, 2643, response_9
	beq $t8, 2648, response_3
	beq $t8, 2649, response_3
	beq $t8, 2653, response_8
	beq $t8, 2658, response_3
	beq $t8, 2659, response_3
	beq $t8, 2683, response_5
	beq $t8, 2685, response_3
	beq $t8, 2689, response_3
	beq $t8, 2694, response_5
	beq $t8, 2695, response_4
	beq $t8, 2698, response_4
	beq $t8, 2736, response_9
	beq $t8, 2738, response_6
	beq $t8, 2739, response_6
	beq $t8, 2743, response_6
	beq $t8, 2746, response_3
	beq $t8, 2748, response_3
	beq $t8, 2763, response_4
	beq $t8, 2764, response_3
	beq $t8, 2768, response_3
	beq $t8, 2783, response_4
	beq $t8, 2784, response_3
	beq $t8, 2786, response_3
	beq $t8, 2793, response_6
	beq $t8, 2794, response_3
	beq $t8, 2796, response_3
	beq $t8, 2836, response_7
	beq $t8, 2837, response_6
	beq $t8, 2839, response_6
	beq $t8, 2846, response_7
	beq $t8, 2847, response_9
	beq $t8, 2849, response_7
	beq $t8, 2864, response_7
	beq $t8, 2867, response_9
	beq $t8, 2869, response_7
	beq $t8, 2873, response_4
	beq $t8, 2874, response_3
	beq $t8, 2876, response_3
	beq $t8, 2893, response_4
	beq $t8, 2894, response_3
	beq $t8, 2896, response_3
	beq $t8, 2934, response_7
	beq $t8, 2937, response_4
	beq $t8, 2938, response_4
	beq $t8, 2946, response_7
	beq $t8, 2947, response_8
	beq $t8, 2948, response_7
	beq $t8, 2964, response_7
	beq $t8, 2967, response_8
	beq $t8, 2968, response_7
	beq $t8, 2973, response_6
	beq $t8, 2974, response_3
	beq $t8, 2976, response_3
	beq $t8, 2983, response_4
	beq $t8, 2984, response_3
	beq $t8, 2986, response_3
	beq $t8, 3146, response_7
	beq $t8, 3147, response_6
	beq $t8, 3149, response_6
	beq $t8, 3164, response_7
	beq $t8, 3167, response_4
	beq $t8, 3169, response_4
	beq $t8, 3176, response_8
	beq $t8, 3178, response_6
	beq $t8, 3179, response_6
	beq $t8, 3186, response_9
	beq $t8, 3187, response_6
	beq $t8, 3189, response_6
	beq $t8, 3194, response_8
	beq $t8, 3197, response_4
	beq $t8, 3198, response_4
	beq $t8, 3246, response_7
	beq $t8, 3247, response_6
	beq $t8, 3248, response_6
	beq $t8, 3264, response_7
	beq $t8, 3267, response_4
	beq $t8, 3268, response_4
	beq $t8, 3276, response_9
	beq $t8, 3278, response_6
	beq $t8, 3279, response_6
	beq $t8, 3286, response_7
	beq $t8, 3287, response_6
	beq $t8, 3289, response_6
	beq $t8, 3294, response_7
	beq $t8, 3297, response_4
	beq $t8, 3298, response_4
	beq $t8, 3426, response_7
	beq $t8, 3427, response_6
	beq $t8, 3428, response_6
	beq $t8, 3462, response_7
	beq $t8, 3467, response_2
	beq $t8, 3468, response_2
	beq $t8, 3476, response_8
	beq $t8, 3478, response_9
	beq $t8, 3479, response_8
	beq $t8, 3482, response_6
	beq $t8, 3486, response_2
	beq $t8, 3487, response_2
	beq $t8, 3492, response_7
	beq $t8, 3497, response_8
	beq $t8, 3498, response_7
	beq $t8, 3614, response_8
	beq $t8, 3617, response_8
	beq $t8, 3618, response_4
	beq $t8, 3624, response_7
	beq $t8, 3627, response_4
	beq $t8, 3628, response_4
	beq $t8, 3642, response_7
	beq $t8, 3647, response_2
	beq $t8, 3648, response_2
	beq $t8, 3672, response_4
	beq $t8, 3674, response_2
	beq $t8, 3678, response_2
	beq $t8, 3682, response_4
	beq $t8, 3684, response_2
	beq $t8, 3687, response_2
	beq $t8, 3716, response_8
	beq $t8, 3718, response_6
	beq $t8, 3719, response_6
	beq $t8, 3746, response_8
	beq $t8, 3748, response_9
	beq $t8, 3749, response_8
	beq $t8, 3761, response_4
	beq $t8, 3764, response_1
	beq $t8, 3769, response_1
	beq $t8, 3781, response_4
	beq $t8, 3784, response_1
	beq $t8, 3786, response_1
	beq $t8, 3791, response_4
	beq $t8, 3794, response_1
	beq $t8, 3796, response_1
	beq $t8, 3812, response_7
	beq $t8, 3817, response_2
	beq $t8, 3819, response_2
	beq $t8, 3826, response_7
	beq $t8, 3827, response_6
	beq $t8, 3829, response_6
	beq $t8, 3861, response_2
	beq $t8, 3862, response_1
	beq $t8, 3867, response_1
	beq $t8, 3871, response_2
	beq $t8, 3872, response_1
	beq $t8, 3879, response_1
	beq $t8, 3891, response_2
	beq $t8, 3892, response_1
	beq $t8, 3897, response_1
	beq $t8, 3914, response_8
	beq $t8, 3917, response_4
	beq $t8, 3918, response_4
	beq $t8, 3921, response_7
	beq $t8, 3927, response_1
	beq $t8, 3928, response_1
	beq $t8, 3942, response_7
	beq $t8, 3947, response_8
	beq $t8, 3948, response_7
	beq $t8, 3971, response_2
	beq $t8, 3972, response_1
	beq $t8, 3978, response_1
	beq $t8, 3981, response_2
	beq $t8, 3982, response_1
	beq $t8, 3987, response_1
	beq $t8, 4236, response_7
	beq $t8, 4237, response_6
	beq $t8, 4238, response_6
	beq $t8, 4267, response_9
	beq $t8, 4268, response_7
	beq $t8, 4269, response_7
	beq $t8, 4273, response_6
	beq $t8, 4276, response_3
	beq $t8, 4278, response_3
	beq $t8, 4286, response_7
	beq $t8, 4287, response_9
	beq $t8, 4289, response_7
	beq $t8, 4296, response_7
	beq $t8, 4297, response_8
	beq $t8, 4298, response_7
	beq $t8, 4326, response_7
	beq $t8, 4327, response_6
	beq $t8, 4328, response_6
	beq $t8, 4362, response_7
	beq $t8, 4367, response_2
	beq $t8, 4368, response_2
	beq $t8, 4376, response_8
	beq $t8, 4378, response_9
	beq $t8, 4379, response_8
	beq $t8, 4382, response_6
	beq $t8, 4386, response_2
	beq $t8, 4387, response_2
	beq $t8, 4392, response_7
	beq $t8, 4397, response_8
	beq $t8, 4398, response_7
	beq $t8, 4523, response_7
	beq $t8, 4527, response_3
	beq $t8, 4529, response_3
	beq $t8, 4532, response_8
	beq $t8, 4538, response_2
	beq $t8, 4539, response_2
	beq $t8, 4572, response_9
	beq $t8, 4578, response_2
	beq $t8, 4579, response_2
	beq $t8, 4583, response_7
	beq $t8, 4587, response_3
	beq $t8, 4589, response_3
	beq $t8, 4593, response_7
	beq $t8, 4597, response_3
	beq $t8, 4598, response_3
	beq $t8, 4627, response_9
	beq $t8, 4628, response_7
	beq $t8, 4629, response_7
	beq $t8, 4632, response_7
	beq $t8, 4637, response_2
	beq $t8, 4638, response_2
	beq $t8, 4673, response_8
	beq $t8, 4678, response_3
	beq $t8, 4679, response_3
	beq $t8, 4683, response_9
	beq $t8, 4687, response_3
	beq $t8, 4689, response_3
	beq $t8, 4692, response_7
	beq $t8, 4697, response_2
	beq $t8, 4698, response_2
	beq $t8, 4736, response_8
	beq $t8, 4738, response_9
	beq $t8, 4739, response_8
	beq $t8, 4756, response_8
	beq $t8, 4758, response_6
	beq $t8, 4759, response_6
	beq $t8, 4765, response_8
	beq $t8, 4768, response_5
	beq $t8, 4769, response_5
	beq $t8, 4785, response_6
	beq $t8, 4786, response_5
	beq $t8, 4789, response_5
	beq $t8, 4795, response_6
	beq $t8, 4796, response_5
	beq $t8, 4798, response_5
	beq $t8, 4826, response_7
	beq $t8, 4827, response_9
	beq $t8, 4829, response_7
	beq $t8, 4856, response_7
	beq $t8, 4857, response_6
	beq $t8, 4859, response_6
	beq $t8, 4865, response_7
	beq $t8, 4867, response_5
	beq $t8, 4869, response_5
	beq $t8, 4875, response_6
	beq $t8, 4876, response_5
	beq $t8, 4879, response_5
	beq $t8, 4895, response_6
	beq $t8, 4896, response_5
	beq $t8, 4897, response_5
	beq $t8, 4926, response_7
	beq $t8, 4927, response_8
	beq $t8, 4928, response_7
	beq $t8, 4956, response_7
	beq $t8, 4957, response_6
	beq $t8, 4958, response_6
	beq $t8, 4965, response_7
	beq $t8, 4967, response_5
	beq $t8, 4968, response_5
	beq $t8, 4975, response_6
	beq $t8, 4976, response_5
	beq $t8, 4978, response_5
	beq $t8, 4985, response_6
	beq $t8, 4986, response_5
	beq $t8, 4987, response_5
	beq $t8, 5234, response_9
	beq $t8, 5236, response_4
	beq $t8, 5239, response_4
	beq $t8, 5243, response_7
	beq $t8, 5247, response_3
	beq $t8, 5249, response_3
	beq $t8, 5263, response_7
	beq $t8, 5267, response_3
	beq $t8, 5269, response_7
	beq $t8, 5274, response_6
	beq $t8, 5276, response_4
	beq $t8, 5279, response_4
	beq $t8, 5294, response_6
	beq $t8, 5296, response_4
	beq $t8, 5297, response_4
	beq $t8, 5326, response_8
	beq $t8, 5328, response_6
	beq $t8, 5329, response_6
	beq $t8, 5342, response_8
	beq $t8, 5348, response_2
	beq $t8, 5349, response_2
	beq $t8, 5362, response_8
	beq $t8, 5368, response_2
	beq $t8, 5369, response_2
	beq $t8, 5382, response_6
	beq $t8, 5386, response_2
	beq $t8, 5389, response_2
	beq $t8, 5392, response_6
	beq $t8, 5396, response_2
	beq $t8, 5398, response_2
	beq $t8, 5423, response_7
	beq $t8, 5427, response_3
	beq $t8, 5429, response_3
	beq $t8, 5432, response_8
	beq $t8, 5438, response_2
	beq $t8, 5439, response_2
	beq $t8, 5472, response_9
	beq $t8, 5478, response_2
	beq $t8, 5479, response_2
	beq $t8, 5483, response_7
	beq $t8, 5487, response_3
	beq $t8, 5489, response_3
	beq $t8, 5493, response_7
	beq $t8, 5497, response_3
	beq $t8, 5498, response_3
	beq $t8, 5623, response_8
	beq $t8, 5628, response_3
	beq $t8, 5629, response_3
	beq $t8, 5632, response_8
	beq $t8, 5638, response_2
	beq $t8, 5639, response_2
	beq $t8, 5672, response_8
	beq $t8, 5678, response_2
	beq $t8, 5679, response_2
	beq $t8, 5683, response_7
	beq $t8, 5687, response_3
	beq $t8, 5689, response_3
	beq $t8, 5692, response_7
	beq $t8, 5697, response_2
	beq $t8, 5698, response_2
	beq $t8, 5724, response_6
	beq $t8, 5726, response_4
	beq $t8, 5729, response_4
	beq $t8, 5746, response_8
	beq $t8, 5748, response_6
	beq $t8, 5749, response_6
	beq $t8, 5764, response_8
	beq $t8, 5768, response_4
	beq $t8, 5769, response_4
	beq $t8, 5784, response_6
	beq $t8, 5786, response_4
	beq $t8, 5789, response_4
	beq $t8, 5794, response_6
	beq $t8, 5796, response_4
	beq $t8, 5798, response_4
	beq $t8, 5834, response_6
	beq $t8, 5836, response_4
	beq $t8, 5839, response_4
	beq $t8, 5846, response_7
	beq $t8, 5847, response_6
	beq $t8, 5849, response_6
	beq $t8, 5864, response_7
	beq $t8, 5867, response_4
	beq $t8, 5869, response_4
	beq $t8, 5874, response_6
	beq $t8, 5876, response_4
	beq $t8, 5879, response_4
	beq $t8, 5894, response_6
	beq $t8, 5896, response_4
	beq $t8, 5897, response_4
	beq $t8, 5924, response_6
	beq $t8, 5926, response_4
	beq $t8, 5927, response_4
	beq $t8, 5946, response_7
	beq $t8, 5947, response_6
	beq $t8, 5948, response_6
	beq $t8, 5964, response_7
	beq $t8, 5967, response_4
	beq $t8, 5968, response_4
	beq $t8, 5974, response_6
	beq $t8, 5976, response_4
	beq $t8, 5978, response_4
	beq $t8, 5984, response_6
	beq $t8, 5986, response_4
	beq $t8, 5987, response_4
	beq $t8, 6127, response_8
	beq $t8, 6128, response_7
	beq $t8, 6129, response_7
	beq $t8, 6152, response_8
	beq $t8, 6157, response_2
	beq $t8, 6158, response_2
	beq $t8, 6172, response_8
	beq $t8, 6178, response_9
	beq $t8, 6179, response_8
	beq $t8, 6182, response_7
	beq $t8, 6187, response_9
	beq $t8, 6189, response_7
	beq $t8, 6192, response_7
	beq $t8, 6197, response_8
	beq $t8, 6198, response_7
	beq $t8, 6217, response_8
	beq $t8, 6218, response_7
	beq $t8, 6219, response_7
	beq $t8, 6251, response_9
	beq $t8, 6257, response_1
	beq $t8, 6259, response_1
	beq $t8, 6271, response_8
	beq $t8, 6278, response_9
	beq $t8, 6279, response_8
	beq $t8, 6281, response_7
	beq $t8, 6287, response_9
	beq $t8, 6289, response_7
	beq $t8, 6291, response_5
	beq $t8, 6295, response_1
	beq $t8, 6298, response_1
	beq $t8, 6412, response_8
	beq $t8, 6418, response_2
	beq $t8, 6419, response_2
	beq $t8, 6427, response_9
	beq $t8, 6428, response_7
	beq $t8, 6429, response_7
	beq $t8, 6472, response_9
	beq $t8, 6478, response_2
	beq $t8, 6479, response_2
	beq $t8, 6482, response_7
	beq $t8, 6487, response_2
	beq $t8, 6489, response_2
	beq $t8, 6492, response_7
	beq $t8, 6497, response_2
	beq $t8, 6498, response_2
	beq $t8, 6512, response_8
	beq $t8, 6517, response_2
	beq $t8, 6518, response_2
	beq $t8, 6521, response_9
	beq $t8, 6527, response_1
	beq $t8, 6529, response_1
	beq $t8, 6572, response_8
	beq $t8, 6578, response_2
	beq $t8, 6579, response_2
	beq $t8, 6581, response_9
	beq $t8, 6587, response_1
	beq $t8, 6589, response_1
	beq $t8, 6592, response_7
	beq $t8, 6597, response_2
	beq $t8, 6598, response_2
	beq $t8, 6724, response_9
	beq $t8, 6728, response_9
	beq $t8, 6729, response_8
	beq $t8, 6745, response_8
	beq $t8, 6748, response_5
	beq $t8, 6749, response_5
	beq $t8, 6754, response_8
	beq $t8, 6758, response_4
	beq $t8, 6759, response_4
	beq $t8, 6784, response_5
	beq $t8, 6785, response_4
	beq $t8, 6789, response_4
	beq $t8, 6794, response_5
	beq $t8, 6795, response_4
	beq $t8, 6798, response_4
	beq $t8, 6824, response_7
	beq $t8, 6827, response_9
	beq $t8, 6829, response_7
	beq $t8, 6845, response_7
	beq $t8, 6847, response_5
	beq $t8, 6849, response_5
	beq $t8, 6854, response_7
	beq $t8, 6857, response_4
	beq $t8, 6859, response_4
	beq $t8, 6874, response_5
	beq $t8, 6875, response_4
	beq $t8, 6879, response_4
	beq $t8, 6894, response_5
	beq $t8, 6895, response_4
	beq $t8, 6897, response_4
	beq $t8, 6924, response_5
	beq $t8, 6925, response_4
	beq $t8, 6928, response_4
	beq $t8, 6945, response_7
	beq $t8, 6947, response_5
	beq $t8, 6948, response_5
	beq $t8, 6954, response_7
	beq $t8, 6957, response_4
	beq $t8, 6958, response_4
	beq $t8, 6974, response_5
	beq $t8, 6975, response_4
	beq $t8, 6978, response_4
	beq $t8, 6984, response_5
	beq $t8, 6985, response_4
	beq $t8, 6987, response_4
	beq $t8, 7123, response_8
	beq $t8, 7128, response_3
	beq $t8, 7129, response_3
	beq $t8, 7136, response_8
	beq $t8, 7138, response_6
	beq $t8, 7139, response_6
	beq $t8, 7163, response_8
	beq $t8, 7168, response_9
	beq $t8, 7169, response_8
	beq $t8, 7182, response_3
	beq $t8, 7183, response_2
	beq $t8, 7189, response_2
	beq $t8, 7192, response_3
	beq $t8, 7193, response_2
	beq $t8, 7198, response_2
	beq $t8, 7236, response_9
	beq $t8, 7238, response_6
	beq $t8, 7239, response_6
	beq $t8, 7243, response_6
	beq $t8, 7246, response_3
	beq $t8, 7248, response_3
	beq $t8, 7263, response_4
	beq $t8, 7264, response_3
	beq $t8, 7268, response_3
	beq $t8, 7283, response_4
	beq $t8, 7284, response_3
	beq $t8, 7286, response_3
	beq $t8, 7293, response_6
	beq $t8, 7294, response_3
	beq $t8, 7296, response_3
	beq $t8, 7316, response_8
	beq $t8, 7318, response_6
	beq $t8, 7319, response_6
	beq $t8, 7346, response_8
	beq $t8, 7348, response_9
	beq $t8, 7349, response_8
	beq $t8, 7361, response_4
	beq $t8, 7364, response_1
	beq $t8, 7369, response_1
	beq $t8, 7381, response_4
	beq $t8, 7384, response_1
	beq $t8, 7386, response_1
	beq $t8, 7391, response_4
	beq $t8, 7394, response_1
	beq $t8, 7396, response_1
	beq $t8, 7423, response_6
	beq $t8, 7426, response_3
	beq $t8, 7428, response_3
	beq $t8, 7436, response_8
	beq $t8, 7438, response_9
	beq $t8, 7439, response_8
	beq $t8, 7463, response_8
	beq $t8, 7468, response_3
	beq $t8, 7469, response_3
	beq $t8, 7482, response_3
	beq $t8, 7483, response_2
	beq $t8, 7486, response_2
	beq $t8, 7492, response_3
	beq $t8, 7493, response_2
	beq $t8, 7496, response_2
	beq $t8, 7613, response_4
	beq $t8, 7614, response_3
	beq $t8, 7619, response_3
	beq $t8, 7631, response_4
	beq $t8, 7634, response_1
	beq $t8, 7639, response_1
	beq $t8, 7643, response_8
	beq $t8, 7648, response_3
	beq $t8, 7649, response_3
	beq $t8, 7681, response_4
	beq $t8, 7683, response_1
	beq $t8, 7684, response_1
	beq $t8, 7691, response_3
	beq $t8, 7693, response_1
	beq $t8, 7694, response_1
	beq $t8, 7812, response_6
	beq $t8, 7813, response_6
	beq $t8, 7816, response_2
	beq $t8, 7823, response_4
	beq $t8, 7824, response_3
	beq $t8, 7826, response_3
	beq $t8, 7832, response_4
	beq $t8, 7834, response_2
	beq $t8, 7836, response_2
	beq $t8, 7842, response_3
	beq $t8, 7843, response_2
	beq $t8, 7846, response_2
	beq $t8, 7862, response_3
	beq $t8, 7863, response_2
	beq $t8, 7864, response_2
	beq $t8, 7913, response_4
	beq $t8, 7914, response_3
	beq $t8, 7916, response_3
	beq $t8, 7923, response_6
	beq $t8, 7924, response_3
	beq $t8, 7926, response_3
	beq $t8, 7931, response_4
	beq $t8, 7934, response_1
	beq $t8, 7936, response_1
	beq $t8, 7941, response_3
	beq $t8, 7943, response_1
	beq $t8, 7946, response_1
	beq $t8, 7961, response_3
	beq $t8, 7963, response_1
	beq $t8, 7964, response_1
	beq $t8, 8134, response_6
	beq $t8, 8136, response_9
	beq $t8, 8139, response_6
	beq $t8, 8143, response_6
	beq $t8, 8146, response_3
	beq $t8, 8149, response_3
	beq $t8, 8153, response_4
	beq $t8, 8154, response_6
	beq $t8, 8156, response_4
	beq $t8, 8163, response_9
	beq $t8, 8164, response_3
	beq $t8, 8169, response_3
	beq $t8, 8193, response_6
	beq $t8, 8194, response_3
	beq $t8, 8196, response_3
	beq $t8, 8314, response_6
	beq $t8, 8316, response_9
	beq $t8, 8319, response_6
	beq $t8, 8341, response_6
	beq $t8, 8346, response_9
	beq $t8, 8349, response_6
	beq $t8, 8354, response_6
	beq $t8, 8356, response_4
	beq $t8, 8359, response_4
	beq $t8, 8361, response_4
	beq $t8, 8364, response_5
	beq $t8, 8365, response_4
	beq $t8, 8391, response_5
	beq $t8, 8394, response_1
	beq $t8, 8395, response_1
	beq $t8, 8413, response_6
	beq $t8, 8416, response_3
	beq $t8, 8419, response_3
	beq $t8, 8431, response_6
	beq $t8, 8436, response_9
	beq $t8, 8439, response_6
	beq $t8, 8451, response_9
	beq $t8, 8453, response_1
	beq $t8, 8459, response_1
	beq $t8, 8461, response_3
	beq $t8, 8463, response_9
	beq $t8, 8469, response_3
	beq $t8, 8491, response_5
	beq $t8, 8495, response_1
	beq $t8, 8496, response_1
	beq $t8, 8534, response_6
	beq $t8, 8536, response_4
	beq $t8, 8539, response_4
	beq $t8, 8546, response_7
	beq $t8, 8547, response_6
	beq $t8, 8549, response_6
	beq $t8, 8564, response_7
	beq $t8, 8567, response_4
	beq $t8, 8569, response_4
	beq $t8, 8574, response_6
	beq $t8, 8576, response_4
	beq $t8, 8579, response_4
	beq $t8, 8594, response_6
	beq $t8, 8596, response_4
	beq $t8, 8597, response_4
	beq $t8, 8613, response_9
	beq $t8, 8614, response_3
	beq $t8, 8619, response_3
	beq $t8, 8631, response_4
	beq $t8, 8634, response_5
	beq $t8, 8635, response_4
	beq $t8, 8641, response_3
	beq $t8, 8643, response_9
	beq $t8, 8649, response_3
	beq $t8, 8651, response_9
	beq $t8, 8653, response_1
	beq $t8, 8659, response_1
	beq $t8, 8691, response_5
	beq $t8, 8694, response_1
	beq $t8, 8695, response_1
	beq $t8, 8713, response_5
	beq $t8, 8715, response_3
	beq $t8, 8716, response_3
	beq $t8, 8731, response_4
	beq $t8, 8734, response_1
	beq $t8, 8736, response_1
	beq $t8, 8743, response_5
	beq $t8, 8745, response_3
	beq $t8, 8746, response_3
	beq $t8, 8751, response_6
	beq $t8, 8754, response_1
	beq $t8, 8756, response_1
	beq $t8, 8763, response_5
	beq $t8, 8764, response_3
	beq $t8, 8765, response_3
	beq $t8, 8913, response_6
	beq $t8, 8914, response_3
	beq $t8, 8916, response_3
	beq $t8, 8931, response_5
	beq $t8, 8934, response_1
	beq $t8, 8935, response_1
	beq $t8, 8941, response_5
	beq $t8, 8945, response_1
	beq $t8, 8946, response_1
	beq $t8, 8953, response_4
	beq $t8, 8954, response_3
	beq $t8, 8956, response_3
	beq $t8, 8961, response_5
	beq $t8, 8964, response_1
	beq $t8, 8965, response_1
	beq $t8, 9134, response_8
	beq $t8, 9137, response_4
	beq $t8, 9138, response_4
	beq $t8, 9143, response_8
	beq $t8, 9146, response_3
	beq $t8, 9148, response_3
	beq $t8, 9164, response_7
	beq $t8, 9167, response_8
	beq $t8, 9168, response_7
	beq $t8, 9173, response_4
	beq $t8, 9174, response_3
	beq $t8, 9176, response_3
	beq $t8, 9183, response_6
	beq $t8, 9184, response_3
	beq $t8, 9186, response_3
	beq $t8, 9234, response_7
	beq $t8, 9237, response_4
	beq $t8, 9238, response_4
	beq $t8, 9246, response_7
	beq $t8, 9247, response_8
	beq $t8, 9248, response_7
	beq $t8, 9264, response_7
	beq $t8, 9267, response_8
	beq $t8, 9268, response_7
	beq $t8, 9273, response_6
	beq $t8, 9274, response_3
	beq $t8, 9276, response_3
	beq $t8, 9283, response_4
	beq $t8, 9284, response_3
	beq $t8, 9286, response_3
	beq $t8, 9314, response_8
	beq $t8, 9317, response_4
	beq $t8, 9318, response_4
	beq $t8, 9321, response_7
	beq $t8, 9327, response_1
	beq $t8, 9328, response_1
	beq $t8, 9342, response_7
	beq $t8, 9347, response_8
	beq $t8, 9348, response_7
	beq $t8, 9371, response_2
	beq $t8, 9372, response_1
	beq $t8, 9378, response_1
	beq $t8, 9381, response_2
	beq $t8, 9382, response_1
	beq $t8, 9387, response_1
	beq $t8, 9426, response_7
	beq $t8, 9427, response_8
	beq $t8, 9428, response_7
	beq $t8, 9432, response_7
	beq $t8, 9437, response_8
	beq $t8, 9438, response_7
	beq $t8, 9462, response_7
	beq $t8, 9467, response_2
	beq $t8, 9468, response_2
	beq $t8, 9472, response_3
	beq $t8, 9473, response_2
	beq $t8, 9476, response_2
	beq $t8, 9482, response_3
	beq $t8, 9483, response_6
	beq $t8, 9486, response_3
	beq $t8, 9614, response_7
	beq $t8, 9617, response_8
	beq $t8, 9618, response_7
	beq $t8, 9621, response_4
	beq $t8, 9624, response_1
	beq $t8, 9628, response_1
	beq $t8, 9642, response_7
	beq $t8, 9647, response_2
	beq $t8, 9648, response_2
	beq $t8, 9671, response_2
	beq $t8, 9672, response_1
	beq $t8, 9674, response_2
	beq $t8, 9681, response_2
	beq $t8, 9682, response_1
	beq $t8, 9684, response_1
	beq $t8, 9713, response_4
	beq $t8, 9714, response_3
	beq $t8, 9716, response_3
	beq $t8, 9723, response_6
	beq $t8, 9724, response_3
	beq $t8, 9726, response_3
	beq $t8, 9731, response_4
	beq $t8, 9734, response_1
	beq $t8, 9736, response_1
	beq $t8, 9741, response_3
	beq $t8, 9743, response_1
	beq $t8, 9746, response_1
	beq $t8, 9761, response_3
	beq $t8, 9763, response_1
	beq $t8, 9764, response_1
	beq $t8, 9812, response_4
	beq $t8, 9814, response_2
	beq $t8, 9816, response_2
	beq $t8, 9823, response_4
	beq $t8, 9824, response_3
	beq $t8, 9826, response_3
	beq $t8, 9831, response_4
	beq $t8, 9832, response_4
	beq $t8, 9834, response_1
	beq $t8, 9841, response_2
	beq $t8, 9842, response_1
	beq $t8, 9846, response_1
	beq $t8, 9861, response_2
	beq $t8, 9862, response_1
	beq $t8, 9864, response_1
	j draw
response_1:
	#put the 'o' in position 1
	li $s0, 2			#updating the grid
	li $t1, 0
	sw $s0, grid($t1)

	li $v0, 4			#Telling computer's move to user
	la $a0, computer_move
	syscall
	li $v0, 1
	li $a0, 1
	syscall

	j check_victory		#Checks if the game is won by computer
response_2:
	#put the 'o' in position 2
	li $s0, 2			#updating the grid
	li $t1, 4
	sw $s0, grid($t1)

	li $v0, 4			#Telling computer's move to user
	la $a0, computer_move
	syscall
	li $v0, 1
	li $a0, 2
	syscall

	j check_victory		#Checks if the game is won by computer
response_3:
	#put the 'o' in position 3
	li $s0, 2			#updating the grid
	li $t1, 8
	sw $s0, grid($t1)

	li $v0, 4			#Telling computer's move to user
	la $a0, computer_move
	syscall
	li $v0, 1
	li $a0, 3
	syscall

	j check_victory		#Checks if the game is won by computer
response_4:
	#put the 'o' in position 4
	li $s0, 2			#updating the grid
	li $t1, 12
	sw $s0, grid($t1)

	li $v0, 4			#Telling computer's move to user
	la $a0, computer_move
	syscall
	li $v0, 1
	li $a0, 4
	syscall

	j check_victory		#Checks if the game is won by computer
response_5:
	#put the 'o' in position 5
	li $s0, 2			#updating the grid
	li $t1, 16
	sw $s0, grid($t1)

	li $v0, 4			#Telling computer's move to user
	la $a0, computer_move
	syscall
	li $v0, 1
	li $a0, 5
	syscall

	j check_victory		#Checks if the game is won by computer
response_6:
	#put the 'o' in position 6
	li $s0, 2			#updating the grid
	li $t1, 20
	sw $s0, grid($t1)

	li $v0, 4			#Telling computer's move to user
	la $a0, computer_move
	syscall
	li $v0, 1
	li $a0, 6
	syscall

	j check_victory		#Checks if the game is won by computer
response_7:
	#put the 'o' in position 7
	li $s0, 2			#updating the grid
	li $t1, 24
	sw $s0, grid($t1)

	li $v0, 4			#Telling computer's move to user
	la $a0, computer_move
	syscall
	li $v0, 1
	li $a0, 7
	syscall

	j check_victory		#Checks if the game is won by computer
response_8:
	#put the 'o' in position 8
	li $s0, 2			#updating the grid
	li $t1, 28
	sw $s0, grid($t1)

	li $v0, 4			#Telling computer's move to user
	la $a0, computer_move
	syscall
	li $v0, 1
	li $a0, 8
	syscall

	j check_victory		#Checks if the game is won by computer
response_9:
	#put the 'o' in position 9
	li $s0, 2			#updating the grid
	li $t1, 32
	sw $s0, grid($t1)

	li $v0, 4			#Telling computer's move to user
	la $a0, computer_move
	syscall
	li $v0, 1
	li $a0, 9
	syscall

	j check_victory		#Checks if the game is won by computer

#Check if the computer has won
check_victory:
	j check_row_1
check_row_1:
	li $t1, 0
	lw $t3, grid($t1)
	li $t1, 4
	lw $t4, grid($t1)

	beq $t3, 0, check_row_2
	bne $t3, $t4, check_row_2

	li $t1, 8
	lw $t4, grid($t1)

	bne $t3, $t4, check_row_2

	j computer_won
check_row_2:
	li $t1, 12
	lw $t3, grid($t1)
	li $t1, 16
	lw $t4, grid($t1)

	beq $t3, 0, check_row_3
	bne $t3, $t4, check_row_3

	li $t1, 20
	lw $t4, grid($t1)

	bne $t3, $t4, check_row_3

	j computer_won
check_row_3:
	li $t1, 24
	lw $t3, grid($t1)
	li $t1, 28
	lw $t4, grid($t1)

	beq $t3, 0, check_col_1
	bne $t3, $t4, check_col_1

	li $t1, 32
	lw $t4, grid($t1)

	bne $t3, $t4, check_col_1

	j computer_won
check_col_1:
	li $t1, 0
	lw $t3, grid($t1)
	li $t1, 12
	lw $t4, grid($t1)

	beq $t3, 0, check_col_2
	bne $t3, $t4, check_col_2

	li $t1, 24
	lw $t4, grid($t1)

	bne $t3, $t4, check_col_2

	j computer_won
check_col_2:
	li $t1, 4
	lw $t3, grid($t1)
	li $t1, 16
	lw $t4, grid($t1)

	beq $t3, 0, check_col_3
	bne $t3, $t4, check_col_3

	li $t1, 28
	lw $t4, grid($t1)

	bne $t3, $t4, check_col_3

	j computer_won
check_col_3:
	li $t1, 8
	lw $t3, grid($t1)
	li $t1, 20
	lw $t4, grid($t1)

	beq $t3, 0, check_dia_1
	bne $t3, $t4, check_dia_1

	li $t1, 32
	lw $t4, grid($t1)

	bne $t3, $t4, check_dia_1

	j computer_won
check_dia_1:
	li $t1, 0
	lw $t3, grid($t1)
	li $t1, 16
	lw $t4, grid($t1)

	beq $t3, 0, check_dia_2
	bne $t3, $t4, check_dia_2

	li $t1, 32
	lw $t4, grid($t1)

	bne $t3, $t4, check_dia_2

	j computer_won
check_dia_2:
	li $t1, 8
	lw $t3, grid($t1)
	li $t1, 16
	lw $t4, grid($t1)

	beq $t3, 0, no_victory
	bne $t3, $t4, no_victory

	li $t1, 24
	lw $t4, grid($t1)

	bne $t3, $t4, no_victory

	j computer_won

no_victory:
	j print_grid

#Printing
print_grid:
	li $t0, 0

	li $v0, 4
	la $a0, newline
	syscall
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
	beq $t9, 6, computer_won_cont
	beq $t9, 5, draw
	j ask_input

#Exiting
draw:
	li $v0, 4
    la $a0, draw_prompt
    syscall
    j end
computer_won:
	li $t9, 6
	j print_grid
computer_won_cont:
	li $v0, 4
    la $a0, won
    syscall
    j end
end:
    #Exiting
    li $v0, 4
    la $a0, Thanks
    syscall
    li $v0, 10
    syscall
.data
grid: .word 0:9
Instructions: .ascii " --------------------\n|    Tic-Tac-Toe     |\n --------------------\n\n Instructions:\n"
            .ascii "1. You play as X and Computer plays as O, first turn is yours\n"
            .ascii "2. The position on the grid are marked as :\n   1 2 3\n   4 5 6\n   7 8 9\n"
            .asciiz "3. On your turn, enter the position no. where you want to place 'X'\n\n Game starts!\n"
space: .asciiz " "
newline: .asciiz "\n"
str_x: .asciiz "X"
str_o: .asciiz "O"
str__: .asciiz "_"
Input_prompt: .asciiz "\n\nEnter a position to put 'X': "
invalid: .asciiz "ERROR! That's an invalid position, try again!\n\n"
Thanks: .asciiz "Thanks for playing. Hope you enjoyed the game.\n"
won: .asciiz "\nWINNER: Computer\n"
draw_prompt: .asciiz "\nIt's a DRAW\n"
computer_move: .asciiz "Computer's response: Position "