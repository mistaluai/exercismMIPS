# | Register | Usage        | Type    | Description                   |
# | -------- | ------------ | ------- | ----------------------------- |
# | `$a0`    | input        | address | garden diagram                |
# | `$a1`    | input        | address | student's name                |
# | `$a2`    | input/output | address | null-terminated output string |
# | `$t0-9`  | temporary    | any     | used for temporary storage    |
.globl plants
.data
radishes: .asciiz "radishes"
clover: .asciiz "clover"
grass: .asciiz "grass"
violets: .asciiz "violets"

.text
#first step is to calculate the length of the single row
#second step is to decide which student we are looking for
# | `$t9` | address   |             return address             |
# | `$t8` | integer   |      stores the length of the row      |
# | `$t7` | integer   |   indicates the name of the student    |
# | `$t6` | ascii     |  indicates the name of the first plant |
# | `$t5` | ascii     | indicates the name of the second plant |
# | `$t4` | ascii     |  indicates the name of the third plant |
# | `$t3` | ascii     | indicates the name of the fourth plant |
plants:
	add $t9, $ra, $0 #store the return address
	jal separate_diagram #gets and stores length of the row in t8
	jal determine_student #gets and stores the index needed to access the first elements for the student
	jal load_plants
	
	move $t1, $a2 #copy the output address
	
	move $t0, $t6 #load the content of the first word to t0
	jal set_word #sets what value to be loaded in t0
	jal load_word #stores the word in the memory starting with the last address we stopped in
	jal __comma
	
	move $t0, $t5 #load the content of the second word to t0
	jal set_word #sets what value to be loaded in t0
	jal load_word #stores the word in the memory starting with the last address we stopped in
	jal __comma
	
	move $t0, $t4 #load the content of the third word to t0
	jal set_word #sets what value to be loaded in t0
	jal load_word #stores the word in the memory starting with the last address we stopped in
	jal __comma
	
	move $t0, $t3 #load the content of the fourth word to t0
	jal set_word #sets what value to be loaded in t0
        jal load_word #stores the word in the memory starting with the last address we stopped in
        
        jr $t9
        

__comma:
	li $t2, 44 #loads comma , in the t2
	sb $t2, 0($t1)
	addi $t1, $t1, 1
	li $t2, 32 #loads space in the t2
	sb $t2, 0($t1)
	addi $t1, $t1, 1
	jr $ra
	
separate_diagram:
	li $t0, 10 #loads t0 with the ascii code of the \n, to know when to stop traversing
	li $t8, 0 #initialize counter with 0
	add $t1, $a0, $0
	separation_loop:
		lb $t3, 0($t1) #load the charachter of the diagram
		beq $t3, $t0, end_separation #if reached new line end counting row length
		addi $t8, $t8, 1 #increment counter by one byte
		addi $t1, $t1, 1 #increment pointer by one byte
		j separation_loop
	end_separation:
		jr $ra
		
determine_student:
	lb $t0, 0($a1) #load first character of the name
	addi $t7, $t0, -65 #will yield 0 for alice, 1 for bob and so on.....
	jr $ra

load_plants:
	sll $t7, $t7, 1 #multiply the student index by two, for the 2-byte plant alignment
	add $t7, $t7, $a0 #calculate the new address 
	lb $t6, 0($t7) #loads the first plant indicator to t6
	lb $t5, 1($t7) #loads the second plant indicator to t5
	addi $t7, $t7, 1 #skip the \n
	add $t7, $t7, $t8 #jump to the second row
	lb $t4, 0($t7) #loads the first plant indicator to t6
	lb $t3, 1($t7) #loads the second plant indicator to t5
	jr $ra
	
set_word:
	check_radishes:
		bne $t0, 82, check_clover #if R load radishes
		la $t0, radishes
		j end_setting
	check_clover:
		bne $t0, 67, check_grass #if C load clover
		la $t0, clover
		j end_setting
	check_grass:
		bne $t0, 71, check_violets #if G load grass
		la $t0, grass
		j end_setting
	check_violets:
		bne $t0, 86, end_loading #if V load violets 
		la $t0, violets
	end_setting:
		jr $ra

load_word:
	loading_loop:
	lb $t2, 0($t0) #loads character of from address t0
	beqz $t2, end_loading
	sb $t2, 0($t1) #stores the loaded character
	addi $t0, $t0, 1 #increment pointer by one byte
	addi $t1, $t1, 1 #increment pointer by one byte
	j loading_loop
	end_loading:
		jr $ra
	
	