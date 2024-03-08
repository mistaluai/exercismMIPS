# | Register | Usage     | Type    | Description                                       |
# | -------- | --------- | ------- | ------------------------------------------------- |
# | `$a0`    | input     | integer | starting number                                   |
# | `$v0`    | output    | integer | expected number of steps, -1 if number is invalid |
# | `$t0-9`  | temporary | any     | used for temporary storage                        |

.globl  steps

steps:
	li $t8, 2 #store 2 in t8 to use it n/2 division
	li $v0, 0 #initialize the counter to be zero
	li $t6, 1 #initialize t6 with 1 to use it in the ending condition
	ble $a0, $0, invalid
	loop:
		ble $a0, $t6, end #end if reached one
		addi $v0, $v0, 1 #increment counter
		div $a0, $t8 #n/2
		mfhi $t0 #moves the remainder of the division to t0
		beqz $t0, even #if the remainder is zero, then the number is even
		odd:
		li $t7, 3 #store 3 in t7 to use it in the 3n multiplication
		mult $a0, $t7 #3n
		mflo $t0 #loads the 3n value into t0
		addi $t0, $t0, 1 #computes the 3n+1
		move $a0, $t0
		j loop
		even:
			mflo $t0
			move $a0, $t0 #sets n to be n/2
			j loop
	
        end:
        	jr $ra
        	
        invalid:
        	li $v0, -1
        	jr $ra
