# | Register | Usage        | Type    | Description                    |
# | -------- | ------------ | ------- | ------------------------------ |
# | `$a0`    | input        | address | array elements                 |
# | `$a1`    | input        | integer | size of array, in words        |
# | `$a2`    | input        | integer | value being searched for       |
# | `$v0`    | output       | integer | index of value in array, or -1 |
# | `$t0-9`  | temporary    | any     | for temporary storage          |

.globl find

find:
	add $t9, $ra, $zero #reserve return address
	add $t0, $zero, $zero #sets lower bound to zero
	add $t1, $zero, $a1   #sets upper bound to n
	beqz $t1, not_found   #aborts if the size is already zero
	loop:
		bgt $t0, $t1, not_found #exits if lower got higher than the upper
		jal calculate_mid #go get mid
		sll $t4, $t3, 2 #multiply by 4 for word alignment
		add $t4, $t4, $a0 #get effective address of array[mid]
		lw $t4, 0($t4) #loads the actual value of array[mid] into t4
		bgt $a2, $t4, update_lower #if the value we are looking for is after the mid then update the lower bound
		bne $a2, $t4, update_higher #if the value we are looking for isn't the array[mid] then update the higher bound
		bne $t4, $a2, not_found
		add $v0, $t3, $zero
		j exit
		update_lower:
			addi $t0, $t3, 1 #updates lower bound to be mid + 1
			j loop
		update_higher:
			addi $t1, $t3, -1 #updates higher to be mid - 1
			j loop
        
        not_found:
        	addi $v0, $zero, -1
        exit :
        	jr $t9
        	
        calculate_mid:
        	sub $t3, $t1, $t0 #mid = upper - lower
        	div $t3, $t3, 2 #mid = (upper-lower) / 2
        	add $t3, $t0, $t3 #mid = lower + (upper-lower) / 2
        	jr $ra
