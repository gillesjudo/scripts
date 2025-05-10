#!/bin/bash
#Write a script that checks if a given file exists and is readable. 
#If it exists and is readable, print the first 10 lines of the file.
#Otherwise, print an appropriate error message.


home='^\~'
local='^\.'

echo -e 'What file would you like checked:' 
read rfile
echo "$rfile"
if [[ $rfile =~ $home && -r $rfile ]]; then
	rmtil=$(echo "$rfile" | sed 's/\~//g')
	rfile=$HOME$rmtil
	echo "This file is readable"
elif [[ $rfile =~ $local && -r $rfile ]]; then 
	rfile=$(pwd)/$(echo "$rfile" | sed 's/\.\///')
	echo "This file is readable"
elif [[ -r $rfile ]]
	echo "This file is readable"
else
	echo 'This either is not file, not readable or has a bd path.'
	echo "$(file $rfile && ls -l $rfile)"
	exit 1
fi
