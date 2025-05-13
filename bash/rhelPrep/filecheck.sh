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

if [[ -r $rfile && -f $rfile ]]; then 
	echo "$rfile is readable"
elif [[ -d $rfile && -r $rfile ]]; then 
	echo "$rfile is not a file but a directory."
	echo "Would you like to check the contents $rfile and see if they are readable"
	contents=$(ls $rfile)
	counter=0
	read answer
	case $answer in
		yes)
			echo "Here are the contents of the directory: "
			echo "$(ls $counter)"
			for i in $contents; do 
				counter=$((counter+1))
				echo "$counter $i"
			done
			echo 'Would you like to open a file within?'
			read answer
			if [[ $answer='yes' ]]; then 
				echo 'Which file would you like to open? '
				read dirfile
				dirfile=$rfile/$dirfile
				if [[ -r $dirfile && -f $dirfile ]]; then 
					echo 'This file is readable'
				elif [[ -d $dirfile ]]; then
					echo 'This is also a directory.'
				else
					echo 'This is not a readable file'
				fi

			else
				exit 0
			fi
		;;
		no)
			echo 'Thank you for using this program.'
		;;
	esac
		
else
	echo "You do not have permissions to read that file or directory."

fi
