#!/bin/bash
#This project focuses on creating a backup script to automate 
#the process of backing up important files. Your task is to 
#create a Bash script that takes a file name or directory 
#name as an argument and creates a compressed backup file 
#in a specified location. The script should also check 
#if the backup file already exists and prompt
#the user to overwrite it if necessary.
if [ -d $HOME/backup ]; then
	echo "Backup folder exists, continuing!"
else 
	mkdir $HOME/backup
	echo "Creating the folder to save the compressed backup"
	echo "Created!"
fi
dirName=$(echo $1 | grep -Eo '(\w+\/?$)')
fileName=$(echo $1 | grep -Eo '(\w+\.?\w+$)')
#narrowing down var to for utilization as file name
newFileName=$(date +%m_%d_%Y)$(echo $fileName | grep -Eo '(^\w+)')
newDirName=$(date +%m_%d_%Y)$(echo $dirName | grep -Eo '(^\w+)')
#will act as compressed file name
if [ -f $1 ]; then
       echo "Checking if backup of file exists"
#Accepts initial file name for compression
       if [ -f $HOME/backup/$newFileName.gz ]; then
	    echo "Would you like to update $newFileName.gz?"
	    echo "Press [1] to overwrite, press [2] to create new backup or press [3] to  exit"
	    read -n 1 -p "Input Selection: [1/2/3]" overwriteSel
	    echo ""
#Prompts user to select whether to create new backup or overwritebackup if exists
	    if [ $overwriteSel -eq 1 ]; then
		    echo "We will overwrite the backup now $(date)"
		    tar -czf ~/backup/$newFileName.gz $1
		    echo "Overwritten!"
		    exit 0
#Overwrites the backup
	    elif [ $overwriteSel -eq 2 ]; then
		    read -p "What would you like to name the new backup? :" newBackupname
		    tar -czf ~/backup/$newBackupname.gz $1
		    echo "New Backup has been Created!"
		    exit 0
	    else
		    exit 0 
#accepts input to create a backup with new name
	    fi
       else
	   echo "We will create the compressed backup now" 
	   tar -czf ~/backup/$newFileName.gz $1 
	   echo "Created to see the backup navigate to the $(HOME)/backup directory"
       fi	   
#The below takes the same action if original folder is a directory 
elif [ -d $1 ]; then
       echo "Checking if backup of directory exists"
       if [ -f $HOME/backup/$newDirName.gz ]; then
#Even if originally directory looking for new .gz file
	       echo "Would you like to update $newDirName.gz?"
	       echo "Press [1] to overwrite, press [2] to create new and press [3] if you want to exit "
	       read -n 1 -p "Input Selection: [1/2/3]" overwriteSel
	       echo ""
	       if [ $overwriteSel -eq 1 ]; then 
		    echo "We will overwrite the backup now $(date)"
                    tar -czf ~/backup/$newDirName.gz $1
		    echo "Overwritten!"
                    exit 0
	       elif [ $overwriteSel -eq 2 ]; then
                    read -p "What would you like to name the new backup? :" newBackupname
                    tar -czf ~/backup/$newBackupname.gz $1
		    echo "Created to see the backup navigate to the $(HOME)/backup directory"
                    exit 0
	       else
		       exit 0
	       fi
       else
	       echo "We will create a compressed backup now"
	       tar -czf ~/backup/$newDirName.gz $1
	       exit 0

       fi	       
else
       echo "Cannot backup if not a file or directory"
#was given an input that is not a file or directory.
fi

