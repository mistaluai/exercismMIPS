# | Register | Usage        | Type    | Description                   |
# | -------- | ------------ | ------- | ----------------------------- |
# | `$a0`    | input        | address | null-terminated input string  |
# | `$a1`    | input/output | address | null-terminated result string |
# | `$t0-9`  | temporary    | any     | for temporary storage         |

.globl transcribe_rna

transcribe_rna:
	loop:
		lb $t0, 0($a0) #loads the character to t0
		beqz $t0, exit #exits if null reached
		check_A:
			bne $t0, 65, check_C #if not A check for C
			addi $t1, $zero, 85 #store U in t1
			j store
		check_C:
			bne $t0, 67, check_G #if not C check for G
			addi $t1, $zero, 71 #store G in t1
			j store
		check_G:
			bne $t0, 71, T #if not G then T
			addi $t1, $zero, 67 #store C in t1
			j store
		T:
			addi $t1, $zero, 65 #store A in t1
		
		store:
			sb $t1, 0($a1) #stores in the output
		
		addi $a1, $a1, 1 #increments pointer
		addi $a0, $a0, 1 #increments pointer
		j loop
        exit:
        	jr $ra
