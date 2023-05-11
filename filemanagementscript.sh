#!/usr/bin/bash
#
#This script accepts a directory as an argument and creates a new directory inside it.
#Then the script should move all .txt extention files from he current directory to the new directory. 
#
#

#Accepting input on what directory to manage
current=$(echo $1 | grep -Eo '(\w+$)')
#Command substition used to save output as a variable
if [ -d $1 ];
then 
	echo "I will create a directory within $1 for you"
	mkdir $1/notesof$current
	echo "The following files will be moved to notesof$current:"
	ls $1 | grep .txt
	mv $1/*.txt $1/notesof$current
else
	echo "I need a directory"
fi
