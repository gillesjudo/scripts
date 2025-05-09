#!/bin/bash
#
#Write a script that iterates over the files in a directory and prints the name and size of each file.
#

echo 'Tell me where the file is: '
read path

realstruct='^\/([0-9A-Za-z]+(\/)){0,}'
endPath='(\/)$'
homeEnv='^\~'
present='^\.'
if [[ ! $path =~ $endPath ]]; then
#check if path is a real path
	path="$path/"
elif [[ $path =~ $homeEnv ]]; then
	path="$HOME$path"
	if [[ ! $path =~ $endPath ]]; then
		path=$path/
	fi
elif [[ $path =~ $present ]];then
	path=$(pwd)$(echo $path | sed 's/\.\///g')
	echo $path
	
fi
	
if [[ $path =~ $realstruct ]]; then 
	echo 'We will check the size of the files here'
	dir=$(ls $path)
	#Saves the files within a variable
	for x in $dir ; do
		stat -c '%n %s' $path$x
		#Returns name and file size
	done
else
	echo 'That is not a directory'
	exit
fi
	
