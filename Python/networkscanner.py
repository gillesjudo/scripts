#!/usr/bin/env python3 

import subprocess
import re
from pacCheck import package_checker
from scapy.all import *

'''This script will require the program netdiscover so we will create
a function to ensure the netdiscover package is present.'''

package = ['nmap', 'scapy']
package_checker(package)

userIP = ""
def myIP():
    global userIP 
    global userHW
    ipcom = subprocess.Popen(('ip', '-4', '-brief', 'address', 'show'), stdout=subprocess.PIPE)
    ip_Addr = subprocess.check_output(('grep', '-Eo', '([0-9]{1,3}\.){3}[0-9]{1,3}\/[0-3][0-9]'), stdin=ipcom.stdout)
    ipcom.stdout.close()
    ipLink = subprocess.Popen(('ip', 'link', 'show'), stdout=subprocess.PIPE)
    greps = subprocess.Popen(('grep','-Eo', 'ether\s([a-f0-9]{2}:?){6}'), stdout=subprocess.PIPE, stdin=ipLink.stdout)
    ipLink.stdout.close()
    hw_Addr = subprocess.check_output(('grep','-Eo', '([a-f0-9]{2}:?){6}'),stdin=greps.stdout)
    greps.stdout.close()
    userIP = str(ip_Addr.strip().decode('utf-8'))
    userHW = str(hw_Addr.strip().decode('utf-8'))
    print('Your IP address is', userIP,'\nYour mac address is', userHW )
myIP()
'''
Now that I am able to extract the IP I want to be able to extrapolate out into
the network and determine what else is present. It might be a wise decision to 
not only use arp to find other hosts but to also include a ping scan if we dont
mind being noisy. So we will first below create a function to do an arp broadcast.  
'''
def layer2NetScan(ip):
   print(userIP)
   
layer2NetScan(userIP)

'''I want to give the user 3 options for scanning a network. I want to give a 
quiet (other users unlikely to be alerted) option, a louder option that will 
likely alert other users on the network but will be more accurate and a loud and
detailed scan. I will use 3 different tools to guarantee this happens.  
'''