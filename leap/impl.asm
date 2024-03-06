## Registers

# | Register | Usage     | Type    | Description                                      |
# | -------- | --------- | ------- | ------------------------------------------------ |
# | `$a0`    | input     | integer | year to check                                    |
# | `$v0`    | output    | boolean | input is leap year (`0` = `false`, `1` = `true`) |
# | `$t0-9`  | temporary | any     | used for temporary storage                       |

.globl is_leap_year

is_leap_year:
	#check for divisbilty by 4
	li $t0, 4
	div $a0, $t0
	mfhi $t1 #will be zero if divisble by zero
	
	#check for divisbilty by 100
	li $t0, 100
	div $a0, $t0
	mfhi $t2 #will be zero if divisble by 100
	
	#check for divisbilty by 400
	li $t0, 400
	div $a0, $t0
	mfhi $t3 #will be zero if divisble by 400
	
	bne $t1, $0, invalid #if not divisble by 4 then invalid
	beq $t2, $0, check_400 #if divisble by 100, check for 400 divisblity
	li $v0, 1 #if not divisble by 100 then leap
	jr $ra
	
	check_400:
		bne $t3, $0, invalid #if not divisble by 400 then invalid
		li $v0, 1 #if divisble by 400 then leap
		jr $ra
	
        invalid:
        	li $v0, 0
        	jr $ra