#!/usr/bin/env python3 

import argparse
import subprocess
import re
from pacCheck import package_checker
import scapy.all as scapy

'''This script will require the program netdiscover so we will create
a function to ensure the netdiscover package is present.'''
print("[+] Welcome! Lets scan some networks! First lets ensure\n[+] you have the dependencies for this script")
package = ['nmap', 'scapy']
package_checker(package)
print("[+] Now lets take a look at your ip and hwaddress")

def myIP():
    global userIP 
    global userHW
    global gateway
    global subnetRange
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
    print('[+] Your IP address is', userIP,'\n[+] Your mac address is', userHW )
myIP()
'''
Now that I am able to extract the IP I want to be able to extrapolate out into
the network and determine what else is present. It might be a wise decision to 
not only use arp to find other hosts but to also include a ping scan if we dont
mind being noisy. So we will first below create a function to do an arp broadcast.  
'''
def layer2NetScan(ip):
   arp_Broadcast = scapy.Ether(dst="ff:ff:ff:ff:ff:ff")   
   arp_Target = scapy.ARP(pdst=ip)
   arp_Full_Broadcast = scapy.srp(arp_Broadcast/arp_Target, timeout=2)[0]
   print(arp_Full_Broadcast)

layer2NetScan(userIP)

'''I want to give the user 3 options for scanning a network. I want to give a 
quiet (other users unlikely to be alerted) option, a louder option that will 
likely alert other users on the network but will be more accurate and a loud and
detailed scan. I will use 3 different tools to guarantee this happens.  
'''