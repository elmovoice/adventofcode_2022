#!/bin/bash

######################################################
# AUTHOR: Megan Kozub
# DATE:   2023-07-24
# FILE:   RockPaperScissors_Part2.sh
# BRIEF:
#     Advent of Code 2022 - Day 2 Part 2
#     adventofcode.com/2022/day/2#part2
# 
#     Determine your rock-paper-scissors score if you
#     follow the given strategy guide.
# INPUT: 
#     A filepath to the input file is supplied by the
#     user. The input file contains lines a round of
#     rock-paper-scissors. The first column is the
#     opponent's move. The second is how the round
#     needs to end.
# SCORING:
#     Scoring is composed of the value of the shape
#     you played (see key below) plus the oucome score
#     (Loss(X) = 0pts, Draw(Y) = 3pts, Win(Z) = 6pts).
#     The key for each move is as follows:
#               MOVE    | POINTS
#               ROCK    |   1
#               PAPER   |   2
#              SCISSORS |   3
# RUN:
# 	./RockPaperScissors_Part2.sh Day2_input.txt
######################################################

# Get the input file from the command-line arguments (1st arg)
INPUT="$1"
INPUT_CONVERTED=converted.txt

# Initialize the total score
TOTAL_SCORE=0

# Set up some constants
LOSE=0
DRAW=3
WIN=6
ROCK=1
PAPER=2
SCISSORS=3

# Convert A & X to "1" # ROCK
# Convert B & Y to "2" # PAPER
# Convert C & Z to "3" # SCISSORS
sed 's/A/1/g;s/X/0/g;s/B/2/g;s/Y/3/g;s/C/3/g;s/Z/6/g' $INPUT > $INPUT_CONVERTED


# Read each line of the input file
while read -r LINE
do
	# Parse the line
	IFS=' ' read -ra VALS <<< "$LINE"
	OPP="${VALS[0]}"
	RESULT="${VALS[1]}"
	
	# Add the points of the result to the total
	TOTAL_SCORE=$((TOTAL_SCORE + RESULT))

	# Determine your move
	if [ $RESULT -eq $DRAW ]
	then
		TOTAL_SCORE=$((TOTAL_SCORE + OPP))
	elif [[ ($OPP == $SCISSORS && $RESULT == $WIN) ||
		($OPP == $PAPER && $RESULT == $LOSE) ]]
	then
		TOTAL_SCORE=$((TOTAL_SCORE + ROCK))
	elif [[ ($OPP == $ROCK && $RESULT == $WIN) ||
		($OPP == $SCISSORS && $RESULT == $LOSE) ]]
	then
		TOTAL_SCORE=$((TOTAL_SCORE + PAPER))
	elif [[ ($OPP == $PAPER && $RESULT == $WIN) ||
		($OPP == $ROCK && $RESULT == $LOSE) ]]
	then
		TOTAL_SCORE=$((TOTAL_SCORE + SCISSORS))
	fi
done < "$INPUT_CONVERTED"

# Clean up intermediate file
rm $INPUT_CONVERTED

# Display the results
echo Total Score: $TOTAL_SCORE
