# Prolog-Programming-Pentago

## Introduction
Pentago is a two-player board game played on a 6x6 board, which is divided into four 3×3
sub-boards (or quadrants). This game is similar to tic-tac-toe. One player owns the red
playing pieces (i.e. the red marbles) and the other one owns the black playing pieces (i.e.
the black marbles). In each turn, one player places one of his/her marbles on the board
and rotates a quadrant by 90 degrees. The goal of this game is to create a vertical,
horizontal or diagonal row of five marbles.
In this assignment, you are required to implement a simple Pentago player program,
which can help you win the game.
## Requirement
In this assignment, you are required to implement two important Prolog predicates:
threatening(Board,CurrentPlayer,ThreatsCount).
pentago_ai(Board,CurrentPlayer,BestMove,NextBoard).
The first one “threatening” calculates the number of threats (introduced later) that the
CurrentPlayer makes for his/her opponent. The second one “pentago_ai” finds the best
move for the CurrentPlayer given the current board. Some related predicates can be
defined and used in your program to support the inference of “threatening” and
“pentagon_ai”.
