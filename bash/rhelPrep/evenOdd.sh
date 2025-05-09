#/bin/bash

#Write a script that reads a number from the user and prints whether the number is even or odd. Use the modulo operator (%) to determine if the number is even or odd.
#
echo 'Give me a number(Only integers): ' && read number
int='^([0-9]+)$'
flt='^(([0-9]|\.)+)$'
if [[ $number =~ $int ]]; then
#The tilda allows for the regular expression to perform on the var
	((result=$number%2))
	echo $result
	if [[ $result -eq 0 ]]; then
		echo -e "$number is even"
	else
		echo -e "$number is odd"
	fi
elif [[ $number =~ $flt ]]; then
	echo "$number is a float. Mod doesnt work on floats"
	exit 1
else
	echo "$number is not an integer and we only want integers."
	exit 1

fi
