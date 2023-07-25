#!/bin/bash

######################################################
# AUTHOR: Megan Kozub
# DATE:   2023-07-23
# FILE:   CalorieCounting.sh
# BRIEF:
#     Advent of Code 2022 - Day 1
#     adventofcode.com/2022/day/1
# 
#     Determine how many Calories the Elf carrying the
#     most Calories has.
# INPUT: A filepath to the input file is supplied by
#        the user. The input file contains lines
#        representing the number of Calories an Elf
#        is carrying. The items carried by distinct
#        elves is separated by an empty line. 
# RUN:
# 	./CalorieCounting.sh Day1_input.txt
######################################################

# Get the input file from the command-line arguments (1st arg)
INPUT="$1"

# Initialize counters
CUR_CALORIES=0
FIRST=0
SECOND=0
THIRD=0

# Read each line of the input file
while read -r LINE
do
	# Keep track of the current Elf
	#ELF_COUNTER=$((ELF_COUNTER+1))

	# If the current line of input is empty then
	# we've reached the end of the current Elf's
	# list of Calories.
	if [ -z "$LINE" ]
	then
		# Check to see if the current calorie count is
		# higher than any of the elves with the current highest calories
		if [ $CUR_CALORIES -gt $FIRST  ]
		then
			THIRD=$SECOND # Push the 2nd elf's count to 3rd
			SECOND=$FIRST # Push the 1st elf's count to 2nd
			FIRST=$CUR_CALORIES # Update the 1st elf's count
		elif [ $CUR_CALORIES -gt $SECOND ]
		then
			THIRD=$SECOND # Push the 2nd elf's count to 3rd
			SECOND=$CUR_CALORIES # Update the 2nd elf's count
		elif [ $CUR_CALORIES -gt $THIRD ]
		then
			# Update the calories for the third elf
			THIRD=$CUR_CALORIES
		fi
		# Reset the current calories counter
		CUR_CALORIES=0
	else
		# If we haven't reached the end of this Elf's list of Calories,
		# then add the current line's calories to the current counter
		CUR_CALORIES=$((CUR_CALORIES + LINE))
	fi
done < "$INPUT"

# Check the final elf's Calories to see if has more
# than any of the elves with the current highest calories
if [ $CUR_CALORIES -gt $FIRST  ]
then
	THIRD=$SECOND # Push the 2nd elf's count to 3rd
	SECOND=$FIRST # Push the 1st elf's count to 2nd
	FIRST=$CUR_CALORIES # Update the 1st elf's count
elif [ $CUR_CALORIES -gt $SECOND ]
then
	THIRD=$SECOND # Push the 2nd elf's count to 3rd
	SECOND=$CUR_CALORIES # Update the 2nd elf's count
elif [ $CUR_CALORIES -gt $THIRD ]
then
	# Update the calories for the third elf
	THIRD=$CUR_CALORIES
fi

# Display the results
echo Max Calories: $FIRST
echo Calories of top 3 Elves: $((FIRST + SECOND + THIRD))
