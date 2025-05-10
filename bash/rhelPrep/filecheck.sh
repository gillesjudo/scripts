#!/bin/bash
#Write a script that checks if a given file exists and is readable. 
#If it exists and is readable, print the first 10 lines of the file.
#Otherwise, print an appropriate error message.


home='^\~'
local='^\.'

echo -e '\nWhat file would you like checked:' 
read rfile
echo -e "$rfile"
if [[ $rfile =~ $home ]]; then
	rmtil=$(echo "$rfile" | sed 's/\~//g')
	rfile=$HOME$rmtil
	echo "$rmtil"
	echo "$rfile"
elif [[ $rfile =~ $local ]]; then 
	rfile=$(pwd)/$(echo "$rfile" | sed 's/\.\///')
	echo "$rfile"
fi
