#!/usr/bin/env python3 

import subprocess
import re
from pacCheck import package_checker

'''This script will require the program netdiscover so we will create
a function to ensure the netdiscover package is present.'''

package = ['netdiscover', 'nmap', 'scapy']
package_checker(package)
'''
ipa = subprocess.Popen(('ip', '-4', '-brief', 'address', 'show'), stdout=subprocess.PIPE)
greps = subprocess.Popen(('grep', '-Eo', '([0-9]{1,3}\.){3}[0-9]{1,3}\/[0-3][0-9]'), stdin=ipa.stdout, stdout=subprocess.PIPE)
ipa.stdout.close()
myIP = subprocess.check_output(('grep', '-Eo','([0-9]{1,3}\.){3}[0-9]{1,3}'), stdin=greps.stdout)
greps.stdout.close()
print('this is your IP address', myIP.strip().decode('utf-8'))
print('Lets map out what else is present using your Ip address.')

range = input("What is the subnet range for your network? ")
ipRange = myIP.strip().decode('utf-8') + range

print(ipRange)

netscan = subprocess.run(('sudo' ,'netdiscover', '-r', ipRange))
'''