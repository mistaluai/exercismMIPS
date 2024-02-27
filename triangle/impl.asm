# | Register | Usage     | Type    | Description                                                                        |
# | -------- | --------- | ------- | ---------------------------------------------------------------------------------- |
# | `$a0`    | input     | integer | side a                                                                             |
# | `$a1`    | input     | integer | side b                                                                             |
# | `$a2`    | input     | integer | side c                                                                             |
# | `$v0`    | output    | integer | type of triangle (`0` = scalene, `1` = isoceles, `2` = equilateral, `3` = invalid) |
# | `$t0-9`  | temporary | any     | used for temporary storage                                                         |

.globl triangle



triangle:
	add $t9, $zero, $ra
	jal validate_triangle
	jal decide_type
	jr $t9


#triangle type decision section
decide_type:
	addi $t7, $zero, 2 #initialize t7 with 2 to use it in branching later
	add $v0, $zero, $zero #initialize the counter with zero
	
	#check all the sides and store the number of equal sides in v0
	first_check:
		bne  $a0, $a1, second_check #increments the counter if a == b
		addi $v0, $v0, 1
	
	second_check:
		bne $a0, $a2, third_check #increments the counter if a == c
		addi $v0, $v0, 1
	
	beq $v0, $t7, end_check #if a == b and a == c then we don't need to check if b == c
	
	third_check:
		bne $a1, $a2, end_check #increments the counter if b == c
		addi $v0, $v0, 1
	
	end_check:
		jr $ra
	
	
#triangle validation section
validate_triangle:
	blez $a0, set_invalid #set the state to invalid if a is less than or equal zero
	blez $a1, set_invalid #set the state to invalid if b is less than or equal zero
	blez $a2, set_invalid #set the state to invalid if c is less than or equal zero
	
	# set t0-t2 for sums of the sides, set t3-t5 for the validation conditions, set t6 for anding the three conditions
	add $t0, $a0, $a1 #adds a and b and stores them in t0
	add $t1, $a0, $a2 #adds a and c and stores them in t1
	add $t2, $a1, $a2 #adds b and c and stores them in t2
	
	sge $t3, $t0, $a2 #checks if a + b ≥ c
	sge $t4, $t2, $a0 #checks if b + c ≥ a
	sge $t5, $t1, $a1 #checks if a + c ≥ b
	
	and $t6, $t3, $t4 #a + b ≥ c && b + c ≥ a in t6
	and $t6, $t6, $t5 #a + b ≥ c && b + c ≥ a && a + c ≥ b in t6
	
	beqz $t6, set_invalid #sets the state to invalid if the side inequalities are not satisfied
	
	jr $ra

set_invalid:
	addi $v0, $zero, 3 #sets the output to 3 to indicate invalidation
	jr $t9 #ends the application
	