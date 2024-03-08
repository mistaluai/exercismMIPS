# Collatz Conjecture

Welcome to Collatz Conjecture on Exercism's MIPS Assembly Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Instructions

The Collatz Conjecture or 3x+1 problem can be summarized as follows:

Take any positive integer n.
If n is even, divide n by 2 to get n / 2.
If n is odd, multiply n by 3 and add 1 to get 3n + 1.
Repeat the process indefinitely.
The conjecture states that no matter which number you start with, you will always reach 1 eventually.

Given a number n, return the number of steps required to reach 1.

## Examples

Starting with n = 12, the steps would be as follows:

0. 12
1. 6
2. 3
3. 10
4. 5
5. 16
6. 8
7. 4
8. 2
9. 1

Resulting in 9 steps.
So for input n = 12, the return value would be 9.

## Registers

| Register | Usage     | Type    | Description                                       |
| -------- | --------- | ------- | ------------------------------------------------- |
| `$a0`    | input     | integer | starting number                                   |
| `$v0`    | output    | integer | expected number of steps, -1 if number is invalid |
| `$t0-9`  | temporary | any     | used for temporary storage                        |

## Source

### Created by

- @ukolka
- @keiravillekode

### Based on

An unsolved problem in mathematics named after mathematician Lothar Collatz - https://en.wikipedia.org/wiki/3x_%2B_1_problem