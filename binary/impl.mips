# | Register | Usage     | Type    | Description                            |
# | -------- | --------- | ------- | -------------------------------------- |
# | `$a0`    | input     | address | null-terminated string of binary chars |
# | `$v0`    | output    | integer | decimal value of input string          |
# | `$t0-9`  | temporary | any     | used for temporary storage             |

.globl binary_convert
binary_convert:

	add $v0, $zero, $zero #prepare the output register
	loop: 
	lb  $t0, 0($a0) #loads the character into a temporary register
	beqz $t0, end   #ends the loop if we reached null
	subi $t0, $t0, 48 #converts the string reprsentation to integer using the mips ascii
	sll $v0, $v0, 1 #shifts by one bit
	add $v0, $v0, $t0 #adds the binary value
	addi $a0, $a0, 1 #increments the pointer by one
	j loop
	
	end:
        jr $ra
