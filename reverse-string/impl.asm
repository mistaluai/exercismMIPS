# | Register | Usage        | Type    | Description                   |
# | -------- | ------------ | ------- | ----------------------------- |
# | `$a0`    | input        | address | null-terminated input string  |
# | `$a1`    | input/output | address | null-terminated output string |
# | `$t0-9`  | temporary    | any     | used for temporary storage    |

.globl reverse

reverse:

	add $t1, $zero, $zero #initialize our counter with zero
	loop:
		lb $t0, 0($a0) #load one character into temporary register
		beqz $t0, pop_all
		subi $sp, $sp, 1 #prepares the stack pointer to store it
		sb $t0, 0($sp) #stores the chracter in the stack to pop it later
		addi $t1, $t1, 1 #increments the counter
		addi $a0, $a0, 1 #increments the pointer
		j loop
	
	pop_all:
		beqz $t1, end 
		lb $t0, 0($sp) #loads character into temporary register
		addi $sp, $sp, 1 #increments the stack to be ready to load the next character
		sb $t0, 0($a1) #stores thr character in the output address
		subi $t1, $t1, 1 #decrements the counter
		addi $a1, $a1, 1 #increments the pointer
		j pop_all
	end:
		add $t0, $zero, $zero
		sb $t0, 0($a1)
		jr $ra