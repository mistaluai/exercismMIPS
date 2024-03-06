# | Register | Usage     | Type    | Description                     |
# | -------- | --------- | ------- | ------------------------------- |
# | `$a0`    | input     | address | first, null-terminated, string  |
# | `$a1`    | input     | address | second, null-terminated, string |
# | `$v0`    | output    | integer | hamming distance                |
# | `$t0-9`  | temporary | any     | for temporary storage           |

.globl hamming_distance

hamming_distance:
	add $v0, $0, $0 #initialize counter with zero
	loop:
		lb $t0, 0($a0) #loads first char in t0
		lb $t1, 0($a1) #loads second char in t1
		beqz $t0, exit #exit on reaching end 
		beqz $t1, exit #exit on reaching end
	
		beq $t0, $t1, continue #if not equal don't increment
		addi $v0, $v0, 1
		
		continue:
		addi $a0, $a0, 1 #increment pointer
		addi $a1, $a1, 1 #increment pointer
		j loop
	exit:
                jr $ra
