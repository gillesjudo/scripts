#!/bin/bash
#Write a script that checks if a given file exists and is readable. 
#If it exists and is readable, print the first 10 lines of the file.
#Otherwise, print an appropriate error message.


home='^\~'
local='^\.'

echo -e 'What file would you like checked:' 
read rfile
echo "$rfile"
if [[ $rfile =~ $home ]]; then
	rmtil=$(echo "$rfile" | sed 's/\~//g')
	rfile=$HOME$rmtil
elif [[ $rfile =~ $local ]]; then 
	rfile=$(pwd)/$(echo "$rfile" | sed 's/\.\///')
fi

if [[ -r $rfile ]]; then 
	echo "This file is readable"
elif [[ -d $rfile ]]; then 
	echo  "This is not a file but a directory"
	echo  "Maybe your file is in here?"
	contents=$(ls)
	echo 'Would you like to check one of the contents within?'
	yes=1
	no=2
	answer=""
	read answer
	while $answer="";
		echo 'please answer 1 for yes or 2 for no'
		if [[ ! $answer -eq $yes || ! $answer -eq $no ]]; then 
			echo 'Please answer yes or no'
		elif [[ $answer -eq $yes ]];then
			echo "$(contents)"
			echo "Please choose a file"
			read entity
			while $entity="";
				filename="[A-Za-z0-9]+(\.[a-z]+)?"
				if [[ ! $entity =~ $filename ]]; then
					entity=""
					echo "Please enter a proper filename " 
				elif [[ -r $rfile$entity ]]; then 
					echo "$entity is readable"
				elif [[ ! -r $rfile$entity ]]; then
					echo "This file is not readable"

			elif [[ $answer -eq $no ]]; then 
			echo "Thank you have a good day!"
			exit 0
fi
