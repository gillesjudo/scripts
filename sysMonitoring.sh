#!/usr/bin/bash
#This project focuses on system monitor`ing using Bash scripts.
#Your task is to create a Bash script that monitors system resources such as CPU usage,
#memory usage, and disk space.
#The script should display the current usage for each resource and send an email 
#We should also monitor resource load by user using (w). 
#alert if any of the resources exceed a specified threshold.
#Usage:
#Threshold: 
#Commands that possibly monitor system resources (top, free, df) 
#Would be wise to show the output in human readable form (free -h) or (df -h) 
#Top needs to be run in batch mode to be accepted in script (top -bn 1) the numeral is the
#number of times top will iterate.
#

w
top -bn1 | grep Tasks
top -bn1 | grep %Cpu
top -bn1 | grep MiB
df -h -x squashfs -x tmpfs -x devtmpfs
