#!/usr/bin/bash

#trying to get dependencies copied
#I need to first copy the dependency paths outputted in the ldd command 


echo Hello, what file dependencies do you need?
echo If you have more then one separate the file paths with a space.
read path
depenlib=`ldd $path | grep -Eo "\/lib\/\S{1,30}"`
depenlib64=`ldd $path | grep -Eo "\/lib64\/\S{1,30}"`
echo $depenlib
echo Would you like to copy these dependencies to a folder?
echo Please respond with yes or no

read decision
yes=1
no=0
if [[ $decision -eq 1 ]]; then 
	echo Where would you like to copy the dependencies to?
	echo Write this as a path example \"/var/jail/lib\".
	read libdest	
	cp $depenlib $libdest
	if [[ -z $depenlib64 ]] && echo "No lib64"; then
		exit 0
	else
		echo What about those lib64 dependencies?
		echo Write this as a path similar to above.
		read lib64dest
		cp $depenlib64 $lib64dest
	fi

else
	echo Okay, See you next time.
fi

