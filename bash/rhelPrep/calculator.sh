#!/bin/bash
#
# Write a script that takes two numbers as command-line arguments and prints their sum, difference, product, and quotient.

echo "What is the first number?" && read integer1

echo "What is the second number?" && read integer2

echo "What operation would you like performed: \n"

echo "(usage: add, sub, mul, div, exp,)"

read operation 

if [[ -n $operation ]]; then 
	echo -e 'We will perform $operator'
	case "$operation" in
		add) 
			let answer=$(($integer1+$integer2))
			echo $answer
			;;
		sub)
			let answer=$(($integer1-$integer2))
			echo $answer
			;;
		mul)
			let answer=$(($integer1*$integer2))
			echo $answer
			;;
		div)
			let answer=$(($integer1/$integer2))
			echo $answer
			;;
		exp)	
			let answer=$(($integer1**$integer2))
			echo $answer
			;;
	esac
fi
