#!/usr/bin/env python3
#This Python Script can change Mac Addresses. 

import subprocess
import argparse
import re
'''Here we import the subprocess module(program) to run linux commands within
the script and the argparse module to manage arguments. We have imported the re
module so that we can use regex to validate user inputs for the mac address, will
be adding a similar input validation for our interfaces. 
'''
print("This script will change the mac address of this device!")

def int_eth_search():
    ipa = subprocess.Popen(('ip', 'a'), stdout=subprocess.PIPE)
    greps = subprocess.Popen(('grep', '-Eo', ':\s(\w){3,}'),stdin=ipa.stdout, stdout=subprocess.PIPE)
    ipa.stdout.close()
    interface = subprocess.check_output(('grep','-Eo' ,'(\w+)'), stdin=greps.stdout)
    iplinkshow = subprocess.Popen(('ip', 'link','show'), stdout=subprocess.PIPE)
    eth = subprocess.Popen(('grep', '-Eo', 'ether\s([A-Fa-f0-9]{2}\:){5}\w{2}'),stdin=iplinkshow.stdout, stdout=subprocess.PIPE)
    iplinkshow.stdout.close()
    mac = subprocess.check_output(('grep','-Eo' ,'([A-Fa-f0-9]{2}\:){5}\w{2}'), stdin=eth.stdout)
    print("[+] These are the interfaces on your device", interface.strip().decode('utf-8').split())
    print("[+] and these are the mac addresses on your device", mac.strip().decode('utf-8').split())
    return
''' I use the subprocess module to run several linux commands and pipe the outputs
 in order to search them using grep. This part of the script utilizes 2 linux 
 commands "ip a" and "ip link show". Which show the nics that are present on 
 the device, this includes the hardware addresses and in the case of "ip a" 
 you get to see the ipv4 and ipv6 addresses.
'''

def mac_change(target,newmac):
    print("[+] We will change this interface's [",target,"] mac address to ", newmac)
    print("[+] Taking down interface [",target,"]")
    down = subprocess.run(['sudo', 'ip', 'link', 'set', 'dev', target, 'down'])
    changemac = subprocess.run(['sudo', 'ip', 'link', 'set', 'dev', target, 'address', newmac])
    up = subprocess.run(['sudo', 'ip', 'link', 'set', 'dev', target , 'up'])
    return 

''' The mac_change function actually does the heavy lifting of changing 
the mac address once the user determines the interface they want to 
take action against and the mac they want changed, this function will 
make the change so long as they have the admin passwords. 
'''    
def is_mac_valid(newmac):
    valid_mac = re.compile(r'([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}')
    return bool(valid_mac.match(newmac))
'''This functions checks to ensure uses submit mac addresses in the proper
format. So this function returns true if the mac address submitted fits 
paramaters which follow the format of 12 hexadecmial characters deliminated
by 5 colons. Here is an example [a1:b2:c3:d4:e5:f6]
'''
if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog='macchanger.py')
    parser.add_argument('-t', '--target', dest='target', help='This is the target interface this generally looks like this [eth0]' )
    parser.add_argument('-m', '--MAC', dest='newmac', help='This is a 12 digit hexadecimal number which is generally in the following format [a1:b2:c3:d4:e5:f6]')
    args = parser.parse_args()

'''The argparse method allows for the programmer to add arguments so that users 
who already know what interface they want changed and what address they want
to implement they can just do it without running the rest of the script. Moreover,
if statement checks to see if this program is being run as a module or being run
as the main program. If this is imported as a module it will not respond to 
arguments, but if run as a program directly you can use the arguments.  
'''

if args.target and args.newmac:
    if is_mac_valid(args.newmac):
        mac_change(args.target, args.newmac)
        print('[+] We have successfully changed the Mac Address.\nThe New Mac address for interface',args.target,'is', args.newmac)
    else:
        print('''
ERROR!
Your Mac was provided in the invalid format, Remember MACs 
are in a Hexadecimal format and must be deliminated 
by a colon like this [a1:b2:c3:d4:e5:f6]''')
elif args.newmac:
    if is_mac_valid(args.newmac):
        target = input("Which interface would you like changed? - ")
        mac_change(target, args.newmac)
        print('[+] We have successfully changed the Mac Address.\nThe New Mac address for interface',target,'is', newmac)
    else:
        print('''[-]
ERROR!
Your Mac was provided in the invalid format, Remember MACs 
are in a Hexadecimal format and must be deliminated 
by a colon like this [a1:b2:c3:d4:e5:f6]''')
elif args.target:
    newmac = input("What would you like as the new MAC? - ")    
    if is_mac_valid(newmac):
        mac_change(args.target, newmac)
        print('[+] We have successfully changed the Mac Address.\nThe New Mac address for interface',target,'is', newmac)
    else:
        print('''[-]
ERROR!
Your Mac was provided in the invalid format, Remember MACs 
are in a Hexadecimal format and must be deliminated 
by a colon like this [a1:b2:c3:d4:e5:f6]''')
else:
    int_eth_search()
    target = input("Which interface would you like changed? - ")
    print("[+] We will be modifying [",target,"] When changing MAC addresses remember that it must be in this format a1:b2:c3:d4:e5:f6")
    newmac = input("What would you like as the new MAC? - ")    
    if is_mac_valid(newmac):
        mac_change(target, newmac)
        print('[+] We have successfully changed the Mac Address.\nThe New Mac address for interface',target,'is', newmac)
    else:
        print('''[-]
ERROR!
Your Mac was provided in the invalid format, Remember MACs 
are in a Hexadecimal format and must be deliminated 
by a colon like this [a1:b2:c3:d4:e5:f6]''')

''' This part of the function sees if arguments were presented, if they were not
provided the user will be prompted for what interface they want to change, and
what they want the new mac to be. 
'''