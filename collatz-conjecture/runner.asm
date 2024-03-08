#
# Test steps with some examples
#
# s0 - num of tests left to run
# s1 - address of input word
# s2 - address of expected output word
# s4 - output word

# steps must:
# - be named steps and declared as global
# - read input integer from a0
# - follow the convention of using the t0-9 registers for temporary storage
# - (if it wants to use s0-7 then it is responsible for pushing existing values to the stack then popping them back off before returning)
# - write the number of steps to v0

.data

# number of test cases
n:  .word 6
# input numbers: (word sized ints)
ins:  .word
        1,
        16,
        12,
        1000000,
        0,
        -15
# expected number of steps, -1 for invalid input (word sized ints)
outs:  .word
        0,
        4,
        9,
        152,
        -1,
        -1

failmsg: .asciiz "failed for test input: "
expectedmsg: .asciiz ". expected "
tobemsg: .asciiz " to be "
okmsg: .asciiz "all tests passed"


.text

runner:
        lw      $s0, n
        la      $s1, ins
        la      $s2, outs
        j       run_test

run_test:
        lw      $a0, 0($s1)             # move input number to a0
        jal     steps                   # call subroutine under test
        move    $v1, $v0                # move return value in v0 to v1 because we need v0 for syscall

        lw      $s4, 0($s2)             # read expected output from memory
        bne     $v1, $s4, exit_fail     # if expected doesn't match actual, jump to fail

        addi    $s1, $s1, 4             # move to next word in input
        addi    $s2, $s2, 4             # move to next word in output

        sub     $s0, $s0, 1             # decrement num of tests left to run
        bgt     $s0, $zero, run_test    # if more than zero tests to run, jump to run_test

exit_ok:
        la      $a0, okmsg              # put address of okmsg into a0
        li      $v0, 4                  # 4 is print string
        syscall

        li      $v0, 10                 # 10 is exit with zero status (clean exit)
        syscall

exit_fail:
        la      $a0, failmsg            # put address of failmsg into a0
        li      $v0, 4                  # 4 is print string
        syscall

        lw      $a0, ($s1)              # print input that failed on
        li      $v0, 1
        syscall

        la      $a0, expectedmsg
        li      $v0, 4
        syscall

        move    $a0, $v1                # print actual that failed on
        li      $v0, 1
        syscall

        la      $a0, tobemsg
        li      $v0, 4
        syscall

        move    $a0, $s4                # print expected value that failed on
        li      $v0, 1
        syscall

        li      $a0, 1                  # set error code to 1
        li      $v0, 17                 # 17 is exit with error
        syscall

        jr      $ra

# # Include your implementation here if you wish to run this from the MARS GUI.
.include "impl.mips"
