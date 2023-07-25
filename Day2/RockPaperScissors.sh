#!/bin/bash

######################################################
# AUTHOR: Megan Kozub
# DATE:   2023-07-24
# FILE:   RockPaperScissors.sh
# BRIEF:
#     Advent of Code 2022 - Day 2
#     adventofcode.com/2022/day/2
# 
#     Determine your rock-paper-scissors score if you
#     follow the given strategy guide.
# INPUT: A filepath to the input file is supplied by
#        the user. The input file contains lines
#        a round of rock-paper-scissors. The first
#        column is the opponent's move and the second
#        is your move.
# SCORING:
#        Scoring is composed of the value of the shape
#        you played (see key below) plus the oucome
#        score (Loss = 0pts, Draw = 3pts, Win = 6pts)
#        The key for each move is as follows:
#        OPPONENT | YOU |  MOVE    | POINTS
#           A     |  X  |  ROCK    |   1
#           B     |  Y  |  PAPER   |   2
#           C     |  Z  | SCISSORS |   3
# RUN:
# 	./RockPaperScissors.sh Day2_input.txt
######################################################

# Get the input file from the command-line arguments (1st arg)
INPUT="$1"
INPUT_CONVERTED=converted.txt

TOTAL_SCORE=0

# Convert A & X to "1" # ROCK
# Convert B & Y to "2" # PAPER
# Convert C & Z to "3" # SCISSORS
sed 's/A/1/g;s/X/1/g;s/B/2/g;s/Y/2/g;s/C/3/g;s/Z/3/g' $INPUT > $INPUT_CONVERTED


# Read each line of the input file
while read -r LINE
do
	# Parse the line
	IFS=' ' read -ra VALS <<< "$LINE"
	OPP="${VALS[0]}"
	YOUR_MOVE="${VALS[1]}"
	
	# Add the points of the shape you threw to the total
	TOTAL_SCORE=$((TOTAL_SCORE + YOUR_MOVE))

	# Evaluate who won
	# if OPP=YOU then draw
	if [ $OPP -eq $YOUR_MOVE ]
	then
		TOTAL_SCORE=$((TOTAL_SCORE + 3))
	elif [[ ($OPP == 1 && $YOUR_MOVE == 2) ||
		($OPP == 2 && $YOUR_MOVE == 3) ||
		($OPP == 3 && $YOUR_MOVE == 1) ]]
	then
		TOTAL_SCORE=$((TOTAL_SCORE + 6))
	fi
done < "$INPUT_CONVERTED"

# Clean up intermediate file
rm $INPUT_CONVERTED

# Display the results
echo Total Score: $TOTAL_SCORE
