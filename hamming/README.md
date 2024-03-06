# Hamming

Welcome to Hamming on Exercism's MIPS Assembly Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Instructions

Calculate the Hamming Distance between two DNA strands.

Your body is made up of cells that contain DNA.
Those cells regularly wear out and need replacing, which they achieve by dividing into daughter cells.
In fact, the average human body experiences about 10 quadrillion cell divisions in a lifetime!

When cells divide, their DNA replicates too.
Sometimes during this process mistakes happen and single pieces of DNA get encoded with the incorrect information.
If we compare two strands of DNA and count the differences between them we can see how many mistakes occurred.
This is known as the "Hamming Distance".

We read DNA using the letters C,A,G and T.
Two strands might look like this:

    GAGCCTACTAACGGGAT
    CATCGTAATGACGGCCT
    ^ ^ ^  ^ ^    ^^

They have 7 differences, and therefore the Hamming Distance is 7.

The Hamming Distance is useful for lots of things in science, not just biology, so it's a nice phrase to be familiar with :)

## Implementation notes

The Hamming distance is only defined for sequences of equal length, so an attempt to calculate it between sequences of different lengths should not work.

## Registers

| Register | Usage     | Type    | Description                     |
| -------- | --------- | ------- | ------------------------------- |
| `$a0`    | input     | address | first, null-terminated, string  |
| `$a1`    | input     | address | second, null-terminated, string |
| `$v0`    | output    | integer | hamming distance                |
| `$t0-9`  | temporary | any     | for temporary storage           |

## Source

### Created by

- @ozan

### Based on

The Calculating Point Mutations problem at Rosalind - https://rosalind.info/problems/hamm/