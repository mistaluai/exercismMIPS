# | Register | Usage     | Type    | Description                      |
# | -------- | --------- | ------- | -------------------------------- |
# | `$a0`    | input     | integer | square number in the range 1..64 |
# | `$v0`    | output    | integer | low 32 bits of output            |
# | `$v1`    | output    | integer | high 32 bits of output           |
# | `$t0-9`  | temporary | any     | for temporary storage            |

.globl square
#s = 2^(n-1) 
square:
	li $v0, 0 #prepare the v0 with zero
	li $v1, 0 #prepare the v1 with zero
	
	li $t0, 0 
	ble $a0, $t0, end #check if under the bound
	li $t0, 64
	bgt $a0, $t0, end #check if over the bound
	
	li $t0, 32
	bgt $a0, $t0, handle_hi #check if will overflow
	
	li $t1, 1 #prepare the constant 1 to be shifted
	add $t0, $a0, -1 #prepare the n-1
	sllv $v0, $t1, $t0 #multiply by 2^(n-1) and store in v0
	j end
	
	handle_hi:
		li $v0, 0
		li $t1, 1 #prepare the constant 1 to be shifted
		addi $t0, $a0, -33 #prepare the high n-1-32
		sllv $v1, $t1, $t0 #multiply by 2^(n-1-32)
		
       	end:
       		jr $ra
