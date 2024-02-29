# | Register | Usage        | Type    | Description                             |
# | -------- | ------------ | ------- | --------------------------------------- |
# | `$a0`    | input        | address | null-terminated input string            |
# | `$a1`    | input/output | address | null-terminated result string (4 words) |
# | `$t0-9`  | temporary    | any     | for temporary storage                   |


.globl nucleotide_counts
#A is 0($a1), C is 4($a1), G is 8($a1), T is 12($a1)
#Ascii >> A:65, C:67, G:71, T:84
#use $t0 for A, $t1 for C, $t2 for G, $t3 for T
nucleotide_counts:
	add $t0, $zero, $zero #initialize A counter with zero
	add $t1, $zero, $zero #initialize C counter with zero
	add $t2, $zero, $zero #initialize G counter with zero
	add $t3, $zero, $zero #initialize T counter with zero
	loop:
		lb $t4, 0($a0) #Loads character
		beqz $t4, exit #exits if reached null
		check_A:
			bne $t4, 65, check_C #if not A, check if C
			addi $t0, $t0, 1 #increment A counter
			j reload #reload the t4 register with the next character to check again
		check_C:
			bne $t4, 67, check_G #if not C, check if G
			addi $t1, $t1, 1 #increment C counter
			j reload #reload the t4 register with the next character to check again
		check_G:
			bne $t4, 71, check_T #if not G, check if T
			addi $t2, $t2, 1 #increment G counter
			j reload #reload the t4 register with the next character to check again
		check_T:
			bne $t4, 84, invalid #if not T then invalid
			addi $t3, $t3, 1 #increment T counter
			j reload #reload the t4 register with the next character to check again
		invalid:
			addi $t0, $zero, -1
			addi $t1, $zero, -1
			addi $t2, $zero, -1
			addi $t3, $zero, -1
			j exit
			
		reload:
			addi $a0, $a0, 1 #increments the pointer
        		j loop
        
        exit:
       		sw $t0, 0($a1) #store A value
       		sw $t1, 4($a1) #store C value
       		sw $t2, 8($a1) #store G value
       		sw $t3, 12($a1) #store T value
        	jr $ra
        
