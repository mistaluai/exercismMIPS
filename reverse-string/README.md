# Reverse String

Welcome to Reverse String on Exercism's MIPS Assembly Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

Reversing strings (reading them from right to left, rather than from left to right) is a surprisingly common task in programming.

For example, in bioinformatics, reversing the sequence of DNA or RNA strings is often important for various analyses, such as finding complementary strands or identifying palindromic sequences that have biological significance.

## Instructions

Your task is to reverse a given string.

Some examples:

- Turn `"stressed"` into `"desserts"`.
- Turn `"strops"` into `"sports"`.
- Turn `"racecar"` into `"racecar"`.

## Registers

| Register | Usage        | Type    | Description                   |
| -------- | ------------ | ------- | ----------------------------- |
| `$a0`    | input        | address | null-terminated input string  |
| `$a1`    | input/output | address | null-terminated output string |
| `$t0-9`  | temporary    | any     | used for temporary storage    |

## Source

### Created by

- @keiravillekode

### Based on

Introductory challenge to reverse an input string - https://medium.freecodecamp.org/how-to-reverse-a-string-in-javascript-in-3-different-ways-75e4763c68cb